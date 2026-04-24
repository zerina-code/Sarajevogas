page 50235 "Calculation Journal Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Calculation Journal Line";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Customer Name"; "Customer Name") { }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = All; }
                field("MM Description"; "MM Description") { ApplicationArea = all; }
                field(Gauge; Gauge) { ApplicationArea = All; }
                field("Gauge Size"; "Gauge Size") { ApplicationArea = All; }
                field("Serial Number"; "Serial Number") { ApplicationArea = All; }
            }
            part("Calculation Entries"; "Calculation Entries")
            {
                subpagelink = "Customer No." = field("Customer No."), "Measuring Point Code" = field("Measuring Point Code"), Locked = filter(True | false);


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