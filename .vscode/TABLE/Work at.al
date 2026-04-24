/*table 50203 "Work at"
{
    Caption = 'Work at';
    DrillDownPageID = "Work at";
    LookupPageID = "Work at";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
            //Đk
        }
        field(2; "Place Of Employment"; Text[100])
        {
            Caption = 'Place Of Employment';
            trigger OnValidate()
            var
                myInt: Integer;
                text: Text[250];
            begin


            end;
        }
    }

    keys
    {
        key(Key1; "No.", "Place Of Employment")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Place Of Employment")
        {
        }
    }
}

*/