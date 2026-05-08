table 50330 "Wage Value Entry"
{
    Caption = 'Wage Value Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Description = 'Primary Key';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'Date of posting to GL';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'Wage Header No.';
            TableRelation = "Wage Header";
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(9; "Wage Posting Group"; Code[10])
        {
            Caption = 'Wage Posting Group';
            Description = 'From employee-defines posting accts';
        }
        field(11; "Wage Ledger Entry No."; Integer)
        {
            Caption = 'Wage Ledger Entry No.';
            Description = 'WLE Primary Key';
        }
        field(12; "Wage Header Entry No."; Integer)
        {
            Caption = 'Document Entry No.';
        }
        field(24; "User ID"; Code[50])
        {
            Caption = 'User ID';

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //ĐK  LoginMgt.LookupUserID("User ID");
            end;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            Description = 'Not Used';
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'From Employee table';
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'From Employee table';
        }
        field(43; "Cost Amount (Actual)"; Decimal)
        {
            Caption = 'Cost Amount (Actual)';
            DecimalPlaces = 2 : 6;
        }
        field(45; "Cost Posted to G/L"; Decimal)
        {
            Caption = 'Cost Posted to G/L';
            DecimalPlaces = 2 : 6;
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(48; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(57; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            Description = 'Not used - when GL posting is automated (not through journal) this should be filled in';
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(105; "Entry Type"; Option)
        {
            Caption = 'Entry Type';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund,Untaxable,Use,Taxable,Work Experience';
            OptionCaption = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,VAT,Meal to pay,Meal to refund,Untaxable,Use,Taxable,Work Experience';
            OptionMembers = Tax,"Added Tax Per City","Net Wage",Contribution,"Sick Leave-Company","Sick Leave-Fund",Reduction,Transport,VAT,"Meal to pay","Meal to refund",Untaxable,Use,Taxable,"Work Experience";
        }
        field(106; "Contribution Type"; Code[10])
        {
            Caption = 'Contribution Type';
            TableRelation = Contribution.Code;
        }
        field(107; "G/L Entry No. (Account)"; Integer)
        {
            Caption = 'G/L Entry No. (Account)';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund';
        }
        field(108; "G/L Entry No. (Bal. Account)"; Integer)
        {
            Caption = 'G/L Entry No. (Bal. Account)';
            Description = 'Tax,Added Tax Per City,Net Wage,Contribution,Sick Leave-Company,Sick Leave-Fund,Reduction,Transport,Not Used-VAT,Meal to pay,Meal to refund';
        }
        field(109; "Reduction No."; Code[20])
        {
            Caption = 'Reduction No.';
            Description = 'Filled in if Entry Type is Reduction';
        }
        field(110; Status; Option)
        {
            Description = 'Not Used-Open,Posted,Paid,Posted+Paid';
            OptionCaption = 'Open,Posted,Paid,Posted+Paid';
            OptionMembers = Open,Posted,Paid,"Posted+Paid";
        }
        field(115; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            Description = 'Used for reporting-link to tax number and city tax percentage';
        }
        field(120; "AT From"; Boolean)
        {
            Description = 'Is AT entry from or over brutto';
        }
        field(121; "AT From neto"; Boolean)
        {
            Description = 'AT je iz Neta (spec porezi)';
        }
        field(125; Basis; Decimal)
        {
            Caption = 'Basis';
            Description = 'Actual basis used for calculating AT';
        }
        field(130; "Contracted Work"; Boolean)
        {
            Caption = 'Contracted Work';
        }
        field(131; "G/L Account No."; Code[10])
        {
            Caption = 'G/L Account No.';
        }
        field(132; "G/L Bal. Account No."; Code[10])
        {
            Caption = 'G/L Bal. Account No.';
        }
        field(133; "Wage Addition Type"; Code[10])
        {
            Caption = 'Wage Addition Type';
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Reduction Type"; Code[10])
        {
            Caption = 'Reduction Type';
        }
        field(199; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(200; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(201; Round; Integer)
        {
        }
        field(202; "Use Apportionment Account"; Boolean)
        {
            Caption = 'Use Apportionment Account';
        }
        field(203; Hours; Decimal)
        {
            Caption = 'Hours';
            DecimalPlaces = 3 : 3;
        }
        field(204; "Cost Amount (Netto)"; Decimal)
        {
            Caption = 'Cost Amount (Actual)';
            DecimalPlaces = 2 : 6;
        }
        field(205; "Cost Amount (Brutto)"; Decimal)
        {
            Caption = 'Cost Amount (Actual)';
            DecimalPlaces = 2 : 6;
        }
        field(206; "Contribution Category Code"; Code[10])
        {
            Caption = 'Contribution Category Code';
            TableRelation = "Contribution Category".Code;
        }
        field(207; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(208; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(209; Difference; Decimal)
        {
        }
        field(210; "RAD-1 Wage Excluded"; Boolean)
        {
            CalcFormula = Lookup("Wage Addition Type"."RAD-1 Wage Excluded" WHERE(Code = FIELD(Description)));
            FieldClass = FlowField;
        }
        field(211; "RAD-1 Wage Other"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Addition Type"."RAD-1 Wage Other" WHERE(Code = FIELD("Wage Addition Type")));

        }
        field(212; "Year of Wage"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Calculation"."Year of Wage" WHERE("Wage Header No." = FIELD("Document No.")));

        }
        field(213; "ECL Org"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Calculation"."Org Jed" WHERE("Employee No." = FIELD("Employee No."),
                                                                    "Wage Header No." = FIELD("Document No.")));

        }
        field(214; "ECL Mun"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Calculation".Munif WHERE("Employee No." = FIELD("Employee No."),
                                                                 "Wage Header No." = FIELD("Document No.")));

        }
        field(215; "Sector"; text[250])
        {
            Caption = 'Sector';
            TableRelation = Sector.Description;
        }
        field(216; "Department Category"; text[250])
        {
            Caption = 'Department Category';
            TableRelation = "Department Category".Description;
        }
        field(217; "Group"; text[250])
        {
            Caption = 'Group';
            TableRelation = Group.Description;
        }

        field(218; "Include WVE"; Boolean)
        {
            CalcFormula = Lookup("Wage Addition Type"."Include WVE" WHERE(Code = FIELD(Description)));
            FieldClass = FlowField;
        }
        field(219; "Tax Number"; Code[20])
        {
            Caption = 'Tax Number';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            SumIndexFields = "Cost Amount (Netto)", "Cost Amount (Brutto)";
        }
        key(Key2; "Document No.", "Wage Header Entry No.", "Posting Date")
        {
        }
        key(Key3; "Wage Ledger Entry No.", "Entry Type", "AT From")
        {
            SumIndexFields = "Cost Amount (Actual)", "Cost Posted to G/L";
        }
        key(Key4; "Employee No.")
        {
        }
        key(Key5; "Document No.", "Posting Date")
        {
        }
        key(Key6; "Global Dimension 1 Code", "Document No.", "Entry Type")
        {
            SumIndexFields = "Cost Amount (Actual)";
        }
    }

    fieldgroups
    {
    }

    var
        GLSetup: Record "General Ledger Setup";
        //ĐK DimMgt: Codeunit "DimensionManagement";
        GLSetupRead: Boolean;

    procedure GetCurrencyCode(): Code[10]
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
        EXIT(GLSetup."Additional Reporting Currency");
    end;
}

