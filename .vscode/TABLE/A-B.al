report 50148 "A-B"
{
    Caption = 'Zahtjev za zaključenje ugovora', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\Zahtjev za zaključenje ugovora.docx';

    dataset
    {
        dataitem("Customer Ledger Entry"; "Customer Ledger Entry")
        {

            column(Customer_Name; "Customer Name")
            {
            }
            column(Father_Name; "Father Name") { }
            column(Code; Code)
            {
            }
            column(Otvoren1RNDA; Otvoren1RNDA) { }
            column(Otvoren1RNNE; Otvoren1RNNE) { }
            column(Otvoren2RNDA; Otvoren2RNDA) { }
            column(Otvoren2RNNE; Otvoren2RNNE) { }

            column(Address; Address)
            {
            }
            column(Description; Description) { }
            column(Customer_String; "Customer String")
            {
            }
            column(StanjeMjerila; StanjeMjerila) { }
            column(Customer_Stroke; "Customer Stroke")
            {
            }
            column(Starting_date; format("Starting date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {
            }
            column(Street_no; "Street No.")
            {
            }
            column(CZK; CZK) { }
            column(Floor; "Floor Customer 2")
            {
            }
            column(st_customer_no; "Customer No.")
            {
            }
            column(Apartment_NO; "Apartment No. Customer") { }
            column(st_customername; StandardText2."Customer name")
            {
            }
            column(DatumO; format(DatumO, 0, '<day,2>.<month,2>.<year4>')) { }
            column(st_Address; StandardText2.Address)
            {
            }
            column(st_Floor; StandardText2."Floor Customer 2")
            {
            }
            column(st_Starting_date; format(StandardText2."Starting date", 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(TrenutnaTuzba; TrenutnaTuzba) { }
            column(TrenutnoDug; TrenutnoDug) { }
            column(id_number; IDnumber."Code")
            {
            }
            column(st_id_number; IDnumber2."Code")
            {
            }
            column(Date_of_creation; format("Starting Date", 0, '<day,2>.<month,2>.<year4>')) { }
            column(gauge_no; Gauge1."Inventar number")
            {
            }
            column(customer_phone_no; CustomerInfo."Phone - Transfer")
            {
            }
            column(customer_no; customer_no)
            {
            }
            column(responsible_department; ResOJ)
            {
            }
            column(Protocol; ServiceH."No.") { }
            column(Licnekarte_niz_stari; Licnekarte_niz_stari) { }
            column(Licnekarte_niz_novi; Licnekarte_niz_novi) { }

            dataitem("A-B Attachments"; "A-B Attachments")
            {
                column(Document_No_; "Document No.") { }
                column(Document_Date; format("Document Date", 0, '<day,2>.<month,2>.<year4>')) { }
                column(K_O; "K.O") { }
                column(Document_Type; "Document Type") { }
                column(Document_Type_Code; "Document Type Code") { }
                column(BR; BR) { }
                column(OPUIP; OPUIP) { }
                column(OPUIPText; OPUIPText) { }
                column(KupacStana; KupacStana) { }
                column(KupacStanatext; KupacStanatext) { }
                column(Nasljednici; Nasljednici) { }
                column(NasljedniciText; NasljedniciText) { }
                column(KpuR; KpuR) { }
                column(Kputext; Kputext) { }
                column(Prethodni; Prethodni) { }
                column(Prethodnitext; Prethodnitext) { }
                column(Prodavac; Prodavac) { }
                column(ProdavacText; ProdavacText) { }
                column(NotarText; NotarText) { }
                column(Notar; Notar) { }
                column(KoText; KoText) { }
                column(KO; KO) { }
                column(DatumDok; DatumDok) { }
                column(RazmakAdd; RazmakAdd) { }
                column(DatumDoktext; DatumDoktext) { }

                column(Court_Number; "Court Number") { }
                column(ZK_No_; "ZK No.") { }
                column(KPU; KPU) { }
                column(Dispatch; Dispatch) { }
                column(Decision_No_; "Decision No.") { }
                column(Descendants; Descendants) { }
                column(Notary_Name; "Notary Name") { }
                column(OPU_IP; "OPU-IP") { }
                column(Previous_Customer; "Previous Customer") { }
                column(JIB_Customer; "JIB Customer") { }
                column(Brojac; Brojac) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    if BrojStavke <> '' then
                        SetFilter(Code, '%1', BrojStavke);

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin




                    Charr := 32;
                    Brojac += 1;
                    DatumDok := '';
                    DatumDoktext := '';
                    Notar := '';
                    NotarText := '';
                    OPUIP := '';
                    OPUIPText := '';
                    KupacStana := '';
                    KupacStanatext := '';
                    KO := '';
                    KoText := '';
                    Nasljednici := '';
                    NasljedniciText := '';
                    Prethodni := '';
                    Prethodnitext := '';
                    KpuR := '';
                    Kputext := '';


                    //ovdje dodajem polja
                    if "Document Date" <> 0D then begin
                        DatumDok := FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>');
                        if StrLen(DatumDok) < 19 then begin
                            for i := 1 to 19 - strlen(DatumDok) do begin
                                DatumDok += format(Charr);

                            end;

                        end;
                        DatumDoktext2 := '/DATUM/          ';
                    end;

                    if "Notary Name" <> '' then begin
                        Notar := "Notary Name";
                        if StrLen(Notar) < 29 then begin
                            for i := 1 to 29 - strlen(Notar) do begin
                                Notar += format(Charr);

                            end;
                        end;
                        NotarText := '/NOTAR/                                ';
                    end;
                    if "ZK No." <> '' then begin

                        Notar := "ZK No.";
                        if StrLen(Notar) < 19 then begin
                            for i := 1 to 19 - strlen(Notar) do begin
                                Notar += format(Charr);

                            end;
                        end;
                        NotarText := '/ZK-a uložak br./  ';


                    end;
                    if "Court Number" <> '' then begin



                    end;
                    if Municipality <> '' then begin

                        Notar := "Municipality Name";
                        if StrLen(Notar) < 40 then begin
                            for i := 1 to 40 - strlen(Notar) do begin
                                Notar += format(Charr);

                            end;
                        end;
                        NotarText := '/Općina/                           ';


                    end;
                    if "Court Number" <> '' then begin

                        Notar := "Court Number";
                        if StrLen(Notar) < 29 then begin
                            for i := 1 to 29 - strlen(Notar) do begin
                                Notar += format(Charr);

                            end;
                        end;
                        NotarText := '/Sud/                     ';


                    end;


                    if KPU <> '' then begin

                        Notar := KPU;
                        if StrLen(Notar) < 29 then begin
                            for i := 1 to 29 - strlen(Notar) do begin
                                Notar += format(Charr);

                            end;
                        end;
                        NotarText := '/KPU podul br./          ';


                    end;

                    if "OPU-IP" <> '' then begin

                        OPUIP := "OPU-IP";
                        if StrLen(OPUIP) < 16 then begin
                            for i := 1 to 16 - strlen(OPUIP) do begin
                                OPUIP += format(Charr);

                            end;
                        end;
                        OPUIPText := '/OPU-IP/       ';

                    end
                    else begin
                        OPUIP := BR;
                        if StrLen(OPUIP) < 25 then begin
                            for i := 1 to 25 - strlen(OPUIP) do begin
                                OPUIP += format(Charr);

                            end;
                        end;
                        OPUIPText := '/BR./                                        ';

                    end;

                    if "Customer buyer" <> '' then begin
                        KupacStana := "Customer buyer";
                        if StrLen(KupacStana) < 29 then begin
                            for i := 1 to 29 - strlen(KupacStana) do begin
                                KupacStana += format(Charr);

                            end;
                        end;
                        KupacStanatext := '/KUPAC STANA/                ';
                    end;

                    if Descendants <> '' then begin
                        KupacStana := Descendants;
                        if StrLen(KupacStana) < 29 then begin
                            for i := 1 to 29 - strlen(KupacStana) do begin
                                KupacStana += format(Charr);

                            end;
                        end;
                        KupacStanatext := '/NASLJEDNIK/                 ';
                    end;

                    if "K.O" <> '' then begin
                        KO := "K.O";
                        KoText := 'K.O.'

                    end;
                    if Descendants <> '' then begin
                        Nasljednici := Descendants;
                        NasljedniciText := 'Nasljednici';
                    end;
                    if "Previous Customer" <> '' then begin

                        Prodavac := "Previous Customer";
                        if StrLen(Prodavac) < 40 then begin
                            for i := 1 to 40 - strlen(Prodavac) do begin
                                Prodavac += format(Charr);

                            end;
                        end;

                        ProdavacText := '/PRODAVAC/                            ';

                    end;
                    if "ZK No." <> '' then begin
                        Prodavac := "K.O";
                        if StrLen(Prodavac) < 19 then begin
                            for i := 1 to 19 - strlen(Prodavac) do begin
                                Prodavac += format(Charr);

                            end;
                        end;

                        ProdavacText := '/K.O./             ';

                    end;



                    if KPU <> '' then begin
                        Prodavac := "K.O";
                        if StrLen(Prodavac) < 19 then begin
                            for i := 1 to 19 - strlen(Prodavac) do begin
                                Prodavac += format(Charr);

                            end;
                        end;

                        ProdavacText := '/K.O./ ';
                    end;

                    if "ZK No." <> '' then begin

                        RazmakAdd := OPUIP + DatumDok + Notar + Prodavac;

                        DatumDoktext := OPUIPText + DatumDoktext2 + NotarText + ProdavacText;

                    end
                    else begin

                        if Municipality <> '' then begin

                            RazmakAdd := DatumDok + OPUIP + Notar;

                            DatumDoktext := DatumDoktext2 + OPUIPText + NotarText;

                        end
                        else begin
                            if "Court Number" <> '' then begin
                                RazmakAdd := OPUIP + DatumDok + KupacStana + Prodavac + Notar;

                                DatumDoktext := OPUIPText + DatumDoktext2 + KupacStanatext + ProdavacText + NotarText;


                            end
                            else begin

                                if Descendants <> '' then begin
                                    RazmakAdd := DatumDok + OPUIP + Notar + Prodavac + KupacStana;

                                    DatumDoktext := DatumDoktext2 + OPUIPText + NotarText + ProdavacText + KupacStanatext;

                                end
                                else begin
                                    if KPU <> '' then begin


                                        RazmakAdd := DatumDok + OPUIP + Notar + Prodavac;

                                        DatumDoktext := DatumDoktext2 + OPUIPText + NotarText + ProdavacText;

                                    end
                                    else begin
                                        RazmakAdd := DatumDok + OPUIP + Notar + Prodavac + KupacStana;

                                        DatumDoktext := DatumDoktext2 + OPUIPText + NotarText + ProdavacText + KupacStanatext;

                                    end;


                                end;
                            end;
                        end;
                    end;




                end;

            }



            trigger OnAfterGetRecord()
            var
                myInt: Integer;

                CalCj: record "Calculation Journal Line";
                SHV: Record "Service Header";
                conecttID: Code[20];

                GaugeFind: Record "Installation History";
                GaugeFindPrevious: Record "Installation History";
                Prekategorizacija: Boolean;
                NewCUstomerCode: code[20];
                DepartmentF: Record Department;
                ECL: Record "Employee Contract Ledger";
                UserSetup: Record "User Setup";
            begin

                MMPreviousExsist := '';
                SHV.Reset();
                SHV.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                SHV.SetFilter("A-B", '%1', true);
                SHV.SetFilter("A-B Entry", '%1', "Customer Ledger Entry".Code);
                if SHV.FindSet() then
                    repeat
                        if strpos(SHV."Reason For Service Order", 'PREGLED UGI') <> 0
                        then
                            Otvoren1RNDA := 'X'
                        else
                            Otvoren1RNNE := 'X';

                        if strpos(SHV."Reason For Service Order", 'ZAMJENA MJERILA') <> 0
                        then
                            Otvoren2RNDA := 'X'
                        else
                            Otvoren2RNNE := 'X';



                    until SHV.Next() = 0;





                CustConnect.Reset();
                CustConnect.setfilter("No.", '%1', "Customer Ledger Entry"."Customer No.");
                if CustConnect.FindFirst() then begin
                    if CustConnect."Customer Connection" <> '' then begin
                        //Anisa
                        LK.Reset(); //ovdje sad kupi lične karte novog korisnika
                        LK.SETFILTER(Active, '%1', true);
                        LK.SETFILTER("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        IF LK.FindSet() then
                            repeat
                                if Licnekarte_niz_novi = '' then begin
                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_novi := LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_novi := LK.Code;
                                end

                                else begin

                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_novi += '; ' + LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_novi += '; ' + LK.Code;
                                end;
                            until LK.Next() = 0;

                        LK.Reset(); // pokupi licne karte starog korisnika koji je u polju customer connection
                        LK.SETFILTER(Active, '%1', true);
                        LK.SETFILTER("Customer No.", '%1', CustConnect."Customer Connection");
                        IF LK.FindSet() then
                            repeat
                                if Licnekarte_niz_stari = '' then
                                    Licnekarte_niz_stari := LK.Code + ', ' + LK."Identity card issuer"
                                else
                                    Licnekarte_niz_stari += '; ' + LK.Code + ', ' + LK."Identity card issuer";
                            until LK.Next() = 0;

                        StandardText2.Reset();
                        Standardtext2.SETFILTER("Starting date", '<%1', "Customer Ledger Entry"."Starting Date");
                        Standardtext2.SETFILTER("Customer No.", '%1', CustConnect."Customer Connection");
                        Standardtext2.SETCURRENTKEY("Starting date");
                        Standardtext2.ASCENDING;
                        if
                        Standardtext2.FINDLAST then
                            IDnumber.Reset();
                        IDnumber.SETFILTER(Active, '%1', true);
                        IDnumber.SETFILTER("Customer No.", '%1', CustConnect."Customer Connection");
                        if
                        IDnumber.FINDLAST then
                            IDnumber2.reset();
                        IDnumber2.SetFilter("Customer No.", '%1', CustConnect."Customer Connection");
                        IDnumber2.SetCurrentKey(ID);
                        IDnumber2.Ascending;
                        if
                        IDnumber2.FindFirst then
                            Gauge1.Reset();
                        Gauge1.SetFilter("Customer No.", '%1', CustConnect."Customer Connection");
                        if Gauge1.FindFirst then
                            CalCj.Reset();
                        CalCj.SetFilter(Gauge, '%1', Gauge1.Code);


                        CalCj.SetFilter("Calculation Date To", '<=%1', "Date of creation");
                        CalCj.SetCurrentKey("Calculation Date From");
                        CalCj.Ascending;
                        if CalCj.Findlast() then begin
                            StanjeMjerila := CalCj."New Value";
                            DatumO := CalCj."Calculation Date To";
                        end
                        else begin
                            StanjeMjerila := 0;
                            DatumO := 0D;
                        end;

                        RNLine.Reset();
                        RNLine.SetFilter("Gauge No.", '%1', Gauge1.Code);
                        RNLine.SetFilter("Document Date", '<=%1', "Starting Date");
                        RNLine.SetCurrentKey("Document Date");
                        RNLine.Ascending;
                        if RNLine.FindLast() then begin
                            if RNLine."Date of consumption" >= DatumO then begin
                                DatumO := RNLine."Date of consumption";
                                StanjeMjerila := RNLine.Reading;
                            end;
                        end;
                        RNLine.Reset();
                        RNLine.SetFilter("New Gauges", '%1', Gauge1.Code);
                        RNLine.SetFilter("Document Date", '<=%1', "Starting Date");
                        RNLine.SetCurrentKey("Document Date");
                        RNLine.Ascending;
                        if RNLine.FindLast() then begin
                            if RNLine."Date of consumption New" >= DatumO then begin
                                DatumO := RNLine."Date of consumption New";
                                StanjeMjerila := RNLine."Reading New";
                            end;

                        end;
                        TrenutnoDug := 'NE';
                        ILE.Reset();
                        ILE.SetFilter("Customer No.", '%1', CustConnect."Customer Connection");
                        ILE.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                        ILE.SetFilter("Document Type", '%1', ILE."Document Type"::Invoice);
                        if ile.FindSet() then
                            repeat
                                ILE.CalcFields("Remaining Amt. (LCY)");
                                DugSum += ile."Remaining Amount";



                            until ile.Next() = 0;
                        if DugSum <> 0 then
                            TrenutnoDug := format(DugSum, 0, '<Precision,2:2><Standard Format,2>');
                        Tuz.Reset();
                        tuz.SetFilter("Customer No.", '%1', CustConnect."Customer Connection");
                        tuz.SetFilter(Archive, '%1', false);
                        Tuz.SetFilter("Accusation Status", '<>%1', '@*ovlačenje*');
                        if Tuz.FindFirst() then begin

                            TrenutnaTuzba := 'DA';
                        end
                        else begin

                            TrenutnaTuzba := 'NE';
                        end;

                        CustomerInfo.Reset();
                        CustomerInfo.SetFilter("No.", '%1', "Customer Ledger Entry"."Customer No.");
                        if
                        CustomerInfo.FindFirst() then

                            //    Department.Reset();
                            //  Department.FindFirst();

                            SHV.Reset();
                        SHV.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        SHV.SetFilter("A-B", '%1', true);
                        SHV.SetFilter("A-B Entry", '%1', "Customer Ledger Entry".Code);
                        if SHV.FindFirst() then
                            ServiceH.Reset();
                        ServiceH.SetFilter("No.", '%1', SHV."No.");
                        if ServiceH.FindFirst() then
                            ResOJ := ServiceH."Request Department";

                    end
                    else begin
                        Prekategorizacija := false;

                        GaugeFind.Reset();
                        GaugeFind.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        GaugeFind.SetFilter("Installation Date", '%1', "Customer Ledger Entry"."Starting Date");
                        GaugeFind.SetFilter(Type, '%1', GaugeFind.Type::Gauge);

                        GaugeFind.SetCurrentKey("Installation Date");
                        GaugeFind.Ascending;
                        if GaugeFind.FindLast() then begin

                            GaugeFindPrevious.Reset();
                            GaugeFindPrevious.SetFilter(Code, '%1', GaugeFind.Code);
                            GaugeFind.SetFilter(Type, '%1', GaugeFind.Type::Gauge);
                            GaugeFindPrevious.SetFilter("Dismantling date", '%1', GaugeFind."Installation Date");
                            GaugeFindPrevious.SetCurrentKey("Dismantling date");
                            GaugeFindPrevious.Ascending;
                            if GaugeFindPrevious.findlast() then begin
                                Prekategorizacija := true;

                                NewCUstomerCode := "Customer Ledger Entry"."Customer No.";

                                MMPreviousExsist := GaugeFindPrevious."Measuring Point Code";

                                "Customer Ledger Entry"."Customer No." := GaugeFindPrevious."Customer No.";
                            end;

                        end;
                        StandardText2.Reset();
                        Standardtext2.SETFILTER("Starting date", '<%1', "Customer Ledger Entry"."Starting Date");
                        Standardtext2.SETFILTER("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");

                        //kada je bila prekategorizacija
                        //moram imati uslov
                        Standardtext2.SETCURRENTKEY("Starting date");
                        Standardtext2.ASCENDING;
                        if
                        Standardtext2.FINDLAST then
                            IDnumber.Reset();
                        IDnumber.SETFILTER(Active, '%1', true);
                        IDnumber.SETFILTER("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        if
                        IDnumber.FINDLAST then
                            //Anisa
                            LK.Reset();
                        LK.SETFILTER(Active, '%1', true);
                        LK.SETFILTER("Customer No.", '%1', IDnumber."Customer No.");
                        IF LK.FindSet() then
                            repeat
                                if Licnekarte_niz_novi = '' then begin
                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_novi := LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_novi := LK.Code;
                                end

                                else begin

                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_novi += '; ' + LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_novi += '; ' + LK.Code;
                                end;
                            until LK.Next() = 0;
                        IDnumber2.reset();
                        IDnumber2.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        IDnumber2.SetCurrentKey(ID);
                        IDnumber2.Ascending;
                        if
                        IDnumber2.FindFirst then
                            //Anisa
                            LK.Reset();
                        LK.SETFILTER(Active, '%1', false);
                        LK.SETFILTER("Customer No.", '%1', IDnumber2."Customer No.");
                        IF LK.FindSet() then
                            repeat
                                if Licnekarte_niz_stari = '' then begin
                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_stari := LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_stari := LK.Code;
                                end
                                else begin
                                    if LK."Identity card issuer" <> '' then
                                        Licnekarte_niz_stari += '; ' + LK.Code + ', ' + LK."Identity card issuer"
                                    else
                                        Licnekarte_niz_stari += '; ' + LK.Code;

                                end;
                            until LK.Next() = 0;

                        Gauge1.Reset();

                        Gauge1.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");

                        if Gauge1.FindFirst then
                            CalCj.Reset();

                        if Prekategorizacija = true then begin
                            Gauge1.Code := GaugeFindPrevious.Code;

                            MMPreviousExsist := GaugeFindPrevious."Measuring Point Code";

                            CalCj.Reset();
                            CalCj.SetFilter(Gauge, '%1', GaugeFindPrevious.Code);
                            CalCj.SetFilter("Calculation Date To", '<=%1', "Starting Date");
                            CalCj.SetCurrentKey("Calculation Date To");
                            CalCj.Ascending;
                            if CalCj.Findlast() then begin
                                StanjeMjerila := CalCj."New Value";
                                DatumO := CalCj."Calculation Date To";
                            end
                            else begin
                                StanjeMjerila := 0;
                                DatumO := 0D;
                            end;


                        end
                        else begin


                            CalCj.SetFilter(Gauge, '%1', Gauge1.Code);
                            CalCj.SetFilter("Calculation Date To", '<=%1', "Date of creation");
                            CalCj.SetCurrentKey("Calculation Date From");
                            CalCj.Ascending;
                            if CalCj.Findlast() then begin
                                StanjeMjerila := CalCj."New Value";
                                DatumO := CalCj."Calculation Date To";
                            end
                            else begin
                                StanjeMjerila := 0;
                                DatumO := 0D;
                            end;

                        end;
                        /*

                                                RNLine.Reset();
                                                RNLine.SetFilter("Gauge No.", '%1', Gauge1.Code);
                                                RNLine.SetFilter("Document Date", '<=%1', "Starting Date");
                                                RNLine.SetCurrentKey("Document Date");
                                                RNLine.Ascending;
                                                if RNLine.FindLast() then begin
                                                    if RNLine."Date of consumption" >= DatumO then begin
                                                        DatumO := RNLine."Date of consumption";
                                                        StanjeMjerila := RNLine.Reading;
                                                    end;
                                                end;
                                                RNLine.Reset();
                                                RNLine.SetFilter("New Gauges", '%1', Gauge1.Code);
                                                RNLine.SetFilter("Document Date", '<=%1', "Starting Date");
                                                RNLine.SetCurrentKey("Document Date");
                                                RNLine.Ascending;
                                                if RNLine.FindLast() then begin
                                                    if RNLine."Date of consumption New" >= DatumO then begin
                                                        DatumO := RNLine."Date of consumption New";
                                                        StanjeMjerila := RNLine."Reading New";
                                                    end;

                                                end;

                                                */
                        TrenutnoDug := 'NE';
                        ILE.Reset();
                        ILE.SetFilter("Customer No.", '%1', "Customer No.");
                        ILE.SetFilter("Bill type", '%1|%2|%3', '01', '02', '03');
                        ILE.SetFilter("Document Type", '%1', ILE."Document Type"::Invoice);
                        if ile.FindSet() then
                            repeat
                                ILE.CalcFields("Remaining Amt. (LCY)");
                                DugSum += ile."Remaining Amount";



                            until ile.Next() = 0;
                        if DugSum <> 0 then
                            TrenutnoDug := format(DugSum, 0, '<Precision,2:2><Standard Format,2>');
                        Tuz.Reset();
                        tuz.SetFilter("Customer No.", '%1', "Customer No.");
                        tuz.SetFilter(Archive, '%1', false);
                        Tuz.SetFilter("Accusation Status", '<>%1', '@*ovlačenje*');
                        if Tuz.FindFirst() then begin

                            TrenutnaTuzba := 'DA';
                        end
                        else begin

                            TrenutnaTuzba := 'NE';
                        end;

                        CustomerInfo.Reset();
                        CustomerInfo.SetFilter("No.", '%1', "Customer Ledger Entry"."Customer No.");
                        if
                        CustomerInfo.FindFirst() then

                            //    Department.Reset();
                            //  Department.FindFirst();

  SHV.Reset();
                        if Prekategorizacija = true then
                            SHV.SetFilter("Customer No.", '%1', NewCUstomerCode)
                        else
                            SHV.SetFilter("Customer No.", '%1', "Customer Ledger Entry"."Customer No.");
                        SHV.SetFilter("A-B", '%1', true);
                        SHV.SetFilter("A-B Entry", '%1', "Customer Ledger Entry".Code);
                        if SHV.FindFirst() then
                            ServiceH.Reset();
                        ServiceH.SetFilter("No.", '%1', SHV."No.");
                        if ServiceH.FindFirst() then
                            ResOJ := ServiceH."Request Department";

                    end;

                end;

                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', UserSetup."Employee No. for Wage");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        ResOJ := ecl."Department Code"
                    else
                        ResOJ := '';

                end;

                customer_no := CustomerInfo."No.";
                if MMPreviousExsist <> '' then
                    customer_no := customer_no + '/' + MMPreviousExsist;
            end;



            trigger OnPreDataItem()

            begin

                //SETFILTER("Contract reason", '=%1', 'A-B');
                if BrojStavke <> ''
                then
                    setfilter("COde", '%1', BrojStavke);
                Licnekarte_niz_stari := '';
                Licnekarte_niz_novi := '';
                //SETFILTER("Customer No.", '1000');

            end;
        }

    }
    procedure SetParam(Code_10: Code[20])
    var

    begin
        BrojStavke := Code_10;

    end;

    var
        StandardText2: Record "Customer Ledger Entry";

        CustConnect: Record customer;
        IDnumber: Record "Customer ID";
        IDnumber2: Record "Customer ID";
        RNLine: Record "Service Item Line";
        BrojStavke: code[20];
        DatumO: date;
        Tuz: Record "Accusation Header";
        TrenutnaTuzba: Text[250];
        TrenutnoDug: Text[250];
        Customer_Category: text;
        DugSum: Decimal;
        StanjeMjerila: Decimal;
        Gauge1: Record Gauge;
        CustomerInfo: Record Customer;
        Department: Record "Service Header";
        Otvoren1RNDA: text[250];
        Otvoren1RNNE: text[250];

        Otvoren2RNDA: text[250];
        MMPreviousExsist: text;
        Otvoren2RNNE: text[250];
        Brojac: Integer;
        ServiceH: Record "Service Header";
        ResOJ: Text[250];
        ILE: Record "Cust. Ledger Entry";
        Licnekarte_niz_stari: Text;
        Licnekarte_niz_novi: Text;
        LK: Record "Customer ID";
        DatumDok: Text[250];
        DatumDoktext: text[250];
        DatumDoktext2: text[250];
        OPUIP: text[250];
        OPUIPText: Text[250];
        Notar: text[250];
        NotarText: text[250];
        Prodavac: Text[250];
        ProdavacText: Text[250];
        KupacStanatext: text[250];

        KupacStana: text[250];
        KoText: text[250];
        KO: text[250];
        Nasljednici: text[250];
        NasljedniciText: text[250];
        Prethodni: text[250];
        Prethodnitext: text[250];
        KpuR: text[250];
        Kputext: text[250];
        i: Integer;
        Charr: Char;
        customer_no: text;
        RazmakAdd: text[2050];


}

