/*page 50200 "Letters"
{
    Caption = 'Letters';
    SourceTable = Letters;
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

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Termination Type"; "Termination Type") { }
                field(Posting; Posting) { }
                field(Remark; Remark) { }
            }
        }
    }
}*/