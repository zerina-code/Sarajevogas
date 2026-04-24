pageextension 50002 "Service Mgt. Setup" extends "Service Mgt. Setup"
{
    layout
    {
        addafter("Posted Service Invoice Nos.")
        {
            field("Gauge Code"; "Gauge Code") { ApplicationArea = all; }
            field("Corrector Code"; "Corrector Code") { ApplicationArea = all; }
        }
        addlast(Content)
        {
            group("Requests Setup")
            {
                Caption = 'Requests Setup';
                field("Requests No. Series"; Rec."Requests No. Series")
                {
                    ApplicationArea = All;
                }
                field("Inform. Issue No. Series"; Rec."Inform. Issue No. Series")
                {
                    ApplicationArea = All;
                }
                field("Inform. On Conn. No. Series"; Rec."Inform. On Conn. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Proj. Overview No. Series"; Rec."Proj. Overview No. Series")
                {
                    ApplicationArea = All;
                }
                field("Proj. Accordance No. Series"; Rec."Proj. Accordance No. Series")
                {
                    ApplicationArea = All;
                }
                field("Work Execution No. Series"; Rec."Work Execution No. Series")
                {
                    ApplicationArea = All;
                }
                field("UGI Overview No. Series"; Rec."UGI Overview No. Series")
                {
                    ApplicationArea = All;
                }
                field("Gen. Work Order No. Series"; Rec."Gen. Work Order No. Series")
                {
                    ApplicationArea = All;
                }
                field("Gen. Work Order Geo No. Series"; Rec."Gen. Work Order Geo No. Series")
                {
                    ApplicationArea = All;
                }
                field("GEO Workplaces No. Series"; "GEO Workplaces No. Series") { }
                field("Geo Registrator No. Series"; "Geo Registrator No. Series") { }
                field("Elaboration No. Series"; "Elaboration No. Series") { }
                field("Sketch No. Series"; "Sketch No. Series") { }
                field("Loc. Accord. Req. No. Series"; Rec."Loc. Accord. Req. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Loc. Accord. Info. No. Series"; Rec."Loc. Accord. Info. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Route Accord. Req. No. Series"; Rec."Route Accord. Req. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Route Accord. Info. No. Series"; Rec."Route Accord. Info. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Spat. Accord. Req. No. Series"; Rec."Spat. Accord. Req. No. Series")
                {
                    ApplicationArea = All;
                }
                field("Spat. Accord. Info. No. Series"; Rec."Spat. Accord. Info. No. Series")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
