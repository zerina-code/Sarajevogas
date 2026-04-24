table 50108 "Accusation Line"
{
    Caption = 'Accusation Line';
    DrillDownPageID = "Accusation Line";
    LookupPageID = "Accusation Line";

    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';
            InitValue = 1;
            AutoIncrement = true;
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
        field(8; Note; Text[500])
        {
            Caption = 'Note';
        }
        field(9; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(10; "Interest Coefficient"; Decimal)
        {
            Caption = 'Interest Coefficient';
            DecimalPlaces = 1 : 8;
            FieldClass = FlowField;
            CalcFormula = sum("Interest Calculation"."Interest Coefficient" where("Document No." = field("Document No."), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));
        }
        field(11; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Interest Calculation"."Interest Amount" where("Document No." = field("Document No."), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));
        }
        field(12; "Interest Calculation Type"; Enum InterestCalculationType)
        {
            Caption = 'Interest Calculation Type';
        }
        field(13; "Interest Yearly Rate"; Decimal)
        {
            Caption = 'Interest Yearly Rate';
        }
        field(14; "Amount Payed"; Decimal)
        {
            Caption = 'Amount Paid';
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Document Type" = filter(Payment), "Entry Type" = filter(Application), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));
        }
        field(15; "Date of Payment"; Date)
        {
            Caption = 'Date of Payment';
            FieldClass = FlowField;
            CalcFormula = lookup("Detailed Cust. Ledg. Entry"."Posting Date" where("Document Type" = filter(Payment), "Entry Type" = filter(Application), "Cust. Ledger Entry No." = field("Cust. Ledger Entry No.")));
        }
        field(16; "Date of Debt"; Date)
        {
            Caption = 'Date of Debt';
        }
        field(17; "Interest Paid"; Decimal)
        {
            Caption = 'Interest Paid';
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
        field(50052; "Withdrawn"; Boolean)
        {
            Caption = 'Withdrawn';
            FieldClass = FlowField;
            CalcFormula = lookup("Accusation Header".Withdrawn where("No." = field("Document No.")));
        }
        field(50053; "Customer No."; Code[20]) //ED
        {
            Caption = 'Customer No.';
        }
        //polja sa 'Transfer' u nazivu su polja koja sadrže vrijednosti unešene iz starog sistema. 
        field(50054; "Sales Invoice No. - Transfer"; Code[20])
        {
            Caption = 'Sales Invoice No. - Transfer';
        }
        field(50055; "Amount Paid - Transfer"; Decimal)
        {
            Caption = 'Amount Paid - Transfer';
        }
        field(50056; "Debt Amount - Transfer"; Decimal)
        {
            Caption = 'Debt Amount - Transfer';
        }
        field(50057; "Interest Amount - Transfer"; Decimal)
        {
            Caption = 'Interest Amount - Transfer';
        }
        field(50058; "Date - Transfer"; Date)
        {
            Caption = 'Date - Transfer';
        }
        field(50059; "Due Date - Transfer"; Date)
        {
            Caption = 'Due Date - Transfer';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        SAL: Page "Sales Invoice";
        invline: Page "Sales Lines";

    trigger OnInsert()
    begin
        InitNewLine(Rec);
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    local procedure InitNewLine(var NewAccLine: Record "Accusation Line")
    var
        AccusationLine: Record "Accusation Line";
    begin
        NewAccLine.Copy(Rec);
        AccusationLine.SetRange("Document No.", NewAccLine."Document No.");
        if AccusationLine.FindLast then begin
            Message(Format(AccusationLine."Line No." + 1));
            NewAccLine."Line No." := AccusationLine."Line No." + 1
        end

        else begin
            NewAccLine."Line No." := 1;
        end;

    end;

}