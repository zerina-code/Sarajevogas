page 50091 "EL. Volume Corr. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "El. Volume Corr";
    Caption = 'El. Volume Corr List';
    CardPageId = "EL. Volume Corr.";

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field("Serial Number"; "Serial Number") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { ApplicationArea = all; }
                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field(Model; Model) { ApplicationArea = all; }
                field("The origin of the meter"; "The origin of the meter") { ApplicationArea = all; }
                field("Year of Production"; "Year of Production") { ApplicationArea = all; }
                field("DD calibration"; "DD calibration") { ApplicationArea = all; }
                field("N2%"; "N2%") { ApplicationArea = all; }
                field("Pressure from (N2%)"; "Pressure from (N2%)") { ApplicationArea = all; }
                field("Pressure to (N2%)"; "Pressure to (N2%)") { ApplicationArea = all; }
                field("CO2 %"; "CO2 %") { ApplicationArea = all; }
                field(Settings; Settings) { ApplicationArea = all; }
                field(Station; Station) { ApplicationArea = all; }
                field("Thick Air"; "Thick Air") { ApplicationArea = all; }
                field(Weight; Weight) { }
                field("Rel density"; "Rel density") { ApplicationArea = all; }
                field("Upper cal."; "Upper cal.") { ApplicationArea = all; }

                field("Pulse transmitter LF/HE"; "Pulse transmitter LF/HE") { ApplicationArea = all; }
                field("Z formule"; "Z formule") { ApplicationArea = all; }
                field("IMP. W"; "IMP. W") { ApplicationArea = all; }

                field("Base Pressure"; "Base Pressure") { ApplicationArea = all; }
                field("Base temperature"; "Base temperature") { ApplicationArea = all; }




            }

        }


    }

    actions
    {
        area(Processing)
        {
            action(ImportCorrection)
            {
                ApplicationArea = all;
                Caption = 'ImportCorrection';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportGaugue: XmlPort "El. Volume Corr Import";

                begin
                    ImportGaugue.RUN;
                end;
            }
        }
    }
    var
        myInt: Integer;


}