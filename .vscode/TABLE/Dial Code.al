table 50001 "Dial Codes"
{
    Caption = 'Dial Codes';
    DrillDownPageID = "Dial Codes";
    LookupPageID = "Dial Codes";

    fields
    {
        field(1; "Country Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Fixed,Mobile';
            OptionMembers = "Fixed",Mobile;
        }
        field(50000; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            NotBlank = true;
            TableRelation = "Country/Region";
        }
        field(50001; City; Text[30])
        {
            Caption = 'City';
            NotBlank = true;
            TableRelation = "Post Code".City;

            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Country Code", "No.", "Line No.")
        {
        }
        key(Key2; "Line No.")
        {
        }
        key(Key3; City)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Country Code", "Country/Region Code", City, "No.", Type)
        {
        }
    }
}

