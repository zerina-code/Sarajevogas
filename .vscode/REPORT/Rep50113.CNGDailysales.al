report 50113 "CNG Daily sales"
{

    DefaultLayout = RDLC;
    RDLCLayout = './CNGDailySales.rdl';

    Caption = 'CNG Daily sales';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(SalesShipmentLine; "Sales Shipment Line")
        {
            column(PostingDate; "Posting Date")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Amount; Amount)
            {
            }
            column(Amountvat; "Amount Incl. VAT")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(PeriodDateFilter; StrSubstNo(Text000, DateFilter))
            {
            }
            column(ReportCaptionLbl; ReportCaptionLbl)
            {
            }
            column(ContinuedCaption; ContinuedCaption)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(DateLbl; DateLbl)
            {
            }
            column(AmountLbl; AmountLbl)
            {
            }

            column(AmountvatLbl; AmountVATLbl)
            {
            }
            column(QuantityLbl; QuantityLbl)
            {
            }
            column(Selected; Selected)
            {
            }
            column(Iternal; Iternal)
            {
            }
            column(Mjesec1; Mjesec[1])
            {
            }

            column(Mjesec2; Mjesec[2])
            {
            }
            column(Mjesec3; Mjesec[3])
            {
            }

            column(Mjesec4; Mjesec[4])
            {
            }
            column(Mjesec5; Mjesec[5])
            {
            }

            column(Mjesec6; Mjesec[6])
            {
            }
            column(Mjesec7; Mjesec[7])
            {
            }

            column(Mjesec8; Mjesec[8])
            {
            }
            column(Mjesec9; Mjesec[9])
            {
            }

            column(Mjesec10; Mjesec[10])
            {
            }
            column(Mjesec11; Mjesec[11])
            {
            }

            column(Mjesec12; Mjesec[12])
            {
            }
            column(Mjesec13; Mjesec[13])
            {
            }

            column(Kolicina1; Kolicina[1])
            {
            }

            column(Kolicina2; Kolicina[2])
            {
            }
            column(Kolicina3; Kolicina[3])
            {
            }

            column(Kolicina4; Kolicina[4])
            {
            }
            column(Kolicina5; Kolicina[5])
            {
            }

            column(Kolicina6; Kolicina[6])
            {
            }
            column(Kolicina7; Kolicina[7])
            {
            }

            column(Kolicina8; Kolicina[8])
            {
            }
            column(Kolicina9; Kolicina[9])
            {
            }

            column(Kolicina10; Kolicina[10])
            {
            }
            column(Kolicina11; Kolicina[11])
            {
            }

            column(Kolicina12; Kolicina[12])
            {
            }
            column(Kolicina13; Kolicina[13])
            {
            }

            column(Prosjek1; Prosjek[1])
            {
            }

            column(Prosjek2; Prosjek[2])
            {
            }
            column(Prosjek3; Prosjek[3])
            {
            }

            column(Prosjek4; Prosjek[4])
            {
            }
            column(Prosjek5; Prosjek[5])
            {
            }

            column(Prosjek6; Prosjek[6])
            {
            }
            column(Prosjek7; Prosjek[7])
            {
            }

            column(Prosjek8; Prosjek[8])
            {
            }
            column(Prosjek9; Prosjek[9])
            {
            }

            column(Prosjek10; Prosjek[10])
            {
            }
            column(Prosjek11; Prosjek[11])
            {
            }

            column(Prosjek12; Prosjek[12])
            {
            }
            column(Prosjek13; Prosjek[13])
            {
            }

            trigger OnPreDataItem()
            begin
                k := 0;
                FOR i := 1 TO 12 - Month DO BEGIN
                    MjeseciUOdnosuNaDatum[i] := Mjesec[Month + k];
                    DatumiOdInteresa[i] := DMY2DATE(1, Month + k, Year - 1);
                    DatumiKrajaOdInteresa[i] := GetMonthRange(Month + k, Year - 1, FALSE);
                    k := k + 1;
                END;
                l := 0;
                FOR i := k + 1 TO 12 DO BEGIN
                    MjeseciUOdnosuNaDatum[i] := Mjesec[l + 1];
                    DatumiOdInteresa[i] := DMY2DATE(1, l + 1, Year);
                    DatumiKrajaOdInteresa[i] := GetMonthRange(l + 1, Year, FALSE);
                    l := l + 1;
                END;
                MjeseciUOdnosuNaDatum[13] := Mjesec[Month];
                DatumiOdInteresa[13] := DMY2DATE(1, Month, Year);
                DatumiKrajaOdInteresa[13] := GetMonthRange(Month, Year, FALSE);


            end;

            trigger OnAfterGetRecord()
            begin
                FOR i := 1 TO 12 DO BEGIN
                    SHL.RESET;
                    SHL.SETFILTER(Quantity, '<>%1', 0);
                    SHL.SETFILTER("No.", '%1', 'GAS');
                    SHL.SETFILTER("Location Code", '%1|%2', 'CNG MLP', 'CNG VLP');
                    SHL.SETFILTER("Correction", '%1', FALSE);
                    SHL.SETFILTER("Posting Date", '%1..%2', DatumiOdInteresa[i], DatumiKrajaOdInteresa[i]);
                    IF SHL.FindFirst() then
                        repeat
                            Prosjek[i] += SHL.Quantity / (DatumiKrajaOdInteresa[i] - DatumiOdInteresa[i] + 1);
                            Kolicina[i] += SHL.Quantity;
                        until SHL.NEXT = 0;

                end;
            end;

        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Selected; Selected)
                    {
                        Caption = 'Izbor:';
                        OptionCaption = ',Dnevna prodaja,Mjesečni prosjek';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }

    }
    trigger OnInitReport()
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50113);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;

        Mjesec[1] := 'Januar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[2] := 'Februar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[3] := 'Mart' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[4] := 'April' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[5] := 'Maj' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[6] := 'Juni' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[7] := 'Juli' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[8] := 'Avgust' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[9] := 'Septembar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[10] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[11] := 'Novembar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));
        Mjesec[12] := 'Decembar' + ' ' + FORMAT(DATE2DMY(TODAY, 3));

        Month := 12;
        Year := DATE2DMY(TODAY, 3);
        FOR i := 1 TO 12 DO BEGIN
            Prosjek[i] := 0;
            Kolicina[i] := 0;
        END;



    end;

    trigger OnPreReport()

    begin
        ComPInfo.GET;
        ComPInfo.CALCFIELDS(Picture);
    end;

    var
        ComPInfo: Record "Company Information";
        Text000: Label 'Period: %1';
        DateFilter: Text[30];
        ReportCaptionLbl: Label 'CNG Dalily Sales';
        ContinuedCaption: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        DateLbl: Label 'Sales Date';
        AmountLbl: Label 'Amount';
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";

        AmountvatLbl: Label 'Amount Incl. VAT';
        QuantityLbl: Label 'Quantity';
        Selected: Option " ","DailySales","MonthlySales";

        iternal: Boolean;
        Mjesec: array[14] of Text;
        Month: integer;
        Year: integer;
        i: integer;
        Prosjek: array[14] of Decimal;
        Kolicina: array[14] of Decimal;
        k: integer;
        l: integer;
        MjeseciUOdnosuNaDatum: array[14] of Text;
        DatumiKrajaOdInteresa: array[14] of Date;
        DatumiOdInteresa: array[14] of Date;
        DateText: Text;

        Datum: record Date;
        SHL: Record "Sales Shipment Line";

    local Procedure GetMonthRange(CurrMonth: Integer; CurrYear: Integer; StartOrEnd: Boolean) ReturnDate: Date
    var


    begin
        IF STRLEN(FORMAT(CurrMonth)) = 1 THEN
            DateText := '0' + FORMAT(CurrMonth) + FORMAT(CurrYear)
        ELSE
            DateText := FORMAT(CurrMonth) + FORMAT(CurrYear);

        IF StartOrEnd THEN
            EVALUATE(ReturnDate, '01' + DateText)
        ELSE BEGIN
            Datum.SETFILTER("Period Type", '%1', 2);
            Datum.SETFILTER("Period No.", FORMAT(CurrMonth));
            Datum.SETFILTER("Period Start", '01' + DateText);
            Datum.FINDFIRST;
            EVALUATE(ReturnDate, FORMAT(DATE2DMY(NORMALDATE(Datum."Period End"), 1)) + DateText);
        END;

    end;
}