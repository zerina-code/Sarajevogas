page 50101 "Gas Appliance Types"
{
    Caption = 'Gas Appliance Types';
    SourceTable = "Gas Appliance Type";
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
                    Editable = CanModify;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                    Editable = CanModify;
                }
                field("Gas Appliance Type"; "Gas Appliance Type")
                {
                    ApplicationArea = All;
                    Editable = CanModify;

                }
                field(Type; Type) { Editable = CanModify; }
            }
        }
    }

    //permission-EK
    trigger OnOpenPage()

    begin
        CanModify := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_GASNI_APARATI;

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_GASNI_APARATI;

        end;
    end;

    //insert permission-EK
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_GASNI_APARATI;
        if not CanModify then begin
            Error('Nemate dozvolu za unos u ovu listu.');
        end;
    end;




    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}