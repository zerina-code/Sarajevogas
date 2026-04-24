page 50165 "Unknown data"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Unknown data";
    Caption = 'Unknown data';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field("Year Of GAS Calculation"; "Year Of GAS Calculation") { ApplicationArea = all; }
                field("Month Of GAS Calculation"; "Month Of GAS Calculation") { ApplicationArea = all; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field(Gauge; Gauge) { ApplicationArea = all; }
                field("Serial Number"; "Serial Number") { ApplicationArea = all; }


                field("Previous Date"; "Previous Date") { ApplicationArea = all; }




                field("Temperature previous - gauge"; "Temperature previous - gauge") { }
                field("Temperature new- gauge"; "Temperature new- gauge") { }
                field("Temperature result- gauge"; "Temperature result- gauge") { }
                field("Pressure previous - gauge"; "Pressure previous - gauge") { }
                field("Pressure new- gauge"; "Pressure new- gauge") { }
                field("Pressure result- gauge"; "Pressure result- gauge") { }
                field("Old Value"; "Old Value") { ApplicationArea = all; }
                field("New Value"; "New Value") { ApplicationArea = all; }

                field(Difference; Difference) { ApplicationArea = all; }

                field("Correction previous - gauge"; "Correction previous - gauge") { }
                field("Correction new- gauge"; "Correction new- gauge") { }
                field("Correction result- gauge"; "Correction result- gauge") { }
                field("UnCorrection previous - gauge"; "UnCorrection previous - gauge") { }
                field("UnCorrection new- gauge"; "UnCorrection new- gauge") { }
                field("UnCorrection result- gauge"; "UnCorrection result- gauge") { }
                field("Temperature Correction"; "Temperature Correction") { }
                field("Pressure Correction"; "Pressure Correction") { }

                field(SM3; SM3)
                {
                    ApplicationArea = all;
                    Style = Unfavorable;
                    StyleExpr = true;

                }
            }
        }
    }


    var
        myInt: Integer;
}