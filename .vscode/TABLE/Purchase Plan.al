table 50112 "Purchase Plan"
{

    //ED 

    Caption = 'Purchase Plan';
    DrillDownPageID = "Purchase Plan";
    LookupPageID = "Purchase Plan";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            Editable = false;
            BlankZero = true;
        }
        field(2; "Purchase Type"; Enum "Purchase Type Enum")
        {
            Caption = 'Purchase Type';

            trigger OnValidate()
            begin
                PurchasePlan.Reset(); //dodjeljivanje broja stavki plana
                //postoje razlicite varijante za koje broj krene od 1
                //zavisi od toga da li je direktni sporazum ili ne, te da li je vrsta roba, radovi ili usluge
                PurchasePlan.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code");
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                if PurchasePlan.FindLast() then
                    Rec."No." := PurchasePlan."No." + 1
                else
                    Rec."No." := 1;
            end;
        }
        field(3; Name; Text[300])
        {
            Caption = 'Name';
        }
        field(4; "Komercijala - rebalans"; Decimal)
        {
            Caption = 'Komercijala - REBALANS';

            trigger OnValidate()
            begin
                Rec."Total - rebalans" := rec."Komercijala - rebalans" + Rec."Investiciono - rebalans" + Rec."Tekuće potrebe - rebalans";
            end;
        }
        field(5; "Investiciono - rebalans"; Decimal)
        {
            Caption = 'Investiciono održavanje i ulaganje u izgradnju novih stalnih sredstava i nabavka stalnih sredstava - REBALANS';

            trigger OnValidate()
            begin
                Rec."Total - rebalans" := rec."Komercijala - rebalans" + Rec."Investiciono - rebalans" + Rec."Tekuće potrebe - rebalans";
            end;
        }
        field(6; "Tekuće potrebe - rebalans"; Decimal)
        {
            Caption = 'Tekuće potrebe - REBALANS';

            trigger OnValidate()
            begin
                Rec."Total - rebalans" := rec."Komercijala - rebalans" + Rec."Investiciono - rebalans" + Rec."Tekuće potrebe - rebalans";
            end;
        }
        field(7; "Total - rebalans"; Decimal)
        {
            Caption = 'Ukupno - REBALANS';
            Editable = false;
        }
        field(9; "Komercijala - realizacija"; Decimal)
        {
            Caption = 'Komercijala - REALIZACIJA';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Purchase Plan Code" = field("Purchase Plan Code"),
                                                                "Plan No." = field("No."),
                                                                "Direktni sporazum" = field("Direktni sporazum"),
                                                                //"Purchase Type" = field("Purchase Type"),
                                                                "Cost Type" = CONST("Komercijalni trošak")));
        }
        field(10; "Investiciono - realizacija"; Decimal)
        {
            Caption = 'Investiciono održavanje i ulaganje u izgradnju novih stalnih sredstava i nabavka stalnih sredstava - REALIZACIJA';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Purchase Plan Code" = field("Purchase Plan Code"),
                                                                "Plan No." = field("No."),
                                                                "Direktni sporazum" = field("Direktni sporazum"),
                                                                "Purchase Type" = field("Purchase Type"),
                                                                "Cost Type" = CONST("Investicioni trošak")));
        }
        field(11; "Tekuće potrebe - realizacija"; Decimal)
        {
            Caption = 'Tekuće potrebe - REALIZACIJA';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Purchase Plan Code" = field("Purchase Plan Code"),
                                                                "Plan No." = field("No."),
                                                                "Direktni sporazum" = field("Direktni sporazum"),
                                                                "Purchase Type" = field("Purchase Type"),
                                                                "Cost Type" = CONST("Tekući trošak")));
        }
        field(12; "Total - realizacija"; Decimal)
        {
            Caption = 'Ukupno - REALIZACIJA';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = SUM("Purch. Inv. Line"."Amount Including VAT" WHERE("Purchase Plan Code" = field("Purchase Plan Code"),
                                                                "Plan No." = field("No."),
                                                                "Direktni sporazum" = field("Direktni sporazum")
            , "Purchase Type" = field("Purchase Type")));
        }
        field(13; "Remained"; Decimal)
        {
            Caption = 'Remained';
            Editable = false;
        }
        field(14; "Index"; Decimal)
        {
            Caption = 'Index';
            Editable = false;
        }
        field(15; "Purchase Plan Code"; Code[4])
        {
            Caption = 'Purchase Plan Code';
            Editable = false;
        }
        field(16; "Contracts Count"; Integer)
        {
            Caption = 'Ukupan broj ugovora'; //ukupan broj ugovora koji su kreirani za ovu stavku ovog Plana
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Contract" WHERE("Entry No. Plan" = field("No."),
                                                        "Purchase Type" = field("Purchase Type"),
                                                        "Direktni sporazum" = field("Direktni sporazum"),
                                                        "Purchase Plan Code" = field("Purchase Plan Code")));
        }

        field(17; "Direktni sporazum"; Enum "Procedure Type Enum")
        {
            Caption = 'Procedure Type';

            trigger OnValidate()
            begin
                PurchasePlan.Reset(); //dodjeljivanje broja stavki plana
                //postoje razlicite varijante za koje broj krene od 1
                //zavisi od toga da li je direktni sporazum ili ne, te da li je vrsta roba, radovi ili usluge
                PurchasePlan.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code");
                PurchasePlan.SetFilter("Direktni sporazum", '%1', Rec."Direktni sporazum");
                PurchasePlan.SetFilter("Purchase Type", '%1', Rec."Purchase Type");
                if PurchasePlan.FindLast() then
                    Rec."No." := PurchasePlan."No." + 1
                else
                    Rec."No." := 1;
            end;
        }
    }

    keys
    {
        key(Key1; "Purchase Plan Code", "No.", "Purchase Type", "Direktni sporazum")
        {
            Clustered = true;
        }
    }

    var
        VendorTable: Record Vendor;
        PurchasePlan: Record "Purchase Plan";
}

