report 50029 "Form AUG-1031-Author Contracts"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Form AUG-1031-Author Contracts.rdlc';
    Caption = 'Temporary Work Form AUG-1031';

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            DataItemTableView = WHERE("Contribution Category Code" = FILTER('AUTH.CONT'));
            column(EmpNo; "No.")
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
            column(EmpName; "First Name")
            {
            }
            column(EmpMName; "Middle Name")
            {
            }
            column(EmpLName; "Last Name")
            {
            }
            column(EmpID; "Employee ID")
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
                DataItemTableView = WHERE("Wage Calculation Type" = FILTER("Author Contracts"));
                column(TaxBasis; "Tax Basis")
                {
                }
                column(Tax; Tax)
                {
                }
                column(Brutto; Brutto)
                {
                }
                column(ContributionFromBruto; "Contribution From Brutto")
                {
                }
                column(ApprovedExpenditures; "Approved Expenditures")
                {
                }
                column(PDateText; PDateText)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PDateText := FORMAT("Payment Date");

                    /*Kol10 := ("Wage Amounts"."Wage Amount" * 20) / 100;
                    Kol11 := "Wage Amounts"."Wage Amount" - Kol10;
                    Kol12 := Kol11 * 0.04;
                    Kol13 := Kol11 - Kol12;
                    Kol14 := Kol13 * 0.1;
                    Kol15 := Kol11 * 0.06;*/
                    CPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE.SETFILTER("Employee No.", '%1', "Employee No.");
                    CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                    IF CPE.FIND('-')
                    THEN
                        Kol15 := CPE."Amount Over Wage";

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
                SETFILTER("Contribution Category Code", '%1', 'TEMPWORK');
                IF CompanyInf.FIND('-') THEN BEGIN
                    CompanyNameT := CompanyInf.Name;
                    CompanyAdress := CompanyInf.Address + ', ' + CompanyInf."Post Code" + ' ' + CompanyInf.City;
                    // CompanyRegNo :=   CompanyInf
                END;
                CompanyInf.GET;
                // EMPL.GET;
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
                    }
                    field(Year; IDYear)
                    {
                        Caption = 'Year';
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

