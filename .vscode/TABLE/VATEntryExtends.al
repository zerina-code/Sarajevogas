tableextension 50075 VATEntryExtends extends "VAT Entry"
{
    fields
    {
        //    VAT Base (retro.)
        field(50003; "VAT Base (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //VAT Amount (retro.)
        field(50002; "VAT Amount (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50006; Import; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50000; "VAT Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Postponed VAT"; boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50004; "Unrealized Amount (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Unrealized Base (retro.)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(50008; "Vendor Entity Code"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(50010; "Full VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("VAT Entry"."VAT Amount (retro.)" where("Document No." = field("Document No."), Import = filter(true)));

        }

        field(50009; "Total Entry No."; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("VAT Entry" where("Document No." = field("Document No."), Import = filter(false)));
        }

        field(50007; "Customer Entity Code"; Code[2048])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Customer"."Entity Code" where("No." = field("Bill-to/Pay-to No.")));


        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";

        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }

        field(50051; "KUF_Entry"; Code[20])

        {
            Caption = 'KUF Entry';
        }
        field(50052; "KIF_Entry"; Code[20])

        {
            Caption = 'KIF Entry';
        }
        field(50053; "KUF_Type"; Option)
        {
            Caption = 'KUF Type';
            OptionCaption = 'DOMAĆI,INO,AVANSI';
            OptionMembers = "DOMAĆI",INO,AVANSI;
        }

        field(50054; Prepayment; Boolean)
        {
            Caption = 'Prepayment';


        }

        field(50055; "VAT Difference CNG"; Decimal)
        {
            Caption = 'VAT Difference CNG';
            DecimalPlaces = 1 : 10;


        }



    }

    var
        myInt: Integer;
}