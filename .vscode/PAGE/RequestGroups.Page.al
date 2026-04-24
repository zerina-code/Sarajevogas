page 50188 "Request Groups"
{
    Caption = 'Request Groups';
    SourceTable = "Request Group";
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
            }
        }
    }




    trigger OnOpenPage()

    begin
        CanModify := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_AKT;

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_AKT;

        end;
    end;




    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}