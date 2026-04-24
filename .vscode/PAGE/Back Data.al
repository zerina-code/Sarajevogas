pageextension 50163 "Change Log Entries" extends "Change Log Entries"
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {

            action(BackData)
            {

                ApplicationArea = all;
                Caption = 'Back Data';
                Image = CalendarChanged;
                //    RunObject = report "Employee Absence Reg";
                trigger OnAction()
                var


                    ChangeLogEntry: Record "Change Log Entry";
                    RecRef: RecordRef;
                    RecRef2: RecordRef;
                    FieldRef: FieldRef;
                    FieldType: FieldType;

                    FieldRef3: FieldRef;
                    FieldNo: Integer;
                    TableNo: Integer;
                    Key1: Code[20];
                    Key2: Text[250];
                    Key3: Text[250];
                    dateT: date;
                    Bool: Boolean;
                begin


                    Rec.FINDFIRST;

                    if Key1 <> '' then
                        RecRef.Field(1).Value := Key1;

                    RecRef.Open(rec."Table No.");



                    // Postavljamo filtere na primarni ključ
                    if Rec."Primary Key Field 1 Value" <> '' then begin
                        FieldRef3 := RecRef.Field(1);
                        RecRef.Field(1).SetRange(ChangeLogEntry."Primary Key Field 1 No.");
                    end;

                    if Rec."Primary Key Field 2 Value" <> '' then begin
                        FieldRef3 := RecRef.Field(1);
                        RecRef.Field(1).SetRange(ChangeLogEntry."Primary Key Field 2 No.");
                    end;

                    if Rec."Primary Key Field 3 Value" <> '' then begin
                        FieldRef3 := RecRef.Field(1);
                        RecRef.Field(1).SetRange(ChangeLogEntry."Primary Key Field 3 No.");
                    end;

                    if RecRef.FindFirst() then begin

                        ChangeLogEntry.Reset();
                        ChangeLogEntry.SetFilter("Primary Key Field 1 Value", '%1', rec."Primary Key Field 1 Value");
                        if ChangeLogEntry.FindSet() then
                            repeat

                                if ChangeLogEntry."Field No." <> ChangeLogEntry."Primary Key Field 1 No." then begin

                                    FieldNo := ChangeLogEntry."Field No.";

                                    if (FieldNo > 0) and (ChangeLogEntry."Old Value" <> '{00000000-0000-0000-0000-000000000000}') then begin

                                        FieldRef := RecRef.Field(FieldNo);
                                        FieldType := FieldRef.Type;
                                        if FieldType = FieldType::DateTime then begin
                                            ChangeLogEntry."Old Value" := ConvertUTCTextToLocalDateTimeText(ChangeLogEntry."Old Value");
                                        end;
                                        if FieldType = FieldType::Date then
                                            ChangeLogEntry."Old Value" := ConvertUTCTextToLocalDateText(ChangeLogEntry."Old Value");
                                        if FieldType = FieldType::Date then begin
                                            ChangeLogEntry."Old Value" := ConvertUTCTextToLocalDateText(ChangeLogEntry."Old Value");
                                            if Evaluate(dateT, ChangeLogEntry."Old Value") then
                                                FieldRef.Value := dateT;

                                        end;

                                        if FieldType = FieldType::Boolean then begin
                                            if ChangeLogEntry."Old Value" = 'true' then begin
                                                Bool := true;
                                                FieldRef.Value := Bool;
                                            end
                                            else begin
                                                Bool := false;
                                                FieldRef.Value := Bool;
                                            end;

                                        end;


                                        if (FieldType <> FieldType::DateTime) and (FieldType <> FieldType::Date)
                                        and (FieldType <> FieldType::Boolean) then begin

                                            if ChangeLogEntry."New Value" = '' then
                                                FieldRef.Value := ChangeLogEntry."Old Value"
                                            else
                                                FieldRef.Value := ChangeLogEntry."New Value"; // možeš koristiti "Old Value" ako praviš staru verziju

                                        end;
                                    end;

                                end;
                            until ChangeLogEntry.Next() = 0;
                        RecRef.Modify();

                    end
                    else begin
                        // Proveravamo da li takav zapis postoji



                        RecRef.Init();

                        ChangeLogEntry.Reset();
                        ChangeLogEntry.SetFilter("Primary Key Field 1 Value", '%1', rec."Primary Key Field 1 Value");
                        ChangeLogEntry.SetFilter("Table No.", '%1', rec."Table No.");
                        if ChangeLogEntry.FindSet() then
                            repeat



                                // Postavi konkretno polje koje je bilo menjano
                                FieldNo := ChangeLogEntry."Field No.";

                                if (FieldNo > 0) and (ChangeLogEntry."Old Value" <> '{00000000-0000-0000-0000-000000000000}') then begin
                                    FieldRef := RecRef.Field(FieldNo);
                                    FieldType := FieldRef.Type;
                                    if FieldType = FieldType::DateTime then begin
                                        ChangeLogEntry."Old Value" := ConvertUTCTextToLocalDateTimeText(ChangeLogEntry."Old Value");
                                    end;
                                    if FieldType = FieldType::Date then begin
                                        ChangeLogEntry."Old Value" := ConvertUTCTextToLocalDateText(ChangeLogEntry."Old Value");
                                        if Evaluate(dateT, ChangeLogEntry."Old Value") then
                                            FieldRef.Value := dateT;

                                    end;


                                    if FieldType = FieldType::Boolean then begin
                                        if ChangeLogEntry."Old Value" = 'true' then begin
                                            Bool := true;
                                            FieldRef.Value := Bool;
                                        end
                                        else begin
                                            Bool := false;
                                            FieldRef.Value := Bool;
                                        end;
                                    end;

                                    if (FieldType <> FieldType::DateTime) and (FieldType <> FieldType::Date)
                                    and (FieldType <> FieldType::Boolean) then begin
                                        if ChangeLogEntry."New Value" = '' then
                                            FieldRef.Value := ChangeLogEntry."Old Value"
                                        else
                                            FieldRef.Value := ChangeLogEntry."New Value"; // možeš koristiti "Old Value" ako praviš staru verziju
                                    end;
                                end;

                            until ChangeLogEntry.Next() = 0;

                        // Na kraju insertuj novi zapis u originalnu tabelu
                        RecRef.Insert();

                    end;
                    Message('Podaci su vraćeni!');

                end;


            }

        }
    }

    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure ConvertUTCTextToLocalDateTimeText(UTCText: Text[100]): Text
    var
        DatePart: Date;
        TimePart: Time;
        DateTimeValue: DateTime;
        TPos: Integer;
        ZPos: Integer;
        DateText: Text[20];
        TimeText: Text[20];
    begin
        // Pronađi pozicije T i Z
        TPos := StrPos(UTCText, 'T');
        ZPos := StrPos(UTCText, 'Z');

        if TPos = 0 then
            Error('Neispravan format datuma (nema T)');

        // Izdvoji datum i vreme kao tekst
        DateText := CopyStr(UTCText, 1, TPos - 1);
        if ZPos > TPos then
            TimeText := CopyStr(UTCText, TPos + 1, ZPos - TPos - 1)
        else
            TimeText := CopyStr(UTCText, TPos + 1);

        // Parsiraj kao Date i Time
        if not Evaluate(DatePart, DateText) then
            Error('Ne mogu konvertovati datum: %1', DateText);

        if not Evaluate(TimePart, TimeText) then
            Error('Ne mogu konvertovati vreme: %1', TimeText);

        // Sastavi DateTime i formatiraj lokalno
        DateTimeValue := CreateDateTime(DatePart, TimePart);
        exit(Format(DateTimeValue, 0, '<Standard Format,0>'));
    end;


    procedure ConvertUTCTextToLocalDateText(UTCText: Text[100]): Text
    var
        YearText: Text[4];
        MonthText: Text[2];
        DayText: Text[2];
    begin
        // Očekivani format: 2025-05-29 (ISO)
        if StrLen(UTCText) <> 10 then
            Error('Neispravan ISO format datuma: %1', UTCText);

        YearText := CopyStr(UTCText, 1, 4);
        MonthText := CopyStr(UTCText, 6, 2);
        DayText := CopyStr(UTCText, 9, 2);

        exit(DayText + '.' + MonthText + '.' + YearText);
    end;


    var
        myInt: Integer;
}