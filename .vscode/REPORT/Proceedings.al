report 50001 "Proceedings"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Proceedings.rdl';

    dataset
    {

        dataitem("Calculation Journal Line"; "Calculation Journal Line")
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
                column(ProceedingPrint; "Calculation Journal Line"."Proceedings No. Print") { }
                column(ShowValue; ShowValue) { }
                column(Adress; CompInf.Address) { }
                column(ReportDate; ReportDate) { }



                column(Customer_No_; "Calculation Journal Line"."Customer No.") { }
                column(Customer_Name; "Calculation Journal Line"."Customer Name") { }

                column(Gauge; "Calculation Journal Line".Gauge) { }

                column(Temperature; "Calculation Journal Line"."Temperature previous - gauge") { }
                column(Pressure; "Calculation Journal Line"."Pressure previous - gauge") { }

                column(PressCorr; "Calculation Journal Line"."Pressure Correction") { }

                column(TemperCorr; "Calculation Journal Line"."Temperature Correction") { }
                column(TemperaturaP; "Calculation Journal Line"."Temperature previous - gauge") { }

                column(CustCategory; "Calculation Journal Line"."Category Customer") { }
                column(MMCategory; "Calculation Journal Line"."Category MM") { }
                column(SummerYes; SummerYes) { }
                column(CustomerMunName; "Calculation Journal Line"."Municipality Name Customer") { }
                column(Address_MM; "Calculation Journal Line"."Address MM") { }
                column(MZ_MM; "Calculation Journal Line"."MZ MM") { }
                column(Summer_Zone; "Calculation Journal Line"."Measuring Zone - summer") { }
                column(Winter_Zone; "Calculation Journal Line"."Measuring Zone - winter") { }
                column(Municipality_Name_MM; "Calculation Journal Line"."MZ Name MM") { }
                column(Measuring_Point_Stroke; "Calculation Journal Line"."Measuring Point Stroke") { }
                column(Measuring_Point_string; "Calculation Journal Line"."Measuring Point string") { }
                column(MM; "Calculation Journal Line"."Measuring Point Code") { }
                column(PressureP; "Calculation Journal Line"."Pressure previous - gauge") { }
                column(MMDesc; "Calculation Journal Line"."MM Description") { }
                column(Corrector_Code; "Calculation Journal Line"."EL Volume Description") { }
                column(TypeTexxt; TypeTexxt) { }
                column(Gauge_Size; "Calculation Journal Line"."Gauge Size") { }
                column(Proceddings_No; "Calculation Journal Line"."Proceedings No.") { }
                column(SerialNumber; "Calculation Journal Line"."Serial Number") { }
                column(Correction; "Calculation Journal Line"."Correction previous - gauge") { }

                column(UnCorrection; "Calculation Journal Line"."UnCorrection previous - gauge") { }


                column(PreviousDate; format("Calculation Journal Line"."Previous Date", 0, '<day,2>.<month,2>.<year4>')) { }
                column(OldDate; "Calculation Journal Line"."Old Value") { }
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

                if "Calculation Journal Line"."EL Correctior Type" <> '' then
                    TypeTexxt := 'TIP ' + "Calculation Journal Line"."EL Correctior Type";

                MjesecNumber :=
                format(format(date2dmy("Calculation Journal Line"."Calculation Date To", 2)));
                if StrLen(MjesecNumber) < 2 then
                    MjesecNumber := '0' + MjesecNumber;



                WCHeadeR.Reset();
                WCHeadeR.SetFilter(Code, '%1', "Calculation Journal Line".Code);
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
                CJLPrevious.SetFilter(Code, '<>%1', "Calculation Journal Line".Code);
                CJLPrevious.SetFilter(Gauge, '%1', "Calculation Journal Line".Gauge);
                CJLPrevious.SetFilter("EL Volume Code", '%1', "Calculation Journal Line"."EL Volume Code");
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

                if "Calculation Journal Line"."Proceedings No. Print" = '' then begin
                    BrojacZona += 1;
                    CalcSetup.get;

                    TempF.Reset();
                    if SummerYes = true then
                        TempF.SetFilter(Amount, '%1', "Calculation Journal Line"."Measuring Zone - summer")
                    else
                        TempF.SetFilter(Order, '%1', "Calculation Journal Line"."Measuring Zone - winter");

                    if not tempF.FindFirst() then begin
                        TempF.Init();
                        TempF.Code := format(BrojacZona);
                        TempF.Order := "Calculation Journal Line"."Measuring Zone - winter";
                        tempF.Amount := "Calculation Journal Line"."Measuring Zone - summer";
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

                    if "Calculation Journal Line"."Proceedings No. Print" = '' then begin

                        //    NoSeriesMgt.InitSeries(CalcSetup."No. series for Proceedings", '', 0D, "Calculation Journal Line"."Proceedings No.", NoSeries);
                        "Calculation Journal Line"."Proceedings No. Print" := NoSeriesMgt.GetNextNo(CalcSetup."No. series for Proceedings VP Reset", TODAY, true);


                        if StrLen(format(Date2DMY("Calculation Journal Line"."Calculation Date To", 2))) = 1
                                                 then
                            "Calculation Journal Line"."Proceedings No. Print" := '0' + format(Date2DMY("Calculation Journal Line"."Calculation Date To", 2)) + copystr("Calculation Journal Line"."Proceedings No. Print", 3, strlen("Calculation Journal Line"."Proceedings No. Print")) + '-' + format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3))
                        else
                            "Calculation Journal Line"."Proceedings No. Print" := format(Date2DMY("Calculation Journal Line"."Calculation Date To", 2)) + copystr("Calculation Journal Line"."Proceedings No. Print", 3, strlen("Calculation Journal Line"."Proceedings No. Print")) + '-' + format(Date2DMY("Calculation Journal Line"."Calculation Date To", 3));
                    end;
                    "Calculation Journal Line".Modify();

                end;
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
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

        CJLPrevious: Record "Calculation Journal Line";
        TempF: Record "Area" temporary;
        BrojacZona: Integer;
        NoSeriesLine: Record "No. Series Line";
}

