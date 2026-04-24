report 50041 "Export VP or heating plant C"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'Export VP or heating plant';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Control list")
        {


            trigger OnAfterGetRecord()
            var
                CalcSetup: Record "Calculation Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                Noseries: code[20];
                Gauge2: Record "Control list";

            begin

                Gauge2.Reset();
                Gauge2.CopyFilters(DataItem2);
                if Gauge2.FindFirst() then
                    TotalRecNo := Gauge2.COUNTAPPROX;



                FirstString := '';
                CalcSetup.get;
                //zapisnik
                if DataItem2."Proceedings No." = '' then begin

                    if DataItem2."Category MM" = DataItem2."Category MM"::Household then begin

                        NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings DOM", '', 0D, DataItem2."Proceedings No.", Noseries);

                    end;






                    if DataItem2."Category MM" = DataItem2."Category MM"::"Small Economy" then begin

                        NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings MP", '', 0D, DataItem2."Proceedings No.", Noseries);

                    end;



                    if (DataItem2."Category MM" = DataItem2."Category MM"::"Large Economy")
                    or (DataItem2."Category MM" = DataItem2."Category MM"::CNG)
                     or (DataItem2."Category MM" = DataItem2."Category MM"::"Special Customer")
                       or (DataItem2."Category MM" = DataItem2."Category MM"::"KJKP Heating plant")
                     then begin

                        NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings VP", '', 0D, DataItem2."Proceedings No.", Noseries);

                        //01-2025/1
                        DataItem2."Proceedings No." += format(Date2DMY(DataItem2."Calculation Date To", 2)) + copystr(DataItem2."Proceedings No.", 3, strlen(DataItem2."Proceedings No."));

                    end;

                    DataItem2.Modify();
                end;

                FirstString += DataItem2."Proceedings No.";
                FirstString += format(Charr);
                //šifra kupcaNoseries
                //ovjde u zavisnosti od broja karaktera dodajem 0.

                ZeroAdd := '';
                Duzina := StrLen("Customer No.");
                if Duzina < 6 then begin
                    for i := 1 to 6 - Duzina do begin
                        ZeroAdd := ZeroAdd + '0';

                    end;
                end;

                FirstString += ZeroAdd + "Customer No.";
                FirstString += format(Charr);
                //hod

                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin

                    FirstString += format("Customer Stroke");

                end
                else begin

                    if DataItem2."Mobile No." <> 0 then
                        FirstString += format("Mobile No.")
                    else
                        FirstString += format("Measuring Point Stroke");

                end;

                FirstString += format(Charr);



                ///Šifra potrošača
                ZeroAdd := '';
                Duzina := StrLen("Measuring Point Code");
                if Duzina < 6 then begin
                    for i := 1 to 6 - Duzina do begin
                        ZeroAdd := ZeroAdd + '0';

                    end;
                end;


                FirstString += ZeroAdd + format("Measuring Point Code");
                FirstString += format(Charr);
                FirstString += format("MM Description");
                FirstString += format(Charr);
                FirstString += format("Address MM");
                FirstString += format(Charr);
                FirstString += format("MZ Name MM");
                FirstString += format(Charr);
                FirstString += Format("Municipality Name MM");
                FirstString += format(Charr);
                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin

                    FirstString += format("Customer Stroke");

                end
                else begin

                    if DataItem2."Mobile No." <> 0 then
                        FirstString += format("Mobile No.")
                    else
                        FirstString += format("Measuring Point Stroke");

                end;


                FirstString += format(Charr);
                FirstString += format("Measuring Point string");
                FirstString += format(Charr);
                FirstString += format("Gauge Size");
                FirstString += format(Charr);
                FirstString += format("Serial Number");
                FirstString += format(Charr);

                ZeroAdd := '';
                Duzina := strlen(format(DelChr(Format("Old Value"), '=', '.')));
                if Duzina < 5 then begin
                    for i := 1 to 5 - Duzina do begin
                        ZeroAdd := ZeroAdd + '0';

                    end;
                end;


                FirstString += ZeroAdd + format(DelChr(Format("Old Value"), '=', '.'));
                FirstString += format(Charr);

                if "Previous Date" = 0D then
                    FirstString += format('')
                else
                    FirstString += format("Previous Date", 0, '<day,2>.<month,2>.<year4>');
                FirstString += format(Charr);

                if "Temperature previous - gauge" = 0 then
                    FirstString += format('')

                else
                    FirstString += format("Temperature previous - gauge");

                FirstString += format(Charr);
                if "Pressure previous - gauge" = 0 then
                    FirstString += format('')
                else
                    FirstString += Replacestring_T(Format("Pressure previous - gauge"), ',', '.');
                FirstString += format(Charr);


                if "Corrector Code" = 0 then
                    FirstString += format('')
                else
                    FirstString += format("EL Volume Code");
                FirstString += format(Charr);




                FirstString += format("EL Correctior Type");
                FirstString += format(Charr);

                if "EL Correctior previous" = 0 then
                    FirstString += format('')
                else
                    FirstString += format("EL Correctior previous");
                FirstString += format(Charr);


                //tip korektora   FirstString+=format(corr);
                if "Correction previous - gauge" = 0 then
                    FirstString += format('')
                else
                    FirstString += format(DelChr(Format("Correction previous - gauge"), '=', '.'));

                FirstString += format(Charr);





                if "Type of reading" = "Type of reading"::Unknown then
                    FirstString += format('0');

                if "Type of reading" = "Type of reading"::"Radio Module" then
                    FirstString += format('1');

                if "Type of reading" = "Type of reading"::"Module Type 3" then
                    FirstString += format('3');

                if ("Reading Mode" = "Reading Mode"::"Reading List") then
                    FirstString += format('4');




                /*  if DataItem2."Remotely Type" = DataItem2."Remotely Type"::Manual then
                      FirstString += format('1');
                  if DataItem2."Remotely Type" = DataItem2."Remotely Type"::Radio then
                      FirstString += format('2');
                  if DataItem2."Remotely Type" = DataItem2."Remotely Type"::"M-Bus GPRS" then
                      FirstString += format('3');
                  if DataItem2."Remotely Type" = DataItem2."Remotely Type"::Unknown then
                      FirstString += format('0');
                  if DataItem2."Remotely Type" = DataItem2."Remotely Type"::Mobile then
                      FirstString += format('4');*/


                FirstString += format(Charr);
                OutStr.WRITETEXT(FirstString);

                OutStr.WRITETEXT(); // This command is to move to next line
                CurrRecNo += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(CurrRecNo / TotalRecNo * 10000, 1));
                Progress.UPDATE(2, CurrentDateT);



            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street No. int", "Zone stroke");
                Ascending;
                StartDaT := time;

                Progress.OPEN('Kreiranje fajla------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
                Progress.UPDATE(1, 0);
                Progress.UPDATE(2, 0);

            end;
        }


    }


    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Charr := 9;
        FileName := 'Ocitavanje.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        FirstString := '';
        FirstString += 'ZapisnikBroj';
        FirstString += format(Charr);
        FirstString += 'Šifra Kupac';
        FirstString += format(Charr);
        FirstString += 'Hod Kupac';
        FirstString += format(Charr);
        FirstString += 'Šifra Potrošno';
        FirstString += format(Charr);
        FirstString += 'Potrošno mjesto';
        FirstString += format(Charr);
        FirstString += 'Adresa';
        FirstString += format(Charr);
        FirstString += 'Mjesna zajednica / Zona';
        FirstString += format(Charr);
        FirstString += 'Općina';
        FirstString += format(Charr);
        FirstString += 'Hod';
        FirstString += format(Charr);
        FirstString += 'Niz Broj';
        FirstString += format(Charr);
        FirstString += 'MjeračTip';
        FirstString += format(Charr);
        FirstString += 'MjeračBroj';
        FirstString += format(Charr);
        FirstString += 'MjeračRanijeStanje';
        FirstString += format(Charr);
        FirstString += 'MjeračRanijiDatum';
        FirstString += format(Charr);
        FirstString += 'MjeračTemperatura';
        FirstString += format(Charr);
        FirstString += 'MjeračPritisak';
        FirstString += format(Charr);
        FirstString += 'KorektorBroj';
        FirstString += format(Charr);
        FirstString += 'KorektorTip';
        FirstString += format(Charr);
        FirstString += 'KorektorRanijeStanje';
        FirstString += format(Charr);
        FirstString += 'KorigovanoRanijeStanje';
        FirstString += format(Charr);
        FirstString += 'VrstaOcitanja';
        /* FirstString += 'Datum';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Vrijeme';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Novo stanje mjerača';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Datum fiksnog očitanja';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Fiksno očitanje';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Novo stanje korektora';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Novo korigovano stanje';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Temperatura mjerača';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Pritisak mjerača';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Temperatura korektora';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Pritisak korektora';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Očitavač';
         OutStr.WRITETEXT(FirstString);
         FirstString += 'Status očitanja';*/
        OutStr.WRITETEXT(FirstString);







        OutStr.WRITETEXT(); // This command is to move to next line


    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        DownloadFromStream(Instr, '', '', '', FileName);
        Progress.Close();

    end;


    procedure Replacestring_TTacka(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        ValueD: Integer;
        StrIn: Integer;
    begin
        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), '.', 'LLL');
        end;
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));

        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), 'LLL', ',');
        end;


        NewString := String;

        if strpos(NewString, '.') <> 0 then begin
            ValueD := strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString)));
            StrIn := strpos(NewString, '.');

            if strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString))) = 1 then
                NewString += '0';

        end;
    end;

    var

        Brojac: Integer;

        FirstString: Text;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        Content_M: Text;
        Charr: Char;
        TotalRecNo: Integer;
        Progress: Dialog;
        StartDaT: time;
        CurrRecNo: Integer;
        CurrentDateT: Time;
        ZeroAdd: text;
        Duzina: Integer;
        i: Integer;





}

