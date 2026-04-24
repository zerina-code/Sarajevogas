report 50031 "Create Massive RN Billing"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Calculation Journal Line")
        {

            trigger OnAfterGetRecord()
            var
                ServiceHeader: Record "Service Header";
                CUstomerInternal: record Customer;
                CalCFI: Record "Calculation Journal Line";
                ServiceTemp: Record "Service Line RN Temp";
                DepartmentCode: Code[20];
                Emp_2: code[20];
                ServiceItemLine: record "Service Item Line";
                Manag: Boolean;
                UseriD_Rec: Record "User Setup";
                EmployeeContractLedger: Record "Employee Contract Ledger";
                OrgSh: Record "ORG Shema";
                Department: Record Department;
                MM: Record "Service Item";
                ServiceItem: Record "Service Item";
                ServiceLineRN: Record "Service Line RN";
                ServiceLineRNEx: Record "Service Line RN";
                InternalCu: Record "Customer";


            begin

                //ja sada kreiram jedan radni nalog na osnovu višee aktivnosti
                BrojaCC += 1;
                LineB += 1000;
                if BrojaCC <> 1 then
                    exit;
                if BrojaCC = 1 then begin
                    ServiceHeader.Init();
                    ServiceHeader."No." := '';
                    ServiceHeader."Request Type" := ServiceHeader."Request Type"::"General Work Order";
                    ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
                    InternalCu.Reset();
                    InternalCu.SetFilter("Internal Customer", '%1', true);
                    if InternalCu.FindFirst() then
                        ServiceHeader.Validate("Customer No.", InternalCu."No.");
                    ServiceHeader.Validate("Calculation Code", DataItem1.Code);
                    ServiceHeader.Validate("Request Group", RequestGroup);
                    ServiceHeader.Validate("Activity Type", ActivityText);
                    ServiceHeader.validate("Prep. Contr. Empl. No.", "Prep. Contr. Empl. No.");
                    ServiceHeader.Validate("Prep. Process. Empl. No.", "Prep. Process. Empl. No.");
                    ServiceHeader.Validate("Prep. Verif. Empl. No.", "Prep. Verif. Empl. No.");
                    ServiceHeader.Validate("Reason For Service Order", "Reason For Service Order");
                    ServiceHeader.Validate("Remark For Service Order", "Remark For Service Order");
                    CUstomerInternal.Reset();
                    CUstomerInternal.setfilter("Internal Customer", '%1', true);
                    CUstomerInternal.SetFilter("Customer Category", '<>%1', CUstomerInternal."Customer Category"::CNG);
                    if CUstomerInternal.FindFirst() then
                        ServiceHeader.validate("Customer No.", CUstomerInternal."No.");
                    ServiceHeader.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
                    Manag := false;

                    UseriD_Rec.Get(UseriD);
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                    EmployeeContractLedger.SetFilter(Active, '%1', true);
                    if EmployeeContractLedger.FindFirst() then begin
                        if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                            Manag := true
                        else
                            Manag := false;
                    end;
                    Emp_2 := UseriD_Rec."Employee No. for Wage";

                    ServiceHeader."Responsible Department" := DepartmentCode;

                    OrgSh.Reset();
                    OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                    if OrgSh.FindFirst() then begin


                        Department.Reset();
                        Department.SetFilter(Code, '%1', DepartmentCode);
                        Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                        if Department.FindFirst() then
                            ServiceHeader."Responsible Department Name" := Department.Description
                        else
                            ServiceHeader."Responsible Department Name" := '';
                    end;
                    //    ServiceHeader."Bill type" := rec."Bill type";
                    //  ServiceHeader."Bill Category" := rec."Bill Category";


                    ServiceHeader."Request Department" := DepartmentCode;

                    OrgSh.Reset();
                    OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                    if OrgSh.FindFirst() then begin


                        Department.Reset();
                        Department.SetFilter(Code, '%1', DepartmentCode);
                        Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                        if Department.FindFirst() then
                            ServiceHeader."Request Department Name" := Department.Description
                        else
                            ServiceHeader."Request Department Name" := '';
                    end;

                    ServiceHeader.Insert(true);
                    Commit();
                end;
                if BrojaCC = 1 then begin
                    CalCFI.Reset();
                    CalCFI.CopyFilters(DataItem1);
                    if CalCFI.FindSet() then
                        repeat
                            LineB += 1000;

                            ServiceItemLine.Init();
                            ServiceItemLine."Document No." := ServiceHeader."No.";
                            ServiceItemLine."Document Type" := ServiceHeader."Document Type";
                            ServiceItemLine.Type := ServiceItemLine.Type::MM;
                            ServiceItemLine."Line No." := LineB;
                            MM.Reset();
                            //   MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                            mm.SetFilter("No.", '%1', CalCFI."Measuring Point Code");
                            //staro mjerno mjesto - preslikati kao da treba
                            if mm.FindFirst() then begin
                                //    ServiceItemLine.Validate("Service Item No. - Relation", mm."No.");
                                ServiceItemLine."Service Item No." := mm."No.";
                                ServiceItemLine."Service Item No. - Relation" := mm."No.";
                                LineB += 1000;

                                if ServiceItemLine."Service Item No." = '' then begin
                                    ServiceItemLine."Purpose" := '';
                                    ServiceItemLine."Dwelling Type" := '';
                                    ServiceItemLine."Elevation" := 0;
                                    ServiceItemLine."Reading Mode" := ServiceItemLine."Reading Mode"::Digital;
                                    ServiceItemLine."MM Category" := Enum::Category::" ";
                                    ServiceItemLine."Municipality Code" := '';
                                    ServiceItemLine."MZ" := '';
                                    ServiceItemLine."Street" := '';
                                    ServiceItemLine."Street No." := '';
                                    ServiceItemLine."String" := 0;
                                    ServiceItemLine.Gauge := '';
                                    ServiceItemLine."Stroke" := 0;
                                    ServiceItemLine."Zone Stroke" := 0;
                                    ServiceItemLine."Municipality Name" := '';
                                    ServiceItemLine."MZ Name" := '';
                                    ServiceItemLine."Street Name" := '';
                                    ServiceItemLine.Address := '';
                                    ServiceItemLine."Home No. MM" := '';
                                    ServiceItemLine."Floor MM" := '';
                                    ServiceItemLine."Apartment No. MM" := '';
                                    ServiceItemLine."Street No. Text MM" := '';
                                    ServiceItemLine."Phone No. MM" := '';

                                end;
                                mm.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                                ServiceItem.Get(mm."No.");
                                ServiceItem.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                                ServiceItemLine."Purpose" := ServiceItem."Purpose";
                                ServiceItemLine."Dwelling Type" := ServiceItem."Dwelling Type";
                                ServiceItemLine."Elevation" := ServiceItem."Elevation";
                                ServiceItemLine."Phone No. MM" := ServiceItem."Phone No. MM";
                                ServiceItemLine."Reading Mode" := ServiceItem."Reading Mode";
                                ServiceItemLine."MM Category" := ServiceItem."MM Category";
                                ServiceItemLine."Municipality Code" := ServiceItem."Municipality Code MM";
                                ServiceItemLine."MZ" := ServiceItem."MZ MM";
                                ServiceItemLine."Street" := Serviceitem.Street;
                                ServiceItemLine.Type := ServiceItemLine.Type::MM;
                                ServiceItemLine."Type G_R" := ServiceItemLine."Type G_R"::Gauge;
                                ServiceItemLine.validate("Service Item No. - Relation", ServiceItem."No.");

                                //  ServiceItemLine.Gauge := CalCFI.Gauge;
                                //  ServiceItemLine."Year of Production"

                                ServiceItemLine."Serial No." := ServiceItem."Serial No.";
                                ServiceItemLine."Gauge Size" := CalCFI."Gauge Size";
                                ServiceItemLine."Street No." := ServiceItem."Street No.";
                                ServiceItemLine.validate("Street No.", ServiceItem."Street No.");
                                ServiceItem.CalcFields("Street Name MM", "Municipality Name MM");
                                //   ServiceItemLine."Street Name" := ServiceItem."Street Name MM";
                                ServiceItemLine."String" := ServiceItem."Measuring Point string";
                                ServiceItemLine."Stroke" := ServiceItem."Measuring Point Stroke";
                                ServiceItemLine."Zone Stroke" := ServiceItem."Zone stroke";
                                //     ServiceItemLine."Municipality Name" := ServiceItem."Municipality Name MM";
                                //     ServiceItemLine."MZ Name" := ServiceItem."MZ Name MM";

                                ServiceItemLine.Address := ServiceItem."Address MM";
                                ServiceItemLine."Home No. MM" := ServiceItem."Home No.";
                                ServiceItemLine."Floor MM" := ServiceItem.Floor;
                                ServiceItemLine."Apartment No. MM" := ServiceItem."Apartment No.";
                                ServiceItemLine."Street No. Text MM" := ServiceItem."Street No. Text";

                            end;

                            ServiceItemLine."Customer No." := CalCFI."Customer No.";
                            ServiceItemLine."Customer Name" := CalCFI."Customer Name";

                            CUstFname.Reset();
                            CUstFname.SetFilter("No.", '%1', CalCFI."Customer No.");
                            if CUstFname.FindFirst() then begin
                                if CUstFname."Name 2" <> '' then begin
                                    ServiceItemLine."Customer Name New" := CUstFname.Name + ' ' + CUstFname."Name 2";
                                end
                                else begin
                                    ServiceItemLine."Customer Name New" := CUstFname.Name;
                                end;

                            end;

                            CUstFname.Reset();
                            CUstFname.SetFilter("No.", '%1', CalCFI."Customer No.");
                            if CUstFname.FindFirst() then begin
                                if CUstFname."Name 2" <> '' then begin
                                    ServiceItemLine."Customer Name" := CUstFname.Name + ' ' + CUstFname."Name 2";
                                end
                                else begin
                                    ServiceItemLine."Customer Name" := CUstFname.Name;
                                end;

                            end;




                            ServiceItemLine.Insert();


                            Commit();
                        until CalCFI.Next() = 0;
                end;

                if BrojaCC = 1 then begin
                    ServiceTemp.Reset();
                    if ServiceTemp.FindSet() then
                        repeat
                            ServiceLineRN.init;
                            ServiceLineRN.TransferFields(ServiceTemp);
                            ServiceLineRN."Document Type" := ServiceHeader."Document Type";
                            ServiceLineRN."Document No." := ServiceHeader."No.";
                            ServiceLineRNEx.Reset();
                            ServiceLineRNEx.SetFilter("Document No.", '%1', ServiceLineRN."Document No.");
                            ServiceLineRNEx.SetFilter("Document Type", '%1', ServiceLineRN."Document Type");
                            ServiceLineRNEx.SetFilter("Line No.", '%1', ServiceLineRN."Line No.");
                            if not ServiceLineRNEx.FindFirst() then
                                ServiceLineRN.Insert();
                        until ServiceTemp.Next() = 0;
                    commit;
                    // ServiceLineRN.TransferFields();
                end;


                //kraj






            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    Caption = 'Options';
                    field(RequestGroup; RequestGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'Request Group';
                        TableRelation = "Request Group".Description;
                    }
                    field(ActivityText; ActivityText)
                    {
                        Caption = 'Activity Text';
                        TableRelation = "Activity Type".Description;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            myInt: Integer;
                            Ac: Record "Activity Type";
                            ActPage: page "Activity Types";
                        begin
                            ac.Reset();
                            ac.SetFilter("Group request", '%1', RequestGroup);
                            ActPage.SetTableView(ac);
                            ActPage.Run();

                            IF ActPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                ActPage.GETRECORD(ac);
                                ActivityText := ac.Description;

                                Commit();

                            end;

                        end;
                    }
                    field("Reason For Service Order"; "Reason For Service Order")
                    {
                        Caption = 'Reason For Service Order';
                        TableRelation = "Dismantling Reason".Description where(type = filter("Reason for Service Order"));
                    }
                    field("Remark For Service Order"; "Remark For Service Order")
                    {
                        Caption = 'Remark For Service Order';

                    }
                    field("Prep. Process. Empl. No."; "Prep. Process. Empl. No.")
                    {
                        Caption = 'Preparation - Processing Employee No.';

                        TableRelation = Employee;
                    }
                    field("Prep. Contr. Empl. No.";
                    "Prep. Contr. Empl. No.")
                    {
                        Caption = 'Employee Control Responsible', Comment = 'Odgovorni zaposlenik';

                        TableRelation = Employee;
                    }
                    field("Prep. Verif. Empl. No."; "Prep. Verif. Empl. No.")
                    {
                        Caption = 'Preparation - Verification Employee No.';
                        TableRelation = Employee;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin


                        end;
                    }
                    field("Real. Process. Empl. No."; "Real. Process. Empl. No.")
                    {
                        Caption = 'Realisation - Processing Employee No.';
                        TableRelation = Employee;
                    }
                    field("Real. Contr. Empl. No."; "Real. Contr. Empl. No.")
                    {
                        Caption = 'Realisation - Processing Employee No.';
                        TableRelation = Employee;
                    }
                    field("Real. Verif. Empl. No."; "Real. Verif. Empl. No.")
                    {
                        Caption = 'Realisation - Verification Employee No.';
                        TableRelation = Employee;
                    }

                    field("Responsible Department"; "Responsible Department")
                    {
                        Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';

                        TableRelation = Department.Code;


                    }




                    part("Service Line RN Temp"; "Service Line RN Temp")

                    {
                        ApplicationArea = All;
                        //SubPageLink = "Massive Code" = field(dataitem.code);

                        // SubPageLink = "Massive Code" = field(DataItem1.Code);
                        //,"Document No."=filter();
                        //SubPageLink = "Document No."=field(Code);
                        //"Document Type" = field("Document Type"), "Document No." = field("No.");
                    }
                    //   subpagelink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                }
            }
        }


    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        //

        BrojaCC := 0;
        LineB := 0;

    end;



    var
        myInt: Integer;
        BrojaCC: Integer;
        CUstFname: Record customer;
        RequestGroup: Text[250];
        ActivityText: Text[250];
        "Reason For Service Order": text[250];
        "Remark For Service Order": text[250];
        LineB: Integer;
        "Prep. Process. Empl. No.": code[20];

        "Prep. Verif. Empl. No.": code[20];
        "Prep. Contr. Empl. No.": code[20];
        "Responsible Department": code[20];
        "Real. Verif. Empl. No.": code[20];
        "Real. Process. Empl. No.": code[20];
        "Real. Contr. Empl. No.": code[20];
}