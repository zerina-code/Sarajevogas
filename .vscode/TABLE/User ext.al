pageextension 50104 UserCard extends "User Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Windows User Name")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;

                UserSetup: Record "User Setup";
                UserRec: Record User;
                Emp: Record Employee;
            begin
                UserSetup.Reset();


                UserSetup.SetFilter("User ID", '%1', USERID);
                if UserSetup.FindFirst() then begin

                    UserSetup."New Username" := "User Name";
                    UserSetup.Modify();
                    Emp.Reset();
                    Emp.SetFilter("No.", '%1', UserSetup.UserEmp);
                    if Emp.FindFirst() then begin
                        Emp."Employee New User Name" := Rec."User Name";
                        Emp.Modify();
                    end;

                end;

            end;

        }
        modify("Authentication Email")
        {
            Visible = True;

        }
        modify("NAV Password Authentication") { Visible = true; }
        modify("ACS Authentication")
        {
            Visible = true;
        }
        modify("Web Service Access")
        {
            Visible = true;
        }
        modify("Office 365 Authentication")
        {
            Visible = True;
        }
        modify(UserGroups)
        {
            Visible = true;
        }
        modify(Plans)
        {
            Visible = True;
        }




    }

    actions
    {
        modify(DeleteExchangeIdentifier)
        {
            Visible = True;
        }

        // Add changes to page actions here
        modify(AcsSetup)
        {
            Visible = True;
        }
        modify(ChangePassword)
        {
            Visible = True;
        }
        modify(ChangeWebServiceAccessKey)
        {
            Visible = True;
        }
        modify("Effective Permissions")
        {
            Visible = True;
        }

    }



    var
        myInt: Integer;
}