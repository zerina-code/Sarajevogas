tableextension 50051 "Posted Whse Shipment Header" extends "Posted Whse. Shipment Header"
{

    //ED 

    fields
    {
        field(50020; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
        }
        field(50021; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50108; "Document No."; Code[20])
        {
            Caption = 'Dobavljačev broj dokumenta';
            Editable = true;
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50109; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(50110; "Transferred"; Boolean)
        {
            Caption = 'Transferred to Item Journal Line';
            Editable = true;
        }
        field(50114; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

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
        field(501156; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Caption = 'G/L Account No.';
        }


    }
}