page 50148 "Gauge Tempoery List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Gauge Change Temporery";
    CardPageId = Gauges;
    Caption = 'Gauge Change Temporery';

    layout
    {
        area(Content)
        {


            field(CountV; CountV)
            {
                ShowCaption = false;
                Caption = 'Count';
                Editable = False;
                Style = Unfavorable;
            }

            field("Reason for dismantling2"; "Reason for dismantling")
            {
                Caption = 'Reason for dismantling';

                trigger OnValidate()
                var
                    myInt: Integer;
                    OtherF: Record "Gauge Change Temporery";
                    Filter: Text;
                    CurrentReason: Text[250];
                    BrojI: Integer;
                    Uss: Record "User Setup";

                begin

                    Rec.FINDFIRST;
                    Uss.Reset();
                    Uss.SetFilter("User ID", '%1', UserId);
                    if Uss.FindFirst() then
                        CurrentReason := Uss."Reason MM"
                    else
                        CurrentReason := rec."Reason for dismantling";
                    BEGIN
                        filter := Rec.GETFILTERS;
                        if "Measuring Point Code" <> '' THEN BEGIN
                            REPEAT
                                if OtherF.get(rec.code, rec."Measuring Point Code", rec.Autoincrement, rec.type, rec."Gauge Code", rec."Gauge Code New")
                                then begin

                                    OtherF.Validate("Reason for dismantling", CurrentReason);
                                    OtherF.Modify();
                                end;
                            UNTIL Rec.NEXT = 0;


                        END;
                    end;
                    //   OtherF."Reason for dismantling" := CurrentReason;
                    // OtherF.Modify();


                end;
            }
            repeater("")
            {

                field("Installation Date"; "Installation Date") { ApplicationArea = all; Style = StrongAccent; }
                field("Gauge Code"; "Gauge Code") { }
                field("Meter Manufacturer Code"; "Meter Manufacturer Code") { }
                field("Measurer manufacturer"; "Measurer manufacturer") { }
                field("Inventory Number"; "Inventory Number") { Style = StrongAccent; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; Style = StrongAccent; }
                field("Measuring Point Adress"; "Measuring Point Adress") { ApplicationArea = all; Style = StrongAccent; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; Style = StrongAccent; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; Style = StrongAccent; }
                field(Code; Code) { ApplicationArea = all; Style = StrongAccent; visible = false; }

                field("Calibration Year"; "Calibration Year") { ApplicationArea = all; Style = StrongAccent; }
                field("Programming date"; "Programming date") { ApplicationArea = all; Style = StrongAccent; Visible = false; }
                field("Date of rescheduling"; "Date of rescheduling") { ApplicationArea = all; Style = StrongAccent; Visible = false; }
                field("Serial Number I"; "Serial Number I") { ApplicationArea = all; Style = StrongAccent; Visible = false; }
                field("Serial Number II"; "Serial Number II") { ApplicationArea = all; Style = StrongAccent; Visible = false; }
                field("Reason for dismantling"; "Reason for dismantling") { Style = StrongAccent; }
                field("Dismantling date"; "Dismantling date") { Style = StrongAccent; }
                //   field(Active; Active) { }
                field("Date of consumption"; "Date of consumption") { Style = StrongAccent; }
                field(Reading; Reading) { Style = StrongAccent; }

                //Nove vrijednosit

                field("Installation Date New"; "Installation Date New") { ApplicationArea = all; style = Favorable; }
                field("Gauge Code New"; "Gauge Code New") { }
                field("Meter Manufacturer Code New"; "Meter Manufacturer Code New") { }
                field("Measurer manufacturer New"; "Measurer manufacturer New") { }
                field("Inventory Number New"; "Inventory Number New") { style = Favorable; }
                field("Measuring Point Code New"; "Measuring Point Code New") { ApplicationArea = all; style = Favorable; }
                field("Measuring Point Address New"; "Measuring Point Address New") { ApplicationArea = all; style = Favorable; }
                field("Customer No. New"; "Customer No. New") { ApplicationArea = all; style = Favorable; }
                field("Customer Name New"; "Customer Name New") { ApplicationArea = all; style = Favorable; }

                field("Production Year New"; "Production Year New") { ApplicationArea = all; Visible = false; style = Favorable; }
                field("Calibration Year New"; "Calibration Year New") { ApplicationArea = all; style = Favorable; }
                field("Programming date New"; "Programming date New") { ApplicationArea = all; style = Favorable; Visible = false; }
                field("Date of rescheduling New"; "Date of rescheduling New") { ApplicationArea = all; style = Favorable; Visible = false; }
                field("Serial Number I New"; "Serial Number I New") { ApplicationArea = all; style = Favorable; Visible = false; }
                field("Serial Number II New"; "Serial Number II New") { ApplicationArea = all; style = Favorable; Visible = false; }
                field("Reason for dismantling New"; "Reason for dismantling New") { style = Favorable; Visible = false; }
                field("Dismantling date New"; "Dismantling date New") { style = Favorable; Visible = false; }
                field("Date of consumption New"; "Date of consumption New") { style = Favorable; }
                field("Reading New"; "Reading New") { style = Favorable; }
                field("Create Date"; "Create Date") { }
                field(Type; Type) { }
                field("Gas Station Placement"; "Gas Station Placement") { }
                field(Remotely; Remotely) { }
                field("Remotely Type"; "Remotely Type") { }



            }

        }






    }



    actions
    {
        area(Processing)
        {
            action(PripareMassiveRN)
            {

                ApplicationArea = BasicHR;
                Caption = 'Pripare RN - Change Gauge';
                Image = CalendarChanged;
                Visible = true;
                //    RunObject = report "Employee Absence Reg";

                trigger OnAction()
                var
                    filter: text[250];
                    NewDoc: code[20];
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit NoSeriesExtented;
                    TempMasive: Record "Gauge Change Temporery";
                    TempMassivePage: page "Gauge Tempoery List";

                    ServiceHeader: Record "Service Header";
                    ServiceItemLine: Record "Service Item Line";
                    //lista masovnih radni naloga
                    CustomerInternal: Record Customer;
                    ReportCreateMasive: Report "Create Massive RN";
                    GTemp: Record "Gauge Change Temporery";
                    ConfirmPostLbl: Label 'Do you want to pripare Massive RN?';


                begin

                    Rec.FINDFIRST;
                    filter := Rec.GETFILTERS;
                    GTemp.Reset();
                    GTemp.CopyFilters(Rec);
                    Report.RunModal(Report::"Create Massive RN", true, true, GTemp);

                    //na osnovu odabrane liste, te podatke pošalji u pomoćnu tabelu 
                end;



            }

            action(Applied)
            {

                ApplicationArea = BasicHR;
                Caption = 'Applied Change Gauge';
                Image = CalendarChanged;
                Visible = true;
                //    RunObject = report "Employee Absence Reg";

                trigger OnAction()
                var
                    filter: text[250];
                    NewDoc: code[20];
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit NoSeriesExtented;
                    TempMasive: Record "Gauge Change Temporery";
                    TempMassivePage: page "Gauge Tempoery List";

                    ServiceHeader: Record "Service Header";
                    ServiceItemLine: Record "Service Item Line";
                    //lista masovnih radni naloga
                    CustomerInternal: Record Customer;
                    ReportCreateMasive: Report "Create Massive RN";
                    GTemp: Record "Gauge Change Temporery";
                    ConfirmPostLbl: Label 'Do you want to pripare Massive RN?';
                    DR: Record "Dismantling Reason";
                    GaugeTemp: Record "Gauge Change Temporery";
                    IHInsert: Record "Installation History";
                    IHInsertPrevious: Record "Installation History";

                    MMNew: Record "Service Item";
                    CustNew: Record Customer;
                    GaugeFF: Record Gauge;
                    GaugeFFRename: Record Gauge;

                begin

                    Rec.FINDFIRST;
                    filter := Rec.GETFILTERS;
                    DR.Reset();
                    GaugeTemp.Reset();
                    GaugeTemp.CopyFilters(Rec);
                    if GaugeTemp.FindSet() then
                        repeat
                            DR.Reset();
                            DR.SetFilter(Type, '%1', dr.Type::"Reason for dismantling");
                            dr.SetFilter(description, '%1', "Reason for dismantling");
                            if dr.FindFirst() then begin
                                if dr.Verification = true then begin
                                    //ako je verifikacija, trebala bi aktivno staviti da je u laboratoriji
                                    IHInsert.Reset();

                                    IHInsert.SetFilter("Installation Date", '%1', GaugeTemp."Installation Date");
                                    IHInsert.SetFilter(Code, '%1', GaugeTemp."Gauge Code");
                                    IHInsert.SetFilter(Type, '%1', GaugeTemp.Type);
                                    if not IHInsert.FindFirst() then begin
                                        IHInsert.Init();
                                        IHInsert."Installation Date" := GaugeTemp."Dismantling date";
                                        IHInsert.Code := GaugeTemp."Gauge Code";
                                        IHInsert."Customer Stroke" := GaugeTemp."Customer Stroke";
                                        IHInsert."Customer string" := GaugeTemp."Customer string";
                                        IHInsert."Customer Zone stroke" := GaugeTemp."Customer Zone stroke";
                                        IHInsert."Measuring Point Stroke" := GaugeTemp."Measuring Point Stroke";
                                        IHInsert."Measuring Point string" := GaugeTemp."Measuring Point string";
                                        IHInsert."Measuring Point Adress" := GaugeTemp."Measuring Point Adress";
                                        IHInsert."Measuring Point Code" := GaugeTemp."Measuring Point Code";
                                        IHInsert."Measurer manufacturer" := GaugeTemp."Measurer manufacturer";
                                        if IHInsert."Measuring Point string" = 0 then begin
                                            MMNew.Reset();
                                            MMNew.SetFilter("No.", '%1', GaugeTemp."Measuring Point Code");
                                            if MMNew.FindFirst() then begin
                                                IHInsert."Measuring Point string" := MMNew."Measuring Point string";
                                                IHInsert."Measuring Point Stroke" := MMNew."Measuring Point Stroke";
                                                IHInsert."Measuring Point Adress" := MMNew."Address MM";


                                            end;
                                        end;



                                        IHInsert."Customer Address" := GaugeTemp."Customer Address";
                                        IHInsert."Customer Category" := GaugeTemp."Customer Category";
                                        IHInsert."Customer City" := GaugeTemp."Customer City";
                                        IHInsert."Customer Name" := GaugeTemp."Customer Name";
                                        IHInsert."Customer No." := GaugeTemp."Customer No.";
                                        IHInsert."Customer Post Code" := GaugeTemp."Customer Post Code";

                                        CustNew.Reset();
                                        CustNew.SetFilter("No.", '%1', GaugeTemp."Customer No.");
                                        if CustNew.FindFirst() then begin

                                            IHInsert."Customer Address" := CustNew.Address;
                                            IHInsert."Customer Category" := CustNew."Customer Category";
                                            IHInsert."Customer City" := CustNew.City;
                                            IHInsert."Customer Name" := CustNew.Name;
                                            IHInsert."Customer Post Code" := CustNew."Post Code";

                                        end;


                                        IHInsert."Serial Number I" := GaugeTemp."Serial Number I";
                                        IHInsert."Serial Number II" := GaugeTemp."Serial Number II";
                                        IHInsert."Inventory Number" := GaugeTemp."Inventory Number";
                                        IHInsert.InvterentoryFil := GaugeTemp."Inventory Number";
                                        IHInsert.Type := IHInsert.Type::Gauge;
                                        IHInsert."Calibration Year" := date2dmy("Dismantling Date", 3);
                                        IHInsert."Measuring Point Code" := '';
                                        IHInsert."Measuring Point Adress" := '';
                                        IHInsert."Measuring Point string" := 0;
                                        IHInsert."Measuring Point Stroke" := 0;
                                        IHInsert."Customer Address" := '';
                                        IHInsert."Customer Category" := GaugeTemp."Customer Category"::" ";
                                        IHInsert."Customer City" := '';
                                        IHInsert."Customer Name" := '';
                                        IHInsert."Customer No." := '';
                                        IHInsert."Customer Post Code" := '';
                                        IHInsert."Customer string" := 0;
                                        IHInsert."Customer Stroke" := 0;
                                        IHInsert."Customer Zone stroke" := 0;
                                        IHInsert.Reading := GaugeTemp.Reading;
                                        IHInsert."Date of consumption" := GaugeTemp."Date of consumption";
                                        IHInsert."DD calibration" := GaugeTemp."DD calibration";
                                        IHInsert."Calibration Year" := GaugeTemp."Calibration Year";
                                        IHInsert."Serial Number I" := GaugeTemp."Serial Number I";
                                        IHInsert."Serial Number II" := GaugeTemp."Serial Number II";
                                        IHInsert."EL Volume Description" := GaugeTemp."EL Volume Description";
                                        IHInsert."Dismantling date" := GaugeTemp."Dismantling date";
                                        IHInsert."Reason for dismantling" := GaugeTemp."Reason for dismantling";
                                        if IHInsert."Dismantling date" <= today then begin
                                            IHInsert.Active := true;
                                            if IHInsert.Type = IHInsert.Type::Gauge then begin
                                                GaugeFF.Reset();
                                                GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                if GaugeFF.FindFirst() then begin
                                                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                    GaugeFF.Reset();

                                                end;
                                            end;






                                            IHInsertPrevious.Reset();
                                            //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                            IHInsertPrevious.SetFilter(Code, '%1', GaugeTemp."Gauge Code");
                                            IHInsertPrevious.SetFilter(Type, '%1', GaugeTemp.Type);
                                            IHInsertPrevious.SetFilter(Active, '%1', true);
                                            if IHInsertPrevious.FindFirst() then begin
                                                IHInsertPrevious."Reason for dismantling" := GaugeTemp."Reason for dismantling";
                                                IHInsertPrevious."Dismantling date" := GaugeTemp."Dismantling date";
                                                IHInsertPrevious.Active := false;
                                                IHInsertPrevious.modify;
                                            end;

                                            IHInsert.Insert();
                                            Commit();


                                        end;
                                    end
                                    else begin

                                        //ovdje samo ako je odjava, da ga samo uklone
                                        IHInsertPrevious.Reset();
                                        //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                        IHInsertPrevious.SetFilter(Code, '%1', GaugeTemp."Gauge Code");
                                        IHInsertPrevious.SetFilter(Type, '%1', GaugeTemp.Type);
                                        IHInsertPrevious.SetFilter(Active, '%1', true);
                                        if IHInsertPrevious.FindFirst() then begin
                                            IHInsertPrevious."Reason for dismantling" := GaugeTemp."Reason for dismantling";
                                            IHInsertPrevious."Dismantling date" := GaugeTemp."Dismantling date";
                                            IHInsertPrevious.Active := false;
                                            IHInsertPrevious.modify;
                                        end;

                                    end;

                                end
                                else begin

                                    //

                                end;

                                //sada hoću da dodam neke nove, ova ugradnja nvoog

                                //
                                if "Gauge Code New" <> '' then begin
                                    IHInsert.Reset();
                                    IHInsert.SetFilter("Installation Date", '%1', GaugeTemp."Installation Date New");
                                    IHInsert.SetFilter(Code, '%1', GaugeTemp."Gauge Code New");
                                    IHInsert.SetFilter(Type, '%1', GaugeTemp.Type);
                                    if not IHInsert.FindFirst() then begin
                                        IHInsert.Init();
                                        IHInsert.Code := GaugeTemp."Gauge Code New";
                                        IHInsert.Type := IHInsert.Type::Gauge;
                                        IHInsert."Installation Date" := GaugeTemp."Installation Date New";
                                        IHInsert."Measuring Point Code" := GaugeTemp."Measuring Point Code New";
                                        IHInsert."MZ MM" := GaugeTemp."MZ MM New";
                                        IHInsert.Reading := GaugeTemp."Reading New";
                                        IHInsert."Street MM" := GaugeTemp."Street MM New";
                                        IHInsert."MZ Name MM" := GaugeTemp."MZ Name MM New";
                                        IHInsert."Address MM" := GaugeTemp."Address MM New";
                                        IHInsert."Dismantling date" := 0D;
                                        IHInsert."Reason for dismantling" := '';
                                        IHInsert.Code := GaugeTemp."Gauge Code New";
                                        IHInsert."Customer No." := GaugeTemp."Customer No. New";
                                        IHInsert."Street No. MM" := GaugeTemp."Street No. MM New";
                                        IHInsert."Customer Name" := GaugeTemp."Customer Name New";
                                        IHInsert."Customer City" := GaugeTemp."Customer City New";
                                        IHInsert."Street Name MM" := GaugeTemp."Street Name MM New";
                                        IHInsert."DD calibration" := GaugeTemp."DD calibration New";
                                        IHInsert."MM Description" := GaugeTemp."MM Description New";
                                        IHInsert."Serial Number I" := GaugeTemp."Serial Number I New";
                                        IHInsert."Customer string" := GaugeTemp."Customer string New";
                                        IHInsert."Customer Stroke" := GaugeTemp."Customer Stroke New";
                                        IHInsert."Production Year" := GaugeTemp."Production Year New";
                                        IHInsert."Serial Number II" := GaugeTemp."Serial Number II New";
                                        IHInsert."Inventory Number" := GaugeTemp."Inventory Number New";
                                        IHInsert.InvterentoryFil := GaugeTemp."Inventory Number New";
                                        IHInsert."Calibration Year" := GaugeTemp."Calibration Year New";
                                        IHInsert."Customer Address" := GaugeTemp."Customer Address New";
                                        IHInsert."Dismantling date" := GaugeTemp."Dismantling date New";
                                        IHInsert."Programming date" := GaugeTemp."Programming date New";
                                        IHInsert."Customer Category" := GaugeTemp."Customer Category New";
                                        IHInsert."Installation Date" := GaugeTemp."Installation Date New";
                                        IHInsert."Customer Post Code" := GaugeTemp."Customer Post Code New";
                                        IHInsert."Date of consumption" := GaugeTemp."Date of consumption New";
                                        IHInsert."Customer Zone stroke" := GaugeTemp."Customer Zone stroke New";
                                        IHInsert."Date of rescheduling" := GaugeTemp."Date of rescheduling New";
                                        IHInsert."Measuring Point Code" := GaugeTemp."Measuring Point Code New";
                                        IHInsert."Municipality Code MM" := GaugeTemp."Municipality Code MM New";
                                        IHInsert."EL Volume Description" := GaugeTemp."EL Volume Description New";
                                        IHInsert."Measurer manufacturer" := GaugeTemp."Measurer manufacturer New";
                                        IHInsert."Measuring Point string" := GaugeTemp."Measuring Point string New";
                                        IHInsert."Measuring Point Stroke" := GaugeTemp."Measuring Point Stroke New";
                                        IHInsert."Reason for dismantling" := GaugeTemp."Reason for dismantling New";
                                        IHInsert."Measuring Point Adress" := GaugeTemp."Measuring Point Address New";
                                        if IHInsert."Installation Date" <= today
             then begin

                                            IHInsert.Active := true;
                                            if Type = Type::Gauge then begin
                                                GaugeFF.Reset();
                                                GaugeFF.SetFilter(Code, '%1', IHInsert.Code);
                                                if GaugeFF.FindFirst() then begin
                                                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                    GaugeFF.Reset();

                                                end;
                                            end;

                                        end;
                                        MMNew.Reset();
                                        MMNew.SetFilter("No.", '%1', GaugeTemp."Measuring Point Code New");
                                        if MMNew.FindFirst() then begin
                                            IHInsert."Measuring Point string" := MMNew."Measuring Point string";
                                            IHInsert."Measuring Point Stroke" := MMNew."Measuring Point Stroke";
                                            IHInsert."Measuring Point Adress" := MMNew."Address MM";

                                        end;


                                        CustNew.Reset();
                                        CustNew.SetFilter("No.", '%1', GaugeTemp."Customer No. New");
                                        if CustNew.FindFirst() then begin

                                            IHInsert."Customer Address" := CustNew.Address;
                                            IHInsert."Customer Category" := CustNew."Customer Category";
                                            IHInsert."Customer City" := CustNew.City;
                                            IHInsert."Customer Name" := CustNew.Name;
                                            IHInsert."Customer Post Code" := CustNew."Post Code";

                                        end;

                                        IHInsert.Insert();
                                        Commit();

                                        IHInsertPrevious.Reset();
                                        //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                        IHInsertPrevious.SetFilter(Code, '%1', GaugeTemp."Gauge Code New");
                                        IHInsertPrevious.SetFilter(Type, '%1', GaugeTemp.Type);
                                        IHInsertPrevious.SetFilter(Active, '%1', true);
                                        if IHInsertPrevious.FindFirst() then begin
                                            IHInsertPrevious."Reason for dismantling" := GaugeTemp."Reason for dismantling";
                                            IHInsertPrevious."Dismantling date" := GaugeTemp."Dismantling date";
                                            IHInsertPrevious.Active := false;
                                            IHInsertPrevious.modify;
                                        end;

                                    end;

                                end;
                            end;

                        until GaugeTemp.Next() = 0;



                    //apliciraj u installacijski faktor

                    //"Dismantling Reason".Description where(Type = filter("Reason for dismantling"));

                    //na osnovu odabrane liste, te podatke pošalji u pomoćnu tabelu 
                end;



            }


        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

        CountV := rec.Count;
        us.reset;
        us.setfilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Calc Date from" <> 0D then begin
                /*       SetFilter("Date Filter 2", '<=%1|>=%2|%3', us."Calc Date from", us."Calc Date to", 0D);
                       //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023
                       SetFilter("Date Filter", '<=%1', us."Calc Date from");
                       SetFilter(Type, '%1', Type::Gauge);*/
            end;
        end;


    end;



    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;
        us.reset;
        us.setfilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Calc Date from" <> 0D then begin
                /*   SetFilter("Date Filter 2", '<=%1|>=%2|%3', us."Calc Date from", us."Calc Date to", 0D);
                   //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023
                   SetFilter("Date Filter", '<=%1', us."Calc Date from");
                   SetFilter(Type, '%1', Type::Gauge);*/
            end;
        end;

    end;


    var
        us: Record "User Setup";
        myInt: Integer;
        CountV: Integer;
}
