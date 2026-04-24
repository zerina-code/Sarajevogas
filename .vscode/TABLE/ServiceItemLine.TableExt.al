tableextension 50069 ServiceItemLine extends "Service Item Line"
{
    fields
    {

        modify("Service Item No.")
        {
            // TableRelation = "Service Item"."No." where("Customer No." = field("Customer No."));


            trigger OnBeforeValidate()
            begin
                OnBeforeValidateServiceItemNo();
            end;
        }
        modify("Customer No.")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Cuf: Record Customer;
            begin
                cuf.Reset();
                cuf.SetFilter("No.", '%1', "Customer No.");
                if cuf.FindFirst() then
                    "Customer Name" := cuf.Name
                else
                    "Customer Name" := '';
            end;
        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }


        field(50111; "Service Item No. - Relation"; Code[20])
        {
            Caption = 'Service Item No.';
            //   TableRelation = "Service Item"."No." where("Customer No." = field("Customer No."));

            trigger OnValidate()
            var
                myInt: Integer;
                RMF: Record "Radio Module";
                Gauge: Record Gauge;
                IH: Record "Installation History";
                SH: Record "Service Header";
                GaugeSerial: Record Gauge;
                MMFirst: record "Service Item";
                FA: Record "Fixed Asset";
                CorrectorF: Record "El. Volume Corr";
                RadioM: Record "Radio Module";
                IHC: Record "Installation History";
                US: record "User Setup";
                SHUpdate: record "Service Header";
                SL: record "Service Item Line";
            //samo ako je jedan mjerač i jedno MM


            begin


                if Type = Type::OS then begin

                    FA.Reset();
                    fa.SetFilter("No.", '%1', "Service Item No. - Relation");
                    if fa.FindFirst() then begin
                        rec.Mark := fa.Mark;
                        rec.Address := fa.Address;
                        rec.street := fa."Home No.";

                    end;
                end;
                if Type = Type::MM then begin

                    Validate("Service Item No.", "Service Item No. - Relation");

                    SL.Reset();
                    SL.SetFilter("Document No.", '%1', rec."Document No.");
                    sl.setfilter(RMS, '<>%1', rec.RMS);
                    if not sl.FindFirst() then begin

                    end;


                    MMFirst.Reset();
                    MMFirst.SetFilter("No.", '%1', "Service Item No. - Relation");
                    if MMFirst.FindFirst() then
                        rec.Validate("Customer No.", MMFirst."Customer No.");
                    rec.Validate("Phone No. MM", MMFirst."Phone No. MM");
                    rec.Validate(Remotely, MMFirst.Remotely);
                    rec.Validate("Remotely Type", MMFirst."Remotely Type");
                    IHC.Reset();
                    ihc.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                    ihc.SetFilter(Type, '%1', ihc.Type::Corrector);
                    ihc.SetFilter(Active, '%1', true);
                    ihc.SetFilter("Customer No.", '%1', rec."Customer No.");
                    if ihc.FindFirst() then begin
                        Validate(Corrector, IHC.Code);
                        CorrectorF.Reset();
                        CorrectorF.SetFilter(Code, '%1', ihc.code);
                        if CorrectorF.FindFirst() then begin
                            Validate("Corrector Serial Number", CorrectorF."Serial Number");

                            Validate(Model, CorrectorF.Model);
                            Validate("Year of Production Corr Old", CorrectorF."Year of Production");
                            Validate("DD calibration Corr Old", CorrectorF."DD calibration");
                        end;
                    end
                    else begin
                        Corrector := '';
                        "Corrector Serial Number" := '';
                        Model := '';
                        Validate("Year of Production Corr Old", 0);
                        Validate("DD calibration Corr Old", 0);
                    end;
                    IH.Reset();
                    IH.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                    iH.SetFilter(Active, '%1', true);
                    //  Ih.SetFilter(Type, '%1', rec."Type G_R");
                    if ("Type G_R" = "Type G_R"::Gauge_RM) or ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Corrector_RM) then
                        iH.SetFilter(Type, '%1', iH.Type::Gauge);

                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                        iH.SetFilter(Type, '%1', iH.Type::Corrector);


                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                        iH.SetFilter(Type, '%1', iH.Type::Radio_Module);
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    us.FindFirst();
                    if us.Today = true then begin
                        IH.SetFilter("Installation Date", '<=%1', WorkDate());

                    end
                    else begin
                        SH.Reset();
                        SH.SetFilter("No.", '%1', rec."Document No.");
                        if sh.FindFirst() then
                            IH.SetFilter("Installation Date", '<=%1', sh."Document Date");
                    end;
                    // IH.SetFilter("Dismantling date", '%1|>=%2', 0D, sh."Document Date");
                    ih.SetCurrentKey("Installation Date");
                    ih.Ascending;
                    if ih.FindLast() then begin
                        rec.validate("Customer No.", ih."Customer No.");

                        rec.Gauge := ih.Code;
                        GaugeSerial.Reset();
                        GaugeSerial.SetFilter("Code", '%1', rec.Gauge);
                        if GaugeSerial.FindFirst() then begin
                            rec.RMS := GaugeSerial."Inventar number";
                            rec."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                            rec."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                            rec."Gauge Size" := GaugeSerial."Gauge Size";
                            rec."Year of Production" := GaugeSerial."Year of Production";
                            rec."DD calibration" := GaugeSerial."DD calibration";
                        end
                        else begin
                            Rec.RMS := '';
                            rec."Meter Manufacturer" := '';
                            rec."Meter Manufacturer Desc" := '';
                            rec."Gauge Size" := '';
                            rec."Year of Production" := 0;
                            rec."DD calibration" := 0;
                        end;
                    end;
                end;
                IF Type = Type::MM THEN BEGIN
                    IHC.Reset();
                    ihc.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                    ihc.SetFilter(Type, '%1', ihc.Type::Radio_Module);
                    ihc.SetFilter("Customer No.", '%1', rec."Customer No.");
                    ihc.SetFilter(Active, '%1', true);
                    if ihc.FindFirst() then begin
                        RMF.reset;
                        RMF.setfilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                        RMF.setfilteR("Gauge Code", '%1', rec.Gauge);
                        RMF.setfilter(Code, '%1', ihc.Code);
                        // "Radio Module".Code where("Gauge Code" = field("Gauge No."), "Measuring Point Code" = field("Service Item No. - Relation"));

                        if RMF.findfirst then begin
                            Validate("Radio Module Code", IHC.Code);


                            RadioM.Reset();
                            RadioM.SetFilter(Code, '%1', ihc.code);
                            if RadioM.FindFirst() then begin
                                Validate("Radio Module Serial I", RadioM."Serial Number I");
                                Validate("Year of Production RM", RadioM."Year of Production");
                                Validate("Type Radio Module", RadioM."Type Radio Module");
                                Validate("Radio Module Serial II", RadioM."Serial Number II");
                            end;
                        end;
                    end;
                END;

                /*     us.Reset();
                     us.SetFilter("User ID", '%1', UserId);
                     if us.FindFirst() then begin
                         if us.Upd = false then begin


                             SHUpdate.reset;
                             shupdate.setfilter("No.", '%1', rec."Document No.");
                             ShUpdate.setfilter("Document Type", '%1', rec."Document Type");
                             if shupdate.FindFirst() then begin


                                 SHUpdate."Filters by Gauge" := rec.rms;
                                 SHUpdate."Filters by Measuring point" := rec."Service Item No. - Relation";
                                 SHUpdate.modify;
                             end;
                         end;
                     end;
     */

            end;
        }

        field(50000; "Gauge No."; Code[20])
        {
            Caption = 'Gauge No.';

            DataClassification = CustomerContent;
            TableRelation = Gauge where("Customer No." = field("Customer No."));
            trigger OnValidate()
            var
                myInt: Integer;
                Gauge: Record Gauge;
                IH: Record "Installation History";
                SH: Record "Service Header";
                GaugeSerial: Record Gauge;

            begin

                IH.Reset();
                //   IH.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                iH.SetFilter(Active, '%1', true);
                Ih.SetFilter(Type, '%1', IH.Type::Gauge);
                ih.SetFilter(Code, '%1', rec.Gauge);
                SH.Reset();
                SH.SetFilter("No.", '%1', rec."Document No.");
                if sh.FindFirst() then
                    IH.SetFilter("Installation Date", '<=%1', sh."Document Date");
                //  IH.SetFilter("Dismantling date", '%1|>=%2', 0D, sh."Document Date");
                ih.SetCurrentKey("Installation Date");
                ih.Ascending;
                if ih.FindLast() then begin

                    //    rec.Gauge := ih.Code;
                    rec.RMS := ih."Inventory Number";

                    GaugeSerial.Reset();
                    GaugeSerial.SetFilter("Code", '%1', rec.Gauge);
                    if GaugeSerial.FindFirst() then begin
                        rec.RMS := GaugeSerial."Inventar number";
                        rec."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                        rec."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                        rec."Gauge Size" := GaugeSerial."Gauge Size";
                        rec."Year of Production" := GaugeSerial."Year of Production";
                        rec."DD calibration" := GaugeSerial."DD calibration";
                    end
                    else begin
                        Rec.RMS := '';
                        rec."Meter Manufacturer" := '';
                        rec."Meter Manufacturer Desc" := '';
                        rec."Gauge Size" := '';
                        rec."Year of Production" := 0;
                        rec."DD calibration" := 0;
                    end;

                end;

            end;

        }
        field(50001; "Purpose"; Text[250])
        {
            Caption = 'Purpose';
            DataClassification = CustomerContent;
            TableRelation = Purpose.Description where(Type = const(MM));
        }
        field(50002; "Dwelling Type"; Text[250])
        {
            Caption = 'Dwelling Type';
            DataClassification = CustomerContent;
            TableRelation = "Dwelling Type".Description;
        }
        field(50003; Elevation; Decimal)
        {
            Caption = 'Elevation';
            DataClassification = CustomerContent;
        }
        field(50004; "Reading Mode"; Option)
        {
            Caption = 'Reading Mode';
            DataClassification = CustomerContent;
            OptionMembers = ,"Reading List","Digital";
            OptionCaption = ' ,Reading List,Digital';
        }
        field(50005; "MM Category"; Enum Category)
        {
            Caption = 'MM Category';
            DataClassification = CustomerContent;
        }
        field(50006; "Consent ID"; code[20])
        {
            Caption = 'Consent ID';
            //  FieldClass = FlowField;
            //CalcFormula = lookup(Consent.Code where("Measuring Point Code" = field("Service Item No."), Active = const(true)));
            //   Editable = false;
        }

        field(50032; "Gas Installation Data"; Integer)
        {
            Caption = 'Gas Installation Data';
            FieldClass = FlowField;
            CalcFormula = count("Gas Installation Data" where("Measure Point No." = field("Service Item No."), "Gauge No." = field(Gauge),
            "Customer No." = field("Customer No.")));
            Editable = false;
        }

        field(50007; "Gauge"; Code[20])
        {
            Caption = 'Gauge';
            TableRelation = Gauge.No where("Customer No." = field("Customer No."), "Measuring Point" = field("Service Item No. - Relation"));          // FieldClass = FlowField;
                                                                                                                                                       // CalcFormula = count(Gauge where("Measuring Point" = field("Service Item No.")));
                                                                                                                                                       // Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
                Gauge: Record Gauge;
                IH: Record "Installation History";
                SH: Record "Service Header";
                GaugeSerial: Record Gauge;
                RMF: Record "Radio Module";


            begin

                IH.Reset();
                //   IH.SetFilter("Measuring Point Code", '%1', "Service Item No. - Relation");
                iH.SetFilter(Active, '%1', true);
                Ih.SetFilter(Type, '%1', IH.Type::Gauge);
                ih.SetFilter(Code, '%1', rec.Gauge);
                SH.Reset();
                SH.SetFilter("No.", '%1', rec."Document No.");
                if sh.FindFirst() then
                    IH.SetFilter("Installation Date", '<=%1', sh."Document Date");
                //  IH.SetFilter("Dismantling date", '%1|>=%2', 0D, sh."Document Date");
                ih.SetCurrentKey("Installation Date");
                ih.Ascending;
                if ih.FindLast() then begin

                    //    rec.Gauge := ih.Code;
                    rec.RMS := ih."Inventory Number";

                    GaugeSerial.Reset();
                    GaugeSerial.SetFilter("Code", '%1', rec.Gauge);
                    if GaugeSerial.FindFirst() then begin
                        rec.RMS := GaugeSerial."Inventar number";
                        rec."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                        rec."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                        rec."Gauge Size" := GaugeSerial."Gauge Size";
                        rec."Year of Production" := GaugeSerial."Year of Production";
                        rec."DD calibration" := GaugeSerial."DD calibration";
                    end
                    else begin
                        Rec.RMS := '';
                        rec."Meter Manufacturer" := '';
                        rec."Meter Manufacturer Desc" := '';
                        rec."Gauge Size" := '';
                        rec."Year of Production" := 0;
                        rec."DD calibration" := 0;
                    end;
                END
                else begin

                    GaugeSerial.Reset();
                    GaugeSerial.SetFilter("Code", '%1', rec.Gauge);
                    if GaugeSerial.FindFirst() then begin
                        rec.RMS := GaugeSerial."Inventar number";
                        rec."Meter Manufacturer" := GaugeSerial."Meter Manufacturer";
                        rec."Meter Manufacturer Desc" := GaugeSerial."Meter Manufacturer Desc";
                        rec."Gauge Size" := GaugeSerial."Gauge Size";
                        rec."Year of Production" := GaugeSerial."Year of Production";
                        rec."DD calibration" := GaugeSerial."DD calibration";
                    end;

                end;
                if Type = Type::Loc then "Type G_R" := "Type G_R"::Radio_Module;

                IF (Type = Type::Loc) and ("Type G_R" = "Type G_R"::Radio_Module) THEN BEGIN
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
            END;
        }
        field(50008; "Total installed kW"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Total Installed kW', Comment = 'Ukupno instalisano opt. (kW)';
        }
        field(50009; "Number of Measure Points"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Number of Measure Points';
        }
        field(50010; "Corrector"; Code[20])
        {
            Caption = 'Corrector';

            TableRelation = "El. Volume Corr".Code where("Customer No." = field("Customer No."), "Measuring Point" = field("Service Item No. - Relation"));
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
                ELVolume: Record "El. Volume Corr";
            begin
                ELVolume.Reset();
                ELVolume.SetFilter(Code, '%1', Corrector);
                if ELVolume.FindFirst() then begin
                    Validate("Corrector Serial Number", ELVolume."Serial Number");

                    Validate(Model, ELVolume.Model);
                    Validate("Year of Production Corr Old", ELVolume."Year of Production");
                    Validate("DD calibration Corr Old", ELVolume."DD calibration");
                end;
            end;
        }
        field(50011; "Status MM"; enum "Status Cust/MM")
        {
            Caption = 'Status MM';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Status History MM"."Information of processing" where(Active = const(true), "Measuring Point" = field("Service Item No."), "Source Table" = filter(5900)));
        }

        field(50100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
            trigger OnValidate()
            var
                MunicipalityRecord: Record Municipality;
            begin
                "Municipality Name" := '';
                if MunicipalityRecord.Get("Municipality Code", MunicipalityRecord.type::regular) then
                    "Municipality Name" := MunicipalityRecord.Name;
            end;
        }
        field(50101; "Municipality Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Name';
        }

        field(50102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
            trigger OnValidate()
            var
                MZRecord: Record MZ;
            begin
                "MZ Name" := '';
                if MZRecord.Get(MZ) then
                    "MZ Name" := MZRecord.Description;
            end;
        }
        field(50103; "MZ Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'MZ Name';
        }

        field(50104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }

        field(50105; "Street Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Street Name';
        }
        field(50106; "Street No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Street No.';
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }
        field(50107; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(50108; "String"; Integer)
        {
            Caption = 'String', Comment = 'Niz';
            TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field(MZ), Street = field(Street), "Municipality Code" = field("Municipality Code"));
            DataClassification = CustomerContent;
        }
        field(50109; "Stroke"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stroke', Comment = 'Hod';
            TableRelation = Stroke.Code where("MZ-Code" = field(MZ), Street = field(Street), "Municipality Code" = field("Municipality Code"));
        }
        field(50110; "Zone Stroke"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Zone Stroke', Comment = 'Zona hoda';
        }

        field(50112; "Gauge Size"; text[250])
        {
            Caption = 'Gauge size';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(50113; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = MM,"OS","Loc";
            OptionCaption = 'MM,OS,Loc';

        }

        field(50114; "RMS"; Code[20])

        {
            Caption = 'RMS';

        }
        field(50115; "New Gauges"; Code[20])

        {
            Caption = 'New Gauges';
            //ovo je novi mjerač
            TableRelation = IF ("Type G_R" = CONST(Gauge)) "Gauge"

            ELSE
            if ("Type G_R" = const(Gauge_RM)) Gauge else
            IF ("Type G_R" = CONST(Corrector))
                                      "El. Volume Corr" else
            IF ("Type G_R" = CONST(Radio_Module)) "Radio Module";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
                GYear: Record Gauge;
                CYear: Record "El. Volume Corr";
                Cust: Record customer;
                ServiceII: Record "Service Item";
                CG: Record Customer;
                ih: Record "Installation History";
                GaguNew: Record Gauge;
                Correct: Record "El. Volume Corr";
                RadioM: Record "Radio Module";
                RYear: Record "Radio Module";
            begin

                //   rec.CalcFields(mz)
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

                if "Type G_R" = "Type G_R"::Gauge then begin
                    GaguNew.Reset();

                    GaguNew.SetFilter(Code, '%1', "New Gauges");
                    if GaguNew.FindFirst() then begin
                        rec.Validate("Production Year New", GaguNew."Year of Production");
                        //  if (rec."DD calibration New" = 0) or (rec."DD calibration New" < GaguNew."DD calibration") then begin
                        rec.Validate("DD calibration New", GaguNew."DD calibration");
                        rec.Validate("Calibration Year New", GaguNew."DD calibration");
                        rec.Validate("Gauge Size New", GaguNew."Gauge Size");
                        rec.Validate("Measurer manufacturer New", GaguNew."Meter Manufacturer Desc");
                        //   end;
                    end;


                end;



                /*if "Type G_R" = "Type G_R"::Corrector then begin


                     Correct.Reset();
                     Correct.SetFilter(Code, '%1', "New Gauges");
                     if Correct.FindFirst() then begin
                         rec.Validate("Production Year New", Correct."Year of Production");
                         if ("DD calibration New" = 0) or ("DD calibration New" < Correct."DD calibration") then begin
                             rec.Validate("DD calibration New", Correct."DD calibration");
                             rec.Validate("Calibration Year New", Correct."DD calibration");
                         end;

                     end;



                 end;*/



                if "Type G_R" = "Type G_R"::Radio_Module then begin


                    RadioM.Reset();
                    RadioM.SetFilter(Code, '%1', "New Gauges");
                    if Correct.FindFirst() then begin
                        rec.Validate("Production Year New", RadioM."Year of Production");
                        //  rec.Validate("DD calibration New", RadioM."DD calibration");
                        rec.Validate("Serial Number I New", RadioM."Serial Number I");
                        rec.Validate("Serial Number II New", RadioM."Serial Number II");
                        rec.Validate("Type Radio Module New", RadioM."Type Radio Module");
                        //ovdje dodati tip novi

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




        }

        field(50116; "Home No. MM"; Code[5])
        {
            Caption = 'Home No.';
            //ĐK   TableRelation = Street."Home No." where(Code = field(Street));
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //ĐK   Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";

            end;
        }
        field(50117; "Apartment No. MM"; Code[5])
        {
            Caption = 'Apartment No.';
            //  TableRelation = Street."Apartment No." where(Code = field(Street), "Home No." = field("Home No."), Floor = field(Floor));
        }
        field(50118; "Floor MM"; code[20])
        {
            Caption = 'Floor MM';
            //   TableRelation = Street.Floor where(Code = field(Street), "Home No." = field("Home No."));


        }
        field(50119; "Street No. Text MM"; text[250])
        {
            Caption = 'Street No. text MM';
        }
        field(50120; "Date of consumption"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                // if "Dismantling date New" = 0D then
                "Dismantling date New" := "Date of consumption";
                //  if "Installation Date New" = 0D then
                "Installation Date New" := "Date of consumption";
                "Date of consumption New" := "Date of consumption";




            end;

        }
        field(50121; "Reading"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading';

        }
        field(50122; "Meter Manufacturer"; Text[250])
        {
            Caption = 'Meter Manufacturer';
            TableRelation = Manufacturer;
            trigger OnValidate()
            var
                myInt: Integer;
                Manufacturer: Record Manufacturer;
            begin
                Manufacturer.reset;
                Manufacturer.setfilteR("Code", '%1', "Meter Manufacturer");
                if Manufacturer.findfirst then
                    "Meter Manufacturer Desc" := Manufacturer.name
                else
                    "Meter Manufacturer Desc" := '';
            end;
        }
        field(50123; "Year of Production"; Integer)
        {
            Caption = 'Year of Production"';

        }
        field(50124; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(50125; "Request type"; enum "Request Type")
        {
            Caption = 'Request Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Type" where("No." = field("Document No.")));

        }

        field(50126; "Gas Appliance"; Integer)
        {
            Caption = 'Gas Appliance';
            FieldClass = FlowField;
            CalcFormula = count("Gas Appliance" where("Measure Point No." = field("Service Item No."), "Gas Install. Data Entry No." = filter(<> 0)));
            Editable = false;
        }
        field(50127; "Meter Manufacturer Desc"; Text[250])
        {
            Caption = 'Meter Manufacturer Desc';
            //  TableRelation = Manufacturer;
        }
        field(50128; "Return RN"; Boolean)
        {
            Caption = 'Return RN';
        }
        field(50129; "Inventory Number New"; Code[20]) { Caption = 'Inventory Number'; }

        field(50130; "Gauge Size New"; text[250])
        {
            Caption = 'Gauge Size New';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));

        }
        field(50131; "Date of consumption New"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date of consumption New';

        }
        field(50132; "Reading New"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New';

        }
        //new value

        field(50133; "Measuring Point Address New"; Text[250]) { Caption = 'Measuring Point Address New'; }


        //ovdje će sve biti new



        field(50134; "Measurer manufacturer New"; Text[250]) { Caption = 'Measurer manufacturer New'; }
        field(50135; "Production Year New"; Integer) { Caption = 'Production Year New'; }
        field(50136; "Calibration Year New"; Integer) { Caption = 'Calibration Year New'; }


        field(50138; "Serial Number I New"; text[250]) { Caption = 'Serial Number I New'; }
        field(50139; "Serial Number II New"; text[250]) { Caption = 'Serial Number New'; }

        field(50140; "Dismantling date New"; Date)
        {
            Caption = 'Dismantling date New';
        }
        field(50141; "Programming date New"; Date) { Caption = 'Programming date New'; }
        field(50142; "Date of rescheduling New"; date) { Caption = 'Date of rescheduling New'; }

        field(50143; "DD calibration New"; Integer) { Caption = 'DD calibration new'; }

        field(50144; "Reason for dismantling New"; Text[250])
        {
            Caption = 'Reason for dismantling';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
            trigger OnValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
                SILine: Record "Service Item Line";
                SILine2: Record "Service Item Line";
            begin
                if "Date of consumption" = 0D then
                    "Date of consumption" := today;

                if "Date of consumption New" = 0D then
                    "Date of consumption New" := today;

                if "Dismantling date New" = 0D then
                    "Dismantling date New" := today;

                if "Installation Date New" = 0D then
                    "Installation Date New" := today;

                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    if us.HS = true then begin
                        SILine.Reset();
                        SILine.SetFilter("Document No.", '%1', rec."Document No.");
                        SILine.SetFilter("Reason for dismantling New", '%1', '');
                        SILine.SetFilter("Line No.", '<>%1', rec."Line No.");
                        if SILine.FindFirst() then begin
                            if Confirm('Da li želite svim ostalim linijama ovog RN dodijeliti istu aktivnost?') then begin

                                SILine2.Reset();
                                SILine2.SetFilter("Document No.", '%1', rec."Document No.");
                                SILine2.SetFilter("Reason for dismantling New", '%1', '');
                                SILine2.SetFilter("Line No.", '<>%1', rec."Line No.");
                                if SILine2.FindSet() then
                                    repeat
                                        SILine2.Validate("Reason for dismantling New", rec."Reason for dismantling New");
                                        SILine2.Modify();
                                    until SILine2.Next() = 0;

                            end;


                        end;
                    end;
                end;


            end;
        }
        field(50145; "Customer No. New"; Code[20])
        {
            Caption = 'Customer No. New';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                CG: record "Customer";
            begin
                CG.Reset();
                CG.SetFilter("No.", '%1', "Customer No. New");
                if cg.FindFirst() then
                    rec.Validate("Customer Name New", cg.Name)
                else
                    rec.Validate("Customer Name New", '');

            end;
        }
        field(50146; "Customer Name New"; Text[250])
        {
            Caption = 'Customer Name New';

        }
        field(50147; "Customer City New"; Text[30])
        {
            //  CalcFormula = Lookup(Customer.City WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer City New';
            Editable = false;
            //   FieldClass = FlowField;
            TableRelation = "Post Code".City;
            ValidateTableRelation = false;
        }
        field(50148; "Municipality Code MM New"; code[20])
        {
            Caption = 'Municipality Code MM New';
            TableRelation = Municipality.Code where(type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
                PostCode: Record "Post Code";
            begin
                /*     Mun.Reset();
                     Mun.SetFilter(Code, '%1', "Municipality Code MM");
                     if Mun.FindFirst() then begin
                         City := Mun.City;
                         PostCode.Reset();
                         PostCode.SetFilter(City, '%1', City);
                         if PostCode.FindFirst() then
                             "Post Code" := PostCode.Code
                         else
                             "Post Code" := '';
                     end
                     else begin
                         City := '';
                         "Post Code" := '';
                     end;*/

            end;
        }
        field(50149; "Customer Zone stroke New"; Integer)
        {
            Caption = 'Customer Zone stroke New';

        }
        field(50150; "Street Name MM New"; Text[250])
        {
            Caption = 'Street Name MM New';
            // FieldClass = FlowField;
            //CalcFormula = lookup(Street.Description where(Code = field(Street)));
        }

        field(50151; "Customer Post Code New"; Code[20])
        {
            //   CalcFormula = Lookup(Customer."Post Code" WHERE("No." = FIELD("Customer No.")));
            Caption = 'Post Code';
            Editable = false;
            //  FieldClass = FlowField;
        }
        field(50152; "Street No. MM New"; Code[20])
        {
            Caption = 'Street No. MM New';
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                /*   if ("Street No. MM" <> '') and (Street <> '') then begin

                       StreetText := TestSubsCu.RemoveLetter("Street No.");
                       Evaluate(StreetInteger, StreetText);
                       Even := TestSubsCu.EvenOrOdd(StreetInteger);
                       if Even = true then begin
                           Stroke.Reset();
                           Stroke.SetFilter(Street, '%1', Street);
                           Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';
                               //ĐK       "Street Customer" := '';
                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;
                           //tražim parne

                       end
                       else begin

                           Stroke.Reset();
                           Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                           Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                           Stroke.SetFilter(Street, '%1', "Street");
                           if Stroke.FindFirst() then begin
                               Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                               Rec.Validate("MZ MM", Stroke."MZ-Code");

                               Rec.Validate("Measuring Point Stroke", Stroke.Code);
                               Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                               Rec.Validate("Zone stroke", Stroke."Zone stroke");
                           end
                           else begin
                               "Municipality Code MM" := '';
                               "MZ MM" := '';

                               "Measuring Point Stroke" := 0;
                               "Measuring Point String" := 0;
                               "Zone stroke" := 0;

                           end;


                       end;
                   end
                   else begin

                       "Municipality Code MM" := '';
                       "MZ MM" := '';
                       "Measuring Point Stroke" := 0;
                       "Measuring Point String" := 0;
                       "Zone stroke" := 0;


                   end;


                   CalcFields("Street Name MM");

                   Address := "Street Name MM" + ' ' + "Street No.";
                   "Address MM" := Address;*/
            end;

        }
        field(50153; "MM Description New"; Text[100])
        {
            Caption = 'MM Description New';

            trigger OnValidate()
            begin

            end;
        }
        field(50154; "Customer Address New"; Text[100])
        {
            //     CalcFormula = Lookup(Customer.Address WHERE("No." = FIELD("Customer No.")));
            Caption = 'Customer Address New';
            Editable = false;
            //   FieldClass = FlowField;
        }

        field(50155; "Address MM New"; text[250])
        {
            Caption = 'Address MM New';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //   Address := "Address MM";

            end;


        }
        field(50156; "Street MM New"; code[20])
        {
            Caption = 'Street MM New';
            TableRelation = Street.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                /*                if ("Street No." <> '') and (Street <> '') then begin

                                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                                    Evaluate(StreetInteger, StreetText);
                                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                                    if Even = true then begin
                                        Stroke.Reset();
                                        Stroke.SetFilter(Street, '%1', Street);
                                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';
                                            //ĐK       "Street Customer" := '';
                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;
                                        //tražim parne

                                    end
                                    else begin

                                        Stroke.Reset();
                                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                                        Stroke.SetFilter(Street, '%1', "Street");
                                        if Stroke.FindFirst() then begin
                                            Rec.Validate("Municipality Code MM", Stroke."Municipality Code");
                                            Rec.Validate("MZ MM", Stroke."MZ-Code");

                                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                                        end
                                        else begin
                                            "Municipality Code MM" := '';
                                            "MZ MM" := '';

                                            "Measuring Point Stroke" := 0;
                                            "Measuring Point String" := 0;
                                            "Zone stroke" := 0;

                                        end;


                                    end;
                                end
                                else begin

                                    "Municipality Code MM" := '';
                                    "MZ MM" := '';
                                    "Measuring Point Stroke" := 0;
                                    "Measuring Point String" := 0;
                                    "Zone stroke" := 0;


                                end;
                                CalcFields("Street Name MM");

                                Address := "Street Name MM" + ' ' + "Street No.";
                                "Address MM" := Address;

                */
            end;



        }

        field(50157; "Measuring Point Stroke New"; Integer)
        {
            Caption = 'Measuring Point Stroke New';
            //TableRelation = Stroke.Code where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));

            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin


            end;
            //Hod


        }
        field(50158; "Measuring Point string New"; Integer)
        {
            Caption = 'Measuring Point string New';
            //    TableRelation = Stroke."Measuring Point string" where("MZ-Code" = field("MZ MM"), Street = field(Street), "Municipality Code" = field("Municipality Code MM"));
            trigger OnValidate()
            var
                myInt: Integer;
                Stroke: Record Stroke;
            begin



            end;
            //niz

        }
        field(50159; "MZ MM New"; code[20])
        {
            Caption = 'Local Community New';
            TableRelation = MZ.Code;
            trigger Onvalidate()
            var
                myInt: Integer;
            begin

                //     Address := Rec."MZ MM" + ' ' + Rec.Street + ' ' + "Home No.";

            end;
        }
        field(50160; "MZ Name MM New"; Text[250])
        {
            Caption = 'MZ Name MM New';
            //FieldClass = FlowField;
            // CalcFormula = lookup(MZ.Description where(Code = field("MZ MM")));
        }
        field(50161; "Customer Stroke New"; Integer)
        {
            Caption = 'Customer Stroke New';
            //Hod


        }
        field(50162; "Customer string New"; Integer)
        {
            Caption = 'Customer string New';
            //niz

        }

        field(50163; "Customer Category New"; enum Category)
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer Category New';


        }




        /*  field(50061; "Calculation Valide"; Boolean)
          {
              Caption = 'Calculation Valide';

          }*/
        field(50166; "EL Volume Description New"; text[250])
        {
            Caption = 'EL Volume Description New';
        }
        field(50167; "Installation Date New"; Date)
        {
            Caption = 'Installation Date';
            //datum ugradnje koji je bio, a mi ga sad mijenjamo.
        }
        field(50168; "Measuring Point Code New"; code[20])
        {
            Caption = 'Measuring Point Code New';
            TableRelation = "Service Item"."No.";

            trigger OnValidate()
            var
                myInt: Integer;
                ServiceII: Record "Service Item";
            begin
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

            end;
        }

        field(50169; "Phone No. MM"; Text[250])
        {
            Caption = 'Phone No. MM';
            ExtendedDatatype = PhoneNo;
        }
        field(50170; "Document Date"; Date)
        {
            Caption = 'Document Date';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Document Date" where("No." = field("Document No.")));
        }


        //kraj

        field(50171; "Type G_R"; Option)
        {
            Caption = 'Type';
            OptionMembers = ,Gauge,Corrector,Radio_Module,Gauge_RM,Corrector_RM;
            OptionCaption = ' ,Gauge,Corrector,Radio_Module,Gauge_Radio_Module,Corrector_RadioModule';

        }
        field(50172; "Request Department"; Code[20])
        {
            Caption = 'Request Department', Comment = 'Org. jedinica pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department" where("No." = field("Document No.")));

        }
        field(50173; "Request Department Name"; Text[150])
        {
            Caption = 'Request Department Name', Comment = 'Naziv org. jedinice pošiljaoca';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Request Department Name" where("No." = field("Document No.")));
            Editable = false;
        }
        field(50174; "Responsible Department"; Code[20])
        {
            Caption = 'Responsible Department', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department" where("No." = field("Document No.")));

        }
        field(50175; "Responsible Department Name"; Text[250])
        {
            Caption = 'Responsible Department Name', Comment = 'Odgovorna org. jedinica';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Responsible Department Name" where("No." = field("Document No.")));


        }


        field(70115; "Prep. Process. Empl. Name."; Text[250])
        {
            Caption = 'Preparation - Processing Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Process. Empl. Name." where("No." = field("Document No.")));

        }
        field(70116; "Prep. Contr. Empl. Name"; Text[250])
        {

            Caption = 'Preparation - Controlling Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Contr. Empl. Name" where("No." = field("Document No.")));

        }
        field(70117; "Prep. Verif. Empl. Name"; Text[250])
        {

            Caption = 'Preparation - Verification Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Verif. Empl. Name" where("No." = field("Document No.")));

        }
        field(70118; "Real. Process. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Processing Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Process. Empl. Name" where("No." = field("Document No.")));

        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Controlling Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Contr. Empl. Name" where("No." = field("Document No.")));

        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {

            Caption = 'Realisation - Verification Employee Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Verif. Empl. Name" where("No." = field("Document No.")));

        }
        field(60017; "Prep. Process. Empl. No."; Code[20])
        {

            Caption = 'Preparation - Processing Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Process. Empl. No." where("No." = field("Document No.")));

        }
        field(60018; "Prep. Contr. Empl. No."; Code[20])
        {
            Caption = 'Preparation - Controlling Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Contr. Empl. No." where("No." = field("Document No.")));
        }
        field(60019; "Prep. Verif. Empl. No."; Code[20])
        {

            Caption = 'Preparation - Verification Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Prep. Verif. Empl. No." where("No." = field("Document No.")));
        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {

            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Process. Empl. No." where("No." = field("Document No.")));
        }
        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;

            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Contr. Empl. No." where("No." = field("Document No.")));

        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;

            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Real. Verif. Empl. No." where("No." = field("Document No.")));
        }
        field(70258; "Done Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Done Date" where("No." = field("Document No.")));
        }

        //da znam da je realizacija završena od ovog radnog naloga, koji je masovni

        field(50177; "Mark"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Mark', Comment = 'Oznaka';
        }

        field(50079; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }

        field(50080; "Work Order No."; Code[20])
        {

            Caption = 'Work Order No.';
        }



        field(50176; "Applied"; Boolean)
        {
            Caption = 'Applied';

            trigger OnValidate()
            var
                CS: Record "Calculation Setup";
                CU: Codeunit "Update Data Billing";
                myInt: Integer;
                DR: Record "Dismantling Reason";
                CustNew: Record Customer;
                IHInsert: Record "Installation History";
                IHInsertPrevious: Record "Installation History";
                GaugeTemp: Record Customer;
                MMTemp: Record "Service Item";
                MMNew: Record "Service Item";
                GaugeF: record Gauge;
                GaugeFF: Record gauge;
                GaugeFFRename: Record Gauge;
                CustFind: Record Customer;
                ServiceItemUpdateS: Record "Service Item";
                StatusH: Record "Status History MM";
                StatusHCheck: Record "Status History MM";
                StatusHPrevious: Record "Status History MM";
                ElVolume: Record "El. Volume Corr";
                RadioMM: Record "Radio Module";
                ElVolumeGet: Record "El. Volume Corr";
                ElVolumeRename: Record "El. Volume Corr";
                CUstFind4: record "Customer";
                SHLastMM: Record "Status History MM";
                SHLast: Record "Status History";

                ShAllowed: Record "Service Header";
                Usset: Record "User Setup";
                CUP: Record Customer;
                IsNotAllowed: Boolean;
                ECL: Record "Employee Contract Ledger";
                gsERIAL: Record Gauge;
                rmgET: Record "Radio Module";
                ggf: Record Gauge;
                RMYes: Boolean;
                CcorrYes: Boolean;
                MMUpdate: Record "Service Item";
                IHEmptyy: Record "Installation History";
                DREmpty: Record "Dismantling Reason";
                IhAll: Record "Installation History";
                SHDone: Record "Service Header";
                GaugeExsistAlready: Record Gauge;
                StatusHCust: Record "Status History";
                StatusHCustPrevious: Record "Status History";
                StatusHCustCheck: Record "Status History";
                SMM: Record "Status History MM";
                BrojMMTrajno: Integer;
                CustomerF: Record "Service Item";
                GLSetupDay: Record "General Ledger Setup";
                CalcSetup: Record "Calculation Setup";
                IHNewGauge: Record "Installation History";
                IHOldGauge: Record "Calculation Journal Line";
                IHInsertForDelete: Record "Installation History";
                IHInsertForDeletePrevious: Record "Installation History";
                GaugeDeletePrevious: Record "Installation History";
                GaugeAllowedToDelete: Record Gauge;
                GaugeDeletePreviousGet: Record Gauge;
                GaugeAllowedToDeleteRM: Record "Radio Module";
                GaugeDeletePreviousGetRM: Record "Radio Module";
                GaugeAllowedToDeleteCorr: Record "El. Volume Corr";
                GaugeDeletePreviousGetCorr: Record "El. Volume Corr";
                GaugeFindInsertData: Record Gauge;
                GaugeFindInsertDataRM: Record "Radio Module";
                GaugeFindInsertDataCorr: Record "El. Volume Corr";

                CustNow: Record Customer;
            begin
                IsNotAllowed := false;
                Usset.Reset();
                Usset.SetFilter("User ID", '%1', UserId);
                if Usset.FindFirst() then begin
                    ECL.Reset();
                    ecl.SetFilter("Employee No.", '%1', Usset."Employee No. for Wage");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst()
                     then begin
                        ShAllowed.Reset();
                        ShAllowed.SetFilter("No.", '%1', rec."Document No.");
                        if ShAllowed.FindFirst()
                     then begin
                            if ShAllowed."Responsible Department" = ecl."Department Code" then
                                IsNotAllowed := true;
                        end;
                    end;
                end;

                if IsNotAllowed = false then
                    Error('Nije Vam dozvoljeno ažurirati podatke. Jedino zaposlenici u odgovornoj služi ' + ShAllowed."Responsible Department" + ' mogu ažurirati ovo polje!');




                if rec."MM Category" = rec."MM Category"::"Large Economy" then begin
                    if "Corrector Serial Number" <> '' then begin

                        if "Allow Deviation" = false then begin
                            TestField("Unadjusted Volume");
                            TestField("Adjusted Volume");
                            TestField("Absolute Pressure Of Corrector");
                            TestField("Pressure Type");
                            TestField("Correction Factor");
                        end;
                        if "Temperature Value" = 0 then begin
                            if not Confirm('Temperatura na starom korektoru je 0, da li isto potvrđujete?') then
                                TestField("Temperature Value");
                        end;


                    end;
                    if ("Corrector Serial Number" = '') and (Gauge <> '') then begin
                        if "Operating Pressure On ML" = 0 then
                            if not Confirm('Pritisak na starom mjeraču je 0, da li isto potvrđujete?') then
                                TestField("Operating Pressure On ML");

                        if "Temperature" = 0 then
                            if not Confirm('Temperatura na starom mjeraču je 0, da li isto potvrđujete?') then
                                TestField("Temperature");


                    end;

                    if ("Corrector Serial Number" = '') and ("New Gauges" <> '') then begin
                        if "Operating Pressure On ML New" = 0 then
                            if not Confirm('Pritisak na novom mjeraču je 0, da li isto potvrđujete?') then
                                TestField("Operating Pressure On ML New");

                        if "Temperature New" = 0 then
                            if not Confirm('Temperatura na novom mjeraču je 0, da li isto potvrđujete?') then
                                TestField("Temperature New");


                    end;


                    if "Corrector Serial Number New" <> '' then begin
                        if "Allow Deviation" = false then begin
                            TestField("Unadjusted Volume New");
                            TestField("Adjusted Volume New");
                            TestField("Absolute Pressure Of Corr. New");
                            TestField("Pressure Type New");
                            TestField("Correction Factor New");

                        end;
                        if not Confirm('Temperatura na novom korektoru je 0, da li isto potvrđujete?') then
                            TestField("Temperature Value New");

                    end;



                end;

                DR.Reset();
                DR.SetFilter(Type, '%1', dr.Type::"Reason for dismantling");
                dr.SetFilter(description, '%1', "Reason for dismantling New");
                if dr.FindFirst() then begin
                    TestField("Dismantling date New");
                    //TestField("Installation Date New");

                    if (xRec.Applied = true) and (rec.Applied = false) and (dr."Verification" = true) then begin
                        if Confirm('Da li ste sigurni da želite poništiti apliciranje ove promjene?') then begin
                            //sad ću vratiti povrat radio modula

                            if ("Type G_R" = "Type G_R"::Radio_Module) or ("Type G_R" = "Type G_R"::Gauge_RM) then begin
                                if "Radio Module Code" <> '' then begin
                                    GaugeAllowedToDeleteRM.Reset();
                                    GaugeAllowedToDeleteRM.SetFilter(Code, '%1', rec."Radio Module Code");
                                    if GaugeAllowedToDelete.FindFirst() then begin
                                        if (GaugeAllowedToDelete."Measuring Point" <> '') then
                                            Error('Možete poništiti podatke samo za radio modul koji je u baždarnici!');
                                    end;
                                    //dio oko starog mjerača što ažurirati
                                    IHInsertForDelete.Reset();
                                    IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Radio_Module);
                                    IHInsertForDelete.SetFilter(Code, '%1', rec."Radio Module Code");
                                    IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                    IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                    if IHInsertForDelete.FindFirst() then
                                        IHInsertForDelete.Delete();
                                    Commit();

                                    Commit();
                                    cs.get;
                                    if cs."Update Data" = true then begin
                                        if rec."Dismantling date New" <> 0D then
                                            cu.UpdateDeleteGaug(IHInsertForDelete);
                                        Commit();
                                    end;

                                    IHInsertForDeletePrevious.Reset();
                                    IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Radio_Module);
                                    IHInsertForDeletePrevious.SetFilter(Code, '%1', rec."Radio Module Code");
                                    IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                    if IHInsertForDeletePrevious.FindFirst() then begin
                                        IHInsertForDeletePrevious."Reason for dismantling" := '';
                                        IHInsertForDeletePrevious."Dismantling date" := 0D;
                                        IHInsertForDeletePrevious.Active := true;
                                        IHInsertForDeletePrevious.Modify();

                                        //key(Key1; Code, "Gauge Code", "Measuring Point Code")

                                        GaugeDeletePrevious.Reset();
                                        GaugeDeletePrevious.SetFilter(Code, '%1', rec."Radio Module Code");
                                        GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.Type::Radio_Module);
                                        if GaugeDeletePrevious.FindFirst() then begin
                                            GaugeFindInsertDataRM.Reset();
                                            GaugeFindInsertDataRM.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                            if GaugeFindInsertDataRM.FindFirst() then begin
                                                if GaugeDeletePreviousGetRM.get(GaugeFindInsertDataRM.Code, GaugeFindInsertDataRM."Gauge Code", GaugeFindInsertDataRM."Measuring Point Code")
                                                                            then
                                                    GaugeDeletePreviousGetRM.Rename(GaugeFindInsertDataRM.Code, IHInsertForDeletePrevious."Gauge Code", IHInsertForDeletePrevious."Measuring Point Code");
                                            end;

                                        end;

                                        //"Code", "Measuring Point", "Customer No.", "Address MM")
                                    end;
                                end;
                                //sada radim dio oko novog mjerača
                                if rec."Radio Module Code New" <> '' then begin
                                    IHInsertForDelete.Reset();
                                    IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Radio_Module);
                                    IHInsertForDelete.SetFilter(Code, '%1', rec."Radio Module Code New");
                                    IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                    IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                    if IHInsertForDelete.FindFirst() then
                                        IHInsertForDelete.Delete();
                                    Commit();
                                    Commit();
                                    cs.get;
                                    if cs."Update Data" = true then begin
                                        if rec."Dismantling date New" <> 0D then
                                            cu.UpdateDeleteGaug(IHInsertForDelete);
                                        Commit();
                                    end;

                                    IHInsertForDeletePrevious.Reset();
                                    IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Radio_Module);
                                    IHInsertForDeletePrevious.SetFilter(Code, '%1', rec."Radio Module Code New");
                                    IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                    if IHInsertForDeletePrevious.FindFirst() then begin
                                        IHInsertForDeletePrevious."Reason for dismantling" := '';
                                        IHInsertForDeletePrevious."Dismantling date" := 0D;
                                        IHInsertForDeletePrevious.Active := true;
                                        IHInsertForDeletePrevious.Modify();

                                        GaugeDeletePrevious.Reset();
                                        GaugeDeletePrevious.SetFilter(Code, '%1', rec."Radio Module Code");
                                        GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.Type::Radio_Module);
                                        if GaugeDeletePrevious.FindFirst() then begin

                                            GaugeFindInsertDataRM.Reset();
                                            GaugeFindInsertDataRM.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                            if GaugeFindInsertDataRM.FindFirst() then begin

                                                if GaugeDeletePreviousGetRM.get(GaugeDeletePrevious.Code, GaugeDeletePrevious."Gauge Code", GaugeDeletePrevious."Measuring Point Code")
                                                then
                                                    GaugeDeletePreviousGetRM.Rename(GaugeDeletePrevious.Code, IHInsertForDeletePrevious."Gauge Code", IHInsertForDeletePrevious."Measuring Point Code");

                                            end;
                                        end;


                                    end;
                                end;
                            end;
                            //kraj radio modula

                            //korektor ispravka


                            if ("Type G_R" = "Type G_R"::Corrector) or ("Type G_R" = "Type G_R"::Corrector_RM) then begin

                                if rec.Corrector <> '' then begin
                                    GaugeAllowedToDeleteCorr.Reset();
                                    GaugeAllowedToDeleteCorr.SetFilter(Code, '%1', rec.Corrector);
                                    if GaugeAllowedToDeleteCorr.FindFirst() then begin
                                        if (GaugeAllowedToDeleteCorr."Customer No." <> '') or (GaugeAllowedToDeleteCorr."Measuring Point" <> '') then
                                            Error('Možete poništiti podatke samo za mjerač koji je u baždarnici!');
                                    end;
                                    //dio oko starog mjerača što ažurirati
                                    IHInsertForDelete.Reset();
                                    IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Corrector);
                                    IHInsertForDelete.SetFilter(Code, '%1', rec.Corrector);
                                    IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                    IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                    if IHInsertForDelete.FindFirst() then begin
                                        IHInsertForDelete.Delete();
                                        Commit();
                                        cs.get;
                                        if cs."Update Data" = true then begin
                                            if rec."Dismantling date New" <> 0D then
                                                cu.UpdateDeleteGaug(IHInsertForDelete);
                                            Commit();
                                        end;
                                    end;

                                    IHInsertForDeletePrevious.Reset();
                                    IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Corrector);
                                    IHInsertForDeletePrevious.SetFilter(Code, '%1', rec.Corrector);
                                    IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                    IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                    if IHInsertForDeletePrevious.FindFirst() then begin
                                        IHInsertForDeletePrevious."Reason for dismantling" := '';
                                        IHInsertForDeletePrevious."Dismantling date" := 0D;
                                        IHInsertForDeletePrevious.Active := true;
                                        IHInsertForDeletePrevious.Modify();

                                        //"Code", "Measuring Point", "Customer No.", "Address MM")
                                        GaugeDeletePrevious.Reset();
                                        GaugeDeletePrevious.SetFilter(Code, '%1', rec.Corrector);
                                        GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.type::Corrector);

                                        if GaugeDeletePrevious.FindFirst() then begin
                                            GaugeFindInsertDataCorr.Reset();
                                            GaugeFindInsertDataCOrr.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                            if GaugeFindInsertDataCorr.FindFirst() then begin

                                                if GaugeDeletePreviousGetCorr.get(GaugeFindInsertDataCorr.Code, GaugeFindInsertDataCorr."Measuring Point", GaugeFindInsertDataCorr."Customer No.", GaugeFindInsertDataCorr."Address MM")
                                                then
                                                    GaugeDeletePreviousGetCorr.Rename(GaugeDeletePrevious.Code, IHInsertForDeletePrevious."Measuring Point Code", IHInsertForDeletePrevious."Customer No.", IHInsertForDeletePrevious."Address MM");
                                            end;
                                        end;
                                        GaugeDeletePreviousGetCorr."Customer Name" := IHInsertForDeletePrevious."Customer Name";
                                        CustNow.reset;
                                        CustNow.SetFilter("No.", '%1', IHInsertForDeletePrevious."Customer No.");
                                        if CustNow.FindFirst() then begin
                                            GaugeDeletePreviousGetCorr."Customer Category" := CustNow."Customer Category";

                                            GaugeDeletePreviousGetCorr."Customer Category" := CustNow."Customer Category";
                                            GaugeDeletePreviousGetCorr."Customer Name" := CustNow.Name;

                                        end
                                        else begin
                                            GaugeDeletePreviousGetCorr."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";

                                            GaugeDeletePreviousGetCorr."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";
                                            GaugeDeletePreviousGetCorr."Customer Name" := '';


                                        end;
                                        GaugeDeletePreviousGetCorr.Modify();
                                    end;
                                end;
                                //"Code", "Measuring Point", "Customer No.", "Address MM")
                            end;

                            //sada radim dio oko novog mjerača
                            if rec."Corrector New" <> '' then begin
                                IHInsertForDelete.Reset();
                                IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Corrector);
                                IHInsertForDelete.SetFilter(Code, '%1', rec."Corrector New");
                                IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                if IHInsertForDelete.FindFirst() then
                                    IHInsertForDelete.Delete();
                                Commit();

                                Commit();
                                cs.get;
                                if cs."Update Data" = true then begin
                                    if rec."Dismantling date New" <> 0D then
                                        cu.UpdateDeleteGaug(IHInsertForDelete);
                                    Commit();
                                end;

                                IHInsertForDeletePrevious.Reset();
                                IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Corrector);
                                IHInsertForDeletePrevious.SetFilter(Code, '%1', rec."Corrector New");
                                IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                if IHInsertForDeletePrevious.FindFirst() then begin
                                    IHInsertForDeletePrevious."Reason for dismantling" := '';
                                    IHInsertForDeletePrevious."Dismantling date" := 0D;
                                    IHInsertForDeletePrevious.Active := true;
                                    IHInsertForDeletePrevious.Modify();

                                    //"Code", "Measuring Point", "Customer No.", "Address MM")
                                    GaugeDeletePrevious.Reset();
                                    GaugeDeletePrevious.SetFilter(Code, '%1', rec."Corrector New");
                                    GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.type::Corrector);
                                    if GaugeDeletePrevious.FindFirst() then begin
                                        GaugeFindInsertDataCorr.Reset();
                                        GaugeFindInsertDataCOrr.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                        if GaugeFindInsertDataCorr.FindFirst() then begin
                                            if GaugeDeletePreviousGetCorr.get(GaugeDeletePrevious.Code, GaugeDeletePrevious."Measuring Point Code", GaugeDeletePrevious."Customer No.", GaugeDeletePrevious."Address MM")
                                            then
                                                GaugeDeletePreviousGetCorr.Rename(GaugeDeletePrevious.Code, IHInsertForDeletePrevious."Measuring Point Code", IHInsertForDeletePrevious."Customer No.", IHInsertForDeletePrevious."Address MM");
                                        end;
                                        GaugeDeletePreviousGetCorr."Customer Name" := IHInsertForDeletePrevious."Customer Name";
                                        CustNow.reset;
                                        CustNow.SetFilter("No.", '%1', IHInsertForDeletePrevious."Customer No.");
                                        if CustNow.FindFirst() then begin
                                            GaugeDeletePreviousGetCorr."Customer Category" := CustNow."Customer Category";

                                            GaugeDeletePreviousGetCorr."Customer Category" := CustNow."Customer Category";
                                            GaugeDeletePreviousGetCorr."Customer Name" := CustNow.Name;

                                        end
                                        else begin
                                            GaugeDeletePreviousGetCorr."Customer Category" := GaugeDeletePreviousGetCorr."Customer Category"::" ";

                                            GaugeDeletePreviousGetCorr."Customer Category" := GaugeDeletePreviousGetCorr."Customer Category"::" ";
                                            GaugeDeletePreviousGetCorr."Customer Name" := '';


                                        end;
                                        GaugeDeletePreviousGetCorr.Modify();
                                    end;

                                    //"Code", "Measuring Point", "Customer No.", "Address MM")

                                end;
                            end;
                        end;

                        //kraj korektor ispravkae

                        if ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Gauge_RM)
                        or (("Type G_R" = "Type G_R"::Corrector_RM)) then begin
                            if gauge <> '' then begin
                                GaugeAllowedToDelete.Reset();
                                GaugeAllowedToDelete.SetFilter(Code, '%1', rec.gauge);
                                if GaugeAllowedToDelete.FindFirst() then begin
                                    if (GaugeAllowedToDelete."Customer No." <> '') or (GaugeAllowedToDelete."Measuring Point" <> '') then
                                        Error('Možete poništiti podatke samo za mjerač koji je u baždarnici!');
                                end;
                                //dio oko starog mjerača što ažurirati
                                IHInsertForDelete.Reset();
                                IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Gauge);
                                IHInsertForDelete.SetFilter(Code, '%1', rec.Gauge);
                                IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                if IHInsertForDelete.FindFirst() then begin
                                    IHInsertForDelete.Delete();

                                    Commit();
                                    cs.get;
                                    if cs."Update Data" = true then begin
                                        if rec."Dismantling date New" <> 0D then
                                            cu.UpdateDeleteGaug(IHInsertForDelete);
                                        Commit();
                                    end;

                                end;

                                IHInsertForDeletePrevious.Reset();
                                IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Gauge);
                                IHInsertForDeletePrevious.SetFilter(Code, '%1', rec.Gauge);
                                IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                if IHInsertForDeletePrevious.FindFirst() then begin
                                    IHInsertForDeletePrevious."Reason for dismantling" := '';
                                    IHInsertForDeletePrevious."Dismantling date" := 0D;
                                    IHInsertForDeletePrevious.Active := true;
                                    IHInsertForDeletePrevious.Modify();

                                    GaugeDeletePrevious.Reset();
                                    GaugeDeletePrevious.SetFilter(Code, '%1', rec.Gauge);
                                    GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.type::Gauge);
                                    if GaugeDeletePrevious.FindFirst() then begin
                                        GaugeFindInsertData.Reset();
                                        GaugeFindInsertData.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                        if GaugeFindInsertData.FindFirst() then begin

                                            if GaugeDeletePreviousGet.get(GaugeFindInsertData.Code, GaugeFindInsertData."Measuring Point", GaugeFindInsertData."Customer No.", GaugeFindInsertData."Address MM")
                                            then
                                                GaugeDeletePreviousget.Rename(GaugeDeletePrevious.Code, IHInsertForDeletePrevious."Measuring Point Code", IHInsertForDeletePrevious."Customer No.", IHInsertForDeletePrevious."Address MM");
                                        end;
                                        GaugeDeletePreviousget."Customer Name" := IHInsertForDeletePrevious."Customer Name";
                                        CustNow.reset;
                                        CustNow.SetFilter("No.", '%1', IHInsertForDeletePrevious."Customer No.");
                                        if CustNow.FindFirst() then begin
                                            GaugeDeletePreviousget."Customer Category" := CustNow."Customer Category";

                                            GaugeDeletePreviousget."Gauge Category" := CustNow."Customer Category";
                                            GaugeDeletePreviousget."Customer Category" := CustNow."Customer Category";
                                            GaugeDeletePreviousget."Customer Name" := CustNow.Name;
                                            GaugeDeletePreviousget."Customer E-mail" := CustNow."E-Mail";
                                            GaugeDeletePreviousget."Tax Liable" := CustNow."Tax Liable";

                                        end
                                        else begin
                                            GaugeDeletePreviousget."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";

                                            GaugeDeletePreviousget."Gauge Category" := GaugeDeletePreviousget."Gauge Category"::" ";
                                            GaugeDeletePreviousget."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";
                                            GaugeDeletePreviousget."Customer Name" := '';
                                            GaugeDeletePreviousget."Customer E-mail" := '';
                                            GaugeDeletePreviousget."Tax Liable" := false;


                                        end;
                                        GaugeDeletePreviousget.Modify();
                                    end;

                                    //"Code", "Measuring Point", "Customer No.", "Address MM")
                                end;
                            end;
                            //sada radim dio oko novog mjerača
                            if rec."New Gauges" <> '' then begin
                                IHInsertForDelete.Reset();
                                IHInsertForDelete.SetFilter(Type, '%1', IHInsertForDelete.Type::Gauge);
                                IHInsertForDelete.SetFilter(Code, '%1', rec."New Gauges");
                                IHInsertForDelete.SetFilter(RN, '%1', rec."Document No.");
                                IHInsertForDelete.SetFilter("Installation Date", '%1', rec."Dismantling date New");
                                if IHInsertForDelete.FindFirst() then
                                    IHInsertForDelete.Delete();
                                Commit();

                                Commit();
                                cs.get;
                                if cs."Update Data" = true then begin
                                    if rec."Dismantling date New" <> 0D then
                                        cu.UpdateDeleteGaug(IHInsertForDelete);
                                    Commit();
                                end;

                                IHInsertForDeletePrevious.Reset();
                                IHInsertForDeletePrevious.SetFilter(Type, '%1', IHInsertForDelete.Type::Gauge);
                                IHInsertForDeletePrevious.SetFilter(Code, '%1', rec."New Gauges");
                                IHInsertForDeletePrevious.SetFilter("Installation Date", '<>%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Dismantling date", '%1', rec."Dismantling date New");
                                IHInsertForDeletePrevious.SetFilter("Reason for dismantling", '%1', rec."Reason for dismantling New");
                                if IHInsertForDeletePrevious.FindFirst() then begin
                                    IHInsertForDeletePrevious."Reason for dismantling" := '';
                                    IHInsertForDeletePrevious."Dismantling date" := 0D;
                                    IHInsertForDeletePrevious.Active := true;
                                    IHInsertForDeletePrevious.Modify();

                                    GaugeDeletePrevious.Reset();
                                    GaugeDeletePrevious.SetFilter(Code, '%1', rec."New Gauges");
                                    GaugeDeletePrevious.SetFilter(Type, '%1', GaugeDeletePrevious.type::Gauge);
                                    if GaugeDeletePrevious.FindFirst() then begin
                                        GaugeFindInsertData.Reset();
                                        GaugeFindInsertData.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                        if GaugeFindInsertData.FindFirst() then begin

                                            GaugeFindInsertData.Reset();
                                            GaugeFindInsertData.SetFilter(Code, '%1', GaugeDeletePrevious.Code);
                                            if GaugeFindInsertData.FindFirst() then begin

                                                if GaugeDeletePreviousGet.get(GaugeFindInsertData.Code, GaugeFindInsertData."Measuring Point", GaugeFindInsertData."Customer No.", GaugeFindInsertData."Address MM")
                                                then
                                                    GaugeDeletePreviousget.Rename(GaugeDeletePrevious.Code, IHInsertForDeletePrevious."Measuring Point Code", IHInsertForDeletePrevious."Customer No.", IHInsertForDeletePrevious."Address MM");
                                            end;
                                            GaugeDeletePreviousget."Customer Name" := IHInsertForDeletePrevious."Customer Name";
                                            CustNow.reset;
                                            CustNow.SetFilter("No.", '%1', IHInsertForDeletePrevious."Customer No.");
                                            if CustNow.FindFirst() then begin
                                                GaugeDeletePreviousget."Customer Category" := CustNow."Customer Category";

                                                GaugeDeletePreviousget."Gauge Category" := CustNow."Customer Category";
                                                GaugeDeletePreviousget."Customer Category" := CustNow."Customer Category";
                                                GaugeDeletePreviousget."Customer Name" := CustNow.Name;
                                                GaugeDeletePreviousget."Customer E-mail" := CustNow."E-Mail";
                                                GaugeDeletePreviousget."Tax Liable" := CustNow."Tax Liable";

                                            end
                                            else begin
                                                GaugeDeletePreviousget."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";

                                                GaugeDeletePreviousget."Gauge Category" := GaugeDeletePreviousget."Gauge Category"::" ";
                                                GaugeDeletePreviousget."Customer Category" := GaugeDeletePreviousget."Customer Category"::" ";
                                                GaugeDeletePreviousget."Customer Name" := '';
                                                GaugeDeletePreviousget."Customer E-mail" := '';
                                                GaugeDeletePreviousget."Tax Liable" := false;


                                            end;
                                            GaugeDeletePreviousget.Modify();
                                        end;


                                    end;
                                end;
                            end;
                        end;
                    end;
                end;


                if Applied = true then begin




                    if "Reason for dismantling New" = '' then begin


                        IHEmptyy.Reset();
                        IHEmptyy.SetFilter(Code, '%1', "New Gauges");
                        IHEmptyy.SetFilter(Type, '%1', IHEmptyy.Type::Gauge);

                        if not IHEmptyy.FindFirst() then begin
                            Usset.Reset();
                            Usset.SetFilter("User ID", '%1', UserId);
                            if Usset.FindFirst() then begin
                                rec."Reason for dismantling New" := Usset."Default reason";
                            end;
                        end;
                    end;
                    TestField("Reason for dismantling New");
                    //pocetak
                    DR.Reset();
                    DR.SetFilter(Type, '%1', dr.Type::"Reason for dismantling");
                    dr.SetFilter(description, '%1', "Reason for dismantling New");
                    if dr.FindFirst() then begin
                        if (dr.Verification = false)
                        and (dr."Gauge cut off" = false)
                        and (dr."Gauge replacement" = false)
                        and (dr."Is not in Calibration facility" = false)
                        and (dr.InActive = false)
                        and (dr.Active = false)
                        and (dr.Permanently = False)
                        and (dr.Temporery = false)
                        and (dr."Default reason" = false) then begin
                            ServiceItemUpdateS.Reset();
                            ServiceItemUpdateS.SetFilter("No.", '%1', rec."Service Item No. - Relation");
                            if ServiceItemUpdateS.FindFirst() then begin
                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                ServiceItemUpdateS.modify;
                            end;
                        end

                        else begin
                            if DR."Type G_R" <> DR."Type G_R"::" " then begin
                                if (DR."Type G_R" = dr."Type G_R"::Radio_Module) and (rec."Type G_R" <> rec."Type G_R"::Radio_Module) then
                                    Error('Vrsta mora biti jednaka ' + format(DR."Type G_R"));
                                if (DR."Type G_R" = dr."Type G_R"::Corrector) and (rec."Type G_R" <> rec."Type G_R"::Corrector) then
                                    Error('Vrsta mora biti jednaka ' + format(DR."Type G_R"));
                                if (DR."Type G_R" = dr."Type G_R"::Corrector_RM) and (rec."Type G_R" <> rec."Type G_R"::Corrector_RM) then
                                    Error('Vrsta mora biti jednaka ' + format(DR."Type G_R"));
                                if (DR."Type G_R" = dr."Type G_R"::Gauge) and (rec."Type G_R" <> rec."Type G_R"::Gauge) then
                                    Error('Vrsta mora biti jednaka ' + format(DR."Type G_R"));
                                if (DR."Type G_R" = dr."Type G_R"::Gauge_RM) and (rec."Type G_R" <> rec."Type G_R"::Gauge_RM) then
                                    Error('Vrsta mora biti jednaka ' + format(DR."Type G_R"));


                            end;

                            if (dr.InActive = true) and (dr.Verification = false) then begin
                                ServiceItemUpdateS.Reset();
                                ServiceItemUpdateS.SetFilter("No.", '%1', rec."Service Item No. - Relation");
                                if ServiceItemUpdateS.FindFirst() then begin
                                    ServiceItemUpdateS."Measuring point off" := True;
                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";

                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";

                                    ServiceItemUpdateS.Modify();
                                end;
                            end;

                            if dr.Verification = true then begin

                                if ("Customer No. New" <> '') and ("Measuring Point Code New" <> '') then begin

                                    if ("Type G_R" = "Type G_R"::Gauge) or ("Type G_R" = "Type G_R"::Corrector_RM) or ("Type G_R" = "Type G_R"::Gauge_RM) then begin
                                        GaugeExsistAlready.Reset();
                                        GaugeExsistAlready.SetFilter("Customer No.", '%1', "Customer No. New");
                                        GaugeExsistAlready.SetFilter("Measuring Point", '%1', "Measuring Point Code New");
                                        GaugeExsistAlready.SetFilter(Code, '<>%1', rec.gauge);
                                        if GaugeExsistAlready.FindFirst() then begin
                                            if GaugeExsistAlready.code <> "New Gauges" then
                                                Error('Mjerno mjesto ' + Format("Measuring Point Code New") + ' kod kupca ' + "Customer No. New" + ' već ima mjerač ' + GaugeExsistAlready."Inventar number" + ' pa ne možete isti dodijeliti!');
                                        end;
                                    end;
                                end;
                            end;


                            if dr.Verification = true then begin

                                GLSetupDay.get;
                                CalcSetup.get;

                                if (rec."MM Category" = rec."MM Category"::Household) or (rec."MM Category" = rec."MM Category"::"Small Economy") then begin
                                    if CalcSetup."Error for summer" = true then begin
                                        IHOldGauge.Reset();
                                        IHOldGauge.SetFilter(Gauge, '%1', Gauge);
                                        IHOldGauge.SetFilter("Calculation Date To", '<=%1', "Date of consumption");
                                        IHOldGauge.SetFilter("New Value", '<>%1', 0);
                                        IHOldGauge.SetCurrentKey("Calculation Date To");
                                        IHOldGauge.Ascending;
                                        if IHOldGauge.FindLast() then begin

                                            if abs(IHOldGauge."New Value" - rec.Reading) > 300 then begin
                                                if Rec."Allow Deviation" = false then
                                                    Error('Odstupanje demontiranog mjerača u odnosu na fakturisanu količinu je veći od 300. Molimo Vas da provjerite podatke!');
                                            end;
                                        end;
                                    end;
                                end;



                                if ("Date of consumption") < (CalcDate(GLSetupDay."Number of Days", "Date of consumption")) then
                                    Error('Datum očitanja ne smije biti ' + format(GLSetupDay."Number of Days") + ' stariji!');
                                if "New Gauges" <> '' then begin
                                    IHNewGauge.Reset();
                                    IHNewGauge.SetFilter(Code, '%1', "New Gauges");
                                    IHNewGauge.SetFilter("Installation Date", '<=%1', "Date of consumption New");
                                    IHNewGauge.SetFilter(Type, '%1', IHNewGauge.Type::Gauge);
                                    IHNewGauge.SetCurrentKey("Installation Date");
                                    IHNewGauge.Ascending;
                                    if IHNewGauge.FindLast() then begin
                                        if abs(IHNewGauge.Reading - rec."Reading New") > 3 then begin
                                            if Rec."Allow Deviation" = false then
                                                Error('Iznos razlike između stanja novog mjerača i prethodnog očitanja u momentu baždarenja ne može biti veći od 3. Molimo Vas da provjerite.!');
                                        end;
                                    end;

                                end;
                            end;


                            if (dr.Active = True) and (dr."Gauge cut off" = false) then begin

                                ServiceItemUpdateS.Reset();
                                ServiceItemUpdateS.SetFilter("No.", '%1', rec."Service Item No. - Relation");
                                if ServiceItemUpdateS.FindFirst() then begin
                                    ServiceItemUpdateS."Measuring point off" := false;
                                    ServiceItemUpdateS."Measuring point off Date" := 0D;
                                    SHDone.Reset();
                                    SHDone.SetFilter("No.", '%1', rec."Document No.");
                                    SHDone.SetFilter("Document Type", '%1', rec."Document Type");
                                    if SHDone.findfirst then begin
                                        if SHDone."Finishing Date" <> 0D then
                                            ServiceItemUpdateS."Measuring point in Date" := SHDone."Finishing Date"
                                        else
                                            ServiceItemUpdateS."Measuring point in Date" := SHDone."Document Date"
                                    end
                                    else begin
                                        ServiceItemUpdateS."Measuring point in Date" := workdate;
                                    end;
                                    ServiceItemUpdateS."Measuring point in" := true;
                                    ServiceItemUpdateS."Measuring point off" := false;
                                    ServiceItemUpdateS."Measuring point off Date" := 0D;


                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";

                                    ServiceItemUpdateS.Modify();
                                end;

                                //djemina
                                StatusH.Init();
                                StatusH."Measuring Point" := Rec."Service Item No.";
                                StatusH."Source Table" := 5940;
                                StatusH.Active := true;
                                StatusH."Information of processing" := StatusH."Information of processing"::Active;
                                StatusH."Insert User ID" := UserId;
                                StatusH."Insert Date and Time" := CurrentDateTime;
                                StatusHCheck.Reset();
                                StatusHCheck.SetFilter("Measuring Point", '%1', Rec."Service Item No.");
                                StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                StatusHCheck.SetFilter(Active, '%1', true);
                                StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Active);
                                if not StatusHCheck.FindFirst() then begin
                                    StatusHPrevious.Reset();
                                    StatusHPrevious.SetFilter("Measuring Point", '%1', rec."Service Item No.");
                                    StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                    StatusHPrevious.SetFilter(Active, '%1', true);

                                    if StatusHPrevious.FindSet() then
                                        repeat
                                            StatusHPrevious.Active := false;
                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                StatusHPrevious.Modify();
                                        until StatusHPrevious.Next() = 0;
                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                        StatusH.Active := true
                                    else
                                        StatusH.Active := false;

                                    SHLastMM.Reset();
                                    SHLastMM.SetFilter("Measuring Point", '%1', Rec."Service Item No.");
                                    SHLastMM.SetCurrentKey(Integer);
                                    SHLastMM.Ascending;
                                    if SHLastMM.FindLast() then
                                        StatusH.Integer := SHLastMM.Integer + 1
                                    else
                                        StatusH.Integer := 1;


                                    StatusH.Insert();

                                end;

                                //status kupca dodati u aktivan obaveznoo 


                                StatusHCust.Init();
                                StatusHCust.validate("Customer No.", Rec."Customer No.");
                                StatusHCust."Source Table" := 18;
                                StatusHCust.Active := true;
                                StatusHCust."Information of processing" := StatusHCust."Information of processing"::Active;
                                StatusHCust."Insert User ID" := UserId;
                                StatusHCust."Insert Date and Time" := CurrentDateTime;
                                StatusHCustCheck.Reset();
                                StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                StatusHCustCheck.SetFilter(Active, '%1', true);
                                StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::Active);
                                if not StatusHCustCheck.FindFirst() then begin
                                    StatusHCustPrevious.Reset();
                                    StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                    StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                    StatusHCustPrevious.SetFilter(Active, '%1', true);

                                    if StatusHCustPrevious.FindSet() then
                                        repeat
                                            StatusHCustPrevious.Active := false;
                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                StatusHCustPrevious.Modify();
                                        until StatusHCustPrevious.Next() = 0;
                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                        StatusHCust.Active := true
                                    else
                                        StatusHCust.Active := false;


                                    SHLast.Reset();
                                    SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                    SHLast.SetCurrentKey(Integer);
                                    SHLast.Ascending;
                                    if SHLast.FindLast() then
                                        StatusHCust.Integer := SHLast.Integer + 1
                                    else
                                        StatusHCust.Integer := 1;


                                    StatusHCust.Insert();

                                end;


                                //kraj Đemina

                            end;



                            if (dr."Only Status Active" = true) then begin
                                //djemina
                                StatusH.Init();
                                StatusH."Measuring Point" := Rec."Service Item No.";
                                StatusH."Source Table" := 5940;
                                StatusH.Active := true;
                                StatusH."Information of processing" := StatusH."Information of processing"::Active;
                                StatusH."Insert User ID" := UserId;
                                StatusH."Insert Date and Time" := CurrentDateTime;
                                StatusHCheck.Reset();
                                StatusHCheck.SetFilter("Measuring Point", '%1', Rec."Service Item No.");
                                StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                StatusHCheck.SetFilter(Active, '%1', true);
                                StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Active);
                                if not StatusHCheck.FindFirst() then begin
                                    StatusHPrevious.Reset();
                                    StatusHPrevious.SetFilter("Measuring Point", '%1', rec."Service Item No.");
                                    StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                    StatusHPrevious.SetFilter(Active, '%1', true);
                                    // StatusHPrevious.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Active);

                                    if StatusHPrevious.FindSet() then
                                        repeat
                                            StatusHPrevious.Active := false;
                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                StatusHPrevious.Modify();
                                        until StatusHPrevious.Next() = 0;
                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                        StatusH.Active := true
                                    else
                                        StatusH.Active := false;

                                    SHLastMM.Reset();
                                    SHLastMM.SetFilter("Measuring Point", '%1', Rec."Service Item No.");
                                    SHLastMM.SetCurrentKey(Integer);
                                    SHLastMM.Ascending;
                                    if SHLastMM.FindLast() then
                                        StatusH.Integer := SHLastMM.Integer + 1
                                    else
                                        StatusH.Integer := 1;

                                    StatusH.Insert();

                                end;

                                //status kupca dodati u aktivan obaveznoo 


                                StatusHCust.Init();
                                StatusHCust.validate("Customer No.", Rec."Customer No.");
                                StatusHCust."Source Table" := 18;
                                StatusHCust.Active := true;
                                StatusHCust."Information of processing" := StatusHCust."Information of processing"::Active;
                                StatusHCust."Insert User ID" := UserId;
                                StatusHCust."Insert Date and Time" := CurrentDateTime;
                                StatusHCustCheck.Reset();
                                StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                StatusHCustCheck.SetFilter(Active, '%1', true);
                                StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::Active);
                                if not StatusHCustCheck.FindFirst() then begin
                                    StatusHCustPrevious.Reset();
                                    StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                    StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                    StatusHCustPrevious.SetFilter(Active, '%1', true);

                                    if StatusHCustPrevious.FindSet() then
                                        repeat
                                            StatusHCustPrevious.Active := false;
                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                StatusHCustPrevious.Modify();
                                        until StatusHCustPrevious.Next() = 0;
                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                        StatusHCust.Active := true
                                    else
                                        StatusHCust.Active := false;

                                    SHLast.Reset();
                                    SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                    SHLast.SetCurrentKey(Integer);
                                    SHLast.Ascending;
                                    if SHLast.FindLast() then
                                        StatusHCust.Integer := SHLast.Integer + 1
                                    else
                                        StatusHCust.Integer := 1;


                                    StatusHCust.Insert();

                                end;


                                //kraj Đemina

                            end;


                            if dr.Verification = true then begin

                                if (Rec."Type G_R" = rec."Type G_R"::Gauge_RM) or (Rec."Type G_R" = rec."Type G_R"::Corrector_RM) then begin

                                    //prvo bih poslala cijeli ovaj kod kao Gauge, a onda ponovo kao RM
                                    if "Type G_R" = "Type G_R"::Gauge_RM then
                                        RMYes := true
                                    else
                                        RMYes := false;
                                    if "Type G_R" = "Type G_R"::Corrector_RM then
                                        CcorrYes := true
                                    else
                                        CcorrYes := false;


                                    Rec."Type G_R" := Rec."Type G_R"::Gauge;
                                    IHInsert.Reset();

                                    //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.

                                    if rec."Installation Date New" = 0D then
                                        rec."Installation Date New" := "Dismantling date New";
                                    IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                    //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");

                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                        IHInsert.SetFilter(Code, '%1', Gauge);
                                    end;

                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                        IHInsert.SetFilter(Code, '%1', Corrector);
                                    end;


                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                        IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                    end;


                                    if not IHInsert.FindFirst() then begin
                                        //nova stavka
                                        IHInsert.Init();
                                        IHInsert."Installation Date" := "Dismantling date New";
                                        IHInsert.RN := "Document No.";
                                        if rec."Type G_R" = rec."Type G_R"::Gauge then
                                            IHInsert.Code := Gauge;
                                        if rec."Type G_R" = rec."Type G_R"::Radio_Module then BEGIN
                                            IHInsert.Code := "Radio Module Code";
                                            IHInsert."Gauge Code" := REC.Gauge;

                                            IF rmgET.GET(ihINSERT.CODE, iHINSERT."Gauge Code", iHiNSERT."Measuring Point Code") THEN BEGIN
                                                rmgET.RENAME(IHINSERT.CODE, REC.Gauge, Rec."Service Item No. - Relation");
                                                ggf.RESET;
                                                ggf.SetFilter(Code, '%1', REC.Gauge);
                                                IF ggf.FindFirst() THEN
                                                    rmgET."Gauge Description" := GGF."Inventar number";
                                                IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                rmgET.Modify();
                                            END;
                                            Commit();

                                            gsERIAL.Reset();
                                            gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                            IF gsERIAL.FindFirst() THEN
                                                IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                        END;
                                        if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                            IHInsert.Code := Corrector;
                                            if CcorrYes = true then begin
                                                IHInsert."Gauge Code" := rec.Gauge;
                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN
                                                    IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                                IHInsert."Gauge Size" := gsERIAL."Gauge Size";
                                            end;
                                        end;

                                        if dr."Gauge cut off" = true then begin
                                            //ako je odjava

                                            if (dr.InActive = false) and (dr.Active = false) then begin
                                                if dr."Is not in Calibration facility" = false then begin
                                                    IHInsert."Customer Stroke" := 0;
                                                    IHInsert."Customer string" := 0;
                                                    IHInsert."Customer Zone stroke" := 0;
                                                    IHInsert."Customer Address" := '';
                                                    IHInsert."Customer Category" := CustFind."Customer Category"::" ";
                                                    IHInsert."Customer City" := '';
                                                    IHInsert."Customer Name" := '';
                                                    IHInsert."Customer No." := '';
                                                    IHInsert."Customer Post Code" := '';
                                                end
                                                else begin
                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                                IHInsert."Reason for dismantling" := rec."Reason for dismantling New";

                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN begin

                                                    IHInsert."Inventory Number" := gsERIAL."Inventar number";

                                                    IHInsert."Gauge Size" := rec."Gauge Size";


                                                end;
                                            end;
                                            IHInsert.Reading := rec.Reading;
                                            IHInsert."Date of consumption" := "Date of consumption";

                                            IHInsert."Pressure Type" := Rec."Pressure Type";
                                            IHInsert."Temperature Value" := rec."Temperature Value";
                                            IHInsert."Adjusted Volume" := rec."Adjusted Volume";
                                            IHInsert."Unadjusted Volume" := rec."Unadjusted Volume";
                                            IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corrector";
                                            IHInsert.Temperature := rec.Temperature;
                                            IHInsert."Correction Factor" := rec."Correction Factor";
                                            IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML";



                                            if "Date of consumption" <= Today then begin

                                                IHInsert.Active := true;
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                //   IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;

                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin
                                            CustFind.Reset();
                                            CustFind.SetFilter("No.", '%1', "Customer No.");
                                            if CustFind.FindFirst() then begin
                                                IHInsert."Customer string" := CustFind."Customer String";
                                                IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";

                                                IHInsert."Customer Address" := CustFind.Address;
                                                IHInsert."Customer Category" := CustFind."Customer Category";
                                                if CustFind."Customer Category" = CustFind."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category";

                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert."Customer No." := CustFind."No.";
                                                IHInsert."Customer Post Code" := CustFind."Post Code";
                                                IHInsert.Email := CustFind."E-mail 2";


                                            end;

                                        end;


                                        if dr."Gauge cut off" = true then begin
                                            if (dr.InActive = false) and (dr.Active = false) then begin
                                                if dr."Is not in Calibration facility" = false then begin
                                                    IHInsert."Measuring Point Stroke" := 0;
                                                    IHInsert."Measuring Point string" := 0;
                                                    IHInsert."Measuring Point Adress" := '';
                                                    IHInsert."Measuring Point Code" := '';
                                                    IHInsert."Measurer manufacturer" := '';
                                                end
                                                else begin
                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                            end;

                                        end
                                        else begin

                                            MMTemp.Reset();
                                            MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if MMTemp.FindFirst() then
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                            IHInsert."Measuring Point string" := MMTemp."Measuring Point string";
                                            IHInsert."Measuring Point Adress" := MMTemp.Address;
                                            IHInsert."Measuring Point Code" := MMTemp."No.";
                                            IHInsert."Measurer manufacturer" := "Measurer manufacturer New";


                                        end;


                                        if IHInsert."Installation Date" <> 0D then begin

                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.Type := IHInsert.Type::Gauge;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.Type := IHInsert.Type::Corrector;

                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.Type := IHInsert.Type::Radio_Module;

                                            if IHInsert.Code <> '' then begin
                                                //"Code", "Measuring Point", "Customer No.", "Address MM")

                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                        ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                        ElVolumeGet.Modify;
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                    end;
                                                end;

                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                             and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                        ElVolumeGet."Gauge Code" := '';
                                                        ElVolumeGet.Modify;
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        IHInsert."Gauge Size" := '';

                                                    end;
                                                end;




                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                and (IHInsert."Measuring Point Code" = '') then begin
                                                    IHInsert."Inventory Number" := '';
                                                    IHInsert."Gauge Size" := '';
                                                    IHInsert."Gauge Code" := '';
                                                    IHInsert."Gauge Description" := '';
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, '', '');
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";


                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Serial Number I" := '';
                                                    IHInsert."Serial Number II" := '';
                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                               and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Inventory Number" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";

                                                    end;
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                               and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Serial Number I" := '';
                                                    IHInsert."Serial Number II" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ggf."Year of Production";
                                                        IHInsert."Production Year" := ggf."Year of Production";
                                                        IHInsert."DD calibration" := ggf."DD calibration";
                                                    end;
                                                    MMUpdate.Reset();
                                                    MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                    if MMUpdate.FindFirst() then begin
                                                        IHInsert.Remotely := MMUpdate.Remotely;
                                                        IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                        IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                    end;

                                                end;
                                                if (IHInsertPrevious."Installation Date" <= "Installation Date New") then
                                                    IHInsert.Active := true
                                                else
                                                    IHInsert.Active := false;

                                                if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                if IHInsert.active = true then begin
                                                    IHInsert."Dismantling Date" := 0D;
                                                    IHInsert."Reason for dismantling" := '';
                                                end;
                                                if (IHInsert.Active = false) then begin
                                                    IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                    IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                end;
                                                IHInsert.Insert();
                                                commit();
                                                cs.get;
                                                if cs."Update Data" = true then begin

                                                    if (IHInsert."Dismantling date" = 0D) then
                                                        cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                    Commit();
                                                    cu.InsertNewFirst(IHInsert);
                                                    Commit();
                                                end;

                                            end;

                                            ServiceItemUpdateS.Reset();
                                            ServiceItemUpdateS.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if ServiceItemUpdateS.FindFirst() then begin
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;


                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";

                                                    ServiceItemUpdateS.Modify();
                                                end;
                                                if (dr.Permanently = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently inactive";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);
                                                        //  StatusHPrevious.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;
                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently inactive"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently inactive";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently inactive");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;
                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;
                                                    //kraj
                                                end;

                                                //dodala đemina neaktivan

                                                //kraj djemina


                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();
                                                //tempo
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;

                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";

                                                    ServiceItemUpdateS.Modify();
                                                end;

                                                if (dr."Is not in Calibration facility" = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::Terminated;
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Terminated);
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;

                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::Terminated
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::Terminated;
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::Terminated);
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;


                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;

                                                if (dr.Temporery = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently deregistered";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently deregistered");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;

                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently deregistered"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently deregistered";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently deregistered");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;
                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;
                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;
                                                //kraj


                                            end
                                            else begin

                                            end;
                                            if "Type G_R" = "Type G_R"::Gauge then begin
                                                GaugeFF.Reset();
                                                GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                if GaugeFF.FindFirst() then begin
                                                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                    if IHInsert."Measuring Point Code" <> '' then begin
                                                        if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                            GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                        IHInsert."Customer No." := rec."Customer No.";
                                                    end
                                                    else begin
                                                        if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                            GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                    end;
                                                    CUP.Reset();
                                                    CUP.SetFilter("No.", '%1', Rec."Customer No.");
                                                    if cup.FindFirst() then begin
                                                        GaugeFFRename."Customer Category" := cup."Customer Category";
                                                        GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                        GaugeFFRename.Modify;
                                                    end;

                                                    GaugeFF.Reset();

                                                end;
                                            end;

                                        end;
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin
                                            IHInsert.Reset();

                                            //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";
                                            IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                            //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);


                                            // IHInsert.SetFilter(Code, '%1', Gauge);
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                                IHInsert.SetFilter(Code, '%1', Gauge);
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                                IHInsert.SetFilter(Code, '%1', Corrector);
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                            end;

                                            if not IHInsert.FindFirst() then begin
                                                //nova stavka
                                                IHInsert.Init();
                                                IHInsert."Installation Date" := "Dismantling date New";
                                                IHInsert.RN := "Document No.";
                                                if "Type G_R" = "Type G_R"::Gauge then begin
                                                    GaugeF.Reset();
                                                    GaugeF.SetFilter(Code, '%1', "New Gauges");
                                                    if GaugeF.FindFirst() then begin

                                                        IHInsert."Inventory Number" := GaugeF."Inventar number";
                                                        IHInsert.InvterentoryFil := GaugeF."Inventar number";

                                                    end;
                                                end;

                                                if "Type G_R" = "Type G_R"::Corrector then begin

                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', "Corrector New");
                                                    if ElVolume.FindFirst() then
                                                        IHInsert."Inventory Number" := ElVolume."Inventar number";
                                                    IHInsert.InvterentoryFil := IHInsert."Inventory Number";
                                                    IHInsert."Gauge Code" := rec."New Gauges";
                                                end;

                                                if "Type G_R" = "Type G_R"::Radio_Module then begin

                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', "Radio Module Code New");
                                                    if RadioMM.FindFirst() then
                                                        IHInsert."Serial Number I" := "Serial Number I New";
                                                    IHInsert."Serial Number II" := "Serial Number II New";

                                                    //Code, "Gauge Code", "Measuring Point Code")
                                                    IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(RadioMM.CODE, rec."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                if "Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::"Gauge";

                                                if "Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::"Corrector";
                                                if "Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::"Radio_Module";

                                                IHInsert."Calibration Year" := date2dmy("Installation Date New", 3);
                                                IHInsert."Measuring Point Code" := rec."Service Item No. - Relation";
                                                MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                                if MMTemp.FindFirst() then
                                                    IHInsert."Measuring Point Adress" := MMTemp."Address MM";
                                                IHInsert."Measuring Point string" := MMTemp."Measuring Point String";
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                                IHInsert."Customer Address" := CustFind.Address;
                                                IHInsert."Customer Category" := MMTemp."Customer Category";
                                                if CustFind."Customer Category" = CustFind."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category";

                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert.Email := CustFind."E-mail 2";
                                                IHInsert."Customer No." := MMTemp."Customer No.";
                                                IHInsert."Customer No." := CustFind."No.";
                                                IHInsert."Customer Post Code" := '';
                                                IHInsert."Customer string" := MMTemp."Customer String";
                                                IHInsert."Customer Stroke" := MMTemp."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";

                                                IHInsert."Date of consumption" := Rec."Date of consumption New";
                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";

                                                IHInsert."DD calibration" := Rec."DD calibration";
                                                IHInsert."Calibration Year" := REc."Calibration Year New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";
                                                /*  IHInsert."Serial Number I" := REc."Serial Number I";
                                                  IHInsert."Serial Number II" := GaugeTemp."Serial Number II";
                                                  IHInsert."EL Volume Description" := GaugeTemp."EL Volume Description";
                                                  IHInsert."Dismantling date" := GaugeTemp."Dismantling date";
                                                  IHInsert."Reason for dismantling" := GaugeTemp."Reason for dismantling";*/
                                                if IHInsert."Dismantling date" <= today then begin
                                                    IHInsert.Active := true;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        if IHInsert.Type = IHInsert.Type::Gauge then begin
                                                            GaugeFF.Reset();
                                                            GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                            if GaugeFF.FindFirst() then begin
                                                                //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                                if IHInsert."Measuring Point Code" <> '' then begin
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                                    IHInsert."Customer No." := rec."Customer No.";
                                                                end
                                                                else begin
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                                end;
                                                                CUP.Reset();
                                                                CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                                if cup.FindFirst() then begin
                                                                    GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                    GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                    GaugeFFRename.Modify();
                                                                end;
                                                                GaugeFF.Reset();

                                                            end;
                                                        end;






                                                    IHInsertPrevious.Reset();
                                                    //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                    //  IHInsertPrevious.SetFilter(Code, '%1', Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                    end;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                    end;


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                    end;

                                                    // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                    IHInsertPrevious.SetFilter(Active, '%1', true);
                                                    if IHInsertPrevious.findset() then
                                                        repeat
                                                            IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                            IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                            IHInsertPrevious.Active := false;
                                                            if "Dismantling date New" = 0D then
                                                                IHInsertPrevious."Dismantling date" := "Installation Date New";

                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                IHInsertPrevious.modify;
                                                            cs.get;
                                                            if cs."Update Data" = true then begin
                                                                if IHInsertPrevious."Dismantling date" <> 0D then
                                                                    cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                            end;
                                                        until IHInsertPrevious.Next() = 0;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsert.Type := IHInsert.Type::Radio_Module;
                                                    if IHInsert.Code <> '' then begin
                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                                ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";
                                                                ElVolumeGet.Modify;
                                                                ggf.Reset();
                                                                ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                                if ggf.FindFirst() then
                                                                    IHInsert."Gauge Size" := ggf."Gauge Size";

                                                            end;
                                                        end;

                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                     and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";
                                                                ElVolumeGet."Gauge Code" := '';
                                                                ElVolumeGet.Modify;

                                                                IHInsert."Gauge Size" := '';

                                                            end;
                                                        end;


                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                 and (IHInsert."Measuring Point Code" = '') then begin
                                                            IHInsert."Inventory Number" := '';
                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Gauge Code" := '';
                                                            IHInsert."Gauge Description" := '';
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, '', '');
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Inventory Number" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";

                                                            end;
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Serial Number I" := '';
                                                            IHInsert."Serial Number II" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                                IHInsert."Year of Production" := ggf."Year of Production";
                                                                IHInsert."Production Year" := ggf."Year of Production";
                                                                IHInsert."DD calibration" := ggf."DD calibration";
                                                            end;
                                                            MMUpdate.Reset();
                                                            MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                            if MMUpdate.FindFirst() then begin
                                                                IHInsert.Remotely := MMUpdate.Remotely;
                                                                IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                                IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                            end;

                                                        end;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            IHInsert.Active := true
                                                        else
                                                            IHInsert.Active := false;

                                                        if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                        else
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                        if IHInsert.active = true then begin
                                                            IHInsert."Dismantling Date" := 0D;
                                                            IHInsert."Reason for dismantling" := '';
                                                        end;
                                                        if (IHInsert.Active = false) then begin
                                                            IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                            IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                        end;
                                                        IHInsert.Insert();
                                                        commit();
                                                        cs.get;
                                                        if cs."Update Data" = true then begin

                                                            if (IHInsert."Dismantling date" = 0D) then
                                                                cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                            Commit();
                                                            cu.InsertNewFirst(IHInsert);
                                                            Commit();
                                                        end;

                                                    end;
                                                    Commit();


                                                end;
                                            end
                                            else begin

                                                //ovdje samo ako je odjava, da ga samo uklone
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;

                                        end
                                        else begin

                                            //

                                        end;

                                        //sada hoću da dodam neke nove, ova ugradnja nvoog

                                        //
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin
                                            IHInsert.Reset();
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";

                                            IHInsert.SetFilter("Installation Date", '%1', "Installation Date New");
                                            //  IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code New");
                                            end;

                                            //   IHInsert.SetFilter(Type, '%1', "Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                            if not IHInsert.FindFirst() then begin
                                                IHInsert.Init();
                                                //     IHInsert.Code := "New Gauges";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsert.Code := "New Gauges";
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsert.Code := "New Gauges";
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsert.Code := "Radio Module Code New";
                                                    IHInsert."Gauge Code" := REC."New Gauges";
                                                    gsERIAL.Reset();
                                                    gsERIAL.SetFilter(Code, '%1', REC."New Gauges");
                                                    IF gsERIAL.FindFirst() THEN
                                                        IHInsert."Gauge Description" := gsERIAL."Inventar number";

                                                    IF rmgET.GET(IHInsert.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(IHInsert.CODE, REC."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                IHInsert.Type := "Type G_R";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";

                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."MZ MM" := "MZ MM New";
                                                IHInsert.Reading := "Reading New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";
                                                IHInsert."Street MM" := "Street MM New";
                                                IHInsert."MZ Name MM" := "MZ Name MM New";
                                                IHInsert."Address MM" := "Address MM New";
                                                IHInsert."Dismantling date" := 0D;
                                                IHInsert."Reason for dismantling" := '';
                                                //  IHInsert.Code := "New Gauges";4
                                                CustFind4.reset;
                                                custfind4.setfilter("No.", '%1', "Customer No. New");
                                                if custfind4.findfirst then
                                                    IHInsert.Email := CustFind4."E-mail 2"
                                                else
                                                    IHInsert."Customer No." := "Customer No. New";
                                                IHInsert.Email := CustFind."E-mail 2";
                                                IHInsert.Email := CustFind."E-mail 2";
                                                IHInsert."Street No. MM" := "Street No. MM New";
                                                IHInsert."Customer Name" := "Customer Name New";
                                                IHInsert."Customer City" := "Customer City New";
                                                IHInsert."Street Name MM" := "Street Name MM New";
                                                IHInsert."DD calibration" := "DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."DD calibration" := rec."DD calibration Corr New";

                                                IHInsert."MM Description" := "MM Description New";
                                                IHInsert."Serial Number I" := "Serial Number I New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";

                                                IHInsert."Customer string" := "Customer string New";
                                                IHInsert."Customer Stroke" := "Customer Stroke New";
                                                IHInsert."Production Year" := "Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."Production Year" := rec."Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."Production Year" := rec."Year of Production RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."Production Year" := rec."Year of Production Corr New";

                                                IHInsert."Serial Number II" := "Serial Number II New";
                                                if ((RMYes = true) and ("Type G_R" = "Type G_R"::Gauge))
                                                   or ((RMYes = false) and ("Type G_R" = "Type G_R"::Gauge)) then begin

                                                    IHInsert."Inventory Number" := "Inventory Number New";
                                                    IHInsert.InvterentoryFil := "Inventory Number New";

                                                end;
                                                IHInsert."Calibration Year" := "Calibration Year New";
                                                IHInsert."Customer Address" := "Customer Address New";
                                                IHInsert."Dismantling date" := "Dismantling date New";
                                                IHInsert."Programming date" := "Programming date New";
                                                IHInsert."Customer Category" := "Customer Category New";
                                                if CustFind."Customer Category" = CustFind."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := CustFind."Customer Category";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";
                                                IHInsert."Customer Post Code" := "Customer Post Code New";
                                                IHInsert."Date of consumption" := "Date of consumption New";
                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";

                                                IHInsert."Customer Zone stroke" := "Customer Zone stroke New";
                                                IHInsert."Date of rescheduling" := "Date of rescheduling New";
                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."Municipality Code MM" := "Municipality Code MM New";
                                                IHInsert."EL Volume Description" := "EL Volume Description New";
                                                IHInsert."Measurer manufacturer" := "Measurer manufacturer New";
                                                IHInsert."Measuring Point string" := "Measuring Point string New";
                                                IHInsert."Measuring Point Stroke" := "Measuring Point Stroke New";
                                                IHInsert."Reason for dismantling" := "Reason for dismantling New";
                                                IHInsert."Measuring Point Adress" := "Measuring Point Address New";
                                                if IHInsert."Installation Date" <= today
                     then begin

                                                    IHInsert.Active := true;
                                                    if "Type G_R" = "Type G_R"::Gauge then begin
                                                        GaugeFF.Reset();
                                                        GaugeFF.SetFilter(Code, '%1', IHInsert.Code);
                                                        if GaugeFF.FindFirst() then begin
                                                            //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                            if IHInsert."Measuring Point Code" <> '' then begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                                IHInsert."Customer No." := rec."Customer No.";
                                                            end
                                                            else begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                            end;
                                                            CUP.Reset();
                                                            CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                            if cup.FindFirst() then begin
                                                                GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                GaugeFFRename.Modify();
                                                            end;

                                                            GaugeFF.Reset();

                                                        end;
                                                    end;

                                                end;
                                                MMNew.Reset();
                                                MMNew.SetFilter("No.", '%1', "Measuring Point Code New");
                                                if MMNew.FindFirst() then begin
                                                    IHInsert."Measuring Point string" := MMNew."Measuring Point string";
                                                    IHInsert."Measuring Point Stroke" := MMNew."Measuring Point Stroke";
                                                    IHInsert."Measuring Point Adress" := MMNew."Address MM";

                                                end;

                                                CustNew.Reset();
                                                CustNew.SetFilter("No.", '%1', "Customer No. New");
                                                if CustNew.FindFirst() then begin

                                                    IHInsert."Customer Address" := CustNew.Address;
                                                    IHInsert."Customer Category" := CustNew."Customer Category";
                                                    if CustNew."Customer Category" = CustNew."Customer Category"::"KJKP Heating plant" then
                                                        IHInsert."Customer Category Filter" := CustNew."Customer Category"::"Large Economy"
                                                    else
                                                        IHInsert."Customer Category Filter" := CustNew."Customer Category";

                                                    IHInsert."Customer City" := CustNew.City;
                                                    IHInsert."Customer Name" := CustNew.Name;
                                                    IHInsert."Customer No." := CustNew."No.";
                                                    IHInsert."Customer Post Code" := CustNew."Post Code";

                                                end;
                                                IHInsert.Type := rec."Type G_R";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::Gauge;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::Corrector;

                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::Radio_Module;
                                                if IHInsert.Code <> '' then begin
                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                            ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                            ElVolumeGet.Modify;
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                 and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                            ElVolumeGet."Gauge Code" := '';
                                                            ElVolumeGet.Modify;

                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                               and (IHInsert."Measuring Point Code" = '') then begin
                                                        IHInsert."Inventory Number" := '';
                                                        IHInsert."Gauge Size" := '';
                                                        IHInsert."Gauge Code" := '';
                                                        IHInsert."Gauge Description" := '';
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, '', '');
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Inventory Number" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";

                                                        end;
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Serial Number I" := '';
                                                        IHInsert."Serial Number II" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ggf."Year of Production";
                                                            IHInsert."Production Year" := ggf."Year of Production";
                                                            IHInsert."DD calibration" := ggf."DD calibration";
                                                        end;
                                                        MMUpdate.Reset();
                                                        MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                        if MMUpdate.FindFirst() then begin
                                                            IHInsert.Remotely := MMUpdate.Remotely;
                                                            IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                            IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                        end;


                                                    end;
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsert.Active := true
                                                    else
                                                        IHInsert.Active := false;

                                                    if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                    else
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                    if IHInsert.active = true then begin
                                                        IHInsert."Dismantling Date" := 0D;
                                                        IHInsert."Reason for dismantling" := '';
                                                    end;
                                                    if (IHInsert.Active = false) then begin
                                                        IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                        IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                    end;
                                                    IHInsert.Insert();
                                                    commit();
                                                    cs.get;
                                                    if cs."Update Data" = true then begin

                                                        if (IHInsert."Dismantling date" = 0D) then
                                                            cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                        Commit();
                                                        cu.InsertNewFirst(IHInsert);
                                                        Commit();
                                                    end;

                                                end;
                                                Commit();

                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                //  IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code New");
                                                end;

                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                //IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;

                                        end;

                                    end;
                                    //kraj
                                    if RMYes = true then
                                        Rec."Type G_R" := Rec."Type G_R"::"Radio_Module"
                                    else
                                        Rec."Type G_R" := Rec."Type G_R"::Corrector;
                                    //ovdje je pocetak RM

                                    IHInsert.Reset();

                                    //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.
                                    if rec."Installation Date New" = 0D then
                                        rec."Installation Date New" := "Dismantling date New";

                                    IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                    //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");

                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                        IHInsert.SetFilter(Code, '%1', Gauge);
                                    end;

                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                        IHInsert.SetFilter(Code, '%1', Corrector);
                                    end;


                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                        IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                    end;


                                    if not IHInsert.FindFirst() then begin
                                        //nova stavka
                                        IHInsert.Init();
                                        IHInsert."Installation Date" := "Dismantling date New";

                                        IHInsert.RN := "Document No.";
                                        if rec."Type G_R" = rec."Type G_R"::Gauge then
                                            IHInsert.Code := Gauge;
                                        if rec."Type G_R" = rec."Type G_R"::Radio_Module then BEGIN
                                            IHInsert.Code := "Radio Module Code";
                                            IHInsert."Gauge Code" := REC.Gauge;

                                            IF rmgET.GET(ihINSERT.CODE, iHINSERT."Gauge Code", iHiNSERT."Measuring Point Code") THEN BEGIN
                                                rmgET.RENAME(IHINSERT.CODE, REC.Gauge, rec."Service Item No. - Relation");
                                                IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                ggf.RESET;
                                                ggf.SetFilter(Code, '%1', REC.Gauge);
                                                IF ggf.FindFirst() THEN
                                                    rmgET."Gauge Description" := GGF."Inventar number";
                                                rmgET.Modify();
                                            END;
                                            Commit();

                                            gsERIAL.Reset();
                                            gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                            IF gsERIAL.FindFirst() THEN
                                                IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                        END;
                                        if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                            if CcorrYes = true then begin
                                                IHInsert."Gauge Code" := rec.Gauge;
                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN
                                                    IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                                IHInsert."Gauge Size" := gsERIAL."Gauge Size";
                                            end;
                                            IHInsert.Code := Corrector;
                                        end;
                                        if dr."Gauge cut off" = true then begin
                                            //ako je odjava

                                            if (dr.InActive = false) and (dr.Active = false) then begin

                                                if dr."Is not in Calibration facility" = false then begin
                                                    IHInsert."Customer Stroke" := 0;
                                                    IHInsert."Customer string" := 0;
                                                    IHInsert."Customer Zone stroke" := 0;
                                                    IHInsert."Customer Address" := '';
                                                    IHInsert."Customer Category" := CustFind."Customer Category"::" ";
                                                    IHInsert."Customer City" := '';
                                                    IHInsert."Customer Name" := '';
                                                    IHInsert."Customer No." := '';
                                                    IHInsert."Customer Post Code" := '';
                                                end
                                                else begin
                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN begin


                                                    IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                    if RMYes = false then begin

                                                        IHInsert."Inventory Number" := gsERIAL."Inventar number";
                                                        IHInsert."Gauge Size" := rec."Gauge Size";

                                                    end;

                                                end;
                                            end;
                                            IHInsert.Reading := rec.Reading;
                                            IHInsert."Date of consumption" := "Date of consumption";
                                            IHInsert."Pressure Type" := Rec."Pressure Type";
                                            IHInsert."Temperature Value" := rec."Temperature Value";
                                            IHInsert."Adjusted Volume" := rec."Adjusted Volume";
                                            IHInsert."Unadjusted Volume" := rec."Unadjusted Volume";
                                            IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corrector";
                                            IHInsert.Temperature := rec.Temperature;
                                            IHInsert."Correction Factor" := rec."Correction Factor";
                                            IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML";


                                            if "Date of consumption" <= Today then begin
                                                IHInsert.Active := true;
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                //   IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin
                                            CustFind.Reset();
                                            CustFind.SetFilter("No.", '%1', "Customer No.");
                                            if CustFind.FindFirst() then begin
                                                IHInsert."Customer string" := CustFind."Customer String";
                                                IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";

                                                IHInsert."Customer Address" := CustFind.Address;
                                                IHInsert."Customer Category" := CustFind."Customer Category";
                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert."Customer No." := CustFind."No.";
                                                IHInsert."Customer Post Code" := CustFind."Post Code";


                                            end;

                                        end;


                                        if dr."Gauge cut off" = true then begin
                                            if (dr.InActive = false) and (dr.Active = false) then begin
                                                if dr."Is not in Calibration facility" = false then begin
                                                    IHInsert."Measuring Point Stroke" := 0;
                                                    IHInsert."Measuring Point string" := 0;
                                                    IHInsert."Measuring Point Adress" := '';
                                                    IHInsert."Measuring Point Code" := '';
                                                    IHInsert."Measurer manufacturer" := '';
                                                end
                                                else begin

                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                            end;

                                        end
                                        else begin

                                            MMTemp.Reset();
                                            MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if MMTemp.FindFirst() then
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                            IHInsert."Measuring Point string" := MMTemp."Measuring Point string";
                                            IHInsert."Measuring Point Adress" := MMTemp.Address;
                                            IHInsert."Measuring Point Code" := MMTemp."No.";
                                            IHInsert."Measurer manufacturer" := "Measurer manufacturer New";


                                        end;


                                        if IHInsert."Installation Date" <> 0D then begin

                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.Type := IHInsert.Type::Gauge;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.Type := IHInsert.Type::Corrector;

                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.Type := IHInsert.Type::Radio_Module;

                                            if IHInsert.Code <> '' then begin
                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                        ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                        ElVolumeGet.Modify;
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                    end;
                                                end;

                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                             and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                        ElVolumeGet."Gauge Code" := '';
                                                        ElVolumeGet.Modify;
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        IHInsert."Gauge Size" := '';

                                                    end;
                                                end;

                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                and (IHInsert."Measuring Point Code" = '') then begin
                                                    IHInsert."Inventory Number" := '';
                                                    IHInsert."Gauge Size" := '';
                                                    IHInsert."Gauge Code" := '';
                                                    IHInsert."Gauge Description" := '';
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, '', '');
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Inventory Number" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";

                                                    end;
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Serial Number I" := '';
                                                    IHInsert."Serial Number II" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ggf."Year of Production";
                                                        IHInsert."Production Year" := ggf."Year of Production";
                                                        IHInsert."DD calibration" := ggf."DD calibration";
                                                    end;
                                                    MMUpdate.Reset();
                                                    MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                    if MMUpdate.FindFirst() then begin
                                                        IHInsert.Remotely := MMUpdate.Remotely;
                                                        IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                        IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                    end;

                                                end;
                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                    IHInsert.Active := true
                                                else
                                                    IHInsert.Active := false;
                                                if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                if IHInsert.active = true then begin
                                                    IHInsert."Dismantling Date" := 0D;
                                                    IHInsert."Reason for dismantling" := '';
                                                end;
                                                if (IHInsert.Active = false) then begin
                                                    IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                    IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                end;
                                                IHInsert.Insert();
                                                commit();
                                                cs.get;
                                                if cs."Update Data" = true then begin

                                                    if (IHInsert."Dismantling date" = 0D) then
                                                        cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                    Commit();
                                                    cu.InsertNewFirst(IHInsert);
                                                    Commit();
                                                end;

                                            end;
                                            Commit();

                                            ServiceItemUpdateS.Reset();
                                            ServiceItemUpdateS.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if ServiceItemUpdateS.FindFirst() then begin
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;


                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";


                                                    ServiceItemUpdateS.Modify();
                                                end;
                                                if (dr.Permanently = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently inactive";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);
                                                        //   StatusHPrevious.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then begin
                                                                    StatusHPrevious.Active := false;
                                                                    StatusHPrevious.Modify();
                                                                end;
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;


                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently inactive"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently inactive";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently inactive");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;
                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;
                                                end;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();
                                                //tempo
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;


                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";

                                                    ServiceItemUpdateS.Modify();
                                                end;
                                                if (dr."Is not in Calibration facility" = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::Terminated;
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Terminated);
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;

                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::Terminated
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::Terminated;
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::Terminated);
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;

                                                if (dr.Temporery = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently deregistered";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently deregistered");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then begin
                                                                    StatusHPrevious.Active := false;
                                                                    StatusHPrevious.Modify();
                                                                end;
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;
                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently deregistered"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently deregistered";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently deregistered");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;
                                                //kraj


                                            end
                                            else begin

                                            end;
                                            if "Type G_R" = "Type G_R"::Gauge then begin
                                                GaugeFF.Reset();
                                                GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                if GaugeFF.FindFirst() then begin
                                                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                    if IHInsert."Measuring Point Code" <> '' then begin
                                                        if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                            GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                        IHInsert."Customer No." := rec."Customer No.";
                                                    end
                                                    else begin
                                                        if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                            GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                    end;
                                                    CUP.Reset();
                                                    CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                    if cup.FindFirst() then begin
                                                        GaugeFFRename."Customer Category" := cup."Customer Category";
                                                        GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                        GaugeFFRename.Modify;
                                                    end;

                                                    GaugeFF.Reset();

                                                end;
                                            end;

                                        end;
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin
                                            IHInsert.Reset();

                                            //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";
                                            IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                            //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);


                                            // IHInsert.SetFilter(Code, '%1', Gauge);
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                                IHInsert.SetFilter(Code, '%1', Gauge);
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                                IHInsert.SetFilter(Code, '%1', Corrector);
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                            end;

                                            if not IHInsert.FindFirst() then begin
                                                //nova stavka
                                                IHInsert.Init();
                                                IHInsert."Installation Date" := "Dismantling date New";
                                                IHInsert.RN := "Document No.";
                                                if "Type G_R" = "Type G_R"::Gauge then begin
                                                    GaugeF.Reset();
                                                    GaugeF.SetFilter(Code, '%1', "New Gauges");
                                                    if GaugeF.FindFirst() then begin

                                                        IHInsert."Inventory Number" := GaugeF."Inventar number";
                                                        IHInsert.InvterentoryFil := GaugeF."Inventar number";

                                                    end;
                                                end;

                                                if "Type G_R" = "Type G_R"::Corrector then begin

                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', "Corrector New");
                                                    if ElVolume.FindFirst() then
                                                        IHInsert."Inventory Number" := ElVolume."Inventar number";
                                                    IHInsert.InvterentoryFil := IHInsert."Inventory Number";
                                                    IHInsert."Gauge Code" := rec."New Gauges";
                                                end;

                                                if "Type G_R" = "Type G_R"::Radio_Module then begin

                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', "Radio Module Code New");
                                                    if RadioMM.FindFirst() then
                                                        IHInsert."Serial Number I" := "Serial Number I New";
                                                    IHInsert."Serial Number II" := "Serial Number II New";

                                                    //Code, "Gauge Code", "Measuring Point Code")
                                                    IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(RadioMM.CODE, REC."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                if "Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::"Gauge";

                                                if "Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::"Corrector";
                                                if "Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::"Radio_Module";

                                                IHInsert."Calibration Year" := date2dmy("Installation Date New", 3);
                                                IHInsert."Measuring Point Code" := rec."Service Item No. - Relation";
                                                MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                                if MMTemp.FindFirst() then
                                                    IHInsert."Measuring Point Adress" := MMTemp."Address MM";
                                                IHInsert."Measuring Point string" := MMTemp."Measuring Point String";
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                                IHInsert."Customer Address" := CustFind.Address;
                                                IHInsert."Customer Category" := MMTemp."Customer Category";
                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;

                                                IHInsert.Email := CustFind."E-mail 2";


                                                IHInsert."Customer No." := MMTemp."Customer No.";

                                                IHInsert."Customer No." := CustFind."No.";
                                                IHInsert."Customer Post Code" := '';
                                                IHInsert."Customer string" := MMTemp."Customer String";
                                                IHInsert."Customer Stroke" := MMTemp."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";
                                                IHInsert."Date of consumption" := Rec."Date of consumption New";

                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";

                                                IHInsert."DD calibration" := Rec."DD calibration";
                                                IHInsert."Calibration Year" := REc."Calibration Year New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";
                                                /*  IHInsert."Serial Number I" := REc."Serial Number I";
                                                  IHInsert."Serial Number II" := GaugeTemp."Serial Number II";
                                                  IHInsert."EL Volume Description" := GaugeTemp."EL Volume Description";
                                                  IHInsert."Dismantling date" := GaugeTemp."Dismantling date";
                                                  IHInsert."Reason for dismantling" := GaugeTemp."Reason for dismantling";*/
                                                if IHInsert."Dismantling date" <= today then begin
                                                    IHInsert.Active := true;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        if IHInsert.Type = IHInsert.Type::Gauge then begin
                                                            GaugeFF.Reset();
                                                            GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                            if GaugeFF.FindFirst() then begin
                                                                //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                                if IHInsert."Measuring Point Code" <> '' then begin
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                                    IHInsert."Customer No." := rec."Customer No.";
                                                                end
                                                                else begin
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                                end;
                                                                CUP.Reset();
                                                                CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                                if cup.FindFirst() then begin
                                                                    GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                    GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                    GaugeFFRename.Modify();
                                                                end;
                                                                GaugeFF.Reset();

                                                            end;
                                                        end;






                                                    IHInsertPrevious.Reset();
                                                    //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                    //  IHInsertPrevious.SetFilter(Code, '%1', Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                    end;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                    end;


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                    end;

                                                    // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                    IHInsertPrevious.SetFilter(Active, '%1', true);
                                                    if IHInsertPrevious.findset() then
                                                        repeat
                                                            IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                            IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                            if "Dismantling date New" = 0D then
                                                                IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then begin
                                                                IHInsertPrevious.Active := false;
                                                                IHInsertPrevious.modify;
                                                                cs.get;
                                                                if cs."Update Data" = true then begin
                                                                    if IHInsertPrevious."Dismantling date" <> 0D then
                                                                        cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                                end;
                                                            end;
                                                        until IHInsertPrevious.Next() = 0;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsert.Type := IHInsert.Type::Radio_Module;
                                                    if IHInsert.Code <> '' then begin
                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                                ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                                ElVolumeGet.Modify;
                                                                ggf.Reset();
                                                                ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                                if ggf.FindFirst() then
                                                                    IHInsert."Gauge Size" := ggf."Gauge Size";
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                            end;
                                                        end;

                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                     and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                                ElVolumeGet."Gauge Code" := '';
                                                                ElVolumeGet.Modify;

                                                                IHInsert."Gauge Size" := '';
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                            end;
                                                        end;

                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                 and (IHInsert."Measuring Point Code" = '') then begin
                                                            IHInsert."Inventory Number" := '';
                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Gauge Code" := '';
                                                            IHInsert."Gauge Description" := '';
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, '', '');
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Inventory Number" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";

                                                            end;
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";


                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Serial Number I" := '';
                                                            IHInsert."Serial Number II" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                                IHInsert."Year of Production" := ggf."Year of Production";
                                                                IHInsert."Production Year" := ggf."Year of Production";
                                                                IHInsert."DD calibration" := ggf."DD calibration";
                                                            end;
                                                            MMUpdate.Reset();
                                                            MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                            if MMUpdate.FindFirst() then begin
                                                                IHInsert.Remotely := MMUpdate.Remotely;
                                                                IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                                IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                            end;

                                                        end;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            IHInsert.Active := true
                                                        else
                                                            IHInsert.Active := false;
                                                        if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                        else
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                        if IHInsert.active = true then begin
                                                            IHInsert."Dismantling Date" := 0D;
                                                            IHInsert."Reason for dismantling" := '';
                                                        end;
                                                        if (IHInsert.Active = false) then begin
                                                            IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                            IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                        end;
                                                        cs.get;
                                                        if cs."Update Data" = true then begin

                                                            if (IHInsert."Dismantling date" = 0D) then
                                                                cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                            Commit();
                                                            cu.InsertNewFirst(IHInsert);
                                                            Commit();
                                                        end;

                                                    end;
                                                    Commit();


                                                end;
                                            end
                                            else begin

                                                //ovdje samo ako je odjava, da ga samo uklone
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;

                                        end
                                        else begin

                                            //

                                        end;

                                        //sada hoću da dodam neke nove, ova ugradnja nvoog

                                        //
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin

                                            IHInsert.Reset();
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";
                                            IHInsert.SetFilter("Installation Date", '%1', "Installation Date New");
                                            //  IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Code, '%1', "Corrector New");
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code New");
                                            end;

                                            //   IHInsert.SetFilter(Type, '%1', "Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                            if not IHInsert.FindFirst() then begin
                                                IHInsert.Init();
                                                //     IHInsert.Code := "New Gauges";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsert.Code := "New Gauges";
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsert.Code := "Corrector New";
                                                end;
                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsert."Gauge Code" := rec."New Gauges";

                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsert.Code := "Radio Module Code New";
                                                    IHInsert."Gauge Code" := REC."New Gauges";
                                                    gsERIAL.Reset();
                                                    gsERIAL.SetFilter(Code, '%1', REC."New Gauges");
                                                    IF gsERIAL.FindFirst() THEN
                                                        IHInsert."Gauge Description" := gsERIAL."Inventar number";

                                                    IF rmgET.GET(IHInsert.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(IHInsert.CODE, REC."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                IHInsert.Type := "Type G_R";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";
                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."MZ MM" := "MZ MM New";
                                                IHInsert.Reading := "Reading New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";
                                                IHInsert."Street MM" := "Street MM New";
                                                IHInsert."MZ Name MM" := "MZ Name MM New";
                                                IHInsert."Address MM" := "Address MM New";
                                                IHInsert."Dismantling date" := 0D;
                                                IHInsert."Reason for dismantling" := '';
                                                //  IHInsert.Code := "New Gauges";
                                                IHInsert."Customer No." := "Customer No. New";
                                                CustFind4.reset;
                                                custfind4.setfilter("No.", '%1', "Customer No. New");
                                                if custfind4.findfirst then
                                                    IHInsert.Email := CustFind4."E-mail 2"
                                                else
                                                    IHInsert.Email := '';

                                                IHInsert."Street No. MM" := "Street No. MM New";
                                                IHInsert."Customer Name" := "Customer Name New";
                                                IHInsert."Customer City" := "Customer City New";
                                                IHInsert."Street Name MM" := "Street Name MM New";
                                                IHInsert."DD calibration" := "DD calibration New";
                                                IHInsert."Customer No." := "Customer No. New";

                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."DD calibration" := rec."DD calibration Corr New";
                                                IHInsert."MM Description" := "MM Description New";
                                                IHInsert."Serial Number I" := "Serial Number I New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";

                                                IHInsert."Customer string" := "Customer string New";
                                                IHInsert."Customer Stroke" := "Customer Stroke New";
                                                IHInsert."Production Year" := "Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."Production Year" := rec."Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."Production Year" := rec."Year of Production RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."Production Year" := rec."Year of Production Corr New";
                                                IHInsert."Serial Number II" := "Serial Number II New";

                                                IHInsert."Inventory Number" := "Inventory Number New";
                                                IHInsert.InvterentoryFil := "Inventory Number New";

                                                IHInsert."Calibration Year" := "Calibration Year New";
                                                IHInsert."Customer Address" := "Customer Address New";
                                                IHInsert."Dismantling date" := "Dismantling date New";
                                                IHInsert."Programming date" := "Programming date New";
                                                IHInsert."Customer Category" := "Customer Category New";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";
                                                IHInsert."Customer Post Code" := "Customer Post Code New";
                                                IHInsert."Date of consumption" := "Date of consumption New";
                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";


                                                IHInsert."Customer Zone stroke" := "Customer Zone stroke New";
                                                IHInsert."Date of rescheduling" := "Date of rescheduling New";
                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."Municipality Code MM" := "Municipality Code MM New";
                                                IHInsert."EL Volume Description" := "EL Volume Description New";
                                                IHInsert."Measurer manufacturer" := "Measurer manufacturer New";
                                                IHInsert."Measuring Point string" := "Measuring Point string New";
                                                IHInsert."Measuring Point Stroke" := "Measuring Point Stroke New";
                                                IHInsert."Reason for dismantling" := "Reason for dismantling New";
                                                IHInsert."Measuring Point Adress" := "Measuring Point Address New";
                                                if IHInsert."Installation Date" <= today
                     then begin

                                                    IHInsert.Active := true;
                                                    if "Type G_R" = "Type G_R"::Gauge then begin
                                                        GaugeFF.Reset();
                                                        GaugeFF.SetFilter(Code, '%1', IHInsert.Code);
                                                        if GaugeFF.FindFirst() then begin
                                                            //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                            if IHInsert."Measuring Point Code" <> '' then begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                                IHInsert."Customer No." := rec."Customer No.";
                                                            end
                                                            else begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                            end;
                                                            CUP.Reset();
                                                            CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                            if cup.FindFirst() then begin
                                                                GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                GaugeFFRename.Modify();
                                                            end;

                                                            GaugeFF.Reset();

                                                        end;
                                                    end;

                                                end;
                                                MMNew.Reset();
                                                MMNew.SetFilter("No.", '%1', "Measuring Point Code New");
                                                if MMNew.FindFirst() then begin
                                                    IHInsert."Measuring Point string" := MMNew."Measuring Point string";
                                                    IHInsert."Measuring Point Stroke" := MMNew."Measuring Point Stroke";
                                                    IHInsert."Measuring Point Adress" := MMNew."Address MM";

                                                end;

                                                CustNew.Reset();
                                                CustNew.SetFilter("No.", '%1', "Customer No. New");
                                                if CustNew.FindFirst() then begin

                                                    IHInsert."Customer Address" := CustNew.Address;
                                                    IHInsert."Customer Category" := CustNew."Customer Category";
                                                    IHInsert."Customer City" := CustNew.City;
                                                    IHInsert."Customer Name" := CustNew.Name;
                                                    IHInsert."Customer Post Code" := CustNew."Post Code";
                                                    IHInsert."Customer No." := "Customer No. New";

                                                end;
                                                IHInsert.Type := rec."Type G_R";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::Gauge;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::Corrector;

                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::Radio_Module;
                                                if IHInsert.Code <> '' then begin
                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                            ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                            ElVolumeGet.Modify;
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                 and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                            ElVolumeGet."Gauge Code" := '';
                                                            ElVolumeGet.Modify;

                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                  and (IHInsert."Measuring Point Code" = '') then begin
                                                        IHInsert."Inventory Number" := '';
                                                        IHInsert."Gauge Size" := '';
                                                        IHInsert."Gauge Code" := '';
                                                        IHInsert."Gauge Description" := '';
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, '', '');
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Inventory Number" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";

                                                        end;
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Serial Number I" := '';
                                                        IHInsert."Serial Number II" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ggf."Year of Production";
                                                            IHInsert."Production Year" := ggf."Year of Production";
                                                            IHInsert."DD calibration" := ggf."DD calibration";
                                                        end;
                                                        MMUpdate.Reset();
                                                        MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                        if MMUpdate.FindFirst() then begin
                                                            IHInsert.Remotely := MMUpdate.Remotely;
                                                            IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                            IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                        end;

                                                    end;
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsert.Active := true
                                                    else
                                                        IHInsert.Active := false;

                                                    if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                    else
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                    if IHInsert.active = true then begin
                                                        IHInsert."Dismantling Date" := 0D;
                                                        IHInsert."Reason for dismantling" := '';
                                                    end;
                                                    if (IHInsert.Active = false) then begin
                                                        IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                        IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                    end;
                                                    IHInsert.Insert();
                                                    commit();
                                                    cs.get;
                                                    if cs."Update Data" = true then begin

                                                        if (IHInsert."Dismantling date" = 0D) then
                                                            cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                        Commit();
                                                        cu.InsertNewFirst(IHInsert);
                                                        Commit();
                                                    end;

                                                end;
                                                Commit();

                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                //  IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code New");
                                                end;

                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                //IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.geT;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;
                                        end;
                                    end;

                                end

                                else begin
                                    //ako je verifikacija, trebala bi aktivno staviti da je u laboratoriji
                                    IHInsert.Reset();

                                    //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.
                                    if rec."Installation Date New" = 0D then
                                        rec."Installation Date New" := "Dismantling date New";
                                    IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                    //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");

                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                        IHInsert.SetFilter(Code, '%1', Gauge);
                                    end;

                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                        IHInsert.SetFilter(Code, '%1', Corrector);
                                    end;


                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                        IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                        IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                    end;


                                    if not IHInsert.FindFirst() then begin
                                        //nova stavka
                                        IHInsert.Init();
                                        IHInsert."Installation Date" := "Dismantling date New";
                                        IHInsert.RN := "Document No.";
                                        if rec."Type G_R" = rec."Type G_R"::Gauge then
                                            IHInsert.Code := Gauge;
                                        if rec."Type G_R" = rec."Type G_R"::Radio_Module then BEGIN
                                            IHInsert.Code := "Radio Module Code";
                                            IHInsert."Gauge Code" := REC.Gauge;

                                            IF rmgET.GET(ihINSERT.CODE, iHINSERT."Gauge Code", iHiNSERT."Measuring Point Code") THEN BEGIN
                                                rmgET.RENAME(IHINSERT.CODE, REC.Gauge, rec."Service Item No. - Relation");
                                                IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                ggf.RESET;
                                                ggf.SetFilter(Code, '%1', REC.Gauge);
                                                IF ggf.FindFirst() THEN
                                                    rmgET."Gauge Description" := GGF."Inventar number";
                                                rmgET.Modify();
                                            END;
                                            Commit();

                                            gsERIAL.Reset();
                                            gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                            IF gsERIAL.FindFirst() THEN
                                                IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                        END;
                                        if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                            IHInsert.Code := Corrector;
                                            if CcorrYes = true then begin
                                                IHInsert."Gauge Code" := rec.Gauge;
                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN
                                                    IHInsert."Gauge Description" := gsERIAL."Inventar number";
                                                IHInsert."Gauge Size" := gsERIAL."Gauge Size";
                                            end;
                                        end;
                                        if dr."Gauge cut off" = true then begin
                                            //ako je odjava

                                            if (dr.InActive = false) and (dr.Active = false) then begin
                                                if dr."Is not in Calibration facility" = false then begin
                                                    IHInsert."Customer Stroke" := 0;
                                                    IHInsert."Customer string" := 0;
                                                    IHInsert."Customer Zone stroke" := 0;
                                                    IHInsert."Customer Address" := '';
                                                    IHInsert."Customer Category" := CustFind."Customer Category"::" ";
                                                    IHInsert."Customer City" := '';
                                                    IHInsert."Customer Name" := '';
                                                    IHInsert."Customer No." := '';
                                                end
                                                else begin
                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                                gsERIAL.Reset();
                                                gsERIAL.SetFilter(Code, '%1', REC.Gauge);
                                                IF gsERIAL.FindFirst() THEN begin
                                                    IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                    if (RMYes = false) and ("Type G_R" = "Type G_R"::Gauge) then begin

                                                        IHInsert."Inventory Number" := gsERIAL."Inventar number";

                                                        IHInsert."Gauge Size" := rec."Gauge Size";
                                                        "Year of Production" := rec."Year of Production";

                                                    end;


                                                end;
                                                IHInsert."Customer Post Code" := '';
                                            end;
                                            IHInsert.Reading := rec.Reading;
                                            IHInsert."Date of consumption" := "Date of consumption";
                                            IHInsert."Pressure Type" := Rec."Pressure Type";
                                            IHInsert."Temperature Value" := rec."Temperature Value";
                                            IHInsert."Adjusted Volume" := rec."Adjusted Volume";
                                            IHInsert."Unadjusted Volume" := rec."Unadjusted Volume";
                                            IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corrector";
                                            IHInsert.Temperature := rec.Temperature;
                                            IHInsert."Correction Factor" := rec."Correction Factor";
                                            IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML";


                                            if "Date of consumption" <= Today then begin
                                                IHInsert.Active := true;
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                //   IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";

                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.geT;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;
                                            end;
                                        end
                                        else begin
                                            CustFind.Reset();
                                            CustFind.SetFilter("No.", '%1', "Customer No.");
                                            if CustFind.FindFirst() then begin
                                                IHInsert."Customer string" := CustFind."Customer String";
                                                IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";

                                                IHInsert."Customer Address" := CustFind.Address;
                                                IHInsert."Customer Category" := CustFind."Customer Category";
                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert."Customer No." := CustFind."No.";
                                                IHInsert."Customer Post Code" := CustFind."Post Code";
                                                IHInsert."Customer No." := "Customer No.";
                                                IHInsert.Email := CustFind."E-mail 2";



                                            end;

                                        end;


                                        if dr."Gauge cut off" = true then begin
                                            if (dr.InActive = false) and (dr.Active = false) then begin
                                                if dr."Is not in Calibration facility" = false
     then begin

                                                    IHInsert."Measuring Point Stroke" := 0;
                                                    IHInsert."Measuring Point string" := 0;
                                                    IHInsert."Measuring Point Adress" := '';
                                                    IHInsert."Measuring Point Code" := '';
                                                    IHInsert."Measurer manufacturer" := '';
                                                end

                                                else begin
                                                    CustFind.Reset();
                                                    CustFind.SetFilter("No.", '%1', "Customer No.");
                                                    if CustFind.FindFirst() then begin
                                                        IHInsert."Customer Stroke" := CustFind."Customer Stroke";
                                                        IHInsert."Customer string" := CustFind."Customer String";
                                                        IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                        IHInsert."Customer Address" := CustFind.Address;
                                                        IHInsert."Customer Category" := CustFind."Customer Category";
                                                        IHInsert."Measuring Point Code" := Rec."Service Item No. - Relation";
                                                        IHInsert."Customer City" := CustFind.City;
                                                        if CustFind."Name 2" <> '' then
                                                            IHInsert."Customer Name" := CustFind.Name + ' ' + CustFind."Name 2"
                                                        else
                                                            IHInsert."Customer Name" := CustFind.Name;
                                                        IHInsert."Customer No." := "Customer No.";
                                                        IHInsert."Customer Post Code" := CustFind."Post Code";
                                                    end;
                                                end;
                                            end;

                                        end
                                        else begin

                                            MMTemp.Reset();
                                            MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if MMTemp.FindFirst() then
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                            IHInsert."Measuring Point string" := MMTemp."Measuring Point string";
                                            IHInsert."Measuring Point Adress" := MMTemp.Address;
                                            IHInsert."Measuring Point Code" := MMTemp."No.";
                                            IHInsert."Measurer manufacturer" := "Measurer manufacturer New";


                                        end;


                                        if IHInsert."Installation Date" <> 0D then begin

                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.Type := IHInsert.Type::Gauge;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.Type := IHInsert.Type::Corrector;

                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.Type := IHInsert.Type::Radio_Module;

                                            if IHInsert.Code <> '' then begin
                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                        ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                        ElVolumeGet.Modify;
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                    end;
                                                end;

                                                if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                             and (IHInsert.Active = true) then begin
                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                    if ElVolume.FindFirst() then begin
                                                        if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                        then
                                                            ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                        ElVolumeGet."Gauge Code" := '';
                                                        ElVolumeGet.Modify;

                                                        IHInsert."Gauge Size" := '';
                                                        IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                        IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                        IHInsert.Model := ElVolumeGet.Model;
                                                        IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                        IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                        IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                    end;
                                                end;

                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                 and (IHInsert."Measuring Point Code" = '') then begin
                                                    IHInsert."Inventory Number" := '';
                                                    IHInsert."Gauge Size" := '';
                                                    IHInsert."Gauge Code" := '';
                                                    IHInsert."Gauge Description" := '';
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, '', '');
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Inventory Number" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";

                                                    end;
                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                    if RadioMM.FindFirst() then

                                                        //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                        IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                            rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                        end;
                                                    IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                    IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                end;
                                                if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                    IHInsert."Dismantling date" := 0D;
                                                    IHInsert."Serial Number I" := '';
                                                    IHInsert."Serial Number II" := '';
                                                    ggf.Reset();
                                                    ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                    if ggf.FindFirst() then begin
                                                        IHInsert."Gauge Size" := ggf."Gauge Size";
                                                        IHInsert."Year of Production" := ggf."Year of Production";
                                                        IHInsert."Production Year" := ggf."Year of Production";
                                                        IHInsert."DD calibration" := ggf."DD calibration";
                                                    end;
                                                    MMUpdate.Reset();
                                                    MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                    if MMUpdate.FindFirst() then begin
                                                        IHInsert.Remotely := MMUpdate.Remotely;
                                                        IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                        IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                    end;

                                                end;
                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                    IHInsert.Active := true
                                                else
                                                    IHInsert.Active := false;
                                                if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                else
                                                    IHInsert."Customer Category Filter" := IHInsert."Customer Category";

                                                if IHInsert.active = true then begin
                                                    IHInsert."Dismantling Date" := 0D;
                                                    IHInsert."Reason for dismantling" := '';
                                                end;
                                                if (IHInsert.Active = false) then begin
                                                    IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                    IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                end;
                                                IHInsert.Insert();
                                                commit();
                                                cs.get;
                                                if cs."Update Data" = true then begin

                                                    if (IHInsert."Dismantling date" = 0D) then
                                                        cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                    Commit();
                                                    cu.InsertNewFirst(IHInsert);
                                                    Commit();
                                                end;

                                            end;
                                            Commit();

                                            ServiceItemUpdateS.Reset();
                                            ServiceItemUpdateS.SetFilter("No.", '%1', "Service Item No. - Relation");
                                            if ServiceItemUpdateS.FindFirst() then begin
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;


                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";


                                                    ServiceItemUpdateS.Modify();
                                                end;
                                                if (dr.Permanently = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently inactive";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);
                                                        //   StatusHPrevious.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently inactive");

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;
                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently inactive"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently inactive";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently inactive");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;
                                                end;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if rec.Remotely = true then
                                                    ServiceItemUpdateS.Remotely := true;
                                                ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";
                                                if (dr.InActive = false) and (dr.Permanently = false) then
                                                    ServiceItemUpdateS.Modify();

                                                //tempo
                                                if (dr.InActive = true) then begin
                                                    ServiceItemUpdateS."Measuring point off" := True;
                                                    ServiceItemUpdateS."Measuring point off Date" := rec."Date of consumption";
                                                    ServiceItemUpdateS."Measuring point in" := false;
                                                    ServiceItemUpdateS."Measuring point in Date" := 0D;


                                                    ServiceItemUpdateS."Last Reason" := rec."Reason for dismantling New";


                                                    ServiceItemUpdateS.Modify();
                                                end;

                                                if (dr."Is not in Calibration facility" = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::Terminated;
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::Terminated);
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;

                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::Terminated
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::Terminated;
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::Terminated);
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;

                                                if (dr.Temporery = true) then begin
                                                    StatusH.Init();
                                                    StatusH."Measuring Point" := ServiceItemUpdateS."No.";
                                                    StatusH."Source Table" := 5940;
                                                    StatusH.Active := true;
                                                    StatusH."Information of processing" := StatusH."Information of processing"::"Permanently deregistered";
                                                    StatusH."Insert User ID" := UserId;
                                                    StatusH."Insert Date and Time" := CurrentDateTime;
                                                    StatusHCheck.Reset();
                                                    StatusHCheck.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                    StatusHCheck.SetFilter("Source Table", '%1', 5940);
                                                    StatusHCheck.SetFilter(Active, '%1', true);
                                                    StatusHCheck.SetFilter("Information of processing", '%1', StatusHCheck."Information of processing"::"Permanently deregistered");
                                                    if not StatusHCheck.FindFirst() then begin
                                                        StatusHPrevious.Reset();
                                                        StatusHPrevious.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        StatusHPrevious.SetFilter("Source Table", '%1', 5940);
                                                        StatusHPrevious.SetFilter(Active, '%1', true);

                                                        if StatusHPrevious.FindSet() then
                                                            repeat
                                                                StatusHPrevious.Active := false;
                                                                if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                    StatusHPrevious.Modify();
                                                            until StatusHPrevious.Next() = 0;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            StatusH.Active := true
                                                        else
                                                            StatusH.Active := false;

                                                        SHLastMM.Reset();
                                                        SHLastMM.SetFilter("Measuring Point", '%1', ServiceItemUpdateS."No.");
                                                        SHLastMM.SetCurrentKey(Integer);
                                                        SHLastMM.Ascending;
                                                        if SHLastMM.FindLast() then
                                                            StatusH.Integer := SHLastMM.Integer + 1
                                                        else
                                                            StatusH.Integer := 1;

                                                        StatusH.Insert();

                                                    end;
                                                    //samo ako ima jedno mjerno mjesto 

                                                    BrojMMTrajno := 1;
                                                    CustomerF.Reset();
                                                    CustomerF.SetFilter("No.", '<>%1', "Service Item No. - Relation");
                                                    CustomerF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                    if CustomerF.FindSet() then
                                                        repeat


                                                            SMM.reset;
                                                            smm.SetFilter("Measuring Point", '%1', rec."Service Item No. - Relation");
                                                            smm.SetFilter(Active, '%1', true);
                                                            smm.SetFilter("Source Table", '%1', 5940);
                                                            if SMM.FindSet() then
                                                                repeat
                                                                    if SMM."Information of processing" <> smm."Information of processing"::"Permanently deregistered"
                                                                    then
                                                                        BrojMMTrajno += 1;

                                                                until smm.Next() = 0;
                                                        until CustomerF.Next() = 0;
                                                    if BrojMMTrajno = 1 then begin
                                                        StatusHCust.Init();
                                                        StatusHCust.validate("Customer No.", Rec."Customer No.");
                                                        StatusHCust."Source Table" := 18;
                                                        StatusHCust.Active := true;
                                                        StatusHCust."Information of processing" := StatusHCust."Information of processing"::"Permanently deregistered";
                                                        StatusHCust."Insert User ID" := UserId;
                                                        StatusHCust."Insert Date and Time" := CurrentDateTime;
                                                        StatusHCustCheck.Reset();
                                                        StatusHCustCheck.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                        StatusHCustCheck.SetFilter("Source Table", '%1', 18);
                                                        StatusHCustCheck.SetFilter(Active, '%1', true);
                                                        StatusHCustCheck.SetFilter("Information of processing", '%1', StatusHCustCheck."Information of processing"::"Permanently deregistered");
                                                        if not StatusHCustCheck.FindFirst() then begin
                                                            StatusHCustPrevious.Reset();
                                                            StatusHCustPrevious.SetFilter("Customer No.", '%1', rec."Customer No.");
                                                            StatusHCustPrevious.SetFilter("Source Table", '%1', 18);
                                                            StatusHCustPrevious.SetFilter(Active, '%1', true);

                                                            if StatusHCustPrevious.FindSet() then
                                                                repeat
                                                                    StatusHCustPrevious.Active := false;
                                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                        StatusHCustPrevious.Modify();
                                                                until StatusHCustPrevious.Next() = 0;
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                StatusHCust.Active := true
                                                            else
                                                                StatusHCust.Active := false;

                                                            SHLast.Reset();
                                                            SHLast.SetFilter("Customer No.", '%1', Rec."Customer No.");
                                                            SHLast.SetCurrentKey(Integer);
                                                            SHLast.Ascending;
                                                            if SHLast.FindLast() then
                                                                StatusHCust.Integer := SHLast.Integer + 1
                                                            else
                                                                StatusHCust.Integer := 1;

                                                            StatusHCust.Insert();

                                                        end;
                                                    end;

                                                end;
                                                //kraj


                                            end
                                            else begin

                                            end;
                                            if "Type G_R" = "Type G_R"::Gauge then begin
                                                GaugeFF.Reset();
                                                GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                if GaugeFF.FindFirst() then begin
                                                    if IHInsert."Measuring Point Code" <> '' then begin
                                                        //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                        if IHInsert."Measuring Point Code" <> '' then begin
                                                            if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then //ovdje djemina popraviti
                                                                GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                            IHInsert."Customer No." := rec."Customer No.";
                                                        end

                                                        else begin
                                                            if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then //ovdje djemina popraviti
                                                                GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                        end;
                                                    end
                                                    else begin
                                                        if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then //ovdje djemina popraviti
                                                            GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                    end;

                                                    CUP.Reset();
                                                    CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                    if cup.FindFirst() then begin
                                                        GaugeFFRename."Customer Category" := cup."Customer Category";
                                                        GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                        GaugeFFRename.Modify;
                                                    end;

                                                    GaugeFF.Reset();

                                                end;
                                            end;

                                        end;
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin
                                            IHInsert.Reset();

                                            //prvo bih trebala demontirati stari mjerač, e sad jedino ako ima novi treba da ga stavimo na novo mjersto.
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";
                                            IHInsert.SetFilter("Installation Date", '%1', rec."Installation Date New");
                                            //  IHInsert.SetFilter(Type, '%1', rec."Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);


                                            // IHInsert.SetFilter(Code, '%1', Gauge);
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);
                                                IHInsert.SetFilter(Code, '%1', Gauge);
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);
                                                IHInsert.SetFilter(Code, '%1', Corrector);
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code");
                                            end;

                                            if not IHInsert.FindFirst() then begin
                                                //nova stavka
                                                IHInsert.Init();
                                                IHInsert."Installation Date" := "Dismantling date New";
                                                IHInsert.RN := "Document No.";
                                                if "Type G_R" = "Type G_R"::Gauge then begin
                                                    GaugeF.Reset();
                                                    GaugeF.SetFilter(Code, '%1', "New Gauges");
                                                    if GaugeF.FindFirst() then begin

                                                        IHInsert."Inventory Number" := GaugeF."Inventar number";
                                                        IHInsert.InvterentoryFil := GaugeF."Inventar number";
                                                    end;

                                                end;

                                                if "Type G_R" = "Type G_R"::Corrector then begin

                                                    ElVolume.Reset();
                                                    ElVolume.SetFilter(Code, '%1', "Corrector New");
                                                    if ElVolume.FindFirst() then
                                                        IHInsert."Inventory Number" := ElVolume."Inventar number";
                                                    IHInsert.InvterentoryFil := IHInsert."Inventory Number";
                                                    IHInsert."Gauge Code" := rec."New Gauges";
                                                end;

                                                if "Type G_R" = "Type G_R"::Radio_Module then begin

                                                    RadioMM.Reset();
                                                    RadioMM.SetFilter(Code, '%1', "Radio Module Code New");
                                                    if RadioMM.FindFirst() then
                                                        IHInsert."Serial Number I" := "Serial Number I New";
                                                    IHInsert."Serial Number II" := "Serial Number II New";

                                                    //Code, "Gauge Code", "Measuring Point Code")
                                                    IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(RadioMM.CODE, REC."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                if "Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::"Gauge";

                                                if "Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::"Corrector";
                                                if "Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::"Radio_Module";

                                                IHInsert."Calibration Year" := date2dmy("Installation Date New", 3);
                                                IHInsert."Measuring Point Code" := rec."Service Item No. - Relation";
                                                MMTemp.SetFilter("No.", '%1', "Service Item No. - Relation");
                                                if MMTemp.FindFirst() then
                                                    IHInsert."Measuring Point Adress" := MMTemp."Address MM";
                                                IHInsert."Measuring Point string" := MMTemp."Measuring Point String";
                                                IHInsert."Measuring Point Stroke" := MMTemp."Measuring Point Stroke";
                                                IHInsert."Customer Address" := CustFind.Address;

                                                IHInsert.Email := CustFind."E-mail 2";


                                                IHInsert."Customer Category" := MMTemp."Customer Category";
                                                IHInsert."Customer City" := CustFind.City;
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert."Customer No." := MMTemp."Customer No.";
                                                IHInsert."Customer Name" := CustFind.Name;
                                                IHInsert."Customer Post Code" := '';
                                                IHInsert."Customer string" := MMTemp."Customer String";
                                                IHInsert."Customer Stroke" := MMTemp."Customer Stroke";
                                                IHInsert."Customer Zone stroke" := CustFind."Zone stroke";
                                                IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";
                                                IHInsert."Date of consumption" := Rec."Date of consumption New";
                                                IHInsert."DD calibration" := Rec."DD calibration";

                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";


                                                IHInsert."Calibration Year" := REc."Calibration Year New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";
                                                /*  IHInsert."Serial Number I" := REc."Serial Number I";
                                                  IHInsert."Serial Number II" := GaugeTemp."Serial Number II";
                                                  IHInsert."EL Volume Description" := GaugeTemp."EL Volume Description";
                                                  IHInsert."Dismantling date" := GaugeTemp."Dismantling date";
                                                  IHInsert."Reason for dismantling" := GaugeTemp."Reason for dismantling";*/
                                                if IHInsert."Dismantling date" <= today then begin
                                                    IHInsert.Active := true;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        if IHInsert.Type = IHInsert.Type::Gauge then begin
                                                            GaugeFF.Reset();
                                                            GaugeFF.SetFilter(Code, '%1', IHInsert.Code);

                                                            if GaugeFF.FindFirst() then begin
                                                                if IHInsert."Measuring Point Code" <> '' then begin
                                                                    //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");
                                                                    IHInsert."Customer No." := rec."Customer No.";
                                                                end
                                                                else begin
                                                                    if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                        GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                                end;
                                                                CUP.Reset();
                                                                CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                                if cup.FindFirst() then begin
                                                                    GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                    GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                    GaugeFFRename.Modify();
                                                                end;
                                                                GaugeFF.Reset();

                                                            end;
                                                        end;






                                                    IHInsertPrevious.Reset();
                                                    //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                    //  IHInsertPrevious.SetFilter(Code, '%1', Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                    end;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                    end;


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                        IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                    end;

                                                    // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                    IHInsertPrevious.SetFilter(Active, '%1', true);
                                                    if IHInsertPrevious.findset() then
                                                        repeat
                                                            IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                            IHInsertPrevious."Dismantling date" := "Dismantling date New";

                                                            IHInsertPrevious.Active := false;
                                                            if "Dismantling date New" = 0D then
                                                                IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                            if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                                IHInsertPrevious.modify;
                                                            cs.get;
                                                            if cs."Update Data" = true then begin
                                                                if IHInsertPrevious."Dismantling date" <> 0D then
                                                                    cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                            end;

                                                        until IHInsertPrevious.Next() = 0;
                                                    if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                        IHInsert.Type := IHInsert.Type::Gauge;

                                                    if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                        IHInsert.Type := IHInsert.Type::Corrector;

                                                    if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                        IHInsert.Type := IHInsert.Type::Radio_Module;
                                                    if IHInsert.Code <> '' then begin
                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                                ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                                ElVolumeGet.Modify;
                                                                ggf.Reset();
                                                                ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                                if ggf.FindFirst() then
                                                                    IHInsert."Gauge Size" := ggf."Gauge Size";
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                            end;
                                                        end;

                                                        if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                     and (IHInsert.Active = true) then begin
                                                            ElVolume.Reset();
                                                            ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                            if ElVolume.FindFirst() then begin
                                                                if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                                then
                                                                    ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                                ElVolumeGet."Gauge Code" := '';
                                                                ElVolumeGet.Modify;

                                                                IHInsert."Gauge Size" := '';
                                                                IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                                IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                                IHInsert.Model := ElVolumeGet.Model;
                                                                IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                                IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                                IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                            end;
                                                        end;

                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                and (IHInsert."Measuring Point Code" = '') then begin
                                                            IHInsert."Inventory Number" := '';
                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Gauge Code" := '';
                                                            IHInsert."Gauge Description" := '';
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, '', '');
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Inventory Number" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";

                                                            end;
                                                            RadioMM.Reset();
                                                            RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                            if RadioMM.FindFirst() then

                                                                //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                                IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                    rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                                end;
                                                            IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                            IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                        end;
                                                        if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                            IHInsert."Dismantling date" := 0D;
                                                            IHInsert."Serial Number I" := '';
                                                            IHInsert."Serial Number II" := '';
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                            if ggf.FindFirst() then begin
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                                IHInsert."Year of Production" := ggf."Year of Production";
                                                                IHInsert."Production Year" := ggf."Year of Production";
                                                                IHInsert."DD calibration" := ggf."DD calibration";
                                                            end;
                                                            MMUpdate.Reset();
                                                            MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                            if MMUpdate.FindFirst() then begin
                                                                IHInsert.Remotely := MMUpdate.Remotely;
                                                                IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                                IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                            end;

                                                        end;
                                                        if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                            IHInsert.Active := true
                                                        else
                                                            IHInsert.Active := false;
                                                        if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                        else
                                                            IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                        if IHInsert.active = true then begin
                                                            IHInsert."Dismantling Date" := 0D;
                                                            IHInsert."Reason for dismantling" := '';
                                                        end;
                                                        if (IHInsert.Active = false) then begin
                                                            IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                            IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                        end;

                                                        IHInsert.Insert();
                                                        commit();
                                                        cs.get;
                                                        if cs."Update Data" = true then begin

                                                            if (IHInsert."Dismantling date" = 0D) then
                                                                cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                            Commit();
                                                            cu.InsertNewFirst(IHInsert);
                                                            Commit();
                                                        end;

                                                    end;
                                                    Commit();


                                                end;
                                            end
                                            else begin

                                                //ovdje samo ako je odjava, da ga samo uklone
                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                // IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                // IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Gauge);
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', Corrector);
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;

                                        end
                                        else begin

                                            //

                                        end;

                                        //sada hoću da dodam neke nove, ova ugradnja nvoog

                                        //
                                        if ("New Gauges" <> '') or ("Radio Module Code New" <> '') or ("Corrector New" <> '') then begin
                                            IHInsert.Reset();
                                            if rec."Installation Date New" = 0D then
                                                rec."Installation Date New" := "Dismantling date New";

                                            IHInsert.SetFilter("Installation Date", '%1', "Installation Date New");
                                            //  IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                IHInsert.SetFilter(Code, '%1', "New Gauges");
                                            end;

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                IHInsert.SetFilter(Code, '%1', "Corrector New");
                                            end;


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                IHInsert.SetFilter(Code, '%1', "Radio Module Code New");
                                            end;

                                            //   IHInsert.SetFilter(Type, '%1', "Type G_R");
                                            if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                            if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                            if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                IHInsert.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);

                                            if not IHInsert.FindFirst() then begin
                                                IHInsert.Init();
                                                //     IHInsert.Code := "New Gauges";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsert.Code := "New Gauges";
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsert.Code := "Corrector New";
                                                    IHInsert."Gauge Code" := rec."New Gauges";

                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsert.Code := "Radio Module Code New";
                                                    IHInsert."Gauge Code" := REC.Gauge;
                                                    gsERIAL.Reset();
                                                    gsERIAL.SetFilter(Code, '%1', REC."New Gauges");
                                                    IF gsERIAL.FindFirst() THEN
                                                        IHInsert."Gauge Description" := gsERIAL."Inventar number";

                                                    IF rmgET.GET(IHInsert.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code") THEN BEGIN
                                                        rmgET.RENAME(IHInsert.CODE, REC."New Gauges", Rec."Service Item No.");
                                                        ggf.RESET;
                                                        ggf.SetFilter(Code, '%1', REC."New Gauges");
                                                        IF ggf.FindFirst() THEN
                                                            rmgET."Gauge Description" := GGF."Inventar number";
                                                        rmgET.Modify();
                                                    END;
                                                    Commit();

                                                end;

                                                IHInsert.Type := "Type G_R";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";
                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."MZ MM" := "MZ MM New";
                                                IHInsert.Reading := "Reading New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert.Reading := rec."Reading New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert.Reading := rec."Reading New RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert.Reading := rec."Reading New Corrector";
                                                IHInsert."Street MM" := "Street MM New";
                                                IHInsert."MZ Name MM" := "MZ Name MM New";
                                                IHInsert."Address MM" := "Address MM New";
                                                IHInsert."Dismantling date" := 0D;
                                                IHInsert."Reason for dismantling" := '';
                                                //  IHInsert.Code := "New Gauges";
                                                IHInsert."Customer No." := "Customer No. New";
                                                CustFind4.reset;
                                                custfind4.setfilter("No.", '%1', "Customer No. New");
                                                if custfind4.findfirst then
                                                    IHInsert.Email := CustFind4."E-mail 2"
                                                else
                                                    IHInsert.Email := '';

                                                IHInsert."Street No. MM" := "Street No. MM New";
                                                IHInsert."Customer Name" := "Customer Name New";
                                                IHInsert."Customer City" := "Customer City New";
                                                IHInsert."Street Name MM" := "Street Name MM New";
                                                IHInsert."DD calibration" := "DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."DD calibration" := rec."DD calibration New";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."DD calibration" := rec."DD calibration Corr New";
                                                IHInsert."MM Description" := "MM Description New";
                                                IHInsert."Serial Number I" := "Serial Number I New";
                                                IHInsert."Type Radio Module" := rec."Type Radio Module New";

                                                IHInsert."Customer string" := "Customer string New";
                                                IHInsert."Customer Stroke" := "Customer Stroke New";
                                                IHInsert."Production Year" := "Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Gauge then
                                                    IHInsert."Production Year" := rec."Production Year New";
                                                if rec."Type G_R" = "Type G_R"::Radio_Module then
                                                    IHInsert."Production Year" := rec."Year of Production RM";
                                                if rec."Type G_R" = "Type G_R"::Corrector then
                                                    IHInsert."Production Year" := rec."Year of Production Corr New";
                                                IHInsert."Serial Number II" := "Serial Number II New";

                                                IHInsert."Inventory Number" := "Inventory Number New";
                                                IHInsert.InvterentoryFil := "Inventory Number New";

                                                IHInsert."Calibration Year" := "Calibration Year New";
                                                IHInsert."Customer Address" := "Customer Address New";
                                                IHInsert."Dismantling date" := "Dismantling date New";
                                                IHInsert."Programming date" := "Programming date New";
                                                IHInsert."Customer Category" := "Customer Category New";
                                                IHInsert."Installation Date" := "Installation Date New";
                                                IHInsert.RN := "Document No.";
                                                IHInsert."Customer Post Code" := "Customer Post Code New";
                                                IHInsert."Date of consumption" := "Date of consumption New";
                                                IHInsert."Pressure Type" := Rec."Pressure Type New";
                                                IHInsert."Temperature Value" := rec."Temperature Value New";
                                                IHInsert."Adjusted Volume" := rec."Adjusted Volume New";
                                                IHInsert."Unadjusted Volume" := rec."Unadjusted Volume New";
                                                IHInsert."Absolute Pressure Of Corrector" := rec."Absolute Pressure Of Corr. New";
                                                IHInsert.Temperature := rec."Temperature New";
                                                IHInsert."Correction Factor" := rec."Correction Factor New";
                                                IHInsert."Operating Pressure On ML" := rec."Operating Pressure On ML New";

                                                IHInsert."Customer Zone stroke" := "Customer Zone stroke New";
                                                IHInsert."Date of rescheduling" := "Date of rescheduling New";
                                                IHInsert."Measuring Point Code" := "Measuring Point Code New";
                                                IHInsert."Municipality Code MM" := "Municipality Code MM New";
                                                IHInsert."EL Volume Description" := "EL Volume Description New";
                                                IHInsert."Measurer manufacturer" := "Measurer manufacturer New";
                                                IHInsert."Measuring Point string" := "Measuring Point string New";
                                                IHInsert."Measuring Point Stroke" := "Measuring Point Stroke New";
                                                IHInsert."Reason for dismantling" := "Reason for dismantling New";
                                                IHInsert."Measuring Point Adress" := "Measuring Point Address New";
                                                if IHInsert."Installation Date" <= today
                     then begin

                                                    IHInsert.Active := true;
                                                    if "Type G_R" = "Type G_R"::Gauge then begin
                                                        GaugeFF.Reset();
                                                        GaugeFF.SetFilter(Code, '%1', IHInsert.Code);
                                                        if GaugeFF.FindFirst() then begin
                                                            //  key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM") 
                                                            if IHInsert."Measuring Point Code" <> '' then begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", Rec."Customer No.", IHInsert."Address MM");

                                                                IHInsert."Customer No." := rec."Customer No.";
                                                            end
                                                            else begin
                                                                if GaugeFFRename.Get(GaugeFF.code, GaugeFF."Measuring Point", GaugeFF."Customer No.", GaugeFF."Address MM") then
                                                                    GaugeFFRename.Rename(GaugeFF.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");

                                                            end;
                                                            CUP.Reset();
                                                            CUP.SetFilter("No.", '%1', IHInsert."Customer No.");
                                                            if cup.FindFirst() then begin
                                                                GaugeFFRename."Customer Category" := cup."Customer Category";
                                                                GaugeFFRename."Gauge Category" := cup."Customer Category";
                                                                GaugeFFRename.Modify();
                                                            end;

                                                            GaugeFF.Reset();

                                                        end;
                                                    end;

                                                end;
                                                MMNew.Reset();
                                                MMNew.SetFilter("No.", '%1', "Measuring Point Code New");
                                                if MMNew.FindFirst() then begin
                                                    IHInsert."Measuring Point string" := MMNew."Measuring Point string";
                                                    IHInsert."Measuring Point Stroke" := MMNew."Measuring Point Stroke";
                                                    IHInsert."Measuring Point Adress" := MMNew."Address MM";

                                                end;

                                                CustNew.Reset();
                                                CustNew.SetFilter("No.", '%1', "Customer No. New");
                                                if CustNew.FindFirst() then begin

                                                    IHInsert."Customer Address" := CustNew.Address;
                                                    IHInsert."Customer Category" := CustNew."Customer Category";
                                                    IHInsert."Customer City" := CustNew.City;
                                                    IHInsert."Customer Name" := CustNew.Name;
                                                    IHInsert."Customer Post Code" := CustNew."Post Code";
                                                    IHInsert."Customer Name" := "Customer Name New";

                                                end;
                                                IHInsert.Type := rec."Type G_R";
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsert.Type := IHInsert.Type::Gauge;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsert.Type := IHInsert.Type::Corrector;

                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsert.Type := IHInsert.Type::Radio_Module;
                                                if IHInsert.Code <> '' then begin
                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." <> '')
                                             and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, IHInsert."Measuring Point Code", IHInsert."Customer No.", IHInsert."Address MM");
                                                            ElVolumeGet."Gauge Code" := IHInsert."Gauge Code";
                                                            ElVolumeGet.Modify;
                                                            ggf.Reset();
                                                            ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                            if ggf.FindFirst() then
                                                                IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Corrector) and (IHInsert."Customer No." = '')
                                                 and (IHInsert.Active = true) then begin
                                                        ElVolume.Reset();
                                                        ElVolume.SetFilter(Code, '%1', IHInsert.code);
                                                        if ElVolume.FindFirst() then begin
                                                            if ElVolumeGet.get(ElVolume.code, ElVolume."Measuring Point", ElVolume."Customer No.", ElVolume."Address MM")
                                                            then
                                                                ElVolumeGet.rename(IHInsert.code, '', '', '');
                                                            ElVolumeGet."Gauge Code" := '';
                                                            ElVolumeGet.Modify;

                                                            IHInsert."Gauge Size" := '';
                                                            IHInsert."Year of Production" := ElVolumeGet."Year of Production";
                                                            IHInsert."DD calibration" := ElVolumeGet."DD calibration";
                                                            IHInsert.Model := ElVolumeGet.Model;
                                                            IHInsert."Inventory Number" := ElVolumeget."Inventar number";
                                                            IHInsert."Inventory Number" := ElVolumeget."Serial Number";
                                                            IHInsert."Calibration Year" := ElVolumeGet."DD calibration";

                                                        end;
                                                    end;

                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." = '')
                                                and (IHInsert."Measuring Point Code" = '') then begin
                                                        IHInsert."Inventory Number" := '';
                                                        IHInsert."Gauge Size" := '';
                                                        IHInsert."Gauge Code" := '';
                                                        IHInsert."Gauge Description" := '';
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, '', '');
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";
                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Radio_Module) and (IHInsert."Customer No." <> '')
                                              and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Inventory Number" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert."Gauge Code");
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";

                                                        end;
                                                        RadioMM.Reset();
                                                        RadioMM.SetFilter(Code, '%1', IHInsert.Code);
                                                        if RadioMM.FindFirst() then

                                                            //ovo je u baždarnici sada i trebala bih ukloniti sve sa radio modula
                                                            IF rmgET.GET(RadioMM.CODE, RadioMM."Gauge Code", RadioMM."Measuring Point Code") THEN BEGIN
                                                                rmgET.RENAME(RadioMM.CODE, IHInsert."Gauge Code", IHInsert."Measuring Point Code");
                                                            end;
                                                        IHInsert."Serial Number I" := rmgET."Serial Number I";
                                                        IHInsert."Serial Number II" := rmgET."Serial Number II";

                                                    end;
                                                    if (IHInsert.Type = IHInsert.Type::Gauge) and (IHInsert."Customer No." <> '')
                                                and (IHInsert.Active = true) then begin
                                                        IHInsert."Dismantling date" := 0D;
                                                        IHInsert."Serial Number I" := '';
                                                        IHInsert."Serial Number II" := '';
                                                        ggf.Reset();
                                                        ggf.SetFilter(Code, '%1', IHInsert.Code);
                                                        if ggf.FindFirst() then begin
                                                            IHInsert."Gauge Size" := ggf."Gauge Size";
                                                            IHInsert."Year of Production" := ggf."Year of Production";
                                                            IHInsert."Production Year" := ggf."Year of Production";
                                                            IHInsert."DD calibration" := ggf."DD calibration";
                                                        end;
                                                        MMUpdate.Reset();
                                                        MMUpdate.SetFilter("No.", '%1', IHInsert."Measuring Point Code");
                                                        if MMUpdate.FindFirst() then begin
                                                            IHInsert.Remotely := MMUpdate.Remotely;
                                                            IHInsert."Remotely Type" := MMUpdate."Remotely Type";
                                                            IHInsert."Municipality Code MM" := MMUpdate."Municipality Code MM";
                                                        end;

                                                    end;
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsert.Active := true
                                                    else
                                                        IHInsert.Active := false;

                                                    if IHInsert."Customer Category" = IHInsert."Customer Category"::"KJKP Heating plant" then
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category"::"Large Economy"
                                                    else
                                                        IHInsert."Customer Category Filter" := IHInsert."Customer Category";
                                                    if IHInsert.active = true then begin
                                                        IHInsert."Dismantling Date" := 0D;
                                                        IHInsert."Reason for dismantling" := '';
                                                    end;
                                                    if (IHInsert.Active = false) then begin
                                                        IHInsert."Dismantling Date" := rec."Dismantling date New";
                                                        IHInsert."Reason for dismantling" := rec."Reason for dismantling New";
                                                    end;
                                                    IHInsert.Insert();
                                                    commit();
                                                    cs.get;
                                                    if cs."Update Data" = true then begin

                                                        if (IHInsert."Dismantling date" = 0D) then
                                                            cu.UpdateGaugeChangeInstalling(IHInsert, Rec);
                                                        Commit();
                                                        cu.InsertNewFirst(IHInsert);
                                                        Commit();
                                                    end;

                                                end;
                                                Commit();

                                                IHInsertPrevious.Reset();
                                                //IHInsertPrevious.SetFilter("Installation Date",'%1',GaugeTemp."Installation Date");
                                                //  IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "New Gauges");
                                                end;

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Corrector New");
                                                end;


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then begin
                                                    IHInsertPrevious.SetFilter(Code, '%1', "Radio Module Code New");
                                                end;

                                                IHInsertPrevious.SetFilter("Installation Date", '<>%1', IHInsert."Installation Date");
                                                //IHInsertPrevious.SetFilter(Type, '%1', "Type G_R");
                                                if rec."Type G_R" = rec."Type G_R"::Gauge then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Gauge);

                                                if rec."Type G_R" = rec."Type G_R"::Corrector then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Corrector);


                                                if rec."Type G_R" = rec."Type G_R"::Radio_Module then
                                                    IHInsertPrevious.SetFilter(Type, '%1', IHInsert.Type::Radio_Module);
                                                IHInsertPrevious.SetFilter(Active, '%1', true);
                                                if IHInsertPrevious.FindFirst() then begin
                                                    IHInsertPrevious."Reason for dismantling" := "Reason for dismantling New";
                                                    IHInsertPrevious."Dismantling date" := "Dismantling date New";
                                                    IHInsertPrevious.Active := false;
                                                    if "Dismantling date New" = 0D then
                                                        IHInsertPrevious."Dismantling date" := "Installation Date New";
                                                    if IHInsertPrevious."Installation Date" <= "Installation Date New" then
                                                        IHInsertPrevious.modify;
                                                    cs.get;
                                                    if cs."Update Data" = true then begin
                                                        if IHInsertPrevious."Dismantling date" <> 0D then
                                                            cu.UpdateGaugeChangeDismantling(IHInsertPrevious, Rec);
                                                    end;
                                                end;

                                            end;

                                        end;
                                    end


                                    //kraj
                                end;


                            end;
                        end;

                        if RMYes = true then
                            "Type G_R" := "Type G_R"::Gauge_RM;
                        if CcorrYes = true then
                            "Type G_R" := "Type G_R"::Corrector_RM;

                    end;
                end;


            end;

        }


        //kraj


        field(50179; "CZK ID"; Code[20])
        {

            TableRelation = "Service Item Line";
            Editable = false;
            Caption = 'CZK ID';

        }

        field(50178; "Work Order Created"; Boolean)
        {

            Caption = 'Work Order Created';
            FieldClass = FlowField;
            CalcFormula = exist("Service Item Line" where("CZK ID" = field("Document No."), "Service Item No. - Relation" = field("Service Item No. - Relation"), Address = field(Address), "Line No." = field("Line No.")));


        }

        field(50180; "Work Order Applied"; Boolean)
        {
            Caption = 'Work Order Applied';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Item Line".Applied where("CZK ID" = field("Document No."), "Service Item No. - Relation" = field("Service Item No. - Relation"), Address = field(Address), "Line No." = field("Line No.")));


        }
        field(50181; "Corrector Serial Number"; text[250])
        {
            Caption = 'Corrector';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }

        field(60087; "Adjusted Volume"; Decimal)
        {
            Caption = 'Adjusted Volume';
        }

        field(60088; "Unadjusted Volume"; Decimal)
        {
            Caption = 'Unadjusted Volume';
        }

        field(60089; "Absolute Pressure Of Corrector"; Decimal)
        {
            Caption = 'Absolute Pressure Of The Corrector';
            DecimalPlaces = 1 : 4;
        }
        field(60090; "Temperature"; Decimal)
        {
            Caption = 'Temperature';
        }
        field(60091; "Correction Factor"; Decimal)
        {
            Caption = 'Correction Factor';
            DecimalPlaces = 1 : 6;
        }
        field(60092; "Operating Pressure On ML"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Operating Pressure On ML';
        }

        field(50182; "Radio Module Serial I"; text[250])
        {
            Caption = 'Radio Module Serial I';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(50183; "Radio Module Serial II"; text[250])
        {
            Caption = 'Radio Module Serial II';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(50184; "Radio Module Code"; Code[20])
        {
            // RMF.setfilteR("Gauge Code", '%1', rec.Gauge);
            Caption = 'Radio Module Code';
            //"Radio Module".Code where("Gauge Code" = field(gauge), "Measuring Point Code" = field("Service Item No. - Relation"));
            TableRelation = IF ("Radio Module Code" = CONST('')) "Radio Module".Code where("Gauge Code" = field(gauge), "Measuring Point Code" = field("Service Item No. - Relation"))
            ELSE
            IF ("Radio Module Code" = FILTER(<> '')) "Radio Module".Code WHERE(Code = field("Radio Module Code"));

            //  Editable = false;

            trigger OnValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
            begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    us.GaugeInsert := rec.Gauge;
                    us.Modify();
                end;

            end;
        }
        field(60076; "Already Transfer"; Boolean)
        {
            Caption = 'Already Transfer';
        }
        field(60077; "Radio Module Code New"; Code[20])
        {
            Caption = 'Radio Module Code';
            //   TableRelation = "Radio Module".Code where("Gauge Code" = field("New Gauges"));

            //  Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                RM: Record "Radio Module";
                ServiceII: Record "Service Item";
                CG: Record customer;
                US: Record "User Setup";

            begin

                if ("Type G_R" = "Type G_R"::Radio_Module) or ("Type G_R" = "Type G_R"::Gauge_RM) then begin
                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        if rec.Gauge <> '' then
                            US."Gauge Code" := rec.Gauge;
                        if rec."New Gauges" <> '' then
                            US."Gauge Code" := rec."New Gauges";
                    end;
                end;
                "Measuring Point Code New" := rec."Service Item No. - Relation";
                ServiceII.reset;
                ServiceII.SetFilter("No.", '%1', "Measuring Point Code New");
                if ServiceII.FindFirst() then begin
                    Validate("MM Description New", ServiceII.Description);

                    validate("Address MM New", ServiceII."Address MM");
                    validate("MZ MM New", ServiceII."MZ MM");
                    validate("MZ Name MM New", ServiceII."MZ Name MM");


                    validate("Street MM New", ServiceII."Street Name MM");
                    validate(Remotely, true);
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


                if ("Type G_R" = "Type G_R"::Radio_Module) or ("Type G_R" = "Type G_R"::Gauge_RM) then begin

                    RM.Reset();
                    RM.SetFilter(Code, '%1', rec."Radio Module Code New");
                    if rm.FindFirst() then begin
                        "Radio Module Serial I New" := rm."Serial Number I";
                        "Radio Module Serial II New" := rm."Serial Number II";
                        "Type Radio Module New" := rm."Type Radio Module";
                        "Year of Production RM New" := rm."Year of Production";
                    end
                    else begin
                        "Radio Module Serial I New" := '';
                        "Radio Module Serial II New" := '';
                        "Type Radio Module New" := "Type Radio Module New"::Unknown;
                        "Year of Production RM New" := 0;

                    end;
                end
                else begin
                    RM.Reset();
                    RM.SetFilter(Code, '%1', rec."Radio Module Code New");
                    if rm.FindFirst() then begin
                        "Radio Module Serial I New" := rm."Serial Number I";
                        "Radio Module Serial II New" := rm."Serial Number II";
                        "Type Radio Module New" := rm."Type Radio Module";
                        "Year of Production RM New" := rm."Year of Production";
                    end
                    else begin
                        "Radio Module Serial I New" := '';
                        "Radio Module Serial II New" := '';
                        "Type Radio Module New" := "Type Radio Module New"::Unknown;
                        "Year of Production RM New" := 0;

                    end;

                end;
            end;
        }
        field(60078; "Radio Module Serial I New"; text[250])
        {
            Caption = 'Radio Module Serial I New';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(60079; "Radio Module Serial II New"; text[250])
        {
            Caption = 'Radio Module Serial II New';
            //   FieldClass = FlowField;
            //   CalcFormula = count("El. Volume Corr" where("Measuring Point" = field("Service Item No.")));
            //  Editable = false;
        }
        field(60080; "Done Document"; Boolean)
        {
            Caption = 'Done Document';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Realisation Done" where("No." = field("Document No.")));
        }
        field(60081; "Year of Production RM"; Integer)
        {
            Caption = 'Year of Production RM\Corr"';
        }
        field(60082; "Type Radio Module"; enum "Type radio module")
        {
            Caption = 'Type Radio Module';
        }
        field(60084; "Type Radio Module New"; enum "Type radio module")
        {
            Caption = 'Type Radio Module New';
        }
        field(60083; Model; text[250]) { Caption = 'Model'; }
        field(60085; "Model New"; text[250]) { Caption = 'Model new'; }

        field(60086; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
        }
        field(60094; "Remotely Type"; enum "Remotely Type")
        {
            Caption = 'Remotely Type';

        }
        field(60093; "Remotely"; Boolean)
        {
            Caption = 'Remotely';
        }
        field(60095; "Finishing Date (filter)"; Date)
        {
            Caption = 'Finishing Date (filter)';
            FieldClass = FlowField;
            CalcFormula = lookup("Service Header"."Finishing Date" where("No." = field("Document No.")));
        }
        field(60096; "Year of Production RM New"; Integer)
        {
            Caption = 'Year of Production RM New"';
        }
        field(60103; "Year of Production Corr Old"; Integer)
        {
            Caption = 'Year of Production Corr Old"';
        }
        field(60104; "DD calibration Corr Old"; Integer)
        {
            Caption = 'DD calibration Corr Old';
        }
        field(60100; "Corrector Serial Number New"; text[250])

        {
            Caption = 'Corrector Serial Number New';
        }
        field(60102; "Reading New RM"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New RM';

        }
        field(60101; "Reading New Corrector"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Reading New Corrector';

        }
        field(60097; "Year of Production Corr New"; Integer)
        {
            Caption = 'Year of Production Corr New"';
        }
        field(60098; "DD calibration Corr New"; Integer)
        {
            Caption = 'DD calibration Corr New';
        }

        field(60105; "Pressure Type"; enum "Pressure type")
        {
            Caption = 'Pressure Type';
        }


        field(60106; "Pressure Type New"; enum "Pressure type")
        {
            Caption = 'Pressure Type New';
        }


        field(60109; "Temperature Value"; decimal)
        {
            Caption = 'Temperature Value';
        }


        field(60110; "Temperature Value New"; decimal)
        {
            Caption = 'Temperature Value New';
        }

        field(60111; "Adjusted Volume New"; Decimal)
        {
            Caption = 'Adjusted Volume New';
        }

        field(60112; "Unadjusted Volume New"; Decimal)
        {
            Caption = 'Unadjusted Volume New';
        }

        field(60113; "Absolute Pressure Of Corr. New"; Decimal)
        {
            Caption = 'Absolute Pressure Of The Corrector New';
        }
        field(60114; "Temperature New"; Decimal)
        {
            Caption = 'Temperature New';
        }
        field(60115; "Correction Factor New"; Decimal)
        {
            Caption = 'Correction Factor New';
            DecimalPlaces = 1 : 6;
        }
        field(60116; "Operating Pressure On ML New"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Operating Pressure On ML New';
        }
        field(60117; "Allow Deviation"; Boolean)
        {

            Caption = 'Allow Deviation';
        }





        field(60099; "Corrector New"; Code[20])
        {
            Caption = 'Corrector New';
            TableRelation = "El. Volume Corr".Code;

            //  Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
                RM: Record "El. Volume Corr";
                ServiceII: Record "Service Item";
                CG: Record customer;

            begin

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

                if "Type G_R" = "Type G_R"::Gauge then begin

                    RM.Reset();
                    RM.SetFilter(Code, '%1', rec."Corrector New");
                    if rm.FindFirst() then begin
                        "Model New" := rm.Model;
                        "Corrector Serial Number New" := rm."Serial Number";
                        "Year of Production Corr New" := rm."Year of Production";
                        "DD calibration Corr New" := rm."DD calibration";
                    end
                    else begin
                        "Model New" := '';
                        "Corrector Serial Number New" := '';
                        "Year of Production Corr New" := 0;
                        "DD calibration Corr New" := 0;

                    end;
                end
                else begin
                    RM.Reset();
                    RM.SetFilter(Code, '%1', rec."Corrector New");
                    if rm.FindFirst() then begin
                        "Model New" := rm.Model;
                        "Corrector Serial Number New" := rm."Serial Number";
                        "Year of Production Corr New" := rm."Year of Production";
                        "DD calibration Corr New" := rm."DD calibration";
                    end
                    else begin
                        "Model New" := '';
                        "Corrector Serial Number New" := '';
                        "Year of Production Corr New" := 0;
                        "DD calibration Corr New" := 0;

                    end;

                end;
            end;


        }




    }




    trigger OnAfterInsert()
    begin
        UpdateDocumentAttachments(1);
    end;

    trigger OnAfterModify()
    begin
        UpdateDocumentAttachments(2);
    end;

    trigger OnAfterDelete()
    begin
        UpdateDocumentAttachments(3);
    end;


    local procedure UpdateDocumentAttachments(TableAction: Integer)
    var
        ServiceHeader: Record "Service Header";
    begin
        //TableAction = 1 = Insert
        //TableAction = 2 = Modify
        //TableAction = 3 = Delete
        ServiceHeader.Get("Document Type", "Document No.");
        /*  if not (ServiceHeader."Request Type" in [
              Enum::"Request Type"::"Information Issuing Request",
              Enum::"Request Type"::"Project overview Request",
              Enum::"Request Type"::"Work Execution Request",
              Enum::"Request Type"::"Location Accordance Issuing Request",
              Enum::"Request Type"::"Route Accordance Issuing Request",
              Enum::"Request Type"::"Spatial plan Accordance Issuing Request"
              ])
          then
              exit;*/
        if TableAction = 3 then begin
            DeleteExistingDocumentAttachments(false);
            exit;
        end;
        if TableAction = 2 then begin
            if xRec."Service Item No." = Rec."Service Item No." then
                exit;
            if xRec."Service Item No." <> '' then
                DeleteExistingDocumentAttachments(true);
        end;
        if "Service Item No." = '' then
            exit;
        InsertMandatoryDocumentAttachments();
    end;

    local procedure DeleteExistingDocumentAttachments(DoConfirm: Boolean)
    var
        DocumentAttachment: Record "Document Attachment";
        DocumentAttachmentDeleteQst: Label 'This action will delete existing %1 lines, do you want to continue?';
    begin
        DocumentAttachment.SetRange("Table ID", Database::"Service Item Line");
        DocumentAttachment.SetRange("No.", "Document No.");
        DocumentAttachment.SetRange("Line No.", "Line No.");
        if DoConfirm then
            if not DocumentAttachment.IsEmpty then
                if not Confirm(StrSubstNo(DocumentAttachmentDeleteQst, DocumentAttachment.TableCaption), false) then
                    Error(ProcessAbortedErr);
        DocumentAttachment.DeleteAll(true);
    end;

    local procedure InsertMandatoryDocumentAttachments()
    var
        DocumentAttachment: Record "Document Attachment";
        MandatoryAttachmentSetup: Record "Mandatory Attachment Setup";
        ServiceHeader: Record "Service Header";
        Mandat: Record "Mandatory Attachment Setup";
    begin
        ServiceHeader.Get("Document Type", "Document No.");
        if ServiceHeader."Request Type" = Enum::"Request Type"::"Others" then begin


            Mandat.Reset();
            Mandat.SetFilter("Gas installation", '%1', false);
            Mandat.SetFilter("Request Type", '%1', Mandat."Request Type"::"Others");
            if Mandat.FindSet() then
                repeat
                    DocumentAttachment.Init();
                    DocumentAttachment."Table ID" := Database::"Service Item Line";
                    DocumentAttachment."No." := rec."Document No.";
                    DocumentAttachment."Line No." := rec."Line No.";
                    DocumentAttachment.Mandatory := Mandat.Mandatory;
                    DocumentAttachment.ID := 0;
                    DocumentAttachment."GAS installation" := Mandat."Gas Installation";
                    DocumentAttachment."Mandatory Attachment Type" := Mandat."Mandatory Attachment Type";
                    DocumentAttachment."File Name" := 'Odaberite datoteku...';
                    DocumentAttachment.Insert();
                until Mandat.Next() = 0;


        end;

        MandatoryAttachmentSetup.SetRange("Request Type", ServiceHeader."Request Type");
        if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Information Issuing Request" then
            MandatoryAttachmentSetup.SetRange("Dwelling Type", "Dwelling Type")
        else
            MandatoryAttachmentSetup.SetRange("Dwelling Type", '');
        if MandatoryAttachmentSetup.FindSet then
            repeat
                DocumentAttachment.SetRange("Table ID", Database::"Service Item Line");
                DocumentAttachment.SetRange("No.", "Document No.");
                DocumentAttachment.SetRange("Line No.", "Line No.");
                DocumentAttachment.SetRange("Mandatory Attachment Type", MandatoryAttachmentSetup."Mandatory Attachment Type");
                if DocumentAttachment.IsEmpty then begin
                    DocumentAttachment.Reset();
                    DocumentAttachment.Init();
                    DocumentAttachment."Table ID" := Database::"Service Item Line";
                    DocumentAttachment."No." := "Document No.";
                    DocumentAttachment."Line No." := "Line No.";
                    DocumentAttachment.Mandatory := MandatoryAttachmentSetup.Mandatory;
                    DocumentAttachment.ID := 0;
                    DocumentAttachment.Information := MandatoryAttachmentSetup.Information;
                    DocumentAttachment."Mandatory Attachment Type" := MandatoryAttachmentSetup."Mandatory Attachment Type";
                    DocumentAttachment."File Name" := 'Odaberite datoteku...';
                    DocumentAttachment.Insert();
                end;
            until MandatoryAttachmentSetup.Next() = 0;
    end;

    local procedure OnBeforeValidateServiceItemNo()
    var
        ServiceItem: Record "Service Item";
    begin
        if "Type G_R" = 0 then
            "Type G_R" := "Type G_R"::Gauge;
        if "Service Item No." = '' then begin
            "Purpose" := '';
            "Dwelling Type" := '';
            "Elevation" := 0;
            "Reading Mode" := "Reading Mode"::Digital;
            "MM Category" := Enum::Category::" ";
            "Municipality Code" := '';
            "MZ" := '';
            "Street" := '';
            "Street No." := '';
            "String" := 0;
            "Stroke" := 0;
            "Zone Stroke" := 0;
            "Municipality Name" := '';
            "MZ Name" := '';
            "Street Name" := '';
            Address := '';
            "Home No. MM" := '';
            "Floor MM" := '';
            "Apartment No. MM" := '';
            "Street No. Text MM" := '';

            exit;
        end;
        ServiceItem.SetAutoCalcFields("Municipality Name MM", "MZ Name MM", "Street Name MM");
        ServiceItem.Get("Service Item No.");
        "Purpose" := ServiceItem."Purpose";
        "Dwelling Type" := ServiceItem."Dwelling Type";
        "Elevation" := ServiceItem."Elevation";
        "Reading Mode" := ServiceItem."Reading Mode";
        "MM Category" := ServiceItem."MM Category";
        "Municipality Code" := ServiceItem."Municipality Code MM";
        "MZ" := ServiceItem."MZ MM";
        "Street" := Serviceitem.Street;

        "Street No." := ServiceItem."Street No.";
        "String" := ServiceItem."Measuring Point string";
        "Stroke" := ServiceItem."Measuring Point Stroke";
        "Zone Stroke" := ServiceItem."Zone stroke";
        "Municipality Name" := ServiceItem."Municipality Name MM";
        "MZ Name" := ServiceItem."MZ Name MM";
        "Street Name" := ServiceItem."Street Name MM";
        Address := ServiceItem."Address MM";
        "Home No. MM" := ServiceItem."Home No.";
        "Floor MM" := ServiceItem.Floor;
        "Apartment No. MM" := ServiceItem."Apartment No.";
        "Street No. Text MM" := ServiceItem."Street No. Text";

    end;

    var
        ProcessAbortedErr: Label 'Process aborted!';

    local procedure OnValidateStreet()
    var
        Stroke: Record Stroke;
        StreetRecord: Record Street;
    begin
        Stroke.ValidateStreetNo("Street No.", Street, "Municipality Code", MZ, Rec.Stroke, String, "Zone Stroke");
        Validate("Municipality Code");
        Validate(MZ);
        "Street Name" := '';
        StreetRecord.SetRange("Code", Street);
        if StreetRecord.FindFirst then
            "Street Name" := StreetRecord.Description;
        Address := StrSubstNo('%1 %2', "Street Name", "Street No.");
    end;

}
