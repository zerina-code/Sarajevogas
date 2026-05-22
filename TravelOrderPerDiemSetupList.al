page 50991 "Per Diem Setup SG"
{
    PageType = List;
    SourceTable = "Travel Order Per Diem Setup";
    UsageCategory = Lists;
    ApplicationArea = All;
    Caption = 'Putni nalog - Dnevnice po zemlji';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                }

                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                }

                field("Full Day Per Diem Amount"; Rec."Full Day Per Diem Amount")
                {
                    ApplicationArea = All;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}