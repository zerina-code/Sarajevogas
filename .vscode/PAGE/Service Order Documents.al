page 50096 "Service Order Documents"
{
    Caption = 'Service Order Documents';
    SourceTable = "A-B Attachments";
    SourceTableView = where(Source = filter("Service Order"));

    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(Code; Code) { Visible = false; }
                field("Document No."; "Document No.") { Visible = false; }
                field("Document Type Code"; "Document Type Code")
                {
                    Visible = false;
                }
                field("Document Date"; "Document Date") { }

                field("Document Type"; "Document Type") { }

                field("Real. Process. Empl. No."; "Real. Process. Empl. No.") { }
                field("Real. Process. Empl. Name"; "Real. Process. Empl. Name") { }
                field("Real. Contr. Empl. No."; "Real. Contr. Empl. No.") { }
                field("Real. Contr. Empl. Name"; "Real. Contr. Empl. Name") { }
                field("Real. Verif. Empl. No."; "Real. Verif. Empl. No.") { }
                field("Real. Verif. Empl. Name"; "Real. Verif. Empl. Name") { }

                field("Real. Exe No"; "Real. Exe No") { }
                field("Real. Exe Employee Name"; "Real. Exe Employee Name") { }
                field("Real. Exe Postion Name"; "Real. Exe Postion Name") { }

                field("Attachment No."; "Attachment No." <> 0)
                {

                    ApplicationArea = all;
                    Caption = 'Attachment No.';
                    Visible = false;

                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No." <> 0 THEN
                            OpenAttachment1;

                        CurrPage.UPDATE;
                    end;
                }

                field("Request File Name"; Rec."Request File Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        DownloadFile();
                    end;

                }



            }
        }
    }
    actions
    {
        area(Processing)
        {

            action("Import File")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'Import File', Comment = 'Uvezi datoteku';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ImportFile();
                end;
            }

        }




    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            us."E. Contract type" := 4;
            us.Modify();
        end;

    end;

    var
        tempSaveDest: text[250];

        HRSetup: record "Human Resources Setup";
        ConfirmFileImportQst: Label '%1 already exists. Do you want to override it?';
        ImportFileFilter: Label 'All files (*.*)|*.*', Locked = true;

        FileDownloadQst: Label 'Do you want to download dokument %1?', Comment = 'Da li želite skinuti dokument %1?';

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

    procedure OpenAttachment1()
    var
        Attachment: Record "Attachment";
        crl: Record "Custom Report Layout";
        EC: Record "Employment Contract";
    //ovdje vidjeti ovaj description
    begin
        HRSetup.get;

        ec.reset;
        ec.setfilter(Type, '%1', rec.Type);
        if ec.FindFirst() then begin

            if ec."Custom Report Layout" <> '' then begin
                crl.Reset();
                crl.SetFilter("Report ID", '%1', ec."NAV ID");
                crl.SetFilter(Code, '%1', ec."Custom Report Layout");
                IF CRL.FindFirst() THEN BEGIN

                    tempSaveDest := HRSetup."File Path" + crl.Description + '-' + FORMAT(rec."Document No.") + '.docx';


                    IF "Attachment No." = 0 THEN
                        EXIT;
                    Attachment.GET("Attachment No.");
                    Attachment.OpenAttachment(tempSaveDest, FALSE, '');

                end;
            end;
        end;
    end;
}

