/*ĐK table 50089 Injury
{
    Caption = 'Injury';
    DrillDownPageID = "Injury List";
    LookupPageID = "Injury List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; "Injury Name"; Text[250])
        {
            Caption = 'Injury Name';
        }
        field(3; "Measure Type"; Option)
        {
            Caption = 'Measure Type';
            OptionCaption = ' ,Lighter, Heavier';
            OptionMembers = " ",Lighter," Heavier";
        }
    }

    keys
    {
        key(Key1; "No.", "Injury Name", "Measure Type")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Injury Name")
        {
        }
    }
}

*/