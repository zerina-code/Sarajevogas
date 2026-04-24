table 50107 "Interest Calculation"
{
    // DrillDownPageID = "Tax Deduction Lists";
    // LookupPageID = "Tax Deduction Lists";

    fields
    {

        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            //AutoIncrement = true;

        }
        field(2; "Document No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Accusation Header"."No.";
            Caption = 'Document No.';
            Editable = false;
        }
        field(3; "Accusation Line Type"; Enum AccusationLineType)
        {
            Caption = 'Accusation Line Type';
        }
        field(6; "Sales Invoice No."; Code[20])
        {
            Caption = 'Sales Invoice No.';
            TableRelation = "Sales Invoice Header"."No.";
        }
        field(7; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';

        }
        field(9; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Interest Coefficient"; Decimal)
        {
            Caption = 'Interest Coefficient';
            DecimalPlaces = 1 : 8;
        }
        field(11; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
        }
        field(12; "Interest Calculation Type"; Enum InterestCalculationType)
        {
            Caption = 'Interest Calculation Type';
        }
        field(13; "Interest Yearly Rate"; Decimal)
        {
            Caption = 'Interest Yearly Rate';
        }
        field(18; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(19; "Cust. Ledger Entry No."; Integer)
        {
            Caption = 'Cust. Ledger Entry No.';

        }
        field(20; "Remaining Amount"; Decimal)
        {
            Caption = 'Cust. Ledger Entry No.';
        }

        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
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
        field(50051; "Archived"; Boolean) //ED
        {
            Caption = 'Archived';

        }
        field(5066052; "Date from"; Date) //ED
        {
            Caption = 'Date from';

        }
        field(5066053; "Date to"; Date) //ED
        {
            Caption = 'Date to';

        }
        field(5066054; "Payment Date"; Date) //ED
        {
            Caption = 'Payment Date';

        }
        field(5066055; "Payment Amount"; Decimal) //ED
        {
            Caption = 'Payment Amount';

        }
        field(5066056; "Difference Amount"; Decimal) //ED
        {
            Caption = 'Difference Amount';

        }
        field(50660567; "Difference Days"; Integer) //ED
        {
            Caption = 'Difference Days';

        }
        field(16; "Date of Debt"; Date)
        {
            Caption = 'Date of Debt';
        }
        field(15; "Date of Payment"; Date)
        {
            Caption = 'Date of Payment';
            FieldClass = FlowField;
            CalcFormula = lookup("Detailed Cust. Ledg. Entry"."Posting Date" where("Document Type" = filter(Payment), "Entry Type" = filter(Application), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));
        }
        field(14; "Amount Payed"; Decimal)
        {
            Caption = 'Amount Paid';
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Document Type" = filter(Payment), "Entry Type" = filter(Application), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));

        }



    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }



}

