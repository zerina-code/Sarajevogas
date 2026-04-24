table 50073 "Radio Module"
{
    Caption = 'Radio Module';
    DrillDownPageId = "Radio Module";
    LookupPageId = "Radio Module";


    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            var
                myInt: Integer;
                GLS: Record "General Ledger Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
            begin
                if Code <> xRec.Code then begin
                    GLS.Get();
                    NoSeriesMgt.TestManual(GLS."Radio Module Code");
                    "No. Series" := '';
                end;

            end;

        }
        field(2; "Type Radio Module"; enum "Type radio module")
        {
            Caption = 'Type Radio Module';
        }

        field(11; "Year of Production"; Integer) { Caption = 'Year of Production"'; }
        field(3; "Serial Number I"; Code[30]) { Caption = 'Serial Number I'; }
        field(4; "Serial Number II"; code[30]) { Caption = 'Serial Number II'; }
        field(5; "Meter Manufacturer"; Text[250])
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
        field(50112; "Meter Manufacturer Desc"; Text[250])
        {
            Caption = 'Meter Manufacturer Desc';
            //  TableRelation = Manufacturer;
        }
        field(6; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';
            TableRelation = IF ("Measuring Point Code" = CONST('')) Gauge.Code where("Radio Module" = filter(<> 1))
            ELSE
            IF ("Measuring Point Code" = FILTER(<> '')) Gauge.code WHERE("Measuring Point" = field("Measuring Point Code"));
            trigger OnValidate()
            var
                myInt: Integer;
                G: Record gauge;
            begin
                G.Reset();
                G.SetFilter(Code, '%1', Rec."Gauge Code");
                if G.FindFirst() then
                    "Gauge Description" := G.Description
                else
                    "Gauge Description" := '';
            end;
        }
        field(7; "Gauge Description"; Text[250])
        {
            Caption = 'Gauge Description';
        }
        field(8; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(9; "Measuring Point Code"; Code[20])
        {
            Caption = 'Measuring Point Code';
        }

    }



    keys
    {
        key(Key1; Code, "Gauge Code", "Measuring Point Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        SMS: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;



    trigger OnInsert()
    var
        ServMgtSetup: Record "General Ledger Setup";
        us: Record "User Setup";
        GaugeF: Record Gauge;
        GaugeR: Record Gauge;
    begin

        /*   IF Rec.Code = '' THEN BEGIN
               SMS.GET;
               SMS.TESTFIELD("Gauge Code");
               NoSeriesMgt.InitSeries(SMS."Gauge Code", xRec."No. Series", 0D, Code, "No. Series");
           END;*/

        if Code = '' then begin
            ServMgtSetup.get;
            ServMgtSetup.TestField("Gauge Code");
            NoSeriesMgt.InitSeries(ServMgtSetup."Radio Module Code", xRec."No. Series", 0D, code, "No. Series");
        end;




        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            //key(Key1; "Code", "Measuring Point", "Customer No.", "Address MM")

            GaugeF.Reset();
            GaugeF.SetFilter(Code, '%1', rec."Gauge Code");
            //   GaugeF.SetFilter();

            if GaugeF.FindFirst() then begin

                //  if GaugeR.Get(GaugeF.Code, GaugeF."Measuring Point", GaugeF."Customer No.", GaugeF."Address MM") then begin
                //  GaugeR.Rename(GaugeF.Code, GaugeF."Measuring Point", GaugeF."Customer No.", GaugeF."Address MM");
                // GaugeF.validate("Measuring Point Code", us."Measuring Code");
                // rec.validate("Gauge Code", us."RMS Code");
                // end;
            end;
            //   rec.Modify();
            //   key(Key1; Code, "Gauge Code", "Measuring Point Code")

        end;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."Gauge Code" <> '' then begin
                rec."Gauge Code" := us."Gauge Code";
            end;
        end;

    end;

    trigger OnModify()
    var
        myInt: Integer;
        us: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            us."Radio Module Code" := rec.Code;
            us.Modify();

        end;
    end;

    trigger OnDelete()
    begin
        if UserId <> 'SARAJEVOGAS\TENEO' then
            Error('Karticu radio modula nije moguće obrisati!');
    end;

    trigger OnRename()
    begin

    end;


    procedure AssistEdit(OldServItem: Record "Radio Module"): Boolean
    var

        ServItem: Record "Radio Module";
        ServMgtSetup: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin
        with ServItem do begin
            ServItem := Rec;
            ServMgtSetup.Get();
            ServMgtSetup.TestField("Gauge Code");
            if NoSeriesMgt.SelectSeries(ServMgtSetup."Radio Module Code", OldServItem."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries(Code);
                Rec := ServItem;
                exit(true);
            end;
        end;
    end;


}