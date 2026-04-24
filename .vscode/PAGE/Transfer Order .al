pageextension 50091 TransferOrder extends "Transfer Order"
{
    layout
    {
        // Add changes to page layout here
        addbefore("Direct Transfer")
        {
            field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Status)
        {
            field("Employee No."; "Employee No.")
            {
                ApplicationArea = all;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = all;
            }
            field("Calculation Number"; "Calculation Number")
            {
                ApplicationArea = all;

            }

        }
        modify("Shortcut Dimension 1 Code") { Visible = false; }
        modify("Shortcut Dimension 2 Code") { Visible = false; }

        addlast(factboxes)
        {
            part(ItemInvoicingFactBox; "Item Invoicing FactBox")
            {
                Caption = 'Item Details';
                ApplicationArea = all;
                Provider = TransferLines;
                SubPageLink = "No." = FIELD("Item No.");
            }

            part(TransferLinesFactbox; "Transfer Line Factbox")
            {
                Caption = 'View reservation';
                ApplicationArea = All;
                Provider = TransferLines;
                SubPageLink = "Item No." = FIELD("Item No.");
            }
        }
    }

    actions
    {
        modify("Re&lease")
        {
            //amir: sakrio originalnu akciju kako bismo sprijecili mijenjanje statusa u Lansirano ako postoje reci gdje artikla nema na stanju
            visible = false;
        }

        addafter("Re&lease")
        {
            action("Re&lease1")
            {
                //amir: nova akcija potpuno identicna originalu, samo postavljeno razdvajanje 
                ApplicationArea = Location;
                Caption = 'Re&lease';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Ctrl+F9';
                ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                trigger OnAction()
                var

                    isOK: Boolean;
                    ReleaseTransferDoc: Codeunit "Release Transfer Document";
                    Tl: Record "Transfer Line";

                begin
                    begin
                        if rec."Gen. Bus. Posting Group" <> 'DOMAĆI' then begin

                            TL.reset;

                            tl.SetFilter("Gen. Prod. Posting Group", '<>%1', rec."Gen. Bus. Posting Group");
                            tl.SetFilter("Document No.", '%1', rec."No.");
                            if tl.FindFirst() then begin
                                Message('Opća knjižna grupa ' + Format("Gen. Bus. Posting Group") + ' ne nalazi se u svim redovima naloga. Sitan inventar i HTZ oprema mora biti posebno razdvojena od ostalih artikala!');
                            end;
                        end;
                        TestField("Posting Date");
                        TestField("Gen. Bus. Posting Group");

                        isOK := CheckBeforeRelease();
                        if NOT isOK then begin
                            Error(Text001, ItemNo);
                        end else begin
                            //amir: Ako količina artikla ima na skladištu svakog retka u nalogu za prenos, tada pozovi originalni Codeunit: 
                            ReleaseTransferDoc.Run(Rec);
                        end;
                        if Rec."Gen. Bus. Posting Group" = 'UPOTREBA' then begin
                            TestField("Employee No.");

                        end;
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        TransferOrderState: Codeunit "Transfer Order State";
    begin
        //Pozovi ovaj codeunit i označi da je poziv sa Naloga za prenos (true) i tada će originalni factbox da sakrije nepotrebna polja a prikaze samo jedno. 
        TransferOrderState.SetCalledFromTransferOrder(true);
    end;

    local procedure CheckBeforeRelease(): Boolean
    var
        isValid: Boolean;
        TL: Record "Transfer Line";
        ItemCheckAvail: Codeunit "Item-Check Avail.";
    begin
        isValid := true;

        TL.Reset();
        TL.SetRange("Document No.", Rec."No.");
        TL.SetRange("Derived From Line No.", 0);
        if TL.FindSet() then
            repeat
                if (TL."Item No." <> '') then begin
                    if ItemCheckAvail.TransferLineShowWarning(TL) then begin
                        ItemNo := TL."Item No.";
                        isValid := false;
                        exit(isValid);
                    end;
                end;
            until TL.Next() = 0;

        exit(isValid);
    end;


    var
        myInt: Integer;
        LocationTable: Record Location;
        ItemNo: Text;
        Text001: Label 'Item %1 has no quantity in the warehouse. Cannot proceed with the release.';
}