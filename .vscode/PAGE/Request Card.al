page 50190 "Request Card"
{
    Caption = 'Request Card';
    PageType = Card;
    SourceTable = "Service Header";
    SourceTableView = where("Document Type" = const("Order"));
    InsertAllowed = false;

    layout
    {
        area(content)
        {


            group("Information on Connection Data")
            {
                Caption = 'Information on Connection Data', Comment = 'Podaci o inform. o mogućnosti priključenja';
                Visible = InformationOnConnectionVisible;
                field("Sent to ZIK"; Rec."Sent to ZIK")
                {
                    ApplicationArea = All;
                }
                field("Received from ZIK"; Rec."Received from ZIK")
                {
                    ApplicationArea = All;
                }
                field("Field Work Planned"; Rec."Field Work Planned")
                {
                    ApplicationArea = All;
                }
                field("DGM Diameter2"; "DGM Diameter") { Caption = 'DGM Diameter'; }
                field("Service Line Diameter2"; "Service Line Diameter") { Caption = 'Service Line Diameter'; }
                field("Measure Point Pressure2"; "Measure Point Pressure") { Caption = 'Measure Point Pressure"'; }
                field("G Gauge Size2"; "G Gauge Size")
                {
                    Caption = 'Gauge size';

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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

                        END;




                    end;


                }
                field(Excavation_2; Excavation) { Caption = 'Excavation'; }
                field("Excavation Permit"; Rec."Excavation Permit")
                {
                    ApplicationArea = All;
                }
                field("Mandatory approval"; Rec."Mandatory approval")
                {
                    ApplicationArea = All;
                }
                field("Legal Property Note"; Rec."Legal Property Note")
                {
                    ApplicationArea = All;
                }


                field("Processing Date"; Rec."Processing Date")
                {
                    Caption = 'Finishing Date', Comment = 'Datum obrade';
                    ApplicationArea = All;
                }
                field("Request File Name"; Rec."Request File Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadFile();
                    end;

                }
                field("Document No."; "Document No.")
                {
                    DrillDown = true;
                    Lookup = true;
                    DrillDownPageId = 50096;
                    LookupPageId = 50096;
                }

            }

            field("Employee Responsible"; Rec."Employee Responsible")
            {
                ApplicationArea = All;
                Visible = false;
                trigger OnValidate()
                begin
                    GetEmployeeResponsibleFullName();
                end;
            }
            field(EmployeeResponsibleName; EmployeeResponsibleName)
            {
                Caption = 'Employee Responsible Name', Comment = 'Ime zaposlenika';
                ApplicationArea = All;
                Visible = false;
                Editable = false;
            }





            //novoĐ
            group("Information On Location,Route,Plan")
            {
                Caption = 'Processing Request', Comment = 'Obrada zahtjeva';
                Visible = LocationRouteSpatialPlanInformationVisible;

                field("Employee Responsible Loc,Route,Plan"; Rec."Employee Responsible")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        GetEmployeeResponsibleFullName();

                    end;
                }
                field(EmployeeResponsibleNameLocRoutePlan; EmployeeResponsibleName)
                {
                    Visible = false;
                    Caption = 'Employee Responsible Name', Comment = 'Ime zaposlenika';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Classification; Rec.Classification)
                {
                    ApplicationArea = All;
                }
                field("Protocol No."; "Protocol No.") { }
                field("Registry No."; Rec."Registry No.")
                {
                    ApplicationArea = All;
                }
                field("Entry Person"; Rec."Entry Person")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Change Person"; Rec."Change Person")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(GeoID; Rec.GeoID)
                {
                    ApplicationArea = All;
                }
                field("Registry Code"; Rec."Registry Code")
                {
                    ApplicationArea = All;
                }
                field(Archived; Archived) { ApplicationArea = all; }
                field("Archive Date"; Rec."Archive Date")
                {
                    ApplicationArea = All;

                }
                field("Entry Date"; Rec."Entry Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Change Date"; Rec."Change Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }

                field("Request File Name_2"; Rec."Request File Name")
                {
                    ApplicationArea = All;
                    Caption = 'Request File Name';
                    trigger OnDrillDown()
                    begin
                        DownloadFile();
                    end;

                }
                field("Document No._2"; "Document No.")
                {
                    DrillDown = true;
                    caption = 'Document No.';
                    Lookup = true;
                    DrillDownPageId = 50096;
                    LookupPageId = 50096;
                }
            }
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    //                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;

                }
                field(Initials; Rec.Initials)
                {
                    Visible = InformationOnConnectionVisible;
                }
                field("Evidential Number"; "Evidential Number") { Visible = onlyGeneral; }

                field("Evidential Number2"; "Evidential Number")
                {
                    Visible = GeoGlobal;

                    caption = 'Evidential Number';
                }
                field("Add Description"; "Add Description") { ApplicationArea = all; Visible = false; }

                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Editable = RTypeEditable;
                    Visible = true;



                }








                //      GaugeSize.SetTableView(GSize);

                //    GaugeSize.LOOKUPMODE(TRUE);

                //  IF GaugeSize.RUNMODAL = ACTION::LookupOK THEN BEGIN

                //    GaugeSize.GETRECORD(GSize);

                //   rec.Status_request := GSize.Description;

                // END;

                field(Status_request; Status_request)
                {
                    DrillDownPageId = "Status history 2";
                    LookupPageId = "Status history 2";
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        USsetup: Record "User Setup";
                        SH: Record "Status History 2";
                        SP: page "Status history 2";


                    begin

                        USsetup.reset;
                        USsetup.setfilter("User ID", '%1', userid);
                        if USsetup.findfirst then begin
                            USsetup."Request Type" := rec."Request Type";
                            USsetup."Source table" := 5900;
                            USsetup.modify;
                        end;

                        SH.Reset();
                        SH.SetFilter("Request No.", '%1', rec."No.");
                        SH.SetFilter("Request Type", '%1', rec."Request Type");
                        sh.SetFilter(Active, '%1', true);
                        sh.setfilter("Source table", '%1', 5900);
                        SP.SetTableView(sh);
                        SP.Run();

                    end;



                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        USsetup: Record "User Setup";
                        SH: Record "Status History 2";
                        SP: page "Status history 2";
                    begin
                        USsetup.reset;
                        USsetup.setfilter("User ID", '%1', userid);
                        if USsetup.findfirst then begin
                            USsetup."Request Type" := rec."Request Type";
                            USsetup."Source table" := 5900;
                            USsetup.modify;

                        end;
                        SH.Reset();
                        SH.SetFilter("Request No.", '%1', rec."No.");
                        SH.SetFilter("Request Type", '%1', rec."Request Type");
                        sh.SetFilter(Active, '%1', true);
                        sh.setfilter("Source table", '%1', 5900);
                        SP.SetTableView(sh);
                        SP.Run();
                    end;


                }

                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Customer Category"; Rec."Customer Category")
                {
                    ApplicationArea = All;
                }
                field("Filters by Gauge"; "Filters by Gauge")
                {

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        IHPage: page "Installation History Page";
                        IH: Record "Installation History";
                        ServiceItemLine: Record "Service Item Line";
                        ServiceItemLineInit: Record "Service Item Line";
                        CUF: Record Customer;
                        US: Record "User Setup";
                    begin

                        Clear(IHPage);

                        IH.Reset();
                        ih.SetFilter(Type, '%1', ih.type::gauge);
                        ih.SetFilter(Active, '%1', true);
                        IHPage.SetTableView(IH);
                        Commit();
                        IHPage.LOOKUPMODE(TRUE);
                        IF IHPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            IHPage.GETRECORD(ih);
                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us.Upd := true;
                                us.Modify();
                                Commit();
                            end;
                            rec.Validate("Customer No.", ih."Customer No.");
                            rec."Filters by Measuring point" := ih."Measuring Point Code";
                            rec."Filters by Gauge" := ih."Inventory Number";


                            ServiceItemLine.Reset();
                            ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                            ServiceItemLine.setfilter("Document Type", '%1', rec."Document Type");
                            ServiceItemLine.SetFilter(type, '%1', ServiceItemLine.type::MM);
                            if not ServiceItemLine.FindFirst() then begin
                                ServiceItemLineInit.init;
                                ServiceItemLineInit."Document No." := rec."No.";
                                ServiceItemLineInit."Document Type" := rec."Document Type";
                                ServiceItemLineInit.validate("Customer No.", ih."Customer No.");
                                ServiceItemLine."Type G_R" := ServiceItemLine."Type G_R"::Gauge;

                                ServiceItemLineInit.validate(type, ServiceItemLineInit.type::MM);
                                ServiceItemLineInit.Validate("Service Item No. - Relation", ih."Measuring Point Code");
                                // rec."Filters by Gauge" := ServiceItemLine.rms;
                                CUF.reset;
                                CUF.SetFilter("No.", '%1', ServiceItemLineInit."Customer No.");
                                if CUF.FindFirst() then
                                    ServiceItemLineInit."Customer Name" := CUF.Name;
                                ServiceItemLineInit.Insert();

                            end;

                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.FindFirst() then begin
                                us.Upd := false;
                                us.Modify();
                                Commit();
                            end;


                        end;
                    end;



                }
                field("Filters by Measuring point"; "Filters by Measuring point") { }
                field("Filters by Fixed Asset"; "Filters by Fixed Asset")
                {
                    trigger OnLookup(var Text: Text): Boolean
                    var

                        ServiceItemLine: Record "Service Item Line";
                        ServiceItemLineInit: Record "Service Item Line";
                        OS: record "Fixed Asset";
                        OSPage: page "Fixed Asset List";
                        CustF: Record Customer;

                    begin


                        OS.Reset();
                        OS.SetFilter("GAS station type", '<>%1', '');
                        OSPage.SetTableView(OS);
                        OSPage.LOOKUPMODE(TRUE);
                        IF OSPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            OSPage.GETRECORD(OS);
                            CustF.Reset();
                            CustF.SetFilter("Internal Customer", '%1', true);
                            if CustF.FindFirst() then
                                Validate("Customer No.", CustF."No.");
                            rec."Filters by Fixed Asset" := OS."No.";


                            ServiceItemLine.Reset();
                            ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                            ServiceItemLine.setfilter("Document Type", '%1', rec."Document Type");
                            ServiceItemLine.SetFilter(type, '%1', ServiceItemLine.type::OS);
                            if not ServiceItemLine.FindFirst() then begin
                                ServiceItemLineInit.init;
                                ServiceItemLineInit."Type" := ServiceItemLineInit.Type::OS;
                                ServiceItemLineInit."Document No." := rec."No.";
                                ServiceItemLineInit."Document Type" := rec."Document Type";
                                ServiceItemLineInit.validate("Customer No.", rec."Customer No.");
                                ServiceItemLineInit.Validate("Service Item No. - Relation", OS."No.");
                                ServiceItemLineInit.Mark := OS.Mark;
                                ServiceItemLineInit.Address := OS.Address;
                                ServiceItemLineInit.street := OS."Home No.";

                                // rec."Filters by Gauge" := ServiceItemLine.rms;

                                ServiceItemLineInit."Customer Name" := CustF.Name;
                                ServiceItemLineInit.Insert();

                            end;
                        end;

                    end;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Caption = 'Customer Phone No.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Caption = 'Customer E-mail';
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    Caption = 'Bill-to Customer No.';
                    ApplicationArea = All;
                }
                field("Bill-to Customer Name"; rec."Bill-to Name")
                {
                    Caption = 'Bill-to Customer Name';
                    ApplicationArea = All;
                }
                field("Bill-to Registration No."; rec."Bill-to Registration No.")
                {
                    Caption = 'Bill-to Registration No.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to VAT Registration No."; rec."Bill-to VAT Registration No.")
                {
                    Caption = 'Bill-to VAT Registration No.';
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Designer Connection Type"; Rec."Designer Connection Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                    //  visible=false;
                }
                field("Designer No."; Rec."Designer No.")
                {
                    ApplicationArea = All;
                    //   Visible = RType;
                    Visible = false;
                }
                field("Designer Name"; Rec."Designer Name")
                {
                    ApplicationArea = All;
                    //   Visible = RType;
                    Visible = false;
                }
                field("Designer Phone No."; Rec."Designer Phone No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    //    Visible = RType;
                }
                field("Designer Email"; Rec."Designer Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                    //  Visible = RType;
                }
                field("ProcesingDocument"; Rec.GetProcessingDocument())
                {
                    Caption = 'Processing Document', Comment = 'Obrada zahtjeva';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ProcessingDocumentVisible;
                    trigger OnDrillDown()
                    begin
                        Rec.OpenRequestDocumentCard(Rec.GetProcessingDocument());
                    end;
                }
                field("Request File Name2"; Rec."Request File Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadFile();
                    end;

                }
                field("Document No.2"; "Document No.")
                {
                    DrillDown = true;
                    Lookup = true;
                    DrillDownPageId = 50096;
                    LookupPageId = 50096;
                }
                field("Consumption Category"; Rec."Consumption Category")
                {
                    Visible = InformationOnConnectionVisible;
                }
            }

            group("Verification")
            {
                Caption = 'Verification Information on Connection Data', Comment = 'Podaci o inform. o mogućnosti priključenja';
                Visible = Verification;

                //ĐK  grid("Prepade")
                //ĐK{
                //ĐKGridLayout = Rows;
                //ĐK  ShowCaption = false;
                group(Prepare)
                {

                    Caption = 'Prepade - processing';
                    field("Prep. Process. Empl. No._2"; Rec."Prep. Process. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Process. Empl. No.';
                        ShowCaption = false;
                    }
                    field("Prep. Process. Empl. Name."; "Prep. Process. Empl. Name.") { ShowCaption = false; Editable = false; }






                    //ĐK }
                }
                //ĐK grid("Prepade2")
                //ĐK {
                //ĐK   GridLayout = Rows;
                group(Prep)
                {

                    Caption = 'Real. Process';

                    field("Real. Process. Empl. No._2"; Rec."Real. Process. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Real. Process. Empl. No.';
                        ShowCaption = false;
                    }

                    field("Real. Process. Empl. Name"; "Real. Process. Empl. Name") { ShowCaption = false; Editable = false; }



                }
                //ĐK  }

                //ĐK   grid("Prepad3")
                //ĐK   {
                //ĐK        GridLayout = Rows;
                group(PrRep)
                {

                    Caption = 'Prepade - Control';



                    field("Prep. Contr. Empl. No._2"; Rec."Prep. Contr. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Contr. Empl. No.';
                        ShowCaption = false;
                    }


                    field("Prep. Contr. Empl. Name"; "Prep. Contr. Empl. Name") { ShowCaption = false; Editable = false; }


                }


                //ĐK   }

                //realization

                //kraj





                //ĐK  grid("Real")
                //ĐK {
                //ĐK GridLayout = Rows;
                //ĐK     ShowCaption = false;
                group(Realization)
                {
                    Caption = 'Realization Control';


                    field("Real. Contr. Empl. No._2"; Rec."Real. Contr. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Real. Contr. Empl. No.';
                        ShowCaption = false;
                    }


                    field("Real. Contr. Empl. Name"; "Real. Contr. Empl. Name") { ShowCaption = false; Editable = false; }





                }
                //ĐK    }

                //ĐK    grid("RealCOntrol")
                //ĐK  {
                //ĐK  GridLayout = Rows;
                //ĐK ShowCaption = false;
                group(RealControl_1)
                {
                    Caption = 'Prep Verification';


                    //ovo valja:
                    field("Prep. Veri. Empl. No._2"; Rec."Prep. Verif. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Verif. Empl. No.';
                        ShowCaption = false;
                    }
                    field("Prep. Verif. Empl. Name"; "Prep. Verif. Empl. Name") { ShowCaption = false; Editable = false; }
                    //






                }
                //ĐK  }





                //ĐK  grid("Prepad3_R3")
                //ĐK {
                //ĐK GridLayout = Rows;
                group(PrRep_3)
                {
                    Caption = 'Realization verifikacija';

                    field("Real. Verif. Empl. No._2"; "Real. Verif. Empl. No.")
                    {
                        Caption = 'Realisation - Verification Employee No.';
                        ShowCaption = false;

                    }
                    field("Real. Verif. Empl. Name"; "Real. Verif. Empl. Name") { ShowCaption = false; Editable = false; }


                }
                //ĐK  }




            }
            //kraj

            //nova verzija 2

            group(VerifCZK)
            {
                Caption = 'Verification Information on Connection Data';

                Visible = ProcessRequestActionVisible;
                group(Prepare3)
                {

                    Caption = 'Prepade - processing';
                    field("Prep. Process. Empl. No._3"; Rec."Prep. Process. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Process. Empl. No.';
                        ShowCaption = false;
                    }
                    field("Prep. Process. Empl. Name.3"; "Prep. Process. Empl. Name.") { ShowCaption = false; Editable = false; }






                    //ĐK }
                }
                //ĐK grid("Prepade2")
                //ĐK {
                //ĐK   GridLayout = Rows;
                group(Prep3)
                {

                    Caption = 'Real. Process';

                    field("Real. Process. Empl. No._3"; Rec."Real. Process. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Real. Process. Empl. No.';
                        ShowCaption = false;
                    }

                    field("Real. Process. Empl. Name3"; "Real. Process. Empl. Name") { ShowCaption = false; Editable = false; }



                }
                //ĐK  }

                //ĐK   grid("Prepad3")
                //ĐK   {
                //ĐK        GridLayout = Rows;
                group(PrRep2)
                {

                    Caption = 'Prepade - Control';



                    field("Prep. Contr. Empl. No._3"; Rec."Prep. Contr. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Contr. Empl. No.';
                        ShowCaption = false;
                    }


                    field("Prep. Contr. Empl. Name3"; "Prep. Contr. Empl. Name") { ShowCaption = false; Editable = false; }


                }


                //ĐK   }

                //realization

                //kraj





                //ĐK  grid("Real")
                //ĐK {
                //ĐK GridLayout = Rows;
                //ĐK     ShowCaption = false;
                group(Realization3)
                {
                    Caption = 'Realization Control';


                    field("Real. Contr. Empl. No._3"; Rec."Real. Contr. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Real. Contr. Empl. No.';
                        ShowCaption = false;
                    }


                    field("Real. Contr. Empl. Name3"; "Real. Contr. Empl. Name") { ShowCaption = false; Editable = false; }





                }
                //ĐK    }

                //ĐK    grid("RealCOntrol")
                //ĐK  {
                //ĐK  GridLayout = Rows;
                //ĐK ShowCaption = false;
                group(RealControl_3)
                {
                    Caption = 'Prep Verification';


                    //ovo valja:
                    field("Prep. Veri. Empl. No._3"; Rec."Prep. Verif. Empl. No.")
                    {
                        ApplicationArea = All;
                        Caption = 'Prep. Verif. Empl. No.';
                        ShowCaption = false;
                    }
                    field("Prep. Verif. Empl. Name3"; "Prep. Verif. Empl. Name") { ShowCaption = false; Editable = false; }
                    //






                }
                //ĐK  }





                //ĐK  grid("Prepad3_R3")
                //ĐK {
                //ĐK GridLayout = Rows;
                group(PrRep_4)
                {
                    Caption = 'Realization verifikacija';

                    field("Real. Verif. Empl. No._4"; "Real. Verif. Empl. No.")
                    {
                        Caption = 'Realisation - Verification Employee No.';
                        ShowCaption = false;

                    }
                    field("Real. Verif. Empl. Name4"; "Real. Verif. Empl. Name") { ShowCaption = false; Editable = false; }


                }
                //ĐK  }




            }
            //kraj

            //nova verzija 2

            group(Done)
            {
                Caption = 'Done';
                field("Prep Realisation Done"; "Prep Realisation Done") { }
                field("Prep Verif Done"; "Prep Verif Done") { }
                field("Prep Control Done"; "Prep Control Done") { }
                field("Prep Done Date"; "Prep Done Date") { }
                field("Prep Control Date"; "Prep Control Date") { }
                field("Prep Verif Date"; "Prep Verif Date") { }

                field("Realisation Done"; "Realisation Done") { }
                field("Verif Done"; "Verif Done") { }
                field("Control Done"; "Control Done") { }

                field("Done Date"; "Done Date") { }
                field("Control Date"; "Control Date") { }
                field("Verif Date"; "Verif Date") { }
                field("Need to reopen work order"; "Need to reopen work order") { }
                field("Due Days Reopen"; "Due Days Reopen") { }
            }

            group("Addresses")
            {
                Caption = 'Addresses';
                group("Customer Address")
                {
                    Caption = 'Customer Address';
                    field(Address; Rec.Address)
                    {
                        ApplicationArea = All;
                        Editable = false;
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
                    field("Municipality Code"; Rec."Municipality Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Municipality Name"; Rec."Municipality Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("MZ"; Rec.MZ)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("MZ Name"; Rec."MZ Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Stroke No."; Rec."Stroke No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Customer String"; Rec."Customer String")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Zone Stroke No."; Rec."Zone Stroke No.")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Project. Route"; Rec."Project. Route")
                    {
                        ApplicationArea = All;
                        Visible = LocationRouteSpatialPlanVisible;
                    }
                }
                group("Delivery Address")
                {
                    Caption = 'Delivery Address';
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Street 2"; Rec."Street 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Street Name 2"; Rec."Street Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Street No. 2"; Rec."Street No. 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Municipality Code 2"; Rec."Municipality Code 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Municipality Name 2"; Rec."Municipality Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Post Code 2"; Rec."Post Code 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("City 2"; Rec."City 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("MZ 2"; Rec."MZ 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("MZ Name 2"; Rec."MZ Name 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Floor 2"; Rec."Floor 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Apartment No. 2"; Rec."Apartment No. 2")
                    {
                        ApplicationArea = All;
                    }
                    field("Stroke No. 2"; Rec."Stroke No. 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Customer String 2"; Rec."Customer String 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Zone Stroke No. 2"; Rec."Zone Stroke No. 2")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }

                }
                /* group("Bill to address")
                 {
                     Caption = 'Bill-to Address';

                     field("Bill-to Address"; "Bill-to Address")
                     {
                         Caption = 'Bill-to Address';
                     }

                 }*/

            }
            group("Request Data")
            {
                Caption = 'Request Data';
                field("CZK Request No."; Rec."CZK Request No.")
                {
                    ApplicationArea = All;
                    Visible = CZKRequestNoVisible;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        ReqCard: page "Request Card";
                        ServiceH: Record "Service Header";
                        ServiceHI: Record "Service Invoice Header";
                        ReqInvoiceCard: Page "Posted Service Invoice";
                    begin
                        ServiceH.reset;
                        ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
                        if ServiceH.findfirst then begin
                            ReqCard.SetTableView(ServiceH);
                            ReqCard.run;
                        end
                        else begin
                            ServiceHI.reset;
                            ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
                            if ServiceHI.findfirst then begin
                                ReqInvoiceCard.SetTableView(ServiceHI);
                                ReqInvoiceCard.run;

                            end;

                        end;
                    end;
                }

                field("CZK Date"; Rec."CZK Date")
                {
                    ApplicationArea = All;
                    Visible = CZKRequestNoVisibleEmpty;
                    Editable = false;
                }
                field("CZK Invoice Date"; "CZK Invoice Date")
                {
                    ApplicationArea = All;
                    Visible = CZKRequestNoVisibleEmpty2;
                    Editable = false;
                }




                //ovdje dodati status


                field("Reason For Service Order"; "Reason For Service Order") { Visible = true; }
                field("Remark For Service Order"; "Remark For Service Order") { Visible = true; }


                field("Holder of works"; "Holder of works") { Visible = OnlyGeneral; }
                field("Supervisory Board"; "Supervisory Board") { Visible = OnlyGeneral; }
                field("RN Source"; "RN Source") { Visible = true; }

                field("No. for Execution"; "No. for Execution") { Visible = WorkExecutionVisible; }
                field("Date for Execution"; "Date for Execution") { Visible = WorkExecutionVisible; }
                field("First view No."; "First view No.") { Visible = WorkExecutionVisible; }
                field("First view date"; "First view date") { Visible = WorkExecutionVisible; }

                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Visible = ProcessRequestActionVisible;
                }
                field("Posting No."; "Posting No.") { ApplicationArea = all; Visible = ProcessRequestActionVisible; }

                field("VAT Date"; "VAT Date") { ApplicationArea = all; Visible = ProcessRequestActionVisible; }

                field("Due Date"; "Due Date")
                {
                    ApplicationArea = all;
                }
                field("Request Department"; Rec."Request Department")
                {
                    ApplicationArea = All;
                }
                field("Request Department Name"; Rec."Request Department Name")
                {
                    ApplicationArea = All;
                }
                field(Sector; Sector) { }
                field("Sector Text"; "Sector Text") { }
                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = All;

                }
                field("Responsible Department Name"; Rec."Responsible Department Name")
                {
                    ApplicationArea = All;
                }
                field("Request Due Date"; Rec."Request Due Date")
                {
                    ApplicationArea = All;
                }

                field("Proforma Paid"; Rec."Proforma Paid")
                {
                    ApplicationArea = All;
                }
                field("Advance Created"; "Advance Created") { ApplicationArea = all; Visible = not CZKRequestNoVisible; }
                field("Advance No."; "Advance No.") { ApplicationArea = all; Visible = not CZKRequestNoVisible; }
                field("Credit Memo Created"; "Credit Memo Created") { ApplicationArea = all; Visible = not CZKRequestNoVisible; }

                field("Credit M.Advance No."; "Credit M.Advance No.") { ApplicationArea = all; Visible = not CZKRequestNoVisible; }
                field("Last DateTime Modified"; Rec."Last DateTime Modified")
                {
                    ApplicationArea = All;
                }

                field("Last Modified by User"; Rec."Last Modified by User")
                {
                    ApplicationArea = All;
                }

            }
            group("Request Reffering Data")
            {
                Visible = false;
                Caption = 'Request Refferring Data', Comment = 'Podaci o upućivanju zahtjeva';
                field("Request Sent to Sarajevogas"; Rec."Request Sent to Sarajevogas")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Request Sent to VIK"; Rec."Request Sent to VIK")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Request Sent to Toplane"; Rec."Request Sent to Toplane")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Request Sent to RAD"; Rec."Request Sent to RAD")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group("Work Execution Data")
            {
                Visible = WorkExecutionVisible;
                Caption = 'Work Execution Data', Comment = 'Podaci o izvođenju radova';
                field("UGI type"; "UGI type") { ApplicationArea = all; }
                field("Execution Company No."; Rec."Execution Company No.")
                {
                    ApplicationArea = All;
                }
                field("Execution Company Name"; Rec."Execution Company Name")
                {
                    ApplicationArea = All;
                }
                field("Execution Address"; Rec."Execution Address")
                {
                    ApplicationArea = All;
                }
                field("Contractor No"; "Contractor No") { ApplicationArea = all; Visible = false; }
                field("Execution Company Phone No."; Rec."Execution Company Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Work Execution Date"; Rec."Work Execution Date")
                {
                    ApplicationArea = All;
                }
                field("Planned W. Exec. Starting Date"; Rec."Planned W. Exec. Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Planned W. Exec. Ending Date"; Rec."Planned W. Exec. Ending Date")
                {
                    ApplicationArea = All;
                }
                field("PPZ for Building"; Rec."PPZ for Building")
                {
                    ApplicationArea = All;
                }
                field(Project2; Project)
                {
                    ApplicationArea = all;
                    Caption = 'Project';
                }

                field("Project Date"; "Project Date") { ApplicationArea = all; }
                field("G Size"; Rec."G Size")
                {
                    ApplicationArea = All;
                    Visible = false;
                    //ovdje veličina
                }
                field("G Gauge Size3"; "G Gauge Size")
                {
                    Caption = 'Gauge size';

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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

                        END;




                    end;


                }
                field(Vertical; Rec.Vertical)
                {
                    ApplicationArea = All;
                }
                field("Responsible Contact"; Rec."Responsible Contact")
                {
                    ApplicationArea = All;
                }
                field(Welder; Rec.Welder)
                {
                    ApplicationArea = All;
                }
                field("Welder Name"; Rec."Welder Name")
                {
                    ApplicationArea = All;
                }
                field("Press Conn. Tool"; Rec."Press Conn. Tool")
                {
                    ApplicationArea = All;
                }
                field("Execution Protocol No."; Rec."Execution Protocol No.")
                {
                    ApplicationArea = All;
                }
                field("Execution Protocol No. Text"; "Execution Protocol No. Text") { ApplicationArea = all; }
                field("According to Legislation"; Rec."According to Legislation")
                {
                    ApplicationArea = All;
                }
                field("Service Header UGI"; "Service Header UGI") { }
                field("Service Date UGI"; "Service Date UGI") { }
                field("Welder Atest"; Rec."Welder Atest")
                {
                    ApplicationArea = All;
                }

            }
            group("Worksite Data")
            {
                Visible = GeoWorkOrderVisible;
                Caption = 'Worksite Data', Comment = 'Podaci o radilištu';
                // field("GEO WorkPlaces Code"; "GEO WorkPlaces Code") { }
                //  field("GEO WorkPlaces"; "GEO WorkPlaces") { }
                field("Applied Investor"; "Applied Investor") { }
                field("Investor Code"; "Investor Code") { }
                field("Investor Name"; "Investor Name") { }
                field("Applied GEO WorkPlaces"; "Applied GEO WorkPlaces") { }
                field("GEO Constructor Manager"; "GEO Constructor Manager") { }
                field("GEO Constructor Manager Name"; "GEO Constructor Manager Name") { }

                /*   field("Activity Type"; Rec."Activity Type")
                   {
                       ApplicationArea = All;
                   }
                   field("Geo. Activity Type"; Rec."Geo. Activity Type")
                   {
                       ApplicationArea = All;
                   }*/
                field("ID Network"; Rec."ID Network")
                {
                    ApplicationArea = All;
                }
                field("ID Vertical"; Rec."ID Vertical")
                {
                    ApplicationArea = All;
                }
                field("Contact Geo"; "Contact Geo") { }

                field("Construction Manager"; "Construction Manager") { }

                field("Construction Manager Name"; "Construction Manager Name") { }

            }

            ///samo kancelarijski
            // dodana izmjena i kancelarijski i opšti
            group("Worksite Data2")
            {
                Visible = IsVisible;
                //Visible = GeoWorkOrderVisibleOffice;
                Caption = 'Worksite Data', Comment = 'Podaci o predmetu';
                field("GEO WorkPlaces Code2"; "GEO WorkPlaces Code") { }
                field("GEO WorkPlaces2"; "GEO WorkPlaces") { }

                /*   field("Activity Type"; Rec."Activity Type")
                   {
                       ApplicationArea = All;
                   }
                   field("Geo. Activity Type"; Rec."Geo. Activity Type")
                   {
                       ApplicationArea = All;
                   }*/

            }

            //kraj
            group("Work Order Data")
            {
                Visible = OnlyGeneral;
                Caption = 'Work Order Data', Comment = 'Podaci o radnog nalogu';

                field("Request Group"; Rec."Request Group")
                {
                    ApplicationArea = All;
                    Visible = OnlyGeneral;
                }
                field("Worksite Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Visible = OnlyGeneral;
                }

                field("Work Order Type"; Rec."Work Order Type")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Date of ticket"; "Date of ticket") { }
                field("Time of ticket"; "Time of ticket") { }
                field("Date of sender"; "Date of sender") { }
                field("Time of sender"; "Time of sender") { }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time"; "Starting Time") { }
                field("Finishing Date"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                }
                field("Finishing Time"; "Finishing Time") { }
                field("Work Order Due Date"; Rec."Work Order Due Date")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No."; Rec."Work Order Registry No.")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No. letter"; "Work Order Registry No. letter") { }
                field("Work Order Requester"; Rec."Work Order Requester")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Activity; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Caption = 'Activity'; //vrste radova za geodete
                    Visible = OnlyGeneral;
                }
                field("Geo. Activity Type"; "Geo. Activity Type")
                {
                    ApplicationArea = all; //vrste godetskih radova
                    Visible = GeoWorkOrderVisible;
                }

                field("Sent to ZIK GEO"; "Sent to ZIK GEO") { Visible = GeoWorkOrderVisibleOffice; }
                field("Received from ZIK GEO"; "Received from ZIK GEO") { Visible = GeoWorkOrderVisibleOffice; }

                field("Work Order Request No."; Rec."Work Order Request No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Order Requeste Date"; Rec."Work Order Request Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Time"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Work Order Emergency"; Rec."Work Order Emergency")
                {
                    ApplicationArea = All;
                    Visible = OnlyGeneral;
                }
                field(Excavation; Rec.Excavation)
                {
                    ApplicationArea = All;
                    Visible = OnlyGeneral;
                }
                field("Type of Investition"; "Type of Investition")
                {
                    ApplicationArea = ALL;
                    /* TableRelation = InvestitionTable.Code;*/
                }

                /*   field("Type of Invest. Description"; "Type of Invest. Description")
                   {
                       ApplicationArea = All;
                       Editable = false;
                   }*/
            }

            //kancelarijski 
            group("Work Order Data2")
            {
                Visible = GeoWorkOrderVisibleOffice;
                Caption = 'Work Order Data', Comment = 'Podaci o radnog nalogu';
                field("Work Order Type2"; Rec."Work Order Type")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field("Starting Date2"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time2"; "Starting Time") { }
                field("Finishing Date2"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                }
                field("Finishing Time2"; "Finishing Time") { }
                field("Implementation Time"; "Implementation Time")
                {
                    ApplicationArea = All;
                }
                field("Work Order Due Date2"; Rec."Work Order Due Date")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No.2"; Rec."Work Order Registry No.")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No. letter2"; "Work Order Registry No. letter") { }
                field("Work Order Requester2"; Rec."Work Order Requester")
                {
                    ApplicationArea = All;
                    Visible = False;
                }
                field(Activity2; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Caption = 'Activity'; //vrste radova za geodete

                }
                field("Geo. Activity Type2"; "Geo. Activity Type")
                {
                    ApplicationArea = all; //vrste godetskih radova
                }
                field("Request Group2"; Rec."Request Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Order Request No.2"; Rec."Work Order Request No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Order Requeste Date2"; Rec."Work Order Request Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Time2"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Work Order Emergency2"; Rec."Work Order Emergency")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Excavation2; Rec.Excavation)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Worksite Activity Type2"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Visible = FalsE;
                }
            }

            group("Work Order DataGeo")
            {
                Visible = GeoWorkOrderVisible;
                Caption = 'Work Order Data', Comment = 'Podaci o radnog nalogu';

                field("Starting Date3"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Starting Time3"; "Starting Time") { }
                field("Finishing Date3"; Rec."Finishing Date")
                {
                    ApplicationArea = All;
                }
                field("Finishing Time3"; "Finishing Time") { }
                field("Work Order Due Date3"; Rec."Work Order Due Date")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No.3"; Rec."Work Order Registry No.")
                {
                    ApplicationArea = All;
                }
                field("Work Order Registry No. letter3"; "Work Order Registry No. letter") { }
                field("Work Order Requester3"; Rec."Work Order Requester")
                {
                    ApplicationArea = All;
                    Visible = False;
                }

                field("Request Group5"; Rec."Request Group")
                {
                    ApplicationArea = All;
                    Visible = GeoWorkOrderVisible;
                }

                field(Activity3; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Caption = 'Activity'; //vrste radova za geodete

                }
                field("Geo. Activity Type3"; "Geo. Activity Type")
                {
                    ApplicationArea = all; //vrste godetskih radova
                }
                //field("Contact Geo"; "Contact Geo") { }

                // field("Construction Manager"; "Construction Manager") { }

                //field("Construction Manager Name"; "Construction Manager Name") { }
                field("Request Group3"; Rec."Request Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Order Request No.3"; Rec."Work Order Request No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Work Order Requeste Date3"; Rec."Work Order Request Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Order Time3"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Work Order Emergency3"; Rec."Work Order Emergency")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Excavation3; Rec.Excavation)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Worksite Activity Type3"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                    Visible = FalsE;
                }
            }

            group("UGI Data")
            {
                Visible = false;
                Caption = 'UGI Data', Comment = 'Podaci o UGI';
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                }
                field(Grouping; Rec.Grouping)
                {
                    ApplicationArea = All;
                }
                field("IKP Realisation"; Rec."IKP Realisation")
                {
                    ApplicationArea = All;
                }
                field(Deadline; Rec.Deadline)
                {
                    ApplicationArea = All;
                }
                field("Realisation in Days"; Rec."Realisation in Days")
                {
                    ApplicationArea = All;
                }
                field(Dued; Rec.Dued)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateRest();
                    end;
                }
                field(Realized; Rec.Realized)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CalculateRest();
                    end;
                }
                field("Rest"; Rest)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Realization Date"; Rec."Realisation Date")
                {
                    ApplicationArea = All;
                }

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

            }

            group("Marking Data")
            {
                Visible = GeoWorkOrderVisible;
                Caption = 'Routing Data', Comment = 'Podaci o obilježavanju';
                field("Marking Done"; Rec."Marking Done")
                {
                    Caption = 'Marking Finished', Comment = 'Obilježavanje završeno';
                    ApplicationArea = All;
                }
                field("Marking Method 2"; Rec."Marking Method 2")
                {
                    ApplicationArea = All;
                }
                field("Marking DGM Total Length 2"; Rec."Marking DGM Total Length")
                {
                    ApplicationArea = All;
                }
                field("Marking PG Total Length 2"; Rec."Marking PG Total Length")
                {
                    ApplicationArea = All;
                }
                field("Marking No. of Connections 2"; Rec."Marking No. of Connections")
                {
                    ApplicationArea = All;
                }
                field("Marking Fully Done"; Rec."Marking Fully Done")
                {
                    Caption = 'Marking Fully Finished', Comment = 'Obilježavanje završeno u cijelosti';
                    ApplicationArea = All;
                }
                field("Marking Start Date 2"; Rec."Marking Start Date - 2")
                {
                    Caption = 'Marking Start Date', Comment = 'Vrijeme početka obilježavanja';
                    ApplicationArea = All;
                }
                field("Marking End Date 2"; Rec."Marking End Date 2")
                {
                    Caption = 'Marking End Date', Comment = 'Vrijeme završetka obilježavanja';
                    ApplicationArea = All;
                }

            }


            group("Routing Data")
            {
                Visible = GeoWorkOrderVisible;
                Caption = 'Routing Data', Comment = 'Podaci o trasiranju';
                field("Marking Finished"; Rec."Marking Finished")
                {
                    Caption = 'Marking Finished', Comment = 'Obilježavanje završeno';
                    ApplicationArea = All;
                }
                field("Mark Method"; Rec."Mark Method")
                {
                    ApplicationArea = All;
                }

                field("Marking DGM Total Length"; Rec."Mark DGM Total Length")
                {
                    ApplicationArea = All;
                }
                field("Marking PG Total Length"; Rec."Mark PG Total Length")
                {
                    ApplicationArea = All;
                }
                field("Marking No. of Connections"; Rec."Mark No. of Connections")
                {
                    ApplicationArea = All;
                }
                field("Marking Fully Finished"; Rec."Marking Fully Finished")
                {
                    Caption = 'Marking Fully Finished', Comment = 'Obilježavanje završeno u cijelosti';
                    ApplicationArea = All;
                }
                field("Marking Start Date"; Rec."Marking Start Date")
                {
                    Caption = 'Marking Start Date', Comment = 'Vrijeme početka obilježavanja';
                    ApplicationArea = All;
                }
                field("Marking End Date"; Rec."Marking End Date")
                {
                    Caption = 'Marking End Date', Comment = 'Vrijeme završetka obilježavanja';
                    ApplicationArea = All;
                }

            }
            group("Recording Data")
            {
                Visible = GeoWorkOrderVisible;
                Caption = 'Recording Data', Comment = 'Podaci o snimanju';
                field("Recording Finished"; Rec."Recording/Marking Finished")
                {
                    Caption = 'Recording Finished', Comment = 'Snimanje završeno';
                    ApplicationArea = All;
                }
                field("Recording Method"; Rec."Recording Method")
                {
                    ApplicationArea = All;
                }
                field("DGM Total Length"; Rec."DGM Total Length")
                {
                    ApplicationArea = All;
                }
                field("PG Total Length"; Rec."PG Total Length")
                {
                    ApplicationArea = All;
                }
                field("Recording No. of Connections"; Rec."No. of Connections")
                {
                    ApplicationArea = All;
                }
                field("No. of Objects"; Rec."No. of Objects")
                {
                    ApplicationArea = All;
                }
                field("No. of Cutting"; Rec."No. of Cutting")
                {
                    ApplicationArea = All;
                }
                field("Folder yes"; "Folder yes") { ApplicationArea = All; }
                field("Pipeline Recording"; Rec."Pipeline Recording")
                {
                    ApplicationArea = All;
                }
                field("Recording Fully Finished"; Rec."Rec/Marking Fully Finished")
                {
                    Caption = 'Recording Fully Finished', Comment = 'Snimanje završeno u cijelosti';
                    ApplicationArea = All;
                }
                field("Recording Start Date"; Rec."Rec/Marking Start Date")
                {
                    Caption = 'Recording Start Date', Comment = 'Vrijeme početka snimanja';
                    ApplicationArea = All;
                }
                field("Recording End Date"; Rec."Rec/Marking End Date")
                {
                    Caption = 'Recording End Date', Comment = 'Vrijeme završetka snimanja';
                    ApplicationArea = All;
                }
            }

            //obilježavanje 


            group("Owner Data")
            {
                Caption = 'Owner Data';
                field("Owner is Customer"; "Owner is Customer") { ApplicationArea = all; Visible = false; }

                field("Owner No."; Rec."Owner No.")
                {
                    ApplicationArea = All;
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                }
                field("Owner Address"; Rec."Owner Address")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner Municipality Code"; Rec."Owner Municipality Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner Municipality Name"; Rec."Owner Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("Owner MZ"; Rec."Owner MZ")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Owner MZ Name"; Rec."Owner MZ Name")
                {
                    ApplicationArea = All;
                }
                field("Owner Street"; Rec."Owner Street")
                {
                    ApplicationArea = All;
                }
                field("Owner Street Name"; Rec."Owner Street Name")
                {
                    ApplicationArea = All;
                }
                field("Owner Street No."; Rec."Owner Street No.")
                {
                    ApplicationArea = All;
                }
                field("Previous Gas"; Rec."Previous Gas")
                {
                    ApplicationArea = All;
                }
                field(Heating; Rec.Heating)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("EU Activity"; Rec."EU Activity")
                {
                    ApplicationArea = All;
                }
                field("Area Dimension"; Rec."Area Dimension")
                {
                    ApplicationArea = All;
                }
                field("kW Power"; Rec."kW Power")
                {
                    ApplicationArea = All;
                }
                field("Number of Floors"; Rec."Number of Floors")
                {
                    Visible = InformationOnConnectionVisible;
                }
                field(Land; Rec.Land)
                {
                    ApplicationArea = All;
                    Visible = not ProcessRequestActionVisible;
                }
                field(NC; NC)
                {
                    ApplicationArea = All;
                    Visible = not ProcessRequestActionVisible;
                }
                field("Catastral Municipality"; "Catastral Municipality")
                {
                    DrillDownPageId = 50140;
                    LookupPageId = 50140;
                    Visible = false;

                    //                    Visible = false;
                }
                field("Catastral Municipality Name"; "Catastral Municipality Name")
                {
                    DrillDownPageId = 50140;
                    LookupPageId = 50140;
                    Visible = false;
                    //                  Visible = false;
                }
            }
            group("El. Accordance")
            {
                Caption = 'El. Accordance', Comment = 'UGI Projekat i el. saglasnost';
                Visible = ElAccordanceVisible;

                field("Information Number"; Rec."Information Number")
                {
                    ApplicationArea = All;
                    Visible = ElAccordanceVisible;
                    DrillDown = true;

                    trigger OnDrillDown()
                    var
                        SH: Record "Service Header";
                        SIH: Record "Service Invoice Header";
                    begin
                        if Rec."Information Number" <> '' then begin
                            if Rec."Source Table Inf Number" = Format(DATABASE::"Service Header") then begin
                                SH.Reset();
                                SH.SetRange("No.", Rec."Information Number");
                                Page.Run(Page::"Request Card", SH);
                            end else
                                if Rec."Source Table Inf Number" = Format(DATABASE::"Service Invoice Header") then begin
                                    SIH.Reset();
                                    SIH.SetRange("No.", Rec."Information Number");
                                    Page.Run(Page::"Posted Service Invoice", SIH);
                                end;
                        end;
                    end;
                }
                field("SGPO Date El. Installation"; Rec."SGPO Date El. Installation")
                {
                    ApplicationArea = All;
                }


                field("Employee Responsible El. Accordance"; Rec."Employee Responsible")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnValidate()
                    begin
                        GetEmployeeResponsibleFullName();
                    end;
                }
                field(EmployeeResponsibleNameElAccordance; EmployeeResponsibleName)
                {
                    Caption = 'Employee Responsible Name', Comment = 'Ime zaposlenika';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Pickup Date"; Rec."Pickup Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Realization Date El. Acc."; Rec."Realisation Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Accord No."; Rec."Accord No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. of Project Accordances"; Rec."No. of Project Accordances")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No. of El. Accord. per Project"; Rec."No. of El. Accord. per Project")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Firefight Accordance"; Rec."Firefight Accordance")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        COntact: Record Contact;
                        PageC: page "Contact List";
                        usSetup: record "User setup";

                    begin
                        Commit();

                        usSetup.reset;
                        usSetup.setfilter("User ID", '%1', UserId);
                        if usSetup.FindFirst() then begin
                            usSetup."Type Relation" := usSetup."Type Relation"::PPZ;
                            usSetup.Modify();
                        end;
                        Commit();
                        clear(PageC);
                        COntact.reset;
                        COntact.SetFilter("Type Relation", '%1', COntact."Type Relation"::PPZ);
                        PageC.SetTableView(COntact);


                        PageC.LOOKUPMODE(TRUE);
                        IF PageC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PageC.GETRECORD(COntact);
                            "Firefight Accordance" := COntact."Name";

                        end;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        COntact: Record Contact;
                        PageC: page "Contact List";
                        usSetup: record "User Setup";
                    begin
                        Commit();
                        usSetup.reset;
                        usSetup.setfilter("User ID", '%1', UserId);
                        if usSetup.FindFirst() then begin
                            usSetup."Type Relation" := usSetup."Type Relation"::PPZ;
                            usSetup.Modify();
                        end;
                        Commit();
                        clear(PageC);
                        COntact.reset;
                        COntact.SetFilter("Type Relation", '%1', COntact."Type Relation"::PPZ);
                        PageC.SetTableView(COntact);


                        PageC.LOOKUPMODE(TRUE);
                        IF PageC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PageC.GETRECORD(COntact);
                            "Firefight Accordance" := COntact."Name";

                        end;
                    end;
                }
                field("Firefight Accordance No."; "Firefight Accordance No.") { }
                field("SGPO Date Fire Protection"; Rec."SGPO Date Fire Protection")
                {
                    ApplicationArea = All;
                }

                field("El. Accordance Date"; Rec."El. Accordance Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Project Accordance Date"; Rec."Project Accordance Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("UGI Project Name"; Rec."UGI Project Name")
                {
                    ApplicationArea = All;
                }
                field("UGI Project Creation Date"; Rec."UGI Project Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Connection to"; "Connection to")
                {

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if "Connection to" = "Connection to"::"Distribution gas line" then begin
                            Rec."Service Line Diameter" := '';
                            ServiceLineDiameterEditability := false;
                        end
                        else begin
                            ServiceLineDiameterEditability := true;
                        end;
                    end;
                }
                field("Measure Point Pressure1"; "Measure Point Pressure1") { }
                field("Service Line Diameter"; Rec."Service Line Diameter")
                {
                    ApplicationArea = All;
                    Editable = ServiceLineDiameterEditability;

                }
                field("DGM Diameter"; Rec."DGM Diameter")
                {
                    ApplicationArea = All;
                }
                field("kW Power el. Accordance"; Rec."kW Power")
                {
                    ApplicationArea = All;
                }
                field("G Gauge Size"; Rec."G Gauge Size")
                {
                    ApplicationArea = All;
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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

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

                            rec."G Gauge Size" := GSize.Description;
                            rec."Measuring Area 1" := GSize."Measuring Area 1";
                            rec."Measuring Area 2" := GSize."Measuring Area 2";

                        END;




                    end;


                }
                field("Measuring Area 1"; "Measuring Area 1") { }
                field("Measuring Area 2"; "Measuring Area 2") { }
                field("Measure Point Pressure"; Rec."Measure Point Pressure")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                    Lookup = true;


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        PressureP: page Pressure;
                        PressureT: Record "Types Of Diseases";
                    begin

                        PressureP.LOOKUPMODE(TRUE);
                        IF PressureP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PressureP.GETRECORD(PressureT);
                            "Measure Point Pressure" := PressureT."Description";



                        end;
                    END;



                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        PressureP: page "Pressure";
                        PressureT: Record "Types Of Diseases";
                    begin

                        PressureP.LOOKUPMODE(TRUE);
                        IF PressureP.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PressureP.GETRECORD(PressureT);
                            "Measure Point Pressure" := PressureT."Description";


                        end;
                    END;



                }

                field("Design Company"; Rec."Design Company")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        COntact: Record Contact;
                        PageC: page "Contact List";
                        usSetup: record "User Setup";

                    begin
                        Commit();
                        usSetup.reset;
                        usSetup.setfilter("User ID", '%1', UserId);
                        if usSetup.FindFirst() then begin
                            usSetup."Type Relation" := usSetup."Type Relation"::Designer;
                            usSetup.Modify();
                        end;
                        Commit();
                        clear(PageC);
                        COntact.reset;
                        COntact.SetFilter("Type Relation", '%1', COntact."Type Relation"::Designer);
                        PageC.SetTableView(COntact);


                        PageC.LOOKUPMODE(TRUE);
                        IF PageC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PageC.GETRECORD(COntact);
                            "Design Company" := COntact."Name";

                        end;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        COntact: Record Contact;
                        PageC: page "Contact List";
                        usSetup: record "User Setup";
                    begin
                        Commit();
                        usSetup.reset;
                        usSetup.setfilter("User ID", '%1', UserId);
                        if usSetup.FindFirst() then begin
                            usSetup."Type Relation" := usSetup."Type Relation"::PPZ;
                            usSetup.Modify();
                        end;
                        Commit();
                        clear(PageC);
                        COntact.reset;
                        COntact.SetFilter("Type Relation", '%1', COntact."Type Relation"::Designer);
                        PageC.SetTableView(COntact);


                        PageC.LOOKUPMODE(TRUE);
                        IF PageC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            PageC.GETRECORD(COntact);
                            "Design Company" := COntact."Name";

                        end;
                    end;
                }
                field("Project Accordance"; Rec."Project Accordance")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Chimney Expert Opinion"; Rec."Chimney Expert Opinion")
                {
                    ApplicationArea = All;
                    Visible = ElAccordanceVisible;
                    // Visible = false;
                }
                field("Chimney Expert Date"; "Chimney Expert Date") { Visible = ElAccordanceVisible; }
            }
            part("GEO part"; "GEO Part")
            {
                //Visible = GeoGlobal;
                Visible = IsGeoPartVisible;
                subpagelink = "Document Type" = field("Document Type"), "Document No." = field("No.");


            }

            part("GEO part2"; "GEO Part 2")
            {

                Caption = 'Workers';
                Visible = OnlyGeneral;
                subpagelink = "Document Type" = field("Document Type"), "Document No." = field("No.");

            }
            //
            //Service Item Worksheet Subform

            part("Material\Resource RN"; "Service Item Worksheet Subform")
            {

                Caption = 'Material RN';
                Visible = OnlyGeneral;
                subpagelink = "Document Type" = field("Document Type"), "Document No." = field("No."), "Internal Employees" = filter(false);
            }


            //obilježavanje, trasiranje, snimanje


            group(Material)
            {
                Visible = GeoWorkOrderVisible;
                caption
            = 'Material';

                group(O)
                {
                    caption = 'O';
                    Visible = GeoWorkOrderVisible;
                    field("Spray -O"; "Spray -O") { }
                    field("Harpoon -O"; "Harpoon -O") { }
                    field("Bolcna -O"; "Bolcna -O") { }
                    field("Palette -O"; "Palette -O") { }

                }


                group(T)
                {
                    caption = 'Routing';

                    field(Spray; Spray) { }
                    field(Harpoon; Harpoon) { }
                    field(Bolcna; Bolcna) { }
                    field(Palette; Palette) { }


                }
                group(Record)
                {
                    caption = 'Recording';
                    Visible = GeoWorkOrderVisible;
                    field("Spray -R"; "Spray -R") { }
                    field("Harpoon -R"; "Harpoon -R") { }
                    field("Bolcna -R"; "Bolcna -R") { }
                    field("Palette -R"; "Palette -R") { }

                }




            }

            group(Used_equipment_O)
            {
                Visible = GeoWorkOrderVisible;
                caption = 'Used equipment (O)';

                group(InstrumentO)
                {
                    caption = 'Instrument';
                    field("Trimble M3-O"; "Trimble M3 -O") { }
                    field("Sokkia SET2030-O"; "Sokkia SET2030 -O") { }
                    field("Zeiss REC ELTA 15 -O"; "Zeiss REC ELTA 15 -O") { }
                    field("GPS L1 - Promark 3 -O"; "GPS L1 - Promark 3 -O") { }
                    field("GPS - Others -O"; "GPS - Others - O") { }
                    field("GPS TRIMBLE R8S -O"; "GPS TRIMBLE R8S -O") { }
                    field("TRIMBLE C5 -O"; "TRIMBLE C5 -O") { }
                    field("GPS Tersus"; "GPS Tersus")

                    {
                    }
                    field("Topcon OS 201"; "Topcon OS 201") { }
                }
                group(Prism_carrierO)
                {
                    Caption = 'Prism carrier';
                    field("Sokkia 5 m-O"; "Sokkia 5 m -O") { }
                    field("Sokkia 3.8 m-O"; "Sokkia 3.8 m -O") { }
                    field("Sokkia 2.7 m-O"; "Sokkia 2.7 m -O") { }
                    field("Wild 2.15 m-O"; "Wild 2.15 m -O") { }
                    field("Topcon 2.15m (T)"; "Topcon 2.15m (T)") { }





                }
                group(PrismO)
                {
                    caption = 'Prism';
                    field("Sokkia 1x-O"; "Sokkia 1x-O") { }
                    field("Zeiss 3x-O"; "Zeiss 3x -O") { }
                    field("Zeiss 1x-O"; "Zeiss 1x-O") { }
                    field("Wild 1x-O"; "Wild 1x-O") { }
                    field("Topcon 1x (T)"; "Topcon 1x (T)") { }

                }
                group(RibbonO)
                {
                    Caption = 'Ribbon';
                    field("50 m-O"; "50 m-O") { }
                    field("30 m-O"; "30 m-O") { }
                    field("20 m-O"; "20 m-O") { }
                    field("Leica Disto-O"; "Leica Disto-O") { }
                }
                field("Accessories for Centering-O"; "Accessories for Centering-O") { }

            }




            //snimanje


            group(Used_equipment)
            {
                Visible = GeoWorkOrderVisible;
                caption = 'Used equipment';

                group(Instrument)
                {
                    caption = 'Instrument';
                    field("Trimble M3"; "Trimble M3") { }
                    field("Sokkia SET2030"; "Sokkia SET2030") { }
                    field("Zeiss REC ELTA 15"; "Zeiss REC ELTA 15") { }
                    field("GPS L1 - Promark 3"; "GPS L1 - Promark 3") { }
                    field("GPS - Others"; "GPS - Others") { }
                    field("GPS TRIMBLE R8S"; "GPS TRIMBLE R8S") { }
                    field("TRIMBLE C5"; "TRIMBLE C5") { }
                    field("GPS Tersus (T)"; "GPS Tersus (T)") { }
                    field("Topcon OS 201 (T)"; "Topcon OS 201 (T)") { }
                }
                group(Prism_carrier)
                {
                    Caption = 'Prism carrier';
                    field("Sokkia 5 m"; "Sokkia 5 m") { }
                    field("Sokkia 3.8 m"; "Sokkia 3.8 m") { }
                    field("Sokkia 2.7 m"; "Sokkia 2.7 m") { }
                    field("Wild 2.15 m"; "Wild 2.15 m") { }
                    field("Topcon 2.15m"; "Topcon 2.15m") { }





                }
                group(Prism)
                {
                    Visible = GeoWorkOrderVisible;
                    caption = 'Prism';
                    field("Sokkia 1x"; "Sokkia 1x") { }
                    field("Zeiss 3x"; "Zeiss 3x") { }
                    field("Zeiss 1x"; "Zeiss 1x") { }
                    field("Wild 1x"; "Wild 1x") { }
                    field("Topcon 1x"; "Topcon 1x") { }

                }
                group(Ribbon)
                {
                    Visible = GeoWorkOrderVisible;
                    Caption = 'Ribbon';
                    field("50 m"; "50 m") { }
                    field("30 m"; "30 m") { }
                    field("20 m"; "20 m") { }
                    field("Leica Disto"; "Leica Disto") { }
                }
                field("Accessories for Centering"; "Accessories for Centering") { Visible = GeoWorkOrderVisible; }

            }
            group(Used_equipment_R)
            {
                Visible = GeoWorkOrderVisible;
                caption = 'Used equipment (S)';

                group(InstrumentS)
                {
                    caption = 'Instrument';
                    field("Trimble M3-R"; "Trimble M3 -R") { }
                    field("Sokkia SET2030-R"; "Sokkia SET2030 -R") { }
                    field("Zeiss REC ELTA 15 -R"; "Zeiss REC ELTA 15 -R") { }
                    field("GPS L1 - Promark 3 -R"; "GPS L1 - Promark 3 -R") { }
                    field("GPS - Others -R"; "GPS - Others - R") { }
                    field("GPS TRIMBLE R8S -R"; "GPS TRIMBLE R8S -R") { }
                    field("TRIMBLE C5 -R"; "TRIMBLE C5 -R") { }

                    field("GPS Tersus (S)"; "GPS Tersus (S)") { }
                    field("Topcon OS 201 (S)"; "Topcon OS 201 (S)") { }
                }
                group(Prism_carrierR)
                {
                    Caption = 'Prism carrier';
                    field("Sokkia 5 m-R"; "Sokkia 5 m -R") { }
                    field("Sokkia 3.8 m-R"; "Sokkia 3.8 m -R") { }
                    field("Sokkia 2.7 m-R"; "Sokkia 2.7 m -R") { }
                    field("Wild 2.15 m-R"; "Wild 2.15 m -R") { }
                    field("Topcon 2.15m (S)"; "Topcon 2.15m (S)") { }





                }
                group(PrismR)
                {
                    caption = 'Prism';
                    field("Sokkia 1x-R"; "Sokkia 1x-R") { }
                    field("Zeiss 3x-R"; "Zeiss 3x -R") { }
                    field("Zeiss 1x-R"; "Zeiss 1x-R") { }
                    field("Wild 1x-R"; "Wild 1x-R") { }
                    field("Topcon 1x (S)"; "Topcon 1x (S)") { }

                }
                group(RibbonR)
                {
                    Caption = 'Ribbon';
                    field("50 m-R"; "50 m-R") { }
                    field("30 m-R"; "30 m-R") { }
                    field("20 m-R"; "20 m-R") { }
                    field("Leica Disto-R"; "Leica Disto-R") { }
                }
                field("Accessories for Centering-R"; "Accessories for Centering-R") { }

            }

            //
            part("Measure Points List"; "Request Card SubPage")
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"), "Document No." = field("No.");



            }

            part("Gas Appliance List"; "Gas Appliances Subform")
            {
                Visible = ElAccordanceVisible;
                ApplicationArea = All;
                Provider = "Measure Points List";
                SubPageLink = "Measure Point No." = field("Service Item No."), "Gas Install. Data Entry No." = const(0), "Document No." = field("Document No.");
            }


        }
        area(FactBoxes)
        {
            part("Attached Documents"; "Document Att. Det. FactBox")
            {
                Visible = AttachedDocumentsFactBoxVisible;
                ApplicationArea = All;

                Caption = 'Attachments';
                Provider = "Measure Points List";
                Editable = True;

                SubPageLink = "Table ID" = CONST(5901),
                              "No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No."), Information = filter(false), Archived = filter(false);

            }
            part("Attached Documents2"; "Document Att. Det. FactBox")
            {
                Visible = AttachedDocumentsFactBoxVisible2;
                ApplicationArea = All;

                Caption = 'Attachments';
                Provider = "Measure Points List";
                Editable = True;

                SubPageLink = "Table ID" = CONST(5901),
                              "No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No."), Information = filter(true), Archived = filter(false);

            }
            part("Attached Documents3"; "Document Att. Det. FactBox")
            {
                Visible = ElAccordanceVisible;
                ApplicationArea = All;

                Caption = 'Attachments';
                Provider = "Measure Points List";
                Editable = True;

                SubPageLink = "Table ID" = CONST(5901),
                              "No." = FIELD("Document No."),
                              Information = filter(true),
                              Archived = filteR(false), Archived = filter(false);

            }
            part("Request Work Orders"; "Request Work Orders FactBox")
            {
                Visible = GeneralAll;
                ApplicationArea = All;

                Caption = 'Request Work Orders', Comment = 'Radni nalozi zahtjeva';
                SubPageLink = "Document Type" = Const(Order), "Request Type" = filter("General Work Order" | "General Geo. Work Order" | "General Geo. Work Order Office"), "CZK Request No." = field("No.");
            }
            part("Attached Documents8"; "Document Att. Det. FactBox")
            {
                Visible = WorkExecutionRequestGWO;
                ApplicationArea = All;

                Caption = 'Attachments';
                Provider = "Measure Points List";
                Editable = True;

                SubPageLink = "Table ID" = CONST(5901),
                                "No." = FIELD("Document No."), Archived = filter(false);

            }


            part("Request Work Orders2"; "Request Work Orders FactBox")
            {

                ApplicationArea = All;
                Visible = false;
                Caption = 'Request Work Orders', Comment = 'Radni nalozi zahtjeva';
                SubPageLink = "Document Type" = Const(Order), "Request Type" = filter("General Work Order" | "General Geo. Work Order" | "General Geo. Work Order Office"), "CZK Request No." = field("CZK Request No.");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Customer No.");
            }
            part("Service Item Line FactBox"; "Service Item Line FactBox")
            {
                ApplicationArea = All;
                Provider = "Measure Points List";
                SubPageLink = "Document Type" = field("Document Type"),
                "Document No." = field("Document No."),
                "Line No." = field("Line No.");
            }

            part("Attached Documents_req"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Visible = VisibleE;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5900),
                              "No." = FIELD("No.");
            }

            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Process Request")
            {
                Visible = ProcessRequestActionVisible;
                Caption = 'Process Request', Comment = 'Obrada zahtjeva';
                ApplicationArea = All;
                Image = Process;
                Promoted = true;

                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    DocumentAttachment: Record "Document Attachment";
                    SHInsert: Record "Status History 2";
                    Text007: Label 'Required fields must be filled in. Please check the list of required fields!';
                    SHLastMM: Record "Status History 2";
                begin
                    /*
                    "Table ID" = CONST(5901),
                              "No." = FIELD("Document No."),
                              "Line No." = FIELD("Line No."), Information = filter(false);*/

                    DocumentAttachment.reset;
                    DocumentAttachment.setfilter("Table ID", '%1', 5901);
                    DocumentAttachment.setfilter("No.", '%1', "No.");
                    //   DocumentAttachment.setfilter("Line No.", '%1', "Line No.");
                    DocumentAttachment.setfilter("Information", '%1', false);
                    DocumentAttachment.setfilter(Mandatory, '%1', true);
                    DocumentAttachment.setfilter(Delivered, '%1|%2', DocumentAttachment.Delivered::Empty, DocumentAttachment.Delivered::No);
                    if DocumentAttachment.findfirst then
                        error(Text007);
                    Rec.ProcessRequest();//has commit


                    TestField("Customer No.");

                    //ako nema statusa
                    SHInsert.Reset();
                    SHInsert.setfilter("Source Table", '%1', 5900);
                    SHInsert.setfilter("Request No.", '%1', rec."No.");
                    SHInsert.setfilter("Request Type", '%1', rec."Request Type");
                    SHInsert.setfilter("Information of processing", '%1', SHInsert."Information of processing"::Forwarding);
                    if not SHInsert.FindFirst() then begin
                        SHInsert.init;
                        SHInsert.validate("Source Table", 5900);
                        SHInsert.validate("Request No.", rec."No.");
                        SHInsert.Validate("Request Type", rec."Request Type");
                        SHInsert.validate("Information of processing", SHInsert."Information of processing"::"Forwarding");
                        SHInsert.validate(Active, true);
                        SHInsert.validate("Insert Date and Time", CurrentDateTime);
                        SHInsert.validate("Insert User ID", userid);


                        SHLastMM.Reset();
                        SHLastMM.SetFilter("Request No.", rec."No.");
                        SHLastMM.SetCurrentKey(Integer);
                        SHLastMM.Ascending;
                        if SHLastMM.FindLast() then
                            SHInsert.Integer := SHLastMM.Integer + 1
                        else
                            SHInsert.Integer := 1;

                        SHInsert.insert(true);

                    end;
                end;
            }
            action("Profaktura")
            {
                ApplicationArea = All;
                Caption = 'Profaktura';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var
                    CRL: record "Custom Report Layout";
                    RLS: record "Report Layout Selection";
                begin
                    if confirm('Da li želite automatski da ažurirate datum knjiženja na danas?') then begin

                        rec."Due Date" := calcdate('<+15D>', Today);
                        rec."VAT Date" := today;
                        Rec.Modify();
                    end;


                    ServiceInvoice.SetParam(Rec."No.");
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50147);
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);

                        ServiceInvoice.Run();

                    end;
                end;
            }

            action(CreateAdvance)
            {

                ApplicationArea = All;
                Caption = 'Create Advance';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var

                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    CustomerPrepayment: Record Customer;
                    CustLedger: Record "Cust. Ledger Entry";
                    SalesHeaderAdvance: Record "Sales Header";
                    SalesSetup: Record "Sales & Receivables Setup";
                    PostinD: date;
                    CustTemp: Record "Customer Templ.";
                    SalesLine: Record "Sales Line";
                    SalesAdvance: page "Sales Advance Invoice";
                    PostedSalesAdvance: record "Sales Invoice Header";
                    PostedSalesInvoiceLIne: record "Sales Invoice Line";
                    AbsFill: Codeunit "Absence Fill";
                    FirstDate: Date;
                    LastDate: date;
                    CurrentDate: date;
                    SalesHeader: Record "Sales Header";
                    CustmerPrep: Record Customer;
                    CJL: Record "Calculation Journal Line";
                    CurrentDateCredit: Date;
                    SifraNew: code[20];
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    DetailedCust: Record "Detailed Cust. Ledg. Entry";
                    RecRef: RecordRef;
                    RecordRefExample: Codeunit "Modiy Permissions";
                    EntryLast: Integer;
                    ServiceItemLine: Record "Service Line";
                    SumValue: decimal;
                    US: record "User Setup";
                    RelationShip: Record "No. Series Relationship";
                    GK: record "G/L Account";
                begin

                    if confirm('Da li ste sigurni da želite kreirati avans za ovog kupca') then begin
                        SalesHeaderAdvance.init;
                        SalesSetup.get;
                        //SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                        SalesHeaderAdvance.Prepayment := TRUE;



                        SalesHeaderAdvance.validate("Sell-to Customer No.", Rec."Bill-to Customer No.");
                        SalesHeaderAdvance.validate("No. Series", SalesSetup."Prepayment Invoice Nos.");
                        SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                        SalesHeaderAdvance."Bill type" := rec."Bill type";
                        if confirm('Da li želite kreirati avans za danas?') then begin
                            SalesHeaderAdvance.validate("Order Date", today);
                            SalesHeaderAdvance.validate("Posting Date", today);
                            SalesHeaderAdvance.validate("Shipment Date", today);
                            SalesHeaderAdvance.validate("VAT Date", today);
                        end
                        else begin
                            SalesHeaderAdvance.validate("Order Date", Rec."Posting Date");
                            SalesHeaderAdvance.validate("Posting Date", Rec."Posting Date");
                            SalesHeaderAdvance.validate("Shipment Date", Rec."Posting Date");
                            SalesHeaderAdvance.validate("VAT Date", Rec."Posting Date");
                        end;
                        SalesHeaderAdvance."CZK Request" := rec."No.";
                        US.Reset();
                        US.SetFilter("User ID", '%1', UserId);
                        if US.FindFirst() then begin
                            if US."CZK User" = true then begin

                                CustTemp.Reset();
                                CustTemp.SetFilter(Code, '%1', SalesHeaderAdvance."Bill type");
                                if CustTemp.FindFirst() then begin

                                    US.Reset();
                                    US.SetFilter("User ID", '%1', UserId);
                                    if US.FindFirst() then begin

                                        RelationShip.Reset();
                                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                                        RelationShip.SetFilter(code, '%1', CustTemp."Post. Advance No. Series Bill");
                                        if RelationShip.FindFirst() then begin
                                            SalesHeaderAdvance."Posting No. Series" := RelationShip."Series Code";
                                        end
                                        else begin
                                            SalesHeaderAdvance."Posting No. Series" := CustTemp."Post. Advance No. Series Bill";

                                        end;


                                        RelationShip.Reset();
                                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                                        RelationShip.SetFilter(code, '%1', CustTemp."Advance No. Series Bill");
                                        if RelationShip.FindFirst() then begin
                                            SalesHeaderAdvance."No. Series" := RelationShip."Series Code";
                                        end
                                        else begin
                                            SalesHeaderAdvance."No. Series" := CustTemp."Advance No. Series Bill";

                                        end;

                                        NoSeriesMgt.InitSeries(SalesHeaderAdvance."Posting No. Series", '', SalesHeaderAdvance."Posting Date", SalesHeaderAdvance."Posting No.", SalesHeaderAdvance."Posting No. Series");
                                        NoSeriesMgt.InitSeries(SalesHeaderAdvance."No. Series", '', SalesHeaderAdvance."Posting Date", SalesHeaderAdvance."No.", SalesHeaderAdvance."No. Series");



                                    end;


                                end;

                            end;

                        end;
                        /*        SalesHeaderAdvance.validate("Order Date", today);
                                SalesHeaderAdvance.validate("Posting Date", today);
                                SalesHeaderAdvance.validate("Shipment Date", today);
                                SalesHeaderAdvance.validate("VAT Date", today);*/
                        SalesHeaderAdvance.validate("Bill Category", Rec."Customer Category");
                        //poredati po kategorijama
                        //poredati po kategorijama


                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                        SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                        SalesHeaderAdvance.Insert();

                        commit;



                        //sada dodajem linije

                        SalesLine."Document No." := SalesHeaderAdvance."No.";
                        SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                        SalesLine."Line No." := 1000;
                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                        SalesLine.Validate("No.", CustTemp."Advance GK");
                        GK.reset;
                        GK.setfilter("No.", '%1', CustTemp."Advance GK");
                        if GK.findfirst then
                            salesLine.validate("Gen. Bus. Posting Group", GK."Gen. Bus. Posting Group");
                        //trebam dobiti 79,95 (finalni rezultat)

                        SumValue := 0;

                        ServiceItemLine.Reset();
                        ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                        ServiceItemLine.SetFilter("Document Type", '%1', rec."Document Type");
                        if ServiceItemLine.FindSet() then
                            repeat
                                SumValue += ServiceItemLine."Amount";
                            until ServiceItemLine.Next() = 0;


                        SalesLine.validate("Unit Price", SumValue);
                        //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                        SalesLine.validate(Quantity, 1);
                        //."Balance (LCY)"
                        //."Balance (LCY)"


                        SalesLine.Insert();
                        Commit();

                        //ĐK    Post_Send(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance);

                        SalesHeader.Copy(SalesHeaderAdvance);
                        Code_SHPost(SalesHeader, false);
                        Rec."Advance Created" := true;
                        Rec.Modify();
                    end;
                end;
            }

            action(CreateCrMemoAdvance)
            {

                ApplicationArea = All;
                Caption = 'Create Cr. Memo Advance';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var

                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    CustomerPrepayment: Record Customer;
                    CustLedger: Record "Cust. Ledger Entry";
                    SalesHeaderAdvance: Record "Sales Header";
                    SalesSetup: Record "Sales & Receivables Setup";
                    PostinD: date;
                    CustTemp: Record "Customer Templ.";
                    SalesLine: Record "Sales Line";
                    SalesAdvance: page "Sales Advance Invoice";
                    PostedSalesAdvance: record "Sales Invoice Header";
                    PostedSalesInvoiceLIne: record "Sales Invoice Line";
                    AbsFill: Codeunit "Absence Fill";
                    FirstDate: Date;
                    LastDate: date;
                    CurrentDate: date;
                    SalesHeader: Record "Sales Header";
                    CustmerPrep: Record Customer;
                    CJL: Record "Calculation Journal Line";
                    CurrentDateCredit: Date;
                    SifraNew: code[20];
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    DetailedCust: Record "Detailed Cust. Ledg. Entry";
                    RecRef: RecordRef;
                    RecordRefExample: Codeunit "Modiy Permissions";
                    EntryLast: Integer;
                    ServiceItemLine: Record "Service Line";
                    SumValue: decimal;
                    US: record "User Setup";
                    RelationShip: Record "No. Series Relationship";
                    GK: record "G/L Account";

                begin
                    if confirm('Da li ste sigurni da želite kreirati storno avansa za ovog kupca') then begin
                        if rec."Credit Memo Created" = false then begin
                            PostedSalesAdvance.Reset();
                            PostedSalesAdvance.SetFilter("Sell-to Customer No.", '%1', Rec."Bill-to Customer No.");
                            PostedSalesAdvance.SetFilter("CZK Request", '%1', Rec."No.");
                            PostedSalesAdvance.SetFilter("CZK Credit Memo", '%1', false);
                            if PostedSalesAdvance.FindFirst() then begin


                                SalesHeaderAdvance.init;
                                SalesSetup.get;
                                //SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                SalesHeaderAdvance.Prepayment := TRUE;



                                SalesHeaderAdvance.validate("Sell-to Customer No.", Rec."Bill-to Customer No.");
                                //  SalesHeaderAdvance.validate("No. Series", SalesSetup."Corr. Prepayment Invoice Nos.");
                                // SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Cr. Memo Nos.");
                                SalesHeaderAdvance."Bill type" := rec."Bill type";
                                SalesHeaderAdvance.validate("Order Date", today);
                                SalesHeaderAdvance.validate("Posting Date", today);
                                SalesHeaderAdvance.validate("Shipment Date", today);
                                SalesHeaderAdvance.validate("VAT Date", today);
                                SalesHeaderAdvance."CZK Request" := rec."No.";
                                SalesHeaderAdvance.validate("CZK Credit Memo", true);
                                US.Reset();
                                US.SetFilter("User ID", '%1', UserId);
                                if US.FindFirst() then begin
                                    if US."CZK User" = true then begin

                                        CustTemp.Reset();
                                        CustTemp.SetFilter(Code, '%1', SalesHeaderAdvance."Bill type");
                                        if CustTemp.FindFirst() then begin

                                            US.Reset();
                                            US.SetFilter("User ID", '%1', UserId);
                                            if US.FindFirst() then begin

                                                RelationShip.Reset();
                                                RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                                                RelationShip.SetFilter(code, '%1', CustTemp."Corr. Post. Advance No. Series Bill");
                                                if RelationShip.FindFirst() then begin
                                                    SalesHeaderAdvance."Posting No. Series" := RelationShip."Series Code";
                                                end
                                                else begin
                                                    SalesHeaderAdvance."Posting No. Series" := CustTemp."Corr. Post. Advance No. Series Bill";

                                                end;


                                                RelationShip.Reset();
                                                RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                                                RelationShip.SetFilter(code, '%1', CustTemp."Corr. Advance No. Series Bill");
                                                if RelationShip.FindFirst() then begin
                                                    SalesHeaderAdvance."No. Series" := RelationShip."Series Code";
                                                end
                                                else begin
                                                    SalesHeaderAdvance."No. Series" := CustTemp."Corr. Advance No. Series Bill";

                                                end;

                                                NoSeriesMgt.InitSeries(SalesHeaderAdvance."Posting No. Series", '', SalesHeaderAdvance."Posting Date", SalesHeaderAdvance."Posting No.", SalesHeaderAdvance."Posting No. Series");
                                                NoSeriesMgt.InitSeries(SalesHeaderAdvance."No. Series", '', SalesHeaderAdvance."Posting Date", SalesHeaderAdvance."No.", SalesHeaderAdvance."No. Series");



                                            end;


                                        end;

                                    end;

                                end;
                                SalesHeaderAdvance.validate("Order Date", today);
                                SalesHeaderAdvance.validate("Posting Date", today);
                                SalesHeaderAdvance.validate("Shipment Date", today);
                                SalesHeaderAdvance.validate("VAT Date", today);
                                SalesHeaderAdvance.validate("Bill Category", Rec."Customer Category");
                                //poredati po kategorijama
                                //poredati po kategorijama


                                SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                SalesHeaderAdvance."Posting Description" := 'Storno avanse fakture ' + SalesHeaderAdvance."No.";
                                SalesHeaderAdvance.Validate("Applies-to Doc. Type", SalesHeaderAdvance."Document Type"::Invoice);
                                SalesHeaderAdvance.Validate("Applies-to Doc. No.", PostedSalesAdvance."No.");
                                SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                SalesHeaderAdvance.Insert();

                                commit;



                                //sada dodajem linije

                                SalesLine."Document No." := SalesHeaderAdvance."No.";
                                SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                SalesLine."Line No." := 1000;
                                SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                SalesLine.Validate("No.", CustTemp."Advance GK");
                                GK.reset;
                                GK.setfilter("No.", '%1', CustTemp."Advance GK");
                                if GK.findfirst then
                                    salesLine.validate("Gen. Bus. Posting Group", GK."Gen. Bus. Posting Group");
                                //trebam dobiti 79,95 (finalni rezultat)

                                SumValue := 0;

                                ServiceItemLine.Reset();
                                ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                                ServiceItemLine.SetFilter("Document Type", '%1', rec."Document Type");
                                if ServiceItemLine.FindSet() then
                                    repeat
                                        SumValue += ServiceItemLine."Amount";
                                    until ServiceItemLine.Next() = 0;


                                SalesLine.validate("Unit Price", SumValue);
                                //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                                SalesLine.validate(Quantity, 1);
                                //."Balance (LCY)"
                                //."Balance (LCY)"


                                SalesLine.Insert();
                                Commit();

                                //ĐK    Post_Send(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance);

                                SalesHeader.Copy(SalesHeaderAdvance);
                                Code_SHPost(SalesHeader, false);
                                Rec."Credit Memo Created" := true;
                                Rec.Modify();
                            end;
                        end;
                    end;
                end;

            }

            action(CopyDocumentService)
            {
                ApplicationArea = Suite;
                Caption = 'Copy Document';
                Ellipsis = true;
                Enabled = "No." <> '';
                Image = CopyDocument;
                Promoted = true;
                PromotedCategory = Category7;
                ToolTip = 'Copy document lines and header information from another sales document to this document. You can copy a posted sales invoice into a new sales invoice to quickly create a similar document.';

                trigger OnAction()
                begin

                    CopyDocument();



                    //  if Get("Document Type", "No.") then;
                end;
            }

            //Service Comment Sheet

            action("Service Comment Sheet ")
            {
                ApplicationArea = All;
                Caption = 'Service Comment Sheet';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction()
                var
                    SerCS: page "Service Comment Sheet";
                    ServiceCommLine: Record "Service Comment Line";
                begin
                    ServiceCommLine.Reset();
                    ServiceCommLine.SetFilter("Table Name", '%1', ServiceCommLine."Table Name"::"Service Header");
                    ServiceCommLine.SetFilter("Table Subtype", '%1', ServiceCommLine."Table Subtype"::"1");
                    ServiceCommLine.SetFilter("No.", '%1', rec."No.");
                    ServiceCommLine.SetFilter(Type, '%1', ServiceCommLine.Type::General);
                    SerCS.SetTableView(ServiceCommLine);
                    SerCS.Run();


                    //                    ServiceInvoice.SetParam(Rec."No.");
                    //                  ServiceInvoice.Run();

                end;
            }

            action("Create Work Order")
            {
                // Visible = WorkOrdersActionVisible;
                Caption = 'Create Work Order';
                Visible = true;
                ApplicationArea = All;
                Image = Tools;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    GetFiterFindText: text[250];
                    RezF: boolean;
                    NoviBr: code[20];
                    ServiceItemLine: record "Service Item Line";
                    ServiceHeader: record "Service Header";
                    ErrorF: record "Service Item Line";
                    ServiceLine: record "Service Line";
                    ILEntry: record "Item Ledger Entry";
                    ShiptFilter: code[250];
                    DocFIlter: Record "Service Header";
                    ILE: record "Item Ledger Entry";


                begin

                    TestField("Address");
                    TestField("Address 2");

                    ErrorF.reset;
                    ErrorF.setfilter("Document No.", '%1', rec."No.");
                    ErrorF.setfilter("Document Type", '%1', rec."Document Type");
                    if not ErrorF.findfirst then begin
                        error('Ne možete kreirati radni nalog bez podataka o mjernom mjestu/lokaciji ili gasnoj stanici!');
                    end;

                    if "RN Source" = "RN Source"::" " then
                        error('Vrsta troška mora biti popunjena!');

                    ServiceLine.reset;
                    ServiceLine.setfilter("Document No.", '%1', rec."No.");
                    ServiceLine.setfilter("Document Type", '%1', rec."Document Type");
                    ServiceLine.setfilter("Type", '%1', ServiceLine."Type"::"Item");
                    if ServiceLine.findset then
                        repeat

                            DocFIlter.Reset();
                            DocFIlter.SetFilter("No.", '%1', "No.");
                            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                            if DocFIlter.FindFirst() then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    ShiptFilter := rec."No."
                                else
                                    ShiptFilter := rec."No.";
                            end
                            else begin
                                ShiptFilter := rec."No.";

                            end;

                            ILE.Reset();
                            ILE.SetFilter("Item No.", '%1', "No.");
                            ile.setfilter("Sales Header No.", ShiptFilter);
                            ile.SetFilter("Location Code", "Location Code");
                            ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Transfer);
                            if ile.FindFirst() then begin
                                ile.CalcSums(Quantity);
                                if ile.Quantity <> ServiceLine.Quantity then begin

                                    ILEntry.reset;
                                    ILEntry.setfilter("Item No.", '%1', ServiceLine."No.");
                                    ILEntry.SetFilter("Location Code", '%1', ServiceLine."Source Location Code");
                                    if ILEntry.findfirst then begin
                                        ILEntry.calcsums("Quantity");
                                        if ServiceLine."Quantity" > (ServiceLine."Quantity" - ile.Quantity) then
                                            Message('Artikla ' + ServiceLine."No." + ' nema dovoljno na stanju, pa ne možete kreirati radne naloge!')
                                    end
                                    else begin
                                        message('Artikla ' + ServiceLine."No." + ' nema na stanju, pa ne možete kreirati radne naloge!')
                                    end;
                                end;
                            end
                            else begin
                                ILEntry.reset;
                                ILEntry.setfilter("Item No.", '%1', ServiceLine."No.");
                                ILEntry.SetFilter("Location Code", '%1', ServiceLine."Source Location Code");
                                if ILEntry.findfirst then begin
                                    ILEntry.calcsums("Quantity");
                                    if ServiceLine."Quantity" > ILEntry.Quantity then
                                        message('Artikla ' + ServiceLine."No." + ' nema dovoljno na stanju, pa ne možete kreirati radne naloge!')
                                end
                                else begin
                                    message('Artikla ' + ServiceLine."No." + ' nema na stanju, pa ne možete kreirati radne naloge!')
                                end;
                            end;

                        until ServiceLine.next = 0;


                    //  GetFiterFindText:=
                    //   CurrPage."Measure Points List".GetFiterFind();
                    RezF := CurrPage."Measure Points List".Page.GetFiterFind(true, '', '');
                    if RezF = false then begin
                        Commit();
                        rec.CreateAndOpenWorkOrder(false);

                    end
                    else begin
                        commit();
                        NoviBr := rec.CreateAndOpenWorkOrder(true);
                        Commit();
                        RezF := CurrPage."Measure Points List".Page.GetFiterFind(true, '', NoviBr);
                        ServiceHeader.reset;
                        ServiceHeader.setfilter("No.", '%1', NoviBr);
                        if ServiceHeader.findfirst then begin
                            Commit();
                            Page.RunModal(Page::"Request Card", ServiceHeader);
                            Commit();
                        end;
                    end;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = Warehouse;
                Caption = 'Reopen';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Reactivate the service order after it has been released for warehouse handling.';

                trigger OnAction()
                var
                    ReleaseServiceDocument: Codeunit "Release Service Document";
                begin
                    ReleaseServiceDocument.PerformManualReopen(Rec);
                end;
            }
            action(Post)
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';
                //   Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var
                    ServHeader: Record "Service Header";
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                    InstructionMgt: Codeunit "Instruction Mgt.";


                    SIL: Record "Service Line";

                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    ReleaseServiceDocument: Codeunit "Release Service Document";
                    myInt: Integer;
                    TransferHeader: record "Transfer Header";

                    SLine: record "Service Line";
                    BRojL: integer;
                    Linija: integer;
                    TransferLine: record "Transfer Line";
                    RTD: Codeunit "Release Transfer Document";
                    Postoji: boolean;
                    SHUpdate: Record "Service Header";
                    WhseShptLine: record "WareHouse Shipment Line";
                    WhseShptLineCreate: record "WareHouse Shipment Line";
                    ServiceLineGeneral: record "Service Line";
                    SHReq: Record "Service Header";
                    ItemNoRec: Record item;
                    UserIdOrg: Record "User Setup";
                    ECL: Record "Employee Contract Ledger";
                    THGet: record "Transfer Header";

                begin
                    if Confirm('Da li želite proknjižiti fakturu na danas?') then begin

                        rec."Due Date" := calcdate('<+15D>', Today);
                        rec."VAT Date" := today;
                        Rec.Modify();
                    end;


                    ServHeader.Get("Document Type", "No.");
                    ServPostYesNo.PostDocument(ServHeader);
                    DocumentIsPosted := not ServHeader.Get("Document Type", "No.");
                    if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                        ShowPostedConfirmationMessage;
                    CurrPage.Update(false);
                end;

                //kreiram otpremu i onda sve to fakturišem
                //kreiram prvo otpremu
                /*  ReleaseServiceDocument.PerformManualRelease(Rec);


                  Postoji := false;
                  SLine.reset;
                  BRojL := 0;
                  SLine.reset;
                  SLine.setfilter("Document No.", '%1', rec."No.");
                  SLine.setfilter("Quantity Shipped", '%1', 0);
                  SLine.setfilter("Type", '%1', SLine.type::Item);
                  if SLine.findset then
                      repeat
                          BRojL += 1;
                          if BRojL = 1 then begin
                              TransferHeader.init;

                              //   TransferHeader.Validate("Transfer-from Code", 'GLAVNO');


                              if SLine."Source Location Code" <> '' then
                                  TransferHeader.Validate("Transfer-from Code", SLine."Source Location Code")

                              else
                                  TransferHeader.Validate("Transfer-from Code", 'GLAVNO');
                              TransferHeader.Validate("Transfer-to Code", SLine."Location Code");
                              //sa glavne na neku drugu
                              TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                              TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                              TransferHeader.Validate("Sales Header No.", Rec."No.");
                              UserIdOrg.reset;
                              UserIdOrg.SetFilter("User ID", '%1', UserId);
                              if UserIdOrg.FindFirst() then begin
                                  ECL.Reset();
                                  ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                  ecl.SetFilter(Active, '%1', true);
                                  if ecl.FindFirst() then begin
                                      TransferHeader.Validate("Department Code", ecl."Department Code");
                                  end;
                              end;

                              //šifra naloga
                              TransferHeader.Insert(true);
                              Postoji := true;
                              commit;
                          end;
                          Linija += 10000;

                          TransferLine.init;
                          TransferLine.Validate("Document No.", TransferHeader."No.");
                          TransferLine.Validate("Line No.", SLine."Line No.");
                          TransferLine.Validate("Item No.", SLine."No.");
                          TransferLine.Validate(Quantity, SLine.Quantity);
                          TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                          TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                          TransferLine.Insert(true);
                          commit;
                          if TransferHeader."G/L Account No." = '' then begin
                              ItemNoRec.Reset();
                              ItemNoRec.SetFilter("No.", '%1', SLine."No.");
                              if ItemNoRec.findfirst then begin
                                  if THGet.get(TransferHeader."No.") then begin
                                      THGet."G/L Account No." := ItemNoRec."Inventory Posting Group";
                                      THGet.modify;
                                  end;
                              end;
                          end;

                          SLine."Transfer Order" := TransferHeader."No.";
                          SLine."Qty. to Ship" := SLine.Quantity;
                          SLine."Outstanding Qty. (Base)" := SLine.Quantity;
                          sline."Outstanding Quantity" := sline.Quantity;
                          SLine."Quantity (Base)" := SLine.Quantity;
                          SLine.Modify();

                          SHReq.Reset();
                          SHReq.SetFilter("CZK Request No.", '%1', rec."No.");
                          SHReq.SetFilter("Request Type", '%1', rec."Request Type"::"General Work Order");
                          if SHReq.FindSet() then
                              repeat
                                  ServiceLineGeneral.Reset();
                                  ServiceLineGeneral.SetFilter("Document No.", '%1', SHReq."No.");
                                  ServiceLineGeneral.SetFilter("Document type", '%1', SHReq."Document type");
                                  ServiceLineGeneral.setfilter("Line No.", '%1', SLine."Line No.");
                                  ServiceLineGeneral.setfilter("Quantity", '%1', SLine."Quantity");
                                  ServiceLineGeneral.SetFilter(type, '%1', SLine.Type);
                                  ServiceLineGeneral.setfilter("No.", '%1', SLine."No.");
                                  if ServiceLineGeneral.findfirst then begin
                                      ServiceLineGeneral."Transfer Order" := TransferHeader."No.";
                                      ServiceLineGeneral.modify;
                                  end;
                              until SHReq.next() = 0;

                      until SLine.next = 0;
                  if Postoji = true then begin
                      SHUpdate.Reset();
                      SHUpdate.SetFilter("No.", '%1', rec."No.");
                      if SHUpdate.FindFirst() then begin
                          SHUpdate."Transfer Order" := TransferHeader."No.";
                          SHUpdate.Modify();
                      end;
                      commit;
                      RTD.Run(TransferHeader);
                      commit;

                      //i sada bih trebala reći kreiraj otpremnicu

                      GetSourceDocOutbound.CreateFromOutbndTransferOrder(TransferHeader);
                      commit;
                      WhseShptLineCreate.reset;
                      WhseShptLineCreate.setfilter("Source No.", '%1', TransferHeader."No.");
                      WhseShptLineCreate.setfilter("Source Document", '%1', WhseShptLineCreate."Source Document"::"Outbound Transfer");
                      if WhseShptLineCreate.FindSet() then
                          repeat
                              WhseShptLine.Copy(WhseShptLineCreate);
                              CODEUNIT.Run(CODEUNIT::"Whse.-Post Shipment (Yes/No)", WhseShptLine);
                          until WhseShptLineCreate.next() = 0;
                  end;
                  commit;
                  //kontam da bi ovdje ipak kreirala odmah prenos sa GlavnoGAS na Teren, pa onda knjižiti sa terena: 


                  /*  GetSourceDocOutbound.CreateFromServiceOrder(Rec);
                    if not Find('=><') then
                        Init;
                    Commit();

                    WhseShptLine2.Reset();
                    WhseShptLine2.SetFilter("Source No.", '%1', rec."No.");
                    if WhseShptLine2.FindSet() then
                        repeat

                            WhseShptLine.Copy(WhseShptLine2);
                            //otpremnica, a potom knjiženje na isti dokument
                            // CODEUNIT.Run(CODEUNIT::"Whse.-Post Shipment (Yes/No)", WhseShptLine);
                            "Code_WH";
                        until WhseShptLine2.next = 0;
                    Commit();

                    //dio da se prikači nakon otpremnice, samo trošak


                    ServHeader.Get("Document Type", "No.");
                    PostDocument(servheader);
                    //ServPostYesNo.PostDocument(ServHeader);


*/



                /*    ServHeader.Get("Document Type", "No.");
                    ServPostYesNo.PostDocument(ServHeader);
                    DocumentIsPosted := not ServHeader.Get("Document Type", "No.");
                    ShowPostedConfirmationMessage;

                    //ovo je proknjižena otpremnica
                end;    //ovo je proknjižena otpremnica
                */
                //   end;



            }

            /*Djemina*/

            action("Archive Document")
            {
                /*   ApplicationArea = Suite;
                   Caption = 'Archi&ve Document';
                   Image = Archive;
                   ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';
   */

                ApplicationArea = All;
                Caption = 'Archi&ve Document';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = false;

                trigger OnAction()
                var
                    ArchiveManagement: codeunit ArchiveManagementService;
                begin

                    ArchiveManagement.ArchiveServiceDocument(Rec);
                    CurrPage.Update(false);
                end;
            }

            action("Archived Document")
            {
                /*   ApplicationArea = Suite;
                   Caption = 'Archi&ve Document';
                   Image = Archive;
                   ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';
   */

                ApplicationArea = All;
                Caption = 'Archi&ved Document';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    ArchiveManagement: Page "Requests Archived";
                    ServiceHeaderArchive: record "Service Header Archive";
                begin
                    ServiceHeaderArchive.reset;
                    ServiceHeaderArchive.setfilter("Document No.", '%1', rec."Document No.");
                    ArchiveManagement.SetTableView(ServiceHeaderArchive);

                    ArchiveManagement.run;

                end;
            }

            action("Preview Values")
            {
                /*   ApplicationArea = Suite;
                   Caption = 'Archi&ve Document';
                   Image = Archive;
                   ToolTip = 'Send the document to the archive, for example because it is too soon to delete it. Later, you delete or reprocess the archived document.';
   */

                ApplicationArea = All;
                Caption = 'Preview Values';
                Image = PostOrder;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    TempLinkedRequests: Record "Template_Message" temporary;
                    ServiceLine: record "Service Line";
                    EntryNo: integer;
                    ServiceLineCZK: Record "Service Line";
                    EntryFilters: text;
                    ServiceLineRN: Record "Service Line";
                    EntryFilters2: text;
                    ServiceLineRNQuantity: Record "Service Line";
                    TemporeryItem: Record "Tax Group" temporary;
                    LineNo: integer;
                    ServiceLineCZKInit: Record "Service Line";
                    ArchiveManagement: codeunit ArchiveManagementService;

                begin

                    ArchiveManagement.ArchiveServiceDocument(Rec);
                    CurrPage.Update(false);

                    TempLinkedRequests.deleteall;
                    TemporeryItem.DeleteAll();
                    EntryNo := 1;

                    ServiceLineCZK.Reset();
                    ServiceLineCZK.SetFilter("Document No.", '%1', rec."No.");
                    ServiceLineCZK.SetCurrentKey("Line No.");
                    ServiceLineCZK.Ascending;
                    if ServiceLineCZK.findlast then
                        LineNo += ServiceLineCZK."Line No." + 10000

                    else
                        LineNo += 10000;


                    GetLinkedRequests(Rec."No.", TempLinkedRequests, EntryNo);



                    EntryFilters := '';
                    EntryFilters2 := '';
                    TempLinkedRequests.Reset();
                    TempLinkedRequests.setcurrentkey("ID");
                    TempLinkedRequests.ascending;

                    if TempLinkedRequests.FindSet() then
                        repeat
                            //ovdje sad sada pronašla sve objekte koji su povezani sa osnovnim nalogom
                            EntryFilters += TempLinkedRequests."Message Code" + '|';
                            if TempLinkedRequests."Message Code" <> Rec."No." then
                                EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                        until TempLinkedRequests.Next() = 0;


                    if strlen(EntryFilters) > 2 then
                        EntryFilters := copystr(EntryFilters, 1, strlen(EntryFilters) - 1);


                    if strlen(EntryFilters2) > 2 then
                        EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


                    if EntryFilters <> '' then begin



                        ServiceLineRN.Reset();
                        ServiceLineRN.SetFilter("Document No.", EntryFilters2);
                        ServiceLineRN.setfilter("Type", '%1', ServiceLineCZK."Type"::Item);
                        if ServiceLineRN.findset then
                            repeat

                                ServiceLineCZK.Reset();
                                ServiceLineCZK.SetFilter("Document No.", '%1', rec."No.");
                                ServiceLineCZK.setfilter("Type", '%1', ServiceLineCZK."Type"::Item);
                                ServiceLineCZK.setfilter("No.", '%1', ServiceLineRN."No.");
                                if serviceLineCZK.findfirst then begin
                                    ServiceLineRNQuantity.Reset();
                                    ServiceLineRNQuantity.SetFilter("Document No.", EntryFilters2);
                                    ServiceLineRNQuantity.setfilter("Type", '%1', ServiceLineCZK."Type"::Item);
                                    ServiceLineRNQuantity.SetFilter("No.", '%1', ServiceLineRN."No.");
                                    if ServiceLineRNQuantity.FindFirst() then begin
                                        ServiceLineRNQuantity.calcsums(Quantity);
                                        TemporeryItem.Reset();
                                        TemporeryItem.SetFilter(Code, '%1', ServiceLineCZK."No.");
                                        if not TemporeryItem.FindFirst() then begin
                                            ServiceLineCZK.Validate(Quantity, ServiceLineRNQuantity.Quantity);
                                            ServiceLineCZK.modify;
                                            TemporeryItem.Init();
                                            TemporeryItem.Code := ServiceLineCZK."No.";
                                            TemporeryItem.Insert();
                                        end;
                                        //ovo je koliko je stvarno utrošeno po tom artiklu
                                    end;
                                end
                                else begin

                                    ServiceLineCZKInit.Init();
                                    ServiceLineCZKInit.TransferFields(ServiceLineRN);
                                    ServiceLineCZK.Reset();
                                    ServiceLineCZK.SetFilter("Document No.", '%1', rec."No.");
                                    ServiceLineCZK.setfilter("Type", '%1', ServiceLineCZK."Type"::Item);
                                    if ServiceLineCZK.FindFirst() then begin

                                        ServiceLineCZKInit."Service Item Line No." := ServiceLineCZK."Service Item Line No.";
                                        ServiceLineCZKInit."Service Item No." := ServiceLineCZK."Service Item No.";

                                    end;
                                    ServiceLineCZKInit."Document No." := rec."No.";
                                    ServiceLineCZKInit."DOcument Type" := rec."Document Type";
                                    ServiceLineRNQuantity.Reset();
                                    ServiceLineRNQuantity.SetFilter("Document No.", EntryFilters);
                                    ServiceLineRNQuantity.setfilter("Type", '%1', ServiceLineCZK."Type"::Item);
                                    ServiceLineRNQuantity.SetFilter("No.", '%1', ServiceLineRN."No.");
                                    if ServiceLineRNQuantity.FindFirst() then begin
                                        ServiceLineRNQuantity.calcsums(Quantity);
                                        ServiceLineCZKInit.validate(Quantity, ServiceLineRNQuantity.Quantity);
                                        ServiceLineCZKInit."Line No." := LineNo;
                                        LineNo += 10000;
                                    end;

                                    TemporeryItem.Reset();
                                    TemporeryItem.SetFilter(Code, '%1', ServiceLineCZKInit."No.");
                                    if not TemporeryItem.FindFirst() then begin
                                        ServiceLineCZKInit.Insert();
                                        TemporeryItem.Init();
                                        TemporeryItem.Code := ServiceLineCZKInit."No.";
                                        TemporeryItem.Insert();
                                    end;





                                end;
                            until ServiceLineRN.next = 0;
                    end;

                end;


            }

            action(Preview)
            {
                ApplicationArea = Service;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                begin
                    ServHeader.Get("Document Type", "No.");
                    ServPostYesNo.PreviewDocument(ServHeader);
                    DocumentIsPosted := not ServHeader.Get("Document Type", "No.");
                end;
            }

            action("Sent mail")
            {
                ApplicationArea = All;
                Caption = 'Sent mail';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ProcessRequestActionVisible;

                trigger OnAction()
                var
                    CRL: record "Custom Report Layout";
                    RLS: record "Report Layout Selection";
                    Sendmail: Report "Send mail from RN";
                    filter: text[250];
                    GTemp: Record "Service Header";
                begin

                    GTemp.Reset();
                    GTemp.SetFilter("Sent Mail", '%1', false);
                    GTemp.SetFilter("No.", '%1', rec."No.");
                    Report.RunModal(Report::"Send mail from RN", true, true, GTemp);

                end;
            }



        }
        area(Navigation)
        {
            action(ZROU002501)
            {
                ApplicationArea = All;
                Caption = 'ZR-OU-00-25-01', Locked = true;
                Visible = InformationIssuingRequestVisible;
                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    us: Record "User Setup";
                    crl: record "Custom report layout";
                begin
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    us.Reset();
                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50065);
                    crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                    if crl.FindFirst() then begin
                        us.SetFilter("User ID", '%1', UserId);
                        if us.findfirst then begin
                            us."Crl Code" := crl.code;
                            us.modify;
                        end;

                    end;
                    Commit();
                    Report.RunModal(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                    Commit();
                end;
            }
            action(INFTU031001)
            {
                ApplicationArea = All;
                Caption = 'Izvještaj', Locked = true;
                Visible = InformationOnConnectionVisible;
                Image = Document;

                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                begin
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    Report.RunModal(Report::"INF-TU-03-10-01", true, false, ServiceHeader);
                end;
            }
            action(ZROU002502)
            {
                ApplicationArea = All;
                Caption = 'ZR-OU-00-25-02', Locked = true;
                Visible = ProjectOverviewRequestVisible;
                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    SmS: Record "Service Mgt. Setup";
                    ZR_Report: report "ZR-OU-00-25-01";
                    US: record "User Setup";

                begin
                    //        CurrPage.SetSelectionFilter(ServiceHeader);
                    //      Report.RunModal(Report::"ZR-OU-00-25-02", true, false, ServiceHeader);

                    //  CurrPage.SetSelectionFilter(ServiceHeader);
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    if rec."Request Type" = rec."Request Type"::"Project overview Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50065);
                        crl.SetFilter(Description, '%1', 'Pregled projekta UGI');
                        if crl.FindFirst() then begin
                            // RLS.SetTempLayoutSelected(crl.Code);
                            //   ZR_Report.SetParam(crl.code);
                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.findfirst then begin
                                us."Crl Code" := crl.code;
                                us.modify;
                            end;


                            SmS.Get();
                            Commit();
                            Report.Run(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                            Commit();
                        end;

                    end;


                end;
            }
            action(SGTU030901)
            {
                ApplicationArea = All;
                Caption = 'SG-TU-03-09-01';

                Visible = ElAccordanceVisible;
                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    ServiceItemLine: record "Service Item Line";
                begin
                    //  CurrPage.SetSelectionFilter(ServiceHeader);
                    ServiceItemLine.reset;
                    ServiceItemLine.SetFilter("Document No.", '%1', rec."No.");
                    ServiceItemLine.SetFilter("Document Type", '%1', rec."Document Type");
                    Report.RunModal(Report::"SG-TU-03-09-01", true, false, ServiceItemLine);
                end;
            }
            action(SGTU030903)
            {
                ApplicationArea = All;
                Caption = 'SG-TU-03-09-03', Locked = true;
                Visible = false;

                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                begin
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    Report.RunModal(Report::"SG-TU-03-09-03", true, false, ServiceHeader);
                end;
            }

            action(Location)
            {
                ApplicationArea = All;
                Caption = 'Location Print';
                Visible = LocationRouteSpatialPlanVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50065: Report "ZR-OU-00-25-01";
                    Report50101: Report "INF-TU-03-10-01";
                    US: record "User Setup";
                begin


                    CurrPage.SetSelectionFilter(ServiceHeader);

                    if (rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Information")

                    or (rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Information") then begin

                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50101);
                        crl.SetFilter("Request Type", '%1', rec."Request Type");


                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);

                            Report.Run(Report::"INF-TU-03-10-01", true, false, ServiceHeader);
                            //  Report50065.run;
                            //  Report.RunModal(Report::, true, false, ServiceHeader);
                        end;

                    end
                    else begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50065);
                        if "Request Type" = "Request Type"::"Location Accordance Issuing Request" then
                            crl.SetFilter(Description, '%1', 'Zahtjev za lokaciju');

                        if "Request Type" = "Request Type"::"Route Accordance Issuing Request" then
                            crl.SetFilter(Description, '%1', 'Zahtjev za trasu');

                        if "Request Type" = "Request Type"::"Spatial plan Accordance Issuing Request" then
                            crl.SetFilter(Description, '%1', 'Zahtjev za prostorni plan');

                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);

                            us.Reset();
                            us.SetFilter("User ID", '%1', UserId);
                            if us.findfirst then begin
                                us."Crl Code" := crl.code;
                                us.modify;
                            end;
                            Commit();
                            Report.Run(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                            Commit();
                            //  Report50065.run;
                            //  Report.RunModal(Report::, true, false, ServiceHeader);
                        end;
                    end;

                end;
            }

            action(GeoReport)
            {
                ApplicationArea = All;
                Caption = 'Geo Print';
                Visible = GeoWorkOrderVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50184: Report "Service Order GEO";
                    SILine: Record "Service Item Line";
                begin



                    CurrPage.SetSelectionFilter(ServiceHeader);




                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50184);



                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        ServiceHeader.Reset();
                        ServiceHeader.SetFilter("No.", '%1', rec."No.");
                        if ServiceHeader.FindFirst() then
                            SILine.Reset();
                        SILine.SetFilter("Document No.", '%1', ServiceHeader."No.");
                        if SILine.FindFirst() then
                            Report.Run(Report::"Service Order GEO", true, false, SILine);
                        //  Report50065.run;
                        //  Report.RunModal(Report::, true, false, ServiceHeader);
                    end
                    else begin
                        ServiceHeader.Reset();
                        ServiceHeader.SetFilter("No.", '%1', rec."No.");
                        if ServiceHeader.FindFirst() then
                            SILine.Reset();
                        SILine.SetFilter("Document No.", '%1', ServiceHeader."No.");
                        if SILine.FindFirst() then
                            Report.Run(Report::"Service Order GEO", true, false, ServiceHeader);
                    end;



                end;
            }


            action("Reports")
            {
                ApplicationArea = all;
                Caption = 'Reports';
                Image = Report;
                Visible = VisibleReport;
                //RunPageLink = "Service Item No. - Relation" = Field("No.");
                trigger OnAction()
                var
                    myInt: Integer;
                    Rep: Report "Service Order General RDL";
                    SItem: Record "Service Item Line";

                    LL: Record "Service Header";
                begin

                    SItem.Reset();
                    SItem.SetFilter("Document No.", '%1', rec."No.");
                    SItem.SetFilter(Type, '%1', SItem.Type::OS);
                    Report.Run(50205, true, true, SItem);
                end;
            }

            action(ServiceOrderReport)
            {
                ApplicationArea = All;
                Caption = 'Service Order General Print';
                Visible = WorkOrderVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50186: Report "Service Order General";
                    CRLPage: page "Custom Report Layouts";
                    SL: Record "Service Item Line";
                begin


                    /*  CurrPage.SetSelectionFilter(ServiceHeader);



                      crl.Reset();
                      crl.SetFilter("Report ID", '%1', 50186);



                      if crl.FindFirst() then begin
                          RLS.SetTempLayoutSelected(crl.Code);

                          Report.Run(Report::"Service Order General", true, false, ServiceHeader);
                          //  Report50065.run;
                          //  Report.RunModal(Report::, true, false, ServiceHeader);
                      end
                      else begin
                          Report.Run(Report::"Service Order General", true, false, ServiceHeader);
                      end;
                    */

                    // CurrPage.SetSelectionFilter(ServiceHeader);
                    // Report.RunModal(Report::"Service Order General", true, false, ServiceHeader);


                    //  RunCustomReport;

                    //    CRLPage.RunCustomReport;
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    /*  crl.Reset();
                      crl.SetFilter("Report ID", '%1', 50186);
                      if crl.FindFirst() then begin
                      //    RLS.SetTempLayoutSelected(crl.Code);*/
                    SL.reset;
                    SL.SetFilter("Document No.", '%1', rec."No.");
                    SL.setfilter("Document Type", '%1', rec."Document Type");
                    SL.SetFilter("Request type", '%1', sl."Request type"::"General Work Order");
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50186);
                    CRL.SetFilter(Description, '<>%1', '@*CZK*');
                    if CRL.FindFirst() then begin
                        RLS.SetTempLayoutSelected(CRL.Code);
                        Report.Run(Report::"Service Order General", true, false, SL);
                    end;
                end;
            }

            action(ServiceOrderReportSum)
            {
                ApplicationArea = All;
                Caption = 'Service Order General Print Sum';
                Visible = WorkOrderVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50186: Report "Service Order General";
                    CRLPage: page "Custom Report Layouts";
                    SL: Record "Service Item Line";
                    ECLOrg: Record "Employee Contract Ledger";
                    US: record "User Setup";
                begin


                    /*  CurrPage.SetSelectionFilter(ServiceHeader);



                      crl.Reset();
                      crl.SetFilter("Report ID", '%1', 50186);



                      if crl.FindFirst() then begin
                          RLS.SetTempLayoutSelected(crl.Code);

                          Report.Run(Report::"Service Order General", true, false, ServiceHeader);
                          //  Report50065.run;
                          //  Report.RunModal(Report::, true, false, ServiceHeader);
                      end
                      else begin
                          Report.Run(Report::"Service Order General", true, false, ServiceHeader);
                      end;
                    */

                    // CurrPage.SetSelectionFilter(ServiceHeader);
                    // Report.RunModal(Report::"Service Order General", true, false, ServiceHeader);


                    //  RunCustomReport;

                    //    CRLPage.RunCustomReport;
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    /*  crl.Reset();
                      crl.SetFilter("Report ID", '%1', 50186);
                      if crl.FindFirst() then begin
                      //    RLS.SetTempLayoutSelected(crl.Code);*/
                    SL.reset;
                    //SL.SetFilter("Document No.", '%1', rec."No.");
                    SL.setfilter("Document Type", '%1', rec."Document Type");
                    sl.SetFilter("Request type", '%1', "Request Type"::"General Work Order");
                    ECLOrg.Reset();
                    ECLOrg.SetFilter(Active, '%1', true);
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if US.FindFirst() then begin
                        ECLOrg.SetFilter("Employee No.", '%1', US."Employee No. for Wage");
                    end;
                    if ECLOrg.FindFirst() then begin
                        if ECLOrg."Department Code" <> '' then
                            sl.SetFilter("Responsible Department", '%1', ECLOrg."Department Code");
                    end;
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50217);
                    if CRL.FindFirst() then begin
                        RLS.SetTempLayoutSelected(CRL.Code);
                        Report.Run(Report::"Service Order General Sum", true, false, SL);
                    end;
                end;
            }

            action(CZKPrint)
            {
                ApplicationArea = All;
                Caption = 'CZKPrint';
                Visible = ProcessRequestActionVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50186: Report "Service Order General";
                    CRLPage: page "Custom Report Layouts";
                    SL: Record "Service Item Line";
                begin



                    CurrPage.SetSelectionFilter(ServiceHeader);
                    /*  crl.Reset();
                      crl.SetFilter("Report ID", '%1', 50186);
                      if crl.FindFirst() then begin
                      //    RLS.SetTempLayoutSelected(crl.Code);*/
                    SL.reset;
                    SL.SetFilter("Document No.", '%1', rec."No.");
                    SL.setfilter("Document Type", '%1', rec."Document Type");
                    SL.SetFilter("Request type", '%1', sl."Request type"::Others);
                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50186);
                    CRL.SetFilter(Description, '%1', '@*CZK*');
                    if CRL.FindFirst() then begin
                        RLS.SetTempLayoutSelected(CRL.Code);
                        Report.Run(Report::"Service Order General", true, false, SL);
                    end;
                end;
            }

            action(ViewUGi)
            {
                ApplicationArea = All;
                Caption = 'ViewUGi';
                Visible = WorkExecutionVisible;
                Image = Document;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50065: Report "ZR-OU-00-25-01";
                    SmS: Record "Service Mgt. Setup";
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    US: Record "User Setup";
                begin
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50065);

                    crl.SetFilter(Description, '%1', 'Pregled UGI');

                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);

                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.findfirst then begin
                            us."Crl Code" := crl.code;
                            us.modify;
                        end;

                        SmS.Get();
                        ServiceHeader.Reset();
                        ServiceHeader.SetFilter("No.", '%1', rec."No.");
                        if ServiceHeader.findfirst then begin

                            if
                        ServiceHeader."First view No." = '' then begin
                                NoSeriesMgt.InitSeries(sms."UGI Overview No. Series", xRec."No. Series", 0D, ServiceHeader."First view No.", "No. Series");
                                if ServiceHeader."First view date" = 0D then
                                    ServiceHeader."First view date" := Today;
                                ServiceHeader.Modify();
                            end;
                        end;
                        Commit();

                        Report.Run(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                        Commit();
                        //  Report50065.run;
                        //  Report.RunModal(Report::, true, false, ServiceHeader);
                    end;
                end;
            }

            action("Application for Work")
            {
                ApplicationArea = All;
                Caption = 'Application for Work';
                Visible = WorkExecutionVisible;
                Promoted = true;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50065: Report "ZR-OU-00-25-01";
                    US: Record "User Setup";
                begin
                    CurrPage.SetSelectionFilter(ServiceHeader);
                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50065);
                    crl.SetFilter(Description, '%1', 'Prijava izvođenja radova');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);

                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.findfirst then begin
                            us."Crl Code" := crl.code;
                            us.modify;
                        end;

                        Commit();
                        Report.Run(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                        Commit();
                        //  Report50065.run;
                        //  Report.RunModal(Report::, true, false, ServiceHeader);
                    end;
                end;
            }

            action("Completion of Work")
            {
                ApplicationArea = All;
                Caption = 'Completion of Work';
                Visible = WorkExecutionVisible;
                Promoted = true;
                PromotedIsBig = true;
                Image = Document;
                trigger OnAction()
                var
                    ServiceHeader: Record "Service Header";
                    CRL: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    Report50065: Report "ZR-OU-00-25-01";
                    SmS: Record "Service Mgt. Setup";

                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    US: Record "User Setup";
                begin

                    CurrPage.SetSelectionFilter(ServiceHeader);
                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50065);
                    crl.SetFilter(Description, '%1', 'Izjava o završetku radova');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        SmS.Get();
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.findfirst then begin
                            us."Crl Code" := crl.code;
                            us.modify;
                        end;

                        ServiceHeader.Reset();
                        ServiceHeader.SetFilter("No.", '%1', rec."No.");
                        if ServiceHeader.findfirst then begin

                            if
                        ServiceHeader."No. for Execution" = '' then begin
                                NoSeriesMgt.InitSeries(sms."Work Execution No. Series", xRec."No. Series", 0D, ServiceHeader."No. for Execution", "No. Series");
                                if ServiceHeader."Date for Execution" = 0D then
                                    ServiceHeader."Date for Execution" := Today;
                                ServiceHeader.Modify();
                            end;
                        end;
                        Commit();
                        Report.Run(Report::"ZR-OU-00-25-01", true, false, ServiceHeader);
                        Commit();
                        //  Report50065.run;
                        //  Report.RunModal(Report::, true, false, ServiceHeader);
                    end;
                end;
            }

            action("Work Orders")
            {
                ApplicationArea = All;
                Caption = 'Work Orders';
                Visible = WorkOrdersActionVisible;
                Image = WorkCenterLoad;
                RunObject = Page Requests;
                RunPageLink = "Document Type" = const(Order), "CZK Request No." = field("No."), "Request Type" = filter("General Work Order" | "General Geo. Work Order" | "General Geo. Work Order Office");
            }
            action("Create Shipment")
            {
                ApplicationArea = All;
                Caption = 'Create Shipment';
                Visible = false;

                trigger OnAction()
                var
                    myInt: Integer;
                    TransferHeader: record "Transfer Header";
                    SLine: record "Service Line";
                    BRojL: integer;
                    Linija: integer;
                    UserIdOrg: Record "User Setup";
                    ECL: Record "Employee Contract Ledger";
                    TransferLine: record "Transfer Line";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    Postoji: boolean;
                    SHUpdate: Record "Service Header";
                    DocFIlter: Record "Service Header";
                    LocSource: Record location;
                    TransHeader: record "Transfer Header";
                    TransLine: record "Transfer Line";
                    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
                    TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
                    DefaultNumber: Integer;
                    Selection: Option " ",Shipment,Receipt;
                    Text000: Label '&Ship,&Receive';
                    IsHandled: Boolean;
                    LocationREc: record "Location" temporary;
                    Docno: code[20];
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    InvtSetup: Record "Inventory Setup";
                    USset: record "User Setup";
                    ItemNoRec: record "Item";

                begin
                    LocationREc.reset;
                    LocationREc.SetFilter(name, '%1', userid);
                    if LocationREc.findset then
                        repeat

                            LocationREc.delete;
                        until LocationREc.next = 0;

                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;

                    Postoji := false;
                    SLine.reset;
                    BRojL := 0;
                    SLine.reset;
                    SLine.setfilter("Document No.", '%1', rec."No.");
                    // SLine.setfilter("Quantity Shipped", '%1', 0);
                    SLine.setfilter("Type", '%1', SLine.type::Item);
                    //  SLine.SetFilter("Shiped Quantity",'%1',0);
                    // SLine.SetFilter("Invoiced Quantity",);
                    if SLine.findset then
                        repeat
                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity");

                            DocFIlter.Reset();
                            DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                            if DocFIlter.FindFirst() then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    SLine.SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                                else
                                    SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end
                            else begin
                                SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end;

                            if SLine."Invoiced Quantity" > 0 then begin

                                DocFIlter.Reset();
                                DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                                DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                                if DocFIlter.FindFirst() then begin
                                    SLine.SETRANGE("Shipment No. Filter", DocFIlter."CZK Request No.")

                                end
                                else begin
                                    SLine.SETRANGE("Shipment No. Filter", '       ');

                                end;
                            end
                            else begin

                                SLine.SETRANGE("Shipment No. Filter", SLine."Document No.");

                            end;

                            if DocFIlter."CZK Request No." <> '' then
                                Sline.setfilter("Shipment No. Filter", '%1', Sline."Document No.");

                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity");

                            if (SLine."Shiped Quantity" < SLine.Quantity) and (SLine.Quantity <> 0) then begin
                                LocationREc.Reset();
                                LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                LocationREc.setfilter(Name, '%1', UserId);
                                if not LocationREc.FindFirst() then begin
                                    BRojL := 1;
                                end
                                else begin
                                    BRojL := 0;
                                end;
                            end;


                            /* if (SLine."Shiped Quantity" < SLine.Quantity) and (SLine.Quantity <> 0) then
                                 BRojL += 1;*/

                            if BRojL = 1 then begin
                                TransferHeader.init;
                                InvtSetup.get;
                                Docno := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", TODAY, true);
                                TransferHeader."No." := Docno;
                                BRojL += 1;
                                if SLine."Source Location Code" <> '' then
                                    TransferHeader.Validate("Transfer-from Code", SLine."Source Location Code")

                                else
                                    TransferHeader.Validate("Transfer-from Code", 'GLAVNO');


                                TransferHeader.Validate("Transfer-to Code", SLine."Location Code");
                                //sa glavne na neku drugu
                                TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                TransferHeader.Validate("Sales Header No.", Rec."No.");
                                UserIdOrg.reset;
                                UserIdOrg.SetFilter("User ID", '%1', UserId);
                                if UserIdOrg.FindFirst() then begin
                                    ECL.Reset();
                                    ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                    ecl.SetFilter(Active, '%1', true);
                                    if ecl.FindFirst() then begin
                                        TransferHeader.Validate("Department Code", ecl."Department Code");
                                    end;
                                end;
                                UserIdOrg.reset;
                                UserIdOrg.SetFilter("User ID", '%1', UserId);
                                if UserIdOrg.FindFirst() then begin
                                    ECL.Reset();
                                    ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                    ecl.SetFilter(Active, '%1', true);
                                    if ecl.FindFirst() then begin
                                        TransferHeader.Validate("Department Code", ecl."Department Code");
                                    end;
                                end;
                                TransferHeader."RN Source" := rec."RN Source";
                                rec.CalcFields("Location Name");
                                TransferHeader.Address := rec."Location Name";

                                //šifra naloga
                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', SLine."Source Location Code");
                                if LocSource.findfirst then begin
                                    if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                        TransferHeader."Direct Transfer" := false;
                                        TransferHeader.Validate("Employee No.", USset."Employee No. for Wage");
                                    end;

                                end;

                                TransferHeader."Shipment Date" := today;
                                TransferHeader."Receipt Date" := today;
                                TransferHeader."Posting Date" := today;

                                TransferHeader.Insert(true);

                                LocationREc.Reset();
                                LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                LocationREc.setfilter(Name, '%1', UserId);
                                if not LocationREc.FindFirst() then begin
                                    LocationREc.init;
                                    LocationREc.Code := SLine."Source Location Code";
                                    LocationREc.name := UserId;
                                    LocationREc."Responsible Person E Position" := TransferHeader."No.";
                                    LocationREc.insert;
                                end;

                                Postoji := true;
                                commit;
                            end;

                            if (SLine."Shiped Quantity" < SLine.Quantity) and (SLine.Quantity <> 0) then begin
                                Linija += 10000;

                                TransferLine.init;
                                TransferLine.Validate("Document No.", TransferHeader."No.");
                                TransferLine.Validate("Line No.", SLine."Line No.");
                                //   TransferLine.Validate("Source Line No.",'%1',SLine."Line No.");
                                TransferLine.Validate("Item No.", SLine."No.");
                                TransferLine.Validate(Quantity, SLine.Quantity - SLine."Shiped Quantity");
                                TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                TransferLine.validate("Sales Header No.", rec."No.");
                                UserIdOrg.reset;
                                UserIdOrg.SetFilter("User ID", '%1', UserId);
                                if UserIdOrg.FindFirst() then begin
                                    ECL.Reset();
                                    ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                    ecl.SetFilter(Active, '%1', true);
                                    if ecl.FindFirst() then begin
                                        TransferLine.Validate("Department Code", ecl."Department Code");
                                    end;
                                end;
                                TransferLine.Insert(true);

                                if TransferHeader."G/L Account No." = '' then begin
                                    ItemNoRec.Reset();
                                    ItemNoRec.SetFilter("No.", '%1', SLine."No.");
                                    if ItemNoRec.findfirst then begin
                                        TransferHeader."G/L Account No." := ItemNoRec."Inventory Posting Group";
                                        TransferHeader.modify;
                                    end;
                                end;

                                commit;

                                //lansiraj



                                SLine."Transfer Order" := TransferHeader."No.";
                                SLine."Qty. to Ship" := SLine.Quantity - SLine."Shiped Quantity";
                                SLine."Quantity (Base)" := SLine.Quantity - SLine."Shiped Quantity";
                                SLine."Outstanding Qty. (Base)" := SLine.Quantity;
                                sline."Outstanding Quantity" := sline.Quantity;
                                SLine."Quantity (Base)" := SLine.Quantity;

                                SLine.Modify();
                            end;
                        until SLine.next = 0;
                    if Postoji = true then begin
                        SHUpdate.Reset();
                        SHUpdate.SetFilter("No.", '%1', rec."No.");
                        if SHUpdate.FindFirst() then begin
                            SHUpdate."Transfer Order" := TransferHeader."No.";
                            SHUpdate.Modify();
                        end;
                        commit;

                        LocationREc.Reset();
                        LocationREc.SetFilter(name, '%1', UserId);
                        if LocationREc.findset then
                            repeat
                                commit;
                                TransferHeader.get(LocationREc."Responsible Person E Position");


                                RTD.Run(TransferHeader);
                                commit;

                                //i sada bih trebala reći kreiraj otpremnicu

                                //ovo samo ako se zahtjeva otprema, a ako ne onda samo je potrebno proknjižiti nalog za prenos
                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', LocationREc.Code);
                                if LocSource.findfirst then begin
                                    if LocSource."Require Shipment" = true then begin

                                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(TransferHeader);
                                    end
                                    else begin
                                        //odmah se ovo knjiži
                                        TransHeader.Copy(TransferHeader);
                                        with TransHeader do begin
                                            TransLine.SetRange("Document No.", TransHeader."No.");
                                            if TransLine.Find('-') then
                                                repeat
                                                    if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 1;
                                                    if (TransLine."Quantity Received" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 2;
                                                until (TransLine.Next = 0) or (DefaultNumber > 0);
                                            if LocSource."Require Shipment" = false then begin
                                                Commit();
                                                TransferPostShipment.Run(TransHeader);
                                                Commit();
                                                TransferPostReceipt.Run(TransHeader);
                                                Commit();
                                            end else begin
                                                if DefaultNumber = 0 then
                                                    DefaultNumber := 1;
                                                Selection := StrMenu(Text000, DefaultNumber);
                                                case Selection of
                                                    0:
                                                        exit;
                                                    Selection::Shipment:
                                                        TransferPostShipment.Run(TransHeader);
                                                    Selection::Receipt:
                                                        TransferPostReceipt.Run(TransHeader);
                                                end;
                                            end;
                                        end;
                                    end;

                                    //kraj
                                end;
                            until LocationREc.Next() = 0;
                    end;

                end;
                //ovdje je kreirana skladišna otpremnica


            }

            //kreiraj i povrat


            action("Create Shipment and Undo")
            {
                ApplicationArea = All;
                Caption = 'Create Shipment and Undo';
                Visible = OnlyGeneral;

                trigger OnAction()
                var
                    TempLinkedRequests: Record "Template_Message" temporary;
                    TemporeryItem: Record "Tax Group" temporary;
                    EntryNo: integer;
                    EntryFilters2: text;
                    myInt: Integer;
                    TransferHeader: record "Transfer Header";
                    SLine: record "Service Line";
                    BRojL: integer;
                    Linija: integer;
                    TransferLine: record "Transfer Line";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    Postoji: boolean;
                    SHUpdate: Record "Service Header";
                    DocFIlter: Record "Service Header";
                    LocSource: Record location;
                    TransHeader: record "Transfer Header";
                    TransLine: record "Transfer Line";
                    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
                    TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
                    DefaultNumber: Integer;
                    Selection: Option " ",Shipment,Receipt;
                    Text000: Label '&Ship,&Receive';
                    IsHandled: Boolean;
                    LocationREc: record "Location" temporary;
                    Docno: code[20];
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    InvtSetup: Record "Inventory Setup";
                    USset: record "User Setup";
                    ItemNoRec: record "Item";
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    BrojLoc: Integer;
                    ConnectedRN: text;
                    DocFIlter2: Record "Service Header";
                    SLineConnected: record "Service Line";
                    ServiceHeaderBasic: Record "Service Header";
                    CZkRequestYes: record "Service Header";
                    QuantityOnRevers: Decimal;
                    ItemLedgerEntry: Record "Item Ledger Entry";
                    TransferHeaderEx: record "Transfer Header";
                    TransferLineEx: record "Transfer Line";
                    TransferLineInit: record "Transfer Line";
                    LineNoAdd: integeR;
                    TransferHeaderInit: record "Transfer Header";
                    LinijaInit: Integer;
                    WShipmentPage: page "Warehouse Shipment";
                    WShipmentRecord: Record "Warehouse Shipment Header";
                    WReceiptRecord: Record "Warehouse Receipt Header";
                    TransferHeaderUpdate: record "Transfer Header";
                    WarehouseReceiptPage: page "Warehouse Receipt";
                    THExsistAlready: Record "Transfer Header";

                    UserIdOrg: Record "User Setup";
                    ECL: Record "Employee Contract Ledger";
                    ServiceLine: Record "Service Line";
                    ILEntry: Record "Item Ledger Entry";
                    ShiptFilter: code[250];

                    ILE: record "Item Ledger Entry";

                begin

                    ServiceLine.reset;
                    ServiceLine.setfilter("Document No.", '%1', rec."No.");
                    ServiceLine.setfilter("Document Type", '%1', rec."Document Type");
                    ServiceLine.setfilter("Type", '%1', ServiceLine."Type"::"Item");
                    if ServiceLine.findset then
                        repeat

                            DocFIlter.Reset();
                            DocFIlter.SetFilter("No.", '%1', "No.");
                            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                            if DocFIlter.FindFirst() then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    ShiptFilter := rec."No."
                                else
                                    ShiptFilter := rec."No.";
                            end
                            else begin
                                ShiptFilter := rec."No.";

                            end;

                            ILE.Reset();
                            ILE.SetFilter("Item No.", '%1', "No.");
                            ile.setfilter("Sales Header No.", ShiptFilter);
                            ile.SetFilter("Location Code", "Location Code");
                            ile.SetFilter("Entry Type", '%1', ile."Entry Type"::Transfer);
                            if ile.FindFirst() then begin
                                ile.CalcSums(Quantity);
                                if ile.Quantity <> ServiceLine.Quantity then begin

                                    ILEntry.reset;
                                    ILEntry.setfilter("Item No.", '%1', ServiceLine."No.");
                                    ILEntry.SetFilter("Location Code", '%1', ServiceLine."Source Location Code");
                                    if ILEntry.findfirst then begin
                                        ILEntry.calcsums("Quantity");
                                        if ServiceLine."Quantity" > (ServiceLine."Quantity" - ile.Quantity) then
                                            message('Artikla ' + ServiceLine."No." + ' nema dovoljno na stanju, pa ne možete kreirati radne naloge!')
                                    end
                                    else begin
                                        message('Artikla ' + ServiceLine."No." + ' nema na stanju, pa ne možete kreirati radne naloge!')
                                    end;
                                end;
                            end
                            else begin
                                ILEntry.reset;
                                ILEntry.setfilter("Item No.", '%1', ServiceLine."No.");
                                ILEntry.SetFilter("Location Code", '%1', ServiceLine."Source Location Code");
                                if ILEntry.findfirst then begin
                                    ILEntry.calcsums("Quantity");
                                    if ServiceLine."Quantity" > ILEntry.Quantity then
                                        message('Artikla ' + ServiceLine."No." + ' nema dovoljno na stanju, pa ne možete kreirati radne naloge!')
                                end
                                else begin
                                    message('Artikla ' + ServiceLine."No." + ' nema na stanju, pa ne možete kreirati radne naloge!')
                                end;
                            end;

                        until ServiceLine.next = 0;

                    if "RN Source" = "RN Source"::" " then
                        error('Vrsta troška mora biti popunjena!');

                    LocationREc.reset;
                    LocationREc.SetFilter(name, '%1', userid);
                    if LocationREc.findset then
                        repeat

                            LocationREc.delete;
                        until LocationREc.next = 0;

                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;

                    Postoji := false;
                    SLine.reset;
                    BRojL := 0;
                    SLine.reset;
                    SLine.setfilter("Document No.", '%1', rec."No.");
                    // SLine.setfilter("Quantity Shipped", '%1', 0);
                    SLine.setfilter("Type", '%1', SLine.type::Item);
                    //  SLine.SetFilter("Shiped Quantity",'%1',0);
                    // SLine.SetFilter("Invoiced Quantity",);
                    if SLine.findset then
                        repeat



                            if (SLine."Planned Quantity" = 0) then
                                SLine."Planned Quantity" := sline.Quantity;

                            ServiceHeaderBasic.Reset();
                            ServiceHeaderBasic.SetFilter("No.", '%1', rec."No.");
                            ServiceHeaderBasic.SetFilter("Document Type", '%1', rec."Document Type");
                            if ServiceHeaderBasic.findfirst then begin
                                if ServiceHeaderBasic."CZK Request No." = '' then begin
                                    if (SLine."Planned Quantity" < sline.Quantity) then
                                        SLine."Planned Quantity" := sline.Quantity;

                                    CZkRequestYes.reset;
                                    CZkRequestYes.setfilter("No.", '%1', ServiceHeaderBasic."CZK Request No.");
                                    if CZkRequestYes.findfirst then begin
                                        if CZkRequestYes."Request Type".AsInteger() in [0, 1, 3, 5, 8, 9, 10] then begin
                                            if (SLine."Planned Quantity" < sline.Quantity) then
                                                SLine."Planned Quantity" := sline.Quantity;
                                        end;
                                    end;


                                end;
                            end;



                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity");

                            DocFIlter.Reset();
                            DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                            if DocFIlter.FindFirst() then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    SLine.SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                                else
                                    SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end
                            else begin
                                SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end;

                            if SLine."Invoiced Quantity" > 0 then begin

                                DocFIlter.Reset();
                                DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                                DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                                if DocFIlter.FindFirst() then begin
                                    SLine.SETRANGE("Shipment No. Filter", SLine."Document No.")

                                end
                                else begin
                                    SLine.SETRANGE("Shipment No. Filter", '       ');

                                end;
                            end
                            else begin

                                SLine.SETRANGE("Shipment No. Filter", SLine."Document No.");

                            end;

                            if DocFIlter."CZK Request No." <> '' then
                                Sline.setfilter("Shipment No. Filter", '%1', Sline."Document No.");

                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity", "Shiped Quantity2");

                            //dodala povezani RN

                            ConnectedRN := '';

                            if SLine."Document No." <> '' then begin

                                DocFIlter2.Reset();
                                DocFIlter2.SetFilter("CZK Request No.", '%1', SLine."Document No.");
                                if DocFIlter2.findset() then
                                    repeat
                                        if DocFIlter2."No." <> SLine."Document No." then
                                            ConnectedRN += DocFIlter2."No." + '|';
                                    until DocFIlter.Next() = 0;

                                DocFIlter2.Reset();
                                DocFIlter2.SetFilter("No.", '%1', SLine."Document No.");
                                if DocFIlter2.FindFirst() then begin
                                    if DocFIlter2."CZK Request No." <> '' then begin
                                        if DocFIlter2."CZK Request No." <> SLine."Document No." then
                                            ConnectedRN := DocFIlter."CZK Request No." + '|';
                                    end;
                                end;


                                if rec."CZK Request No." <> '' then begin
                                    DocFIlter2.Reset();
                                    DocFIlter2.SetFilter("CZK Request No.", '%1', rec."CZK Request No.");
                                    if DocFIlter2.findset() then
                                        repeat
                                            if DocFIlter2."No." <> SLine."Document No." then begin
                                                if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                                    ConnectedRN += DocFIlter2."No." + '|';
                                            end;
                                        until DocFIlter.Next() = 0;


                                end;

                                if strlen(ConnectedRN) > 2 then
                                    ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);
                                //ovdje djemina dodalaa


                                //ja bih ovdje sada dodala ovaj connectedRN i da vidim kako će to izgledati

                                TempLinkedRequests.deleteall;
                                TemporeryItem.DeleteAll();
                                EntryNo := 1;




                                GetLinkedRequests(Rec."No.", TempLinkedRequests, EntryNo);
                                EntryFilters2 := '';
                                TempLinkedRequests.Reset();
                                TempLinkedRequests.setcurrentkey("ID");
                                TempLinkedRequests.ascending;

                                if TempLinkedRequests.FindSet() then
                                    repeat
                                        if TempLinkedRequests."Message Code" <> Rec."No." then
                                            EntryFilters2 += TempLinkedRequests."Message Code" + '|';
                                    until TempLinkedRequests.Next() = 0;


                                if strlen(EntryFilters2) > 2 then
                                    EntryFilters2 := copystr(EntryFilters2, 1, strlen(EntryFilters2) - 1);


                                ConnectedRN := EntryFilters2;
                                //kraj djemina

                                //ovdje kraj novi

                                SLineConnected.reset;
                                SLineConnected.copyfilters(SLine);
                                SLineConnected.setfilter("Line No.", '%1', SLine."Line No.");
                                if SLineConnected.findfirst then begin
                                    if ConnectedRN <> '' then
                                        SLineConnected.SETFILTER("CZK Connected No. Filter", ConnectedRN)
                                    else
                                        SLineConnected.setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
                                    SLineConnected.calcfields("Connected Quantity");
                                end;
                            end;


                            if SLine.Quantity > Sline."Shiped Quantity2" then begin
                                //kreiraj dodatno

                                if ((SLine."Shiped Quantity2" < SLine.Quantity) and (SLine.Quantity <> 0) and (SLine."Planned Quantity" > ((SLine."Shiped Quantity2" + SLineConnected."Connected Quantity"))))
                               or (((SLine."Planned Quantity" < SLine.Quantity) and (SLine."Shiped Quantity2" <> SLine.Quantity))) or (((SLine."Planned Quantity" < (SLine."Shiped Quantity2" + SLineConnected."Connected Quantity")) and (SLine."Shiped Quantity2" < SLine.Quantity))) or ((SLine."Shiped Quantity2" = 0) and (SLine.Quantity <> 0)) then begin


                                    LocationREc.Reset();
                                    LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                    LocationREc.setfilter(Name, '%1', UserId);
                                    //  LocationREc.setfilter("Invoice Responsible Person", SLine."Location Code");
                                    if not LocationREc.FindFirst() then begin
                                        BRojL := 1;
                                    end
                                    else begin
                                        BRojL := 0;
                                    end;



                                    QuantityOnRevers := 0;

                                    if Sline."Source Location Code" = 'REVERS' then begin
                                        ItemLedgerEntry.Reset();
                                        ItemLedgerEntry.SetFilter("Item No.", '%1', Sline."No.");
                                        if ConnectedRN <> '' then
                                            ItemLedgerEntry.setfilter("Sales Header No.", ConnectedRN + '|' + Sline."Document No.")
                                        else
                                            ItemLedgerEntry.setfilter("Sales Header No.", Sline."Document No.");
                                        ItemLedgerEntry.setfilter("Location Code", '%1', Sline."Source Location Code");

                                        UserIdOrg.reset;
                                        UserIdOrg.SetFilter("User ID", '%1', UserId);
                                        if UserIdOrg.FindFirst() then begin
                                            ECL.Reset();
                                            ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                            ecl.SetFilter(Active, '%1', true);
                                            if ecl.FindFirst() then begin
                                                ItemLedgerEntry.SetFilter("Department Code", ecl."Department Code");
                                            end;
                                        end;

                                        if ItemLedgerEntry.findfirst then begin
                                            ItemLedgerEntry.calcsums(Quantity);
                                            QuantityOnRevers := ItemLedgerEntry.Quantity;
                                        end;

                                    end;

                                    if QuantityOnRevers = 0 then begin
                                        if SLine."Source Location Code" <> 'GLAVNO' then begin
                                            THExsistAlready.Reset();
                                            THExsistAlready.SetFilter("Sales Header No.", '%1', SLine."Document No.");
                                            if (Sline."Source Location Code" = 'GLAVNO') and (Sline."Shiped Quantity2" > SLine."Quantity") then
                                                THExsistAlready.setfilter("Transfer-to Code", 'GLAVNO')
                                            else
                                                THExsistAlready.setfilter("Transfer-from Code", 'GLAVNO');
                                            if THExsistAlready.findfirst then
                                                BRojL := 0;

                                        end;

                                    end;


                                end;


                                /* if (SLine."Shiped Quantity" < SLine.Quantity) and (SLine.Quantity <> 0) then
                                     BRojL += 1;*/

                                if (BRojL = 1) then begin
                                    TransferHeader.init;
                                    InvtSetup.get;
                                    Docno := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", TODAY, true);
                                    TransferHeader."No." := Docno;
                                    BRojL += 1;


                                    if SLine."Source Location Code" <> '' then begin


                                        QuantityOnRevers := 0;

                                        if Sline."Source Location Code" = 'REVERS' then begin
                                            ItemLedgerEntry.Reset();
                                            ItemLedgerEntry.SetFilter("Item No.", '%1', Sline."No.");
                                            if ConnectedRN <> '' then
                                                ItemLedgerEntry.setfilter("Sales Header No.", ConnectedRN + '|' + Sline."Document No.")
                                            else
                                                ItemLedgerEntry.setfilter("Sales Header No.", Sline."Document No.");
                                            ItemLedgerEntry.setfilter("Location Code", '%1', Sline."Source Location Code");
                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    ItemLedgerEntry.SetFilter("Department Code", ecl."Department Code");
                                                end;
                                            end;
                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    ItemLedgerEntry.SetFilter("Department Code", ecl."Department Code");
                                                end;
                                            end;
                                            if ItemLedgerEntry.findfirst then begin
                                                ItemLedgerEntry.calcsums(Quantity);
                                                QuantityOnRevers := ItemLedgerEntry.Quantity;
                                            end;

                                        end;

                                        if QuantityOnRevers = 0 then begin
                                            if SLine."Source Location Code" <> 'GLAVNO' then begin
                                                SLine."Source Location Code" := 'GLAVNO';
                                                TransferHeader.Validate("Transfer-from Code", 'GLAVNO');




                                                TransferHeader.Validate("Transfer-to Code", SLine."Location Code");
                                                //provjeriti da li ovo uopšte imamo na stanju i koliko

                                            end
                                            else begin
                                                TransferHeader.Validate("Transfer-from Code", SLine."Source Location Code");
                                            end;
                                        end
                                        else begin
                                            TransferHeader.Validate("Transfer-from Code", SLine."Source Location Code");
                                        end;



                                    end


                                    else begin
                                        TransferHeader.Validate("Transfer-from Code", 'GLAVNO');
                                    end;




                                    TransferHeader.Validate("Transfer-to Code", SLine."Location Code");
                                    //sa glavne na neku drugu
                                    TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                    TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                    TransferHeader.Validate("Sales Header No.", Rec."No.");

                                    UserIdOrg.reset;
                                    UserIdOrg.SetFilter("User ID", '%1', UserId);
                                    if UserIdOrg.FindFirst() then begin
                                        ECL.Reset();
                                        ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                        ecl.SetFilter(Active, '%1', true);
                                        if ecl.FindFirst() then begin
                                            TransferHeader.validate("Department Code", ecl."Department Code");
                                        end;
                                    end;

                                    TransferHeader."RN Source" := rec."RN Source";
                                    rec.CalcFields("Location Name");
                                    TransferHeader.Address := rec."Location Name";

                                    //šifra naloga
                                    LocSource.reset;
                                    LocSource.setfilter("Code", '%1', SLine."Source Location Code");
                                    if LocSource.findfirst then begin
                                        if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                            TransferHeader."Direct Transfer" := false;
                                            TransferHeader.Validate("Employee No.", USset."Employee No. for Wage");
                                        end;

                                    end;

                                    TransferHeader."Shipment Date" := today;
                                    TransferHeader."Receipt Date" := today;
                                    TransferHeader."Posting Date" := today;



                                    TransferHeader.Insert(true);

                                    LocationREc.Reset();
                                    LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                    LocationREc.setfilter(Name, '%1', UserId);
                                    // LocationREc.setfilter("Invoice Responsible Person", SLine."Location Code");
                                    if not LocationREc.FindFirst() then begin
                                        LocationREc.init;
                                        LocationREc.Code := SLine."Source Location Code";
                                        LocationREc."Invoice Responsible Person" := SLine."Location Code";
                                        LocationREc.name := UserId;
                                        LocationREc."Responsible Person E Position" := TransferHeader."No.";
                                        LocationREc.insert;
                                    end;

                                    Postoji := true;
                                    commit;
                                end;

                                if ((SLine."Shiped Quantity2" < SLine.Quantity) and (SLine.Quantity <> 0) and (SLine."Planned Quantity" > (SLine."Shiped Quantity2" + SLineConnected."Connected Quantity")))
                                or ((SLine."Planned Quantity" < SLine.Quantity) and (SLine."Shiped Quantity2" <> SLine.Quantity)) or ((SLine."Planned Quantity" < (SLine."Shiped Quantity2" + SLineConnected."Connected Quantity")) and (SLine."Shiped Quantity2" <> SLine.Quantity)) or ((SLine."Shiped Quantity2" = 0) and (SLine.Quantity <> 0)) then begin

                                    if TransferHeader."Transfer-from Code" <> SLine."Source Location Code" then begin
                                        TransferHeaderUpdate.reset;
                                        TransferHeaderUpdate.setfilter("Sales Header No.", '%1', SLine."Document NO.");
                                        TransferHeaderUpdate.setfilter("Transfer-from Code", '%1', SLine."Source Location Code");
                                        if TransferHeaderUpdate.findfirst then begin
                                            TransferHeader."No." := TransferHeaderUpdate."NO.";
                                            TransferHeader."Transfer-from Code" := TransferHeaderUpdate."Transfer-from Code";
                                            TransferHeader."Transfer-to Code" := TransferHeaderUpdate."Transfer-to Code";



                                        end;
                                    end;



                                    Linija += 10000;

                                    TransferLine.init;
                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                    TransferLine.Validate("Line No.", SLine."Line No.");
                                    //   TransferLine.Validate("Source Line No.",'%1',SLine."Line No.");
                                    TransferLine.Validate("Item No.", SLine."No.");


                                    //sada bi ja provjerila koliko ima na reversu, da li ima da mogu eventualno smanjiti količinu i poslati je ponovo na teren
                                    QuantityOnRevers := 0;

                                    if Sline."Source Location Code" = 'REVERS' then begin
                                        ItemLedgerEntry.Reset();
                                        ItemLedgerEntry.SetFilter("Item No.", '%1', Sline."No.");
                                        if ConnectedRN <> '' then
                                            ItemLedgerEntry.setfilter("Sales Header No.", ConnectedRN + '|' + Sline."Document No.")
                                        else
                                            ItemLedgerEntry.setfilter("Sales Header No.", Sline."Document No.");
                                        ItemLedgerEntry.setfilter("Location Code", '%1', Sline."Source Location Code");

                                        UserIdOrg.reset;
                                        UserIdOrg.SetFilter("User ID", '%1', UserId);
                                        if UserIdOrg.FindFirst() then begin
                                            ECL.Reset();
                                            ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                            ecl.SetFilter(Active, '%1', true);
                                            if ecl.FindFirst() then begin
                                                ItemLedgerEntry.SetFilter("Department Code", ecl."Department Code");
                                            end;
                                        end;

                                        if ItemLedgerEntry.findfirst then begin
                                            ItemLedgerEntry.calcsums(Quantity);
                                            QuantityOnRevers := ItemLedgerEntry.Quantity;
                                        end;

                                    end;

                                    if QuantityOnRevers <> 0 then begin
                                        if QuantityOnRevers - (SLine.Quantity - SLine."Shiped Quantity2") <= 0 then
                                            TransferLine.Validate(Quantity, QuantityOnRevers)
                                        else
                                            TransferLine.Validate(Quantity, (SLine.Quantity - SLine."Shiped Quantity2"));
                                    end

                                    else begin
                                        TransferLine.Validate(Quantity, (SLine.Quantity - SLine."Shiped Quantity2"));
                                    end;


                                    TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                    TransferLine.validate("Sales Header No.", rec."No.");
                                    UserIdOrg.reset;
                                    UserIdOrg.SetFilter("User ID", '%1', UserId);
                                    if UserIdOrg.FindFirst() then begin
                                        ECL.Reset();
                                        ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                        ecl.SetFilter(Active, '%1', true);
                                        if ecl.FindFirst() then begin
                                            TransferLine.validate("Department Code", ecl."Department Code");
                                        end;
                                    end;

                                    TransferLine.Insert(true);

                                    if TransferHeader."G/L Account No." = '' then begin
                                        ItemNoRec.Reset();
                                        ItemNoRec.SetFilter("No.", '%1', SLine."No.");
                                        if ItemNoRec.findfirst then begin
                                            TransferHeader."G/L Account No." := ItemNoRec."Inventory Posting Group";
                                            TransferHeader.modify;
                                        end;
                                    end;

                                    commit;

                                    //lansiraj



                                    SLine."Transfer Order" := TransferHeader."No.";
                                    SLine."Qty. to Ship" := SLine.Quantity - SLine."Shiped Quantity2";
                                    SLine."Quantity (Base)" := SLine.Quantity - SLine."Shiped Quantity2";
                                    SLine."Outstanding Qty. (Base)" := SLine.Quantity - SLine."Shiped Quantity2";
                                    sline."Outstanding Quantity" := sline.Quantity - SLine."Shiped Quantity2";
                                    SLine."Quantity (Base)" := SLine.Quantity - SLine."Shiped Quantity2";

                                    SLine.Modify();

                                    //ja bih ovdje sada dodala provjeru da li ima glavno skladište po ovom nalogu i ako nema, dodaj novi Header, a ako ima nadodaj
                                    if (QuantityOnRevers - (SLine.Quantity - SLine."Shiped Quantity2") < 0) and (QuantityOnRevers > 0) then begin
                                        TransferLineEx.reset;
                                        TransferLineEx.setfilter("Transfer-from Code", '%1', 'GLAVNO');
                                        TransferLineEx.setfilteR("Sales Header No.", '%1', Rec."No.");
                                        TransferLineEx.setcurrentkey("Line No.");
                                        TransferLineEx.ascending;
                                        if TransferLineEx.findlast then begin

                                            TransferLineInit.init;
                                            TransferLineInit.Validate("Document No.", TransferLineEx."Document No.");
                                            TransferLineInit.Validate("Line No.", TransferLineEx."Line No." + 1000);

                                            //   TransferLineInit.Validate("Source Line No.",'%1',SLine."Line No.");
                                            TransferLineInit.Validate("Item No.", SLine."No.");
                                            TransferLineInit.Validate(Quantity, (SLine.Quantity - SLine."Shiped Quantity2") - QuantityOnRevers);
                                            TransferLineInit.validate("Transfer-from Code", TransferLineEx."Transfer-from Code");
                                            TransferLineInit.validate("Transfer-to Code", TransferLineEx."Transfer-to Code");
                                            TransferLineInit.validate("Sales Header No.", TransferLineEx."Sales Header No.");

                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    TransferLineInit.validate("Department Code", ecl."Department Code");
                                                end;
                                            end;


                                            TransferLineInit.Insert(true);

                                            //ovdje sam recimo sada dodala u linijama samo ako je slučajno postojao nalog
                                            Commit();

                                        end
                                        else begin
                                            //ovdje sve dodajem ispočetka

                                            LinijaInit += 10000;
                                            TransferHeaderInit.init;
                                            InvtSetup.get;
                                            Docno := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", TODAY, true);
                                            TransferHeaderInit."No." := Docno;
                                            BRojL += 1;
                                            TransferHeaderInit.Validate("Transfer-from Code", 'GLAVNO');


                                            TransferHeaderInit.Validate("Transfer-to Code", SLine."Location Code");
                                            //sa glavne na neku drugu
                                            TransferHeaderInit.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                            TransferHeaderInit.Validate("In-Transit Code", 'TRANZIT');
                                            TransferHeaderInit.Validate("Sales Header No.", Rec."No.");

                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    TransferHeaderInit.validate("Department Code", ecl."Department Code");
                                                end;
                                            end;


                                            TransferHeaderInit."RN Source" := rec."RN Source";
                                            rec.CalcFields("Location Name");
                                            TransferHeaderInit.Address := rec."Location Name";

                                            //šifra naloga
                                            LocSource.reset;
                                            LocSource.setfilter("Code", '%1', 'GLAVNO');
                                            if LocSource.findfirst then begin
                                                if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                                    TransferHeaderInit."Direct Transfer" := false;
                                                    TransferHeaderInit.Validate("Employee No.", USset."Employee No. for Wage");
                                                end;

                                            end;

                                            TransferHeaderInit."Shipment Date" := today;
                                            TransferHeaderInit."Receipt Date" := today;
                                            TransferHeaderInit."Posting Date" := today;

                                            TransferHeaderInit.Insert(true);

                                            LocationREc.Reset();
                                            LocationREc.SetFilter(Code, '%1', TransferHeaderInit."Transfer-from Code");
                                            LocationREc.setfilter(Name, '%1', UserId);
                                            //    LocationREc.setfilter("Invoice Responsible Person", SLine."Location Code");
                                            if not LocationREc.FindFirst() then begin
                                                LocationREc.init;
                                                LocationREc.Code := TransferHeaderInit."Transfer-from Code";
                                                LocationREc.name := UserId;
                                                LocationREc."Invoice Responsible Person" := Sline."Location Code";
                                                LocationREc."Responsible Person E Position" := TransferHeaderInit."No.";
                                                LocationREc.insert;
                                            end;

                                            Postoji := true;
                                            commit;

                                            //i sada dodajem ponovo liniju
                                            TransferLineInit.init;
                                            TransferLineInit.Validate("Document No.", TransferHeaderInit."No.");
                                            TransferLineInit.Validate("Line No.", LinijaInit);

                                            //   TransferLineInit.Validate("Source Line No.",'%1',SLine."Line No.");
                                            TransferLineInit.Validate("Item No.", SLine."No.");
                                            TransferLineInit.Validate(Quantity, (SLine.Quantity - SLine."Shiped Quantity2") - QuantityOnRevers);
                                            TransferLineInit.validate("Transfer-from Code", TransferHeaderInit."Transfer-from Code");
                                            TransferLineInit.validate("Transfer-to Code", TransferHeaderInit."Transfer-to Code");
                                            TransferLineInit.validate("Sales Header No.", TransferHeaderInit."Sales Header No.");
                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    TransferLineInit.validate("Department Code", ecl."Department Code");
                                                end;
                                            end;

                                            UserIdOrg.reset;
                                            UserIdOrg.SetFilter("User ID", '%1', UserId);
                                            if UserIdOrg.FindFirst() then begin
                                                ECL.Reset();
                                                ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                                ecl.SetFilter(Active, '%1', true);
                                                if ecl.FindFirst() then begin
                                                    TransferLineInit.validate("Department Code", ecl."Department Code");
                                                end;
                                            end;


                                            TransferLineInit.Insert(true);

                                            //ovdje sam recimo sada dodala u linijama samo ako je slučajno postojao nalog
                                            Commit();
                                            //kraj

                                            //
                                            //kraj
                                        end;

                                    end;

                                end;

                            end;
                            if (SLine."Shiped Quantity2" <> 0) or (SLineConnected."Connected Quantity" <> 0)
                            then begin

                                // SLine.validate("Source Location Code", 'REVERS');
                                //SLine.Modify();
                                // neka oni sami mijenjaju




                            end;
                        until SLine.next = 0;


                    if Postoji = true then begin
                        SHUpdate.Reset();
                        SHUpdate.SetFilter("No.", '%1', rec."No.");
                        if SHUpdate.FindFirst() then begin
                            SHUpdate."Transfer Order" := TransferHeader."No.";
                            SHUpdate.Modify();
                        end;
                        commit;

                        LocationREc.Reset();
                        LocationREc.SetFilter(name, '%1', UserId);
                        if LocationREc.findset then
                            repeat
                                commit;
                                TransferHeader.get(LocationREc."Responsible Person E Position");


                                RTD.Run(TransferHeader);
                                commit;

                                //i sada bih trebala reći kreiraj otpremnicu

                                //ovo samo ako se zahtjeva otprema, a ako ne onda samo je potrebno proknjižiti nalog za prenos
                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', LocationREc.Code);
                                if LocSource.findfirst then begin
                                    if LocSource."Require Shipment" = true then begin

                                        GetSourceDocOutbound.CreateFromOutbndTransferOrder(TransferHeader);
                                    end
                                    else begin
                                        //odmah se ovo knjiži
                                        TransHeader.Copy(TransferHeader);
                                        with TransHeader do begin
                                            TransLine.SetRange("Document No.", TransHeader."No.");
                                            if TransLine.Find('-') then
                                                repeat
                                                    if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 1;
                                                    if (TransLine."Quantity Received" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 2;
                                                until (TransLine.Next = 0) or (DefaultNumber > 0);
                                            if LocSource."Require Shipment" = false then begin
                                                Commit();
                                                TransferPostShipment.Run(TransHeader);
                                                Commit();
                                                TransferPostReceipt.Run(TransHeader);
                                                Commit();
                                            end else begin
                                                if DefaultNumber = 0 then
                                                    DefaultNumber := 1;
                                                Selection := StrMenu(Text000, DefaultNumber);
                                                case Selection of
                                                    0:
                                                        exit;
                                                    Selection::Shipment:
                                                        TransferPostShipment.Run(TransHeader);
                                                    Selection::Receipt:
                                                        TransferPostReceipt.Run(TransHeader);
                                                end;
                                            end;
                                        end;
                                    end;

                                    //kraj
                                end;
                            until LocationREc.Next() = 0;
                    end;


                    //ovdje je kreirana skladišna otpremnica

                    //ovdje sad radim i povrat kroz jednu akciju
                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset.Povrat := true;
                        USset.modify;
                        commit;
                    end;

                    BrojLoc := 0;

                    LocationREc.reset;
                    LocationREc.SetFilter(name, '%1', userid);
                    if LocationREc.findset then
                        repeat

                            LocationREc.delete;
                        until LocationREc.next = 0;
                    Postoji := false;
                    SLine.reset;
                    BRojL := 0;
                    SLine.reset;
                    SLine.setfilter("Document No.", '%1', rec."No.");
                    // SLine.setfilter("Quantity Shipped", '%1', 0);
                    SLine.setfilter("Type", '%1', SLine.type::Item);
                    //  SLine.SetFilter("Shiped Quantity",'%1',0);
                    // SLine.SetFilter("Invoiced Quantity",);
                    SLine.SetCurrentKey("Location Code");
                    if SLine.findset then
                        repeat
                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity", "Shiped Quantity2");

                            if SLine.Quantity < Sline."Shiped Quantity2" then begin
                                DocFIlter.Reset();
                                DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                                DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                                if DocFIlter.FindFirst() then begin
                                    if DocFIlter."CZK Request No." <> '' then
                                        SLine.SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                                    else
                                        SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                                end
                                else begin
                                    SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                                end;

                                if SLine."Invoiced Quantity" > 0 then begin

                                    DocFIlter.Reset();
                                    DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                                    DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                                    if DocFIlter.FindFirst() then begin
                                        SLine.SETRANGE("Shipment No. Filter", SLine."Document No.")

                                    end
                                    else begin
                                        SLine.SETRANGE("Shipment No. Filter", '       ');

                                    end;
                                end
                                else begin

                                    SLine.SETRANGE("Shipment No. Filter", SLine."Document No.");

                                end;

                                if DocFIlter."CZK Request No." <> '' then
                                    Sline.setfilter("Shipment No. Filter", '%1', Sline."Document No.");
                                SLine.CalcFields("Shiped Quantity", "Invoiced Quantity", "Shiped Quantity2");

                                ConnectedRN := '';

                                if SLine."Document No." <> '' then begin

                                    DocFIlter2.Reset();
                                    DocFIlter2.SetFilter("CZK Request No.", '%1', SLine."Document No.");
                                    if DocFIlter2.findset() then
                                        repeat

                                            if DocFIlter2."No." <> SLine."Document No." then
                                                ConnectedRN += DocFIlter2."No." + '|';
                                        until DocFIlter.Next() = 0;

                                    DocFIlter2.Reset();
                                    DocFIlter2.SetFilter("No.", '%1', SLine."Document No.");
                                    if DocFIlter2.FindFirst() then begin

                                        if DocFIlter2."CZK Request No." <> SLine."Document No." then begin
                                            if DocFIlter2."CZK Request No." <> '' then
                                                ConnectedRN := DocFIlter."CZK Request No." + '|';
                                        end;
                                    end;



                                    if rec."CZK Request No." <> '' then begin
                                        DocFIlter2.Reset();
                                        DocFIlter2.SetFilter("CZK Request No.", '%1', rec."CZK Request No.");
                                        if DocFIlter2.findset() then
                                            repeat
                                                if DocFIlter2."No." <> SLine."Document No." then begin

                                                    if strpos(ConnectedRN, DocFIlter2."No.") = 0 then
                                                        ConnectedRN += DocFIlter2."No." + '|';
                                                end;
                                            until DocFIlter.Next() = 0;

                                    end;

                                    if strlen(ConnectedRN) > 2 then
                                        ConnectedRN := CopyStr(ConnectedRN, 1, StrLen(ConnectedRN) - 1);

                                    SLineConnected.reset;
                                    SLineConnected.copyfilters(SLine);
                                    SLineConnected.setfilter("Line No.", '%1', SLine."Line No.");
                                    if SLineConnected.findfirst then begin
                                        if ConnectedRN <> '' then
                                            SLineConnected.SETFILTER("CZK Connected No. Filter", ConnectedRN)
                                        else
                                            SLineConnected.setfilter("CZK Connected No. Filter", '%1', 'Ne postoji');
                                        SLineConnected.calcfields("Connected Quantity");
                                    end;
                                end;

                                //povrat ne radi
                                if ((SLine."Shiped Quantity2" > SLine.Quantity) and (SLine."Shiped Quantity2" <> 0) and (SLine."Invoiced Quantity" = 0)
                                and (SLine."Planned Quantity" > (SLine."Shiped Quantity2" - SLine.Quantity + SLineConnected."Connected Quantity")))
                                or (((SLine."Shiped Quantity2") > 0) and (SLine.Quantity = 0)) then begin

                                    //userid
                                    LocationREc.Reset();
                                    LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                    LocationREc.setfilter(Name, '%1', UserId);
                                    //  LocationREc.setfilter("Invoice Responsible Person", SLine."Location Code");
                                    if not LocationREc.FindFirst() then begin
                                        BRojL := 1;
                                    end
                                    else begin
                                        BRojL := 0;
                                    end;









                                end;
                                if BRojL = 1 then begin
                                    TransferHeader.init;
                                    InvtSetup.get;
                                    Docno := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", TODAY, true);
                                    TransferHeader."No." := Docno;
                                    BRojL += 1;

                                    TransferHeader.Validate("Transfer-from Code", SLine."Location Code");
                                    if SLine."Source Location Code" <> '' then
                                        TransferHeader.Validate("Transfer-to Code", SLine."Source Location Code")

                                    else
                                        TransferHeader.Validate("Transfer-to Code", 'GLAVNO');
                                    //sa glavne na neku drugu
                                    TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                    TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                    TransferHeader.Validate("Sales Header No.", Rec."No.");

                                    UserIdOrg.reset;
                                    UserIdOrg.SetFilter("User ID", '%1', UserId);
                                    if UserIdOrg.FindFirst() then begin
                                        ECL.Reset();
                                        ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                        ecl.SetFilter(Active, '%1', true);
                                        if ecl.FindFirst() then begin
                                            TransferHeader.validate("Department Code", ecl."Department Code");
                                        end;
                                    end;

                                    TransferHeader."RN Source" := rec."RN Source";
                                    rec.CalcFields("Location Name");
                                    TransferHeader.Address := rec."Location Name";
                                    //šifra naloga

                                    LocSource.reset;
                                    LocSource.setfilter("Code", '%1', SLine."Source Location Code");
                                    if LocSource.findfirst then begin
                                        if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                            TransferHeader."Direct Transfer" := false;
                                            TransferHeader.Validate("Employee No.", USset."Employee No. for Wage");
                                        end;
                                    end;
                                    InvtSetup.get;

                                    TransferHeader."Shipment Date" := today;
                                    TransferHeader."Receipt Date" := today;
                                    TransferHeader."Posting Date" := today;
                                    TransferHeader.Insert;
                                    Commit();
                                    LocationREc.Reset();
                                    LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                    LocationREc.setfilter(Name, '%1', UserId);
                                    //  LocationREc.setfilter("Invoice Responsible Person", SLine."Location Code");
                                    if not LocationREc.FindFirst() then begin
                                        LocationREc.init;
                                        LocationREc.Code := SLine."Source Location Code";
                                        LocationREc.name := UserId;
                                        LocationREc."Invoice Responsible Person" := SLine."Location Code";
                                        LocationREc."Responsible Person E Position" := TransferHeader."No.";
                                        LocationREc.insert;
                                    end;

                                    Postoji := true;
                                    commit;
                                end;


                                if ((SLine."Shiped Quantity2" > SLine.Quantity) and (SLine."Shiped Quantity2" <> 0) and (SLine."Invoiced Quantity" = 0)
                                and (SLine."Planned Quantity" > (SLine."Shiped Quantity2" - SLine.Quantity + SLineConnected."Connected Quantity")))
                                or (((SLine."Shiped Quantity2") > 0) and (SLine.Quantity = 0)) then begin
                                    Linija += 10000;

                                    TransferLine.init;
                                    TransferLine.Validate("Document No.", TransferHeader."No.");
                                    TransferLine.Validate("Line No.", SLine."Line No.");
                                    //   TransferLine.Validate("Source Line No.",'%1',SLine."Line No.");
                                    TransferLine.Validate("Item No.", SLine."No.");
                                    TransferLine.Validate("Sales Header No.", rec."No.");


                                    UserIdOrg.reset;
                                    UserIdOrg.SetFilter("User ID", '%1', UserId);
                                    if UserIdOrg.FindFirst() then begin
                                        ECL.Reset();
                                        ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                        ecl.SetFilter(Active, '%1', true);
                                        if ecl.FindFirst() then begin
                                            TransferLine.validate("Department Code", ecl."Department Code");
                                        end;
                                    end;

                                    TransferLine.Validate(Quantity, SLine."Shiped Quantity2" - SLine.Quantity);
                                    TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                    TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                    TransferLine."Qty. to Receive" := TransferLine.Quantity;
                                    TransferLine.Insert(true);
                                    if TransferHeader."G/L Account No." = '' then begin
                                        ItemNoRec.Reset();
                                        ItemNoRec.SetFilter("No.", '%1', SLine."No.");
                                        if ItemNoRec.findfirst then begin
                                            TransferHeader."G/L Account No." := ItemNoRec."Inventory Posting Group";
                                            TransferHeader.modify;
                                        end;
                                    end;
                                    commit;

                                    //lansiraj



                                    SLine."Transfer Order" := TransferHeader."No.";
                                    SLine."Qty. to Ship" := SLine."Shiped Quantity2" - SLine.Quantity;
                                    SLine."Quantity (Base)" := SLine."Shiped Quantity2" - SLine.Quantity;
                                    SLine."Outstanding Qty. (Base)" := SLine."Shiped Quantity2" - SLine.Quantity;
                                    sline."Outstanding Quantity" := SLine."Shiped Quantity2" - SLine.Quantity;
                                    SLine."Quantity (Base)" := SLine."Shiped Quantity2" - SLine.Quantity;

                                    SLine.Modify();
                                end;
                            end;
                        until SLine.next = 0;


                    if Postoji = true then begin
                        SHUpdate.Reset();
                        SHUpdate.SetFilter("No.", '%1', rec."No.");
                        if SHUpdate.FindFirst() then begin
                            SHUpdate."Transfer Order" := TransferHeader."No.";
                            SHUpdate.Modify();
                        end;





                        LocationREc.Reset();
                        LocationREc.SetFilter(name, '%1', UserId);
                        if LocationREc.findset then
                            repeat
                                commit;
                                TransferHeader.get(LocationREc."Responsible Person E Position");
                                RTD.Run(TransferHeader);
                                commit;

                                //sad bih trebala na nalogu za prenos kreirati 

                                commit;//i sada bih trebala reći kreiraj otpremnicu

                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', LocationREc.Code);
                                if LocSource.findfirst then begin

                                    if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin


                                        TransHeader.Copy(TransferHeader);
                                        with TransHeader do begin
                                            TransLine.SetRange("Document No.", TransHeader."No.");
                                            if TransLine.Find('-') then
                                                repeat
                                                    if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 1;
                                                    if (TransLine."Quantity Received" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 2;
                                                until (TransLine.Next = 0) or (DefaultNumber > 0);
                                            if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                                Commit();
                                                BrojLoc += 1;

                                                if BrojLoc > 1 then begin
                                                    USset.Reset();
                                                    USset.setfilter("User ID", '%1', UserId);
                                                    if USset.findfirst then begin
                                                        USset."Undo Shipment" := true;
                                                        USset.modify;
                                                        commit;
                                                    end;
                                                end;
                                                TransferPostShipment.Run(TransHeader);

                                                Commit();
                                                TransferPostReceipt.Run(TransHeader);
                                                Commit();
                                            end else begin
                                                if DefaultNumber = 0 then
                                                    DefaultNumber := 1;
                                                Selection := StrMenu(Text000, DefaultNumber);
                                                case Selection of
                                                    0:
                                                        exit;
                                                    Selection::Shipment:
                                                        TransferPostShipment.Run(TransHeader);
                                                    Selection::Receipt:
                                                        TransferPostReceipt.Run(TransHeader);
                                                end;
                                            end;

                                        end;

                                    end

                                    else begin
                                        BrojLoc += 1;

                                        if BrojLoc > 1 then begin
                                            USset.Reset();
                                            USset.setfilter("User ID", '%1', UserId);
                                            if USset.findfirst then begin
                                                USset."Undo Shipment" := true;
                                                USset.modify;
                                                commit;
                                            end;
                                        end;

                                        TransferPostShipment.Run(TransferHeader);
                                        //ovo bi moralo biti kao otpremi (a potom kreira) s
                                        commit;

                                        GetSourceDocInbound.CreateFromInbndTransferOrder(TransferHeader);
                                        commit;

                                        TransferLine.reset;
                                        TransferLine.SetFilter("Document No.", '%1', TransferHeader."No.");
                                        TransferLine.SetFilter(Quantity, '<>%1', 0);
                                        TransferLine.setfilter("Derived From Line No.", '%1', 0);
                                        if TransferLine.FindSet() then
                                            repeat
                                                commit;
                                                TransferLine.validate("Qty. to Receive", TransferLine.Quantity);
                                                TransferLine.modify;
                                                commit;
                                            until TransferLine.Next() = 0;
                                        commit;
                                    end;

                                    //ovdje je kreirana skladišna otpremnica
                                end;
                            until LocationREc.next = 0;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset.Povrat := false;
                        USset.modify;
                        commit;
                    end;


                    //ovdje bi ja dodala sve što treba kod njih 

                    WShipmentRecord.Reset();
                    WShipmentRecord.SetFilter("Sales Header No.", '%1', rec."No.");
                    if WShipmentRecord.FindFirst() then begin
                        WShipmentPage.SetTableView(WShipmentRecord);
                        commit;
                        WShipmentPage.run;
                    end;


                    WReceiptRecord.Reset();
                    WReceiptRecord.SetFilter("Sales Header No.", '%1', rec."No.");
                    if WReceiptRecord.FindFirst() then begin
                        WarehouseReceiptPage.SetTableView(WReceiptRecord);
                        commit;
                        WarehouseReceiptPage.run;
                    end;
                    //

                    CurrPage.update;

                    //kraj
                end;

            }


            //kraj


            action("Whse. Shi&pments")
            {
                ApplicationArea = Warehouse;
                Caption = 'Whse. Shi&pments';
                Image = Shipment;
                visible = OnlyGeneral;
                RunObject = Page "Whse. Shipment Lines";
                RunPageLink = "Source Type" = CONST(5741),
                                                  "Source Subtype" = CONST("0"),
                                  "Sales Header No." = FIELD("No.");
                RunPageView = SORTING("Source Type", "Source Subtype", "Source No.", "Source Line No.");
                ToolTip = 'View outbound items that have been shipped with warehouse activities for the transfer order.';
            }
            action("S&hipments")
            {
                ApplicationArea = Location;
                Caption = 'S&hipments';
                Image = Shipment;
                Promoted = true;
                visible = false;

                PromotedCategory = Category9;

                RunObject = Page "Posted Transfer Shipments";
                RunPageLink = "Transfer Order No." = FIELD("Transfer Order");
                ToolTip = 'View related posted transfer shipments.';
            }

            action("Undo Shipment")
            {
                ApplicationArea = All;
                Caption = 'Undo Shipment';
                Visible = false;

                trigger OnAction()
                var
                    myInt: Integer;
                    TransferHeader: record "Transfer Header";
                    SLine: record "Service Line";
                    BRojL: integer;
                    Linija: integer;
                    TransferLine: record "Transfer Line";
                    RTD: Codeunit "Release Transfer Document";
                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    Postoji: boolean;
                    SHUpdate: Record "Service Header";
                    DocFIlter: Record "Service Header";
                    UserIdOrg: Record "User Setup";
                    ECL: Record "Employee Contract Ledger";
                    LocSource: record "Location";
                    TransHeader: record "Transfer Header";
                    TransLine: record "Transfer Line";
                    TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
                    TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
                    DefaultNumber: Integer;
                    Selection: Option " ",Shipment,Receipt;
                    Text000: Label '&Ship,&Receive';
                    IsHandled: Boolean;
                    LocationREc: record "Location" temporary;
                    InvtSetup: Record "Inventory Setup";
                    Docno: code[20];
                    NoSeriesMgt: Codeunit NoSeriesExtented;
                    GetSourceDocInbound: Codeunit "Get Source Doc. Inbound";
                    USset: Record "User Setup";
                    BrojLoc: Integer;
                    ItemNoRec: record "Item";



                begin
                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset.Povrat := true;
                        USset.modify;
                        commit;
                    end;

                    BrojLoc := 0;

                    LocationREc.reset;
                    LocationREc.SetFilter(name, '%1', userid);
                    if LocationREc.findset then
                        repeat

                            LocationREc.delete;
                        until LocationREc.next = 0;
                    Postoji := false;
                    SLine.reset;
                    BRojL := 0;
                    SLine.reset;
                    SLine.setfilter("Document No.", '%1', rec."No.");
                    // SLine.setfilter("Quantity Shipped", '%1', 0);
                    SLine.setfilter("Type", '%1', SLine.type::Item);
                    //  SLine.SetFilter("Shiped Quantity",'%1',0);
                    // SLine.SetFilter("Invoiced Quantity",);
                    SLine.SetCurrentKey("Location Code");
                    if SLine.findset then
                        repeat
                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity");

                            DocFIlter.Reset();
                            DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                            DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                            if DocFIlter.FindFirst() then begin
                                if DocFIlter."CZK Request No." <> '' then
                                    SLine.SETRANGE("CZK Request No. Filter", DocFIlter."CZK Request No.")
                                else
                                    SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end
                            else begin
                                SLine.SETRANGE("CZK Request No. Filter", SLine."Document No.");

                            end;

                            if SLine."Invoiced Quantity" > 0 then begin

                                DocFIlter.Reset();
                                DocFIlter.SetFilter("No.", '%1', SLine."Document No.");
                                DocFIlter.SetFilter("Document Type", '%1', "Document Type");
                                if DocFIlter.FindFirst() then begin
                                    SLine.SETRANGE("Shipment No. Filter", DocFIlter."CZK Request No.")

                                end
                                else begin
                                    SLine.SETRANGE("Shipment No. Filter", '       ');

                                end;
                            end
                            else begin

                                SLine.SETRANGE("Shipment No. Filter", SLine."Document No.");

                            end;

                            if DocFIlter."CZK Request No." <> '' then
                                Sline.setfilter("Shipment No. Filter", '%1', Sline."Document No.");
                            SLine.CalcFields("Shiped Quantity", "Invoiced Quantity");



                            if (SLine."Shiped Quantity" > SLine.Quantity) and (SLine."Shiped Quantity" <> 0) and (SLine."Invoiced Quantity" = 0) then begin

                                LocationREc.Reset();
                                LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                LocationREc.setfilter(Name, '%1', UserId);
                                if not LocationREc.FindFirst() then begin
                                    BRojL := 1;
                                end
                                else begin
                                    BRojL := 0;
                                end;
                            end;
                            if BRojL = 1 then begin
                                TransferHeader.init;
                                InvtSetup.get;
                                Docno := NoSeriesMgt.GetNextNo(InvtSetup."Transfer Order Nos.", TODAY, true);
                                TransferHeader."No." := Docno;
                                BRojL += 1;

                                TransferHeader.Validate("Transfer-from Code", SLine."Location Code");
                                if SLine."Source Location Code" <> '' then
                                    TransferHeader.Validate("Transfer-to Code", SLine."Source Location Code")

                                else
                                    TransferHeader.Validate("Transfer-to Code", 'GLAVNO');
                                //sa glavne na neku drugu
                                TransferHeader.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                                TransferHeader.Validate("In-Transit Code", 'TRANZIT');
                                TransferHeader.Validate("Sales Header No.", Rec."No.");

                                UserIdOrg.reset;
                                UserIdOrg.SetFilter("User ID", '%1', UserId);
                                if UserIdOrg.FindFirst() then begin
                                    ECL.Reset();
                                    ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                    ecl.SetFilter(Active, '%1', true);
                                    if ecl.FindFirst() then begin
                                        TransferHeader.validate("Department Code", ecl."Department Code");
                                    end;
                                end;

                                TransferHeader."RN Source" := rec."RN Source";
                                rec.CalcFields("Location Name");
                                TransferHeader.Address := rec."Location Name";
                                //šifra naloga

                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', SLine."Source Location Code");
                                if LocSource.findfirst then begin
                                    if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                        TransferHeader."Direct Transfer" := false;
                                        TransferHeader.Validate("Employee No.", USset."Employee No. for Wage");
                                    end;
                                end;
                                InvtSetup.get;

                                TransferHeader."Shipment Date" := today;
                                TransferHeader."Receipt Date" := today;
                                TransferHeader."Posting Date" := today;
                                TransferHeader.Insert;
                                Commit();
                                LocationREc.Reset();
                                LocationREc.SetFilter(Code, '%1', SLine."Source Location Code");
                                LocationREc.setfilter(Name, '%1', UserId);
                                if not LocationREc.FindFirst() then begin
                                    LocationREc.init;
                                    LocationREc.Code := SLine."Source Location Code";
                                    LocationREc.name := UserId;
                                    LocationREc."Responsible Person E Position" := TransferHeader."No.";
                                    LocationREc.insert;
                                end;

                                Postoji := true;
                                commit;
                            end;


                            if (SLine."Shiped Quantity" > SLine.Quantity) and (SLine."Shiped Quantity" <> 0) then begin
                                Linija += 10000;

                                TransferLine.init;
                                TransferLine.Validate("Document No.", TransferHeader."No.");
                                TransferLine.Validate("Line No.", SLine."Line No.");
                                //   TransferLine.Validate("Source Line No.",'%1',SLine."Line No.");
                                TransferLine.Validate("Item No.", SLine."No.");
                                TransferLine.Validate("Sales Header No.", rec."No.");

                                UserIdOrg.reset;
                                UserIdOrg.SetFilter("User ID", '%1', UserId);
                                if UserIdOrg.FindFirst() then begin
                                    ECL.Reset();
                                    ECL.SetFilter("Employee No.", '%1', UserIdOrg."Employee No. for Wage");
                                    ecl.SetFilter(Active, '%1', true);
                                    if ecl.FindFirst() then begin
                                        TransferLine.validate("Department Code", ecl."Department Code");
                                    end;
                                end;

                                TransferLine.Validate(Quantity, SLine."Shiped Quantity" - SLine.Quantity);
                                TransferLine.validate("Transfer-from Code", TransferHeader."Transfer-from Code");
                                TransferLine.validate("Transfer-to Code", TransferHeader."Transfer-to Code");
                                TransferLine."Qty. to Receive" := TransferLine.Quantity;
                                TransferLine.Insert(true);
                                if TransferHeader."G/L Account No." = '' then begin
                                    ItemNoRec.Reset();
                                    ItemNoRec.SetFilter("No.", '%1', SLine."No.");
                                    if ItemNoRec.findfirst then begin
                                        TransferHeader."G/L Account No." := ItemNoRec."Inventory Posting Group";
                                        TransferHeader.modify;
                                    end;
                                end;
                                commit;

                                //lansiraj



                                SLine."Transfer Order" := TransferHeader."No.";
                                SLine."Qty. to Ship" := SLine."Shiped Quantity" - SLine.Quantity;
                                SLine."Quantity (Base)" := SLine."Shiped Quantity" - SLine.Quantity;
                                SLine."Outstanding Qty. (Base)" := SLine.Quantity;
                                sline."Outstanding Quantity" := sline.Quantity;
                                SLine."Quantity (Base)" := SLine.Quantity;

                                SLine.Modify();
                            end;
                        until SLine.next = 0;


                    if Postoji = true then begin
                        SHUpdate.Reset();
                        SHUpdate.SetFilter("No.", '%1', rec."No.");
                        if SHUpdate.FindFirst() then begin
                            SHUpdate."Transfer Order" := TransferHeader."No.";
                            SHUpdate.Modify();
                        end;





                        LocationREc.Reset();
                        LocationREc.SetFilter(name, '%1', UserId);
                        if LocationREc.findset then
                            repeat
                                commit;
                                TransferHeader.get(LocationREc."Responsible Person E Position");
                                RTD.Run(TransferHeader);
                                commit;

                                //sad bih trebala na nalogu za prenos kreirati 

                                commit;//i sada bih trebala reći kreiraj otpremnicu

                                LocSource.reset;
                                LocSource.setfilter("Code", '%1', LocationREc.Code);
                                if LocSource.findfirst then begin

                                    if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin


                                        TransHeader.Copy(TransferHeader);
                                        with TransHeader do begin
                                            TransLine.SetRange("Document No.", TransHeader."No.");
                                            if TransLine.Find('-') then
                                                repeat
                                                    if (TransLine."Quantity Shipped" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 1;
                                                    if (TransLine."Quantity Received" < TransLine.Quantity) and
                                                       (DefaultNumber = 0)
                                                    then
                                                        DefaultNumber := 2;
                                                until (TransLine.Next = 0) or (DefaultNumber > 0);
                                            if (LocSource."Require Shipment" = false) and (LocSource."Require Receive" = false) then begin
                                                Commit();
                                                BrojLoc += 1;

                                                if BrojLoc > 1 then begin
                                                    USset.Reset();
                                                    USset.setfilter("User ID", '%1', UserId);
                                                    if USset.findfirst then begin
                                                        USset."Undo Shipment" := true;
                                                        USset.modify;
                                                        commit;
                                                    end;
                                                end;
                                                TransferPostShipment.Run(TransHeader);

                                                Commit();
                                                TransferPostReceipt.Run(TransHeader);
                                                Commit();
                                            end else begin
                                                if DefaultNumber = 0 then
                                                    DefaultNumber := 1;
                                                Selection := StrMenu(Text000, DefaultNumber);
                                                case Selection of
                                                    0:
                                                        exit;
                                                    Selection::Shipment:
                                                        TransferPostShipment.Run(TransHeader);
                                                    Selection::Receipt:
                                                        TransferPostReceipt.Run(TransHeader);
                                                end;
                                            end;

                                        end;

                                    end

                                    else begin
                                        BrojLoc += 1;

                                        if BrojLoc > 1 then begin
                                            USset.Reset();
                                            USset.setfilter("User ID", '%1', UserId);
                                            if USset.findfirst then begin
                                                USset."Undo Shipment" := true;
                                                USset.modify;
                                                commit;
                                            end;
                                        end;

                                        TransferPostShipment.Run(TransferHeader);
                                        //ovo bi moralo biti kao otpremi (a potom kreira) s
                                        commit;

                                        GetSourceDocInbound.CreateFromInbndTransferOrder(TransferHeader);
                                        commit;

                                        TransferLine.reset;
                                        TransferLine.SetFilter("Document No.", '%1', TransferHeader."No.");
                                        TransferLine.SetFilter(Quantity, '<>%1', 0);
                                        TransferLine.setfilter("Derived From Line No.", '%1', 0);
                                        if TransferLine.FindSet() then
                                            repeat
                                                commit;
                                                TransferLine.validate("Qty. to Receive", TransferLine.Quantity);
                                                TransferLine.modify;
                                                commit;
                                            until TransferLine.Next() = 0;
                                        commit;
                                    end;

                                    //ovdje je kreirana skladišna otpremnica
                                end;
                            until LocationREc.next = 0;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset."Undo Shipment" := false;
                        USset.modify;
                        commit;
                    end;


                    USset.Reset();
                    USset.setfilter("User ID", '%1', UserId);
                    if USset.findfirst then begin
                        USset.Povrat := false;
                        USset.modify;
                        commit;
                    end;


                    CurrPage.update;

                end;
            }

            action("Process Requests")
            {
                ApplicationArea = All;
                Caption = 'Process Requests';
                Visible = ProcessingDocumentVisible;
                Image = OrderList;
                trigger OnAction()
                begin
                    Rec.ShowProcessRequests();
                end;
            }
            Group(FileAttachment)
            {
                Caption = 'File Attachment', Comment = 'Priložak';
                Visible = Verification;
                action("Import File")
                {
                    ApplicationArea = All;
                    Visible = Verification;
                    Caption = 'Import File', Comment = 'Uvezi datoteku';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ImportFile();
                    end;
                }
                action("Remove File")
                {
                    ApplicationArea = All;
                    Visible = Verification;
                    Caption = 'Remove File', Comment = 'Ukloni datoteku';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        DeleteFile();
                    end;
                }
            }
            Group("Elaborations and Sketches")
            {
                Caption = 'Elaborations and Sketches';
                action("Elaborations")
                {
                    ApplicationArea = All;
                    Visible = GeoGlobal
                    ;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Elaborations';
                    Image = EditLines;
                    RunObject = page "Elaboration Lines";
                    RunPageLink = "Document Type" = const("Order"), "Document No." = field("No.");
                }
                action("Sketches")
                {
                    ApplicationArea = All;
                    Visible = GeoGlobal;
                    Promoted = true;
                    PromotedCategory = Process;
                    Caption = 'Sketches';
                    Image = EditLines;
                    RunObject = page "Sketch Lines";
                    RunPageLink = "Document Type" = const("Order"), "Document No." = field("No.");
                }
            }
        }
    }





    procedure GetLinkedRequests(StartNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: Integer)
    var
        CZKExsist: record "Service Header";
    begin
        // Dodaj početni No.
        TempResultRec.Reset();
        TempResultRec.SetFilter("Message Code", '%1', StartNo);
        if not TempResultRec.findfirst then begin
            TempResultRec.Init();
            TempResultRec."Message Code" := StartNo;
            TempResultRec."ID" := EntryNo;
            EntryNo += 1;
            TempResultRec.Insert();
        end;

        // Pokreni rekurziju
        GetChildRequests(StartNo, TempResultRec, Count);

        CZKExsist.Reset();
        CZKExsist.SetFilter("No.", '%1', StartNo);
        if CZKExsist.findfirst then begin

            if CZKExsist."CZK Request No." <> '' then begin
                TempResultRec.Reset();
                TempResultRec.SetFilter("Message Code", '%1', CZKExsist."CZK Request No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := CZKExsist."CZK Request No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                end;

                // Pokreni rekurziju
                GetChildRequests(CZKExsist."CZK Request No.", TempResultRec, Count);
            end;
        end;

    end;


    local procedure GetChildRequests(ParentNo: Code[20]; var TempResultRec: Record Template_Message temporary; EntryNo: integer)
    var
        MyTable: Record "Service Header";
    begin
        MyTable.Reset();
        MyTable.SetRange("CZK Request No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                TempResultRec.reset;
                TempResultRec.setfilter("Message Code", '%1', MyTable."No.");
                if not TempResultRec.findfirst then begin
                    TempResultRec.Init();
                    TempResultRec."Message Code" := MyTable."No.";
                    TempResultRec."ID" := EntryNo;
                    EntryNo += 1;
                    TempResultRec.Insert();
                    // Rekurzivno idi dalje
                    GetChildRequests(MyTable."No.", TempResultRec, EntryNo);
                end;
            until MyTable.Next() = 0;
        MyTable.Reset();
        MyTable.SetRange("No.", ParentNo);
        if MyTable.FindSet() then
            repeat
                TempResultRec.reset;
                if MyTable."CZK Request No." <> '' then begin
                    TempResultRec.setfilter("Message Code", '%1', MyTable."CZK Request No.");
                    if not TempResultRec.findfirst then begin
                        TempResultRec.Init();
                        TempResultRec."Message Code" := MyTable."CZK Request No.";
                        TempResultRec."ID" := EntryNo;
                        EntryNo += 1;
                        TempResultRec.Insert();
                        // Rekurzivno idi dalje
                        GetChildRequests(MyTable."CZK Request No.", TempResultRec, EntryNo);
                    end;
                end;
            until MyTable.Next() = 0;
    end;

    local procedure ShowPostedConfirmationMessage()
    var
        OrderServiceHeader: Record "Service Header";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        if not OrderServiceHeader.Get("Document Type", "No.") then begin
            ServiceInvoiceHeader.SetRange("No.", ServHeader."Last Posting No.");
            if ServiceInvoiceHeader.FindFirst then
                if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedServiceOrderQst, ServiceInvoiceHeader."No."),
                     InstructionMgt.ShowPostedConfirmationMessageCode)
                then
                    PAGE.Run(PAGE::"Posted Service Invoice", ServiceInvoiceHeader);
        end;
    end;

    local procedure UpdatePage()
    begin
        CurrPage.Update(true);
    end;

    local procedure SetVisibleControls()
    var
        ServiceH: record "Service Header";
    begin
        WorkOrderVisible := false;
        OnlyGeneral := false;
        AllRequest := false;
        RType := true;
        CZKRequestNoVisible := false;
        CZKRequestNoVisibleEmpty2 := false;
        GeneralAll := true;
        GeneralAll2 := true;
        CZKRequestNoVisibleEmpty := false;
        WorkOrdersActionVisible := false;
        ProcessRequestActionVisible := false;
        WorkExecutionVisible := false;
        AttachedDocumentsFactBoxVisible := false;
        AttachedDocumentsFactBoxVisible2 := false;
        InformationOnConnectionVisible := false;
        GeoGlobal := falsE;
        Verification := false;
        ProcessingDocumentVisible := false;
        ElAccordanceVisible := false;
        VisibleE := true;
        GeoWorkOrderVisible := false;
        LocationRouteSpatialPlanVisible := false;
        LocationRouteSpatialPlanInformationVisible := false;
        InformationIssuingRequestVisible := false;
        ProjectOverviewRequestVisible := false;
        WorkExecutionRequestGWO := false;


        if (rec."Request Type" = rec."Request Type"::"Information Issuing Request")
        or (rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request")
        or (rec."Request Type" = rec."Request Type"::"Project overview Request")
        or (rec."Request Type" = rec."Request Type"::"Route Accordance Issuing Request")
        or (rec."Request Type" = rec."Request Type"::"Spatial plan Accordance Issuing Request")
        or (rec."Request Type" = rec."Request Type"::"Work Execution Request") then
            AllRequest := true;

        case Rec."Request Type" of
            Enum::"Request Type"::"Information Issuing Request":
                begin
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                    AttachedDocumentsFactBoxVisible2 := true;
                    ProcessingDocumentVisible := true;
                    InformationIssuingRequestVisible := true;

                end;
            Enum::"Request Type"::"Information on Connection":
                begin
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    WorkOrdersActionVisible := true;
                    InformationOnConnectionVisible := true;
                end;

            Enum::"Request Type"::"General Work Order":
                begin
                    WorkOrderVisible := true;
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    OnlyGeneral := true;

                    if ("CZK Request No." <> '') then begin
                        ServiceH.reset;
                        ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
                        ServiceH.SetFilter("Request type", '%1', ServiceH."Request Type"::"Work Execution Request");

                        if ServiceH.findfirst then
                            WorkExecutionRequestGWO := true
                        else
                            WorkExecutionRequestGWO := false;
                    end;

                end;
            Enum::"Request Type"::"General Geo. Work Order":
                begin
                    WorkOrderVisible := true;
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    OnlyGeneral := false;
                    GeoWorkOrderVisible := true;
                    GeoGlobal := true;

                end;
            Enum::"Request Type"::"Project overview Request":
                begin
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                    ProcessingDocumentVisible := true;
                    ProjectOverviewRequestVisible := true;
                end;
            Enum::"Request Type"::"Project and Energy Accordance":
                begin
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    WorkOrdersActionVisible := true;
                    ElAccordanceVisible := true;
                end;
            Enum::"Request Type"::"UGI Overview and First Release":
                begin
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    AttachedDocumentsFactBoxVisible := true;
                    WorkOrdersActionVisible := true;
                    ProcessRequestActionVisible := true;
                end;
            Enum::"Request Type"::"Location Accordance Issuing Request",
    Enum::"Request Type"::"Route Accordance Issuing Request",
    Enum::"Request Type"::"Spatial plan Accordance Issuing Request":
                begin
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                    ProcessingDocumentVisible := true;
                    LocationRouteSpatialPlanVisible := true;
                end;
            Enum::"Request Type"::"Location Accordance Issuing Information",
    Enum::"Request Type"::"Route Accordance Issuing Information",
    Enum::"Request Type"::"Spatial plan Accordance Issuing Information":
                begin
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    LocationRouteSpatialPlanVisible := true;
                    LocationRouteSpatialPlanInformationVisible := true;
                end;
            Enum::"Request Type"::"Work Execution Request":
                begin
                    WorkExecutionVisible := true;
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                    ProcessingDocumentVisible := true;




                end;


            Enum::"Request Type"::"Others":
                begin
                    RType := false;
                    VisibleE := true;
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                end;

            Enum::"Request Type"::"General Geo. Work Order Office":
                begin
                    WorkOrderVisible := true;
                    OnlyGeneral := false;
                    CZKRequestNoVisible := true;
                    CZKRequestNoVisibleEmpty2 := true;
                    CZKRequestNoVisibleEmpty := true;
                    GeoWorkOrderVisibleOffice := true;
                    GeoGlobal := true;
                end;


        end;
        if (InformationOnConnectionVisible = true) or (ElAccordanceVisible = true) or (WorkOrderVisible = true)
        or (LocationRouteSpatialPlanInformationVisible = true) then
            Verification := true
        else
            Verification := False;
    end;

    local procedure GetEmployeeResponsibleFullName()
    var
        Employee:
                Record Employee;
    begin
        EmployeeResponsibleName := '';
        if Rec."Employee Responsible" = '' then
            exit;
        if not Employee.Get(Rec."Employee Responsible") then
            exit;
        EmployeeResponsibleName := Employee.FullName();
    end;

    local procedure CalculateRest()
    begin
        Rest := Rec.Dued - Rec.Realized;
    end;

    local procedure ImportFile()
    var
        ConfirmAction: Boolean;
        OutStr: OutStream;
        InStr: InStream;
    begin
        ConfirmAction := true;
        Rec.CalcFields("Request File");
        if Rec."Request File".HasValue then
            ConfirmAction := Confirm(StrSubstNo(ConfirmFileImportQst, Rec.FieldCaption("Request File")), false);

        if not ConfirmAction then
            exit;

        UploadIntoStream('', '', ImportFileFilter, Rec."Request File Name", InStr);
        if Rec."Request File Name" = '' then
            exit;

        Rec."Request File".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        CurrPage.Update(true);
    end;

    local procedure DownloadFile()
    var
        InStr: InStream;
    begin
        Rec.CalcFields("Request File");
        if not Rec."Request File".HasValue then
            exit;



        if not Confirm(StrSubstNo(FileDownloadQst, Rec."Request File Name"), false) then
            exit;

        Rec."Request File".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', ImportFileFilter, Rec."Request File Name");
    end;

    local procedure DeleteFile()
    begin
        Rec.CalcFields("Request File");
        if not Rec."Request File".HasValue then
            exit;
        if not Confirm(StrSubstNo(ConfirmFileDeletetQst, Rec."Request File Name"), false) then
            exit;
        Clear(Rec."Request File");
        Rec."Request File Name" := '';
        CurrPage.Update(true);
    end;

    trigger OnAfterGetCurrRecord()
    var
        ServiceH: record "Service Header";
        ServiceHI: record "Service Invoice Header";
        UserSetup: record "User Setup";
    begin
        //    CalcFields("Request Status Real", "Status project", "Request Status general");
        //, "Sent to ZIK", "Received from ZIK");
        calcfields(Status_request, "Due Days Status");
        SetVisibleControls();
        UserSetup.reset;
        UserSetup.setfilter("User ID", '%1', userid);
        if UserSetup.findfirst then begin
            if UserSetup."Allowed to Change Request Type" = true then
                RTypeEditable := true
            else
                RTypeEditable := false;
        end;
        VisibleReport := UserSetup."Visible Report";
        ServiceH.reset;
        ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
        if ServiceH.findfirst then begin
            GeneralAll := true;
            GeneralAll2 := false;

        end
        else begin
            ServiceHI.reset;
            ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
            if ServiceHI.findfirst then begin
                GeneralAll := false;
                GeneralAll2 := true;

            end;


        end;

        if (CZKRequestNoVisibleEmpty = true) or (CZKRequestNoVisibleEmpty2 = true) then begin
            ServiceH.reset;
            ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
            if ServiceH.findfirst then begin
                CZKRequestNoVisibleEmpty := true;
                CZKRequestNoVisibleEmpty2 := false;

            end
            else begin
                ServiceHI.reset;
                ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
                if ServiceHI.findfirst then begin
                    CZKRequestNoVisibleEmpty := false;
                    CZKRequestNoVisibleEmpty2 := true;

                end;


            end;
        end;
        GetEmployeeResponsibleFullName();
        CalculateRest();
        // CalcFields("Responsible Department Name", "Request Department Name");
    end;

    trigger OnAfterGetRecord()
    var
        ServiceH: record "Service Header";
        ServiceHI: record "Service Invoice Header";
        UserSetup: record "User Setup";
    begin
        //  CalcFields("Request Status Real", "Status project", "Request Status general");
        //, "Sent to ZIK", "Received from ZIK");

        UserSetup.reset;
        UserSetup.setfilter("User ID", '%1', userid);
        if UserSetup.findfirst then begin
            if UserSetup."Allowed to Change Request Type" = true then
                RTypeEditable := true
            else
                RTypeEditable := false;
        end;

        VisibleReport := UserSetup."Visible Report";

        calcfields(Status_request, "Due Days Status");
        SetVisibleControls();
        ServiceH.reset;
        ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
        if ServiceH.findfirst then begin
            GeneralAll := true;
            GeneralAll2 := false;

        end
        else begin
            ServiceHI.reset;
            ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
            if ServiceHI.findfirst then begin
                GeneralAll := false;
                GeneralAll2 := true;

            end;


        end;
        if (CZKRequestNoVisibleEmpty = true) or (CZKRequestNoVisibleEmpty2 = true) then begin
            ServiceH.reset;
            ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
            if ServiceH.findfirst then begin
                CZKRequestNoVisibleEmpty := true;
                CZKRequestNoVisibleEmpty2 := false;

            end
            else begin
                ServiceHI.reset;
                ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
                if ServiceHI.findfirst then begin
                    CZKRequestNoVisibleEmpty := false;
                    CZKRequestNoVisibleEmpty2 := true;

                end;


            end;
        end;

        GeoGlobal2 := (Rec."Request Type" = Rec."Request Type"::"General Geo. Work Order");
        IsGeoPartVisible := GeoGlobal2;

        GeoGlobal3 := (Rec."Request Type" = Rec."Request Type"::"General Geo. Work Order") OR (Rec."Request Type" = Rec."Request Type"::"General Geo. Work Order Office");
        IsVisible := GeoGlobal3;

        GetEmployeeResponsibleFullName();
        CalculateRest();
    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
        ServiceH: record "Service Header";
        ServiceHI: record "Service Invoice Header";
    begin
        CalcFields(Status_request, "Due Days Status");
        ServiceH.reset;
        ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
        if ServiceH.findfirst then begin
            GeneralAll := true;
            GeneralAll2 := false;

        end
        else begin
            ServiceHI.reset;
            ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
            if ServiceHI.findfirst then begin
                GeneralAll := false;
                GeneralAll2 := true;

            end;


        end;


        //   CalcFields("Responsible Department Name", "Request Department Name");
        //Request Department Name
        SetVisibleControls();

        //"Sent to ZIK", "Received from ZIK");

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            VisibleReport := UserSetup."Visible Report";
            UserSetup."Request Type" := rec."Request Type";
            UserSetup.Modify();

            if UserSetup."Allowed to Change Request Type" = true then
                RTypeEditable := true
            else
                RTypeEditable := false;
        end;

        if (CZKRequestNoVisibleEmpty = true) or (CZKRequestNoVisibleEmpty2 = true) then begin
            ServiceH.reset;
            ServiceH.setfilter("No.", '%1', rec."CZK Request No.");
            if ServiceH.findfirst then begin
                CZKRequestNoVisibleEmpty := true;
                CZKRequestNoVisibleEmpty2 := false;

            end
            else begin
                ServiceHI.reset;
                ServiceHI.setfilter("Order No.", '%1', rec."CZK Request No.");
                if ServiceHI.findfirst then begin
                    CZKRequestNoVisibleEmpty := false;
                    CZKRequestNoVisibleEmpty2 := true;

                end;


            end;
        end;

    end;


    // permissions on modify EK
    trigger OnModifyRecord(): Boolean

    var

        UserSetupRec: Record "User Setup";

        IsAuthorized: Boolean;

        CanModify: Boolean;

        EmployeeS: Enum "Employee Status Ext";

        RequestType: Enum "Request Type";

    begin


        IsAuthorized := false;



        if (Rec."Request Type" = Rec."Request Type"::"Information Issuing Request") or
           (Rec."Request Type" = Rec."Request Type"::"Project overview Request") or
           (Rec."Request Type" = Rec."Request Type"::"Work Execution Request") or
           (Rec."Request Type" = Rec."Request Type"::"Location Accordance Issuing Request") or
           (Rec."Request Type" = Rec."Request Type"::"Route Accordance Issuing Request") or
           (Rec."Request Type" = Rec."Request Type"::"Spatial plan Accordance Issuing Request") then begin

            UserSetupRec.Reset();
            UserSetupRec.SetFilter("User ID", '%1', UserId);
            if UserSetupRec.FindFirst() then begin

                CanModify := UserSetupRec."CZK User";
                IsAuthorized := true;
            end;

            if not CanModify then begin
                Error('Nemate dozvolu da modifikujete ovaj zahtjev jer niste CZK korisnik.');
            end;

        end

        else begin

            if UserSetupRec.Get(UserId) then begin

                if UserSetupRec."Employee No. for Wage" <> '' then begin

                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', UserSetupRec."Employee No. for Wage");
                    ecl.SetFilter(Active, '%1', true);
                    if ECL.FindFirst() then begin


                        if (ECL."Department Code" = Rec."Request Department") or
                           (ECL."Department Code" = Rec."Responsible Department")
                           then begin
                            IsAuthorized := true;
                        end

                        else
                            if (UserSetupRec."Employee No. for Wage" = Rec."Prep. Process. Empl. No.") or
                               (UserSetupRec."Employee No. for Wage" = Rec."Prep. Contr. Empl. No.") or
                               (UserSetupRec."Employee No. for Wage" = Rec."Prep. Verif. Empl. No.") or
                               (UserSetupRec."Employee No. for Wage" = Rec."Real. Process. Empl. No.") or
                               (UserSetupRec."Employee No. for Wage" = Rec."Real. Verif. Empl. No.") or
                               (UserSetupRec."Employee No. for Wage" = Rec."Real. Contr. Empl. No.") then begin
                                IsAuthorized := true;
                            end;

                        if not IsAuthorized then
                            Error('Modifikacija nije dozvoljena jer nisu pronađeni odgovarajući kriteriji.');

                    end else
                        Error('Nema zapisa u evidenciji stavki ugovora za datu šifru zaposlenika');
                end else
                    Error('Šifra zaposlenika nije unesena');
            end else
                Error('Nema zapisa o postavkama korisnika za trenutnog korisnika.');
        end;

        exit(IsAuthorized);
        if IsAuthorized = false then
            Error('Nije dozvoljena izmjena podataka za Vašeg korisnika. Molimo Vas da se obratite administratorima!');

    end;





    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        CustomerT: Record "Customer Templ.";
        CustomerPage: page "Customer Templ. List";
        UserSetup: Record "User Setup";
        SalesH: Record "Service Header";
        SalesO: page "Request Card";
        SalesOH: Record "Service Header";
        Docno: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;


        SalesSetup: Record "Service Mgt. Setup";

    begin
        SalesSetup.Get();

        CLEAR(CustomerPage);
        CustomerT.Reset();
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin


            UserSetup."Request Type" := rec."Request Type";
            UserSetup.Modify();

        end;

        // CustomerPage.Run();
        CustomerPage.LOOKUPMODE(TRUE);
        IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CustomerPage.GETRECORD(CustomerT);
            "Bill type" := CustomerT.Code;
            "Bill Category" := CustomerT."Bill Category";




            /*       if CustomerT.NN = true then begin

                       SalesH.Init();
                       SalesH."Bill type" := CustomerT.Code;
                       SalesH.Validate("Document Type", SalesH."Document Type"::Order);
                       SalesH.validate("Document Date", Today);
                       SalesH.validate("VAT Date", today);
                       Docno := NoSeriesMgt.GetNextNo(SalesSetup."Order Nos.", TODAY, false);
                       SalesH.Validate("No.", Docno);
                       SalesH.Validate("Assigned User ID", UserId);
                       SalesH.validate("Order Date", today);
                       SalesH.validate("Posting Date", today);
                       SalesH.Validate("Sell-to Customer No.", SalesSetup."NN Customer Code");
                       SalesH.Insert();

                       SalesH.Reset();
                       SalesH.SetFilter("No.", '%1', Docno);
                       CurrPage.Close();
                       SalesO.SetTableView(SalesH);
                       Commit();
                       SalesO.Run();
                       Commit();




                   end;

       */
        END;
    end;

    trigger OnClosePage()
    begin
        TempServiceHeader.Reset();
        if TempServiceHeader.FindSet() then
            repeat
                TempServiceHeader.Delete();
            until TempServiceHeader.Next() = 0;
    end;

    local procedure FillTempServiceHeaderTable()
    var
        SrvcHeader: Record "Service Header";
        ServiceInvHeader: Record "Service Invoice Header";
        MaxID: Integer;
        RequestTypeEnum: ENUM "Request Type";
    begin
        MaxID := 10000;
        TempServiceHeader.Reset();
        if TempServiceHeader.FindSet() then
            repeat
                TempServiceHeader.Delete();
            until TempServiceHeader.Next() = 0;

        SrvcHeader.Reset();
        SrvcHeader.SetRange("Customer No.", Rec."Customer No.");
        SrvcHeader.SetRange("Request Type", RequestTypeEnum::"Information on Connection");
        if SrvcHeader.FindSet() then
            repeat
                TempServiceHeader.Init();
                //TempServiceHeader."ID" := MaxID;
                TempServiceHeader."No." := SrvcHeader."No.";
                TempServiceHeader."Customer No." := SrvcHeader."Customer No.";
                TempServiceHeader."Request Type" := SrvcHeader."Request Type";
                TempServiceHeader."Source Table" := Format(DATABASE::"Service Header");
                TempServiceHeader.Insert();
                Commit();
                MaxID += 1;
            until SrvcHeader.Next() = 0;


        ServiceInvHeader.Reset();
        ServiceInvHeader.SetRange("Customer No.", Rec."Customer No.");
        ServiceInvHeader.SetRange("Request Type", RequestTypeEnum::"Information on Connection");
        if ServiceInvHeader.FindSet() then
            repeat
                TempServiceHeader.Init();
                //TempServiceHeader."ID" := MaxID;
                TempServiceHeader."No." := ServiceInvHeader."No.";
                TempServiceHeader."Customer No." := ServiceInvHeader."Customer No.";
                TempServiceHeader."Request Type" := ServiceInvHeader."Request Type";
                TempServiceHeader."Source Table" := Format(DATABASE::"Service Invoice Header");
                TempServiceHeader.Insert();
                Commit();
                MaxID += 1;
            until ServiceInvHeader.Next() = 0;
    end;


    local procedure "Code_Trošak"(var PassedServLine: Record "Service Line"; var PassedServiceHeader: Record "Service Header")
    var
        ServicePost: Codeunit "Service-Post";
        ConfirmManagement: Codeunit "Confirm Management";
        Ship: Boolean;
        Consume: Boolean;
        Invoice: Boolean;
        HideDialog: Boolean;
        IsHandled: Boolean;
    begin
        if not PassedServiceHeader.Find then
            Error(NothingToPostErr);

        HideDialog := false;
        IsHandled := false;
        if IsHandled then
            exit;

        with PassedServiceHeader do begin
            if not HideDialog then
                case "Document Type" of
                    "Document Type"::Order:
                        begin
                            Selection := 2;

                            Ship := Selection in [1, 3, 4];
                            Consume := Selection in [4];
                            Invoice := Selection in [2, 3];
                        end;
                end;

            ServicePost.SetPreviewMode(false);
            ServicePost.PostWithLines(PassedServiceHeader, PassedServLine, Ship, Consume, Invoice);
        end;


    end;

    local procedure "Code_WH"()
    var
        Invoice: Boolean;
        HideDialog: Boolean;
        IsPosted: Boolean;
    begin
        HideDialog := false;
        IsPosted := false;
        if IsPosted then
            exit;

        with WhseShptLine do begin
            if Find then
                Selection := 2;

            Invoice := (Selection = 2);


            WhsePostShipment.SetPostingSettings(Invoice);
            WhsePostShipment.SetPrint(false);
            WhsePostShipment.Run(WhseShptLine);
            WhsePostShipment.GetResultMessage;
            Clear(WhsePostShipment);
        end;
    end;

    local procedure CheckBeforeRelease(): Boolean
    var
        isValid: Boolean;
        ServiceLine: Record "Service Line";
        ItemCheckAvail: Codeunit TestSubsCu;
    begin
        isValid := true;

        ServiceLine.Reset();
        ServiceLine.SetRange("Document No.", Rec."No.");
        ServiceLine.SetRange("Document Type", Rec."Document Type");
        if ServiceLine.FindSet() then
            repeat
                if (ServiceLine."RN Type" = ServiceLine."RN Type"::Item) AND (ServiceLine."No." <> '') then begin
                    if ItemCheckAvail.ServiceInvLineShowWarning(ServiceLine) then begin
                        ItemNo := ServiceLine."No.";
                        SourceLocationCode := ServiceLine."Source Location Code";
                        isValid := false;
                        exit(isValid);
                    end;
                end;
            until ServiceLine.Next() = 0;

        exit(isValid);
    end;

    procedure PostDocument(var ServiceHeaderSource: Record "Service Header")
    var
        DummyServLine: Record "Service Line" temporary;
    begin

        PostDocumentWithLines(ServiceHeaderSource, DummyServLine);
    end;

    procedure PostDocumentWithLines(var ServiceHeaderSource: Record "Service Header"; var PassedServLine: Record "Service Line")
    var
        ServiceHeader: Record "Service Header";
    begin

        ServiceHeader.Copy(ServiceHeaderSource);
        Code_SH(PassedServLine, ServiceHeader);
        ServiceHeaderSource := ServiceHeader;
    end;

    procedure CopyDocument()
    var
        CopySalesDocument: Report "Copy Service Document SA";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        if IsHandled then
            exit;

        //  CopySalesDocument.SetSalesHeader(Rec);
        //   CopySalesDocument.SetServContractHeader(Rec);
        /*  procedure InitializeRequest(DocumentType: Option; DocumentNo: Code[20])
        begin
            DocType := DocumentType;
            DocNo := DocumentNo;
        end;*/
        //   CopySalesDocument.InitializeRequest(rec."Document Type", rec."No.");
        if rec."Document Type" = rec."Document Type"::"Credit Memo" then begin
            CopySalesDocument.InitializeRequest(rec."Document Type", rec."No.", true, rec."Customer No.");

            CopySalesDocument.RunModal;
        end
        else begin
            CopySalesDocument.InitializeRequest(rec."Document Type", rec."No.", false, rec."Customer No.");

            CopySalesDocument.RunModal;
        end;

    end;


    local procedure Code_SHPost(var SalesHeader: Record "Sales Header"; PostAndSend: Boolean)
    var
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPostViaJobQueue: Codeunit "Sales Post via Job Queue";
        HideDialog: Boolean;
        IsHandled: Boolean;
        DefaultOption: Integer;
    begin
        HideDialog := false;
        IsHandled := false;
        DefaultOption := 3;


        SalesSetup.Get();
        if SalesSetup."Post with Job Queue" and not PostAndSend then
            SalesPostViaJobQueue.EnqueueSalesDoc(SalesHeader)
        else
            CODEUNIT.Run(CODEUNIT::"Sales-Post", SalesHeader);

    end;

    local procedure Code_SH(var PassedServLine: Record "Service Line"; var PassedServiceHeader: Record "Service Header")
    var
        ServicePost: Codeunit ServicePost_2;
        ConfirmManagement: Codeunit "Confirm Management";
        Ship: Boolean;
        Consume: Boolean;
        Invoice: Boolean;
        HideDialog: Boolean;
        IsHandled: Boolean;
        NothingToPostErr: Label 'There is nothing to post.';

    begin
        if not PassedServiceHeader.Find then
            Error(NothingToPostErr);

        HideDialog := false;
        IsHandled := false;
        if IsHandled then
            exit;

        with PassedServiceHeader do begin


            Selection := 2;
            Ship := Selection in [1, 3, 4];
            Consume := Selection in [4];
            Invoice := Selection in [2, 3];


        end;



        ServicePost.SetPreviewMode(false);
        ServicePost.PostWithLines(PassedServiceHeader, PassedServLine, Ship, Consume, Invoice);
    end;




    var
        [InDataSet]
        WorkOrderVisible, WorkExecutionVisible, InformationOnConnectionVisible, ElAccordanceVisible, GeoWorkOrderVisible, LocationRouteSpatialPlanVisible, LocationRouteSpatialPlanInformationVisible, InformationIssuingRequestVisible, ProjectOverviewRequestVisible, Verification, AllRequest, OnlyGeneral : Boolean;
        [InDataSet]
        CZKRequestNoVisible, WorkOrdersActionVisible, ProcessRequestActionVisible, AttachedDocumentsFactBoxVisible, ProcessingDocumentVisible, GeoWorkOrderVisibleOffice, GeoGlobal, GeoGlobal2, GeoGlobal3, IsGeoPartVisible, IsVisible, CZKRequestNoVisibleEmpty, CZKRequestNoVisibleEmpty2, GeneralAll, GeneralAll2 : Boolean;
        Rest: Integer;
        VisibleReport: Boolean;

        WorkExecutionRequestGWO: Boolean;
        VisibleE: Boolean;
        TransferPostShipment: Codeunit "TransferOrder-Post Shipment";
        TransferPostReceipt: Codeunit "TransferOrder-Post Receipt";
        AttachedDocumentsFactBoxVisible2: Boolean;
        ServiceInvoice: Report "ServiceInvoice";
        ShipInvoiceQst: Label '&Ship,Ship &and Invoice';
        EmployeeResponsibleName: Text[100];
        ConfirmFileImportQst: Label '%1 already exists. Do you want to override it?';
        ConfirmFileDeletetQst: Label 'Are you sure that you want to delete %1?';
        ImportFileFilter: Label 'All files (*.*)|*.*', Locked = true;
        FileDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';
        DocumentIsPosted: Boolean;
        RTypeEditable: boolean;
        ServHeader: Record "Service Header";
        RType: Boolean;
        Selection: Integer;
        Selection2: Integer;
        WhseShptLine: Record "Warehouse Shipment Line";
        WhseShptLine2: Record "Warehouse Shipment Line";
        WhsePostShipment: Codeunit "Whse.-Post Shipment_2";
        NothingToPostErr: Label 'There is nothing to post.';
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';
        TempServiceHeader: Record "Temp Service Header";
        ServiceLineDiameterEditability: Boolean;
        ItemNo: Text;
        Text001: Label 'Item %1 has no quantity in the warehouse %2 (Source Location Code). Cannot proceed with the shipment.';
        SourceLocationCode: Text;
        ECL: Record "Employee Contract Ledger";
        UserSetup: Record "User Setup";
        CanModify: Boolean;



}
