pageextension 50118 "Fixed Asset G/L Journal" extends "Fixed Asset G/L Journal"
{
    layout
    {
        //R
        // Add changes to page layout here
        modify("FA Posting Date") { Visible = true; }
        addafter(Description)
        {
            field("FA Posting Group"; "FA Posting Group")
            {
                Caption = 'FA Posting Group';

            }
        }
        addafter("Document No.")
        {

            field(KUF_Entry; KUF_Entry) { }
            field(Correction; Correction) { }


        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}