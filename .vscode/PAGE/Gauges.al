page 50168 "Gauges"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Gauge;
    Caption = 'Gauge';

    layout
    {
        area(Content)
        {
            group(General)
            {

                Caption = 'General';

                field(Code; Code)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Gauge Category"; "Gauge Category") { ApplicationArea = all; }
                field("Inventar number"; "Inventar number") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { }
                field("Customer No."; "Customer No.") { ApplicationArea = all; visible = false; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; visible = false; }
                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; visible = false; }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Gas Station Placement"; "Gas Station Placement") { }

                field("Number of impulses (Imp/m3)"; "Number of impulses (Imp/m3)") { ApplicationArea = all; Caption = 'Imp/m3'; }
                field(Destroyed; Destroyed) { }
                field("Year of Production"; "Year of Production")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if "Year of Production" < 1970 then begin
                            Error('Godina produkcije mora biti u rasponu od 1970te godine do trenutne');
                        end;
                        if "Year of Production" > Date2DMY(Today, 3) then begin
                            Error('Godina produkcije mora biti u rasponu od 1970te godine do trenutne');

                        end;
                        if strlen(Format("Year of Production")) < 4 then
                            Error('Godina produkcije mora imati 4 karaktera!');

                    end;
                }
                field("DD calibration"; "DD calibration")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if strlen(Format("Year of Production")) < 4 then
                            Error('Godina produkcije mora imati 4 karaktera!');
                        if "Year of Production" <> Date2DMY(WorkDate(), 3) then
                            Message('Unesena godina se razlikuje od trenutne kalendarske godine!');
                    end;
                }

                field("Radio Module"; "Radio Module")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "Radio Module";
                        GCard: page "Radio Module Card";
                        GList: page "Radio Module";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."Measuring Point";
                            us.Modify();
                        end;
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point Code", '%1', Rec."Measuring Point");

                        if Gauge.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;





                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "Radio Module";
                        GCard: page "Radio Module Card";
                        GList: page "Radio Module";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."Measuring Point";
                            us.Modify();
                        end;
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point Code", '%1', rec."Measuring Point");
                        if Gauge.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;


                    end;
                }

                field("Meter type"; "Meter type") { ApplicationArea = all; }
                field("Gauge Type"; "Gauge Type")
                {
                    ApplicationArea = all;
                    Visible = false;


                    /*  trigger OnDrillDown()
                      var
                          myInt: Integer;
                          GaugeSize: page "Gauge sizes";
                          GSize: Record "Types Of Diseases";
                      begin

                          GSize.Reset();
                          GSize.SetFilter(Types, '%1', GSize.Types::"Gauge Type");
                          GaugeSize.SetTableView(GSize);
                          GaugeSize.run;

                      end;
  */
                    /*      trigger OnLookup(var Text: Text): Boolean
                          var
                              myInt: Integer;
                              GaugeSize: page "Gauge Types";
                              GSize: Record "Types Of Diseases";
                          begin


                              GSize.Reset();
                              GSize.SetFilter(Types, '%1', GSize.Types::"Gauge Type");
                              GaugeSize.SetTableView(GSize);

                              GaugeSize.LOOKUPMODE(TRUE);

                              IF GaugeSize.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                  GaugeSize.GETRECORD(GSize);

                                  rec."Gauge Type" := GSize.Description;

                              END;




                          end;*/
                }
                field("Gauge Size"; "Gauge Size")
                {
                    ApplicationArea = all;

                    /*   trigger OnDrillDown()
                       var
                           myInt: Integer;
                           GaugeSize: page "Gauge sizes";
                           GSize: Record "Types Of Diseases";
                       begin

                           GSize.Reset();
                           GSize.SetFilter(Types, '%1', GSize.Types::"Gauge size");
                           GaugeSize.SetTableView(GSize);
                           GaugeSize.run;

                       end;*/

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        GaugeSize: page "Gauge sizes";
                        GSize: Record "Types Of Diseases";
                    begin


                        GSize.Reset();
                        GSize.SetFilter(Types, '%1', GSize.Types::"Gauge size");
                        GaugeSize.SetTableView(GSize);

                        GaugeSize.LOOKUPMODE(TRUE);

                        IF GaugeSize.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            GaugeSize.GETRECORD(GSize);

                            rec."Gauge Size" := GSize.Description;

                        END;




                    end;


                }
                field("Gauge Position"; "Gauge Position") { ApplicationArea = all; }
                field("Flow direction"; "Flow direction") { ApplicationArea = all; }
                field("Type of Connection"; "Type of Connection") { ApplicationArea = all; }
                field("Installation length"; "Installation length") { ApplicationArea = all; }
                field(Station; Station) { ApplicationArea = all; }
                field(Weight; Weight) { ApplicationArea = all; Visible = false; }
                field(Model; Model) { ApplicationArea = all; }
                field("Remotely Type"; "Remotely Type") { ApplicationArea = all; }
                field(Origin; Origin) { ApplicationArea = all; }
                field("Method of calculation"; "Method of calculation") { }
                field("Type of reading"; "Type of reading") { ApplicationArea = all; }
                field("Reading Time"; "Reading Time") { ApplicationArea = all; }



            }
            group(parameter)
            {
                Caption = 'parameter';
                field(No; No) { ApplicationArea = all; }
                field(Pmax; Pmax) { ApplicationArea = all; Caption = 'Pmax (bar)'; }
                field(Qmin; Qmin) { ApplicationArea = all; }
                field(Qmax; Qmax) { ApplicationArea = all; }

            }
            part(InstallationHistory; "Installation History")

            {
                ApplicationArea = all;
                SubPageLink = Type = filter(Gauge), Code = field(Code);
            }
        }



    }

    procedure GetF(DocumentNO: code[20]) Source: Text
    var
        Gaug2: Record Gauge;
        iHC: Record "Installation History";
        Csetup: Record "Calculation Setup";
        MMInt: Integer;

    begin
        Source := GETFILTERS;
        Gauge2.Reset();
        Gauge2.CopyFilters(Rec);
        if Gauge2.FindSet() then
            repeat
                CJL.Init();
                Csetup.get;
                cjl."Calorific power coefficient" := Csetup."Calorific power coefficient";
                CJL."Atmospheric pressure" := Csetup."Atmospheric pressure";
                CJL."Scale factor" := Csetup."Scale factor";
                CJL."Compression coefficient" := Csetup."Compression coefficient";
                CJL.Gauge := Gauge2.Code;
                CJL."Gauge Size" := Gauge2."Gauge Size";
                CJL."Measuring Point Code" := Gauge2."Measuring Point";
                MM.Reset();
                MM.SetFilter("No.", '%1', Gauge2."Measuring Point");
                if mm.FindFirst() then begin
                    mm.CalcFields("Street Name MM", "Municipality Name MM");
                    CJL."Address MM" := mm.Address;

                    if Evaluate(MMInt, MM.Street) then
                        CJL."Street No. Int MM" := MMInt
                    else
                        CJL."Street No. Int MM" := 0;

                    cjl."Street Name MM" := MM."Street Name MM";
                    cjl.Floor := mm.Floor;
                    CJL."Apartment No." := mm."Apartment No.";
                    CJL."Remotely Type" := mm."Remotely Type";
                    CJL."MM Description" := mm.Description + mm."Description 2";
                    cjl."Municipality Code MM" := MM."Municipality Code MM";
                    CJL."Municipality Name MM" := mm."Municipality Name MM";
                    cjl."Summer Zone" := mm."Summer Zone";
                    cjl."Reading Mode" := mm."Reading Mode";
                    cjl."Winter Zone" := mm."Winter Zone";
                    cjl."Transit Zone" := mm."Transit Zone";
                    CJL."Municipality Code Customer" := mm."Municipality Code Customer";
                    cjl."Municipality Name Customer" := mm."Municipality Name Customer";
                    cjl."Street Customer" := mm."Street Customer";
                    CJL."Street Name Customer" := mm."Street Name Customer";
                    cjl."Floor Customer" := mm."Floor Customer";
                    cjl."Apartment No. Customer" := mm."Apartment No. Customer";
                    cjl."Home No. Customer" := mm."Home No. Customer";
                    cjl."Home No." := mm."Home No.";
                    cjl."Category Customer" := mm."Customer Category";
                    cjl."Category MM" := mm."MM Category";
                    cjl."Customer No." := mm."Customer No.";
                    cjl."MZ Customer" := mm."MZ Customer";
                    cjl."MZ Name Customer" := mm."MZ Name Customer";
                    cjl."MZ MM" := mm."MZ MM";
                    cjl."MZ Name MM" := mm."MZ Name MM";
                    cjl."MM Description" := mm.Description + mm."Description 2";
                    cjl."Remotely Type" := mm."Remotely Type";
                    cjl."Reading Mode" := mm."Reading Mode";
                    CJL."MM Description" := mm.Description + mm."Description 2";
                    CJL."Mobile No." := mm."Mobile No.";
                    CH.Reset();
                    CH.SetFilter(Code, '%1', DocumentNO);
                    if ch.findfirst then begin
                        CJL."Month of Calculation" := ch."Month of Calculation";
                        cjl."Year of Calculation" := ch."Year of Calculation";
                        CJL."Month Of GAS Calculation" := ch."Month Of GAS Calculation";
                        cjl."Year Of GAS Calculation" := ch."Year Of GAS Calculation";


                    end;



                end;

                Gaug2.Reset();
                Gaug2.SetFilter(Code, '%1', Gauge2.Code);
                if Gaug2.FindFirst() then
                    cjl."Serial Number" := Gaug2."Inventar number";

                iHC.Reset();
                iHC.SetFilter(Type, '%1', iHC.Type::Corrector);
                iHC.SetFilter("Customer No.", '%1', cjl."Customer No.");
                iHC.SetFilter(Active, '%1', true);
                if iHC.FindFirst() then begin
                    cjl."EL Volume Code" := iHC.Code;
                    CJl."EL Volume Description" := iHC."EL Volume Description";
                end;

                CJL.Insert();

            until Gauge2.Next() = 0;

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Radio Module");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Radio Module");

    end;


    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
        InventarE: Record Gauge;
    begin
        if Code <> '' then begin
            TestField("Inventar number");
            TestField("Meter Manufacturer");
            TestField("Gauge Size");
            TestField("Year of Production");
            TestField("DD calibration");

            InventarE.Reset();
            InventarE.SetFilter("Inventar number", '%1', "Inventar number");
            InventarE.SetFilter(Code, '<>%1', Code);
            if InventarE.FindFirst() then
                Message('Mjerač već postoji sa ovim serijskim brojem!');
        end;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var

        myInt: Integer;
        us: Record "User Setup";
        SMS: Record "General Ledger Setup";
        ServMgtSetup: Record "General Ledger Setup";
        ServMgtSetupGet: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Cust: Record customer;
        MMPoint: Record "Service Item";
    begin
        ServMgtSetup.get;
        if Code = '' then begin
            ServMgtSetupGet.get;
            ServMgtSetupGet.TestField("Gauge Code");
            NoSeriesMgt.InitSeries(ServMgtSetupGet."Gauge Code", xRec."No. Series", 0D, code, "No. Series");
        end;

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Cust.Reset();
            Cust.SetFilter("No.", '%1', us."Customer No.");
            if Cust.FindFirst() then
                Validate("Customer Category", cust."Customer Category");
            Validate("Address MM", us."Adress MM");
            Validate("Customer No.", us."Customer No.");

            MMPoint.Reset();
            MMPoint.SetFilter("No.", '%1', us."Measuring Code");
            if MMPoint.FindFirst() then
                Validate("Gauge Category", MMPoint."MM Category");


        end;



    end;

    var
        myInt: Integer;
        CH: Record "Calcuation Header";
        Gauge2: Record Gauge;
        MM: Record "Service Item";
        CU: Record Customer;
        CJL: Record "Calculation Journal Line";
}