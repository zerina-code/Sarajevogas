page 50169 "EL. Volume Corr."
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "El. Volume Corr";
    Caption = 'El. Volume Corr';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Code)
                {
                    ApplicationArea = all;

                    trigger OnAssistEdit()
                    begin
                        if AssistEdit(xRec) then
                            CurrPage.Update;
                    end;
                }
                field("Serial Number"; "Serial Number") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { ApplicationArea = all; }
                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; visible = false; }
                field("Address MM"; "Address MM") { ApplicationArea = all; visible = false; }
                field("Customer No."; "Customer No.") { ApplicationArea = all; visible = false; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; visible = false; }
                field(Model; Model) { ApplicationArea = all; }
                field("The origin of the meter"; "The origin of the meter") { ApplicationArea = all; }
                field("Year of Production"; "Year of Production") { ApplicationArea = all; }
                field("DD calibration"; "DD calibration") { ApplicationArea = all; }
                field("N2%"; "N2%") { ApplicationArea = all; }
                field("CO2 %"; "CO2 %") { ApplicationArea = all; }
                field(Settings; Settings) { ApplicationArea = all; }
                field(Station; Station) { ApplicationArea = all; }
                field("Thick Air"; "Thick Air") { ApplicationArea = all; }
                field("Rel density"; "Rel density") { ApplicationArea = all; }
                field("Upper cal."; "Upper cal.") { ApplicationArea = all; }
                field(Weight; Weight) { }
                field("Number of decimals /Tr"; "Number of decimals /Tr") { }
                //field("Type of Connection"; "Type of Connection") { ApplicationArea = all; }
                field("Pulse transmitter LF/HE"; "Pulse transmitter LF/HE") { ApplicationArea = all; }
                field("Z formule"; "Z formule") { ApplicationArea = all; }
                field("Gauge Code"; "Gauge Code") { }
            }
            group(OwnerShip)
            {
                caption = 'OwnerShip';
                field("Ownership FA"; "Ownership FA") { ApplicationArea = all; }
                field("Ownership Customer No."; "Ownership Customer No.") { ApplicationArea = all; }
                field("Ownership Customer Name"; "Ownership Customer Name")
                {
                    ApplicationArea = all;
                }
            }



            group(Parameter)
            {
                Caption = 'Parameter';
                field("IMP. W"; "IMP. W") { ApplicationArea = all; }
                field("Pressure from (N2%)"; "Pressure from (N2%)") { ApplicationArea = all; }
                field("Pressure to (N2%)"; "Pressure to (N2%)") { ApplicationArea = all; }
                field("Base Pressure"; "Base Pressure") { ApplicationArea = all; }
                field("Base temperature"; "Base temperature") { ApplicationArea = all; }

            }
            part(InstallationHistory; "Installation History")

            {
                ApplicationArea = all;
                SubPageLink = Type = filter(Corrector), Code = field(Code);

                //SubPageLink = "Measuring Point Code" = field("Measuring Point"), Type = filter(Gauge), Code = field(Code);
            }



        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var

        myInt: Integer;
        us: Record "User Setup";
        SMS: Record "Service Mgt. Setup";
        ServMgtSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Cust: Record customer;
        MMPoint: Record "Service Item";
    begin
        ServMgtSetup.get;
        if Code = '' then begin
            ServMgtSetup.TestField("Corrector Code");
            NoSeriesMgt.InitSeries(ServMgtSetup."Corrector Code", xRec."No. Series", 0D, code, "No. Series");
        end;

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Cust.Reset();
            Cust.SetFilter("No.", '%1', us."Customer No.");
            if Cust.FindFirst() then
                Validate("Customer Category", cust."Customer Category");
            Validate("Address MM", us."Adress MM");
            Validate("Customer No.", us."Customer No.");




        end;



    end;


    var
        myInt: Integer;
}