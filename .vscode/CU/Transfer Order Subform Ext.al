pageextension 50151 "Transfer Order Subform Ext" extends "Transfer Order Subform"
{
    layout
    {
        modify(Description)
        {
            //Na nalogu za prenos korisnik ne treba da ima mogućnosti mijenjanja ovog polja. Nakon što se odabere artikal, tu piše naziv artikla i to je to.
            Editable = false;
        }
    }
}
