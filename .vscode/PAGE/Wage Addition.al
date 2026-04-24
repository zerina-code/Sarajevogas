page 50032 "Wage Addition"
{
    Caption = 'Wage Addition';
    PageType = List;
    SourceTable = "Wage Addition";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group("K")
            {
                Caption = 'K';
                field("Wage Year"; YearFilter)
                {
                    Caption = 'Wage Year';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        WA.SETFILTER("Wage Header No.", '%1', '');
                        IF WA.FINDFIRST THEN
                            REPEAT
                            BEGIN
                                WA."Year of Wage" := YearFilter;
                                WA.MODIFY;
                            END
                            UNTIL WA.NEXT = 0;

                    end;
                }
                field("Wage Month"; MonthFilter)
                {
                    ApplicationArea = all;
                    Caption = 'Wage Month';

                    trigger OnValidate()
                    begin
                        WA.SETFILTER("Wage Header No.", '%1', '');
                        IF WA.FINDFIRST THEN
                            REPEAT
                            BEGIN
                                WA."Month of Wage" := MonthFilter;
                                WA.MODIFY;
                            END
                            UNTIL WA.NEXT = 0;

                    end;
                }
            }
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Internal ID"; "Internal ID")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Wage Addition Type"; "Wage Addition Type")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("No. Of Hours"; "No. Of Hours")
                {
                    ApplicationArea = all;
                }
                field("No. Of Days"; "No. Of Days")
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field(Brutto; Brutto)
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field("Amount to Pay"; "Amount to Pay") { ApplicationArea = all; }
                field("Year of Wage"; "Year of Wage")
                {
                    ApplicationArea = all;
                }
                field("Month of Wage"; "Month of Wage")
                {
                    ApplicationArea = all;
                }
                field("Sent e-mail"; "Sent e-mail")
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
            action("Insert Additional Wage")
            {
                Caption = 'Insert Additional Wage';
                Image = RollUpCosts;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WAM: Record "Wage Addition";
                    WAM2: Record "Wage Addition";
                    emp: Record "Employee";
                    ConCat: Record "Contribution Category";
                begin
                    MAI.Reset();
                    MAI.SETFILTER("Misc. Article Code", '%1', '1312');
                    MAI.SETFILTER("To Date", '%1', 0D);
                    IF MAI.FIND('-') THEN
                        REPEAT

                            WAM.INIT;
                            IF WAM2.FINDLAST THEN
                                WAM."Entry No." := WAM2."Entry No." + 1
                            ELSE
                                WAM."Entry No." := 0;
                            WAM.VALIDATE("Employee No.", MAI."Employee No.");
                            WageSetup.GET;
                            WAM.VALIDATE("Wage Addition Type", WageSetup."Additional Wage Code");

                            IF WAmount.GET(MAI."Employee No.") THEN BEGIN
                                ConCat.SETFILTER(Code, '%1', WAM."Contribution Category Code");
                                IF ConCat.FINDSET THEN BEGIN
                                    ConCat.CALCFIELDS("From Brutto");
                                    IF DATE2DMY(WORKDATE, 2) <= 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 1, 6);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, (wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100));

                                        END;
                                    END;
                                    IF DATE2DMY(WORKDATE, 2) > 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 1, 6);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, (wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100));

                                        END;
                                    END;

                                END;
                            END;
                            WAM.VALIDATE("Year of Wage", DATE2DMY(WORKDATE, 3));
                            WAM.VALIDATE("Month of Wage", DATE2DMY(WORKDATE, 2));
                            WAM.INSERT(TRUE);


                        UNTIL MAI.NEXT = 0;

                    MAI.RESET;
                    WAM.RESET;
                    WAM2.RESET;
                    MAI.SETFILTER("Misc. Article Code", '%1', '1312');
                    MAI.SETFILTER("To Date", '<=%1', AbsenceFill.GetMonthRange(DATE2DMY(WORKDATE, 2), DATE2DMY(WORKDATE, 3), FALSE));

                    //StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
                    //EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);
                    IF MAI.FIND('-') THEN
                        REPEAT

                            WAM.INIT;
                            IF WAM2.FINDLAST THEN
                                WAM."Entry No." := WAM2."Entry No." + 1
                            ELSE
                                WAM."Entry No." := 0;
                            WAM.VALIDATE("Employee No.", MAI."Employee No.");
                            WageSetup.GET;
                            WAM.VALIDATE("Wage Addition Type", WageSetup."Additional Wage Code");

                            IF WAmount.GET(MAI."Employee No.") THEN BEGIN
                                ConCat.SETFILTER(Code, '%1', WAM."Contribution Category Code");
                                IF ConCat.FINDSET THEN BEGIN
                                    ConCat.CALCFIELDS("From Brutto");
                                    IF DATE2DMY(WORKDATE, 2) <= 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 1, 6);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, (wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100));

                                        END;
                                    END;
                                    IF DATE2DMY(WORKDATE, 2) > 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 7, 12);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, (wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100));

                                        END;
                                    END;
                                END;
                            END;
                            WAM.VALIDATE("Year of Wage", DATE2DMY(WORKDATE, 3));
                            WAM.VALIDATE("Month of Wage", DATE2DMY(WORKDATE, 2));
                            WAM.INSERT(TRUE);


                        UNTIL MAI.NEXT = 0;
                end;
            }
            action("Insert Half Additional Wage")
            {
                Caption = 'Insert Additional Wage';
                Image = SalesTax;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    WAM: Record "Wage Addition";
                    WAM2: Record "Wage Addition";
                    emp: Record "Employee";
                    ConCat: Record "Contribution Category";
                begin
                    MAI.Reset();
                    MAI.SETFILTER("Misc. Article Code", '%1', '1312');
                    MAI.SETFILTER("To Date", '%1', 0D);
                    IF MAI.FIND('-') THEN
                        REPEAT

                            WAM.INIT;
                            IF WAM2.FINDLAST THEN
                                WAM."Entry No." := WAM2."Entry No." + 1
                            ELSE
                                WAM."Entry No." := 0;
                            WAM.VALIDATE("Employee No.", MAI."Employee No.");
                            WageSetup.GET;
                            WAM.VALIDATE("Wage Addition Type", WageSetup."HAlf Additional Wage Code");

                            IF WAmount.GET(MAI."Employee No.") THEN BEGIN
                                ConCat.SETFILTER(Code, '%1', WAM."Contribution Category Code");
                                IF ConCat.FINDSET THEN BEGIN
                                    ConCat.CALCFIELDS("From Brutto");
                                    IF DATE2DMY(WORKDATE, 2) <= 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 1, 6);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, ((wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100)) / 2);

                                        END;
                                    END;
                                    IF DATE2DMY(WORKDATE, 2) > 6 THEN BEGIN
                                        wc.RESET;
                                        wc.SETFILTER("Month Of Wage", '%1..%2', 7, 12);
                                        wc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
                                        wc.SETFILTER("Employee No.", '%1', MAI."Employee No.");
                                        IF wc.FINDFIRST THEN BEGIN
                                            wc.CALCSUMS("Wage (Base)");
                                            WAM.VALIDATE(Amount, ((wc."Wage (Base)" / wc.COUNT) - ((wc."Wage (Base)" / wc.COUNT) * ConCat."From Brutto" / 100)) / 2);

                                        END;
                                    END;
                                END;
                            END;

                            WAM.VALIDATE("Year of Wage", DATE2DMY(WORKDATE, 3));
                            WAM.VALIDATE("Month of Wage", DATE2DMY(WORKDATE, 2));
                            WAM.INSERT(TRUE);


                        UNTIL MAI.NEXT = 0;
                    /*
                    MAI.RESET;
                    WAM.RESET;
                    WAM2.RESET;
                    MAI.SETFILTER("Misc. Article Code",'%1',1312);
                    MAI.SETFILTER("To Date",'<%1',AbsenceFill.GetMonthRange(DATE2DMY(WORKDATE,2), DATE2DMY(WORKDATE,3), FALSE));
                    
                    //StartDate := GetMonthRange(CurrentMonth, CurrentYear, TRUE);
                    //EndDate := GetMonthRange(CurrentMonth, CurrentYear, FALSE);
                    IF MAI.FIND('-') THEN REPEAT
                    
                       WAM.INIT;
                        IF WAM2.FINDLAST THEN
                       WAM."Entry No.":=WAM2."Entry No."+1
                        ELSE
                          WAM."Entry No.":=0;
                       WAM.VALIDATE("Employee No.",MAI."Employee No.");
                       WageSetup.GET;
                       WAM.VALIDATE("Wage Addition Type",WageSetup."Additional Wage Code");
                    
                       IF WAmount.GET(MAI."Employee No.") THEN BEGIN
                            ConCat.SETFILTER(Code,'%1',WAM."Contribution Category Code");
                          IF ConCat.FINDSET THEN
                            BEGIN
                                  ConCat.CALCFIELDS("From Brutto");
                       WAM.VALIDATE(Amount,WAmount."Wage Amount"-(WAmount."Wage Amount"*ConCat."From Brutto"/100));
                         END; END;
                       WAM.VALIDATE("Year of Wage",DATE2DMY(WORKDATE,3));
                       WAM.VALIDATE("Month of Wage",DATE2DMY(WORKDATE,2));
                       WAM.INSERT(TRUE);
                    
                    
                    UNTIL MAI.NEXT=0;*/

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        IF Employee.GET("Employee No.") THEN
            Name := Employee."Last Name" + ' ' + Employee."First Name"
        ELSE
            Name := '';
    end;

    trigger OnInit()
    begin
        //WH.FINDFIRST;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "Month of Wage" := MonthFilter;
        "Year of Wage" := YearFilter;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Name := '';
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
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        MonthFilter := DATE2DMY(WORKDATE, 2);
        YearFilter := DATE2DMY(WORKDATE, 3);
        SETFILTER("Wage Header No.", '%1', '');
        /*
        SetFilters;*/

    end;

    var
        Name: Text[250];
        Employee: Record "Employee";
        YearFilter: Integer;
        MonthFilter: Integer;
        WageSetup: Record "Wage Setup";
        WH: Record "Wage Header";
        WagePrecalculation: Codeunit "Wage Precalculation";
        R_WorkExperience: Report "Work experience in Company";
        R_BroughtExperience: Report "Update Brought Experience";
        HasError: Boolean;
        CalcWage: Codeunit "Wage Calculation";
        WA: Record "Wage Addition";
        MAI: Record "Misc. article information";
        WAmount: Record "Wage Amounts";
        AbsenceFill: Codeunit "Absence Fill";
        wc: Record "Wage Calculation";

    procedure SetFilters()
    begin
        /*Rec.FILTERGROUP(2);
        Rec.SETRANGE("Month of Wage",MonthFilter);
        Rec.SETRANGE("Year of Wage",YearFilter);
        Rec.FILTERGROUP(0);*/
        //IF Rec."Employee No." = '' THEN Rec.DELETE;
        //CurrForm.UPDATECONTROLS;

    end;
}

