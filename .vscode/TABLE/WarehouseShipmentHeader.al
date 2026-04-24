tableextension 50079 WarehouseShipmentHeader extends "Warehouse Shipment Header"
{

    //ED

    fields
    {
        // Add changes to table fields here
        field(50000; "Truck Number"; Integer)
        {
            Caption = 'Truck Number';
            BlankZero = true;
        }
        field(50001; "CD Number"; Integer)
        {
            Caption = 'CD Number';
            BlankZero = true;
        }
        field(50060; "Employee No."; Code[20])
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
        field(50061; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50062; "Transfer Header No."; Code[20])
        {
            Caption = 'Transfer Header No.';
        }
        field(50100; "SalesHeaderReleased"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order),
                                                         Status = FILTER(Released),
                                                         "Shipment Date" = field(FilterDate))); //danas
            FieldClass = FlowField;
            Caption = 'Sales Header Released';
        }
        field(50101; "FilterDate"; Date) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            Caption = 'Filter Date';
        }
        field(50102; "ShipmentHeader"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Warehouse Shipment Header" WHERE("Shipment Date" = field(FilterDate)));
            FieldClass = FlowField;
            Caption = 'Shipment Header';
        }
        field(50103; "PostedShipmentHeader"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Posted Whse. Shipment Header" WHERE("Posting Date" = field(FilterDate)));
            FieldClass = FlowField;
            Caption = 'Posted Shipment Header';
        }
        field(50104; "WarehouseReceipts"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {

            CalcFormula = Count("Warehouse Receipt Header" WHERE("Posting Date" = field(FilterDate)));//where("Posting Date" = field(FilterDate)));
            FieldClass = FlowField;
            Caption = 'Warehouse Receipts';
        }
        field(50105; "PostedWarehouseReceipts"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Posted Whse. Receipt Header" WHERE("Posting Date" = field(FilterDate)));
            FieldClass = FlowField;
            Caption = 'Posted Warehouse Receipts';
        }
        field(50106; "AllMovements"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = filter(Movement)));
            FieldClass = FlowField;
            Caption = 'All Movements';
        }
        field(50107; "AllPutAways"; Integer) //ED hrpice za Role centar skladištara da ne bih uzimala još jedan tableextension
        {
            CalcFormula = Count("Warehouse Activity Header" WHERE(Type = filter("Put-away")));
            FieldClass = FlowField;
            Caption = 'Skladištenja - sva';
        }

        field(50108; "Document No."; Code[20])
        {
            Caption = 'Dobavljačev broj dokumenta';

        }
        field(50109; "Order Date"; Date)
        {
            Caption = 'Order Date';
        }
        field(50110; "Responsible Person Exit Name"; text[250])
        {
            Caption = 'Responsible Person Exit Name';

        }
        field(50111; "Responsible Person E Position"; text[250])
        {
            Caption = 'Responsible Person Exit Position';

        }
        field(50112; "Responsible Person Exit Unit"; text[250])
        {
            Caption = 'Responsible Person Exit Unit';

        }
        field(50113; "Destination test"; Text[200])
        {
            Caption = 'Destination test';

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

        field(50114; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';
            trigger OnValidate()
            var
                myInt: Record "Warehouse Shipment Line";
            begin
                myInt.Reset();
                myInt.SetFilter("No.", '%1', rec."No.");
                if myInt.FindSet() then
                    repeat
                        if myInt."Sales Header No." = '' then begin
                            myInt."Sales Header No." := rec."Sales Header No.";
                            myInt.Modify();
                        end;
                    until myInt.Next() = 0;

            end;

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }



    }


    trigger OnBeforeDelete()
    var
        myInt: Integer;
        WSL: Record "Warehouse Shipment Line";
        TransferH: Record "Transfer Header";
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        US: Record "User Setup";

    begin

        WSL.Reset();
        WSL.SetFilter("No.", '%1', "No.");
        if WSL.FindFirst() then begin
            TransferH.Reset();
            TransferH.SetFilter("No.", '%1', WSL."Source No.");
            if TransferH.FindFirst() then begin

                ReleaseTransferDoc.Reopen(TransferH);
                //    TransferH.Delete(true);
                Commit();
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    us."Last Org Shema" := TransferH."No.";
                    us.Modify();
                end;

            end;
        end;

    end;

    trigger OnDelete()
    var
        myInt: Integer;
        WSL: Record "Warehouse Shipment Line";
        TransferH: Record "Transfer Header";
        ReleaseTransferDoc: Codeunit "Release Transfer Document";
        US: Record "User Setup";

    begin


        //    ReleaseTransferDoc.Reopen(TransferH);

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            TransferH.Reset();
            TransferH.SetFilter("No.", '%1', us."Last Org Shema");
            if TransferH.FindFirst() then
                TransferH.Delete(true);

        end;

    end;

    procedure TodaysDate(Test: Integer) FilterDate: Date
    begin
        FilterDate := Today;
    end;

    var
        EmployeeTable: Record Employee;
}