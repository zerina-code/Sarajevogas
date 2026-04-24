table 50145 "Unknown data"
{
    Caption = 'Unknown data';
    DrillDownPageId = "Unknown data";
    LookupPageId = "Unknown data";
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; MM; code[20])
        {
            Caption = 'MM Code';
            TableRelation = "Service Item"."No.";
        }
        field(3; "Gauge"; Code[20])
        {
            TableRelation = Gauge.Code;
        }

        field(6; "Category MM"; enum Category) { Caption = 'Category MM'; }
        field(7; "Customer No."; code[20]) { Caption = 'Customer No.'; TableRelation = Customer."No."; }
        field(8; "Customer Name"; Text[250]) { Caption = 'Customer Name'; }

        field(4; "Year of Calculation"; Integer)
        { Caption = 'Year of calculation'; }

        field(5; "Month of Calculation"; Integer)
        { Caption = 'Month of Calculation'; }

        field(70; "Month Of GAS Calculation"; Integer)
        {
            Caption = 'Month of GAS Calculation';
            Description = 'Month for which the wage is calculated and paid';

            trigger OnValidate()
            begin

            end;
        }
        field(75; "Year Of GAS Calculation"; Integer)
        {
            Caption = 'Year of GAS Calculation';
            Description = 'Year for which the wage is calculated and paid';

            trigger OnValidate()
            begin


            end;
        }
        field(50092; "Source Data"; enum "Import Data")
        {
            Caption = 'Source Data';
        }


        field(50013; "Measuring Point Code"; Code[20])
        {
            TableRelation = "Service Item"."No.";
            Caption = 'Measuring Point Code';
        }
        field(50024; "Old Value"; Integer)
        {
            Caption = 'Old Value';
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                Difference := "New Value" - "Old Value";

            end;
        }
        field(50025; "New Value"; Integer)
        {
            Caption = 'New Value';
            trigger OnValidate()
            var
                myInt: Integer;

            begin
                Difference := "New Value" - "Old Value";

            end;
        }
        field(50026; "Difference"; Decimal)
        {
            Caption = 'Difference';
        }
        field(50027; "SM3"; Decimal)
        {
            Caption = 'SM3';
        }
        field(50031; "Previous Date"; Date)
        {
            Caption = 'Previous Date';
        }
        field(31; "Calculation Date From"; Date)
        {
            Caption = 'Calculation Date From';
        }
        field(32; "Calculation Date To"; Date)
        {
            Caption = 'Calculation Date To';
        }

        field(33; "Proceedings No."; Code[20])
        {
            Caption = 'Proceedings No.';
        }
        field(34; "Temperature previous - gauge"; Integer)
        {
            Caption = 'Temperature previous - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Temperature result- gauge" := ("Temperature previous - gauge" + "Temperature new- gauge") / 2;

            end;
        }
        field(35; "Temperature new- gauge"; Integer)
        {
            Caption = 'Temperature new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Temperature result- gauge" := ("Temperature previous - gauge" + "Temperature new- gauge") / 2;

            end;
        }
        field(36; "Temperature result- gauge"; Decimal)
        {
            Caption = 'Temperature new - gauge';
        }
        field(37; "Pressure previous - gauge"; Decimal)
        {
            Caption = 'Pressure previous - gauge"';
            DecimalPlaces = 1 : 4;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                //   "Pressure result- gauge" := ("Pressure previous - gauge" + "Pressure new- gauge") / 2;

            end;
        }
        field(38; "Pressure new- gauge"; Decimal)
        {
            Caption = 'Pressure new - gauge';
            DecimalPlaces = 1 : 4;
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Pressure result- gauge" := "Pressure new- gauge";

            end;
        }
        field(39; "Pressure result- gauge"; Decimal)
        {
            Caption = 'Pressure new - gauge';
            DecimalPlaces = 1 : 4;
        }

        field(40; "Correction previous - gauge"; Decimal)
        {
            Caption = 'Correction previous - gauge"';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Correction result- gauge" := ("Correction new- gauge" - "Correction previous - gauge");

            end;

        }
        field(41; "Correction new- gauge"; Decimal)
        {
            Caption = 'Correction new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Correction result- gauge" := ("Correction new- gauge" - "Correction previous - gauge");

            end;
        }
        field(42; "Correction result- gauge"; Decimal)
        {
            Caption = 'Correction new - gauge';
        }
        field(43; "UnCorrection previous - gauge"; Decimal)
        {
            Caption = 'UnCorrection previous - gauge"';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "UnCorrection result- gauge" := ("UnCorrection new- gauge" - "UnCorrection previous - gauge");

            end;
        }
        field(44; "UnCorrection new- gauge"; Decimal)
        {
            Caption = 'UnCorrection new - gauge';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "UnCorrection result- gauge" := ("UnCorrection new- gauge" - "UnCorrection previous - gauge");

            end;
        }
        field(45; "UnCorrection result- gauge"; Decimal)
        {
            Caption = 'UnCorrection new - gauge';
        }
        field(46; "Temperature Correction"; Decimal)
        {
            Caption = 'Temperature Correction';
        }
        field(47; "Pressure Correction"; Decimal)
        {
            Caption = 'Pressure Correction';
            DecimalPlaces = 1 : 4;
        }
        field(48; "Calorific power coefficient"; Decimal)
        {
            Caption = 'Calorific power coefficient';
            DecimalPlaces = 1 : 6;
        }
        field(49; "Compression coefficient"; Decimal)
        {
            Caption = 'Compression coefficient';
            DecimalPlaces = 1 : 4;
        }
        field(50; "Atmospheric pressure"; Decimal)
        {
            Caption = 'Atmospheric pressure';
            DecimalPlaces = 1 : 6;
        }
        field(51; "% reduction"; Decimal)
        {
            Caption = '% reduction';
            MaxValue = 100;
        }
        field(52; "Method of calculation"; enum "Method of calculation")
        {
            Caption = 'Method of calculation';



        }
        field(53; "Working pressure"; Decimal)
        {
            Caption = 'Working pressure';
        }

        field(54; "Scale factor"; Decimal)
        {
            Caption = 'Scale factor';
        }
        field(56; "Correct consumption "; Boolean)
        {
            Caption = 'Correct consumption';
        }
        field(57; "USERID_ID"; text[250])
        {
            Caption = 'USERID';
            Editable = false;
        }
        field(50086; "Serial Number"; Text[250])
        {
            Caption = 'MM Description';



        }
        field(50134; "Date"; DateTime)
        {
            Caption = 'Date';
        }
        field(50135; "Autoin"; integer)
        {
            Caption = 'Autoin';
            //AutoIncrement = true;
        }


    }

    keys
    {
        key(Key1; "Code", MM, "Customer No.", Gauge, Autoin)
        {
        }

    }

    fieldgroups
    {
    }
}

