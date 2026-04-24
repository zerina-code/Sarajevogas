table 50128 "War Debt Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'War Debt Setup';
    DrillDownPageId = "War Dept Setups";
    LookupPageId = "War Dept Setups";

    fields
    {
        field(1; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Category';

        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; "Month"; Integer)
        {
            MaxValue = 12;
            Caption = 'Month';
        }
        field(4; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(5; "Currency Code"; code[20])
        {
            Caption = 'Currency Code';
            TableRelation = Currency.Code;
        }
        field(6; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(7; "CBM"; Decimal)
        {
            Caption = 'CBM';
        }
        field(8; "Resource"; code[20])
        {
            Caption = 'Resource';
            TableRelation = Resource."No.";
        }
        field(9; "Totaling"; Text[20])
        {
            Caption = 'Totaling';

        }
    }

    keys
    {
        key(Key1; "Customer Category", Month)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        Active := true;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}