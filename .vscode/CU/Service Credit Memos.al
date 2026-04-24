pageextension 50158 "Service Credit Memos" extends "Service Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Evidential Number"; "Evidential Number") { }
            field("Request Type"; Rec."Request Type")
            {
                ApplicationArea = All;
            }


            field("Municipality Name"; Rec."Municipality Name")
            {
                ApplicationArea = All;
            }
            field("Owner No."; Rec."Owner No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Owner Name"; Rec."Owner Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Owner Municipality Name"; Rec."Owner Municipality Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("CZK Request No."; Rec."CZK Request No.")
            {
                ApplicationArea = All;
            }
            field("Gas Installation Data"; "Gas Installation Data") { }
            field("Request ID"; Rec."Request ID")
            {
                ApplicationArea = All;
                Visible = false;
            }

            field("Sent to ZIK"; Rec."Sent to ZIK")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Received from ZIK"; Rec."Received from ZIK")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
            }


            field("Processing Date"; Rec."Processing Date")
            {
                Caption = 'Finishing Date', Comment = 'Datum obrade';
                ApplicationArea = All;
            }
            field("Done Date"; Rec."Done Date")
            {
                Caption = 'Done Date', Comment = 'Datum završene obrade';
                ApplicationArea = All;
            }
            field("Request File Name"; Rec."Request File Name")
            {
                ApplicationArea = All;
                Visible = false;

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
                Visible = false;
            }
            field("Change Person"; Rec."Change Person")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
            }
            field("Entry Date"; Rec."Entry Date")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Change Date"; Rec."Change Date")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
                //Visible = RType;
            }
            field("Designer No."; Rec."Designer No.")
            {
                ApplicationArea = All;
                //Visible = RType;
                Visible = false;
            }
            field("Designer Name"; Rec."Designer Name")
            {
                ApplicationArea = All;
                //Visible = RType;
                Visible = false;
            }
            field("Designer Phone No."; Rec."Designer Phone No.")
            {
                ApplicationArea = All;
                //Visible = RType;
                Visible = false;
            }
            field("Designer Email"; Rec."Designer Email")
            {
                ApplicationArea = All;
                //Visible = RType;
                Visible = false;
            }
            field("ProcesingDocument"; Rec.GetProcessingDocument())
            {
                Caption = 'Processing Document', Comment = 'Obrada zahtjeva';
                ApplicationArea = All;
                Editable = false;
                Visible = false;


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
            field("Service Line RN Team"; "Service Line RN Team") { }
            field("Service Line RN Team Name"; "Service Line RN Team Name") { }
            field("Service Line RN External"; "Service Line RN External") { }
            field("Service Line RN External Name"; "Service Line RN External Name") { }



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
                Visible = false;
            }
            field("Street Name"; Rec."Street Name")
            {
                ApplicationArea = All;
            }
            field("Street No."; Rec."Street No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Municipality Code"; Rec."Municipality Code")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
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
                Visible = false;
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
                Visible = false;
            }

            field("Address 2"; Rec."Address 2")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Street 2"; Rec."Street 2")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
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
                Visible = false;
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
                Visible = false;
            }
            field("Last DateTime Modified"; Rec."Last DateTime Modified")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Last Modified by User"; Rec."Last Modified by User")
            {
                ApplicationArea = All;
                Visible = false;
            }






            field("UGI type"; "UGI type") { ApplicationArea = all; Visible = false; }
            field("Execution Company No."; Rec."Execution Company No.")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Execution Company Name"; Rec."Execution Company Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Execution Address"; Rec."Execution Address")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Contractor No"; "Contractor No") { ApplicationArea = all; Visible = false; }
            field("Execution Company Phone No."; Rec."Execution Company Phone No.")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
            }
            field(Welder; Rec.Welder)
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Welder Name"; Rec."Welder Name")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
            }
            field("Service Header UGI"; "Service Header UGI") { }
            field("Service Date UGI"; "Service Date UGI") { }
            field("Welder Atest"; Rec."Welder Atest")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Work Order Type"; Rec."Work Order Type")
            {
                ApplicationArea = All;
                Visible = false;
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

            field("Work Order Emergency"; Rec."Work Order Emergency")
            {
                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
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
                Visible = false;
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
                Visible = false;
            }
            field("Owner Municipality Code"; Rec."Owner Municipality Code")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }

            field("Owner MZ"; Rec."Owner MZ")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Owner MZ Name"; Rec."Owner MZ Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Owner Street"; Rec."Owner Street")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Owner Street Name"; Rec."Owner Street Name")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("Owner Street No."; Rec."Owner Street No.")
            {

                ApplicationArea = All;
                Visible = false;
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
                Visible = false;
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
                Visible = false;
            }
            field("UGI Project Creation Date"; Rec."UGI Project Creation Date")
            {
                ApplicationArea = All;
                Visible = false;
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
        // Add changes to page actions here
        addbefore("P&osting")
        {
            action(NewRequest)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = "Invoicing-MDL-New";
                Caption = 'New';

                trigger OnAction()
                var

                    Filters: text[250];
                    RT: Enum "Request Type";
                    OrdinalValue: Integer;
                    Index: Integer;
                    RTName: Text;
                    CustomerT: Record "Customer Templ.";
                    CustomerPage: page "Customer Templ. List";

                begin

                    CustomerPage.LOOKUPMODE(TRUE);
                    IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        CustomerPage.GETRECORD(CustomerT);
                        "Bill type" := CustomerT.Code;
                        "Bill Category" := CustomerT."Bill Category";
                    end;

                    if GlobalLanguage <> 1033 then
                        GlobalLanguage := 1033;

                    Filters := GetFilter("Request Type");
                    if (Filters <> '') and (rec."Request Type" <> rec."Request Type"::"Others") then begin
                        RT := EnumConvertDemo(filters);

                        if RT <> RT::"Others" then
                            rec."Request Type" := RT;
                    end;
                    GlobalLanguage := 1050;
                    if rec."Request Type" = rec."Request Type"::Others then begin
                        rec."Request Type" := rec."Request Type"::Others;
                    end;

                    //Rec."Request Type":=Filters;
                    CreateAndOpenNewRequest();
                end;
            }
        }
    }
    procedure CreateAndOpenNewRequest()
    var
        ServiceHeader: Record "Service Header";
        NewRequestDialogPage: Page NewRequestDialog;
        DepartmentCode: Code[20];
        Emp_2: code[20];
        Manag: Boolean;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        UseriD_Rec: Record "User Setup";
        Department: Record Department;
        OrgSh: Record "ORG Shema";
        USSetup: Record "User Setup";
        RelationShip: Record "No. Series Relationship";
        US: Record "User Setup";
        CustTemp: Record "Customer Templ.";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin


        if rec."Request Type" = Rec."Request Type"::"Others" then begin
            NewRequestDialogPage.LookupMode := true;
            NewRequestDialogPage.SetOriginNewRequest();
            if NewRequestDialogPage.RunModal = Action::LookupOK then begin
                ServiceHeader.Init();
                ServiceHeader."No." := '';
                ServiceHeader."Verif Done" := false;
                ServiceHeader."Control Done" := false;
                ServiceHeader."Realisation Done" := false;
                NewRequestDialogPage.GetSelectedData(ServiceHeader."Request Type");
                ServiceHeader."Document Type" := Enum::"Service Document Type"::"Credit Memo";
                Rec.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
                ServiceHeader.Excavation := ServiceHeader.Excavation::"No Excavation";

                Manag := false;

                UseriD_Rec.Get(UseriD);
                EmployeeContractLedger.Reset();
                EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
                EmployeeContractLedger.SetFilter(Active, '%1', true);
                if EmployeeContractLedger.FindFirst() then begin
                    if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                        Manag := true
                    else
                        Manag := false;
                end;
                Emp_2 := UseriD_Rec."Employee No. for Wage";

                ServiceHeader."Responsible Department" := DepartmentCode;
                // ServiceHeader."Posting No." := ServiceHeader."No.";

                CustTemp.Reset();
                CustTemp.SetFilter(Code, '%1', ServiceHeader."Bill type");
                if CustTemp.FindFirst() then begin
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if US.FindFirst() then begin

                        RelationShip.Reset();
                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                        RelationShip.SetFilter(code, '%1', CustTemp."Undo Posting No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."Posting No. Series" := CustTemp."Undo Posting No. Series Bill";

                        end;

                        RelationShip.Reset();
                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                        RelationShip.SetFilter(code, '%1', CustTemp."Undo No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."No. Series" := CustTemp."Undo No. Series Bill";

                        end;

                    end;

                    NoSeriesMgt.InitSeries(ServiceHeader."Posting No. Series", '', ServiceHeader."Posting Date", ServiceHeader."Posting No.", ServiceHeader."Posting No. Series");
                    NoSeriesMgt.InitSeries(ServiceHeader."No. Series", '', ServiceHeader."Posting Date", ServiceHeader."No.", ServiceHeader."No. Series");


                end;


                USSetup.Reset();
                USSetup.SetFilter("User ID", '%1', UserId);
                if USSetup.FindFirst() then
                    ServiceHeader.validate("Real. Process. Empl. No.", USSetup."Employee No. for Wage");
                OrgSh.Reset();
                OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                if OrgSh.FindFirst() then begin


                    Department.Reset();
                    Department.SetFilter(Code, '%1', DepartmentCode);
                    Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                    if Department.FindFirst() then
                        ServiceHeader."Responsible Department Name" := Department.Description
                    else
                        ServiceHeader."Responsible Department Name" := '';
                end;
                ServiceHeader."Bill type" := rec."Bill type";
                ServiceHeader."Bill Category" := rec."Bill Category";


                ServiceHeader."Request Department" := DepartmentCode;

                OrgSh.Reset();
                OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
                if OrgSh.FindFirst() then begin


                    Department.Reset();
                    Department.SetFilter(Code, '%1', DepartmentCode);
                    Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                    if Department.FindFirst() then
                        ServiceHeader."Request Department Name" := Department.Description
                    else
                        ServiceHeader."Request Department Name" := '';
                end;
                //da ovdje dodjeli 
                //   ServiceHeader."Posting No." := ServiceHeader."No.";
                // if ServiceHeader."Real. Process. Empl. No." = '' then
                ServiceHeader.validate("Real. Process. Empl. No.", Department."Signatory 1");
                //  if ServiceHeader."Real. Verif. Empl. No." = '' then
                ServiceHeader.validate("Real. Verif. Empl. No.", Department."Signatory 1 Position");
                //  if ServiceHeader."Real. Contr. Empl. No." = '' then
                ServiceHeader.validate("Real. Contr. Empl. No.", Department."Signatory 2");

                ServiceHeader.validate("Prep. Process. Empl. No.", Department."Prip Realisation");
                //  if ServiceHeader."Real. Verif. Empl. No." = '' then
                ServiceHeader.validate("Prep. Contr. Empl. No.", Department."Prip Control");
                //  if ServiceHeader."Real. Contr. Empl. No." = '' then
                ServiceHeader.validate("Prep. Verif. Empl. No.", Department."Prip Verif");


                USSetup.Reset();
                USSetup.SetFilter("User ID", '%1', UserId);
                if USSetup.FindFirst() then
                    ServiceHeader.validate("Real. Process. Empl. No.", USSetup."Employee No. for Wage");

                // ServiceHeader.Excavation:=ServiceHeader.Excavation::"No Excavation";
                ServiceHeader.Insert(true);
                Commit();
                OpenRequestCardPage(ServiceHeader);
            end
        end
        else begin

            ServiceHeader.Init();
            ServiceHeader."No." := '';
            ServiceHeader."Request Type" := rec."Request Type";
            ServiceHeader."Verif Done" := false;
            ServiceHeader."Control Done" := false;
            ServiceHeader."Realisation Done" := false;
            NewRequestDialogPage.GetSelectedData(Rec."Request Type");
            ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
            Rec.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
            Manag := false;

            UseriD_Rec.Get(UseriD);
            EmployeeContractLedger.Reset();
            EmployeeContractLedger.SetFilter("Employee No.", '%1', UseriD_Rec."Employee No. for Wage");
            EmployeeContractLedger.SetFilter(Active, '%1', true);
            if EmployeeContractLedger.FindFirst() then begin
                if (EmployeeContractLedger."Management Level" <> EmployeeContractLedger."Management Level"::E) then
                    Manag := true
                else
                    Manag := false;
            end;
            Emp_2 := UseriD_Rec."Employee No. for Wage";
            USSetup.Reset();
            USSetup.SetFilter("User ID", '%1', UserId);
            if USSetup.FindFirst() then
                ServiceHeader.validate("Real. Process. Empl. No.", USSetup."Employee No. for Wage");

            ServiceHeader."Responsible Department" := DepartmentCode;
            OrgSh.Reset();
            OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
            if OrgSh.FindFirst() then begin


                Department.Reset();
                Department.SetFilter(Code, '%1', DepartmentCode);
                Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                if Department.FindFirst() then
                    ServiceHeader."Responsible Department Name" := Department.Description
                else
                    ServiceHeader."Responsible Department Name" := '';
            end;
            ServiceHeader."Request Department" := DepartmentCode;
            OrgSh.Reset();
            OrgSh.SetFilter(Status, '%1', OrgSh.Status::Active);
            if OrgSh.FindFirst() then begin


                Department.Reset();
                Department.SetFilter(Code, '%1', DepartmentCode);
                Department.SetFilter("ORG Shema", '%1', OrgSh.Code);
                if Department.FindFirst() then
                    ServiceHeader."Request Department Name" := Department.Description
                else
                    ServiceHeader."Request Department Name" := '';
            end;

            //   if ServiceHeader."Real. Process. Empl. No." = '' then
            ServiceHeader.validate("Real. Process. Empl. No.", Department."Signatory 1");
            //  if ServiceHeader."Real. Verif. Empl. No." = '' then
            ServiceHeader.validate("Real. Verif. Empl. No.", Department."Signatory 1 Position");
            // if ServiceHeader."Real. Contr. Empl. No." = '' then
            ServiceHeader.validate("Real. Contr. Empl. No.", Department."Signatory 2");

            ServiceHeader.validate("Prep. Process. Empl. No.", Department."Prip Realisation");
            //  if ServiceHeader."Real. Verif. Empl. No." = '' then
            ServiceHeader.validate("Prep. Contr. Empl. No.", Department."Prip Control");
            //  if ServiceHeader."Real. Contr. Empl. No." = '' then
            ServiceHeader.validate("Prep. Verif. Empl. No.", Department."Prip Verif");

            USSetup.Reset();
            USSetup.SetFilter("User ID", '%1', UserId);
            if USSetup.FindFirst() then
                ServiceHeader.validate("Real. Process. Empl. No.", USSetup."Employee No. for Wage");

            ServiceHeader."Bill type" := rec."Bill type";
            ServiceHeader."Bill Category" := rec."Bill Category";
            // ServiceHeader."Posting No." := ServiceHeader."No.";
            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', ServiceHeader."Bill type");
            if CustTemp.FindFirst() then begin

                //ovdje pronađem proknjiženi format ovog računa

                //  ServiceHeader."Posting No." := ServiceHeader."No.";
                //Đemina dodaj ovdje
                //e sad bi trebala prema tome kojem centru kupca pripadam
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."Undo Posting No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."Posting No. Series" := CustTemp."Undo Posting No. Series Bill";

                    end;

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."Undo No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."No. Series" := CustTemp."Undo No. Series Bill";

                    end;

                end;

                NoSeriesMgt.InitSeries(ServiceHeader."Posting No. Series", '', ServiceHeader."Posting Date", ServiceHeader."Posting No.", ServiceHeader."Posting No. Series");
                NoSeriesMgt.InitSeries(ServiceHeader."No. Series", '', ServiceHeader."Posting Date", ServiceHeader."No.", ServiceHeader."No. Series");


            end;

            ServiceHeader.Insert(true);
            Commit();
            OpenRequestCardPage(ServiceHeader);

        end;
    end;

    local procedure OpenRequestCardPage(var InServiceHeader: Record "Service Header")
    var
        ServiceHeader: Record "Service Header";
    begin
        ServiceHeader := InServiceHeader;
        ServiceHeader.CopyFilters(InServiceHeader);
        ServiceHeader.SetRange("Request Type", InServiceHeader."Request Type");
        ServiceHeader.SetRange("Document Type", InServiceHeader."Document Type");
        Page.Run(Page::"Service Credit Memo", ServiceHeader);
    end;

    procedure EnumConvertDemo(LevelNameInput: text[250]) RTOutput: enum "Request Type"
    var
        Level: Enum "Request Type";
        OrdinalValue: Integer;
        Index: Integer;
        LevelName: Text;


    begin

        //LevelNameInput := 'Location Accordance Issuing Request';
        Index := Level.Names.IndexOf(LevelNameInput); // Index = 3
        if Index <> 0 then begin
            OrdinalValue := Level.Ordinals.Get(Index); // Ordinal value = 30
            Level := Enum::"Request Type".FromInteger(OrdinalValue);
            RTOutput := Level;
        end
        else begin
            RTOutput := RTOutput::"Others";
        end;

    end;

    var
        myInt: Integer;
}