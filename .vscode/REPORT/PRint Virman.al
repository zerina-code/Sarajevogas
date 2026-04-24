report 50076 "PRint Virman"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PRint Virman.rdl';
    Caption = 'Print Virman';
    ProcessingOnly = false;

    dataset
    {
        dataitem(DataItem2936; "Payment Order")
        {
            RequestFilterFields = "Wage Header No.";
            column(SvrhaDoznake1_PaymentOrder; SvrhaDoznake1)
            {
            }
            column(Iznos_PaymentOrder; Iznos)
            {
            }
            column(VrstaPrihoda_PaymentOrder; VrstaPrihoda)
            {
            }
            column(Opstina_PaymentOrder; Opstina)
            {
            }
            column(PozivNaBroj_PaymentOrder; PozivNaBroj)
            {
            }
            column(BrojPoreznogObaveznika_PaymentOrder; CompInfo."Registration No.")
            {
            }
            column(PorezniPeriodOd_PaymentOrder; PorezniPeriodOd)
            {
            }
            column(PorezniPeriodDo_PaymentOrder; PorezniPeriodDo)
            {
            }
            column(RacunPosiljaoca_PaymentOrder; CompInfo."Giro No.")
            {
            }
            column(RacunPrimaoca_PaymentOrder; RacunPrimaoca)
            {
            }
            column(DatumUplate_PaymentOrder; "DatumUplate")
            {
            }
            column(MjestoUplate_PaymentOrder; MjestoUplate)
            {
            }
            column(Primalac3_PaymentOrder; Primalac3)
            {
            }
            column(Primalac2_PaymentOrder; Primalac2)
            {
            }
            column(Primalac1_PaymentOrder; Primalac1)
            {
            }
            column(EntryNo_PaymentOrder; "Entry No.")
            {
            }
            column(SvrhaDoznake2_PaymentOrder; SvrhaDoznake2)
            {
            }
            column(Name_CompanyInformation; CompInfo.Name)
            {
            }
            column(Name; Name)
            {
            }

            trigger OnAfterGetRecord()
            begin
                IF (RacunPosiljaoca = '') THEN
                    RacunPosiljaoca := '                ';

                IF (BrojPoreznogObaveznika = '') THEN
                    BrojPoreznogObaveznika := '             ';

                IF (VrstaPrihoda = '') THEN
                    VrstaPrihoda := '      ';

                IF (PozivNaBroj = '') THEN
                    PozivNaBroj := '          ';

                IF (Opstina = '') THEN
                    Opstina := '   ';

                IF (DatumUplate = 0D) THEN
                    DatumUplate := 17530101D;

                IF (PorezniPeriodOd = 0D) THEN
                    PorezniPeriodOd := 17530101D;

                IF (PorezniPeriodDo = 0D) THEN
                    PorezniPeriodDo := 17530101D;


                IF SvrhaDoznake1 = 'Neto na račun' THEN
                    Name := SvrhaDoznake3
                ELSE
                    Name := '';
            end;

            trigger OnPreDataItem()
            begin
                //SETFILTER("Wage Header No.",'%1',"Wage Header No.");
                CompInfo.GET;
                Name := '';
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        /*"Entry No.":="Entry No."+1;*/

    end;

    trigger OnPreReport()
    begin
        /*IF "Entry No." >= 3 THEN BEGIN
        CurrReport.NEWPAGE;
          END;*/

    end;

    var
        Text000: Label 'Do you want to copy the production forecast?';
        CompInfo: Record "Company Information";
        Name: Text[150];
}

