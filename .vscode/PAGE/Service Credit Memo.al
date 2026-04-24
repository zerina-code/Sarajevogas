pageextension 50082 ServiceCreditMemo extends "Service Credit Memo"
{
    layout
    {
        modify(Invoicing) { Visible = false; }
        modify(Shipping) { Visible = false; }
        modify("Foreign Trade") { Visible = false; }
        modify("Post Code") { Visible = false; }
        modify(City) { Visible = false; }
        modify("Address 2") { Visible = false; }


        modify(Address) { Visible = false; }

        modify("Document Date")
        {

            ApplicationArea = All;
            Visible = ProcessRequestActionVisible;

        }
        modify("Posting Date")
        {

            ApplicationArea = All;
            Visible = ProcessRequestActionVisible;

        }


        /*   addafter("No.")
           {

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

           }*/

        addbefore(General)
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
            group(General2)
            {
                Caption = 'General';
                field("No.2"; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
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

                field("Customer No.2"; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Customer No.';
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Name2"; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name';
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

                            rec.Validate("Customer No.", ih."Customer No.");
                            rec."Filters by Measuring point" := ih."Measuring Point Code";
                            commit;
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
                                rec."Filters by Gauge" := ServiceItemLine.rms;
                                CUF.reset;
                                CUF.SetFilter("No.", '%1', ServiceItemLineInit."Customer No.");
                                if CUF.FindFirst() then
                                    ServiceItemLineInit."Customer Name" := CUF.Name;
                                ServiceItemLineInit.Insert();

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
                    field(Address2; Rec.Address)
                    {
                        Caption = 'Address';
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
                    field("Post Code2"; Rec."Post Code")
                    {
                        Caption = 'Post Code';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(City2; Rec.City)
                    {
                        Caption = 'City';
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
                    field("Address 2_2"; Rec."Address 2")
                    {
                        Caption = 'Address 2';
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
                field("RN Source"; "RN Source") { Visible = OnlyGeneral; }

                field("No. for Execution"; "No. for Execution") { Visible = WorkExecutionVisible; }
                field("Date for Execution"; "Date for Execution") { Visible = WorkExecutionVisible; }
                field("First view No."; "First view No.") { Visible = WorkExecutionVisible; }
                field("First view date"; "First view date") { Visible = WorkExecutionVisible; }

                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
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
                field("GEO WorkPlaces Code"; "GEO WorkPlaces Code") { }
                field("GEO WorkPlaces"; "GEO WorkPlaces") { }
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

            group("Worksite Data2")
            {
                Visible = GeoWorkOrderVisibleOffice;
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





                }
                group(PrismO)
                {
                    caption = 'Prism';
                    field("Sokkia 1x-O"; "Sokkia 1x-O") { }
                    field("Zeiss 3x-O"; "Zeiss 3x -O") { }
                    field("Zeiss 1x-O"; "Zeiss 1x-O") { }
                    field("Wild 1x-O"; "Wild 1x-O") { }

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





                }
                group(Prism)
                {
                    Visible = GeoWorkOrderVisible;
                    caption = 'Prism';
                    field("Sokkia 1x"; "Sokkia 1x") { }
                    field("Zeiss 3x"; "Zeiss 3x") { }
                    field("Zeiss 1x"; "Zeiss 1x") { }
                    field("Wild 1x"; "Wild 1x") { }

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





                }
                group(PrismR)
                {
                    caption = 'Prism';
                    field("Sokkia 1x-R"; "Sokkia 1x-R") { }
                    field("Zeiss 3x-R"; "Zeiss 3x -R") { }
                    field("Zeiss 1x-R"; "Zeiss 1x-R") { }
                    field("Wild 1x-R"; "Wild 1x-R") { }

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
        // Add changes to page layout here
        addafter("Document Date")
        {

            field("VAT Date"; "VAT Date")
            {
                ApplicationArea = All;
            }

        }

    }
    actions
    {
        addafter("Post and &Print")
        {

            action(CopyDocument)
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
                    if Get("Document Type", "No.") then;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        CustomerT: Record "Customer Templ.";
        CustomerPage: page "Customer Templ. List";
        UserSetup: Record "User Setup";
        SalesH: Record "Sales Header";
        SalesO: page "Sales Order";
        SalesOH: Record "Sales Header";
        Docno: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;


        SalesSetup: Record "Sales & Receivables Setup";

    begin
        SalesSetup.Get();

        CLEAR(CustomerPage);
        CustomerT.Reset();
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if (UserSetup.Household <> 0) or (UserSetup.Household <> 0) then begin
                CustomerPage.SetTableView(CustomerT);
            end;


        end;

        // CustomerPage.Run();
        CustomerPage.LOOKUPMODE(TRUE);
        IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CustomerPage.GETRECORD(CustomerT);
            "Bill type" := CustomerT.Code;
            "Bill Category" := CustomerT."Bill Category";



            /* if CustomerT.NN = true then begin

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




             end;*/




        END;







    end;

    local procedure CalculateRest()
    begin
        Rest := Rec.Dued - Rec.Realized;
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
        Commit();
        CopySalesDocument.InitializeRequest(rec."Document Type", rec."No.", true, rec."Customer No.");
        Commit();
        CopySalesDocument.RunModal;
    end;

    var

        [InDataSet]
        WorkOrderVisible, WorkExecutionVisible, InformationOnConnectionVisible, ElAccordanceVisible, GeoWorkOrderVisible, LocationRouteSpatialPlanVisible, LocationRouteSpatialPlanInformationVisible, InformationIssuingRequestVisible, ProjectOverviewRequestVisible, Verification, AllRequest, OnlyGeneral : Boolean;
        [InDataSet]
        CZKRequestNoVisible, WorkOrdersActionVisible, ProcessRequestActionVisible, AttachedDocumentsFactBoxVisible, ProcessingDocumentVisible, GeoWorkOrderVisibleOffice, GeoGlobal, GeoGlobal2, IsGeoPartVisible, CZKRequestNoVisibleEmpty, CZKRequestNoVisibleEmpty2, GeneralAll, GeneralAll2 : Boolean;
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
