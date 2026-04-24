pageextension 50225 "Resource Prices" extends "Resource Prices"
{
    layout
    {
        modify(Type)
        {
            Editable = CanModify;
        }
        modify(Code)
        {
            Editable = CanModify;
        }
        modify("Work Type Code")
        {
            Editable = CanModify;
        }
        modify("Unit Price")
        {
            Editable = CanModify;
        }
        modify("Currency Code")
        {
            Editable = CanModify;
        }

    }


    trigger OnOpenPage()

    begin
        CanModify := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_R;

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.MM_UGI_R;

        end;
    end;



    var
        CanModify: Boolean;
        UserSetup: Record "User Setup";
}