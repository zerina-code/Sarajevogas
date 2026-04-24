page 50196 "Projects"
{
    Caption = 'Projects';
    SourceTable = "Project";
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
                field("Project Date"; "Project Date") { ApplicationArea = All; }
                field("Investor Code"; "Investor Code") { }
                field("Investor Name"; "Investor Name") { }
                //   field("RN Number"; "RN Number") { ApplicationArea = all; }
            }
        }

    }
}