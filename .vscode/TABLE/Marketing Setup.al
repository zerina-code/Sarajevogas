tableextension 50047 MarketingSetup extends "Marketing Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Bus. Rel. Code for SI"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Service Item';
            TableRelation = "Business Relation";
        }
        field(50001; "Bus. Rel. Code for Welder"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Welder';
            TableRelation = "Business Relation";
        }
        field(50002; "Bus. Rel. Code for Builder"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Builder';
            TableRelation = "Business Relation";
        }
        field(50003; "Bus. Rel. Code for Contractor"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Contractor';
            TableRelation = "Business Relation";
        }

        field(50004; "Bus. Rel. Code for CM"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Construction Manager';
            TableRelation = "Business Relation";
        }
        field(50005; "Bus. Rel. Code for Designer"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Designer';
            TableRelation = "Business Relation";
        }
        field(50006; "Bus. Rel. Code for Investor"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Investor';
            TableRelation = "Business Relation";
        }

        field(50007; "Bus. Rel. Code for CW"; Code[10])
        {
            Caption = 'Bus. Rel. Code for Chimney sweep';
            TableRelation = "Business Relation";
        }
        field(50008; "Bus. Rel. Code for SM"; Code[10])
        {
            Caption = 'Bus. Rel. Code for ServiceMan';
            TableRelation = "Business Relation";
        }
        field(50009; "Bus. Rel. Code for OW"; Code[10])
        {
            Caption = 'Bus. Rel. Code for OW';
            TableRelation = "Business Relation";
        }


    }

    var
        myInt: Integer;
}