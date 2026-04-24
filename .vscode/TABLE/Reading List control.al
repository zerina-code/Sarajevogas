report 50026 "Reading List Control"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReadingList.rdl';

    dataset
    {

        dataitem("Control list"; "Control list")
        {
            column(Address_MM; Address_MM) { }
            column(Customer_No_; "Customer No.") { }
            column(Customer_Name; "Customer Name") { }
            column(Serial_Number; "Serial Number") { }
            column(Proceedings_No_; "Proceedings No.") { }
            column(Reading_Mode; "Reading Mode") { }

            column(ReportDate; format(ReportDate, 0, '<day,2>.<month,2>.<year4>')) { }

            column(OrgJed; OrgJed) { }
            column(CompInf_Picture; CompInf.Picture) { }
            column(CompInf; CompInf.Name) { }
            //  column(Measuring_Point_Stroke; "Measuring Point Stroke") { }
            column(Measuring_Point_Stroke; "Measuring Point stroke") { }
            column(Measuring_Point_string; "Measuring Point string") { }
            column(Year_Of_GAS_Calculation; "Year Of GAS Calculation") { }
            column(Mjes; Mjesec) { }
            column(redniB; redniB) { }
            column(Measuring_Point_Code; "Measuring Point Code") { }
            column(MM_Description; "MM Description") { }
            column(Customer_Stroke; "Customer Stroke") { }
            column(OdgovornoLice; OdgovornoLice) { }
            column(TextAddd; TextAddd) { }
            column(Filters; Filters) { }
            column(New_Value; "New Value") { }
            column(Source_Data; "Source Data") { }




            trigger OnAfterGetRecord()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
                CalcSetup: Record "Calculation Setup";
                NoSeries: code[20];
                US: Record "User Setup";
                ECL: Record "Employee Contract Ledger";
                Dism: Record "Dismantling Reason";



            begin
                OdgovornoLice := '';
                Address_MM := '';

                if ("New Value" = 0) and ("Source Data" = "Source Data"::Unknown) then
                    TextAddd := 'BOČ';

                if ("New Value" = 0) and ("Source Data" <> "Source Data"::Unknown) then
                    TextAddd := 'PogrOč';

                if (Difference < 0) and ("New Value" <> 0) then
                    TextAddd := 'PogrOč';

                Dism.Reset();
                Dism.SetFilter(Description, '%1', "Control list"."Reason for Control");
                if Dism.FindFirst() then
                    TextAddd := Dism."Short Text";



                Address_MM += "Control list"."Address MM" + ' ';
                //slovima
                if "Street No. Text" <> '' then
                    Address_MM := Address_MM + ' ' + "Street No. Text MM";
                if Floor <> '' then
                    Address_MM := Address_MM + ' ' + Floor;
                if "Apartment No." <> '' then
                    Address_MM := Address_MM + ' ' + "Apartment No.";


                Customerrr.Reset();
                Customerrr.SetFilter("No.", '%1', "Control list"."Customer No.");
                if Customerrr.FindFirst() then begin

                    if (StrPos(OdgovornoLice, Customerrr.Contact) = 0) and (Customerrr.Contact <> '') then
                        OdgovornoLice += Customerrr.Contact + ', ';

                    if (StrPos(OdgovornoLice, Customerrr."Phone No.") = 0) and (Customerrr."Phone No." <> '') then
                        OdgovornoLice += Customerrr."Phone No." + ', ';

                    if (StrPos(OdgovornoLice, Customerrr."Phone - Transfer") = 0) and (Customerrr."Phone - Transfer" <> '') then
                        OdgovornoLice += Customerrr."Phone - Transfer" + ', ';





                end;

                MMOhone.Reset();
                MMOhone.SetFilter("No.", '%1', "Control list"."Measuring Point Code");
                if MMOhone.FindFirst() then begin
                    if (StrPos(OdgovornoLice, MMOhone."Owner Phone No.") = 0) and (MMOhone."Owner Phone No." <> '') then
                        OdgovornoLice += MMOhone."Owner Phone No." + ', ';

                end;
                if StrLen(OdgovornoLice) > 2 then
                    OdgovornoLice += CopyStr(OdgovornoLice, 1, StrLen(OdgovornoLice) - 2);
                CompInf.get;
                CompInf.CalcFields(Picture);
                ReportDate := today;
                if "Control list"."Month Of GAS Calculation" = 1 then
                    Mjesec := 'Januar';
                if "Control list"."Month Of GAS Calculation" = 2 then
                    Mjesec := 'Februar';

                if "Control list"."Month Of GAS Calculation" = 3 then
                    Mjesec := 'Mart';

                if "Control list"."Month Of GAS Calculation" = 4 then
                    Mjesec := 'April';

                if "Control list"."Month Of GAS Calculation" = 5 then
                    Mjesec := 'Maj';

                if "Control list"."Month Of GAS Calculation" = 6 then
                    Mjesec := 'Juni';

                if "Control list"."Month Of GAS Calculation" = 7 then
                    Mjesec := 'Juli';

                if "Control list"."Month Of GAS Calculation" = 8 then
                    Mjesec := 'August';

                if "Control list"."Month Of GAS Calculation" = 9 then
                    Mjesec := 'Septembar';

                if "Control list"."Month Of GAS Calculation" = 10 then
                    Mjesec := 'Oktobar';

                if "Control list"."Month Of GAS Calculation" = 11 then
                    Mjesec := 'Novembar';

                if "Control list"."Month Of GAS Calculation" = 12 then
                    Mjesec := 'Decembar';




                redniB := redniB + 1;

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', us."Employee No. for Wage");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        OrgJed := ecl."Department Code"
                    else
                        OrgJed := '';
                end;



            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //    Evaluate(UlicaSort, "Street No.");
                if ReportLayout = 'ZA VP' then begin
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
                end
                else begin
                    //Street No. Text int" - ovo smo stavili kao sprat MM u integer.

                    SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street Name MM", "Street No. Int", "Street No. Text MM", "Street No. Text int", "Street No. Text Apartment", "Customer No. int");
                end;
                Ascending;

                Filters := GetFilters;

            end;
        }



    }


    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field(ReportLayout; ReportLayout)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Report Layout';
                        //   TableRelation="Custom Report Layout".Description wher;
                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                            No_: code[20];
                            SHG: Record "Service Header";

                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50181);
                            CRLPage.SetTableView(CustomReportLayout);


                            CRLPage.LOOKUPMODE(TRUE);
                            IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                CRLPage.GETRECORD(CustomReportLayout);
                                ReportLayout := CustomReportLayout.Description;

                                ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));

                            end;

                        end;

                    }
                }
            }

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
        CustomReportLayout.SetFilter("Report ID", '%1', 50181);
        if CustomReportLayout.FindFirst() then begin

            ReportLayout := CustomReportLayout.Description;

            ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));


        end;
    end;

    var
        CompInf: record "Company Information";
        WCHeadeR: Record "Calcuation Header";
        SummerYes: Boolean;
        ReportDate: date;
        OutputNo: Integer;
        Address_MM: text[1000];
        OrgJed: text[1000];
        Mjesec: text[1000];
        redniB: Integer;
        UlicaSort: integer;
        OdgovornoLice: Text;
        ReportLayout: text[1000];
        Customerrr: Record Customer;
        Filters: text;
        MMOhone: Record "Service Item";
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        TextAddd: Text;
}

