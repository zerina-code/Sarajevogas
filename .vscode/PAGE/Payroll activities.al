page 50092 "Payroll Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Payroll Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }
            cuegroup(Information)
            {
                Caption = 'Information';
                field("For Calculation"; "For Calculation")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("For Calculation", '%1', true);
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;



                }
                field(Calculated; Calculated)
                {

                    ApplicationArea = all;
                }
                field("New Employees FC"; "New Employees FC")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;

                }
                field("Terminated Employees"; "Terminated Employees")
                {
                    Image = Checklist;
                    Importance = Additional;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    ApplicationArea = all;
                }
                field("For Calculation Witout Meal"; "For Calculation Witout Meal")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("For Calculation", '%1', true);
                        Employee.SetFilter(Meal, '%1', false);
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
                field("Negative Payment"; "Negative Payment")
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = TRUE;

                    trigger OnDrillDown()
                    begin
                        WageCalc.SETFILTER(Payment, '<%1', 0);
                        PAGE.RUNMODAL(50218, WageCalc);
                    end;
                }
                field(Additions; Additions)
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("For Calculation", '%1', true);
                        Employee.SetFilter(StatusExt, '%1', Employee.StatusExt::Active);
                        Employee.SetFilter("Calculate Wage Addition", '%1', false);
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;

                }
                field(Transfers; Transfers)
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
            }
            cuegroup("Changes")
            {
                Caption = 'Changes';
                field("Surname Change"; "Surname Change")
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Adress Change"; "Adress Change")
                {
                    ApplicationArea = all;
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Internal Fund"; "Internal Fund")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("Internal Solidarity Fund", '%1', true);
                        Employee.SetFilter("Int. Solidarity Fund Date From", '%1', DateFilter6);
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
                field("External Fund"; "External Fund")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("External Solidarity Fund", '%1', true);
                        Employee.SetFilter("Ext. Solidarity Fund Date From", '%1', DateFilter6);
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
                field("Union Employees"; "Union Employees")
                {
                    ApplicationArea = all;
                }
                field("Education Level Change"; "Education Level Change")
                {
                    ApplicationArea = all;
                    Image = Library;
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                }
                field("Employee Disability"; "Employee Disability")
                {

                    ApplicationArea = all;
                    Image = Library;
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("Disabled Person", '%1', true);
                        Employee.SetFilter("StatusExt", '%1', Employee.StatusExt::Active);

                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }

            }
            cuegroup(Contracts)
            {
                Caption = 'Contracts';
                field("Regular Contracts"; "Regular Contracts")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := true;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("For Calculation", '%1', true);
                        Employee.SetFilter(StatusExt, '%1', Employee.StatusExt::Active);
                        Employee.SetFilter("Contribution Category Code", '%1', 'FBIH');
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
                field("Temporary Service Contracts"; "Temporary Service Contracts")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := false;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("Temporary Contract Type", '%1|%2', Employee."Temporary Contract Type"::"Temporary Contract", Employee."Temporary Contract Type"::"Temporary Contract 0");
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
                field("Author Contracts"; "Author Contracts")
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserS: Record "User Setup";
                        Employee: Record Employee;
                        EmList: Page "Employee List";
                    begin
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Employee Status" := false;
                            users.modify;


                        end;
                        Employee.Reset();
                        Employee.SetFilter("Temporary Contract Type", '%1', Employee."Temporary Contract Type"::"Temporary Contract Non-Residents");
                        EmList.SetTableView(Employee);
                        EmList.Run();



                    end;
                }
            }
            cuegroup("Wage history")
            {
                Caption = 'Wage history';
                field("Opened calculations"; "Opened calculations")
                {

                    ApplicationArea = all;
                    Image = Cash;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Closed calculations"; "Closed calculations")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;

        // SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        //SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        // SETFILTER("User ID Filter",USERID);
        // SETRANGE(DateFilter5,CALCDATE('-'+ FORMAT(HRSetup."New employee period"),TODAY),TODAY);
        ThisMonthFirst := CALCDATE('-SM;', WORKDATE);
        ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
        NextMonthFirst := CALCDATE('+1D', ThisMonthLast);
        NextMonthLast := CALCDATE('SM', NextMonthFirst);
        DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);
        DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
        //SETRANGE(DateFilter6,ThisMonthFirst,ThisMonthLast);
        SETRANGE(DateFilter7, ThisMonthFirst, DBThisMonthLast);
        //SETRANGE(DateFilter8,01011980D,DBThisMonthFirst);
        SETRANGE(DateFilter9, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);
        SETRANGE(DateFilterChange, ThisMonthFirst, ThisMonthLast);
    end;

    var

        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        DBThisMonthLast: Date;
        DBThisMonthFirst: Date;
        WageCalc: Record "Wage Calculation";
        WageCalcPage: Page "Wage Calculation Subform";
}

