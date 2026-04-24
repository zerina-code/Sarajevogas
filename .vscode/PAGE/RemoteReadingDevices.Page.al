//staviti ću izvan ranga- nisam sigurna da li će mi trebati kao šifarnik
page 50208 "Remote Reading Devices"
{
    Caption = 'Remote Reading Devices';
    SourceTable = "Remote Reading Device";
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
            }
        }
    }
}