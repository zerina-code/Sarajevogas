page 50214 "Temp Requests"
{
    ApplicationArea = All;
    Caption = 'Temp Requests';
    PageType = List;
    SourceTable = "Temp Service Header";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
