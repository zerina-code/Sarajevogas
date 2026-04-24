pageextension 50116 PostedWhseReceiptSubform extends "Posted Whse. Receipt Subform"
{
    Editable = true;
    layout
    {



        addafter(Description)
        {
            field("Print Quantity"; "Print Quantity")
            {
                ApplicationArea = all;
                Editable = true;
                trigger OnValidate()
                var
                    Text001: Label 'Broj za naljepnice ne smije biti manji ili jednak 0';
                begin
                    if "Print Quantity" < 0 then
                        Error(Text001);
                end;
            }
        }


        modify("Source Document") { Editable = false; }
        modify("Source No.") { Editable = false; }
        modify("Due Date") { Editable = false; }
        modify("Item No.") { Editable = false; }
        modify(Description) { Editable = false; }
        modify(Quantity) { Editable = false; }
        modify("Unit of Measure Code") { Editable = false; }

    }

}


