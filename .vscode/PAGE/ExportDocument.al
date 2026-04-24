report 50213 "Export Document No."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {
            trigger OnAfterGetRecord()
            var
                CustT: Record "Customer Templ."; // used to read posting no. series
                NoSeriesMgt: Codeunit "NoSeriesExtented";
                Docno: Text;
                MonthText: Text;
                YearText: Text;
                KeyCode: Text;
                NextDocNo: Text;
            begin
                // make sure the customer template selection exists
                CustT.Reset();
                if ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"KJKP Heating plant")
                   or ("Calculation Journal Line"."Category Customer" = "Calculation Journal Line"."Category Customer"::"Special Customer") then
                    CustT.SetFilter("Bill Category", '%1', "Calculation Journal Line"."Category Customer"::"Large Economy")
                else
                    CustT.SetFilter("Bill Category", '%1', "Calculation Journal Line"."Category Customer");

                if not CustT.FindFirst() then
                    exit; // nothing to do for this record

                // build key parts
                MonthText := Format("Calculation Journal Line"."Month Of GAS Calculation");
                YearText := Format("Calculation Journal Line"."Year Of GAS Calculation");
                KeyCode := Format("Calculation Journal Line"."Customer No.") + '_' + MonthText + '_' + YearText;

                // try to find an existing temp record (acts as cache) for this customer+month+year
                CustttTemp.Reset();
                CustttTemp.SetFilter("Invoice Disc. Code", '%1', "Calculation Journal Line"."Customer No.");
                CustttTemp.SetFilter(Description, '%1', MonthText);
                CustttTemp.SetFilter("Territory Code", '%1', YearText);

                if not CustttTemp.FindFirst() then begin
                    // not found -> get next no and insert into temp cache
                    NextDocNo := NoSeriesMgt.GetNextNo(CustT."Posting No. Series Bill", "Calculation Date To", true);
                    CustttTemp.Init();
                    CustttTemp.Code := KeyCode;
                    CustttTemp."Invoice Disc. Code" := "Calculation Journal Line"."Customer No.";
                    CustttTemp.Description := MonthText;
                    CustttTemp."Territory Code" := YearText;
                    CustttTemp."Contact Phone" := NextDocNo; // store generated doc no as contact phone temporarily
                    CustttTemp.Insert(true);
                    Docno := NextDocNo;
                end else begin
                    Docno := CustttTemp."Contact Phone";
                end;

                // Build Document No. Posting - use two-digit year extracted from Calculation Date To
                // Example: take Year() and take last two characters
                if StrLen(Format(Date2DMY(("Calculation Journal Line"."Calculation Date To"), 3))) = 4 then
                    "Calculation Journal Line"."Document No. Posting" := Docno + '/' + CopyStr(Format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3)), 3, 2)
                else
                    // fallback - use full year string
                    "Calculation Journal Line"."Document No. Posting" := Docno + '/' + Format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3));

                // Append CSV line to accumulator (BigText)
                FirstString := Format("Calculation Journal Line".Code) + ';' + Format("Calculation Journal Line"."Customer No.") + ';' +
                               Format("Calculation Journal Line"."Document No. Posting") + ';' + MonthText + ';' + YearText;

                // Use in-memory text accumulator (BigText) and only write to OutStream in OnPostReport
                if FirstString <> '' then begin
                    BigText.AddText(FirstString + CharV + CharV1);
                end;




                Broj2 += 1;
                CurrentDateT := TIME;
                Progress.UPDATE(1, Broj2);
                Progress.UPDATE(2, CurrentDateT);

                // do not Commit() here to avoid transactional overheads; commit once at the end
            end;

            trigger OnPreDataItem()
            var
                US: Record "User Setup";
            begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    if US.SortBilling then
                        SetCurrentKey("Customer No. int")
                    else
                        SetCurrentKey("Municipality Name Customer 2", "Street Name Customer 2", "Street No.2 int", "Street No.2 Text", "Street No. Text Apartment", "Apartment No. Customer 2", "Customer No. int", "Calculation Date To", "Reading Date To");
                end else
                    // fallback default key
                    SetCurrentKey("Customer No. int");
            end;
        }
    }

    trigger OnPreReport()
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        // initialize and clear temp cache

        CustttTemp.DeleteAll();
        Company.Get();
        CharV := 13;
        CharV1 := 10;

        FileName := 'AzuriranjeDoc.txt';

        // Prepare an in-memory stream using TempBlob; we'll write to it in OnPostReport
        TempBlob.CreateOutStream(OutStreamObj, TextEncoding::UTF8);

        // initialize counters and progress
        Broj2 := 0;
        //  BigText := '';
        StartDaT := TIME;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + Format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
    end;

    trigger OnPostReport()
    begin
        Company.Get;

        FileName := Company."Path for Documents" + 'AzuriranjePodaci3' +
            DelChr(DelChr(Format(StartDaT), '=', '.'), '=', ':') + '.txt';


        // kreiraj ime fajla
        // kreiraj fajl na disku
        Filexml.CREATE(FileName);

        // kreiraj OutStream vezan za fajl
        Filexml.CREATEOUTSTREAM(OutStr);
        // upiši sav sadržaj iz BigText u fajl
        BigText.Write(OutStr);

        // zatvori fajl
        Filexml.CLOSE;

        // XMLPORT import
        Filexml.OPEN(FileName);
        Filexml.CREATEINSTREAM(InStr);
        XMLPORT.IMPORT(50047, InStr);
        Filexml.CLOSE;

        Commit();
    end;

    var
        Broj2: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        FileName: Text;
        FirstString: Text;
        OutStreamObj: OutStream;
        BigText: BigText;
        CustttTemp: Record "Customer Templ." temporary;

        FileManagement: Codeunit "File Management";
        Progress: Dialog;
        Company: Record "Company Information";
        Filexml: File;
        OutStr: OutStream; // ovo je OutStream vezan za fajl
        InStr: InStream;
        CharV: Char;
        CharV1: Char;
    //  XMLPORT: Codeunit; // XMLPORT placeholder - keep your import ID usage above
}
