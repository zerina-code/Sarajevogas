report 50218 "Precategory Updat"
{

    PreviewMode = Normal;
    UseRequestPage = true;
    ShowPrintStatus = false;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Data)
                {
                    Caption = 'Data';
                    field(Ihdate; Ihdate)
                    {
                        Caption = 'Ihdate';
                    }

                    field(OldCustomer; OldCustomer)
                    {
                        Caption = 'OldCustomer:';
                        TableRelation = Customer."No.";
                        trigger OnValidate()
                        var
                            myInt: Integer;
                            CusF: Record Customer;
                        begin
                            CusF.Reset();
                            CusF.SetFilter("No.", '%1', OldCustomer);
                            if CusF.FindFirst() then begin
                                if CusF."Customer Category" = CusF."Customer Category"::Household then
                                    OldMM := CusF."No.";
                            end;


                        end;
                    }
                    field(NewCustomer; NewCustomer)
                    {
                        Caption = 'NewCustomer:';

                    }

                    field(OldMM; OldMM)
                    {
                        Caption = 'OldMM:';
                        TableRelation = "Service Item"."No.";
                        trigger OnValidate()
                        var
                            myInt: Integer;
                            ItemS: Record "Service Item";
                        begin
                            ItemS.Reset();
                            ItemS.SetFilter("No.", '%1', OldMM);
                            if ItemS.FindFirst() then
                                OldCustomer := ItemS."Customer No.";
                        end;
                    }
                    field(NewMM; NewMM)
                    {
                        Caption = 'NewMM:';
                    }

                    field(TransferOnlyGauge; TransferOnlyGauge)
                    {
                        Caption = 'TransferOnlyGauge';
                    }


                    field(Logs1; Logs1)
                    {
                        Caption = 'Logs1';
                        trigger OnDrillDown()
                        var
                            Losg: Record Logs;
                            LogsUpdate: Page Logs;
                        begin

                            LogsUpdate.Run();
                        end;
                    }

                }
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        crl.Reset();
        crl.SetFilter("Report ID", '%1', 50218);

        if crl.FindFirst() then begin
            ReportLayoutSelection.SetTempLayoutSelected(crl.Code);
        end;


    end;

    trigger OnPostReport()
    var
        myInt: Integer;
        CUstomerUpdate: Record Customer;
        ServiceItem: Record "Service Item";
        IH: Record "Installation History";
        MMServiceItemUpdateOld: Record "Service Item";
        MMServiceItemUpdateNew: Record "Service Item";
        Gauge: Record Gauge;
        ELVolume: Record "El. Volume Corr";
        RadioMM: Record "Radio Module";
        GaugeRM: Record gauge;
        Ihprevious: Record "Installation History";
        Ihautoincrement: Record "Installation History";
        Increment1: Integer;
        ServiceItemLine: Record "Service Item Line";
        ServiceHeader: Record "Service Header";
        CalcJournal: Record "Calculation Journal Line";
        ControlJournal: Record "Control list";
        DeleteNew: Record Customer;
        MMNewDelete: Record "Service Item";
        ECL: Record "Customer Ledger Entry";
        ServiceItemLog: Record "Service Item Log";
        IHENtry: Record "Installation History";
        EntryAdd: Integer;
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesRelationShip: Record "No. Series Relationship";
        EvaluateStartID: Integer;
        EvaludateEndID: Integer;
        CategoryUpdate: enum Category;
        MMUpdate: enum Category;
        CurrentID: Integer;
        ServiceGet: Record "Service Mgt. Setup";
        ElVolumeGet: Record "El. Volume Corr";
        ServiceF: Record "Service Item";
        rmgET: Record "Radio Module";
        IhLast: Record "Installation History";
        CalcReading: Record "Calculation Journal Line";
        SHExsist: Record "Status History";
        SHMMexsist: Record "Status History MM";
        GaugeExsistAlready: Record Gauge;

    begin
        if OldCustomer <> '' then begin
            CategoryUpdate := CategoryUpdate::" ";
            MMUpdate := MMUpdate::" ";
            SalesSetup.get;
            NoSeriesRelationShip.Reset();
            NoSeriesRelationShip.SetFilter("Code", '%1', SalesSetup."Customer Nos.");
            if NoSeriesRelationShip.FindSet() then
                repeat

                    NoSeriesLine.Reset();
                    NoSeriesLine.SetFilter("Starting Date", '<=%1', Ihdate);
                    NoSeriesLine.SetFilter("Series Code", '%1', NoSeriesRelationShip."Series Code");
                    NoSeriesLine.SetCurrentKey("Starting Date");
                    NoSeriesLine.Ascending;
                    if NoSeriesLine.FindLast() then begin
                        if Evaluate(CurrentID, NewCustomer) then begin
                            Evaluate(EvaluateStartID, NoSeriesLine."Starting No.");
                            if Evaluate(EvaludateEndID, NoSeriesLine."Last No. Used") then begin
                                if (CurrentID >= EvaluateStartID) and (CurrentID <= EvaludateEndID) then begin
                                    NoSeries.Reset();
                                    NoSeries.SetFilter(Code, '%1', NoSeriesLine."Series Code");
                                    if NoSeries.FindFirst() then
                                        CategoryUpdate := NoSeries."Customer Category";
                                end;
                            end
                            else begin
                                //kada nema kraja
                                if (CurrentID >= EvaluateStartID) then begin
                                    NoSeries.Reset();
                                    NoSeries.SetFilter(Code, '%1', NoSeriesLine."Series Code");
                                    if NoSeries.FindFirst() then
                                        CategoryUpdate := NoSeries."Customer Category";

                                end;

                            end;
                        end;
                    end;
                until NoSeriesRelationShip.Next() = 0;
        end;

        if OldMM <> '' then begin
            MMUpdate := MMUpdate::" ";
            ServiceGet.get;
            NoSeriesRelationShip.Reset();
            NoSeriesRelationShip.SetFilter("Code", '%1', ServiceGet."Service Item Nos.");
            if NoSeriesRelationShip.FindSet() then
                repeat

                    NoSeriesLine.Reset();
                    NoSeriesLine.SetFilter("Starting Date", '<=%1', Ihdate);
                    NoSeriesLine.SetFilter("Series Code", '%1', NoSeriesRelationShip."Series Code");
                    NoSeriesLine.SetCurrentKey("Starting Date");
                    NoSeriesLine.Ascending;
                    if NoSeriesLine.FindLast() then begin
                        if Evaluate(CurrentID, NewMM) then begin
                            Evaluate(EvaluateStartID, NoSeriesLine."Starting No.");
                            if Evaluate(EvaludateEndID, NoSeriesLine."Last No. Used") then begin
                                if (CurrentID >= EvaluateStartID) and (CurrentID <= EvaludateEndID) then begin
                                    NoSeries.Reset();
                                    NoSeries.SetFilter(Code, '%1', NoSeriesLine."Series Code");
                                    if NoSeries.FindFirst() then
                                        MMUpdate := NoSeries."Customer Category";
                                end;
                            end
                            else begin
                                //kada nema kraja
                                if (CurrentID >= EvaluateStartID) then begin
                                    NoSeries.Reset();
                                    NoSeries.SetFilter(Code, '%1', NoSeriesLine."Series Code");
                                    if NoSeries.FindFirst() then
                                        MMUpdate := NoSeries."Customer Category";

                                end;

                            end;
                        end;
                    end;
                until NoSeriesRelationShip.Next() = 0;
        end;



        if TransferOnlyGauge = true then begin
            if (OldCustomer = '') or (NewCustomer = '')
            or (OldMM = '') or (NewMM = '') then
                Error('Svi podaci o novom\starom kupcu moraju biti popunjeni!');

            //ovdje ako pokuša prebaciti mjerač, a ovaj kupac već ima neki drugi mjerač aktivan da javi grešku.

            GaugeExsistAlready.Reset();
            GaugeExsistAlready.SetFilter("Customer No.", '%1', NewCustomer);
            GaugeExsistAlready.SetFilter("Measuring Point", '%1', NewMM);
            if GaugeExsistAlready.FindFirst() then begin
                Error('Mjerno mjesto ' + Format(NewMM) + ' kod kupca ' + NewCustomer + ' već ima mjerač ' + GaugeExsistAlready."Inventar number" + ' pa ne možete isti dodijeliti!');
            end;
            Ihautoincrement.Reset();
            Ihautoincrement.SetCurrentKey(Autoincrement);
            Ihautoincrement.Ascending;
            if Ihautoincrement.FindLast() then
                Increment1 := Ihautoincrement.Autoincrement + 1
            else
                Increment1 := 1;



            MMServiceItemUpdateOld.Reset();
            MMServiceItemUpdateOld.SetFilter("No.", '%1', OldMM);
            if MMServiceItemUpdateOld.FindFirst() then begin
                MMServiceItemUpdateNew.Reset();
                MMServiceItemUpdateNew.SetFilter("No.", '%1', NewMM);
                if MMServiceItemUpdateNew.FindFirst() then begin
                    MMServiceItemUpdateNew."Last Reason" := MMServiceItemUpdateOld."Last Reason";
                    MMServiceItemUpdateNew."Measuring point in" := MMServiceItemUpdateOld."Measuring point in";
                    MMServiceItemUpdateNew."Measuring point in Date" := MMServiceItemUpdateOld."Measuring point in Date";
                    MMServiceItemUpdateNew."Measuring point off" := MMServiceItemUpdateOld."Measuring point off";
                    MMServiceItemUpdateNew."Measuring point off Date" := MMServiceItemUpdateOld."Measuring point off Date";



                    MMServiceItemUpdateNew."Reading Mode" := MMServiceItemUpdateOld."Reading Mode";
                    MMServiceItemUpdateNew."Reading Type" := MMServiceItemUpdateOld."Reading Type";
                    MMServiceItemUpdateNew."Type of reading" := MMServiceItemUpdateOld."Type of reading";
                    MMServiceItemUpdateNew."Reading Time" := MMServiceItemUpdateOld."Reading Time";
                    MMServiceItemUpdateNew."Method of calculation" := MMServiceItemUpdateOld."Method of calculation";
                    MMServiceItemUpdateNew."Posting GAS" := MMServiceItemUpdateOld."Posting GAS";
                    MMServiceItemUpdateNew."Posting" := MMServiceItemUpdateOld."Posting";
                    MMServiceItemUpdateNew."Distribution" := MMServiceItemUpdateOld."Distribution";
                    MMServiceItemUpdateNew."Distribution - read" := MMServiceItemUpdateOld."Distribution - read";
                    MMServiceItemUpdateNew."Specification" := MMServiceItemUpdateOld."Specification";
                    MMServiceItemUpdateNew."RMS Maintenance" := MMServiceItemUpdateOld."RMS Maintenance";
                    MMServiceItemUpdateNew."Remotely" := MMServiceItemUpdateOld."Remotely";
                    MMServiceItemUpdateNew."Remotely Type" := MMServiceItemUpdateOld."Remotely Type";
                    MMServiceItemUpdateNew."Mobile No." := MMServiceItemUpdateOld."Mobile No.";
                    MMServiceItemUpdateNew."Bill delivery" := MMServiceItemUpdateNew."Bill delivery"::Monthly;
                    MMServiceItemUpdateNew."Reading Time" := MMServiceItemUpdateNew."Reading Time"::"Per Month";
                    MMServiceItemUpdateNew.Modify();
                end;

            end;

            IHENtry.Reset();
            IHENtry.SetFilter("Measuring Point Code", '%1', OldMM);
            IHENtry.SetFilter(Active, '%1', true);
            //IHENtry.SetFilter(Type,'%1',IHENtry.Type::Gauge);
            if IHENtry.FindSet() then
                repeat

                    MMmore.Reset();
                    MMmore.SetFilter("Customer No.", '%1', OldCustomer);
                    MMmore.SetFilter("No.", '<>%1', OldMM);
                    MMmore.SetFilter("Status MM", '%1', MMmore."Status MM"::Active);
                    if not MMmore.FindFirst() then begin
                        //trajano neaktivno kupca
                        SHPrev.Reset();
                        SHPrev.SetFilter("Customer No.", '%1', OldCustomer);
                        SHPrev.SetFilter(Active, '%1', true);
                        if SHPrev.FindFirst() then begin

                            SH.Init();
                            SH.Validate("Customer No.", OldCustomer);
                            sh.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                            sh."Source Table" := 18;
                            sh.validate(Active, true);
                            SHExsist.Reset();
                            SHExsist.SetFilter("Customer No.", '%1', OldCustomer);
                            SHExsist.SetFilter("Information of processing", '%1', SHExsist."Information of processing"::"Permanently inactive");
                            SHExsist.SetFilter(Active, '%1', true);
                            SHExsist.SetFilter("Source Table", '%1', 18);
                            if not SHExsist.FindFirst() then begin

                                SHLast.Reset();
                                SHLast.SetFilter("Customer No.", '%1', OldCustomer);
                                SHLast.SetCurrentKey(Integer);
                                SHLast.Ascending;
                                if SHLast.FindLast() then
                                    SH.Integer := SHLast.Integer + 1
                                else
                                    SH.Integer := 1;

                                SH.Insert();
                                SHPrev.Active := false;
                                SHPrev.modify;
                            end;
                        end;

                    end;

                    //sad ću još provjeriti da li ovaj stari ima mjerač 



                    SHMMPrev.Reset();
                    //samo mm stavljam u trajno neaktivno
                    SHMMPrev.SetFilter("Measuring Point", '%1', OldMM);
                    SHMMPrev.SetFilter(Active, '%1', true);
                    if SHMMPrev.FindFirst() then begin



                        SHMM.Init();
                        SHMM.Validate("Measuring Point", OldMM);
                        SHMM.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                        SHMM."Source Table" := 5940;
                        SHMM.validate(Active, true);
                        SHMMexsist.Reset();
                        SHMMexsist.SetFilter("Measuring Point", '%1', OldMM);
                        SHMMexsist.SetFilter("Information of processing", '%1', SHMMexsist."Information of processing"::"Permanently inactive");
                        SHMMexsist.SetFilter(Active, '%1', true);
                        SHMMexsist.SetFilter("Source Table", '%1', 5940);
                        if not SHMMexsist.FindFirst() then begin

                            SHLastMM.Reset();
                            SHLastMM.SetFilter("Measuring Point", OldMM);
                            SHLastMM.SetCurrentKey(Integer);
                            SHLastMM.Ascending;
                            if SHLastMM.FindLast() then
                                SHMM.Integer := SHLastMM.Integer + 1
                            else
                                SHMM.Integer := 1;

                            SHMM.Insert();
                            SHMMPrev.Active := false;
                            SHMMPrev.Modify();
                        end;
                    end;




                    //samo promjena (ovdje je 2 puta ušao)

                    IH.Init();
                    ih.TransferFields(IHENtry);


                    //prebacio 
                    CalcReading.Reset();
                    CalcReading.SetFilter("Measuring Point Code", '%1', OldMM);
                    CalcReading.SetFilter(Gauge, '%1', IHENtry.code);
                    CalcReading.SetCurrentKey("New Value");
                    CalcReading.Ascending;
                    if CalcReading.FindLast() then begin
                        if IHENtry.Reading < (CalcReading."New Value") then begin
                            IHENtry.Reading := CalcReading."New Value";
                            IHENtry."Date of consumption" := CalcReading."Reading Date To";
                        end;
                    end;
                    ih.Autoincrement := Increment1;
                    if NewCustomer <> '' then begin
                        ih."Customer No." := NewCustomer;


                        ih.Validate("Customer No.", NewCustomer);
                    end;
                    ih."Measuring Point Code" := NewMM;
                    ih.Validate("Measuring Point Code", NewMM);
                    ih."Installation Date" := Ihdate;
                    //     ih.Type := ih.Type::Gauge;
                    ih.Insert();
                    IHENtry."Dismantling date" := Ihdate;
                    IHENtry.Active := false;
                    IHENtry.Modify();
                    if IHENtry.Type = IHENtry.Type::Corrector then begin
                        ServiceF.Reset();
                        ServiceF.SetFilter("No.", '%1', NewMM);
                        if ServiceF.FindFirst() then
                            //preimenuj korektor module
                            ElVolume.Reset();
                        ElVolume.SetFilter(Code, '%1', IHENtry.code);
                        if ElVolume.FindFirst() then begin
                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                            then
                                ElVolumeGet.rename(IHENtry.code, NewMM, NewCustomer, ServiceF."Address MM");
                        end;
                    end;
                    if IHENtry.Type = IHENtry.Type::Radio_Module then begin

                        IF rmgET.GET(IHENtry.CODE, rmgET."Gauge Code", IHENtry."Measuring Point Code") THEN BEGIN
                            rmgET.RENAME(IHENtry.CODE, rmgET."Gauge Code", NewMM);

                        end;
                    end;
                    if IHENtry.Type = IHENtry.Type::Gauge then begin
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', OldMM);
                        if Gauge.FindFirst() then begin
                            // key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
                            if OldCustomer <> '' then begin
                                if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                                then begin
                                    GaugeRM.Rename(Gauge.Code, NewMM, NewCustomer, ServiceItem."Address MM");
                                    GaugeRM."Gauge Category" := MMUpdate;
                                    GaugeRM."Customer Category" := CategoryUpdate;
                                    if GaugeRM."Gauge Category" = GaugeRM."Gauge Category"::" " then begin
                                        CustCategoryF.Reset();
                                        CustCategoryF.SetFilter("No.", '%1', NewCustomer);
                                        if CustCategoryF.FindFirst() then begin
                                            GaugeRM."Gauge Category" := CustCategoryF."Customer Category";
                                            GaugeRM."Customer Category" := CustCategoryF."Customer Category";
                                        end;
                                    end;
                                    GaugeRM.Modify;
                                end;
                            end
                            else begin
                                if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                               then begin
                                    GaugeRM.Rename(Gauge.Code, NewMM, Gauge."Customer No.", ServiceItem."Address MM");
                                    GaugeRM."Gauge Category" := MMUpdate;
                                    GaugeRM."Customer Category" := CategoryUpdate;

                                    if GaugeRM."Gauge Category" = GaugeRM."Gauge Category"::" " then begin
                                        CustCategoryF.Reset();
                                        CustCategoryF.SetFilter("No.", '%1', Gauge."Customer No.");
                                        if CustCategoryF.FindFirst() then begin
                                            GaugeRM."Gauge Category" := CustCategoryF."Customer Category";
                                            GaugeRM."Customer Category" := CustCategoryF."Customer Category";
                                        end;
                                    end;

                                    GaugeRM.Modify;
                                end;
                            end;
                        end;
                    end;

                until IHENtry.Next() = 0;

            //ovdje sam dodam i status kupca


            SHPrev.Reset();
            SHPrev.SetFilter("Customer No.", '%1', NewCustomer);
            SHPrev.SetFilter(Active, '%1', true);
            if SHPrev.FindFirst() then begin

                SH.Init();
                SH.Validate("Customer No.", NewCustomer);
                sh.Validate("Information of processing", sh."Information of processing"::Active);
                sh."Source Table" := 18;
                sh.validate(Active, true);
                SHExsist.Reset();
                SHExsist.SetFilter("Customer No.", '%1', NewCustomer);
                SHExsist.SetFilter("Information of processing", '%1', SHExsist."Information of processing"::Active);
                SHExsist.SetFilter(Active, '%1', true);
                SHExsist.SetFilter("Source Table", '%1', 18);
                if not SHExsist.FindFirst() then begin

                    SHLast.Reset();
                    SHLast.SetFilter("Customer No.", '%1', NewCustomer);
                    SHLast.SetCurrentKey(Integer);
                    SHLast.Ascending;
                    if SHLast.FindLast() then
                        SH.Integer := SHLast.Integer + 1
                    else
                        SH.Integer := 1;

                    SH.Insert();
                    SHPrev.Active := false;
                    SHPrev.modify;
                end;
            end;


            SHMMPrev.Reset();
            //samo mm stavljam u trajno neaktivno
            SHMMPrev.SetFilter("Measuring Point", '%1', NewMM);
            SHMMPrev.SetFilter(Active, '%1', true);
            if SHMMPrev.FindFirst() then begin



                SHMM.Init();
                SHMM.Validate("Measuring Point", NewMM);
                SHMM.Validate("Information of processing", sh."Information of processing"::Active);
                SHMM."Source Table" := 5940;
                SHMM.validate(Active, true);
                SHMMexsist.Reset();
                SHMMexsist.SetFilter("Measuring Point", '%1', NewMM);
                SHMMexsist.SetFilter("Information of processing", '%1', SHMMexsist."Information of processing"::Active);
                SHMMexsist.SetFilter(Active, '%1', true);
                SHMMexsist.SetFilter("Source Table", '%1', 5940);
                if not SHMMexsist.FindFirst() then begin

                    SHLastMM.Reset();
                    SHLastMM.SetFilter("Measuring Point", NewMM);
                    SHLastMM.SetCurrentKey(Integer);
                    SHLastMM.Ascending;
                    if SHLastMM.FindLast() then
                        SHMM.Integer := SHLastMM.Integer + 1
                    else
                        SHMM.Integer := 1;

                    SHMM.Insert();
                    SHMMPrev.Active := false;
                    SHMMPrev.Modify();
                end;
            end;

            //sad ću još provjeriti da li ovaj stari ima mjerač 

            //kraj









        end
        else begin

            if NewCustomer <> '' then begin
                DeleteNew.Reset();
                DeleteNew.SetFilter("No.", '%1', NewCustomer);
                if DeleteNew.FindFirst() then begin
                    if DeleteNew.Name = '' then begin
                        DeleteNew.Delete();
                        Commit();
                    end;
                end;
            end;
            if NewMM <> '' then begin
                MMNewDelete.Reset();
                MMNewDelete.SetFilter("No.", '%1', NewMM);
                if MMNewDelete.FindFirst() then begin
                    if MMNewDelete.Name = '' then begin
                        MMNewDelete.Delete();
                        Commit();
                        ServiceItemLog.Reset();
                        ServiceItemLog.SetFilter("Service Item No.", '%1', NewMM);
                        if ServiceItemLog.FindSet() then
                            repeat
                                ServiceItemLog.Delete();
                                Commit();
                            until ServiceItemLog.Next() = 0;
                    end;
                end;
            end;


            Ihautoincrement.Reset();
            Ihautoincrement.SetCurrentKey(Autoincrement);
            Ihautoincrement.Ascending;
            if Ihautoincrement.FindLast() then
                Increment1 := Ihautoincrement.Autoincrement + 1
            else
                Increment1 := 1;

            if OldMM <> '' then begin

                ControlJournal.Reset();
                ControlJournal.SetFilter("MM previous", '%1', '');
                ControlJournal.SetFilter("Measuring Point Code", '%1', OldMM);
                if ControlJournal.FindSet() then
                    repeat
                        ControlJournal."MM previous" := OldMM;
                        ControlJournal."Category MM" := MMUpdate;
                        ControlJournal.Modify();
                    until ControlJournal.Next() = 0;
            end;

            if OldCustomer <> '' then begin
                ControlJournal.Reset();
                ControlJournal.SetFilter("Customer No. previous", '%1', '');
                ControlJournal.SetFilter("Customer No.", '%1', OldCustomer);
                if ControlJournal.FindSet() then
                    repeat
                        ControlJournal."Customer No. previous" := OldCustomer;
                        ControlJournal."Category Customer" := CategoryUpdate;
                        ControlJournal.Modify();
                    until ControlJournal.Next() = 0;

            end;


            if OldCustomer <> '' then begin
                ECL.Reset();
                ECL.SetFilter("Customer No. previous", '%1', '');
                ECL.SetFilter("Customer No.", '%1', OldCustomer);
                if ECL.FindSet() then
                    repeat
                        ECL."Customer No. previous" := OldCustomer;
                        if OldMM <> '' then
                            ecl."MM previous" := OldMM;
                        ecl."Customer Category" := CategoryUpdate;
                        ECL.Modify();
                    until ECL.Next() = 0;

            end;
            if OldMM <> '' then begin
                ServiceItemLine.Reset();
                ServiceItemLine.SetFilter("Service Item No. - Relation", '%1', OldMM);
                ServiceItemLine.SetFilter("MM previous", '%1', '');
                if ServiceItemLine.FindSet() then
                    repeat
                        ServiceItemLine."MM previous" := OldMM;
                        ServiceItemLine."MM Category" := MMUpdate;

                        ServiceItemLine.Modify();
                    until ServiceItemLine.Next() = 0;
            end;
            if OldMM <> '' then begin
                CalcJournal.Reset();
                CalcJournal.SetFilter("MM previous", '%1', '');
                CalcJournal.SetFilter("Measuring Point Code", '%1', OldMM);
                if CalcJournal.FindSet() then
                    repeat
                        CalcJournal."MM previous" := OldMM;
                        CalcJournal."Category MM" := MMUpdate;
                        CalcJournal.Modify();
                    until CalcJournal.Next() = 0;
            end;
            if OldCustomer <> '' then begin
                CalcJournal.Reset();
                CalcJournal.SetFilter("Customer No. previous", '%1', '');
                CalcJournal.SetFilter("Customer No.", '%1', OldCustomer);
                if CalcJournal.FindSet() then
                    repeat
                        CalcJournal."Customer No. previous" := OldCustomer;
                        CalcJournal."Category Customer" := CategoryUpdate;
                        CalcJournal.Modify();
                    until CalcJournal.Next() = 0;

            end;


            if OldCustomer <> '' then begin

                ServiceHeader.Reset();
                ServiceHeader.SetFilter("Customer No.", '%1', OldCustomer);
                ServiceHeader.SetFilter("Customer No. previous", '%1', '');

                if ServiceHeader.FindSet() then
                    repeat
                        ServiceHeader."Customer No. previous" := OldCustomer;
                        ServiceHeader."Customer Category" := CategoryUpdate;
                        ServiceHeader.Modify();

                    until ServiceHeader.Next() = 0;

            end;



            if OldMM <> '' then begin


                if ServiceItem.get(OldMM) then begin
                    Gauge.Reset();
                    Gauge.SetFilter("Measuring Point", '%1', OldMM);
                    if Gauge.FindFirst() then begin
                        // key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
                        if OldCustomer <> '' then begin
                            if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                            then
                                GaugeRM.Rename(Gauge.Code, NewMM, NewCustomer, ServiceItem."Address MM");
                        end

                        else begin
                            if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                      then
                                GaugeRM.Rename(Gauge.Code, NewMM, Gauge."Customer No.", ServiceItem."Address MM");

                        end;

                        if OldCustomer <> '' then begin
                            Ihprevious.Reset();
                            Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Gauge);
                            Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                            Ihprevious.SetFilter(Active, '%1', true);
                            if Ihprevious.FindFirst() then begin

                                /* IH.Init();
                                 ih.TransferFields(Ihprevious);
                                 ih.Autoincrement := Increment1;

                                 ih.Validate("Customer No.", OldCustomer);
                                 ih.Validate("Measuring Point Code", OldMM);
                                 ih."Customer No." := NewCustomer;
                                 ih."Measuring Point Code" := NewMM;
                                 ih."Installation Date" := Ihdate;
                                 ih.Type := ih.Type::Gauge;


                                 Ihprevious.Reset();
                                 Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Gauge);
                                 Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                                 Ihprevious.SetFilter("Customer No. previous", '%1', '');*/

                                if Ihprevious.FindSet() then
                                    repeat
                                        Ihprevious."Customer No. previous" := OldCustomer;
                                        Ihprevious."Customer Category" := CategoryUpdate;
                                        Ihprevious."Customer Category Filter" := CategoryUpdate;
                                        if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"KJKP Heating plant" then
                                            Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                        if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"Special Customer" then
                                            Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                        if Ihprevious."Customer Category" = Ihprevious."Customer Category"::CNG then
                                            Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";



                                        Ihprevious.Modify;
                                    until Ihprevious.Next() = 0;

                                if OldMM <> '' then begin
                                    Ihprevious.Reset();
                                    Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Gauge);
                                    Ihprevious.SetFilter("MM previous", '%1', '');
                                    Ihprevious.SetFilter("Measuring Point Code", '%1', OldMM);

                                    if Ihprevious.FindSet() then
                                        repeat
                                            Ihprevious."MM previous" := OldMM;

                                            Ihprevious.Modify;
                                        until Ihprevious.Next() = 0;
                                end;


                                //   IH.Insert();
                            end;

                        end;

                    end;

                end;
            end;

            //korektori

            if OldMM <> '' then begin

                ELVolume.Reset();
                ELVolume.SetFilter("Measuring Point", '%1', OldMM);
                if ELVolume.FindFirst() then begin
                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
                    if NewCustomer <> '' then begin
                        if ELVolume.get(ELVolume.Code, ELVolume."Measuring Point", ELVolume."Customer No.", ELVolume."Address MM")
                        then
                            ELVolume.Rename(ELVolume.Code, NewMM, NewCustomer, ServiceItem."Address MM");
                    end

                    else begin
                        if ELVolume.get(ELVolume.Code, ELVolume."Measuring Point", ELVolume."Customer No.", ELVolume."Address MM")
                                            then
                            ELVolume.Rename(ELVolume.Code, NewMM, ELVolume."Customer No.", ServiceItem."Address MM");

                    end;
                    if OldCustomer <> '' then begin
                        Ihprevious.Reset();
                        Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Corrector);
                        Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                        Ihprevious.SetFilter("Customer No. previous", '%1', '');

                        if Ihprevious.FindSet() then
                            repeat
                                Ihprevious."Customer No. previous" := OldCustomer;
                                Ihprevious."Customer Category" := CategoryUpdate;
                                Ihprevious."Customer Category Filter" := CategoryUpdate;
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"KJKP Heating plant" then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"Special Customer" then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::CNG then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";


                                Ihprevious.Modify;
                            until Ihprevious.Next() = 0;
                    end;
                    Ihprevious.Reset();
                    Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Corrector);
                    Ihprevious.SetFilter("MM previous", '%1', '');
                    Ihprevious.SetFilter("Measuring Point Code", '%1', OldMM);

                    if Ihprevious.FindSet() then
                        repeat
                            Ihprevious."MM previous" := OldMM;
                            Ihprevious.Modify;
                        until Ihprevious.Next() = 0;
                    if OldCustomer <> '' then begin
                        Ihprevious.Reset();
                        Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Corrector);
                        Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                        Ihprevious.SetFilter("Measuring Point Code", '%1', OldMM);
                        Ihprevious.SetFilter(Active, '%1', true);
                        if Ihprevious.FindFirst() then begin
                            /*  Ihprevious.validate("Dismantling date", Ihdate);
                              Ihprevious.Active := false;
                              Ihprevious.modify;
                              IH.Init();
                              ih.TransferFields(Ihprevious);
                              ih.Autoincrement := Increment1 + 1;
                              ih.Validate("Customer No.", OldCustomer);
                              ih.Validate("Measuring Point Code", OldMM);
                              ih."Customer No." := NewCustomer;
                              ih."Measuring Point Code" := NewMM;
                              ih."Installation Date" := Ihdate;
                              ih.Type := ih.Type::Corrector;
      */

                            //   IH.Insert();
                        end;
                    end;
                end;
                //


                //radiomoduli

                RadioMM.Reset();
                RadioMM.SetFilter("Measuring Point Code", '%1', OldMM);
                if RadioMM.FindFirst() then begin
                    //  key( key(Key1; Code, "Gauge Code", "Measuring Point Code")
                    if RadioMM.get(RadioMM.Code, RadioMM."Gauge Code", RadioMM."Measuring Point Code")
                    then
                        RadioMM.Rename(RadioMM.Code, RadioMM."Gauge Code", NewMM);

                    if OldCustomer <> '' then begin
                        Ihprevious.Reset();
                        Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Radio_Module);
                        Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                        Ihprevious.SetFilter("Customer No. previous", '%1', '');

                        if Ihprevious.FindSet() then
                            repeat
                                Ihprevious."Customer No. previous" := OldCustomer;
                                Ihprevious."Customer Category" := CategoryUpdate;
                                Ihprevious."Customer Category Filter" := CategoryUpdate;
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"KJKP Heating plant" then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::"Special Customer" then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";
                                if Ihprevious."Customer Category" = Ihprevious."Customer Category"::CNG then
                                    Ihprevious."Customer Category Filter" := Ihprevious."Customer Category"::"Large Economy";


                                Ihprevious.Modify;
                            until Ihprevious.Next() = 0;
                    end;
                    Ihprevious.Reset();
                    Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Radio_Module);
                    Ihprevious.SetFilter("MM previous", '%1', '');
                    Ihprevious.SetFilter("Measuring Point Code", '%1', OldMM);

                    if Ihprevious.FindSet() then
                        repeat
                            Ihprevious."MM previous" := OldMM;
                            Ihprevious.Modify;
                        until Ihprevious.Next() = 0;
                    if OldCustomer <> '' then begin
                        Ihprevious.Reset();
                        Ihprevious.SetFilter(Type, '%1', Ihprevious.Type::Radio_Module);
                        Ihprevious.SetFilter("Customer No.", '%1', OldCustomer);
                        Ihprevious.SetFilter("Measuring Point Code", '%1', OldMM);
                        Ihprevious.SetFilter(Active, '%1', true);
                        if Ihprevious.FindFirst() then begin
                            /* Ihprevious.validate("Dismantling date", Ihdate);
                             Ihprevious.Active := false;
                             Ihprevious.modify;
                             IH.Init();
                             ih.TransferFields(Ihprevious);
                             ih.Autoincrement := Increment1 + 2;
                             ih.Validate("Customer No.", OldCustomer);
                             ih.Validate("Measuring Point Code", OldMM);
                             ih."Customer No." := NewCustomer;
                             ih."Measuring Point Code" := NewMM;
                             ih."Installation Date" := Ihdate;
                             ih.Type := ih.Type::Radio_Module;*/
                            //    IH.Insert();
                        end;
                    end;
                end;
                //

            end;


            if OldCustomer <> '' then begin
                if CUstomerUpdate.get(OldCustomer) then begin


                    CUstomerUpdate.Rename(NewCustomer);

                    SHPrev.Reset();
                    SHPrev.SetFilter("Customer No.", '%1', OldCustomer);
                    SHPrev.SetFilter("Customer No. previous", '%1', '');
                    if SHPrev.FindSet() then
                        repeat
                            SHPrev."Customer No. previous" := OldCustomer;
                            SHPrev.Modify();
                        until SHPrev.Next() = 0;


                    SHPrev.Reset();
                    SHPrev.SetFilter("Customer No.", '%1', OldCustomer);
                    SHPrev.SetFilter(Active, '%1', true);
                    if SHPrev.FindFirst() then begin
                        SHPrev.Active := false;
                        SHPrev.modify;
                        SH.Init();
                        SH.Validate("Customer No.", NewCustomer);
                        sh.Validate("Information of processing", SHPrev."Information of processing");
                        sh."Source Table" := 18;
                        sh.validate(Active, true);

                        SHLast.Reset();
                        SHLast.SetFilter("Customer No.", '%1', NewCustomer);
                        SHLast.SetCurrentKey(Integer);
                        SHLast.Ascending;
                        if SHLast.FindLast() then
                            sh.Integer := SHLast.Integer + 1
                        else
                            sh.Integer := 1;

                        SH.Insert();
                    end;

                end;

            end;

            if OldMM <> '' then begin

                if ServiceItem.get(OldMM) then begin
                    ServiceItem.Rename(NewMM);

                    SHMMPrev.Reset();
                    SHMMPrev.SetFilter("Measuring Point", '%1', OldMM);
                    SHMMPrev.SetFilter("MM previous", '%1', '');
                    if SHMMPrev.FindSet() then
                        repeat
                            SHMMPrev."MM previous" := OldMM;
                            SHMMPrev.Modify();
                        until SHMMPrev.Next() = 0;



                    SHMMPrev.Reset();
                    SHMMPrev.SetFilter("Measuring Point", '%1', OldMM);
                    SHMMPrev.SetFilter(Active, '%1', true);
                    if SHMMPrev.FindFirst() then begin
                        SHMMPrev.Active := false;
                        SHMMPrev.modify;
                        SH.Init();
                        SH.Validate("Measuring Point", NewMM);
                        sh.Validate("Information of processing", SHMMPrev."Information of processing");
                        sh."Source Table" := 5940;
                        sh.validate(Active, true);

                        SHLastMM.Reset();
                        SHLastMM.SetFilter("Measuring Point", NewMM);
                        SHLastMM.SetCurrentKey(Integer);
                        SHLastMM.Ascending;
                        if SHLastMM.FindLast() then
                            SH.Integer := SHLastMM.Integer + 1
                        else
                            SH.Integer := 1;

                        SH.Insert();
                    end;
                end;
            end;

            Logs.Init();
            Logs."MM Old" := OldMM;
            Logs."MM New" := NewMM;
            Logs."Customer Old" := OldCustomer;
            Logs."Customer New" := NewCustomer;
            Logs.Insert();

            /*  if (OldCustomer <> '') and (OldMM <> '') then begin
                  MMmore.Reset();
                  MMmore.SetFilter("Customer No.", '%1', OldCustomer);
                  MMmore.SetFilter("No.", '<>%1', OldMM);
                  MMmore.SetFilter("Status MM", '%1', MMmore."Status MM"::Active);
                  if not MMmore.FindFirst() then begin
                      SHMMPrev.Reset();
                      //samo mm stavljam u trajno neaktivno
                      SHMMPrev.SetFilter("Measuring Point", '%1', OldMM);
                      SHMMPrev.SetFilter(Active, '%1', true);
                      if SHMMPrev.FindFirst() then begin
                          SHMMPrev.Active := false;
                          SHMMPrev.Modify();
                          SH.Init();
                          SH.Validate("Measuring Point", OldMM);
                          sh.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                          sh."Source Table" := 5940;
                          sh.validate(Active, true);
                          SH.Insert();
                      end;

                  end
                  else begin
                      //sad ću još provjeriti da li ovaj stari ima mjerač 
                      GaugeE.Reset();
                      GaugeE.SetFilter("Customer No.", '%1', OldCustomer);
                      GaugeE.SetFilter("Measuring Point", '%1', OldMM);
                      if not GaugeE.FindFirst() then begin
                          //ovdje dodijeliti vrijednost trajno neaktiivan za staro mm i starog kupca

                          //ovo bi bio status starog MM
                          SHMMPrev.Reset();
                          SHMMPrev.SetFilter("Measuring Point", '%1', OldMM);
                          SHMMPrev.SetFilter(Active, '%1', true);
                          if SHMMPrev.FindFirst() then begin
                              SHMMPrev.Active := false;
                              SHMMPrev.Modify();
                              SH.Init();
                              SH.Validate("Measuring Point", OldMM);
                              sh.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                              sh."Source Table" := 5940;
                              sh.validate(Active, true);
                              SH.Insert();
                          end;


                          SHPrev.Reset();
                          SHPrev.SetFilter("Customer No.", '%1', OldCustomer);
                          SHPrev.SetFilter(Active, '%1', true);
                          if SHPrev.FindFirst() then begin
                              SHPrev.Active := false;
                              SHPrev.modify;
                              SH.Init();
                              SH.Validate("Customer No.", OldCustomer);
                              sh.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                              sh."Source Table" := 18;
                              sh.validate(Active, true);
                              SH.Insert();
                          end;

                      end;
                  end;
              end;*/
        end;
    end;





    trigger OnInitReport()
    var
        myInt: Integer;
        us: Record "User Setup";
    begin

        CRL.reset;
        crl.SetFilter("Report ID", '%1', 50218);
        if crl.findfirst then begin
            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

        end;

        Ihdate := WorkDate();
        TransferOnlyGauge := true;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            NewCustomer := us.NewCust;
            NewMM := us.NewMM;
        end;


    end;


    var
        OldCustomer: code[20];

        MMmore: Record "Service Item";
        CustCategoryF: Record Customer;

        SHLast: Record "Status History";
        SHLastMM: Record "Status History MM";
        NewCustomer: code[20];
        AppliedbyNoSeriesCust: Boolean;
        GaugeE: Record Gauge;
        AppliedbyNoSeriesMM: Boolean;

        NewMM: code[20];
        OldMM: code[20];
        Ihdate: Date;
        Logs: Record Logs;
        SH: Record "Status History";
        SHMM: Record "Status History MM";

        SHPrev: Record "Status History";
        Logs1: Integer;
        SHMMPrev: Record "Status History MM";

        TransferOnlyGauge: Boolean;
        UpdateCustomer: Boolean;
        CRL: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
}
