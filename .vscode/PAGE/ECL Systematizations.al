page 50144 "ECL Systematizations"
{
    ApplicationArea = BasicHR;
    Caption = 'Employees nk';
    //CardPageID = "Employee Card";
    PageType = List;
    SourceTable = "ECL Systematization";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Systematization)
            {
                field("Internal ID"; "Internal ID")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {
                    Applicationarea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    Applicationarea = all;
                }
                field("Reason for Change"; "Reason for Change")
                {
                    Applicationarea = all;
                }
                field("Difference Org/Position"; "Difference Org/Position")
                {
                    Applicationarea = all;
                    visible = false;
                }
                field("Org Belongs"; "Org Belongs")
                {
                    Applicationarea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
                field("Position Description"; "Position Description")
                {
                    Applicationarea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }

                field("Position Code"; "Position Code")
                {
                    Applicationarea = all;
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

                field("Will Be Changed Later"; "Will Be Changed Later")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Changing Position"; "Changing Position")
                {
                    Applicationarea = all;
                }

                field("Branch Agency"; "Branch Agency")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field(IS; IS)
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("IS Date From"; "IS Date From")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("IS Date To"; "IS Date To")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Org Unit Name"; "Org Unit Name")
                {
                    Applicationarea = all;

                    Visible = false;
                }
                field("GF of work Description"; "GF of work Description")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Phisical Department Desc"; "Phisical Department Desc")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Regionalni Head Office"; "Regionalni Head Office")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field(Region; Region)
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Team Description"; "Team Description")
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field(Team; Team)
                {
                    Applicationarea = all;
                    Visible = false;
                }
                field("Group Description"; "Group Description")
                {
                    Applicationarea = all;
                }
                field(Group; Group)
                {
                    Applicationarea = all;
                }
                field("Department Cat. Description"; "Department Cat. Description")
                {
                    Applicationarea = all;
                }
                field("Department Category"; "Department Category")
                {
                    Applicationarea = all;
                }
                field("Sector Description"; "Sector Description")
                {
                    Applicationarea = all;
                }
                field(Sector; Sector)
                {
                    Applicationarea = all;
                }
                field("Department Code"; "Department Code")
                {
                    Editable = false;
                    Applicationarea = all;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Applicationarea = all;
                    Visible = false;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    Style = Unfavorable;
                    Applicationarea = all;
                    StyleExpr = TRUE;
                    Visible = false;
                }
                field("Order By Managment"; "Order By Managment")
                {
                    Applicationarea = all;
                    Visible = false;

                }
                field(Brutto; Brutto)
                {
                    Applicationarea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;
                Caption = 'Next step';


                trigger OnAction()
                begin


                    CurrPage.SAVERECORD;

                    StepNext.RUN;
                    CurrPage.CLOSE();

                end;
            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;
                Caption = 'Previous step';

                trigger OnAction()
                begin


                    PreviousStep.RUN;
                    CurrPage.CLOSE();

                end;
            }
            action(ShowRecord)
            {
                Caption = 'ShowRecord';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;


                //   RunObject = Report "Show record";
                Visible = false;
            }
            action(UpdateDep)
            {
                Caption = 'UpdateDep';
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Update dep";
                Applicationarea = all;
                Visible = true;

            }
            action(UpdateHeadOf)
            {
                Caption = 'UpdateHeadOf';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Applicationarea = all;
                Visible = false;
                RunObject = Report "Update Head Of table";
            }
        }
    }

    var
        Response: Boolean;
        StepNext: Page "Head Of's temporary sist";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        PreviousStep: Page "Position menu temp";
        NewReport: Report "Update Head Of table";
}
