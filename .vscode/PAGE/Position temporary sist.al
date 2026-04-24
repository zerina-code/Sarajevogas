page 50103 "Position temporary sist"
{
    Caption = 'Position temporary sist wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Position temporery";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field("Position ID"; "Position ID")
                {
                    ApplicationArea = all;
                }
                field(Order; Order)
                {
                    ApplicationArea = all;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Employee Full Name"; "Employee Full Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Changing Position"; "Changing Position")
                {
                    ApplicationArea = all;
                }
                field("Will Be Changed Later"; "Will Be Changed Later")
                {
                    ApplicationArea = all;
                }
                field(Agency; Agency)
                {
                    ApplicationArea = all;
                }
                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    ApplicationArea = all;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Official Translation"; "Official Translation")
                {
                    ApplicationArea = all;
                }
                field("Free Translation"; "Free Translation")
                {
                    ApplicationArea = all;
                }
                field("Control Function"; "Control Function")
                {
                    ApplicationArea = all;
                }
                field("Key Function"; "Key Function")
                {
                    ApplicationArea = all;
                }
                field("Disc. Department Code"; "Disc. Department Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Disc. Department Name"; "Disc. Department Name")
                {
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Manager 1 Code"; "Manager 1 Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Full Name"; "Manager 1 Full Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1  Department Code"; "Manager 1  Department Code")
                {
                    ApplicationArea = all;
                    Caption = 'Manager Department Code';
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Position Code"; "Manager 1 Position Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 1 Position ID"; "Manager 1 Position ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Favorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Code"; "Manager 2 Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Full Name"; "Manager 2 Full Name")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2  Department Code"; "Manager 2  Department Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Position Code"; "Manager 2 Position Code")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field("Manager 2 Position ID"; "Manager 2 Position ID")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                }
                field(Vocation; Vocation)
                {
                    ApplicationArea = all;
                }
                field("Vocation Description"; "Vocation Description")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

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
                Caption = 'Next step';


                trigger OnAction()
                begin

                    Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        CurrPage.SAVERECORD;
                        //StepNext.SETRECORD(Rec);
                        StepNext.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;

                    /*  ConfirmClose2 := FALSE;
                      //bt01
                      // Rec."No." := '0000000001';
                      // Rec."Entry No." := 0;
                      CODEUNIT.RUN(CODEUNIT::"Wage Precalculation",Rec);
                        //Bt01
                         //Rec.GET('0000000001',Rec."Entry No.");
                      Rec.GET(Rec."No.",Rec."Entry No.");
                      Rec."Step 2":= TRUE;
                      CurrPage.SAVERECORD;
                      IF Reduction THEN
                        BEGIN
                          Step3.SETRECORD(Rec);
                          Step3.RUN
                        END
                      ELSE
                        BEGIN
                          Step4.SETRECORD(Rec);
                          Step4.RUN;
                        END;
                      CurrPage.EDITABLE(FALSE);*/

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
                        /* DepartmentCategroyTemp.RESET;
                         DepartmentCategroyTemp.SETFILTER("Org Shema",'%1',Rec."Org Shema");
                         IF NOT DepartmentCategroyTemp.ISEMPTY THEN
                           DepartmentCategroyTemp.DELETEALL(TRUE);*/
                    END;
                    CurrPage.SAVERECORD;
                    // PreviousStep.SETRECORD(Rec);
                    //   PreviousStep.RUN;
                    CurrPage.CLOSE();
                    CurrPage.EDITABLE(FALSE);



                    /* ConfirmClose2 := FALSE;
                     IF Rec."Step 2" THEN
                       BEGIN
                         WageCalcTemp.RESET;
                         WageCalcTemp.SETFILTER("Wage Header No.", Rec."No.");
                         WageCalcTemp.SETRANGE("Entry No.", Rec."Entry No.");
                         IF NOT WageCalcTemp.ISEMPTY THEN
                           WageCalcTemp.DELETEALL(TRUE);
                         ReductionTemp.RESET;
                         ReductionTemp.SETFILTER("Wage Header No.", Rec."No.");
                         IF NOT ReductionTemp.ISEMPTY THEN
                           ReductionTemp.DELETEALL(TRUE);
                         WPClose.ClosedForm(Rec);
                       END;
                     Rec."Step 2":=FALSE;
                     CurrPage.SAVERECORD;
                     Step1.SETRECORD(Rec);
                     Step1.RUN;
                     CurrPage.EDITABLE(FALSE);*/

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
        StepNext: Page "Head Of's temporary sist";
        //  PreviousStep: Page "Team temporary sist";
        Response: Boolean;
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
}

