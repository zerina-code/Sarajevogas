pageextension 50029 CustomerCard extends "Customer Card"
{
    layout
    {
        /* addafter("Customer Posting Group")
         {
             field("PDV_Number"; PDV_NUMBER)
             {

             }



    }*/


        addafter("Name 2")
        {
            field("Name 3"; "Name 2") { ApplicationArea = all; Caption = 'Name 2'; Visible = false; }
            field("Father Name"; "Father Name") { }
            field("Contract Name"; "Contract Name") { }
            field("Customer Phone No."; "Customer Phone No.") { ApplicationArea = all; }
        }
        modify("Prices Including VAT") { Visible = false; }
        modify("No.")
        {
            Visible = true;
            Editable = false;
        }
        modify("Balance (LCY)") { Visible = false; }
        addafter("Balance (LCY)")
        {
            field("Balance (LCY) Prepayment"; "Balance (LCY) Prepayment") { }
            field("Prepayment (LCY)"; "Prepayment (LCY)")
            {

            }
        }

        modify("Invoice Disc. Code") { Visible = false; }
        // Add changes to page layout here
        addafter("VAT Registration No.")
        {
            field("Registration No."; "Registration No.")
            {

            }
        }
        modify("Name 2") { Visible = true; }
        addbefore("Primary Contact No.")
        {
            field("Primary Contact No.2"; "Primary Contact No.2") { ApplicationArea = all; }
        }
        modify("Primary Contact No.") { Visible = false; }


        addbefore("No.")
        {
            field("Customer Category"; Rec."Customer Category")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Internal Customer"; "Internal Customer") { ApplicationArea = all; Editable = False; }
        }

        addafter("Customer Price Group")
        {
            field(Agreement; Agreement) { ApplicationArea = all; }
            field("Agreement Customer No."; "Agreement Customer No.") { }
            field("Bill distribution percentage"; "Bill distribution percentage") { }


        }
        addbefore("Prepayment %")
        {
            field("Social status category"; "Social status category")
            {

            }
        }

        addafter("Address & Contact")
        {

            group(Owner_Detail)
            {
                Visible = false;
                Caption = 'Owner Detail';
                field("Owner Primary Contact"; "Owner Primary Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Owner Primary Code';
                    Importance = Additional;
                    ShowMandatory = true;
                }
                field(ContactNameOwner; "Owner Contact")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Contact Name';

                    Importance = Promoted;
                    ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';

                    trigger OnValidate()
                    begin

                    end;
                }
                field("Owner Phone No."; "Owner Phone No.")
                {
                    ApplicationArea = Basic, Suite;

                }
                field("Owner Mobile Phone No."; "Owner Mobile Phone No.")
                {
                    Caption = 'Owner Mobile Phone No.';
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = PhoneNo;
                }
                field("Owner E-Mail"; "Owner E-Mail")
                {
                    ApplicationArea = Basic, Suite;
                    ExtendedDatatype = EMail;
                    Importance = Promoted;
                }

            }
        }

        addafter("Reminder Terms Code")
        {
            field("Reminder Date"; "Reminder Date") { }
        }
        addafter(Payments)
        {
            group("CR")
            {
                Editable = EditableMainCashier;
                Visible = false;


                field(Orderer; Orderer)
                {


                }
                field("Contract Number"; "Contract Number")
                {

                }
                field("Order person"; "Order person")
                {

                }
                field("Responsible Person"; "Responsible Person")
                {

                }
                field("Responsible Person Infodom"; "Responsible Person Infodom")
                {

                }
                field(Designer; Designer)
                {

                }
                field("Project manager"; "Project manager")
                {

                }
            }
        }

        modify(General)
        {
            Editable = EditableMainCashier;
        }
        modify(Invoicing)
        {
            Editable = EditableMainCashier;
        }
        modify(Payments)
        {
            Editable = EditableMainCashier;
        }
        modify(Shipping)
        {
            Editable = EditableMainCashier;
        }
        addafter(Address)

        {

            field("Street Customer"; "Street Customer") { ApplicationArea = all; }
            field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = false; }
            field("Street No."; "Street No.") { ApplicationArea = all; }
            field("Street No. Text"; "Street No. Text") { ApplicationArea = all; }

            field("Applied address"; "Applied address") { ApplicationArea = all; }
            field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; Editable = false; }
            field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = false; }
            field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = false; }
            field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = false; }
            field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; }
            field("Floor Customer 2"; "Floor Customer 2") { ApplicationArea = all; }
            field("Apartment No. Customer 2"; "Apartment No. Customer 2") { ApplicationArea = all; }
            field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = false; }
            field("Customer String"; "Customer String") { ApplicationArea = all; Editable = false; }
            field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }
            field("Way of Sending Reminder"; "Way of Sending Reminder") { ApplicationArea = All; }

        }
        addbefore("Balance (LCY)")
        {
            field(CUM; CUM)
            {
                ApplicationArea = all;
                Caption = 'CUM';
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    Users: Record "User Setup";
                    ServiceItemCard: page "Service Item Card";
                    ServiceList: Page "Service Item List";
                    ServiceItem: Record "Service Item";
                begin

                    CurrPage.Update();
                    ServiceItem.Reset();
                    ServiceItem.SetFilter("Customer No.", '%1', rec."No.");
                    //   ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
                    ServiceList.SetTableView(ServiceItem);
                    ServiceList.Run();
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    Users: Record "User Setup";
                    ServiceItemCard: page "Service Item Card";
                    ServiceList: Page "Service Item List";
                    ServiceItem: Record "Service Item";
                begin

                    CurrPage.Update();
                    users.Reset();
                    Users.SetFilter("User ID", '%1', UserId);
                    if Users.FindFirst() then begin
                        Users."Customer No." := rec."No.";
                        UserS.Modify();

                    end;
                    ServiceItem.Reset();
                    ServiceItem.SetFilter("Customer No.", '%1', rec."No.");
                    //  ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
                    ServiceList.SetTableView(ServiceItem);
                    ServiceList.Run();

                end;
            }
            field(MM_2; MM_2)
            {
                ApplicationArea = all;
                Caption = 'MM_2';

                // CalcFormula = count("Service Item" WHERE("Customer No. - Gauge" = field("No.")));

                trigger OnDrillDown()
                var

                    myInt: Integer;
                    Users: Record "User Setup";
                    ServiceItemCard: page "Service Item Card";
                    ServiceList: Page "Service Item List";
                    ServiceItem: Record "Service Item";
                begin
                    CurrPage.Update();
                    users.Reset();
                    Users.SetFilter("User ID", '%1', UserId);
                    if Users.FindFirst() then begin
                        Users."Customer No." := rec."No.";
                        UserS.Modify();
                    end;
                    ServiceItem.Reset();
                    ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
                    ServiceItem.SetFilter("Customer No. - Gauge", '%1', rec."No.");
                    ServiceList.SetTableView(ServiceItem);
                    ServiceList.Run();

                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    Users: Record "User Setup";
                    ServiceItemCard: page "Service Item Card";
                    ServiceList: Page "Service Item List";
                    ServiceItem: Record "Service Item";
                begin

                    CurrPage.Update();
                    users.Reset();
                    Users.SetFilter("User ID", '%1', UserId);
                    if Users.FindFirst() then begin
                        Users."Customer No." := rec."No.";
                        UserS.Modify();

                    end;
                    ServiceItem.Reset();
                    ServiceItem.SetFilter("Customer No. - Gauge", '%1', rec."No.");
                    ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
                    ServiceList.SetTableView(ServiceItem);
                    ServiceList.Run();
                    CurrPage.update;

                end;




            }

            field("Customer Connection"; "Customer Connection")
            {
                Visible = false;

            }
            field("MM Connection"; "MM Connection")
            {

                Visible = false;
            }


            field(CustomerLedEntryContractNumber; CustomerLedEntry.Description)
            {
                Caption = 'Active Contract Number';
                Editable = false;
                ApplicationArea = all;


                trigger OnDrillDown()
                var
                    CustLedEntries: Page "Customer Ledger Entries -SA";
                    US: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;
                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    US: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;

                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", "No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", "No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;

                end;
            }

            field(CustomerLedEntryStartingDate; CustomerLedEntry."Starting Date")
            {
                Caption = 'Active Starting Date';
                Editable = false;
                ApplicationArea = all;


                trigger OnDrillDown()
                var
                    CustLedEntries: Page "Customer Ledger Entries -SA";
                    us: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;
                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    US: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;
                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", "No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", "No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;

                end;
            }

            field(CustomerLedEntryEndingDate; CustomerLedEntry."Ending Date")
            {
                Caption = 'Active Ending Date';
                Editable = false;
                ApplicationArea = all;


                trigger OnDrillDown()
                var
                    CustLedEntries: Page "Customer Ledger Entries -SA";
                    US: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;
                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", '%1', Rec."No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    US: Record "User Setup";
                begin

                    US.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us."Customer No." := rec."No.";
                        us.Modify();

                    end;
                    CustomerLedEntry.RESET;
                    CustomerLedEntry.SETFILTER("Customer No.", "No.");
                    //CustomerLedEntry.SETFILTER(Active,'%1',TRUE);
                    IF CustomerLedEntry.FINDFIRST THEN BEGIN
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END
                    ELSE BEGIN
                        CustomerLedEntry.RESET;
                        CustomerLedEntry.SETFILTER("Customer No.", "No.");
                        CustLedEntries.SETTABLEVIEW(CustomerLedEntry);
                        CustLedEntries.RUN;
                    END;
                    CurrPage.UPDATE;

                end;
            }

        }


        addafter("VAT Registration No.")
        {
            field("Customer ID"; "Customer ID")
            {
                ApplicationArea = all;
                trigger Onlookup(var Text: Text): Boolean
                var
                    CustomerID: Record "Customer ID";
                    CUstomerIDPage: Page "Customer ID";
                begin
                    CustomerID.Reset();
                    CustomerID.SetFilter("Customer No.", '%1', Rec."No.");
                    CUstomerIDPage.SetTableView(CustomerID);
                    CUstomerIDPage.Run();
                end;

                trigger OnDrillDown()
                var
                    CustomerID: Record "Customer ID";
                    CUstomerIDPage: Page "Customer ID";
                begin
                    CustomerID.Reset();
                    CustomerID.SetFilter("Customer No.", '%1', Rec."No.");
                    CUstomerIDPage.SetTableView(CustomerID);
                    CUstomerIDPage.Run();
                end;
            }
        }
        addafter("E-Mail")
        {
            field("E-Mail 2"; "E-Mail 2") { }
            field("E-mail Delivery"; "E-mail Delivery") { ApplicationArea = all; }
            field("E-mail Delivery Date"; "E-mail Delivery Date") { ApplicationArea = all; }
            field("E-mail Delivery Date to"; "E-mail Delivery Date to") { Visible = false; }
            field("E-CZK"; "E-CZK") { Editable = false; }
            field("E-verification"; "E-verification")
            {
                Editable = Control;
            }
        }
        addafter("Phone No.") { field("Phone - Transfer"; "Phone - Transfer") { ApplicationArea = all; } }
        addafter("Fax No.") { field("Fax - Transfer"; "Fax - Transfer") { ApplicationArea = all; } }


        addafter("customer Posting group")
        { field("Exclude from Repost"; "Exclude from Repost") { ApplicationArea = all; } }
        addafter("AddressDetails")
        {
            group("Adresa2")

            {
                Caption = 'Adresa dostava';
                field("Street Customer 2"; "Street Customer 2") { ApplicationArea = all; }
                field("Street Name Customer 2"; "Street Name Customer 2") { ApplicationArea = all; Editable = false; }
                field("Street No. 2"; "Street No. 2") { ApplicationArea = all; }
                field("Street No.2 Text"; "Street No.2 Text") { ApplicationArea = all; }


                field("Municipality Code Customer 2"; "Municipality Code Customer 2") { ApplicationArea = all; Editable = false; }
                field("Municipality Name Customer 2"; "Municipality Name Customer 2") { ApplicationArea = all; Editable = false; }
                field("City 2"; "City 2") { ApplicationArea = all; Editable = false; }
                field("Post Code 2"; "Post Code 2") { ApplicationArea = all; Editable = false; }
                field("MZ Customer 2"; "MZ Customer 2") { ApplicationArea = all; Editable = false; }
                field("MZ Name Customer 2"; "MZ Name Customer 2") { ApplicationArea = all; Editable = false; }

                field("Home No. Customer 2"; "Home No. Customer 2") { ApplicationArea = all; Visible = false; }
                field("Floor Customer"; "Floor Customer") { ApplicationArea = all; }

                field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; }
                field("Box Number"; "Box Number") { ApplicationArea = all; }
                field("Customer Stroke 2"; "Customer Stroke 2") { ApplicationArea = all; Editable = false; }
                field("Customer String 2"; "Customer String 2") { ApplicationArea = all; Editable = false; }
                field("Zone stroke 2"; "Zone stroke 2") { ApplicationArea = all; Editable = false; }

            }

        }
        modify(Address) { Editable = false; }
        modify("Address 2") { Editable = false; }
        moveafter("Address & Contact"; ContactDetails)



        movebefore("Street Customer 2"; "Address 2")
        modify("Country/Region Code") { Visible = false; }
        movebefore("MZ Customer"; City)
        moveafter(City; "Post Code")
        modify("Privacy Blocked") { Visible = false; }
        modify(Blocked) { Visible = false; }
        modify("Post Code") { Editable = false; }
        modify(City) { Editable = false; }
        addafter(Blocked)
        {
            field("Customer Status"; "Customer Status")
            {
                ApplicationArea = all;
                Caption = 'Customer_Status';
                Editable = false;


                trigger OnDrillDown()
                var
                    myInt: Integer;
                    StatusHi: Record "Status History";
                    StatusHIPage: page "Status history";

                begin

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        UserSetup."Source Table" := 18;
                        UserSetup."Customer No." := rec."No.";
                        UserSetup.Modify();



                    end;

                    StatusHi.RESET;
                    StatusHi.SETFILTER("Source Table", '%1', 18);
                    StatusHi.SetFilter("Customer No.", '%1', Rec."No.");
                    StatusHi.SetFilter(Active, '%1', true);
                    StatusHIPage.SetTableView(StatusHi);
                    StatusHIPage.RUN;
                    CurrPage.UPDATE;

                end;
            }
            field("Documents for customer"; "Documents for customer")
            {
                DrillDown = true;
                caption = 'Document No.';
                Lookup = true;
                DrillDownPageId = 50096;
                LookupPageId = 50096;

            }


        }
        modify("Salesperson Code") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Service Zone Code") { Visible = false; }
        modify("Document Sending Profile") { Visible = false; }
        modify("Disable Search by Name") { Visible = false; }
        modify("IC Partner Code") { Visible = false; }
        modify("Use GLN in Electronic Document") { Visible = false; }
        modify("Copy Sell-to Addr. to Qte From") { Visible = false; }
        modify("Tax Area Code") { Visible = false; }
        modify("Invoice Copies") { Visible = false; }
        modify("Partner Type") { Visible = false; }
        modify("Print Statements") { Visible = false; }
        modify("Last Statement No.") { Visible = false; }
        modify("Block Payment Tolerance") { Visible = false; }
        modify("Shipping Agent Code") { Visible = false; }
        modify("Shipping Agent Service Code") { Visible = false; }
        modify("Base Calendar Code") { Visible = false; }
        modify("Customized Calendar") { Visible = false; }

        addbefore("Customer Status")
        {
            field(Activity; Activity) { ApplicationArea = all; }
            field("Activity Code"; "Activity Code") { ApplicationArea = all; Editable = False; }
            field("Activity ID"; "Activity ID") { }
        }


        addafter(Agreement)
        {
            field("Subsidies - YES/NO "; "Subsidies - YES/NO") { ApplicationArea = all; }
            field("Subsidies - has statement"; "Subsidies - has statement") { ApplicationArea = all; }
        }

        addafter("Tax Liable")
        {
            field("Cust VAT Excluded"; "Cust VAT Excluded") { ApplicationArea = all; }
        }



    }

    actions
    {
        // Add changes to page actions here
        modify("Report Statement") { Visible = false; }
        modify(BackgroundStatement) { Visible = false; }
        addafter("F&unctions")
        {

            action("Precategory Updat")
            {
                ApplicationArea = All;
                Caption = 'Precategory Updat';
                Image = ServiceItemGroup;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ServItemStreets: Report "Precategory Updat";
                    US: Record "User Setup";
                begin
                    us.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us.NewCust := rec."No.";
                        if rec."Customer Category" = rec."Customer Category"::Household then
                            us.NewMM := rec."No."
                        else
                            us.NewMM := '';
                        us.Modify();
                        Commit();
                    end;
                    ServItemStreets.Run();
                end;
            }


            action("Uvoz bankovnih računa")
            {
                ApplicationArea = all;
                Caption = 'Uvoz bankovnih računa';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "Bank Account Import";

                begin
                    CustomerTable.Run();

                end;
            }
            action("Obrada - knjižne grupe")
            {
                ApplicationArea = all;
                Caption = 'Obrada - knjižne grupe';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: Record Customer;

                begin
                    CustomerTable.Reset();
                    CustomerTable.SetFilter("Customer Category", '%1|%2|%3|%4|%5', 1, 2, 3, 4, 5);
                    if CustomerTable.FindFirst() then
                        repeat
                            IF CustomerTable."Customer Category".AsInteger() = 1 then
                                CustomerTable."Gen. Bus. Posting Group" := 'DOMAĆINSTVA';
                            IF CustomerTable."Customer Category".AsInteger() = 2 then
                                CustomerTable."Gen. Bus. Posting Group" := 'VELIKA PRIVREDA';
                            IF CustomerTable."Customer Category".AsInteger() = 3 then
                                CustomerTable."Gen. Bus. Posting Group" := 'MALA PRIVREDA';
                            IF CustomerTable."Customer Category".AsInteger() = 4 then
                                CustomerTable."Gen. Bus. Posting Group" := 'TOPLANE';
                            IF CustomerTable."Customer Category".AsInteger() = 5 then
                                CustomerTable."Gen. Bus. Posting Group" := 'SP';
                            if CustomerTable."VAT Registration No." <> '' then begin
                                CustomerTable."VAT Bus. Posting Group" := 'K-17-PDV';
                                CustomerTable.Modify();
                            end else begin
                                CustomerTable."VAT Bus. Posting Group" := 'K-0-PDV';

                            end;
                            IF CustomerTable."Customer Category".AsInteger() = 1 then
                                CustomerTable."Customer Posting Group" := 'GAS-DOM';
                            IF CustomerTable."Customer Category".AsInteger() = 2 then
                                CustomerTable."Customer Posting Group" := 'GAS-PL';
                            IF CustomerTable."Customer Category".AsInteger() = 3 then
                                CustomerTable."Customer Posting Group" := 'GAS-MP';
                            IF CustomerTable."Customer Category".AsInteger() = 4 then
                                CustomerTable."Customer Posting Group" := 'GAS-PL';
                            IF CustomerTable."Customer Category".AsInteger() = 5 then
                                CustomerTable."Customer Posting Group" := 'GAS-PL';
                            CustomerTable.Modify();
                        until CustomerTable.Next() = 0;
                end;
            }

            action("Obrada - Br ulice za kupce")
            {
                ApplicationArea = All;
                Caption = 'Obrada Br ulice za kupce';
                Image = CustomerSalutation;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerStreets: XmlPort "Update Street No For Customer";
                begin
                    CustomerStreets.Run();
                end;
            }
            action("Obrada - import")
            {
                ApplicationArea = all;
                Caption = 'Obrada - import';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "Customer Import";

                begin
                    CustomerTable.RUN;
                end;
            }
            //50202 "DataImport"

            /* action("Obrada - import DJ")
             {
                 ApplicationArea = all;
                 Caption = 'Obrada - import DJ';
                 Image = PaymentPeriod;
                 Promoted = true;
                 PromotedCategory = Category9;
                 Visible = true;

                 trigger OnAction()
                 var
                     CustomerTable: XmlPort DataImport;

                 begin
                     CustomerTable.RUN;
                 end;
             }
 */
            action("Obrada - import razlike")
            {
                ApplicationArea = all;
                Caption = 'Obrada - import';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "Customer Import SaGAS";

                begin
                    CustomerTable.RUN;
                end;
            }
            //"Customer Contract Import"

            action("Obrada - import Ugovor")
            {
                ApplicationArea = all;
                Caption = 'Obrada - import ugovor';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "Customer Contract Import";

                begin
                    CustomerTable.RUN;
                end;
            }
            //"UpdateAll"

            action("Ažuriranje šifri - ispravke")
            {
                ApplicationArea = all;
                Caption = 'Ažuriranje šifri - ispravke';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "UpdateAll";

                begin
                    CustomerTable.RUN;
                end;
            }


            action(ImportNotesFMExcel)
            {
                Caption = 'Import Notes From Excel';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction()
                begin
                    ReadExcelSheet();
                    ImportNotesFromExcel();
                end;
            }
            //
            action("Transfer to Gen journal Line")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Transfer to Gen Journal Line';
                Image = TransferToGeneralJournal;
                Visible = true;
                Tooltip = 'This action will transfer the balance amount to the General Journal Line and reprogram the debt.';

                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                    ReprogramReport: Report "Reprogramming of debt";
                begin
                    CustomerRec.Reset();
                    CustomerRec.SetFilter("No.", '%1', Rec."No.");
                    ReprogramReport.SetTableView(CustomerRec);
                    ReprogramReport.Run();
                end;
            }
        }
    }
    trigger OnClosePage()
    var
        myInt: Integer;
    begin
        if (Name = '') then
            Error('Kupac mora obavezno biti popunjen, već ste otvorili karticu. Molimo Vas da podatke popunite!');

    end;

    trigger OnOpenPage()
    var
        ServiceItem: Record "Service Item";
        us: Record "User Setup";
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;

        CalcFields("Customer Status");
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            if UserSetup.CurrentJnlBatchName <> '' then
                EditableMainCashier := false
            else
                EditableMainCashier := true;

        CustomerLedEntry.Reset();
        CustomerLedEntry.SetFilter(Active, '%1', true);
        CustomerLedEntry.SetFilter("Customer No.", '%1', "No.");
        if CustomerLedEntry.FindFirst() then
            Broj := CustomerLedEntry.Count
        else
            Broj := 0;

        ServiceItem.Reset();
        ServiceItem.SetFilter("Customer No.", '%1', rec."No.");
        ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
        CUM := ServiceItem.Count;

        ServiceItem.Reset();
        ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
        ServiceItem.SetFilter("Customer No. - Gauge", '%1', rec."No.");
        MM_2 := ServiceItem.Count;




    end;

    //modification permission-EK
    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_K;
        if not CanModify then begin
            Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        ServiceItem: Record "Service Item";
        US: Record "User Setup";
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;

        CalcFields("Customer Status");
        CustomerLedEntry.Reset();
        CustomerLedEntry.SetFilter(Active, '%1', true);
        CustomerLedEntry.SetFilter("Customer No.", '%1', "No.");

        if CustomerLedEntry.FindFirst() then
            Broj := CustomerLedEntry.Count
        else
            Broj := 0;

        ServiceItem.Reset();
        ServiceItem.SetFilter("Customer No.", '%1', rec."No.");
        ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
        CUM := ServiceItem.Count;

        ServiceItem.Reset();
        ServiceItem.SetFilter("Status MM", '%1', ServiceItem."Status MM"::Active);
        ServiceItem.SetFilter("Customer No. - Gauge", '%1', rec."No.");
        MM_2 := ServiceItem.Count;
    end;

    local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile = '' then
            Error(NoFileFoundMsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(IStream, TempExcelBuffer.SelectSheetsNameStream(IStream));
        TempExcelBuffer.ReadSheet();
    end;

    local procedure GetLastLinkID()
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.Reset();
        if RecordLink.FindLast() then
            LastLinkID := RecordLink."Link ID"
        else
            LastLinkID := 0;
    end;

    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

    local procedure ImportNotesFromExcel()
    var
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
        RecordLink: Record "Record Link";
        Item: Record Customer;
        RecordLinkMgt: Codeunit "Record Link Management";


    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then
            MaxRowNo := TempExcelBuffer."Row No.";
        LastLinkID := 0;
        GetLastLinkID();
        for RowNo := 2 to MaxRowNo do begin
            LastLinkID += 1;
            RecordLink.Init();
            RecordLink."Link ID" := LastLinkID;
            RecordLink.Insert();
            RecordLink.Company := CompanyName;
            RecordLink.Type := RecordLink.Type::Note;
            RecordLink.Created := CurrentDateTime;
            RecordLink."User ID" := UserId;
            Item.Get(GetValueAtCell(RowNo, 1));
            RecordLink."Record ID" := Item.RecordId;
            RecordLinkMgt.WriteNote(RecordLink, GetValueAtCell(RowNo, 3));
            RecordLink.Modify();

        end;
        Message('Done!');
    end;

    var
        UserSetup: Record "User Setup";
        Control: Boolean;
        UploadExcelMsg: Label 'Please Choose the Excel file.';
        TempExcelBuffer: Record "Excel Buffer" temporary;
        NoFileFoundMsg: Label 'No Excel file found!';
        LastLinkID: Integer;
        EditableMainCashier: Boolean;
        CUM: Integer;
        myInt: Integer;
        CustomerLedEntry: Record "Customer Ledger Entry";
        CustLedEntries: Page "Customer Ledger Entries -SA";
        Broj: Integer;
        MM_2: Integer;
        Customer_Status: text[250];
        CanModify: Boolean;
}