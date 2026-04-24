page 50140 "Gas Appliances List"
{
    Caption = 'Gas Appliances';
    PageType = List;
    SourceTable = "Gas Appliance";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Power From"; Rec."Power From")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Power To"; Rec."Power To")
                {
                    ApplicationArea = All;
                }
                field("Gas Appliance Type"; Rec."Gas Appliance Type")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }

    //insert permission-EK
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_GASNI_APARATI;
        if not CanModify then begin
            Error('Nemate dozvolu da modifikujete ovu listu.');
        end;
    end;

    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}
