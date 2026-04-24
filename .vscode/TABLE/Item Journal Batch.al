tableextension 50042 Item_Journal_BatchExtends extends "Item Journal Batch"
{
    fields
    {

        field(50000; "Gen. Bus. Posting Group"; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
            trigger OnValidate();
            var
                GenBusPostingGrp: Record "Gen. Business Posting Group";
            begin

                GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp, "Gen. Bus. Posting Group"); //+BH1.00
            end;
        }
        field(50022; "Nivelacija"; Boolean)
        {
            Caption = 'Nivelacija';
        }
        field(50023; "Transfer"; Boolean)
        {
            Caption = 'Transfer';
        }
    }
}