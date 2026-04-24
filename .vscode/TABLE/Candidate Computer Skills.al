/*table 50246 "Candidate Computer Skills"
{
    Caption = 'Candidate Computer Skills';
    DrillDownPageID = "Candidate Computer Skills List";
    LookupPageID = "Candidate Computer Skills List";

    fields
    {
        field(1; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            Editable = false;
            TableRelation = Candidates."Serial Number";
        }
        field(2; "Computer Knowledge Code"; Code[10])
        {
            Caption = 'Computer Knowledge Code';
            TableRelation = "Computer Knowledge"."Program Code";

            trigger OnValidate()
            begin
                IF "Computer Knowledge Code" <> '' THEN BEGIN
                    ComputerKnowledge.RESET;
                    ComputerKnowledge.SETFILTER("Program Code", "Computer Knowledge Code");
                    IF ComputerKnowledge.FINDFIRST THEN
                        "Computer Knowledge Description" := ComputerKnowledge.Description;
                END
                ELSE
                    "Computer Knowledge Description" := '';
            end;
        }
        field(3; "Computer Knowledge Description"; Text[100])
        {
            Caption = 'Computer Knowledge Description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Serial Number", "Computer Knowledge Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        ComputerKnowledge: Record "Computer Knowledge";
}

*/