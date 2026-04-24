pageextension 50063 PostedServiceCreditMemo extends "Posted Service Credit Memo"
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
                              "No." = FIELD("Pre-Assigned No."), Information = filter(false),
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
                              "No." = FIELD("Pre-Assigned No."), Information = filter(true),
                              Archived = filter(false);

            }
            part("Request Work Orders"; "Request Work Orders FactBox")
            {
                Visible = true;
                ApplicationArea = All;
                Caption = 'Request Work Orders', Comment = 'Radni nalozi zahtjeva';
                SubPageLink = "Document Type" = Const(Order), "Request Type" = filter("General Work Order" | "General Geo. Work Order" | "General Geo. WOrk Order Office"), "CZK Request No." = field("Pre-Assigned No.");
            }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("Customer No.");
            }


        }
    }
    actions
    {
        addafter(ActivityLog)
        {
            action(FiscalPrint)
            {
                Caption = 'FiscalPrint';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    FiscalPrinterService: Codeunit FiscalPrinterService;
                begin
                    FiscalPrinterService.SetParam(Rec."No.", TRUE);
                    FiscalPrinterService.RUN;
                end;
            }
        }

    }
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
        ServiceHeader.SetRange("CZK Request No.", "Pre-Assigned No.");
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

    var
        Reklamnixml: Codeunit FiscalPrinter;
        OutStreamObj: OutStream;
        Putanja: text[250];
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
}
