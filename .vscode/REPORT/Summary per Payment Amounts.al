report 50086 "Summary per Payment Amounts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Payment Amounts.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Value Entry")
        {
            RequestFilterFields = "Document No.", "Contribution Category Code";
            column(No_Employee; DataItem1."Employee No.")
            {
            }
            column(PaymentType; DataItem1.Description)
            {
            }
            column(Amount; DataItem1."Cost Amount (Netto)")
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
            column(PaymentTotal; WageHeader."Payment WVE")
            {
            }
            column(ReductiionTotal; WageHeader."Reduction WVE")
            {
            }
            column(ContributionFromTotal; WageHeader."Contribution From WVE")
            {
            }
            column(ContributionOverTotal; WageHeader."Contribution Over WVE")
            {
            }
            column(InternalID; InternalID)
            {
            }
            column(EmpName; EmpName)
            {
            }
            column(PostingGroup; PostingGroup)
            {
            }

            trigger OnAfterGetRecord()
            begin
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
                            Contribution.SETFILTER("Short Code", '%1', Description);
                            IF Contribution.FINDFIRST THEN BEGIN
                                COADescription := Contribution.Description;
                                //   ContributionPercentage.SETFILTER(
                                //  Percentage:=Contribution.
                            END
                            ELSE
                                IF Description = '999' THEN
                                    COADescription := 'Minuli rad';
                            IF Description = '830' THEN
                                COADescription := 'Naknada za prevoz u novcu';

                        END;
                    END;
                END;

                IF Emp.GET("Employee No.") THEN BEGIN
                    InternalID := Emp."No.";
                    EmpName := Emp."First Name" + ' ' + Emp."Last Name";
                    PostingGroup := Emp."Contribution Category Code";
                END;
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Entry Type",'%1|%2|%3|%4|%5|%6|%7|%8|%9',2,6,7,9,10,11,12,13,14);
                SETFILTER("Entry Type", '<>%1', 0);
                SETFILTER("Contribution Type", '%1', '');
                SETFILTER("Reduction Type", '%1', '');
                CompanyInfo.GET;
                COADescription := '';

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
                InternalID := '';
                EmpName := '';
                PostingGroup := '';
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
        Emp: Record "Employee";
        InternalID: Text[250];
        EmpName: Text[250];
        PostingGroup: Code[10];
}

