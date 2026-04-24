page 50153 "Gas Station Parameters"
{
    Caption = 'Gas Station Parameters';
    PageType = List;
    SourceTable = "Gas Station Parameter";
    UsageCategory = None;
    DelayedInsert = true;
    PopulateAllFields = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Pul; Rec.Pul)
                {
                    ApplicationArea = All;
                }
                field(Piz; Rec.Piz)
                {
                    ApplicationArea = All;
                }
                field("Security Blocking Device"; Rec."Security Blocking Device")
                {
                    ApplicationArea = All;
                }
                field("Security Vent Valve"; Rec."Security Vent Valve")
                {
                    ApplicationArea = All;
                }
                field("AFV Working Regulator"; Rec."AFV Working Regulator")
                {
                    ApplicationArea = All;
                }
                field("AFV Monitor Regulator"; Rec."AFV Monitor Regulator")
                {
                    ApplicationArea = All;
                }
                field("Valve Blocking Activation"; Rec."Valve Blocking Activation")
                {
                    ApplicationArea = All;
                }
                field("Second Security Device"; Rec."Second Security Device")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
