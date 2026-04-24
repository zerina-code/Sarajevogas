report 50223 "COntrol Proceedings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Proceedings.rdl';

    dataset
    {

        dataitem("Control list"; "Control list")
        {
            dataitem(Integer; Integer)
            {
                column(Number; Number) { }
                column(OutputNo; OutputNo) { }

                column(Grad; CompInf.City)
                {
                }
                column(Naziv; CompInf."Name 2")
                {
                }
                column(ProceedingPrint; "Control list"."Proceedings No. Print") { }
                column(ShowValue; ShowValue) { }
                column(Adress; CompInf.Address) { }
                column(ReportDate; ReportDate) { }



                column(Customer_No_; "Control list"."Customer No.") { }
                column(Customer_Name; "Control list"."Customer Name") { }

                column(Gauge; "Control list".Gauge) { }

                column(Temperature; "Control list"."Temperature previous - gauge") { }
                column(Pressure; "Control list"."Pressure previous - gauge") { }

                column(PressCorr; "Control list"."Pressure Correction") { }

                column(TemperCorr; "Control list"."Temperature Correction") { }
                column(TemperaturaP; "Control list"."Temperature previous - gauge") { }

                column(CustCategory; "Control list"."Category Customer") { }
                column(MMCategory; "Control list"."Category MM") { }
                column(SummerYes; SummerYes) { }
                column(CustomerMunName; "Control list"."Municipality Name Customer") { }
                column(Address_MM; "Control list"."Address MM") { }
                column(MZ_MM; "Control list"."MZ MM") { }
                column(Summer_Zone; "Control list"."Measuring Zone - summer") { }
                column(Winter_Zone; "Control list"."Measuring Zone - winter") { }
                column(Municipality_Name_MM; "Control list"."MZ Name MM") { }
                column(Measuring_Point_Stroke; "Control list"."Measuring Point Stroke") { }
                column(Measuring_Point_string; "Control list"."Measuring Point string") { }
                column(MM; "Control list"."Measuring Point Code") { }
                column(PressureP; "Control list"."Pressure previous - gauge") { }
                column(MMDesc; "Control list"."MM Description") { }
                column(Corrector_Code; "Control list"."EL Volume Description") { }
                column(TypeTexxt; TypeTexxt) { }
                column(Gauge_Size; "Control list"."Gauge Size") { }
                column(Proceddings_No; "Control list"."Proceedings No.") { }
                column(SerialNumber; "Control list"."Serial Number") { }
                column(Correction; "Control list"."Correction previous - gauge") { }

                column(UnCorrection; "Control list"."UnCorrection previous - gauge") { }


                column(PreviousDate; format("Control list"."Previous Date", 0, '<day,2>.<month,2>.<year4>')) { }
                column(OldDate; "Control list"."Old Value") { }
                column(TempPreviousKo; TempPreviousKo) { }
                column(PreviousPressure; PreviousPressure) { }


                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    IF Number > 1 THEN BEGIN
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin

                    SETRANGE(Number, 1, 1);
                    OutputNo := 1;
                    GlobalLanguage := 1033;

                end;
            }


            trigger OnAfterGetRecord()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
                CalcSetup: Record "Calculation Setup";
                NoSeries: code[20];
            begin
                SummerYes := false;
                TypeTexxt := '';

                if "Control list"."EL Correctior Type" <> '' then
                    TypeTexxt := 'TIP ' + "Control list"."EL Correctior Type";

                MjesecNumber :=
                format(format(date2dmy("Control list"."Calculation Date To", 2)));
                if StrLen(MjesecNumber) < 2 then
                    MjesecNumber := '0' + MjesecNumber;



                WCHeadeR.Reset();
                WCHeadeR.SetFilter(Code, '%1', "Control list".Code);
                if WCHeadeR.FindFirst() then begin
                    if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                        SummerYes := true
                    else
                        SummerYes := false;
                end;
                CompInf.get;
                ReportDate := today;
                CalcSetup.get;


                CJLPrevious.Reset();
                CJLPrevious.SetFilter(Code, '<>%1', "Control list".Code);
                CJLPrevious.SetFilter(Gauge, '%1', "Control list".Gauge);
                CJLPrevious.SetFilter("EL Volume Code", '%1', "Control list"."EL Volume Code");
                CJLPrevious.SetFilter("New Value", '<>%1', 0);
                CJLPrevious.SetCurrentKey("Calculation Date To");
                CJLPrevious.Ascending();
                if CJLPrevious.FindLast() then begin
                    TempPreviousKo := CJLPrevious."Temperature Correction";
                    PreviousPressure := CJLPrevious."Pressure Correction"

                end
                else begin

                    TempPreviousKo := 0;
                    PreviousPressure := 0;
                end;


                //reset na svakoj zoni

                if "Control list"."Proceedings No. Print" = '' then begin
                    BrojacZona += 1;
                    CalcSetup.get;

                    TempF.Reset();
                    if SummerYes = true then
                        TempF.SetFilter(Amount, '%1', "Control list"."Measuring Zone - summer")
                    else
                        TempF.SetFilter(Order, '%1', "Control list"."Measuring Zone - winter");

                    if not tempF.FindFirst() then begin
                        TempF.Init();
                        TempF.Code := format(BrojacZona);
                        TempF.Order := "Control list"."Measuring Zone - winter";
                        tempF.Amount := "Control list"."Measuring Zone - summer";
                        TempF.Insert();
                        //ide reset ove linije na prazan zadnji korišteni broj
                        NoSeriesLine.Reset();
                        NoSeriesLine.SetFilter("Series Code", '%1', CalcSetup."No. series for Proceedings VP Reset");
                        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
                        NoSeriesLine.Ascending;
                        if NoSeriesLine.FindLast() then begin
                            NoSeriesLine."Last No. Used" := '';
                            NoSeriesLine.Modify();
                            Commit();
                        end;
                    end;

                    if "Control list"."Proceedings No. Print" = '' then begin

                        //    NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings", '', 0D, "Control list"."Proceedings No.", NoSeries);
                        "Control list"."Proceedings No. Print" := NoSeriesMgt.GetNextNo(CalcSetup."No. series for Proceedings VP Reset", TODAY, true);


                        if StrLen(format(Date2DMY("Control list"."Calculation Date To", 2))) = 1
                                                 then
                            "Control list"."Proceedings No. Print" := '0' + format(Date2DMY("Control list"."Calculation Date To", 2)) + copystr("Control list"."Proceedings No. Print", 3, strlen("Control list"."Proceedings No. Print")) + '-' + format(Date2DMY("Control list"."Calculation Date To", 3))
                        else
                            "Control list"."Proceedings No. Print" := format(Date2DMY("Control list"."Calculation Date To", 2)) + copystr("Control list"."Proceedings No. Print", 3, strlen("Control list"."Proceedings No. Print")) + '-' + format(Date2DMY("Control list"."Calculation Date To", 3));
                    end;
                    "Control list".Modify();

                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                WCHeadeR.Reset();
                WCHeadeR.SetFilter(Status, '%1', WCHeadeR.Status::Open);
                WCHeadeR.SetFilter("Summer or Winter Zone", '<>%1', WCHeadeR."Summer or Winter Zone"::" ");
                //  WCHeadeR.SetFilter(Code, '%1', "Control list".Code);
                if WCHeadeR.FindFirst() then begin

                    if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                        SetCurrentKey("Measuring Zone - summer", "Measuring Zone - winter", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM")

                    else
                        SetCurrentKey("Measuring Zone - winter", "Measuring Zone - summer", "Measuring Point Stroke", "Measuring Point String", "Street No. Int MM");

                end;


                //   SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street No. int", "Zone stroke");
                Ascending;
                TempF.DeleteAll();
            end;
        }



    }


    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowValue; ShowValue)
                    {
                        Caption = 'ShowValue';
                        ApplicationArea = all;
                    }
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

    trigger OnInitReport()
    var
        myInt: Integer;
    begin

        CustomReportLayout.reset;
        CustomReportLayout.SetFilter("Report ID", '%1', 50001);
        if CustomReportLayout.FindFirst() then begin

            ReportLayout := CustomReportLayout.Description;

            ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));


        end;

    end;

    var
        CompInf: record "Company Information";
        ReportDate: date;
        OutputNo: Integer;
        WCHeadeR: Record "Calcuation Header";
        SummerYes: Boolean;

        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        ReportLayout: text[1000];
        MjesecNumber: text;
        TypeTexxt: Text;
        ShowValue: Boolean;
        PreviousPressure: Decimal;

        TempPreviousKo: Decimal;

        CJLPrevious: Record "Control list";
        TempF: Record "Area" temporary;
        BrojacZona: Integer;
        NoSeriesLine: Record "No. Series Line";
}

