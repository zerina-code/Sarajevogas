pageextension 50138 "Service Manager" extends "Service Dispatcher Role Center"
{
    layout
    {
        // Add changes to page layout here
        modify(ApprovalsActivities) { Visible = false; }
        modify(Control32) { Visible = false; }
        modify("Power BI Report Spinner Part") { Visible = false; }
        modify(Control21) { Visible = false; }
        modify(Control1907692008) { Visible = false; }
        modify(Control1905989608) { Visible = false; }
        modify(Control31) { Visible = false; }
        modify("User Tasks Activities") { Visible = false; }





    }

    actions
    {

        addafter("Posted Documents")
        {
            group(Setups)
            {
                Caption = 'Setups';
                Image = Setup;

                action("Mandatory Attachment Types")
                {
                    ApplicationArea = Service;
                    Caption = 'Mandatory Attachment Types';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Mandatory Attachment Types";
                }
                //Mandatory Attachment Setup

                action("Mandatory Attachment Setup")
                {
                    ApplicationArea = Service;
                    Caption = 'Mandatory Attachment Setup';
                    Image = Attachments;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Mandatory Attachment Setup";
                }




            }
        }
        // Add changes to page actions here
        modify(Service)
        {
            Visible = false;
        }
        modify(Profit) { Visible = false; }
        modify(Loaners) { Visible = false; }
        modify("Item Journals") { Visible = false; }
        modify("Requisition Worksheets") { Visible = false; }
        modify("Service Contract &Quote") { Visible = false; }
        modify("Service &Contract") { Visible = false; }
        modify("Transfer &Order") { Visible = false; }
        modify(Tasks) { Visible = false; }
        modify(Administration) { Visible = false; }
        modify("Item &Tracing") { Visible = false; }

        addbefore("Service Q&uote")
        {
            action("Requests")
            {
                ApplicationArea = Service;
                Caption = 'Requests';
                Image = Quote;
                Promoted = false;
                Visible = False;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page Requests;
                RunPageMode = Create;
            }


        }

        addafter(Items)
        {



            action("Installation History")
            {
                ApplicationArea = Service;
                Caption = 'Requests';
                Image = List;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Installation History Page";
                //  RunPageMode = Create;
            }

            action("RN by Address")
            {
                ApplicationArea = Service;
                Caption = 'Requests';
                Image = List;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "List RN by address";



                //  RunPageMode = Create;
            }
            // "Page by Intervention"

            action("RN by Intervention")
            {
                ApplicationArea = Service;
                Caption = 'RN by Intervention';
                Image = List;
                Promoted = true;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Page by Intervention";

                //  RunPageMode = Create;
            }

            action("Transfer Orders")
            {
                ApplicationArea = Service;
                Caption = 'Transfer Orders';
                Image = List;
                RunObject = Page "Transfer Orders";
            }

            action("Employee Absence")
            {
                ApplicationArea = Service;
                Caption = 'Employee Absence';
                Image = List;
                RunObject = Page "Employee Absence";
            }
        }


    }


    var
        myInt: Integer;
}