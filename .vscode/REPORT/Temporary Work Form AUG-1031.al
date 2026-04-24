report 50006 "Temporary Work Form AUG-1031"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Obrazac AUG-1031.rdl';
    Caption = 'Temporary Work Form AUG-1031';

    dataset
    {
        dataitem(DataItem1; "Employee")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView = '';
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
            column(SumKol15; SumKol15)
            {
            }
            column(SumKol12; SumKol12)
            {
            }
            dataitem(DataItem6; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                RequestFilterFields = "Payment Date", "No.";
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
                column(PDate; DataItem6."Payment Date")
                {
                }
                column(PDateText; PDateText)
                {
                }
                column(NetWage; DataItem6."Net Wage After Tax")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    PDateText := FORMAT(TODAY);
                    Kol15 := 0;
                    Kol12 := 0;
                    CPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE.SETFILTER("Employee No.", '%1', DataItem1."No.");
                    CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                    CPE.SETFILTER("Payment Date", '%1', "Payment Date");
                    CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                    IF CPE.FIND('-')
                    THEN
                        REPEAT
                            Kol15 += CPE."Amount Over Wage";
                        UNTIL CPE.NEXT = 0;

                    CPE2.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE2.SETFILTER("Employee No.", '%1', DataItem1."No.");
                    CPE2.SETFILTER("Payment Date", '%1', "Payment Date");
                    CPE2.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                    CPE2.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                    IF CPE2.FIND('-')
                    THEN
                        REPEAT
                            Kol12 += CPE2."Amount From Wage";
                        UNTIL CPE2.NEXT = 0;


                    CPE.RESET;
                    CPE.SETCURRENTKEY("Wage Header No.", "Entry No.", "Contribution Code", "Employee No.");
                    CPE.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                    CPE.SETFILTER("Payment Date", '%1', "Payment Date");
                    CPE.SETFILTER("Contribution Category Code", '<>%1 & <>%2 & <>%3', 'NO', 'OR', 'SK');
                    IF Empfilter <> '' THEN
                        CPE.SETFILTER("Employee No.", '%1', Empfilter);
                    CPE.SETFILTER("Contribution Code", '%1', 'D-PIO-NA');
                    CPE.CALCSUMS("Amount Over Wage");
                    SumKol15 := CPE."Amount Over Wage";


                    CPE2.RESET;
                    CPE2.SETCURRENTKEY("Wage Header No.", "Entry No.", "Contribution Code", "Employee No.");
                    CPE2.SETFILTER("Wage Header No.", '%1', "Wage Header No.");
                    CPE2.SETFILTER("Payment Date", '%1', "Payment Date");
                    CPE2.SETFILTER("Contribution Category Code", '<>%1 & <>%2 & <>%3', 'NO', 'OR', 'SK');
                    IF Empfilter <> '' THEN
                        CPE2.SETFILTER("Employee No.", '%1', Empfilter);
                    CPE2.SETFILTER("Wage Calculation Type", '%1|%2', 1, 2);
                    CPE2.SETFILTER("Contribution Code", '%1', 'D-ZDRAV-IZ');
                    CPE2.CALCSUMS("Amount From Wage");
                    SumKol12 := CPE2."Amount From Wage";
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
                SETFILTER("Temporary Contract Type", '%1|%2|%3', 1, 2, 4);
                SETFILTER("Contribution Category Code", '<>%1 & <>%2 & <>%3', 'NO', 'OR', 'SK');
                Empfilter := GETFILTER("No.")
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
        PDateText: Text[10];
        SumKol12: Decimal;
        SumKol15: Decimal;
        Empfilter: Text[1024];
}

