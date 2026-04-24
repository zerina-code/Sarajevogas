page 50124 "Dwelling Types"
{
    Caption = 'Dwelling Types';
    SourceTable = "Dwelling Type";
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
                field("Short Description"; "Short Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Short Description';
                }
            }
        }
    }
}