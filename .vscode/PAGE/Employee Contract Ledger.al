page 50051 "Employee Contract Ledger"
{
    Caption = 'Employee Contract Ledger';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Employee Contract Ledger";
    SourceTableView = WHERE("Show Record" = FILTER(true));
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group3)
            {
                Editable = true;
                Enabled = true;
                field("No."; "No.")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(Contract; Contract)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Operator No."; "Operator No.")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Internal ID"; "Internal ID")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Reason for Change"; "Reason for Change")
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Wage Change"; "Wage Change")
                {
                    BlankZero = true;

                    ApplicationArea = all;
                }
                /*      field("Contract Phase"; "Contract Phase")
                      {
                          BlankZero = true;
                          Editable = false;
                          Importance = Promoted;
                          ShowMandatory = true;
                          Style = Unfavorable;
                          StyleExpr = TRUE;
                          Visible = true;
                          ApplicationArea = all;
                      }
                      field("Contract Phase Time"; "Contract Phase Time")
                      {
                          Visible = IsVisible;
                          ApplicationArea = all;
                      }
                      field("Contract Phase Date"; "Contract Phase Date")
                      {
                          Visible = IsVisible;
                          ApplicationArea = all;
                      }*/
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field(Team; Team)
                {

                    Editable = false;
                    Enabled = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("<Team Description>"; "Team Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                    Visible = false;
                }

                field("Group Description"; "Group Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("<Group>"; Group)
                {

                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }

                field("Department Cat. Description"; "Department Cat. Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    Editable = false;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }

                field("Sector Description"; "Sector Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    Editable = false;
                    Enabled = true;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Department Name"; "Department Name")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Org Dio"; "Org Dio")
                {
                    //  BlankZero = true;
                    ShowMandatory = true;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department City"; "Department City")
                {
                    Visible = false;
                    ApplicationArea = all;
                }

                field("Org Unit Name"; "Org Unit Name")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;
                    Visible = false;


                }

                field("Phisical Department Desc"; "Phisical Department Desc")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }


                field("Org Entity Code"; "Org Entity Code")
                {

                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field(Canton; Canton)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Org Municipality"; "Org Municipality")
                {

                    Visible = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Org Municipality of ag"; "Org Municipality of ag")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field("Municipality Name"; "Municipality Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Department Address"; "Department Address")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }

                field("<Position Description>"; "Position Description")
                {

                    ShowMandatory = true;
                    ApplicationArea = all;


                }
                field("Position complexity"; "Position complexity")
                {
                    ApplicationArea = all;

                }
                field("Position Responsibility"; "Position Responsibility")
                {
                    ApplicationArea = all;
                }
                field("Workplace conditions"; "Workplace conditions")
                {
                    ApplicationArea = all;
                }
                field("Increment"; "Increment") { ApplicationArea = all; }
                field("Position Coefficient for Wage"; "Position Coefficient for Wage")
                {
                    ApplicationArea = all;
                }
                field(School; School)
                {
                    ApplicationArea = all;
                }
                field("Employee Education Level"; "Employee Education Level")
                {
                    ApplicationArea = all;
                }



                field("Place of work"; "Place of work")
                {
                    ApplicationArea = all;
                }

                field("Starting Date"; "Starting Date")
                {
                    NotBlank = true;
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Ending Date"; "Ending Date")
                {

                    ApplicationArea = all;
                }
                field("Contract Number"; "Contract Number")
                {
                    ApplicationArea = all;
                }
                field("Type of Engagement"; "Type of engagement")
                {
                    ApplicationArea = All;
                    TableRelation = TypeOfEngagement.Code;

                }
                field("Type of Engagement Description"; "Type of engagement Description")
                {
                    ApplicationArea = All;
                    Editable = False;


                }
                field("Contract Type"; "Contract Type")
                {

                    ApplicationArea = all;
                    ShowMandatory = true;
                    //ovdje dodati da se čita
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        PageEC: page "Employment Contracts";
                        EC: Record "Employment Contract";
                    begin
                        Clear(PageEC);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."E. Contract type" := 3;
                            us.Modify();
                        end;
                        ec.Reset();
                        ec.SetFilter(Type, '%1', ec.Type::"Employee");
                        PageEC.SetTableView(EC);
                        Commit();
                        PageEC.LOOKUPMODE(TRUE);
                        IF PageEC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Commit();
                            PageEC.GETRECORD(ec);

                            validate("Contract Type", ec.Code);
                        end;
                        Commit();


                    end;



                }

                field("Contract Type Name"; "Contract Type Name")
                {
                    Editable = false;

                    ApplicationArea = all;

                }

                field("Attachment No."; "Attachment No." <> 0)
                {

                    ApplicationArea = all;
                    Caption = 'Attachment No.';

                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No." <> 0 THEN
                            OpenAttachment;

                        CurrPage.UPDATE;
                    end;
                }
                field("Work Years"; "Work Years")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Work Months"; "Work Months")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Work Days"; "Work Days")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Rad u smjenama"; "Rad u smjenama")
                {
                    ApplicationArea = all;
                }
                field("First Time Employed"; "First Time Employed")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field(Prentice; Prentice)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Prentice Precentage"; "Prentice Precentage") { }
                field("Testing Period"; "Testing Period")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF "Testing Period" = TRUE THEN
                            "Testing Period Starting Date" := "Starting Date"
                        ELSE
                            IF "Testing Period" = FALSE THEN BEGIN
                                "Testing Period Starting Date" := 0D;
                                "Testing Period Ending Date" := 0D;
                                "Probation Days" := 0;
                                "Probation Months" := 0;
                                "Probation Year" := 0;
                                MODIFY;


                                //CurrPage.UPDATE;

                            END;
                    end;
                }
                field("Testing Period Starting Date"; "Testing Period Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Testing Period Ending Date"; "Testing Period Ending Date")
                {
                    ApplicationArea = all;
                }
                field("Probation Year"; "Probation Year")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Probation Months"; "Probation Months")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Probation Days"; "Probation Days")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Testing Period Successful"; "Testing Period Successful")
                {
                    ApplicationArea = all;
                }
                field("Testing Period - Comment"; "Testing Period - Comment")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field(Brutto; Brutto)
                {
                    BlankZero = true;
                    ShowMandatory = true;
                    ApplicationArea = all;


                }
                field(Netto; Netto)
                {
                    Editable = true;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Percentage of Fixed Part"; "Percentage of Fixed Part")
                {
                    Editable = false;

                    ApplicationArea = all;
                    Visible = false;
                }
                field("Fixed Amount Brutto"; "Fixed Amount Brutto")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Fixed Amount Netto"; "Fixed Amount Netto")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Percentage of Variable"; "Percentage of Variable")
                {

                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Variable Amount Brutto"; "Variable Amount Brutto")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Variable Amount Netto"; "Variable Amount Netto")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("BJF/GJF"; "BJF/GJF")
                {

                    Editable = false;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Additional Benefits"; "Additional Benefits")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Employee Benefits"; "Employee Benefits")
                {
                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        UserSetup: Record "User Setup";
                        Misc: Record "Misc. article information";
                        MiscP: Page "Misc Article Informations";
                    begin
                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup."Last ECL No." := Rec."No.";
                            UserSetup."Last Org Shema" := Rec."Org. Structure";
                            UserSetup.Modify();
                        end;
                        Misc.Reset();
                        Misc.SetFilter("Org Shema", '%1', Rec."Org. Structure");
                        Misc.SetFilter("Emp. Contract Ledg. Entry No.", '%1', Rec."No.");
                        Misc.SetFilter("Employee No.", '%1', Rec."Employee No.");
                        MiscP.SetTableView(Misc);
                        MiscP.Run();
                        CurrPage.Update();


                    end;

                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Visible = false;
                }



                field("<Minimal Education Levell>"; "Minimal Education Level")
                {

                    ApplicationArea = all;
                    Visible = false;
                }
                field(KPI; KPI)
                {
                    Visible = false;
                    ApplicationArea = all;
                }







                field("Way of Employment"; "Way of Employment")
                {
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Manner of Term. Description"; "Manner of Term. Description")
                {
                    ApplicationArea = all;
                }
                field("Manner of Term. Code"; "Manner of Term. Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Grounds for Term. Description"; "Grounds for Term. Description")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        PageEC2: page "Grounds for Termination";
                        ec2: Record "Grounds for Termination";
                        US: Record "User Setup";

                    begin

                        Clear(PageEC2);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Customer or Employee" := false;
                            us.Modify();
                        end;
                        ec2.Reset();
                        ec2.SetFilter(Type2, '%1', ec2.Type2::Employee);
                        PageEC2.SetTableView(EC2);
                        Commit();
                        PageEC2.LOOKUPMODE(TRUE);
                        IF PageEC2.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Commit();
                            PageEC2.GETRECORD(ec2);
                            "Grounds for Term. Description" := ec2.Description;
                            "Grounds for Term. Code" := ec2.Code;
                        end;
                        Commit();

                    end;

                    //on drill

                }
                field("Grounds for Term. Code"; "Grounds for Term. Code")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Exit Interview"; "Exit Interview")
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Employment Abroad"; "Employment Abroad")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Employment Abroad City"; "Employment Abroad City")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Empl.Abroad Country/Region"; "Empl.Abroad Country/Region")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Manager 1"; "Manager 1")
                {

                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Manager 1 First Name"; "Manager 1 First Name")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 1 Last Name"; "Manager 1 Last Name")
                {
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 2"; "Manager 2")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("Manager 2 First Name"; "Manager 2 First Name")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Manager 2 Last Name"; "Manager 2 Last Name")
                {
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }





                /* 
                  field("Other Attachment No."; "Other Attachment No." <> 0)
                  {

                      ApplicationArea = all;

                      trigger OnAssistEdit()
                      begin
                          IF "Other Attachment No." <> 0 THEN
                              OpenAttachment1;

                          CurrPage.UPDATE;
                      end;
                  }
                  field("Change other documents"; "Change other documents")
                  {
                      Editable = false;
                      ApplicationArea = all;
                  }
                  field("Number of certification"; "Number of certification")
                  {
                      ApplicationArea = all;
                  }*/

                field("Temporary disposition"; "Temporary disposition")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("Additional Position"; "Additional Position")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Additional Responsiblity"; "Additional Responsiblity")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Temporary disposition starting"; "Temporary disposition starting")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Temporary disposition ending"; "Temporary disposition ending")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                /*
                field("Number of protocol for documen"; "Number of protocol for documen")
                {
                    ApplicationArea = all;
                }*/
                /*field(Status; Status)
                {
                    ApplicationArea = all;
                }*/
                /* field("Status of employee"; "Status of employee")
                 {

                     Caption = 'Status';
                 }*/
                field(Status; Status)
                {
                    ApplicationArea = all;
                }


            }
        }
    }

    actions
    {
        area(processing)
        {
            /*  action("Custom report layouts")
              {
                  Caption = 'Custom report layouts';
                  Image = Agreement;
                  RunObject = Page "Custom Report Layouts";
                  Visible = IsVisible;
                  ApplicationArea = all;
              }*/
            /*ĐK  group(Process)
              {
                  Caption = 'Process';
                  //The property 'ToolTip' cannot be empty.
                  //ToolTip = '';*/
            action(Copy)
            {
                Caption = 'Copy';
                Image = Copy;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Scope = Page;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    ECLCopy.COPY(Rec, FALSE);
                    ECLCopy2.SETFILTER("No.", '<>%1', 0);
                    IF ECLCopy2.FINDLAST THEN
                        ECLCopy."No." := ECLCopy2."No." + 1
                    ELSE
                        ECLCopy."No." := 1;
                    ECLCopy."Operator No." := USERID;
                    ECLCopy.Active := FALSE;
                    ECLCopy."Attachment No." := 0;
                    ECLCopy."Reason for Change" := ECLCopy."Reason for Change"::Empty;
                    ECLCopy."Ending Date" := 0D;
                    //ECLCopy.VALIDATE("Starting Date",TODAY);
                    ECLCopy."Starting Date" := 0D;
                    ECLCopy.Change := FALSE;
                    ECLCopy.VALIDATE("Manner of Term. Description", '');
                    ECLCopy.VALIDATE("Grounds for Term. Description", '');
                    ECLCopy.VALIDATE("Contract Type Name", '');
                    ECLCopy.Status := 1;
                    //    ECLCopy."Agreement Name" := '';
                    ECLCopy."Agremeent Code" := '';
                    ECLCopy."Sent Mail Change Pos" := FALSE;
                    ECLCopy."Sent Mail Duration" := FALSE;
                    ECLCopy."Sent Mail Employment" := FALSE;
                    ECLCopy."Sent Mail Termination" := FALSE;

                    ECLCopy.INSERT(TRUE);
                    IF Rec."Org. Structure" <> ECLCopy."Org. Structure" THEN BEGIN
                        Dep.RESET;
                        Dep.SETFILTER("ORG Shema", '%1', ECLCopy."Org. Structure");
                        Dep.SETFILTER(Code, '%1', ECLCopy."Department Code");
                        Dep.SETFILTER(Description, '%1', ECLCopy."Department Name");
                        IF Dep.FINDFIRST THEN BEGIN
                            IF Dep."Department Type" = Dep."Department Type"::Sector THEN BEGIN
                                ECLCopy.VALIDATE("Sector Description", '');
                                ECLCopy.VALIDATE("Sector Description", Dep."Sector  Description");
                                ECLCopy.MODIFY;
                                PositionRec.RESET;
                                PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                IF PositionRec.FINDFIRST THEN BEGIN
                                    ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                    ECLCopy.MODIFY;
                                END
                                ELSE BEGIN
                                    ECLCopy.VALIDATE("Position Description", '');
                                END;
                            END;

                            IF Dep."Department Type" = Dep."Department Type"::"Department Category" THEN BEGIN
                                ECLCopy.VALIDATE("Department Cat. Description", '');
                                ECLCopy.VALIDATE("Department Cat. Description", Dep."Department Categ.  Description");
                                ECLCopy.MODIFY;
                                PositionRec.RESET;
                                PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                IF PositionRec.FINDFIRST THEN BEGIN
                                    ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                    ECLCopy.MODIFY;
                                END
                                ELSE BEGIN
                                    ECLCopy.VALIDATE("Position Description", '');
                                END;
                            END;
                            IF Dep."Department Type" = Dep."Department Type"::Group THEN BEGIN
                                ECLCopy.VALIDATE("Group Description", '');
                                ECLCopy.VALIDATE("Group Description", Dep."Group Description");
                                ECLCopy.MODIFY;
                                PositionRec.RESET;
                                PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                IF PositionRec.FINDFIRST THEN BEGIN
                                    ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                    ECLCopy.MODIFY;
                                END
                                ELSE BEGIN
                                    ECLCopy.VALIDATE("Position Description", '');
                                END;
                            END;
                            IF Dep."Department Type" = Dep."Department Type"::"Main office" THEN BEGIN
                                ECLCopy.VALIDATE("Team Description", '');
                                ECLCopy.VALIDATE("Team Description", Dep."Team Description");
                                ECLCopy.MODIFY;
                                PositionRec.RESET;
                                PositionRec.SETFILTER(Description, '%1', ECLCopy."Position Description");
                                PositionRec.SETFILTER("Org. Structure", '%1', ECLCopy."Org. Structure");
                                PositionRec.SETFILTER("Department Code", '%1', ECLCopy."Department Code");
                                IF PositionRec.FINDFIRST THEN BEGIN
                                    //    ECLCopy.VALIDATE("Position Description", ECLCopy."Position Description");
                                    //         ECLCopy.MODIFY;
                                END
                                ELSE BEGIN
                                    //       ECLCopy.VALIDATE("Position Description", '');
                                END;
                            END;
                        END
                        ELSE BEGIN
                            //  ECLCopy.VALIDATE("Sector Description", '');
                            // ECLCopy.VALIDATE("Position Description", '');
                            //  ECLCopy.MODIFY;
                        END;

                    END;
                end;
            }
            /*     action("Copy Orginal")
                 {
                     Caption = 'Copy';
                     ApplicationArea = all;
                     Image = Copy;
                     Promoted = false;
                     //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                     //PromotedIsBig = false;
                     Scope = Page;

                     trigger OnAction()
                     begin

                         ECLCopy.COPY(Rec, FALSE);
                         ECLCopy2.SETFILTER("No.", '<>%1', 0);
                         IF ECLCopy2.FINDLAST THEN
                             ECLCopy."No." := ECLCopy2."No." + 1
                         ELSE
                             ECLCopy."No." := 1;
                         ECLCopy."Operator No." := USERID;

                         ECLCopy.INSERT(TRUE);
                     end;
                 }
                 action(RunReport)
                 {
                     Caption = 'RunReport';
                     ApplicationArea = all;
                     Image = Print;
                     Promoted = true;
                     PromotedCategory = Process;
                     PromotedIsBig = true;
                     Visible = false;

                     trigger OnAction()
                     begin
                         /*DR.SETFILTER("Agreement Code",'%1',Rec."Agremeent Code");
                         IF DR.FIND('-') THEN BEGIN
                           CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
                           IF CRL.FIND('-') THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                            IF "Agremeent Code"='26' THEN BEGIN
                             ContractR.SetParam("Employee No.",'26');
                              // REPORT.RUNMODAL(DR."NAV Agreement Code");
                             ContractR.RUN;
                             CreateAttachment;
                             END;
                             IF "Agremeent Code"='262' THEN BEGIN
                               ECL.RESET;
                               ECL.SETFILTER("Employee No.","Employee No.");
                               IF ECL.FINDLAST THEN BEGIN
                               ContractP.SetParam("Employee No.");
                             ContractP.RUN;
                               END;
                               END;

                             //REPORT.RUNMODAL(DR.NAV Agreement Code");
                            ReportLayoutSelection.SetTempLayoutSelected(0);
                            END;
                           END;


                     end;
                 }*/

            /*action(Open1)
            {
                Caption = 'Open';
                Image = Edit;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    OpenAttachment;

                end;
            }
            action(Create)
            {
                Caption = 'Create';
                Ellipsis = true;
                ApplicationArea = all;
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CreateAttachment;
                end;
            }
            action("Copy_from")
            {
                Caption = 'Copy_from';
                Ellipsis = true;
                Image = Copy;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Visible = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    CopyFromAttachment;
                end;
            }
            action(Import)
            {
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //ImportAttachment;
                    Change := TRUE;
                    MODIFY;
                    IF "Attachment No." <> 0 THEN BEGIN
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                    END;
                    ECL.RESET;
                    ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    IF ECL.FIND('-') THEN BEGIN
                        BrojUgovora := ECL.COUNT;
                    END;
                    //ĐK   Attachment.SetParam(Rec."Employee No.", Rec."No.", 1);
                    IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) THEN BEGIN
                        "Attachment No." := Attachment."No.";

                    END;


                end;
            }
            action("Export")
            {
                Caption = 'Export';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    ExportAttachment;
                end;
            }
            action(Remove)
            {
                Caption = 'Remove';
                Ellipsis = true;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    RemoveAttachment(TRUE);
                end;
            }
            action(Open2)
            {
                Caption = 'Open';
                Image = Edit;
                ApplicationArea = all;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                ShortCutKey = 'Return';

                trigger OnAction()
                begin
                    OpenAttachment1;
                end;
            }
            action(Create1)
            {
                Caption = 'Create1';
                Ellipsis = true;
                Image = New;
                Promoted = true;
                PromotedCategory = New;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CreateAttachment1;
                end;
            }
            action("Copy_from1")
            {
                Caption = 'Copy_from1';
                Ellipsis = true;
                Image = Copy;
                Promoted = true;
                PromotedCategory = New;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CopyFromAttachment1;
                end;
            }
            action(Import1)
            {
                Caption = 'Import1';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all; 

                trigger OnAction()
    begin
        //ImportAttachment1;
        //ImportAttachment;

        "Change other documents" := TRUE;
        MODIFY;
        IF "Other Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Other Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;
        ECL.RESET;
        ECL.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        IF ECL.FIND('-') THEN BEGIN
            BrojUgovora := ECL.COUNT;
        END;
        //ĐK     Attachment.SetParam(Rec."Employee No.", Rec."No.", 2);
        IF Attachment.ImportAttachmentFromClientFile('', FALSE, FALSE) THEN BEGIN
            "Other Attachment No." := Attachment."No."
        END;

    end;
}
            action("E_xport1")
            {
                Caption = 'E_xport1';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                begin
                    ExportAttachment1;
                end;
            }
            action(Remove1)
            {
                Caption = 'Remove1';
                Ellipsis = true;
                ApplicationArea = all;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RemoveAttachment1(TRUE);
                end;
            }
            action("<Action80>")
            {
                Caption = 'Auto Import';
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = New;
                Visible = false;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    // Auto Uvoz

                    /*DR.SETFILTER("Agreement Code",'%1',Rec."Agremeent Code");
                    IF DR.FINDLAST THEN BEGIN
                      CRL.SETFILTER("Report ID",'%1',DR."NAV Agreement Code");
                      IF CRL.FINDLAST THEN BEGIN
                       ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));

                      IF "Agremeent Code"='26' THEN BEGIN
                        ContractR.SetParam("Employee No.",'26');

                          // REPORT.RUNMODAL(DR."NAV Agreement Code");

                          //ContractR.RUN;
                          //CreateAttachment;

                          tempSaveDest := 'C:\Temp\autouvoz_'+FORMAT(WORKDATE)+'.doc';

                          // Prepare for temporary file allocation and word save
                          // Specify that the temporary is opened as a binary file.
                          tempFile.TEXTMODE(FALSE);

                          // Specify that you can write to temporary file.
                          tempFile.WRITEMODE(TRUE);

                          // Create and open tempFile.
                          tempFile.CREATE(tempSaveDest);

                          // Close TempFile so that the SAVEASWORD function can write to it.
                          tempFile.CLOSE;

                          // Call the save function providing the temporary destination path
                          ContractR.SAVEASWORD(tempSaveDest);

                          // Now opeon the temp file from the temporary save destination
                          tempFile.OPEN(tempSaveDest);

                          // Create a new binary stream for the temmporary file
                          tempFile.CREATEINSTREAM(NewStream);

                        END;

                        IF "Agremeent Code"='262' THEN BEGIN
                          ECL.RESET;
                          ECL.SETFILTER("Employee No.","Employee No.");
                          IF ECL.FINDLAST THEN BEGIN
                            ContractP.SetParam("Employee No.");
                            ContractP.RUN;
                            //ContractR.SAVEASWORD('C:\test.docx');
                          END;
                        END;

                        //REPORT.RUNMODAL(DR.NAV Agreement Code");
                      ReportLayoutSelection.SetTempLayoutSelected(0);
                      END;
                      END;







                end;
            }
            action("Show/Hide record")
            {
                Caption = 'Show/Hide record';
                RunObject = Report "ECL Show/Hide record";
                ApplicationArea = all;
            }
        }
        group(Certifications1)
        {
            Caption = 'Certifications';
            Visible = false;
            group(Certifications2)
            {
                Caption = 'Certifications';
                Image = LotInfo;
                action("Certificate for maternity leave")
                {
                    Caption = 'Certificate for maternity leav';
                    Image = "Report";
                    ApplicationArea = all;

                    trigger OnAction()
                    begin
                        CRL2.SETFILTER("Report ID", '%1', 99001047);
                        IF CRL2.FIND('-') THEN BEGIN
                            //ĐK  ReportLayoutSelection.SetTempLayoutSelected(CRL2.ID);
                            // Certificatematernity.SetParam("Employee No.");
                            //  Certificatematernity.RUN;
                        END;
                        //    ReportLayoutSelection.SetTempLayoutSelected(0);

                    end;
                }
            }*/
            // }
            /*group(Forms1)
            {
                Caption = 'Forms';
                Image = LotInfo;*/


            /* ĐK  action(PD3100)
               {
                   Caption = 'PD3100';
                   ApplicationArea = all;
                   Image = Document;

                   trigger OnAction()
                   begin
                       CLEAR(ObrazacPD300);
                       ObrazacPD300.SetParam(Rec."Employee No.", Rec."No.");
                       ObrazacPD300.RUN;
                   end;
               }*/
            action(JS3100)
            {
                Caption = 'JS3100';
                Image = Document;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CLEAR(ObrazacJS3100);
                    ObrazacJS3100.SetParam(Rec."Employee No.", Rec."No.");
                    ObrazacJS3100.RUN;
                end;
            }

        }
        //}
    }

    trigger OnAfterGetRecord()
    begin
        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Show Record", '%1', TRUE);
        Rec.FILTERGROUP(0);

        IF ("Testing Period Successful" = "Testing Period Successful"::" ") AND ("Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
            "Testing Period Successful" := "Testing Period Successful"::Yes
        END;
        /*PosNew.RESET;
        PosNew.SETFILTER("Employee No.",'%1',"Employee No.");
        PosNew.SETFILTER("Org. Structure",'%1',"Org. Structure");
        PosNew.SETFILTER("Changing Position",'%1',TRUE);
        IF PosNew.FINDLAST THEN BEGIN
           IF PosNew.Description<>Rec."Position Description" THEN BEGIN
             Rec."Position Description":=PosNew.Description;
             EmployeeContractLedger.SETFILTER("Employee No.",'%1',PosNew."Employee No.");
             IF EmployeeContractLedger.FINDLAST THEN BEGIN
             EmployeeContractLedger.VALIDATE("Position Description",PosNew.Description);
             END;
             END;
             END;*/


        IF "Employee No." <> '' THEN
            EVALUATE(Order, "Employee No.");
        "Registration Date" := "Starting Date";


        /*EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER(Status,'Active');
        EmployeeContractLedger.SETFILTER("Employee No.","Employee No.");
        EmployeeContractLedger.SETFILTER("Org. Structure","Org. Structure");
        IF "Org Dio"<>'' THEN BEGIN
          OrgDijelovi.SETFILTER(Code,"Org Dio");
          OrgDijelovi.SETFILTER("ORG Shema","Org. Structure");
          IF OrgDijelovi.FINDFIRST THEN BEGIN
          "Regional Head Officey":= OrgDijelovi."Regionalni Head Office";
        END
        ELSE BEGIN
         "Regional Head Officey":='';
         END;
         END;
         */
        EmployeeContractLedger.RESET;
        //EmployeeContractLedger.SETFILTER(Active,'%1',TRUE);
        EmployeeContractLedger.SETFILTER("Employee No.", Rec."Employee No.");
        EmployeeContractLedger.SETFILTER("Org. Structure", "Org. Structure");
        EmployeeContractLedger.SETFILTER("No.", '%1', Rec."No.");
        IF EmployeeContractLedger.FINDLAST THEN BEGIN
            /* ContractPhase.RESET;
             ContractPhase.SETFILTER("Employee No.", EmployeeContractLedger."Employee No.");
             ContractPhase.SETFILTER("Contract Ledger Entry No.", '%1', EmployeeContractLedger."No.");
             ContractPhase.SETFILTER(Active, '%1', TRUE);
             IF ContractPhase.FINDLAST THEN BEGIN
                 "Contract Phase" := ContractPhase."Contract Phase";
                 "Contract Phase Time" := ContractPhase."Contract Phase Time";
                 "Contract Phase Date" := ContractPhase."Contract Phase Date";
             END;
         END;*/
        end;

        EmployeeContractLedger.CALCFIELDS("Manager 1");
        EmployeeContractLedger.CALCFIELDS("Manager 1 First Name");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Last Name");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Position Code");
        EmployeeContractLedger.CALCFIELDS("Manager 1 Position ID");
        EmployeeContractLedger.CALCFIELDS("Manager 2");
        EmployeeContractLedger.CALCFIELDS("Manager 2 First Name");
        EmployeeContractLedger.CALCFIELDS("Manager 2 Last Name");
        EmployeeContractLedger.CALCFIELDS("Manager 2 Position Code");


    end;

    trigger OnClosePage()
    begin
        CALCFIELDS("Minimal Education Level");
        //CALCFIELDS("Residence/Network","Department Name","Department Address","Department City","B-1","B-1 (with regions)",Stream);
        CALCFIELDS("Residence/Network");
        //CALCFIELDS("Sector Description","Department Cat. Description","Group Description");
        CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name", "Manager 1 Position Code");
        CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name", "Manager 2 Position Code");

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        //đ.k
    end;

    trigger OnModifyRecord(): Boolean
    begin
        IF xRec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := xRec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF Rec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF NOT CONFIRM(Text000, FALSE) THEN BEGIN
            Rec := xRec;
            xRec.TRANSFERFIELDS(Rec);
            //IF Rec."Identity Sector"=0 THEN BEGIN

            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            CurrPage.UPDATE(FALSE);
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF xRec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := xRec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        IF Rec."Employee No." <> '' THEN BEGIN
            FilterEmployeeNo := Rec.GETFILTER("Employee No.");
            SETFILTER("Employee No.", FilterEmployeeNo);
        END;
        Izmjena := FALSE;
        "Registration Date" := "Starting Date";
        IF ((USERID <> 'MBDOM\HRAPP') AND (USERID <> 'MBDOM\FEDJA.BOGDANOVIC')) THEN
            "Operator No." := USERID;
        IF (xRec."Starting Date" <> Rec."Starting Date") THEN
            // AND (Rec."Reason for Change"=Rec."Reason for Change"::"New Contract")) THEN
            VALIDATE("Starting Date", Rec."Starting Date");
        IF xRec."Team Description" <> Rec."Team Description" THEN BEGIN
            VALIDATE("Team Description", Rec."Team Description");
            Izmjena := TRUE;
        END;
        IF xRec."Group Description" <> Rec."Group Description" THEN BEGIN
            VALIDATE("Group Description", Rec."Group Description");
            Izmjena := TRUE;
        END;
        IF xRec."Department Cat. Description" <> Rec."Department Cat. Description" THEN BEGIN
            VALIDATE("Department Cat. Description", Rec."Department Cat. Description");
            Izmjena := TRUE;
        END;

        IF xRec."Sector Description" <> Rec."Sector Description" THEN BEGIN
            VALIDATE("Sector Description", Rec."Sector Description");
            Izmjena := TRUE;
        END;

        IF (xRec."Position Description" = Rec."Position Description") AND (Izmjena = TRUE) THEN
            VALIDATE("Position Description", Rec."Position Description");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        OsActive.RESET;
        OsActive.SETFILTER(Status, '%1', 0);
        IF OsActive.FINDLAST THEN BEGIN
            "Org. Structure" := OsActive.Code;
        END
        ELSE BEGIN
            "Org. Structure" := '';
        END;
    end;

    trigger OnOpenPage()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp.HR;

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        Rec.FILTERGROUP(2);
        Rec.SETFILTER("Show Record", '%1', TRUE);
        Rec.FILTERGROUP(0);

        /*   UserPersonalisation.RESET;
           UserPersonalisation.SETFILTER("User ID", USERID);
           IF UserPersonalisation.FINDFIRST THEN BEGIN
               IF UserPersonalisation."Profile ID" <> 'PAYROLL' THEN
                   show := TRUE
               ELSE
                   show := FALSE;
           END;*/

        //REPORT.RUNMODAL(50050,FALSE,TRUE);


        CALCFIELDS("Minimal Education Level");
        //CALCFIELDS("Residence/Network","Department Name","Department Address","Department City","B-1","B-1 (with regions)",Stream);
        CALCFIELDS("Residence/Network");
        //CALCFIELDS("Sector Description","Department Cat. Description","Group Description");
        CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name", "Manager 1 Position Code");
        CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name", "Manager 2 Position Code");
        SETCURRENTKEY(Order);
        /*  CALCFIELDS("Contract Phase");
          CALCFIELDS("Contract Phase Date");
          CALCFIELDS("Contract Phase Time");*/
        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);

        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" = 'HR OPERATER' THEN
                IsVisible := FALSE
            ELSE
                IsVisible := TRUE;
        END;
        IF ("Testing Period Successful" = "Testing Period Successful"::" ") AND ("Testing Period Ending Date" = CALCDATE('<-1D>', TODAY)) THEN BEGIN
            "Testing Period Successful" := "Testing Period Successful"::Yes
        END;

        /*  PosNew.RESET;
        PosNew.SETFILTER("Employee No.",'%1',"Employee No.");
        PosNew.SETFILTER("Org. Structure",'%1',"Org. Structure");
        PosNew.SETFILTER("Changing Position",'%1',TRUE);
        IF PosNew.FINDLAST THEN BEGIN
        IF PosNew.Description<>Rec."Position Description" THEN BEGIN
        Rec."Position Description":=PosNew.Description;
        EmployeeContractLedger.SETFILTER("Employee No.",'%1',PosNew."Employee No.");
        IF EmployeeContractLedger.FINDLAST THEN BEGIN
        EmployeeContractLedger.VALIDATE("Position Description",PosNew.Description);
        END;
        END;
        END;
        */
        SETCURRENTKEY("Starting Date");
        ASCENDING(FALSE);

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        CurrPage.UPDATE;
        IsUpadate := FALSE;
        IF "No." <> 0 THEN BEGIN

            TESTFIELD("Starting Date");
        END;
        OrgF.RESET;
        OrgF.SETFILTER(Status, '%1', OrgF.Status::Active);
        IF OrgF.FINDLAST THEN BEGIN
            OrgC := OrgF.Code;
        END;


    end;

    var
        show: Boolean;
        UserPersonalization: Record "User Personalization";
        ObrazacJS3100: Report "Obrazac JS3100";
        Tip: Text;
        EditableNetto: Boolean;
        EditableBrutto: Boolean;
        CloseDate: Date;
        ECLCD: Record "Employee Contract Ledger";
        ECLCopy: Record "Employee Contract Ledger";
        ECLCopy2: Record "Employee Contract Ledger";
        Sec: Record "Sector";
        NemaNiko: Boolean;
        Org: Record "Org Dijelovi";
        OrgDijelovi: Record "Org Dijelovi";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        ContractPhase: Record "Contract Phase t";
        ContractPhasePage: Page "Contract Phase";
        IsVisible: Boolean;
        UserPersonalisation: Record "User Personalization";
        //     DR: Record "Document Register";
        ReportLayoutSelection: Record "Report Layout Selection";
        CRL: Record "Custom Report Layout";
        ///   PayRange: Record "Payment range";
        BruttoError: Label 'Brutto isn''t in pay range!';
        // ContractR: Report "test";
        //  ContractP: Report "Anex Contract -r";
        Text000: Label 'Would you like to save the changes?';
        lcduMail: Codeunit "SMTP Mail";
        HRsetup: Record "Human Resources Setup";
        ReportDistributionManagement: Codeunit "Report Distribution Management";
        DocumentSendingProfile: Record "Document Sending Profile";
        // R: Report "Segmentation report";
        DocumentMailing: Codeunit "Document-Mailing";
        CustomReportSelection: Record "Custom Report Selection";
        //ĐK        R_PayList: Report "Pay List";
        FileManagement: Codeunit "File Management";
        filename: Text;
        n: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "Mail";
        //MOŽDA  TM: Record "Template Messages";
        TextMsg: BigText;
        IStream: InStream;
        counter: Integer;
        MessageBody: Text;
        EmpName: Text;
        Emp1: Record "Employee";
        Manager1: Text;
        Manager2: Text;
        Manager3: Text;
        Emp2: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        attachment1: Text;
        SMTPMail: Codeunit "SMTP Mail";
        Pos: Record "Position";
        attachment2: Text;
        AttFiles: array[5] of Text;
        CC: Text;
        CompanyInfo: Record "Company Information";
        TempBlob: Codeunit "Temp Blob";
        FileManagment: Codeunit "File Management";
        LastFieldNo: Integer;
        ConfidentialInformationFilter: Text;
        OD: Codeunit "Temp Blob";
        PhaseR: Option;
        OD2: Codeunit "Temp Blob";
        DatumOd: Date;
        EmpCL: Record "Employee Contract Ledger";
        OrgUnit: Text;
        PositionPlace: Text;
        WorkPlace: Text;
        StartingDate: Date;
        EmployeeRole: Code[10];
        ManagerC: Text;
        ManagerFull: Text;
        ES: Record "Employee Surname";
        OldCompanyEmail: Text;
        NewCompanyEmail: Text;
        EndingDate: Date;
        EMPCL1: Record "Employee Contract Ledger";
        Found: Boolean;
        NoPrevious: Integer;
        EndingDateOFPosition: Date;
        EmailBodyText: Text;
        Emp: Record "Employee";
        Reg: Text;
        Brojac: Integer;
        filenamenew: Text;
        //        DR1: Record "Document Register";
        ReportLayoutSelection1: Record "Report Layout Selection";
        CRL1: Record "Custom Report Layout";
        CRL2: Record "Custom Report Layout";
        //ĐK Certificatematernity: Report "Certificate for maternity leav";
        PosNew: Record "Position";
        Employee: Record "Employee";
        ECLTable: Record "Employee Contract Ledger";
        tempSaveDest: Text;
        tempFile: File;
        NewStream: InStream;
        ToFile: Text;
        ReturnValue: Boolean;
        Attachment: Record "Attachment";
        BrojUgovora: Integer;
        PositionMenu: Record "Position Menu";
        DepartmentT: Record "Department";
        DepartmentT1: Record "Department";
        PositionBenefits: Record "Position Benefits";
        PositionBenefits1: Record "Position Benefits";
        OsActive: Record "ORG Shema";
        //   Role: Record "Role";
        pOSITIONTA: Record "Position";
        pOSITIONTA1: Record "Position";
        Misc: Record "Misc. article information";
        // RefreshOrg: Report "Org unit refresh 2";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        DimensionForPosition: Record "Dimension for position";
        UserT: Record "User";
        //ĐK ObrazacJS3100: Report "Obrazac JS3100";
        //ĐK   ObrazacPD300: Report "Obrazac PD3100";
        OrgF: Record "ORG Shema";
        OrgC: Code[10];
        ECL1: Record "Employee Contract Ledger";
        MjestoRada: Text;
        PositionMenuOrginal: Record "Position Menu";
        RoleCode: Code[10];
        RoleName: Text;
        ECL2: Record "Employee Contract Ledger";
        EmailBodyText1: Text;
        EmailBodyText2: Text;
        ECL3: Record "Employee Contract Ledger";
        ECL4: Record "Employee Contract Ledger";
        ECL5: Record "Employee Contract Ledger";
        "PositionPlace¸2": Text;
        ECLCHange: Record "Employee Contract Ledger";
        EmailBodyText5: Text;
        Dep: Record "Department";
        PositionRec: Record "Position Menu";
        Izmjena: Boolean;
        FilterEmployeeNo: Code[10];
        ECLLastDate: Record "Employee Contract Ledger";
        IsUpadate: Boolean;
}

