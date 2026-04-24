/*table 50069 "Employee Skills"
{
    // //MBO01

    Caption = 'Employee Skills';
    //ĐK DrillDownPageID = 99000863;
    // ĐK LookupPageID = 99000863;

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin

                IF "Employee No." <> '' THEN BEGIN
                    Employee.GET("Employee No.");
                    "First Name" := Employee."First Name";
                    "Last Name" := Employee."Last Name";
                    "E-mail" := Employee."E-Mail";
                    JMBG := Employee."Employee ID";
                    "Employment Date" := Employee."Employment Date";


                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", Rec."Employee No.");
                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        EmployeeContractLedger.CALCFIELDS("Position Description", "Minimal Education Level", "Manager 1");
                        EmployeeContractLedger.CALCFIELDS("Residence/Network", "Department Name", Sector, "Department Category", Group, "Manager 1 First Name", "Manager 1 Last Name");
                        EmployeeContractLedger.CALCFIELDS("Sector Description", "Department Cat. Description", "Group Description", "Phisical Org Dio", "Org Dio", "Phisical Org Dio Name", "Org Dio Name");


                        "Position Description" := EmployeeContractLedger."Position Description";
                        "Position Start Date" := EmployeeContractLedger."Starting Date";
                        //"Position ID":=EmployeeContractLedger."Position ID";
                        "Department Name" := EmployeeContractLedger."Department Name";
                        "Department ID" := EmployeeContractLedger."Department Code";
                      
                        "Direct Manager" := EmployeeContractLedger."Manager 1 First Name" + ' ' + EmployeeContractLedger."Manager 1 Last Name";

                        ECL.SETFILTER("Employee No.", '%1', EmployeeContractLedger."Manager 1");
                        ECL.SETFILTER(Active, '%1', TRUE);
                        IF ECL.FIND('+') THEN BEGIN
                            Empl.SETFILTER("No.", '%1', EmployeeContractLedger."Manager 1");
                            IF Empl.FINDLAST THEN BEGIN
                                "Head supervisor" := Empl."First Name" + ' ' + Empl."Last Name";

                            END;
                        END;

                    END;
                END;

            end;
        }
        field(4; Skill; Text[250])
        {
            Caption = 'Skill';
        }
        field(5; Level; Text[250])
        {
            Caption = 'Level';
        }
        field(9; JMBG; Code[13])
        {
            Caption = 'JMBG';
        }
        field(10; "Form ID"; Code[10])
        {
            Caption = 'Form ID';
        }
        field(11; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(12; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(13; "E-mail"; Text[100])
        {
        }
        field(14; "Position Description"; Text[120])
        {
            Caption = 'Position Description';
        }
        field(15; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(16; "Position Start Date"; Date)
        {
            Caption = 'Position Start Date';
        }
        field(17; "Department ID"; Code[10])
        {
            Caption = 'Department ID';
        }
        field(18; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
        }
        field(19; "Direct Manager"; Text[30])
        {
            Caption = 'Direct Manager';
        }
        field(20; "Head supervisor"; Text[30])
        {
            Caption = 'Head supervisor';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Employee No.")
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'This routing line cannot be moved because of critical work centers in previous operations';
        Text001: Label 'This routing line cannot be moved because of critical work centers in next operations';
        Employee: Record "Employee";
        Empl: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        Department: Record "Department";

    procedure Caption(): Text[100]
    var
        ReqWkshName: Record "Requisition Wksh. Name";
        ReqLine: Record "Requisition Line";
    begin
    end;

    local procedure GetLine()
    begin
    end;

    local procedure WorkCenterTransferfields()
    begin
    end;

    local procedure MachineCtrTransferfields()
    begin
    end;

    procedure SetRecalcStatus()
    begin
    end;

    procedure RunTimePer(): Decimal
    begin
    end;

    local procedure CalcStartingEndingDates()
    begin
    end;

    local procedure CalculateRoutingBack()
    begin
    end;

    local procedure CalculateRoutingForward()
    begin
    end;

    local procedure ModifyCapNeedEntries()
    begin
    end;

    local procedure AdjustComponents(var ReqLine: Record "Requisition Line")
    var
    //    PlanningComponent: Record "Employee Career";
    begin
    end;

    procedure TransferFromProdOrderRouting(var ProdOrderRoutingLine: Record "Prod. Order Routing Line")
    begin
    end;

    procedure UpdateDatetime()
    begin
    end;

    procedure SetNextOperations()
    var
        PlanningRtngLine2: Record "Employee Skills";
    begin
    end;

    local procedure GetGLSetup()
    begin
    end;
}

*/