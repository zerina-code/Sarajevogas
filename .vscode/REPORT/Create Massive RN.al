report 50007 "Create Massive RN"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Gauge Change Temporery")
        {

            trigger OnAfterGetRecord()
            var
                ServiceHeader: Record "Service Header";
                CUstomerInternal: record Customer;
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
                GaugeF: Record "Gauge Change Temporery";
                GaugeR: Record Gauge;
                CUstFname: Record Customer;


            begin

                //ja sada kreiram jedan radni nalog na osnovu višee aktivnosti
                BrojaCC += 1;

                if BrojaCC = 1 then begin
                    LineB += 1000;
                    ServiceHeader.Init();
                    ServiceHeader."No." := '';
                    ServiceHeader."Request Type" := ServiceHeader."Request Type"::"General Work Order";
                    ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
                    ServiceHeader.Validate("Request Group", RequestGroup);
                    ServiceHeader.Validate("Activity Type", ActivityText);
                    ServiceHeader.Validate("Reason For Service Order", "Reason For Service Order");
                    ServiceHeader.Validate("Remark For Service Order", "Remark For Service Order");
                    if CustomerN = '' then begin
                        CUstomerInternal.Reset();
                        CUstomerInternal.setfilter("Internal Customer", '%1', true);
                        CUstomerInternal.SetFilter("Customer Category", '<>%1', CUstomerInternal."Customer Category"::CNG);
                        if CUstomerInternal.FindFirst() then
                            ServiceHeader.validate("Customer No.", CUstomerInternal."No.");

                    end
                    else begin
                        ServiceHeader.validate("Customer No.", CustomerN);
                    end;

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
                    ServiceHeader."Massive Code" := DataItem1.Code;
                    ServiceHeader.Validate("Real. Process. Empl. No.", "Employee Prepare Responsible");
                    ServiceHeader.Validate("Real. Contr. Empl. No.", "Employee Control Responsible");
                    ServiceHeader.Validate("Real. Verif. Empl. No.", "Prep. Verif. Empl. No.");
                    ServiceHeader.Insert(true);
                    Commit();
                end;
                if BrojaCC = 1 then begin
                    GaugeF.Reset();
                    GaugeF.CopyFilters(DataItem1);
                    if GaugeF.FindSet() then
                        repeat
                            LineB += 10000;
                            ServiceItemLine.Init();
                            ServiceItemLine."Document No." := ServiceHeader."No.";
                            ServiceItemLine."Document Type" := ServiceHeader."Document Type";
                            ServiceItemLine.Type := ServiceItemLine.Type::MM;
                            ServiceItemLine."Line No." := LineB;
                            MM.Reset();
                            //   MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                            mm.SetFilter("No.", '%1', GaugeF."Measuring Point Code");
                            //staro mjerno mjesto - preslikati kao da treba
                            if mm.FindFirst() then begin
                                //    ServiceItemLine.Validate("Service Item No. - Relation", mm."No.");
                                ServiceItemLine."Service Item No." := mm."No.";
                                ServiceItemLine."Service Item No. - Relation" := mm."No.";


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

                                end;
                                mm.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                                ServiceItem.Get(mm."No.");
                                ServiceItem.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                                ServiceItemLine."Purpose" := ServiceItem."Purpose";
                                ServiceItemLine."Dwelling Type" := ServiceItem."Dwelling Type";
                                ServiceItemLine."Elevation" := ServiceItem."Elevation";
                                ServiceItemLine."Reading Mode" := ServiceItem."Reading Mode";
                                ServiceItemLine."MM Category" := ServiceItem."MM Category";
                                ServiceItemLine."Municipality Code" := ServiceItem."Municipality Code MM";
                                ServiceItemLine.validate("MZ", ServiceItem."MZ MM");
                                ServiceItemLine."Phone No. MM" := ServiceItem."Phone No. MM";
                                ServiceItemLine.Remotely := ServiceItem.Remotely;
                                ServiceItemLine."Remotely Type" := ServiceItem."Remotely Type";



                                ServiceItemLine.validate("Street No.", ServiceItem."Street No.");
                                //  ServiceItemLine."Street Name" := ServiceItem."Street Name MM";
                                //ServiceItemLine."Municipality Name" := ServiceItem."Municipality Name MM";
                                //ServiceItemLine."MZ Name" := ServiceItem."MZ Name MM";
                                ServiceItemLine."String" := ServiceItem."Measuring Point string";
                                ServiceItemLine."Stroke" := ServiceItem."Measuring Point Stroke";
                                ServiceItemLine."Zone Stroke" := ServiceItem."Zone stroke";
                                // ServiceItemLine."Municipality Name" := ServiceItem."Municipality Name MM";
                                ServiceItemLine."MZ Name" := ServiceItem."MZ Name MM";
                                ServiceItemLine."Street Name" := ServiceItem."Street Name MM";
                                ServiceItemLine.validate("Street", Serviceitem.Street);
                                ServiceItemLine.Address := ServiceItem."Address MM";
                                ServiceItemLine."Home No. MM" := ServiceItem."Home No.";
                                ServiceItemLine."Floor MM" := ServiceItem.Floor;
                                ServiceItemLine."Apartment No. MM" := ServiceItem."Apartment No.";
                                ServiceItemLine.validate("Street No. Text MM", ServiceItem."Street No. Text");
                                ServiceItemLine.Gauge := GaugeF."Gauge Code";
                                ServiceItemLine."Year of Production" := GaugeF."Production Year";
                                ServiceItemLine."DD calibration" := GaugeF."DD calibration";


                                ServiceItemLine."Serial No." := GaugeF."Inventory Number";//serijski broj
                                ServiceItemLine.RMS := GaugeF."Inventory Number";
                                GaugeR.Reset();
                                GaugeR.SetFilter(Code, '%1', GaugeF."Gauge Code");
                                if GaugeR.FindFirst() then
                                    ServiceItemLine."Gauge Size" := GaugeR."Gauge Size";
                                ServiceItemLine."Date of consumption" := GaugeF."Date of consumption";
                                ServiceItemLine."Gas Station Placement" := GaugeF."Gas Station Placement";
                                ServiceItemLine.Reading := GaugeF.Reading;
                                ServiceItemLine."Customer No." := GaugeF."Customer No.";
                                ServiceItemLine."Customer Name" := GaugeF."Customer Name";

                                CUstFname.Reset();
                                CUstFname.SetFilter("No.", '%1', GaugeF."Customer No.");
                                if CUstFname.FindFirst() then begin
                                    if CUstFname."Name 2" <> '' then begin
                                        ServiceItemLine."Customer Name" := CUstFname.Name + ' ' + CUstFname."Name 2";
                                    end
                                    else begin
                                        ServiceItemLine."Customer Name" := CUstFname.Name;
                                    end;

                                end;
                                ServiceItemLine."Meter Manufacturer" := GaugeF."Meter Manufacturer Code";
                                ServiceItemLine."Meter Manufacturer Desc" := GaugeF."Measurer manufacturer";

                                ServiceItemLine."New Gauges" := GaugeF."Gauge Code New";
                                ServiceItemLine."Type G_R" := DataItem1.Type;
                                ServiceItemLine."Inventory Number New" := GaugeF."Inventory Number New";//serijski broj
                                GaugeR.Reset();
                                GaugeR.SetFilter(Code, '%1', GaugeF."Gauge Code New");
                                if GaugeR.FindFirst() then
                                    ServiceItemLine."Gauge Size New" := GaugeR."Gauge Size";
                                ServiceItemLine."Date of consumption New" := GaugeF."Date of consumption New";
                                ServiceItemLine."Reading New" := GaugeF."Reading New";
                                ServiceItemLine."MZ MM New" := GaugeF."MZ Name MM New";
                                ServiceItemLine."Street MM New" := GaugeF."Street MM New";
                                ServiceItemLine."MZ Name MM New" := GaugeF."MZ Name MM New";
                                ServiceItemLine."Address MM New" := GaugeF."Address MM New";
                                ServiceItemLine."Customer No. New" := GaugeF."Customer No. New";
                                ServiceItemLine."Customer Name New" := GaugeF."Customer Name New";


                                ServiceItemLine."Street No. MM New" := GaugeF."Street No. MM New";
                                ServiceItemLine."Customer Name New" := GaugeF."Customer Name New";

                                CUstFname.Reset();
                                CUstFname.SetFilter("No.", '%1', GaugeF."Customer No. New");
                                if CUstFname.FindFirst() then begin
                                    if CUstFname."Name 2" <> '' then begin
                                        ServiceItemLine."Customer Name New" := CUstFname.Name + ' ' + CUstFname."Name 2";
                                    end
                                    else begin
                                        ServiceItemLine."Customer Name New" := CUstFname.Name;
                                    end;

                                end;


                                ServiceItemLine."Customer City New" := GaugeF."Customer City New";
                                ServiceItemLine."Street Name MM New" := GaugeF."Street Name MM New";
                                ServiceItemLine."DD calibration New" := GaugeF."DD calibration New";
                                ServiceItemLine."MM Description New" := GaugeF."MM Description New";
                                ServiceItemLine."Serial Number I New" := GaugeF."Serial Number I New";
                                ServiceItemLine."Serial Number II New" := GaugeF."Serial Number II New";
                                ServiceItemLine."Customer string New" := GaugeF."Customer string New";
                                ServiceItemLine."Customer Stroke New" := GaugeF."Customer Stroke New";
                                ServiceItemLine."Production Year New" := GaugeF."Production Year New";
                                ServiceItemLine."Calibration Year New" := GaugeF."Calibration Year New";
                                ServiceItemLine."Customer Address New" := GaugeF."Customer Address New";
                                ServiceItemLine."Dismantling date New" := GaugeF."Dismantling date New";
                                ServiceItemLine."Programming date New" := GaugeF."Programming date New";
                                ServiceItemLine."Customer Category New" := GaugeF."Customer Category New";
                                ServiceItemLine."Customer Post Code New" := GaugeF."Customer Post Code New";
                                ServiceItemLine."Date of consumption New" := GaugeF."Date of consumption New";
                                ServiceItemLine."Customer Zone stroke New" := GaugeF."Customer Zone stroke New";
                                ServiceItemLine."Date of rescheduling New" := GaugeF."Date of rescheduling New";
                                ServiceItemLine."Municipality Code MM New" := GaugeF."Municipality Code MM New";
                                ServiceItemLine."EL Volume Description New" := GaugeF."EL Volume Description New";
                                ServiceItemLine."Measurer manufacturer New" := GaugeF."Measurer manufacturer New";
                                ServiceItemLine."Measuring Point string New" := GaugeF."Measuring Point string New";
                                ServiceItemLine."Measuring Point Stroke New" := GaugeF."Measuring Point Stroke New";
                                ServiceItemLine."Reason for dismantling New" := GaugeF."Reason for dismantling New";
                                ServiceItemLine."Measuring Point Address New" := GaugeF."Measuring Point Address New";
                                ServiceItemLine."Installation Date New" := GaugeF."Installation Date New";
                                ServiceItemLine."Measuring Point Code New" := GaugeF."Measuring Point Code New";




                            end;

                            ServiceItemLine.Insert();
                        until GaugeF.Next() = 0;

                    Commit();


                    ServiceTemp.Reset();
                    if ServiceTemp.FindSet() then
                        repeat
                            ServiceLineRN.init;
                            ServiceLineRN.TransferFields(ServiceTemp);
                            ServiceLineRN."Document Type" := ServiceHeader."Document Type";
                            ServiceLineRN."Document No." := ServiceHeader."No.";
                            if ServiceLineRN."Unit of Measure Code2" = '' then
                                ServiceLineRN."Unit of Measure Code2" := 'SAT';
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

                    field(CustomerN; CustomerN)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No.';
                        TableRelation = Customer;

                    }
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
                            //    ActPage.Run();
                            ActPage.LookupMode(true);
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
                    field("Employee Prepare Responsible"; "Employee Prepare Responsible")
                    {
                        Caption = 'Employee Prepare Responsible', Comment = 'Odgovorni zaposlenik';

                        TableRelation = Employee;
                    }
                    field("Employee Control Responsible";
                    "Employee Control Responsible")
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
        CusF.Reset();
        CusF.SetFilter("Internal Customer", '%1', true);
        cusf.SetFilter("Customer Category", '<>%1', cusf."Customer Category"::CNG);
        if cusf.FindFirst() then begin
            CustomerN := CusF."No.";
        end;


    end;



    var
        myInt: Integer;
        CusF: Record Customer;
        BrojaCC: Integer;
        CustomerN: Code[20];
        RequestGroup: Text[250];
        ActivityText: Text[250];
        "Reason For Service Order": text[250];
        "Remark For Service Order": text[250];
        LineB: Integer;
        "Employee Control Responsible": code[20];
        "Employee Prepare Responsible": code[20];
        "Prep. Verif. Empl. No.": code[20];
}