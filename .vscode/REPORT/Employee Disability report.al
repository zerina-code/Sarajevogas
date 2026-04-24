report 50096 "Izvjestaj invalidet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Izvjestaj invalidet.rdl';

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            column(Name_CompanyInformation; Name)
            {
            }
            column(Address_CompanyInformation; Address)
            {
            }
            column(City_CompanyInformation; City)
            {
            }
            column(Picture_CompanyInformation; Picture)
            {
            }
            column(Date_CompanyInformation; FORMAT(Date_CompanyInformation, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(RegistrationNo_CompanyInformation; "Registration No.")
            {
            }
            dataitem(DataItem5; Employee)
            {
                DataItemTableView = WHERE("Disabled Person" = FILTER(true));
                column(InternalId_Employee; "Internal ID")
                {
                }
                column(No_Employee; "No.")
                {
                }
                column(PhoneNo_Employee; "Phone No.")
                {
                }
                column(AddressCIPS_Employee; "Address CIPS")
                {
                }
                column(CityCIPS_Employee; "City CIPS")
                {
                }
                column(DisabledPerson_Employee; "Disabled Person")
                {
                }
                column(DisabilityLevel_Employee; "Disability Level")
                {
                }
                column(BrutoV; BrutoV)
                { }
                column(NetoV; NetoV)

                { }
                column(DoprinosiV; DoprinosiV)
                {

                }
                column(FirstName_Employee; "First Name")
                {
                }
                column(YearsOfExperience_Employee; "Years of Experience")
                {
                }
                column(EmployeeID_Employee; "Employee ID")
                {
                }
                column(CurrentMonthsTotal_Employee; "Current Months Total")
                {
                }
                column(CurrentYearsTotal_Employee; "Current Years Total")
                {
                }
                column(CompanyMobilePhoneNo_Employee; "Company Mobile Phone No.")
                {
                }
                column(CompanyEMail_Employee; "Company E-Mail")
                {
                }
                column(LastName_Employee; "Last Name")
                {
                }
                column(EmploymentDate_Employee; FORMAT("Employment Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(TerminationDate_Employee; FORMAT("Termination Date", 0, '<day,2>.<month,2>.<year4>'))
                {
                }
                column(Description_DisabilityLevel; Description_DisabilityLevel)
                {
                }
                column(LevelofDisability_DisabilityLevel; LevelofDisability_DisabilityLevel)
                {
                }
                column(Code_DisabilityLevel; Code_DisabilityLevel)
                {
                }
                column(EngagementType_EmployeeContractLedger; EngagementType_EmployeeContractLedger)
                {
                }
                column(EndingDate_EmployeeContractLedger; EndingDate_EmployeeContractLedger)
                {
                }
                column(PositionDescription_EmployeeContractLedger; PositionDescription_EmployeeContractLedger)
                {
                }
                column(EducationLevel_AdditionalEducation; EducationLevel_AdditionalEducation)
                {
                }
                column(ContractType_EmployeeContractLedger; ContractType_EmployeeContractLedger)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Date_CompanyInformation := TODAY;

                    EmployeeLevelOfDisability1.RESET;
                    EmployeeLevelOfDisability1.SETFILTER("Employee No.", "No.");
                    EmployeeLevelOfDisability1.SETFILTER("Date From", '<=%1', ReportDate);
                    EmployeeLevelOfDisability1.SetCurrentKey("Date From");
                    EmployeeLevelOfDisability1.Ascending;
                    IF EmployeeLevelOfDisability1.FindLast() THEN BEGIN
                        Description_DisabilityLevel := EmployeeLevelOfDisability1.Description;
                        LevelofDisability_DisabilityLevel := EmployeeLevelOfDisability1."Level of Disability";
                    END ELSE BEGIN
                        Description_DisabilityLevel := '';
                        LevelofDisability_DisabilityLevel := '';
                    END;


                    WageC.Reset();
                    WageC.SetFilter("Payment Date", '<=%1', ReportDate);
                    WageC.SetFilter("Employee No.", '%1', "No.");
                    WageC.SetCurrentKey("Payment Date");
                    WageC.Ascending;
                    if WageC.FindFirst() then begin
                        BrutoV := WageC.Brutto;
                        IF ((WageC."Contribution Category Code" = 'FBIHRS') OR (WageC."Contribution Category Code" = 'BDPIORS')) THEN   // 'BPIORS'
              BEGIN
                            IF (WageC.Brutto - WageC."Contribution From Brutto" - WageC.Tax - WageC."Wage Reduction") > 0 THEN
                                NetoV := Brutto - WageC."Contribution From Brutto" - WageC.Tax - WageC."Wage Reduction"
                            ELSE
                                NetoV := 0;
                        END
                        ELSE BEGIN
                            IF (WageC."Net Wage After Tax" - WageC."Use Netto" - WageC."Wage Reduction") > 0 THEN
                                NetoV := WageC."Net Wage After Tax" - WageC."Use Netto" - WageC."Wage Reduction"
                            ELSE
                                NetoV := 0;

                        END;
                        DoprinosiV := WageC."Contribution Over Brutto" + WageC."Contribution From Brutto";



                    end
                    else begin
                        BrutoV := 0;
                        NetoV := 0;
                        DoprinosiV := 0;
                    end;

                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", "No.");
                    EmployeeContractLedger.SETFILTER("Starting Date", '<=%1', ReportDate);
                    EmployeeContractLedger.SETCURRENTKEY("Starting Date");
                    EmployeeContractLedger.ASCENDING;
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        EngagementType_EmployeeContractLedger := EmployeeContractLedger."Contract Type Name";
                        PositionDescription_EmployeeContractLedger := EmployeeContractLedger."Position Description";
                        EndingDate_EmployeeContractLedger := FORMAT(FORMAT(EmployeeContractLedger."Ending Date", 0, '<day,2>.<month,2>.<year4>'));
                        ContractType_EmployeeContractLedger := EmployeeContractLedger."Contract Type Name";
                    END ELSE BEGIN
                        EngagementType_EmployeeContractLedger := '';
                        PositionDescription_EmployeeContractLedger := '';
                        EndingDate_EmployeeContractLedger := '';
                        ContractType_EmployeeContractLedger := '';
                    END;

                    AdditionalEducation.RESET;
                    AdditionalEducation.SETFILTER("Employee No.", "No.");
                    AdditionalEducation.SETFILTER(Active, '%1', TRUE);
                    IF AdditionalEducation.FINDFIRST THEN BEGIN
                        EducationLevel_AdditionalEducation := FORMAT(AdditionalEducation."Education Level");
                    END ELSE BEGIN
                        EducationLevel_AdditionalEducation := '';
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ReportDate; ReportDate)
                {
                    Caption = 'Report Date';
                    ApplicationArea = all;
                }

            }

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
    end;

    var
        Description_DisabilityLevel: Text;
        ReportDate: Date;
        BrutoV: Decimal;
        NetoV: Decimal;
        DoprinosiV: Decimal;
        WageC: Record "Wage Calculation";
        LevelofDisability_DisabilityLevel: Text;
        Code_DisabilityLevel: Text;
        EngagementType_EmployeeContractLedger: Text;
        EmployeeLevelOfDisability1: Record "Employee Level Of Disability";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        PositionDescription_EmployeeContractLedger: Text;
        AdditionalEducation: Record "Additional Education";
        EducationLevel_AdditionalEducation: Text;
        EndingDate_EmployeeContractLedger: Text;
        Date_CompanyInformation: Date;
        ContractType_EmployeeContractLedger: Text;
}

