table 50157 "El. Volume Corr"
{
    Caption = 'El. Volume Corr';
    DrillDownPageId = "EL. Volume Corr.";
    LookupPageId = "EL. Volume Corr.";
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Customer No."; code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
                MM: Record "Service Item";
            begin
                if "Customer No." <> '' then begin
                    Cust.get("Customer No.");
                    "Customer Name" := Cust.Name;

                end;
                if Rec."Measuring Point" <> '' then begin
                    MM.Get("Measuring Point");
                    "Address MM" := MM."Address MM";


                end;

            end;
        }
        field(4; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
            Editable = false;
        }
        field(5; "Measuring Point"; code[20])
        {
            Caption = 'Measuring Point';
            TableRelation = "Service Item"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                MM: Record "Service Item";
            begin
                mm.Reset();
                mm.SetFilter("No.", '%1', Rec."Measuring Point");
                if mm.FindFirst() then begin
                    Validate("Customer No.", mm."Customer No.");
                    mm."Address MM" := mm.Address;
                end


            end;
        }
        field(6; "Customer Category"; Enum Category)
        {
            Caption = 'Customer Category';

        }
        field(7; "Customer Type"; Option)
        {
            Caption = 'Customer Type';
            OptionMembers = ,Active,Potential;
            OptionCaption = ' ,Active,Potential';
        }
        field(8; "Address MM"; text[250])
        {
            Caption = 'Address MM';
        }


        field(11; "Year of Production"; Integer) { Caption = 'Year of Production"'; }
        field(12; "Inventar number"; code[20]) { Caption = 'Inventar Number'; }
        field(13; "Serial Number"; text[250]) { Caption = 'Serial Number'; }

        field(22; "Number of decimals /Tr"; Decimal) { Caption = 'Number of decimals /Tr'; }
        field(23; "Number of impulses (Imp/m3)"; Decimal) { Caption = 'Number of impulses (Imp/m3)'; }
        field(24; "Pulse transmitter LF/HE"; Option)
        {

            Caption = 'Pulse transmitter LF/HE';
            OptionMembers = "NN","NF","HF";
            OptionCaption = 'NN,NF,HF';
        }
        field(25; "Installation length"; Decimal) { Caption = 'Installation length'; }
        field(26; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(27; "Pressure from (N2%)"; Decimal)
        {
            DecimalPlaces = 1 : 4;
            Caption = 'Pressure from (N2%)';
        }
        field(28; "Pressure to (N2%)"; Decimal) { Caption = 'Pressure to (N2%)'; }
        field(29; "Base Pressure"; Decimal) { DecimalPlaces = 1 : 6; Caption = 'Base Pressure'; }
        field(30; "Base temperature"; Decimal) { DecimalPlaces = 1 : 4; Caption = 'Base temperature'; }
        field(31; "IMP. W"; Decimal) { Caption = 'IMP. W'; }
        field(32; "N2%"; Decimal) { DecimalPlaces = 1 : 4; Caption = 'N2 %'; }
        field(33; "CO2 %"; Decimal) { DecimalPlaces = 1 : 4; Caption = 'CO2 %'; }
        field(34; Settings; Date) { Caption = 'Settings'; }
        field(35; Model; text[250]) { Caption = 'Model'; }

        field(36; "Thick Air"; Decimal) { DecimalPlaces = 1 : 4; Caption = 'Thick Air'; }
        field(37; "Rel density"; Decimal) { DecimalPlaces = 1 : 4; Caption = 'Rel density'; }
        field(38; "Upper cal."; Decimal) { DecimalPlaces = 1 : 4; caption = 'Upper cal.'; }
        field(39; "Impulse transmitter"; Text[250]) { Caption = 'Impulse transmitter'; }
        field(40; "Z formule"; Option)
        {
            Caption = 'Z formule';
            OptionMembers = "Unknown","AGA NX19 (CO2 Hs ..)","SGERG (CO2 N2 d)";
            OptionCaption = 'Unknown,AGA NX19 (CO2 Hs ..),SGERG (CO2 N2 d)';

        }
        field(42; "The origin of the meter"; Integer)
        {
            Caption = 'The origin of the meter';
        }
        field(43; "Meter Manufacturer"; Text[250])
        {
            Caption = 'Meter Manufacturer';
            TableRelation = Manufacturer;
            trigger OnValidate()
            var
                myInt: Integer;
                Manufacturer: Record Manufacturer;
            begin
                Manufacturer.reset;
                Manufacturer.setfilteR("Code", '%1', "Meter Manufacturer");
                if Manufacturer.findfirst then
                    "Meter Manufacturer Desc" := Manufacturer.name
                else
                    "Meter Manufacturer Desc" := '';
            end;
        }

        /*  field(44; "Type of Connection"; Option)
          {
              Caption = 'Type of connection';

              OptionMembers = "Unknown","Flanged","Threaded";
              OptionCaption = 'Unknown,Flanged,Threaded';

              //ĐK

          }
  */

        field(48; "Station"; Integer)
        {
            Caption = 'Station';

        }
        field(49; "Ownership FA"; Code[20])
        {
            Caption = 'Ownership FA';
            TableRelation = "Fixed Asset"."No.";
            //osnovno sredstvo koje je povezano sa kupcem

        }
        field(50; "Ownership Customer No."; Code[20])
        {
            Caption = 'Ownership Customer No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Fixed Asset"."Customer No." where("No." = field("Ownership FA")));
            //osnovno sredstvo koje je povezano sa kupcem

        }
        field(51; "Ownership Customer Name"; Text[250])
        {
            Caption = 'Ownership Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Ownership Customer No.")));
            //osnovno sredstvo koje je povezano sa kupcem

        }
        field(52; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }


        field(50127; "Meter Manufacturer Desc"; Text[250])
        {
            Caption = 'Meter Manufacturer Desc';
            //  TableRelation = Manufacturer;
        }
        field(50128; "Weight"; Decimal)
        {
            Caption = 'Weight (kg)';
            DecimalPlaces = 1 : 4;
        }
        field(50129; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';
            TableRelation = IF ("Measuring Point" = CONST('')) Gauge.Code where("Customer No." = filter(''), "Measuring Point" = filter(''))
            ELSE
            IF ("Measuring Point" = FILTER(<> '')) Gauge.code WHERE("Measuring Point" = field("Measuring Point"));

        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }





    }



    keys
    {
        key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnDelete()
    var


    begin
        if UserId <> 'SARAJEVOGAS\TENEO' then
            Error('Karticu korektora nije moguće obrisati!');
    end;



    trigger OnInsert()
    var
        myInt: Integer;
        us: Record "User Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        SMS: Record "Service Mgt. Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Validate("Address MM", us."Adress MM");
            Validate("Customer No.", us."Customer No.");
            us."Corrector Code" := rec.Code;
            us.Modify();

        end;
        IF Rec.Code = '' THEN BEGIN
            SMS.GET;
            SMS.TESTFIELD("Gauge Code");
            NoSeriesMgt.InitSeries(SMS."Corrector Code", xRec."No. Series", 0D, Code, "No. Series");
        END;


    end;

    trigger OnModify()
    var
        myInt: Integer;
        us: Record "User Setup";
        CS: Record "Calculation Setup";
        CU: Codeunit "Update Data Billing";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            us."Corrector Code" := rec.Code;
            us.Modify();

        end;

        cs.Get();
        if cs."Update Data" = true then begin
            cu.UpdateCorrectorData(rec);
        end;


    end;

    procedure AssistEdit(OldServItem: Record "El. Volume Corr"): Boolean
    var

        ServItem: Record "El. Volume Corr";
        ServMgtSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin
        with ServItem do begin
            ServItem := Rec;
            ServMgtSetup.Get();
            ServMgtSetup.TestField("Gauge Code");
            if NoSeriesMgt.SelectSeries(ServMgtSetup."Gauge Code", OldServItem."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries(Code);
                Rec := ServItem;
                exit(true);
            end;
        end;
    end;

}

