pageextension 50011 "Sales Setup Additional Field" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("Date When Reminder Was Sent"; Rec."Date When Reminder Was Sent")
            {
                ApplicationArea = All;

                //ĐK
            }
            field("Reminder Date"; "Reminder Date") { }

        }
        addbefore("Posted Prepmt. Inv. Nos.")
        {
            field("Prepayment Invoice Nos."; "Prepayment Invoice Nos.") { ApplicationArea = All; }

        }
        addbefore("Posted Prepmt. Cr. Memo Nos.")
        {
            field("Corr. Prepayment Invoice Nos."; "Corr. Prepayment Invoice Nos.") { ApplicationArea = all; }
        }
        addbefore("Ignore Updated Addresses")
        {
            field("NN Customer Code"; "NN Customer Code") { ApplicationArea = all; }
        }
        addafter("Date When Reminder Was Sent")
        {
            field("Picture"; "Picture")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        addfirst(Processing)
        {
            action("Delete Picture")
            {
                Caption = 'Brisanje slike';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    if Rec.Picture.HasValue then
                        if Confirm(ConfirmDeletePicture) then begin
                            Clear(Rec.Picture);
                            CurrPage.SaveRecord();
                        end;
                end;

            }
        }
    }
    var
        ConfirmDeletePicture: Label 'Da li želite obrisati sliku ?';
}