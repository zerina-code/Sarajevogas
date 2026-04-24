tableextension 50008 ApprovalsActivitiesCue extends "Approvals Activities Cue"
{

    //ED

    fields
    {
        field(5; "Purchase Orders for Approval"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Accounting = const(false)));
            Caption = 'Purchase Orders for Approval';
            FieldClass = FlowField;
        }
        field(6; "Purchase Orders for Posting"; Integer)
        {
            CalcFormula = Count("Purchase Header" WHERE(Accounting = const(true), Commercial = const(true)));
            Caption = 'Purchase Orders for Posting';
            FieldClass = FlowField;
        }
    }

    var

}