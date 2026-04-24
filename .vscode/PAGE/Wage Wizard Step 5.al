page 50028 "Wage Wizard Step 5"
{
    Caption = 'Wage Wizard Step 5-Closing';
    Editable = false;
    PageType = Card;
    SourceTable = "Wage Header";


    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';
                field("No."; "No.")
                {
                    ApplicationArea = all;

                }
                field("Year Of Wage"; "Year Of Wage")
                {
                    ApplicationArea = all;
                }
                field("Month Of Wage"; "Month Of Wage")
                {
                    ApplicationArea = all;
                }

                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Date Of Calculation"; "Date Of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Year of Calculation"; "Year of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Month of Calculation"; "Month of Calculation")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    ApplicationArea = all;
                }
                field("Negative Payment"; "Negative Payment")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                    Style = Unfavorable;
                    StyleExpr = TRUE;


                    trigger OnDrillDown()
                    begin
                        WCTemp.RESET;
                        WCTemp.SETFILTER(Payment, '<%1', 0);
                        WCPage.SETTABLEVIEW(WCTemp);
                        WCPage.RUN;
                        CurrPage.UPDATE;
                    end;
                }


            }
            group(WA)
            {
                Caption = 'Privremeni obračun plate';

                part("Wage Calculation Temp Subform"; "Wage Calculation Temp Subform")
                {
                    SubPageLink = "Wage Header No." = FIELD("No.");
                    SubPageView = WHERE(MasterLine = CONST(false));
                    Visible = wage;
                }

                part("Wage Addition Calculated"; "Wage Addition Calculated")
                {
                    SubPageLink = "Wage Header No." = FIELD("No."),
                                   "Closing Date" = field("Closing Date");
                    Visible = Additions;
                }

            }
            group(Parameters)
            {
                Caption = 'Parameters';
                field("Hour Pool"; "Hour Pool")
                {
                    ApplicationArea = all;
                }
                field(Transportation; Transportation)
                {
                    ApplicationArea = all;
                }
                field(Reduction; Reduction)
                {
                    ApplicationArea = all;
                }

            }
            group(Totals)
            {
                Caption = 'Totals';
                field("Temp Brutto"; "Temp Brutto")
                {
                    ApplicationArea = all;
                }
                field("Temp Net Wage"; "Temp Net Wage")
                {
                    ApplicationArea = all;
                }
                field("Temp Final Net Wage"; "Temp Final Net Wage")
                {
                    ApplicationArea = all;
                }
                field("Temp Add. Tax From Brutto"; "Temp Add. Tax From Brutto")
                {
                    ApplicationArea = all;
                }
                field("Temp Add. Tax Over Brutto"; "Temp Add. Tax Over Brutto")
                {
                    ApplicationArea = all;
                }
                field("Temp Tax"; "Temp Tax")
                {
                    ApplicationArea = all;
                }

                field("Temp Wage Reduction"; "Temp Wage Reduction")
                {
                    ApplicationArea = all;
                }
                field("Temp Transport"; "Temp Transport")
                {
                    ApplicationArea = all;
                }
                field("Temp Sick Leave-Company"; "Temp Sick Leave-Company")
                {
                    ApplicationArea = all;
                }
                field("Temp Sick Leave-Fund"; "Temp Sick Leave-Fund")
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
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    /*Rec.CALCFIELDS("Negative Payment");
                    IF Rec."Negative Payment"=0 THEN BEGIN
                    Response :=CONFIRM(Txt001);
                    IF Response THEN
                      BEGIN
                        ConfirmClose := FALSE;
                        CloseCalc.CloseCalc(Rec);
                        DoNotActivateWPClose := TRUE;
                        IF Rec."Wage Calculation Type"=0 THEN BEGIN
                          R_Additions.SetWHNo(Rec."No.");
                         R_Additions.RUN;
                    
                      END;
                        CurrPage.CLOSE;
                      END;
                      END
                    ELSE BEGIN
                      ERROR(Txt003);
                      END;*/
                    Rec.CALCFIELDS("Negative Payment");
                    BEGIN
                        IF Rec."Negative Payment" <> 0 THEN MESSAGE(Txt003);
                        Response := CONFIRM(Txt001);
                        IF Response THEN BEGIN
                            ConfirmClose := FALSE;
                            CloseCalc.CloseCalc(Rec);
                            DoNotActivateWPClose := TRUE;
                            /* IF Rec."Wage Calculation Type"=0 THEN BEGIN
                               R_Additions.SetWHNo(Rec."No.");
                              R_Additions.RUN;

                           END;*/
                            CurrPage.CLOSE;
                        END;
                    END;

                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    WPClose.ClosedForm(Rec);
                    CurrPage.CLOSE;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF (Rec."No." <> xRec."No.") OR (Rec."Entry No." <> xRec."Entry No.") THEN BEGIN
            Rec.RESET;
            Rec.GET(RecKey, RecKey2);
        END;
    end;

    trigger OnClosePage()
    begin
        IF NOT DoNotActivateWPClose THEN
            WPClose.ClosedForm(Rec);
    end;

    trigger OnInit()
    begin
        DoNotActivateWPClose := FALSE;
    end;

    trigger OnOpenPage()
    begin
        FILTERGROUP(10);
        Rec.SETFILTER("No.", Rec."No.");
        Rec.SETRANGE("Entry No.", Rec."Entry No.");
        FILTERGROUP(0);
        RecKey := Rec."No.";
        RecKey2 := Rec."Entry No.";
        CurrPage.UPDATE(FALSE);
        DoNotActivateWPClose := FALSE;


        ConfirmClose := TRUE;
        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::"Fixed Add" THEN
            Additions := TRUE
        ELSE
            Wage := TRUE;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

        /*IF ConfirmClose THEN
          BEGIN
            Response:=CONFIRM(Txt002);
            EXIT(Response);
          END
        ELSE
          EXIT(TRUE);       */
        /*
       Response :=CONFIRM(Txt001);
       IF Response THEN
         BEGIN
           ConfirmClose := FALSE;
           CloseCalc.CloseCalc(Rec);
           DoNotActivateWPClose := TRUE;
           CurrPage.CLOSE;
         END;      */

    end;

    var
        Response: Boolean;
        RecKey: Code[10];
        Step4: Page "Wage Wizard Step 4n";
        CloseCalc: Codeunit "Close Wage Calculation";
        RecKey2: Integer;
        WC: Record "Wage Calculation Temp";
        WPClose: Codeunit "Wage Precalculation";
        DoNotActivateWPClose: Boolean;
        ConfirmClose: Boolean;
        Txt001: Label 'Are you sure you wish to close this calculation?';
        Txt002: Label 'Are you sure you wish to return to previous step?';
        //NKBC R_Additions: Report "Additions";
        WCPage: Page "Wage Calculation Temp Subform";
        Txt003: Label 'Ne možete nastaviti dalje. Postoje obračun sa negativnom isplatom!';
        WCTemp: Record "Wage Calculation Temp";
        Additions: Boolean;
        Wage: Boolean;
        WageCalc: Record "Wage Calculation";
}

