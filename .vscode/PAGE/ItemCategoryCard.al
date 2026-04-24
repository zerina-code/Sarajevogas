pageextension 50049 ItemCategoryCard extends "Item Category Card"
{

    //ED

    layout
    {
        addafter(Description)
        {
            field("Code Category Text"; "Code Category Text")
            {

            }
        }
        modify(Code)
        {
            trigger OnBeforeValidate()
            begin
                UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', UserId);
                if UserSetup.FindFirst() then begin
                    "Code Category Text" := UserSetup."Code Category Text";
                end;
            end;
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            Rec."Code Category Text" := UserSetup."Code Category Text";
        end;
    end;

    var
        UserSetup: Record "User Setup";

}