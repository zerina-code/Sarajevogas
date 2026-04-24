tableextension 50076 VendorLedgerEntryExtends extends "Vendor Ledger Entry"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }


        field(50001; "G/L Account"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Vendor Posting Group"."Payables Account" where(code = field("Vendor Posting Group")));

        }

        field(50002; "Vendor Type"; Option)

        {
            OptionMembers = ,Ink,"Spare parts";

            DataClassification = ToBeClassified;

        }

        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(50003; "Compensation"; Boolean)
        {

            DataClassification = ToBeClassified;

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
    }


    var
        myInt: Integer;



}