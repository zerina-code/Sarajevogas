page 50031 "Wage Wizard Step 3"
{
    Caption = 'Wage Wizard Step 3-Reductions';
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

                part(SubRedMain; "Wage Wizard Step 3 Subform RM")
                {
                    ApplicationArea = all;
                }
                part(SubRedTemp; "Wage Wizard Step 3 Subform RT")
                {
                    ApplicationArea = all;
                    SubPageLink = "Wage Header No." = FIELD("No.");
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
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = all;
                RunObject = Page "Wage Wizard Step 4n";

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt002);
                    IF Response THEN BEGIN
                        ConfirmClose3 := FALSE;
                        Rec."Step 3" := TRUE;
                        CurrPage.SAVERECORD;
                        Step4.SETRECORD(Rec);
                        Step4.RUN;
                        CurrPage.EDITABLE(FALSE);
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
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        ConfirmClose3 := FALSE;
                        RedTemp.RESET;
                        IF NOT RedTemp.ISEMPTY THEN
                            RedTemp.DELETEALL;
                        WPClose.ClosedForm(Rec);
                        Rec."Step 3" := FALSE;
                        CurrPage.SAVERECORD;
                        Step2.SETRECORD(Rec);
                        Step2.RUN;
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action(Activate)
            {
                Image = ActivateDiscounts;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                begin

                    RedNo := '0000000000';
                    RedTemp.RESET;
                    IF RedTemp.FIND('+') THEN
                        RedNo := RedTemp."No.";
                    IF RedNo = '0000000000' THEN BEGIN
                        RedReal.RESET;
                        IF RedReal.FIND('+') THEN
                            RedNo := RedReal."No.";
                    END;

                    CurrPage.SubRedMain.PAGE.GETRECORD(RedMain);
                    IF RedMain."No." <> '' THEN BEGIN
                        RedReal.RESET;
                        RedReal.SETFILTER("Wage Header No.", Rec."No.");
                        RedReal.SETFILTER("Reduction No.", RedMain."No.");
                        IF NOT (RedReal.FIND('-')) THEN BEGIN
                            RedTemp.RESET;
                            RedTemp.SETFILTER("Wage Header No.", Rec."No.");
                            RedTemp.SETFILTER("Reduction No.", RedMain."No.");
                            IF NOT (RedTemp.FIND('-')) THEN
                                WITH RedTemp DO BEGIN
                                    INIT;
                                    RedNo := INCSTR(RedNo);
                                    "No." := RedNo;
                                    "Reduction No." := RedMain."No.";
                                    "Wage Header No." := Rec."No.";
                                    "Employee No." := RedMain."Employee No.";
                                    Amount := RedMain."Installment Amount";
                                    "User ID" := USERID;
                                    "Date of Calculation" := WageHeader."Date Of Calculation";
                                    INSERT;
                                END;
                        END;
                    END;
                    CurrPage.SubRedTemp.PAGE.RefreshMe(RedMain."No.");
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
        WPClose.ClosedForm(Rec);
    end;

    trigger OnInit()
    begin
        ConfirmClose3 := TRUE;
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

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin


        IF ConfirmClose3 THEN BEGIN
            Response := CONFIRM(Txt001);
            IF Response THEN
                WageHeader.RESET;
            WageHeader.SETRANGE(Status, 0);
            IF WageHeader.FIND('-') THEN
                WageHeader.DELETE;
            EXIT(Response);
        END
        ELSE
            EXIT(TRUE);
    end;

    var
        Step4: Page "Wage Wizard Step 4n";
        Response: Boolean;
        ConfirmClose3: Boolean;
        WageHeader: Record "Wage Header";
        RecKey: Code[10];
        Step2: Page "Wage Wizard Step 2";
        RedMain: Record "Reduction";
        RedTemp: Record "Reduction per Wage Temp";
        RedReal: Record "Reduction per Wage";
        RedNo: Code[20];
        RecKey2: Integer;
        WPClose: Codeunit "Wage Precalculation";
        Txt001: Label 'Do you wish to exit Wage Calculation?';
        Txt002: Label 'Are you sure you wish to go to next step?';
        Txt006: Label 'Are you sure you wish to return to previous step?';
}

