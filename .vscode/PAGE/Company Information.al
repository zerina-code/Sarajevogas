pageextension 50021 MyExtensionComp extends "Company Information"
{
    layout
    {
        addafter("Country/Region Code")
        {
            field("Municipality Code"; "Municipality Code")
            {
                ApplicationArea = all;
            }

            field("Municipality Name"; "Municipality Name")
            {
                ApplicationArea = all;
                Editable = false;
            }


        }


        addafter("Fax No.") { field(Fax2; Fax2) { } }

        addafter("E-Mail")
        {
            field("E-mail2"; "E-mail2") { }
            field("Purchase E-mail"; Rec."Purchase E-mail") { ApplicationArea = All; }
        }

        addafter(Name)
        {
            field("Name 2"; "Name 2")
            { }
        }



        addafter("Industrial Classification")
        {
            field("Path Value"; "Path Value") { }
            field("Path for Documents"; "Path for Documents") { }
        }
        modify(County)
        {
            Visible = true;
            ApplicationArea = all;
        }
        // Add changes to page layout here
        addafter(County)
        {
            field("Entity Code"; "Entity Code")
            {
                ApplicationArea = all;
            }
        }
        addafter("Phone No.")
        {
            field("Contact Phone"; "Contact Phone") { ApplicationArea = all; }
            field("Phone No. 2"; "Phone No. 2") { ApplicationArea = all; }
            field("Purchase Phone No."; Rec."Purchase Phone No.") { ApplicationArea = All; }
            field("Dispatch Center"; "Dispatch Center")
            {
                ApplicationArea = all;
            }
            field("Phone Number Butile"; "Phone Number Butile") { }
            field("Fax Butile"; "Fax Butile") { }
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = all;
            }

            field("Tax No."; "Tax No.")
            {
                ApplicationArea = all;
            }


        }
        addafter(GLN)
        {
            field("Registration Text"; "Registration Text")
            {
                ApplicationArea = all;
            }

            field(MBS; MBS)
            {
                ApplicationArea = all;
            }
            field("Activity Code"; "Activity Code")
            {
                ApplicationArea = All;
            }
            field("Standard for the gas"; "Standard for the gas") { }
        }
        addafter("Home Page")
        {
            field("Operater No"; "Operater No")
            {
                ApplicationArea = all;
            }
            field("Operater E-mail"; "Operater E-mail")
            {
                ApplicationArea = all;
            }
            field("Prefix for JS"; "Prefix for JS")
            {
                ApplicationArea = all;
            }
            field("Ekstenzija za e-mail"; "Ekstenzija za e-mail")
            {
                ApplicationArea = all;
            }
        }
        addafter("Bank Name")
        {
            field("Bank No. 1"; "Bank No. 1")
            {
                ApplicationArea = all;
            }
            field("Bank No. 2"; "Bank No. 2")
            {
                ApplicationArea = all;
            }
            field("Bank No. 3"; "Bank No. 3")
            {
                ApplicationArea = all;
            }
            field("Bank No. 4"; "Bank No. 4")
            {
                ApplicationArea = all;
            }

            field("Bank No. 5"; "Bank No. 5")
            {
                ApplicationArea = all;
            }
            field("Bank No. 6"; "Bank No. 6")
            {
                ApplicationArea = all;
            }
            field("Bank No. 7"; "Bank No. 7")
            {
                ApplicationArea = all;
            }
            field("Bank No. 8"; "Bank No. 8")
            {
                ApplicationArea = all;
            }
            field("Bank No. 9"; "Bank No. 9")
            {
                ApplicationArea = all;
            }
            field("Bank No. 10"; "Bank No. 10")
            {
                ApplicationArea = all;
            }
            field("Bank No. 11"; "Bank No. 11")
            {
                ApplicationArea = all;
            }
            field("Bank No. 12"; "Bank No. 12")
            {
                ApplicationArea = all;
            }
            field("Bank No. 13"; "Bank No. 13")
            {
                ApplicationArea = all;
            }
            field("Bank No. 14"; "Bank No. 14")
            {
                ApplicationArea = all;
            }
            field("Bank No. 15"; "Bank No. 15")
            {
                ApplicationArea = all;
            }



            field("Employee Signatory"; "Employee Signatory") { ApplicationArea = all; }
            field("Spending Plan Responsible Person"; "Spending Plan Responsible Person")
            {
                ApplicationArea = All;
            }
            field("Spending Plan Responsible Person Name"; "Spending Plan Responsible Person Name")
            {
                ApplicationArea = all;
            }
            field("Spending Plan Responsible Person Position"; "Spending Plan Responsible Person Position")
            {
                ApplicationArea = all;
            }
            field("Accusation Responsible Person"; "Accusation Responsible Person")
            {
                ApplicationArea = All;
            }
            field("Accusation Responsible Person Name"; "Accusation Responsible Person Name")
            {
                ApplicationArea = all;
            }
            field("Accusation Responsible Person Position"; "Accusation Responsible Person Position")
            {
                ApplicationArea = all;
            }
            field("Accusation Responsible Person Exe"; "Accusation Responsible Person Exe") { }
            field("Accusation Phone No."; "Accusation Phone No.")
            {
                ApplicationArea = All;
            }
            field("Billing Signatory"; "Billing Signatory") { }
            field("Billing Signatory Emp"; "Billing Signatory Emp") { }
            field("Billing Sign"; "Billing Sign") { }

        }
        addafter(Picture)
        {
            field(Picture1; Picture1)
            {
                ApplicationArea = all;
            }
            field(Picture2; Picture2)
            {
                ApplicationArea = all;
            }
            field(Picture3; Picture3)
            {
                ApplicationArea = all;
            }

        }
        moveafter("Phone No."; "Fax No.")
        modify("Use GLN in Electronic Document")
        {
            Visible = false;
        }
        moveafter(Picture; "Industrial Classification")

        modify("Industrial Classification")
        {

            ApplicationArea = all;
        }
        modify("Auto. Send Transactions")
        {
            Visible = false;
        }
        modify("System Indicator")
        {
            Visible = false;
        }
        modify("User Experience")
        {
            Visible = false;
        }





    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}