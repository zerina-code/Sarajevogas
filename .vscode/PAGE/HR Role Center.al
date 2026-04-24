page 50003 "HR Role Center"
{
    Caption = 'HR Role Center';
    PageType = RoleCenter;
    UsageCategory = Lists;
    ApplicationArea = all;


    layout
    {
        area(rolecenter)
        {
            part(Control139; "Payrollgreeting")
            {
                ApplicationArea = all;
                Visible = true;
            }

            part("HR activities"; "HR activities")
            {
                Caption = 'HR activities';
                ApplicationArea = all;
                Visible = true;
            }
            //}


        }
    }

    actions
    {
        area(processing)
        {
            //group(Setup1)
            //{
            ////  Caption = 'Setup';
            // Image = HRSetup;
            /*  group(Setup2)
              {
                  Caption = 'Setup';
                  Image = HRSetup;
              }*/
            group(Setup)
            {
                Caption = 'Setup';
                Image = HRSetup;
                action("Page Human Resources Setup")
                {
                    Caption = 'Human Resources Setup';
                    ApplicationArea = all;
                    Image = HRSetup;
                    RunObject = Page "Human Resources Setup";
                    ToolTip = 'Set up your number series for creating new employee cards and define if employment time is measured by days or hours.';
                }


                action("Company Information")
                {
                    Caption = 'Company Information';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ApplicationArea = all;
                }
                //"ECL Update"

                action("ECL Update")
                {
                    Caption = 'ECL Update';
                    Image = CompanyInformation;
                    RunObject = xmlport "ECL Update";
                    ApplicationArea = all;
                    Visible = false;

                }

                action(Countries)
                {
                    Caption = 'Countries';
                    Image = CountryRegion;
                    RunObject = Page "Countries/Regions";
                    ApplicationArea = all;
                }
                action(Entities)
                {
                    Caption = 'Entities';
                    Image = CostCenter;

                    RunObject = Page Entities;
                    ApplicationArea = all;
                }
                action(Cantons)
                {
                    Caption = 'Cantons';
                    Image = PostApplication;

                    RunObject = Page Cantons;
                    ApplicationArea = all;
                }
                action("Post Codes")
                {
                    Caption = 'Post Codes';
                    Image = Post;
                    RunObject = Page "Post Codes";
                    ApplicationArea = all;
                }
                action(Municipalities)
                {
                    Caption = 'Municipalities';
                    Image = Addresses;
                    RunObject = Page "Municipalities";
                    ApplicationArea = all;
                }
                action(Citizenship)
                {
                    Caption = 'Citizenship';
                    Image = MapAccounts;
                    RunObject = Page "Citizenship Description";
                    ApplicationArea = all;
                }
                action("Training Catalogue")
                {
                    Caption = 'Training Catalogue';
                    Image = TaskList;
                    RunObject = Page "Trainings Catalogue";
                    ApplicationArea = all;

                }
                action("Training Time Entry")
                {
                    Caption = 'Training time entries';
                    Image = Entries;
                    RunObject = Page "Training Time Entries";
                    ApplicationArea = all;

                }
                action("Types Of Diseases")
                {
                    Caption = 'Types Of Diseases';
                    Image = Category;
                    RunObject = Page "Types Of Diseases";
                    ApplicationArea = all;
                }
                action("Disability Level")
                {
                    Caption = 'Disability Level';
                    Image = Job;
                    RunObject = Page "Disability Level";
                    ApplicationArea = all;
                }
                action(Languages)
                {
                    Caption = 'Languages';
                    Image = Language;

                    RunObject = Page "Languages";
                    ApplicationArea = all;
                }
                action(Nationallity)
                {
                    Caption = 'Nationallity';
                    Image = NewLotProperties;
                    RunObject = Page "Nationallity";
                    ApplicationArea = all;
                }

                action("Misc. Articles")
                {
                    Caption = 'Misc. Articles';
                    Image = Approval;
                    RunObject = Page "Misc. Articles";
                    ApplicationArea = all;
                }
                action(Position)
                {
                    Caption = 'Position';
                    Image = Position;

                    RunObject = Page "Positions";
                    ApplicationArea = all;
                }
                action(XML)
                {
                    Caption = 'XML';
                    Image = XMLFile;
                    RunObject = xmlport "Position Import";
                    ApplicationArea = all;
                    Visible = true;
                }
                action(Vocation)
                {
                    Caption = 'Vocation';
                    Image = List;
                    RunObject = Page "Vocation";
                    ApplicationArea = all;
                }
                action(Profession)
                {
                    Caption = 'Profession';
                    Image = IndustryGroups;
                    RunObject = Page "Profession";
                    ApplicationArea = all;
                }
                action("Institutions/Companies")
                {
                    Caption = 'Institutions/Companies';
                    Image = Company;
                    RunObject = Page "Institutions/Companies";
                    ApplicationArea = all;
                }
                action(Title)
                {
                    Caption = 'Title';
                    Image = Vendor;
                    RunObject = Page "Title";
                    ApplicationArea = all;
                }
                action(Majors)
                {
                    Caption = 'Majors';
                    ApplicationArea = all;
                }
                action("No. Series")
                {
                    Caption = 'No. Series';
                    Image = NewSum;
                    RunObject = Page "No. Series";
                    ApplicationArea = all;
                }
                action("User Personalization List")
                {
                    Caption = 'User Personalization List';
                    Image = User;
                    RunObject = Page "User Personalization List";
                    ApplicationArea = all;
                }

                /*      action(Documents)
                      {
                          Caption = 'Documents';
                          Image = Documents;
                          RunObject = Page "Document Register";
                          ApplicationArea = all;
                      }*/
                action(Users)
                {
                    Caption = 'Userst';
                    Image = User;
                    RunObject = Page "Users";
                    ApplicationArea = all;
                }
                //  }
            }

            group("Org. structure and positions2")
            {
                Caption = 'Org. structure and positions';
                Image = HumanResources;


            }
            group("Org. structure and positions")
            {
                Caption = 'Org. structure and positions';
                Image = HumanResources;
                action("ORG Dijelovi")
                {
                    ApplicationArea = all;
                    Caption = 'ORG Part';
                    Image = Dimensions;
                    RunObject = Page "ORG Dijelovi";
                }
                //Employees Import
                action("Employees Import")
                {
                    ApplicationArea = all;
                    Caption = 'Employees Import';
                    Image = Dimensions;
                    RunObject = xmlport "Employees Import";
                    Visible = false;
                }
                //
                action("Employee No import")
                {
                    ApplicationArea = all;
                    Caption = 'Employees Import';
                    Image = Dimensions;
                    RunObject = xmlport "Employee No import";
                    Visible = false;
                }

                action("ORG Shema")
                {
                    ApplicationArea = all;
                    Caption = 'ORG Shema';
                    Image = Dimensions;
                    RunObject = Page "ORG Shema";
                }
                action(Departments)
                {
                    ApplicationArea = all;
                    Caption = 'Departments';
                    Image = Dimensions;

                    RunObject = Page "Department";
                    RunPageMode = View;
                }
                action("Head Of's")
                {
                    ApplicationArea = all;
                    Caption = 'Head Of''s';
                    Image = Employee;
                    RunObject = Page "Head Of's";
                    RunPageMode = View;
                }
                action(Sector)
                {
                    Caption = 'Sector';
                    Image = Dimensions;
                    RunObject = Page "Sector";
                    ApplicationArea = all;
                }
                action(Department)
                {
                    ApplicationArea = all;
                    Caption = 'Department';
                    Image = DimensionSets;
                    RunObject = Page "Department Category";
                }
                action(Group)
                {
                    Caption = 'Group';
                    Image = DefaultDimension;
                    RunObject = Page "Group";
                    ApplicationArea = all;
                }

                action(PositionMenu)
                {
                    ApplicationArea = all;
                    Caption = 'Update Position';
                    Image = DistributionGroup;
                    RunObject = Page "Update Position";
                }

                action(Positions)
                {
                    ApplicationArea = all;
                    Caption = 'Positions';
                    Image = DistributionGroup;
                    RunObject = Page "Positions";
                }


                /*   action("Dimension for position")
                   {
                       ApplicationArea = all;
                       Caption = 'Dimension for position';
                       Image = AllocatedCapacity;
                       RunObject = Page "Dimension for Position";
                       RunPageMode = View;
                       Visible = false;
                   }*/
                action("Dimension Values")
                {
                    ApplicationArea = all;
                    Caption = 'Dimension Values';
                    Image = AllocatedCapacity;
                    RunObject = Page "Dimension Values";
                }
                action("Employee Default Dimension")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Default Dimension';
                    Image = Allocate;
                    RunObject = Page "Employee Default Dimension";
                }



                /*   action("Payment range")
                   {
                       ApplicationArea = all;
                       Caption = 'Payment range';
                       Image = Payment;
                       RunObject = Page "Payment range";
                   }*/
                action("Employee Contract Ledger")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Contract Ledger';
                    Image = Agreement;
                    RunObject = page "Employee Contract Ledger";
                }


            }




            group(Import2)
            {
                Caption = 'Import';
                Image = Administration;
                Visible = false;
                /* action("Employee Contract Ledger Impor")
                 {
                     Caption = 'Employee Contract Ledger Impor';
                     Image = ContractPayment;
                     RunObject = Page "Employee Contract Ledger Impor";
                     Visible = false;
                 }*/
                /*  action("Employee Contract Ledger I Netto")
                  {
                      Caption = 'Employee Contract Ledger I Netto';
                      Image = ContractPayment;
                      Promoted = false;
                      RunObject = "Employee Contract L Imopt Neto";
                      Visible = false;
                  }
                action("External Fund Import")
                {
                    Caption = 'External Fund Import';
                    Image = Import;
                    RunObject = XMLport "Djevojačko prezime";
                }
                action("Internal Fund Import")
                {
                    Caption = 'Internal Fund Import';
                    Image = Import;
                    RunObject = XMLport "Ime oca";
                }*/
                action("Wage Additions")
                {
                    ApplicationArea = all;
                    Caption = 'Wage Addition';
                    Image = Allocations;
                    RunObject = Page "Wage Addition";
                }

            }

            group("Holiday Plan2")
            {

                Caption = 'Holiday Plan';
                Image = Transactions;
            }
            group("Holiday Plan")
            {
                Caption = 'Holiday Plan';
                Image = Transactions;
                action("Vacation Usage Plan")
                {
                    ApplicationArea = all;
                    Caption = 'Vacation Usage Plan';
                    Image = Holiday;
                    RunObject = Page "Vacation Usage Plan";
                }
                action("Vacation Usage Plan2")
                {
                    ApplicationArea = all;
                    Caption = 'Vacation Usage Plan';
                    Image = Holiday;
                    RunObject = Page "Vacation setup history";
                }
                /*action("Vacation Usage Plan3")
                {
                    ApplicationArea = all;
                    Caption = 'Vacation Usage Plan';
                    Image = Holiday;
                    RunObject = Page "Vacation Grounds2";
                }*/
                action("Points per Experience Years")
                {
                    ApplicationArea = all;
                    Caption = 'Points per Experience Years';
                    Image = Excise;
                    RunObject = Page "Points per Experience Years";
                }
                action("Points per Disability Status")
                {
                    ApplicationArea = all;
                    Caption = 'Points per Disability Status';
                    Image = Filed;
                    RunPageView = WHERE(Category = CONST(0)); //ED
                    RunObject = Page "Points per Disability Status";
                }
                //ED 02 START
                action("Points per Military Service")
                {
                    ApplicationArea = all;
                    Caption = 'Points per Military Service';
                    Image = Employee;
                    RunPageView = WHERE(Category = CONST(1));
                    RunObject = Page "Points per Disability Status";
                }
                action("Points per Working Conditions")
                {
                    ApplicationArea = all;
                    Caption = 'Points per Working Conditions';
                    Image = WorkTax;
                    RunPageView = WHERE(Category = CONST(2));
                    RunObject = Page "Points per Disability Status";
                }
                //ED 02 END
                action("Vacation statistic")
                {
                    ApplicationArea = all;
                    Caption = 'Vacation statistic';
                    Image = "Report";
                    RunObject = Report "Vacation statistics";
                }
                action("Vacation")
                {
                    ApplicationArea = all;
                    Caption = 'Vacation Decision';
                    Image = Report;
                    RunObject = report VacationDecision;
                }

            }

            group(MBO2)
            {
                Caption = 'MBO';
                Image = ResourcePlanning;



            }

            group(Refresh2)
            {
                Caption = 'Refresh';
                Image = ExecuteBatch;



                action("Status update")
                {
                    ApplicationArea = all;
                    Caption = 'Status update';
                    Image = UpdateXML;
                    RunObject = Report "StatusExt update";
                    Visible = true;
                }
                action("Update TC")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'Update TC';
                    Image = UpdateXML;
                    //  RunObject = report "Azuriraj troskovni centar";
                }
                action(SistJob)
                {
                    ApplicationArea = all;
                    Caption = 'SistJob';
                    Image = UpdateXML;
                    RunObject = Report "Systematization job";
                }

            }








            group(Timesheets2)
            {
                Caption = 'Timesheets';
                Image = Worksheets;
            }
            group(Timesheets)
            {
                Caption = 'Timesheets';
                Image = Worksheets;
                action("Timesheets Export")
                {
                    ApplicationArea = all;
                    Caption = 'Timesheets Export';
                    Image = Excel;
                    //  RunObject = Report "Timesheets";
                    Visible = false;
                }
                action("Timesheets Import")
                {
                    ApplicationArea = all;
                    Caption = 'Import Work Evidence';
                    Image = Import;
                    RunObject = XMLport "Import sihterica";
                    Visible = false;
                }
                /*  action("Vacation setup")
                  {
                      ApplicationArea = all;
                      Caption = 'Absence setup';
                      Image = PersonInCharge;
                      Promoted = true;
                      PromotedCategory = Process;
                      PromotedIsBig = true;
                      RunObject = Page "Vacation setup";
                  }*/
                action("Base Calendar")
                {
                    Caption = 'Calendar';
                    Image = CalendarChanged;
                    RunObject = Page "Base Calendar Changes";
                }
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

                action("Causes of Absence")
                {
                    ApplicationArea = all;
                    Caption = 'Causes of Absence';
                    Image = AbsenceCategory;
                    RunObject = Page "Causes of Absence";
                }
                /*       action("Cause of Absence Subtype")
                       {
                           ApplicationArea = all;
                           Caption = 'Cause of Absence Subtype';
                           Image = AbsenceCategory;
                           RunObject = Page "Cause of Absence Subtype";
                           Visible = false;
                       }
       */


            }
            action("TRansferOrder")
            {
                ApplicationArea = all;
                Caption = 'Transfer Orders';
                RunObject = page "Transfer Orders";
            }
            action("Base Calendar Change")
            {
                ApplicationArea = all;
                Caption = 'Base Calendar Change';
                RunObject = page "Base Calendar Changes";
            }
            group("Zapošljavanje2")
            {
                Caption = 'Zapošljavanje';
                Image = HumanResources;
                Visible = false;
            }
            group("Zapošljavanje")
            {
                Caption = 'Zapošljavanje';
                Visible = false;
                Image = HumanResources;

                /*      action("Posting List")
                      {
                          ApplicationArea = all;
                          Caption = 'Lista konkursa';
                          Image = BlanketOrder;
                          RunObject = Page "Posting List";
                      }*/


            }

        }
        area(embedding)
        {
        }
        area(reporting)
        {

            group("General Employee Reports2")
            {
                Caption = 'General Employee Reports';
                Image = Administration;



                /* action("Employee - Birthdays")
                 {
                     Caption = 'Employee - Birthdays';
                     Image = "Event";
                     RunObject = Report 5209;
                 }
                 action("Gender Structure1")
                 {
                     Caption = 'Gender structure';
                     Image = SalesPurchaseTeam;
                     RunObject = Report "Education Structure";
                 }
                 action("Report Time To Hire")
                 {
                     Caption = 'Time To Hire';
                     Image = "Report";
                     RunObject = Report "Employee Status";
                 }*/

            }

            group(Forms2)
            {
                Caption = 'Forms';
                Image = LotInfo;
                action(PD3100)
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = 'PD3100';
                    Image = Document;
                    RunObject = Report "Obrazac PD3100";
                }
                action(JS3100)
                {
                    ApplicationArea = all;
                    Caption = 'JS3100';
                    Image = Document;
                    RunObject = Report "Obrazac JS3100";
                }

            }

            group(Certifications2)
            {
                Caption = 'Certifications';
                Image = LotInfo;














            }

            group("Contracts And Annexes2")
            {
                Caption = 'Contracts And Annexes';
                Image = AdministrationSalesPurchases;
                /* action("Anex work contract on indefini")
                 {
                     Caption = 'Anex work contract on indefinite';
                     Image = "Report";
                     RunObject = Report "Anex contract on indef word";
                     Visible = false;
                 }
                 action("Anex work contract on definit")
                 {
                     Caption = 'Anex work contract on definit';
                     Image = "Report";
                     RunObject = Report "Anex work contract on definit";
                     Visible = false;
                 }
                 action("Contr on indef w/o p w ar")
                 {
                     Caption = 'Contr on indef w/o p w ar';
                     Image = "Report";
                     RunObject = Report 99001014;
                     Visible = false;
                 }
                 action("Certificate on indefinitely M")
                 {
                     Caption = 'Certificate on indefinitely M';
                     Image = "Report";
                     RunObject = Report 99000787;
                     Visible = false;
                 }
                 action("Contract on indef w/o prob")
                 {
                     Caption = 'Contract on indef w/o prob';
                     Image = "Report";
                     RunObject = Report 99000791;
                     Visible = false;
                 }
                 action("Cont indef w/ prob for arrang")
                 {
                     Caption = 'Cont indef w/ prob for arrang';
                     Image = "Report";
                     RunObject = Report 99000789;
                     Visible = false;
                 }
                 action("Contract on indef w/probation ")
                 {
                     Caption = 'Contract on indef w/probation ';
                     Image = "Report";
                     RunObject = Report 99001017;
                     Visible = false;
                 }
                 action("Contr on definitely w/o prob")
                 {
                     Caption = 'Contr on definitely w/o prob';
                     Image = "Report";
                     RunObject = Report 99000788;
                     Visible = false;
                 }
                 action("Contract on indef new employer with probation")
                 {
                     Caption = 'Contract on indef new employer with probation';
                     Image = "Report";
                     RunObject = Report 99003805;
                     Visible = false;
                 }
                 action("Anex change of salary and competitiveness clauses")
                 {
                     Caption = 'RS Anex change of salary and competitiveness clauses';
                     Image = "report";
                     RunObject = Report "Anex Contract -r";
                     Visible = false;
                 }
                 action("Contract on definitely new employer with probation")
                 {
                     Caption = 'Contract on definitely new employer with probation';
                     Image = "Report";
                     RunObject = Report "test";
                     Visible = false;
                 }
                 action("Cont on definitely w p")
                 {
                     Caption = 'Cont on definitely w p';
                     Image = "Report";
                     RunObject = Report 99001015;
                     Visible = false;
                 }
                 action("Custom report layouts")
                 {
                     Caption = 'Custom report layouts';
                     Image = Agreement;
                     RunObject = Page 9650;
                     Visible = true;
                 }*/

            }

            group("General Reports2")
            {
                Caption = 'General Reports';
                Image = Marketing;
                /*  action("Employee list")
                  {
                      Caption = 'Employee list';
                      Image = "Report";
                      RunObject = Report 99000783;
                  }
                  action("Birth information")
                  {
                      Caption = 'Birth information';
                      Image = "Report";
                      RunObject = Report 99000786;
                  }
                  action("Education Structure 2")
                  {
                      Caption = 'Education Structure 2';
                      Image = "Report";
                      RunObject = Report "Education Structure 2";
                  }
                  action("Employees By Department")
                  {
                      Caption = 'Employees By Department';
                      Image = "Report";
                      RunObject = Report "Employees By Department";
                  }
                  action("List of disabled people")
                  {
                      Caption = 'List of disabled people';
                      Image = "Report";
                      RunObject = Report 99000766;
                  }
                  action("Addresses and contacts")
                  {
                      Caption = 'Addresses and contacts';
                      Image = "Report";
                      RunObject = Report 99000767;
                  }
                  action("Family relatives")
                  {
                      Caption = 'Family relatives';
                  }
                  action("Employee Contract Ledger rep")
                  {
                      Caption = 'Employee Contract Ledger rep';
                      Image = "Report";
                      RunObject = Report 99000780;
                  }
                  action("Ending employment rel")
                  {
                      Caption = 'Ending employment rel';
                      Image = "Report";
                      RunObject = Report 110;
                  }
                  action("Establishing employment rel")
                  {
                      Caption = 'Establishing employment rel';
                      RunObject = Report 506;
                  }
                  action(Qualifications)
                  {
                      Caption = 'Qualifications';
                      Image = "Report";
                      RunObject = Report 99000763;
                  }
                  action("Age structure")
                  {
                      Caption = 'Age structure';
                      Image = "Report";
                      RunObject = Report 5500;
                  }
                  action("Work experience")
                  {
                      Caption = 'Work experience';
                      Image = "Report";
                      RunObject = Report 5213;
                  }
                  action("Additional Receivings")
                  {
                      Caption = 'Additional Receivings';
                      Image = "Report";
                      RunObject = Report 99000757;
                  }
                  action("Total Staff")
                  {
                      Caption = 'Total Staff';
                      Image = "Report";
                      RunObject = Report "picture_import";
                  }*/

            }

            group("Training Reports2")
            {
                Caption = 'Training Reports';
                Image = RegisteredDocs;


            }

            group(Analysis2)
            {
                Caption = 'Analysis';
                //ĐK  Image = Analysis;
            }

            /* action("Wages per department")
            {
                Caption = 'Wages per department';
                Image = JobLedger;
                Promoted = false;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "picture_import";
                Visible = false;
            }
            action("Employees per department")
            {
                Caption = 'Employees per department';
                Image = JobLedger;
                Promoted = false;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Training Import";
                Visible = false;
            }
            action("Gender structure")
            {
                Caption = 'Gender structure';
                Image = JobLedger;
                Promoted = false;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                RunObject = Report "Education Structure";
                Visible = false;
            }
            action("Budget by Dimensions")
            {
                Caption = 'Budget by Dimensions';
                Image = BankAccount;
                RunObject = Report "Employees By Department";
                Visible = false;
            }*/

            group(Forms22)
            {
                Caption = 'Forms';
                Image = "Report";



            }





            group("Module Budget")
            {
                Caption = 'Module Budget';
                Visible = false;
                action(budget)
                {
                    ApplicationArea = all;
                    Caption = 'Export GPS';
                    Image = "Table";
                    RunObject = Page "G/L Budget Names";
                }
            }
        }
    }

    var
        PageEmployeeAbsences: Page "Employee Absences";
        UserPersonalisation: Record "User Personalization";
        IsVisible: Boolean;
        ECL: Record "Employee Contract Ledger";
        show: Boolean;
}

