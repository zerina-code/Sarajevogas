/*report 50080 "Mail Sending"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Mail Sending.rdl';
    Caption = 'Mail Sending';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
            column(Name; DataItem1.Name)
            {
            }
            column(SLika; DataItem1.Picture)
            {

            }

            column(MailTo; MailTo)
            {
            }
            column(MailCc; MailCc)
            {
            }
            column(Subject; Subject)
            {
            }
            column(CompanyName2; CompanyName2)
            {
            }
            column(TextMsg; FORMAT(TextMsg))
            {
            }
            column(Attachments; FORMAT(Attachments))
            {
            }
            column(Sender; Sender)
            {

            }
            trigger OnAfterGetRecord()
            var
                SalesHeader: Record "Sales Header";
                templateM: Record Template_Message;
            begin


                SalesHeader.Reset();
                SalesHeader.SetFilter("No.", '%1', Off);
                if SalesHeader.FindFirst() then begin
                    templateM.Reset();
                    templateM.SetFilter("Message Code", '%1', SalesHeader."Message Code");
                    templateM.SetFilter("Type", '%1', templateM.Type::"Mail notification");
                    if templateM.FindFirst() then begin

                        templateM.CALCFIELDS("Message Text");

                        templateM."Message Text".CREATEINSTREAM(IStream);
                        SadrzajNotifikacije.Read(IStream);

                        SadrzajNotifikacije.GETSUBTEXT(Sadrzaj_notifikacije_text, Pos, 10000);

                        Sadrzaj_notifikacije_text := ReplaceString(Sadrzaj_notifikacije_text, '@HD_broj', SalesHeader."HD Number");



                    end;

                end;


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Notifications';
                    field(Notification; Notification)
                    {
                        Caption = 'Type';
                        TableRelation = Template_Message."Message Code";
                        Visible = true;

                        trigger OnValidate()
                        var
                            OrderConf: Report "Order Confirmation new";
                            CRRep: Report CR;
                            CRL: Record "Custom Report Selection";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            tempSaveDest: Text[1000];
                            SalesHeader: Record "Sales Header";
                        begin

                        end;
                    }
                    field(MailTo; MailTo)
                    {
                        Caption = 'To';
                    }
                    field(MailCc; MailCc)
                    {
                        Caption = 'Cc';
                    }
                    field(Name; CompanyName2)
                    {
                        Caption = 'Name';
                    }
                    field(Subject; Subject)
                    {
                        Caption = 'Subject';
                    }
                }
                group("L")
                {
                    field(TextMsg; TextMsg)
                    {
                        Caption = 'TextMsg';
                        MultiLine = true;

                        trigger OnValidate()
                        begin



                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CompanyName2 := 'INFODOM';
    end;

    trigger OnPostReport()
    var
        duzina: Integer;
        duzina1: Integer;
    begin

        Message('Dokumenti su kreirani, Molim Vas da iste provjerite!');

 

    end;

    trigger OnPreReport()
    var
        Naziv: Text[1000];
    begin
        Pos := 1;


        DocumforOffer.RESET;
        DocumforOffer.SETFILTER("Document No", '%1', Off);
        IF DocumforOffer.FindSet() THEN
            repeat

                Attachments.ADDTEXT(DocumforOffer."Document Name" + '; ')
until DocumforOffer.Next() = 0;

    end;

    var
        AttachmentList: array[10] of Integer;
        CompInf: Record "Company Information";
        pos: Integer;

        filenames: array[10] of Text;
        Sadrzaj_notifikacije_text: Text[2048];

        AttachmentNumber: Integer;
        Off: Code[20];
        Sender: Text[1000];
        Vers: Integer;
        i: Integer;
        Attachment: Record Attachment;
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "Mail Management";
        FileManagement: Codeunit "File Management";
        ExportFile: Text;
        DocumforOffer: Record Documents;
        Subject: Text;
        Body: BigText;
        ToAdressess: Text;
        CCAdressess: Text;
        BccAdressess: Text;
        Notification: Text[30];
        TemplateMessages: Record Template_Message;
        IStream: InStream;
        ServiceHeader: Record "Sales Header";
        Customer: Record Customer;
        User: Record User;

        MailTo: Text;
        MailCc: Text;
        TextMsg: BigText;
        AttachmentNameList: array[10] of Text;
        Attachments: BigText;
        CompanyName2: Text;
        MailHistory: Record "Mail History";
        SadrzajNotifikacije: BigText;
        OStream: OutStream;
        AttachmentHistory: Record "Attachment History";
        brojac: Integer;
        LocationFile: Text;
        NameFile: Text;
        Recipients: Text;

    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO

            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure ImportAttachment(CR: Boolean) AttNo: integer

    var
        Naziv: Text;
        Attachment: Record Attachment;
        SalesH: Record "Sales Header";
    begin

        if DocumforOffer."Attachment No" <> 0 then begin
            IF Attachment.GET(DocumforOffer."Attachment No") THEN
                Attachment.TESTFIELD("Read Only", FALSE);
        END;




        Attachment.SetParam(Off, 1, 2);
        CompInf.get();
        SalesH.Reset();
        SalesH.SetFilter("No.", '%1', Off);
        if SalesH.FindFirst() then begin

        end;

        CompInf.get();

        if CR = true then
            Naziv := CompInf."Universal Value for CR"
        else
            Naziv := CompInf."Universal Value for OC";
        IF Attachment.ImportAttachmentFromClientFile2(CompInf."Path for Documents" + Naziv + SalesH."HD Number" + '.pdf', FALSE, FALSE)

       THEN BEGIN

        END;

        CompInf.get();
        //ĐK     IF EXISTS(CompInf."Path for Documents" + Naziv + SalesH."HD Number" + '.pdf') THEN
        //ĐK     ERASE(CompInf."Path for Documents" + Naziv + SalesH."HD Number" + '.pdf');
        exit(Attachment."No.")

    end;

    procedure SetParam(Attachments: array[10] of Integer; AttachmentsName: array[10] of Text; "Offer Code": Code[20]; "Offer Version": Integer; "Message Code": Text[30]; FileLocation: Text; FileName: Text; MessageCode: text[30])
    var
        i: Integer;
        TemplaT: Record Template_Message;
        AttachmentManagement: Codeunit AttachmentManagement;
        Sales: Record "Sales Header";
        CRL: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        CRReport: Report CR;
        OrderConf: Report "Order Confirmation new";
        tempSaveDest: Text[1000];
        NewAttachNo: Integer;
        Documentt: record Documents;

    begin
        //max 10 priloga
        i := 1;
        WHILE i < 10 DO BEGIN
            AttachmentList[i] := Attachments[i];
            AttachmentNameList[i] := AttachmentsName[i];
            i += 1;
        END;
        Off := "Offer Code";
        Vers := "Offer Version";
        LocationFile := FileLocation;
        NameFile := FileName;
        Sales.SetFilter("No.", '%1', Off);
        if Sales.FindFirst() then begin
        end;

        IF MessageCode <> '' THEN BEGIN
            Notification := MessageCode;
            TemplateMessages.RESET;
            TemplateMessages.SETFILTER("Message Code", '%1', MessageCode);
            TemplateMessages.SetFilter(Type, '%1', TemplateMessages.Type::"Mail notification");
            TemplateMessages.SetFilter("Document No.", '%1', Off);

            IF TemplateMessages.FINDFIRST THEN BEGIN

                //Da probam samo send mail  
                Sales.Reset();
                Sales.SetFilter("No.", '%1', Off);
                if Sales.FindFirst() then begin

                    if Sales."CR included" = true then begin


                        DocumforOffer.Reset();
                        DocumforOffer.SetFilter(CR, '%1', true);
                        DocumforOffer.SetFilter("Document No", '%1', Off);
                        if DocumforOffer.FindFirst() then begin
                            DocumforOffer.Delete();
                            CompInf.get();
                            tempSaveDest := CompInf."Path for Documents" + CompInf."Universal Value for CR" + Sales."HD Number" + '.pdf';
                            IF EXISTS(tempSaveDest) THEN
                                ERASE(tempSaveDest);
                        end;

                        Clear(CRReport);
                        CRL.RESET;
                        CRL.SETFILTER("Report ID", '%1', 50081);
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);
                            CRReport.SetTableView(Sales);
                            CompInf.get();
                            tempSaveDest := CompInf."Path for Documents" + CompInf."Universal Value for CR" + Sales."HD Number" + '.pdf';
                            CRReport.SaveAsPdf(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            DocumforOffer.Init();
                            DocumforOffer."Document No" := Off;
                            DocumforOffer."Attachment No" := 0;
                            DocumforOffer."Document Name" := tempSaveDest;

                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment(DocumforOffer."Attachment No");
                        IF NewAttachNo <> 0 THEN BEGIN
                            DocumforOffer."Attachment No" := NewAttachNo;
                            COMMIT;
                        END;



                        DocumforOffer."Attachment No" := ImportAttachment(true);
                        DocumforOffer.CR := true;
                        Commit();

                        Documentt.Reset();
                        Documentt.SetCurrentKey(ID_New);
                        Documentt.Ascending;
                        if Documentt.FindLast() then
                            DocumforOffer.ID_New := Documentt.ID_New + 1
                        else
                            DocumforOffer.ID_New := 1;


                        DocumforOffer.Insert();

                        Commit();
                    END;

                    //ako ima print confirmation
                    if TemplateMessages."Print Confirmation" = true then begin

                        DocumforOffer.Reset();
                        DocumforOffer.SetFilter("Print confirmation", '%1', true);
                        DocumforOffer.SetFilter("Document No", '%1', Off);
                        if DocumforOffer.FindFirst() then begin
                            DocumforOffer.Delete();
                            tempSaveDest := CompInf."Path for Documents" + CompInf."Universal Value for OC" + Sales."HD Number" + '.pdf';
                            IF EXISTS(tempSaveDest) THEN
                                ERASE(tempSaveDest);

                        end;
                        Clear(OrderConf);
                        CRL.RESET;
                        CRL.SETFILTER("Report ID", '%1', 50099);
                        IF CRL.FINDLAST THEN BEGIN
                            ReportLayoutSelection.SetTempLayoutSelected(CRL.Code);
                            OrderConf.SetTableView(Sales);
                            CompInf.get();
                            tempSaveDest := CompInf."Path for Documents" + CompInf."Universal Value for OC" + Sales."HD Number" + '.pdf';

                            OrderConf.SaveAsPdf(tempSaveDest);
                            FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                            DocumforOffer.Init();
                            DocumforOffer."Document No" := Off;
                            DocumforOffer."Document Name" := tempSaveDest;

                            DocumforOffer."Attachment No" := 0;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment(DocumforOffer."Attachment No");
                        IF NewAttachNo <> 0 THEN BEGIN
                            DocumforOffer."Attachment No" := NewAttachNo;
                            COMMIT;
                        END;


                        DocumforOffer."Attachment No" := ImportAttachment(false);
                        DocumforOffer."Print Confirmation" := true;
                        Commit();
                        Documentt.Reset();
                        Documentt.SetCurrentKey(ID_New);
                        Documentt.Ascending;
                        if Documentt.FindLast() then
                            DocumforOffer.ID_New := Documentt.ID_New + 1
                        else
                            DocumforOffer.ID_New := 1;

                        DocumforOffer.Insert();


                        Commit();
                    END;

                end;



                ToAdressess := '';
                CCAdressess := TemplateMessages."E-mail receiver";
                BccAdressess := '';
                Subject := ReplaceString(TemplateMessages."Message Subject", '@HD_broj', Sales."HD Number");



                MailTo := ToAdressess;
                MailCc := CCAdressess;

                TemplateMessages.CALCFIELDS("Message Text");
                TemplateMessages."Message Text".CREATEINSTREAM(IStream);
                TextMsg.READ(IStream);

            END ELSE BEGIN
                MailTo := '';
                MailCc := '';
                Subject := '';
                CLEAR(TextMsg);
            END;

        END;
    end;
}
*/