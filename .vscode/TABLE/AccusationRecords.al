pageextension 50201 "AccusationRecords" extends Territories
{

    layout
    {
        addbefore(Name)
        {
            field(Type; Type)
            {
                ApplicationArea = All;
                Visible = false;
                Editable = false;
            }
        }
        addafter(Name)
        {
            field(Date; Date) { ApplicationArea = All; }
            field(Accusation; Accusation) { ApplicationArea = All; Editable = false; Visible = false; }
            field("Accusation Type"; "Accusation Type") { ApplicationArea = All; Visible = accType; }
            field(Status; Status) { ApplicationArea = All; Visible = accStatus_1; }
            field(Status_2; Status_2) { ApplicationArea = All; Visible = accStatus_2; }
            field(Status_3; Status_3) { ApplicationArea = All; Visible = accStatus_3; }
            field(MALS; MALS) { ApplicationArea = All; Visible = malsVisible; }
            field(IP; IP) { ApplicationArea = All; Visible = ipVisible; }
            field("Date of Next Trial"; "Date of Next Trial")
            {
                ApplicationArea = All;
                Visible = hearing;
                trigger OnValidate()
                var
                    us: Record "User Setup";
                begin
                    us.SetFilter("User ID", '%1', UserId);
                    if us.FindFirst() then begin

                        acc.SetFilter("No.", '%1', us."Accusation No.");
                        if acc.FindFirst() then begin
                            acc."Date of Accusation" := "Date of Next Trial";
                            acc.Modify();
                        end;
                    end;
                end;
            }
            field(Note; Note) { ApplicationArea = All; }

        }
        modify(Code)
        {
            Visible = false;
        }
        modify(Name)
        {
            Visible = false;
        }
    }

    var
        accStatus: boolean;
        accStatus_2: Boolean;
        accStatus_3: Boolean;
        accStatus_1: Boolean;
        acc: Record "Accusation Header";
        malsVisible: Boolean;
        accType: boolean;
        ipVisible: Boolean;
        hearing: boolean;

    trigger OnOpenPage()
    var
        us: Record "User Setup";
    begin
        accStatus_3 := false;
        accStatus_2 := false;
        accStatus_1 := false;


        us.reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Accusation Record" = AccusationRecordType::"Accusation Status" then begin
                if (us."Accusation Type" = us."Accusation Type"::"Criminal proceedings") then
                    accStatus_3 := true;

                if (us."Accusation Type" = us."Accusation Type"::"Executive Procedure") then
                    accStatus_2 := true;

                if (accStatus_2 = false) and (accStatus_3 = false) then accStatus_1 := true;
                //1 - parn
                //izv
                //kriv

                accStatus := true;
                accType := false;
                malsVisible := false;
                ipVisible := false;
                hearing := false;
            end else
                if us."Accusation Record" = AccusationRecordType::"Accusation Type" then begin
                    accStatus := false;
                    accType := true;
                    malsVisible := false;
                    ipVisible := false;
                    hearing := false;
                end
                else
                    if us."Accusation Record" = AccusationRecordType::"MALS" then begin
                        accStatus := false;
                        accType := false;
                        malsVisible := true;
                        ipVIsible := false;
                        hearing := false;
                    end
                    else
                        if us."Accusation Record" = AccusationRecordType::"IP" then begin
                            accStatus := false;
                            accType := false;
                            malsVisible := false;
                            ipVIsible := true;
                            hearing := false;
                        end
                        else
                            if us."Accusation Record" = AccusationRecordType::"Trial" then begin
                                accStatus := false;
                                accType := false;
                                malsVisible := false;
                                ipVIsible := false;
                                hearing := true;
                            end
                            else begin
                                accStatus := false;
                                accType := false;
                                malsVisible := false;
                                ipVisible := false;
                                hearing := false;
                            end;
        end;
    end;


    trigger OnAfterGetRecord()
    var
        us: Record "User Setup";
    begin
        accStatus_3 := false;
        accStatus_2 := false;
        accStatus_1 := False;
        us.reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Accusation Record" = AccusationRecordType::"Accusation Status" then begin
                if (us."Accusation Type" = us."Accusation Type"::"Criminal proceedings") then
                    accStatus_3 := true;

                if (us."Accusation Type" = us."Accusation Type"::"Executive Procedure") then
                    accStatus_2 := true;

                if (accStatus_2 = false) and (accStatus_3 = false) then accStatus_1 := true;
                //1 - parn
                //izv
                //kriv

                accStatus := true;
                accType := false;
                malsVisible := false;
                ipVisible := false;
                hearing := false;
            end else
                if us."Accusation Record" = AccusationRecordType::"Accusation Type" then begin
                    accStatus := false;
                    accType := true;
                    malsVisible := false;
                    ipVisible := false;
                    hearing := false;
                end
                else
                    if us."Accusation Record" = AccusationRecordType::"MALS" then begin
                        accStatus := false;
                        accType := false;
                        malsVisible := true;
                        ipVIsible := false;
                        hearing := false;
                    end
                    else
                        if us."Accusation Record" = AccusationRecordType::"IP" then begin
                            accStatus := false;
                            accType := false;
                            malsVisible := false;
                            ipVIsible := true;
                            hearing := false;
                        end
                        else
                            if us."Accusation Record" = AccusationRecordType::"Trial" then begin
                                accStatus := false;
                                accType := false;
                                malsVisible := false;
                                ipVIsible := false;
                                hearing := true;
                            end
                            else begin
                                accStatus := false;
                                accType := false;
                                malsVisible := false;
                                ipVisible := false;
                                hearing := false;
                            end;
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        gls: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        us: Record "User Setup";

    begin
        gls.get();
        if gls.findfirst then begin
            Rec.Code := NoSeriesMgt.GetNextNo(gls."Accusation Record Entry Series", TODAY, true);
            Rec.Date := Today();
        end;
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Rec.Type := us."Accusation Record";
            Rec.Accusation := us."Accusation No.";
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean

    //   trigger OnNewRecord(BelowxRec: Boolean)
    var
    begin
        InitNewLine();
    end;


    local procedure InitNewLine()
    var
        acc: Record Territory;
        us: Record "User Setup";
        gls: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;


    begin
        gls.Get();
        if gls.FindFirst() then begin
            us.SetFilter("User ID", '%1', UserId);
            if us.FindFirst() then begin


                if us."Accusation Record" = AccusationRecordType::"Accusation Type" then begin
                    Rec."Document No." := NoSeriesMgt.GetNextNo(gls."Type Entry Series", TODAY, true);
                    Rec.Type := AccusationRecordType::"Accusation Type";

                end else
                    if us."Accusation Record" = AccusationRecordType::"Accusation Status" then begin
                        Rec."Document No." := NoSeriesMgt.GetNextNo(gls."Status Entry Series", TODAY, true);
                    end
                    else
                        if us."Accusation Record" = AccusationRecordType::"MALS" then begin
                            Rec."Document No." := NoSeriesMgt.GetNextNo(gls."Court Number Entry Series", TODAY, true);
                        end
                        else
                            if us."Accusation Record" = AccusationRecordType::"Trial" then begin
                                Rec."Document No." := NoSeriesMgt.GetNextNo(gls."Hearing Entry Series", TODAY, true);
                            end
                            else
                                if us."Accusation Record" = AccusationRecordType::"History" then begin
                                    Rec."Document No." := NoSeriesMgt.GetNextNo(gls."History Entry Series", TODAY, true);
                                end;
            end;
        end;
    end;
}