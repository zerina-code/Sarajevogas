report 50081 "Purchase Plan Report"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Purchase Plan Report.rdl';

    dataset
    {
        dataitem(DataItem21; "Purchase Plan")
        {
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(No_; "No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Komercijala___rebalans; "Komercijala - rebalans")
            {
            }
            column("Tekuće_potrebe___rebalans"; "Tekuće potrebe - rebalans")
            {
            }
            column(Investiciono___rebalans; "Investiciono - rebalans")
            {
            }
            column(Total___rebalans; "Total - rebalans")
            {
            }
            column(Komercijala___realizacija; "Komercijala - realizacija")
            {
            }
            column(Investiciono___realizacija; "Investiciono - realizacija")
            {
            }
            column("Tekuće_potrebe___realizacija"; "Tekuće potrebe - realizacija")
            {
            }
            column(Total___realizacija; "Total - realizacija")
            {
            }
            column(Remained; Remained)
            {
            }
            column(Index; Index)
            {
            }
            column(Purchase_Type; "Purchase Type")
            {
            }
            column(Direktni_sporazum; "Direktni sporazum")
            {
            }
            column(RobaInvesticionoRebalans; RobaInvesticionoRebalans)
            {
            }
            column(RobaKomercijalaRebalans; RobaKomercijalaRebalans)
            {
            }
            column(RobaTekuceRebalans; RobaTekuceRebalans)
            {
            }
            column(RobaUkupnoRebalans; RobaUkupnoRebalans)
            {
            }
            column(RobaInvesticionoRealizacija; RobaInvesticionoRealizacija)
            {
            }
            column(RobaKomercijalaRealizacija; RobaKomercijalaRealizacija)
            {
            }
            column(RobaTekuceRealizacija; RobaTekuceRealizacija)
            {
            }
            column(RobaUkupnoRealizacija; RobaUkupnoRealizacija)
            {
            }
            column(CurrentRemain; CurrentRemain)
            {
            }
            column(CurrentIndex; CurrentIndex)
            {
            }
            column(Purchase_Plan_Code; "Purchase Plan Code")
            {
            }
            column(RadoviInvesticionoRebalans; RadoviInvesticionoRebalans)
            {
            }
            column(RadoviKomercijalaRebalans; RadoviKomercijalaRebalans)
            {
            }
            column(RadoviTekuceRebalans; RadoviTekuceRebalans)
            {
            }
            column(RadoviUkupnoRebalans; RadoviUkupnoRebalans)
            {
            }
            column(RadoviInvesticionoRealizacija; RadoviInvesticionoRealizacija)
            {
            }
            column(RadoviKomercijalaRealizacija; RadoviKomercijalaRealizacija)
            {
            }
            column(RadoviTekuceRealizacija; RadoviTekuceRealizacija)
            {
            }
            column(RadoviUkupnoRealizacija; RadoviUkupnoRealizacija)
            {
            }
            column(UslugeInvesticionoRebalans; UslugeInvesticionoRebalans)
            {
            }
            column(UslugeKomercijalaRebalans; UslugeKomercijalaRebalans)
            {
            }
            column(UslugeTekuceRebalans; UslugeTekuceRebalans)
            {
            }
            column(UslugeUkupnoRebalans; UslugeUkupnoRebalans)
            {
            }
            column(UslugeInvesticionoRealizacija; UslugeInvesticionoRealizacija)
            {
            }
            column(UslugeKomercijalaRealizacija; UslugeKomercijalaRealizacija)
            {
            }
            column(UslugeTekuceRealizacija; UslugeTekuceRealizacija)
            {
            }
            column(UslugeUkupnoRealizacija; UslugeUkupnoRealizacija)
            {
            }

            column(RobaDSInvesticionoRebalans; RobaDSInvesticionoRebalans)
            {
            }
            column(RobaDSKomercijalaRebalans; RobaDSKomercijalaRebalans)
            {
            }
            column(RobaDSTekuceRebalans; RobaDSTekuceRebalans)
            {
            }
            column(RobaDSUkupnoRebalans; RobaDSUkupnoRebalans)
            {
            }
            column(RobaDSInvesticionoRealizacija; RobaDSInvesticionoRealizacija)
            {
            }
            column(RobaDSKomercijalaRealizacija; RobaDSKomercijalaRealizacija)
            {
            }
            column(RobaDSTekuceRealizacija; RobaDSTekuceRealizacija)
            {
            }
            column(RobaDSUkupnoRealizacija; RobaDSUkupnoRealizacija)
            {
            }

            column(UslugeDSInvesticionoRebalans; UslugeDSInvesticionoRebalans)
            {
            }
            column(UslugeDSKomercijalaRebalans; UslugeDSKomercijalaRebalans)
            {
            }
            column(UslugeDSTekuceRebalans; UslugeDSTekuceRebalans)
            {
            }
            column(UslugeDSUkupnoRebalans; UslugeDSUkupnoRebalans)
            {
            }
            column(UslugeDSInvesticionoRealizacija; UslugeDSInvesticionoRealizacija)
            {
            }
            column(UslugeDSKomercijalaRealizacija; UslugeDSKomercijalaRealizacija)
            {
            }
            column(UslugeDSTekuceRealizacija; UslugeDSTekuceRealizacija)
            {
            }
            column(UslugeDSUkupnoRealizacija; UslugeDSUkupnoRealizacija)
            {
            }

            column(RadoviDSInvesticionoRebalans; RadoviDSInvesticionoRebalans)
            {
            }
            column(RadoviDSKomercijalaRebalans; RadoviDSKomercijalaRebalans)
            {
            }
            column(RadoviDSTekuceRebalans; RadoviDSTekuceRebalans)
            {
            }
            column(RadoviDSUkupnoRebalans; RadoviDSUkupnoRebalans)
            {
            }
            column(RadoviDSKomercijalaRealizacija; RadoviDSKomercijalaRealizacija)
            {
            }
            column(RadoviDSInvesticionoRealizacija; RadoviDSInvesticionoRealizacija)
            {
            }
            column(RadoviDSTekuceRealizacija; RadoviDSTekuceRealizacija)
            {
            }
            column(RadoviDSUkupnoRealizacija; RadoviDSUkupnoRealizacija)
            {
            }


            trigger OnAfterGetRecord()
            begin
                if ("Purchase Type".AsInteger() = 1) and ("Direktni sporazum".AsInteger() <> 1) then begin //roba, ne direktni sporazum

                    RobaKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO ROBE, dio REBALANS
                    RobaInvesticionoRebalans += "Investiciono - rebalans";
                    RobaTekuceRebalans += "Tekuće potrebe - rebalans";
                    RobaUkupnoRebalans += "Total - rebalans";

                    RobaKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO ROBE, dio REALIZACIJA
                    RobaInvesticionoRealizacija += "Investiciono - realizacija";
                    RobaTekuceRealizacija += "Tekuće potrebe - realizacija";
                    RobaUkupnoRealizacija += "Total - realizacija";
                end;

                if ("Purchase Type".AsInteger() = 2) AND ("Direktni sporazum".AsInteger() <> 1) then begin //radovi, ne direktni sporazum
                    RadoviKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO RADOVI, dio REBALANS
                    RadoviInvesticionoRebalans += "Investiciono - rebalans";
                    RadoviTekuceRebalans += "Tekuće potrebe - rebalans";
                    RadoviUkupnoRebalans += "Total - rebalans";

                    RadoviKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO RADOVI, dio REALIZACIJA
                    RadoviInvesticionoRealizacija += "Investiciono - realizacija";
                    RadoviTekuceRealizacija += "Tekuće potrebe - realizacija";
                    RadoviUkupnoRealizacija += "Total - realizacija";
                end;

                if ("Purchase Type".AsInteger() = 3) AND ("Direktni sporazum".AsInteger() <> 1) then begin //usluge, ne direktni sporazum
                    UslugeKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO USLUGE, dio REBALANS
                    UslugeInvesticionoRebalans += "Investiciono - rebalans";
                    UslugeTekuceRebalans += "Tekuće potrebe - rebalans";
                    UslugeUkupnoRebalans += "Total - rebalans";

                    UslugeKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO USLUGE, dio REALIZACIJA
                    UslugeInvesticionoRealizacija += "Investiciono - realizacija";
                    UslugeTekuceRealizacija += "Tekuće potrebe - realizacija";
                    UslugeUkupnoRealizacija += "Total - realizacija";
                end;

                if ("Purchase Type".AsInteger() = 1) and ("Direktni sporazum".AsInteger() = 1) then begin //roba, uz direktni sporazum                     
                    RobaDSKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO ROBE, dio REBALANS
                    RobaDSInvesticionoRebalans += "Investiciono - rebalans";
                    RobaDSTekuceRebalans += "Tekuće potrebe - rebalans";
                    RobaDSUkupnoRebalans += "Total - rebalans";

                    RobaDSKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO ROBE, dio REALIZACIJA
                    RobaDSInvesticionoRealizacija += "Investiciono - realizacija";
                    RobaDSTekuceRealizacija += "Tekuće potrebe - realizacija";
                    RobaDSUkupnoRealizacija += "Total - realizacija";
                end;

                if ("Purchase Type".AsInteger() = 3) AND ("Direktni sporazum".AsInteger() = 1) then begin //usluge, uz direktni sporazum
                    UslugeDSKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO USLUGE, dio REBALANS
                    UslugeDSInvesticionoRebalans += "Investiciono - rebalans";
                    UslugeDSTekuceRebalans += "Tekuće potrebe - rebalans";
                    UslugeDSUkupnoRebalans += "Total - rebalans";

                    UslugeDSKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO USLUGE, dio REALIZACIJA
                    UslugeDSInvesticionoRealizacija += "Investiciono - realizacija";
                    UslugeDSTekuceRealizacija += "Tekuće potrebe - realizacija";
                    UslugeDSUkupnoRealizacija += "Total - realizacija";
                end;

                if ("Purchase Type".AsInteger() = 2) AND ("Direktni sporazum".AsInteger() = 1) then begin //radovi, uz direktni sporazum
                    RadoviDSKomercijalaRebalans += "Komercijala - rebalans"; //račun za red: UKUPNO RADOVI, dio REBALANS
                    RadoviDSInvesticionoRebalans += "Investiciono - rebalans";
                    RadoviDSTekuceRebalans += "Tekuće potrebe - rebalans";
                    RadoviDSUkupnoRebalans += "Total - rebalans";

                    RadoviDSKomercijalaRealizacija += "Komercijala - realizacija"; //račun za red: UKUPNO RADOVI, dio REALIZACIJA
                    RadoviDSInvesticionoRealizacija += "Investiciono - realizacija";
                    RadoviDSTekuceRealizacija += "Tekuće potrebe - realizacija";
                    RadoviDSUkupnoRealizacija += "Total - realizacija";
                end;

                CurrentRemain := "Total - rebalans" - "Total - realizacija"; //ostatak nabavki za svaki red
                if "Total - rebalans" <> 0 then
                    CurrentIndex := "Total - realizacija" / "Total - rebalans" * 100 //index za svaki red
                else
                    CurrentIndex := 0;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                RobaKomercijalaRebalans := 0;
                RobaInvesticionoRebalans := 0;
                RobaTekuceRebalans := 0;
                RobaUkupnoRebalans := 0;

                RobaKomercijalaRealizacija := 0;
                RobaInvesticionoRealizacija := 0;
                RobaTekuceRealizacija := 0;
                RobaUkupnoRealizacija := 0;

                RadoviKomercijalaRebalans := 0;
                RadoviInvesticionoRebalans := 0;
                RadoviTekuceRebalans := 0;
                RadoviUkupnoRebalans := 0;

                RadoviKomercijalaRealizacija := 0;
                RadoviInvesticionoRealizacija := 0;
                RadoviTekuceRealizacija := 0;
                RadoviUkupnoRealizacija := 0;

                UslugeKomercijalaRebalans := 0;
                UslugeInvesticionoRebalans := 0;
                UslugeTekuceRebalans := 0;
                UslugeUkupnoRebalans := 0;

                UslugeKomercijalaRealizacija := 0;
                UslugeInvesticionoRealizacija := 0;
                UslugeTekuceRealizacija := 0;
                UslugeUkupnoRealizacija := 0;

                RobaDSKomercijalaRebalans := 0;
                RobaDSInvesticionoRebalans := 0;
                RobaDSTekuceRebalans := 0;
                RobaDSUkupnoRebalans := 0;

                RobaDSKomercijalaRealizacija := 0;
                RobaDSInvesticionoRealizacija := 0;
                RobaDSTekuceRealizacija := 0;
                RobaDSUkupnoRealizacija := 0;

                UslugeDSKomercijalaRebalans := 0;
                UslugeDSInvesticionoRebalans := 0;
                UslugeDSTekuceRebalans := 0;
                UslugeDSUkupnoRebalans := 0;

                UslugeDSKomercijalaRealizacija := 0;
                UslugeDSInvesticionoRealizacija := 0;
                UslugeDSTekuceRealizacija := 0;
                UslugeDSUkupnoRealizacija := 0;

                RadoviDSKomercijalaRebalans := 0;
                RadoviDSInvesticionoRebalans := 0;
                RadoviDSTekuceRebalans := 0;
                RadoviDSUkupnoRebalans := 0;

                RadoviDSKomercijalaRealizacija := 0;
                RadoviDSInvesticionoRealizacija := 0;
                RadoviDSTekuceRealizacija := 0;
                RadoviDSUkupnoRealizacija := 0;
            end;
        }
    }

    var
        CompanyInformation: Record "Company Information";

        CurrentRemain: Decimal;
        CurrentIndex: Decimal;

        RobaKomercijalaRebalans: Decimal;
        RobaInvesticionoRebalans: Decimal;
        RobaTekuceRebalans: Decimal;
        RobaUkupnoRebalans: Decimal;

        RobaKomercijalaRealizacija: Decimal;
        RobaInvesticionoRealizacija: Decimal;
        RobaTekuceRealizacija: Decimal;
        RobaUkupnoRealizacija: Decimal;

        RadoviKomercijalaRebalans: Decimal;
        RadoviInvesticionoRebalans: Decimal;
        RadoviTekuceRebalans: Decimal;
        RadoviUkupnoRebalans: Decimal;

        RadoviKomercijalaRealizacija: Decimal;
        RadoviInvesticionoRealizacija: Decimal;
        RadoviTekuceRealizacija: Decimal;
        RadoviUkupnoRealizacija: Decimal;

        UslugeKomercijalaRebalans: Decimal;
        UslugeInvesticionoRebalans: Decimal;
        UslugeTekuceRebalans: Decimal;
        UslugeUkupnoRebalans: Decimal;

        UslugeKomercijalaRealizacija: Decimal;
        UslugeInvesticionoRealizacija: Decimal;
        UslugeTekuceRealizacija: Decimal;
        UslugeUkupnoRealizacija: Decimal;

        RobaDSKomercijalaRebalans: Decimal;
        RobaDSInvesticionoRebalans: Decimal;
        RobaDSTekuceRebalans: Decimal;
        RobaDSUkupnoRebalans: Decimal;

        RobaDSKomercijalaRealizacija: Decimal;
        RobaDSInvesticionoRealizacija: Decimal;
        RobaDSTekuceRealizacija: Decimal;
        RobaDSUkupnoRealizacija: Decimal;

        UslugeDSKomercijalaRebalans: Decimal;
        UslugeDSInvesticionoRebalans: Decimal;
        UslugeDSTekuceRebalans: Decimal;
        UslugeDSUkupnoRebalans: Decimal;

        UslugeDSKomercijalaRealizacija: Decimal;
        UslugeDSInvesticionoRealizacija: Decimal;
        UslugeDSTekuceRealizacija: Decimal;
        UslugeDSUkupnoRealizacija: Decimal;

        RadoviDSKomercijalaRebalans: Decimal;
        RadoviDSInvesticionoRebalans: Decimal;
        RadoviDSTekuceRebalans: Decimal;
        RadoviDSUkupnoRebalans: Decimal;

        RadoviDSKomercijalaRealizacija: Decimal;
        RadoviDSInvesticionoRealizacija: Decimal;
        RadoviDSTekuceRealizacija: Decimal;
        RadoviDSUkupnoRealizacija: Decimal;
}

