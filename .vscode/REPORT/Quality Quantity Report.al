report 50078 "Quality Quantity Report"
{

    //ED

    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Quality Quantity Report.rdl';

    dataset
    {
        dataitem(DataItem21; "Warehouse Receipt Header")
        {
            column(Picture_CompanyInfo; CompanyInformation.Picture)
            {
            }
            column(LocationName; LocationName)
            {
            }
            column(Today; Today)
            {
            }
            column(Driver_Name; "Driver Name")
            {
            }
            column(Shipping_Agent_Name; "Shipping Agent Name")
            {
            }
            column(Transport_Document_No_; "Transport Document No.")
            {
            }
            column(Truck_Number; "Truck Number")
            {
            }
            column(Selected; Selected)
            {
            }
            column(CD_Number; "CD Number")
            {
            }
            column(Supplier; Supplier)
            {
            }
            column(SourceNo; SourceNo)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(OrderDate; OrderDate)
            {
            }
            column(Posting_Date; "Posting Date") //datum isporuke na izvjestaju je datum knjizenja na primci
            {
            }

            trigger OnAfterGetRecord()
            begin
                LocationTable.Reset(); //naziv skladista, ne samo sifra
                LocationTable.SetFilter(Code, '%1', "Location Code");
                if LocationTable.FindFirst() then
                    LocationName := LocationTable.Name;

                WarehouseReceiptLine.Reset(); //iz linija primke preuzimam broj narudžbenice
                WarehouseReceiptLine.SetFilter("No.", '%1', "No.");
                if WarehouseReceiptLine.FindFirst() then begin
                    SourceNo := WarehouseReceiptLine."Source No.";
                end;

                PurchaseHeader.Reset(); //u popisu narudzbenica trazim tačno ovu narudžbenicu iz koje je kreirana primka
                //preuzimam naziv dobavljača, datum narudzbenice
                PurchaseHeader.SetFilter("No.", '%1', SourceNo);
                if PurchaseHeader.FindFirst() then begin
                    VendorName := PurchaseHeader."Buy-from Vendor Name";
                    OrderDate := PurchaseHeader."Order Date";
                end;
            end;

            trigger OnPreDataItem()
            begin
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);

                Today := System.Today;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Choose report")
                {
                    Caption = 'Choose report';
                    field(Selected; Selected)
                    {
                        Caption = 'Select: ';
                        OptionCaption = ' ,Zapisnik o kvalitetu isporučene robe,Zapisnik o neusaglašenosti količine robe';
                    }
                }
            }
        }
    }

    var
        CompanyInformation: Record "Company Information";
        Today: Date;
        LocationName: Text[100];
        LocationTable: Record Location;
        Selected: Option " ","Zapisnik o kvalitetu","Zapisnik o neusaglašenosti količine";
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
        SourceNo: Code[20];
        PurchaseHeader: Record "Purchase Header";
        VendorName: Text[100];
        OrderDate: Date;
}

