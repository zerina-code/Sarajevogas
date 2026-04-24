pageextension 50042 GenJournalBatchExtends extends "General Journal Batches"
{
    layout
    {
        addafter("Copy to Posted Jnl. Lines")
        {
            field(TAB; TAB) { ApplicationArea = all; }
            field(Commissioning; Commissioning) { ApplicationArea = all; }
            field("Cashier Table"; "Cashier Table") { ApplicationArea = all; }
            field("Path for Cashier"; "Path for Cashier") { ApplicationArea = all; }
            field("Payment to Employees"; "Payment to Employees") { }
            field("No. series Payment Int"; "No. series Payment Int") { }
            field("No. series Payment Int Card"; "No. series Payment Int Card") { }
        }


    }

    actions
    {
        // Add changes to page actions here
        addafter(EditJournal)
        {
            action("Import Bank Statement")
            {
                ApplicationArea = all;
                Caption = 'Import Bank Statement';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import Bank Statement for selected journal batch.';

                trigger OnAction()
                var
                    BS: Report "Bank Statement Tab";
                begin
                    if Rec.TAB = Rec.TAB::TAB then
                        BS.SetParam(Rec.Name, Rec."Journal Template Name", true)
                    else
                        BS.SetParam(Rec.Name, Rec."Journal Template Name", false);
                    BS.Run();
                    CurrPage.Close();


                end;
            }
            //Bank Statement Central

        }


    }


    var
        myInt: Integer;
}