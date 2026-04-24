page 50152 "A-B Attachment"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "A-B Attachments";
    SourceTableView = where(Source = filter("Standard Text"), Type = filter(Customer));


    layout
    {
        area(Content)
        {

            repeater(Group)
            {
                field(Code; Code) { ApplicationArea = all; }

                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        CustomReportLayout: Record "Custom Report Layout";
                        ReportLayoutSelection: Record "Report Layout Selection";
                        CRLPage: Page "Custom Report Layouts";
                        US: record "User Setup";
                        EC: Record "Employment Contract";
                        ECPage: page "Employment Contracts";

                    begin
                        US.reset;
                        US.SetFilter("User ID", '%1', UserId);

                        if us.FindFirst() then begin
                            us."E. Contract type" := 7;
                            us.Modify();
                        end;

                        Commit();
                        clear(ECPage);
                        EC.reset;
                        EC.SetFilter(Type, '%1', ec.Type::"A-B");
                        ECPage.SetTableView(EC);

                        ECPage.LOOKUPMODE(TRUE);
                        IF ECPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            ECPage.GETRECORD(EC);
                            "Document Type" := ec.Description;
                            "Document Type Code" := ec.Code;

                            Commit();

                        end;

                    end;

                }


                field("Document Type Code"; "Document Type Code") { ApplicationArea = all; }
                field(BR; BR) { }
                field("Document Date"; "Document Date") { ApplicationArea = all; }
                field("ZK No."; "ZK No.") { }
                field(KPU; KPU) { }
                field("K.O"; "K.O") { }
                field(Municipality; Municipality) { }
                field("Municipality Name"; "Municipality Name") { }

                field("Notary Name"; "Notary Name") { ApplicationArea = all; }
                field("OPU-IP"; "OPU-IP") { ApplicationArea = all; }

                field("Court Number"; "Court Number") { ApplicationArea = all; }
                field("Decision No."; "Decision No.") { ApplicationArea = all; }
                field(Descendants; Descendants) { }
                field("Previous Customer"; "Previous Customer") { }
                field("JIB Customer"; "JIB Customer") { }
                field("Customer buyer"; "Customer buyer") { }
                field(Dispatch; Dispatch) { }
                field("File Name"; "File Name")
                {
                    ApplicationArea = all;


                    trigger Onvalidate()
                    var
                        myInt: Integer;
                        FilePath: Text;
                        InFileStream: InStream;
                    begin

                        if Rec."File Name" <> 'Odaberite datoteku...' then begin
                            DownloadFile();
                        end
                        else begin


                            if UploadIntoStream('Odaberite fajl...', '', '', FilePath, InFileStream) then
                                UploadFile(InFileStream, FilePath);
                        end;

                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        FilePath: Text;
                        InFileStream: InStream;
                    begin


                        if Rec."File Name" <> 'Odaberite datoteku...' then begin
                            DownloadFile();
                        end
                        else begin


                            if UploadIntoStream('Odaberite fajl...', '', '', FilePath, InFileStream) then
                                UploadFile(InFileStream, FilePath);
                        end;

                    end;
                }
            }


        }
    }



    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
    begin
        if "File Name" = '' then
            "File Name" := 'Odaberite datoteku...';

    end;


    procedure DownloadFile()
    var
        IStream: InStream;
        ExportFileName: Text;
    begin

        ExportFileName := Rec."File Name" + '.' + Rec."File Extension";
        Rec.CalcFields(Content);
        if not Rec.Content.HasValue then
            exit;
        Rec.Content.CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);

    end;

    procedure UploadFile(DocumentInStream: InStream; FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        OStream: OutStream;
    begin
        Rec.Validate("File Extension", FileManagement.GetExtension(FileName));
        Rec.Validate("File Name", FileManagement.GetFileNameWithoutExtension(FileName));
        Rec.Content.CreateOutStream(OStream);
        CopyStream(OStream, DocumentInStream);
        // Rec.User := UserId;
        //Rec."Attached Date" := System.CurrentDateTime();
        if not Rec.Insert(false) then
            Rec.Modify(false);

    end;

    var
        myInt: Integer;
}