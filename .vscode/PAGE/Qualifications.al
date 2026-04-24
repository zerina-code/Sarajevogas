pageextension 50075 Qualifications extends Qualifications
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Description 2"; "Description 2")
            {
                ApplicationArea = all;
            }
        }
        modify(Description)
        {
            Visible = false;
        }
        modify("Qualified Employees") { Visible = false; }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}