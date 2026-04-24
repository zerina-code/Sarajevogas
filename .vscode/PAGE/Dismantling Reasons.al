page 50172 "Dismantling Reasons"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Dismantling Reason";
    Caption = 'Dismantling Reasons';
    // SourceTableView = where(Type = filter("Reason for dismantling"));


    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; Editable = CanModify; }
                field("Short Text"; "Short Text") { Editable = CanModify; }
                field("RN No. Series"; "RN No. Series") { Editable = CanModify; }
                field(Verification; Verification) { Editable = CanModify; }
                field("Gauge replacement"; "Gauge replacement") { Editable = CanModify; }
                field("Gauge cut off"; "Gauge cut off") { Editable = CanModify; }
                field(InActive; InActive) { Editable = CanModify; } //isključen mjerač
                field(Active; Active) { Editable = CanModify; } //uključen mjerač
                field(Temporery; Temporery) { Editable = CanModify; } //privremeno odjavljen
                field(Permanently; Permanently) { Editable = CanModify; } //trajno odjavljen
                field("Default reason"; "Default reason") { Editable = CanModify;Visible=false; }
                field("Is not in Calibration facility"; "Is not in Calibration facility") { Editable = CanModify; }
                field("Type G_R"; "Type G_R") { Editable = CanModify; }
                field("Only Status Active"; "Only Status Active") { Editable = CanModify; }

            }
        }
    }

    trigger OnOpenPage()

    begin
        CanModify := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.DIS_REAS;

        end;
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.DIS_REAS;

        end;
    end;




    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
        myInt: Integer;





}