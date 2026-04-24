pageextension 50013 ApprovalsActivities extends "Approvals Activities"
{

    layout
    {
        // Add changes to page layout here
        addafter("Requests to Approve")
        {
            cuegroup("Purchase Orders")
            {
                Caption = 'Purchase Orders';

                field("Purchase Orders for Approval"; "Purchase Orders for Approval")
                {
                    ApplicationArea = all;
                    Visible = Finansije;
                    DrillDownPageId = "Purchase Order List";
                }
                field("Purchase Orders for Posting"; "Purchase Orders for Posting")
                {
                    ApplicationArea = all;
                    Visible = "Računovodstvo";
                    DrillDownPageId = "Purchase Order List";
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            Finansije := UserSetup.Finance;
            Komercijala := UserSetup.Commercial;
            "Računovodstvo" := UserSetup.Accounting;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        Finansije: Boolean;
        Komercijala: Boolean;
        Računovodstvo: Boolean;
}