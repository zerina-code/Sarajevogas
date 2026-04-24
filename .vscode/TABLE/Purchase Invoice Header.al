tableextension 50056 PurchaseInvoiceHeaderExtends extends "Purch. Inv. Header"
{

    //ED

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(50007; "Contract Purchase Item"; Text[200])
        {
            Caption = 'Contract Purchase Item';
            Editable = false;
        }
        field(50011; "Commercial UserID"; Code[50])
        {
            Caption = 'Commercial UserID';
        }
        field(50012; "Accounting UserID"; Code[50])
        {
            Caption = 'Accounting UserID';
        }
        field(50013; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
        }
        field(50016; "User ID Number"; Code[50])
        {
            Caption = 'User ID Number';
        }
        field(50017; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50018; "Calculation Number"; Code[50])
        {
            Caption = 'Calculation Number';
        }
        field(50019; "KUF"; Code[20])
        {
            Caption = 'KUF';

        }
    }
}
