pageextension 50142 "Service Comment Sheet" extends "Service Comment Sheet"
{
    layout
    {
        // Add changes to page layout here
        addafter(Comment)
        {
            field("Comment Option"; "Comment Option") { ApplicationArea = all; }
            field(Problems; Problems) { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}