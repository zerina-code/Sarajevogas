page 50154 "Gas Installation Data"
{
    Caption = 'Gas Installation Data';
    PageType = List;
    SourceTable = "Gas Installation Data";
    CardPageId = "Gas Installation Data Card";
    UsageCategory = Administration;
    ApplicationArea = all;
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    begin
                        OnDrillDownEntryNo();
                    end;
                }
                field(Date; Date) { }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Municipality Name"; Rec."Municipality Name")
                {
                    ApplicationArea = All;
                }
                field(Street; Street) { }
                field("Street Name"; "Street Name") { }
                field("Home No."; "Home No.") { }
                field(Floor; Floor) { }
                field("Apartment No."; "Apartment No.") { }
                field("MP Street"; "MP Street") { }
                field("MP Street Name"; "MP Street Name") { }
                field("MP Home No."; "MP Home No.") { }
                field("MP Floor"; "MP Floor") { }
                field("MP Apartment No."; "MP Apartment No.") { }
                field("MP MZ"; "MP MZ") { }
                field("MP MZ Name"; "MP MZ Name") { }


                field(MZ; MZ) { }
                field("MZ Name"; "MZ Name") { }

                field("Measure Point No."; Rec."Measure Point No.")
                {
                    ApplicationArea = All;
                }
                field("Gauge No."; Rec."Gauge No.")
                {
                    ApplicationArea = All;
                }
                field("MP Municipality Name"; Rec."MP Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("Gas Station Placement"; "Gas Station Placement") { }
                field("Pipe/Connection Type"; "Pipe/Connection Type") { }
                field("Ceiling Ventilation"; "Ceiling Ventilation") { }
                field("Outdoor Ventilation"; "Outdoor Ventilation") { }
                field("RMS Disconn."; "RMS Disconn.") { }
                field("Gas Appliance Disconn."; "Gas Appliance Disconn.") { }
                field("Visual inspection of the gas"; "Visual inspection of the gas") { }
                field("Observed flaws in RMS"; "Observed flaws in RMS") { }
                field("The seal is correct"; "The seal is correct") { }
                field(Hardness; Hardness) { }
                field(Impermeability; Impermeability) { }
                field(Usability; Usability) { }
                field(Attest; Attest) { }
                field("Attest Text"; "Attest Text") { }
                field(Chimney; Chimney) { }
                field(Serviceman; Serviceman) { }
                field("Serviceman Text"; "Serviceman Text") { }
                field("Alternative Fuel"; "Alternative Fuel") { }
                field("Alternative fuel text"; "Alternative fuel text") { }
                field("Alternative fuel Date"; "Alternative fuel Date") { }
                field(Purpose; Purpose) { }
                field("Connection Elements Locked"; "Connection Elements Locked") { }
                field("Accessible for Reading"; "Accessible for Reading") { }
                field("RMS Reading"; "RMS Reading") { }
                field("Technical Doc. Provided"; "Technical Doc. Provided") { }
                field("Designer Connection Type"; "Designer Connection Type") { }
                field("Designer No."; "Designer No.") { }
                field("Consent ID"; "Consent ID") { }
                field("Total Heating Area"; "Total Heating Area") { }
                field("UGI - affect tightness"; "UGI - affect tightness") { }
                field("All openings tightly closed"; "All openings tightly closed") { }
                field("Detection of gas lines"; "Detection of gas lines") { }
                field(CO2; CO2) { }
                field("Visual inspection of the RMS"; "Visual inspection of the RMS") { }

                field("UGI is technically correct"; "UGI is technically correct") { }
                field("UGI out of operation"; "UGI out of operation") { }


                field("UGI put into operation"; "UGI put into operation") { }
                field("UGI remained in operation"; "UGI remained in operation") { }
                field("UGI remained out of order"; "UGI remained out of order") { }



            }
        }
    }
    actions

    {
        area(Reporting)
        {
            action(ImportUGI)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'ImportGID';
                Ellipsis = true;
                Image = ImportExcel;

                trigger OnAction()
                var
                    UGI: XmlPort ImportGID;
                begin
                    UGI.Run;
                end;

            }
            action(ImportGA)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'ImportGA';
                Ellipsis = true;
                Image = ImportExcel;

                trigger OnAction()
                var
                    GA: XmlPort ImportGasAppliance;
                begin
                    GA.Run;
                end;

            }
        }


    }



    local procedure OnDrillDownEntryNo()
    begin
        Page.Run(Page::"Gas Installation Data Card", Rec);
    end;






}

