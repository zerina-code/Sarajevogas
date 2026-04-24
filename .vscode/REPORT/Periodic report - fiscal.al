report 50013 "Periodic report - fiscal"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Periodic report - fiscal.rdlc';
    Caption = 'Periodic report - fiscal';

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateFrom; DateFrom)
                {
                    Caption = 'Date from';
                }
                field(DateTo; DateTo)
                {
                    Caption = 'Date to';
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

    trigger OnPreReport()
    var
        Genl: Record "General Ledger Setup";
        Putanja: text[250];

        CZkF: record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        Genl.get;

        Putanja := GenL."Path for fiscal printer";

        CZkF.Get(UserId);
        BankAccocunt.Reset();
        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
        if BankAccocunt.findfirst then begin
            Putanja := BankAccocunt."Path for fiscal printer";

        end
        else begin
            Putanja := GenL."Path for fiscal printer";

        end;


        File1.CREATE(Putanja + 'stampatiperiodicniizvjestaj.xml', TEXTENCODING::UTF8);
        File1.CREATEOUTSTREAM(OutStreamObj);
        plite := '<?xml version="1.0" encoding="utf-8"?>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<BrojZahtjeva>695503</BrojZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<VrstaZahtjeva>5</VrstaZahtjeva>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Parametri>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Parametar>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Naziv>odDatuma</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Vrijednost>' + FORMAT(DateFrom, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '</Vrijednost>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</Parametar>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Parametar>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Naziv>doDatuma</Naziv>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '<Vrijednost>' + FORMAT(DateTo, 0, '<Day,2>.<Month,2>.<Year4> <Hours24,2>:<Minutes,2>:<Seconds,2>') + '</Vrijednost>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</Parametar>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</Parametri>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        plite := '</Zahtjev>';
        OutStreamObj.WRITETEXT(plite);
        OutStreamObj.WRITETEXT();
        File1.CLOSE;
        //Odgovor('\\FORTNAV\Temp\StampatiPeriodicniIzvjestaj-odg');
        FileManagement.DownloadToFile(Putanja + 'stampatiperiodicniizvjestaj.xml', Putanja + 'stampatiperiodicniizvjestaj.xml');
    end;

    var
        File1: File;
        OutStreamObj: OutStream;
        plite: Text;
        DateFrom: DateTime;
        DateTo: DateTime;
        Periodicreportfiscal: Report "Periodic report - fiscal";
        TXTTab: Char;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text;
        x5: Text;
        X6: Text;
        x1: Text;
        x2: Text;
        x3: Text;
        x4: Text;
        Zamjena: Text;
        ReadLine2: Text;
        VrstaOdgovora: Text;
        strInStream: InStream;
        XMLFileOutStr: OutStream;
        ToFileName: Text;
        xmlDomdoc: XmlDocument;
        FileManagement: Codeunit "File Management";
        xmldomDoc3: XmlDocument;
        xmldomElem1: XmlElement;
        xmlNodeList2: XmlNodeList;
        xmldomElem2: XmlElement;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmlNodeList6: XmlNodeList;
        XMLNode: DotNet XmlNode;
        XMLNode2: DotNet XmlNode;
        NodeList: DotNet XmlNodeList;
        XMLDomNode: DotNet SystemXmlNode;
        XMLDomNode5: DotNet SystemXmlNode;
        XMLDomNode1: DotNet SystemXmlNode;
        XMLDomNode3: DotNet SystemXmlNode;
        XMLDomNode4: DotNet SystemXmlNode;
        XMLDomNode2: DotNet SystemXmlNode;
        SystemXmlNodeListValue: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue2: DotNet SystemXmlNodeList;
        SystemXmlNodeValue: DotNet SystemXmlNode;
        SystemXmlNodeValue2: DotNet SystemXmlNode;
        xmldomDoc2: XmlDocument;
        xmlNodeList1: XmlNodeList;
        xmlNodeList5: XmlNodeList;
        XMLDomDocParam: DotNet SystemXmlDocument;
        i: Integer;
        BrojZahtjeva: Text;

    procedure Odgovor(Upit: Text)
    begin
        TXTTab := 13;

        IF EXISTS(Upit + '_1' + '.xml') THEN
            ERASE(Upit + '_1' + '.xml');

        IF EXISTS(Upit + '.xml') THEN BEGIN
            IF EXISTS(Upit + '_1' + '.xml') THEN
                ERASE(Upit + '_1' + '.xml');
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
                x2 := 'KasaOdgovor xmlns';
                x5 := '</KasaOdgovor>';
                X6 := '<Odgovori />';
                IF (STRPOS(ReadLine, x1) = 0) THEN BEGIN
                    IF (STRPOS(ReadLine, x2) = 0) THEN BEGIN
                        IF (STRPOS(ReadLine, x5) <> 0) THEN BEGIN
                            importFile2.WRITE('</Odgovori>');

                        END;
                        IF (STRPOS(ReadLine, X6) <> 0) THEN BEGIN
                            importFile2.WRITE('<Odgovori>');

                        END;

                        IF (STRPOS(ReadLine, X6) = 0) AND ((STRPOS(ReadLine, x5) = 0)) THEN
                            importFile2.WRITE(ReadLine);

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
        CLEAR(XMLDomDocParam);


        XMLDomDocParam := XMLDomDocParam.XmlDocument();
        XMLDomDocParam.Load(Upit + '_1' + '.xml');
        SystemXmlNodeListValue := XMLDomDocParam.GetElementsByTagName('VrstaOdgovora');
        SystemXmlNodeListValue2 := XMLDomDocParam.GetElementsByTagName('BrojZahtjeva');


        FOR i := 0 TO SystemXmlNodeListValue.Count - 1 DO BEGIN
            SystemXmlNodeValue := SystemXmlNodeListValue.Item(i);
            SystemXmlNodeValue2 := SystemXmlNodeListValue2.Item(i);


            VrstaOdgovora := SystemXmlNodeValue.InnerText;
            BrojZahtjeva := SystemXmlNodeValue.InnerText;


        END;

        MESSAGE(VrstaOdgovora);
        MESSAGE(BrojZahtjeva);
    end;
}

