page 50126 "Mandatory Attachment Setup"
{
    Caption = 'Mandatory Attachment Setup';
    PageType = List;
    SourceTable = "Mandatory Attachment Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    DelayedInsert = true;
    PopulateAllFields = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field("Dwelling Type"; Rec."Dwelling Type")
                {
                    ApplicationArea = All;
                }
                field("Mandatory Attachment Type"; Rec."Mandatory Attachment Type")
                {
                    ApplicationArea = All;
                }
                field(Information; Information)
                {
                    ApplicationArea = all;
                }
                field("Gas Installation"; "Gas Installation") { }
                field(Mandatory; Mandatory)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
