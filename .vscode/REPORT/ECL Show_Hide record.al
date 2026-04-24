/*report 50024 "ECL Show/Hide record"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ECL ShowHide record.rdlc';
    Caption = 'Show record';

    dataset
    {
        dataitem(DataItem1; "Employee Contract Ledger")
        {

            trigger OnAfterGetRecord()
            begin
                IF DataItem1."Show Record" = TRUE THEN
                    DataItem1."Show Record" := FALSE
                ELSE
                    DataItem1."Show Record" := TRUE;
                DataItem1.MODIFY;
            end;

            trigger OnPreDataItem()
            begin
                DataItem1.SETFILTER("No.", '%1', BrojStavke);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BrojStavke; BrojStavke)
                {
                    ApplicationArea = all;
                    Caption = 'No.';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        BrojStavke: Integer;
}

*/