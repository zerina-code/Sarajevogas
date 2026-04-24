tableextension 50009 "Attachment_Ext" extends Attachment
{
    fields
    {
        // Add changes to table fields here
        field(18; "File Name"; Text[500])
        {
            Caption = 'File Name';
            //sta sada
        }
    }

    var
        myInt: Integer;
        RMSetup: Record "Marketing Setup";
        Text002: Label 'The attachment is empty.';
        Text003: Label 'Attachment is already in use on this machine.';
        Broj2: Integer;
        Emp1: Code[20];
        NoECL1: Integer;
        FileName: Text[1000];
        FileMgt: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        FileExt: Text[250];
        Att: Record Attachment;

    procedure OpenAttachmentFilenameAndExportToServerFile(Caption: Text[260]; IsTemporary: Boolean; LanguageCode: Code[10]; ExportFile: Text[400]) file_name: Text[250]
    var
        WordManagement: Codeunit "WordManagement";
        FileName: Text;
    begin
        IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN

        END;

        FileName := ConstFilename;
        IF NOT DeleteFile(FileName) THEN
            ERROR(Text003);

        IF EXISTS(ExportFile) THEN
            ERASE(ExportFile);

        ExportAttachmentToServerFile(ExportFile);

        file_name := ExportFile;
    end;

    procedure DeleteFile(FileName: Text): Boolean
    var
        I: Integer;
        FileMgt: Codeunit "File Management";
    begin
        IF FileName = '' THEN
            EXIT(FALSE);

        IF NOT FileMgt.ClientFileExists(FileName) THEN
            EXIT(TRUE);

        REPEAT
            SLEEP(250);
            I := I + 1;
        UNTIL FileMgt.DeleteClientFile(FileName) OR (I = 25);
        EXIT(NOT FileMgt.ClientFileExists(FileName));
    end;

    procedure SetParam(Emp: Code[20]; NoECL: Integer; Broj: Integer)
    begin
        Broj2 := Broj;
        Emp1 := Emp;
        NoECL1 := NoECL;

    end;

    procedure ImportTemporaryAttachmentFromClientFile2(ImportFromFile: Text): Boolean
    var
        AttachmentTable: Record Attachment;
    begin
        //ĐK FileName := FileMgt.BLOBImport(TempBlob, ImportFromFile);

        FileName := FileMgt.BLOBImport(TempBlob, ImportFromFile);

        if FileName <> '' then begin
            SetAttachmentFileFromBlob(TempBlob);
            "Storage Type" := "Storage Type"::Embedded;
            "Storage Pointer" := '';
            "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(FileName)), 1, 250);
            exit(true);
        end;

        EXIT(FALSE);

    end;

    procedure ImportAttachmentFromClientFile2(ImportFromFile: Text; IsTemporary: Boolean; IsInherited: Boolean): Boolean
    var
        NewAttachmentNo: Integer;
        AttachmentMgt: Codeunit AttachmentManagement;
        ServerFileName: Text[1000];
        Text006: Label 'Import Attachment';
        Text007: Label 'All Files (*.*)|*.*';
        Text008: Label 'Error during copying file: %1.';
        CompIn: Record "Company Information";
    begin
        IF IsTemporary THEN
            EXIT(ImportTemporaryAttachmentFromClientFile2(ImportFromFile));

        TESTFIELD("Read Only", FALSE);
        RMSetup.GET;
        IF RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::"Disk File" THEN
            RMSetup.TESTFIELD("Attachment Storage Location");

        IF IsInherited THEN BEGIN
            NewAttachmentNo := AttachmentMgt.InsertAttachment("No.");
            GET(NewAttachmentNo);
        END ELSE
            IF "No." = 0 THEN
                NewAttachmentNo := AttachmentMgt.InsertAttachment(0)
            ELSE
                NewAttachmentNo := "No.";
        GET(NewAttachmentNo);

        IF Broj2 = 1 THEN BEGIN
            ServerFileName := TEMPORARYPATH;
            //Đk  ServerFileName := CompIn."Path for Documents";
            FileName := ImportFromFile;

            IF NOT UPLOAD(Text006, '', Text007, FileName, ServerFileName) THEN
                ERROR(Text008, GETLASTERRORTEXT);

            EXIT(ImportAttachmentFromServerFile2(ServerFileName, FALSE, TRUE));

        END
        ELSE BEGIN
            ServerFileName := TEMPORARYPATH;
            FileName := ImportFromFile;
            EXIT(ImportAttachmentFromServerFile2(FileName, FALSE, TRUE));

        END;

    end;

    procedure ImportAttachmentFromServerFile2(ImportFromFile: Text; IsTemporary: Boolean; Overwrite: Boolean): Boolean
    begin
        IF IsTemporary THEN BEGIN
            ImportTemporaryAttachmentFromServerFile2(ImportFromFile);
            EXIT(TRUE);
        END;

        IF NOT Overwrite THEN
            TESTFIELD("Read Only", FALSE);

        RMSetup.GET;
        IF RMSetup."Attachment Storage Type" = RMSetup."Attachment Storage Type"::"Disk File" THEN
            RMSetup.TESTFIELD("Attachment Storage Location");

        CASE RMSetup."Attachment Storage Type" OF
            RMSetup."Attachment Storage Type"::Embedded:
                BEGIN
                    FileMgt.BLOBImportFromServerFile(TempBlob, ImportFromFile); // Copy from file on server (UNC location also)
                    SetAttachmentFileFromBlob(TempBlob);
                    "Storage Type" := "Storage Type"::Embedded;
                    "Storage Pointer" := '';
                    FileExt := CopyStr(FileMgt.GetExtension(ImportFromFile), 1, 250);
                    if FileExt <> '' then
                        "File Extension" := FileExt;
                    Modify(true);
                    exit(true);
                END;
            "Storage Type"::"Disk File":
                BEGIN
                    "Storage Type" := "Storage Type"::"Disk File";
                    "Storage Pointer" := RMSetup."Attachment Storage Location";
                    "File Extension" := COPYSTR(FileMgt.GetExtension(ImportFromFile), 1, 250);
                    FileMgt.CopyServerFile(ImportFromFile, ConstDiskFileName, Overwrite); // Copy from UNC location to another UNC location
                    MODIFY(TRUE);
                    EXIT(TRUE);
                END;
        END;

        EXIT(TRUE);

    end;

    procedure ImportTemporaryAttachmentFromServerFile2(ImportFromFile: Text)
    var
        TempBlob: Codeunit "Temp Blob";
    begin
        FileMgt.BLOBImportFromServerFile(TempBlob, ImportFromFile);
        SetAttachmentFileFromBlob(TempBlob);
        "Storage Type" := "Storage Type"::Embedded;
        "Storage Pointer" := '';
        "File Extension" := CopyStr(UpperCase(FileMgt.GetExtension(ImportFromFile)), 1, 250);
    end;

}
