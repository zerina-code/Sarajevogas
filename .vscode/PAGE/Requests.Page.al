page 50189 Requests
{
    ApplicationArea = All;
    Caption = 'Requests';
    PageType = List;
    SourceTable = "Service Header";
    SourceTableView = where("Document Type" = const("Order"));
    UsageCategory = Lists;
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
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        OpenRequestCardPage(Rec);
                    end;
                }
                field("Evidential Number"; "Evidential Number") { }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
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
                field("Gas Installation Data today"; "Gas Installation Data today")
                {
                }
                field("GID Finish Date"; "GID Finish Date") { }
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

                field(Hod; Hod)
                {
                    Caption = 'Hod';
                    ApplicationArea = All;
                }

                field("Response Date"; "Response Date")
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

                field("Document Date"; Rec."Document Date")
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
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = all;
                }
                field("Due Days Reopen"; "Due Days Reopen") { }
                field("Proforma Paid"; Rec."Proforma Paid")
                {
                    ApplicationArea = All;

                }
                field("Advance Created"; "Advance Created") { ApplicationArea = all; }
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
                field("Order Time"; Rec."Order Time")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Visible = FalsE;
                }
            }
        }
    }
    actions
    {
        area(Processing)
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
            action(DeleteRequest)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = "Invoicing-MDL-Delete";
                Caption = 'Delete';
                trigger OnAction()
                begin
                    DeleteRequests();
                end;
            }

            action("Create Work Order")
            {
                Visible = true;
                Caption = 'Create Work Order';
                ApplicationArea = All;
                Image = Tools;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.CreateAndOpenWorkOrderEmpty();//has commit
                end;
            }

            action("Copy and create Work Order")
            {
                Visible = true;
                Caption = 'Copy and create Work Order';
                ApplicationArea = All;
                Image = Tools;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                begin
                    Rec.CreateAndOpenWorkOrder(false);
                end;
            }

            action(CreateAdvanceCZK)
            {

                ApplicationArea = All;
                Caption = 'Create Advance CZK';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

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
                    filter: Text;
                begin
                    if confirm('Da li ste sigurni da želite kreirati avanse za listu odabranih kupaca') then begin

                        Rec.FINDFIRST;

                        BEGIN
                            filter := Rec.GETFILTERS;

                            REPEAT

                                if rec."Advance Created" = false then begin

                                    SalesHeaderAdvance.init;
                                    SalesSetup.get;
                                    //SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                    SalesHeaderAdvance.Prepayment := TRUE;



                                    SalesHeaderAdvance.validate("Sell-to Customer No.", Rec."Bill-to Customer No.");
                                    SalesHeaderAdvance.validate("No. Series", SalesSetup."Prepayment Invoice Nos.");
                                    SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                                    SalesHeaderAdvance."Bill type" := rec."Bill type";


                                    SalesHeaderAdvance.validate("Order Date", today);
                                    SalesHeaderAdvance.validate("Posting Date", today);
                                    SalesHeaderAdvance.validate("Shipment Date", today);
                                    SalesHeaderAdvance.validate("VAT Date", today);
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
                                    SalesHeaderAdvance.validate("Order Date", today);
                                    SalesHeaderAdvance.validate("Posting Date", today);
                                    SalesHeaderAdvance.validate("Shipment Date", today);
                                    SalesHeaderAdvance.validate("VAT Date", today);
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
                                    Commit();
                                end;
                            until Rec.Next() = 0;
                        end;
                    end;
                end;

            }

            action(CreateCrMemoAdvanceCZK)
            {

                ApplicationArea = All;
                Caption = 'Create Cr. Memo Advance CZK';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


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
                    filter: text;

                begin
                    if confirm('Da li ste sigurni da želite kreirati storno avanse za listu odabranih kupaca') then begin
                        Rec.FINDFIRST;
                        BEGIN
                            filter := Rec.GETFILTERS;

                            REPEAT

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
                            until rec.Next() = 0;
                        end;
                    end;
                end;

            }


            action(PostBilling)
            {
                ApplicationArea = All;
                Caption = 'PostBilling';
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
                    ServHeader: Record "Service Header";
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                    InstructionMgt: Codeunit "Instruction Mgt.";


                    SIL: Record "Service Line";
                    CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";

                    GetSourceDocOutbound: Codeunit "Get Source Doc. Outbound";
                    ReleaseServiceDocument: Codeunit "Release Service Document";
                    SHMore: Record "Service Header";
                    CustLedgerEntry: Record "Cust. Ledger Entry";
                    CustLedgerEntry2: Record "Cust. Ledger Entry";
                    AppliedC: page "Apply Customer Entries";
                    ApplicationDate: date;
                    CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
                    Applied2222: Boolean;
                    DocCounter: Integer;
                    BatchSize: Integer;
                begin

                    DocCounter := 0;
                    BatchSize := 1000;

                    SHMore.Reset();
                    SHMore.CopyFilters(Rec);
                    SHMore.SetFilter("Request Type", '%1', SHMore."Request Type"::"Billing Invoice");
                    SHMore.SetCurrentKey("No.");
                    if SHMore.FindSet() then
                        repeat
                            DocCounter += 1;
                            SIL.reset;
                            sil.SetFilter("Document No.", '%1', SHMore."No.");
                            sil.SetFilter(type, '%1', sil.type::Item);
                            if not sil.FindFirst() then begin
                                ServHeader.Get(SHMore."Document Type", SHMore."No.");
                                ServPostYesNo.PostDocument(ServHeader);
                                DocumentIsPosted := not ServHeader.Get(SHMore."Document Type", SHMore."No.");

                            end
                            else begin

                                ReleaseServiceDocument.PerformManualRelease(SHMore);


                                GetSourceDocOutbound.CreateFromServiceOrder(SHMore);
                                // if not Find('=><') then
                                //      Init;
                                Commit();

                                WhseShptLine2.Reset();
                                WhseShptLine2.SetFilter("Source No.", '%1', SHMore."No.");
                                if WhseShptLine2.FindSet() then
                                    repeat

                                        WhseShptLine.Copy(WhseShptLine2);
                                        "Code_WH";
                                    until WhseShptLine2.next = 0;
                                Commit();
                                ServHeader.Get(SHMore."Document Type", SHMore."No.");
                                PostDocument(servheader);

                                if DocCounter mod BatchSize = 0 then
                                    Commit();

                            end;


                        until SHMore.Next() = 0;
                end;
            }
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


                begin
                    //vidi sve preplate u sistemu.
                    //prvo uraditi storno svih prethodnih avansa
                    CJL.Reset();
                    cjl.SetCurrentKey("Calculation Date To");
                    cjl.Ascending;
                    if cjl.FindLast() then
                        CurrentDate := cjl."Calculation Date To";
                    SifraNew := cjl.Code;

                    /*    CustLedgerEntry.Reset();
                        CustLedgerEntry.SetFilter(Prepayment, '%1', true);
                        CustLedgerEntry.SetFilter("Billing Credit Memo", '%1', false);
                        CustLedgerEntry.SetFilter("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
                        CustLedgerEntry.SetCurrentKey("Entry No.");
                        CustLedgerEntry.Ascending;
                        if CustLedgerEntry.FindLast() then
                            EntryLast := CustLedgerEntry."Entry No."
                        else
                            EntryLast := 0;


                        //storno početnih stanja
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetFilter(Prepayment, '%1', true);
                        CustLedgerEntry.SetFilter("Billing Credit Memo", '%1', false);
                        CustLedgerEntry.SetFilter("Document Type", '%1', CustLedgerEntry."Document Type"::Invoice);
                        CustLedgerEntry.SetFilter("Entry No.", '<=%1', EntryLast);
                        CustLedgerEntry.SetFilter("Posting Date", '%1', 20230831D);
                        if CustLedgerEntry.FindSet() then
                            repeat
                                SalesSetup.get;
                                //sada pripremam storno 

                                SalesHeaderAdvance.init;
                                SalesHeaderAdvance.Prepayment := true;
                                SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Corr. Prepayment Invoice Nos.", PostinD, true);
                                SalesHeaderAdvance.Prepayment := TRUE;

                                CustomerPrepayment.Reset();
                                CustomerPrepayment.SetFilter("No.", '%1', CustLedgerEntry."Customer No.");
                                if CustomerPrepayment.FindFirst() then
                                    SalesHeaderAdvance.validate("No. Series", SalesSetup."Corr. Prepayment Invoice Nos.");
                                SalesHeaderAdvance.validate("Sell-to Customer No.", CustomerPrepayment."No.");
                                SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Cr. Memo Nos.");
                                SalesHeaderAdvance.validate("Order Date", today);
                                SalesHeaderAdvance.validate("Posting Date", today);
                                SalesHeaderAdvance.validate("Shipment Date", today);
                                SalesHeaderAdvance.validate("Bill Category", CustomerPrepayment."Customer Category");
                                SalesHeaderAdvance.validate("Billing Credit Memo", true);
                                //  SalesHeaderAdvance.Validate("Applies-to Doc. Type", SalesHeaderAdvance."Document Type"::Invoice);
                                //  SalesHeaderAdvance.Validate("Applies-to Doc. No.", PostedSalesAdvance."No.");
                                SalesHeaderAdvance."Posting Description" := 'Storno avansne fakture ' + SalesHeaderAdvance."No.";
                                //poredati po kategorijama
                                CustTemp.Reset();
                                CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                if CustTemp.FindFirst() then
                                    SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);



                                SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                SalesHeaderAdvance.Insert();
                                Commit();
                                //sad i linije dodati


                                SalesLine.init;
                                SalesLine."Document No." := SalesHeaderAdvance."No.";

                                SalesLine."Line No." := 1000;
                                SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                SalesLine.Validate("No.", CustTemp."Advance GK");
                                SalesLine.validate(Quantity, 1);
                                //."Balance (LCY)"
                                CustLedgerEntry.CalcFields("Remaining Amount");

                                SalesLine.validate("Unit Price", abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100));
                                SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";

                                SalesLine.Insert();
                                Commit();




                                //proknjižim avansno odobrenje
                                //Đ PROBAJ  PostDocumentSales(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance."No.");
                                SalesHeader.Copy(SalesHeaderAdvance);
                                Code_SHPost(SalesHeader, false);
                                // PostDocument(CODEUNIT::"Sales-Post (Yes/No)");

                                //zavrseno - test
                                CustLedgerEntry."Billing Credit Memo" := true;
                                RecRef.GetTable(CustLedgerEntry);
                                RecordRefExample.ModifyRecords(RecRef);

                                //  CustLedger.Modify();

                                DetailedCust.Reset();
                                DetailedCust.SetFilter("Cust. Ledger Entry No.", '%1', CustLedgerEntry."Entry No.");
                                DetailedCust.SetFilter("Customer No.", '%1', CustLedgerEntry."Customer No.");
                                if DetailedCust.FindSet() then
                                    repeat
                                        DetailedCust."Billing Credit Memo" := true;
                                        RecRef.GetTable(DetailedCust);
                                        RecordRefExample.ModifyRecords(RecRef);
                                    //     DetailedCust.Modify();
                                    until DetailedCust.Next() = 0;

                            until CustLedgerEntry.Next() = 0;

                        //kraj početnih stanja
    */

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        UserSetup.Advance := true;
                        UserSetup.Modify();
                    end;


                    CJL.Reset();
                    CJL.SetFilter("Customer Prepayment", '<>%1', 0);
                    cjl.SetFilter(Code, '%1', SifraNew);
                    if cjl.FindSet() then
                        repeat

                            CustomerPrepayment.Reset();
                            CustomerPrepayment.setfilter("No.", '%1', cjl."Customer No.");

                            if CustomerPrepayment.FindSet() then begin
                                CurrentDateCredit := CalcDate('<-1M>', CurrentDate);
                                FirstDate := AbsFill.GetMonthRange(Date2DMY(CurrentDateCredit, 2), Date2DMY(CurrentDateCredit, 3), true);
                                LastDate := AbsFill.GetMonthRange(Date2DMY(CurrentDateCredit, 2), Date2DMY(CurrentDateCredit, 3), false);
                                //prvo da uradim storno svih avansnih faktura prošli mjesec

                                PostedSalesAdvance.Reset();
                                PostedSalesAdvance.SetFilter("Sell-to Customer No.", '%1', CustomerPrepayment."No.");
                                PostedSalesAdvance.SetFilter("Billing Created", '%1', true);
                                PostedSalesAdvance.SetFilter("Billing Credit Memo", '%1', false);
                                //ĐK naknadno provjeriti datum 
                                PostedSalesAdvance.SetFilter("Posting Date", '%1..%2', FirstDate, LastDate);
                                if PostedSalesAdvance.FindFirst() then begin

                                    PostinD := today;
                                    SalesSetup.Get();
                                    SalesHeaderAdvance.init;
                                    SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Corr. Prepayment Invoice Nos.", PostinD, true);
                                    SalesHeaderAdvance.Prepayment := TRUE;



                                    SalesHeaderAdvance.validate("No. Series", SalesSetup."Corr. Prepayment Invoice Nos.");
                                    SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Cr. Memo Nos.");
                                    SalesHeaderAdvance.validate("Sell-to Customer No.", CustomerPrepayment."No.");
                                    SalesHeaderAdvance.validate("Order Date", PostinD);
                                    SalesHeaderAdvance.validate("Posting Date", PostinD);
                                    SalesHeaderAdvance.validate("Shipment Date", PostinD);
                                    SalesHeaderAdvance.validate("VAT Date", PostinD);
                                    SalesHeaderAdvance.validate("Bill Category", CustomerPrepayment."Customer Category");
                                    SalesHeaderAdvance.validate("Billing Credit Memo", true);
                                    SalesHeaderAdvance.Validate("Applies-to Doc. Type", SalesHeaderAdvance."Document Type"::Invoice);
                                    SalesHeaderAdvance.Validate("Applies-to Doc. No.", PostedSalesAdvance."No.");
                                    SalesHeaderAdvance."Posting Description" := 'Storno avansne fakture ' + SalesHeaderAdvance."No.";
                                    //poredati po kategorijama
                                    CustTemp.Reset();
                                    CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                    if CustTemp.FindFirst() then
                                        SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);



                                    SalesHeaderAdvance."Document Type" := SalesHeaderAdvance."Document Type"::"Credit Memo";
                                    SalesHeaderAdvance.Insert();
                                    Commit();
                                    //sad i linije dodati

                                    PostedSalesInvoiceLIne.reset;
                                    PostedSalesInvoiceLIne.SetFilter("Document No.", '%1', PostedSalesAdvance."No.");
                                    PostedSalesInvoiceLIne.SetFilter("Sell-to Customer No.", '%1', PostedSalesAdvance."Sell-to Customer No.");

                                    if PostedSalesInvoiceLIne.FindSet() then
                                        repeat

                                            SalesLine.init;
                                            SalesLine."Document No." := SalesHeaderAdvance."No.";

                                            SalesLine."Line No." := 1000;
                                            SalesLine."Document Type" := SalesHeaderAdvance."Document Type";
                                            SalesLine.Validate("Type", SalesLine.Type::"G/L Account");
                                            SalesLine.Validate("No.", PostedSalesInvoiceLIne."No.");
                                            SalesLine.validate(Quantity, PostedSalesInvoiceLIne.Quantity);
                                            //."Balance (LCY)"

                                            SalesLine.validate("Unit Price", PostedSalesInvoiceLIne."Unit Price");
                                            SalesLine."Document Type" := SalesLine."Document Type"::"Credit Memo";

                                            SalesLine.Insert();
                                            Commit();

                                        until PostedSalesInvoiceLIne.next = 0;


                                    //proknjižim avansno odobrenje
                                    //Đ PROBAJ  PostDocumentSales(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance."No.");
                                    SalesHeader.Copy(SalesHeaderAdvance);
                                    Code_SHPost(SalesHeader, false);
                                    // PostDocument(CODEUNIT::"Sales-Post (Yes/No)");

                                    //zavrseno - test

                                end;



                                //ovo su nove avansne fakture

                                if abs(cjl."Customer Prepayment") - (cjl.Total) > 0 then begin

                                    PostinD := today;
                                    SalesSetup.Get();
                                    SalesHeaderAdvance.init;
                                    SalesHeaderAdvance."No." := NoSeriesMgt.GetNextNo(SalesSetup."Prepayment Invoice Nos.", PostinD, true);
                                    SalesHeaderAdvance.Prepayment := TRUE;


                                    SalesHeaderAdvance."Posting Description" := 'Avansna Faktura ' + SalesHeaderAdvance."No.";
                                    SalesHeaderAdvance.validate("Sell-to Customer No.", CustomerPrepayment."No.");
                                    SalesHeaderAdvance.validate("No. Series", SalesSetup."Prepayment Invoice Nos.");
                                    SalesHeaderAdvance.validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                                    SalesHeaderAdvance.validate("Order Date", CJL."Calculation Date To");
                                    SalesHeaderAdvance.validate("Posting Date", CJL."Calculation Date To");
                                    SalesHeaderAdvance.validate("Shipment Date", CJL."Calculation Date To");
                                    SalesHeaderAdvance.validate("VAT Date", CJL."Calculation Date To");
                                    SalesHeaderAdvance.validate("Bill Category", CustomerPrepayment."Customer Category");
                                    SalesHeaderAdvance.validate("Billing Created", true);
                                    //poredati po kategorijama
                                    //poredati po kategorijama
                                    CustTemp.SetFilter("Bill Category", '%1', CustomerPrepayment."Customer Category");
                                    if CustTemp.FindFirst() then
                                        SalesHeaderAdvance.Validate("Bill type", CustTemp.Code);


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


                                    SalesLine.validate("Unit Price", (abs(cjl."Customer Prepayment") - (cjl.Total)) / ((1 + SalesLine."VAT %" / 100)));
                                    //abs(CustLedgerEntry."Remaining Amount") / (1 + SalesLine."VAT %" / 100)
                                    SalesLine.validate(Quantity, 1);
                                    //."Balance (LCY)"
                                    //."Balance (LCY)"


                                    SalesLine.Insert();
                                    Commit();

                                    //ĐK    Post_Send(CODEUNIT::"Sales-Post (Yes/No)", SalesHeaderAdvance);

                                    SalesHeader.Copy(SalesHeaderAdvance);
                                    Code_SHPost(SalesHeader, false);
                                end;
                            end;
                        until cjl.Next() = 0;

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        UserSetup.Advance := false;
                        UserSetup.Modify();
                    end;
                    //pr            oknjižila sam avanse (samo provjeriti koje podatke uzimam za avans
                    //proknjižila sam avanse (samo provjeriti koje podatke uzimam za avans


                end;



            }
        }
    }







    procedure Post_Send(PostingCodeunitID: Integer; SalesHe: record "Sales Header")
    begin
        SendToPosting_Advance(PostingCodeunitID, SalesHe);

    end;

    procedure SendToPosting_Advance(PostingCodeunitID: Integer; SalesHe: record "Sales Header") IsSuccess: Boolean
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
    begin

        Commit();
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, RecordId, 0, '');
        IsSuccess := CODEUNIT.Run(PostingCodeunitID, SalesHe);
        if not IsSuccess then
            ErrorMessageHandler.ShowErrors;
    end;





    procedure SendToPosting(PostingCodeunitID: Integer; Doc: code[20]) IsSuccess: Boolean
    var
        ErrorContextElement: Codeunit "Error Context Element";
        ErrorMessageMgt: Codeunit "Error Message Management";
        ErrorMessageHandler: Codeunit "Error Message Handler";
        SCM: Record "Sales Header";
    begin


        Commit();
        ErrorMessageMgt.Activate(ErrorMessageHandler);
        ErrorMessageMgt.PushContext(ErrorContextElement, RecordId, 0, '');
        SCM.Reset();
        SCM.SetFilter("No.", '%1', doc);
        if scm.FindFirst() then begin
            IsSuccess := CODEUNIT.Run(PostingCodeunitID, scm);

        end;
        if not IsSuccess then
            ErrorMessageHandler.ShowErrors;
    end;


    local procedure PostDocumentSales(PostingCodeunitID: Integer; DOcumentNo_Send: code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        OfficeMgt: Codeunit "Office Management";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
        IsScheduledPosting: Boolean;
    begin
        PreAssignedNo := "No.";

        SendToPosting(PostingCodeunitID, DOcumentNo_Send);

        DocumentIsPosted := (not SalesHeader.Get("Document Type", DOcumentNo_Send)) or IsScheduledPosting;

        if IsScheduledPosting then
            CurrPage.Close;
        CurrPage.Update(false);

        if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
            exit;

        if OfficeMgt.IsAvailable then begin
            SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            if SalesCrMemoHeader.FindFirst then
                PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
        end else
            if InstructionMgt.IsEnabled(InstructionMgt.ShowPostedConfirmationMessageCode) then
                ShowPostedConfirmationMessage(PreAssignedNo);
    end;

    local procedure ShowPostedConfirmationMessage(PreAssignedNo: Code[20])
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        InstructionMgt: Codeunit "Instruction Mgt.";
    begin
        SalesCrMemoHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
        if SalesCrMemoHeader.FindFirst then
            if InstructionMgt.ShowConfirm(StrSubstNo(OpenPostedSalesCrMemoQst, SalesCrMemoHeader."No."),
                 InstructionMgt.ShowPostedConfirmationMessageCode)
            then
                PAGE.Run(PAGE::"Posted Sales Credit Memo", SalesCrMemoHeader);
    end;



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
                ServiceHeader."Bill type" := rec."Bill type";
                ServiceHeader."Bill Category" := rec."Bill Category";
                ServiceHeader."No." := '';
                ServiceHeader."Verif Done" := false;
                ServiceHeader."Control Done" := false;
                ServiceHeader."Realisation Done" := false;
                NewRequestDialogPage.GetSelectedData(ServiceHeader."Request Type");
                ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
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
                        RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";

                        end;

                        RelationShip.Reset();
                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                        RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."No. Series" := CustTemp."No. Series Bill";

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
                    RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";

                    end;

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."No. Series" := CustTemp."No. Series Bill";

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

    //Empty: 

    local procedure CreateAndOpenNewRequestEmpty()
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
        GlobalLanguage := 1050;

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
                ServiceHeader."Bill type" := rec."Bill type";
                ServiceHeader."Bill Category" := rec."Bill Category";
                //  if ServiceHeader."Real. Process. Empl. No." = '' then
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

                //     if ServiceHeader."Real. Process. Empl. No." = '' then
                ServiceHeader.validate("Real. Process. Empl. No.", Department."Signatory 1");
                //   if ServiceHeader."Real. Verif. Empl. No." = '' then
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
                        RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";

                        end;

                        RelationShip.Reset();
                        RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                        RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                        if RelationShip.FindFirst() then begin
                            ServiceHeader."No. Series" := RelationShip."Series Code";
                        end
                        else begin
                            ServiceHeader."No. Series" := CustTemp."No. Series Bill";

                        end;

                    end;

                    NoSeriesMgt.InitSeries(ServiceHeader."Posting No. Series", '', ServiceHeader."Posting Date", ServiceHeader."Posting No.", ServiceHeader."Posting No. Series");
                    NoSeriesMgt.InitSeries(ServiceHeader."No. Series", '', ServiceHeader."Posting Date", ServiceHeader."No.", ServiceHeader."No. Series");


                end;

                ServiceHeader.Insert(true);
                Commit();
                OpenRequestCardPage(ServiceHeader);
            end
        end
        else begin

            ServiceHeader.Init();
            ServiceHeader."Verif Done" := false;
            ServiceHeader."Control Done" := false;
            ServiceHeader."Realisation Done" := false;
            ServiceHeader."No." := '';
            ServiceHeader."Request Type" := rec."Request Type";
            NewRequestDialogPage.GetSelectedData(Rec."Request Type");
            ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
            Rec.GetDefaultResponsibleDepartment(DepartmentCode, Manag, Emp_2);
            Manag := false;

            UseriD_Rec.Get(UseriD);
            ServiceHeader.Validate("Real. Process. Empl. No.", UseriD_Rec."Employee No. for Wage");
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

            //     if ServiceHeader."Real. Process. Empl. No." = '' then
            ServiceHeader.validate("Real. Process. Empl. No.", Department."Signatory 1");
            //     if ServiceHeader."Real. Verif. Empl. No." = '' then
            ServiceHeader.validate("Real. Verif. Empl. No.", Department."Signatory 1 Position");
            //    if ServiceHeader."Real. Contr. Empl. No." = '' then
            ServiceHeader.validate("Real. Contr. Empl. No.", Department."Signatory 2");
            ServiceHeader.validate("Prep. Process. Empl. No.", Department."Prip Realisation");
            //  if ServiceHeader."Real. Verif. Empl. No." = '' then
            ServiceHeader.validate("Prep. Contr. Empl. No.", Department."Prip Control");
            //  if ServiceHeader."Real. Contr. Empl. No." = '' then
            ServiceHeader.validate("Prep. Verif. Empl. No.", Department."Prip Verif");

            ServiceHeader."Bill type" := rec."Bill type";
            ServiceHeader."Bill Category" := rec."Bill Category";
            USSetup.Reset();
            USSetup.SetFilter("User ID", '%1', UserId);
            if USSetup.FindFirst() then
                ServiceHeader.validate("Real. Process. Empl. No.", USSetup."Employee No. for Wage");

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
                    RelationShip.SetFilter(code, '%1', CustTemp."Posting No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."Posting No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."Posting No. Series" := CustTemp."Posting No. Series Bill";

                    end;

                    RelationShip.Reset();
                    RelationShip.SetFilter("Series Code", '%1', STRSUBSTNO('*%1*', Us.CZK));
                    RelationShip.SetFilter(code, '%1', CustTemp."No. Series Bill");
                    if RelationShip.FindFirst() then begin
                        ServiceHeader."No. Series" := RelationShip."Series Code";
                    end
                    else begin
                        ServiceHeader."No. Series" := CustTemp."No. Series Bill";

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

    local procedure OpenRequestCardPage(var InServiceHeader: Record "Service Header")
    var
        ServiceHeader: Record "Service Header";
    begin
        ServiceHeader := InServiceHeader;
        ServiceHeader.CopyFilters(InServiceHeader);
        ServiceHeader.SetRange("Request Type", InServiceHeader."Request Type");
        ServiceHeader.SetRange("Document Type", InServiceHeader."Document Type");
        Page.Run(Page::"Request Card", ServiceHeader);
    end;

    local procedure DeleteRequests()
    var
        ServiceHeader: Record "Service Header";
    begin
        CurrPage.SetSelectionFilter(ServiceHeader);
        if Confirm(ConfirmDeleteLbl, false) then
            ServiceHeader.DeleteAll(true);

    end;

    trigger OnOpenPage()
    var
    begin
        // SetCurrentKey("Document Date");
        SetFilter("Today date", '%1', WorkDate());
        //  Ascending;
        CalcFields("Service Line RN Team", "Service Line RN Team Name", "Service Item Line count", "Location Name", "Due Days Status", "Gas Installation Data", "Amount Including VAT", "Gas Installation Data today", "GID Finish Date", "Service Line RN External", "Service Line RN External Name");
        SetPageFilter();
        VisiblePosting := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Accounting then
                VisiblePosting := true;
        end;

        CountV := rec.Count;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        ServItemLine: Record "Service Item Line";
    begin
        CountV := rec.Count;
        CalcFields("Service Line RN Team", "Service Line RN Team Name", Status_request, "Service Item Line count", "Location Name", "Gas Installation Data", "Amount Including VAT", "GID Finish Date", "Gas Installation Data today", "Service Line RN External", "Service Line RN External Name");
        VisiblePosting := false;
        //   SetCurrentKey("Document Date");
        //   Ascending;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Accounting then
                VisiblePosting := true;
        end;

        ServItemLine.Reset();
        ServItemLine.SetRange("Document No.", Rec."No.");
        ServItemLine.SetRange("Document Type", Rec."Document Type");

        if "Service Item Line count" = 1 then begin
            ServItemLine.FindFirst();
            Hod := ServItemLine.Stroke;
        end else
            Hod := 0;


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

    procedure PostDocumentWithLines(var ServiceHeaderSource: Record "Service Header"; var PassedServLine: Record "Service Line")
    var
        ServiceHeader: Record "Service Header";
    begin

        ServiceHeader.Copy(ServiceHeaderSource);
        Code_SH(PassedServLine, ServiceHeader);
        ServiceHeaderSource := ServiceHeader;
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


            Selection := 3;
            Ship := Selection in [1, 3, 4];
            Consume := Selection in [4];
            Invoice := Selection in [2, 3];


        end;



        ServicePost.SetPreviewMode(false);
        ServicePost.PostWithLines(PassedServiceHeader, PassedServLine, Ship, Consume, Invoice);
    end;


    procedure PostDocument(var ServiceHeaderSource: Record "Service Header")
    var
        DummyServLine: Record "Service Line" temporary;
    begin

        PostDocumentWithLines(ServiceHeaderSource, DummyServLine);
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


    procedure SetPageFilter()
    var
    begin
        Rec.SetDepartmentFilter();
    end;

    var
        ConfirmDeleteLbl: Label 'Do you want to continue and delete?', Comment = 'Da li želite nastaviti i brisati?';
        DocumentIsPosted: Boolean;
        WhseShptLine2: Record "Warehouse Shipment Line";
        WhseShptLine: Record "Warehouse Shipment Line";
        CountV: Integer;
        UserSetup: Record "User Setup";
        VisiblePosting: Boolean;
        OpenPostedSalesCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';
        Hod: Integer;
        Selection: Integer;
        Selection2: Integer;
        ServHeader: Record "Service Header";
        WhsePostShipment: Codeunit "Whse.-Post Shipment_2";
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

}
