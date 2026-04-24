pageextension 50077 MyExtension extends Relatives
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(Relation; Relation)
            {
                ApplicationArea = all;
            }
            field(Sex; Sex)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}