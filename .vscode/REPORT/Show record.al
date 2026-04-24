/*report 50083 "Show record"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Show record.rdlc';
    Caption = 'Show record';

    dataset
    {
        dataitem(DataItem1; "ECL systematization")
        {

            trigger OnAfterGetRecord()
            begin
                ECL.RESET;
                ECL.SETFILTER("Employee No.", '%1', "DataItem1"."Employee No.");
                ECL.SETFILTER("Org. Structure", '%1', "DataItem1"."Org. Structure");
                IF ECL.FINDSET THEN
                    REPEAT
                        ECL."Show Record" := TRUE;
                        ECL.MODIFY;
                    UNTIL ECL.NEXT = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BrojZaposlenika; BrojZaposlenika)
                {
                    ApplicationArea = all;
                    Caption = 'BrojZaposlenika';
                    TableRelation = Employee."No.";
                }
                field(OrgCode; OrgCode)
                {
                    ApplicationArea = all;
                    Caption = 'OrgCode';
                    TableRelation = "ORG Shema".Code;
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
        BrojZaposlenika: Code[10];
        OrgCode: Code[10];
        ECL: Record "Employee COntract Ledger";
}

*/