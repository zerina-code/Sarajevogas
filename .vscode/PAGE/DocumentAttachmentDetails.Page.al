page 50142 "Document Att. Det. FactBox"
{
    Caption = 'Attached Documents';
    //DelayedInsert = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Document Attachment";
    RefreshOnActivate = true;
    SourceTableView = SORTING(ID, "Table ID");
    ModifyAllowed = true;
    InsertAllowed = true;
    DeleteAllowed = true;
    UsageCategory = Lists;
    ApplicationArea = all;



    layout
    {
        area(content)
        {
            repeater(Group)
            {

                field("Mandatory Attachment Type"; Rec."Mandatory Attachment Type")
                {
                    ApplicationArea = All;
                }
                field(Delivered; Rec.Delivered)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        enumO: Enum Option;
                    begin
                        CurrPage.Editable(true);



                        if rec.Delivered = rec.Delivered::Empty then begin
                            rec.Delivered := rec.Delivered::Yes;
                        end
                        else begin
                            if rec.Delivered = rec.Delivered::No then begin
                                rec.Delivered := rec.Delivered::Yes;
                            end
                            else begin
                                rec.Delivered := rec.Delivered::No;
                            end;
                        end;





                        //   Rec.Delivered := not Rec.Delivered;






                        //  rec.Delivered := enumO;

                        Rec.Modify(true);
                    end;
                }
                field("No need"; "No need")
                {
                    ApplicationArea = All;
                    Visible = false;
                    trigger OnDrillDown()
                    var
                        enumO: Enum Option;
                    begin
                        CurrPage.Editable(true);
                        //   Rec.Delivered := not Rec.Delivered;
                        rec."No need" := not rec."No need";


                        //  rec.Delivered := enumO;

                        Rec.Modify(true);
                    end;
                }

                field(Value; Value)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Visible = false;

                }
            }
            field("File Name"; Rec."File Name")
            {
                ApplicationArea = all;
                DrillDown = true;
                Editable = false;
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
            field("File Extension"; Rec."File Extension")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."File Name" := SelectFileTxt;
    end;

    var
        SelectFileTxt: Label 'Select File...';

    procedure UploadFile(DocumentInStream: InStream; FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        OStream: OutStream;
    begin
        Rec.Validate("File Extension", FileManagement.GetExtension(FileName));
        Rec.Validate("File Name", FileManagement.GetFileNameWithoutExtension(FileName));
        Rec.Content.CreateOutStream(OStream);
        CopyStream(OStream, DocumentInStream);
        Rec.User := UserId;
        Rec."Attached Date" := System.CurrentDateTime();
        if not Rec.Insert(false) then
            Rec.Modify(false);

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

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CurrPage.Editable(true);

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CurrPage.Editable(true);

    end;

}

