/* ne koristi se table 50001 "BaH Fiscal User Setup"
{
    // BH1.00, Fiscal Process

    Caption = 'User Setup';
    // LookupPageID = 57070;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            Caption = 'User ID';
            NotBlank = true;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //ĐK      LoginMgt.LookupUserID("User ID");
            end;

            trigger OnValidate()
            var
                LoginMgt: Codeunit "User Management";
            begin
                //ĐK   LoginMgt.ValidateUserID("User ID");
            end;
        }
        field(2; "Fiscal Printer Code"; Code[10])
        {
            Caption = 'Fiscal printer code';
            //đk   TableRelation = "BaH Fiscal Printer Setup";
        }
    }

    keys
    {
        key(Key1; "User ID")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'The %1 Salesperson/Purchaser code is already assigned to another User ID %2.';
        Text003: Label 'You cannot have both a %1 and %2. ';
        Text004: Label 'The %1 User ID does not have a %2 assigned.';
        Text005: Label 'You cannot have approval limits less than zero.';
}

*/