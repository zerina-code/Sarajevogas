pageextension 50064 PostedServiceInvoice extends "Posted Service Invoice"
{
    layout
    {



        // Add changes to page layout here

        modify(General) { Visible = false; }

        modify(Invoicing)
        { Visible = false; }
        modify(Shipping) { Visible = false; }
        modify("Foreign Trade") { Visible = false; }




        addafter(General)
        {
            // cuegroup(General2)
            // {
            //   Caption = 'General2';

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
                field("Excavation Permit"; Rec."Excavation Permit")
                {
                    ApplicationArea = All;
                }
                field("Legal Property Note"; Rec."Legal Property Note")
                {
                    ApplicationArea = All;
                }
                field("Employee Responsible"; Rec."Employee Responsible")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        GetEmployeeResponsibleFullName();
                    end;
                }
                field(EmployeeResponsibleName; EmployeeResponsibleName)
                {
                    Caption = 'Employee Responsible Name', Comment = 'Ime zaposlenika';
                    ApplicationArea = All;
                    Editable = false;
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
            group("Information On Location,Route,Plan")
            {
                Caption = 'Processing Request', Comment = 'Obrada zahtjeva';
                Visible = LocationRouteSpatialPlanInformationVisible;


                field("Employee Responsible Loc,Route,Plan"; Rec."Employee Responsible")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        GetEmployeeResponsibleFullName();
                    end;
                }
                field(EmployeeResponsibleNameLocRoutePlan; EmployeeResponsibleName)
                {
                    Caption = 'Employee Responsible Name', Comment = 'Ime zaposlenika';
                    ApplicationArea = All;
                    Editable = false;
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
            }
            group(General3)
            {
                Caption = 'General';
                field("No.2"; Rec."No.")
                {
                    Caption = 'No.'
;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Add Description"; "Add Description") { ApplicationArea = all; }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Status"; Rec.Status_request)
                {
                    ApplicationArea = All;

                    //
                    /* trigger OnDrillDown()
                     var
                         myInt: Integer;
                         StatusH: Record "Status History";
                         StatusHPage: Page "Status history";
                         US: Record "User Setup";
                     begin
                         if rec."Request Type" = rec."Request Type"::"Information Issuing Request" then begin

                             StatusH.Reset();
                             StatusH.SETFILTER(Type, '%1', StatusH.Type::Request);
                             StatusH.SetFilter("Request No.", '%1', rec."Order No.");
                             us.Reset();
                             us.SetFilter("User ID", '%1', UserId);
                             if us.FindFirst() then begin
                                 us."Status History" := us."Status History"::Request;
                                 us.Modify();
                             end;

                             StatusHPage.SetTableView(StatusH);
                             StatusHPage.Run();


                         end;


                         CurrPage.UPDATE;


                     end;


                     trigger Onlookup(var Text: Text): Boolean
                     var

                         myInt: Integer;
                         StatusH: Record "Status History";
                         StatusHPage: Page "Status history";
                         US: Record "User Setup";
                     begin
                         if rec."Request Type" = rec."Request Type"::"Information Issuing Request" then begin

                             StatusH.Reset();
                             StatusH.SETFILTER(Type, '%1', StatusH.Type::Request);
                             StatusH.SetFilter("Request No.", '%1', rec."Order No.");
                             us.Reset();
                             us.SetFilter("User ID", '%1', UserId);
                             if us.FindFirst() then begin
                                 us."Status History" := us."Status History"::Request;
                                 us.Modify();
                             end;

                             StatusHPage.SetTableView(StatusH);
                             StatusHPage.Run();


                         end;


                         CurrPage.UPDATE;


                     end;*/


                }

                field("Customer No.2"; Rec."Customer No.")
                {
                    Caption = 'Customer No.2';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Name2"; Rec."Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name2';
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
                }
                field("Designer No."; Rec."Designer No.")
                {
                    ApplicationArea = All;
                }
                field("Designer Name"; Rec."Designer Name")
                {
                    ApplicationArea = All;
                }
                field("Designer Phone No."; Rec."Designer Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Designer Email"; Rec."Designer Email")
                {
                    ApplicationArea = All;
                }
                field("ProcesingDocument"; GetProcessingDocument())
                {
                    Caption = 'Processing Document', Comment = 'Obrada zahtjeva';
                    ApplicationArea = All;
                    Editable = false;
                    Visible = ProcessingDocumentVisible;
                    trigger OnDrillDown()
                    begin
                        OpenRequestDocumentCard(GetProcessingDocument());
                    end;
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
                        Caption = 'Addres 2';
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
                        Caption = 'Post Code 2';
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field(City2; Rec.City)
                    {
                        Caption = 'City2';
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
                }
                field("CZK Date"; Rec."CZK Date")
                {
                    ApplicationArea = All;
                    Visible = CZKRequestNoVisible;
                }
                field("Request ID"; Rec."Request ID")
                {
                    ApplicationArea = All;
                }
                field("Document Date2"; Rec."Document Date")
                {
                    Caption = 'Document Date';
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
                field("Due Date2"; "Due Date")
                {
                    ApplicationArea = all;
                    Caption = 'Due Date';
                }
                field("Fiscal No. Printed"; "Fiscal No. Printed") { Editable = true; }
                field("Fiscal No."; "Fiscal No.") { Editable = true; }
                field("Fiscal DateTime"; "Fiscal DateTime") { Editable = true; }
                field("Fiscal User"; "Fiscal User") { Editable = true; }
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
                Visible = LocationRouteSpatialPlanVisible;
                Caption = 'Request Refferring Data', Comment = 'Podaci o upućivanju zahtjeva';
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
            }
            group("Work Execution Data")
            {
                Visible = WorkExecutionVisible;
                Caption = 'Work Execution Data', Comment = 'Podaci o izvođenju radova';
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
                field("According to Legislation"; Rec."According to Legislation")
                {
                    ApplicationArea = All;
                }
                field("Welder Atest"; Rec."Welder Atest")
                {
                    ApplicationArea = All;
                }

            }
            group("Work Order Data")
            {
                Visible = WorkOrderVisible;
                Caption = 'Work Order Data', Comment = 'Podaci o radnog nalogu';
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
            }
            group("UGI Data")
            {
                Visible = WorkOrderVisible;
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
                }
                field("Real. Process. Empl. No."; Rec."Real. Process. Empl. No.")
                {
                    ApplicationArea = All;
                }
                field("Real. Verif. Empl. No."; Rec."Real. Verif. Empl. No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Worksite Data")
            {
                Visible = WorkOrderVisible;
                Caption = 'Worksite Data', Comment = 'Podaci o radilištu';
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
                Visible = WorkOrderVisible;
                Caption = 'Routing Data', Comment = 'Podaci o trasiranju';
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

            }

            group("Recording Data")
            {
                Visible = WorkOrderVisible;
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

            group("Owner Data")
            {
                Caption = 'Owner Data';
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
                field(NC; NC)
                {
                    ApplicationArea = All;
                }
                field("Catastral Municipality"; "Catastral Municipality")
                {
                    DrillDownPageId = 50140;
                    LookupPageId = 50140;
                    Visible = false;
                }
                field("Catastral Municipality Name"; "Catastral Municipality Name")
                {
                    DrillDownPageId = 50140;
                    LookupPageId = 50140;
                    Visible = false;
                }
            }
            group("El. Accordance")
            {
                Caption = 'El. Accordance', Comment = 'UGI Projekat i el. saglasnost';
                Visible = ElAccordanceVisible;

                field("SGPO Date El. Installation"; Rec."SGPO Date El. Installation")
                {
                    ApplicationArea = All;
                }
                field("SGPO Date Fire Protection"; Rec."SGPO Date Fire Protection")
                {
                    ApplicationArea = All;
                }

                field("Employee Responsible El. Accordance"; Rec."Employee Responsible")
                {
                    ApplicationArea = All;
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
                field("Connection to"; "Connection to") { }
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


            part("GEO part"; "GEO Part")
            {
                Visible = GeoWorkOrderVisible;
                subpagelink = "Document No." = field("No.");
            }

            group(O)
            {
                caption = 'O';
                Visible = GeoWorkOrderVisible;
                field("Spray -O"; "Spray -O") { }
                field("Harpoon -O"; "Harpoon -O") { }
                field("Bolcna -O"; "Bolcna -O") { }
                field("Palette -O"; "Palette -O") { }

            }

            group(Material)
            {
                caption

            = 'Material';
                Visible = GeoWorkOrderVisible;

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


            group(Used_equipment_O)
            {
                Visible = GeoWorkOrderVisible;
                caption = 'Used equipment (O)';

                group(InstrumentO)
                {
                    caption = 'Instrument';
                    Visible = GeoWorkOrderVisible;
                    field("Trimble M3-O"; "Trimble M3 -O") { }
                    field("Sokkia SET2030-O"; "Sokkia SET2030 -O") { }
                    field("Zeiss REC ELTA 15 -O"; "Zeiss REC ELTA 15 -O") { }
                    field("GPS L1 - Promark 3 -O"; "GPS L1 - Promark 3 -O") { }
                    field("GPS - Others -O"; "GPS - Others - O") { }
                    field("GPS TRIMBLE R8S -O"; "GPS TRIMBLE R8S -O") { }
                    field("TRIMBLE C5 -O"; "TRIMBLE C5 -O") { }
                    field("GPS Tersus"; "GPS Tersus") { }
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
            group(Used_equipment)
            {
                caption = 'Used equipment';
                Visible = GeoWorkOrderVisible;
                group(Instrument)
                {
                    caption = 'Instrument';
                    Visible = GeoWorkOrderVisible;
                    field("Trimble M3"; "Trimble M3") { }
                    field("Sokkia SET2030"; "Sokkia SET2030") { }
                    field("Zeiss REC ELTA 15"; "Zeiss REC ELTA 15") { }
                    field("GPS L1 - Promark 3"; "GPS L1 - Promark 3") { }
                    field("GPS - Others"; "GPS - Others") { }
                    field("GPS TRIMBLE R8S"; "GPS TRIMBLE R8S") { }
                    field("TRIMBLE C5"; "TRIMBLE C5") { }
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
                    caption = 'Prism';
                    field("Sokkia 1x"; "Sokkia 1x") { }
                    field("Zeiss 3x"; "Zeiss 3x") { }
                    field("Zeiss 1x"; "Zeiss 1x") { }
                    field("Wild 1x"; "Wild 1x") { }

                }
                group(Ribbon)
                {
                    Caption = 'Ribbon';
                    field("50 m"; "50 m") { }
                    field("30 m"; "30 m") { }
                    field("20 m"; "20 m") { }
                    field("Leica Disto"; "Leica Disto") { }
                }
                field("Accessories for Centering"; "Accessories for Centering") { }

            }

            //snimanje

            group(Used_equipment_R)
            {
                caption = 'Used equipment (S)';
                Visible = GeoWorkOrderVisible;
                group(InstrumentS)
                {
                    Visible = GeoWorkOrderVisible;
                    caption = 'Instrument';
                    field("Trimble M3-R"; "Trimble M3 -R") { }
                    field("Sokkia SET2030-R"; "Sokkia SET2030 -R") { }
                    field("Zeiss REC ELTA 15 -R"; "Zeiss REC ELTA 15 -R") { }
                    field("GPS L1 - Promark 3 -R"; "GPS L1 - Promark 3 -R") { }
                    field("GPS - Others -R"; "GPS - Others - R") { }
                    field("GPS TRIMBLE R8S -R"; "GPS TRIMBLE R8S -R") { }
                    field("TRIMBLE C5 -R"; "TRIMBLE C5 -R") { }
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

            part("Measure Points List"; "Request Card SubPage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                Visible = false;
            }

            part("Gas Appliance List"; "Gas Appliances Subform")
            {
                Visible = ElAccordanceVisible;
                ApplicationArea = All;
                Provider = "Measure Points List";
                SubPageLink = "Measure Point No." = field("Service Item No."), "Gas Install. Data Entry No." = const(0), "Document No." = field("Document No.");
            }

        }




        addbefore(Control1900383207)
        {
            part("Attached Documents"; "Document Att. Det. FactBox")
            {
                Visible = AttachedDocumentsFactBoxVisible;
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5901),
                              "No." = FIELD("Order No."), Information = filter(false),
                              Archived = filter(false)
                              ;
            }
            part("Attached Documents2"; "Document Att. Det. FactBox")
            {
                Visible = AttachedDocumentsFactBoxVisible2;
                ApplicationArea = All;

                Caption = 'Attachments';
                Editable = True;

                SubPageLink = "Table ID" = CONST(5901),
                              "No." = FIELD("Order No."), Information = filter(true),
                              Archived = filter(false);

            }
            part("Request Work Orders"; "Request Work Orders FactBox")
            {
                Visible = true;
                ApplicationArea = All;
                Caption = 'Request Work Orders', Comment = 'Radni nalozi zahtjeva';
                SubPageLink = "Document Type" = Const(Order), "Request Type" = filter("General Work Order" | "General Geo. Work Order" | "General Geo. WOrk Order Office"), "CZK Request No." = field("Order No.");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Customer No.");
            }


        }


        // }
    }





    actions
    {



        addafter("&Print")
        {

            action("Print2")
            {
                ApplicationArea = Service;
                Caption = '&Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ServiceInvoice: Report "Posted Service Invoice";

                    crl: Record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                begin
                    crl.Reset();
                    crl.SetFilter("Report ID", '%1', 50149);
                    //   crl.SetFilter(Description, '%1', 'Prijava izvođenja radova');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);
                        ServiceInvoice.SetParam(Rec."No.");

                        ServiceInvoice.Run();
                    end;
                end;
            }

            action("Print3")
            {
                ApplicationArea = Service;
                Caption = '&Print3';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                var
                    ServiceInvoice: Report "ZR-OU-00-25-01 Invoice";
                    CRL: record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    SmS: Record "Service Mgt. Setup";
                    ServiceHeaderIn: Record "Service Invoice Header";


                begin

                    CurrPage.SetSelectionFilter(ServiceHeaderIn);
                    if rec."Request Type" = rec."Request Type"::"Work Execution Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Prijava izvođenja radova');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;


                    if rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Zahtjev za lokaciju');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;



                    if rec."Request Type" = rec."Request Type"::"Location Accordance Issuing Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Zahtjev za trasu');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;

                    if rec."Request Type" = rec."Request Type"::"Information Issuing Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;

                    if rec."Request Type" = rec."Request Type"::"Project overview Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Pregled projekta UGI');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;


                end;


            }

            //izjava o završetku

            action("Print5")
            {
                ApplicationArea = Service;
                Caption = '&Print5';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = WorkExecutionVisible;

                trigger OnAction()
                var
                    ServiceInvoice: Report "ZR-OU-00-25-01 Invoice";
                    CRL: record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    SmS: Record "Service Mgt. Setup";
                    ServiceHeaderIn: Record "Service Invoice Header";


                begin

                    CurrPage.SetSelectionFilter(ServiceHeaderIn);
                    if rec."Request Type" = rec."Request Type"::"Work Execution Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Pregled UGI');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;





                end;


            }

            //pregled ugi 
            action("Print4")
            {
                ApplicationArea = Service;
                Caption = '&Print4';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = WorkExecutionVisible;

                trigger OnAction()
                var
                    ServiceInvoice: Report "ZR-OU-00-25-01 Invoice";
                    CRL: record "Custom Report Layout";
                    RLS: Record "Report Layout Selection";
                    SmS: Record "Service Mgt. Setup";
                    ServiceHeaderIn: Record "Service Invoice Header";


                begin

                    CurrPage.SetSelectionFilter(ServiceHeaderIn);
                    if rec."Request Type" = rec."Request Type"::"Work Execution Request" then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', 50142);
                        crl.SetFilter(Description, '%1', 'Izjava o završetku radova');
                        if crl.FindFirst() then begin
                            RLS.SetTempLayoutSelected(crl.Code);
                            SmS.Get();


                            Report.Run(Report::"ZR-OU-00-25-01 Invoice", true, false, ServiceHeaderIn);
                        end;

                    end;

                end;




            }
            action("Print Fiscal")
            {

                ApplicationArea = Service;
                Caption = 'Print Fiscal';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category5;
                //  ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                begin
                    PrintFiscal_New(true, rec);
                end;


            }

            action("Fiscal print Correction")

            {
                Caption = 'Fiscal print Correction';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //Visible = ShowF;

                trigger OnAction()
                var
                    UF: Report "Update Fiscal";
                    FiltersR: Record "Service Invoice Header";

                begin
                    FiltersR.Reset();
                    FiltersR.CopyFilters(Rec);
                    if FiltersR.FindFirst() then begin
                        if FiltersR.Count = 1 then begin
                            Report.runmodal(50222, true, true, Rec);
                        end
                        else begin
                            Error('Molimo Vas da filtrirate 1. dokument kako biste mogli ažurirati broj fiskalnog računa!');
                        end;
                    end;
                end;
            }

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
                    Text007: Label 'Required fields must be filled in. Please check the list of required fields!';
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
                    DocumentAttachment.setfilter(Mandatory, '%1', false);
                    DocumentAttachment.setfilter(Delivered, '%1|%2', DocumentAttachment.Delivered::Empty, DocumentAttachment.Delivered::No);
                    if DocumentAttachment.findfirst then
                        error(Text007);
                    Rec.ProcessRequest();//has commit
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
                begin
                    Rec.CreateAndOpenWorkOrder();//has commit
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
                    GTemp: Record "Service Invoice Header";
                begin


                    Rec.FINDFIRST;
                    filter := Rec.GETFILTERS;
                    GTemp.Reset();
                    GTemp.CopyFilters(Rec);
                    GTemp.SetFilter("Sent Mail", '%1', false);
                    GTemp.SetFilter("No.", '%1', rec."No.");
                    Report.RunModal(Report::"Send mail from RN Invoice", true, true, GTemp);

                end;
            }

            //đk 


            //đk 


        }

        modify("&Print")
        {
            Visible = false;
        }

    }

    //fiscalni

    trigger OnAfterGetCurrRecord()
    begin
        SetVisibleControls();
        CalcFields(Status_request, "Due Days Status");
        GetEmployeeResponsibleFullName();
        CalculateRest();
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        SetVisibleControls();
        CalcFields(Status_request, "Due Days Status");
        GetEmployeeResponsibleFullName();
        CalculateRest();
    end;

    trigger OnOpenPage()
    begin
        SetVisibleControls();
        CalcFields(Status_request, "Due Days Status");
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;
    end;

    procedure CreateAndOpenWorkOrder()
    var
        ServiceHeader: Record "Service Invoice Header";
        ServiceItemLine: Record "Service Invoice Line";
        NewWorkOrderDialog: Page NewWorkOrderDialog;
        NewWorkOrderType: enum "Request Type";
        NewReason: Text[250];
        NewRemark: Text[250];
        UseriD_REc: Record "User Setup";
        IsCopyWorkOrder: Boolean;
    begin

        //    TestField("Document Type", Enum::"Service Document Type"::Order);
        //    ServiceItemLine.SetRange("Document Type", "Document Type");
        ServiceItemLine.SetRange("Document No.", "No.");
        ServiceItemLine.FindFirst();
        ServiceItemline.TestField("Service Item No.");

        NewWorkOrderDialog.SetInitialWorkOrderType(Enum::"Request Type"::"General Work Order", '', '', false, false);
        NewWorkOrderDialog.LookupMode := true;
        if NewWorkOrderDialog.RunModal = Action::LookupOK then begin
            NewWorkOrderDialog.GetSelectedWorkOrderType(NewWorkOrderType, NewRemark, NewReason, IsCopyWorkOrder);
            UseriD_REc.get(UserId);
            NewReason := UseriD_REc.Reason;
            NewRemark := UseriD_REc.Remark;
        end

        else begin
            Error('');
        end;
        ;

        CreateServiceHeaderFromServiceHeader(ServiceHeader, NewWorkOrderType, NewRemark, NewReason);

        Commit();

        UseriD_REc.Get(UseriD);
        if (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order")
        or (ServiceHeader."Request Type" = ServiceHeader."Request Type"::"General Geo. Work Order Office")
        then
            UseriD_REc.GEO := true
        else
            UseriD_REc.GEO := false;

        UseriD_REc.Modify();
        Commit();

        Page.RunModal(Page::"Request Card", ServiceHeader);
        Commit();
    end;


    /*local procedure CreateServiceHeaderFromServiceHeader(var ServiceHeader: Record "Service Header"; RequestType: Enum "Request Type"; var Descri: Text[250]; var Remar: Text[250])
        var
            ServiceItemLine: record "Service Item Line";
            NewServiceItemLine: record "Service Item Line";
            RequestID: Code[20];
            DocumentAttachment: Record "Document Attachment";
            Mandat: Record "Mandatory Attachment Setup";
        begin
            ServiceHeader.Init();
            ServiceHeader."Document Type" := Enum::"Service Document Type"::Order;
            ServiceHeader."No." := '';


            ServiceHeader."No. Series" := GetNoSeries(RequestType);
            ServiceHeader.Insert(True);
            RequestID := ServiceHeader."Request ID";
            ServiceHeader.TransferFields(Rec, false);
            ServiceHeader."Reason For Service Order" := Remar;
            ServiceHeader."Remark For Service Order" := Descri;
            ServiceHeader."Request ID" := RequestID;
            ServiceHeader."Request Type" := RequestType;
            ServiceHeader."CZK Request No." := "No.";
            Serviceheader."Document Date" := Today();
            ServiceHeader.Modify(true);
            ServiceItemLine.SetRange("Document Type", "Document Type");
            ServiceItemLine.SetRange("Document No.", "No.");
            if ServiceItemLine.FindSet() then
                repeat
                    NewServiceItemLine.Init();
                    NewServiceItemLine.TransferFields(ServiceItemLine, false);
                    NewServiceItemLine."Document Type" := "Document Type";
                    NewServiceItemLine."Document No." := ServiceHeader."No.";
                    NewServiceItemLine."Line No." := ServiceItemLine."Line No.";
                    NewServiceItemLine.Insert();
                until ServiceItemLine.Next() = 0;

            if ServiceHeader."Request Type" = ServiceHeader."Request Type"::"Project and Energy Accordance" then begin

                Mandat.Reset();
                Mandat.SetFilter(Information, '%1', true);
                Mandat.SetFilter("Request Type", '%1', ServiceHeader."Request Type");
                if mandat.FindSet() then
                    repeat
                        DocumentAttachment.Init();
                        DocumentAttachment."Table ID" := Database::"Service Item Line";
                        DocumentAttachment."No." := ServiceHeader."No.";
                        DocumentAttachment."Line No." := 1000;
                        DocumentAttachment.Mandatory := Mandat.Mandatory;
                        DocumentAttachment.ID := 0;
                        DocumentAttachment.Information := mandat.Information;
                        DocumentAttachment."Mandatory Attachment Type" := mandat."Mandatory Attachment Type";
                        DocumentAttachment."File Name" := 'Odaberite datoteku...';
                        DocumentAttachment.Insert();
                    until Mandat.Next() = 0;
            end;
        end;*/

    procedure ChangeSeparator(Number: Text[2000]) NumberConvert: Text


    begin
        IF STRLEN(Number) > 2 THEN BEGIN
            IF COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2) = ',' THEN BEGIN
                NumberConvert := COPYSTR(FORMAT(Number), 1, STRLEN(FORMAT(Number)) - 2) + '.' + COPYSTR(FORMAT(Number), STRLEN(FORMAT(Number)) - 2, 2);
            END
            ELSE BEGIN
                NumberConvert := FORMAT(Number);
            END;
        END
        ELSE BEGIN
            NumberConvert := FORMAT(Number);
        END;

    end;

    procedure Odgovor(Upit: Text[2000])

    var
        myInt: Integer;
        XMLManagement: Codeunit "XML DOM Management";
        UlazniRacun: Code[20];
        ReklamniDA: Boolean;
        ImaZarez: Integer;
        TextCitanje: BigText;
        Rezultat: Text[2000];
        TotalCijena2: Decimal;
        Sallesr: Record "Sales Cr.Memo Line";
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        Iznoss: Decimal;

        xmlDomdoc: XmlDocument;
        TextPos: Integer;
        xmldomDoc3: XmlDocument;
        xmldomDoc2: XmlDocument;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        xmlNodeList1: XmlNodeList;
        xmlNodeList2: XmlNodeList;
        xmlNodeList3: XmlNodeList;
        xmlNodeList4: XmlNodeList;
        xmlNodeList6: XmlNodeList;

        NodeVale: XmlNode;
        SystemXmlNodeValue: DotNet SystemXmlNode;
        SystemXmlNodeValue2: DotNet SystemXmlNode;
        SystemXmlNodeValue3: DotNet SystemXmlNode;
        SystemXmlNodeValue4: DotNet SystemXmlNode;

        ChildNode: DotNet SystemXmlNode;

        ChildNodeList: DotNet SystemXmlNodeList;

        i: Integer;
        j: Integer;
        xmlNodeList5: XmlNodeList;
        //TempBlob: Record TempBlob;
        Charr: Char;
        importFile: File;
        importFile2: File;
        ReadLine: Text[2000];
        ReadLine2: Text[2000];
        VrstaOdgovora: Text[2000];
        strInStream: InStream;
        x1: Text[2000];
        x2: Text[2000];
        x3: Text[2000];
        x4: Text[2000];
        XMLFileOutStr: OutStream;
        ToFileName: Text[2000];
        x5: Text[2000];
        x6: Text[2000];
        Zamjena: Text[2000];


        Custt: Record Customer;
        Putanja: Text[250];
        OutStreamObj2: OutStream;
        Linije: Text[2000];

        File5: File;
        Putanja2: Text[250];
        SystemXmlNodeListValue: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue2: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue3: DotNet SystemXmlNodeList;
        SystemXmlNodeListValue4: DotNet SystemXmlNodeList;

        TXTTab: Char;
        Instr: InStream;
        filename: Text[2000];
        filepath: Text[2000];
        SalesHeader: Record "Sales Invoice Header";
        XMLDomDocParam: DotNet SystemXmlDocument;

        SystemDokument: Dotnet SystemXmlDocument;
        SubText: Text[2000];
        OutStreamObj: OutStream;
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        plite: Text[2000];
        SalesInvoiceLine: Record "Sales Invoice Line";
        Salles: Record "Sales Invoice Line";
        TotalCijena: Decimal;
        FileManagement: Codeunit "File Management";


    begin
        TXTTab := 13;
        //Upit:='\\DESKTOP-B6A3125\odgovori\sfr';
        IF EXISTS(Upit + '_1') THEN
            ERASE(Upit + '_1');

        Message((Upit));
        IF EXISTS(Upit) THEN BEGIN
            Charr := 10;
            importFile.WRITEMODE(TRUE);
            importFile.TEXTMODE(TRUE);
            importFile.OPEN(Upit);
            importFile2.WRITEMODE(TRUE);
            importFile2.TEXTMODE(TRUE);
            IF NOT EXISTS(Upit + '_1') THEN
                importFile2.CREATE(Upit + '_1');


            WHILE importFile.READ(ReadLine) > 0 DO BEGIN

                x1 := 'xml';
                x2 := 'Kasa';
                x3 := 'VrstaOdgovora';
                x4 := 'Naziv';
                x5 := 'Vrijednost';
                X6 := 'Odgovor';
                IF (STRPOS(ReadLine, x1) = 0) THEN BEGIN
                    IF (STRPOS(ReadLine, x2) = 0) THEN BEGIN
                        IF (STRPOS(ReadLine, x3) = 0) THEN BEGIN
                            IF (STRPOS(ReadLine, x4) <> 0) THEN BEGIN

                                //<Naziv>BrojFiskalnogRacuna</Naziv>
                                Zamjena := COPYSTR(ReadLine, STRLEN('<Naziv>') + 7, STRLEN(ReadLine) - STRLEN('<Naziv></Naziv>') - 6);

                            END;
                            IF (STRPOS(ReadLine, x5) <> 0) THEN BEGIN
                                ReadLine2 := '<' + Zamjena + '>' + COPYSTR(ReadLine, STRPOS(ReadLine, '">') + 2, STRLEN(ReadLine) - STRPOS(ReadLine, '">') - STRLEN('</Vrijednost>') - 1) + '</' + Zamjena + '>';
                                importFile2.WRITE(ReadLine2 + FORMAT(Charr));
                            END;
                            IF STRPOS(ReadLine, X6) <> 0 THEN BEGIN
                                importFile2.WRITE(ReadLine);
                            END;


                        END
                        ELSE BEGIN
                            VrstaOdgovora := COPYSTR(ReadLine, STRLEN('<VrstaOdgovora>') + 3, STRLEN(ReadLine) - STRLEN('<VrstaOdgovora></VrstaOdgovora>') - 2)
                        END;


                    END;

                END;

                importFile2.CREATEINSTREAM(strInStream);
                importFile2.CREATEOUTSTREAM(XMLFileOutStr);
            END;
        END;



        importFile.CLOSE;
        importFile2.CLOSE;


        ToFileName := Upit + '_1';

        CLEAR(xmldomDoc2);
        CLEAR(xmlNodeList1);
        CLEAR(xmlNodeList2);
        CLEAR(xmlNodeList3);
        CLEAR(xmlNodeList4);
        CLEAR(xmlNodeList5);
        CLEAR(xmlNodeList6);

        //ĐK xmldomDoc2 := XmlDocument.Create();
        XMLDomDocParam := XMLDomDocParam.XmlDocument();
        XMLDomDocParam.Load(Upit + '_1');
        SystemXmlNodeListValue := XMLDomDocParam.GetElementsByTagName('BrojFiskalnogRacuna');
        SystemXmlNodeListValue2 := XMLDomDocParam.GetElementsByTagName('DatumFiskalnogRacuna');
        SystemXmlNodeListValue3 := XMLDomDocParam.GetElementsByTagName('VrijemeFiskalnogRacuna');
        SystemXmlNodeListValue4 := XMLDomDocParam.GetElementsByTagName('IznosFiskalnogRacuna');

        FOR i := 0 TO SystemXmlNodeListValue.Count - 1 DO BEGIN
            SystemXmlNodeValue := SystemXmlNodeListValue.Item(i);
            SystemXmlNodeValue2 := SystemXmlNodeListValue2.Item(i);
            SystemXmlNodeValue3 := SystemXmlNodeListValue3.Item(i);
            SystemXmlNodeValue4 := SystemXmlNodeListValue4.Item(i);




            BrojFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            DatumFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            VrijemeFiskalnogRacuna := SystemXmlNodeValue.InnerText;
            IznosFiskalnogRacuna := SystemXmlNodeValue.InnerText;




        END;




    end;

    procedure PrintFiscal_New(Allow: Boolean; SalesLine_New: record "Service Invoice Header")

    var
        Custt: record Customer;
        ImaZarez: Integer;

        Rezultat: Text[2000];
        Putanja2: text[250];
        GenL: Record "General Ledger Setup";
        Samount: Record "Service Invoice Line";
        US: Record "User Setup";
        CZkF: Record "User Setup";
        BankAccocunt: Record "Bank Account";

    begin
        GenL.get;
        Putanja := GenL."Path for fiscal printer";


        CZkF.Get(UserId);
        if CZkF.CZK = '' then
            Error('Ne postoje podaci o putanji za fiskalnu kasu.!');
        BankAccocunt.Reset();
        BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
        if BankAccocunt.findfirst then begin
            Putanja := BankAccocunt."Path for fiscal printer";

        end
        else begin
            Putanja := GenL."Path for fiscal printer";

        end;
        if rec."Fiscal No. Printed" = false then begin

            File1.CREATE(Putanja + 'Stampatifiskalniracun.000', TEXTENCODING::UTF8);

            File1.CREATEOUTSTREAM(OutStreamObj);

            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<RacunZahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>233</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<VrstaZahtjeva>0</VrstaZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<NoviObjekat>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();


            Custt.RESET;
            Custt.SETFILTER("No.", '%1', SalesLine_New."Bill-to Customer No.");
            IF Custt.FINDFIRST THEN begin

                if Custt."Registration No." <> '' then begin

                    plite := '<Kupac>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '<IDbroj>' + Custt."Registration No." + '</IDbroj>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();


                    //<Naziv>Tring d.o.o. Informatički Inženj</Naziv>
                    plite := '<Naziv>' + SalesLine_New."Bill-to Name" + '</Naziv>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<Adresa>Mehmeda Vehbi ef. Šemsekadića bb</Adresa>

                    plite := '<Adresa>' + SalesLine_New."Bill-to Address" + '</Adresa>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<PostanskiBroj>75320</PostanskiBroj>

                    plite := '<PostanskiBroj>' + SalesLine_New."Bill-to Post Code" + '</PostanskiBroj>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    //<Grad>Gračanica</Grad>
                    plite := '<Grad>' + SalesLine_New."Bill-to City" + '</Grad>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();

                    plite := '</Kupac>';
                    OutStreamObj.WRITETEXT(plite);
                    OutStreamObj.WRITETEXT();
                    //</Kupac>

                end;

            end;

            plite := '<StavkeRacuna>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<RacunStavka>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<artikal>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '<Sifra>' + FORMAT(SalesLine_New."Request Type") + '</Sifra>';
            plite := '<Sifra>' + FORMAT(SalesLine_New."No.") + '</Sifra>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Naziv>' + FORMAT('Iznos po nalogu ' + SalesLine_New."No.") + '</Naziv>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<JM>' + 'KO' + '</JM>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            Samount.Reset();
            Samount.SetFilter("Document No.", '%1', SalesLine_New."No.");
            if Samount.FindFirst() then begin
                Samount.CalcSums("Amount Including VAT");
                Samount."Amount Including VAT" := round(Samount."Amount Including VAT", 0.01, '=');
                ImaZarez := STRPOS(FORMAT(Samount."Amount Including VAT"), ',') + 1;
            end
            else begin
                ImaZarez := STRPOS(FORMAT(0), ',') + 1;
            end;

            Samount.Amount := round(Samount.Amount, 0.01, '=');
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            if US.FindFirst() then begin

                if (us."CNG Administrator" = true) or (us."CNG User" = true) then begin

                    IF STRPOS(FORMAT(COPYSTR(FORMAT(Samount.Amount), ImaZarez, 2)), '00') = 0 THEN
                        Rezultat := ChangeSeparator(FORMAT(Samount.Amount, 0, '<Sign><Integer><Decimals><Comma,.>'))
                    ELSE
                        Rezultat := ChangeSeparator(FORMAT(ROUND(Samount.Amount), 0, '<Precision,2:2><Standard Format,2>'));

                end
                else begin
                    Samount."Amount Including VAT" := round(Samount."Amount Including VAT", 0.01, '=');

                    IF STRPOS(FORMAT(COPYSTR(FORMAT(Samount."Amount Including VAT"), ImaZarez, 2)), '00') = 0 THEN
                        Rezultat := ChangeSeparator(FORMAT(Samount."Amount Including VAT", 0, '<Sign><Integer><Decimals><Comma,.>'))
                    ELSE
                        Rezultat := ChangeSeparator(FORMAT(ROUND(Samount."Amount Including VAT"), 0, '<Precision,2:2><Standard Format,2>'));
                end;


            end;

            plite := '<Cijena>' + Rezultat + '</Cijena>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            IF round(Samount.Amount, 0.01, '=') - round(Samount."Amount Including VAT", 0.01, '=') < 0 THEN
                plite := '<Stopa>E</Stopa>'
            ELSE
                plite := '<Stopa>K</Stopa>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Grupa>0</Grupa>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<PLU>0</PLU>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</artikal>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Kolicina>' + '1' + '</Kolicina>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();




            plite := '<Rabat>0</Rabat>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();

            plite := '</RacunStavka>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</StavkeRacuna>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<VrstePlacanja>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<VrstaPlacanja>';


            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Oznaka>Virman</Oznaka>';

            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Iznos>' + '0' + '</Iznos>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();


            plite := '</VrstaPlacanja>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</VrstePlacanja>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</NoviObjekat>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</RacunZahtjev>';

            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();


            File1.CLOSE;

            IF SalesLine_New."Fiscal No. Printed" = FALSE THEN
                FileManagement.DownloadToFile(Putanja + 'Stampatifiskalniracun.000', Putanja + 'Stampatifiskalniracun.000');
            GL.get;
            Commit();
            SLEEP(GL."Sleep value");
        end;


        IF SalesLine_New."Fiscal No. Printed" = FALSE THEN BEGIN
            Putanja2 := GL."Path for fiscal printer" + 'odgovori\';
            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin

                Putanja2 := BankAccocunt."Path for fiscal printer" + 'odgovori\';
            end
            else begin

                Putanja2 := GenL."Path for fiscal printer" + 'odgovori\';
            end;

            //   Odgovor(Putanja2 + 'Stampatifiskalniracun.000');
            //Key1; "Document Type", "Document No.", "Line No.")
            CZkF.Get(UserId);
            BankAccocunt.Reset();
            BankAccocunt.SetFilter("No.", '%1', CZkF.CZK);
            if BankAccocunt.findfirst then begin
                BrojFiskalnogRacuna := NoSeriesMgt.GetNextNo(BankAccocunt."No. series FIscal No.", TODAY, true);

            end;


            SalesLine_New."Fiscal No." := BrojFiskalnogRacuna;
            SalesLine_New."Fiscal DateTime" := CURRENTDATETIME;
            SalesLine_New."Fiscal No. Printed" := true;
            SalesLine_New."Fiscal User" := UserId;
            SalesLine_New.Modify();
            //odmah i duplikat
            PrintDuplicateFiscal(true, BrojFiskalnogRacuna);

        END
        else begin
            PrintDuplicateFiscal(true, rec."Fiscal No.");
        end;

    end;

    procedure PrintDuplicateFiscal(Allow: Boolean; Fisc: code[20])
    var
        GenL: Record "General Ledger Setup";
        CZkF: Record "User Setup";
        BankAccocunt: Record "Bank Account";
    begin
        GenL.get;
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

        if Allow = true then begin

            File1.CREATE(Putanja + 'stampatiduplikatfiskalnogracuna.xml', TEXTENCODING::UTF8);
            //File1.CREATE('\\FORTNAV\Temp\snd.xml',TEXTENCODING::UTF8);

            File1.CREATEOUTSTREAM(OutStreamObj);
            plite := '';

            plite := '<?xml version="1.0" encoding="utf-8"?>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Zahtjev xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<BrojZahtjeva>607356</BrojZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<VrstaZahtjeva>3</VrstaZahtjeva>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Naziv>BrojRacuna</Naziv>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '<Vrijednost>' + Fisc + '</Vrijednost>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Parametar>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Parametri>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            plite := '</Zahtjev>';
            OutStreamObj.WRITETEXT(plite);
            OutStreamObj.WRITETEXT();
            File1.CLOSE;
            FileManagement.DownloadToFile(Putanja + 'stampatiduplikatfiskalnogracuna.xml', Putanja + 'stampatiduplikatfiskalnogracuna.xml');
        end;

    end;

    local procedure CalculateRest()
    begin
        Rest := Rec.Dued - Rec.Realized;
    end;

    procedure OpenRequestDocumentCard(DocumentNo: Code[20])
    var
        ServiceHeader: Record "Service Header";
        RC: page "Request Card";
    begin
        if DocumentNo = '' then
            exit;
        ServiceHeader.Reset();
        ServiceHeader.SetFilter("no.", '%1', DocumentNo);
        //  ServiceHeader.Get(ServiceHeader."Document Type"::Invoice, DocumentNo);
        //   ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
        //  ServiceHeader.SetRange("Request Type", ServiceHeader."Request Type");
        //    ServiceHeader.SetRange("No.", "No.");
        RC.SetTableView(ServiceHeader);
        rc.Run();
        //    Page.RunModal(Page::"Request Card", ServiceHeader);
    end;

    procedure GetProcessingDocument(): Code[20]
    var
        ServiceHeader: Record "Service Header";
        ProcessingDocumentType: Enum "Request Type";
    begin
        ProcessingDocumentType := GetProcessingDocumentType("Request Type");
        if ProcessingDocumentType = Enum::"Request Type"::"Others" then
            exit;

        ServiceHeader.SetLoadFields("No.");
        ServiceHeader.SetRange("Request Type", ProcessingDocumentType);
        ServiceHeader.SetRange("CZK Request No.", "Order No.");
        if ServiceHeader.FindFirst then
            exit(ServiceHeader."No.");

        exit('');
    end;

    local procedure GetProcessingDocumentType(RequestDocumentType: Enum "Request Type"): Enum "Request Type";
    begin
        case RequestDocumentType of
            enum::"Request Type"::"Information Issuing Request":
                exit(Enum::"Request Type"::"Information on Connection");
            enum::"Request Type"::"Project overview Request":
                exit(Enum::"Request Type"::"Project and Energy Accordance");
            enum::"Request Type"::"Location Accordance Issuing Request":
                exit(Enum::"Request Type"::"Location Accordance Issuing Information");
            enum::"Request Type"::"Route Accordance Issuing Request":
                exit(Enum::"Request Type"::"Route Accordance Issuing Information");
            enum::"Request Type"::"Spatial plan Accordance Issuing Request":
                exit(Enum::"Request Type"::"Spatial plan Accordance Issuing Information");
            enum::"Request Type"::"Work Execution Request":
                exit(Enum::"Request Type"::"UGI Overview and First Release");
            else
                exit(Enum::"Request Type"::"Others");
        end;
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

    local procedure GetEmployeeResponsibleFullName()
    var
        Employee: Record Employee;
    begin
        EmployeeResponsibleName := '';
        if Rec."Employee Responsible" = '' then
            exit;
        if not Employee.Get(Rec."Employee Responsible") then
            exit;
        EmployeeResponsibleName := Employee.FullName();
    end;

    local procedure SetVisibleControls()
    begin
        WorkOrderVisible := false;
        CZKRequestNoVisible := false;
        WorkOrdersActionVisible := false;
        ProcessRequestActionVisible := false;
        Verification := false;
        WorkExecutionVisible := false;
        AttachedDocumentsFactBoxVisible2 := false;
        AttachedDocumentsFactBoxVisible := false;
        InformationOnConnectionVisible := false;
        ProcessingDocumentVisible := false;
        ElAccordanceVisible := false;
        GeoWorkOrderVisible := false;
        GeoWorkOrderVisibleOffice := False;
        LocationRouteSpatialPlanVisible := false;
        LocationRouteSpatialPlanInformationVisible := false;
        InformationIssuingRequestVisible := false;
        ProjectOverviewRequestVisible := false;

        case Rec."Request Type" of
            Enum::"Request Type"::"Information Issuing Request":
                begin
                    ProcessRequestActionVisible := true;
                    AttachedDocumentsFactBoxVisible := true;
                    ProcessingDocumentVisible := true;
                    AttachedDocumentsFactBoxVisible2 := true;
                    InformationIssuingRequestVisible := true;
                end;
            Enum::"Request Type"::"Information on Connection":
                begin
                    CZKRequestNoVisible := true;
                    WorkOrdersActionVisible := true;
                    InformationOnConnectionVisible := true;
                end;
            Enum::"Request Type"::"General Work Order":
                begin
                    WorkOrderVisible := true;
                    CZKRequestNoVisible := true;
                end;
            Enum::"Request Type"::"General Geo. Work Order":
                begin
                    WorkOrderVisible := true;
                    CZKRequestNoVisible := true;
                    GeoWorkOrderVisible := true;
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
                    WorkOrdersActionVisible := true;
                    ElAccordanceVisible := true;
                end;
            Enum::"Request Type"::"UGI Overview and First Release":
                begin
                    CZKRequestNoVisible := true;
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

            Enum::"Request Type"::"General Geo. Work Order Office":
                begin
                    WorkOrderVisible := true;
                    CZKRequestNoVisible := true;
                    GeoWorkOrderVisibleOffice := true;
                end;


        end;
        if (InformationOnConnectionVisible = true) or (ElAccordanceVisible = true) or (WorkOrderVisible = true)
        or (LocationRouteSpatialPlanInformationVisible = true) then
            Verification := true
        else
            Verification := False;
    end;

    var
        OutStreamObj: OutStream;
        Putanja: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;
        GL: Record "General Ledger Setup";
        plite: text[250];
        File1: File;
        FileManagement: Codeunit "File Management";
        File5: File;
        OutStreamObj2: OutStream;
        Linije: Text[2000];
        [InDataSet]
        WorkOrderVisible, WorkExecutionVisible, InformationOnConnectionVisible, ElAccordanceVisible, GeoWorkOrderVisible, LocationRouteSpatialPlanVisible, LocationRouteSpatialPlanInformationVisible, InformationIssuingRequestVisible, ProjectOverviewRequestVisible, GeoWorkOrderVisibleOffice, Verification, AllRequest, OnlyGeneral : Boolean;
        [InDataSet]
        CZKRequestNoVisible, WorkOrdersActionVisible, ProcessRequestActionVisible, AttachedDocumentsFactBoxVisible, ProcessingDocumentVisible : Boolean;
        Rest: Integer;
        AttachedDocumentsFactBoxVisible2: Boolean;
        ServiceInvoice: Report "ServiceInvoice";
        EmployeeResponsibleName: Text[100];
        ConfirmFileImportQst: Label '%1 already exists. Do you want to override it?';
        ConfirmFileDeletetQst: Label 'Are you sure that you want to delete %1?';
        ImportFileFilter: Label 'All files (*.*)|*.*', Locked = true;
        FileDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';
        DocumentIsPosted: Boolean;
        ServHeader: Record "Service Invoice Header";
        OpenPostedServiceOrderQst: Label 'The order is posted as number %1 and moved to the Posted Service Invoices window.\\Do you want to open the posted invoice?', Comment = '%1 = posted document number';

        BrojFiskalnogRacuna: Text[2000];
        VrijemeFiskalnogRacuna: Text[2000];
        DatumFiskalnogRacuna: Text[2000];
        IznosFiskalnogRacuna: Text[2000];
        US: Record "User Setup";
        SHowF: Boolean;
}
