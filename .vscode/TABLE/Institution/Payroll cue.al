table 50120 "Payroll Cue"
{
    Caption = 'Finance Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }


        field(11; "Customers - Blocked"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE(Blocked = FILTER(<> ' ')));
            Caption = 'Customers - Blocked';

        }
        field(20; "Due Date Filter"; Date)
        {
            Caption = 'Due Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50221; "Overdue Date Filter"; Date)
        {
            Caption = 'Overdue Date Filter';
            FieldClass = FlowFilter;
        }
        field(22; "New Incoming Documents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE(Status = CONST(New)));
            Caption = 'New Incoming Documents';

        }
        field(23; "Approved Incoming Documents"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE(Status = CONST(Released)));
            Caption = 'Approved Incoming Documents';

        }
        field(24; "OCR Pending"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Incoming Document" WHERE("OCR Status" = FILTER('Ready|Sent|Awaiting Verification')));
            Caption = 'OCR Pending';

        }


        field(27; "Requests Sent for Approval"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count("Approval Entry" WHERE("Sender ID" = FIELD("User ID Filter"),
                                                        Status = FILTER('Open')));
            Caption = 'Requests Sent for Approval';

        }
        field(28; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(50000; "Active Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER('Active|Inactive|On boarding'),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false)));
            Caption = 'Active Employees';

        }
        field(50222; "Inactive Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER(<> Active)));
            Caption = 'Inactive Employees';

        }
        field(50223; "Closed calculations"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Header" WHERE(Status = CONST(Closed)));
            Caption = 'Closed calculations';

        }
        field(50224; "Regular Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Contribution Category Code" = FILTER('FBIH'),
                                                Status = FILTER(Active),
                                                "For Calculation" = FILTER(true)));
            Caption = 'Regular Contracts';

        }
        field(50225; "Temporary Service Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Temporary Contract Type" = FILTER('Temporary Contract|Temporary Contract 0')));
            Caption = 'Temporary Service Contracts';

        }
        field(50226; "Temporary Service Contracts NR"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Contribution Category Code" = FILTER('UODNR')));
            Caption = 'Temporary Service Contracts-Non Residents';

        }
        field(50006; "Author Contracts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Temporary Contract Type" = FILTER('Temporary Contract Non-Residents')));
            Caption = 'Author Contracts';

        }
        field(50227; "Opened calculations"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Header" WHERE(Status = CONST(Open)));
            Caption = 'Opened calculations';

        }
        field(50228; Active; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER('Active|Inactive|On boarding'),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false)));
            Caption = 'Active Employees';

        }
        field(50009; "For Calculation"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(true)));
            Caption = 'For Calculation';

        }
        field(50229; "For Calculation Witout Meal"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(true),
                                                Meal = FILTER(false)));
            Caption = 'For Calculation';

        }
        field(50230; DateFilter5; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50231; "New Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(Status = FILTER(Active),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false),
                                                "Employment Date" = FIELD(DateFilter5)));
            Caption = 'New Employees';

        }
        field(50232; DateFilter6; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50233; "New Employees FC"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter6),
                                                                  "Reason for Change" = FILTER('New Contract')));
            Caption = 'New Employees';

        }
        field(50234; "Terminated Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter7),
                                                                  "Grounds for Term. Code" = FILTER(<> '')));
            Caption = 'Terminated Employees';

        }
        field(50235; Transfers; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Reason for Change" = FILTER('Relocation'),
                                                                  Active = FILTER(true),
                                                                  "Starting Date" = FIELD(DateFilter6)));
            Caption = 'Transfers';

        }
        field(50236; "Surname Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Surname" WHERE("Last Date Modified" = FIELD(DateFilter6),
                                                          "Number Of Surnames" = FILTER(> 1),
                                                          "No." = FILTER('<> 9*')));
            Caption = 'Surname Change';

        }
        field(50237; "Adress Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Alternative Address" WHERE("Date From (CIPS)" = FIELD(DateFilter6),
                                                             Active = FILTER(true),
                                                             "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Adress Change';

        }
        field(50238; "Internal Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Internal Solidarity Fund" = FILTER(true),
                                                "Int. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'Internal Fund';

        }
        field(50239; "External Fund"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("External Solidarity Fund" = FILTER(true),
                                                "Ext. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'External Fund';

        }
        field(50240; "Education Level Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Additional Education" WHERE(Active = FILTER(true),
                                                              "From Date" = FIELD(DateFilter6),
                                                              "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Education Level Change';

        }
        field(50241; Calculated; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Calculation Type" = FILTER(Regular),
                                                          "Date Of Calculation" = FIELD(DateFilter6)));
            Caption = 'Calculated';

        }

        field(50242; DateFilter7; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50243; DateFilter8; Date)
        {
            FieldClass = FlowFilter;
        }

        /*    field(50039; "Travel Orders"; Integer)
            {
                FieldClass = FlowField;
                CalcFormula = Count("Travel Header");
                Caption = 'Travel Orders';

            }*/
        field(50244; "Wage Change"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilterChange),
                                                                  "Wage Change" = FILTER('Change Position Coefficient')));
            Caption = 'Wage Change';

        }
        field(50245; DateFilter9; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50246; "Union Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Diseases" WHERE("Date From" = FIELD(DateFilter6), Types = filter("Union Employees")));
            Caption = 'Union Employees';

        }
        field(50054; DateFilterChange; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50055; "Negative Payment"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE(Payment = FILTER(< 0)));
            Caption = 'Negative Payment';

        }
        field(50056; Additions; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Calculate Wage Addition" = FILTER(false),
                                                Status = FILTER(Active)));
            Caption = 'Active employees without wage additions';

        }
        field(50247; "Employee Disability"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Disabled Person" = FILTER(true),
                                                Status = FILTER(Active)));
            Caption = 'Employee Disability';

        }
        field(2; Employees_HRCUE; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active | Inactive | Unpaid | Terminated | "On boarding")));
            Caption = 'Employees';
            Editable = false;
            FieldClass = FlowField;
        }

        field(4; "Active Employees _HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER('Active')


                                               ));
            Caption = 'Active Employees';

        }
        field(3; FromDate_HRCUE; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'From Date';
        }


        field(21; "Responsibility CF HRCUE"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(50001; "Inactive Employees_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Inactive),
                                                "Potential Employee" = CONST(false)));
            Caption = 'Inactive Employees';

        }
        field(50002; "Potential Employees_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true)));
            Caption = 'Potential Employees';

        }
        field(50003; "Invited to Interview_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Invited to interview" = CONST(true)));
            Caption = 'Invited to Interview';

        }
        field(50004; "Appropriate Candidates_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Appropriate candidate" = CONST(true)));
            Caption = 'Appropriate Candidates';

        }
        field(50005; "Inappropriate Candidates_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Potential Employee" = CONST(true),
                                                "Inappropriate candidate" = CONST(true)));
            Caption = 'Inappropriate Candidates';

        }

        field(50007; "Employees on Probation_HRCUE"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Testing Period" = FILTER(TRUE),
                                                                  Active = FILTER(TRUE)));
            Caption = 'Employees on Probation';
            FieldClass = FlowField;

            trigger OnValidate()
            begin
                //t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",TODAY,010101D);
            end;
        }
        field(50008; "Probation expired_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Is not extended expired P" = FILTER(TRUE),
                                                                 "Testing Period Ending Date" = FIELD(DateFilter2),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Probation expired';


            trigger OnLookup()
            begin


                //datum:=CALCDATE('<',TODAY);
                //t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",TODAY,311299D);
            end;
        }
        field(50094; DateTraining_HRCUE; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Training expiring';
        }


        field(50097; DateTraining2_HRCUE; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Training expired';

        }


        field(50010; "Inactive - Terminated_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Terminated),
                                                "Potential Employee" = CONST(false)));
            Caption = 'Inactive - Terminated';

        }
        field(50011; DateFIlter_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50012; DateFilter2; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50013; "Probation Expires NP_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Testing Period Ending Date" = FIELD(DateFIlter_HRCUE),
                                                                  Active = FILTER(TRUE),
                                                                  "Is not extended P" = FILTER(TRUE)));
            Caption = 'Probation expired';


            trigger OnLookup()
            var
                HRsetup: Record "Human Resources Setup";
                datum: Date;
                t_Employee: Record Employee;
            begin

                HRsetup.GET;
                datum := CALCDATE(HRsetup."Probation Expire Days", TODAY);
                t_Employee.FINDFIRST;
                //t_Employee.SETRANGE("Probation Period End",datum,TODAY);
            end;
        }
        field(50014; DateFilter3_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }


        field(50018; "Three Years In Company_HRCUE"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Three Years in company" = FILTER(TRUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                /*HRsetup.GET;
                finalDate:= CALCDATE('-3Y',CALCDATE(HRsetup.WarningPeriod,TODAY));
                
                ECL.FINDFIRST;
                ECL.SETRANGE(Status,0);
                
                ECL.SETRANGE("Starting Date",CALCDATE('-3Y',TODAY),CALCDATE('-3Y',finalDate));*/

            end;
        }
        field(50019; DateFilter4_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50020; DateFilter5_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50021; "New Employees_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Active),
                                                "Potential Employee" = CONST(false),
                                                Associates = CONST(false),
                                                "Employment Date" = FIELD(DateFilter5)));
            Caption = 'New Employees';

        }
        field(50022; DateFilterTraining_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50023; Practicians_HRCUE; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Practicians)));
            Caption = 'Practicians';
            FieldClass = FlowField;
        }
        field(50024; "For Calculation_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("For Calculation" = FILTER(TRUE)));
            Caption = 'For Calculation';

        }
        field(50025; DateFilter6_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50026; "New Employees FC_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter6),
                                                                  "Reason for Change" = FILTER("New Contract"),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'New Employees';

        }
        field(50027; "Terminated Employees_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter7),
                                                                  "Grounds for Term. Code" = FILTER(<> ''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Terminated Employees';

        }
        field(50028; Transfers_HRCUE; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Reason for Change" = FILTER(Relocation),
                                                                  Active = FILTER(TRUE),
                                                                  "Starting Date" = FIELD(DateFilter6)));
            Caption = 'Transfers';

        }
        field(50029; "Surname Change_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Surname" WHERE("Last Date Modified" = FIELD(DateFilter6),
                                                          "Number Of Surnames" = FILTER(> 1)
                                                          ));
            Caption = 'Surname Change';

        }
        field(50030; "Adress Change_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Alternative Address" WHERE("Date From (CIPS)" = FIELD(DateFilter6),
                                                             Active = FILTER(TRUE),
                                                             "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Adress Change';

        }
        field(50031; "Internal Fund_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("Internal Solidarity Fund" = FILTER(TRUE),
                                                "Int. Solidarity Fund Date From" = FIELD(DateFilter6)));


        }
        field(50032; "External Fund_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE("External Solidarity Fund" = FILTER(TRUE),
                                               "Ext. Solidarity Fund Date From" = FIELD(DateFilter6)));
            Caption = 'External Fund';

        }
        field(50033; "Education Level Change_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Additional Education" WHERE(Active = FILTER(TRUE),
                                                              "From Date" = FIELD(DateFilter6),
                                                              "Employment Date" = FIELD(DateFilter8)));
            Caption = 'Education Level Change';

        }
        field(50034; Calculated_HRCUE; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Calculation Type" = FILTER(Regular),
                                                          "Date Of Calculation" = FIELD(DateFilter6)));
            Caption = 'Calculated';

        }
        field(50035; "Terminated  Unpaid E_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Unpaid)));
            Caption = 'Terminated Employees';

        }
        field(50036; DateFilter7_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50037; DateFilter8_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50039; "Unsegmented Positions_HRCUE"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE("Contract Type" = FILTER(<> 7),
                                                                  "Starting Date" = FILTER('')));
            Caption = 'Unsegmented Positions';
            FieldClass = FlowField;

            trigger OnLookup()
            begin
                OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Blocked);
                IF OrgShema.FINDLAST THEN BEGIN
                    OrgShema.GET;
                    "Active Sistematizaction_HRCUE" := OrgShema.Code;
                END;
            end;
        }
        field(50040; "Education And Dev HRCUE"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Education Plan" = FILTER("In Progress" | Completed)));
            Caption = 'Education And Development';
            FieldClass = FlowField;
        }


        field(50041; "Wage Change_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Starting Date" = FIELD(DateFilter9),
                                                                  "Wage Change" = FILTER("Change Position Coefficient"),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Wage Change';

        }
        field(50042; DateFilter9_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50043; "Expiring Contracts_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter10_HRCUE),
                                                                  Active = FILTER(TRUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Is not extended" = FILTER(TRUE),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Expiring Contracts';

        }
        field(50044; DateFilter10_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50045; "Expired Contracts_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Ending Date" = FIELD(DateFilter11_HRCUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Is not extended expired" = FILTER(TRUE),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Expiring Contracts';

        }
        field(50046; DateFilter11_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50048; "On Boarding_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER("On boarding")));
            Caption = 'On Boarding';

        }
        field(50049; "Temporary Disposition_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Temporary disposition" = FILTER(TRUE),
                                                                  Status = FILTER(Active),
                                                                  "Show Record" = FILTER(TRUE),
                                                                  Active = FILTER(TRUE)));
            Caption = 'Temporary Disposition';

        }
        field(50050; "Sent Notification_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Notification send" = FILTER(TRUE),
                                                                  Status = FILTER(Active),
                                                                  "Ending Date" = FIELD(DateFilter10_HRCUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Sent Notification';

        }
        field(50051; "Not Sent Notification_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Contract Ledger" WHERE("Notification send" = FILTER(FALSE),
                                                                  Status = FILTER(Active),
                                                                  "Ending Date" = FIELD(DateFilter10_HRCUE),
                                                                  "Grounds for Term. Code" = FILTER(''),
                                                                  "Show Record" = FILTER(TRUE)));
            Caption = 'Not Sent Notification';

        }
        field(50052; "Active Sistematizaction_HRCUE"; Code[10])
        {
            Caption = 'Active Sistematizaction';
            FieldClass = FlowFilter;
        }
        field(50053; "Union Employees_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Diseases" WHERE("Date From" = FIELD(DateFilter6), Types = filter("Union Employees")));
            Caption = 'Union Employees';

        }



        field(50057; "Temporary Contract_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER("Temporary Contract"),
                                                "External employer Status" = FILTER(Active)));
            Caption = 'Temporary Contract';

        }
        field(50058; Volonteer_HRCUE; Integer)
        {
            CalcFormula = Count(Employee WHERE(StatusExt = FILTER(Volonteer),
                                                "External employer Status" = FILTER(Active)));
            Caption = 'Volonteer';
            FieldClass = FlowField;
        }


        field(50061; "Contract in conflict_HRCUE"; Integer)
        {
            CalcFormula = Count("Employee Contract Ledger" WHERE(Conflict = FILTER(TRUE),
                                                                  "The Change is update" = FILTER(FALSE)));
            Caption = 'Contract in conflict';
            FieldClass = FlowField;
        }
        field(50062; DateFilter12_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        /*  field(50063; Candidate_HRCUE; Integer)
          {
              CalcFormula = Count(Candidates);
              Caption = 'Candidates';
              FieldClass = FlowField;
          }*/
        /*       field(50064; "Active Measures_HRCUE"; Integer)
               {
                   FieldClass = FlowField;
                   CalcFormula = Count("Work Duties Violation" WHERE("Page Type" = FILTER("Disciplinary measures"),
                                                                      "Active Measure" = FILTER(TRUE)));
                   Caption = 'Active Measures';

               }
               field(50065; "Expirings Measures_HRCUE"; Integer)
               {
                   FieldClass = FlowField;
                   CalcFormula = Count("Work Duties Violation" WHERE("Page Type" = FILTER("Disciplinary measures"),
                                                                      "Measure To" = FIELD("Expirings Measures Filter")));
                   Caption = 'Expirings Measures';

               }
               */
        field(50066; "Expirings Measures F_HRCUE"; Date)
        {
            FieldClass = FlowFilter;
        }
        /*  field(50067; OpenPostingAll_HRCUE; Integer)
          {
              CalcFormula = Count(Posting WHERE("Published Date" = FILTER(<> ''),
                                                 "Employment Date" = FILTER(''),
                                                 "Closing Date" = FILTER(<> ''),
                                                 Status = FILTER('Otvoren')));
              Caption = 'OpenPostingAll';
              Editable = false;
              FieldClass = FlowField;
          }*/



        /*    field(50071; ClosedPostingCompleted_HRCUE; Integer)
            {
                FieldClass = FlowField;
                CalcFormula = Count(Posting WHERE(Status = FILTER('Izbor završen')));
                Caption = 'ClosedPostingCompleted';
                Editable = false;

            }
            field(50072; ClosedPostingNoChoice_HRCUE; Integer)
            {
                FieldClass = FlowField;
                CalcFormula = Count(Posting WHERE(Status = FILTER('Bez izbora')));
                Caption = 'ClosedPostingNoChoice';
                Editable = false;

            }
            field(50073; ClosedPosting_HRCUE; Integer)
            {
                FieldClass = FlowField;
                CalcFormula = Count(Posting WHERE(Status = FILTER('Zatvoren')));
                Caption = 'ClosedPosting';
                Editable = false;

            }*/
        /*   field(50074; CandidatesGFSarajevo_HRCUE; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Ilijaš|Sarajevo|Ilidža|Hrasnica|Istočno Novo Sarajevo|Hadžići|Pale|Goražde')));
               Caption = 'Candidates GF Sarajevo';
               Editable = false;

           }
           field(50075; CandidatesGFZenica; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Zenica|Zavidovići|Žepče|Kakanj|Vitez|Kiseljak|Visoko|Tešanj|Maglaj|Jelah|Teslić|Travnk|Bugojno')));
               Caption = 'Candidates GF Zenica';
               Editable = false;

           }
           field(50076; CandidatesGFBanjaLuka; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Banja Luka|Laktaši|Mrkonjić Grad|Kotor Varoš|Prijedor|Kozarska Dubica|Novi Grad|Gradiška|Prnjavor|Doboj|Derventa|Modrića|Brod|Šamac')));
               Caption = 'Candidates GF BanjaLuka';
               Editable = false;

           }
           field(50077; CandidatesGFMostar; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Mostar|Konjic|Čitljuk|Čapljina|Međugorje|Široki Brijeg|Grude|Ljubuški|Posušje|Trebinje|Livno|Tomislagrad')));
               Caption = 'Candidates GF Mostar';
               Editable = false;

           }
           field(50078; CandidatesGFTuzla; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Tuzla|Živinice|Lukavac|Banovići|Gračanica|Gradačac|Srebrenik|Bijeljina|Ugljevik|Brčko|Orašje|Odžak')));
               Caption = 'Candidates GF Tuzla';
               Editable = false;

           }
           field(50079; CandidatesGFBihac; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE(Location = FILTER('Bihać|Cazin|Velika Kladuša|Sanski Most|Ključ|Bosanska Krupa|Bužim')));
               Caption = 'Candidates GF Bihac';

           }
           field(50080; EconomicProfileLastYear; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                     "Name of edu. institution" = FILTER('@*Ekonomski fakultet*')));
               Caption = 'Economic Profile Last Year';
               Editable = false;

           }
           field(50081; EconomicProfileThisYear; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                     "Name of edu. institution" = FILTER('@*Ekonomski fakultet*')));
               Caption = 'Economic Profile This Year';
               Editable = false;

           }
           field(50082; LawFacultyLastYear; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                     "Name of edu. institution" = FILTER('@*Pravni fakultet*')));
               Caption = 'LawFacultyLastYear';

           }
           field(50083; LawFacultyThisYear; Integer)
           {

               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                     "Name of edu. institution" = FILTER('@*Pravni fakultet*')));
               Caption = 'LawFacultyThisYear';

           }
           field(50084; ElectricalLastYear; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(LastYearFilter),
                                                     "Name of edu. institution" = FILTER('@*elektrotehni*')));
               Caption = 'ElectricalLastYear';

           }
           field(50085; ElectricalThisYear; Integer)
           {
               FieldClass = FlowField;
               CalcFormula = Count(Candidates WHERE("Date of aplication" = FIELD(ThisYearFilter),
                                                     "Name of edu. institution" = FILTER('@*elektrotehni*')));
               Caption = 'ElectricalThisYear';

           }*/
        field(50086; LastYearFilter_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50087; ThisYearFilter_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50088; TodayFilter_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50089; "Training_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Training Ledger" WHERE("End date of certificate" = field(DateTraining_HRCUE)));
            Caption = 'Trainings';


        }

        field(50096; "Expired Training_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Training Ledger" WHERE("End date of certificate" = field(DateTraining2_HRCUE)));
            Caption = 'Trainings';


        }

        field(50090; DateCatalogue_HRCUE; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50091; "Training Catalogue_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Training Catalogue");
            Caption = 'Trainings';


        }
        field(50092; "Training Entry_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Training Time Entry");
            Caption = 'Održavanje treninga/edukacija';


        }
        field(50093; "Certification_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Qualification" where("Expiration Date" = field(DateTraining_HRCUE)));
            Caption = 'Certifikati čiji rok ističe za mjesec dana';


        }

        field(50098; "Certification Expired_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Qualification" where("Expiration Date" = field(DateCatalogue_HRCUE)));
            Caption = 'Certifikati čiji rok je istekao u toku mjesec dana';


        }

        field(50095; "Employee Training Ledger_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Training Ledger");
            Caption = 'Employee Training Ledger';


        }
        field(50099; "Employees on call_HRCUE"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Absence Reg" where("Cause of absence on-call" = const(true), "From Date" = field(FromDate_HRCUE)));
            Caption = 'Employees on call';
        }
        field(50261; "Before the end of the court term"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Header" where("Date of Accusation" = field(ExpirationDate_Hearing)));
            Caption = 'Pred istek sudskog roka';
        }
        field(50263; "Reminders for 300D-330D"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Issued Reminder Header" where("Document Date" = field(Reminders_for_300D)));
            Caption = 'Opomene 300-330 dana';
        }
        field(50264; Reminders_for_300D; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50265; "Reminders for over 330D"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Issued Reminder Header" where("Document Date" = field(Reminders_over_330D)));
            Caption = 'Opomene preko 330 dana';
        }
        field(50266; Reminders_over_330D; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50262; ExpirationDate_Hearing; Date)
        {
            FieldClass = FlowFilter;
        }

        field(50248; "Customers"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'Customers';
        }
        field(50249; "All Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account");
            Caption = 'All Bank Accounts';
        }
        field(50250; "Bank Accounts"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('BANK*')));
            Caption = 'Bank Accounts';
        }
        field(50251; "CZK"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" WHERE("No." = FILTER('CZK*')));
            Caption = 'Centri za kupce';
        }
        field(50252; "Centar za kupce"; Code[20])
        {

            Caption = 'Centar za kupce';

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    //If NOT UserSetup."Main Cashier" then begin        
                    GenJournalBatch.Reset();
                    GenJournalBatch.SetFilter(Name, '%1', UserSetup.CurrentJnlBatchName);
                    if GenJournalBatch.FindFirst() then
                        Rec."Centar za kupce" := GenJournalBatch."Bal. Account No.";

                end;

            end;
        }
        field(50253; "Cash Receipt Journal"; Text[100])
        {
            Caption = 'Cash Receipt Journal';
        }

        //od Sales natural cue

        field(50311; "Customers - Active"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Active')));
            Caption = 'Customers - Active';

        }
        field(50312; "Customers - all"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer);
            Caption = 'Customers - Active';

        }
        field(50313; "Customers - Terminated"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Terminated')));
            Caption = 'Customers - Terminated';

        }
        field(50314; "Customers - Potential"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Customer WHERE("Customer Status" = FILTER('Potential')));
            Caption = 'Customers - Potential';

        }
        field(50320; "Measuring Point - Active"; Integer)
        {
            Caption = 'Measuring Point';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Active')));

        }
        field(50321; "Measuring Point - all"; Integer)
        {
            Caption = 'Measuring Point-all ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item");

        }
        field(50322; "Measuring Point - TR"; Integer)
        {
            Caption = 'Measuring Point- temporery registered ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Temporarily deregistered')));

        }

        field(50323; "Measuring Point - PR"; Integer)
        {
            Caption = 'Measuring Point- Permanently deregistered ';
            FieldClass = FlowField;
            CalcFormula = Count("Service Item" WHERE("Status MM" = FILTER('Permanently deregistered')));

        }
        field(50324; "Calculation Header - Open"; Integer)
        {
            Caption = 'Calculation Header - Open';
            FieldClass = FlowField;
            CalcFormula = Count("Calcuation Header" WHERE(Status = filter(Open)));

        }
        field(50325; "Calculation Header - Locked"; Integer)
        {
            Caption = 'Calculation Header - Locked';
            FieldClass = FlowField;
            CalcFormula = Count("Calcuation Header" WHERE(Status = filter(Locked)));

        }

        field(50326; "Customer CNG - NP"; Integer)
        {
            Caption = 'Customer CNG - Natural person';
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("Customer Status" = filter(Active), "Customer Price Group" = filter('CNG'), "Tax Liable" = filter(false), "Internal Customer" = filter(false)));
        }
        field(50327; "Customer CNG - Legal Person"; Integer)
        {
            Caption = 'Customer CNG - Legal Person';
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("Customer Status" = filter(Active), "Customer Price Group" = filter('CNG'), "Tax Liable" = filter(true)));

        }

        field(50328; "Customer CNG - Own consumption"; Integer)
        {
            Caption = 'Customer CNG - Own consumption ';
            FieldClass = FlowField;
            CalcFormula = Count(Customer where("Customer Status" = filter(Active), "Internal Customer" = filter(true)));

        }
        //kraj
        /*   field(50326; "Customer - Household"; Integer)
           {
               Caption = 'Customer - Household';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(1)));
           }
           field(50327; "Customer - Large Economy"; Integer)
           {
               Caption = 'Customer - Large Economy';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(2)));
           }
           field(50328; "Customer - Small Economy"; Integer)
           {
               Caption = 'Customer - Small Economy';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(3), Name = filter('')));
           }
           field(50329; "Customer - KJKP Heating plant"; Integer)
           {
               Caption = 'Customer - KJKP Heating plant';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(4)));
           }
           field(50330; "Customer - Special Customer"; Integer)
           {
               Caption = 'Customer - Special Customer';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(5)));
           }
           field(50331; "Customer - CNG"; Integer)
           {
               Caption = 'Customer - CNG';
               FieldClass = FlowField;

               CalcFormula = count(Customer where("Customer Category" = filter(6)));
           }*/
        field(50329; "Sales Orders - Open"; Integer)
        {
            FieldClass = FlowField;

            CalcFormula = Count("Sales Header" WHERE("Document Type" = FILTER(Order)
                                                      ));
            Caption = 'Sales Orders';


        }

        field(50330; "Sales Credit Memo - Open"; Integer)
        {

            CalcFormula = Count("Sales Cr.Memo Header"
                                                      );
            Caption = 'Sales Credit Memo';

            FieldClass = FlowField;
        }

        field(50331; "Sales Shipment Header"; Integer)
        {

            CalcFormula = Count("Sales Shipment Header" where(CNG = filter(true))
                                                      );
            Caption = 'Sales Shipment Header';

            FieldClass = FlowField;
        }

        field(50332; "Transfer Header"; Integer)
        {

            CalcFormula = Count("Transfer Header"
                                                      );
            Caption = 'Transfer Header';

            FieldClass = FlowField;
        }

        field(50333; "Transfer Shipment Header"; Integer)
        {

            CalcFormula = Count("Transfer Shipment Header"
                                                      );
            Caption = 'Transfer Shipment Header';

            FieldClass = FlowField;
        }

        field(50334; "Transfer Receipt Header"; Integer)
        {

            CalcFormula = Count("Transfer Receipt Header"
                                                      );
            Caption = 'Transfer Receipt Header';

            FieldClass = FlowField;
        }

        field(50335; "Revaluation Journal"; Integer)
        {

            CalcFormula = Count("Item Journal Line"
                                                      );
            Caption = 'Revaluation Journal';

            FieldClass = FlowField;
        }
        field(50336; "TestAVANSFIELD"; Integer)
        {

            CalcFormula = Count("Sales Header"
                                                      );
            Caption = 'Sales Advance Invoice';

            FieldClass = FlowField;
        }
        field(50337; "Sales Advanced Credit Memo"; Integer)
        {

            CalcFormula = Count("Sales Header"
                                                      );
            Caption = 'Sales Header';

            FieldClass = FlowField;
        }
        field(50338; "StornoAvansField"; Integer)
        {
            CalcFormula = Count("Sales Cr.Memo Header" where(Prepayment = filter(true))
                                                      );
            Caption = 'Sales Cr.Memo Header';

            FieldClass = FlowField;
        }
        field(50339; "Statue Limitations"; Integer)
        {

            CalcFormula = Count("Accusation Header"
                                                      );
            Caption = 'Accusation Header';

            FieldClass = FlowField;
        }
        field(50340; "Reprogram"; Integer)
        {

            CalcFormula = Count("Accusation Header"
                                 WHERE("Reprogrammed Debt" = const(true)));
            Caption = 'Accusation Header';

            FieldClass = FlowField;
        }
        field(500481; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(500482; "New Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Potencijalna utuženja';
            CalcFormula = Count("Reminder Header" WHERE("Document Date" = FIELD("Date Filter 2")));
        }
        field(500483; "All Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Sve opomene';
            CalcFormula = Count("Reminder Header");
        }
        field(500484; "Printed Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Isprintane opomene';
            CalcFormula = Count("Reminder Header" WHERE("Reminder Printed" = const(true)));
        }

        field(500485; "Sent Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Poslane opomene';
            CalcFormula = Count("Reminder Header" WHERE("Reminder sent" = const(true)));
        }
        field(500486; "Date Filter 3"; Date)
        {
            Caption = 'Date Filter 3';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(500487; "Before the Limitation"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Prije zastare';
            CalcFormula = Count("Reminder Header" WHERE("Document Date" = FIELD("Date Filter 3")));
        }
        field(500488; "Household"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Domaćinstvo';
            CalcFormula = Count("Reminder Header" WHERE(CustomerCategory = const(1)));
        }
        field(500489; "Large Economy"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Velika privreda';
            CalcFormula = Count("Reminder Header" WHERE(CustomerCategory = const(2)));
        }
        field(500490; "Small Economy"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Mala privreda';
            CalcFormula = Count("Reminder Header" WHERE(CustomerCategory = const(3)));
        }
        field(500491; "Criminal Proceedings"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Krivične tužbe';
            CalcFormula = Count("Accusation Header" WHERE("Current Accusation Type" = const(3)));
        }
        field(500492; "Executive Proceedings"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Izvršne tužbe';
            CalcFormula = Count("Accusation Header" WHERE("Current Accusation Type" = const(2)));
        }
        field(500493; "Litigation Proceedings"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Parnične tužbe';
            CalcFormula = Count("Accusation Header" WHERE("Current Accusation Type" = const(1)));
        }
        field(500494; "All Accusations"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Sve tužbe';
            CalcFormula = Count("Accusation Header");
        }
        field(500495; "AC - Household"; Integer)
        {
            Caption = 'Accusation HouseHold ';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter(Household), Archived = filter(false)));

        }

        field(500496; "AC - Large Economy"; Integer)
        {
            Caption = 'Accusation Large Economy ';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("Large Economy"), Archived = filter(false)));

        }

        field(500497; "AC - Small Economy"; Integer)
        {
            Caption = 'Accusation Small Economy ';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("Small Economy"), Archived = filter(false)));

        }
        field(500498; "AC - KJKP Heating plant"; Integer)
        {
            Caption = 'Accusation KJKP Heating plant ';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("KJKP Heating plant"), Archived = filter(false)));

        }
        field(500499; "AC - Special Customer"; Integer)
        {
            Caption = 'Accusation Special Customer';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("Special Customer"), Archived = filter(false)));

        }
        field(500500; "AC - CNG"; Integer)
        {
            Caption = 'Accusation CNG';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("CNG"), Archived = filter(false)));

        }
        field(500501; "AC - Resource"; Integer)
        {
            Caption = 'Accusation Resource';
            FieldClass = FlowField;
            CalcFormula = Count("Accusation Line" where("Bill Category" = filter("Resource"), Archived = filter(false)));

        }
        field(500502; "Petty Cash"; Integer)
        {
            Caption = 'Petty Cash';
            FieldClass = FlowField;
            CalcFormula = Count("Bank Account" where("No." = const('CNG')));

        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }
    var
        datum: Date;
        t_Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        datum2: Date;
        PQ: page "Bookkeeper activities";
        HRsetup: Record "Human Resources Setup";
        finalDate: Date;
        datum3: Date;

        OrgShema: Record "Org Shema";
        Sistematizacija: Text;
        UserSetup: Record "User Setup";
        BankAccount: Record "Bank Account";
        GenJournalBatch: Record "Gen. Journal Batch";

}

