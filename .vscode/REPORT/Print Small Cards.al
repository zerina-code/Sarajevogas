report 50080 "Print Small Cards"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Print Small Cards.rdl';

    dataset
    {

        dataitem(DataItem21; "Warehouse Receipt Line")
        {
            /*column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }*/
            column(No_; "No.") //broj primke
            {
            }
            column(ReceiptPostingDate; ReceiptPostingDate) //datum primke
            {
            }
            column(Item_No_; "Item No.") //sifra artikla
            {
            }
            column(ItemDescription; ItemDescription) //naziv artikla
            {
            }
            column(ItemUOM; ItemUOM) //jedinica mjere
            {
            }

            trigger OnAfterGetRecord()
            begin
                //kada se uzme jedan red skladisne primke treba iz headera preuzeti: broj primke i datum

                WarehouseReceiptHeaderTable.Reset();
                WarehouseReceiptHeaderTable.SetFilter("No.", '%1', WarehouseReceiptNoFilter);
                if WarehouseReceiptHeaderTable.FindFirst() then
                    ReceiptPostingDate := WarehouseReceiptHeaderTable."Posting Date"; //preuzimam datum primke

                //za artikal u redu treba pretražiti tabelu item prema šifri artikla
                //iz tabele item se preuzimaju podaci: naziv i jedinica mjere

                ItemTable.Reset();
                ItemTable.SetFilter("No.", '%1', "Item No.");
                if ItemTable.FindFirst() then begin //artikal iz primke je pronadjen u tabeli Item
                    ItemDescription := ItemTable.Description; //preuzimam naziv artikla
                    ItemUOM := ItemTable."Base Unit of Measure"; //preuzimam jedinicu mjere
                end;

                //ZA SVAKI ARTIKAL TREBA PONOVO POKRENUTI IZVJEŠTAJ

            end;

            trigger OnPreDataItem()
            begin
                DataItem21.Reset();
                DataItem21.SetFilter("No.", '%1', WarehouseReceiptNoFilter);
            end;
        }
        dataitem(DataItem22; Integer)
        {
            column(Number; Number)
            {
            }

            trigger OnPreDataItem()
            begin
                //DataItem22.SetFilter(Number, '<=%1', 3);
            end;
        }
    }

    requestpage
    {
        Caption = 'Print Small Cards';

        layout
        {
            area(content)
            {
                group("Copies")
                {
                    Caption = 'Filter: Print';

                    field(NumberOfCopies; NumberOfCopies)
                    {
                        Caption = 'Number of copies';
                    }
                    field(ItemFilterNo; ItemFilterNo)
                    {
                        Caption = 'Item No.';
                        //TableRelation = "Warehouse Receipt Line"."Item No." where ("No."=const()))

                    }
                    field(WarehouseReceiptNoFilter; WarehouseReceiptNoFilter)
                    {
                        caption = 'SKLPR-22-0085';
                    }
                }
            }
        }
    }

    procedure SetParam(WarehouseReceiptNo: Code[20])    //veza izmedju WarehouseReceiptHeader i WarehouseReceiptLine je polje No.
    begin
        WarehouseReceiptNoFilter := WarehouseReceiptNo;
    end;

    var
        CompanyInformation: Record "Company Information";
        WarehouseReceiptHeaderTable: Record "Warehouse Receipt Header";
        WarehouseReceiptLineTable: Record "Warehouse Receipt Line";
        ItemTable: Record Item;
        ItemDescription: Text[100];
        ItemUOM: Code[10];
        ItemNo: Code[20];
        NumberOfCopies: Integer;
        ItemFilterNo: Code[20];
        WarehouseReceiptNoFilter: Code[20];
        ReceiptPostingDate: Date;
}

