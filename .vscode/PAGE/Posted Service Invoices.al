pageextension 50152 "Posted Service Invoices" extends "Posted Service Invoices"
{
    layout
    {
        // Add changes to page layout here

        addafter("Amount")
        {
            field(VAT; VAT)
            {
                caption = 'VAT Amount';

            }

        }
        modify("Posting Date") { Visible = true; }

        addafter("Location Code")
        {
            field("Fiscal No. Printed"; "Fiscal No. Printed") { }
            // field("Posting Date"; "Posting Date") { }
            field("Fiscal No."; "Fiscal No.") { }
            field("Fiscal DateTime"; "Fiscal DateTime") { }
            field("Fiscal User"; "Fiscal User") { }
            field("Evidential Number"; "Evidential Number") { }
            field("Request Type"; Rec."Request Type")
            {
                ApplicationArea = All;
            }
            field("Bill type"; "Bill type") { }
            field("Municipality Name"; Rec."Municipality Name")
            {
                ApplicationArea = All;
            }
            field("Owner No."; Rec."Owner No.")
            {
                ApplicationArea = All;
            }
            field("Owner Name"; Rec."Owner Name")
            {
                ApplicationArea = All;
            }
            field("Owner Municipality Name"; Rec."Owner Municipality Name")
            {
                ApplicationArea = All;
            }
            field("CZK Request No."; Rec."CZK Request No.")
            {
                ApplicationArea = All;
            }
            field("Request ID"; Rec."Request ID")
            {
                ApplicationArea = All;
            }

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
            field(Excavation_2; Excavation) { Caption = 'Excavation'; }
            field("Excavation Permit"; Rec."Excavation Permit")
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

            }


            field(Classification; Rec.Classification)
            {
                ApplicationArea = All;
            }
            field("Registry No."; Rec."Registry No.")
            {
                ApplicationArea = All;
            }
            field("Entry Person"; Rec."Entry Person")
            {
                ApplicationArea = All;
            }
            field("Change Person"; Rec."Change Person")
            {
                ApplicationArea = All;
            }
            field(Number; Rec.Number)
            {
                ApplicationArea = All;
            }
            field(GeoID; Rec.GeoID)
            {
                ApplicationArea = All;
            }
            field("Registry Code"; Rec."Registry Code")
            {
                ApplicationArea = All;
            }
            field("Archive Date"; Rec."Archive Date")
            {
                ApplicationArea = All;
            }
            field("Entry Date"; Rec."Entry Date")
            {
                ApplicationArea = All;
            }
            field("Change Date"; Rec."Change Date")
            {
                ApplicationArea = All;
            }
            field("Add Description"; "Add Description") { ApplicationArea = all; }


            ///Status Inf


            field(Status_request; Status_request)
            {
                DrillDownPageId = "Status history 2";
                LookupPageId = "Status history 2";
                Visible = true;
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




            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = All;
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
                //Visible = RType;
            }
            field("Designer No."; Rec."Designer No.")
            {
                ApplicationArea = All;
                //Visible = RType;
            }
            field("Designer Name"; Rec."Designer Name")
            {
                ApplicationArea = All;
                //Visible = RType;
            }
            field("Designer Phone No."; Rec."Designer Phone No.")
            {
                ApplicationArea = All;
                //Visible = RType;
            }
            field("Designer Email"; Rec."Designer Email")
            {
                ApplicationArea = All;
                //Visible = RType;
            }
            field("ProcesingDocument"; Rec.GetProcessingDocument())
            {
                Caption = 'Processing Document', Comment = 'Obrada zahtjeva';
                ApplicationArea = All;
                Editable = false;


            }


            field("Prep. Process. Empl. No._2"; Rec."Prep. Process. Empl. No.")
            {
                ApplicationArea = All;
                Caption = 'Prep. Process. Empl. No.';

            }
            field("Prep. Process. Empl. Name."; "Prep. Process. Empl. Name.") { Editable = false; }

            field("Real. Process. Empl. No._2"; Rec."Real. Process. Empl. No.")
            {
                ApplicationArea = All;
                Caption = 'Real. Process. Empl. No.';

            }

            field("Real. Process. Empl. Name"; "Real. Process. Empl. Name") { Editable = false; }


            field("Prep. Contr. Empl. No._2"; Rec."Prep. Contr. Empl. No.")
            {
                ApplicationArea = All;
                Caption = 'Prep. Contr. Empl. No.';

            }


            field("Prep. Contr. Empl. Name"; "Prep. Contr. Empl. Name") { Editable = false; }



            //ĐK   }

            //realization

            //kraj


            field("Real. Contr. Empl. No._2"; Rec."Real. Contr. Empl. No.")
            {
                ApplicationArea = All;
                Caption = 'Real. Contr. Empl. No.';

            }


            field("Real. Contr. Empl. Name"; "Real. Contr. Empl. Name") { Editable = false; }


            //ovo valja:
            field("Prep. Veri. Empl. No._2"; Rec."Prep. Verif. Empl. No.")
            {
                ApplicationArea = All;
                Caption = 'Prep. Verif. Empl. No.';
            }
            field("Prep. Verif. Empl. Name"; "Prep. Verif. Empl. Name") { Editable = false; }
            //




            field("Real. Verif. Empl. No._2"; "Real. Verif. Empl. No.")
            {
                Caption = 'Realisation - Verification Employee No.';


            }
            field("Real. Verif. Empl. Name"; "Real. Verif. Empl. Name") { Editable = false; }


            //kraj

            //nova verzija 2
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
                // Visible = LocationRouteSpatialPlanVisible;
            }

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
            field("Location Name"; "Location Name") { }
            field("Service Item Line count"; "Service Item Line count") { }

            field("CZK Date"; Rec."CZK Date")
            {
                ApplicationArea = All;
                //  Visible = CZKRequestNoVisible;
                Editable = false;
            }
            field("No. for Execution"; "No. for Execution")
            { //Visible = WorkExecutionVisible; 
            }
            field("Date for Execution"; "Date for Execution")
            { //Visible = WorkExecutionVisible; 
            }
            field("First view No."; "First view No.")
            { //Visible = WorkExecutionVisible;
            }
            field("First view date"; "First view date")
            { //Visible = WorkExecutionVisible;
            }



            field("Request Department"; Rec."Request Department")
            {
                ApplicationArea = All;
            }
            field("Request Department Name"; Rec."Request Department Name")
            {
                ApplicationArea = All;
            }
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

            field("Request Sent to Sarajevogas"; Rec."Request Sent to Sarajevogas")
            {
                ApplicationArea = All;
            }
            field("Request Sent to VIK"; Rec."Request Sent to VIK")
            {
                ApplicationArea = All;
            }
            field("Request Sent to Toplane"; Rec."Request Sent to Toplane")
            {
                ApplicationArea = All;
            }
            field("Request Sent to RAD"; Rec."Request Sent to RAD")
            {
                ApplicationArea = All;
            }

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
            field("Work Order Type"; Rec."Work Order Type")
            {
                ApplicationArea = All;
            }
            field("Starting Date"; Rec."Starting Date")
            {
                ApplicationArea = All;
            }
            field("Finishing Date"; Rec."Finishing Date")
            {
                ApplicationArea = All;
            }
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
            }
            field(Activity; Rec.Activity)
            {
                ApplicationArea = All;
            }
            field("Request Group"; Rec."Request Group")
            {
                ApplicationArea = All;
            }
            field("Reason For Service Order"; "Reason For Service Order") { }
            field("Remark For Service Order"; "Remark For Service Order") { }
            field("Work Order Request No."; Rec."Work Order Request No.")
            {
                ApplicationArea = All;
            }
            field("Work Order Requeste Date"; Rec."Work Order Request Date")
            {
                ApplicationArea = All;
            }
            field("Order Time"; Rec."Order Time")
            {
                ApplicationArea = All;
            }
            field("Work Order Emergency"; Rec."Work Order Emergency")
            {
                ApplicationArea = All;
            }
            field(Excavation; Rec.Excavation)
            {
                ApplicationArea = All;
            }
            field("Worksite Activity Type"; Rec."Activity Type")
            {
                ApplicationArea = All;
            }
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
                end;
            }
            field(Realized; Rec.Realized)
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                end;
            }

            field("Realization Date"; Rec."Realisation Date")
            {
                ApplicationArea = All;
            }

            field("Prep. Contr. Empl. No."; Rec."Prep. Contr. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Prep. Process. Empl. No."; Rec."Prep. Process. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Prep. Verif. Empl. No."; Rec."Prep. Verif. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Real. Contr. Empl. No."; Rec."Real. Contr. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Real. Process. Empl. No."; Rec."Real. Process. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Real. Verif. Empl. No."; Rec."Real. Verif. Empl. No.")
            {
                ApplicationArea = All;
                Visible = false;
            }

            field("Activity Type"; Rec."Activity Type")
            {
                ApplicationArea = All;
            }
            field("Geo. Activity Type"; Rec."Geo. Activity Type")
            {
                ApplicationArea = All;
            }
            field("ID Network"; Rec."ID Network")
            {
                ApplicationArea = All;
            }
            field("ID Vertical"; Rec."ID Vertical")
            {
                ApplicationArea = All;
            }
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
            field("Marking Finished"; Rec."Recording/Marking Finished")
            {
                Caption = 'Marking Finished', Comment = 'Obilježavanje završeno';
                ApplicationArea = All;
            }
            field("Marking Method"; Rec."Marking Method")
            {
                ApplicationArea = All;
            }
            field("Marking DGM Total Length"; Rec."DGM Total Length")
            {
                ApplicationArea = All;
            }
            field("Marking PG Total Length"; Rec."PG Total Length")
            {
                ApplicationArea = All;
            }
            field("Marking No. of Connections"; Rec."No. of Connections")
            {
                ApplicationArea = All;
            }
            field("Marking Fully Finished"; Rec."Rec/Marking Fully Finished")
            {
                Caption = 'Marking Fully Finished', Comment = 'Obilježavanje završeno u cijelosti';
                ApplicationArea = All;
            }
            field("Marking Start Date"; Rec."Rec/Marking Start Date")
            {
                Caption = 'Marking Start Date', Comment = 'Vrijeme početka obilježavanja';
                ApplicationArea = All;
            }
            field("Marking End Date"; Rec."Rec/Marking End Date")
            {
                Caption = 'Marking End Date', Comment = 'Vrijeme završetka obilježavanja';
                ApplicationArea = All;
            }


            field("Owner is Customer"; "Owner is Customer") { ApplicationArea = all; Visible = false; }


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
            field(Land; Rec.Land)
            {
                ApplicationArea = All;
            }
            field("SGPO Date El. Installation"; Rec."SGPO Date El. Installation")
            {
                ApplicationArea = All;
            }


            field("Employee Responsible El. Accordance"; Rec."Employee Responsible")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    //  GetEmployeeResponsibleFullName();
                end;
            }

            field("Pickup Date"; Rec."Pickup Date")
            {
                ApplicationArea = All;
            }
            field("Realization Date El. Acc."; Rec."Realisation Date")
            {
                ApplicationArea = All;
            }
            field("Accord No."; Rec."Accord No.")
            {
                ApplicationArea = All;
            }
            field("No. of Project Accordances"; Rec."No. of Project Accordances")
            {
                ApplicationArea = All;
            }
            field("No. of El. Accord. per Project"; Rec."No. of El. Accord. per Project")
            {
                ApplicationArea = All;
            }
            field("Firefight Accordance"; Rec."Firefight Accordance")
            {
                ApplicationArea = All;




            }
            field("Firefight Accordance No."; "Firefight Accordance No.") { }
            field("SGPO Date Fire Protection"; Rec."SGPO Date Fire Protection")
            {
                ApplicationArea = All;
            }

            field("El. Accordance Date"; Rec."El. Accordance Date")
            {
                ApplicationArea = All;
            }
            field("Project Accordance Date"; Rec."Project Accordance Date")
            {
                ApplicationArea = All;
            }
            field("UGI Project Name"; Rec."UGI Project Name")
            {
                ApplicationArea = All;
            }
            field("Service Line Diameter"; Rec."Service Line Diameter")
            {
                ApplicationArea = All;
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
            }
            field("Measure Point Pressure"; Rec."Measure Point Pressure")
            {
                ApplicationArea = All;
            }
            field("Design Company"; Rec."Design Company")
            {
                ApplicationArea = All;
            }
            field("UGI Project Creation Date"; Rec."UGI Project Creation Date")
            {
                ApplicationArea = All;
            }
            field("Information Number"; Rec."Information Number")
            {
                ApplicationArea = All;
                DrillDownPageId = 50189;
            }
            field("Project Accordance"; Rec."Project Accordance")
            {
                ApplicationArea = All;
            }
            field("Chimney Expert Opinion"; Rec."Chimney Expert Opinion")
            {
                ApplicationArea = All;
            }



        }






    }
    actions
    {
        addafter("&Print")
        {

            group(Advance)
            {


                action(CreateAdvance)
                {
                    ApplicationArea = All;
                    Caption = 'CreateAdvance';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    Visible = VisiblePosting;


                    //   Visible = ProcessRequestActionVisible;

                    trigger OnAction()
                    var
                        CustomerPrepayment: Record Customer;
                        CustLedger: Record "Cust. Ledger Entry";

                        SalesHeaderAdvance: Record "Sales Header";
                        SalesSetup: Record "Sales & Receivables Setup";
                        NoSeriesMgt: Codeunit NoSeriesExtented;
                        PostinD: date;
                        Date2: date;

                        CustTemp: Record "Customer Templ.";
                        SalesLine: Record "Sales Line";
                        SalesAdvance: page "Sales Advance Invoice";
                        PostedSalesAdvance: record "Sales Invoice Header";
                        PostedSalesInvoiceLIne: record "Sales Invoice Line";
                        cjlGt: Record "Calculation Journal Line";
                        AbsFill: Codeunit "Absence Fill";
                        FirstDate: Date;
                        FirstDate1: date;
                        LastDate: date;
                        LastDate1: date;
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
                        GetFiltersCOde: Record "Calcuation Header";
                        TempCust: Record "Calcuation Header" temporary;
                        DetailedCust2: Record "Detailed Cust. Ledg. Entry";
                        CustLedgC: Record "Cust. Ledger Entry";
                        CustF: Record "Cust. Ledger Entry";
                        CustCateg: Record Customer;
                        FiltersCust: text;
                        CJLBIll: Record "Cust. Ledger Entry";
                        CJLSum: Record "Calculation Journal Line";
                        LogsAvansiObrada: Record "CJL Logs";
                        CH: Record "Calcuation Header";
                        SIH: Record "Service Invoice Header";




                    begin

                        CH.Reset();
                        CH.SetFilter("Month Of GAS Calculation", '%1', date2dmy(rec."Posting Date", 2));
                        CH.SetFilter("Year Of GAS Calculation", '%1', date2dmy(rec."Posting Date", 3));
                        if CH.findfirst then begin
                            LogsAvansiObrada.reset;
                            LogsAvansiObrada.SetFilter(Purpose, '%1', 'Avansi');
                            LogsAvansiObrada.SetFilter("Billing_Code", '<>%1', CH.code);
                            if LogsAvansiObrada.FindFirst() then
                                LogsAvansiObrada.DeleteAll();

                            Commit();
                            SIH.Reset();
                            SIH.SetFilter("No.", '%1', Rec."No.");
                            Report.Run(50167, true, true, SIH);
                        end;
                    end;
                }
                //greska avansi ispraviti

                action(CreateAdvanceCCorrection)
                {
                    ApplicationArea = All;
                    Caption = 'CreateAdvance';
                    Image = PostOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'F9';
                    Visible = false;


                    //   Visible = ProcessRequestActionVisible;

                    trigger OnAction()
                    var
                        CustomerPrepayment: Record Customer;
                        CustLedger: Record "Cust. Ledger Entry";

                        SalesHeaderAdvance: Record "Sales Header";
                        SalesSetup: Record "Sales & Receivables Setup";
                        NoSeriesMgt: Codeunit NoSeriesExtented;
                        PostinD: date;
                        Date2: date;

                        CustTemp: Record "Customer Templ.";
                        SalesLine: Record "Sales Line";
                        SalesAdvance: page "Sales Advance Invoice";
                        PostedSalesAdvance: record "Sales Invoice Header";
                        PostedSalesInvoiceLIne: record "Sales Invoice Line";
                        cjlGt: Record "Calculation Journal Line";
                        AbsFill: Codeunit "Absence Fill";
                        FirstDate: Date;
                        FirstDate1: date;
                        LastDate: date;
                        LastDate1: date;
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
                        GetFiltersCOde: Record "Calcuation Header";
                        TempCust: Record "Calcuation Header" temporary;
                        DetailedCust2: Record "Detailed Cust. Ledg. Entry";
                        CustLedgC: Record "Cust. Ledger Entry";
                        CustF: Record "Cust. Ledger Entry";
                        CustCateg: Record Customer;
                        FiltersCust: text;
                        CJLBIll: Record "Cust. Ledger Entry";
                        CJLSum: Record "Calculation Journal Line";
                        LogsAvansiObrada: Record "CJL Logs";
                        AdvanceEX: Record "Sales Invoice Header";
                        CustCategory: Record Customer;





                    begin

                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Advance := true;
                            UserSetup.Modify();
                        end;

                        CurrentDate := 20250831D;
                        LogsAvansiObrada.Reset();
                        LogsAvansiObrada.SetFilter(Description, '%1', '@*ISPRAVKA*');
                        if LogsAvansiObrada.FindSet() then
                            repeat

                                DetailedCust2."Amount (LCY)" := 0;
                                DetailedCust2.reset;
                                DetailedCust2.setfilter("Customer No.", '%1', LogsAvansiObrada.Code);
                                DetailedCust2.setfilter("Prepayment", '%1', true);
                                DetailedCust2.SetFilter("Document No.", '%1', 'PS');
                                DetailedCust2.setfilter("Entry Type", '%1', DetailedCust2."Entry Type"::"Initial Entry");
                                CustCategory.Reset();
                                CustCategory.SetFilter("No.", '%1', LogsAvansiObrada.Code);
                                if CustCategory.FindFirst() then
                                    rec."Customer Category" := CustCategory."Customer Category";
                                if rec."Customer Category" = rec."Customer Category"::Household then rec."Bill type" := '03';
                                if rec."Customer Category" = rec."Customer Category"::"Large Economy" then rec."Bill type" := '01';
                                if rec."Customer Category" = rec."Customer Category"::Household then rec."Bill type" := '02';


                                if (rec."Customer Category" = rec."Customer Category"::"Large Economy") or
       (rec."Customer Category" = rec."Customer Category"::"KJKP Heating plant") or (rec."Customer Category" = rec."Customer Category"::"Special Customer") then
                                    DetailedCust2.SetFilter("Bill type", '%1|%2', '01', '1');

                                if (rec."Customer Category" = rec."Customer Category"::Household)
                                                           then
                                    DetailedCust2.SetFilter("Bill type", '%1|%2', '03', '3');

                                if (rec."Customer Category" = rec."Customer Category"::"Small Economy")
                                                           then
                                    DetailedCust2.SetFilter("Bill type", '%1|%2', '02', '2');
                                if DetailedCust2.findfirst then begin
                                    DetailedCust2.calcsums("Amount (LCY)");
                                end;

                                //ovo su nove avansne fakture
                                if abs(DetailedCust2."Amount (LCY)") > 0 then begin

                                    AdvanceEX.Reset();
                                    AdvanceEX.SetFilter(Prepayment, '%1', true);
                                    AdvanceEX.SetFilter("Bill-to Customer No.", '%1', LogsAvansiObrada.Code);
                                    AdvanceEX.SetFilter("Posting Date", '%1', 20250831D);
                                    if not AdvanceEX.FindFirst() then begin

                                        PostinD := today;
                                        SalesSetup.Get();
                                        SalesHeaderAdvance.init;
                                        SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                        SalesHeaderAdvance.Prepayment := TRUE;


                                        SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                                        SalesHeaderAdvance.validate("Sell-to Customer No.", LogsAvansiObrada.Code);
                                        SalesHeaderAdvance.validate("No. Series", SalesSetup."Prepayment Invoice Nos.");
                                        SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                                        SalesHeaderAdvance.validate("Order Date", CurrentDate);
                                        SalesHeaderAdvance.validate("Posting Date", CurrentDate);
                                        SalesHeaderAdvance.validate("Shipment Date", CurrentDate);
                                        SalesHeaderAdvance.validate("VAT Date", CurrentDate);
                                        SalesHeaderAdvance.validate("Bill Category", Rec."Customer Category");
                                        SalesHeaderAdvance.validate("Billing Created", true);
                                        //poredati po kategorijama
                                        //poredati po kategorijama
                                        CustTemp.SetFilter("Bill Category", '%1', Rec."Customer Category");
                                        if CustTemp.FindFirst() then
                                            SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);

                                        if SalesHeaderAdvance."Bill type" = '' then
                                            SalesHeaderAdvance.Validate("Bill type", Rec."Bill type");
                                        SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::Invoice;
                                        SalesHeaderAdvance.Insert();

                                        commit;

                                        //sada dodajem linije

                                        SalesLine."Document No." := SalesHeaderAdvance."No.";
                                        SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                        SalesLine."Line No." := 1000;
                                        SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                        SalesLine.Validate("No.", CustTemp."Advance GK");
                                        //trebam dobiti 79,95 (finalni rezultat)



                                        //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                                        SalesLine.validate(Quantity, 1);
                                        SalesLine.validate("Avans Amount", abs(DetailedCust2."Amount (LCY)"));
                                        //."Balance (LCY)"
                                        //."Balance (LCY)"


                                        SalesLine.Insert();
                                        Commit();

                                        //ĐK    Post_Send(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance);

                                        SalesHeader.Copy(SalesHeaderAdvance);
                                        Code_SHPost(SalesHeader, false);
                                    end;
                                end;

                            until LogsAvansiObrada.Next() = 0;

                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup.Advance := false;
                            UserSetup.Modify();
                        end;
                    end;

                }

                //kraj


                group(Fiscal)
                {
                    Caption = 'Fiscal';
                    Image = Print;


                    /*   group(Fiscal2)
                       {
                           Caption = 'Fiscal2';
                           Image = Print;*/

                    action("Cross section")
                    {
                        Caption = 'Cross section';
                        Image = Print;
                        Promoted = true;
                        PromotedCategory = Report;
                        PromotedIsBig = true;


                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";

                        trigger OnAction()
                        var
                            Genl: Record "General Ledger Setup";
                            CZKf: Record "User Setup";
                            BankAccocunt: Record "Bank Account";
                        begin

                            Genl.get;
                            Putanja := GenL."Path for fiscal printer";

                            CZkF.Get(UserId);
                            BankAccocunt.Reset();
                            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                            if BankAccocunt.findfirst then begin
                                Putanja := BankAccocunt."Path for fiscal printer";

                            end
                            else begin
                                Putanja := GenL."Path for fiscal printer";

                            end;

                            File1.CREATE(Putanja + 'stampatipresjekstanja.xml', TEXTENCODING::UTF8);
                            File1.CREATEOUTSTREAM(OutStreamObj);
                            Plite := '<?xml version="1.0" encoding="utf-8"?>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<BrojZahtjeva>198020</BrojZahtjeva>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<Parametri />';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '</Zahtjev>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            File1.CLOSE;
                            FileManagement.DownloadToFile(Putanja + 'stampatipresjekstanja.xml', Putanja + 'stampatipresjekstanja.xml');
                            COMMIT;


                            //Odgovor('\\SERVER6\Temp2\XML\odgovori\sps');
                        end;
                    }
                    action("Print Daily report")
                    {
                        Caption = 'Print Daily report';
                        Image = Print;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        Promoted = true;
                        PromotedCategory = Report;
                        PromotedIsBig = true;


                        trigger OnAction()
                        var
                            Genl: Record "General Ledger Setup";
                            CZKf: Record "User Setup";
                            BankAccocunt: Record "Bank Account";
                        begin
                            Genl.get;

                            Putanja := GenL."Path for fiscal printer";

                            CZkF.Get(UserId);
                            BankAccocunt.Reset();
                            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
                            if BankAccocunt.findfirst then begin
                                Putanja := BankAccocunt."Path for fiscal printer";

                            end
                            else begin
                                Putanja := GenL."Path for fiscal printer";

                            end;

                            File1.CREATE(Putanja + 'stampatidnevniizvjestaj.xml', TEXTENCODING::UTF8);
                            File1.CREATEOUTSTREAM(OutStreamObj);
                            Plite := '<?xml version="1.0" encoding="utf-8"?>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001FileManagement.DownloadToFile(filename,filename);/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<BrojZahtjeva>61529</BrojZahtjeva>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<VrstaZahtjeva>4</VrstaZahtjeva>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '<Parametri />';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            Plite := '</Zahtjev>';
                            OutStreamObj.WRITETEXT(Plite);
                            OutStreamObj.WRITETEXT();
                            File1.CLOSE;

                            //Odgovor('\\SERVER6\Temp2\XML\odgovori\StampatiDnevniIzvjestaj');
                            FileManagement.DownloadToFile(Putanja + 'stampatidnevniizvjestaj.xml', Putanja + 'stampatidnevniizvjestaj.xml');
                            COMMIT;
                        end;
                    }
                    action("Print Periodic report")
                    {
                        Promoted = true;
                        PromotedCategory = Report;
                        PromotedIsBig = true;


                        Caption = 'Print Periodic report';
                        Image = Print;
                        //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                        //PromotedCategory = "Report";
                        RunObject = Report "Periodic report - fiscal";
                    }
                }


            }
        }
    }

    trigger OnOpenPage()
    var
        VAT: Decimal;
    begin
        CalcFields("Amount Including VAT", Amount);
        VAT := "Amount Including VAT" - "Amount";

        VisiblePosting := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Accounting then
                VisiblePosting := true;
        end;

    end;

    trigger OnAfterGetRecord()
    var
        VAT: Decimal;
    begin
        CalcFields("Amount Including VAT", Amount);

        VAT := "Amount Including VAT" - "Amount";

        VisiblePosting := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Accounting then
                VisiblePosting := true;
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

    var
        VAT: Decimal;
        USsetup: Record "User Setup";
        myInt: Integer;
        Putanja: Text[1000];
        File1: File;
        Plite: Text;
        OutStreamObj: OutStream;
        Periodicreportfiscal: Report "Periodic report - fiscal";
        TXTTab: Char;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text;
        x5: Text;
        X6: Text;
        x1: Text;
        x2: Text;
        x3: Text;
        x4: Text;
        Zamjena: Text;
        ReadLine2: Text;
        VrstaOdgovora: Text;
        strInStream: InStream;
        XMLFileOutStr: OutStream;
        VisiblePosting: Boolean;
        UserSetup: Record "User Setup";
        ToFileName: Text;
        FileManagement: Codeunit "File Management";
}