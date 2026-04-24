report 50210 "Export Data"
{
    // //
    //ĐK WordLayout = './Transport print.docx';

    Caption = 'Export Data';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Calculation Journal Line")
        {


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if Selected = Selected::"Usporedba 1" then
                    SelectedT := '1';
                if Selected = Selected::"Usporedba 2" then
                    SelectedT := '2';
                if Selected = Selected::"Usporedba 3" then
                    SelectedT := '3';
                if Selected = Selected::"Usporedba 4" then
                    SelectedT := '4';
                if Selected = Selected::"Usporedba 5" then
                    SelectedT := '5';

            end;

            trigger OnAfterGetRecord()
            var
                CJLine: Record "Calculation Journal Line";


            begin

                FirstString := '';
                // This command is to move to next line
                DataItem2."New and Old value compare" := 0;
                DataItem2."New and Old value compare Max" := 0;
                DataItem2."Range 1" := 0;
                DataItem2."Difference Amount 1" := 0;
                DataItem2."Difference Out of range 1" := false;

                CJLine.Reset();
                //  CJLine.CopyFilters(DataItem2);
                CJLine.SetFilter(Locked, '%1', true);
                CJLine.SetFilter(Code, '<>%1', DataItem2.Code);
                CJLine.SetFilter("Measuring Point Code", '%1', DataItem2."Measuring Point Code");
                // CJLine.SetFilter(Gauge, '%1', rec.Gauge);
                CJLine.SetFilter("Customer No.", '%1', DataItem2."Customer No.");
                CJLine.SetFilter("Calculation Date To", '%1..%2', DMY2Date(1, Date2DMY(DateUpdate, 2), Date2DMY(DateUpdate, 3)), DateUpdate);
                CJLine.SetCurrentKey("Calculation Date To");
                CJLine.Ascending;
                if CJLine.FindLast() then begin
                    CJLine.CalcSums(Difference, "Correction result- gauge");
                    if DataItem2."Method of calculation" = DataItem2."Method of calculation"::"3" then begin

                        DecimalV := (Range1 / 100 * CJLine."Correction result- gauge" + CJLine."Correction result- gauge");
                        if CJLine."Correction result- gauge" <> 0 then
                            DataItem2."New and Old value compare" := (DataItem2."Correction result- gauge" / CJLine."Correction result- gauge") * 100
                        else
                            DataItem2."New and Old value compare" := 0;


                        if DataItem2."Max Difference" <> 0 then
                            DataItem2."New and Old value compare Max" := (DataItem2."Correction result- gauge" / DataItem2."Max Difference") * 100
                        else
                            DataItem2."New and Old value compare Max" := 0;

                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                        if Evaluate(DecimalV2E, DecimalV2) then begin

                            if DecimalV2E > 50 then
                                DataItem2."Difference Amount 1" := Round((Range1 / 100 * CJLine."Correction result- gauge" + CJLine."Correction result- gauge"), 1, '>')
                            else
                                DataItem2."Difference Amount 1" := Round((Range1 / 100 * CJLine."Correction result- gauge" + CJLine."Correction result- gauge"), 1, '<');
                        end;
                        if DataItem2."Correction result- gauge" > DataItem2."Difference Amount 1"
                     then
                            DataItem2."Difference Out of range 1" := true
                        else
                            DataItem2."Difference Out of range 1" := False;

                        DataItem2."Difference Range 1" := "Difference Amount 1" - "Correction result- gauge";


                        "Date for previous Quantity" := DateUpdate;
                        DatePrevious := DateUpdate;

                        if "Date for previous Quantity" <> 0D then
                            DataItem2."Date Difference 1" := "Date for previous Quantity"
                        else
                            DataItem2."Date Difference 1" := DatePrevious;

                        DataItem2."Date for previous Quantity" := DatePrevious;
                        DataItem2."Range 1" := Range1;





                        if (DataItem2."Date Difference 1") = 0D then
                            DateT1 := ' ; '
                        else
                            DateT1 := Format(DataItem2."Date Difference 1") + ';';

                        if (DataItem2."Date for previous Quantity") = 0D then
                            DateT2 := ' ; '
                        else
                            DateT2 := Format(DataItem2."Date for previous Quantity") + ';';
                    end
                    else begin

                        //da uzmem razliku od prethodnog mjeseca uvećanu za 20 % (npr)
                        DecimalV := (Range1 / 100 * CJLine.Difference + CJLine.Difference);
                        if CJLine.Difference <> 0 then
                            DataItem2."New and Old value compare" := (DataItem2.Difference / CJLine.Difference) * 100
                        else
                            DataItem2."New and Old value compare" := 0;


                        if DataItem2."Max Difference" <> 0 then
                            DataItem2."New and Old value compare Max" := (DataItem2.Difference / DataItem2."Max Difference") * 100
                        else
                            DataItem2."New and Old value compare Max" := 0;






                        DecimalV2 := format(Round(DecimalV, 0.0001, '=') MOD 1 * 100);

                        if Evaluate(DecimalV2E, DecimalV2) then begin

                            if DecimalV2E > 50 then
                                DataItem2."Difference Amount 1" := Round((Range1 / 100 * CJLine.Difference + CJLine.Difference), 1, '>')
                            else
                                DataItem2."Difference Amount 1" := Round((Range1 / 100 * CJLine.Difference + CJLine.Difference), 1, '<');
                        end;
                    end;

                    if DataItem2.Difference > DataItem2."Difference Amount 1"
                      then
                        DataItem2."Difference Out of range 1" := true
                    else
                        DataItem2."Difference Out of range 1" := False;

                    DataItem2."Difference Range 1" := "Difference Amount 1" - Difference;


                    "Date for previous Quantity" := DateUpdate;
                    DatePrevious := DateUpdate;

                    if "Date for previous Quantity" <> 0D then
                        DataItem2."Date Difference 1" := "Date for previous Quantity"
                    else
                        DataItem2."Date Difference 1" := DatePrevious;

                    DataItem2."Date for previous Quantity" := DatePrevious;
                    DataItem2."Range 1" := Range1;





                    if (DataItem2."Date Difference 1") = 0D then
                        DateT1 := ' ; '
                    else
                        DateT1 := Format(DataItem2."Date Difference 1") + ';';

                    if (DataItem2."Date for previous Quantity") = 0D then
                        DateT2 := ' ; '
                    else
                        DateT2 := Format(DataItem2."Date for previous Quantity") + ';';

                end;

                FirstString := format(DataItem2.Code) + ';' + Format(DataItem2."Customer No.") + ';' + format(DataItem2."Measuring Point Code") + ';' + format(DataItem2."New and Old value compare") + ';' + format(DataItem2."Difference Amount 1") + ';' + format(DataItem2."Difference Out of range 1")
+ ';' + format(DateT1) + format(DateT2) + format(DataItem2."Range 1") + ';' + format(SelectedT) + ';' + format(DataItem2."New and Old value compare Max") + ';' + Format(DataItem2."Difference Range 1");

                OutStreamObj.WRITETEXT(FirstString);
                OutStreamObj.WRITETEXT();
                Broj2 += 1;
                CurrentDateT := time;
                Progress.UPDATE(1, ROUND(Broj2));
                Progress.UPDATE(2, CurrentDateT);
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(Selected; Selected)
                {
                    Caption = 'Selected';
                }
                field(Range1; Range1)
                {
                    Caption = 'Range';
                }
                field(DateUpdate; DateUpdate)
                {
                    Caption = 'Date previous for update';
                }

            }

        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Company.get;

        FileName := 'AzuriranjePodaci.txt';
        // TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        File1.CREATE(Company."Path for Documents" + 'AzuriranjePodaci.txt', TEXTENCODING::UTF8);

        File1.CREATEOUTSTREAM(OutStreamObj);

        StartDaT := time;
        Progress.OPEN('Ukupan broj ažuriranja ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
        Progress.UPDATE(1, 0);
        Progress.UPDATE(2, 0);
        StartDaT := Time;

    end;




    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        Company.get;

        File1.CLOSE;
        //    TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        //  DownloadFromStream(Instr, '', '', '', FileName);
        FileManagement.DownloadToFile(Company."Path for Documents" + 'AzuriranjePodaci.txt', Company."Path for Documents" + 'AzuriranjePodaci.txt');


        Commit();

        Filexml.OPEN(Company."Path for Documents" + 'AzuriranjePodaci.txt');
        Filexml.CREATEINSTREAM(instreamobject);
        XMLPORT.IMPORT(50044, instreamobject);
        Commit();

    end;



    var
        Company: Record "Company Information";
        FileManagement: Codeunit "File Management";
        FirstString: Text;
        DatePrevious: Date;
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        DateT1: Text;
        DateT2: Text;
        FileName: Text;
        Selected: Option "Usporedba 1","Usporedba 2","Usporedba 3","Usporedba 4","Usporedba 5";
        Range1: Decimal;
        SelectedT: Text;
        Broj2: Integer;

        DateUpdate: Date;
        DecimalV: Decimal;
        instreamobject: InStream;
        DecimalV2: Text;
        DecimalV2E: Decimal;
        Filexml: File;
        File1: File;
        OutStreamObj: OutStream;
        Progress: Dialog;
        StartDaT: Time;
        CurrentDateT: Time;

}

