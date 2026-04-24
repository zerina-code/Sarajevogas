pageextension 50053 MarketingSetupCard extends "Marketing Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Bus. Rel. Code for Employees")
        {
            field("Bus. Rel. Code for SI"; "Bus. Rel. Code for SI") { ApplicationArea = all; }
            field("Bus. Rel. Code for Welder"; "Bus. Rel. Code for Welder") { ApplicationArea = all; }
            field("Bus. Rel. Code for Builder"; "Bus. Rel. Code for Builder") { ApplicationArea = all; }
            field("Bus. Rel. Code for Contractor"; "Bus. Rel. Code for Contractor") { ApplicationArea = all; }
            field("Bus. Rel. Code for CM"; "Bus. Rel. Code for CM") { ApplicationArea = all; }
            field("Bus. Rel. Code for Designer"; "Bus. Rel. Code for Designer") { ApplicationArea = all; }
            field("Bus. Rel. Code for Investor"; "Bus. Rel. Code for Investor") { ApplicationArea = all; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}