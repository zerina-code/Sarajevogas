/*report 50081 CR
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;
    WordLayout = './CR.docx';
    //RDLCLayout = './CR.rdl';
    Caption = 'CR';
    ProcessingOnly = false;

    dataset
    {
        dataitem(DataItem1; "Sales Header")
        {
            column(ColumnName; DataItem1."Sell-to Customer Name")
            {

            }
            column(Naziv_kompanije; CompanyInfo.Name)
            {

            }
            column(Datum_izvjestaja; format(TODAY, 0, '<Day,2>.<Month,2>.<Year4>.'))
            {

            }
            column(Narucitelj; Narucitelj)
            {

            }
            column(Broj_Ugovora; BrojUgovora)
            {

            }
            column(Podnositelj_zahtjeva; Podnositelj_zahtjeva)
            {

            }
            column(Odgovorna_osoba; Odgovorna_osoba)
            {

            }
            column(Odgovorna_osoba_Infodom; Odgovorna_osoba_Infodom)
            {

            }
            column(HD_broj; HD_broj)
            {

            }
            column(Podrucje_obuhvaceno_promjenom; Podrucje_obuhvaceno_promjenom)
            {

            }
            column(Covjek_Sat; Covjek_Sat)
            {

            }
            column(Iznos_bez_PDV_a; Iznos_bez_PDV_a)
            {

            }

            column(Krajnji_rok_za_implementaciju; Krajnji_rok_za_implementaciju)
            {

            }
            column(Ozbiljnost; Ozbiljnost)
            {

            }
            column(Dizajner; Dizajner)
            {

            }
            column(Voditelj_projekta; Voditelj_projekta)
            {

            }
            column(Sazetak; format(Sazetak))
            {

            }
            column(Detaljan_opis; format(Detaljan_opis))
            {

            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SalesLine: Record "Sales Line";

            begin
                CompanyInfo.get;
                Narucitelj := DataItem1.Orderer;
                BrojUgovora := DataItem1."Contract Number";
                Podnositelj_zahtjeva := DataItem1."Order person";
                Odgovorna_osoba := DataItem1."Responsible Person";
                Odgovorna_osoba_Infodom := DataItem1."Responsible Person Infodom";
                HD_broj := DataItem1."HD Number";
                Podrucje_obuhvaceno_promjenom := DataItem1."Area covered by changes";
                Ozbiljnost := DataItem1.seriousness;
                Voditelj_projekta := DataItem1."Project manager";
                Dizajner := DataItem1.Designer;

                SalesLine.Reset();
                SalesLine.SetFilter("Document No.", '%1', DataItem1."No.");
                SalesLine.SetFilter(type, '<>%1', SalesLine.Type::" ");
                if SalesLine.FindFirst() then begin
                    SalesLine.CalcSums(Amount, Quantity);
                    Iznos_bez_PDV_a := SalesLine.Amount;
                    Covjek_Sat := format(SalesLine.Quantity) + 'h';

                end
                else begin
                    Iznos_bez_PDV_a := 0;
                    Covjek_Sat := '';
                end;
                Krajnji_rok_za_implementaciju := DataItem1.Deadline;
                TemplateMessages.Reset();
                TemplateMessages.SetFilter("Document No.", '%1', DataItem1."No.");
                TemplateMessages.SetFilter(type, '%1', TemplateMessages.Type::Abstract);
                if TemplateMessages.FindFirst() then begin
                    TemplateMessages.CALCFIELDS("Message Text");

                    TemplateMessages."Message Text".CREATEINSTREAM(IStream);
                    Sazetak.Read(IStream);
                end
                else begin
                    Sazetak.AddText('');
                end;

                TemplateMessages2.Reset();
                TemplateMessages2.SetFilter("Document No.", '%1', DataItem1."No.");
                TemplateMessages2.SetFilter(type, '%1', TemplateMessages.Type::"Detailed Description");
                if TemplateMessages2.FindFirst() then begin
                    TemplateMessages2.CALCFIELDS("Message Text");

                    TemplateMessages2."Message Text".CREATEINSTREAM(IStream2);
                    Detaljan_opis.Read(IStream2);
                end
                else begin
                    Detaljan_opis.AddText('');
                end;




            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";

        Narucitelj: Text[1000];
        BrojUgovora: Text[1000];

        Podnositelj_zahtjeva: Text[1000];
        TemplateMessages: Record Template_Message;
        IStream: InStream;
        IStream2: InStream;
        TemplateMessages2: Record Template_Message;

        Odgovorna_osoba: Text[1000];
        Odgovorna_osoba_Infodom: Text[1000];

        HD_broj: text[1000];
        Podrucje_obuhvaceno_promjenom: Text[1000];
        Covjek_Sat: Text[1000];
        Iznos_bez_PDV_a: Decimal;

        Krajnji_rok_za_implementaciju: Text[1000];

        Ozbiljnost: Integer;
        Dizajner: Text[1000];
        Voditelj_projekta: Text[1000];
        Sazetak: BigText;
        Detaljan_opis: BigText;
}
*/