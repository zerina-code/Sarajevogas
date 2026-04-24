page 50094 "Payroll Role Center"
{
    Caption = 'Payroll', Comment = '{Dependency=Match,"ProfileDescription_Payroll"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control139; "Payrollgreeting")
            {
                ApplicationArea = all;
                Visible = true;

            }
            part("Payroll Activities"; "Payroll Activities")
            {
                ApplicationArea = all;
            }

        }
    }

    actions
    {
        area(processing)
        {


            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                action("Company Information")
                {
                    Caption = 'Company Information';
                    Image = CompanyInformation;
                    ApplicationArea = all;
                    RunObject = Page "Company Information";
                }
                action("Wage Setup")
                {
                    Caption = 'Wage Setup';
                    Image = Setup;
                    RunObject = Page "Wage Setup";
                    ApplicationArea = all;
                }

                action("Update Position")
                {
                    Caption = 'Update Position';
                    Image = Setup;
                    RunObject = Page "Update Position";
                    ApplicationArea = all;
                }

                action("Chart of Accounts2")
                {
                    ApplicationArea = all;
                    Caption = 'Chart of Accounts';
                    Image = Accounts;
                    RunObject = Page "Chart of Accounts";
                }
                action(Municipalities)
                {
                    ApplicationArea = all;
                    Caption = 'Municipalities';
                    Image = MapSetup;
                    RunObject = Page Municipalities;
                }
                action(Countries)
                {
                    ApplicationArea = all;
                    Caption = 'Countries';
                    Image = CountryRegion;
                    RunObject = Page "Countries/Regions";
                }
                action(Entities)
                {
                    ApplicationArea = all;
                    Caption = 'Entities';
                    Image = CostCenter;

                    RunObject = Page Entities;
                }
                action(Cantons)
                {
                    ApplicationArea = all;
                    Caption = 'Cantons';
                    Image = PostApplication;

                    RunObject = Page Cantons;
                }
                action("Post Codes")
                {
                    ApplicationArea = all;
                    Caption = 'Post Codes';
                    Image = Post;
                    RunObject = Page "Post Codes";
                }
                action("Employee Default Dimension")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Default Dimension';
                    Image = DefaultDimension;
                    RunObject = Page "Employee Default Dimension";
                }
                action("No. Series")
                {
                    ApplicationArea = all;
                    Caption = 'No. Series';
                    Image = NewSum;
                    RunObject = Page "No. Series";
                }
                action(Users)
                {
                    ApplicationArea = all;
                }
                action("Accounting Period")
                {
                    ApplicationArea = all;
                    Caption = 'Accounting Period';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action(Transport)
                {
                    ApplicationArea = all;
                    Caption = 'Transport';
                    Image = Import;
                    RunObject = XMLport "Transport";
                }
                action("Tax Deduction Amount")
                {
                    ApplicationArea = all;
                    Caption = 'Tax Deduction Amount';
                    Image = Import;
                    RunObject = XMLport "Tax Deduction Amount";
                }
                /*Import knjižnih grupa 
                action("Import Knj Gr")
                {
                    ApplicationArea = all;
                    Caption = 'Import Knj Gr';
                    Image = Import;
                    RunObject = XMLport "Import Knjiznih Grupa";
                }*/

                //Import jedinica mjere
                /*action("Import JM")
                {
                    ApplicationArea = all;
                    Caption = 'Import JM';
                    Image = Import;
                    RunObject = XMLport "Import JM";
                }*/

            }
            group("Send Pay Lists via e-mail")
            {
                Caption = 'Send Pay Lists via e-mail';
                Image = ExecuteBatch;

                action("Send PayList")
                {
                    ApplicationArea = all;
                    Caption = 'Send Pay Lists via e-mail';
                    Image = CompanyInformation;
                    RunObject = Report "Send Pay Lists via e-mail";
                }
                /*    action("Send PayList Add")
                    {
                        ApplicationArea = all;
                        Caption = 'Send Pay Lists via e-mail (Add)';
                        Image = CompanyInformation;
                        RunObject = Report "Send Pay Add via e-mail";
                    }*/

            }

            group("<Action61>")
            {
                Caption = 'Reductions';
                Image = Payables;
                action("Reduction Types")
                {
                    ApplicationArea = all;
                    Caption = 'Reduction Types';
                    Image = Payment;
                    RunObject = Page "Reduction types";
                }
                action("Reduction List")
                {
                    ApplicationArea = all;
                    Caption = 'Reduction List';
                    Image = PaymentDays;
                    RunObject = Page "Reduction List";
                }
                action("Wage/Reduction Banks")
                {
                    ApplicationArea = all;
                    Caption = 'Wage/Reduction Banks';
                    Image = Bank;
                    RunObject = Page "Wage/Reduction Banks";
                }
                action("Wage/Reduction bank accounts")
                {
                    ApplicationArea = all;
                    Caption = 'Wage/Reduction bank accounts';
                    Image = BankAccount;
                    RunObject = Page "Wage/Reduction bank accounts";
                }

            }

            group("<Action611>")
            {
                Caption = 'Additions';
                Image = Receivables;
                action("Wage Additon Types")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Additon Types';
                    Image = Allocate;
                    RunObject = Page "Wage Addition Types";
                }
                action("Wage Additions")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Addition';
                    Image = Allocations;
                    RunObject = Page "Wage Addition";
                }

            }

            group("<Action63211>")
            {
                Caption = 'Contribution';
                Image = CostAccounting;
                action("Contribution Category List")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Category List';
                    Image = Account;
                    RunObject = Page "Contribution Category List";
                }
                action("Contribution List")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution List';
                    Image = AutoReserve;
                    RunObject = Page "Contribution List";
                }
                action("Contribution Connections")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Percentages';
                    Ellipsis = true;
                    Image = Percentage;
                    InFooterBar = true;
                    RunObject = Page "Contribution Connections";
                }
                action("Contribution Posting Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Posting Setup';
                    Image = ContactReference;
                    RunObject = Page "Contribution Posting Setup";
                }
            }


            group("<Action6111>")
            {
                Caption = 'Tax';
                Image = Intrastat;
                action("Tax Classes")
                {
                    ApplicationArea = all;
                    Caption = 'Tax Classes';
                    Image = TaxSetup;
                    RunObject = Page "Tax Classes";
                }
            }


            group(Calculations)
            {
                Caption = 'Calculations';
                Image = RegisteredDocs;
                action("Wage Calculation")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Calculation';
                    Image = WageLines;

                    RunObject = Page "Wage Wizard Step 1";
                }
                action("Temporary Service Agreements")
                {
                    ApplicationArea = all;
                    Caption = 'Temporary Service Agreements Calculation';
                    Image = EmployeeAgreement;

                    RunObject = Report "Temporary Contract Calculation";
                }

            }
            group("Pay Lists2")
            {
                Caption = 'Pay Lists';
                Image = Statistics;
                action("Pay Lists")
                {
                    ApplicationArea = all;
                    Caption = 'Pay Lists';
                    Image = Recalculate;
                    RunObject = Report "Pay List Final";
                }
                /*       action("Pay list with add")
                       {
                           ApplicationArea = all;
                           Caption = 'Pay list with add';
                           Image = "Report";
                           Promoted = true;
                           PromotedIsBig = true;
                           RunObject = Report "Pay List Wage Add";
                       }*/


            }
            group("Payment Orders2")
            {
                Caption = 'Payment Orders';
                Image = Bank;

                action("Payment Orders")
                {
                    ApplicationArea = all;
                    Caption = 'Payment orders';
                    Image = WageLines;

                    RunObject = Page "Payment Orders";
                }
                action("Contribution Payments Setup")
                {
                    ApplicationArea = all;
                    Caption = 'Contribution Payments Setup';
                    Image = Setup;
                    RunObject = Page "Contribution Payment Setup";
                }

            }

            group(Analytics)
            {
                Caption = 'Analytics';
                Image = AnalysisView;
                action("Wage entries")
                {
                    ApplicationArea = all;
                    Caption = 'Wage entries';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Wage Calculation Subform";
                }
                action("Wage Value Entries")
                {
                    ApplicationArea = all;
                    Caption = 'Wage value entries';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Wage Value Entries";
                }


                action("Reduction per Wage")
                {
                    ApplicationArea = all;
                    Caption = 'Reduction per wage';
                    Image = Recalculate;
                    RunObject = Page "Reductions Per Wage";
                }
                action("Wage Addition")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Addition';
                    Image = AmountByPeriod;
                    RunObject = Page "Wage Addition Calculated";
                }
                action("General Ledger Entries")
                {
                    ApplicationArea = all;
                    Caption = 'General Ledger Entries';
                    Image = AnalysisViewDimension;
                    RunObject = Page "General Ledger Entries";
                }

                action("Tax Analysis Items")
                {
                    ApplicationArea = all;
                    Caption = 'Tax Analysis Items';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Tax Per Employee Page";

                }
            }

            group(Posting)
            {
                Caption = 'Posting';
                Image = Ledger;
                action("Wage Posting Groups")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Posting Groups';
                    Image = Post;
                    RunObject = Page "Wage Posting Groups";
                }
                action("General Journal")
                {
                    ApplicationArea = all;
                    Caption = 'General Journal';
                    Image = PostBatch;
                    RunObject = Page "General Journal";

                }

            }
            group("Chart of Accounts")
            {
                Caption = 'Chart of Accounts';
                Visible = false;
                group("Chart of Accounts3")
                {
                    Caption = 'Chart of Accounts';
                    Image = Intrastat;
                    action("Chart Accounts")
                    {
                        ApplicationArea = all;
                        Caption = 'Chart of Accounts';
                        Image = Account;
                        RunObject = Page "Chart of Accounts";
                    }
                }
            }

            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = Worksheets;
                action("Cause of Absence")
                {
                    ApplicationArea = all;
                    Caption = 'Cause of Absence';
                    Image = Absence;
                    RunObject = Page "Causes of Absence";
                }
                /*      action("Cause of Absence Subtype")
                      {
                          ApplicationArea = all;
                          Caption = 'Cause of Absence Subtype';
                          Image = AbsenceCategory;
                          RunObject = Page "Cause of Absence Subtype";
                          Visible = false;
                      }*/
                action("Timesheets Export")
                {
                    ApplicationArea = all;
                    Caption = 'Timesheets Export';
                    Image = Excel;
                    //  RunObject = Report "Timesheets";
                    Visible = false;
                }
                /* action("Create Timesheets")
                 {
                     ApplicationArea = all;
                     Caption = 'Create Timesheets';
                     Image = Excel;
                     RunObject = Report "Create Timesheet final";


                 }*/

                //Create Timesheet GAS

                action("Create absence Registration")
                {
                    ApplicationArea = all;
                    Caption = 'Create Absence Registration';
                    Image = Absence;
                    RunObject = Page "Employee Absence";
                }

                action("Absence Registration")
                {
                    ApplicationArea = all;
                    Caption = 'Absence Registration';
                    Image = Absence;
                    RunObject = Page "Absence Registration";
                }
                action("Timesheets Import")
                {
                    ApplicationArea = all;
                    Caption = 'Import Work Evidence';
                    Image = ElectronicRegister;

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = XMLport "Import sihterica";
                    Visible = true;
                }





            }
            action("Transfer Orders")
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders';
                Image = Worksheets;
                RunObject = Page "Transfer Orders";
            }
            action("Base Calendar Change")
            {
                ApplicationArea = all;
                Caption = 'Base Calendar Change';
                RunObject = page "Base Calendar Changes";
            }
        }
        area(reporting)
        {

            group(Summary)
            {
                Caption = 'Summary';
                Image = CashFlow;
                action("Sumarry per Payment Order")
                {
                    ApplicationArea = all;
                    Caption = 'Sumarry per Payment Orders';
                    Image = "Report";

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summary per Payment Orders";
                }
                action("Reduction per Banks")
                {
                    ApplicationArea = all;
                    Caption = 'Reduction per Banks';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Reduction per Banks";
                }
                /*  action("LAst Installment")
                  {
                      ApplicationArea = all;
                      Caption = 'Last Installment';
                      Image = "Report";
                      
                      //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                      //PromotedIsBig = false;
                      RunObject = Report "TS_knjizenja 3";
                  }*/
                action("Payment List")
                {
                    ApplicationArea = all;
                    Caption = 'Payment List';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Payment List";
                }
                /* action("Pay List")
                 {
                     Caption = 'Pay List';
                     Image = "Report";
                     
                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                     //PromotedIsBig = false;
                     RunObject = Report 60032;
                 }*/
                action("Sumarry per Employee")
                {

                    ApplicationArea = all;
                    Caption = 'Sumarry per Employee';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summarry Per Employee";
                }
                action("Summary per Payment Type")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment Type';
                    Image = "Report";
                    RunObject = Report "Summary per Payment Type";
                }
                action("Summary per Payment hours")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment hours';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Summary per Payment Hours";
                }
                action("Summary per Payment Amounts")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per Payment Amounts';
                    Image = "Report";
                    RunObject = Report "Summary per Payment Amounts";
                }
                action("Summary per years")
                {
                    ApplicationArea = all;
                    Caption = 'Summary per years';
                    Image = "Report";
                    RunObject = Report "Summary per years";
                }
                action("Employee Disability")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Disability';
                    Image = "Report";
                    RunObject = Report "Izvjestaj invalidet";
                }
                action("Expenses by municipalities")
                {
                    ApplicationArea = all;
                    Caption = 'Expenses by municipalities';
                    Image = Report;
                    RunObject = report "Expenses by municipality";
                }

            }

            group("Org. structure and positions")
            {
                Caption = 'Org. structure and positions';
                Image = HumanResources;
            }

            action("ORG Dijelovi")
            {
                ApplicationArea = all;
                Caption = 'ORG Part';
                Image = Dimensions;
                RunObject = Page "ORG Dijelovi";
            }



            group(Forms)
            {
                Caption = 'Forms';
                Image = Transactions;
                action("Salary specification")
                {
                    ApplicationArea = all;
                    Caption = 'Form 2001-Salary specification';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Salary specification";
                }
                action("Salary specification2")
                {
                    ApplicationArea = all;
                    Caption = 'Form 2003-Salary specification';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Salary specification 2003";
                }
                action("MIP - 1023")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023';
                    Image = Document;

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "MIP - 1023";
                }
                action("MIP - 1023 Brčko distrikt")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023 Brčko distrikt';
                    Image = "Report";

                    Visible = false;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "MIP - 1023 Brčko distrikt";
                }
                action("MIP - 1023 BDPIOFBIH")
                {
                    ApplicationArea = all;
                    Caption = 'MIP - 1023 BDPIOFBIH';
                    Image = "Report";
                    Visible = false;
                    RunObject = Report "MIP - 1023 BDPIOFBIH";
                }
                action("GIP - 1022")

                {
                    ApplicationArea = all;
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;""
                    RunObject = Report "GIP-1022 ";
                    Visible = false;

                }
                action("GIP - 1022 Cumulative")
                {
                    ApplicationArea = all;
                    Caption = 'GIP - 1022 Cumulative';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "GIP-1022 Cumulative ";
                    Visible = false;
                }
                action("GIP - 1022 Brčko")
                {
                    ApplicationArea = all;
                    Caption = 'GIP-1022 Brčko';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    //  RunObject = Report "GIP-1022 Brcko";
                    Visible = false;
                }
                action("GIP-1022 New")
                {
                    ApplicationArea = all;
                    Caption = 'GIP-1022';
                    Image = "Report";
                    RunObject = Report "GIP-1022 New";
                }
                action("Rad-1")
                {
                    ApplicationArea = all;
                    Caption = 'Rad-1';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Rad-1";
                }
                action("Rad-1G")
                {
                    ApplicationArea = all;
                    Caption = 'Rad-1G';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Rad-1G";
                }
                action("Obrazac 1002")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Obrazac 1002-OL";
                    Visible = false;
                }
                action("Obrazac 1002 OL")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002';
                    Image = "Report";
                    RunObject = Report "Obrazac 1002-DL1";
                }
                action("Obrazac 1002-OL Brcko")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 1002-OL Brcko';
                    Image = "Report";
                    RunObject = Report "Obrazac 1002-OL Brcko";
                    Visible = false;
                }
                action("OLP-1021")
                {
                    ApplicationArea = all;
                    Caption = 'OLP-1021';
                    Image = "Report";
                    RunObject = Report "OLP-1021";
                }

                action("Obrazac DL-2")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac DL-2';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Obrazac DL-2";
                    Visible = false;
                }

                action("Obrazac 2001-A")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 2001-A';
                    Image = "Report";
                    RunObject = Report "Obrazac 2001-A";
                    Visible = false;
                }
                action("Obrazac 2001-A Brcko")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac 2001-A Brcko';
                    Image = "Report";
                    RunObject = Report "Obrazac 2001-A Brcko";
                    Visible = false;
                }
                action("Obrazac DL-1")
                {
                    ApplicationArea = all;
                    Caption = 'Obrazac DL-1';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "DL1";
                }

            }

            group("Forms For Temporary Agreements")
            {
                Caption = 'Forms For Temporary Agreements';
                Image = Transactions;
                action("Temporary Work Form AUG-1031")
                {
                    Caption = 'Temporary Work Form AUG-1031';
                    ApplicationArea = all;
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form AUG-1031";
                }

                action("Temporary Work Form ASD-1032")
                {
                    Caption = 'Temporary Work Form ASD-1032';
                    ApplicationArea = all;
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form ASD-1032";
                }

                //
                action("Temporary Work Form PDN-1033")
                {
                    ApplicationArea = all;
                    Caption = 'Temporary Work Form PDN-1033';
                    Image = "Report";
                    Visible = false;

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Temporary Work Form PDN-1033";
                }
                action("Form AUG-1031-Author Contracts")
                {
                    ApplicationArea = all;
                    Caption = 'Form AUG-1031-Author Contracts';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "Form AUG-1031-Author Contracts";
                }
                action("GIP - 1022 TC")
                {
                    ApplicationArea = all;
                    Caption = 'GIP - 1022 Temporary Contracts';
                    Image = "Report";

                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;
                    RunObject = Report "GIP-1022 TC";
                }

            }

            group("Forms export")
            {
                Caption = 'Forms export';
                Image = SNInfo;
                action("Export MIP-1023")
                {
                    ApplicationArea = all;
                    Image = Export;
                    RunObject = XMLport "MIP 1023";
                }
                action("Export GIP-1022")
                {
                    ApplicationArea = all;
                    Caption = 'Export GIP-1022';
                    Image = Export1099;
                    RunObject = XMLport "GIP 1022";
                }
                //EmployeeData



            }

        }
    }
}


