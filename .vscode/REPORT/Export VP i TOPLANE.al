report 50009 "Export VP or heating plant"
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
        dataitem(DataItem2; "Calculation Journal Line")
        {


            trigger OnAfterGetRecord()
            var
                CalcSetup: Record "Calculation Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                Noseries: code[20];
                Gauge2: Record "Calculation Journal Line";
                CH: Record "Calcuation Header";

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



                    if (DataItem2."Category MM" = DataItem2."Category MM"::"Large Economy")
                    or (DataItem2."Category MM" = DataItem2."Category MM"::CNG)
                     or (DataItem2."Category MM" = DataItem2."Category MM"::"Special Customer")
                       or (DataItem2."Category MM" = DataItem2."Category MM"::"KJKP Heating plant")
                     then begin

                        NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings VP", '', 0D, DataItem2."Proceedings No.", Noseries);

                        //01-2025/1
                        if StrLen(format(Date2DMY(DataItem2."Calculation Date To", 2))) = 1
                        then
                            DataItem2."Proceedings No." := '0' + format(Date2DMY(DataItem2."Calculation Date To", 2)) + copystr(DataItem2."Proceedings No.", 3, strlen(DataItem2."Proceedings No.")) + '-' + format(Date2DMY(DataItem2."Calculation Date To", 3))
                        else
                            DataItem2."Proceedings No." := format(Date2DMY(DataItem2."Calculation Date To", 2)) + copystr(DataItem2."Proceedings No.", 3, strlen(DataItem2."Proceedings No.")) + '-' + format(Date2DMY(DataItem2."Calculation Date To", 3));

                    end;

                    if DataItem2."Category MM" = DataItem2."Category MM"::"Small Economy" then begin

                        NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings MP", '', 0D, DataItem2."Proceedings No.", Noseries);

                    end;



                    //DataItem2.Modify(false);
                    //  Commit();
                end;

                FirstString += DataItem2."Proceedings No.";
                FirstString += format(Charr);
                //šifra kupcaNoseries

                Result := FormatWithLeadingZeros("Customer No.", 6);
                FirstString += Result;
                FirstString += format(Charr);
                if "Category MM" = "Category MM"::"Small Economy" then
                    DataItem2."Fictitious Code" := "Mobile No.";



                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin
                    Result := FormatWithLeadingZeros(format("Customer Stroke"), 3);
                    FirstString += format(Result);

                end
                else begin

                    if "Type of reading" = "Type of reading"::"Radio Module" then begin
                        Result := FormatWithLeadingZeros(format(DataItem2."Fictitious Code"), 3);
                        FirstString += format(Result);

                    end
                    else begin

                        if "Type of reading" = "Type of reading"::"Module Type 3" then begin

                            Result := FormatWithLeadingZeros(format(DataItem2."Measuring Point Stroke"), 3);
                            FirstString += format(Result);

                        end else begin
                            if DataItem2."Mobile No." <> 0 then begin
                                Result := FormatWithLeadingZeros(format(DataItem2."Mobile No."), 3);
                                FirstString += format(Result)
                            end
                            else begin
                                Result := FormatWithLeadingZeros(format("Measuring Point Stroke"), 3);
                                FirstString += format(Result);
                            end;
                        end;
                    end;
                end;
                FirstString += format(Charr);
                ///Šifra potrošača
                Result := FormatWithLeadingZeros(format("Measuring Point Code"), 6);
                FirstString += format(Result);
                FirstString += format(Charr);
                FirstString += format("MM Description");
                FirstString += format(Charr);
                FirstString += format("Address MM");
                FirstString += format(Charr);
                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin
                    CH.Reset();
                    CH.SetFilter(Code, '%1', DataItem2.Code);
                    if ch.FindFirst() then begin
                        if ch."Summer or Winter Zone" = ch."Summer or Winter Zone"::Summer then
                            FirstString += format("MZ Name MM") + ' Zona: ' + Format(DataItem2."Measuring Zone - summer");
                        if ch."Summer or Winter Zone" = ch."Summer or Winter Zone"::Winter then
                            FirstString += format("MZ Name MM") + ' Zona: ' + Format(DataItem2."Measuring Zone - winter");
                        if ch."Summer or Winter Zone" = ch."Summer or Winter Zone"::" " then
                            FirstString += format("MZ Name MM") + ' Zona: ' + Format('');

                    end;
                end
                else begin
                    FirstString += format("MZ Name MM");
                end;
                FirstString += format(Charr);
                FirstString += Format("Municipality Name MM");
                FirstString += format(Charr);

                /*   if "Category MM" <> "Category MM"::"Small Economy" then
                       DataItem2."Mobile No." := "Fictitious Code";

                   if DataItem2."Mobile No." <> 0 then
                       FirstString += format("Mobile No.")
                   else
                       FirstString += format("Measuring Point Stroke");
                   FirstString += format(Charr);*/






                if "Category MM" = "Category MM"::"Small Economy" then
                    DataItem2."Fictitious Code" := "Mobile No.";



                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin
                    Result := FormatWithLeadingZeros(format("Customer Stroke"), 3);
                    FirstString += format(Result);

                end
                else begin

                    if "Type of reading" = "Type of reading"::"Radio Module" then begin
                        Result := FormatWithLeadingZeros(format(DataItem2."Fictitious Code"), 3);
                        FirstString += format(Result);

                    end
                    else begin

                        if "Type of reading" = "Type of reading"::"Module Type 3" then begin

                            Result := FormatWithLeadingZeros(format(DataItem2."Measuring Point Stroke"), 3);
                            FirstString += format(Result);

                        end else begin
                            if DataItem2."Mobile No." <> 0 then begin
                                Result := FormatWithLeadingZeros(format(DataItem2."Mobile No."), 3);
                                FirstString += format(Result)
                            end
                            else begin
                                Result := FormatWithLeadingZeros(format("Measuring Point Stroke"), 3);
                                FirstString += format(Result);
                            end;
                        end;
                    end;
                end;

                FirstString += format(Charr);
                //Street No. int
                if DataItem2."Category Customer" = DataItem2."Category Customer"::"Large Economy" then begin

                    FirstString += format("Measuring Point string") + ' - ' + Format("Street No. int");
                end
                else begin
                    Result := FormatWithLeadingZeros(format("Measuring Point string"), 3);
                    FirstString += format(Result);
                end;
                FirstString += format(Charr);
                FirstString += format("Gauge Size");
                FirstString += format(Charr);
                FirstString += format("Serial Number");
                FirstString += format(Charr);
                Result := FormatWithLeadingZeros(format(DelChr(Format("Old Value"), '=', '.')), 5);
                FirstString += Result;
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


                if "EL Volume Code" = '' then
                    FirstString += format('')
                else
                    FirstString += format("EL Volume Description");
                FirstString += format(Charr);

                if "EL Volume Code" = '' then
                    FirstString += format('')
                else
                    FirstString += format("EL Correctior Type");
                FirstString += format(Charr);

                if "UnCorrection previous - gauge" = 0 then
                    FirstString += format('')
                else
                    FirstString += delchr(format("UnCorrection previous - gauge"), '=', '.');

                FirstString += format(Charr);


                //tip korektora   FirstString+=format(corr);
                if "Correction previous - gauge" = 0 then begin
                    if "Category Customer" = "Category Customer"::Household then
                        FirstString += format('')
                    else
                        FirstString += format(0)
                end

                else begin
                    FirstString += format(DelChr(Format("Correction previous - gauge"), '=', '.'));
                end;
                FirstString += format(Charr);

                if ("Category MM" = "Category MM"::"KJKP Heating plant")
                or ("Category MM" = "Category MM"::"Large Economy")
                or ("Category MM" = "Category MM"::"Special Customer")
                 then begin
                    FirstString += format('0');
                end
                else begin

                    if ("Reading Mode" = "Reading Mode"::"Reading List") then begin
                        FirstString += format('4');
                    end else begin
                        if "Type of reading" = "Type of reading"::Unknown then
                            FirstString += format('00');

                        if "Type of reading" = "Type of reading"::"Radio Module" then
                            FirstString += format('1');

                        if "Type of reading" = "Type of reading"::"Module Type 3" then
                            FirstString += format('3');

                    end;

                end;

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
                WCHeadeR: Record "Calcuation Header";
            begin

                if SortVP = true then begin
                    WCHeadeR.Reset();
                    WCHeadeR.SetFilter(Status, '%1', WCHeadeR.Status::Open);
                    WCHeadeR.SetFilter("Summer or Winter Zone", '<>%1', WCHeadeR."Summer or Winter Zone"::" ");
                    //  WCHeadeR.SetFilter(Code, '%1', "Calculation Journal Line".Code);
                    if WCHeadeR.FindFirst() then begin

                        if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                            SetCurrentKey("Measuring Zone - summer", "Measuring Zone - winter", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM")

                        else
                            SetCurrentKey("Measuring Zone - winter", "Measuring Zone - summer", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM");

                    end;
                END
                else begin
                    SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Zone stroke MM", "Street No. Int", "Street No. Text MM", "Street No. Text int", "Street No. Text Apartment", "Customer No. int");
                    // SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street Name MM", "Street No. Int MM", "Street No. Text MM","Street No. Text int", "Street No. Text Apartment", "Customer No. int");
                end;

                Ascending;
                StartDaT := time;

                Progress.OPEN('Kreiranje fajla------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
                Progress.UPDATE(1, 0);
                Progress.UPDATE(2, 0);

            end;
        }


    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(SortVP; SortVP)
                {
                    Caption = 'Sort VP';
                }
            }
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

    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure FormatWithLeadingZeros(MyValue: Code[20]; BrojnNUla: Integer): Code[20]
    var
        TempText: Text[20];
    begin
        TempText := Format(MyValue);
        TempText := TempText.PadLeft(BrojnNUla, '0'); // Dodaje '0' dok string ne bude dužine 6
        exit(TempText);
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
        SortVP: Boolean;
        Result: text;




}

