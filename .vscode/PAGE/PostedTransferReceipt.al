pageextension 50254 "Posted Transfer Receipt" extends "Posted Transfer Receipt"
{
    layout
    {
        // Add changes to page layout here

        addafter("Posting Date")
        {
            field("Employee No."; "Employee No.") { }
            field("Employee Name"; "Employee Name") { }
        }

    }

    actions
    {
        modify("&Print")
        {
            Visible = false;
        }

        addafter("&Receipt")
        {
            action("TransferCalculation")
            {
                ApplicationArea = All;
                Caption = 'Transfer Calculation';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    TransferCalculation.SetParam(Rec."No.");
                    TransferCalculation.Run();

                end;
            }
        }
    }

    var
        myInt: Integer;
        TransferCalculation: Report "Retail Calculation";

}