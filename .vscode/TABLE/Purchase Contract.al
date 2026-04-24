table 50051 "Purchase Contract"
{

    //ED

    Caption = 'Purchase Contract';
    DrillDownPageID = "Purchase Contract";
    LookupPageID = "Purchase Contract";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(7; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                VendorTable.Reset();
                VendorTable.SetFilter("No.", '%1', Rec."Vendor No.");
                if VendorTable.FindFirst() then begin
                    Rec."Vendor Name" := VendorTable.Name;
                end;
            end;
        }
        field(8; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            Editable = false;
        }
        field(9; "Contract Start Date"; Date)
        {
            Caption = 'Contract Start Date';
        }
        field(11; "Purchase Type"; Enum "Purchase Type Enum")
        {
            Caption = 'Purchase Type';


        }
        field(12; "Entry No. Plan"; Integer)
        {
            Caption = 'Entry No. Plan';
            TableRelation = "Purchase Plan"."No." where("Purchase Plan Code" = field("Purchase Plan Code"),
                                                    "Purchase Type" = field("Purchase Type"),
                                                    "Direktni sporazum" = field("Direktni sporazum"));

            trigger OnValidate()
            begin
                PurchasePlan.Reset();
                //prvo filtriram po vrsti postupka
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                //zatim filtiram plan prema robi, radovima ili uslugama da bih prikazala samo te stavke plana, ne čitav plan
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                PurchasePlan.SetFilter("No.", '%1', Rec."Entry No. Plan");
                if PurchasePlan.FindFirst() then begin
                    Validate("Entry Name Plan", PurchasePlan.Name);
                    //Rec."Entry Name Plan" := PurchasePlan.Name;
                    Validate("Purchase Item", PurchasePlan.Name); //predmet nabavke preuzima naziv stavke plana jer većinom imaju isti naziv
                end
            end;
        }
        field(13; "Entry Name Plan"; Text[300])
        {
            Caption = 'Entry Name Plan';
            Editable = false;
        }
        field(14; "Contract Amount"; Decimal)
        {
            Caption = 'Contract Amount';
            AutoFormatType = 1;
            CalcFormula = Sum("Contract Scope".Total where("Contract Entry No." = field("Contract Entry No.")));
            Editable = false;
            FieldClass = FlowField;

        }
        field(15; "Direktni sporazum"; enum "Procedure Type Enum")
        {
            Caption = 'Vrsta postupka';
        }
        field(16; "Purchase Item"; Text[200])
        {
            Caption = 'Purchase Item';
        }
        field(17; "Realized"; Decimal)
        {
            Caption = 'Realized';
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Contract Entry No." = field("Contract Entry No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))));
        }
        field(18; "Tekući trošak"; Decimal)
        {
            Caption = 'Tekući trošak - REALIZOVANO';
            FieldClass = FlowField;

            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Cost Type" = CONST("Tekući trošak"),
                                                            "Contract Entry No." = field("Contract Entry No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))));

            trigger OnValidate()
            begin
                Rec.Realized := Rec."Tekući trošak" + Rec."Komercijalni trošak" + Rec."Investicioni trošak";

                PurchasePlan.Reset();
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                PurchasePlan.SetFilter("No.", '%1', Rec."Entry No. Plan");
                if PurchasePlan.FindFirst() then begin
                    PurchasePlan.Validate("Tekuće potrebe - realizacija", PurchasePlan."Tekuće potrebe - realizacija" + Rec."Tekući trošak");
                    PurchasePlan.Modify();
                end;
            end;
        }
        field(19; "Komercijalni trošak"; Decimal)
        {
            Caption = 'Komercijalni trošak - REALIZOVANO';
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Cost Type" = CONST("Komercijalni trošak"),
                                                            "Contract Entry No." = field("Contract Entry No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))));

            trigger OnValidate()
            begin
                Rec.Realized := Rec."Tekući trošak" + Rec."Komercijalni trošak" + Rec."Investicioni trošak";

                PurchasePlan.Reset();
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                PurchasePlan.SetFilter("No.", '%1', Rec."Entry No. Plan");
                if PurchasePlan.FindFirst() then begin
                    PurchasePlan.Validate("Komercijala - realizacija", PurchasePlan."Komercijala - realizacija" + Rec."Komercijalni trošak");
                    PurchasePlan.Modify();
                end;
            end;
        }
        field(20; "Investicioni trošak"; Decimal)
        {
            Caption = 'Investicioni trošak - REALIZOVANO';
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Cost Type" = CONST("Investicioni trošak"),
                                                            "Contract Entry No." = field("Contract Entry No."), "Posting Date" = FIELD(UPPERLIMIT("Date Filter"))));

            trigger OnValidate()
            begin
                Rec.Realized := Rec."Tekući trošak" + Rec."Komercijalni trošak" + Rec."Investicioni trošak";

                PurchasePlan.Reset();
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                PurchasePlan.SetFilter("No.", '%1', Rec."Entry No. Plan");
                if PurchasePlan.FindFirst() then begin
                    PurchasePlan.Validate("Investiciono - realizacija", PurchasePlan."Investiciono - realizacija" + Rec."Investicioni trošak");
                    PurchasePlan.Modify();
                end;
            end;
        }
        field(21; "Fixed Price"; Boolean)
        {
            Caption = 'Fixed Price';
        }
        field(10; "Contract Scope"; Integer)
        {
            Caption = 'Contract Scope';
            //TableRelation = "Contract Scope";
            FieldClass = FlowField;
            CalcFormula = count("Contract Scope" where("Contract Entry No." = field("Contract Entry No.")));
        }
        field(22; "Purchase Plan Code"; Code[10])
        {
            Caption = 'Purchase Plan Code';
            TableRelation = "Purchase Plans List";
        }
        field(23; "Contract Final Date"; Date)
        {
            Caption = 'Contract Final Date';

            trigger OnValidate()
            begin
                //R
                IF "Contract Final Date" <> 0D THEN BEGIN
                    IF "Contract Start Date" = 0D THEN
                        ERROR(Text001);

                    IF "Contract Start Date" > "Contract Final Date" then
                        ERROR(Text003);

                END;

                IF "Contract Final Date" = 0D THEN
                    "Contract Final Date" := WORKDATE;
            END;
        }
        /*field(24; "Exemption"; Boolean)
        {
            Caption = 'Exemption';
        }*/
        field(25; "Registration Number"; Code[50])
        {
            Caption = 'Registration Number';
        }
        field(26; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
            Editable = false;
        }
        field(27; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(28; Order; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Contract Entry No.", "Purchase Item")
        {
            Clustered = true;
        }
    }

    var
        VendorTable: Record Vendor;
        PurchasePlan: Record "Purchase Plan";
        PurchaseContract: Record "Purchase Contract";
        PomocniInt: Integer;
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';

    trigger OnInsert()
    begin
        PurchaseContract.Reset();
        PurchaseContract.SetCurrentKey(Order);
        PurchaseContract.Ascending;
        /*PurchaseContract.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
        PurchaseContract.SetFilter(Exemption, '%1', Rec.Exemption);*/
        //PurchaseContract.SetFilter("Purchase Type", '%1', Rec."Purchase Type"); 
        //ne može za svaku vrstu nabavke (roba, radovi, usluge) da krene redni broj ugovora od 1 jer je ključ u tabeli opseg ugovora samo redni broj ugovora
        if PurchaseContract.FindLast() then begin
            if PurchaseContract."Contract Entry No." <> '' then begin
                Evaluate(PomocniInt, PurchaseContract."Contract Entry No."); //iz code u integer da mogu povecati za 1
                PomocniInt += 1;
                Rec."Contract Entry No." := FORMAT(PomocniInt);
            end else
                Rec."Contract Entry No." := format(1);
        end
        else
            Rec."Contract Entry No." := format(1);
        //R
        Evaluate(Order, "Contract Entry No.");
        Commit();

    end;
}

