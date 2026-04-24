pageextension 50120 Value_entries extends "Value Entries"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Sales Amount (Actual)")
        {
            field("Retail Unit Price"; "Retail Unit Price")
            {

            }
            field("Total Retail Amount"; "Total Retail Amount") { }
            field("Retail RUC"; "Retail RUC") { }
            field("Retail VAT"; "Retail VAT") { }
            field("Retail Unit Price with VAT"; "Retail Unit Price with VAT") { }
            field("T.Retail Unit Price with VAT"; "T.Retail Unit Price with VAT") { }


            field("Wholesale Unit Price"; "Wholesale Unit Price")
            {

            }
            field("Total Wholesale Amount"; "Total Wholesale Amount") { }
            field("Wholesale RUC"; "Wholesale RUC") { }
            field("Wholesale VAT"; "Wholesale VAT") { }
            field("Wholesale Unit Price with VAT"; "Wholesale Unit Price with VAT") { }
            field("T.Wholesale Unit Price with V"; "T.Wholesale Unit Price with V") { }

        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("&Navigate")
        {
            action("Leveling Report")
            {
                ApplicationArea = all;
                Caption = 'Leveling Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Shift+Ctrl+I';
                trigger OnAction()
                var
                    ValueEn: Record "Value Entry";
                begin

                    //

                    ValueEn.Reset();
                    ValueEn.SetFilter("Entry No.", '%1', rec."Entry No.");

                    Report.RUN(50157, TRUE, TRUE, ValueEn);


                end;
            }
        }
    }

    var
        myInt: Integer;
}