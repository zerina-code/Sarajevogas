pageextension 50086 "Service Item Card" extends "Service Item Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Item No.") { Visible = false; }
        modify("Item Description") { Visible = false; }

        modify(Description)
        {
            Visible
        = false;
        }
        modify("No.") { Visible = true; }
        modify(Address) { Editable = false; Visible = false; }
        modify("Address 2") { Editable = false; Visible = false; }










        addafter(Description)
        {

            group("Measuring Point")

            {
                Caption = 'Address Detailed';

                field(Description2; Description) { ApplicationArea = all; }
                field("Description 2"; "Description 2") { ApplicationArea = all; }
                field("MM Category"; "MM Category") { ApplicationArea = all; Editable = false; }
                field(Gauge_3_; Gauge_3_)
                {

                    ApplicationArea = all;
                    Caption = 'Gauge 3';
                    Editable = false;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record gauge;
                        GCard: page Gauges;
                        GList: page "Gauge List";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";

                            us.Modify();
                        end;

                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', Rec."No.");
                        if Gauge_3_ > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;





                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record gauge;
                        GCard: page Gauges;
                        GList: page "Gauge List";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";
                            us.Modify();
                        end;
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', Rec."No.");
                        if Gauge_3_ > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;


                    end;




                }
                field(Corrector_3; Corrector_3)
                {
                    ApplicationArea = all;
                    Caption = 'Corrector 3';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "El. Volume Corr";
                        GCard: page "EL. Volume Corr.";
                        GList: page "EL. Volume Corr. List";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";
                            us.Modify();
                        end;
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', Rec."No.");
                        if Gauge.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;





                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "El. Volume Corr";
                        GCard: page "EL. Volume Corr.";
                        GList: page "EL. Volume Corr. List";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";
                            us.Modify();
                        end;
                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', Rec."No.");
                        if Gauge.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;


                    end;
                }

                field("Radio Module"; "Radio Module")
                {

                    ApplicationArea = all;
                    Visible = False;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "Radio Module";
                        GCard: page "Radio Module Card";
                        GList: page "Radio Module";
                        IHC: Record "Installation History";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";
                            us.Modify();
                        end;
                        IHC.Reset();
                        IHC.SetFilter(Type, '%1', IHC.Type::Radio_Module);
                        IHC.SetFilter("Measuring Point Code", '%1', rec."No.");
                        ihc.SetFilter("Installation Date", '<=%1', WorkDate);
                        ihc.SetFilter(Active, '%1', true);

                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point Code", '%1', Rec."No.");

                        if ihc.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            Gauge.SetFilter(Code, '%1', ihc.Code);
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;





                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        Gauge: Record "Radio Module";
                        GCard: page "Radio Module Card";
                        GList: page "Radio Module";
                        IHC: Record "Installation History";
                    begin
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Adress MM" := Rec."Address MM";
                            us."Customer No." := Rec."Customer No.";
                            us."Measuring Code" := rec."No.";
                            us.Modify();
                        end;
                        IHC.Reset();
                        IHC.SetFilter(Type, '%1', IHC.Type::Radio_Module);
                        IHC.SetFilter("Measuring Point Code", '%1', rec."No.");
                        ihc.SetFilter("Installation Date", '<=%1', WorkDate);
                        ihc.SetFilter(Active, '%1', true);

                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point Code", '%1', Rec."No.");

                        if ihc.Count > 1 then begin
                            GList.SetTableView(Gauge);
                            GList.Run();
                        end
                        else begin
                            Gauge.SetFilter(Code, '%1', ihc.Code);
                            GCard.SetTableView(Gauge);
                            GCard.Run();

                        end;





                    end;
                }

                field("Status MM"; "Status MM")
                {
                    ApplicationArea = all;



                    //prikaži stranice i otvori listu

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        StatusHi: Record "Status History MM";
                        StatusHIPage: page "Status history MM";
                        UserSetup: Record "User Setup";

                    begin


                        UserSetup.Reset();
                        UserSetup.SetFilter("User ID", '%1', UserId);
                        if UserSetup.FindFirst() then begin
                            UserSetup."Source Table" := 5940;
                            UserSetup.modify;


                            Commit();
                        end;

                        StatusHi.RESET;
                        StatusHi.SETFILTER("Source Table", '%1', 5940);
                        StatusHi.SetFilter("Measuring Point", '%1', Rec."No.");
                        StatusHi.SetFilter(Active, '%1', true);
                        StatusHIPage.SetTableView(StatusHi);
                        StatusHIPage.RUN;
                        //      CurrPage.UPDATE;

                    end;


                }



                field("Measuring point off"; "Measuring point off") { }
                field("Measuring point off Date"; "Measuring point off Date") { }
                field("Measuring point in"; "Measuring point in") { }
                field("Measuring point in Date"; "Measuring point in Date") { }
                field("Last Reason"; "Last Reason") { }
                field("Dwelling Type"; Rec."Dwelling Type") { ApplicationArea = all; ShowMandatory = true; }

                group("CustomerNo")
                {
                    Caption = 'Customer No.';
                    field("Customer No. TEST"; "Customer No.")
                    {
                        Editable = editableCust;
                    }


                    field(Gauge_3_Cust; Gauge_3_Cust)
                    {
                        ApplicationArea = all;
                        Caption = 'Gauge_3_Cust';
                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            Customer: Record Customer;
                            CustomerCard: Page "Customer Card";
                        begin
                            CalcFields("Customer No. - Gauge");
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', "Customer No. - Gauge");
                            CustomerCard.SetTableView(Customer);
                            CustomerCard.Run();

                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            myInt: Integer;
                            Customer: Record Customer;
                            CustomerCard: Page "Customer Card";
                        begin
                            CalcFields("Customer No. - Gauge");
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', "Customer No. - Gauge");
                            CustomerCard.SetTableView(Customer);
                            CustomerCard.Run();

                        end;

                    }

                    field("Customer Name. - Gauge"; "Customer Name. - Gauge")
                    {
                        ApplicationArea = all;

                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            Customer: Record Customer;
                            CustomerCard: Page "Customer Card";
                        begin
                            CalcFields("Customer No. - Gauge");
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', "Customer No. - Gauge");
                            CustomerCard.SetTableView(Customer);
                            CustomerCard.Run();

                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            myInt: Integer;
                            Customer: Record Customer;
                            CustomerCard: Page "Customer Card";
                        begin
                            CalcFields("Customer No. - Gauge");
                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', "Customer No. - Gauge");
                            CustomerCard.SetTableView(Customer);
                            CustomerCard.Run();

                        end;
                    }
                }



            }
            group("Address Detailed")
            {
                Caption = 'Address Detailed';
                field("Applied address"; "Applied address") { ApplicationArea = all; }
                field(Street; Street) { ApplicationArea = all; }
                field("Street Name MM"; "Street Name MM") { ApplicationArea = all; Editable = false; }
                field("Street No."; "Street No.") { ApplicationArea = all; }
                field("Street No. Text"; "Street No. Text") { ApplicationArea = all; }



                field("Address MM"; "Address MM") { ApplicationArea = all; }


                field("Municipality Code MM"; "Municipality Code MM") { ApplicationArea = all; Editable = false; }
                field("Municipality Name MM"; "Municipality Name MM") { ApplicationArea = all; Editable = false; }
                field("MZ MM"; "MZ MM") { ApplicationArea = all; Editable = false; }
                field("MZ Name MM"; "MZ Name MM") { ApplicationArea = all; Editable = false; }


                field("Home No."; "Home No.") { ApplicationArea = all; }
                field(Floor; Floor) { ApplicationArea = all; }
                field("Apartment No."; "Apartment No.") { ApplicationArea = all; }
                field("Measuring Point Stroke"; "Measuring Point Stroke") { ApplicationArea = all; Editable = false; }
                field("Measuring Point string"; "Measuring Point string") { ApplicationArea = all; Editable = false; }
                field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }
                field(Hodogram; Hodogram) { ApplicationArea = all; }


                //ulica
                //kućni broj
                //sprat
                //stan



            }



            //djemina field("Customer Category"; "Customer Category") { ApplicationArea = all; }




            group("Adress Customer")


            {
                Caption = 'Adress Customer';
                field("Address Customer"; "Address Customer") { ApplicationArea = all; Editable = false; Visible = false; }

                field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Street Customer"; "Street Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Floor Customer"; "Floor Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = false; Visible = false; }
                field("Customer string"; "Customer string") { ApplicationArea = all; Editable = false; Visible = false; }

            }


        }

        addafter(General)
        {
            group("Z")
            {
                Caption = 'Zone and Activities';
                field(Activity; Activity)
                {
                    ApplicationArea = all;
                }
                field("EU Activity"; "EU Activity") { ApplicationArea = all; }
                field("EF Activity"; "EF Activity") { ApplicationArea = all; }

                field("Summer Zone"; "Summer Zone") { ApplicationArea = all; }
                field("Winter Zone"; "Winter Zone") { ApplicationArea = all; }
                field("Transit Zone"; "Transit Zone") { ApplicationArea = all; }
                field("Measuring Zone - winter"; "Measuring Zone - winter") { ApplicationArea = all; }
                field("Measuring Zone - summer"; "Measuring Zone - summer") { ApplicationArea = all; }
                field("Winter Pecentage"; "Winter Pecentage") { }
                field("Summer Pecentage"; "Summer Pecentage") { }
                field("Fictitious Code"; "Fictitious Code") { ApplicationArea = all; }
                field("Pressure Date"; "Pressure Date") { }
                field("Adjusted Pressure"; "Adjusted Pressure") { ApplicationArea = all; }
                field(GIS; GIS) { ApplicationArea = all; }


            }


        }
        addbefore("Z")
        {
            group("O")
            {
                Caption = 'Measuring';
                field("Reading Mode"; "Reading Mode")
                {
                    ApplicationArea = all;

                }
                field("Reading Type"; "Reading Type") { ApplicationArea = all; Visible = false; }
                field("Type of reading"; "Type of reading") { ApplicationArea = all; }
                field("Reading Time"; "Reading Time") { ApplicationArea = all; }
                field("Method of calculation"; "Method of calculation") { }
                field("Posting GAS"; "Posting GAS") { }
                field(Posting; Posting) { }
                field(Distribution; Distribution) { }
                field("Distribution - read"; "Distribution - read") { }
                field(Specification; Specification) { }
                field("Bill delivery"; "Bill delivery") { }
                field("RMS Maintenance"; "RMS Maintenance") { }


                field(Remotely; Remotely) { ApplicationArea = all; Editable = true; }

                field("Remotely Type"; "Remotely Type") { ApplicationArea = all; Editable = Edit; }
                field("Mobile No."; "Mobile No.") { ApplicationArea = all; Editable = Edit; }
                field("Economic/Technic"; "Economic/Technic") { ApplicationArea = all; Editable = Edit; Visible = false; }
            }
        }
        addbefore("O")
        {
            group("Parameters of the measuring point")
            {
                Caption = 'Parameters of the measuring point';
                field("Gauge Position"; "Gauge Position") { ApplicationArea = all; Editable = true; }

                field("Flow Direction"; "Flow Direction")
                {
                    ApplicationArea = All;
                }
                field("VU Installation"; "VU Installation")
                {
                    ApplicationArea = All;
                }
                field("HV Installation"; "HV Installation")
                {
                    ApplicationArea = All;
                }
                field("Pul"; "Pul") { ApplicationArea = all; }
                field("Piz"; "Piz") { ApplicationArea = all; }
                field("Tmin"; "Tmin") { ApplicationArea = all; }
                field("Tmax"; "Tmax") { ApplicationArea = all; }

            }
        }

        addafter("Z")
        {
            group(Contact2)
            {
                Caption = 'Contact Information';
                field(Contact3; Contact) { ApplicationArea = all; Editable = true; }
                field("Phone No.2"; "Phone No.") { ApplicationArea = all; }
                field("Applied Customer inf"; "Applied Customer inf") { ApplicationArea = all; }

                field("Contact MM"; "Contact MM") { ApplicationArea = all; Editable = true; }
                field("Phone No. MM"; "Phone No. MM") { ApplicationArea = all; }
                field("E-Mail"; "E-Mail") { ApplicationArea = all; }
                field("Mobile Phone No."; "Mobile Phone No.") { ApplicationArea = all; }


                field(Purpose; Purpose) { ApplicationArea = all; }
                field(Designer; Designer) { ApplicationArea = all; }
                field("Consent ID"; "Consent ID") { ApplicationArea = all; }
                field(Measured; Measured) { ApplicationArea = all; }
                field(Unmeasured; Unmeasured) { ApplicationArea = all; }




            }
            group("Consumption")
            {
                Caption = 'Consumption';
                field("Date 1"; "Date 1") { ApplicationArea = all; }
                field("Date 2"; "Date 2") { ApplicationArea = all; }
                field("Date 3"; "Date 3") { ApplicationArea = all; }
                field("Minimal Consumption"; "Minimal Consumption") { ApplicationArea = all; }
                field(Elevation; Elevation) { ApplicationArea = all; }
                field("Date TK"; "Date TK") { ApplicationArea = all; }

                field("Starting Measuring"; "Starting Measuring") { ApplicationArea = all; }
                field(Statement; Statement) { ApplicationArea = all; }
                field("Technical review"; "Technical review") { ApplicationArea = all; }

                field("Installed KW"; "Installed KW") { ApplicationArea = all; }
                field("Designed KW"; "Designed KW") { ApplicationArea = all; }


                field("Alternative fuel"; "Alternative fuel") { ApplicationArea = all; }
            }
        }
        addlast(content)
        {
            part("Gas Appliances"; "Gas Appliances Subform")
            {
                ApplicationArea = All;
                Caption = 'Gas Appliances';
                SubPageLink = "Measure Point No." = field("No."), "Gas Install. Data Entry No." = const(0);
            }
        }

        modify("Sell-to") { Visible = false; }
        modify(Shipping) { Visible = false; }
        modify(Vendor) { Visible = false; }
        modify(Contract) { Visible = false; }
        modify(Customer) { Visible = false; }
        modify(Detail) { Visible = false; }
        movebefore(Description2; "No.")
        movebefore("Municipality Code Customer"; "Address 2")
        movebefore("Municipality Code MM"; Address)
        modify("Service Item Group Code") { Visible = false; }
        modify("Service Price Group Code") { Visible = false; }
        modify("Service Item Components") { Visible = false; }
        modify("Search Description") { Visible = false; }
        modify("Response Time (Hours)") { Visible = false; }
        modify(Priority) { Visible = false; }
        modify("Last Service Date") { Visible = false; }
        modify("Warranty Starting Date (Labor)") { Visible = false; }
        modify("Warranty Starting Date (Parts)") { Visible = false; }
        modify("Warranty % (Labor)") { Visible = false; }
        modify("Warranty % (Parts)") { Visible = false; }
        modify("Warranty Ending Date (Labor)") { Visible = false; }
        modify("Warranty Ending Date (Parts)") { Visible = false; }
        modify("Preferred Resource") { Visible = false; }
        addafter("Dwelling Type")
        {
            field("MM VAT Excluded"; "MM VAT Excluded") { ApplicationArea = all; }
            field("Control Number"; "Control Number") { ApplicationArea = all; }

        }
        addafter("Phone No. MM")
        {
            field("Fax No."; "Fax No.") { ApplicationArea = all; }
            field("Fax No. - Transfer"; "Fax No. - Transfer") { ApplicationArea = all; }
        }






        addbefore("O")
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


        modify("Ship-to Post Code") { Visible = false; }
        moveafter("Municipality Name MM"; City)
        modify("Ship-to City") { Visible = false; }
        moveafter(City; "Post Code")

        addafter(City)
        {
            field("City MM"; "City MM") { Editable = false; }
            field("Post Code MM"; "Post Code MM") { Editable = false; }

        }


        modify("Country/Region Code") { Visible = false; }
        modify(City) { Visible = false; }
        modify("Post Code") { Visible = false; }
        modify("Ship-to Country/Region Code") { Visible = false; }
        modify(County) { Visible = false; }
        modify("Ship-to County") { Visible = false; }
        modify("Location of Service Item") { Visible = false; }
        modify(Contact) { Visible = false; }
        modify("Phone No.") { Visible = false; }
        modify("Ship-to Phone No.") { Visible = false; }
        modify("Variant Code") { Visible = false; }
        modify("Serial No.") { Visible = false; }
        modify(Status) { Visible = false; }

        moveafter("Address Detailed"; "Sell-to")
        /*ĐK brojac addbefore("Customer No. - Gauge")
        {
            field("Customer No.2"; "Customer No.") { ApplicationArea = all; Visible = true; }
            field(Name2; Name) { ApplicationArea = all; }
        }*/



    }



    actions
    {
        // Add changes to page actions here
        modify("&Service Item") { Visible = False; }
        modify(New) { Visible = False; }
        modify(Documents) { Visible = False; }
        modify(History) { Visible = False; }
        modify("Service Line Item Label") { Visible = False; }


        addafter("Service Item Lo&g")
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
                    us: Record "User Setup";
                begin
                    us.Reset();
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin
                        us.NewMM := rec."No.";
                        if rec."Customer Category" = rec."Customer Category"::Household then
                            us.NewCust := rec."No."
                        else
                            us.NewCust := '';
                        us.Modify();
                        Commit();
                    end;

                    ServItemStreets.Run();
                end;
            }

            action("Obrada - Br ulice za mjerna mjesta")
            {
                ApplicationArea = All;
                Caption = 'Obrada Br ulice za mjerna mjesta';
                Image = ServiceItemGroup;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ServItemStreets: XmlPort "Update StreetNo ServiceItem";
                begin
                    ServItemStreets.Run();
                end;
            }

            action("UpdateAddress- DJ")
            {
                ApplicationArea = All;
                Caption = 'UpdateAddress- DJ';
                Image = ServiceItemGroup;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ServItemStreets: XmlPort "Update Applied";
                begin
                    ServItemStreets.Run();
                end;
            }
        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Status MM");

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            editableCust := UserSetup."Allowed to update IH"
        else
            editableCust := false;

        Gauge_R.Reset();
        Gauge_R.SetFilter("Measuring Point Code", '%1', Rec."No.");
        Gauge_R.SetFilter(Active, '%1', true);
        Gauge_R.SetFilter(type, '%1', Gauge_R.Type::Gauge);
        Gauge_3_ := Gauge_R.Count;

        Gauge_R.Reset();
        Gauge_R.SetFilter("Measuring Point Code", '%1', Rec."No.");
        Gauge_R.SetFilter(Active, '%1', true);
        Gauge_R.SetFilter(type, '%1', Gauge_R.Type::Corrector);
        Corrector_3 := Gauge_R.Count;

        Rec.CalcFields("Customer No. - Gauge");
        if Rec."Customer No. - Gauge" <> Rec."Customer No. - Gauge" then begin
            Rec."Customer No." := rec."Customer No. - Gauge";
            Rec.Modify();
        end;
        if Remotely = true then
            Edit := true
        else
            Edit := false;

    end;
    //modification permission-EK
    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_M;
        if not CanModify then begin
            Error('You do not have permission to modify this item.');
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Status MM");

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            editableCust := UserSetup."Allowed to update IH"
        else
            editableCust := false;

        Gauge_R.Reset();
        Gauge_R.SetFilter("Measuring Point Code", '%1', Rec."No.");
        Gauge_R.SetFilter(Active, '%1', true);
        Gauge_R.SetFilter(type, '%1', Gauge_R.Type::Gauge);
        Gauge_3_ := Gauge_R.Count;

        Gauge_R.Reset();
        Gauge_R.SetFilter("Measuring Point Code", '%1', Rec."No.");
        Gauge_R.SetFilter(Active, '%1', true);
        Gauge_R.SetFilter(type, '%1', Gauge_R.Type::Corrector);
        Corrector_3 := Gauge_R.Count;



        if Remotely = true then
            Edit := true
        else
            Edit := false;
        Rec.CalcFields("Customer No. - Gauge");
        if Rec."Customer No. - Gauge" <> Rec."Customer No. - Gauge" then begin
            Rec."Customer No." := rec."Customer No. - Gauge";
            Rec.Modify();
        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Status MM");
        if Remotely = true then
            Edit := true
        else
            Edit := false;
        Rec.CalcFields("Customer No. - Gauge");
        if Rec."Customer No. - Gauge" <> Rec."Customer No. - Gauge" then begin
            Rec."Customer No." := rec."Customer No. - Gauge";
            Rec.Modify();
        end;

    end;

    var
        myInt: Integer;
        Corrector_3: Integer;
        Gauge_3_: Integer;
        Gauge_3_Cust: Integer;
        Edit: Boolean;
        Gauge_R: Record "Installation History";
        UserSetup: Record "User Setup";
        CanModify: Boolean;
        editableCust: Boolean;
}