report 50052 "Evidencija preraspoređeni"
{
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './EvidencijaPrerasporedjenih.rdl';

    dataset
    {
        dataitem(DataItem1; "Employee Contract Ledger")
        {
            //The property 'DataItemTableView' shouldn't have an empty value.
            //DataItemTableView='';
            RequestFilterFields = "Starting Date";
            column(EmployeeName_EmployeeContractLedger; DataItem1."Employee Name")
            {
                IncludeCaption = true;
            }
            column(Status_EmployeeContractLedger; DataItem1.Status)
            {
            }
            column(ID; DataItem1."Employee No.")
            {
            }
            column(StariUgovor; PomocnaStariUgovor)
            {
            }
            column(StartingDate_EmployeeContractLedger; DataItem1."Starting Date")
            {
            }
            column(ReasonforChange_EmployeeContractLedger; DataItem1."Reason for Change")
            {
            }
            column(BrojTelefona; CompInfo."Phone No.")
            {
            }
            column(Grad; CompInfo.City)
            {
            }
            column(Adresa; CompInfo.Address)
            {
            }
            column(kod; CompInfo."Country/Region Code")
            {
            }
            column(AktivniUgovor; DataItem1."Position Description")
            {
            }
            column(Picture; CompInfo.Picture)
            {
            }



            trigger OnAfterGetRecord()
            begin

                CompInfo.GET();
                CompInfo.CALCFIELDS(Picture);
                //Stari ugovor

                EmployeeContractLedger2.RESET;
                EmployeeContractLedger2.SETFILTER("Employee No.", '%1', DataItem1."Employee No.");
                EmployeeContractLedger2.SETFILTER("Starting Date", '<%1', DataItem1."Starting Date");
                EmployeeContractLedger2.SETCURRENTKEY("Starting Date");
                EmployeeContractLedger2.ASCENDING(FALSE);
                //dodan filter da se Edin ne bi ponavljao
                EmployeeContractLedger2.SETFILTER("Show Record", '%1', TRUE);
                PomocnaAktivniUgovor := '';
                IF EmployeeContractLedger2.FINDFIRST THEN
                    PomocnaStariUgovor := EmployeeContractLedger2."Position Description"
                ELSE
                    PomocnaStariUgovor := '';
                //EmployeeContractLedger2.SETFILTER("Employee No.", '<>%1', DataItem1."Employee No.");
            end;

            trigger OnPreDataItem()
            begin
                DataItem1.SETFILTER("Reason for Change", '%1', DataItem1."Reason for Change"::"Relocation");
                //"Employee Contract Ledger".SETFILTER(Active,'%1',TRUE); //ne ovako, jer radim naopako; ovdje sam odmah stavila sebi da budu svi AKTIVNI, samim tim
                //nema starih ugovora tj. pozicija
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
        EmployeeContractLedger: Record "Employee Contract Ledger";
        PomocnaAktivniUgovor: Text;
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        PomocnaStariUgovor: Text;
        CompInfo: Record "Company Information";
}

