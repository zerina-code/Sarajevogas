report 50098 "Temporary Work Form PDN-1033"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Obrazac PDN-1033.rdl';
    Caption = 'Temporary Work Form PDN-1033';

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            RequestFilterFields = "No.";
            column(EmpNo; DataItem1."No.")
            {
            }
            column(MjesecPoreza; IDMonth)
            {
            }
            column(IDMonthText; IDMonthText)
            {
            }
            column(GodinaPoreza; IDYear)
            {
            }
            column(EmpName; DataItem1."First Name")
            {
            }
            column(EmpMName; DataItem1."Middle Name")
            {
            }
            column(EmpLName; DataItem1."Last Name")
            {
            }
            column(EmpID; DataItem1."Employee ID")
            {
            }
            column(CompanyNAme; COMPANYNAME)
            {
            }
            column(CompanyAdress; CompanyAdress)
            {
            }
            column(CompanyRegNo; CompanyRegNo)
            {
            }
            column(JIB; CompanyInf."Registration No.")
            {
            }
            column(Kol10; Kol10)
            {
            }
            column(Kol11; Kol11)
            {
            }
            column(Kol12; Kol12)
            {
            }
            column(Kol13; Kol13)
            {
            }
            column(Kol14; Kol14)
            {
            }
            column(Kol15; Kol15)
            {
            }
            dataitem(DataItem6; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = WHERE("Wage Calculation Type" = FILTER('Service Contracts-No Residents'));
                RequestFilterFields = "Payment Date";
                column(TaxBasis; DataItem6."Tax Basis")
                {
                }
                column(Tax; DataItem6.Tax)
                {
                }
                column(Brutto; DataItem6.Brutto)
                {
                }
                column(ContributionFromBruto; DataItem6."Contribution From Brutto")
                {
                }
                column(ApprovedExpenditures; DataItem6."Approved Expenditures")
                {
                }
                column(PDateText; PDateText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PDateText := FORMAT("Payment Date");


                    CPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE.SETFILTER("Employee No.", '%1', "Employee No.");
                    CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-IZ');
                    IF CPE.FIND('-')
                    THEN
                        Kol15 := CPE."Amount From Wage";

                    CPE2.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE2.SETFILTER("Employee No.", '%1', "Employee No.");
                    CPE2.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                    IF CPE2.FIND('-')
                    THEN
                        Kol12 := CPE2."Amount From Wage";
                end;

                trigger OnPreDataItem()
                begin
                    SETRANGE("Month Of Wage", IDMonth);
                    SETRANGE("Year of Wage", IDYear);
                    IF IDMonth < 10 THEN
                        IDMonthText := '0' + FORMAT(IDMonth)
                    ELSE
                        IDMonthText := FORMAT(IDMonth);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInf.SETFILTER(Name, '<>%1', '');

                IF CompanyInf.FIND('-') THEN BEGIN
                    CompanyNameT := CompanyInf.Name;
                    CompanyAdress := CompanyInf.Address + ', ' + CompanyInf."Post Code" + ' ' + CompanyInf.City;
                    // CompanyRegNo :=   CompanyInf
                END;
                CompanyInf.GET;
                // EMPL.GET;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Temporary Contract Type", '%1', 3);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Month and year';
                    field(Month; IDMonth)
                    {
                        Caption = 'Month';
                        ApplicationArea = all;

                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
                        ApplicationArea = all;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            IDMonth := DATE2DMY(CALCDATE('0D', TODAY), 2);
            IDYear := DATE2DMY(CALCDATE('0D', TODAY), 3);
        end;
    }

    labels
    {
    }

    var
        CompanyInf: Record "Company Information";
        CompanyNameT: Text[100];
        CompanyAdress: Text[100];
        CompanyRegNo: Text[30];
        Kol10: Decimal;
        Kol11: Decimal;
        Kol12: Decimal;
        Kol13: Decimal;
        Kol14: Decimal;
        Kol15: Decimal;
        CPE: Record "Contribution Per Employee";
        CPE2: Record "Contribution Per Employee";
        IDMonth: Integer;
        IDMonthText: Text[50];
        IDYear: Integer;
        PDateText: Text[100];
}