report 50141 listofchanges
{
    DefaultLayout = RDLC;
    RDLCLayout = './listingofcganges.rdl';
    Caption = 'listofchanges';
    PreviewMode = PrintLayout;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Customer Category", "Date Filter";

            column(TodayFormatted; FORMAT(TODAY)) { }
            column(customerNo; "No.") { }
            column(CustomerName; Name) { }
            column(AmountBroj1; AmountBroj[1]) { }
            column(AmountBroj2; AmountBroj[2]) { }
            column(AmountBroj3; AmountBroj[3]) { }
            column(AmountBroj4; AmountBroj[4]) { }
            column(AmountBroj5; AmountBroj[5]) { }
            column(AmountBroj6; AmountBroj[6]) { }
            column(AmountBroj7; AmountBroj[7]) { }
            column(AmountBroj8; AmountBroj[8]) { }
            column(AmountBroj9; AmountBroj[9]) { }
            column(AmountBroj10; AmountBroj[10]) { }
            column(AmountBroj11; AmountBroj[11]) { }
            column(AmountBroj12; AmountBroj[12]) { }
            column(AmountBroj13; AmountBroj[13]) { }
            column(RacuniBroj1; RacuniBrojRed[1]) { }
            column(RacuniBroj2; RacuniBrojRed[2]) { }
            column(RacuniBroj3; RacuniBrojRed[3]) { }
            column(RacuniBroj4; RacuniBrojRed[4]) { }
            column(RacuniBroj5; RacuniBrojRed[5]) { }
            column(RacuniBroj6; RacuniBrojRed[6]) { }
            column(RacuniBroj7; RacuniBrojRed[7]) { }
            column(RacuniBroj8; RacuniBrojRed[8]) { }
            column(RacuniBroj9; RacuniBrojRed[9]) { }
            column(RacuniBroj10; RacuniBrojRed[10]) { }
            column(RacuniBroj11; RacuniBrojRed[11]) { }
            column(RacuniBroj12; RacuniBrojRed[12]) { }
            column(RacuniBroj13; RacuniBrojRed[13]) { }
            column(Selected; Selected) { }
            column(Mjesec1; Mjesec[1]) { }
            column(Mjesec2; Mjesec[2]) { }
            column(Mjesec3; Mjesec[3]) { }
            column(Mjesec4; Mjesec[4]) { }
            column(Mjesec5; Mjesec[5]) { }
            column(Mjesec6; Mjesec[6]) { }
            column(Mjesec7; Mjesec[7]) { }
            column(Mjesec8; Mjesec[8]) { }
            column(Mjesec9; Mjesec[9]) { }
            column(Mjesec10; Mjesec[10]) { }
            column(Mjesec11; Mjesec[11]) { }
            column(Mjesec12; Mjesec[12]) { }
            column(Mjesec13; Mjesec[13]) { }
            column(CustomerCategory; "Customer Category") { }
            column(RacuniBroj; RacuniBroj + RacuniBrojPlus) { }
            column(KO; KO + KOPLUS) { }
            column(CompanyCity; CompInfo.City) { }
            column(CompanyAdress2; CompInfo."Address 2") { }
            column(Saldo; RacuniBroj + RacuniBrojPlus - AmountLCY) { }
            column(AmountLCY; AmountLCY) { }
            column(testpolje1; Testpolje[1]) { }
            column(testpolje2; Testpolje[2]) { }
            column(testpolje3; Testpolje[3]) { }
            column(testpolje4; Testpolje[4]) { }
            column(testpolje5; Testpolje[5]) { }
            column(testpolje6; Testpolje[6]) { }
            column(testpolje7; Testpolje[7]) { }
            column(testpolje8; Testpolje[8]) { }
            column(testpolje9; Testpolje[9]) { }
            column(testpolje10; Testpolje[10]) { }
            column(testpolje11; Testpolje[11]) { }
            column(testpolje12; Testpolje[12]) { }

            column(LargeEconomyPercentage; LargeEconomyPercentage) { }
            column(LargeEconomyLastYrPercentage; LargeEconomyLastYrPercentage) { }
            column(LargeEconomyYrBeforeLastPercentage; LargeEconomyYrBeforeLastPercentage) { }
            column(SmallEconomyPercentage; SmallEconomyPercentage) { }
            column(SmallEconomyLastYrPercentage; SmallEconomyLastYrPercentage) { }
            column(SmallEconomyYrBeforeLastPercentage; SmallEconomyYrBeforeLastPercentage) { }
            column(HouseholdPercentage; HouseholdPercentage) { }
            column(HouseholdLastYrPercentage; HouseholdLastYrPercentage) { }
            column(HouseholdYrBeforeLastPercentage; HouseholdYrBeforeLastPercentage) { }
            column(SpecialCustomerPercentage; SpecialCustomerPercentage) { }
            column(SpecialCustomerLastYrPercentage; SpecialCustomerLastYrPercentage) { }
            column(SpecialCustomerYrBeforeLastPercentage; SpecialCustomerYrBeforeLastPercentage) { }
            column(KJKPPercentage; KJKPPercentage) { }
            column(KJKPLastYrPercentage; KJKPLastYrPercentage) { }
            column(KJKPYrBeforeLastPercentage; KJKPYrBeforeLastPercentage) { }
            column(LargeEconomyIndex; LargeEconomyIndex) { }
            column(SmallEconomyIndex; SmallEconomyIndex) { }
            column(HouseholdIndex; HouseholdIndex) { }
            column(SpecialCustomerIndex; SpecialCustomerIndex) { }
            column(KJKPIndex; KJKPIndex) { }
            column(StartDate; Format(StartDate)) { }
            column(EndDate; Format(EndDate)) { }
            column(StartDateLastYear; Format(StartDateLastYear)) { }
            column(EndDateLastYear; Format(EndDateLastYear)) { }
            column(StartDateYearBeforeLast; Format(StartDateYearBeforeLast)) { }
            column(EndDateYearBeforeLast; Format(EndDateYearBeforeLast)) { }
            column(TotalPercentage; TotalPercentage) { }
            column(TotalLastYrPercentage; TotalLastYrPercentage) { }
            column(TotalYrBeforeLastPercentage; TotalYrBeforeLastPercentage) { }
            column(ReportTitle; ReportTitle) { }
            column(PeriodDateFilter; STRSUBSTNO(Text000Lbl, CustDateFilter)) { }
            column(PageNoCaption; PageNoCaptionLbl) { }

            trigger OnAfterGetRecord()
            begin
                //Opcija 1: Zbirni pregled fakturisanih i naplaćenih vrijednosti
                if Selected = Selected::RegBrojCNG then begin
                    RacuniBroj := 0;
                    SalesShipmentHeader.Reset();
                    SalesShipmentHeader.SetFilter("Bill-to Customer No.", '%1', "No.");
                    if SalesShipmentHeader.FindFirst() then
                        repeat
                            SalesShipmentLine.Reset();
                            SalesShipmentLine.SetFilter("Document No.", '%1', SalesShipmentHeader."No.");
                            if SalesShipmentLine.FindSet() then
                                repeat
                                    RacuniBroj += SalesShipmentLine."Amount Incl. VAT";
                                until SalesShipmentLine.next = 0;
                        until SalesShipmentHeader.next() = 0;

                    KO := 0;
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("Bill-to Customer No.", '%1', "No.");
                    SalesHeader.SetFilter("Document Type", '%1', SalesHeader."Document Type"::"Credit Memo");
                    if SalesHeader.FindSet() then
                        repeat
                            SalesLine.Reset();
                            SalesLine.SetFilter("Document No.", '%1', SalesHeader."No.");
                            if SalesLine.FindSet() then
                                repeat begin
                                    KO += SalesLine."Amount Including VAT";
                                end until SalesLine.Next = 0;
                        until SalesHeader.Next() = 0;

                    KOPLUS := 0;
                    SalesCrMemoHeader.Reset();
                    SalesCrMemoHeader.SetFilter("Bill-to Customer No.", '%1', "No.");
                    if SalesCrMemoHeader.FindFirst() then
                        repeat
                            SalesCrMemoLine.Reset();
                            SalesCrMemoLine.SetFilter("Document No.", '%1', SalesCrMemoHeader."No.");
                            if SalesCrMemoLine.FindSet() then
                                repeat begin
                                    KOPLUS += SalesCrMemoLine."Amount Including VAT";
                                end until SalesCrMemoLine.Next = 0;
                        until SalesCrMemoHeader.Next() = 0;

                    AmountLCY := 0;
                    CustomerLedgerEntries.Reset();
                    CustomerLedgerEntries.SetFilter("Document Type", '%1', CustomerLedgerEntries."Document Type"::Payment);
                    CustomerLedgerEntries.SetFilter("Customer No.", '%1', "No.");
                    if CustomerLedgerEntries.FindSet() then
                        repeat
                            CustomerLedgerEntries.CalcFields(Amount);
                            AmountLCY += CustomerLedgerEntries."Amount";
                        until CustomerLedgerEntries.Next() = 0;
                end;

                //Opcija 2: Stepen naplate
                if Selected = Selected::ListingCNG then begin
                    FOR i := 1 TO 12 DO BEGIN
                        SalesShipmentHeader.RESET();
                        SalesShipmentHeader.SetFilter("Bill-to Customer No.", '%1', "No.");
                        SalesShipmentHeader.SETFILTER("Posting Date", '%1..%2', DatumiOdInteresa[i], DatumiKrajaOdInteresa[i]);

                        IF SalesShipmentHeader.FindFirst() then begin
                            SalesShipmentLine.reset();
                            SalesShipmentLine.SetFilter("Document No.", '%1', SalesShipmentHeader."No.");
                            if SalesShipmentLine.Findfirst() then
                                repeat
                                    RacuniBrojRed[i] += SalesShipmentLine."Amount Incl. VAT";
                                until SalesShipmentLine.next = 0;
                        end;
                    end;

                    FOR i := 1 TO 12 DO BEGIN
                        CustomerLedgerEntries.RESET();
                        CustomerLedgerEntries.SetFilter("Customer No.", '%1', "No.");
                        CustomerLedgerEntries.SetFilter("Document Type", '%1', CustomerLedgerEntries."Document Type"::Payment);
                        CustomerLedgerEntries.SETFILTER("Posting Date", '%1..%2', DatumiOdInteresa[i], DatumiKrajaOdInteresa[i]);

                        IF CustomerLedgerEntries.FindSet() then
                            repeat
                                AmountBroj[i] += CustomerLedgerEntries."Amount";
                            until CustomerLedgerEntries.NEXT = 0;

                    end;

                    FOR i := 1 TO 12 DO BEGIN
                        IF RacuniBrojRed[i] = 0 THEN
                            Testpolje[i] := 0
                        ELSE
                            Testpolje[i] := (AmountBroj[i] / RacuniBrojRed[i]) * 100;
                    END;
                end;

                //Opcija 3: StepenNaplatePotrazivanja
                if Selected = Selected::StepenNaplatePotrazivanja then begin
                    // za trenutnu godinu-period:
                    DetailedCustLedgerEntries.Reset();
                    DetailedCustLedgerEntries.SetFilter("Customer No.", '%1', "No.");
                    DetailedCustLedgerEntries.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                    DetailedCustLedgerEntries.SetFilter("Ledger Entry Amount", '%1', true);
                    if DetailedCustLedgerEntries.FindSet() then
                        repeat

                            case "Customer Category" of
                                "Customer Category"::"Large Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Small Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::Household:
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Special Customer":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"KJKP Heating plant":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                            end;
                        until DetailedCustLedgerEntries.Next() = 0;

                    TotalInvoice := LargeEconomyInvoice + SmallEconomyInvoice + HouseholdInvoice + SpecialCustomerInvoice + KJKPInvoice;
                    TotalPayment := LargeEconomyPayment + SmallEconomyPayment + HouseholdPayment + SpecialCustomerPayment + KJKPPayment;

                    // za prethodnu godinu-period
                    DetailedCustLedgerEntries.Reset();
                    DetailedCustLedgerEntries.SetFilter("Customer No.", '%1', "No.");
                    DetailedCustLedgerEntries.SetFilter("Posting Date", '%1..%2', StartDateLastYear, EndDateLastYear);
                    DetailedCustLedgerEntries.SetFilter("Ledger Entry Amount", '%1', true);

                    if DetailedCustLedgerEntries.FindSet() then
                        repeat
                            case "Customer Category" of
                                "Customer Category"::"Large Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyLastYrInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyLastYrPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Small Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyLastYrInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyLastYrPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::Household:
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdLastYrInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdLastYrPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Special Customer":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerLastYrInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerLastYrPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"KJKP Heating plant":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPLastYrInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPLastYrPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                            end;
                        until DetailedCustLedgerEntries.Next() = 0;
                    TotalLastYrInvoice := LargeEconomyLastYrInvoice + SmallEconomyLastYrInvoice + HouseholdLastYrInvoice + SpecialCustomerLastYrInvoice + KJKPLastYrInvoice;
                    TotalLastYrPayment := LargeEconomyLastYrPayment + SmallEconomyLastYrPayment + HouseholdLastYrPayment + SpecialCustomerLastYrPayment + KJKPLastYrPayment;



                    // za pretproslu godinu-period
                    DetailedCustLedgerEntries.Reset();
                    DetailedCustLedgerEntries.SetFilter("Customer No.", '%1', "No.");
                    DetailedCustLedgerEntries.SetFilter("Posting Date", '%1..%2', StartDateYearBeforeLast, EndDateYearBeforeLast);
                    DetailedCustLedgerEntries.SetFilter("Ledger Entry Amount", '%1', true);
                    if DetailedCustLedgerEntries.FindSet() then
                        repeat
                            case "Customer Category" of
                                "Customer Category"::"Large Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyYrBeforeLastInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            LargeEconomyYrBeforeLastPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Small Economy":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyYrBeforeLastInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SmallEconomyYrBeforeLastPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::Household:
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdYrBeforeLastInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            HouseholdYrBeforeLastPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"Special Customer":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerYrBeforeLastInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            SpecialCustomerYrBeforeLastPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                                "Customer Category"::"KJKP Heating plant":
                                    begin
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Invoice then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPYrBeforeLastInvoice += DetailedCustLedgerEntries.Amount;
                                        end;
                                        if DetailedCustLedgerEntries."Document Type" = DetailedCustLedgerEntries."Document Type"::Payment then begin
                                            //DetailedCustLedgerEntries.CalcSums(Amount);
                                            KJKPYrBeforeLastPayment += DetailedCustLedgerEntries.Amount;
                                        end;
                                    end;
                            end;
                        until DetailedCustLedgerEntries.Next() = 0;

                    TotalYrBeforeLastInvoice := LargeEconomyYrBeforeLastInvoice + SmallEconomyYrBeforeLastInvoice + HouseholdYrBeforeLastInvoice + SpecialCustomerYrBeforeLastInvoice + KJKPYrBeforeLastInvoice;
                    TotalYrBeforeLastPayment := LargeEconomyYrBeforeLastPayment + SmallEconomyYrBeforeLastPayment + HouseholdYrBeforeLastPayment + SpecialCustomerYrBeforeLastPayment + KJKPYrBeforeLastPayment;

                    if LargeEconomyInvoice = 0 then
                        LargeEconomyPercentage := 0
                    else
                        LargeEconomyPercentage := (LargeEconomyPayment / LargeEconomyInvoice) * 100;

                    if SmallEconomyInvoice = 0 then
                        SmallEconomyPercentage := 0
                    else
                        SmallEconomyPercentage := (SmallEconomyPayment / SmallEconomyInvoice) * 100;

                    if HouseholdInvoice = 0 then
                        HouseholdPercentage := 0
                    else
                        HouseholdPercentage := (HouseholdPayment / HouseholdInvoice) * 100;

                    if SpecialCustomerInvoice = 0 then
                        SpecialCustomerPercentage := 0
                    else
                        SpecialCustomerPercentage := (SpecialCustomerPayment / SpecialCustomerInvoice) * 100;

                    if KJKPInvoice = 0 then
                        KJKPPercentage := 0
                    else
                        KJKPPercentage := (KJKPPayment / KJKPInvoice) * 100;

                    if LargeEconomyLastYrInvoice = 0 then
                        LargeEconomyLastYrPercentage := 0
                    else
                        LargeEconomyLastYrPercentage := (LargeEconomyLastYrPayment / LargeEconomyLastYrInvoice) * 100;

                    if SmallEconomyLastYrInvoice = 0 then
                        SmallEconomyLastYrPercentage := 0
                    else
                        SmallEconomyLastYrPercentage := (SmallEconomyLastYrPayment / SmallEconomyLastYrInvoice) * 100;

                    if HouseholdLastYrInvoice = 0 then
                        HouseholdLastYrPercentage := 0
                    else
                        HouseholdLastYrPercentage := (HouseholdLastYrPayment / HouseholdLastYrInvoice) * 100;

                    if SpecialCustomerLastYrInvoice = 0 then
                        SpecialCustomerLastYrPercentage := 0
                    else
                        SpecialCustomerLastYrPercentage := (SpecialCustomerLastYrPayment / SpecialCustomerLastYrInvoice) * 100;

                    if KJKPLastYrInvoice = 0 then
                        KJKPLastYrPercentage := 0
                    else
                        KJKPLastYrPercentage := (KJKPLastYrPayment / KJKPLastYrInvoice) * 100;

                    if LargeEconomyYrBeforeLastInvoice = 0 then
                        LargeEconomyYrBeforeLastPercentage := 0
                    else
                        LargeEconomyYrBeforeLastPercentage := (LargeEconomyYrBeforeLastPayment / LargeEconomyYrBeforeLastInvoice) * 100;

                    if SmallEconomyYrBeforeLastInvoice = 0 then
                        SmallEconomyYrBeforeLastPercentage := 0
                    else
                        SmallEconomyYrBeforeLastPercentage := (SmallEconomyYrBeforeLastPayment / SmallEconomyYrBeforeLastInvoice) * 100;

                    if HouseholdYrBeforeLastInvoice = 0 then
                        HouseholdYrBeforeLastPercentage := 0
                    else
                        HouseholdYrBeforeLastPercentage := (HouseholdYrBeforeLastPayment / HouseholdYrBeforeLastInvoice) * 100;

                    if SpecialCustomerYrBeforeLastInvoice = 0 then
                        SpecialCustomerYrBeforeLastPercentage := 0
                    else
                        SpecialCustomerYrBeforeLastPercentage := (SpecialCustomerYrBeforeLastPayment / SpecialCustomerYrBeforeLastInvoice) * 100;

                    if KJKPYrBeforeLastInvoice = 0 then
                        KJKPYrBeforeLastPercentage := 0
                    else
                        KJKPYrBeforeLastPercentage := (KJKPYrBeforeLastPayment / KJKPYrBeforeLastInvoice) * 100;

                    // izračunaj indekse
                    if LargeEconomyYrBeforeLastPercentage = 0 then
                        LargeEconomyIndex := 0
                    else
                        LargeEconomyIndex := LargeEconomyPercentage / LargeEconomyYrBeforeLastPercentage * 100;

                    if SmallEconomyYrBeforeLastPercentage = 0 then
                        SmallEconomyIndex := 0
                    else
                        SmallEconomyIndex := SmallEconomyPercentage / SmallEconomyYrBeforeLastPercentage * 100;

                    if HouseholdYrBeforeLastPercentage = 0 then
                        HouseholdIndex := 0
                    else
                        HouseholdIndex := HouseholdPercentage / HouseholdYrBeforeLastPercentage * 100;

                    if SpecialCustomerYrBeforeLastPercentage = 0 then
                        SpecialCustomerIndex := 0
                    else
                        SpecialCustomerIndex := SpecialCustomerPercentage / SpecialCustomerYrBeforeLastPercentage * 100;

                    if KJKPYrBeforeLastPercentage = 0 then
                        KJKPIndex := 0
                    else
                        KJKPIndex := KJKPPercentage / KJKPYrBeforeLastPercentage * 100;

                    if TotalInvoice = 0 then
                        TotalPercentage := 0
                    else
                        TotalPercentage := TotalPayment / TotalInvoice * 100;

                    if TotalLastYrInvoice = 0 then
                        TotalLastYrPercentage := 0
                    else
                        TotalLastYrPercentage := TotalLastYrPayment / TotalLastYrInvoice * 100;

                    if TotalYrBeforeLastInvoice = 0 then
                        TotalYrBeforeLastPercentage := 0
                    else
                        TotalYrBeforeLastPercentage := TotalYrBeforeLastPayment / TotalYrBeforeLastInvoice * 100;
                end;
            end;

            trigger OnPreDataItem()
            begin
                CustDateFilter := Customer.GETFILTER("Date Filter");
                StartDate := Customer.GetRangeMin("Date Filter");
                EndDate := Customer.GETRANGEMAX("Date Filter");
                ToDateFilter := Customer.GETRANGEMAX("Date Filter");

                StartDateLastYear := CALCDATE('<-1Y>', StartDate);
                EndDateLastYear := CALCDATE('<-1Y>', EndDate);
                StartDateYearBeforeLast := CALCDATE('<-2Y>', StartDate);
                EndDateYearBeforeLast := CALCDATE('<-2Y>', EndDate);

                Mjesec[1] := 'Januar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[2] := 'Februar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[3] := 'Mart' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[4] := 'April' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[5] := 'Maj' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[6] := 'Juni' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[7] := 'Juli' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[8] := 'Avgust' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[9] := 'Septembar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[10] := 'Oktobar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[11] := 'Novembar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));
                Mjesec[12] := 'Decembar' + ' ' + FORMAT(DATE2DMY(ToDateFilter, 3));

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

                LargeEconomyInvoice := 0;
                LargeEconomyPayment := 0;
                LargeEconomyPercentage := 0;

                SmallEconomyInvoice := 0;
                SmallEconomyPayment := 0;
                SmallEconomyPercentage := 0;

                HouseholdInvoice := 0;
                HouseholdPayment := 0;
                HouseholdPercentage := 0;

                SpecialCustomerInvoice := 0;
                SpecialCustomerPayment := 0;
                SpecialCustomerPercentage := 0;

                KJKPInvoice := 0;
                KJKPPayment := 0;
                KJKPPercentage := 0;

                LargeEconomyLastYrInvoice := 0;
                LargeEconomyLastYrPayment := 0;
                LargeEconomyLastYrPercentage := 0;

                SmallEconomyLastYrInvoice := 0;
                SmallEconomyLastYrPayment := 0;
                SmallEconomyLastYrPercentage := 0;

                HouseholdLastYrInvoice := 0;
                HouseholdLastYrPayment := 0;
                HouseholdLastYrPercentage := 0;

                SpecialCustomerLastYrInvoice := 0;
                SpecialCustomerLastYrPayment := 0;
                SpecialCustomerLastYrPercentage := 0;

                KJKPLastYrInvoice := 0;
                KJKPLastYrPayment := 0;
                KJKPLastYrPercentage := 0;

                LargeEconomyYrBeforeLastInvoice := 0;
                LargeEconomyYrBeforeLastPayment := 0;
                LargeEconomyYrBeforeLastPercentage := 0;

                SmallEconomyYrBeforeLastInvoice := 0;
                SmallEconomyYrBeforeLastPayment := 0;
                SmallEconomyYrBeforeLastPercentage := 0;

                HouseholdYrBeforeLastInvoice := 0;
                HouseholdYrBeforeLastPayment := 0;
                HouseholdYrBeforeLastPercentage := 0;

                SpecialCustomerYrBeforeLastInvoice := 0;
                SpecialCustomerYrBeforeLastPayment := 0;
                SpecialCustomerYrBeforeLastPercentage := 0;

                KJKPYrBeforeLastInvoice := 0;
                KJKPYrBeforeLastPayment := 0;
                KJKPYrBeforeLastPercentage := 0;

                LargeEconomyIndex := 0;
                SmallEconomyIndex := 0;
                HouseholdIndex := 0;
                SpecialCustomerIndex := 0;
                KJKPIndex := 0;

                TotalInvoice := 0;
                TotalPayment := 0;
                TotalLastYrInvoice := 0;
                TotalLastYrPayment := 0;
                TotalYrBeforeLastInvoice := 0;
                TotalYrBeforeLastPayment := 0;
                TotalPercentage := 0;
                TotalLastYrPercentage := 0;
                TotalYrBeforeLastPercentage := 0;
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
                        OptionCaption = ',Zbirni pregled fakturisanih i naplaćenih vrijednosti,Stepen naplate,Stepen naplate potraživanja';
                    }
                }
            }
        }

        actions
        {
        }
    }
    trigger OnInitReport()
    begin
        Month := 12;
        Year := DATE2DMY(TODAY, 3);
        FOR i := 1 TO 12 DO BEGIN
            RacuniBrojRed[i] := 0;
            AmountBroj[i] := 0;
            Testpolje[i] := 0;
        END;

        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50141);
        if CRL.FindFirst() then begin
            RLS.SetTempLayoutSelected(CRL.Code);
        end;
    end;

    trigger OnPreReport()
    begin
        CompInfo.GET;
        if Selected = Selected::RegBrojCNG then
            ReportTitle := 'Zbirni pregled fakturisanih i naplaćenih vrijednosti'
        else
            if Selected = Selected::ListingCNG then
                ReportTitle := 'Stepen naplate'
            else
                if Selected = Selected::StepenNaplatePotrazivanja then
                    ReportTitle := 'Stepen naplate potraživanja'
                else
                    ReportTitle := 'n/a';
    end;

    var
        testpolje1: Decimal;
        testpolje2: Decimal;
        testpolje3: Decimal;
        testpolje4: Decimal;
        testpolje5: Decimal;
        testpolje6: Decimal;
        testpolje7: Decimal;
        testpolje8: Decimal;
        testpolje9: Decimal;
        testpolje10: Decimal;
        testpolje11: Decimal;
        testpolje12: Decimal;
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";

        //PostedSalesCrMemoLine:Record "Posted "
        CustomerLedgerEntries: Record "Cust. Ledger Entry";
        KOPLUS: decimal;
        CompInfo: Record "Company Information";
        SalesCrMemoLine: record "Sales Cr.Memo Line";
        RacuniBrojPlus: Decimal;
        RacuniBrojRedPlus: array[14] of decimal;
        Postotak: array[14] of decimal;
        SaldoBroj: array[14] of Decimal;
        AmountBroj: array[14] of Decimal;

        StartDate: Date;
        EndDate: Date;
        RacuniBroj: Decimal;
        KO: Decimal;
        Saldo: Decimal;
        SalesHeader: record "Sales Header";
        SalesLine: record "Sales Line";
        SalesCrMemoHeader: record "Sales Cr.Memo Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: record "Sales Invoice Line";
        CompanyAdress2: TEXT[50];
        AmountLCY: Decimal;
        Month: integer;
        Year: integer;
        i: integer;
        RacuniBrojRed: array[14] of Decimal;
        Prosjek: array[14] of Decimal;
        Kolicina: array[14] of Decimal;
        Mjesec: array[14] of Text;

        Selected: Option " ","RegBrojCNG","ListingCNG","StepenNaplatePotrazivanja";
        k: integer;
        l: integer;
        MjeseciUOdnosuNaDatum: array[14] of Text;
        DatumiKrajaOdInteresa: array[14] of Date;
        DatumiOdInteresa: array[14] of Date;
        DateText: Text;

        Datum: record Date;
        SalesShipmentHeader: record "Sales Shipment Header";
        SalesShipmentLine: record "Sales Shipment Line";
        ToDateFilter: Date;
        Testpolje: array[12] of Decimal;

        //varijable za 3. opciju izvj: StepenNaplatePotrazivanja
        DetailedCustLedgerEntries: Record "Detailed Cust. Ledg. Entry";
        StartDateLastYear,
        EndDateLastYear : Date;
        StartDateYearBeforeLast,
        EndDateYearBeforeLast : Date;

        LargeEconomyInvoice,
        LargeEconomyLastYrInvoice,
        LargeEconomyYrBeforeLastInvoice : Decimal;

        SmallEconomyInvoice,
        SmallEconomyLastYrInvoice,
        SmallEconomyYrBeforeLastInvoice : Decimal;

        HouseholdInvoice,
        HouseholdLastYrInvoice,
        HouseholdYrBeforeLastInvoice : Decimal;

        SpecialCustomerInvoice,
        SpecialCustomerLastYrInvoice,
        SpecialCustomerYrBeforeLastInvoice : Decimal;

        KJKPInvoice,
        KJKPLastYrInvoice,
        KJKPYrBeforeLastInvoice : Decimal;

        LargeEconomyPayment,
        LargeEconomyLastYrPayment,
        LargeEconomyYrBeforeLastPayment : Decimal;

        SmallEconomyPayment,
        SmallEconomyLastYrPayment,
        SmallEconomyYrBeforeLastPayment : Decimal;

        HouseholdPayment,
        HouseholdLastYrPayment,
        HouseholdYrBeforeLastPayment : Decimal;

        SpecialCustomerPayment,
        SpecialCustomerLastYrPayment,
        SpecialCustomerYrBeforeLastPayment : Decimal;

        KJKPPayment,
        KJKPLastYrPayment,
        KJKPYrBeforeLastPayment : Decimal;

        LargeEconomyPercentage,
        LargeEconomyLastYrPercentage,
        LargeEconomyYrBeforeLastPercentage : Decimal;

        SmallEconomyPercentage,
        SmallEconomyLastYrPercentage,
        SmallEconomyYrBeforeLastPercentage : Decimal;

        HouseholdPercentage,
        HouseholdLastYrPercentage,
        HouseholdYrBeforeLastPercentage : Decimal;

        SpecialCustomerPercentage,
        SpecialCustomerLastYrPercentage,
        SpecialCustomerYrBeforeLastPercentage : Decimal;

        KJKPPercentage,
        KJKPLastYrPercentage,
        KJKPYrBeforeLastPercentage : Decimal;

        LargeEconomyIndex,
        SmallEconomyIndex,
        HouseholdIndex,
        SpecialCustomerIndex,
        KJKPIndex : Decimal;

        TotalInvoice,
        TotalPayment,
        TotalLastYrInvoice,
        TotalLastYrPayment,
        TotalYrBeforeLastInvoice,
        TotalYrBeforeLastPayment,
        TotalPercentage,
        TotalLastYrPercentage,
        TotalYrBeforeLastPercentage : Decimal;

        ReportTitle: Text;
        Text000Lbl: Label 'Period: %1';
        CustDateFilter: Text[30];
        PageNoCaptionLbl: Label 'Page';



    local Procedure GetMonthRange(CurrMonth: Integer; CurrYear: Integer; StartOrEnd: Boolean) ReturnDate: Date
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