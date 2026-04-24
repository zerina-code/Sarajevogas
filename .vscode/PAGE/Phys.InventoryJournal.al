pageextension 50199 "Phys.InventoryJournal" extends "Phys. Inventory Journal"
{
    layout
    {
        addafter("Unit Cost")
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Employee Name"; Rec."Employee Name")
            {
                ApplicationArea = Basic, Suite;
            }
        }

    }

    actions
    {
        modify(Print)
        {
            Visible = false;
        }

        ADDAFTER(Print)
        {
            action("Import Inventory")
            {
                Caption = 'Import inventory';
                Image = ImportExport;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = xmlport "Import Inventory";
                trigger OnAction()
                begin
                    CurrPage.UPDATE;
                end;
            }

            action(PrintCustom)
            {
                ApplicationArea = Basic, Suite;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                Scope = Repeater;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    ItemJournalBatch.SetRange("Journal Template Name", "Journal Template Name");
                    ItemJournalBatch.SetRange(Name, "Journal Batch Name");
                    REPORT.RunModal(50178, true, false, ItemJournalBatch);
                end;
            }
        }

        addbefore(CalculateCountingPeriod)
        {
            action(CalculateInventory_v1)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Calculate &Inventory';
                Ellipsis = true;
                Image = CalculateInventory;
                Promoted = true;
                PromotedCategory = Category5;
                Scope = Repeater;
                ToolTip = 'Start the process of counting inventory for employee by filling the journal with known quantities.';

                trigger OnAction()
                begin
                    CalcQtyOnHand_v1.SetItemJnlLine(Rec);
                    CalcQtyOnHand_v1.RunModal;
                    Clear(CalcQtyOnHand_v1);
                end;
            }
        }

    }

    var
        myInt: Integer;
        ItemJournalBatch: Record "Item Journal Batch";
        CalcQtyOnHand_v1: Report "Calculate Inventory v1";
}