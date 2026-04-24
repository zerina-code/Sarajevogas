tableextension 50083 "Transfer Shipment Header" extends "Transfer Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(50020; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';




        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(501156; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Caption = 'G/L Account No.';
        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }
        field(50115; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(50021; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50108; "Document No."; Code[20])
        {
            Caption = 'Dobavljačev broj dokumenta';
        }
        field(50109; "Responsible Person Exit Name"; text[250])
        {
            Caption = 'Responsible Person Exit Name';

        }
        field(50110; "Responsible Person E Position"; text[250])
        {
            Caption = 'Responsible Person Exit Position';

        }
        field(50111; "Responsible Person Exit Unit"; text[250])
        {
            Caption = 'Responsible Person Exit Unit';

        }
        field(50012; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(50013; "Assigned User ID"; code[250])
        {
            Caption = 'Assigned User ID';
        }


        field(50022; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50018; "Calculation Number"; Text[50])
        {
            Caption = 'Calculation Number';
            Editable = false;
        }
        field(50024; "Group Calculation Number"; Text[50])
        {
            Caption = 'Group Calculation Number';
            Editable = false;
        }


    }

    var
        myInt: Integer;
}