page 50011 "Stay By Country Subf."
{
    Caption = 'Boravak po Državama';
    PageType = ListPart;
    SourceTable = "Travel Stay By Country";
    AutoSplitKey = true;
    DelayedInsert = true;
    MultipleNewLines = false;
    LinksAllowed = false;
    SaveValues = false;

    layout
    {
        area(Content)
        {
            repeater(Stavke)
            {
                field("ISO Kod Drzave"; Rec."ISO Kod Drzave")
                {
                    ApplicationArea = All;
                    Caption = 'Država (ISO)';
                    ToolTip = 'Odaberite državu iz padajuće liste. Ručni unos nije dozvoljen.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        BoravakMgt.ValidirajBoravak(Rec);
                        CurrPage.Update(false);
                    end;
                }
                field("Naziv Drzave"; Rec."Naziv Drzave")
                {
                    ApplicationArea = All;
                    Caption = 'Naziv Države';
                    Editable = false;
                    ToolTip = 'Pun naziv države — automatski se popunjava.';
                }
                field("Datum Vrijeme Ulaska"; Rec."Datum Vrijeme Ulaska")
                {
                    ApplicationArea = All;
                    Caption = 'Ulazak';
                    ToolTip = 'Datum i vrijeme ulaska u državu.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ProvjeriPreklapanje();
                        CurrPage.Update(false);
                    end;
                }
                field("Datum Vrijeme Izlaska"; Rec."Datum Vrijeme Izlaska")
                {
                    ApplicationArea = All;
                    Caption = 'Izlazak';
                    ToolTip = 'Datum i vrijeme izlaska iz države.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        ProvjeriPreklapanje();
                        CurrPage.Update(false);
                    end;
                }
                field("Trajanje Tekst"; Rec."Trajanje Tekst")
                {
                    ApplicationArea = All;
                    Caption = 'Trajanje';
                    Editable = false;
                    ToolTip = 'Automatski izračunato trajanje boravka (sati i minute).';
                    Style = StrongAccent;
                }
                field("Tip Boravka"; Rec."Tip Boravka")
                {
                    ApplicationArea = All;
                    Caption = 'Tip';
                    ToolTip = 'Standard ili Tranzit. Tranzit se obračunava identično standardnom boravku.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Status stavke boravka.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ValidirajKontinuitet)
            {
                ApplicationArea = All;
                Caption = '&Validiraj kontinuitet';
                Image = CheckRulesSyntax;
                ToolTip = 'Provjerava da nema vremenskih praznina ili preklapanja između svih stavki.';

                trigger OnAction()
                begin
                    BoravakMgt.ValidirajKontinuitetBoravaka(Rec."Broj Naloga");
                    Message('Validacija kontinuiteta prošla uspješno. Nema praznina ni preklapanja.');
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Auto-postavi ulazak = izlazak prethodne stavke (ako postoji)
        AutoPopuniUlazak();
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        if not BoravakMgt.DozvolioBrisanje(Rec) then
            Error('Nije dozvoljeno brisanje stavki boravka u trenutnom statusu putnog naloga.');
        exit(true);
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.IzracunajTrajanje();
    end;

    // ─────────────────────────────────────────────
    //  Lokalna logika
    // ─────────────────────────────────────────────

    var
        BoravakMgt: Codeunit "Stay Validation Mgt.";

    local procedure ProvjeriPreklapanje()
    begin
        if (Rec."Datum Vrijeme Ulaska" <> 0DT) and (Rec."Datum Vrijeme Izlaska" <> 0DT) then
            if BoravakMgt.PreklapaIzmedjuStavki(
                Rec."Broj Naloga",
                Rec."Datum Vrijeme Ulaska",
                Rec."Datum Vrijeme Izlaska",
                Rec."Broj Linije")
            then
                Error('Ovaj vremenski interval se preklapa sa postojećom stavkom boravka. Korigirajte datum/vrijeme.');
    end;

    local procedure AutoPopuniUlazak()
    var
        PrethodniBoravak: Record "Travel Stay By Country";
    begin
        PrethodniBoravak.SetRange("Broj Naloga", Rec."Broj Naloga");
        PrethodniBoravak.SetCurrentKey("Broj Naloga", "Datum Vrijeme Ulaska");
        PrethodniBoravak.SetAscending("Datum Vrijeme Ulaska", true);
        if PrethodniBoravak.FindLast() then
            if PrethodniBoravak."Datum Vrijeme Izlaska" <> 0DT then
                Rec."Datum Vrijeme Ulaska" := PrethodniBoravak."Datum Vrijeme Izlaska";
    end;
}
