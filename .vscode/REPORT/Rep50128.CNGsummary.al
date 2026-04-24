report 50128 "CNG summary"
{
    Caption = 'CNG summary';
    DefaultLayout = RDLC;
    RDLCLayout = './CNGsummary.rdl';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(SalesInvoiceHeader; "Sales Shipment Line")

        {
            RequestFilterFields = "Posting Date";
            column(Amount; Amount)
            {
            }
            column(AmountIncludingVAT; "Amount Incl. VAT")
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(Type_of_vehicle; "Type of vehicle") { }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(ShiptoName; CustName)
            {
            }
            column(PaymentMethodCode; "Payment Method Code")
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
            column(kg; Quantity)
            {
            }
            column(racuna; racuna)
            {
            }

            column(PaymentMethodCaptionLbl; PaymentMethodCaptionLbl)
            {
            }


            column(CustomerCaptionLbl; CustomerCaptionLbl)
            {
            }

            column(AmountCaptionLbl; AmountCaptionLbl)
            {
            }
            column(AmountInclVATCaptionLbl; AmountInclVATCaptionLbl)
            {
            }


            column(VATCaptionLbl; VATCaptionLbl)
            {
            }



            column(CustomerNAme; CustName)
            {
            }
            column(CustNameRedni; CustNameRedni) { }

            column(GotovinaAmount; GotovinaAmount)
            {
            }


            column(GotovinaAmountInclVAT; GotovinaAmountInclVAT)
            {
            }

            column(GotovinaKG; GotovinaKG)
            {
            }

            column(GotovinaRacuna; GotovinaRacuna)
            {
            }
            column(KarticnoAmount; KarticnoAmount)
            {
            }


            column(KarticnoAmountInclVAT; KarticnoAmountInclVAT)
            {
            }

            column(KarticnoKG; KarticnoKG)
            {
            }
            column(KarticnoRacuna; KarticnoRacuna)
            {
            }
            column(VirmanAmount; VirmanAmount)
            {
            }


            column(VirmanAmountInclVAT; VirmanAmountInclVAT)
            {
            }

            column(VirmanKG; VirmanKG)
            {
            }
            column(VirmanRacuna; VirmanRacuna)
            {
            }
            column(TeretnaAmount; TeretnaAmount)
            {
            }


            column(TeretnaAmountInclVAT; TeretnaAmountInclVAT)
            {
            }

            column(TeretnaKG; TeretnaKG)
            {
            }
            column(TeretnaRacuna; TeretnaRacuna)
            {
            }
            column(VlastitaAmount; VlastitaAmount)
            {
            }
            column(RedniBroj; RedniBroj) { }


            column(VlastitaAmountInclVAT; VlastitaAmountInclVAT)
            {
            }

            column(VlastitaKG; VlastitaKG)
            {
            }
            column(VlastitaRacuna; VlastitaRacuna)
            {
            }

            column(TotalLbl; TotalLbl)
            {
            }


            column(Selected; Selected)
            {
            }

            column(Iternal; Internal)
            {
            }

            column(NN; NN)
            {
            }

            column(PravnaAmount; PravnaAmount)
            {
            }


            column(PravnaAmountInclVAT; PravnaAmountInclVAT)
            {
            }

            column(PravnaKG; PravnaKG)
            {
            }
            column(PravnaRacuna; PravnaRacuna)
            {
            }

            column(FizickaAmount; FizickaAmount)
            {
            }


            column(FizickaAmountInclVAT; FizickaAmountInclVAT)
            {
            }

            column(FizickaKG; FizickaKG)
            {
            }
            column(FizickaRacuna; FizickaRacuna)
            {
            }

            column(FizickaKartAmount; FizickaKartAmount)
            {
            }


            column(FizickaKartAmountInclVAT; FizickaKartAmountInclVAT)
            {
            }

            column(FizickaKartKG; FizickaKartKG)
            {
            }
            column(FizickaKartRacuna; FizickaKartRacuna)
            {
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin


                SETFILTER(Quantity, '<>%1', 0);
                SETFILTER("No.", '%1', 'GAS');
                SETFILTER("Location Code", 'CNG*|*VLASTITA*');
                SetCurrentKey("Bill Type", "Sell-to Customer No.");
                Ascending(false);

            end;

            trigger OnAfterGetRecord()
            begin
                racuna := 0;
                ComPInfo.GET;
                ComPInfo.CALCFIELDS(Picture);

                SlineTemp.reset;
                SlineTemp.SetFilter("Code", '%1', SalesInvoiceHeader."Sell-to Customer No.");
                SlineTemp.SetFilter(Description, '%1', SalesInvoiceHeader."Payment Method Code");
                if not SlineTemp.FindFirst() then begin
                    RedniBroj += 1;
                    SlineTemp.init;
                    Slinetemp."Code" := SalesInvoiceHeader."Sell-to Customer No.";
                    SlineTemp.Description := SalesInvoiceHeader."Payment Method Code";

                    Slinetemp.insert;



                    SHL.Reset();
                    SHL.CopyFilters(SalesInvoiceHeader);
                    SHL.SETFILTER("Payment Method Code", '%1', SalesInvoiceHeader."Payment Method Code");
                    SHL.SETFILTER(Quantity, '<>%1', 0);
                    SHL.SETFILTER("No.", '%1', 'GAS');
                    SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                    SHL.SETFILTER("Sell-to Customer No.", '%1', "Sell-to Customer No.");
                    SHL.SetFilter("Type of vehicle", '%1', "Type of vehicle");
                    // SHL.SetFilter("Fiscal No.", '<>%1', '');
                    //SHL.SETFILTER("Correction", '%1', FALSE);
                    IF SHL.FindFirst() then begin

                        racuna := SHL.Count;
                    end;





                end;

                kg := 0;
                CustName := '';
                CustNameRedni := RedniBroj;
                PaymentMEthod := '';
                PaidAmountInclVAT := 0;
                PaidAmount := 0;



                //SETFILTER("Correction", '%1', FALSE);

                cust.GET("Sell-to Customer No.");
                SalesSetup.GET;


                CustName := Cust.Name;

                CustNameRedni := RedniBroj;






                /*if (cust."Internal Customer" = true) then begin
                    IF Amount > 0
                     then
                        racuna += 1
                    else
                        racuna -= 1;
                end;*/



                GotovinaAmount := 0;
                GotovinaAmountInclVAT := 0;
                GotovinaRacuna := 0;
                GotovinaKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER("Payment Method Code", '%1', 'GOTOVINA');
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');

                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then begin
                    shl.CalcSums(Amount, "Amount Incl. VAT", Quantity);
                    GotovinaAmount := SHL.Amount;
                    GotovinaAmountInclVAT := SHL."Amount Incl. VAT";

                    GotovinaRacuna := SHL.Count;


                    GotovinaKG += SHL.Quantity;


                end;

                KarticnoAmount := 0;
                KarticnoAmountInclVAT := 0;
                KarticnoRacuna := 0;
                KarticnoKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER("Payment Method Code", '%1', 'KARTIČNO');
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then begin
                    shl.CalcSums(Amount, "Amount Incl. VAT", Quantity);

                    KarticnoAmount := SHL.Amount;
                    KarticnoAmountInclVAT := SHL."Amount Incl. VAT";

                    KarticnoRacuna := SHL.Count;


                    KarticnoKG += SHL.Quantity;


                end;

                VirmanAmount := 0;
                VirmanAmountInclVAT := 0;
                VirmanRacuna := 0;
                VirmanKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER("Payment Method Code", '%1', 'VIRMAN');
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then begin
                    shl.CalcSums(Amount, "Amount Incl. VAT", Quantity);
                    VirmanAmount := SHL.Amount;
                    VirmanAmountInclVAT := SHL."Amount Incl. VAT";

                    VirmanRacuna := SHL.Count;


                    VirmanKG += SHL.Quantity;


                end;

                TeretnaAmount := 0;
                TeretnaAmountInclVAT := 0;
                TeretnaRacuna := 0;
                TeretnaKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER("Type of Vehicle", '%1', SHL."Type of Vehicle"::"Cargo vehicles");
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');

                SHL.SETFILTER("Location Code", '%1|%2', '*CNG*', 'VLASTITA');
                SHL.SetFilter("Payment Method Code", '%1', 'VLASTITA');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then begin
                    shl.CalcSums(Amount, "Amount Incl. VAT", Quantity);
                    TeretnaAmount := SHL.Amount;
                    TeretnaAmountInclVAT := SHL."Amount Incl. VAT";

                    TeretnaRacuna := SHL.Count;


                    TeretnaKG += SHL.Quantity;


                end;


                VlastitaAmount := 0;
                VlastitaAmountInclVAT := 0;
                VlastitaRacuna := 0;
                VlastitaKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER("Payment Method Code", '%1', 'VLASTITA');
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '%1|%2', 'CNG*', 'VLASTITA');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then begin
                    shl.CalcSums(Amount, "Amount Incl. VAT", Quantity);
                    VlastitaAmount := SHL.Amount;
                    VlastitaAmountInclVAT := SHL."Amount Incl. VAT";

                    VlastitaRacuna := shl.Count;

                    VlastitaKG += SHL.Quantity;

                end;



                PravnaAmount := 0;
                PravnaAmountInclVAT := 0;
                PravnaRacuna := 0;
                PravnaKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                IF SHL.FindFirst() then
                    repeat
                        cust.GET(SHL."Sell-to Customer No.");
                        IF (NOT cust."Internal Customer") AND NOT (SalesSetup."NN Customer Code" = SHL."Sell-to Customer No.") then begin

                            PravnaAmount += SHL.Amount;
                            PravnaAmountInclVAT += SHL."Amount Incl. VAT";

                            IF SHL.Amount > 0 then
                                PravnaRacuna += 1;






                            PravnaKG += SHL.Quantity;
                        end;

                    until SHL.NEXT = 0;



                FizickaAmount := 0;
                FizickaAmountInclVAT := 0;
                FizickaRacuna := 0;
                FizickaKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                // SHL.SETFILTER("Correction", '%1', FALSE);
                SHL.SETFILTER("Payment Method code", '%1', 'GOTOVINA');
                IF SHL.FindFirst() then
                    repeat

                        IF SalesSetup."NN Customer Code" = SHL."Sell-to Customer No." then begin

                            FizickaAmount += SHL.Amount;
                            FizickaAmountInclVAT += SHL."Amount Incl. VAT";
                            IF SHL.Amount > 0 then
                                FizickaRacuna += 1;


                            FizickaKG += SHL.Quantity;
                        end;

                    until SHL.NEXT = 0;

                FizickaKartAmount := 0;
                FizickaKartAmountInclVAT := 0;
                FizickaKartRacuna := 0;
                FizickaKartKG := 0;

                SHL.Reset();
                SHL.CopyFilters(SalesInvoiceHeader);
                SHL.SETFILTER(Quantity, '<>%1', 0);
                SHL.SETFILTER("No.", '%1', 'GAS');
                SHL.SETFILTER("Location Code", '*CNG*|*VLASTITA*');
                //SHL.SETFILTER("Correction", '%1', FALSE);
                SHL.SETFILTER("Payment Method code", '%1', 'KARTIČNO');
                IF SHL.FindFirst() then
                    repeat

                        IF SalesSetup."NN Customer Code" = SHL."Sell-to Customer No." then begin

                            FizickaKartAmount += SHL.Amount;
                            FizickaKartAmountInclVAT += SHL."Amount Incl. VAT";
                            IF SHL.Amount > 0 then
                                FizickaKartRacuna += 1;

                            FizickaKartKG += SHL.Quantity;
                        end;

                    until SHL.NEXT = 0;

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
                        OptionCaption = ',CNG zbirni izvještaj,Pregled prodaje,';
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
    var
        myInt: Integer;
    begin
        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50128);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;

    end;

    trigger OnPreReport()
    begin

        CompInfo.GET;
        CompInfo.CALCFIELDS(Picture);
        DateFilter := SalesInvoiceHeader.GetFilter("Posting Date");
        ContinuedCaption := TRUE;

        SlineTemp.DeleteAll();
        RedniBroj := 0;
        SlineTemp.DeleteAll();


    end;

    var
        ComPInfo: Record "Company Information";
        Text000: Label 'Period: %1';
        DateFilter: Text[30];
        ReportCaptionLbl: Label 'CNG Summary';
        ContinuedCaption: Boolean;
        CurrReportPageNoCaptionLbl: Label 'Page';
        SlineTemp: Record "Dismantling Reason" temporary;
        RedniBroj: Integer;

        kg: decimal;
        racuna: decimal;
        SIL: Record "Sales Invoice Line";
        CustomerCaptionLbl: Label 'Customer';
        PaymentMethodCaptionLbl: Label 'Payment Method';

        AmountCaptionLbl: Label 'Amount';
        AmountInclVATCaptionLbl: Label 'Amount Including VAT';
        VATCaptionLbl: Label 'VAT';

        cash: decimal;
        card: decimal;
        ownconsumption: decimal;
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";

        giro: decimal;

        SIH: record "Sales Invoice Header";

        CustName: Text;
        CustNameRedni: Integer;
        PaymentMethod: Text[30];

        PaidAmount: decimal;
        PaidAmountInclVAT: decimal;

        SL: record "Sales Line";
        SH: record "Sales Header";
        Cust: Record Customer;

        GotovinaAmount: Decimal;
        GotovinaAmountInclVAT: Decimal;
        GotovinaKG: Decimal;
        GotovinaRacuna: Decimal;
        KarticnoAmount: Decimal;
        KarticnoAmountInclVAT: Decimal;
        KarticnoKG: Decimal;
        KarticnoRacuna: Decimal;
        VirmanAmount: Decimal;
        VirmanAmountInclVAT: Decimal;
        VirmanKG: Decimal;
        VirmanRacuna: Decimal;

        TeretnaAmount: Decimal;
        TeretnaAmountInclVAT: Decimal;
        TeretnaKG: Decimal;
        TeretnaRacuna: Decimal;
        VlastitaAmount: Decimal;
        VlastitaAmountInclVAT: Decimal;
        VlastitaKG: Decimal;
        VlastitaRacuna: Decimal;

        TotalLbl: Label 'Total';
        SHL: Record "Sales Shipment Line";
        Selected: Option " ","TotalSales","CNGSales";

        SalesSetup: Record "Sales & Receivables Setup";


        PravnaAmount: Decimal;
        PravnaAmountInclVAT: Decimal;
        PravnaKG: Decimal;
        PravnaRacuna: Decimal;

        FizickaAmount: Decimal;
        FizickaAmountInclVAT: Decimal;
        FizickaKG: Decimal;
        FizickaRacuna: Decimal;
        FizickaKartAmount: Decimal;
        FizickaKartAmountInclVAT: Decimal;
        FizickaKartKG: Decimal;
        FizickaKartRacuna: Decimal;

}
