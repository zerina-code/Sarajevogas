page 50163 "Work booklet"
{
    AutoSplitKey = false;
    Caption = 'Work booklet';
    //ĐK DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    InsertAllowed = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Work Booklet";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Contract No."; "Contract No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Work Booklet No."; "Work Booklet No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Serial No."; "Serial No.")
                {
                    ApplicationArea = all;
                }
                field("Work Experience Document"; "Work Experience Document")
                {
                    ApplicationArea = all;
                }
                field("Old PIO No."; "Old PIO No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee ID"; "Employee ID")
                {
                    ApplicationArea = all;
                }

                field("Employee First Name"; "Employee First Name")
                {
                    ApplicationArea = all;
                }
                field("Employee Last Name"; "Employee Last Name")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF "Current Company" = FALSE THEN
                            enable := TRUE;
                    end;
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //CurrPage.UPDATE(TRUE);
                    end;
                }
                field(Employer; Employer)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Current Company"; "Current Company")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        IF "Current Company" = FALSE THEN BEGIN
                            enable := TRUE;
                            CLEAR(Employer);
                            //Rec.MODIFY;
                            CurrPage.UPDATE(TRUE);
                        END
                        ELSE BEGIN
                            t_CompInfo.GET;
                            Employer := t_CompInfo.Name;
                            enable := FALSE;
                            //Rec.MODIFY;
                            CurrPage.UPDATE(TRUE);

                        END;
                    end;
                }
                //BH 01 start

                field("Military service"; "Military service")
                {
                    ApplicationArea = all;


                }
                //BH 01 end
                field(Coefficient; Coefficient)
                {
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Years; Years)
                {
                    ApplicationArea = all;
                }
                field(Months; Months)
                {
                    ApplicationArea = all;
                }
                field(Days; Days)
                {
                    ApplicationArea = all;
                }
                field("Hours change"; "Hours change")
                {
                    ApplicationArea = all;
                }
                field("Team Name"; "Team Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = all;
                }

                field("Contract Ledger Entry No."; "Contract Ledger Entry No.")
                {
                    ApplicationArea = all;
                    Editable = true;
                    Visible = false;
                }
                field("Is dekra"; "Is dekra")
                {
                    ApplicationArea = all;
                    Caption = 'Is dekra';
                    Visible = false;
                }
                field("Is not dekra"; "Is not dekra")
                {
                    ApplicationArea = all;
                    Caption = 'Is not dekra';
                    Visible = false;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        /*nk R_BroughtExperience.RUN;
        R_WorkExperience.SetEndingDate(TODAY);
        R_WorkExperience.RUN;*/
        SETCURRENTKEY("Starting Date");
        ASCENDING(FALSE);

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        enable := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //HR01 start

        /*  FOR "Contract No.":=0 TO 1000 DO BEGIN
        IF "Current Company"=TRUE THEN
          "End Date":=TODAY;
        END;*/
        //HR01 end
        SETCURRENTKEY("Starting Date");
        ASCENDING(FALSE);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        R_BroughtExperience.SetEmp(Rec."Employee No.");
        R_BroughtExperience.RUN;
        CALCFIELDS(Status);
        IF (Rec.Status = Rec.Status::Active) THEN BEGIN

            R_WorkExperience.SetEmp("Employee No.", TODAY);
            R_WorkExperience.RUN;
            SETCURRENTKEY("Starting Date");
            ASCENDING(FALSE);
        END
        ELSE BEGIN
            Employee2.RESET;
            Employee2.SETFILTER("No.", '%1', Rec."Employee No.");
            Employee2.SETFILTER("External employer Status", '%1', Employee2."External employer Status"::Active);
            IF Employee2.FINDFIRST THEN BEGIN
                R_WorkExperience.SetEmp("Employee No.", TODAY);
                R_WorkExperience.RUN;
                SETCURRENTKEY("Starting Date");
                ASCENDING(FALSE);
            END;
        END;
    END;




    var
        t_CompInfo: Record "Company Information";
        enable: Boolean;
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        ECL: Record "Employee Contract Ledger";
        WB: Record "Work Booklet";
        IMA: Boolean;
        ECL2: Record "Employee Contract Ledger";
        Employee2: Record "Employee";
        UserPersonalization: Record "User Personalization";
        Edit: Boolean;
}

