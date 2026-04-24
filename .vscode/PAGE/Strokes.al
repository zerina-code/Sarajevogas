page 50119 Strokes
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Stroke;
    Caption = 'Strokes';

    layout
    {
        area(Content)
        {
            repeater("")
            {

                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field("Measuring Point string"; "Measuring Point string") { ApplicationArea = all; }
                field("Municipality Code"; "Municipality Code") { ApplicationArea = all; }
                field("MZ-Code"; "MZ-Code") { ApplicationArea = all; }
                field(Street; Street) { ApplicationArea = all; }
                field("Even stroke from"; "Even stroke from") { ApplicationArea = all; }
                field("Even stroke to"; "Even stroke to") { ApplicationArea = all; }
                field("Odd stroke from"; "Odd stroke from") { ApplicationArea = all; }
                field("Odd stroke to"; "Odd stroke to") { ApplicationArea = all; }
                field("Zone stroke"; "Zone stroke") { ApplicationArea = all; }
                field("Fictitious Code"; "Fictitious Code") { ApplicationArea = all; }

            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Update Data")
            {
                ApplicationArea = All;
                Caption = 'Update Data';
                Image = "Print";
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Visible;


                trigger OnAction()
                var
                    GTemp: Record "User Setup";


                begin
                    GTemp.Reset();
                    GTemp.SetFilter("User ID", '%1', UserId);
                    if GTemp.FindFirst() then begin
                        GTemp."StreetNo." := rec.Street;
                        GTemp.Modify();

                    end;
                    Commit();

                    Report.RunModal(Report::"Update Stroke", true, true);
                    Commit();
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Visible := false
        else
            Visible := true;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Visible := false
        else
            Visible := true;

    end;

    var
        myInt: Integer;
        Visible: Boolean;
}