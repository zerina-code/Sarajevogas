pageextension 50057 "Posted Sales Cr Memo" extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("VAT Date"; "VAT Date")
            {

            }
            field("Shipment Date"; "Shipment Date")
            {

            }
            field("Fiscal No. Printed"; "Fiscal No. Printed")
            {

            }
            field("Fiscal No."; "Fiscal No.")
            {

            }
            field("Fiscal DateTime"; "Fiscal DateTime")
            {

            }
            field("Fiscal User"; "Fiscal User")
            {

            }
            field("Remark for CR Memo"; "Remark for CR Memo") { }
            field
            ("Control Employee USERID"; "Control Employee USERID")
            { Editable = false; }
            field("Posting Employee USERID"; "Posting Employee USERID") { Editable = false; }
            field("Exe Employee USERID"; "Exe Employee USERID") { Editable = false; Visible = false; }


        }
        addafter("Salesperson Code")
        {
            field("Bal. Account No."; "Bal. Account No.")
            {

            }
        }
        addafter("Document Date")
        {
            field("Posting Description"; "Posting Description")
            {
                Visible = true;
                editable = true;
            }
            field(KUF_Entry; KUF_Entry)
            {

            }
            field("Bill type"; "Bill type")
            {
                Visible = true;
                Editable = false;
            }

        }

    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }
        // Add changes to page actions here
        addafter(Print)
        {
            action("Fiscal print")

            {
                Caption = 'Order Confirmation Cr. Memo';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    //ReportRun.SetParam(Rec."No.", FALSE);
                    Report.Run(40128, true, true, Rec);
                end;
            }


            action("Fiscal print srr")

            {
                Caption = 'Fiscal print srr';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CU.SetParam(rec."No.", true);
                    CU.Run();


                end;
            }
            action(PrintCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Ispis';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    SCMH: Record "Sales Cr.Memo Header";
                    CM: Report "Credit Memo";
                begin
                    SCMH.Reset();
                    SCMH.SetRange("No.", Rec."No.");
                    SCMH.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    CM.SetTableView(SCMH);
                    CM.Run();
                end;
            }
        }

    }

    var
        myInt: Integer;
        ReportRun: Report "Posted Sales - Credit Memo";
        CU: Codeunit FiscalPrinter;
}