/*table 50249 "Candidate Feedback"
{
    Caption = 'Candidate Feedback';
    //   DrillDownPageID = "Candidate Feedback List";
    // LookupPageID = "Candidate Feedback List";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
        }
        field(2; Feedback; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "No.", Feedback)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Feedback)
        {
        }
    }
}

*/