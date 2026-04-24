page 50066 "HR activities"
{
    // 

    PageType = CardPart;
    SourceTable = "Payroll Cue";
    UsageCategory = Lists;
    ApplicationArea = all;
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
            cuegroup(Employees2)
            {
                Caption = 'Employees';


                field("New Employees"; "New Employees_HRCUE")
                {
                    ApplicationArea = all;
                    Image = People;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = ProfileID = 'TRAINING MANAGER';
                }
                field(Employees; Employees_HRCUE)
                {
                    ApplicationArea = all;
                    Caption = 'Employees';

                    Importance = Promoted;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                }
                field("Active Employees"; "Active Employees _HRCUE")
                {
                    ApplicationArea = all;

                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Potential Employees"; "Potential Employees_HRCUE")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("On Boarding"; "On Boarding_HRCUE")
                {
                    Caption = 'On Boarding';
                    Importance = Additional;
                    Visible = true;
                    ApplicationArea = all;
                }
            }
            cuegroup("Absence")
            {
                Caption = 'Absence';


                field("Inactive Employees"; "Inactive Employees_HRCUE")
                {
                    Caption = 'Inactive Employees';
                    Image = People;
                    Importance = Additional;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Inactive - Terminated"; "Inactive - Terminated_HRCUE")
                {
                    Image = People;
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                //"Terminated  Unpaid Employees_HRCUE"
                field("Terminated  Unpaid Employees"; "Terminated  Unpaid E_HRCUE")
                {
                    Importance = Additional;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }

            }


            cuegroup(Employees3)
            {
                Caption = 'External Employee';

                field(Practicians; Practicians_HRCUE)
                {
                    Image = People;
                    Importance = Promoted;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }



                field("Temporary Contract"; "Temporary Contract_HRCUE")
                {
                    Image = People;
                    ApplicationArea = all;



                }
                field(Volonteer; Volonteer_HRCUE)
                {
                    Image = People;
                    ApplicationArea = all;
                }


            }




            cuegroup(Warnings)
            {

                Caption = 'Warnings';
                Visible = ProfileID <> 'TRAINING MANAGER';

                field("Three Years In Company"; "Three Years In Company_HRCUE")
                {
                    Caption = 'Employees reaching out 3 years in SBBH';
                    Image = Calendar;
                    Style = Attention;
                    StyleExpr = true;
                    ApplicationArea = all;
                }
                field("Expiring Contracts"; "Expiring Contracts_HRCUE")
                {
                    Image = Receipt;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Expired Contracts"; "Expired Contracts_HRCUE")
                {
                    ApplicationArea = all;
                }
            }
            cuegroup(Probation)
            {
                Caption = 'Probation';
                Visible = ProfileID <> 'TRAINING MANAGER';

                field("Employees on Probation"; "Employees on Probation_HRCUE")
                {
                    Image = Diagnostic;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                //"Probation Expires in NextPerio_HRCUE"
                field("Probation Expires in NextPerio"; "Probation Expires NP_HRCUE")
                {
                    Caption = 'Probation Expires in Next Period';
                    Image = Diagnostic;
                    Style = Ambiguous;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Probation expired"; "Probation expired_HRCUE")
                {
                    Image = Diagnostic;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }


            }
            cuegroup("Unsegmented Positions1")
            {
                Caption = 'Unsegmented Positions';
                Visible = false;


                field("Unsegmented Positions"; "Unsegmented Positions_HRCUE")
                {
                    Visible = show;
                    ApplicationArea = all;
                }

            }
            cuegroup(Information)
            {
                Caption = 'Information';
                Visible = show;

                field("For Calculation"; "For Calculation_HRCUE")
                {

                    Visible = false;
                    ApplicationArea = all;
                }
                field(Calculated; Calculated_HRCUE)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("New Employees FC"; "New Employees FC_HRCUE")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Terminated Employees"; "Terminated Employees_HRCUE")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Visible = show;
                    ApplicationArea = all;
                }
                field(Transfers; Transfers_HRCUE)
                {
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change_HRCUE")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Temporary Disposition"; "Temporary Disposition_HRCUE")
                {
                    LookupPageID = "Employee Contract Ledger";
                    ApplicationArea = all;
                }
                field("Employees on call"; "Employees on call_HRCUE")
                {
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Attention;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;

                }

            }
            cuegroup("Changes")
            {
                Caption = 'Changes';
                Visible = show;

                field("Surname Change"; "Surname Change_HRCUE")
                {
                    Image = Checklist;
                    Importance = Additional;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Adress Change"; "Adress Change_HRCUE")
                {
                    Image = Checklist;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Education Level Change"; "Education Level Change_HRCUE")
                {
                    Image = Library;
                    Importance = Promoted;
                    Style = AttentionAccent;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
            }
            cuegroup("Fund")
            {

                Caption = 'Fund or Union Employees';


                field("Internal Fund"; "Internal Fund_HRCUE")
                {
                    Visible = show;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //Đ.K.
                    end;
                }
                field("External Fund"; "External Fund_HRCUE")
                {
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Union Employees"; "Union Employees_HRCUE")
                {
                    Visible = show;
                    ApplicationArea = all;
                }

            }


            /*  cuegroup("Potential Employees1")
              {
                  Caption = 'Potential Employees2';
                  Visible = false;


                  field("Invited to Interview"; "Invited to Interview")
                  {
                      ApplicationArea = all;
                  }
                  field("Appropriate Candidates"; "Appropriate Candidates")
                  {
                      ApplicationArea = all;
                  }
                  field("Inappropriate Candidates"; "Inappropriate Candidates")
                  {
                      ApplicationArea = all;
                  }


              }*/
            cuegroup(Trainings1)
            {
                Caption = 'Trainings';
                Visible = show;


                /*field("Education And Development"; "Education And Development")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }*/

                field("Training Catalogue"; "Training Catalogue_HRCUE")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Training Entry"; "Training Entry_HRCUE")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Employee Training Ledger"; "Employee Training Ledger_HRCUE")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;

                }
            }
            cuegroup("Expiring Training")
            {
                Caption = 'Expiring Training';
                field(Training; Training_HRCUE)
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Expired Training"; "Expired Training_HRCUE")
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;

                }
            }

            cuegroup("Expiring Certification")
            {
                Caption = 'Expiring Certification';

                field(Certification; Certification_HRCUE)
                {
                    Image = Receipt;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = show;
                    ApplicationArea = all;
                }
                field("Certification Expired"; "Certification Expired_HRCUE")
                { }
            }


            cuegroup(Reminders)
            {
                Caption = 'Opomene';
                field("All Reminders"; "All Reminders")
                {
                    Caption = 'Sve opomene';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("No.", '<>%1', '');
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Printed Reminders"; "Printed Reminders")
                {
                    Caption = 'Isprintane opomene';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("Reminder Printed", '%1', true);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Sent Reminders"; "Sent Reminders")
                {
                    Caption = 'Poslane opomene';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("Reminder Sent", '%1', true);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("New Reminders"; "New Reminders")
                {
                    Caption = 'Potencijalna utuženja';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("Created From Reminder", '%1', false);
                        Reminder.SetRange("Document Date", Today + 10, DMY2Date(31, 12, 2040));
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Household"; "Household")
                {
                    Caption = 'Domaćinstvo';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("CustomerCategory", '%1', Category::Household);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Large Economy"; "Large Economy")
                {
                    Caption = 'Velika privreda';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("CustomerCategory", '%1', Category::"Large Economy");
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Small Economy"; "Small Economy")
                {
                    Caption = 'Mala privreda';
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetFilter("CustomerCategory", '%1', Category::"Small Economy");
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
                field("Reminders for 300D-330D"; "Reminders for 300D-330D")
                {
                    Image = Diagnostic;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Reminders for over 330D"; "Reminders for over 330D")
                {
                    Image = Diagnostic;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
            }

            cuegroup(Accusations)
            {
                Caption = 'Accusations';
                field("All Accusations"; "All Accusations")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("No.", '<>%1', '');
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;
                }

                field("Before the Limitation"; "Before the Limitation")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetRange("Statue of Limitation Date", Today - 10, Today);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;


                }


                field("Reprogram"; "Reprogram")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Reprogrammed Debt", '%1', true);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;


                }
                field("Criminal"; "Criminal Proceedings")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Criminal proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;
                }
                field("Executive"; "Executive Proceedings")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Executive Procedure");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;

                }
                field("Litigation"; "Litigation Proceedings")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Litigation Proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;
                }
                field("Before the end of the court term"; "Before the end of the court term")
                {
                    Image = Diagnostic;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }

            }

            cuegroup(Acc)
            {
                Caption = 'Acc by Category';
                field(ACHold; "AC - Household")
                {
                    Caption = 'AC - Household';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::"HouseHold");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }
                field(AcLarge; "AC - Large Economy")
                {
                    Caption = 'AC - Large economy';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::"Large Economy");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }
                field(ACSmall; "AC - Small Economy")
                {
                    Caption = 'AC - small economy';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::"Small Economy");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }
                field(ACKJKP; "AC - KJKP Heating plant")
                {
                    Caption = 'AC - KJKP Heating plant';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::"KJKP Heating plant");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }


                field(ACSpecial; "AC - Special Customer")
                {
                    Caption = 'AC - Special Customer';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::"Special Customer");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }
                field(ACCNg; "AC - CNG")
                {
                    Caption = 'AC - CNG';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::CNG);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }

                field("AC - Resource"; "AC - Resource")
                {
                    Caption = 'AC - Resource';


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin

                        accusations.Reset();
                        accusations.SetFilter(Archive, '%1', false);
                        accusations.setfilter("Bill Category", '%1', accusations."Bill Category"::Resource);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;


                }
            }



            /* cuegroup(Postings)
             {
                 Caption = 'Postings';

                 field(OpenPostingAll; OpenPostingAll)
                 {
                     ApplicationArea = all;
                 }
                 field(OpenPostingInternal; OpenPostingInternal)
                 {
                 }
                 field(OpenPostingExternal; OpenPostingExternal)
                 {
                     ApplicationArea = all;
                 }
                 field(OpenPostingBase; OpenPostingBase)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPostingCompleted; ClosedPostingCompleted)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPostingNoChoice; ClosedPostingNoChoice)
                 {
                     ApplicationArea = all;
                 }
                 field(ClosedPosting; ClosedPosting)
                 {xd
                     ApplicationArea = all;
                 }
             }
               cuegroup(Candidates)
                {
                    Caption = 'Candidates';

                    field(CandidatesGFSarajevo; CandidatesGFSarajevo)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFZenica; CandidatesGFZenica)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFBanjaLuka; CandidatesGFBanjaLuka)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFMostar; CandidatesGFMostar)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFTuzla; CandidatesGFTuzla)
                    {
                        ApplicationArea = all;
                    }
                    field(CandidatesGFBihac; CandidatesGFBihac)
                    {
                        ApplicationArea = all;
                    }
                }
                cuegroup("L")
                {
                    Caption = '';


                    field(EconomicProfileLastYear; EconomicProfileLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(EconomicProfileThisYear; EconomicProfileThisYear)
                    {
                        ApplicationArea = all;
                    }
                    field(LawFacultyLastYear; LawFacultyLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(LawFacultyThisYear; LawFacultyThisYear)
                    {
                        ApplicationArea = all;
                    }
                    field(ElectricalLastYear; ElectricalLastYear)
                    {
                        ApplicationArea = all;
                    }
                    field(ElectricalThisYear; ElectricalThisYear)
                    {
                        ApplicationArea = all;
                    }
                */
            /* cuegroup("Disciplinary Measures")
             {
                 Caption = 'Disciplinary Measures';
                 Visible = show;

                 field("Active Measures"; "Active Measures")
                 {
                     ApplicationArea = all;
                 }
                 field("Expirings Measures"; "Expirings Measures")
                 {
                     ApplicationArea = all;
                 }

                 actions
                 {
                     action("<Page Training Catalogue11>")
                     {
                         Caption = 'NewEmployee99';
                         RunObject = Page "Employee Card";
                         RunPageMode = Create;
                     }

                 }
             }*/

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    var

        accusations: record "Accusation Line";
        AQ: Query "Accusation Count";
    begin

        HRsetup.GET;
        Date := 20010101D;
        Date2 := CALCDATE(HRsetup."Probation Expire Days", TODAY);
        Date3 := 20991231D;
        Date10 := CALCDATE(HRsetup."Expiry period (contracts)", TODAY);
        Date11 := CALCDATE('-30D', TODAY);
        Date4 := CALCDATE('-' + FORMAT(HRsetup."Reaching years in company"), CALCDATE(HRsetup."Warning Period", TODAY));
        //DateFilter:=0D;
        //MESSAGE(FORMAT(DateFIlter2));
        SETRANGE(DateFIlter_HRCUE, TODAY, Date2);
        SETRANGE(DateFilter2, Date, TODAY);
        SETRANGE(DateFilter3_HRCUE, TODAY, Date3);
        SETRANGE(DateFilter10_HRCUE, TODAY, Date10);
        SETRANGE(DateFilter11_HRCUE, Date11, TODAY);
        SetRange("Date Filter 2", CALCDATE('<+10D>', WorkDate), DMY2Date(31, 12, 2040));
        SetRange("Date Filter 3", CALCDATE('<-10D>', WorkDate), WorkDate());


        SETRANGE(DateFilter4_HRCUE, CALCDATE('-' + FORMAT(HRsetup."Reaching years in company"), TODAY), Date4);
        SETRANGE(DateFilter5_HRCUE, CALCDATE('-' + FORMAT(HRsetup."New employee period"), TODAY), TODAY);
        SETRANGE(DateFilter12_HRCUE, Date, TODAY);
        SETRANGE("Expirings Measures F_HRCUE", CALCDATE('<-3D>', TODAY), TODAY);
        SETRANGE(LastYearFilter_HRCUE, DMY2DATE(1, 1, DATE2DMY(TODAY, 3) - 1), DMY2DATE(31, 12, DATE2DMY(TODAY, 3) - 1));
        SETRANGE(ThisYearFilter_HRCUE, DMY2DATE(1, 1, DATE2DMY(TODAY, 3)), DMY2DATE(31, 12, DATE2DMY(TODAY, 3)));
        SetRange(DateTraining_HRCUE, today, CalcDate('<+30D>', Today));
        SetRange(DateTraining2_HRCUE, CalcDate('<-30D>', Today), calcdate('<-1D>', Today));
        SetRange(DateCatalogue_HRCUE, CalcDate('<-30D>', Today), Today);
        SetRange(FromDate_HRCUE, CalcDate('<-30D>', Today), CalcDate('<+30D>', Today));
        SetRange(ExpirationDate_Hearing, Today, CalcDate('<+5D>', Today));
        SetRange(Reminders_for_300D, CalcDate('<-10M>', Today), today);
        SetRange(Reminders_over_330D, CalcDate('<-11M>', Today), today);



        UP.SETFILTER("User ID", '%1', USERID);
        IF UP.FINDFIRST THEN
            ProfileID := UP."Profile ID";
        DateTraining := CALCDATE(HRsetup."Legal Training Expire Days", TODAY);
        SETRANGE(DateFilterTraining_HRCUE, TODAY, DateTraining);

        if GlobalLanguage = 1033 then
            ThisMonthFirst := CALCDATE('-CM', WORKDATE)
        else
            ThisMonthFirst := CALCDATE('-SM', WORKDATE);


        if GlobalLanguage = 1033 then
            ThisMonthLast := CALCDATE('CM', WORKDATE)
        else
            ThisMonthLast := CALCDATE('SM', ThisMonthFirst);
        NextMonthFirst := CALCDATE('+1D', ThisMonthLast);


        if GlobalLanguage = 1033 then
            NextMonthLast := CALCDATE('CM', NextMonthFirst)
        else
            NextMonthLast := CALCDATE('SM', NextMonthFirst);



        if GlobalLanguage = 1033 then
            DBThisMonthLast := CALCDATE('CM-1D', NextMonthFirst)
        else
            DBThisMonthLast := CALCDATE('SM-1D', ThisMonthFirst);


        if GlobalLanguage = 1033 then
            DBThisMonthFirst := CALCDATE('-CM-1D', WORKDATE)
        else
            DBThisMonthFirst := CALCDATE('-SM-1D', WORKDATE);




        //  DBThisMonthFirst := CALCDATE('-SM-1D;', WORKDATE);
        SETRANGE(DateFilter6_HRCUE, ThisMonthFirst, ThisMonthLast);
        SETRANGE(DateFilter7_HRCUE, ThisMonthFirst, DBThisMonthLast);
        SETRANGE(DateFilter8_HRCUE, 0D, DBThisMonthFirst);
        SETRANGE(DateFilter9_HRCUE, CALCDATE('+1D;', ThisMonthFirst), ThisMonthLast);

        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" <> 'LEGAL' THEN
                show := TRUE
            ELSE
                show := FALSE;
        END;

        UserPersonalisation2.RESET;
        UserPersonalisation2.SETFILTER("User ID", USERID);
        IF UserPersonalisation2.FINDFIRST THEN BEGIN
            IF UserPersonalisation2."Profile ID" <> 'HR READ' THEN BEGIN





                /*
                ECLHO.SETFILTER("Ending Date",'%1',CALCDATE('-1D',WORKDATE));
                IF ECLHO.FIND('-') THEN BEGIN
                    HeadOfRefresh.SETFILTER("ORG Shema",'%1',ECLHO."Org. Structure");
                    HeadOfRefresh.SETFILTER("Position Code",'%1',ECLHO."Position Code");
                   IF HeadOfRefresh.FINDLAST THEN BEGIN
                   REPORT.RUNMODAL(50050,FALSE,TRUE);
                 //   REPORT.RUNMODAL(19,FALSE,TRUE);

                     END;*/
            END;

            OrgShema.RESET;
            OrgShema.SETFILTER(Status, '%1', 0);
            IF OrgShema.FINDLAST THEN BEGIN
                "Active Sistematizaction_HRCUE" := OrgShema.Code;
                SETFILTER("Active Sistematizaction_HRCUE", OrgShema.Code);
            END
            ELSE BEGIN
                "Active Sistematizaction_HRCUE" := '';
            END;

            //    accusations.Reset();
            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 7);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACResource := aq.count;

                end;

            end;
            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 6);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACCNg := aq.count;

                end;

            end;

            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 1);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACHold := aq.count;

                end;

            end;

            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 2);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACLarge := aq.count;

                end;

            end;

            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 3);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACSmall := aq.count;

                end;

            end;

            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 4);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACKJKP := aq.count;

                end;

            end;

            AQ.SetFilter(Archived, '%1', false);
            AQ.setfilter(Bill_Category, '%1', 5);

            if AQ.Open() then begin
                while AQ.Read() do begin
                    ACSpecial := aq.count;

                end;

            end;

            /*
            ECLHO2.SETFILTER("Starting Date",'%1',CALCDATE('0D',WORKDATE));
            IF ECLHO2.FIND('-') THEN BEGIN
                HeadOfRefresh2.SETFILTER("ORG Shema",'%1',ECLHO2."Org. Structure");
                HeadOfRefresh2.SETFILTER("Position Code",'%1',ECLHO2."Position Code");
               IF HeadOfRefresh2.FINDLAST THEN BEGIN
               REPORT.RUNMODAL(50050,FALSE,TRUE);
               REPORT.RUNMODAL(19,FALSE,TRUE);
                 END;
              END;*/




            //STATUS UPDATE
            /*ECL2.SETFILTER(Active,'%1',TRUE);
            ECL2.SETFILTER("Reason for Change",'%1',ECL2."Reason for Change"::"New Contract");
            ECL2.SETFILTER("Starting Date",'%1',TODAY);
            IF ECL2.FIND('-') THEN REPEAT

              Employee2.SETFILTER("No.",'%1',ECL2."Employee No.");
              Employee2.SETFILTER(Status,'<>%1',Employee2.Status::Active);
              IF Employee2.FIND('-') THEN
                BEGIN
                  IF Employee2.Status<4 THEN
                  Employee2.Status:=Employee2.Status::Active
                  ELSE
                  Employee2."External employer Status":=Employee2."External employer Status"::Active;
                  Employee2.MODIFY;

                END;

            UNTIL ECL2.NEXT=0;
            */
            //NAPISATI ISPOD ECL
            /*EmployeeContractLedger2.RESET;
            EmployeeContractLedger2.SETFILTER("Grounds for Term. Code",'<>%1','');
            IF EmployeeContractLedger2.FINDSET THEN REPEAT
              EmployeeContractLedger.RESET;
              EmployeeContractLedger.SETFILTER("Employee No.",'%1',EmployeeContractLedger2."Employee No.");
              EmployeeContractLedger.SETFILTER("No.",'>%1',EmployeeContractLedger2."No.");
              EmployeeContractLedger.SETFILTER("Starting Date",'<=%1',WORKDATE);
              IF EmployeeContractLedger.FINDFIRST THEN BEGIN
                EmployeeContractLedger2.Active:=FALSE;
                EmployeeContractLedger2.MODIFY;
            IF EmployeeContractLedger."Starting Date" <=WORKDATE THEN BEGIN
               Employee.RESET;
                  Employee.SETFILTER("No.",'%1',EmployeeContractLedger2."Employee No.");
              IF Employee.FIND('-') THEN BEGIN

                  IF Employee.StatusExt=Employee.Status::Terminated   THEN BEGIN
                  Employee.StatusExt:=Employee.Status::Active;
                  Employee.MODIFY;
                   END;
                END;
               EmployeeContractLedger.VALIDATE("Starting Date",WORKDATE);
              EmployeeContractLedger. MODIFY(TRUE);
              END;
               END

             ELSE BEGIN
               IF EmployeeContractLedger2."Ending Date"<=WORKDATE THEN BEGIN
               EmployeeContractLedger2.VALIDATE("Grounds for Term. Code",EmployeeContractLedger2."Grounds for Term. Code");
               EmployeeContractLedger2.MODIFY;
               END;
                //END;

                END;



            UNTIL EmployeeContractLedger2.NEXT=0;*/

            /* //STATUS UPDATE
            ECLOrg9.RESET;
            ECLOrg9.SETFILTER("Org. Structure",'%1',OrgShema.Code);
            ECLOrg9.SETFILTER("Show Record",'%1',TRUE);
            ECLOrg9.SETFILTER("Position Description",'<>%1','');
            ECLOrg9.SETFILTER("Starting Date",'%1',CALCDATE('<-1D>',WORKDATE));
            IF ECLOrg9.FINDSET THEN BEGIN
                 REPORT.RUNMODAL(213,FALSE,FALSE,ECLOrg9);
                COMMIT;
             END;*/



        END;
    END;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        AQ: Query "Accusation Count";
    begin


        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 7);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACResource := aq.count;

            end;

        end;
        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 6);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACCNg := aq.count;

            end;

        end;

        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 1);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACHold := aq.count;

            end;

        end;

        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 2);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACLarge := aq.count;

            end;

        end;

        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 3);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACSmall := aq.count;

            end;

        end;

        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 4);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACKJKP := aq.count;

            end;

        end;

        AQ.SetFilter(Archived, '%1', false);
        AQ.setfilter(Bill_Category, '%1', 5);

        if AQ.Open() then begin
            while AQ.Read() do begin
                ACSpecial := aq.count;

            end;

        end;

    end;


    var
        UserPersonalisation2: Record "User Personalization";
        show: Boolean;
        UserPersonalisation: Record "User Personalization";
        ECLHO: Record "Employee Contract Ledger";
        HeadOfRefresh: Record "Head Of's";
        ECLHO2: Record "Employee Contract Ledger";
        HeadOfRefresh2: Record "Head Of's";
        Date: Date;
        Date2: Date;
        Date3: Date;
        Date4: Date;
        HRsetup: Record "Human Resources Setup";
        UP: Record "User Personalization";
        ProfileID: Text;
        DateTraining: Date;
        ThisMonthFirst: Date;
        ThisMonthLast: Date;
        NextMonthFirst: Date;
        NextMonthLast: Date;
        DBThisMonthLast: Date;
        DBThisMonthFirst: Date;
        Date10: Date;
        Date11: Date;
        ECL: Record "Employee Contract Ledger";
        Employee: Record "Employee";
        ECL2: Record "Employee Contract Ledger";
        Employee2: Record "Employee";
        OrgShema: Record "ORG Shema";
        SistematizationCode: Code[10];
        OrgShema1: Record "ORG Shema";
        OrgShema2: Record "ORG Shema";
        SectorTemp: Record "Sector temporary";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        DepCatTemp: Record "Department Category temporary";
        GroupOrginal: Record "Group";
        GroupTemp: Record "Group temporary";
        //    TeamOrginal: Record "TeamT";
        TeamTemp: Record "Team temporary";
        DepartmentOrginal: Record "Department";
        ACHold: Integer;
        ACSmall: Integer;
        AcLarge: Integer;
        ACKJKP: Integer;
        ACSpecial: Integer;
        ACCNg: Integer;
        ACResource: Integer;
        DepartmentTemp: Record "Department temporary";
        HeadOfOrginal: Record "Head Of's";
        HeadOfTemp: Record "Head Of's temporary";
        DimensionOrginalPos: Record "Dimension for position";
        DimensionTempPos: Record "Dimension temp for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuTemp: Record "Position Menu temporary";
        PositionMenuOrginal: Record "Position Menu";
        ECLOrg11: Record "Employee Contract Ledger";
        PositionMenuOrginal1: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        ECLSyst: Record "ECL systematization";
        ECLOrg: Record "Employee Contract Ledger";
        PoSMenDUp: Record "Position Menu";
        Brojac: Integer;
        ECLSis: Record "ECL systematization";
        Novi: Integer;
        PositionIDFind: Record "Position";
        DimensionForPos: Record "Dimension for position";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        ECLBefore: Record "Employee Contract Ledger";
        OrgShemaA: Record "ORG Shema";
        //   ReportNotification: Report "Systematization e-mail";
        SectorOrginal1: Record "Sector";
        DepCatOrginal1: Record "Department Category";
        GroupOrginal1: Record "Group";
        TeamOrginal1: Record "TeamT";
        DepartmentOrginal1: Record "Department";
        HeadOfOrginal1: Record "Head Of's";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsOrginal1: Record "Position Benefits";
        ECLOrg1: Record "Employee Contract Ledger";
        PositionBenef: Record "Position Benefits";
        MAIS: Record "Misc. article information";
        MAI1: Record "Misc. article information";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        DepartmentCodeForpos: Code[30];
        ORGDijelovi: Record "Org Dijelovi";
        // ECLSYSEmail: Report "Systematization e-mail";
        ECLForEmail: Record "Employee Contract Ledger";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        WorkBooklet: Record "Work Booklet";
        EmployeeContractChangeOrgRename: Record "Employee Contract Ledger";
        EmployeeContractChangeOrg: Record "Employee Contract Ledger";
        CheckConflict: Record "Employee Contract Ledger";
        BR: Record "Employee Contract Ledger";
        ECLSYSTChangeBR: Record "ECL systematization";
        ECLCheck: Record "Employee Contract Ledger";
        ECLOrg8: Record "Employee Contract Ledger";
        ECLOrg9: Record "Employee Contract Ledger";
    //       WDV: Record "Work Duties Violation";
}

