pageextension 50088 ServiceItemGroups extends "Service Item Groups"
{

    //ED

    layout
    {
        addafter(Description)
        {
            field("Category Code"; "Category Code")
            {
                ApplicationArea = All;
            }
            field("Category Description"; "Category Description")
            {
                ApplicationArea = All;
            }
            field("Code Category Text"; "Code Category Text")
            {
                ApplicationArea = All;
            }
        }
        modify("Default Contract Discount %")
        {
            Visible = false;
        }
        modify("Default Serv. Price Group Code")
        {
            Visible = false;
        }
        modify("Default Response Time (Hours)")
        {
            Visible = false;
        }
        modify("Create Service Item")
        {
            Visible = false;
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            ServiceItemGroupTable.Reset();
            ServiceItemGroupTable.SetFilter("Code Category Text", '%1', UserSetup."Code Category Text");
            ServiceItemGroupPage.SetTableView(ServiceItemGroupTable);
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
        ServiceItemGroupTable: Record "Service Item Group";
        ServiceItemGroupPage: Page "Service Item Groups";

}

