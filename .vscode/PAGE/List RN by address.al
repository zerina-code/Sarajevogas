page 50078 "List RN by address"
{
    Caption = 'List RN by address';
    CardPageID = "Request Card";
    PageType = List;
    SourceTable = "Service Item Line";
    Editable = false;



    layout
    {
        area(content)
        {

            field(CountV; CountV)
            {

                Caption = 'Count';
                Style = Unfavorable;
            }

            repeater(General)
            {
                field("Document No."; "Document No.")
                {

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        shi.SetFilter("Document Type", '%1', shi."Document Type"::Order);
                        rp.SetTableView(shi);
                        rp.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        shi.SetFilter("Document Type", '%1', shi."Document Type"::Order);
                        rp.SetTableView(shi);
                        rp.Run();

                    end;


                }
                field(Type; Type)
                {
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        shi.SetFilter("Document Type", '%1', shi."Document Type"::Order);
                        rp.SetTableView(shi);
                        rp.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        shi.SetFilter("Document Type", '%1', shi."Document Type"::Order);
                        rp.SetTableView(shi);
                        rp.Run();

                    end;

                }
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
                        OS: Record "Fixed Asset";
                        OSPage: page "Fixed Asset List";

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

                                ServH.Validate("Owner No.", ServiceItem."Contact MM");
                                ServH.Modify();

                                //ovdje preuzeti podatke o vlasniku

                                //
                            end;

                            //    SerItem.Run();
                            ;

                        end;

                        if Type = Type::OS then begin
                            Clear(SerItem);

                            ServH.Get(rec."Document Type", rec."Document No.");

                            OS.Reset();
                            OS.SetFilter("Customer No.", '%1', ServH."Customer No.");
                            OSPage.SetTableView(OS);
                            OSPage.LOOKUPMODE(TRUE);
                            IF OSPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                                OSPage.GETRECORD(OS);
                                validate("Service Item No. - Relation", OS."No.");

                                // ServH.Validate("Owner No.", ServiceItem."Contact MM");
                                ServH.Modify();

                                //ovdje preuzeti podatke o vlasniku

                                //
                            end;


                        end;

                    end;
                }
                field("Customer No."; "Customer No.") { }
                field("Customer Name"; "Customer Name") { }




                field("MM Category"; Rec."MM Category")
                {
                    ApplicationArea = All;
                }
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
                    Visible = false;
                }
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
                        GaugeP: page Gauges;

                    begin
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
                }
                field(RMS; RMS)
                {
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
                        GaugeP: page Gauges;

                    begin
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
                }



                field("Serial No."; "Serial No.")
                {
                    Visible = false;

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
                        GaugeP: page Gauges;

                    begin
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
                }

                field("New Gauges2"; "New Gauges")
                {
                    Visible = false;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        GaugeR: Record Gauge;
                        GaugeP: page Gauges;

                    begin

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
                }
                field("Gauge Size"; "Gauge Size") { }
                field("Gauge Size New"; "Gauge Size New") { Visible = false; }
                field("Measurer manufacturer New"; "Measurer manufacturer New") { Visible = false; }
                field("Date of consumption"; "Date of consumption") { }
                field(Reading; Reading) { }

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
                field(Remotely; Remotely) { ApplicationArea = All; }
                field("Remotely Type"; "Remotely Type") { ApplicationArea = All; }
                field("Request Department"; "Request Department") { }
                field("Request Department Name"; "Request Department Name") { }
                field("Responsible Department"; "Responsible Department") { }
                field("Responsible Department Name"; "Responsible Department Name") { }

                field("Reason for dismantling New"; "Reason for dismantling New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Dismantling date New"; "Dismantling date New") { ApplicationArea = all; style = Favorable; Visible = true; }
                //datum  razlog za zamjenu
                field("Type G_R"; "Type G_R") { ApplicationArea = all; style = Favorable; Visible = true; }
                //Datum nove ugradnje
                field("Installation Date New"; "Installation Date New") { ApplicationArea = all; style = Favorable; Visible = true; }

                field("Date of consumption New"; "Date of consumption New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Reading New"; "Reading New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Radio Module Code New"; "Radio Module Code New")
                {

                }
                field("Radio Module Serial I New"; "Radio Module Serial I New") { }
                field("Radio Module Serial II New"; "Radio Module Serial II New") { }
                field(Applied; Applied) { }
                field("Inventory Number New"; "Inventory Number New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Measuring Point Code New"; "Measuring Point Code New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("New Gauges"; "New Gauges") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Measuring Point Address New"; "Measuring Point Address New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Customer No. New"; "Customer No. New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Customer Name New"; "Customer Name New") { ApplicationArea = all; style = Favorable; Visible = true; }

                field("Production Year New"; "Production Year New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Calibration Year New"; "Calibration Year New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Programming date New"; "Programming date New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Date of rescheduling New"; "Date of rescheduling New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Serial Number I New"; "Serial Number I New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Serial Number II New"; "Serial Number II New") { ApplicationArea = all; style = Favorable; Visible = true; }
                field("Return RN"; "Return RN") { ApplicationArea = all; }
                field("Prep. Contr. Empl. No."; Rec."Prep. Contr. Empl. No.")
                {
                    ApplicationArea = All;
                }
                field("Prep. Process. Empl. No."; Rec."Prep. Process. Empl. No.")
                {
                    ApplicationArea = All;
                }
                field("Prep. Verif. Empl. No."; Rec."Prep. Verif. Empl. No.")
                {
                    ApplicationArea = All;
                }
                field("Real. Contr. Empl. No."; Rec."Real. Contr. Empl. No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Real. Process. Empl. No."; Rec."Real. Process. Empl. No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Real. Verif. Empl. No."; Rec."Real. Verif. Empl. No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Done Date"; "Done Date") { }

            }




        }

    }


    actions
    {

        //CR
        area(Processing)
        {

            action("Update Data")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = true;
                Caption = 'Update Data';
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                //      ReportCR: Report CR;
                begin
                    if UserId <> 'SARAJEVOGAS\TENEO' then begin
                        Error('Vi nemate pravo da ažurirate ove podatke!');
                    end
                    else begin
                        Report.Run(50201, true, true, Rec);
                    end;

                end;
            }

            action("CR dokument")
            {
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Visible = false;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                //      ReportCR: Report CR;
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetFilter("No.", '%1', "Document No.");

                    //    ReportCR.SETTABLEVIEW(SalesHeader);
                    //  ReportCR.RUN;

                end;
            }

        }


    }
    trigger OnOpenPage()
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

    end;

    var
        CountV: Integer;
}
