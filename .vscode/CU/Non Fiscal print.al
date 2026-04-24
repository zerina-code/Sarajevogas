/*codeunit 50000 "Non Fiscal print"
{
    // BH1.00, Fiscal Process
    trigger OnRun()
    begin
        GL.Get();


        Putanja := GL."Path for fiscal printer";
       
        TXTTab := 13;
        TXTTab := 13;

        GJL.RESET;
        GJL.SetFilter("Line No.", '%1', UlazniRacun);
        GJL.SetFilter("Journal Template Name", '%1', GTem);
        GJL.SetFilter("Journal Batch Name", '%1', GBatch);
        GJL.SetFilter("Document No.", '%1', GDocument);

        IF GJL.FINDFIRST THEN BEGIN

            File1.CREATE(Putanja + 'snd.xml', TEXTENCODING::UTF8);

            File1.CREATEOUTSTREAM(OutStreamObj);
            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>837650</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := ' <VrstaZahtjeva>6</VrstaZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Naziv>Text</Naziv>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1B\x61\x01';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1D\x54\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '\x1C\x70\x01\x30';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();

            plite := '\x1b\x61\x08POTVRDA PLAĆANJA\x1b\x21\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            Custt.RESET;
            Custt.SETFILTER("No.", '%1', GJL."Account No.");
            IF Custt.FINDFIRST THEN
                plite := Format(GJL."Account No.") + ' ' + GJL.Description + ' ' + Custt.Address
            else
                plite := Format(GJL."Account No.") + ' ' + GJL.Description;
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '\x1B\x21\x00REFERENCE' + ' ' + GJL."Applies-to Doc. No." + '\x1B\x21\x20';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();
            Iznoss := abs(GJL.Amount);
            ImaZarez := STRPOS(FORMAT(abs(GJL.Amount)), ',') + 1;

            IF STRPOS(FORMAT(COPYSTR(FORMAT(Iznoss), ImaZarez, 2)), '00') = 0 THEN
                Rezultat := ChangeSeparator(FORMAT(Iznoss, 0, '<Sign><Integer><Decimals><Comma,.>'))
            ELSE
                Rezultat := ChangeSeparator(FORMAT(ROUND(Iznoss)));


            plite := '\x1b\x21\x08     IZNOS UPLATE : ' + Rezultat + 'KM     \x1B\x21\x00';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            OutStreamObj.WRITETEXT();



            plite := GBatch + ' ' + 'B ' + GJL."Cashier Employer";
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            OutStreamObj.WRITETEXT('R.B. ' + format(GJL."Payment No."));
            OutStreamObj.WRITETEXT();
            plite := '';

            plite := '################################';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '\x1B\x4d\x01POTVRDA O PLAĆANJU JE ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'IZDATA ELEKTRONSKI I VAŽEĆA JE';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'BEZ PEČATA I POTPISA ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := 'OVLAŠTENE OSOBE ';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := ' </Zahtjev>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();


            //CZK 1 BLG 1 B 013



            //<Naziv>Text</Naziv>













            File1.CLOSE;
            FileManagement.DownloadToFile(Putanja + 'snd.xml', Putanja + 'snd.xml');


        END;





    end;



    procedure SetParam(BrojRacuna: Integer; JBatch: Code[20]; JTemp: Code[20]; Document: Text[250])


    begin
        UlazniRacun := BrojRacuna;
        GBatch := JBatch;
        GTem := JTemp;
        GDocument := Document;



    end;

    procedure Odgovor(Upit: Text[2000])




    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1' + '.xml') THEN
            ERASE(Upit + '_1' + '.xml');
        IF EXISTS(Upit + '.xml') THEN BEGIN
            Charr := 10;
            importFile.WRITEMODE(TRUE);
            importFile.TEXTMODE(TRUE);
            importFile.OPEN(Upit + '.xml');
            importFile2.WRITEMODE(TRUE);
            importFile2.TEXTMODE(TRUE);
            IF NOT EXISTS(Upit + '_1' + '.xml') THEN
                importFile2.CREATE(Upit + '_1' + '.xml');


            WHILE importFile.READ(ReadLine) > 0 DO BEGIN

                x1 := 'xml';
                x2 := 'Kasa';
                x3 := 'VrstaOdgovora';
                x4 := 'Naziv';
                x5 := 'Vrijednost';
                X6 := 'Odgovor';
                IF (STRPOS(ReadLine, x1) = 0) THEN BEGIN
                    IF (STRPOS(ReadLine, x2) = 0) THEN BEGIN
                        IF (STRPOS(ReadLine, x3) = 0) THEN BEGIN
                            IF (STRPOS(ReadLine, x4) <> 0) THEN BEGIN

                                //<Naziv>BrojFiskalnogRacuna</Naziv>
                                Zamjena := COPYSTR(ReadLine, STRLEN('<Naziv>') + 7, STRLEN(ReadLine) - STRLEN('<Naziv></Naziv>') - 6);

                            END;
                            IF (STRPOS(ReadLine, x5) <> 0) THEN BEGIN
                                ReadLine2 := '<' + Zamjena + '>' + COPYSTR(ReadLine, STRPOS(ReadLine, '">') + 2, STRLEN(ReadLine) - STRPOS(ReadLine, '">') - STRLEN('</Vrijednost>') - 1) + '</' + Zamjena + '>';
                                importFile2.WRITE(ReadLine2 + FORMAT(Charr));
                            END;
                            IF STRPOS(ReadLine, X6) <> 0 THEN BEGIN
                                importFile2.WRITE(ReadLine);
                            END;


                        END
                        ELSE BEGIN
                            VrstaOdgovora := COPYSTR(ReadLine, STRLEN('<VrstaOdgovora>') + 3, STRLEN(ReadLine) - STRLEN('<VrstaOdgovora></VrstaOdgovora>') - 2)
                        END;


                    END;

                END;

                importFile2.CREATEINSTREAM(strInStream);
                importFile2.CREATEOUTSTREAM(XMLFileOutStr);
            END;
        END;



        importFile.CLOSE;
        importFile2.CLOSE;


        ToFileName := Upit + '_1' + '.xml';

        CLEAR(xmldomDoc2);
        CLEAR(xmlNodeList1);
        CLEAR(xmlNodeList2);
        CLEAR(xmlNodeList3);
        CLEAR(xmlNodeList4);
        CLEAR(xmlNodeList5);
        CLEAR(xmlNodeList6);

        //ĐK xmldomDoc2 := XmlDocument.Create();
        XMLDomDocParam := XMLDomDocParam.XmlDocument();
        XMLDomDocParam.Load(Upit + '_1' + '.xml');
        SystemXmlNodeListValue := XMLDomDocParam.GetElementsByTagName('BrojFiskalnogRacuna');
        SystemXmlNodeListValue2 := XMLDomDocParam.GetElementsByTagName('DatumFiskalnogRacuna');
        SystemXmlNodeListValue3 := XMLDomDocParam.GetElementsByTagName('VrijemeFiskalnogRacuna');
        SystemXmlNodeListValue4 := XMLDomDocParam.GetElementsByTagName('IznosFiskalnogRacuna');

        FOR i := 0 TO SystemXmlNodeListValue.Count - 1 DO BEGIN
            SystemXmlNodeValue := SystemXmlNodeListValue.Item(i);
            SystemXmlNodeValue2 := SystemXmlNodeListValue2.Item(i);
            SystemXmlNodeValue3 := SystemXmlNodeListValue3.Item(i);
            SystemXmlNodeValue4 := SystemXmlNodeListValue4.Item(i);




            BrojFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            DatumFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            VrijemeFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            IznosFiskalnogRacuna := SystemXmlNodeValue.InnerText;




        END;




    end;

    procedure ChangeSeparator(Number: Text[2000]) NumberConvert: Text


    begin
        IF STRLEN(Number) > 2 THEN BEGIN
            IF COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2) = ',' THEN BEGIN
                NumberConvert := COPYSTR(FORMAT(Number), 1, STRLEN(FORMAT(Number)) - 2) + '.' + COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2);
            END
            ELSE BEGIN
                NumberConvert := FORMAT(Number);
            END;
        END
        ELSE BEGIN
            NumberConvert := FORMAT(Number);
        END;

    end;



    var
        myInt: Integer;
        GTem: Code[20];
        GBatch: Code[20];
        GDocument: Text[250];
        GL: Record "General Ledger Setup";
        XMLManagement: Codeunit "XML DOM Management";
        UlazniRacun: Integer;
        ReklamniDA: Boolean;
        ImaZarez: Integer;
        TextCitanje: BigText;
        Rezultat: Text[2000];
        TotalCijena2: Decimal;
        Sallesr: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Iznoss: Decimal;

        xmlDomdoc: XmlDocument;
        TextPos: Integer;
        xmldomDoc3: XmlDocument;
        xmldomDoc2: XmlDocument;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        xmlNodeList1: XmlNodeList;
        xmlNodeList2: XmlNodeList;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmlNodeList6: XmlNodeList;

        NodeVale: XmlNode;
        SystemXmlNodeValue: DotNet SystemXmlNode;
        SystemXmlNodeValue2: DotNet SystemXmlNode;
        SystemXmlNodeValue3: DotNet SystemXmlNode;
        SystemXmlNodeValue4: DotNet SystemXmlNode;

        ChildNode: DotNet SystemXmlNode;

        ChildNodeList: DotNet SystemXmlNodeList;

        i: Integer;
        j: Integer;
        xmlNodeList5: XmlNodeList;
        //TempBlob: Record TempBlob;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text[2000];
        ReadLine2: Text[2000];
        VrstaOdgovora: Text[2000];
        strInStream: InStream;
        x1: Text[2000];
        x2: Text[2000];
        x3: Text[2000];
        x4: Text[2000];
        XMLFileOutStr: OutStream;
        ToFileName: Text[2000];
        x5: Text[2000];
        x6: Text[2000];
        Zamjena: Text[2000];
        BrojFiskalnogRacuna: Text[2000];
        VrijemeFiskalnogRacuna: Text[2000];


        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];

        Custt: Record Customer;
        Putanja: Text[250];
        OutStreamObj2: OutStream;
        Linije: Text[2000];

        File5: File;
        Putanja2: Text[250];
        SystemXmlNodeListValue: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue2: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue3: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue4: DotNet SystemXmlNodeList;

        TXTTab: Char;
        Instr: InStream;
        filename: Text[2000];
        filepath: Text[2000];
        SalesHeader: Record "Sales Invoice Header";
        GJL: Record "Gen. Journal Line";
        XMLDomDocParam: DotNet SystemXmlDocument;
        File1: File;
        SystemDokument: Dotnet SystemXmlDocument;
        SubText: Text[2000];
        OutStreamObj: OutStream;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        plite: Text[2000];
        SalesInvoiceLine: Record "Sales Invoice Line";
        Salles: Record "Sales Invoice Line";
        TotalCijena: Decimal;
        FileManagement: Codeunit "File Management";
    //    FiscalPrinterSetup: Record "BaH Fiscal Printer Setup";

}




*/