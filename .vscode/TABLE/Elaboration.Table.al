table 50116 Elaboration
{
    Caption = 'Elaboration';
    DrillDownPageId = "Elaboration Lines";
    LookupPageId = "Elaboration Lines";
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
        field(4; "Elaboration Registry Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Registry Code';
        }
        field(5; "Recording Method"; Enum "Recording Method")
        {
            DataClassification = CustomerContent;
            Caption = 'Recording Method';
        }
        field(6; "Creation Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Creation Date';
        }
        field(7; "ZIK Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'ZIK Date';
        }
        field(8; "GIS Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'GIS Date';
        }
        field(9; "Caption"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Caption';
        }
        field(10; "Detail List"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Detail List';
        }
        field(11; "Registration No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Registration No.';
        }
        field(12; "Comment"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Comment';
        }
        field(13; "Elaboration Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elaboration Code';
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
        field(106; "Street No."; Code[20])
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

        field(60072; "Connection"; Code[20])
        {
            Caption = 'Connection';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Service Header"."CZK Request No." WHERE("No." = field("Document No."), "Document Type" = field("Document Type")));
        }
        field(60073; "Executor"; Text[250])
        {
            Caption = 'Executor';

            FieldClass = FlowField;
            CalcFormula = Lookup("Service Header"."Real. Process. Empl. Name" WHERE("No." = field("Document No."), "Document Type" = field("Document Type")));
        }


        field(60074; "List of drafts"; Text[1000])
        {
            Caption = 'List of drafts';
            Editable = true;
            //  TableRelation = Sketch."Sketch Code" where("Document No." = field("Document No."));


        }


    }
    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.", "Elaboration Code")
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
        SH: Record "Service Header";
        DocNoInt: Integer;
        SK: Record Sketch;
        NewNoE: Code[20];
        LastElabCode: Code[20];
        FirstPart: Code[20];
        FirstPartInt: Integer;
        Godina: Code[2];

    begin
        //EK zakomentarisala
        /*  IF "Elaboration Code" = '' THEN BEGIN


              MgmS.GET;
              MgmS.TESTFIELD("GEO Workplaces No. Series");
              NoSeriesMgt.InitSeries(MgmS."GEO Workplaces No. Series", xRec."No. Series", 0D, "Elaboration Code", "No. Series");


              if "Open Date" = 0D then
                   "Open Date" := today;
               El.Reset();
               El.SetFilter("Document No.", '%1', rec."Document No.");
               El.SetFilter("Document Type", '%1', rec."Document Type");
               if el.FindFirst() then
                   Broj := el.Count
               else
                   Broj := 1;
               "Elaboration Code" := "Elaboration Code" + '/' + format(copystr(format(Date2DMY("Open Date", 3)), 3, 2)) + '-' + format(Broj);
          END;*/

        IF "Elaboration Code" = '' THEN BEGIN
            MgmS.GET;
            MgmS.TESTFIELD("GEO Workplaces No. Series");

            // Generisanje novog osnovnog broja elaborata
            NoSeriesMgt.InitSeries(MgmS."GEO Workplaces No. Series", xRec."No. Series", 0D, NewNoE, "No. Series");

            IF "Open Date" = 0D THEN
                "Open Date" := TODAY;

            // Filtriramo zapise po "Open Date" kako bismo našli posljednji unesen elaborat za taj datum
            El.Reset();
            El.SetFilter("Document No.", '%1', SH."No.");
            El.SetFilter("Open Date", '%1', "Open Date");
            IF El.FindLast() THEN BEGIN
                LastElabCode := El."Elaboration Code"; // Dohvati zadnji elaborat za taj datum
                FirstPart := COPYSTR(LastElabCode, 1, STRPOS(LastElabCode, '/') - 1); // Izvlači RAD-0000014
                IF EVALUATE(FirstPartInt, FirstPart) THEN
                    FirstPartInt := FirstPartInt + 1 // Povećaj broj
                ELSE
                    FirstPartInt := 1; // Ako ne uspije parsiranje, kreći od 1

                FirstPart := FORMAT(FirstPartInt); // Konvertuj broj nazad u string
            END ELSE
                FirstPart := NewNoE; // Ako nema prethodnog, koristi novi broj iz serije
            // Brojimo koliko elaborata već postoji na taj datum
            El.Reset();
            El.SetFilter("Document No.", '%1', SH."No.");
            El.SetFilter("Open Date", '%1', "Open Date");
            IF El.FindFirst() THEN
                Broj := El.Count
            ELSE
                Broj := 1;

            // Ispravka formata da uzme samo godinu (dvije cifre)
            Godina := FORMAT(Date2DMY("Open Date", 3) MOD 100);

            // Kreiranje novog Elaboration Code sa istim mjesecom i brojem iteracije
            "Elaboration Code" := FirstPart + '/' + Godina + '-' + FORMAT(Broj);
        END;



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

        if rec."Document No." <> '' then begin
            SH.reset();
            if Evaluate(DocNoInt, rec."Document No.") then
                SH.SetFilter("Document No.", '%1', DocNoInt);
            SH.SetFilter("Document Type", '%1', rec."Document Type");
            if SH.FindFirst() then begin

                rec.Executor := sh."Real. Process. Empl. Name";
            end;
        end;

        if rec."Document No." <> '' then begin
            SH.Reset();


            if Evaluate(DocNoInt, rec."Document No.") then begin
                SH.SetFilter("Document No.", '%1', DocNoInt);
                SH.SetFilter("Document Type", '%1', rec."Document Type");

                if SH.FindFirst() then begin

                    rec.Executor := SH."Real. Process. Empl. Name";
                    rec.Connection := SH."CZK Request No.";

                end;
            end;



        end;

        /*   if "List of drafts" <> '' then begin
               SK.Reset();
               SK.setfilter("Document No.", '%1', "Document No.");
               if SK.FindFirst() then begin
                   rec."List of drafts" := SK."Sketch Code";
               end;




           end*/


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



    var


}