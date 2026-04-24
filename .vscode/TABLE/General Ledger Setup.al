tableextension 50034 GeneralLedgerSetup extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Print VAT specification"; Boolean)
        {
            Caption = 'Print VAT specification';
        }


        field(50004; "Travel No. Series"; Code[10])
        {
            Caption = 'Travel No. Series';
        }
        field(50005; "Is Simple Page"; Boolean)
        {
            Caption = 'Is Simple Page';
        }
        field(50006; "Path for fiscal printer"; Text[250])
        {
            Caption = 'Path for fiscal printer';
        }
        field(50007; "No. series for S.Inventory"; Code[20])
        {
            Caption = 'No. series for S.Inventory';
            TableRelation = "No. Series".Code;
        }
        //Sales & Receivables Setup
        field(50008; "No. series for Shipment A"; Code[20])
        {
            Caption = 'No. series for Shipment Address';
            TableRelation = "No. Series".Code;
        }
        field(50009; "Z.Obligation Series"; Code[10])
        {
            Caption = 'Z.Obligation Series';
            TableRelation = "No. Series";
        }
        field(500010; "R.Obligation Series"; Code[10])
        {
            Caption = 'R.Obligation Series';
            TableRelation = "No. Series";
        }
        field(500011; "Customer Contract Entry"; Code[10])
        {
            Caption = 'Customer Contract Entry';
            TableRelation = "No. Series";
        }
        field(500012; "Retail Calc. Entry Series"; Code[10])
        {
            Caption = 'Retail Calculation Entry Series';
            TableRelation = "No. Series";
        }

        field(500013; "Vendor Invoice No."; Code[10])
        {
            Caption = 'Vendor Invoice No.';
            TableRelation = "No. Series";
        }
        field(500014; "Wholesale Calc. Entry Series"; Code[10])
        {
            Caption = 'Wholesale Calculation Entry Series';
            TableRelation = "No. Series";
        }

        field(500015; "Repost Journal Template"; Code[10])
        {
            Caption = 'Repost Journal Template';
            TableRelation = "Gen. Journal Template"."Name" where("Type" = filter("General"));

        }
        field(500016; "Repost Batch Name"; Code[10])
        {
            Caption = 'Repost Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Repost Journal Template"));

        }
        field(50017; "Sleep value"; Integer)
        {
            Caption = 'Sleep value for fiscal';
        }
        field(500018; "Purch. Retail C. Entry Series"; Code[10])
        {
            Caption = 'Purch. Retail Calculation Entry Series';
            TableRelation = "No. Series";
        }
        field(500019; "Purch.Wholesale C.Entry Series"; Code[10])
        {
            Caption = 'Purch. Wholesale Calculation Entry Series';
            TableRelation = "No. Series";
        }
        field(500020; "Path for import txt file"; Code[250])
        {
            Caption = 'Path for import txt file - CNG';
        }
        field(500021; "Path for copy txt file"; Code[250])
        {
            Caption = 'Path for copy txt file - CNG';
        }
        field(500022; "Doubtful rec. No. series"; Code[20])
        {
            Caption = 'Doubtful receivables No. series';
            TableRelation = "No. Series".Code;
        }

        field(500023; "Cash Receipt Journal Template"; Code[10])
        {
            Caption = 'Cash Receipt Journal Template';
            TableRelation = "Gen. Journal Template"."Name" where("Type" = filter(Payments));

        }
        field(500024; "Cash Batch Name"; Code[10])
        {
            Caption = 'Cash Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Cash Receipt Journal Template"));

        }
        field(500025; "Group Retail Calculation Entry Series"; Code[10])
        {
            Caption = 'Group Retail Calculation Entry Series';
            TableRelation = "No. Series";
        }

        field(500026; "G_L Entry"; Code[20])
        {
            Caption = 'G/L Entry';
            TableRelation = "No. Series";
        }
        field(500027; "Gauge Code"; Code[10])
        {
            Caption = 'Gauge Code';
            TableRelation = "No. Series";
        }
        field(500028; "Radio Module Code"; Code[10])
        {
            Caption = 'Radio Module';
            TableRelation = "No. Series";
        }
        field(500030; "Accusation Entry Series"; Code[10])
        {
            Caption = 'Accusation Entry Series';
            TableRelation = "No. Series";
        }
        field(500031; "Court Number Entry Series"; Code[10])
        {
            Caption = 'Court Number Entry Series';
            TableRelation = "No. Series";
        }
        field(500032; "Hearing Entry Series"; Code[10])
        {
            Caption = 'Hearing Entry Series';
            TableRelation = "No. Series";
        }
        field(500033; "Status Entry Series"; Code[10])
        {
            Caption = 'Accusation Status Entry Series';
            TableRelation = "No. Series";

        }
        field(500034; "Type Entry Series"; Code[10])
        {
            Caption = 'Type Entry Series';
            TableRelation = "No. Series";
        }
        field(500035; "Accusation Record Entry Series"; Code[10])
        {
            Caption = 'Accusation Record Entry Series';
            TableRelation = "No. Series";
        }
        field(500036; "History Entry Series"; Code[10])
        {
            Caption = 'History Entry Series';
            TableRelation = "No. Series";
        }
        field(500037; "Interest Yearly Rate"; Decimal)
        {
            Caption = 'Interest Yearly Rate';
        }
        field(50038; "Send name e-mail"; Text[1000])
        {
            Caption = 'Send name e-mail';
        }
        field(50039; "Send email"; Text[1000])
        {
            Caption = 'Send email';
        }
        field(50040; "Export Report Path"; Text[1000])
        {
            Caption = 'Export Report Path';
        }
        field(50041; "Reminder Line Entry Series"; Code[20])
        {
            Caption = 'Reminder Line Entry Series';
            TableRelation = "No. Series";
        }
        field(50042; "Interest Normal Coefficient"; Decimal)
        {
            Caption = 'Interest Normal Coefficient';
        }
        field(50043; "Interest Comfort Coefficient"; Decimal)
        {
            Caption = 'Interest Comfort Coefficient';
        }
        field(50044; "Issued Reminder Entry Series"; Code[20])
        {
            Caption = 'Issued Reminder Line Entry Series';
            TableRelation = "No. Series";
        }
        field(50045; "Issued Reminder Line Entry Series"; Code[20])
        {
            Caption = 'Issued Reminder Line Entry Series';
            TableRelation = "No. Series";
        }
        field(50046; "Undo Shipment for CP"; Boolean)
        {
            Caption = 'Undo Shipment for CP';

        }
        field(50047; "Interest Rate Document Entry Series"; Code[20])
        {
            Caption = 'Interest Rate Document Entry Series';
            TableRelation = "No. Series";
        }
        field(50048; "Number of Days Necessary before Interest Calculation"; Integer)
        {
            Caption = 'Number of Days Necessary before Interest Calculation';
        }
        field(50049; "VAT Bus VL"; Code[20])
        {
            Caption = 'VAT Bus VL';
            TableRelation = "VAT Business Posting Group";
        }
        field(50050; "Nivelacija No. Series"; Code[20])
        {
            Caption = 'Nivelacija No. Series';
            TableRelation = "No. Series";
        }
        field(50051; "Interest Setup"; Integer)
        {
            Caption = 'Interest Setup';
            FieldClass = FlowField;
            CalcFormula = count("Tax deduction list" where(Type = filter("Interest Setup")));

        }
        field(500052; "Group Retail Calculation Entry Series VP"; Code[10])
        {
            Caption = 'Group Retail Calculation Entry Series VP';
            TableRelation = "No. Series";
        }

        field(500056; "Massive RN"; Code[10])
        {
            Caption = 'Massive RN';
            TableRelation = "No. Series";
        }
        field(500057; "CNG Amount Rounding Precision"; decimal)
        {
            Caption = 'CNG Amount Rounding Precision';
            DecimalPlaces = 1 : 18;
            //     TableRelation = "No. Series";
        }
        field(500058; "Path for pay slip"; text[250])
        {
            Caption = 'Path for pay slip';
        }
        field(500059; "Undo Warehouse Receipt"; Code[10])
        {
            Caption = 'Undo Warehouse Receipt';
            TableRelation = "No. Series";
        }
        field(500060; "Posted Undo Warehouse Receipt"; Code[10])
        {
            Caption = 'Posted Undo Warehouse Receipt';
            TableRelation = "No. Series";
        }
        field(500061; "Number of Days"; DateFormula)
        {
            Caption = 'Number of Days';
        }
        field(500062; "CNG Amount SG"; decimal)
        {
            Caption = 'CNG Amount Rounding Precision SG';
            DecimalPlaces = 1 : 18;
            //     TableRelation = "No. Series";
        }

    }

    var
        myInt: Integer;
}