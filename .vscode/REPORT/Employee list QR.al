report 50057 QRCodeList
{
    Caption = 'QRCode List Report';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'QR.rdl';
    dataset
    {
        dataitem(Employee; Employee)
        {
            column(No_; "No.")
            {

            }
            column(temp; barcode2)
            {

            }
            trigger OnAfterGetRecord()
            begin
                barcode2 := InitArguments("No.");
            end;
        }


    }
    var
        BarCode2: text;

    local procedure InitArguments(ItemNo: text): text
    var
        BaseURL: Text;
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TypeHelper: Codeunit "Type Helper";
        client: HttpClient;
        response: HttpResponseMessage;
        InStr: InStream;

    begin
        client.get('https://barcode.tec-it.com/barcode.ashx?data=' + 'BrojArtiklaSerijskiBrojDuzina' + '&code=QRCode', response);
        TempBlob.CreateInStream(InStr);
        response.Content().ReadAs(InStr);
        BarCode2 := Base64Convert.ToBase64(InStr);
        exit(BarCode2);
    end;

}

