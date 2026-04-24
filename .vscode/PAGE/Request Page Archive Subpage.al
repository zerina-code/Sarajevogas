page 50233 "Request Card SubPage Archive"
{
    Caption = 'Measure Points';
    PageType = ListPart;
    SourceTable = "Service Item Line Archive";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {

            field(CountV; CountV)
            {
                ShowCaption = false;
                Caption = 'Count';
                Editable = False;
                Style = Unfavorable;
            }


            repeater(General)
            {
                field(Type; Type) { }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Measure Point';
                    Visible = false;
                }
                field("Service Item No. - Relation"; "Service Item No. - Relation")
                {
                    Caption = 'Measure point';


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        //  ServOrderMgt: Codeunit "Service-Quote to Order";
                        ServiceItem: Record "Service Item";
                        SerItem: page "Service Item List";
                        ServH: Record "Service Header";
                        ServiceItemLine: record "Service Item Line";
                        OS: Record "Fixed Asset";
                        OSPage: page "Fixed Asset List";
                        ServiceItemOhers: Record "Service Item";
                        EENew: code[20];
                        NoSeries: Codeunit NoSeriesExtented;
                        SSet: Record "Service Mgt. Setup";
                        LineNoB: Integer;
                        ServiceItemOhersInser: Record "Service Item Line";
                        ZahtjevLastEE: Record "Service Item Line";


                    begin

                        if Type = Type::MM then begin
                            Clear(SerItem);

                            ServH.Get(rec."Document Type", rec."Document No.");
                            ServiceItem.Reset();
                            ServiceItem.SetFilter("Customer No.", '%1', ServH."Customer No.");
                            SerItem.SetTableView(ServiceItem);
                            SerItem.LOOKUPMODE(TRUE);
                            IF SerItem.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                SerItem.GETRECORD(ServiceItem);


                                validate("Service Item No. - Relation", ServiceItem."No.");
                                LineNoB += 10000;

                                ServH.Validate("Owner No.", ServiceItem."Contact MM");

                                if ServH."Request type" = ServH."Request type"::"Project and Energy Accordance" then
                                    Validate("Consent ID", rec."Document No.");

                                //nađi neki posljednji EE
                                //    ServH.Modify();


                                ZahtjevLastEE.reset;
                                ZahtjevLastEE.reset;
                                ZahtjevLastEE.SetFilter("Service Item No.", '%1', ServiceItem."No.");
                                ZahtjevLastEE.setfilter("Request type", '%1', ZahtjevLastEE."Request type"::"Project and Energy Accordance");
                                ZahtjevLastEE.setcurrentkey(SystemCreatedAt);
                                ZahtjevLastEE.ascending;
                                if ZahtjevLastEE.FindLast() then
                                    Validate("Consent ID", ZahtjevLastEE."Document No.");

                                if ServH."Request type" = ServH."Request type"::"Project and Energy Accordance" then begin

                                    if Confirm(Text005, true) then begin

                                        ServiceItemOhers.Reset();
                                        ServiceItemOhers.SetFilter("Customer No.", '%1', ServH."Customer No.");
                                        ServiceItemOhers.SetFilter("No.", '<>%1', ServiceItem."No.");
                                        if ServiceItemOhers.FindSet() then
                                            repeat

                                                ServiceItemLine.Init();
                                                ServiceItemOhersInser.Reset();
                                                ServiceItemOhersInser.SetFilter("Service Item No. - Relation", '%1', ServiceItemOhers."No.");
                                                ServiceItemOhersInser.SetFilter("Document Type", '%1', ServH."Document Type");
                                                ServiceItemOhersInser.SetFilter("Document No.", '%1', ServH."No.");
                                                if not ServiceItemOhersInser.FindFirst() then begin
                                                    LineNoB += 10000;
                                                    ServiceItemLine."Document No." := Rec."Document No.";
                                                    ServiceItemLine."Document Type" := ServH."Document Type";
                                                    ServiceItemLine."Line No." := LineNoB;
                                                    ServiceItemLine.Type := ServiceItemLine.Type::MM;
                                                    SSet.get;
                                                    //      EENew := NoSeries.GetNextNo(SSet."Proj. Accordance No. Series", Today, true);

                                                    ServiceItemLine."Consent ID" := EENew;

                                                    //    ServiceItemLine.Validate("Service Item No. - Relation", mm."No.");
                                                    ServiceItemLine."Service Item No." := ServiceItemOhers."No.";
                                                    ServiceItemLine."Service Item No. - Relation" := ServiceItemOhers."No.";

                                                    if ServiceItemLine."Service Item No." = '' then begin
                                                        ServiceItemLine."Purpose" := '';
                                                        ServiceItemLine."Dwelling Type" := '';
                                                        ServiceItemLine."Elevation" := 0;
                                                        ServiceItemLine."Reading Mode" := ServiceItemLine."Reading Mode"::Digital;
                                                        ServiceItemLine."MM Category" := Enum::Category::" ";
                                                        ServiceItemLine."Municipality Code" := '';
                                                        ServiceItemLine."MZ" := '';
                                                        ServiceItemLine."Street" := '';
                                                        ServiceItemLine."Street No." := '';
                                                        ServiceItemLine."String" := 0;
                                                        ServiceItemLine."Stroke" := 0;
                                                        ServiceItemLine."Zone Stroke" := 0;
                                                        ServiceItemLine."Municipality Name" := '';
                                                        ServiceItemLine."MZ Name" := '';
                                                        ServiceItemLine."Street Name" := '';
                                                        ServiceItemLine.Address := '';
                                                        ServiceItemLine."Home No. MM" := '';
                                                        ServiceItemLine."Floor MM" := '';
                                                        ServiceItemLine."Apartment No. MM" := '';
                                                        ServiceItemLine."Street No. Text MM" := '';

                                                    end;
                                                    ServiceItemOhers.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
                                                    ServiceItemLine."Purpose" := ServiceItemOhers."Purpose";
                                                    ServiceItemLine."Dwelling Type" := ServiceItemOhers."Dwelling Type";
                                                    ServiceItemLine."Elevation" := ServiceItemOhers."Elevation";
                                                    ServiceItemLine."Reading Mode" := ServiceItemOhers."Reading Mode";
                                                    ServiceItemLine."MM Category" := ServiceItemOhers."MM Category";
                                                    ServiceItemLine."Municipality Code" := ServiceItemOhers."Municipality Code MM";
                                                    ServiceItemLine."MZ" := ServiceItemOhers."MZ MM";
                                                    ServiceItemLine."Street" := ServiceItemOhers.Street;

                                                    ServiceItemLine."Street No." := ServiceItemOhers."Street No.";
                                                    ServiceItemLine."String" := ServiceItemOhers."Measuring Point string";
                                                    ServiceItemLine."Stroke" := ServiceItemOhers."Measuring Point Stroke";
                                                    ServiceItemLine."Zone Stroke" := ServiceItemOhers."Zone stroke";
                                                    ServiceItemLine."Municipality Name" := ServiceItemOhers."Municipality Name MM";
                                                    ServiceItemLine."MZ Name" := ServiceItemOhers."MZ Name MM";
                                                    ServiceItemLine."Street Name" := ServiceItemOhers."Street Name MM";
                                                    ServiceItemLine.Address := ServiceItemOhers."Address MM";
                                                    ServiceItemLine."Home No. MM" := ServiceItemOhers."Home No.";
                                                    ServiceItemLine."Floor MM" := ServiceItemOhers.Floor;
                                                    ServiceItemLine."Apartment No. MM" := ServiceItemOhers."Apartment No.";
                                                    ServiceItemLine."Street No. Text MM" := ServiceItemOhers."Street No. Text";


                                                    ServiceItemLine.Insert();
                                                    Commit();

                                                end;
                                            until ServiceItemOhers.Next() = 0;
                                        CurrPage.Update();
                                    end;


                                    //ovdje preuzeti podatke o vlasniku
                                end;

                                //
                            end;

                            //    SerItem.Run();
                            ;

                        end;

                        if Type = Type::OS then begin
                            Clear(SerItem);

                            ServH.Get(rec."Document Type", rec."Document No.");

                            OS.Reset();
                            //  OS.SetFilter("Customer No.", '%1', ServH."Customer No.");
                            os.SetFilter("Gas Station Type", '<>%1', '');
                            OSPage.SetTableView(OS);
                            OSPage.LOOKUPMODE(TRUE);
                            IF OSPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                OSPage.GETRECORD(OS);
                                validate("Service Item No. - Relation", OS."No.");
                                "MM Category" := "MM Category"::" ";

                                // ServH.Validate("Owner No.", ServiceItem."Contact MM");
                                ServH.Modify();

                                //ovdje preuzeti podatke o vlasniku

                                //
                            end;


                        end;

                    end;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                }


                field("MM Category"; Rec."MM Category")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; "Customer No.") { }
                field("Customer Name"; "Customer Name") { }
                field("Phone No. MM"; "Phone No. MM") { }
                field(Mark; Mark) { }


                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                }
                field("Street Name"; Rec."Street Name")
                {
                    ApplicationArea = All;
                }
                field("Street No."; Rec."Street No.")
                {
                    ApplicationArea = All;
                }
                field("Street No. Text MM"; "Street No. Text MM") { }
                field("Municipality Code"; Rec."Municipality Code")
                {
                    ApplicationArea = All;
                }
                field("Municipality Name"; Rec."Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("MZ"; Rec.MZ)
                {
                    ApplicationArea = All;
                }
                field("MZ Name"; Rec."MZ Name")
                {
                    ApplicationArea = All;
                }
                field("Home No. MM"; "Home No. MM") { }
                field("Apartment No. MM"; "Apartment No. MM") { }
                field("Floor MM"; "Floor MM") { }
                field(Stroke; Rec.Stroke)
                {
                    ApplicationArea = All;
                }
                field(String; Rec.String)
                {
                    ApplicationArea = All;
                }
                field("Zone Stroke"; "Zone Stroke")
                {
                    ApplicationArea = All;
                }


                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                }
                field("Consent ID"; Rec."Consent ID")
                {
                    ApplicationArea = All;
                    Visible = TypeVisible;
                }
                field("Gas Station Placement"; "Gas Station Placement") { }
                field("Total installed kW"; Rec."Total installed kW")
                {
                    ApplicationArea = All;
                }
                field("Number of Measure Points"; Rec."Number of Measure Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of Measure Points requested to be installed.';
                }
                field(Gauge; Rec.Gauge)
                {
                    ApplicationArea = All;

                    //kao stari broj mjerača

                    //stari mjerač
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        //  ServOrderMgt: Codeunit "Service-Quote to Order";
                        ServiceItem: Record "Service Item";
                        SerItem: page "Service Item List";
                        ServH: Record "Service Header";
                        OS: Record "Fixed Asset";
                        OSPage: page "Fixed Asset List";
                        GaugeR: Record Gauge;
                        GaugeP: page "Gauge List";
                        US: Record "User Setup";
                        IH: Record "Installation History";
                        SH: Record "Service Header";
                        RMF: Record "Radio Module";

                    begin
                        if Type = type::MM then begin
                            GaugeR.Reset();
                            GaugeR.SetFilter(Code, '%1', Gauge);
                            GaugeP.SetTableView(GaugeR);
                            GaugeP.LOOKUPMODE(TRUE);
                            IF GaugeP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GaugeP.GETRECORD(GaugeR);
                                Gauge := GaugeR.Code;
                                validate("Service Item No. - Relation", GaugeR."Measuring Point");
                                "Serial No." := gaugeR."Inventar number";

                            end;
                        end;
                        if Type = Type::Loc then "Type G_R" := "Type G_R"::Radio_Module;

                        if (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) then begin

                            rec."Gauge No." := rec.Gauge;


                            GaugeR.Reset();
                            if rec.Gauge = '' then
                                GaugeR.SetFilter("Customer No.", '%1', '')
                            else
                                GaugeR.SetFilter(Code, '%1', Gauge);

                            GaugeP.SetTableView(GaugeR);
                            GaugeP.LOOKUPMODE(TRUE);
                            IF GaugeP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GaugeP.GETRECORD(GaugeR);
                                Gauge := GaugeR.Code;
                                rec.RMS := GaugeR."Inventar number";
                                rec."Meter Manufacturer" := GaugeR."Meter Manufacturer";
                                rec."Meter Manufacturer Desc" := GaugeR."Meter Manufacturer Desc";
                                rec."Gauge Size" := GaugeR."Gauge Size";
                                rec."Year of Production" := GaugeR."Year of Production";
                                rec."DD calibration" := GaugeR."DD calibration";




                            end;

                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if US.FindFirst() then begin
                                us.GaugeInsert := rec.Gauge;
                                us.Modify();
                            end;

                            IF (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) THEN BEGIN
                                rec."Gauge No." := rec.Gauge;
                                IH.Reset();
                                //   IH.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                                iH.SetFilter(Active, '%1', true);
                                Ih.SetFilter(Type, '%1', IH.Type::Radio_Module);
                                ih.SetFilter("Gauge cODE", '%1', rec.Gauge);
                                SH.Reset();
                                SH.SetFilter("No.", '%1', rec."Document No.");
                                if sh.FindFirst() then
                                    IH.SetFilter("Installation Date", '<=%1', sh."Document Date");
                                //  IH.SetFilter("Dismantling date", '%1|>=%2', 0D, sh."Document Date");
                                ih.SetCurrentKey("Installation Date");
                                ih.Ascending;
                                if ih.FindLast() then begin

                                    RMF.reset;
                                    RMF.setfilteR("Gauge Code", '%1', rec.Gauge);
                                    RMF.setfilter(Code, '%1', ih.Code);
                                    // "Radio Module".Code where("Gauge Code" = field("Gauge No."), "Measuring Point Code" = field("Service Item No. - Relation"));

                                    if RMF.findfirst then
                                        Validate("Radio Module Code", IH.Code);



                                    Validate("Radio Module Serial I", RMF."Serial Number I");
                                    Validate("Year of Production RM", RMF."Year of Production");
                                    Validate("Type Radio Module", RMF."Type Radio Module");
                                    Validate("Radio Module Serial II", RMF."Serial Number II");

                                END;

                            END;
                        end;

                    end;
                }
                field(RMS; RMS)
                {
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        //Stari serijski broj mjerača
                        myInt: Integer;
                        //  ServOrderMgt: Codeunit "Service-Quote to Order";
                        ServiceItem: Record "Service Item";
                        SerItem: page "Service Item List";
                        ServH: Record "Service Header";
                        OS: Record "Fixed Asset";
                        OSPage: page "Fixed Asset List";
                        GaugeR: Record Gauge;
                        GaugeP: page Gauges;
                        US: Record "User Setup";
                        IH: Record "Installation History";
                        SH: Record "Service Header";
                        RMF: Record "Radio Module";

                    begin

                        if Type = type::MM then begin
                            GaugeR.Reset();
                            GaugeR.SetFilter(Code, '%1', Gauge);
                            GaugeP.SetTableView(GaugeR);
                            GaugeP.LOOKUPMODE(TRUE);
                            IF GaugeP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GaugeP.GETRECORD(GaugeR);
                                Gauge := GaugeR.Code;
                                validate("Service Item No. - Relation", GaugeR."Measuring Point");
                                "Serial No." := gaugeR."Inventar number";

                            end;

                        end;

                        if (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) then begin
                            rec."Gauge No." := rec.Gauge;

                            GaugeR.Reset();
                            if rec.Gauge = '' then
                                GaugeR.SetFilter("Customer No.", '%1', '')
                            else
                                GaugeR.SetFilter(Code, '%1', Gauge);

                            GaugeP.SetTableView(GaugeR);
                            GaugeP.LOOKUPMODE(TRUE);
                            IF GaugeP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                GaugeP.GETRECORD(GaugeR);
                                Gauge := GaugeR.Code;
                                rec.RMS := GaugeR."Inventar number";
                                rec."Meter Manufacturer" := GaugeR."Meter Manufacturer";
                                rec."Meter Manufacturer Desc" := GaugeR."Meter Manufacturer Desc";
                                rec."Gauge Size" := GaugeR."Gauge Size";
                                rec."Year of Production" := GaugeR."Year of Production";
                                rec."DD calibration" := GaugeR."DD calibration";




                            end;
                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if US.FindFirst() then begin
                                us.GaugeInsert := rec.Gauge;
                                us.Modify();
                            end;
                            IF (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) THEN BEGIN
                                rec."Gauge No." := rec.Gauge;
                                IH.Reset();
                                //   IH.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                                iH.SetFilter(Active, '%1', true);
                                Ih.SetFilter(Type, '%1', IH.Type::Radio_Module);
                                ih.SetFilter("Gauge cODE", '%1', rec.Gauge);
                                SH.Reset();
                                SH.SetFilter("No.", '%1', rec."Document No.");
                                if sh.FindFirst() then
                                    IH.SetFilter("Installation Date", '<=%1', sh."Document Date");
                                //  IH.SetFilter("Dismantling date", '%1|>=%2', 0D, sh."Document Date");
                                ih.SetCurrentKey("Installation Date");
                                ih.Ascending;
                                if ih.FindLast() then begin

                                    RMF.reset;
                                    RMF.setfilteR("Gauge Code", '%1', rec.Gauge);
                                    RMF.setfilter(Code, '%1', ih.Code);
                                    // "Radio Module".Code where("Gauge Code" = field("Gauge No."), "Measuring Point Code" = field("Service Item No. - Relation"));

                                    if RMF.findfirst then
                                        Validate("Radio Module Code", IH.Code);



                                    Validate("Radio Module Serial I", RMF."Serial Number I");
                                    Validate("Year of Production RM", RMF."Year of Production");
                                    Validate("Type Radio Module", RMF."Type Radio Module");
                                    Validate("Radio Module Serial II", RMF."Serial Number II");

                                END;

                            END;
                        end;



                    end;
                }
                field("Gauge Size"; "Gauge Size") { }//stara veličina mjerača
                field("Year of Production"; "Year of Production") { }//stara godina proizvodnje mjerača
                field("DD calibration"; "DD calibration") { }//stara verifikacija
                field("Date of consumption"; "Date of consumption") { Style = Unfavorable; } //Datum očitanja
                field(Reading; Reading) { Style = Unfavorable; } //Vrijednost očitanja
                                                                 //ovo je na mjeraču 
                field("Pressure Type"; "Pressure Type") { }
                field("Operating Pressure On ML"; "Operating Pressure On ML") { }
                field(Temperature; Temperature) { }
                field(Remotely; Remotely) { }
                field("Remotely Type"; "Remotely Type") { }
                field("Radio Module Code"; "Radio Module Code") { }//Šifra radio modula
                field("Radio Module Serial I"; "Radio Module Serial I") { }
                field("Radio Module Serial II"; "Radio Module Serial II") { }
                field(Corrector; Corrector) { }//Šifra trenutnog korektora
                field("Corrector Serial Number"; "Corrector Serial Number") { }

                //dodati nove vrijednoti
                //novi razlog za zamjenu

                field("Adjusted Volume"; "Adjusted Volume") { }
                field("Unadjusted Volume"; "Unadjusted Volume") { }
                field("Absolute Pressure Of Corrector"; "Absolute Pressure Of Corrector") { }
                field("Temperature Value"; "Temperature Value") { }
                field("Correction Factor"; "Correction Factor") { }
                field("Year of Production Corr Old"; "Year of Production Corr Old") { }
                field("DD calibration Corr Old"; "DD calibration Corr Old") { }

                field("Reason for dismantling New"; "Reason for dismantling New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Dismantling date New"; "Dismantling date New") { ApplicationArea = all; style = Favorable; Visible = true; }
                //datum  razlog za zamjenu
                field("Type G_R"; "Type G_R") { ApplicationArea = all; style = Favorable; Visible = true; }
                //Datum nove ugradnje
                field("Installation Date New"; "Installation Date New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("New Gauges"; "New Gauges")
                {
                    //novi mjerač ili korektor ili radio modul ( s tim da je radio modul dio )
                    ApplicationArea = all;
                    style = Favorable;
                    Visible = true;
                    //  DrillDownPageId = "Gauge List";
                    //LookupPageId = "Gauge List";

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        GaugeR: Record Gauge;
                        ServiceII: Record "Service Item";
                        CG: Record Customer;
                        ih: Record "Installation History";
                        Correct: Record "El. Volume Corr";
                        GaugeP: page "Gauge List";
                        US: Record "User Setup";
                        CorrectR: record "El. Volume Corr";
                        CorrectP: page "EL. Volume Corr. List";
                        RadioR: Record "Radio Module";
                        RadioP: page "Radio Module Card";
                        GaguNew: Record Gauge;
                        RYear: Record "Radio Module";

                    begin

                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            Commit();
                            us."Adress MM" := Rec.Address;
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."Service Item No. - Relation";
                            us.Modify();
                            Commit();
                        end;

                        if ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Gauge_RM) or (("Type G_R" = "Type G_R"::Corrector_RM)) then begin
                            GaugeR.Reset();
                            Commit();
                            //  GaugeR.SetFilter(Code, '%1', Gauge);
                            GaugeR.setfilter("Customer No.", '%1|%2', rec."Customer No.", '');
                            GaugeP.SetTableView(GaugeR);
                            GaugeP.LOOKUPMODE(TRUE);
                            IF GaugeP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                US.Reset();
                                US.SetFilter("User ID", '%1', UserId);
                                if us.FindFirst() then begin
                                    Commit();
                                    us."Measuring Code" := rec."Service Item No. - Relation";
                                    us.Modify()
                                    ;
                                    Commit();
                                end;
                                Commit();

                                GaugeP.GETRECORD(GaugeR);
                                "New Gauges" := GaugeR.Code;
                                Commit();
                                validate("Service Item No. - Relation", Rec."Service Item No. - Relation");
                                "Inventory Number New" := gaugeR."Inventar number";

                                "Measuring Point Code New" := rec."Service Item No. - Relation";
                                ServiceII.reset;
                                ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                                if ServiceII.FindFirst() then begin
                                    Validate("MM Description New", ServiceII.Description);

                                    validate("Address MM New", ServiceII."Address MM");
                                    validate("MZ MM New", ServiceII."MZ MM");
                                    validate("MZ Name MM New", ServiceII."MZ Name MM");
                                    validate("Street MM New", ServiceII."Street Name MM");
                                end
                                else begin

                                    Validate("MM Description New", '');
                                    validate("Address MM New", '');
                                    validate("MZ MM New", '');
                                    validate("MZ Name MM New", '');
                                    validate("Street MM New", '');

                                end;
                                "Customer No. New" := "Customer No.";
                                CG.Reset();
                                CG.SetFilter("No.", '%1', "Customer No. New");
                                if cg.FindFirst() then
                                    rec.Validate("Customer Name New", cg.Name)
                                else
                                    rec.Validate("Customer Name New", '');

                                rec.Validate("Measuring Point Code New", rec."Service Item No. - Relation");
                                rec.Validate("Measuring Point Address New", rec.Address);
                                rec.Validate("Customer No. New", rec."Customer No.");
                                rec.Validate("Customer Zone stroke New", cg."Zone stroke");
                                rec.Validate("Customer Stroke New", cg."Customer Stroke");
                                rec.Validate("Customer string New", cg."Customer String");

                                ih.Reset();
                                ih.SetFilter(Code, '%1', "New Gauges");
                                //   ih.SetFilter(type, '%1', rec."Type G_R");
                                if ("Type G_R" = "Type G_R"::Gauge_RM) or ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Corrector_RM) then
                                    iH.SetFilter(Type, '%1', iH.Type::Gauge);
                                iH.SetFilter(Type, '%1', iH.Type::Gauge);

                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                    iH.SetFilter(Type, '%1', iH.Type::Corrector);


                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                    iH.SetFilter(Type, '%1', iH.Type::Radio_Module);


                                ih.SetCurrentKey("Installation Date");
                                ih.Ascending;
                                if ih.FindLast() then begin
                                    rec.Validate("Calibration Year New", ih."Calibration Year");
                                    rec.Validate("DD calibration New", ih."DD calibration");

                                end;



                                GaguNew.Reset();

                                GaguNew.SetFilter(Code, '%1', "New Gauges");
                                if GaguNew.FindFirst() then begin

                                    rec.Validate("Production Year New", GaguNew."Year of Production");

                                    rec.Validate("DD calibration New", GaguNew."DD calibration");
                                    rec.Validate("Calibration Year New", GaguNew."DD calibration");
                                end;
                                if "Type G_R" = "Type G_R"::Gauge_RM then begin

                                    RadioR.Reset();
                                    RadioR.SetFilter("Gauge Code", '%1', rec."New Gauges");
                                    if RadioR.FindFirst() then begin
                                        validate("Radio Module Code New", RadioR.Code);
                                    end;

                                end;



                                Commit();

                            end;

                        end;


                        //korektori

                        if "Type G_R" = "Type G_R"::Corrector then begin

                            CorrectR.Reset();
                            // CorrectR.SetFilter(Code, '%1', "New Gauges");
                            CorrectR.setfilter("Customer No.", '%1|%2', rec."Customer No.", '');
                            CorrectP.SetTableView(CorrectR);
                            CorrectP.LOOKUPMODE(TRUE);
                            IF CorrectP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                US.Reset();
                                US.SetFilter("User ID", '%1', UserId);
                                if us.FindFirst() then begin
                                    us."Measuring Code" := rec."Service Item No. - Relation";
                                    us.Modify()
                                    ;
                                end;

                                CorrectP.GETRECORD(CorrectR);
                                "New Gauges" := CorrectR.Code;
                                validate("Service Item No. - Relation", GaugeR."Measuring Point");
                                "Inventory Number New" := CorrectR."Inventar number";

                                "Measuring Point Code New" := rec."Service Item No. - Relation";
                                ServiceII.reset;
                                ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                                if ServiceII.FindFirst() then begin
                                    Validate("MM Description New", ServiceII.Description);

                                    validate("Address MM New", ServiceII."Address MM");
                                    validate("MZ MM New", ServiceII."MZ MM");
                                    validate("MZ Name MM New", ServiceII."MZ Name MM");
                                    validate("Street MM New", ServiceII."Street Name MM");
                                end
                                else begin

                                    Validate("MM Description New", '');
                                    validate("Address MM New", '');
                                    validate("MZ MM New", '');
                                    validate("MZ Name MM New", '');
                                    validate("Street MM New", '');

                                end;
                                "Customer No. New" := "Customer No.";
                                CG.Reset();
                                CG.SetFilter("No.", '%1', "Customer No. New");
                                if cg.FindFirst() then
                                    rec.Validate("Customer Name New", cg.Name)
                                else
                                    rec.Validate("Customer Name New", '');

                                rec.Validate("Measuring Point Code New", rec."Service Item No. - Relation");
                                rec.Validate("Measuring Point Address New", rec.Address);
                                rec.Validate("Customer No. New", rec."Customer No.");
                                rec.Validate("Customer Zone stroke New", cg."Zone stroke");
                                rec.Validate("Customer Stroke New", cg."Customer Stroke");
                                rec.Validate("Customer string New", cg."Customer String");

                                ih.Reset();
                                ih.SetFilter(Code, '%1', "New Gauges");
                                //   ih.SetFilter(type, '%1', rec."Type G_R");
                                if ("Type G_R" = "Type G_R"::Gauge_RM) or ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Corrector_RM) then
                                    iH.SetFilter(Type, '%1', iH.Type::Gauge);
                                iH.SetFilter(Type, '%1', iH.Type::Gauge);

                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                    iH.SetFilter(Type, '%1', iH.Type::Corrector);


                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                    iH.SetFilter(Type, '%1', iH.Type::Radio_Module);


                                ih.SetCurrentKey("Installation Date");
                                ih.Ascending;
                                if ih.FindLast() then begin
                                    rec.Validate("Calibration Year New", ih."Calibration Year");
                                    rec.Validate("DD calibration New", ih."DD calibration");

                                end;

                                Correct.Reset();
                                Correct.SetFilter(Code, '%1', "New Gauges");
                                if Correct.FindFirst() then begin

                                    rec.Validate("Production Year New", Correct."Year of Production");

                                    rec.Validate("DD calibration New", Correct."DD calibration");
                                    rec.Validate("Calibration Year New", Correct."DD calibration");

                                end;



                            end;

                        end;
                        //

                        //radio module

                        //korektori

                        if "Type G_R" = "Type G_R"::Radio_Module then begin


                            RadioR.Reset();
                            //  RadioR.SetFilter(Code, '%1', Gauge);
                            RadioR.setfilter("Measuring Point Code", '%1|%2', rec."Service Item No. - Relation", '');

                            RadioP.SetTableView(RadioR);
                            RadioP.LOOKUPMODE(TRUE);
                            IF RadioP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                US.Reset();
                                US.SetFilter("User ID", '%1', UserId);
                                if us.FindFirst() then begin
                                    us."Measuring Code" := rec."Service Item No. - Relation";
                                    us.Modify()
                                    ;
                                end;

                                RadioP.GETRECORD(RadioR);
                                "New Gauges" := RadioR.Code;
                                validate("Service Item No. - Relation", RadioR."Measuring Point Code");
                                // "Inventory Number New" := RadioR."Serial Number I";
                                "Serial Number I New" := RadioR."Serial Number I";
                                "Serial Number II New" := RadioR."Serial Number II";
                                //  "Radio Module Serial I" := RadioR."Serial Number I";
                                //   "Radio Module Serial II" := RadioR."Serial Number II";
                                "Measuring Point Code New" := rec."Service Item No. - Relation";
                                ServiceII.reset;
                                ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                                if ServiceII.FindFirst() then begin
                                    Validate("MM Description New", ServiceII.Description);

                                    validate("Address MM New", ServiceII."Address MM");
                                    validate("MZ MM New", ServiceII."MZ MM");
                                    validate("MZ Name MM New", ServiceII."MZ Name MM");
                                    validate("Street MM New", ServiceII."Street Name MM");
                                end
                                else begin

                                    Validate("MM Description New", '');
                                    validate("Address MM New", '');
                                    validate("MZ MM New", '');
                                    validate("MZ Name MM New", '');
                                    validate("Street MM New", '');

                                end;
                                "Customer No. New" := "Customer No.";
                                CG.Reset();
                                CG.SetFilter("No.", '%1', "Customer No. New");
                                if cg.FindFirst() then
                                    rec.Validate("Customer Name New", cg.Name)
                                else
                                    rec.Validate("Customer Name New", '');

                                rec.Validate("Measuring Point Code New", rec."Service Item No. - Relation");
                                rec.Validate("Measuring Point Address New", rec.Address);
                                rec.Validate("Customer No. New", rec."Customer No.");
                                rec.Validate("Customer Zone stroke New", cg."Zone stroke");
                                rec.Validate("Customer Stroke New", cg."Customer Stroke");
                                rec.Validate("Customer string New", cg."Customer String");

                                ih.Reset();
                                ih.SetFilter(Code, '%1', "New Gauges");
                                //   ih.SetFilter(type, '%1', rec."Type G_R");
                                if ("Type G_R" = "Type G_R"::Gauge_RM) or ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Corrector_RM) then
                                    iH.SetFilter(Type, '%1', iH.Type::Gauge);
                                iH.SetFilter(Type, '%1', iH.Type::Gauge);

                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                    iH.SetFilter(Type, '%1', iH.Type::Corrector);


                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                    iH.SetFilter(Type, '%1', iH.Type::Radio_Module);


                                ih.SetCurrentKey("Installation Date");
                                ih.Ascending;
                                if ih.FindLast() then begin
                                    rec.Validate("Calibration Year New", ih."Calibration Year");
                                    rec.Validate("DD calibration New", ih."DD calibration");

                                end;


                                if rec."Production Year New" = 0 then begin
                                    RYear.Reset();
                                    RYear.SetFilter(Code, '%1', "New Gauges");
                                    if RYear.FindFirst() then begin
                                        "Production Year New" := RYear."Year of Production";
                                        //    "DD calibration New":=RYear.cal;
                                    end;

                                end;


                            end;

                        end;
                        //

                    end;
                }

                field("Date of consumption New"; "Date of consumption New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Reading New"; "Reading New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Allow Deviation"; "Allow Deviation") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Pressure Type New"; "Pressure Type New") { }
                field("Operating Pressure On ML New"; "Operating Pressure On ML New") { }
                field("Temperature New"; "Temperature New") { }
                field("Production Year New"; "Production Year New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Calibration Year New"; "Calibration Year New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Programming date New"; "Programming date New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Date of rescheduling New"; "Date of rescheduling New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Serial Number I New"; "Serial Number I New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Serial Number II New"; "Serial Number II New") { ApplicationArea = all; style = Favorable; Visible = true; }


                field("Radio Module Code New"; "Radio Module Code New")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        RadioR: Record "Radio Module";
                        US: Record "User Setup";
                        RadioP: page "Radio Module";
                        ServiceII: record "Service Item";
                        CG: Record customer;
                        IH: Record "Installation History";
                        ggf: RECORD Gauge;
                        rmgET: Record "Radio Module";
                        rmgRENAME: Record "Radio Module";
                    begin

                        IF REC.Type <> REC.Type::Loc THEN BEGIN
                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                Commit();
                                us."Adress MM" := Rec.Address;
                                us."Customer No." := Rec."Customer No.";
                                us."Measuring Code" := rec."Service Item No. - Relation";
                                if "New Gauges" <> '' then
                                    us."Gauge Code" := "New Gauges";
                                if "New Gauges" = '' then
                                    us."Gauge Code" := Gauge;
                                if "Type G_R" = "Type G_R"::Gauge then
                                    us."RMS Code" := "New Gauges";
                                us.Modify();
                                Commit();
                            end;
                        END;





                        RadioR.Reset();
                        //  RadioR.SetFilter(Code, '%1', Gauge);
                        RadioR.setfilter("Measuring Point Code", '%1|%2', rec."Service Item No. - Relation", '');
                        //   RadioR.SetFilter("Gauge Code", '<>%1', '');
                        RadioP.SetTableView(RadioR);
                        RadioP.LOOKUPMODE(TRUE);
                        IF RadioP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            US.Reset();
                            US.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                IF Type <> Type::Loc
 THEN BEGIN
                                    us."Measuring Code" := rec."Service Item No. - Relation";
                                    us.Modify()
                                END;
                                IF Type = Type::Loc THEN BEGIN
                                    US.GaugeInsert := REC.Gauge;
                                    US.Modify();
                                    Commit();
                                END
                                ;
                            end;

                            RadioP.GETRECORD(RadioR);
                            "Radio Module Code New" := RadioR.Code;
                            //  validate("Service Item No. - Relation", RadioR."Measuring Point Code");
                            // "Inventory Number New" := RadioR."Serial Number I";
                            "Serial Number I New" := RadioR."Serial Number I";
                            "Serial Number II New" := RadioR."Serial Number II";
                            //  "Radio Module Serial I" := RadioR."Serial Number I";
                            //  "Radio Module Serial II" := RadioR."Serial Number II";

                            "Measuring Point Code New" := rec."Service Item No. - Relation";

                            ServiceII.reset;
                            ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                            if ServiceII.FindFirst() then begin
                                Validate("MM Description New", ServiceII.Description);

                                validate("Address MM New", ServiceII."Address MM");
                                validate("MZ MM New", ServiceII."MZ MM");
                                validate("MZ Name MM New", ServiceII."MZ Name MM");
                                validate("Street MM New", ServiceII."Street Name MM");
                            end
                            else begin

                                Validate("MM Description New", '');
                                validate("Address MM New", '');
                                validate("MZ MM New", '');
                                validate("MZ Name MM New", '');
                                validate("Street MM New", '');

                            end;
                            "Customer No. New" := "Customer No.";
                            CG.Reset();
                            CG.SetFilter("No.", '%1', "Customer No. New");
                            if cg.FindFirst() then
                                rec.Validate("Customer Name New", cg.Name)
                            else
                                rec.Validate("Customer Name New", '');

                            rec.Validate("Measuring Point Code New", rec."Service Item No. - Relation");
                            rec.Validate("Measuring Point Address New", rec.Address);
                            rec.Validate("Customer No. New", rec."Customer No.");
                            rec.Validate("Customer Zone stroke New", cg."Zone stroke");
                            rec.Validate("Customer Stroke New", cg."Customer Stroke");
                            rec.Validate("Customer string New", cg."Customer String");

                            IF (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) THEN BEGIN
                                Commit();
                                rec."Gauge No." := rec.Gauge;

                                //Code, "Gauge Code", "Measuring Point Code")
                                IF rmgET.GET(RadioR.CODE, RadioR."Gauge Code", RadioR."Measuring Point Code") THEN BEGIN
                                    rmgET.RENAME(RadioR.CODE, REC.Gauge, RadioR."Measuring Point Code");
                                    ggf.RESET;
                                    ggf.SetFilter(Code, '%1', REC.Gauge);
                                    IF ggf.FindFirst() THEN
                                        rmgET."Gauge Description" := GGF."Inventar number";
                                    rmgET.Modify();
                                    "Radio Module Serial I New" := RadioR."Serial Number I";
                                    "Radio Module Serial II New" := RadioR."Serial Number II";
                                END;
                                Commit();
                            END;

                        end;

                    end;

                }
                field("Radio Module Serial I New"; "Radio Module Serial I New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Radio Module Serial II New"; "Radio Module Serial II New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Year of Production RM New"; "Year of Production RM New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Reading New RM"; "Reading New RM") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Corrector New"; "Corrector New")
                {
                    ApplicationArea = all;
                    style = Favorable;
                    Visible = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        RadioR: Record "El. Volume Corr";
                        US: Record "User Setup";
                        RadioP: page "EL. Volume Corr. List";
                        ServiceII: record "Service Item";
                        CG: Record customer;
                        IH: Record "Installation History";
                        ggf: RECORD Gauge;
                        rmgET: Record "El. Volume Corr";
                        rmgRENAME: Record "El. Volume Corr";
                        Correct: Record "El. Volume Corr";
                    begin
                        if "Type G_R" = "Type G_R"::Corrector then begin

                            RadioR.Reset();
                            //  RadioR.SetFilter(Code, '%1', Gauge);
                            RadioR.setfilter("Measuring Point", '%1|%2', rec."Service Item No. - Relation", '');
                            RadioR.SetFilter("Gauge Code", '%1', rec."Gauge No.");

                            RadioP.SetTableView(RadioR);
                            RadioP.LOOKUPMODE(TRUE);
                            IF RadioP.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                RadioP.GETRECORD(RadioR);

                                rec.Validate("Year of Production Corr New", RadioR."Year of Production");
                                rec.Validate("DD calibration Corr New", RadioR."DD calibration");
                                rec.Validate("Corrector New", RadioR.Code);
                                rec.Validate("Corrector Serial Number New", RadioR."Serial Number");

                            end;

                        end;

                        if "Type G_R" = "Type G_R"::Corrector_RM then begin

                            RadioR.Reset();
                            //  RadioR.SetFilter(Code, '%1', Gauge);
                            RadioR.setfilter("Measuring Point", '%1|%2', rec."Service Item No. - Relation", '');
                            RadioR.SetFilter("Gauge Code", '%1', rec."New Gauges");

                            RadioP.SetTableView(RadioR);
                            RadioP.LOOKUPMODE(TRUE);
                            IF RadioP.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                RadioP.GETRECORD(RadioR);

                                rec.Validate("Year of Production Corr New", RadioR."Year of Production");
                                rec.Validate("DD calibration Corr New", RadioR."DD calibration");
                                rec.Validate("Corrector New", RadioR.Code);
                                rec.Validate("Corrector Serial Number New", RadioR."Serial Number");

                            end;

                        end;


                    end;
                }
                field("Corrector Serial Number New"; "Corrector Serial Number New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Model New"; "Model New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Year of Production Corr New"; "Year of Production Corr New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("DD calibration Corr New"; "DD calibration Corr New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Reading New Corrector"; "Reading New Corrector") { ApplicationArea = all; style = Favorable; Visible = true; }

                field("Adjusted Volume New"; "Adjusted Volume New") { }
                field("Unadjusted Volume New"; "Unadjusted Volume New") { }
                field("Absolute Pressure Of Corr. New"; "Absolute Pressure Of Corr. New") { }
                field("Temperature Value New"; "Temperature Value New") { }
                field("Correction Factor New"; "Correction Factor New") { }

                field(Applied; Applied) { }

                field("Inventory Number New"; "Inventory Number New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Measuring Point Code New"; "Measuring Point Code New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Measuring Point Address New"; "Measuring Point Address New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Customer No. New"; "Customer No. New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Customer Name New"; "Customer Name New") { ApplicationArea = all; style = Favorable; Visible = true; }


                field("Dwelling Type"; Rec."Dwelling Type")
                {
                    ApplicationArea = All;
                }
                field(Elevation; Rec.Elevation)
                {
                    ApplicationArea = All;
                }
                field("Reading Mode"; Rec."Reading Mode")
                {
                    ApplicationArea = All;
                }

                field("Work Order Created"; "Work Order Created")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        SHCard: page "Request Card";

                    begin
                        SH.Reset();
                        SH.SetFilter("No.", '%1', rec."CZK ID");
                        SHCard.SetTableView(sh);
                        SHCard.Run();


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        SHCard: page "Request Card";

                    begin
                        SH.Reset();
                        SH.SetFilter("No.", '%1', rec."CZK ID");
                        SHCard.SetTableView(sh);
                        SHCard.Run();


                    end;


                }
                field("Work Order Applied"; "Work Order Applied")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        SHCard: page "Request Card";

                    begin
                        SH.Reset();
                        SH.SetFilter("No.", '%1', rec."CZK ID");
                        SHCard.SetTableView(sh);
                        SHCard.Run();


                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        SHCard: page "Request Card";

                    begin
                        SH.Reset();
                        SH.SetFilter("No.", '%1', rec."CZK ID");
                        SHCard.SetTableView(sh);
                        SHCard.Run();


                    end;
                }
                field("CZK ID"; "CZK ID") { }
                field("Return RN"; "Return RN") { }


                //kraj
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("Line")
            {
                Caption = 'Line';
                Image = Line;
                action("Service Item Worksheet")
                {
                    ApplicationArea = Service;
                    Caption = 'Service Item Worksheet';
                    Image = ServiceItemWorksheet;
                    RunObject = Page "Service Item Worksheet Archive";
                    RunPageLink = "Document Type" = FIELD("Document Type"),
                                                  "Document No." = FIELD("Document No."),
                                  "Line No." = FIELD("Line No."), "Version No." = field("Version No.");
                    ShortCutKey = 'Shift+F7';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        sh: Record "Service Header";
        DIsman: Record "Dismantling Reason";
    begin
        CountV := rec.Count;
        CalcFields("Work Order Created", "Work Order Applied");
        if "Request type" = "Request type"::"Project and Energy Accordance" then
            TypeVisible := true
        else
            TypeVisible := false;
        sh.Reset();
        sh.SetFilter("No.", '%1', rec."Document No.");
        sh.SetFilter("Document Type", '%1', rec."Document Type");
        if sh.FindFirst() then begin
            if sh."Massive Code" <> ''
            then
                Massive := true
            else
                Massive := false;
        end;

        sh.Reset();
        sh.SetFilter("No.", '%1', rec."Document No.");
        if sh.FindFirst() then begin
            Disman.Reset();
            Disman.SetFilter(Description, '%1', sh."Reason For Service Order");
            if Disman.FindFirst() then begin
                if Disman."Gauge replacement" = true then
                    Massive := true
            end;
        end;



    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        sh: Record "Service Header";
        DIsman: Record "Dismantling Reason";
    begin
        CountV := rec.Count;
        CalcFields("Work Order Created", "Work Order Applied");
        if "Request type" = "Request type"::"Project and Energy Accordance" then
            TypeVisible := true
        else
            TypeVisible := false;

        sh.Reset();
        sh.SetFilter("No.", '%1', rec."Document No.");
        sh.SetFilter("Document Type", '%1', rec."Document Type");
        if sh.FindFirst() then begin
            if sh."Massive Code" <> ''
            then
                Massive := true
            else
                Massive := false;
        end;
        sh.Reset();
        sh.SetFilter("No.", '%1', rec."Document No.");
        if sh.FindFirst() then begin
            Disman.Reset();
            Disman.SetFilter(Description, '%1', sh."Reason For Service Order");
            if Disman.FindFirst() then begin
                if Disman."Gauge replacement" = true then
                    Massive := true
            end;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        SH: record "Service Header";
        Disman: Record "Dismantling Reason";
    begin
        CountV := rec.Count;
        CalcFields("Work Order Created", "Work Order Applied");
        if "Request type" = "Request type"::"Project and Energy Accordance" then
            TypeVisible := true
        else
            TypeVisible := false;
        sh.Reset();
        sh.SetFilter("No.", '%1', rec."Document No.");
        sh.SetFilter("Document Type", '%1', rec."Document Type");
        if sh.FindFirst() then begin
            if sh."Massive Code" <> ''
            then
                Massive := true
            else
                Massive := false;


            sh.Reset();
            sh.SetFilter("No.", '%1', rec."Document No.");
            if sh.FindFirst() then begin
                Disman.Reset();
                Disman.SetFilter(Description, '%1', sh."Reason For Service Order");
                if Disman.FindFirst() then begin
                    if Disman."Gauge replacement" = true then
                        Massive := true
                end;
            end;

        end;

    end;


    procedure GetFiterFind(GetFilterSent: Boolean; MMCode: code[20]; ServHNo: code[20]) Rez: Boolean;
    var
        filters: text[250];
        InsertYes: Record "Service Item Line";
        ServiceItemLine: Record "Service Item Line";
        NewServiceItemLine: Record "Service Item Line";

    begin
        if GetFilterSent = true then begin

            filters := rec.GetFilters;
            if filters <> '' then
                rez := true
            else
                Rez := False;
            if ServHNo <> '' then begin
                ServiceItemLine.Reset();
                ServiceItemLine.CopyFilters(Rec);
                if ServiceItemLine.FindSet() then
                    repeat

                        NewServiceItemLine.Init();
                        NewServiceItemLine.TransferFields(ServiceItemLine, false);
                        NewServiceItemLine."Document Type" := "Document Type";
                        NewServiceItemLine."CZK ID" := ServiceItemLine."Document No.";
                        NewServiceItemLine."Document No." := ServHNo;
                        NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                        NewServiceItemLine.Applied := false;
                        NewServiceItemLine.Insert();

                    until ServiceItemLine.Next() = 0;
            end;

        end;
        if MMCode <> '' then begin
            InsertYes.Reset();
            InsertYes.CopyFilters(rec);
            InsertYes.SetFilter("Service Item No. - Relation", '%1', MMcode);
            if InsertYes.FindFirst() then begin
                Rez := true;
            end
            else begin
                Rez := false;
            end;

        end;

        if filters <> '' then begin
        end;

    end;

    var
        Text005: Label 'Do you want to add all measuring point into Service Item line?';
        TypeVisible: Boolean;
        Massive: Boolean;
        CountV: Integer;
}
