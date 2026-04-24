codeunit 50005 NoSeriesExtented
{
    trigger OnRun()
    begin

    end;

    var

        myInt: Integer;
        NoSeriesCode: Code[20];
        NoSeries: Record "No. Series";
        TryNoSeriesCode: Code[20];
        TrySeriesDate: Date;
        TryNo: Code[20];
        WarningNoSeriesCode: Code[20];
        Text000: Label 'You may not enter numbers manually. ';
        Text001: Label 'If you want to enter numbers manually, please activate %1 in %2 %3.';
        Text002: Label 'It is not possible to assign numbers automatically. ';
        Text003: Label 'If you want the program to assign numbers automatically, please activate %1 in %2 %3.';
        Text004: Label 'You cannot assign new numbers from the number series %1 on %2.';
        Text005: Label 'You cannot assign new numbers from the number series %1.';
        Text006: Label 'You cannot assign new numbers from the number series %1 on a date before %2.';
        Text007: Label 'You cannot assign numbers greater than %1 from the number series %2.';
        Text009: Label 'The number format in %1 must be the same as the number format in %2.';
        Text010: Label 'The number %1 cannot be extended to more than 20 characters.';
        LastNoSeriesLine: Record "No. Series Line";

    procedure TryGetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date): Code[20]
    var
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin
        NoSeriesMgt.GetNextNo1(NoSeriesCode, SeriesDate);
        Commit();
        IF NoSeriesMgt.RUN THEN
            EXIT(NoSeriesMgt.GetNextNo2);
        Commit();
    end;

    procedure GetNextNo1(NoSeriesCode: Code[20]; SeriesDate: Date): Code[20]
    begin
        TryNoSeriesCode := NoSeriesCode;
        TrySeriesDate := SeriesDate;
    end;

    procedure GetNextNo2(): Code[20]
    begin
        EXIT(TryNo);
    end;

    procedure TestManual(DefaultNoSeriesCode: Code[20])
    begin
        IF DefaultNoSeriesCode <> '' THEN BEGIN
            NoSeries.GET(DefaultNoSeriesCode);
            IF NOT NoSeries."Manual Nos." THEN
                ERROR(
                  Text000 +
                  Text001,
                  NoSeries.FIELDCAPTION("Manual Nos."), NoSeries.TABLECAPTION, NoSeries.Code);
        END;
    end;

    procedure InitSeries(DefaultNoSeriesCode: Code[20]; OldNoSeriesCode: Code[20]; NewDate: Date; var NewNo: Code[20]; var NewNoSeriesCode: Code[20])
    var
        UserSetup: Record "User Setup";
    begin
        IF NewNo = '' THEN BEGIN
            NoSeries.GET(DefaultNoSeriesCode);
            IF NOT NoSeries."Default Nos." THEN
                ERROR(
                  Text002 +
                  Text003,
                  NoSeries.FIELDCAPTION("Default Nos."), NoSeries.TABLECAPTION, NoSeries.Code);
            IF OldNoSeriesCode <> '' THEN BEGIN
                NoSeriesCode := DefaultNoSeriesCode;
                FilterSeries;
                NoSeries.Code := OldNoSeriesCode;
                IF NOT NoSeries.FIND THEN
                    NoSeries.GET(DefaultNoSeriesCode);
            END;
            NewNo := GetNextNo(NoSeries.Code, NewDate, TRUE);
            NewNoSeriesCode := NoSeries.Code;
        END ELSE
            TestManual(DefaultNoSeriesCode);
    end;

    local procedure FilterSeries()
    var
        NoSeriesRelationship: Record "No. Series Relationship";
    begin
        NoSeries.RESET;
        NoSeriesRelationship.SETRANGE(Code, NoSeriesCode);
        IF NoSeriesRelationship.FINDSET THEN
            REPEAT
                NoSeries.Code := NoSeriesRelationship."Series Code";
                NoSeries.MARK := TRUE;
            UNTIL NoSeriesRelationship.NEXT = 0;
        NoSeries.GET(NoSeriesCode);
        NoSeries.MARK := TRUE;
        NoSeries.MARKEDONLY := TRUE;
    end;

    procedure GetNextNo(NoSeriesCode: Code[20]; SeriesDate: Date; ModifySeries: Boolean): Code[20]
    begin
        EXIT(GetNextNo3(NoSeriesCode, SeriesDate, ModifySeries, FALSE));
    end;

    procedure GetNextNo3(NoSeriesCode: Code[20]; SeriesDate: Date; ModifySeries: Boolean; NoErrorsOrWarnings: Boolean): Code[20]
    var
        NoSeriesLine: Record "No. Series Line";
    begin
        IF SeriesDate = 0D THEN
            SeriesDate := WORKDATE;

        IF ModifySeries OR (LastNoSeriesLine."Series Code" = '') THEN BEGIN
            IF ModifySeries THEN
                NoSeriesLine.LOCKTABLE;
            NoSeries.GET(NoSeriesCode);
            SetNoSeriesLineFilter(NoSeriesLine, NoSeriesCode, SeriesDate);
            IF NOT NoSeriesLine.FINDFIRST THEN BEGIN
                IF NoErrorsOrWarnings THEN
                    EXIT('');
                NoSeriesLine.SETRANGE("Starting Date");
                IF NOT NoSeriesLine.ISEMPTY THEN
                    ERROR(
                      Text004,
                      NoSeriesCode, SeriesDate);
                ERROR(
                  Text005,
                  NoSeriesCode);
            END;
        END ELSE
            NoSeriesLine := LastNoSeriesLine;

        IF NoSeries."Date Order" AND (SeriesDate < NoSeriesLine."Last Date Used") THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            ERROR(
              Text006,
              NoSeries.Code, NoSeriesLine."Last Date Used");
        END;
        NoSeriesLine."Last Date Used" := SeriesDate;
        IF NoSeriesLine."Last No. Used" = '' THEN BEGIN
            IF NoErrorsOrWarnings AND (NoSeriesLine."Starting No." = '') THEN
                EXIT('');
            NoSeriesLine.TESTFIELD("Starting No.");
            NoSeriesLine."Last No. Used" := NoSeriesLine."Starting No.";
        END ELSE
            IF NoSeriesLine."Increment-by No." <= 1 THEN
                NoSeriesLine."Last No. Used" := INCSTR(NoSeriesLine."Last No. Used")
            ELSE
                IncrementNoText(NoSeriesLine."Last No. Used", NoSeriesLine."Increment-by No.");
        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Last No. Used" > NoSeriesLine."Ending No.")
        THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            ERROR(
              Text007,
              NoSeriesLine."Ending No.", NoSeriesCode);
        END;
        IF (NoSeriesLine."Ending No." <> '') AND
           (NoSeriesLine."Warning No." <> '') AND
           (NoSeriesLine."Last No. Used" >= NoSeriesLine."Warning No.") AND
           (NoSeriesCode <> WarningNoSeriesCode) AND
           (TryNoSeriesCode = '')
        THEN BEGIN
            IF NoErrorsOrWarnings THEN
                EXIT('');
            WarningNoSeriesCode := NoSeriesCode;
            MESSAGE(
              Text007,
              NoSeriesLine."Ending No.", NoSeriesCode);
        END;
        NoSeriesLine.VALIDATE(Open);

        IF ModifySeries THEN
            NoSeriesLine.MODIFY
        ELSE
            LastNoSeriesLine := NoSeriesLine;
        EXIT(NoSeriesLine."Last No. Used");
    end;

    procedure SetNoSeriesLineFilter(var NoSeriesLine: Record "No. Series Line"; NoSeriesCode: Code[20]; StartDate: Date)
    begin
        IF StartDate = 0D THEN
            StartDate := WORKDATE;
        NoSeriesLine.RESET;
        NoSeriesLine.SETCURRENTKEY("Series Code", "Starting Date");
        NoSeriesLine.SETRANGE("Series Code", NoSeriesCode);
        NoSeriesLine.SETRANGE("Starting Date", 0D, StartDate);
        IF NoSeriesLine.FINDLAST THEN BEGIN
            NoSeriesLine.SETRANGE("Starting Date", NoSeriesLine."Starting Date");
            NoSeriesLine.SETRANGE(Open, TRUE);
        END;
    end;

    procedure IncrementNoText(var No: Code[20]; IncrementByNo: Decimal)
    var
        DecimalNo: Decimal;
        StartPos: Integer;
        EndPos: Integer;
        NewNo: Text[30];
    begin
        GetIntegerPos(No, StartPos, EndPos);
        EVALUATE(DecimalNo, COPYSTR(No, StartPos, EndPos - StartPos + 1));
        NewNo := FORMAT(DecimalNo + IncrementByNo, 0, 1);
        ReplaceNoText(No, NewNo, 0, StartPos, EndPos);
    end;

    local procedure GetIntegerPos(No: Code[20]; var StartPos: Integer; var EndPos: Integer)
    var
        IsDigit: Boolean;
        i: Integer;
    begin
        StartPos := 0;
        EndPos := 0;
        IF No <> '' THEN BEGIN
            i := STRLEN(No);
            REPEAT
                IsDigit := No[i] IN ['0' .. '9'];
                IF IsDigit THEN BEGIN
                    IF EndPos = 0 THEN
                        EndPos := i;
                    StartPos := i;
                END;
                i := i - 1;
            UNTIL (i = 0) OR (StartPos <> 0) AND NOT IsDigit;
        END;
    end;

    local procedure ReplaceNoText(var No: Code[20]; NewNo: Code[20]; FixedLength: Integer; StartPos: Integer; EndPos: Integer)
    var
        StartNo: Code[20];
        EndNo: Code[20];
        ZeroNo: Code[20];
        NewLength: Integer;
        OldLength: Integer;
    begin
        IF StartPos > 1 THEN
            StartNo := COPYSTR(No, 1, StartPos - 1);
        IF EndPos < STRLEN(No) THEN
            EndNo := COPYSTR(No, EndPos + 1);
        NewLength := STRLEN(NewNo);
        OldLength := EndPos - StartPos + 1;
        IF FixedLength > OldLength THEN
            OldLength := FixedLength;
        IF OldLength > NewLength THEN
            ZeroNo := PADSTR('', OldLength - NewLength, '0');
        IF STRLEN(StartNo) + STRLEN(ZeroNo) + STRLEN(NewNo) + STRLEN(EndNo) > 20 THEN
            ERROR(
              Text010,
              No);
        No := StartNo + ZeroNo + NewNo + EndNo;
    end;

    procedure SetSeries(var NewNo: Code[20])
    var
        NoSeriesCode2: Code[20];
    begin
        NoSeriesCode2 := NoSeries.Code;
        FilterSeries;
        NoSeries.Code := NoSeriesCode2;
        NoSeries.FIND;
        NewNo := GetNextNo(NoSeries.Code, 0D, TRUE);
    end;

    procedure SelectSeries(DefaultNoSeriesCode: Code[20]; OldNoSeriesCode: Code[20]; var NewNoSeriesCode: Code[20]): Boolean
    begin
        NoSeriesCode := DefaultNoSeriesCode;
        FilterSeries;
        IF NewNoSeriesCode = '' THEN BEGIN
            IF OldNoSeriesCode <> '' THEN
                NoSeries.Code := OldNoSeriesCode;
        END ELSE
            NoSeries.Code := NewNoSeriesCode;
        IF PAGE.RUNMODAL(0, NoSeries) = ACTION::LookupOK THEN BEGIN
            NewNoSeriesCode := NoSeries.Code;
            EXIT(TRUE);
        END;
    end;


}