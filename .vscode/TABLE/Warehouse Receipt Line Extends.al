tableextension 50081 "Warehouse Receipt Line Extends" extends "Warehouse Receipt Line"
{
    fields
    {
        field(50022; "Print Quantity"; Integer) //ED za ispis kartica malog formata
        {
            Caption = 'Print Quantity';
        }
        field(50024; "Sales Order"; Code[20]) //ED za ispis kartica malog formata
        {
            Caption = 'Sales Order';
        }
        field(50017; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
    }

    var
        myInt: Integer;
}