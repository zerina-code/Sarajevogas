page 50077 "Sketch Lines"
{
    Caption = 'Sketch Lines';
    PageType = List;
    SourceTable = Sketch;
    //UsageCategory = None;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    // AutoSplitKey = true;
    AutoSplitKey = false;
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            field(CountV; CountV)
            {

                Caption = 'Count';
                Style = Unfavorable;
            }
            repeater(General)
            {
                field("Sketch Registry Code"; Rec."Sketch Registry Code")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Elaboration Line No."; "Elaboration Line No.")
                {
                    ApplicationArea = All;
                }
                field("Sketch Code"; Rec."Sketch Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Caption; Rec.Caption)
                {
                    ApplicationArea = All;
                }
                field("Date"; Rec."Date")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                }
                field("Street Name"; Rec."Street Name")
                {
                    ApplicationArea = All;
                }
                field("Street No."; Rec."Street No.")
                {
                    ApplicationArea = All;
                }
                field("Municipality Code"; Rec."Municipality Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Municipality Name"; Rec."Municipality Name")
                {
                    ApplicationArea = All;
                }
                field("MZ"; Rec.MZ)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("MZ Name"; Rec."MZ Name")
                {
                    ApplicationArea = All;
                }
                field("Detail List"; Rec."Detail List")
                {
                    ApplicationArea = All;
                }
                field(Measure; Rec.Measure)
                {
                    ApplicationArea = All;
                }



                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Request File Name"; Rec."Request File Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadFile();
                    end;

                }
                field("Document Type"; "Document Type") { }
                field("Document No."; "Document No.") { }

                field("Status"; Status) { }
            }


        }


    }

    actions
    {
        area(Processing)
        {

            Group(FileAttachment)
            {
                Caption = 'File Attachment', Comment = 'Priložak';

                action("Import File")
                {
                    ApplicationArea = All;

                    Caption = 'Import File', Comment = 'Uvezi datoteku';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        ImportFile();
                    end;
                }
                action("Remove File")
                {
                    ApplicationArea = All;

                    Caption = 'Remove File', Comment = 'Ukloni datoteku';
                    Image = Delete;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        DeleteFile();
                    end;
                }
            }
        }


    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";
        docNo: Code[20];
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        US.SetFilter(Elaborate, '%1', true);
        if not US.FindFirst() then
            Error('Nije moguće izvršiti pregled, nemate dozvolu za isto!');

        CountV := rec.Count;

        CZKFIlter := '';
        SketchTable.Reset();
        SHOrg.Reset();
        SHOrg.SetFilter("No.", '%1', rec."Document No.");
        if SHOrg.FindFirst() then begin
            if SHOrg."CZK Request No." <> '' then begin
                CZKConnection.Reset();
                CZKConnection.SetFilter("CZK Request No.", '%1', SHOrg."CZK Request No.");
                if CZKConnection.FindSet() then
                    repeat

                        if StrPos(CZKFIlter, CZKConnection."No.") = 0 then
                            CZKFIlter += CZKConnection."No." + '|';
                    until CZKConnection.Next() = 0;
                if StrLen(CZKFIlter) > 2 then
                    CZKFIlter := CopyStr(CZKFIlter, 1, StrLen(CZKFIlter) - 1);

            end;
        end;


        if CZKFIlter <> '' then
            setfilter("Document FIlters", CZKFIlter)
        else
            setfilter("Document FIlters", Rec."Document No.");



    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CountV := rec.Count;

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        CountV := rec.Count;

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        US.SetFilter(Elaborate, '%1', true);
        if not US.FindFirst() then
            Error('Nije moguće izvršiti pregled, nemate dozvolu za isto!');

        CZKFIlter := '';
        SketchTable.Reset();
        SHOrg.Reset();
        SHOrg.SetFilter("No.", '%1', rec."Document No.");
        if SHOrg.FindFirst() then begin
            if SHOrg."CZK Request No." <> '' then begin
                CZKConnection.Reset();
                CZKConnection.SetFilter("CZK Request No.", '%1', SHOrg."CZK Request No.");
                if CZKConnection.FindSet() then
                    repeat

                        if StrPos(CZKFIlter, CZKConnection."No.") = 0 then
                            CZKFIlter += CZKConnection."No." + '|';
                    until CZKConnection.Next() = 0;
                if StrLen(CZKFIlter) > 2 then
                    CZKFIlter := CopyStr(CZKFIlter, 1, StrLen(CZKFIlter) - 1);

            end;
        end;


        if CZKFIlter <> '' then
            SetFilter("Document FIlters", CZKFIlter)
        else
            SetFilter("Document FIlters", Rec."Document No.");
    end;

    local procedure ImportFile()
    var
        ConfirmAction: Boolean;
        OutStr: OutStream;
        InStr: InStream;
    begin
        ConfirmAction := true;
        Rec.CalcFields("Request File");
        if Rec."Request File".HasValue then
            ConfirmAction := Confirm(StrSubstNo(ConfirmFileImportQst, Rec.FieldCaption("Request File")), false);

        if not ConfirmAction then
            exit;

        UploadIntoStream('', '', ImportFileFilter, Rec."Request File Name", InStr);
        if Rec."Request File Name" = '' then
            exit;

        Rec."Request File".CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        CurrPage.Update(true);
    end;

    local procedure DownloadFile()
    var
        InStr: InStream;
    begin
        Rec.CalcFields("Request File");
        if not Rec."Request File".HasValue then
            exit;

        if not Confirm(StrSubstNo(FileDownloadQst, Rec."Request File Name"), false) then
            exit;

        Rec."Request File".CreateInStream(InStr);
        DownloadFromStream(InStr, '', '', ImportFileFilter, Rec."Request File Name");
    end;

    local procedure DeleteFile()
    begin
        Rec.CalcFields("Request File");
        if not Rec."Request File".HasValue then
            exit;
        if not Confirm(StrSubstNo(ConfirmFileDeletetQst, Rec."Request File Name"), false) then
            exit;
        Clear(Rec."Request File");
        Rec."Request File Name" := '';
        CurrPage.Update(true);
    end;

    /* procedure GetSelectionFilter(): Text[1000]
     var
         SketchRec: Record Sketch;
         SelectedSketches: Text[1000];
     begin
         CurrPage.SetSelectionFilter(SketchRec);

         if SketchRec.FindSet() then begin
             repeat
                 if SelectedSketches = '' then
                     SelectedSketches := SketchRec."Sketch Code"
                 else
                     SelectedSketches += ',' + SketchRec."Sketch Code";
             until SketchRec.Next() = 0;
         end;

         exit(SelectedSketches);
     end;

     procedure GetSelectedSketches(): Text;
     var
         SelectedRec: Record Sketch;
         SelectedFilter: Text;
     begin
         CurrPage.SetSelectionFilter(SelectedRec); // Postavlja filter za selektovane zapise

         if SelectedRec.FindSet() then
             repeat
                 if SelectedFilter = '' then
                     SelectedFilter := SelectedRec."Sketch Code"
                 else
                     SelectedFilter := SelectedFilter + ',' + SelectedRec."Sketch Code";
             until SelectedRec.Next() = 0;

         exit(SelectedFilter); // Vraća listu odabranih skica kao string
     end;*/



    var
        ConfirmFileImportQst: Label '%1 already exists. Do you want to override it?';
        ConfirmFileDeletetQst: Label 'Are you sure that you want to delete %1?';
        ImportFileFilter: Label 'All files (*.*)|*.*', Locked = true;
        FileDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';
        CountV: Integer;
        CZKFIlter: text;
        SketchTable: Record Elaboration;
        SHOrg: Record "Service Header";
        CZKConnection: Record "Service Header";
}

