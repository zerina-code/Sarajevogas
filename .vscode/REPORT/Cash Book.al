report 50075 "Cash Book"
{
    //ED
    DefaultLayout = RDLC;
    RDLCLayout = './Cash Book.rdl';

    dataset
    {
        dataitem(DataItem22; "Bank Account Ledger Entry")
        {

            RequestFilterFields = "Posting Date";

            column(PostingDate; DataItem22."Posting Date")
            {
            }
            column(JBName; DataItem22."Journal Batch Name")
            {
            }
            column(GLNo; DataItem22."Entry No.")
            {
            }
            column(DocumentNo; DataItem22."Document No.")
            {
            }
            column(Amound; DataItem22.Amount)
            {
            }
            column(Description; DataItem22.Description)
            {
            }
            column(Ext; DataItem22."External Document No.")
            {
            }
            column(Datum; Datum)
            {
            }
            column(Brdokumenta; Brdokumenta)
            {
            }
            column(Kolicina; Kolicina)
            {
            }
            column(DatumIS; DatumIS)
            {
            }
            column(BrdokumentaIS; BrdokumentaIS)
            {
            }
            column(KolicinaIS; KolicinaIS)
            {
            }
            column(PostingDatefilter; PostingDatefilter)
            {
            }
            column(Adress_CompanyInfo; CompanyInformation.Address)
            {
            }
            column(City_CompanyInfo; CompanyInformation.City)
            {
            }
            column(Phone1_CompanyInfo; CompanyInformation."Phone No.")
            {
            }
            column(Phone2_CompanyInfo; CompanyInformation."Phone No. 2")
            {
            }
            column(Fax_CompanyInfo; CompanyInformation."Fax No.")
            {
            }
            column(Email_CompanyInfo; CompanyInformation."E-Mail")
            {
            }
            column(Homepage_CompanyInfo; CompanyInformation."Home Page")
            {
            }
            column(RegistrationNo_CompanyInfo; CompanyInformation."Registration No.")
            {
            }
            column(Postcode_CompanyInfo; CompanyInformation."Post Code")
            {
            }
            column(VATRegistrationNo_CompanyInfo; CompanyInformation."VAT Registration No.")
            {
            }
            column(GiroNo_CompanyInfo; CompanyInformation."Giro No.")
            {
            }
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(PrethodniSaldo; PrethodniSaldo)
            {
            }
            column(EmmployeeName; EmmployeeName)
            {
            }
            column(BankAccCardFilter; BankAccCardFilter)
            {
            }
            column(Prikazi; Prikazi)
            {

            }
            column(polje3; polje3)
            {

            }


            trigger OnAfterGetRecord()
            var
                banacc: Record "Bank Account";
                gl: record "G/L Entry";
                banacc2: record "Bank Account";
                BALE: record "Bank Account Ledger Entry";
            begin
                Kolicina := 0;
                KolicinaIS := 0;


                if banacc.get("Bank Account No.") then begin
                    if banacc.Showondocument = true then begin
                        Prikazi := 'DA';
                        polje3 := 'DA';

                        EmmployeeName := '';

                        if "Debit Amount" <> 0 then begin //ulaz u blagajnu je uplata
                            Datum := "Posting Date";
                            Brdokumenta := "Document No.";
                            BrdokumentaIS := '';
                            Kolicina := Amount;
                            KolicinaIS := 0;
                        end;


                        if "Credit Amount" <> 0 then begin //potražni iznos je isplata: polog pazara, isplata zaposlenima itd.
                            Datum := "Posting Date";
                            Brdokumenta := '';
                            BrdokumentaIS := "Document No.";
                            Kolicina := 0;
                            KolicinaIS := Amount;
                        end;
                    end;
                end;
                BALE.Reset();
                BALE.SETFILTER("Posting Date", '<%1', "Posting Date");
                BALE.setfilter("Bal. Account No.", '%1', DataItem22."Bal. Account No.");
                IF BALE.FIND('-') THEN begin
                    banacc.Reset();
                    banacc.GET(BALE."Bank Account No.");
                    BALE.CalcSums("Amount (LCY)");
                    if banacc.Showondocument = true then
                        PrethodniSaldo := BALE."Amount (LCY)";
                end;

                /*emp.SETFILTER("No.", '%1', "Employee No.");
                IF emp.FIND('-') THEN
                    EmmployeeName := emp."First Name" + ' ' + emp."Last Name";*/
            end;


            trigger OnPreDataItem()
            begin
                DataItem22.SetFilter("Bank Account No.", '<>%1', '');

                PostingDatefilter := GETFILTER("Posting Date");
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInformation: Record "Company Information";
        GLEntry: Record "G/L Entry";
        Country: Text[100];
        City: Text[100];
        Test: Integer;
        CountryRegion: Record "Country/Region";
        Location: Record Location;
        PostingDatefilter: Text[100];
        BankAccCardFilter: Code[20];
        BankAccountName: Text[100];
        Datum: Date;
        bankacc: record "Bank Account";
        Brdokumenta: Text[100];
        Kolicina: Decimal;
        DatumIS: Date;
        BrdokumentaIS: Text[100];
        KolicinaIS: Decimal;
        BankAccount: Record "Bank Account";
        PrethodniSaldo: Decimal;
        emp: Record Employee;
        EmmployeeName: Text[150];
        BALE: Record "Bank Account Ledger Entry";
        Showondocument: Boolean;
        Prikazi: text[20];
        testnopolje: text[20];
        polje3: text[20];



}

