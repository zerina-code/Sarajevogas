table 50129 "Position Benefits"
{
    Caption = 'Position benefits';

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            TableRelation = "Misc. Article".Code;

            trigger OnValidate()
            begin
                "Benefit Type".SETFILTER("Code", '%1', "Code");
                IF "Benefit Type".FINDFIRST
                  THEN
                    Description := "Benefit Type".Description;
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Position Name"; Text[250])
        {
            Caption = 'Position Name';
        }
        field(50006; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
    }

    keys
    {
        key(Key1; "Position Code", "Code", Description, "Position Name", "Org. Structure")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Benefit Type": Record "Misc. Article";
        OrgShema: Record "ORG Shema";
        PositionMenu: Record "Position Menu";
}

