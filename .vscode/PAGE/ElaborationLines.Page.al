page 50088 "Elaboration Lines"
{
    Caption = 'Elaboration Lines';
    PageType = List;
    SourceTable = Elaboration;
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
                field("Elaboration Code"; Rec."Elaboration Code")
                {
                    ApplicationArea = All;
                }
                field(Caption; Rec.Caption)
                {
                    ApplicationArea = All;
                }
                field("Connection"; Connection)
                {
                    ApplicationArea = All;
                }

                field("Recording Method"; Rec."Recording Method")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("ZIK Date"; Rec."ZIK Date")
                {
                    ApplicationArea = All;
                }
                field("GIS Date"; Rec."GIS Date")
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
                field("Elaboration Registry Code"; Rec."Elaboration Registry Code")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Executor"; Executor)
                {
                    ApplicationArea = All;
                }

                field("List of drafts"; "List of drafts")
                {
                    ApplicationArea = All;
                    //nacin 1 gdje se odabere vise skica i sve su prikazane u polju
                    /*      trigger OnLookup(var Text: Text): Boolean
                          var
                              SketchListPage: Page "Sketch Lines";
                              SelectedSketches: Text[1000];
                          begin
                              SketchListPage.LookupMode(true);

                              if SketchListPage.RunModal() = Action::LookupOK then begin

                                  SelectedSketches := SketchListPage.GetSelectionFilter();
                                  Text := SelectedSketches;
                                  exit(true);
                              end else
                                  exit(false);
                          end;*/
                    /*  trigger OnLookup(var Text: Text): Boolean
                      var
                          SketchListPage: Page "Sketch Lines";
                          SelectedSketches: Text[1000];
                          SketchTable: Record Sketch;
                          ElaborationTabel: Record Elaboration;
                      begin



                          SketchListPage.LookupMode(true);

                          //  SketchTable.SetFilter("Document No.", Rec."Document No.");
                          //    SketchListPage.SetRecord(SketchTable);


                          if SketchListPage.RunModal() = Action::LookupOK then begin
                              SelectedSketches := SketchListPage.GetSelectionFilter();
                              Text := SelectedSketches;
                              exit(true);
                          end else
                              exit(false);
                      end;*/
                    //nacin 2 gdje ukoliko se odabere vise skica u polju ce biti prikazan broj odabranih 
                    /*   trigger OnLookup(var Text: Text): Boolean
                       var
                           SketchListPage: Page "Sketch Lines";
                           SelectedSketches: Text[1000];
                           SketchTable: Record Sketch;
                           SketchCount: Integer;
                           TempRec: Record Sketch;
                           SelectedSketch: Text;
                           SketchNo: Text;
                           Selections: List of [Text];
                       begin
                           SketchListPage.LookupMode(true);
                           SketchTable.Reset();
                           SketchTable.SetFilter("Document No.", Rec."Document No.");
                           SketchListPage.SetTableView(SketchTable);


                           if SketchListPage.RunModal() = Action::LookupOK then begin
                               SelectedSketches := SketchListPage.GetSelectedSketches();


                               SketchCount := STRLEN(SelectedSketches) - STRLEN(DELCHR(SelectedSketches, '=', ',')) + 1;

                               Text := FORMAT(SketchCount);
                               exit(true);
                           end else
                               exit(false);
                       end;*/

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SketchListPage: Page "Sketch Lines";
                        SelectedSketches: Text[1000];
                        SketchTable: Record Sketch;
                        SketchCount: Integer;
                        TempRec: Record Sketch;
                        SelectedSketch: Text;
                        SketchNo: Text;
                        Selections: List of [Text];
                        CZKConnection: Record "Service Header";
                        SHOrg: Record "Service Header";
                        CZKFIlter: text;
                    begin
                        SketchListPage.LookupMode(true);
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
                            SketchTable.SetFilter("Document No.", CZKFIlter)
                        else
                            SketchTable.SetFilter("Document No.", Rec."Document No.");

                        SketchListPage.SetTableView(SketchTable);


                        SketchCount := SketchTable.Count;
                        SketchListPage.RunModal();
                        Text := FORMAT(SketchCount);

                        exit(true);
                    end;







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
                field("Document No."; "Document No.") { }
                field("Document Type"; "Document Type") { }
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
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        US.SetFilter(Elaborate, '%1', true);
        if not US.FindFirst() then
            Error('Nije moguće izvršiti pregled, nemate dozvolu za isto!');

        CountV := rec.Count;

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

    var
        ConfirmFileImportQst: Label '%1 already exists. Do you want to override it?';
        ConfirmFileDeletetQst: Label 'Are you sure that you want to delete %1?';
        ImportFileFilter: Label 'All files (*.*)|*.*', Locked = true;
        FileDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';
        CountV: Integer;
}
