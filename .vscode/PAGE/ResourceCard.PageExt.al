pageextension 50005 "Resource Card" extends "Resource Card"
{

    //ED modify 

    layout
    {
        modify("No.")
        {
            Visible = true;
        }
        addafter("Resource Group No.")
        {
            field("Catalog Sheet"; "Catalog Sheet") //ED za import usluga
            {
                ApplicationArea = All;
            }
            field("Order"; "Order")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Request Resource Type"; Rec."Request Resource Type")
            {
                ApplicationArea = All;
            }
        }

        modify("Privacy Blocked") { Visible = false; }
        modify("Use Time Sheet") { Visible = false; }
        modify("Time Sheet Owner User ID") { Visible = false; }
        modify("Time Sheet Approver User ID") { Visible = false; }
        modify("Default Deferral Template Code") { Visible = false; }
        modify("Automatic Ext. Texts") { Visible = false; }
        modify("IC Partner Purch. G/L Acc. No.") { Visible = false; }
        modify("Social Security No.") { Visible = false; }
        modify(Education) { Visible = false; }
        modify("Contract Class") { Visible = false; }
        modify("Employment Date") { Visible = false; }
        modify("Direct Unit Cost") { Visible = false; }
        modify("Indirect Cost %") { Visible = false; }
        modify("Unit Cost") { Visible = false; }
        modify("Price/Profit Calculation") { Visible = false; }
        modify("Profit %") { Visible = false; }
    }

    actions
    {
        modify(CreateTimeSheets) { Visible = false; }
        modify("S&kills") { Visible = false; }
        modify("&Picture") { Visible = false; }
        modify("Online Map") { Visible = false; }
        modify("E&xtended Texts") { Visible = false; }

        addafter("&Resource")
        {
            action("Delete Resource")
            {
                ApplicationArea = All;
                Caption = 'Delete Resource', Comment = 'Obriši Usluge';
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Res: Record "Resource";
                begin
                    RES.SETFILTER("No.", '%1', 'KP*');
                    IF RES.FINDFIRST then
                        repeat
                            REs.DELETE;
                        until Res.NEXT = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 3;
            UserSetup.Modify();
        end;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_R;
        if not CanModify then begin
            Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;
    end;

    trigger OnClosePage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 0;
            UserSetup.Modify();
        end;
    end;

    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}
