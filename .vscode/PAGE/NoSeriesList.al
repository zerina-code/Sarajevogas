pageextension 50055 NoSeriesList extends "No. Series List"
{

    //ED

    layout
    {
        addafter(Description)
        {
            field("Subgroup Code"; "Subgroup Code")
            {
                ApplicationArea = All;
                Visible = Show;
            }
            field("Subgroup Name"; "Subgroup Name")
            {
                ApplicationArea = All;
                Visible = Show;
                //Editable=false;
            }
            field("Group Code"; "Group Code")
            {
                ApplicationArea = All;
                Visible = Show;
            }
            field("Group Name"; "Group Name")
            {
                ApplicationArea = All;
                Visible = Show;
                //Editable = false;
            }
            field("Category Code"; "Category Code")
            {
                ApplicationArea = All;
                Visible = true;
            }
            field("Category Name"; "Category Name")
            {
                ApplicationArea = All;
                Visible = true;
                //Editable = false;
            }
            field("Code Category Text"; "Code Category Text") //IZBRISATI
            {
                ApplicationArea = All;
                Visible = true;
                //Visible = Show; VRATITI
                //Editable = false;
            }
            field("Customer Category"; "Customer Category") { ApplicationArea = all; }
            //R
            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = Show;
                Editable = "Code Category Text" = 1;
                TableRelation = "Gen. Product Posting Group";
            }

            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = Show;
                Editable = "Code Category Text" = 1;
                TableRelation = "VAT Product Posting Group";
            }

            field("Inventory Posting Group"; "Inventory Posting Group")
            {
                ApplicationArea = All;
                Visible = Show;
                Editable = "Code Category Text" = 1;
                TableRelation = "Inventory Posting Group";
            }

            field("Cust. Gen. Bus. Posting Group"; "Cust. Gen. Bus. Posting Group")
            {
                Visible = true;
            }
            field("Cust. VAT Bus. Posting Group"; "Cust. VAT Bus. Posting Group") { Visible = true; }
            field("Customer Posting Group"; "Customer Posting Group") { Visible = true; }

            field("Customer Price Group"; "Customer Price Group") { Visible = true; }
            field("Type Relation"; "Type Relation") { ApplicationArea = all; }
            //R
        }
    }
    actions
    {

        addafter("&Series")
        {
            action("&Import")
            {
                Caption = '&Import';
                Image = Import;
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = xmlport "Item Posting Groups import";

            }
        }


    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if (UserSetup."Code Category Text" <> 0) and (UserSetup."Code Category Text" < 3) then
                Show := true
            else
                Show := false;

            if UserSetup."Code Category Text" = 4 then
                ShowC := true
            else
                ShowC := false;

            Rec."Code Category Text" := UserSetup."Code Category Text";
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if (UserSetup."Code Category Text" <> 0) and (UserSetup."Code Category Text" < 3) then
                Show := true
            else
                Show := false;

            if UserSetup."Code Category Text" = 4 then
                ShowC := true
            else
                ShowC := false;

            Rec."Code Category Text" := UserSetup."Code Category Text";
        end;

    end;

    trigger OnClosePage()
    begin

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
        Show: Boolean;
        ShowC: Boolean;
        NoSeriesTable: Record "No. Series";

}