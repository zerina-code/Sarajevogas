page 50194 "Installation History Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Installation History";
    Caption = 'Installation History';


    layout
    {
        area(Content)



        {
            field(CountV; CountV)
            {

                Caption = 'Count';
                Style = Unfavorable;
            }
            repeater("")
            {
                field("Installation Date"; "Installation Date") { ApplicationArea = all; }
                field("Inventory Number"; "Inventory Number") { }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field("Measuring Point Adress"; "Measuring Point Adress") { ApplicationArea = all; }
                field("Measuring Point string"; "Measuring Point string") { }
                field("Measuring Point Stroke"; "Measuring Point Stroke") { }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("Customer Stroke"; "Customer Stroke") { }
                field("Customer string"; "Customer string") { }
                field("Customer Zone stroke"; "Customer Zone stroke") { }
                field(Email; Email) { }

                field(Code; Code)
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        G: Record Gauge;
                        GCard: Page Gauges;
                        Corr: Record "El. Volume Corr";
                        CorrCard: page "EL. Volume Corr.";
                        Radio: Record "Radio Module";
                        RadioCard: Page "Radio Module Card";

                    begin
                        if Type = Type::Corrector then begin
                            Corr.Reset();
                            Corr.SetFilter(Code, '%1', rec.Code);
                            CorrCard.SetTableView(Corr);
                            CorrCard.Run();
                        end;

                        if Type = Type::Radio_Module then begin
                            Radio.Reset();
                            Radio.SetFilter(Code, '%1', rec.Code);
                            RadioCard.SetTableView(Radio);
                            RadioCard.Run();
                        end;

                        if Type = Type::Gauge then begin
                            G.Reset();
                            G.SetFilter(Code, '%1', rec.Code);
                            GCard.SetTableView(G);
                            GCard.Run();
                        end;

                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        G: Record Gauge;
                        GCard: Page Gauges;
                        Corr: Record "El. Volume Corr";
                        CorrCard: page "EL. Volume Corr.";
                        Radio: Record "Radio Module";
                        RadioCard: Page "Radio Module Card";
                    begin

                        if Type = Type::Corrector then begin
                            Corr.Reset();
                            Corr.SetFilter(Code, '%1', rec.Code);
                            CorrCard.SetTableView(Corr);
                            CorrCard.Run();
                        end;

                        if Type = Type::Radio_Module then begin
                            Radio.Reset();
                            Radio.SetFilter(Code, '%1', rec.Code);
                            RadioCard.SetTableView(Radio);
                            RadioCard.Run();
                        end;

                        if Type = Type::Gauge then begin
                            G.Reset();
                            G.SetFilter(Code, '%1', rec.Code);
                            GCard.SetTableView(G);
                            GCard.Run();
                        end;

                    end;

                }
                field("Production Year"; "Production Year") { ApplicationArea = all; Visible = false; }
                field("Calibration Year"; "Calibration Year") { ApplicationArea = all; }
                field("Programming date"; "Programming date") { ApplicationArea = all; }
                field("Date of rescheduling"; "Date of rescheduling") { ApplicationArea = all; }
                field("Serial Number I"; "Serial Number I") { ApplicationArea = all; }
                field("Serial Number II"; "Serial Number II") { ApplicationArea = all; }
                field("Reason for dismantling"; "Reason for dismantling") { }
                field("Dismantling date"; "Dismantling date") { }
                field(Active; Active) { }
                field("Date of consumption"; "Date of consumption") { Visible = false; }
                field(Reading; Reading) { Visible = false; }
                field("Gauge Size"; "Gauge Size")
                {
                    LookupPageId = "Gauge sizes";
                    DrillDownPageId = "Gauge sizes";

                    DrillDown = true;
                    Lookup = true;


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

                            //   rec."Gauge Size" := GSize.Description;



                        END;




                    end;



                    trigger OnDrillDown()
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

                            //  rec."Gauge Size" := GSize.Description;

                        END;




                    end;
                }
                field("Gauge Type"; "Gauge Type") { }
                field("Measuring point off"; "Measuring point off") { }
                field("Measuring point off Date"; "Measuring point off Date") { }
                field("Municipality Code MM"; Rec."Municipality Code MM") { }
                field(Model; Rec.Model) { }
                field(Remotely; Remotely) { }
                field("Remotely Type"; "Remotely Type") { }
                field("Measurer manufacturer"; "Measurer manufacturer") { }
                field("Gas Station Placement"; "Gas Station Placement") { }
                field(SystemCreatedBy; SystemCreatedBy) { Editable = false; Visible = false; }
                field(Billing; Billing) { }
                field("Author UserName"; "Author UserName") { Editable = false; }
                field(SystemCreatedAt; SystemCreatedAt) { Editable = false; }
                field(SystemModifiedAt; SystemModifiedAt) { Editable = false; }
                field(SystemModifiedBy; SystemModifiedBy) { Editable = false; Visible = false; }
                field("Modify UserName"; "Modify UserName") { Editable = false; }

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
                //    RunObject = report "Employee Absence Reg";

                trigger OnAction()
                var
                    //     filter: text[250];
                    NewDoc: code[20];
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit NoSeriesExtented;
                    TempMasive: Record "Gauge Change Temporery";
                    TempMassivePage: page "Gauge Tempoery List";
                    ConfirmPostLbl: Label 'Do you want to pripare Massive RN?';
                    GN: Record Gauge;
                    Manf: Record Manufacturer;
                    MM: Record "Service Item";
                begin

                    if Confirm(ConfirmPostLbl) then begin
                        Rec.FINDFIRST;
                        //   filter := Rec.GETFILTERS;
                        GLSetup.get;
                        //  NewDoc::= NoSerie.GetNextNooGLSetup.Massive', GLEntry."Posting Date", false)
                        NewDoc := NoSeries.GetNextNo(GLSetup."Massive RN", today, true);
                        //  TempMasive.DeleteAll();

                        if rec.FindSet() then
                            REPEAT
                                TempMasive.Init();
                                TempMasive.Code := NewDoc;
                                TempMasive."Create Date" := today;

                                TempMasive."Measuring Point Code" := rec."Measuring Point Code";
                                TempMasive."Gauge Code" := rec.code;
                                MM.Reset();
                                MM.SetFilter("No.", '%1', rec."Measuring Point Code");
                                if mm.FindFirst() then begin
                                    TempMasive.Remotely := mm.Remotely;
                                    TempMasive."Remotely Type" := mm."Remotely Type";
                                end;
                                if rec.Type = rec.Type::Gauge then begin
                                    GN.Reset();
                                    GN.SetFilter(Code, '%1', rec.Code);
                                    if gn.FindFirst() then begin
                                        TempMasive."Measurer manufacturer" := gn."Meter Manufacturer Desc";
                                        TempMasive."Gas Station Placement" := gn."Gas Station Placement";



                                        TempMasive."Meter Manufacturer Code" := gn."Meter Manufacturer";
                                        Manf.Reset();
                                        Manf.SetFilter(Code, '%1', TempMasive."Meter Manufacturer Code");
                                        if Manf.FindFirst() then
                                            TempMasive."Measurer manufacturer" := Manf.Name;

                                    end;

                                end;
                                TempMasive."Installation Date" := rec."Installation Date";
                                TempMasive."Measuring Point Adress" := rec."Measuring Point Adress";
                                if TempMasive."Reason for dismantling" = '' then
                                    TempMasive.validate("Reason for dismantling", 'Zamjena zbog redovne verifikacije');
                                if TempMasive."Reason for dismantling" = '' then
                                    TempMasive.validate("Reason for dismantling New", 'Zamjena zbog redovne verifikacije');
                                TempMasive."Production Year" := rec."Production Year";
                                TempMasive."Calibration Year" := rec."Calibration Year";
                                TempMasive."DD calibration" := rec."Calibration Year";

                                TempMasive."Measuring Point Adress" := rec."Measuring Point Adress";
                                TempMasive."Inventory Number" := rec."Inventory Number";
                                TempMasive."Serial Number I" := rec."Serial Number I";
                                TempMasive."Serial Number II" := rec."Serial Number II";
                                TempMasive."Dismantling date" := rec."Dismantling date";
                                TempMasive."Reason for dismantling" := rec."Reason for dismantling";
                                TempMasive."Date of rescheduling" := rec."Date of rescheduling";
                                TempMasive."Programming date" := rec."Programming date";
                                TempMasive."DD calibration" := rec."DD calibration";
                                TempMasive."DD calibration" := rec."Calibration Year";
                                if TempMasive."DD calibration" = 0 then
                                    TempMasive."DD calibration" := GN."DD calibration";
                                TempMasive."Customer No." := rec."Customer No.";
                                TempMasive."Customer Address" := rec."Customer Address";
                                TempMasive."Customer Category" := rec."Customer Category";
                                TempMasive."Customer City" := rec."Customer City";
                                TempMasive."Customer Name" := rec."Customer Name";
                                TempMasive."Customer Post Code" := rec."Customer Post Code";
                                TempMasive."Customer string" := Rec."Customer string";
                                TempMasive."Customer Stroke" := rec."Customer Stroke";
                                TempMasive."Customer Zone stroke" := rec."Customer Zone stroke";
                                TempMasive."Municipality Code MM" := rec."Municipality Code MM";
                                TempMasive."Measuring Point string" := rec."Measuring Point string";
                                TempMasive."Measuring Point Stroke" := rec."Measuring Point Stroke";
                                TempMasive."Street MM" := rec."Street MM";
                                TempMasive."Street Name MM" := rec."Street Name MM";
                                TempMasive."Street No. MM" := rec."Street No. MM";
                                TempMasive."MM Description" := rec."MM Description";
                                TempMasive."MZ MM" := rec."MZ MM";
                                TempMasive."MZ Name MM" := rec."MZ Name MM";
                                TempMasive."Address MM" := rec."Address MM";
                                TempMasive."Municipality Code MM" := rec."Municipality Code MM";
                                TempMasive.Type := rec.Type;
                                //ovo sam kao napunila sve što su oni odabrali da bi trebalo da ide na verifikaciju
                                TempMasive.Insert();



                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        clear(TempMassivePage);
                        commit;
                        TempMasive.Reset();
                        TempMasive.SetFilter(Code, '%1', NewDoc);
                        TempMassivePage.SetTableView(TempMasive);
                        TempMassivePage.Run();
                        Commit();

                        //na osnovu odabrane liste, te podatke pošalji u pomoćnu tabelu 


                    end;
                end;
            }

            action(Show)
            {

                ApplicationArea = BasicHR;
                Caption = 'Show massive temporery gauge';
                Image = CalendarChanged;
                //    RunObject = report "Employee Absence Reg";

                trigger OnAction()
                var
                    //   filter: text[250];
                    NewDoc: code[20];
                    GLSetup: Record "General Ledger Setup";
                    NoSeries: Codeunit NoSeriesExtented;
                    TempMasive: Record "Gauge Change Temporery";
                    TempMassivePage: page "Gauge Tempoery List";
                begin

                    clear(TempMassivePage);
                    commit;
                    TempMassivePage.Run();
                    Commit();

                end;

            }

            action(UpdateMMandCorrector)
            {
                // Polja Municipality Code MM (Šifra opštine mjernog mjesta) i Model (Tip korektora) su dodana na ovaj page list pa ih je potrebno populirati 
                // postojećim podacima. Ovu akciju će vjerovatno trebati obrisati poslije, pošto će se poslije ova polja ažurirati preko Mjerača
                ApplicationArea = BasicHR;
                Caption = 'Update fields Municipality Code MM and Model';
                Image = UpdateDescription;
                ToolTip = 'This action will update all fields Municipality Code MM and Model in table Installation History if they are empty.';

                trigger OnAction()
                var
                    IH: Record "Installation History";
                    SI: Record "Service Item"; //Mjerno mjesto
                    CORR: Record "El. Volume Corr"; //Šifarnik korektora
                    ConfirmUpdate: Label 'Do you want to update the fields Municipality Code MM and Model?';
                begin
                    if Confirm(ConfirmUpdate) then begin
                        //Pronadji prazna polja Šifra opštine MM i populiraj ih sa šifrom iz Mjernog mjesta:
                        IH.Reset();
                        IH.SetFilter("Municipality Code MM", '%1', '');
                        if IH.FindSet() then
                            repeat
                                SI.Reset();
                                SI.SetRange("No.", IH."Measuring Point Code");
                                if SI.FindFirst() then begin
                                    IH."Municipality Code MM" := SI."Municipality Code MM";
                                    IH.Modify();
                                end;
                            until IH.Next() = 0;

                        //Pronađi redove sa praznim poljem Tip korektora (Model) gdje je Vrsta = Korektor i populiraj polje Tip korektora sa podatkom Tip Korektora (Model) sa Liste Korektora:
                        IH.Reset();
                        IH.SetRange(Type, Rec.Type::Corrector);
                        IH.SetFilter(Model, '%1', '');
                        if IH.FindSet() then
                            repeat
                                CORR.Reset();
                                CORR.SetRange(Code, IH.Code);
                                if CORR.FindFirst() then begin
                                    IH.Model := CORR.Model;
                                    IH.Modify();
                                end;
                            until IH.Next() = 0;

                    end;
                end;
            }

            action(UpdateEmailAddress)
            {
                ApplicationArea = BasicHR;
                Caption = 'Update field Email';
                Image = UpdateDescription;
                ToolTip = 'This action will update all fields Email in table Installation History if they are empty.';


                trigger OnAction()
                var
                    IHT: Record "Installation History";
                    CustT: Record Customer;
                    ConfirmMessage: Label 'Do you want to update the field Email?';
                begin

                    if Confirm(ConfirmMessage) then begin
                        IHT.Reset();
                        IHT.SetRange(Active, true);
                        IHT.SetFilter("Customer No.", '<>%1', '');
                        if IHT.FindSet() then
                            repeat
                                CustT.Reset();
                                CustT.SetRange("No.", IHT."Customer No.");
                                if CustT.FindFirst() then begin
                                    IHT.Email := CustT."E-Mail 2";
                                    IHT.Modify();
                                end;

                            until IHT.Next() = 0;

                    end



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


        CalcFields("Status MM", "Measuring point off", "Measuring point off Date");
        us.reset;
        us.setfilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Allowed to update IH" = true then
                CurrPage.Editable := true
            else
                CurrPage.Editable := False;

            if us."Calc Date from" <> 0D then begin
                /*       SetFilter("Date Filter 2", '<=%1|>=%2|%3', us."Calc Date from", us."Calc Date to", 0D);
                       //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023
                       SetFilter("Date Filter", '<=%1', us."Calc Date from");
                       SetFilter(Type, '%1', Type::Gauge);*/

            end;
        end;


    end;




    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Status MM", "Measuring point off", "Measuring point off Date");
        CountV := rec.Count;

        us.reset;
        us.setfilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Allowed to update IH" = true then
                CurrPage.Editable := true
            else
                CurrPage.Editable := False;


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
        ModifyYes: Boolean;
}