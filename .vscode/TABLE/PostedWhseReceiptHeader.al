tableextension 50052 PostedWhseReceiptHeader extends "Posted Whse. Receipt Header"
{
    fields
    {
        field(50000; "Truck Number"; Code[30])
        {
            Caption = 'Truck Number';
        }
        field(50001; "CD Number"; Integer)
        {
            Caption = 'CD Number';
        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(50002; "Transport Document No."; Code[50])
        {
            Caption = 'Transport Document No.';
        }
        field(50003; "Driver No."; Integer)
        {
            Caption = 'Driver No.';
        }
        field(50004; "Driver Name"; Text[50])
        {
            Caption = 'Driver Name';
        }
        field(50005; "Shipping Agent Name"; Text[50])
        {
            Caption = 'Shipping Agent Name';
        }
        field(50006; "Supplier"; Text[50])
        {
            Caption = 'Supplier';
        }
        field(50007; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;

        }
        field(50008; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(500010; "Vendor No."; code[20])
        {
            Caption = 'Vendor No.';

        }
        field(500011; "Vendor Name"; Text[250])
        {
            Caption = 'Vendor Name';

        }
        field(50012; "Vendor Date"; Date)
        {

            Caption = 'Vendor Date';

        }
        field(50013; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(50014; "Responsible Name"; Text[250])
        {
            Caption = 'Responsible Name';
        }
        field(50015; "Responsible Position"; Text[250])
        {
            Caption = 'Responsible person position';
        }
        field(50016; "Destination test"; Text[200])
        {
            Caption = 'Destination test';

        }
        field(50578; "Driver Registraton No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';



        }
        field(50017; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
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
        field(70213; "User ID Number"; Code[50])
        {

            Caption = 'User ID Number';

        }
    }
}

