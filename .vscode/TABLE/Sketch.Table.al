table 50137 Sketch
{
    Caption = 'Sketch';
    DrillDownPageId = "Sketch Lines";
    LookupPageId = "Sketch Lines";
    fields
    {
        field(1; "Document Type"; Enum "Service Document Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Service Document Type';
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            TableRelation = "Service Header"."No." where("Document Type" = field("Document Type"));
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
        field(4; "Sketch Registry Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Registry Code';
        }
        field(5; "Elaboration Line No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elaboration Line No.';
            TableRelation = Elaboration."Elaboration Code" where("Document Type" = field("Document Type"), "Document No." = field("Document FIlters"));
        }

        //
        field(80; "Document FIlters"; text[250])
        {
            FieldClass = FlowFilter;
        }
        field(6; "Caption"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption';
        }
        field(7; "Detail List"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Detail List';
        }
        field(8; "Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(9; "Sketch Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sketch Code';
        }
        field(10; "Registration No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Registration No.';
        }
        field(11; "Measure"; option)
        {
            DataClassification = CustomerContent;
            Caption = 'Measure';
            OptionMembers = "1:500","1:1000","1:2500","1:5000";
            OptionCaption = '1:500,1:1000,1:2500,1:5000';
        }
        field(12; "Comment"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending_processing,Supplement_required,In_the_elaboration,Direct_execution;
        }
        field(100; "Municipality Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(101; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), Type = filter(Regular)));
            Editable = false;
        }
        field(102; "MZ"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Local Community';
            TableRelation = MZ.Code;
        }
        field(103; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ")));
            Editable = false;
        }
        field(104; "Street"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }
        field(105; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
            Editable = false;
        }
        field(106; "Street No."; Code[5])
        {
            DataClassification = CustomerContent;
            Caption = 'Street No.';
            trigger OnValidate()
            begin
                OnValidateStreet();
            end;
        }
        field(107; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(108; "No. Series"; Code[20])
        {
            Caption = 'No Series';
        }
        field(109; "Open Date"; Date)
        {
            Caption = 'Open Date';
        }
        field(60070; "Request File"; Blob)
        {
            Caption = 'Request File', Comment = 'Datoteka zahtjeva';
            DataClassification = CustomerContent;
        }
        field(60071; "Request File Name"; Text[100])
        {
            Caption = 'Request File Name', Comment = 'Naziv priložene datoteke';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.", "Sketch Code")
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    var
        myInt: Integer;
        MgmS: record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        El: Record Elaboration;
        Broj: Integer;
        SL: Record "Service Item Line";
        NewNo: code[20];
        NoSeries: Record "No. Series";

    begin

        IF "Sketch Code" = '' THEN BEGIN


            MgmS.GET;
            MgmS.TESTFIELD("GEO Workplaces No. Series");
            NoSeriesMgt.InitSeries(MgmS."GEO Workplaces No. Series", xRec."No. Series", 0D, "Sketch Code", "No. Series");

            if "Open Date" = 0D then
                "Open Date" := today;
            El.Reset();
            El.SetFilter("Document No.", '%1', rec."Document No.");
            El.SetFilter("Document Type", '%1', rec."Document Type");
            if el.FindFirst() then
                Broj := el.Count
            else
                Broj := 1;
            "Sketch Code" := "Sketch Code" + '/' + format(copystr(format(Date2DMY("Open Date", 3)), 3, 2)) + '-' + format(Broj);
        END;


        if "Sketch Registry Code" = '' then begin
            "Sketch Registry Code" := Format(Date2DMY(Today, 3)); // Uzima trenutnu godinu
        end;



        begin
            if "Registration No." = '' then begin
                MgmS.GET;
                MgmS.TESTFIELD("Geo Registrator No. Series");
                NoSeriesMgt.InitSeries(MgmS."Geo Registrator No. Series", xRec."No. Series", 0D, NewNo, "No. Series");

                "Registration No." := NewNo;
            end;
        end;









        if rec."Document No." <> '' then begin
            SL.Reset();
            SL.SetFilter("Document No.", '%1', rec."Document No.");
            SL.SetFilter("Document Type", '%1', rec."Document Type");
            if sl.FindFirst() then begin
                rec.Address := sl.Address;
                rec."Municipality Code" := sl."Municipality Code";
                rec."Municipality Name" := sl."Municipality Name";
                rec.Street := sl.Street;
                rec."Street Name" := sl."Street Name";
                rec."Street No." := sl."Street No.";
                rec.MZ := sl.MZ;
                rec."MZ Name" := sl."MZ Name";

            end;

        end;



    end;


    local procedure OnValidateStreet()
    var
        Stroke: Record Stroke;
    begin
        Stroke.ValidateStreetNo("Street No.", Street, "Municipality Code", MZ);
        Validate("Municipality Code");
        Validate(MZ);
        CalcFields("Street Name", "Municipality Name", "MZ Name");
        Address := StrSubstNo('%1 %2', "Street Name", "Street No.");
    end;

}
