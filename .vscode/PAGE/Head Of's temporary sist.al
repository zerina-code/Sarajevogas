page 50064 "Head Of's temporary sist"
{
    Caption = 'Head Of''s wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Head Of's temporary";
    UsageCategory = Lists;
    ApplicationArea = all;
    // Editable = false;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = true;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Caption = 'First and Last name';
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
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
                    ApplicationArea = all;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Head's number of employee"; "Head's number of employee")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Exe Manager List")
            {
                Caption = 'Exe Manager List';
                Image = ListPage;
                Promoted = true;
                PromotedIsBig = true;

                RunObject = page "Exe Manager List temporery";
                RunPageLink = "ORG Shema" = field("ORG Shema");

            }
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                Visible = true;
                Caption = 'Next step';


                trigger OnAction()
                begin

                    Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        CurrPage.SAVERECORD;
                        StepNext.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;
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
                    IF Response THEN
                        CurrPage.SAVERECORD;
                    PreviousStep.RUN;
                    CurrPage.CLOSE();
                    CurrPage.EDITABLE(FALSE);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*HRsetup.FINDFIRST;
        CALCFIELDS("Position Code", "Position ID");
        SETFILTER(Status,'%1',Status::Active);
        SETRANGE("Employment Date", CALCDATE('-'+ FORMAT(HRsetup."New employee period"),TODAY),TODAY);
        SETFILTER(Testing,'%1',TRUE);*/
        CurrPage.EDITABLE(FALSE);

    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        PreviousStep: Page "Position menu temp";
        StepNext: Page "Department temporary sist";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
}

