xmlport 50050 "UpdateAll"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'UpdateAll';
    UseRequestPage = false;
    //ovo bi bilo samo da preimenujemo šifre, bez da radimo prekategorizaciju.


    schema
    {


        textelement(Root)
        {
            tableelement("Service Item"; "Service Item")
            {
                AutoSave = false;
                MinOccurs = Zero;
                XmlName = 'Calculation_Journal_Line';
                UseTemporary = false;
                textelement(StaraSifraMM)
                {
                    MinOccurs = Zero;
                }
                textelement(NovaSifraMM)
                {
                    MinOccurs = Zero;
                }
                textelement(StaraSifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(NovaSifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(AzurirajSamoKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(AzuriraajSamoMM)
                {
                    MinOccurs = Zero;
                }
                textelement(DatumPrekategorizacije)
                {

                }
                trigger OnAfterInsertRecord()
                var
                    CalJ: Record "Calculation Journal Line";
                    MobI: Integer;
                    NewDecimal: Decimal;
                    DifA: Decimal;
                    DateD: Date;
                    DateP: Date;
                    RF: Decimal;
                    IntCus: Integer;
                    CUstomerUpdate: record "Customer";
                    ServiceItem: Record "Service Item";
                    Ihautoincrement: Record "Installation History";
                    Increment1: Integer;
                    IHENtry: Record "Installation History";
                    NoSeries: Record "No. Series";
                    NoSeriesLine: Record "No. Series Line";
                    SalesSetup: Record "Sales & Receivables Setup";
                    NoSeriesRelationShip: Record "No. Series Relationship";
                    EvaluateStartID: Integer;
                    EvaludateEndID: Integer;
                    ServiceGet: Record "Service Mgt. Setup";
                    CurrentID: Integer;
                    MMmore: Record "Service Item";
                    SHPrev: Record "Status History";
                    SH: Record "Status History";
                    SHMMPrev: Record "Status History MM";
                    SHMM: Record "Status History MM";
                    IH: Record "Installation History";
                    DatumPrekategorizacijeD: date;
                    ServiceF: Record "Service Item";
                    ELVolume: Record "El. Volume Corr";
                    ElVolumeGet: Record "El. Volume Corr";
                    rmgET: Record "Radio Module";
                    Gauge: Record Gauge;
                    GaugeRM: Record gauge;
                    CategoryUpdate: enum Category;
                    MMUpdate: enum Category;
                begin

                    if UpdateGauge = false then begin

                        if AzuriraajSamoMM = 'DA' then begin
                            if (StaraSifraMM <> '') and (NovaSifraMM <> '') then begin
                                if ServiceItem.get(StaraSifraMM) then begin
                                    ServiceItem.Rename(NovaSifraMM);

                                end;

                            end;

                        end;


                        if AzurirajSamoKupca = 'DA' then begin
                            if (StaraSifraKupca <> '') and (NovaSifraKupca <> '') then begin
                                if CUstomerUpdate.get(StaraSifraKupca) then begin


                                    CUstomerUpdate.Rename(NovaSifraKupca);

                                end;
                            end;
                        end;

                        if (AzuriraajSamoMM = 'NE') and (AzurirajSamoKupca = 'NE') then begin

                            if (StaraSifraMM <> '') and (NovaSifraMM <> '') and (StaraSifraKupca <> '') and (NovaSifraKupca <> '') then begin

                                if ServiceItem.get(StaraSifraMM) then
                                    ServiceItem.Rename(NovaSifraMM);

                                if CUstomerUpdate.get(StaraSifraKupca) then
                                    CUstomerUpdate.Rename(NovaSifraKupca);

                            end;
                        end;



                    end;


                    if UpdateGauge = true then begin

                        Ihautoincrement.Reset();
                        Ihautoincrement.SetCurrentKey(Autoincrement);
                        Ihautoincrement.Ascending;
                        if Ihautoincrement.FindLast() then
                            Increment1 := Ihautoincrement.Autoincrement + 1
                        else
                            Increment1 := 1;

                        CategoryUpdate := CategoryUpdate::" ";
                        MMUpdate := MMUpdate::" ";
                        ServiceGet.get;
                        NoSeriesRelationShip.Reset();
                        NoSeriesRelationShip.SetFilter("Code", '%1', ServiceGet."Service Item Nos.");
                        if NoSeriesRelationShip.FindSet() then
                            repeat

                                NoSeriesLine.Reset();
                                if Evaluate(DatumPrekategorizacijeD, DatumPrekategorizacije) then
                                    NoSeriesLine.SetFilter("Starting Date", '<=%1', DatumPrekategorizacijeD)
                                else
                                    NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
                                NoSeriesLine.SetFilter("Series Code", '%1', NoSeriesRelationShip."Series Code");
                                NoSeriesLine.SetCurrentKey("Starting Date");
                                NoSeriesLine.Ascending;
                                if NoSeriesLine.FindLast() then begin
                                    if Evaluate(CurrentID, NovaSifraMM) then begin
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


                        SalesSetup.get;
                        NoSeriesRelationShip.Reset();
                        NoSeriesRelationShip.SetFilter("Code", '%1', SalesSetup."Customer Nos.");
                        if NoSeriesRelationShip.FindSet() then
                            repeat

                                NoSeriesLine.Reset();
                                if Evaluate(DatumPrekategorizacijeD, DatumPrekategorizacije) then
                                    NoSeriesLine.SetFilter("Starting Date", '<=%1', DatumPrekategorizacijeD)
                                else
                                    NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
                                NoSeriesLine.SetFilter("Series Code", '%1', NoSeriesRelationShip."Series Code");
                                NoSeriesLine.SetCurrentKey("Starting Date");
                                NoSeriesLine.Ascending;
                                if NoSeriesLine.FindLast() then begin
                                    if Evaluate(CurrentID, NovaSifraKupca) then begin
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


                        IHENtry.Reset();
                        IHENtry.SetFilter("Measuring Point Code", '%1', StaraSifraMM);
                        IHENtry.SetFilter(Active, '%1', true);
                        //IHENtry.SetFilter(Type,'%1',IHENtry.Type::Gauge);
                        if IHENtry.FindSet() then
                            repeat

                                MMmore.Reset();
                                MMmore.SetFilter("Customer No.", '%1', StaraSifraKupca);
                                MMmore.SetFilter("No.", '<>%1', StaraSifraMM);
                                MMmore.SetFilter("Status MM", '%1', MMmore."Status MM"::Active);
                                if not MMmore.FindFirst() then begin
                                    //trajano neaktivno kupca
                                    SHPrev.Reset();
                                    SHPrev.SetFilter("Customer No.", '%1', StaraSifraKupca);
                                    SHPrev.SetFilter(Active, '%1', true);
                                    if SHPrev.FindFirst() then begin

                                        SH.Init();
                                        SH.Validate("Customer No.", StaraSifraKupca);
                                        sh.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                                        sh."Source Table" := 18;
                                        sh.validate(Active, true);
                                        SHLast.Reset();
                                        SHLast.SetFilter("Customer No.", '%1', StaraSifraKupca);
                                        SHLast.SetCurrentKey(Integer);

                                        SHLast.Ascending;
                                        if SHLast.FindLast() then
                                            sh.Integer := SHLast.Integer + 1
                                        else
                                            sh.Integer := 1;

                                        SH.Insert();
                                        SHPrev.Active := false;
                                        SHPrev.modify;
                                    end;

                                end;

                                //sad ću još provjeriti da li ovaj stari ima mjerač 



                                SHMMPrev.Reset();
                                //samo mm stavljam u trajno neaktivno
                                SHMMPrev.SetFilter("Measuring Point", '%1', StaraSifraMM);
                                SHMMPrev.SetFilter(Active, '%1', true);
                                if SHMMPrev.FindFirst() then begin



                                    SHMM.Init();
                                    SHMM.Validate("Measuring Point", StaraSifraMM);
                                    SHMM.Validate("Information of processing", sh."Information of processing"::"Permanently inactive");
                                    SHMM."Source Table" := 5940;
                                    SHMM.validate(Active, true);

                                    SHLastMM.Reset();
                                    SHLastMM.SetFilter("Measuring Point", StaraSifraMM);
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




                                //samo promjena (ovdje je 2 puta ušao)

                                IH.Init();
                                ih.TransferFields(IHENtry);
                                ih.Autoincrement := Increment1;
                                if NovaSifraKupca <> '' then
                                    ih."Customer No." := NovaSifraKupca;

                                ih."Measuring Point Code" := NovaSifraMM;
                                if Evaluate(DatumPrekategorizacijeD, DatumPrekategorizacije) then
                                    ih."Installation Date" := DatumPrekategorizacijeD
                                else
                                    ih."Installation Date" := 0D;
                                //     ih.Type := ih.Type::Gauge;
                                ih.Insert();

                                if Evaluate(DatumPrekategorizacijeD, DatumPrekategorizacije) then
                                    IHENtry."Dismantling date" := DatumPrekategorizacijeD
                                else
                                    IHENtry."Dismantling date" := todaY;



                                IHENtry.Active := false;
                                IHENtry.Modify();
                                if IHENtry.Type = IHENtry.Type::Corrector then begin
                                    ServiceF.Reset();
                                    ServiceF.SetFilter("No.", '%1', NovaSifraMM);
                                    if ServiceF.FindFirst() then
                                        //preimenuj korektor module
                                        ElVolume.Reset();
                                    ElVolume.SetFilter(Code, '%1', IHENtry.code);
                                    if ElVolume.FindFirst() then begin
                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                        then
                                            ElVolumeGet.rename(IHENtry.code, NovaSifraMM, NovaSifraKupca, ServiceF."Address MM");
                                    end;
                                end;
                                if IHENtry.Type = IHENtry.Type::Radio_Module then begin

                                    IF rmgET.GET(IHENtry.CODE, rmgET."Gauge Code", IHENtry."Measuring Point Code") THEN BEGIN
                                        rmgET.RENAME(IHENtry.CODE, rmgET."Gauge Code", NovaSifraMM);

                                    end;
                                end;
                                if IHENtry.Type = IHENtry.Type::Gauge then begin
                                    Gauge.Reset();
                                    Gauge.SetFilter("Measuring Point", '%1', StaraSifraMM);
                                    if Gauge.FindFirst() then begin
                                        // key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
                                        if StaraSifraKupca <> '' then begin
                                            if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                                            then begin
                                                GaugeRM.Rename(Gauge.Code, NovaSifraMM, NovaSifraKupca, ServiceItem."Address MM");
                                                GaugeRM."Gauge Category" := MMUpdate;
                                                GaugeRM."Customer Category" := CategoryUpdate;
                                                GaugeRM.Modify;
                                            end;
                                        end
                                        else begin
                                            if GaugeRM.get(Gauge.Code, Gauge."Measuring Point", Gauge."Customer No.", Gauge."Address MM")
                                           then begin
                                                GaugeRM.Rename(Gauge.Code, NovaSifraMM, Gauge."Customer No.", ServiceItem."Address MM");
                                                GaugeRM."Gauge Category" := MMUpdate;
                                                GaugeRM."Customer Category" := CategoryUpdate;
                                                GaugeRM.Modify;
                                            end;
                                        end;
                                    end;
                                end;
                            until IHENtry.Next() = 0;

                    end;

                end;

            }

        }


    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Izaberi izvještaj")
                {
                    field(UpdateGauge; UpdateGauge)
                    {
                        Caption = 'UpdateGauge';
                        ApplicationArea = all;
                    }

                }
            }
        }
    }

    trigger OnPreXmlPort()
    begin
    end;




    var

        Sm3_decimal: Decimal;
        UP_decimal: Decimal;
        SHLast: Record "Status History";
        SHLastMM: Record "Status History MM";
        BM_decimal: Decimal;
        WAR_decimal: Decimal;
        GA_Dec: Decimal;
        GV_dec: Decimal;
        UpdateGauge: Boolean;
        GP_dec: Decimal;
        GTot: Decimal;
        BVM_decimal: Decimal;
        WAR_LVT_decimal: Decimal;
        MonthInt: Integer;
        YearInt: Integer;
        CalcFrom: Date;
        D1Date: Date;
        CalcTo: Date;
        SA_decimal: Decimal;
        STA_decimal: Decimal;
        SVA_decimal: Decimal;


}

