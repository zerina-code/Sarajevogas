page 50215 "Box Fixed Asset"
{
    ApplicationArea = All;
    Caption = 'Box';
    PageType = List;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("Box"));
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
            }
        }
    }
}
