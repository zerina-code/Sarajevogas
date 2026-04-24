
pageextension 50084 "Whse. Receipt Subform Extends" extends "Whse. Receipt Subform"
{
    layout
    {
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify("Over-Receipt Quantity")
        {
            Visible = false;
        }
        addafter(Quantity)
        {
            field("Print Quantity"; "Print Quantity")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    Text001: Label 'Broj za naljepnice ne smije biti manji ili jednak 0';
                begin
                    if "Print Quantity" < 0 then
                        Error(Text001);
                end;
            }
        }
    }
}