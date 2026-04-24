table 50037 "Meal Header"
{
    Caption = 'Meal Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Description = 'Primary Key';

            trigger OnValidate()
            begin

                IF "No." <> xRec."No." THEN BEGIN
                    WageSetup.GET;
                    //ĐK  NoSeriesMgt.TestManual(WageSetup."Meal No. Series");
                    "No. Series" := '';
                END;
            end;
        }
        field(5; "Year Of Wage"; Integer)
        {
            Caption = 'Year of Wage';
            Description = 'For what year is meal calculated';
        }
        field(10; "Month Of Wage"; Integer)
        {
            Caption = 'Month of Wage';
            Description = 'For what month is meal calculated';
        }
        field(15; Workdays; Integer)
        {
            Caption = 'Workdays';
            Description = 'Workdays in month-Not currently used-intended for payment of meal if not at work full month';
        }
        field(20; Status; Option)
        {
            Caption = 'Status';
            Description = 'Open,Closed,Locked';
            OptionCaption = 'Open,Closed,Locked';
            OptionMembers = Open,Closed,Locked;
        }
        field(25; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(30; "Date Of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(35; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Description = 'Which number series is used';
        }
        field(40; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            Description = 'Sum of all lines for current meal header';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        IF xRec.Status = 2 THEN BEGIN
            Response := CONFIRM(Txt002);
            IF NOT Response THEN
                ERROR(Txt003);
        END;
        MealLine.RESET;
        MealLine.SETFILTER("Document No.", "No.");
        IF NOT MealLine.ISEMPTY THEN
            MealLine.DELETEALL;
        MealLineTemp.RESET;
        MealLineTemp.SETFILTER("Document No.", "No.");
        IF NOT MealLineTemp.ISEMPTY THEN
            MealLineTemp.DELETEALL;
    end;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin


        IF "No." = '' THEN BEGIN
            WageSetup.GET;
            WageSetup.TESTFIELD("Meal No. Series");
            NoSeriesMgt.InitSeries(WageSetup."Meal No. Series", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        IF "Date Of Calculation" = 0D THEN
            "Date Of Calculation" := WORKDATE;
        IF "User ID" = '' THEN
            "User ID" := USERID;
    end;

    trigger OnModify()
    begin

        IF (xRec.Status = 2) OR (xRec.Status = 3) THEN
            ERROR(Txt001);
    end;

    var
        Txt001: Label '<Topli obrok je placen i zatvoren. Promjene nisu moguce.>';
        Txt002: Label '<Jeste li sigurni da zelite izbrisati ovaj zapis?>';
        Txt003: Label '<Zapis nece biti izbrisan.>';
        WageSetup: Record "Wage Setup";
        //  NoSeriesMgt: Codeunit NoSeriesManagement;
        Response: Boolean;
        MealLine: Record "Meal Line";
        MealLineTemp: Record "Meal Line Temp";
}

