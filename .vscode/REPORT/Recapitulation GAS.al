report 50183 "Recapitulation GAS"
{
    // BH1.00, Fiscal Process
    // BH1.01, Invoice elements
    DefaultLayout = RDLC;
    RDLCLayout = './Recapitulacion GAS.rdl';

    Caption = 'Recapitulacion GAS';
    //Permissions = TableData 7190 = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem5581; "Calculation Journal Line")
        {


            column(Customer_No_; "Customer No.") { }


            column(Customer_string; "Customer string") { }
            column(Customer_Stroke; "Customer Stroke") { }
            column(TotalDigital; TotalDigital) { }
            column(TotD; TotD) { }
            column(CompanyInfo2Picture; comp.Picture)
            {
            }
            column(DwellingRez; DwellingRez) { }
            column(TotM; TotM) { }
            column(TotU; TotU) { }
            column(TotalManual; TotalManual) { }
            column(TotalSum; TotalSum) { }
            column(Slovarica; Slovarica) { }
            column(ReportDate; format(ReportDate, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Mjesec; Mjesec) { }
            column(Godina; Godina) { }
            column(SlovaricaT; SlovaricaT) { }


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CH: Record "Calcuation Header";
                CalCJ: Record "Calculation Journal Line";
                ShortText: text;
                BrojBezUnosa: Integer;
            begin
                TotalManual := 0;
                DwellingRez := '';
                BrojBezUnosa := 0;
                TotalDigital := 0;
                comp.get;
                comp.calcfields(Picture);
                ReportDate := today;

                DwellingText := '';
                DwellingType.Reset();
                if DwellingType.FindSet() then
                    repeat

                        CalCJ.Reset();
                        CalCJ.CopyFilters(DataItem5581);
                        CalCJ.SetFilter("Customer Stroke", '%1', DataItem5581."Customer Stroke");
                        CalCJ.SetFilter("Dwelling Type", '%1', DwellingType."Description");
                        if CalCJ.FindFirst() then begin

                            if DwellingType."Short Description" <> '' then
                                DwellingText += DwellingType."Short Description" + ' ' + format(CalCJ.Count) + ' '
                            else
                                BrojBezUnosa += CalCJ.Count;

                        end;


                    until DwellingType.Next() = 0;

                CalCJ.Reset();
                CalCJ.CopyFilters(DataItem5581);
                CalCJ.SetFilter("Customer Stroke", '%1', DataItem5581."Customer Stroke");
                CalCJ.SetFilter("Dwelling Type", '%1', '');
                if CalCJ.FindFirst() then begin
                    BrojBezUnosa += CalCJ.Count;
                end;

                DwellingText += ')';
                DwellingRez := '(' + 'B ' + format(BrojBezUnosa) + DwellingText;








                CalCJ.Reset();
                CalCJ.CopyFilters(DataItem5581);
                CalCJ.SetFilter("Customer Stroke", '%1', DataItem5581."Customer Stroke");
                CalCJ.SetFilter(Code, '%1', DataItem5581.Code);
                CalCJ.SetFilter("Reading Mode", '%1', CalCJ."Reading Mode"::"Reading List");
                if CalCJ.FindFirst() then
                    TotalManual := CalCJ.Count;

                CalCJ.Reset();
                CalCJ.CopyFilters(DataItem5581);
                CalCJ.SetFilter("Customer Stroke", '%1', DataItem5581."Customer Stroke");
                CalCJ.SetFilter(Code, '%1', DataItem5581.Code);
                CalCJ.SetFilter("Reading Mode", '%1', CalCJ."Reading Mode"::Digital);
                if CalCJ.FindFirst() then
                    TotalDigital := CalCJ.Count;


                TotalSum := TotalManual + TotalDigital;

                if DataItem5581."Month Of GAS Calculation" = 1 then
                    Mjesec := 'Januar';
                if DataItem5581."Month Of GAS Calculation" = 2 then
                    Mjesec := 'Februar';

                if DataItem5581."Month Of GAS Calculation" = 3 then
                    Mjesec := 'Mart';

                if DataItem5581."Month Of GAS Calculation" = 4 then
                    Mjesec := 'April';

                if DataItem5581."Month Of GAS Calculation" = 5 then
                    Mjesec := 'Maj';

                if DataItem5581."Month Of GAS Calculation" = 6 then
                    Mjesec := 'Juni';

                if DataItem5581."Month Of GAS Calculation" = 7 then
                    Mjesec := 'Juli';

                if DataItem5581."Month Of GAS Calculation" = 8 then
                    Mjesec := 'August';

                if DataItem5581."Month Of GAS Calculation" = 9 then
                    Mjesec := 'Septembar';

                if DataItem5581."Month Of GAS Calculation" = 10 then
                    Mjesec := 'Oktobar';

                if DataItem5581."Month Of GAS Calculation" = 11 then
                    Mjesec := 'Novembar';

                if DataItem5581."Month Of GAS Calculation" = 12 then
                    Mjesec := 'Decembar';

                ch.Reset();
                ch.SetFilter(code, '%1', DataItem5581.Code);
                if ch.FindFirst() then
                    Godina := ch."Year Of GAS Calculation";

                TotM := 0;
                CalCJ.Reset();
                CalCJ.CopyFilters(DataItem5581);
                CalCJ.SetFilter(Code, '%1', DataItem5581.Code);
                CalCJ.SetFilter("Reading Mode", '%1', CalCJ."Reading Mode"::"Reading List");
                if CalCJ.FindFirst() then
                    TotM := CalCJ.Count;
                TotD := 0;
                CalCJ.Reset();
                CalCJ.CopyFilters(DataItem5581);

                CalCJ.SetFilter(Code, '%1', DataItem5581.Code);
                CalCJ.SetFilter("Reading Mode", '%1', CalCJ."Reading Mode"::Digital);
                if CalCJ.FindFirst() then
                    TotD := CalCJ.Count;
                TotU := TotM + totD;

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("Customer Stroke");
                Ascending;

            end;


        }



    }
    trigger OnPreReport()
    var
        myInt: Integer;


    begin
        comp.get;
        comp.calcfields(Picture);

    end;

    var
        comp: Record "Company Information";
        CalcD: Date;
        CaldF: Date;
        Godina: Integer;
        TotM: Integer;
        DwellingText: text;
        TotD: Integer;
        TotU: Integer;
        CH: Record "Calcuation Header";
        TotalManual: Integer;
        TotalDigital: Integer;
        ReportDate: Date;

        Mjesec: text[250];
        DwellingType: Record "Dwelling Type";

        TotalSum: Integer;
        Slovarica: Text[250];
        SlovaricaT: text[250];
        DwellingRez: text;

}