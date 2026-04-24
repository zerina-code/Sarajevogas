/*ĐK table 50079 "Grounds For Dispute"
{
    Caption = 'Grounds For Dispute';
    DrillDownPageID = "Grounds For Dispute";
    LookupPageID = "Grounds For Dispute";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
        }
        field(2; "Grounds For Dispute"; Text[150])
        {
            Caption = 'Grounds For Dispute';
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
        fieldgroup(DropDown; "No.", "Grounds For Dispute")
        {
        }
    }
}

*/