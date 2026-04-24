pageextension 50145 "Employment Contracts" extends "Employment Contracts"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("No Series"; "No Series") { }
            //   field("NAV ID";"NAV ID"){}
            field("Custom Report Layout"; "Custom Report Layout") { }
            field("NAV ID"; "NAV ID") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}