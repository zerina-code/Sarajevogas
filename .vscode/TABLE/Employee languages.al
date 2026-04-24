/*table 50054 "Employee languages"
{
    Caption = 'Employee Languages';
    DrillDownPageID = "Employee languages";
    LookupPageID = "Employee languages";

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line no.';
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language code';
        }
        field(4; Level; Option)
        {
            Caption = 'Level';
            OptionCaption = 'A1,A2,B1,B2,C1,C2';
            OptionMembers = A1,A2,B1,B2,C1,C2;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

*/