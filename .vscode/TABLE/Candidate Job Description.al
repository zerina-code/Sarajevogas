/*table 50252 "Candidate Job Description"
{
    Caption = 'Candidate Job Description List';
    DrillDownPageID = "Candidate Job Description List";
    LookupPageID = "Candidate Job Description List";

    fields
    {
        field(1; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            Editable = false;
            TableRelation = Candidates."Serial Number";
        }
        field(2; "Job position ID"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Job description ID';
            Editable = false;
        }
        field(3; "Job position"; Text[250])
        {
            Caption = 'Job position';
            Editable = true;
            TableRelation = "Position Menu".Description;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Serial Number", "Job position ID")
        {
        }
    }

    fieldgroups
    {
    }
}

*/