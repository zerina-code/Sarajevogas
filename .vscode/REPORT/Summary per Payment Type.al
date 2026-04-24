report 50089 "Summary per Payment Type"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Payment Type.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Value Entry")
        {
            RequestFilterFields = "Document No.", "Contribution Category Code";
            column(No_Employee; DataItem1."Employee No.")
            {
                //LL
            }
            column(PaymentType; PaymentType)
            {
            }
            column(Amount; DataItem1."Cost Amount (Netto)")
            {
            }
            column(BruttoAmount; DataItem1."Cost Amount (Brutto)")
            {
            }
            column(CostAmountActual; DataItem1."Cost Amount (Actual)")
            {
            }
            column(Name; CompanyInfo.Name)
            {
            }
            column(CEO; CompanyInfo.CEO)
            {
            }
            column(Hours; DataItem1.Hours)
            {
            }
            column(COADescription; UPPERCASE(COADescription))
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(COAType; COAType)
            {
            }
            column(ContributionFrom; ContributionFrom)
            {
            }
            column(ContributionOver; ContributionOver)
            {
            }
            column(ReductionType; ReductionType)
            {
            }
            column(Reduction; DataItem1."Reduction Type")
            {
            }
            column(Contribution; DataItem1."Contribution Type")
            {
            }
            column(ATFrom; DataItem1."AT From")
            {
            }
            column(ATFromNetto; DataItem1."AT From neto")
            {
            }
            column(Basis; DataItem1.Basis)
            {
            }
            column(PaymentTotal; PAymentNetto)
            {
            }
            column(ReductiionTotal; PaymentRed)
            {
            }
            column(ContributionFromTotal; PaymentContribution)
            {
            }
            column(ContributionOverTotal; PAymentContributionOver)
            {
            }
            column(BruttoTotal; PaymentBrutto)
            {
            }

            trigger OnAfterGetRecord()
            begin
                PaymentType := DataItem1.Description;
                if DataItem1.Description = '' then begin
                    PaymentType := "Contribution Type";
                end;
                COADescription := '';
                COA.SETFILTER("Short Code", '%1', Description);
                IF COA.FINDFIRST THEN BEGIN
                    COADescription := COA.Description;
                END
                ELSE BEGIN
                    WAT.SETFILTER(Code, '%1', Description);
                    IF WAT.FINDFIRST THEN BEGIN
                        COADescription := WAT.Description;
                    END
                    ELSE BEGIN
                        RED.SETFILTER(Code, '%1', Description);
                        IF RED.FINDFIRST THEN BEGIN
                            COADescription := RED.Description;
                        END
                        ELSE BEGIN
                            Contribution.SETFILTER("Code", '%1', "Contribution Type");
                            IF Contribution.FINDFIRST THEN BEGIN
                                COADescription := Contribution.Description;

                                //   ContributionPercentage.SETFILTER(
                                //  Percentage:=Contribution.
                            END
                            ELSE
                                /*  IF Description = '999' THEN
                                      COADescription := 'Minuli rad';*/

                                if DataItem1."Entry Type" = DataItem1."Entry Type"::"Work Experience" then
                                    COADescription := 'Minuli rad';

                            if DataItem1."Entry Type" = DataItem1."Entry Type"::Transport then
                                COADescription := 'Naknada za prevoz u novcu';

                            /*    IF Description = '830' THEN
                                    COADescription := 'Naknada za prevoz u novcu';*/

                        END;
                    END;
                END;


                /*   WageHeader.CALCFIELDS("Payment WVE");
                     WageHeader.CALCFIELDS("Payment Brutto WVE");
                    WageHeader.CALCFIELDS("Reduction WVE");
                    WageHeader.CALCFIELDS("Contribution From WVE");
                     WageHeader.CALCFIELDS("Contribution Over WVE");*/

                IF emp <> '' THEN
                    WVE.SETFILTER("Employee No.", '%1', emp);
                WVE.SETFILTER("Document No.", '%1', "Document No.");
                WVE.SETFILTER("Entry Type", '%1|%2|%3|%4|%5|%6|%7',
                WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Use, WVE."Entry Type"::"Work Experience",
                WVE."Entry Type"::Taxable, WVE."Entry Type"::Untaxable, WVE."Entry Type"::"Meal to pay", WVE."Entry Type"::Transport);
                //2,12,14,13,11,7,9);
                IF wageCalcType = 'Redovni' THEN
                    WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                IF wageCalcType = 'Dodaci' THEN
                    WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Additions);
                IF GETFILTER("Contribution Category Code") <> '' THEN
                    WVE.SETFILTER("Contribution Category Code", '%1', GETFILTER("Contribution Category Code"));

                IF WVE.FINDFIRST THEN BEGIN
                    WVE.CALCSUMS("Cost Amount (Netto)");
                    WVE.CALCSUMS("Cost Amount (Brutto)");
                    PAymentNetto := WVE."Cost Amount (Netto)";
                    PaymentBrutto := WVE."Cost Amount (Brutto)";
                END;


                IF emp <> '' THEN
                    WVE2.SETFILTER("Employee No.", '%1', emp);
                WVE2.SETFILTER("Document No.", '%1', "Document No.");
                WVE2.SETFILTER("Reduction Type", '<>%1', '');
                IF wageCalcType = 'Redovni' THEN
                    WVE2.SETFILTER("Wage Calculation Type", '%1', WVE2."Wage Calculation Type"::Regular);
                IF wageCalcType = 'Dodaci' THEN
                    WVE2.SETFILTER("Wage Calculation Type", '%1', WVE2."Wage Calculation Type"::Additions);
                IF GETFILTER("Contribution Category Code") <> '' THEN
                    WVE2.SETFILTER("Contribution Category Code", '%1', GETFILTER("Contribution Category Code"));
                //2,12,14,13,11,7,9);
                IF WVE2.FINDFIRST THEN BEGIN
                    WVE2.CALCSUMS("Cost Amount (Netto)");
                    PaymentRed := WVE2."Cost Amount (Netto)";
                END;



                IF emp <> '' THEN
                    WVE3.SETFILTER("Employee No.", '%1', emp);
                WVE3.SETFILTER("Document No.", '%1', "Document No.");
                WVE3.SETFILTER("AT From", '%1', TRUE);
                IF wageCalcType = 'Redovni' THEN
                    WVE3.SETFILTER("Wage Calculation Type", '%1', WVE3."Wage Calculation Type"::Regular);
                IF wageCalcType = 'Dodaci' THEN
                    WVE3.SETFILTER("Wage Calculation Type", '%1', WVE3."Wage Calculation Type"::Additions);
                IF GETFILTER("Contribution Category Code") <> '' THEN
                    WVE3.SETFILTER("Contribution Category Code", '%1', GETFILTER("Contribution Category Code"));
                //2,12,14,13,11,7,9);
                IF WVE3.FINDFIRST THEN BEGIN
                    WVE3.CALCSUMS("Cost Amount (Netto)");
                    PaymentContribution := WVE3."Cost Amount (Netto)";
                END;

                IF emp <> '' THEN
                    WVE4.SETFILTER("Employee No.", '%1', emp);
                WVE4.SETFILTER("Document No.", '%1', "Document No.");
                WVE4.SETFILTER("AT From", '%1', FALSE);
                WVE4.SETFILTER("AT From neto", '%1', FALSE);
                WVE4.SETFILTER("Contribution Type", '<>%1', '');
                IF wageCalcType = 'Redovni' THEN
                    WVE4.SETFILTER("Wage Calculation Type", '%1', WVE4."Wage Calculation Type"::Regular);
                IF wageCalcType = 'Dodaci' THEN
                    WVE4.SETFILTER("Wage Calculation Type", '%1', WVE4."Wage Calculation Type"::Additions);
                IF GETFILTER("Contribution Category Code") <> '' THEN
                    WVE4.SETFILTER("Contribution Category Code", '%1', GETFILTER("Contribution Category Code"));
                //2,12,14,13,11,7,9);
                IF WVE4.FINDFIRST THEN BEGIN
                    WVE4.CALCSUMS("Cost Amount (Netto)");
                    PAymentContributionOver := WVE4."Cost Amount (Netto)";
                END;

            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Entry Type",'%1|%2|%3|%4|%5|%6|%7|%8|%9',2,6,7,9,10,11,12,13,14);
                SETFILTER("Entry Type", '<>%1', 0);

                CompanyInfo.GET;
                COADescription := '';
                Base := 0;
                WHNo := GETFILTER("Document No.");
                IF WHNo <> '' THEN BEGIN
                    WageHeader.GET(WHNo);
                    StartDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", TRUE);
                    EndDate := AbsenceFill.GetMonthRange(WageHeader."Month Of Wage", WageHeader."Year Of Wage", FALSE);


                END;

                COAType := FALSE;
                ContributionFrom := FALSE;
                ContributionOver := FALSE;
                ReductionType := FALSE;
                Percentage := 0;
                emp := GETFILTER("Employee No.");
                PAymentNetto := 0;
                PaymentBrutto := 0;
                PaymentContribution := 0;
                PAymentContributionOver := 0;
                PaymentRed := 0;
                IF GETFILTER("Wage Calculation Type") <> '' THEN
                    wageCalcType := GETFILTER("Wage Calculation Type");
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
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

        T_HumanResourceSetup.GET;
    end;

    var
        T_HumanResourceSetup: Record "Human Resources Setup";
        CompanyInfo: Record "Company Information";
        COA: Record "Cause of Absence";
        COADescription: Text[250];
        WAT: Record "Wage Addition Type";
        RED: Record "Reduction types";
        AbsenceFill: Codeunit "Absence Fill";
        StartDate: Date;
        EndDate: Date;
        WHNo: Text;
        WageHeader: Record "Wage Header";
        Contribution: Record "Contribution";
        COAType: Boolean;
        ContributionFrom: Boolean;
        ContributionOver: Boolean;
        ReductionType: Boolean;
        COADescriptionR: Text[250];
        Percentage: Decimal;
        ContributionPercentage: Record "Contribution Category Conn.";
        WVE: Record "Wage Value Entry";
        emp: Code[10];
        PAymentNetto: Decimal;
        PaymentBrutto: Decimal;
        PaymentContribution: Decimal;
        PaymentType: text[250];
        PaymentRed: Decimal;
        WVE2: Record "Wage Value Entry";
        WVE3: Record "Wage Value Entry";
        WVE4: Record "Wage Value Entry";
        PAymentContributionOver: Decimal;
        CPE: Record "Contribution Per Employee";
        Base: Decimal;
        wageCalcType: Text;
}

