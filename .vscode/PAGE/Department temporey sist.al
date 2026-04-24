page 50131 "Department temporary sist"
{
    Caption = 'Department wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Department temporary";
    UsageCategory = Lists;
    ApplicationArea = all;
    // Editable = false;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(City; City)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department ID"; "Department ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department IC"; "Department IC")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    Caption = 'Sector';
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    Caption = 'Sector Description';
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    Editable = true;
                    ApplicationArea = all;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Team Description"; "Team Description")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets administrator"; "Timesheets administrator")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets administrator 2"; "Timesheets administrator 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets Manager"; "Timesheets Manager")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cnfidential Clerk 1"; "Cnfidential Clerk 1")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 1 Full Name"; "Confidential Clerk 1 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 1 Position"; "Confidential Clerk 1 Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cnfidential Clerk 2"; "Cnfidential Clerk 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 2 Full Name"; "Confidential Clerk 2 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 2 Position"; "Confidential Clerk 2 Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1"; "Signatory 1")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Signatory 1 Full Name"; "Signatory 1 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 Position"; "Signatory 1 Position")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Signatory 2"; "Signatory 2")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Signatory 2 Full Name"; "Signatory 2 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 2 Position"; "Signatory 2 Position")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 Contr With Benef"; "Signatory 1 Contr With Benef")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 With Benef Name"; "Signatory 1 With Benef Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 2 Contr With Benef"; "Signatory 2 Contr With Benef")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 2 With Benef Name"; "Signatory 2 With Benef Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                Caption = 'Next step';


                trigger OnAction()
                begin

                    /*Response :=CONFIRM(Txt003);
                    IF Response THEN
                      BEGIN
                       CurrPage.SAVERECORD;
                        StepNext.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                        END;
                     */

                end;
            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Previous step';

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        CurrPage.SAVERECORD;
                        PreviousStep.RUN;
                        CurrPage.CLOSE();
                        // CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Rec.DELETE;
    end;

    trigger OnOpenPage()
    begin
        /*HRsetup.FINDFIRST;
        CALCFIELDS("Position Code", "Position ID");
        SETFILTER(Status,'%1',Status::Active);
        SETRANGE("Employment Date", CALCDATE('-'+ FORMAT(HRsetup."New employee period"),TODAY),TODAY);
        SETFILTER(Testing,'%1',TRUE);*/
        //   CurrPage.EDITABLE(FALSE);

    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        StepNext: Page "Position temporary sist";
        PreviousStep: Page "Head Of's temporary sist";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
}

