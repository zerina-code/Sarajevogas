page 50117 "Gas Installation Data Card"
{
    Caption = 'Gas Installation Data Card';
    PageType = Card;
    SourceTable = "Gas Installation Data";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Date) { }
                field("Gas Station No."; Rec."Gas Station No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = False;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Municipality Code"; Rec."Municipality Code")
                {
                    ApplicationArea = All;
                }
                field("Municipality Name"; Rec."Municipality Name")
                {
                    ApplicationArea = All;
                }
                field(MZ; Rec.MZ)
                {
                    ApplicationArea = All;
                }
                field("MZ Name"; Rec."MZ Name")
                {
                    ApplicationArea = All;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                }
                field("Street Name"; Rec."Street Name")
                {
                    ApplicationArea = All;
                }
                field("Home No."; Rec."Home No.")
                {
                    ApplicationArea = All;
                }
                field(Floor; Rec.Floor)
                {
                    ApplicationArea = All;
                }
                field("Apartment No."; Rec."Apartment No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Measure Point")
            {
                Caption = 'Measure Point';
                field("Measure Point No."; Rec."Measure Point No.")
                {
                    ApplicationArea = All;
                }
                field("Gauge No."; Rec."Gauge No.")
                {
                    ApplicationArea = All;
                }
                field("Gas Station Placement"; "Gas Station Placement") { }
                field("Connection Elements Locked"; Rec."Connection Elements Locked")
                {
                    ApplicationArea = All;
                }
                field("Accessible for Reading"; Rec."Accessible for Reading")
                {
                    ApplicationArea = All;
                }
                field("RMS Reading"; "RMS Reading") { BlankZero = true; }
                field("Reading Value 0"; "Reading Value 0") { }

                field("Intervention valve in RMS"; "Intervention valve in RMS") { }

                field("Shutdown on the IV"; "Shutdown on the IV") { }
                field("RMS Disconn."; "RMS Disconn.") { }
                field("Plomba SG RMS"; "Plomba SG RMS") { }
                field("Visual inspection of the RMS"; "Visual inspection of the RMS") { }
                field("Observed flaws in RMS"; "Observed flaws in RMS") { }
                field("The seal is correct"; "The seal is correct") { }

                field(CH4; CH4) { }
                field("Const CH4"; "Const CH4") { }
                field(ppm; ppm) { }
                field("Location of leakage"; "Location of leakage") { }
                field("Alternative Fuel"; "Alternative Fuel") { }
                field("Alternative fuel text"; "Alternative fuel text") { }
                field("Alternative fuel Date"; "Alternative fuel Date") { }
                field("Total Heating Area"; "Total Heating Area") { }
                field(Purpose; Purpose) { }

                field("Technical Doc. Provided"; Rec."Technical Doc. Provided")
                {
                    ApplicationArea = All;
                }
                field("Consent ID"; Rec."Consent ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("MP Municipality Code"; Rec."MP Municipality Code")
                {
                    ApplicationArea = All;
                }
                field("MP Municipality Name"; Rec."MP Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("MP MZ"; Rec."MP MZ")
                {
                    ApplicationArea = All;
                }
                field("MP MZ Name"; Rec."MP MZ Name")
                {
                    ApplicationArea = All;
                }
                field("MP Street"; Rec."MP Street")
                {
                    ApplicationArea = All;
                }
                field("MP Street Name"; Rec."MP Street Name")
                {
                    ApplicationArea = All;
                }
                field("MP Home No."; Rec."MP Home No.")
                {
                    ApplicationArea = All;
                }
                field("MP Floor"; Rec."MP Floor")
                {
                    ApplicationArea = All;
                }
                field("MP Apartment No."; Rec."MP Apartment No.")
                {
                    ApplicationArea = All;
                }
                field("Measuring Point Stroke"; "Measuring Point Stroke") { }
                field("Measuring Point string"; "Measuring Point string") { }
            }
            group("Installation Data")
            {
                Caption = 'Installation Data';

                field(Hardness; Rec.Hardness)
                {
                    ApplicationArea = All;
                }
                field("Hardness Date"; "Hardness Date") { }
                field(Impermeability; Rec.Impermeability)
                {
                    ApplicationArea = All;
                }
                field("Impermeability Date"; "Impermeability Date") { }
                field("Usability UGI"; Rec."Usability UGI") { }

                field(Usability; Rec.Usability)
                {
                    ApplicationArea = All;
                }
                field("Usability Date"; "Usability Date") { }
                field("Working pressure test"; "Working pressure test") { }

                field("Working pressure Date test"; "Working pressure Date test") { }
                field("Attest Electro Execution"; "Attest Electro Execution") { }
                field(Attest; Attest) { }
                field("Attest Text"; "Attest Text") { }
                field("Attest date"; "Attest date") { }
                field("Chimney System Control Execution"; "Chimney System Control Execution") { }
                field(Chimney; Rec.Chimney)
                {
                    ApplicationArea = All;
                }
                field("Chimney Date"; "Chimney Date") { }
                field("Gas appliance service"; "Gas appliance service") { }
                field("Gas appliance service date"; "Gas appliance service date") { }
                field(Serviceman; Rec.Serviceman)
                {
                    ApplicationArea = All;
                }
                field("Serviceman Text"; "Serviceman Text") { }



                group("Gas Line")
                {
                    Caption = 'Gas Line';

                    field("Pipe/Connection Type"; Rec."Pipe/Connection Type")
                    {
                        ApplicationArea = All;
                    }
                    field("Connection type"; "Connection type") { }
                    field("Anticorrosive protection"; "Anticorrosive protection") { }

                    field("Fire Protection"; "Fire Protection") { }


                    /*    field("Designer Connection Type"; Rec."Designer Connection Type")
                        {
                            ApplicationArea = All;
                        }
                        field("Designer No."; Rec."Designer No.")
                        {
                            ApplicationArea = All;
                        }*/

                    field("Ceiling Ventilation"; Rec."Ceiling Ventilation")
                    {
                        ApplicationArea = All;
                    }

                    field("Outdoor Ventilation"; Rec."Outdoor Ventilation")
                    {
                        ApplicationArea = All;
                    }
                    /*   field("Gas Appliance Disconn."; Rec."Gas Appliance Disconn.")
                       {
                           ApplicationArea = All;
                       }*/

                }

                group("After Control Gas Line")
                {
                    Caption = 'After Control Gas Line';
                    field("Visual inspection of the gas"; "Visual inspection of the gas") { }

                    field("UGI - affect tightness"; "UGI - affect tightness") { }
                    field("All openings tightly closed"; "All openings tightly closed") { }
                    field("Detection of gas lines"; "Detection of gas lines") { }
                    field(ppm1; ppm1) { }
                    field("Location of leakage1"; "Location of leakage1") { }
                    field(CO2; CO2) { }
                    field(ppm2; ppm2) { }
                    field("Location of leakage2"; "Location of leakage2") { }
                    field("UGI is technically correct"; "UGI is technically correct") { }
                    field("UGI put into operation"; "UGI put into operation") { }
                    field("UGI remained in operation"; "UGI remained in operation") { }
                    field("UGI out of operation"; "UGI out of operation") { }
                    field("UGI remained out of order"; "UGI remained out of order") { }


                    field("Shutdown gas consumer"; "Shutdown gas consumer") { }
                    field("Shutdown gas consumer by"; "Shutdown gas consumer by") { }

                    field("Plomba SG GA"; "Plomba SG GA") { }
                    field(Remark; Remark) { }
                    field("Due Date"; "Due Date") { }
                }



            }
            part("Gas Appliances"; "Gas Appliances Subform")
            {
                ApplicationArea = All;
                Caption = 'Gas Appliances';
                SubPageLink = "Gas Install. Data Entry No." = field("Entry No."), "Measure Point No." = field("Measure Point No.");
            }


        }

        area(FactBoxes)
        {
            part("Attached Documents"; "Document Att. Det. FactBox")
            {
                ApplicationArea = All;

                Caption = 'Attachments';
                //   Provider = "Measure Points List";
                Editable = True;

                SubPageLink = "Table ID" = CONST(5940),
                              "No." = FIELD("Measure Point No.");

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        if "Measure Point No." <> '' then
            OnValidateMeasurePointNo();
    end;
}
