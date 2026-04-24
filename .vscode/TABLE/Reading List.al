report 50181 "Reading List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './ReadingList.rdl';

    dataset
    {

        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {
            column(Address_MM; Address_MM) { }
            column(Customer_No_; "Customer No.") { }
            column(CustCategory; "Calculation Journal Line"."Category Customer") { }

            column(MMCategory; "Calculation Journal Line"."Category MM") { }
            column(Customer_Name; "Customer Name") { }
            column(Reading_Mode; "Reading Mode") { }
            column(ProceedingPrint; "Proceedings No. Print") { }
            column(Serial_Number; "Serial Number") { }
            column(Summer_Zone; "Summer Zone") { }
            column(Winter_Zone; "Winter Zone") { }
            column(SummerYes; SummerYes) { }
            column(Summer_ZoneM; "Calculation Journal Line"."Measuring Zone - summer") { }
            column(Winter_ZoneM; "Calculation Journal Line"."Measuring Zone - winter") { }

            column(Street_No__Text_MM; "Street No. Text MM") { }
            column(Proceedings_No_; "Proceedings No.") { }

            column(ReportDate; format(ReportDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(Year; format("Calculation Journal Line"."Year Of GAS Calculation")) { }
            column(Month; format("Calculation Journal Line"."Month Of GAS Calculation")) { }

            column(OrgJed; OrgJed) { }
            column(CompInf_Picture; CompInf.Picture) { }
            column(CompInf_Picture1; CompInf.Picture1) { }
            column(CompInf; CompInf.Name) { }
            //  column(Measuring_Point_Stroke; "Measuring Point Stroke") { }
            column(Measuring_Point_Stroke; "Measuring Point stroke") { }
            column(Measuring_Point_string; "Measuring Point string") { }
            column(Year_Of_GAS_Calculation; "Year Of GAS Calculation") { }
            column(Street_Name_MM; "Street Name MM") { }
            column(Mjes; Mjesec) { }
            column(redniB; redniB) { }
            column(Measuring_Point_Code; "Measuring Point Code") { }
            column(MM_Description; "MM Description") { }
            column(Customer_Stroke; "Customer Stroke") { }
            column(OdgovornoLice; OdgovornoLice) { }
            column(Filters; Filters) { }
            column(Street_No__int; "Street No. int") { }
            column(Street_No__Text; "Street No. Text") { }
            column(Street_No__Text_Apartment; "Street No. Text Apartment") { }
            column(Customer_No__int; "Customer No. int") { }
            column(Street_No__Text_int; "Street No. Text int") { }
            column(New_Value; "New Value") { }
            column(TextAddd; TextAddd) { }


            trigger OnAfterGetRecord()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
                CalcSetup: Record "Calculation Setup";
                NoSeries: code[20];
                US: Record "User Setup";
                ECL: Record "Employee Contract Ledger";
                Dism: Record "Dismantling Reason";



            begin




                SummerYes := false;


                WCHeadeR.Reset();
                WCHeadeR.SetFilter(Code, '%1', "Calculation Journal Line".Code);
                if WCHeadeR.FindFirst() then begin
                    if WCHeadeR."Summer or Winter Zone" = WCHeadeR."Summer or Winter Zone"::Summer then
                        SummerYes := true
                    else
                        SummerYes := false;
                end;



                OdgovornoLice := '';
                Address_MM := '';

                Address_MM += "Calculation Journal Line"."Address MM" + ' ';

                if "Customer No." = "Measuring Point Code" then begin
                    //slovima
                    if "Street No. Text" <> '' then
                        Address_MM := Address_MM + '/' + "Street No. Text MM";
                    if Floor <> '' then
                        Address_MM := Address_MM + '/' + Floor;
                    if "Apartment No." <> '' then
                        Address_MM := Address_MM + '/' + "Apartment No.";
                end;

                if "Customer No." <> "Measuring Point Code" then begin

                    if "Street No. Text MM" <> '' then
                        Address_MM := Address_MM + '/' + "Street No. Text MM";
                    if Floor <> '' then
                        Address_MM := Address_MM + '/' + Floor;
                    if "Apartment No." <> '' then
                        Address_MM := Address_MM + '/' + "Apartment No.";


                end;


                if ShowCustomer = true then begin
                    Customerrr.Reset();
                    Customerrr.SetFilter("No.", '%1', "Calculation Journal Line"."Customer No.");
                    if Customerrr.FindFirst() then begin

                        if (StrPos(OdgovornoLice, Customerrr.Contact) = 0) and (Customerrr.Contact <> '') then
                            OdgovornoLice := OdgovornoLice + Customerrr.Contact + ', ';

                        if (StrPos(OdgovornoLice, Customerrr."Phone No.") = 0) and (Customerrr."Phone No." <> '') then
                            OdgovornoLice += Customerrr."Phone No." + ', ';

                        if (StrPos(OdgovornoLice, Customerrr."Phone - Transfer") = 0) and (Customerrr."Phone - Transfer" <> '') then
                            OdgovornoLice += Customerrr."Phone - Transfer" + ', ';

                    end;

                end;
                MMOhone.Reset();
                MMOhone.SetFilter("No.", '%1', "Calculation Journal Line"."Measuring Point Code");
                if MMOhone.FindFirst() then begin
                    ConcactF.Reset();
                    ConcactF.SetFilter("No.", '%1', MMOhone."Contact MM");
                    if ConcactF.FindFirst() then begin
                        if (StrPos(OdgovornoLice, ConcactF.name) = 0) and (ConcactF.Name <> '') then
                            OdgovornoLice += ConcactF.name + ', ';
                        if (StrPos(OdgovornoLice, MMOhone."Owner Phone No.") = 0) and (MMOhone."Owner Phone No." <> '') then
                            OdgovornoLice += MMOhone."Owner Phone No." + ', ';

                    end;
                end;

                MMOhone.Reset();
                MMOhone.SetFilter("No.", '%1', "Calculation Journal Line"."Measuring Point Code");
                if MMOhone.FindFirst() then begin
                    if (StrPos(OdgovornoLice, MMOhone."Phone No. MM") = 0) and (MMOhone."Phone No. MM" <> '') then
                        OdgovornoLice += MMOhone."Phone No. MM" + ', ';

                end;

                if StrLen(OdgovornoLice) > 2 then
                    OdgovornoLice := CopyStr(OdgovornoLice, 1, StrLen(OdgovornoLice) - 2);


                CompInf.get;
                CompInf.CalcFields(Picture, Picture1);
                ReportDate := today;
                if "Calculation Journal Line"."Month Of GAS Calculation" = 1 then
                    Mjesec := 'Januar';
                if "Calculation Journal Line"."Month Of GAS Calculation" = 2 then
                    Mjesec := 'Februar';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 3 then
                    Mjesec := 'Mart';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 4 then
                    Mjesec := 'April';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 5 then
                    Mjesec := 'Maj';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 6 then
                    Mjesec := 'Juni';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 7 then
                    Mjesec := 'Juli';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 8 then
                    Mjesec := 'August';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 9 then
                    Mjesec := 'Septembar';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 10 then
                    Mjesec := 'Oktobar';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 11 then
                    Mjesec := 'Novembar';

                if "Calculation Journal Line"."Month Of GAS Calculation" = 12 then
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
                //  SetCurrentKey("Measuring Point Stroke", "Measuring Point string", "Street No. int", "Street No. Text", Floor, "Apartment No.");
                //dodala isti sort kao kod pošte

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
                    field(ShowCustomer; ShowCustomer)
                    {
                        Caption = 'Show Customer Date';
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

        ShowCustomer := false;

        CustomReportLayout.reset;
        CustomReportLayout.SetFilter("Report ID", '%1', 50181);
        if CustomReportLayout.FindFirst() then begin

            ReportLayout := CustomReportLayout.Description;

            ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));


        end;
    end;

    var
        CompInf: record "Company Information";
        ReportDate: date;
        OutputNo: Integer;
        Address_MM: text[1000];
        OrgJed: text[1000];
        ConcactF: Record Contact;
        Filters: text;
        Mjesec: text[1000];
        redniB: Integer;
        UlicaSort: integer;
        OdgovornoLice: Text;
        ShowCustomer: Boolean;
        ReportLayout: text[1000];
        Customerrr: Record Customer;
        MMOhone: Record "Service Item";
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";

        WCHeadeR: Record "Calcuation Header";
        SummerYes: Boolean;
        TextAddd: Text;
}

