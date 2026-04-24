page 50002 "VAT Books Setup"
{
    AutoSplitKey = true;
    Caption = 'VAT Books Setup';
    DelayedInsert = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "VAT Books Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                }
                field("Column Name"; "Column Name")
                {
                }
                field(Operator1; Operator1)
                {
                }
                field(Value1; Value1)
                {
                }
                field(Operator2; Operator2)
                {
                }
                field(Value2; Value2)
                {
                }
            }
        }
    }

    actions
    {
    }
}

