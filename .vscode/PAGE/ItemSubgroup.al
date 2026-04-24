page 50007 ItemSubgroup
{
    //ED

    Caption = 'Item Subgroup';
    PageType = List;
    SourceTable = ItemSubgroup;
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Subgroup Code"; "Subgroup Code")
                {
                    ApplicationArea = all;
                }
                field("Subgroup Label"; "Subgroup Label")
                {
                    ApplicationArea = all;
                }
                field("Subgroup Description"; "Subgroup Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Class Code"; "Class Code")
                {
                    ApplicationArea = all;
                }
                field("Class Description"; "Class Description")
                {
                    ApplicationArea = all;
                }
                field("Code Category Text"; "Code Category Text")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            ItemSubgroupTable.Reset();
            ItemSubgroupTable.SetFilter("Code Category Text", '%1', UserSetup."Code Category Text");
            ItemSubgroupPage.SetTableView(ItemSubgroupTable);
            "Code Category Text" := UserSetup."Code Category Text";
        end;
    end;

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
        ItemSubgroupTable: Record ItemSubgroup;
        ItemSubgroupPage: Page ItemSubgroup;
}

