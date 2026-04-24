page 50116 "Gas Station Attributes"
{
    Caption = 'Gas Station Attributes';
    SourceTable = "Gas Station Attribute";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec."Gas Station Attribute Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}