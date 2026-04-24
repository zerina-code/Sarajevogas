table 50110 "MZ"
{
    DataClassification = ToBeClassified;
    LookupPageId = "MZ-s";
    DrillDownPageId = "MZ-s";

    fields
    {
        field(1; "Code"; Code[20])
        {

            Caption = 'Code';

        }
        field(2; "Description"; Text[250])
        {

            Caption = 'Description';

        }
        field(3; Zone; Integer)
        {
            Caption = 'MZ Zone';
            TableRelation = Zone_Table.Code;
        }
        field(4; MZHSR; Integer)
        {
            Caption = 'MZ Zone';
            TableRelation = Zone_Table.Code;
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    trigger OnModify()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    trigger OnDelete()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    trigger OnRename()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

}