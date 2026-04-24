page 50203 "Groupings"
{
    Caption = 'Groupings';
    SourceTable = "Grouping";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field(Type; Type)
                {
                    ApplicationArea = all;

                }
            }
        }
    }
}