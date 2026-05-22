page 50009 "Travel Order Card SG"
{
    PageType = Card;
    SourceTable = "Travel Order Header SG";
    Caption = 'Putni nalog';
    UsageCategory = Documents;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Opći podaci';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Broj putnog naloga (auto-generisan).';
                    Editable = false;
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Trenutni status putnog naloga.';
                    StyleExpr = StatusStyle;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Odaberite zaposlenika.';
                    Editable = IsEditableVar;
                }
                field("Employee Full Name"; Rec."Employee Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Ime i prezime zaposlenika.';
                }
                field("Employee Job Title"; Rec."Employee Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Radno mjesto zaposlenika.';
                }
            }
            group(TripDetails)
            {
                Caption = 'Detalji putovanja';

                field("Destination"; Rec.Destination)
                {
                    ApplicationArea = All;
                    ToolTip = 'Odredište putovanja.';
                    Editable = IsEditableVar;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Zemlja putovanja.';
                    Editable = IsEditableVar;
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum polaska.';
                    Editable = IsEditableVar;
                }
                field("Departure Time"; Rec."Departure Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vrijeme polaska.';
                    Editable = IsEditableVar;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum dolaska.';
                    Editable = IsEditableVar;
                }
                field("Return Time"; Rec."Return Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vrijeme dolaska.';
                    Editable = IsEditableVar;
                }
                field("Transport Type"; Rec."Transport Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Vrsta prijevoza.';
                    Editable = IsEditableVar;
                }
                field("Purpose"; Rec.Purpose)
                {
                    ApplicationArea = All;
                    ToolTip = 'Svrha putovanja.';
                    Editable = IsEditableVar;
                    MultiLine = true;
                }
            }

            part(BoravakPoDrzavama; "Stay By Country Subf.")
            {
                ApplicationArea = All;
                Caption = 'Boravak po Državama';
                SubPageLink = "Broj Naloga" = field("No.");
                UpdatePropagation = Both;
            }
            group(Financial)
            {
                Caption = 'Financijski podaci';

                field("Advance Amount"; Rec."Advance Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Iznos akontacije (ne može biti negativan).';
                    Editable = IsEditableVar;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Valuta akontacije.';
                    Editable = IsEditableVar;
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Troškovno mjesto.';
                    Editable = IsEditableVar;
                }
            }

            group(AdministrativeInfo)
            {
                Caption = 'Administrativni podaci';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Korisnik koji je kreirao nalog.';
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum kreiranja naloga.';
                }
                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Korisnik koji je odobrio nalog.';
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Datum odobrenja.';
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Napomena uz nalog.';
                    Editable = IsEditableVar;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Caption = 'Odobri';
                ApplicationArea = All;
                Image = Approve;
                ToolTip = 'Odobri putni nalog.';
                Enabled = Rec.Status = Rec.Status::Open;

                trigger OnAction()
                begin
                    Rec.TestField("Employee No.");
                    Rec.TestField("Departure Date");
                    Rec.TestField("Return Date");
                    Rec.TestField(Destination);
                    Rec.TestField(Purpose);
                    Rec.Status := Rec.Status::Approved;
                    Rec."Approved By" := CopyStr(UserId(), 1, MaxStrLen(Rec."Approved By"));
                    Rec."Approved Date" := Today();
                    Rec.Modify(true);
                    CurrPage.Update(false);
                    Message('Nalog %1 je odobren.', Rec."No.");
                end;
            }
            action(Close)
            {
                Caption = 'Zatvori nalog';
                ApplicationArea = All;
                Image = Close;
                ToolTip = 'Zatvori putni nalog.';
                //  Enabled = Rec.Status = Rec.Status::Approved;

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Closed;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                end;
            }
            action(Cancel)
            {
                Caption = 'Otkaži nalog';
                ApplicationArea = All;
                Image = Cancel;
                ToolTip = 'Otkaži putni nalog.';
                //     Enabled = Rec.Status in [Rec.Status::Open, Rec.Status::Approved];

                trigger OnAction()
                begin
                    if Confirm('Da li ste sigurni da želite otkazati nalog %1?', false, Rec."No.") then begin
                        Rec.Status := Rec.Status::Cancelled;
                        Rec.Modify(true);
                        CurrPage.Update(false);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetPageVariables();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetPageVariables();
    end;

    var
        IsEditableVar: Boolean;
        StatusStyle: Text;

    local procedure SetPageVariables()
    begin
        IsEditableVar := Rec.IsEditable();
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
}
