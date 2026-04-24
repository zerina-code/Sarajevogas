/*ĐK - Disciplinske mjere table 50165 "Category Disciplinary Measure"
{
    Caption = 'Category Disciplinary Measure';
    DrillDownPageID = "Category Disc. Measure List";
    LookupPageID = "Category Disc. Measure List";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; Category; Code[20])
        {
            Caption = 'Category';
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
        }
    }

    keys
    {
        key(Key1; Category, Name)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Category, Name)
        {
        }
    }
}

*/