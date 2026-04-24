table 50002 Title
{
    Caption = 'Title';
    DrillDownPageID = "Title";
    LookupPageID = "Title";

    fields
    {
        field(1; "Capacity Type"; Option)
        {
            Caption = 'Capacity Type';
            OptionCaption = 'Work Center,Machine Center';
            OptionMembers = "Work Center","Machine Center";

            trigger OnValidate()
            begin
                /*Code := '';
                "Work Center No." := '';
                "Work Center Group Code" := '';
                */

            end;
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin

                EVALUATE(Order, Code);

                /*IF Code = '' THEN
                  EXIT;
                
                CASE "Capacity Type" OF
                  "Capacity Type"::"Work Center":
                    BEGIN
                      WorkCenter.GET(Code);
                      WorkCenter.TESTFIELD("Work Center Group Code");
                      "Work Center No." := WorkCenter.Code;
                      "Work Center Group Code" := WorkCenter."Work Center Group Code";
                      Efficiency := WorkCenter.Efficiency;
                      IF NOT WorkCenter."Consolidated Calendar" THEN
                        Capacity := WorkCenter.Capacity;
                    END;
                  "Capacity Type"::"Machine Center":
                    BEGIN
                      MachineCenter.GET(Code);
                      MachineCenter.TESTFIELD("Work Center No.");
                      WorkCenter.GET(MachineCenter."Work Center No.");
                      WorkCenter.TESTFIELD("Work Center Group Code");
                      "Work Center No." := WorkCenter.Code;
                      "Work Center Group Code" := WorkCenter."Work Center Group Code";
                      Efficiency := MachineCenter.Efficiency;
                      Capacity := MachineCenter.Capacity;
                    END;
                END;
                IF "Ending Time" <> 0T THEN
                  VALIDATE("Ending Time");
                */

            end;
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                //CheckRedundancy;
            end;
        }
        /*      field(5; "Work Shift Code"; Code[10])
              {
                  Caption = 'Work Shift Code';
                  NotBlank = true;
                  TableRelation = "Employee Picture";

                  trigger OnValidate()
                  begin
                      //CheckRedundancy;
                  end;
              }*/
        field(6; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN BEGIN
                  CalendarEntry.RESET;
                  CalendarEntry.SETRANGE("Capacity Type","Capacity Type");
                  CalendarEntry.SETRANGE(Code,Code);
                  CalendarEntry.SETRANGE(Date,Date);
                  CalendarEntry.SETRANGE("Starting Time","Starting Time",235959T);
                  IF CalendarEntry.FIND('-') THEN
                    "Ending Time" := CalendarEntry."Starting Time"
                  ELSE
                    "Ending Time" := 235959T;
                END;
                VALIDATE("Ending Time");
                */

            end;
        }
        field(7; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            NotBlank = true;

            trigger OnValidate()
            begin
                /*IF ("Ending Time" < "Starting Time") AND
                   ("Ending Time" <> 000000T)
                THEN
                  ERROR(Text000,FIELDCAPTION("Ending Time"),FIELDCAPTION("Starting Time"));
                
                CalculateCapacity;
                
                CheckRedundancy;
                
                UpdateDatetime;
                */

            end;
        }
        field(8; "Work Center No."; Code[20])
        {
            Caption = 'Work Center No.';
            Editable = false;
            TableRelation = Profession;
        }
        /*  field(9; "Work Center Group Code"; Code[10])
          {
              Caption = 'Work Center Group Code';
              Editable = false;
              TableRelation = "Employee Blood Donation";
          }*/
        field(10; "Capacity (Total)"; Decimal)
        {
            Caption = 'Capacity (Total)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(11; "Capacity (Effective)"; Decimal)
        {
            Caption = 'Capacity (Effective)';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(20; Efficiency; Decimal)
        {
            Caption = 'Efficiency';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                //"Capacity (Effective)" := ROUND("Capacity (Total)" * Efficiency / 100,0.001);
            end;
        }
        field(21; Capacity; Decimal)
        {
            Caption = 'Capacity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

            trigger OnValidate()
            begin
                //CalculateCapacity;
            end;
        }
        field(22; "Absence Efficiency"; Decimal)
        {
            Caption = 'Absence Efficiency';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                //"Capacity (Effective)" := ROUND("Capacity (Total)" * Efficiency / 100,0.001);
            end;
        }
        field(23; "Absence Capacity"; Decimal)
        {
            Caption = 'Absence Capacity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            begin
                //CalculateCapacity;
            end;
        }
        field(24; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';

            trigger OnValidate()
            begin
                /*Date := DT2DATE("Starting Date-Time");
                VALIDATE("Starting Time",DT2TIME("Starting Date-Time"));
                */

            end;
        }
        field(25; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';

            trigger OnValidate()
            begin
                /*Date := DT2DATE("Ending Date-Time");
                VALIDATE("Ending Time",DT2TIME("Ending Date-Time"));
                */

            end;
        }
        field(50000; Description; Text[120])
        {
            Caption = 'Description';
        }
        field(50001; "Order"; Integer)
        {
            AutoIncrement = false;
            Caption = 'Code';

            trigger OnValidate()
            begin

                //Code:=FORMAT(Order);
                //MODIFY;
            end;
        }
        field(50002; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(Key1; "Code", Description)
        {
        }
        key(Key2; "Order")
        {
        }
        key(Key3; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Order")
        {
        }
    }

    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Title Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Title Nos", xRec."No. Series", 0D, Code, "No. Series");
        END;
        EVALUATE(Order, Code);
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        Text001: Label 'There is redundancy in %1 within the calendar of %2. From %3 to %4. Conflicting time from %5 to %6.';
        WorkCenter: Record "Profession";
        //   MachineCenter: Record "Travel Header";
        CalendarEntry: Record "Title";
        //ĐK CalendarMgt: Codeunit "CalendarManagement";
        "Integer": Integer;
        Title: Record "Title";
        Ord: Code[10];
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;

    local procedure CheckRedundancy()
    begin
        /*IF ("Starting Time" = 0T) AND ("Ending Time" = 0T) THEN
          EXIT;
        
        CalendarEntry.SETRANGE("Capacity Type","Capacity Type");
        CalendarEntry.SETRANGE(Code,Code);
        CalendarEntry.SETRANGE(Date,Date);
        CalendarEntry.SETFILTER("Starting Time",'<%1',"Ending Time");
        CalendarEntry.SETFILTER("Ending Time",'>%1|%2',"Starting Time",000000T);
        
        IF CalendarEntry.FIND('-') THEN
          REPEAT
            IF (CalendarEntry."Starting Time" <> xRec."Starting Time") OR
               (CalendarEntry."Ending Time" <> xRec."Ending Time") OR
               (CalendarEntry."Work Shift Code" <> xRec."Work Shift Code")
            THEN
              ERROR(
                Text001,
                "Capacity Type",
                Code,
                "Starting Time",
                "Ending Time",
                CalendarEntry."Starting Time",
                CalendarEntry."Ending Time");
          UNTIL CalendarEntry.NEXT = 0;
        */

    end;

    local procedure CalculateCapacity()
    begin
        /*WorkCenter.GET("Work Center No.");
        
        IF ("Starting Time" = 0T) AND
           ("Ending Time" = 0T)
        THEN BEGIN
          VALIDATE("Capacity (Total)",0);
          EXIT;
        END;
        
        "Capacity (Total)" :=
          ROUND(
            CalendarMgt.CalcTimeDelta("Ending Time","Starting Time") /
            CalendarMgt.TimeFactor(WorkCenter."Unit of Measure Code") *
            (Capacity - "Absence Capacity"),WorkCenter."Calendar Rounding Precision");
        
        "Capacity (Effective)" := ROUND("Capacity (Total)" * Efficiency / 100,WorkCenter."Calendar Rounding Precision");
        */

    end;

    procedure Caption(): Text[100]
    begin
        /*IF "Capacity Type" = "Capacity Type"::"Machine Center" THEN BEGIN
          IF NOT MachineCenter.GET(GETFILTER(Code)) THEN
            EXIT('');
          EXIT(
            STRSUBSTNO('%1 %2',
              MachineCenter."No.",MachineCenter.Name));
        END;
        IF NOT WorkCenter.GET(GETFILTER(Code)) THEN
          EXIT('');
        EXIT(
          STRSUBSTNO('%1 %2',
            WorkCenter.Code,WorkCenter.Description));
            */

    end;

    local procedure UpdateDatetime()
    begin
        /*"Starting Date-Time" := CREATEDATETIME(Date,"Starting Time");
        "Ending Date-Time" := CREATEDATETIME(Date,"Ending Time");
        */

    end;
}

