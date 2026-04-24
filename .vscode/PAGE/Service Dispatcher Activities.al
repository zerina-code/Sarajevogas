pageextension 50139 "Service Dispatcher Activities" extends "Service Dispatcher Activities"
{
    layout
    {
        // Add changes to page layout here
        modify("My User Tasks") { Visible = false; }

        modify("Open Service Quotes") { Visible = CZKORRN; }
        modify("Open Service Contract Quotes") { Visible = CZKORRN; }
        modify("Service Contracts") { Visible = CZKORRN; }



        addafter("Service Quotes")
        {
            cuegroup("Invoices")
            {
                Caption = 'Invoices';
                Visible = CZKORRN;

                field("Service Invoice Header"; "Service Invoice Header")
                {
                    DrillDownPageId = "Posted Service Invoices";
                }
            }
        }

        addbefore("Service Orders")
        {
            cuegroup("Requests")
            {
                Caption = 'CZK Customer Requests';

                field(BrojInf; BrojInf)
                {
                    ApplicationArea = Service;
                    Caption = 'Service Orders - Information Issuing Request';
                    Visible = CZKORRN;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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

                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojInf := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojInf := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojInf := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }

                field(BrojInf_2; BrojInf_2)
                {
                    ApplicationArea = Service;
                    Caption = 'Service Orders - Proccesing Information Issuing Request';
                    Visible = not CZKORRN;

                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information on Connection");
                        if (DepartmentCode <> '') and (CZKORRN = false) then begin



                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojInf_2 := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information on Connection");
                        if (DepartmentCode <> '') and (CZKORRN = false) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojInf_2 := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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


                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information on Connection");
                        if (DepartmentCode <> '') and (CZKORRN = false) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojInf_2 := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                field(BrojE; BrojE)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Project overview Request';
                    //    DrillDownPageID = "Requests";
                    Visible = CZKORRN;
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project overview Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojE := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project overview Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojE := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project overview Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojE := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }

                //eneg

                field(BrojE_2; BrojE_2)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Processing Project overview Request';
                    Visible = not CZKORRN;
                    //    DrillDownPageID = "Requests";
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project and Energy Accordance");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojE_2 := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project and Energy Accordance");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojE_2 := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();

                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Project and Energy Accordance");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojE_2 := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }

                //lokacija


                field(BrojLoc; BrojLoc)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Location';
                    Visible = not CZKORRN;
                    //    DrillDownPageID = "Requests";
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojLoc := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojLoc := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();

                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojLoc := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }


                field(BrojTrasa; BrojTrasa)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Route';
                    Visible = not CZKORRN;
                    //    DrillDownPageID = "Requests";
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojTrasa := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojTrasa := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();

                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Information");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojTrasa := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }


                field(BrojGEO; BrojGEO)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - GEO';
                    Visible = not CZKORRN;
                    //    DrillDownPageID = "Requests";
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := true;
                        UseriD_REc.Modify();
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1|%2', sh."Request Type"::"General Geo. Work Order", sh."Request Type"::"General Geo. Work Order Office");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojGEO := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := true;
                        UseriD_REc.Modify();
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1|%2', sh."Request Type"::"General Geo. Work Order", sh."Request Type"::"General Geo. Work Order Office");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojGEO := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := true;
                        UseriD_REc.Modify();
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
                        sh.Reset();

                        sh.SetFilter("Request Type", '%1|%2', sh."Request Type"::"General Geo. Work Order", sh."Request Type"::"General Geo. Work Order Office");
                        if (DepartmentCode <> '') and (CZKORRN = true) then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojGEO := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                //Medin zahtjevi


                field(BrojRN; BrojRN)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - General';
                    Visible = not CZKORRN;
                    //    DrillDownPageID = "Requests";
                    //  ;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin

                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := false;
                        UseriD_REc.Modify();
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");

                        if CZKORRN = false then begin


                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojRN := sh.Count;


                        end;
                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := false;
                        UseriD_REc.Modify();
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");


                        if CZKORRN = false then begin
                            if Manag = true then
                                sh.SetFilter("Responsible Department", DepartmentCode)
                            else
                                sh.SetFilter("Employee Responsible", '%1', Emp_2);
                            BrojRN := sh.Count;
                        end;



                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
                        UseriD_REc.GEO := false;
                        UseriD_REc.Modify();
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
                        sh.Reset();

                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");



                        if Manag = true then
                            sh.SetFilter("Responsible Department", DepartmentCode)
                        else
                            sh.SetFilter("Employee Responsible", '%1', Emp_2);
                        BrojRN := sh.Count;



                        dl.SetTableView(sh);
                        dl.Run();
                    end;


                }

                //sada bi ja ovdje dodala dio za kontrolu podataka - 


                //

                //kraj lokaciju

                //kraj
                field(BrojZ; BrojZ)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Work Execution Request';
                    Visible = CZKORRN;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojZ := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojZ := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojZ := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }

                field(BrojUGI; BrojUGI)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - UGI Overview and First Release';
                    Visible = CZKORRN;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        sh.SetFilter("First view date", '<>%1', 0D);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojUGI := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        sh.SetFilter("First view date", '<>%1', 0D);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojUGI := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Work Execution Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            sh.SetFilter("First view date", '<>%1', 0D);
                            BrojUGI := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                field(BrojL; BrojL)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Location Accordance Issuing Request';
                    Visible = CZKORRN;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojL := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojL := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Location Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojL := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                field("Service Orders - RAIR"; "Service Orders - RAIR")
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Route Accordance Issuing Reques';
                    Visible = CZKORRN;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojTr := sh.Count;

                        end;

                    end;
                    //  DrillDownPageID = "Requests";
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojTr := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Route Accordance Issuing Request");
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojTr := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }
                field("Service Orders - SPAIR"; "Service Orders - SPAIR")
                {
                    ApplicationArea = Service;
                    DrillDownPageID = "Requests";
                    Visible = false;


                }



            }


            cuegroup(ControlRN)
            {
                Caption = 'Control RN';
                field(ControlGeneral; ControlGeneral)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Control General';
                    Visible = ControlVisible;
                    trigger OnAssistEdit()
                    var
                        sh: Record "Service Header";
                    begin

                        sh.Reset();

                        /*  sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                          sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                          sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                          sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                          sh."Request Type"::"Route Accordance Issuing Information",
                          sh."Request Type"::"Spatial plan Accordance Issuing Information",
                          sh."Request Type"::"Spatial plan Accordance Issuing Information",
                          sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        sh.SetFilter("Control Done", '%1', false);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
                        ControlGeneral := sh.Count;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        sh: Record "Service Header";
                    begin

                        sh.Reset();

                        /*    sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                            sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                            sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                            sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                            sh."Request Type"::"Route Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
                        sh.SetFilter("Control Done", '%1', false);
                        ControlGeneral := sh.Count;

                    end;

                    trigger OnDrillDown()
                    var
                        sh: Record "Service Header";
                        DL: Page Requests;
                    begin

                        sh.Reset();

                        /*    sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                            sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                            sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                            sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                            sh."Request Type"::"Route Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
                        sh.SetFilter("Control Done", '%1', false);
                        ControlGeneral := sh.Count;
                        dl.SetTableView(SH);
                        dl.Run();

                    end;
                }

            }
            //verifikacija

            cuegroup(VerifRN)
            {
                Caption = 'Verif RN';
                field(VerifGeneral; VerifGeneral)
                {
                    ApplicationArea = Service;
                    Caption = ' Service Orders - Verif General';
                    Visible = VerifVisible;
                    trigger OnAssistEdit()
                    var
                        sh: Record "Service Header";
                    begin

                        sh.Reset();

                        /*    sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                            sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                            sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                            sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                            sh."Request Type"::"Route Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Prepare Responsible", UseriD_REc."Employee No. for Wage");
                        sh.SetFilter("Verif Done", '%1', false);
                        VerifGeneral := sh.Count;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        sh: Record "Service Header";
                    begin

                        sh.Reset();

                        /*    sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                            sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                            sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                            sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                            sh."Request Type"::"Route Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"Spatial plan Accordance Issuing Information",
                            sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Prepare Responsible", UseriD_REc."Employee No. for Wage");
                        sh.SetFilter("Verif Done", '%1', false);
                        VerifGeneral := sh.Count;

                    end;

                    trigger OnDrillDown()
                    var
                        sh: Record "Service Header";
                        DL: Page Requests;
                    begin

                        sh.Reset();

                        /*   sh.SetFilter("Request Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10|%11', sh."Request Type"::"General Work Order",
                           sh."Request Type"::"General Geo. Work Order Office", sh."Request Type"::"General Geo. Work Order",
                           sh."Request Type"::"Information on Connection", sh."Request Type"::"Location Accordance Issuing Information",
                           sh."Request Type"::Others, sh."Request Type"::"Project and Energy Accordance",
                           sh."Request Type"::"Route Accordance Issuing Information",
                           sh."Request Type"::"Spatial plan Accordance Issuing Information",
                           sh."Request Type"::"Spatial plan Accordance Issuing Information",
                           sh."Request Type"::"UGI Overview and First Release");*/
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        sh.SetFilter("Responsible Department", DepartmentCode);
                        UseriD_REc.Get(UseriD);
                        sh.SetFilter("Employee Prepare Responsible", UseriD_REc."Employee No. for Wage");
                        sh.SetFilter("Verif Done", '%1', false);
                        VerifGeneral := sh.Count;
                        dl.SetTableView(SH);
                        dl.Run();

                    end;
                }

            }

            //end


            cuegroup(Others)
            {
                Caption = 'Others';
                field("Service Orders - Today2"; "Service Orders - Today")
                {
                    caption = 'Service Orders - Today';
                    DrillDownPageId = Requests;
                    Visible = not CZKORRN;
                }
            }

        }



        //Visible=CZKORRN;



        modify("Service Orders") { Visible = false; }
        addafter("Service Orders")
        {
            cuegroup("Other Service Invoice")
            {
                Caption = 'Other Service Invoice';
                Visible = CZKORRN;

                field(BrojOther; BrojOther)
                {
                    ApplicationArea = all;
                    Caption = 'BrojOther';
                    DrillDownPageID = "Requests";
                    Visible = CZKORRN;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        DL: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojOther := sh.Count;

                        end;


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        dl: Page Requests;
                    begin
                        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
                        Manag := false;

                        UseriD_REc.Get(UseriD);
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
                        sh.Reset();
                        sh.SetFilter("Request Type", '%1', 0);
                        if (DepartmentCode <> '') and (CZKUser = true) then begin


                            sh.SetFilter("Request Department", DepartmentCode);
                            BrojOther := sh.Count;

                        end;

                        dl.SetTableView(SH);
                        dl.Run();

                    end;

                }



            }

            /*    cuegroup("Request by Status")
                {
                    Caption = 'Request by Status';
                    field("Service Orders - Processing"; "Service Orders - Processing")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }
                    field("Service Orders - Forwarding"; "Service Orders - Forwarding")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }
                    field("Service Orders - Received"; "Service Orders - Received")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }
                    field("Service Orders - Delivered"; "Service Orders - Delivered")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }
                    field("Service Orders - Cancelled"; "Service Orders - Cancelled")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }
                    field("Service Orders - Expiring"; "Service Orders - Expiring")
                    {
                        DrillDownPageId = Requests;
                        LookupPageId = Requests;
                    }

                }*/
            cuegroup(Reminders)
            {
                Caption = 'Potencijalna utuženja';
                field("New Reminders"; "New Reminders")
                {
                    DrillDownPageId = "Reminder List";
                    Visible = CZKORRN;
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetRange("Document Date", Today - 10, Today);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
            }
        }
    }
    actions
    {
        addafter("Edit Dispatch Board")
        {
            action("AgingReport")
            {
                ApplicationArea = All;
                Caption = '30-60-90';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = CZKORRN;

                trigger OnAction()
                begin
                    agingReport.Run();
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
        SH: Record "Service Header";
        USPersonalization: Record "User Personalization";
        USetup: Record "User Setup";
        Sh2: Record "Service Header";
        Profile: Record "All Profile";

    begin
        SetRange("Date Filter - Request", WorkDate, CALCDATE('<+2D>', WorkDate));

        USetup.reset;
        USetup.SetFilter("User ID", '%1', UserId);
        if USetup.findfirst then begin
            if USetup."Visible Request" = true then begin
                CZKPurchaseAgent := true;
            end
            else begin
                CZKPurchaseAgent := FalsE;

            end;
        end;

        USPersonalization.Reset();
        USPersonalization.SetFilter("User ID", '%1', UserId);
        if USPersonalization.FindFirst() then begin
            Profile.Reset();
            Profile.SetFilter("Profile ID", '%1', USPersonalization."Profile ID");
            if Profile.FindFirst() then begin
                if Profile.Caption = 'CZK' then
                    CZKORRN := true
                else
                    CZKORRN := false;
            end;
        end;


        SetRange("Date Filter 2", CALCDATE('<-10D>', WorkDate), WorkDate);
        SetFilter("Date Filter First View", '<>%1', 0D);
        // if CZKUser then

        //"CZK Org" := DepartmentCode;
        //Modify();
        // if CZKUser <> false then
        //   SetFilter("CZK Org", DepartmentCode)

        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        Manag := false;

        UseriD_REc.Get(UseriD);
        if UseriD_REc."Control R" then
            ControlVisible := true
        else
            ControlVisible := false;
        if UseriD_REc."Verif R" = true
        then
            VerifVisible := true
        else
            VerifVisible := falsE;
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
        sh.Reset();
        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information Issuing Request");
        if (DepartmentCode <> '') and (CZKUser = true) then begin


            sh.SetFilter("Request Department", DepartmentCode);
            BrojInf := sh.Count;

        end;

        if CZKORRN = false then begin


            Sh2.Reset();
            //  sh2.SetFilter("Responsible Department", DepartmentCode);

            if Manag = true then
                sh2.SetFilter("Responsible Department", DepartmentCode)
            else
                sh2.SetFilter("Employee Responsible", '%1', Emp_2);

            //  BrojInf := sh.Count;

        end;

        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        Manag := false;

        UseriD_REc.Get(UseriD);
        UseriD_REc.GEO := false;
        UseriD_REc.Modify();
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
        sh.Reset();
        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");


        if (CZKORRN = false) then begin
            if Manag = true then
                sh.SetFilter("Responsible Department", DepartmentCode)
            else
                sh.SetFilter("Employee Responsible", '%1', Emp_2);
            BrojRN := sh.Count;
        end;


        sh.Reset();

        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        sh.SetFilter("Responsible Department", DepartmentCode);
        UseriD_REc.Get(UseriD);
        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
        ControlGeneral := sh.Count;



    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        USPersonalization: Record "User Personalization";
        sh: Record "Service Header";
        Sh2: Record "Service Header";
        Profile: Record "All Profile";
        USetup: Record "User Setup";
    begin


        USetup.reset;
        USetup.SetFilter("User ID", '%1', UserId);
        if USetup.findfirst then begin
            if USetup."Visible Request" = true then begin
                CZKPurchaseAgent := true;
            end
            else begin
                CZKPurchaseAgent := FalsE;

            end;
        end;

        USPersonalization.Reset();
        USPersonalization.SetFilter("User ID", '%1', UserId);
        if USPersonalization.FindFirst() then begin
            Profile.Reset();
            Profile.SetFilter("Profile ID", '%1', USPersonalization."Profile ID");
            if Profile.FindFirst() then begin
                if Profile.Caption = 'CZK' then
                    CZKORRN := true
                else
                    CZKORRN := false;
            end;
        end;


        sh.Reset();
        sh.SetFilter("Request Type", '%1', sh."Request Type"::"Information Issuing Request");
        if (DepartmentCode <> '') and (CZKUser = true) then begin


            sh.SetFilter("Request Department", DepartmentCode);
            BrojInf := sh.Count;

        end;

        if CZKORRN = false then begin


            Sh2.Reset();
            //sh2.SetFilter("Responsible Department", DepartmentCode);

            if Manag = true then
                sh2.SetFilter("Responsible Department", DepartmentCode)
            else
                sh2.SetFilter("Employee Responsible", '%1', Emp_2);


            //  BrojInf := sh.Count;

        end;
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        Manag := false;

        UseriD_REc.Get(UseriD);
        if UseriD_REc."Control R" = true then
            ControlVisible := true
        else
            ControlVisible := false;

        UseriD_REc.Get(UseriD);
        if UseriD_REc."Verif R" = true then
            VerifVisible := true


        else
            VerifVisible := false;
        UseriD_REc.GEO := false;
        UseriD_REc.Modify();
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
        sh.Reset();
        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");



        if Manag = true then
            sh.SetFilter("Responsible Department", DepartmentCode)
        else
            sh.SetFilter("Employee Responsible", '%1', Emp_2);
        BrojRN := sh.Count;


        sh.Reset();

        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        sh.SetFilter("Responsible Department", DepartmentCode);
        UseriD_REc.Get(UseriD);
        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
        ControlGeneral := sh.Count;


    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        sh: Record "Service Header";
        USetup: Record "User Setup";
    begin

        USetup.reset;
        USetup.SetFilter("User ID", '%1', UserId);
        if USetup.findfirst then begin
            if USetup."Visible Request" = true then begin
                CZKPurchaseAgent := true;
            end
            else begin
                CZKPurchaseAgent := FalsE;

            end;
        end;

        sh.Reset();

        sh.SetFilter("Request Type", '%1', sh."Request Type"::"General Work Order");
        GetDefaultResponsibleDepartment(DepartmentCode, CZKUser, Manag, Emp_2);
        sh.SetFilter("Responsible Department", DepartmentCode);
        UseriD_REc.Get(UseriD);
        sh.SetFilter("Employee Control Responsible", UseriD_REc."Employee No. for Wage");
        ControlGeneral := sh.Count;

    end;

    procedure GetDefaultResponsibleDepartment(var DeparmentCode: Code[20]; var CZKUser: Boolean; Manag: Boolean; Emp: code[20])
    var
        UserSetup: Record "User Setup";
        Employee: Record Employee;
        EmployeeContractLedger: Record "Employee Contract Ledger";
    begin
        Employee.SetAutoCalcFields("Department Code");
        Employee.SetLoadFields("Department Code");

        if not UserSetup.Get(UserId) then
            exit;
        if not Employee.Get(UserSetup."Employee No. for Wage") then
            exit;
        Manag := false;
        EmployeeContractLedger.Reset();
        EmployeeContractLedger.SetFilter("Employee No.", '%1', Employee."No.");
        EmployeeContractLedger.SetFilter(Active, '%1', true);
        if EmployeeContractLedger.FindFirst() then begin
            if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                Manag := true
            else
                Manag := false;
        end;
        Emp := Employee."No.";
        DeparmentCode := Employee."Department Code";
        CZKUser := UserSetup."CZK User";
    end;



    var
        myInt: Integer;
        agingReport: Report CustomerSummaryAging;
        BrojE_2: Integer;
        BrojGEO: Integer;
        BrojLoc: Integer;
        BrojTrasa: Integer;
        CZKUser: Boolean;
        Manag: Boolean;
        DepartmentCode: code[20];
        UseriD_REc: Record "User Setup";
        BrojRN: Integer;
        BrojInf: Integer;
        BrojInf_2: Integer;

        CZKORRN: Boolean;
        CZKPurchaseAgent: Boolean;
        BrojE: Integer;
        BrojZ: Integer;
        BrojUGI: Integer;
        ControlGeneral: Integer;
        VerifGeneral: Integer;
        VerifVisible: Boolean;
        ControlVisible: Boolean;
        BrojL: Integer;
        BrojTr: Integer;
        BrojOther: Integer;
        EmployeeContractLedger: Record "Employee Contract Ledger";

        Emp_2: code[20];
}