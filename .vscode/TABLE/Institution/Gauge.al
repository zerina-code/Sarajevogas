table 50156 "Gauge"
{
    Caption = 'Gauge';
    DrillDownPageId = Gauges;
    LookupPageId = Gauges;
    // DrillDownPageID = "Activities MM";
    // LookupPageID = "Activities MM";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            trigger OnValidate()
            var
                myInt: Integer;
                GLS: Record "General Ledger Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
            begin
                if Code <> xRec.Code then begin
                    GLS.Get();
                    NoSeriesMgt.TestManual(GLS."Gauge Code");
                    "No. Series" := '';
                end;

            end;

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
                US: Record "User Setup";
            begin
                US.Reset();
                us.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    us."Customer No." := rec."Customer No.";
                    us."Measuring Code" := rec."Measuring Point";
                    us."Gauge Code" := rec.Code;
                    us.Modify();
                    Commit();
                end;

                if "Customer No." <> '' then begin
                    Cust.get("Customer No.");
                    "Gauge Category" := cust."Customer Category";
                    "Customer Category" := cust."Customer Category";
                    "Customer Name" := Cust.Name;
                    "Customer E-mail" := Cust."E-Mail";
                    "Tax Liable" := Cust."Tax Liable";
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
                US: record "User Setup";
            begin
                US.Reset();
                us.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin
                    us."Customer No." := rec."Customer No.";
                    us."Measuring Code" := rec."Measuring Point";
                    us."Gauge Code" := rec.Code;
                    us.Modify();
                    Commit();
                end;
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
        field(9; "Meter type"; Text[250])
        {
            Caption = 'Meter type';
            TableRelation = "Meter Type"."Gauge Size";


        }
        field(10; "Meter Manufacturer"; Text[250])
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

        field(11; "Year of Production"; Integer)
        {
            Caption = 'Year of Production"';

        }
        field(12; "Inventar number"; code[20])
        {
            Caption = 'Inventar Number';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if strlen("Inventar number") > 8 then
                    Error('Serijski broj ne može biti veći od 8!');

            end;
        }
        field(13; "Status Gauge"; Option)
        {
            Caption = 'Status Gauge';
            OptionMembers = ,Active,Replaced,Off;
            OptionCaption = ' Active, Replaced, Off';
        }

        field(14; "Qmax"; Decimal) { Caption = 'Qmax'; }
        field(15; "Qmin"; Decimal) { Caption = 'Qmin'; }
        field(16; "No"; Integer) { Caption = 'No'; }
        field(17; "Pmax"; Decimal) { Caption = 'Pmax (bar)'; }
        field(18; "Tmin"; Decimal) { Caption = 'Tmin'; }
        field(19; "Tmax"; Decimal) { Caption = 'Tmax'; }
        field(20; "Pul"; Decimal) { Caption = 'Pul'; }
        field(21; "Piz"; Decimal) { Caption = 'Piz'; }

        field(22; "Number of decimals /Tr"; Decimal) { Caption = 'Number of decimals /Tr'; }
        field(23; "Number of impulses (Imp/m3)"; Decimal) { Caption = 'Number of impulses (Imp/m3)'; }
        field(24; "Pulse transmitter LF/HE"; Decimal) { Caption = 'Pulse transmitter LF/HE'; }
        field(25; "Installation length"; Decimal) { Caption = 'Installation length'; }
        field(26; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(27; "Flow direction"; Enum "Gauge Flow Direction") { Caption = 'Flow Direction'; }
        field(28; "Weight"; Decimal) { Caption = 'Weight (kg)'; }
        field(29; "Model"; Text[250]) { Caption = 'Model'; }
        field(30; "Gauge Size"; Text[250])
        {
            Caption = 'Gauge size';
            TableRelation = "Types Of Diseases".Description where(Types = filter("Gauge size"));


        }
        field(31; "Type of Connection"; Option)
        {
            Caption = 'Type of connection';

            OptionMembers = "Unknown","Flanged","Threaded";
            OptionCaption = 'Unknown,Flanged,Threaded';

            //ĐK

        }
        field(32; "VU installation"; Option)
        {
            Caption = 'VU Installation';
            OptionMembers = "Unknown","Inside","Outside";

            OptionCaption = 'Unknown,Inside,Outside';
        }
        field(33; "HV Installation"; Option)
        {
            Caption = 'HV installation';
            OptionMembers = "Unknown","Vertical","Horizontal";

            OptionCaption = 'Unknown,Vertical,Horizontal';
        }
        field(34; "Tr"; Decimal)
        { Caption = 'Tr'; }
        field(35; "Customer E-mail"; Text[250])
        {
            Caption = 'Customer E-mail';
        }
        field(36; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';

        }
        field(37; "Calculation Valide"; Boolean)
        {
            Caption = 'Calculation Valide';

        }
        field(38; "Gauge Position"; Option)
        {
            Caption = 'Gauge Position';
            OptionMembers = "Unknown","Before Regulator","After Regulator","Without regulator";
            OptionCaption = 'Unknown,Before Regulator,After Regulator,Without regulator';

        }

        field(40; "Gauge Type"; Text[100])
        {
            Caption = 'Description';
            TableRelation = "Types of Diseases".Description where(types = filter("Gauge Type"));
        }
        field(41; "Gauge Category"; Enum Category)
        {
            Caption = 'Gauge Category';


        }
        field(42; "Station"; code[20])
        {
            Caption = 'Station';
            TableRelation = "Fixed Asset"."No.";

        }
        field(43; "Remotely Type"; enum "Remotely Type")
        {
            Caption = 'Remotely Type';

        }
        field(44; "Origin"; Option)
        {
            Caption = 'Origin';
            OptionMembers = "Unknown","Pre-war Singer","Pre-war 010392","46000","After 31052000","Aida and Senad","Approved 22062015";
            OptionCaption = 'Unknown,Pre-war Singer,Pre-war 010392,46000,After 31052000,Aida and Senad,Approved 22062015';


        }
        field(45; "Method of calculation"; enum "Method of calculation")
        {
            Caption = 'Method of calculation';



        }
        field(46; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(47; "Holes number"; Integer)
        {
            Caption = 'Holes number';
        }
        field(48; "Customer Status"; enum "Status Cust/MM")
        {
            Caption = 'Customer Status';
            FieldClass = FlowField;
            CalcFormula = lookup("Status History"."Information of processing" where(Active = filter(true), "Customer No." = field("Customer No."), "Source Table" = filter(18)));
        }

        field(50111; "Type of reading"; enum "Type of reading")
        {
            Caption = 'Type of reading';
        }
        field(50110; "Reading Time"; enum "Reading Time")
        {
            Caption = 'Reading Time';
        }
        field(50112; "Meter Manufacturer Desc"; Text[250])
        {
            Caption = 'Meter Manufacturer Desc';
            //  TableRelation = Manufacturer;
        }
        //destroyed

        field(50113; "Destroyed"; Boolean)
        {
            Caption = 'Destroyed';
            //  TableRelation = Manufacturer;
        }
        field(50078; "Radio Module"; Integer)
        {
            Caption = 'Radio Module';
            FieldClass = FlowField;
            CalcFormula = count("Installation History" where(Type = filter(Radio_Module), "Measuring Point Code" = field("Measuring Point"), Active = const(true)));
            // count("Installation History" where("Measuring Point Code" = field("No."), Active = const(true), Type = const(Radio_Module)));


        }
        field(50079; "Gas Station Placement"; Enum "Gas Station Placement")
        {
            DataClassification = CustomerContent;
            Caption = 'Gas Station Placement';
        }












    }


    keys
    {
        key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")
        {
        }
        key(Key2; Description, "Inventar number")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Code", "Inventar number", "Measuring Point", "Customer No.", "Address MM")
        {
        }
    }

    trigger OnRename()
    var
        myInt: Integer;
    begin
        if (xRec.Code <> Rec.Code) and (xrec.Code <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');

    end;




    trigger OnModify()
    var
        myInt: Integer;
        CompanyInf: Record "User Setup";
        CS: Record "Calculation Setup";
        CU: Codeunit "Update Data Billing";
    begin


        if (xRec.Code <> Rec.Code) and (xrec.Code <> '') then
            Error('Nije moguće mijenjati već dodijeljenu šifru!');

        cs.Get();
        if cs."Update Data" = true then begin
            cu.UpdateGaugeData(rec);
        end;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin

        if UserId <> 'SARAJEVOGAS\TENEO' then
            Error('Karticu mjerača nije moguće obrisati!');

    end;

    trigger OnInsert()
    var
        myInt: Integer;
        us: Record "User Setup";
        SMS: Record "General Ledger Setup";
        ServMgtSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Cust: Record customer;
        MMPoint: Record "Service Item";
    begin


        //   if Code = '' then begin
        ServMgtSetup.get;
        ServMgtSetup.TestField("Gauge Code");
        NoSeriesMgt.InitSeries(ServMgtSetup."Gauge Code", xRec."No. Series", 0D, code, "No. Series");
        // end;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Cust.Reset();
            Cust.SetFilter("No.", '%1', us."Customer No.");
            if Cust.FindFirst() then
                Validate("Customer Category", cust."Customer Category");
            Validate("Address MM", us."Adress MM");
            Validate("Customer No.", us."Customer No.");

            MMPoint.Reset();
            MMPoint.SetFilter("No.", '%1', us."Measuring Code");
            if MMPoint.FindFirst() then
                Validate("Gauge Category", MMPoint."MM Category");


        end;


    end;

    procedure AssistEdit(OldServItem: Record Gauge): Boolean
    var

        ServItem: Record Gauge;
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

