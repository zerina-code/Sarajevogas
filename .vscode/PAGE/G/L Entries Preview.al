pageextension 50140 "G_L entry Preview" extends "G/L Entries Preview"
{
    layout
    {
        modify("Debit Amount") { visible = true; }
        modify("Credit Amount") { Visible = true; }
        modify("Amount") { visible = false; }
        // Add changes to page layout here
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter(Description, '<>%1', 'Direktni trošak  na *');
        SetCurrentKey("New Order");

        Ascending;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        P: page "G/L Posting Preview";
        CU: Codeunit "Gen. Jnl.-Post Preview";
    begin
        SetFilter(Description, '<>%1', 'Direktni trošak  na *');
        SetCurrentKey("Posting Date", "Document No.", "New Order");

        Ascending;

    end;


    var
        myInt: Integer;
}