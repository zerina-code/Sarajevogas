tableextension 50078 WarehouseReceiptHeader extends "Warehouse Receipt Header"
{


    //ED 

    fields
    {
        // Add changes to table fields here
        field(50000; "Truck Number"; Code[30])
        {
            Caption = 'Truck Number';
            //BlankZero = true;
        }

        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(50001; "CD Number"; Integer)
        {
            Caption = 'CD Number';
            BlankZero = true;
        }
        field(50002; "Transport Document No."; Code[50])
        {
            Caption = 'Transport Document No.';
        }
        field(50003; "Driver No."; Integer)
        {
            Caption = 'Driver No.';
            TableRelation = "Warehouse Transporter"."Entry No.";

            trigger OnValidate()
            begin
                WarehouseTransporter.Reset();
                WarehouseTransporter.SetFilter("Entry No.", '%1', Rec."Driver No.");
                if WarehouseTransporter.FindFirst() then begin
                    Rec."Driver Name" := WarehouseTransporter.Driver;
                    Rec."Shipping Agent Name" := WarehouseTransporter."Shipping Agent Name";
                end;
            end;
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
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Employee No.");
                if EmployeeTable.FindFirst() then
                    "Employee Name" := StrSubstNo('%1 %2', Format(EmployeeTable."First Name"), Format(EmployeeTable."Last Name"));
            end;
        }
        field(50008; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50009; "UnfinishedDoc"; Integer)
        {
            CalcFormula = Count("Warehouse Receipt Header" WHERE("Document Status" = FILTER("Partially Received")));
            FieldClass = FlowField;
            Caption = 'Djelimično zaprimljene';
        }
        field(500010; "Vendor No."; code[20])
        {
            Caption = 'Vendor No.';

        }
        field(500011; "Vendor Name"; Text[250])
        {
            Caption = 'Vendor Name';

        }
        field(500012; "Vendor Date"; Date)
        {
            Caption = 'Vendor Date';
        }
        field(500013; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(500014; "Responsible Name"; Text[250])
        {
            Caption = 'Responsible Name';
        }
        field(50015; "Responsible Position"; Text[250])
        {
            Caption = 'Responsible person position';
        }
        field(50017; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50578; "Driver Registration No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';



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
        field(50016; "User ID Number"; Code[50])
        {

            Caption = 'User ID Number';

        }




    }

    trigger OnBeforeInsert()
    var
        myInt: Integer;
        WhseSetup: Record "Warehouse Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        US: Record "User Setup";
        NoManagement: Record "No. Series Relationship";
    begin
        if "No." = '' then begin
            us.Reset();
            us.SetFilter("User ID", '%1', UserId);
            if us.FindFirst() then begin
                if us."Povrat" = true then begin
                    WhseSetup.get;
                    WhseSetup.TestField("Whse. Receipt Nos.");
                    NoManagement.Reset();
                    NoManagement.SetFilter(Code, '%1', WhseSetup."Whse. Receipt Nos.");
                    if NoManagement.FindFirst() then begin

                        NoSeriesMgt.InitSeries(NoManagement."Series Code", xRec."No. Series", "Posting Date", "No.", "No. Series");

                    end
                    else begin
                        NoSeriesMgt.InitSeries(WhseSetup."Whse. Receipt Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");

                    end;
                end
                else begin
                    WhseSetup.Get();
                    if "No." = '' then begin
                        WhseSetup.TestField("Whse. Receipt Nos.");
                        NoSeriesMgt.InitSeries(WhseSetup."Whse. Receipt Nos.", xRec."No. Series", "Posting Date", "No.", "No. Series");
                    end;


                end;
            end;
        end;
    end;

    var

    VAR

        WarehouseTransporter: Record "Warehouse Transporter";
        EmployeeTable: Record Employee;
}