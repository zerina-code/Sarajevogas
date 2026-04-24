table 50130 "Street"
{
    DataClassification = ToBeClassified;
    LookupPageId = Streets;
    DrillDownPageId = Streets;

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
        field(3; "Home No."; Code[20])
        {
            Caption = 'Home No';
        }
        field(4; "Floor"; Code[20])
        {
            Caption = 'Floor';
        }
        field(5; "Apartment No."; Code[5])
        {
            Caption = 'Apartment No.';
        }
    }

    keys
    {
        key(Key1; Code, "Home No.", "Apartment No.", Floor)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    trigger OnModify()

    var
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;



    trigger OnDelete()

    var
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;


    trigger OnRename()
    var
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;


}