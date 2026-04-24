tableextension 50094 TransferReceiptHeader extends "Transfer Receipt Header"
{
    fields
    {
        field(52010; "Calculation Number"; Text[50])
        {
            Caption = 'Calculation Number';
            Editable = false;
        }
        field(50022; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';

        }
        field(50018; "Correction"; Boolean)
        {
            Caption = 'Correction';
        }
        field(50024; "Group Calculation Number"; Text[50])
        {
            Caption = 'Group Calculation Number';
            Editable = false;
        }
        field(50020; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin

            end;

        }
        field(50021; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50025; "Original Correction"; Boolean)
        {

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }

    }
}