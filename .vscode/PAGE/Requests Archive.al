page 50232 "Requests Archived"
{
    ApplicationArea = All;
    Caption = 'Requests';
    PageType = List;
    CardPageId = "Request Card Archive";
    SourceTable = "Service Header Archive";
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
                field("Proforma Paid"; Rec."Proforma Paid")
                {
                    ApplicationArea = All;

                }
                field("Advance Created"; "Advance Created")
                {
                    ApplicationArea = all;

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




    //Empty: 



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
        SetCurrentKey("Document Date");
        Ascending;
        CalcFields("Service Line RN Team", "Service Line RN Team Name", "Service Item Line count", "Location Name", "Due Days Status", "Gas Installation Data", "Service Line RN External", "Service Line RN External Name");
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
    begin
        CountV := rec.Count;
        CalcFields("Service Line RN Team", "Service Line RN Team Name", Status_request, "Service Item Line count", "Location Name", "Gas Installation Data", "Service Line RN External", "Service Line RN External Name");
        VisiblePosting := false;
        SetCurrentKey("Document Date");
        Ascending;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Accounting then
                VisiblePosting := true;
        end;


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




    var
        ConfirmDeleteLbl: Label 'Do you want to continue and delete?', Comment = 'Da li želite nastaviti i brisati?';
        DocumentIsPosted: Boolean;
        WhseShptLine2: Record "Warehouse Shipment Line";
        WhseShptLine: Record "Warehouse Shipment Line";
        CountV: Integer;
        UserSetup: Record "User Setup";
        VisiblePosting: Boolean;
        OpenPostedSalesCrMemoQst: Label 'The credit memo is posted as number %1 and moved to the Posted Sales Credit Memos window.\\Do you want to open the posted credit memo?', Comment = '%1 = posted document number';

        Selection: Integer;
        Selection2: Integer;
        ServHeader: Record "Service Header";
        WhsePostShipment: Codeunit "Whse.-Post Shipment_2";
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

}
