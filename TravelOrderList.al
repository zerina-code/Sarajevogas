page 50010 "Travel Order List SG"
{
    PageType = List;
    SourceTable = "Travel Order Header SG";
    Caption = 'Travel Order List';
    UsageCategory = Lists;
    ApplicationArea = All;
    CardPageId = "Travel Order Card SG";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Broj putnog naloga.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Šifra zaposlenika.';
                }
                field("Employee Full Name"; Rec."Employee Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ime i prezime zaposlenika.';
                }
                field("Destination"; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Odredište.';
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum polaska.';
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum dolaska.';
                }
                field("Advance Amount"; Rec."Advance Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Akontacija.';
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Status naloga.';
                    StyleExpr = StatusStyle;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Kreirao.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum kreiranja.';
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(NewTravelOrder)
            {
                Caption = 'Novi putni nalog';
                ApplicationArea = All;
                Image = New;
                RunObject = page "Travel Order Card SG";
                RunPageMode = Create;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Status of
            Rec.Status::Open:
                StatusStyle := 'Favorable';
            Rec.Status::Approved:
                StatusStyle := 'Ambiguous';
            Rec.Status::Closed, Rec.Status::"ClosedPosted":
                StatusStyle := 'Subordinate';
            Rec.Status::Cancelled, Rec.Status::"ClosedCancelled":
                StatusStyle := 'Unfavorable';
            else
                StatusStyle := 'Standard';
        end;
    end;

    var
        StatusStyle: Text;
}
