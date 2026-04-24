table 50152 "Purchase Plans List"
{

    //ED 

    Caption = 'Purchase Plans List';
    DrillDownPageID = "Purchase Plans List";
    LookupPageID = "Purchase Plans List";

    fields
    {
        field(1; "Purchase Plan Code"; Code[4])
        {
            Caption = 'Purchase Plan Code';
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Purchase Plan Name';
        }
        field(3; Year; Integer)
        {
            Caption = 'Godina';
        }
    }

    keys
    {
        key(Key1; "Purchase Plan Code")
        {
            Clustered = true;
        }
    }

}

