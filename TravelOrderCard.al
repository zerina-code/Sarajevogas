page 50009 "Travel Order Card SG"
{
    PageType = Card;
    SourceTable = "Travel Order Header SG";
    Caption = 'Putni nalog';
    UsageCategory = Documents;
    ApplicationArea = All;
    RefreshOnActivate = true;
    //SaveValues = false;


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
                    Editable = false;
                }

                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusStyle;
                    Editable = false;
                }

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Employee Full Name"; Rec."Employee Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Employee Job Title"; Rec."Employee Job Title")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Order Issuer"; Rec."Order Issuer")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Destination City"; Rec."Destination City")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = ShowVehicle;
                }

                field("Start Mileage"; Rec."Start Mileage")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = ShowMileage;
                }

                field("End Mileage"; Rec."End Mileage")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = ShowMileage;
                }

                field("Authorized Person"; Rec."Authorized Person")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }

            group(TripDetails)
            {
                Caption = 'Detalji putovanja';

                field("Destination"; Rec.Destination)
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("Departure Time"; Rec."Departure Time")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("Return Time"; Rec."Return Time")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }

                field("Transport Type"; Rec."Transport Type")
                {
                    ApplicationArea = All;
                    Editable = true;

                    trigger OnValidate()
                    begin
                        SetPageVariables();
                        CurrPage.Update(false);
                    end;
                }

                field("Purpose"; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Editable = true;
                    MultiLine = true;
                }
            }

            group("Per Diem Calculation")
            {
                Caption = 'Obračun dnevnice';

                field("Duration Minutes"; Rec."Duration Minutes")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Duration Text"; Rec."Duration Text")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Per Diem Type"; Rec."Per Diem Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Per Diem Base Amount"; Rec."Per Diem Base Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Per Diem Amount"; Rec."Per Diem Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Financial)
            {
                Caption = 'Financijski podaci';

                field("Advance Amount"; Rec."Advance Amount")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }

                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }

            group(AdministrativeInfo)
            {
                Caption = 'Administrativni podaci';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved By"; Rec."Approved By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
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
        StatusStyle: Text;
        ShowVehicle: Boolean;
        ShowMileage: Boolean;

    local procedure SetPageVariables()
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

        ShowVehicle := Rec."Transport Type" = Rec."Transport Type"::Sluzbeno;
        ShowMileage := Rec."Transport Type" = Rec."Transport Type"::Privatno;
    end;
}