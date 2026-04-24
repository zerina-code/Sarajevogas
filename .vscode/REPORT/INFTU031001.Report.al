report 50101 "INF-TU-03-10-01"
{
    Caption = 'Izvještaj', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\INF-TU-03-10-01.docx';
    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            column(No_; "No.")
            {

            }
            column(CZK_Request_No_; "CZK Request No.")
            {

            }
            column(Document_NoNewValue; Document_NoNewValue) { }
            column(registrationNumber; registrationNumber) { }
            column(vatNumber; vatNumber) { }
            column(CompInfo_mbs; CompInfo.MBS) { }
            column(registrationVATNumber; registrationVATNumber) { }
            column(court; court) { }
            column(activityCode; activityCode) { }
            column(transBBI; transBBI) { }
            column(transIntesa; transIntesa) { }
            column(transRaif; transRaif) { }
            column(transUni; transUni) { }
            column(transUnion; transUnion) { }
            column(courtNumber; courtNumber) { }
            column(CompInfo_Fax2; CompInfo.Fax2) { }
            column(ZvanjeR_Process; ConvertText(ZvanjeR_Process)) { }
            column(ZvanjeR_Control; ConvertText(ZvanjeR_Control)) { }
            column(ZvanjeR_Verif; ConvertText(ZvanjeR_Verif)) { }
            column(ZvanjeDisegner; ConvertText(ZvanjeDisegner)) { }
            column(CEO_Phone; CEO_Phone) { }
            column(RD; "Responsible Department")
            {

            }
            column(Designer_Name; "Designer Name") { }
            column(Name; Name)
            {

            }
            column(Contr__Empl__Name; "Real. Contr. Empl. Name") { }
            column(Process__Empl__Name; "Real. Process. Empl. Name") { }
            column(Verif__Empl__Name; "Real. Verif. Empl. Name") { }
            column(DateOfRealisation; format("Done Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(Street; Address)
            {

            }
            column(Street2; Street2) { }
            column(Initials; Initials) { }
            column(NC; NC) { }
            column(ConsumptionCategory; ConsumptionCategory) { }
            column(NumberOfFloors; NumberOfFloors) { }

            column(Catastral_Municipality; "Catastral Municipality") { }
            column(Catastral_Municipality_Name; "Catastral Municipality Name") { }
            column(CompInfo_Indu; CompInfo."Industrial Classification") { }
            column(Municipality; "Municipality Name")
            {

            }
            column(AccExe_Pos; AccExe_Pos) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExeName; AccExeName) { }
            column(Acc2_Name; Acc2_Name) { }
            column(City; City)
            {

            }
            column(City2; City2) { }
            column(kW_Power; "kW Power")
            {
                DecimalPlaces = 0 : 2;

            }
            column(Land; Land)
            {

            }

            column(Customer_Category; "Customer Category") { }
            column(CZK_Date; Format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }

            column(Owner; "Owner Name")
            {

            }
            column(Owner_Mun; "Owner Municipality Name")
            {

            }
            column(Owner_Add; "Owner Address")
            {

            }
            column(EU_Activity; "EU Activity")
            {

            }
            column(Comp_Picture; Comp.Picture) { }
            column(Comp_Picture1; Comp.Picture1) { }
            column(Comp_Picture2; Comp.Picture2) { }
            column(Comp_Address; Comp.Address) { }
            column(Comp_PostCode; Comp."Post Code") { }
            column(Comp_City; Comp.City) { }
            column(PhoneNo; Comp."Phone No.")


            {

            }
            column(YearDocument; YearDocument) { }
            column(PhoneNo2; Comp."Phone No. 2")
            {

            }
            column(FaxNo; Comp."Fax No.")
            {

            }
            column(CompPage; Comp."Home Page")
            {

            }
            column(Document_Date; FORMAT("Document Date", 0, '<day,2>.<month,2>.<year4>')) { }

            column(TextExc; TextExc) { }
            column(TextExc2; TextExc2) { }
            column(G_Gauge_Size; "G Gauge Size") { }
            column(DGM_Diameter; format("DGM Diameter", 0, '<Precision,0:0><Standard Format,2>')) { }
            column(Service_Line_Diameter; format("Service Line Diameter", 0, '<Precision,0:0><Standard Format,2>')) { }
            column(Measure_Point_Pressure; format(
                "Measure Point Pressure"))
            { }
            column(CompEmail2; Comp."E-mail2") { }
            column(ServiceItemLineGaugeSize; ServiceItemLine."Gauge Size") { }
            column(ServiceItemLineNumberOfMM; ServiceItemLine."Number of Measure Points") { }
            column(ServiceItemLineMM; ServiceItemLine."Service Item No.") { }
            column(TextMA; TextMA) { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Comp.get;
                Comp.CalcFields(Picture, Picture1, Picture2);
                if No_ <> '' then
                    setfilter("No.", '%1', No_);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                AD: record "Additional Education";
                ContactR: Record Contact;

            begin
                City2 := "City 2";
                Street2 := "Address 2";
                Initials := "Initials";
                NumberOfFloors := "Number of Floors";
                ConsumptionCategory := "Consumption Category";

                YearDocument := Date2DMY("Document Date", 3);

                //                CalcFields("Catastral Municipality Name");

                banacc.Reset();
                banacc.SetFilter("No.", 'BANK01');
                if banacc.FindFirst() then begin
                    transUni := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK02');
                if banacc.FindFirst() then begin
                    transUnion := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK05');
                if banacc.FindFirst() then begin
                    transRaif := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK06');
                if banacc.FindFirst() then begin
                    transBBI := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK03');
                if banacc.FindFirst() then begin
                    transIntesa := banacc."Bank Account No.";
                end;
                registrationNumber := CompInfo."Registration No.";
                registrationVATNumber := CompInfo."VAT Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";

                if "Excavation Permit" = true then begin
                    TextExc := 'POTREBAN PROKOP JAVNE POVRŠINE';
                    TextExc2 := 'Prokop i sanaciju javne površine mora izvesti ovlaštena firma.';
                end
                else begin
                    TextExc := '';
                    TextExc2 := '';
                end;
                Charr := 95;
                CR := 13;
                LF := 10;
                CRLF := FORMAT(CR) + FORMAT(LF);

                if "Mandatory approval" then
                    TextMA := '•   Izraditi projektnu dokumentaciju, kojom će se rješiti način dovoda gasa od mjesta postavljanja regulaciono mjerne opreme do gasnih aparata u objektu, uz koju se prilaže ova Informacija sa prilozima.'
                     + CRLF + '•   Pribaviti saglasnosti, koji se traže u postupku izgradnje priključnog gasovoda (po potrebi).'
                     + CRLF + '•   Na urađenu projektnu dokumentaciju pribaviti saglasnost nadležne ustanove za zaštitu od požara i eksplozije.'
                     + CRLF + '•   Pribaviti saglasnost na projektnu dokumentaciju i energetsku saglasnost KJKP Sarajevogasa d.o.o..'
                     + CRLF + '•   Riješiti imovinsko-pravne odnose i kolizije sa drugim energetskim i infrastrukturnim objektima na trasi priključnog gasovoda.'
                     + CRLF + '•   Izvesti unutrašnje gasne instalacije u skladu sa projektom i pribaviti saglasnost KJKP Sarajevogas d.o.o. na izvedene instalacije.'
                     + CRLF + '•   Svi aparati i dijelovi prostrojenja moraju biti certificirani (Registar certificirane opreme dostupan na www.sarajevogas.ba).'
                     + CRLF + '•   Izmiriti finansijske obaveze prema KJKP Sarajevogas d.o.o.'
                     + CRLF + '•   Prokop i sanaciju javne površine mora izvesti ovlaštena firma.'
                else
                    TextMA := '•   Izraditi projektnu dokumentaciju, kojom će se rješiti način dovoda gasa od mjesta postavljanja regulaciono mjerne opreme do gasnih aparata u objektu, uz koju se prilaže ova Informacija sa prilozima.'
                     + CRLF + '•   Pribaviti saglasnosti, koji se traže u postupku izgradnje priključnog gasovoda (po potrebi).'
                     + CRLF + '•   Pribaviti saglasnost na projektnu dokumentaciju i energetsku saglasnost KJKP Sarajevogasa d.o.o..'
                     + CRLF + '•   Riješiti imovinsko-pravne odnose i kolizije sa drugim energetskim i infrastrukturnim objektima na trasi priključnog gasovoda.'
                     + CRLF + '•   Izvesti unutrašnje gasne instalacije u skladu sa projektom i pribaviti saglasnost KJKP Sarajevogas d.o.o. na izvedene instalacije.'
                     + CRLF + '•   Svi aparati i dijelovi prostrojenja moraju biti certificirani (Registar certificirane opreme dostupan na www.sarajevogas.ba).'
                     + CRLF + '•   Izmiriti finansijske obaveze prema KJKP Sarajevogas d.o.o.'
                     + CRLF + '•   Prokop i sanaciju javne površine mora izvesti ovlaštena firma.';
                Acc2_Name := '';
                AccExeName := '';
                Acc2_Pos_ := '';
                ZvanjeDisegner := '';
                ZvanjeR_Control := '';
                ZvanjeR_Process := '';
                ZvanjeR_Verif := '';
                CompInfo.get;




                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeader."Real. Process. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeader."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Process := AD."Title Description";



                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeader."Real. Contr. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeader."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Control := AD."Title Description";


                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeader."Real. Verif. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeader."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Verif := AD."Title Description";

                if ServiceHeader."Designer Connection Type" = ServiceHeader."Designer Connection Type"::Internal then begin

                    AD.Reset();
                    AD.SetFilter("Employee No.", '%1', ServiceHeader."Designer No.");
                    AD.SetFilter("From Date", '<=%1', ServiceHeader."Document Date");
                    AD.SetCurrentKey("From Date");
                    if AD.FindLast() then
                        ZvanjeDisegner := AD."Title Description";
                end;

                if ServiceHeader."Designer Connection Type" = ServiceHeader."Designer Connection Type"::External then begin

                    ContactR.Reset();
                    ContactR.SetFilter("No.", '%1', ServiceHeader."Designer No.");
                    ContactR.SetFilter("Type Relation", '%1', ContactR."Type Relation"::Designer);
                    if ContactR.FindLast() then
                        ZvanjeDisegner := ContactR."Title Description";
                end;



                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person");
                if EmpN.FindFirst() then begin
                    AccExeName := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        AccExe_Pos := ecl."Position Description";

                end;

                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person Exe");
                if EmpN.FindFirst() then begin
                    Acc2_Name := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        Acc2_Pos_ := ecl."Position Description";

                end;




                ServiceItemLine.Reset();
                ServiceItemLine.SetFilter("Document No.", '%1', ServiceHeader."No.");
                if ServiceItemLine.FindFirst() then
                    ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetFilter(status, '%1', ORG.Status::Active);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                ORG.FindFirst();

                Head.Reset();
                Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                Head.SetFilter("ORG Shema", '%1', ORG.Code);
                if Head.FindFirst() then begin
                    Head.CalcFields("Employee Name", "Employee Last Name", "Employee No.");
                    Head.CalcFields("Position Description");
                    emp.SetFilter("No.", '%1', Head."Employee No.");
                    if emp.FindFirst() then begin
                        CEO_Phone := emp."Company Phone No.";
                    end;
                end;

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

                            No_ := ServiceHeader.GetFilter("No.");
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50101);
                            SHG.Reset();
                            SHG.SetFilter("No.", '%1', No_);
                            if SHG.FindFirst() then
                                CustomReportLayout.SetFilter("Request Type", '%1', SHG."Request Type");

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

    trigger OnInitReport()
    var
        myInt: Integer;
        CL: Record "Custom Report Layout";
        No_: Code[20];
        SHG: Record "Service Header";
    begin
        No_ := ServiceHeader.GetFilter("No.");



        CL.Reset();
        CL.SetFilter("Report ID", '%1', 50101);
        if No_ <> '' then begin
            SHG.Reset();
            SHG.SetFilter("No.", '%1', No_);
            if SHG.FindFirst() then
                cl.SetFilter("Request Type", '%1', SHG."Request Type");
        end;
        if cl.FindFirst() then
            ReportLayout := cl.Description;

    end;

    var
        Comp: Record "Company Information";
        CEO_Phone: Text[100];
        ORG: Record "ORG Shema";
        banacc: record "Bank Account";
        TextExc: text[250];
        TextExc2: text[250];
        TextMA: text;
        Head: Record "Head Of's";
        emp: Record Employee;
        ServiceItemLine: Record "Service Item Line";
        AccExe_Pos: Text;
        Acc2_Name: Text;
        AccExeName: Text;
        EmpN: record "Employee";
        Acc2_Pos_: Text;
        CompInfo: Record "Company Information";
        ecl: Record "Employee Contract Ledger";
        ZvanjeR_Process: text[250];
        ZvanjeR_Control: Text[250];
        ZvanjeR_Verif: text[250];

        YearDocument: integer;
        transUnion: Text;

        transRaif: Text;
        Document_NoNewValue: text;
        transUni: Text;
        transIntesa: Text;
        transBBI: Text;
        court: Text;
        courtNumber: Text;
        numberOfDecision: Text;
        No_: code[20];
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;


        ZvanjeDisegner: Text[250];
        ReportLayout: text[250];

        Street2: Text;
        City2: Text;

        NumberOfFloors: Text;
        Initials: Text;
        ConsumptionCategory: Text;
        CR: Char;
        LF: Char;
        CRLF: Text[2];

        Charr: Char;




    local procedure ConvertText(var Input: Text[250]) Output: Text
    var
        myInt: Integer;
    begin

        if StrLen(Input) > 1 then begin
            Output := copystr(Input, 1, 1) + text.LowerCase(copystr(Input, 2, StrLen(Input)));
        end
        else begin
            Output := input;
        end;

    end;

    procedure SetParam(Code_10: Code[20]; Document_NoNew: code[20])
    var

    begin
        No_ := Code_10;
        Document_NoNewValue := Document_NoNew;
    end;


}