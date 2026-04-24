pageextension 50108 "Location List" extends "Location List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field(Order; Order) { ApplicationArea = all; Visible = true; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetCurrentKey(Order);
        Ascending;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetCurrentKey(Order);
        Ascending;
    end;

    var
        myInt: Integer;
}