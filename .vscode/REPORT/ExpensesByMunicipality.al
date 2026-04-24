report 50160 "Expenses by municipality"
{
    DefaultLayout = RDLC;
    ApplicationArea = All;
    Caption = 'Expenses by municipality';
    RDLCLayout = './Expenses by municipality.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Municipality; Municipality)
        {
            column(Code; "Code") { }
            column(Name; Name) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(FilterMonth; FilterMonth) { }
            column(FilterYear; FilterYear) { }
            column(MonthName; MonthName) { }
            column(TodayDate; TodayDate) { }
            column(PIODoprinosi; PIODoprinosi) { }
            column(ZdravstvoDoprinosi; ZdravstvoDoprinosi) { }
            column(NezaposleniDoprinosi; NezaposleniDoprinosi) { }
            column(DoprinosiUkupno; DoprinosiUkupno) { }
            column(PIONaTeret; PIONaTeret) { }
            column(ZdravstvoNaTeret; ZdravstvoNaTeret) { }
            column(NezaposleniNaTeret; NezaposleniNaTeret) { }
            column(NaTeretUkupno; NaTeretUkupno) { }
            column(MunicipalityName; MunicipalityName) { }
            column(Osnovica; Osnovica) { }
            column(Taksa; Taksa) { }
            column(Posebni; Posebni) { }
            column(Dept; Dept) { }
            trigger OnPreDataItem()
            begin
                //SetRange("Entity Code", 'FBIH');
                //SetFilter(Code, '077|038|078|040|108|079|109|093|080|098');
                SetCurrentKey(Name);

                CompanyInfo.CalcFields(Picture);

                WH.Reset();
                WH.SetFilter("Month Of Wage", '%1', MonthInt);
                WH.SetFilter("Year Of Wage", '%1', YearInt);
                if WH.FindFirst() then begin
                    WageNo := WH."No.";
                end;

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', US."Employee No. for Wage");
                    ECL.SetFilter("Starting Date", '<=%1', Today);
                    ECL.SetCurrentKey("Starting Date");
                    ECL.Ascending := true;
                    if ECL.FindLast() then begin
                        Dept := ECL."Department Category";
                    end;
                end;

            end;

            trigger OnAfterGetRecord()
            var
                Position: Integer;
                Length: Integer;
                percF: Decimal;
                WCTotal: Record "Wage Calculation";
                WATotal: Record "Wage Addition";
                TaxBasisF: Decimal;

            begin
                PIODoprinosi := 0;
                PIONaTeret := 0;
                ZdravstvoDoprinosi := 0;
                ZdravstvoNaTeret := 0;
                NezaposleniDoprinosi := 0;
                NezaposleniNaTeret := 0;
                DoprinosiUkupno := 0;
                NaTeretUkupno := 0;
                Osnovica := 0;
                Taksa := 0;
                Posebni := 0;
                Dept := Dept;

                //Skracivanje naziva opstine, da izbaci nepotrebno " - SARAJEVO"
                Position := STRPOS(Name, '- Sarajevo');
                Length := STRLEN('- Sarajevo');

                // Ukloni " - SARAJEVO" ako postoji
                if Position > 0 then
                    MunicipalityName := DELSTR(Name, Position, Length)
                else
                    MunicipalityName := Name;
                TaxBasisF := 0;





                TPE.Reset();
                TPE.SetRange("Wage Header No.", WageNo);
                TPE.SetRange("Tax Number", Municipality.Code);
                TPE.SetFilter("Wage Calculation Type", '%1', 0);
                IF TPE.FindSet() then
                    repeat
                        WC.Reset();
                        WC.SetRange("No.", TPE."Wage Calculation No.");
                        WC.SetFilter("Month Of Wage", '%1', MonthInt);
                        WC.SetFilter("Year of Wage", '%1', YearInt);
                        IF WC.FindFirst() then begin
                            Osnovica += WC."Tax Basis";
                            Taksa += WC.Tax;
                            percF := Osnovica;

                            WVE.Reset();
                            WVE.SetFilter("Employee No.", '%1', WC."Employee No.");
                            WVE.SetFilter("Document No.", '%1', WC."Wage Header No.");
                            WVE.SetFilter("AT From neto", '%1', true);
                            WVE.SetFilter("Entry Type", '%1', WVE."Entry Type"::Contribution);
                            WVE.SetFilter("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            if WVE.FindFirst() then begin
                                WVE.CalcSums("Cost Amount (Actual)");
                                Posebni += WVE."Cost Amount (Actual)";
                            end;

                            WVE.Reset();
                            WVE.SetFilter("Document No.", '%1', WC."Wage Header No.");
                            WVE.SetFilter("Entry Type", '%1', WVE."Entry Type"::Tax);
                            WVE.SetFilter("Tax Number", '%1', Municipality.code);
                            WVE.SetFilter("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            if WVE.findset() then begin
                                WVE.CalcSums("Cost Amount (Actual)");
                                Taksa := WVE."Cost Amount (Actual)";
                            end;


                            WVE.Reset();
                            WVE.SetFilter("Document No.", '%1', WC."Wage Header No.");
                            WVE.SetFilter("Entry Type", '%1', WVE."Entry Type"::Tax);
                            WVE.SetFilter("Tax Number", '%1', Municipality.code);
                            WVE.SetFilter("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::Regular);
                            if WVE.findset() then begin
                                WVE.CalcSums(Basis);
                                TaxBasisF := WVE.Basis;
                            end;




                            PIODoprinosi := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-PIO-I*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount From Wage");
                                PIODoprinosi := CPE."Amount From Wage";
                            end;


                            ZdravstvoDoprinosi := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-ZDRAV-I*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount From Wage");
                                ZdravstvoDoprinosi := CPE."Amount From Wage";
                            end;


                            NezaposleniDoprinosi := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-NEZAP-I*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount From Wage");
                                NezaposleniDoprinosi := CPE."Amount From Wage";
                            end;

                            PIONaTeret := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-PIO-N*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount Over Wage");
                                PIONaTeret := CPE."Amount Over Wage";
                            end;


                            ZdravstvoNaTeret := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-ZDRAV-N*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount Over Wage");
                                ZdravstvoNaTeret := CPE."Amount Over Wage";
                            end;

                            NezaposleniNaTeret := 0;
                            CPE.Reset();
                            CPE.SetRange("Wage Header No.", WageNo);
                            CPE.SetFilter("Tax Number", '%1', Municipality.code);
                            CPE.SetFilter("Contribution Code", '%1', 'D-NEZAP-N*');
                            CPE.SetFilter("Wage Calculation Type", '%1', CPE."Wage Calculation Type"::Regular);

                            IF CPE.FindFirst() then begin
                                CPE.CalcSums("Amount Over Wage");
                                NezaposleniNaTeret := CPE."Amount Over Wage";
                            end;


                        end;


                        DoprinosiUkupno := PIODoprinosi + ZdravstvoDoprinosi + NezaposleniDoprinosi;
                        NaTeretUkupno := PIONaTeret + ZdravstvoNaTeret + NezaposleniNaTeret;
                    until tpe.Next() = 0;
                Osnovica := TaxBasisF;
                if (DoprinosiUkupno = 0) and (NaTeretUkupno = 0) then CurrReport.Skip();

            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(FilterPeriod)
                {
                    Caption = 'Insert the period';
                    field(FilterMonth; FilterMonth)
                    {
                        Caption = 'Month';
                        ApplicationArea = All;
                    }
                    field(FilterYear; FilterYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Year';
                    }
                }
            }
        }
        actions
        {
            area(Processing)
            {
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

        if FilterMonth = '' then
            FilterMonth := Format(DATE2DMY(CALCDATE('0D', WORKDATE), 2) - 1);

        if FilterYear = '' then
            FilterYear := Format(DATE2DMY(CALCDATE('0D', WORKDATE), 3));
    end;

    trigger OnPreReport()
    begin

        if FilterMonth = '' then
            Error(Txt001);

        if not Evaluate(MonthInt, FilterMonth) or (MonthInt < 1) or (MonthInt > 12) then
            Error(Txt003);

        if FilterYear = '' then
            Error(Txt002);

        if not Evaluate(YearInt, FilterYear) or (YearInt <= 1970) then
            Error(Txt004);

        MonthName := CU.NumberToMonth(MonthInt);

        TodayDate := Today;
    end;

    var

        CompanyInfo: Record "Company Information";
        FilterMonth, FilterYear : Text;
        MonthInt, YearInt : Integer;
        MonthName: Text;
        Txt001: Label 'You must enter a month.';
        Txt002: Label 'You must enter a year.';
        Txt003: Label 'You must enter a valid month. It must be a number between 1 and 12.';
        Txt004: Label 'You must enter a valid year. It must be a four-digit number greater than 1970.';
        CU: Codeunit TestSubsCu;
        TodayDate: Date;
        TPE: Record "Tax Per Employee";
        E: Record Employee;
        CPE: Record "Contribution Per Employee";
        WC: Record "Wage Calculation";
        PIODoprinosi, PIONaTeret : Decimal;
        ZdravstvoDoprinosi, ZdravstvoNaTeret : Decimal;
        NezaposleniDoprinosi, NezaposleniNaTeret : Decimal;
        DoprinosiUkupno, NaTeretUkupno : Decimal;
        MunicipalityName: Text;
        Osnovica: Decimal;
        Taksa: Decimal;
        WVE: Record "Wage Value Entry";
        Posebni: Decimal;
        WH: Record "Wage Header";
        WageNo: Text;
        US: Record "User Setup";
        ECL: Record "Employee Contract Ledger";
        Dept: Text;
}
