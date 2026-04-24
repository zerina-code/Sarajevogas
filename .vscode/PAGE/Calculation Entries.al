page 50184 "Calculation Entries"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Calculation Journal Line";
    Caption = 'Calculation Entries';
    SourceTableView = where(Locked = filter(true));


    layout
    {
        area(Content)
        {
            repeater("")

            {
                field(Autoint; Autoint) { Visible = false; }
                field(Code; Code) { ApplicationArea = all; Visible = Visib; }
                field("Month Of GAS Calculation"; "Month Of GAS Calculation") { Visible = Visib; }
                field("Year Of GAS Calculation"; "Year Of GAS Calculation") { Visible = Visib; }
                field("Calculation Date From"; "Calculation Date From") { Visible = false; }
                field("Calculation Date To"; "Calculation Date To") { }
                field("Reading Date From"; "Reading Date From") { }
                field("Reading Date To"; "Reading Date To") { }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }

                field("Gauge"; "Gauge") { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field(MM; MM) { ApplicationArea = all; Visible = false; }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Address Customer"; "Address Customer") { ApplicationArea = all; }
                field("Proceedings No."; "Proceedings No.") { Visible = Visib; }
                field("Method of calculation"; "Method of calculation") { Visible = Visib; }
                field("Previous Date"; "Previous Date") { ApplicationArea = all; Visible = Visib; }



                field("Temperature previous - gauge"; "Temperature previous - gauge") { Visible = Visib; }
                field("Temperature new- gauge"; "Temperature new- gauge") { Visible = Visib; }
                field("Temperature result- gauge"; "Temperature result- gauge") { Visible = Visib; }
                field("Pressure previous - gauge"; "Pressure previous - gauge") { Visible = Visib; }
                field("Pressure new- gauge"; "Pressure new- gauge") { Visible = Visib; }
                field("Pressure result- gauge"; "Pressure result- gauge") { Visible = Visib; }
                field("Old Value"; "Old Value") { ApplicationArea = all; }
                field("New Value"; "New Value") { ApplicationArea = all; }

                field(Difference; Difference) { ApplicationArea = all; Visible = Visib; }
                field(SM3; SM3) { ApplicationArea = all; }
                field("Correction previous - gauge"; "Correction previous - gauge") { Visible = Visib; }
                field("Correction new- gauge"; "Correction new- gauge") { Visible = Visib; }
                field("Correction result- gauge"; "Correction result- gauge") { Visible = Visib; }
                field("UnCorrection previous - gauge"; "UnCorrection previous - gauge") { Visible = Visib; }
                field("UnCorrection new- gauge"; "UnCorrection new- gauge") { Visible = Visib; }
                field("UnCorrection result- gauge"; "UnCorrection result- gauge") { Visible = Visib; }
                field("Temperature Correction"; "Temperature Correction") { Visible = Visib; }
                field("Pressure Correction"; "Pressure Correction") { Visible = Visib; }
                field("Scale factor"; "Scale factor") { Visible = Visib; }
                field("Calorific power coefficient"; "Calorific power coefficient") { Visible = Visib; }
                field("Compression coefficient"; "Compression coefficient") { Visible = Visib; }
                field("Atmospheric pressure"; "Atmospheric pressure") { Visible = Visib; }
                field("% reduction"; "% reduction") { Visible = Visib; }

                field("Unit Price"; "Unit Price") { ApplicationArea = all; Visible = Visib; }
                field("GAS - amount"; "GAS - amount") { ApplicationArea = all; }
                field("GAS - VAT"; "GAS - VAT") { ApplicationArea = all; }
                field("GAS - part"; "GAS - part") { ApplicationArea = all; ; }
                field("Basis maintenance"; "Basis maintenance") { ApplicationArea = all; }
                field("Maintenance VAT"; "Maintenance VAT") { ApplicationArea = all; }
                field("Maintenance - part"; "Maintenance - part") { ApplicationArea = all; }
                field(Total; Total) { ApplicationArea = all; }
                field("Correct consumption "; "Correct consumption") { Visible = Visib; }
                field(USERID; USERID) { Visible = Visib; }
                field(Locked; Locked) { Visible = Visib; }
                field("Bill Created"; "Bill Created") { Visible = Visib; }
                field("Category Customer"; "Category Customer") { }
                field("Category MM"; "Category MM") { }
                field("Source Data"; "Source Data") { }
                field("EU Activity"; "EU Activity") { }


            }



        }




    }

    actions
    {
        area(Reporting)
        {


            action("Preview Print Sales Invoice")
            {
                Caption = 'Preview Print Sales Invoice';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                begin
                    Report.Run(50182, true, true, rec);
                end;
            }
        }


    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        uSerP.Reset();
        uSerP.SetFilter("User ID", '%1', UserId);
        uSerP.SetFilter("Profile ID", '%1', 'SALES AGENT - Natural GAS');
        if uSerP.FindFirst() then
            Visib := true
        else
            Visib := false;

        SetRange("Date Filter", 0D, "Calculation Date To");
        SetCurrentKey("Year Of GAS Calculation", "Month Of GAS Calculation", "Measuring Point Code");
        Ascending(false);

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        uSerP.Reset();
        uSerP.SetFilter("User ID", '%1', UserId);
        uSerP.SetFilter("Profile ID", '%1', 'SALES AGENT - Natural GAS');
        if uSerP.FindFirst() then
            Visib := true
        else
            Visib := false;

    end;



    var
        myInt: Integer;
        uSerP: Record "User Personalization";
        Visib: Boolean;



}