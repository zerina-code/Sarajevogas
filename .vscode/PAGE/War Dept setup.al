page 50123 "War Dept Setups"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "War Debt Setup";
    Caption = 'War Dept Setup';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field("Customer Category"; "Customer Category") { }
                field(Month; Month) { }
                field("Currency Code"; "Currency Code") { }
                field(CBM; CBM) { }
                field(Amount; Amount) { Visible = false; }
                field(Active; Active) { }

                field(Resource; Resource) { }
                field(Totaling; Totaling) { }



            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}