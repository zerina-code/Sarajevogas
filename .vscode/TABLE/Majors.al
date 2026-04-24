/*table 50096 Majors
{
    Caption = 'Majors';
    DrillDownPageID = Majors;
    LookupPageID = Majors;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Institution/Company" WHERE("Type" = FILTER("Education"));

            trigger OnValidate()
            begin
                InstitutionRec.SETFILTER("No.", '%1', "No.");
                IF InstitutionRec.FINDFIRST THEN
                    Description := InstitutionRec.Description;
            end;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(50001; Major; Text[100])
        {
            Caption = 'Major of Graduation';
        }
        field(50002; Profession; Code[10])
        {
            Caption = 'Profession';
            TableRelation = Profession.Code;

            trigger OnValidate()
            begin
                IF Profession <> '' THEN BEGIN
                    ProfessionRec.RESET;
                    ProfessionRec.SETFILTER(Code, Profession);
                    IF ProfessionRec.FINDFIRST THEN
                        "Profession Description" := ProfessionRec.Description;
                END
                ELSE
                    "Profession Description" := '';
            end;
        }
        field(50003; "Profession Description"; Text[100])
        {
            Caption = 'Profession Description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.", Profession, Major)
        {
        }
    }

    fieldgroups
    {
    }

    var
        ProfessionRec: Record "Profession";
        InstitutionRec: Record "Institution/Company";
}
*/
