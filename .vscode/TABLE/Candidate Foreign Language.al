/*table 50232 "Candidate Foreign Language"
{
    Caption = 'Candidate Foreign Language';
    DrillDownPageID = "Cand. Foreign Language List";
    LookupPageID = "Cand. Foreign Language List";

    fields
    {
        field(1; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            Editable = false;
            TableRelation = Candidates."Serial Number";
        }
        field(2; "Language Name"; Text[50])
        {
            Caption = 'Language Name';
            Editable = false;
        }
        field(3; "Language Code"; Code[10])
        {
            Caption = 'Language code';
            TableRelation = Languages.Code;

            trigger OnValidate()
            begin
                IF "Language Code" <> '' THEN BEGIN
                    Languages.RESET;
                    Languages.SETFILTER(Code, "Language Code");
                    IF Languages.FINDFIRST THEN
                        "Language Name" := Languages.Description;
                END
                ELSE
                    "Language Name" := '';
            end;
        }
        field(4; "Language Level"; Option)
        {
            Caption = 'Level';
            OptionCaption = 'Basic,Medium,Advanced,Active';
            OptionMembers = Basic,Medium,Advanced,Active;
        }
        field(5; ID; Integer)
        {
        }
    }

    keys
    {
        key(Key1; ID)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Languages: Record "Languages";
}

*/