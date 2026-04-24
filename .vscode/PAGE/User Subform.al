pageextension 50092 UserSubform extends "User Subform"
{
    layout
    {
        // Add changes to page layout here
        modify(ExtensionName)
        {
            Visible = false;
        }
        modify(PermissionScope)
        {
            Visible = false;
        }
    }


    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}