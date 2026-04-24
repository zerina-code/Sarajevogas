tableextension 50036 GLEntryExtends extends "G/L Entry"
{
    fields
    {
        //    VAT Base (retro.)

        field(50000; "Contact link"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact."No.";
        }
        //VAT Amount (retro.)

        field(50001; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50002; "Vendor Order No."; Code[35])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Purch. Inv. Header"."Vendor Order No." where("No." = field("Document No.")));
        }
        field(50003; "Payment Type Code"; Code[10])
        {
            Caption = 'Vrsta uplate';
            NotBlank = true;
        }
        field(50004; "Payment Method"; Text[20])
        {
            Caption = 'Payment Method';
            NotBlank = true;
        }
        field(50005; "Cashier Code"; Code[10])
        {
            Caption = 'Cashier Code';
            NotBlank = true;
        }

        field(50006; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference';
            NotBlank = true;
        }

        field(50007; "New Order"; Integer)
        {
            Caption = 'Payment Reference';

        }
        field(50051; "KUF_Entry"; code[20])

        {
            Caption = 'KUF Entry';
        }
        field(50052; "KIF_Entry"; code[20])

        {
            Caption = 'KIF Entry';
        }
        field(50053; "KUF_Type"; Option)
        {
            Caption = 'KUF Type';
            OptionCaption = 'DOMAĆI,INO,AVANSI';
            OptionMembers = "DOMAĆI",INO,AVANSI;
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
        field(50090; "Adjusted"; Boolean)
        {
            Caption = 'Adjusted';
        }

        field(50091; "Request Document"; code[20])

        {
            Caption = 'Request Document';
        }
    }

    var
        myInt: Integer;
}