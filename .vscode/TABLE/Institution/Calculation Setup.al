table 50081 "Calculation Setup"
{
    Caption = 'Calculation Setup';
    DrillDownPageId = Gauges;
    LookupPageId = Gauges;
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "PK"; Integer)
        {
            Caption = 'PK';
            NotBlank = true;
        }
        field(2; "Item No."; code[20])
        {
            Caption = 'Item No. for calculation';
            TableRelation = Item."No.";
        }
        field(3; "No. series for Proceedings SP"; code[20])
        {
            Caption = 'No. series for Proceedings SP';
            TableRelation = "No. Series";
        }
        field(4; "PS Constant"; Decimal)
        {
            Caption = 'PS Constant';
            DecimalPlaces = 1 : 6;

        }
        field(5; "TS Constant"; Decimal)
        {
            Caption = 'TS Constant';

        }
        field(6; "Absolute zero"; Decimal)
        {
            Caption = 'Absolute zero';
            DecimalPlaces = 1 : 4;
        }

        field(7; "Scale factor"; Decimal)
        {
            Caption = 'Scale factor';
        }

        field(8; "Calorific power coefficient"; Decimal)
        {
            Caption = 'Calorific power coefficient';
            DecimalPlaces = 1 : 6;
        }
        field(9; "Compression coefficient"; Decimal)
        {
            Caption = 'Compression coefficient';
            DecimalPlaces = 1 : 4;
        }
        field(10; "Atmospheric pressure"; Decimal)
        {
            Caption = 'Atmospheric pressure';
            DecimalPlaces = 1 : 6;
        }

        field(11; "% reduction"; Decimal)
        {
            Caption = '% reduction';
            MaxValue = 100;
        }
        field(12; "Subsidies"; Decimal)
        {
            Caption = 'Subsidies';

        }
        field(13; "Subsidies Date from"; Date)
        {
            Caption = 'Subsidies Date froms';
        }
        field(14; "Subsidies Date to"; Date)
        {
            Caption = 'Subsidies Date to';

        }
        //ratni dug provjeriti 
        field(15; "JEDKS"; Decimal)
        {
            Caption = 'JEDKS';
            DecimalPlaces = 1 : 6;

        }
        field(16; "War Dabt"; Integer)
        {
            Caption = 'War Dabt';
            FieldClass = FlowField;
            CalcFormula = count("War Debt Setup" where(Active = filter(true)));

        }
        field(17; "Deminimis Legal act"; text[250])
        {
            Caption = 'Deminimis Legal act';
        }
        field(18; "Deminimis Act Name"; Text[250])

        {
            Caption = 'Deminimis Act Name';
        }
        field(19; "Deminimis Act Number"; Text[250])
        {
            Caption = 'Deminimis Act Number';
        }
        field(20; "Deminimis Act Date"; Date)
        {
            Caption = 'Deminimis Act Date';
        }
        field(21; "Deminimis Purpose"; Text[250])
        {
            Caption = 'Deminimis Purpose';
        }
        field(22; "Aid granting instrument"; text[250])
        {
            Caption = 'Aid granting instrument';
        }
        field(23; "Deminimis Remark"; Text[250])
        {
            Caption = 'Deminimis Remark';
        }
        field(24; "Vendor No."; code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor."No.";
        }
        field(25; "Customer - Subsidies"; Code[20])
        {
            Caption = 'Customer - Subsidies';
            TableRelation = Customer."No.";
        }
        field(26; "Subsidies Resource"; code[20])
        {
            Caption = 'Subsidies';
            TableRelation = Resource."No.";
        }
        field(27; "Item No. 2"; code[20])
        {
            Caption = 'Item No. for purchase';
            TableRelation = Item."No.";
        }
        field(28; "Transfer Items"; Boolean)
        {
            Caption = 'Transfer Items';
        }
        field(29; "No. Series Transfer"; Code[20])
        {
            Caption = 'No series Transfer';
            TableRelation = "No. Series";
        }
        field(30; "Change Price"; Date)
        {
            Caption = 'Change Price';

        }
        field(31; "New Price"; Decimal)
        {
            Caption = 'New Price';
            trigger OnValidate()
            var
                myInt: Integer;
                GS: Record "General Ledger Setup";
            begin
                GS.get;
                GS."CNG Amount Rounding Precision" := rec."New Price";
                gs.Modify();

            end;

        }
        field(32; "Rounding Value Quantity VP"; Decimal)
        {
            Caption = 'Rounding Value Quantity VP';

        }
        field(33; "Rounding Value Quantity MP"; Decimal)
        {
            Caption = 'Rounding Value Quantity MP';

        }
        field(34; "Rounding Value Quantity DOM"; Decimal)
        {
            Caption = 'Rounding Value Quantity DOM';

        }
        field(35; "Rounding Value Quantity KJKP"; Decimal)
        {
            Caption = 'Rounding Value Quantity KJKP';

        }
        field(36; "Rounding Value Quantity SP"; Decimal)
        {
            Caption = 'Rounding Value Quantity SP';

        }
        field(37; "Rounding Value Quantity CNG"; Decimal)
        {
            Caption = 'Rounding Value Quantity CNG';

        }
        field(38; "No. series for Proceedings VP"; code[20])
        {
            Caption = 'No. series for Proceedings Vp';
            TableRelation = "No. Series";
        }
        field(39; "No. series for Proceedings MP"; code[20])
        {
            Caption = 'No. series for Proceedings MP';
            TableRelation = "No. Series";
        }
        field(40; "No. series for Proceedings DOM"; code[20])
        {
            Caption = 'No. series for Proceedings DOM';
            TableRelation = "No. Series";
        }
        field(41; "No. series for Proceedings CNG"; code[20])
        {
            Caption = 'No. series for Proceedings CNG';
            TableRelation = "No. Series";
        }

        field(42; "No. series for Proceedings KP"; code[20])
        {
            Caption = 'No. series for Proceedings KJKP';
            TableRelation = "No. Series";
        }
        field(43; "Reminder amount"; Decimal)
        {
            Caption = 'Reminder amount';

        }

        //4 - procenti raspodjele po mjesecima
        field(44; "Distribution 1"; Decimal)
        {
            Caption = 'Distribution 1';
        }
        field(45; "Distribution 2"; Decimal)
        {
            Caption = 'Distribution 2';
        }

        field(46; "Distribution 3"; Decimal)
        {
            Caption = 'Distribution 3';
        }

        field(47; "Distribution 4"; Decimal)
        {
            Caption = 'Distribution 4';
        }

        field(48; "Distribution 5"; Decimal)
        {
            Caption = 'Distribution 5';
        }

        field(49; "Distribution 6"; Decimal)
        {
            Caption = 'Distribution 6';
        }

        field(50; "Distribution 7"; Decimal)
        {
            Caption = 'Distribution 7';
        }

        field(51; "Distribution 8"; Decimal)
        {
            Caption = 'Distribution 8';
        }

        field(52; "Distribution 9"; Decimal)
        {
            Caption = 'Distribution 9';
        }
        field(53; "Distribution 10"; Decimal)
        {
            Caption = 'Distribution 10';
        }

        field(54; "Distribution 11"; Decimal)
        {
            Caption = 'Distribution 11';
        }

        field(55; "Distribution 12"; Decimal)
        {
            Caption = 'Distribution 12';
        }
        field(56; "Reminder amount VP"; Decimal)
        {
            Caption = 'Reminder amount VP';

        }
        field(57; "Reminder amount MP"; Decimal)
        {
            Caption = 'Reminder amount MP';

        }
        field(58; "Reminder amount SP"; Decimal)
        {
            Caption = 'Reminder amount SP';

        }
        field(59; "Reminder amount CNG"; Decimal)
        {
            Caption = 'Reminder amount CNG';

        }
        field(60; "Reminder amount KJKP"; Decimal)
        {
            Caption = 'Reminder amount KJKP';

        }
        field(61; "Path"; Text[250])
        {
            Caption = 'Path';

        }
        field(62; "Update Data"; Boolean)
        {
            Caption = 'Update Data';
            //da li će se ažurirati podaci 

        }

        field(63; "Error for summer"; Boolean)
        {
            Caption = 'Error for summer';
            //da li će se ažurirati podaci 

        }
        field(64; "No. series for Proceedings VP Reset"; code[20])
        {
            Caption = 'No. series for Proceedings Vp R';
            TableRelation = "No. Series";
        }









    }

    keys
    {
        key(Key1; PK)
        {
        }

    }

    fieldgroups
    {
    }
}

