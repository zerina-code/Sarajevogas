report 50103 "SG-TU-03-09-01"
{
    Caption = 'SG-TU-03-09-01', Locked = true;
    DefaultLayout = Word;
    WordMergeDataItem = ServiceHeader;
    WordLayout = '.\.vscode\REPORT\WORD\SG-TU-03-09-01.docx';
    dataset
    {
        dataitem(ServiceHeader; "Service Item Line")
        {
            //   CalcFields = "CZK Date";
            column(No_; "Document No.")
            {

            }
            column(Connection_to; Connection_to) { }
            column(VrstaObjekta; ServiceHeader."Dwelling Type") { }
            column(Customer_CategoryPrint; Customer_CategoryPrint) { }
            //column(Connection_to; ServiceHeaderAdd."Connection to") { }
            column(BrojSamo; BrojSamo) { }
            column(Owner; ServiceHeaderAdd."Owner Name")
            {

            }

            column(Mjesec; Mjesec) { }
            column(Owner_Mun; ServiceHeaderAdd."Owner Municipality Name")
            {

            }

            column(Initials; ServiceHeaderAdd.Initials) { }

            column(Owner_Add; ServiceHeaderAdd."Owner Address") { }
            column(Measure_Point_Pressure1; ServiceHeaderAdd."Measure Point Pressure1") { }
            column(AddressPR; AddressPR) { }
            column(TotalOpt; TotalOpt) { }
            column(BrUlicePR; BrUlicePR) { }

            column(Catastral_Municipality; ServiceHeaderAdd."Catastral Municipality") { }
            column(Catastral_Municipality_Name; ServiceHeaderAdd."Catastral Municipality Name") { }
            column(Responsible_Department; ServiceHeaderAdd."Responsible Department") { }
            column(CZK_Request_No_; ServiceHeaderAdd."CZK Request No.")
            {

            }
            column(Document_NoNewValue; Document_NoNewValue) { }
            column(Measure_Point_Pressure; ServiceHeaderAdd."Measure Point Pressure") { }
            column(G_Gauge_Size; ServiceHeaderAdd."G Gauge Size") { }
            column(FaxNo; Comp."Fax No.")
            {

            }
            column(CompInfo_Fax2; CompInfo.Fax2) { }
            column(CompInfoFax; CompInfo."Fax No.") { }
            column(Firefight_Accordance; ServiceHeaderAdd."Firefight Accordance") { }
            column(Firefight_Accordance_No_; ServiceHeaderAdd."Firefight Accordance No.") { }
            column(Note; Note) { }
            column(Note2; Note2) { }
            column(Note3; Note3) { }
            column(SGPO_Date_Fire_Protection; ServiceHeaderAdd."SGPO Date Fire Protection") { }
            column(ZvanjeR_Process; ConvertText(ZvanjeR_Process)) { }
            column(ZvanjeR_Control; ConvertText(ZvanjeR_Control)) { }
            column(ZvanjeR_Verif; ConvertText(ZvanjeR_Verif)) { }
            column(ZvanjeDisegner; ConvertText(ZvanjeDisegner)) { }
            column(PositionDisegner; PositionDisegner) { }
            column(PositionR_Control; PositionR_Control) { }
            column(PositionR_Process; PositionR_Process) { }
            column(PositionR_Verif; PositionR_Verif) { }
            column(Project; ServiceHeaderAdd.Project) { }
            column(UGI_Project_Name; ServiceHeaderAdd."UGI Project Name") { }
            column(UGI_Project_Creation_Date; Format(ServiceHeaderAdd."UGI Project Creation Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Investor_Code; ServiceHeaderAdd."Investor Code") { }
            column(Investor_Name; ServiceHeaderAdd."Investor Name") { }
            column(CEO_Phone; CEO_Phone) { }
            column(Designer_Name; ServiceHeaderAdd."Designer Name") { }
            column(Design_Company; ServiceHeaderAdd."Design Company") { }
            column(EUActivity; ServiceHeaderAdd."EU Activity") { }
            column(RD; ServiceHeaderAdd."Responsible Department")
            {

            }
            column(Name; ServiceHeaderAdd.Name)
            {

            }
            column(Street; Address)
            {

            }
            column(AdresaMMM; AdresaMMM) { }
            column(Street_No__Text_MM; "Street No. Text MM") { }

            column(Contr__Empl__Name; ServiceHeaderAdd."Real. Contr. Empl. Name") { }
            column(Process__Empl__Name; ServiceHeaderAdd."Real. Process. Empl. Name") { }
            column(Verif__Empl__Name; ServiceHeaderAdd."Real. Verif. Empl. Name") { }
            column(Municipality; "Municipality Name")
            {

            }
            column(Service_Line_Diameter; ServiceHeaderAdd."Service Line Diameter") { }
            column(DGM; ServiceHeaderAdd."DGM Diameter") { }
            column(precnik; precnik) { }

            column(City; ServiceHeaderAdd.City)
            {

            }
            column(Customer_Category; ServiceHeaderAdd."Customer Category") { }

            column(AccExe_Pos; AccExe_Pos) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExeName; AccExeName) { }
            column(Acc2_Name; Acc2_Name) { }
            column(Phone_No_; ServiceHeaderAdd."Phone No.")
            {

            }
            column(CompPage; Comp."Home Page")
            {

            }
            column(PhoneNo2; Comp."Phone No. 2")
            {

            }
            column(Designer; StrSubstNo('%1 / %2', ServiceHeaderAdd."Designer Phone No.", ServiceHeaderAdd."Designer Email"))
            {

            }
            column(CZK_Date; Format(ServiceHeaderAdd."CZK Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Measuring_Area_1; ServiceHeaderAdd."Measuring Area 1") { }
            column(Measuring_Area_2; ServiceHeaderAdd."Measuring Area 2") { }
            column(Document_Date; Format(ServiceHeaderAdd."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(ServiceItemLineAddress; ServiceItemLine.Address) { }
            column(ServiceItemLineMM; ServiceItemLine."Service Item No.") { }
            column(Request_Due_Date; ServiceHeaderAdd."Request Due Date")
            {

            }
            column(ServiceItemLineConsentID; ServiceHeader."Consent ID") { }
            column(kW_Power; ServiceHeaderAdd."kW Power")
            {

            }

            column(CompEmail2; Comp."E-mail2") { }
            column(ServiceItemLineGaugeSize; ServiceItemLine."Gauge Size") { }
            column(ServiceItemLineNumberOfMM; ServiceItemLine."Number of Measure Points") { }
            column(Comp_Picture; Comp.Picture) { }
            column(Comp_Picture1; Comp.Picture1) { }
            column(Comp_Picture2; Comp.Picture2) { }
            column(Comp_Address; Comp.Address) { }
            column(Comp_PostCode; Comp."Post Code") { }
            column(Comp_City; Comp.City) { }
            column(PhoneNo; Comp."Phone No.") { }



            dataitem("Gas Appliance"; "Gas Appliance")
            {
                DataItemLink = "Document No." = field("Document No.");

                column(Description; Description) { }
                column(Q; Quantity) { }
                column(Power_From; "Power From") { }
                column(Power_To; "Power To") { }
                column(Type; "Gas Appliance Type") { }
                column(Br; Brojac) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Connection_to := '';

                    if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                        ServiceHeaderAdd.CalcFields("CZK Date");

                    if ServiceHeaderAdd."Connection to" = ServiceHeaderAdd."Connection to"::"Distribution gas line"
                    then
                        Connection_to := 'Distributivni gasni vod';
                    if ServiceHeaderAdd."Connection to" = ServiceHeaderAdd."Connection to"::"Service gas line"
                    then
                        Connection_to := 'Servisni gasni vod';


                    Brojac += 1;
                    BrojSamo := GetNo(ServiceHeaderAdd."No.");
                    //   BrojSamo := DelChr(BrojSamo, '=', '0');

                    //Gas Appliance

                end;


            }
            dataitem("Document Attachment"; "Document Attachment")
            {
                column(Mandatory_Attachment_Type; MandText) { }
                column(Delivered; Delivered) { }
                column(BrojacRedova; BrojacRedova) { }
                column(da; da) { }
                column(ne; ne) { }

                trigger OnAfterGetRecord()
                var
                    ServiceHeaderAddRec: Record "Service Header";
                    myInt: Integer;
                    ProcessedAttachment: Boolean;
                begin

                    MandText := "Mandatory Attachment Type";
                    if (CopyStr(MandText, 1, 1) in ['1', '2', '3', '4', '5', '6', '7', '8', '9'])
                    and (CopyStr(MandText, 1, 2) <> '9Ž') then
                        MandText := CopyStr(MandText, 2, StrLen(MandText));

                    if (CopyStr(MandText, 1, 2) in ['9ž']) then
                        MandText := CopyStr(MandText, 3, StrLen(MandText));


                    if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                        ServiceHeaderAdd.CalcFields("CZK Date");
                    Da := '  ';
                    Ne := '  ';
                    BrojacRedova += 1;
                    if Delivered = Delivered::Yes then
                        Da := 'X ' else
                        Ne := 'X ';

                    /*      Da := '';
                          Ne := '';
                          BrojacRedova := 0;
                          ProcessedAttachment := false; // Reset obradjenih zapisa

                          if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                              ServiceHeaderAdd.CalcFields("CZK Date");

                          // Pretražuje sve zapise u trenutnom DataItem-u
                          if "Document Attachment".FindSet() then begin
                              repeat


                                  // Povećaj brojač redova
                                  BrojacRedova += 1;

                                  // Provjera da li je već obrađen ovaj prilog (ako nije, dodaj "X")
                                  if ("Document Attachment".Delivered = "Document Attachment".Delivered::Yes) and not ProcessedAttachment then begin
                                      Da := Da + 'X '; // Dodaj "X" samo jednom
                                      ProcessedAttachment := true; // Označi kao obrađeno
                                  end
                                  else
                                      Ne := Ne + 'X '; // Dodavanje u niz ako nije označeno

                              // Debugging the values of Da and Ne

                              until "Document Attachment".Next() = 0; // Iterira kroz sve zapise
                          end;*/
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    GlobalLanguage := 1050;
                    "Document Attachment".SetFilter("No.", '%1', ServiceHeaderAdd."No.");
                    "Document Attachment".SetCurrentKey("Mandatory Attachment Type");
                    "Document Attachment".Ascending;

                end;
            }
            dataitem("Service Comment Line"; "Service Comment Line")
            {

                column(Comment; Comment) { }
                column(BrojacNedostataka; BrojacNedostataka) { }


                trigger OnPreDataItem()
                var

                    myInt: Integer;
                begin
                    "Service Comment Line".SetFilter("No.", '%1', ServiceHeaderAdd."No.");
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                        ServiceHeaderAdd.CalcFields("CZK Date");
                    BrojacNedostataka += 1;
                end;
            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Comp.get;
                Comp.CalcFields(Picture, Picture1, Picture2);
                if No_ <> '' then
                    SetFilter("Document No.", '%1', No_);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                AD: record "Additional Education";
                ContactR: Record Contact;
                ECL: Record "Employee Contract Ledger";
                GASApp: Record "Gas Appliance";

            begin


                if ServiceHeader."Street No. Text MM" <> '' then
                    AdresaMMM := ServiceHeader.Address + '/' + "Street No. Text MM"
                else
                    AdresaMMM := ServiceHeader.Address;



                if ServiceHeaderAdd.Get(ServiceHeader."Document Type", ServiceHeader."Document No.") then
                    ServiceHeaderAdd.CalcFields("CZK Date");


                if ServiceHeaderAdd."Connection to" = ServiceHeaderAdd."Connection to"::"Distribution gas line" then
                    precnik := format(ServiceHeaderAdd."DGM Diameter")
                else
                    precnik := ServiceHeaderAdd."Service Line Diameter";

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::Household
         then
                    Customer_CategoryPrint := 'Domaćinstva';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::CNG
              then
                    Customer_CategoryPrint := 'CNG';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Large Economy"
              then
                    Customer_CategoryPrint := 'Velika privreda';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Small Economy"
              then
                    Customer_CategoryPrint := 'Mala privreda';

                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"Special Customer"
              then
                    Customer_CategoryPrint := 'Specijalni kupac';
                if ServiceHeaderAdd."Customer Category" = ServiceHeaderAdd."Customer Category"::"KJKP Heating plant"
              then
                    Customer_CategoryPrint := 'KJKP Toplane';

                TotalOpt := 0;
                GASApp.Reset();
                GASApp.SetFilter("Document No.", '%1', ServiceHeaderAdd."No.");
                if GASApp.FindSet() then
                    repeat
                        TotalOpt += GASApp.Quantity * GASApp."Power To";

                    until GASApp.Next() = 0;

                ContactR.Reset();
                ContactR.SetFilter(Name, '%1', ServiceHeaderAdd."Design Company");
                ContactR.SetFilter("Type Relation", '%1', ContactR."Type Relation"::Designer);
                if ContactR.FindLast() then begin
                    AddressPR := ContactR.Address;
                    BrUlicePR := ContactR.Street;
                end;

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 1
 then
                    Mjesec := 'januara ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';




                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 2

            then
                    Mjesec := 'februara ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 3
            then
                    Mjesec := 'marta ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 4
            then
                    Mjesec := 'aprila ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 5
            then
                    Mjesec := 'maja ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 6
            then
                    Mjesec := 'juna ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 7
            then
                    Mjesec := 'jula ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 8
            then
                    Mjesec := 'augusta ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 9
            then
                    Mjesec := 'septembra ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 10
            then
                    Mjesec := 'oktobra ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 11
            then
                    Mjesec := 'novembra ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';

                if Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 2) = 12
            then
                    Mjesec := 'decembra ' + format(Date2DMY(ServiceHeaderAdd."UGI Project Creation Date", 3)) + '.' + ' godine,';



                //  CalcFields("Catastral Municipality Name");
                if ServiceHeaderAdd."Excavation Permit" = true then
                    TextExc := 'POTREBAN PROKOP JAVNE POVRŠINE'
                else
                    TextExc := '';

                Acc2_Name := '';
                AccExeName := '';
                Acc2_Pos_ := '';
                ZvanjeDisegner := '';
                ZvanjeR_Control := '';
                ZvanjeR_Process := '';
                ZvanjeR_Verif := '';
                CompInfo.get;
                PositionDisegner := '';
                PositionR_Control := '';
                PositionR_Process := '';
                PositionR_Verif := '';




                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Process. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeaderAdd."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Process := AD."Title Description";

                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Process. Empl. No.");
                ecl.SetFilter(Active, '%1', true);
                if ecl.FindFirst() then
                    PositionR_Process := ecl."Position Description";



                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Contr. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeaderAdd."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Control := AD."Title Description";


                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Contr. Empl. No.");
                ecl.SetFilter(Active, '%1', true);
                if ecl.FindFirst() then
                    PositionR_Control := ecl."Position Description";

                AD.Reset();
                AD.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Verif. Empl. No.");
                AD.SetFilter("From Date", '<=%1', ServiceHeaderAdd."Document Date");
                AD.SetCurrentKey("From Date");
                if AD.FindLast() then
                    ZvanjeR_Verif := AD."Title Description";

                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Real. Verif. Empl. No.");
                ecl.SetFilter(Active, '%1', true);
                if ecl.FindFirst() then
                    PositionR_Verif := ecl."Position Description";

                if ServiceHeaderAdd."Designer Connection Type" = ServiceHeaderAdd."Designer Connection Type"::Internal then begin

                    AD.Reset();
                    AD.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Designer No.");
                    AD.SetFilter("From Date", '<=%1', ServiceHeaderAdd."Document Date");
                    AD.SetCurrentKey("From Date");
                    if AD.FindLast() then
                        ZvanjeDisegner := AD."Title Description";

                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', ServiceHeaderAdd."Designer No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        PositionDisegner := ecl."Position Description";

                end;

                if ServiceHeaderAdd."Designer Connection Type" = ServiceHeaderAdd."Designer Connection Type"::External then begin

                    ContactR.Reset();
                    ContactR.SetFilter("No.", '%1', ServiceHeaderAdd."Designer No.");
                    ContactR.SetFilter("Type Relation", '%1', ContactR."Type Relation"::Designer);
                    if ContactR.FindLast() then begin
                        ZvanjeDisegner := ContactR."Title Description";
                        PositionDisegner := ContactR."Job Title";
                    end;




                end;



                EmpN.Reset();
                // EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person");
                EmpN.SetFilter("No.", '%1', CompInfo."Spending Plan Responsible Person");
                if EmpN.FindFirst() then begin
                    AccExeName := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        //AccExe_Pos := ecl."Position Description";
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
                ServiceItemLine.SetFilter("Document No.", '%1', ServiceHeaderAdd."No.");
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

                if ServiceHeaderAdd."Firefight Accordance" <> '' then begin
                    Note3 := 'Napomena: ';
                    Note := 'Projekat je bio ovjeren pečatom firme za poslove protivpožarne zaštite: ' + ServiceHeaderAdd."Firefight Accordance";
                    Note2 := 'i uz njega je bila data dokumentacija te firme pod brojem: ' + ServiceHeaderAdd."Firefight Accordance No." + ' od ' + format(ServiceHeaderAdd."SGPO Date Fire Protection", 0, '<Day,2>.<Month,2>.<Year4>') + '.';

                end
                else begin
                    Note := '';
                    Note3 := '';
                    Note2 := '';
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

                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50103);
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
    begin
        GlobalLanguage := 1050;
        Brojac := 0;
        CL.Reset();
        CL.SetFilter("Report ID", '%1', 50103);
        if cl.FindFirst() then
            ReportLayout := cl.Description;

    end;

    var
        Comp: Record "Company Information";
        CEO_Phone: Text[100];
        ORG: Record "ORG Shema";
        TextExc: text[250];
        Head: Record "Head Of's";
        Connection_to: Text[250];
        emp: Record Employee;
        ServiceItemLine: Record "Service Item Line";
        AccExe_Pos: Text;
        Acc2_Name: Text;
        AccExeName: Text;
        BrojSamo: Text[250];
        EmpN: record "Employee";
        Acc2_Pos_: Text;
        CompInfo: Record "Company Information";
        ecl: Record "Employee Contract Ledger";
        ZvanjeR_Process: text[250];
        ZvanjeR_Control: Text[250];
        TotalOpt: Decimal;
        ServiceHeaderAdd: Record "Service Header";
        ZvanjeR_Verif: text[250];
        BrojacNedostataka: Integer;

        ZvanjeDisegner: Text[250];
        AddressPR: Text[250];
        AdresaMMM: text;

        BrUlicePR: text[250];
        Customer_CategoryPrint: text[250];
        BrojacRedova: Integer;
        precnik: Text[250];
        Da: Text[250];
        Ne: Text[250];
        Document_NoNewValue: text;
        No_: code[20];
        Brojac: Integer;
        PositionR_Process: text[250];
        PositionR_Control: Text[250];
        PositionR_Verif: text[250];

        PositionDisegner: Text[250];

        ReportLayout: text[250];
        Mjesec: text;
        Note: text[250];
        Note2: text[250];
        Note3: text[250];
        DocumentNo: Code[200];
        MandText: text;




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


    procedure GetNo(InputCode: Text[250]) result: Code[20]
    var
        BrojFirst: Integer;
        BrojLast: Integer;
        pos: Integer;
        Pos2: Integer;
        IsNumeric: Boolean;
        Kontinuitet: Integer;
        Kontinuitet2: Integer;

    begin
        Kontinuitet2 := 0;
        pos := 1;
        WHILE (pos <= STRLEN(InputCode))

        DO BEGIN
            IsNumeric := InputCode[pos] IN ['0' .. '9'];
            IF IsNumeric THEN begin
                //kao nastavi niz 
                result := result + FORMAT(InputCode[pos]);
            end
            else begin
                result := '';
            end;

            pos += 1;
        END;



    end;

    procedure SetParam(Code_10: Code[20]; Document_NoNew: code[20])
    var

    begin
        No_ := Code_10;
        Document_NoNewValue := Document_NoNew;
    end;




}
