page 50025 "Wage Wizard Step 4n"
{
    Caption = 'Wage Wizard Step 4-Errors';
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
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Last Calculation In Month"; "Last Calculation In Month")
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
                field("Closing Date"; "Closing Date")
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

                part(ErrorSubform; "Wage Wizard Step 4 Subform Err")

                {
                    ApplicationArea = all;
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
                field("Minimum Wage"; "Minimum Wage")
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
                field("Temp Added Tax Per City"; "Temp Added Tax Per City")
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
            action(Cancel)
            {
                Image = Cancel;
                Promoted = true;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CurrPage.CLOSE;
                end;
            }
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin
                    //NKBC ErrTab.SETFILTER("Transport Amount", '<>%1', 0);
                    //NKBC IF ErrTab.FINDFIRST THEN
                    //NKBC  REPEAT
                    //NKBC   Employee.SETFILTER("No.", '%1', ErrTab.Value);
                    //NKBC IF Employee.FINDFIRST THEN BEGIN
                    //NKBC    Employee."Transport Confirmed" := TRUE;
                    //NKBC  Employee.MODIFY;
                    //NKBC   ErrTab.DELETE;
                    //NKBC END;
                    //NKBC UNTIL ErrTab.NEXT = 0;


                    BEGIN
                        ConfirmClose := FALSE;
                        CurrPage.SAVERECORD;
                        HasError := FALSE;

                        WagePrecalculation.RunPrecalculation(Rec, HasError);
                        IF HasError THEN BEGIN
                            CurrPage.SAVERECORD;

                            COMMIT;
                            ErrorsForm.SETRECORD(Rec);
                            ErrorsForm.RUNMODAL;
                        END
                        ELSE BEGIN
                            CurrPage.SAVERECORD;

                            CLEAR(CalcWage);
                            CalcWage.DeleteTemps;
                            CalcWage.RUN(Rec);
                            CurrPage.EDITABLE(FALSE);
                            COMMIT;
                            FinalForm.SETRECORD(Rec);
                            FinalForm.RUNMODAL;
                        END;
                        CurrPage.CLOSE;
                    END;
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

    trigger OnOpenPage()
    begin
        FILTERGROUP(10);
        Rec.SETFILTER("No.", Rec."No.");
        Rec.SETRANGE("Entry No.", Rec."Entry No.");
        RecKey := Rec."No.";
        RecKey2 := Rec."Entry No.";
        FILTERGROUP(0);
    end;

    var
        RecKey: Code[10];
        ConfirmClose4: Boolean;
        RecKey2: Integer;
        Txt001: Label 'Are you sure you wish to go to next step?';
        Txt002: Label 'Critical errors were not corrected!';
        Txt006: Label 'Are you sure you wish to return to previous step?';
        Txt003: Label 'Do you wish to exit Wage Calculation?';
        TxtAddTaxFrom: Label 'Additional taxes from wages were not defined!';
        TxtAddTAxOver: Label 'Additional taxes over wages were not defined!';
        TxtTax: Label 'Taxes were not defined!';
        Response: Boolean;
        ConfirmClose: Boolean;
        WPClose: Codeunit "Wage Precalculation";
        Step1: Page "Wage Wizard Step 1";
        Step4: Page "Wage Wizard Step 4n";
        HasError: Boolean;
        WagePrecalculation: Codeunit "Wage Precalculation";
        WageCalc: Record "Wage Calculation";
        ErrorsForm: Page "Wage Wizard Step 4n";
        CalcWage: Codeunit "Wage Calculation";
        FinalForm: Page "Wage Wizard Step 5";
        ErrTab: Record "Error Buffer";
        Employee: Record "Employee";
}

