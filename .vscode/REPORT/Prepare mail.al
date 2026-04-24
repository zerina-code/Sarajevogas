/*report 50012 "Mail Sending2"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './Mail Sending.rdl';
    Caption = 'Mail Sending';
    ProcessingOnly = false;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

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
            column(TextMsg; FORMAT(Sadrzaj_notifikacije_text))
            {
            }
            column(Attachments; FORMAT(Attachments))
            {
            }
            column(Sender; TemplateMessages."E-mail sender")
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
                    Caption = 'Sadržaj mail-a';
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
        CompInf.get;
        CompanyName2 := 'INFODOM';
    end;

    trigger OnPostReport()
    var
        duzina: Integer;
        duzina1: Integer;
    begin


        IF DIALOG.CONFIRM('Da li želite poslati e-mail notifikaciju?') = TRUE THEN BEGIN
            SMTPSetup.GET;



            //   IF MailCc <> '' THEN
            //     Recipients := MailTo + ';' + MailCc
            //ELSE
            Recipients := MailTo;
            CompInf.get();


            SMTPMail.CreateMessage(CompInf."Sender Name", TemplateMessages."E-mail sender", Recipients, Subject, Sadrzaj_notifikacije_text, TRUE);

            //ĐK   SMTPMail.AddCC(MailCc);
            DocumforOffer.RESET;
            DocumforOffer.SETFILTER("Document No", '%1', Off);
            IF DocumforOffer.FindSet() THEN
                repeat
                    LocationFile := DocumforOffer."Document Name";
                    duzina := strlen(TemporaryPath);
                    CompInf.get();
                    duzina1 := StrLen(CompInf."Path for Documents");

                    if StrPos(LocationFile, TemporaryPath) <> 0 then
                        SMTPMail.AddAttachment(LocationFile, copystr(LocationFile, duzina, StrLen(LocationFile)))
                    else
                        SMTPMail.AddAttachment(LocationFile, copystr(LocationFile, duzina1, StrLen(LocationFile)));

                until DocumforOffer.Next() = 0;

            SMTPMail.Send;
            MESSAGE('Mail notifikacija je uspješno poslana!');

            MailHistory.INIT;

            User.RESET;
            User.SETFILTER("User Name", '%1', USERID);
            IF User.FINDFIRST THEN
                MailHistory."User Name" := User."User Name";

            MailHistory."Sent Date" := TODAY;
            MailHistory."Message Name" := CompanyName2;
            MailHistory."Message Subject" := Subject;
            MailHistory."Message To" := MailTo;
            MailHistory."Message Cc" := MailCc;

            MailHistory."Message Text".CREATEOUTSTREAM(OStream);
            TextMsg.WRITE(OStream);

            MailHistory.INSERT;

            AttachmentHistory.RESET;
            IF AttachmentHistory.FINDLAST THEN
                brojac := AttachmentHistory."No." + 1
            ELSE
                brojac := 1;

            MailHistory.RESET;
            IF MailHistory.FINDLAST THEN BEGIN
                i := 1;
                WHILE i < 10 DO BEGIN
                    IF filenames[i] <> '' THEN BEGIN
                        AttachmentHistory.INIT;
                        AttachmentHistory."No." := brojac;
                        AttachmentHistory.Attachment := filenames[i];
                        AttachmentHistory."Mail ID" := MailHistory."No.";
                        AttachmentHistory.INSERT;
                        brojac := brojac + 1;
                    END;
                    i += 1;
                END;

            END;
        END;

        Attachment.Reset();
        Attachment.SetFilter("File Extension", '%1', '');
        if Attachment.FindFirst() then
            Attachment.DeleteAll();

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




                ToAdressess := TemplateMessages."E-mail receiver";
                CCAdressess := TemplateMessages.MailCC;
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
