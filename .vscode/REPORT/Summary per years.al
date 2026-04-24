report 50037 "Summary per years"
{

    DefaultLayout = RDLC;
    RDLCLayout = './SummaryPerYears.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Summary per years';

    dataset
    {
        dataitem(DataItemName; Integer)
        {
            /*  DataItemTableView = SORTING(Number)
                                          WHERE(Number = CONST(1..3));*/
            column(ColumnName; Year)
            {
            }
            column(BrojZaposlenih1; BrojZaposlenih[1] [1]) { }
            column(Bruto1; BrojZaposlenih[1] [2]) { }
            column(DatumUplate1; PaymentDate[1] [1]) { }

            column(BrojZaposlenih2; BrojZaposlenih[2] [1]) { }
            column(Bruto2; BrojZaposlenih[2] [2]) { }
            column(DatumUplate2; PaymentDate[2] [1]) { }

            column(BrojZaposlenih3; BrojZaposlenih[3] [1]) { }
            column(Bruto3; BrojZaposlenih[3] [2]) { }
            column(DatumUplate3; PaymentDate[3] [1]) { }

            column(BrojZaposlenih4; BrojZaposlenih[4] [1]) { }
            column(Bruto4; BrojZaposlenih[4] [2]) { }
            column(DatumUplate4; PaymentDate[4] [1]) { }
            column(BrojZaposlenih5; BrojZaposlenih[5] [1]) { }
            column(Bruto5; BrojZaposlenih[5] [2]) { }
            column(DatumUplate5; PaymentDate[5] [1]) { }

            column(BrojZaposlenih6; BrojZaposlenih[6] [1]) { }
            column(Bruto6; BrojZaposlenih[6] [2]) { }
            column(DatumUplate6; PaymentDate[6] [1]) { }

            column(BrojZaposlenih7; BrojZaposlenih[7] [1]) { }
            column(Bruto7; BrojZaposlenih[7] [2]) { }
            column(DatumUplate7; PaymentDate[7] [1]) { }

            column(BrojZaposlenih8; BrojZaposlenih[8] [1]) { }
            column(Bruto8; BrojZaposlenih[8] [2]) { }
            column(DatumUplate8; PaymentDate[8] [1]) { }


            column(BrojZaposlenih9; BrojZaposlenih[9] [1]) { }
            column(Bruto9; BrojZaposlenih[9] [2]) { }
            column(DatumUplate9; PaymentDate[9] [1]) { }


            column(BrojZaposlenih10; BrojZaposlenih[10] [1]) { }
            column(Bruto10; BrojZaposlenih[10] [2]) { }
            column(DatumUplate10; PaymentDate[10] [1]) { }

            column(BrojZaposlenih11; BrojZaposlenih[11] [1]) { }
            column(Bruto11; BrojZaposlenih[11] [2]) { }
            column(DatumUplate11; PaymentDate[11] [1]) { }

            column(BrojZaposlenih12; BrojZaposlenih[12] [1]) { }
            column(Bruto12; BrojZaposlenih[12] [2]) { }
            column(DatumUplate12; PaymentDate[12] [1]) { }
            column(Name_CompanyInformation; CompInf.Name)
            {
            }
            column(Address_CompanyInformation; CompInf.Address)
            {
            }
            column(City_CompanyInformation; CompInf.City)
            {
            }
            column(Picture_CompanyInformation; CompInf.Picture)
            {
            }
            column(Date_CompanyInformation; FORMAT(Date_CompanyInformation, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(RegistrationNo_CompanyInformation; CompInf."Registration No.")
            {
            }
            column(Year; Year) { }

            column(PaymentDate1; PaymentDate[1] [1]) { }
            column(PaymentDate2; PaymentDate[1] [1]) { }
            column(PaymentDate3; PaymentDate[1] [1]) { }
            column(PaymentDate4; PaymentDate[1] [1]) { }
            column(PaymentDate5; PaymentDate[1] [1]) { }
            column(PaymentDate6; PaymentDate[1] [1]) { }
            column(PaymentDate7; PaymentDate[1] [1]) { }
            column(PaymentDate8; PaymentDate[1] [1]) { }
            column(PaymentDate9; PaymentDate[1] [1]) { }
            column(PaymentDate10; PaymentDate[1] [1]) { }
            column(PaymentDate11; PaymentDate[1] [1]) { }
            column(PaymentDate12; PaymentDate[1] [1]) { }

            column(BrojInvalida1; BrojInvalida[1] [1]) { }
            column(BrojInvalida2; BrojInvalida[2] [1]) { }
            column(BrojInvalida3; BrojInvalida[3] [1]) { }
            column(BrojInvalida4; BrojInvalida[4] [1]) { }
            column(BrojInvalida5; BrojInvalida[5] [1]) { }
            column(BrojInvalida6; BrojInvalida[6] [1]) { }
            column(BrojInvalida7; BrojInvalida[7] [1]) { }
            column(BrojInvalida8; BrojInvalida[8] [1]) { }
            column(BrojInvalida9; BrojInvalida[9] [1]) { }
            column(BrojInvalida10; BrojInvalida[10] [1]) { }
            column(BrojInvalida11; BrojInvalida[11] [1]) { }
            column(BrojInvalida12; BrojInvalida[12] [1]) { }

            column(ProsjekNeto1; ProsjekNeto[1] [1]) { }
            column(ProsjekNeto2; ProsjekNeto[2] [1]) { }
            column(ProsjekNeto3; ProsjekNeto[3] [1]) { }
            column(ProsjekNeto4; ProsjekNeto[4] [1]) { }
            column(ProsjekNeto5; ProsjekNeto[5] [1]) { }
            column(ProsjekNeto6; ProsjekNeto[6] [1]) { }
            column(ProsjekNeto7; ProsjekNeto[7] [1]) { }
            column(ProsjekNeto8; ProsjekNeto[8] [1]) { }
            column(ProsjekNeto9; ProsjekNeto[9] [1]) { }
            column(ProsjekNeto10; ProsjekNeto[10] [1]) { }
            column(ProsjekNeto11; ProsjekNeto[11] [1]) { }
            column(ProsjekNeto12; ProsjekNeto[12] [1]) { }
            column(Doprinos1; Doprinos[1] [1]) { }
            column(Doprinos2; Doprinos[2] [1]) { }
            column(Doprinos3; Doprinos[3] [1]) { }
            column(Doprinos4; Doprinos[4] [1]) { }
            column(Doprinos5; Doprinos[5] [1]) { }
            column(Doprinos6; Doprinos[6] [1]) { }
            column(Doprinos7; Doprinos[7] [1]) { }
            column(Doprinos8; Doprinos[8] [1]) { }
            column(Doprinos9; Doprinos[9] [1]) { }
            column(Doprinos10; Doprinos[10] [1]) { }
            column(Doprinos11; Doprinos[11] [1]) { }
            column(Doprinos12; Doprinos[12] [1]) { }
            column(BrutoI1; BrutoI[1] [1]) { }
            column(BrutoI2; BrutoI[2] [1]) { }
            column(BrutoI3; BrutoI[3] [1]) { }
            column(BrutoI4; BrutoI[4] [1]) { }
            column(BrutoI5; BrutoI[5] [1]) { }
            column(BrutoI6; BrutoI[6] [1]) { }
            column(BrutoI7; BrutoI[7] [1]) { }
            column(BrutoI8; BrutoI[8] [1]) { }
            column(BrutoI9; BrutoI[9] [1]) { }
            column(BrutoI10; BrutoI[10] [1]) { }
            column(BrutoI11; BrutoI[11] [1]) { }
            column(BrutoI12; BrutoI[12] [1]) { }

            trigger OnAfterGetRecord()
            begin
                Year := date2dmy(ReportDateFrom, 3) + Number - 1;
                for myInt := 1 to 12 do begin
                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    BrojZaposlenih[myInt, 1] := WageCalc.Count;
                    WageCalc.CalcSums(Brutto);
                    BrojZaposlenih[myInt, 2] := WageCalc.Brutto;

                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    WageCalc.SetFilter("Employee Disability", '%1', true);
                    WageCalc.CalcSums(Brutto);
                    BrutoI[myInt, 1] := WageCalc.Brutto;


                    PaymentDate[myInt, 1] := WageCalc."Payment Date";
                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    WageCalc.CalcSums("Contribution From Brutto", "Contribution Over Brutto");
                    Doprinos[myInt, 1] := WageCalc."Contribution From Brutto" + WageCalc."Contribution From Brutto";
                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    WageCalc.SetFilter("Employee Disability", '%1', true);
                    BrojInvalida[myInt, 1] := WageCalc.Count;

                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    WageCalc.SetFilter("Contribution Category Code", '<>%1 & <>%2', 'FBIHRS', 'BDPIORS');
                    WageCalc.CalcSums("Net Wage After Tax", "Wage Reduction");
                    WH.Reset();
                    WH.SetFilter("Month Of Wage", '%1', myInt);
                    WH.SetFilter("Year Of Wage", '%1', Year);
                    if WH.FindFirst() then begin

                        WA.Reset();
                        WA.SetFilter("Wage Header No.", '%1', WH."No.");
                        WA.SetFilter(Use, '%1', true);
                        WA.CalcSums("Calculated Amount");

                    end
                    else begin
                        WA."Calculated Amount" := 0;

                    end;


                    ProsjekNeto[myInt, 1] := WageCalc."Net Wage After Tax" - WA."Calculated Amount" - WageCalc."Wage Reduction";

                    WageCalc.Reset();
                    WageCalc.SetFilter("Month Of Wage", '%1', myInt);
                    WageCalc.SetFilter("Year of Wage", '%1', Year);
                    WageCalc.SetFilter("Contribution Category Code", '%1|%2', 'FBIHRS', 'BDPIORS');
                    WageCalc.CalcSums(Brutto, "Contribution From Brutto", "Tax", "Wage Reduction");
                    if BrojZaposlenih[myInt, 1] <> 0 then
                        ProsjekNeto[myInt, 1] := (ProsjekNeto[myInt, 1] + WageCalc.Brutto - WageCalc."Contribution From Brutto" - WageCalc.Tax - WageCalc."Wage Reduction") / (BrojZaposlenih[myInt, 1])
                    else
                        ProsjekNeto[myInt, 1] := 0;


                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if ReportDateFrom = 0D then
                    Error('Date from must have value!');
                if ReportDateTo = 0D then
                    Error('Date to must have value!');
                SetFilter(Number, '%1..%2', 1, Date2DMY(ReportDateTo, 3) - Date2DMY(ReportDateFrom, 3) + 1);
                CompInf.get();
                CompInf.CalcFields(Picture);
                Date_CompanyInformation := Today;



            end;
        }

    }


    requestpage
    {
        layout
        {
            area(Content)
            {

                field("Report Date From"; ReportDateFrom)
                {
                    ApplicationArea = All;
                    Caption = 'Report Date From';

                }
                field(ReportDateTo; ReportDateTo)
                {
                    ApplicationArea = all;
                    Caption = 'Report Date To';
                }

            }
        }


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
        myInt: Integer;
        CompInf: Record "Company Information";
        Date_CompanyInformation: Date;

        SourceFieldName: Text;
        BrojZaposlenih: array[12, 6] of Decimal;
        PaymentDate: array[12, 1] of Date;
        BrojInvalida: array[12, 1] of Integer;
        WA: Record "Wage Addition";
        BrutoI: array[12, 1] of Decimal;
        WH: Record "Wage Header";
        ProsjekNeto: array[12, 1] of Decimal;
        Doprinos: array[12, 1] of Decimal;
        Year: Integer;
        ReportDateFrom: Date;
        ReportDateTo: Date;
        WageCalc: Record "Wage Calculation";

}