report 50192 "Send Mails"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItemName; "A-B Attachments")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                templateM.Reset();
                templateM.SetFilter("Message Code", '%1', MessageC);
                templateM.SetFilter("Type", '%1', templateM.Type::"Mail notification");
                if templateM.FindFirst() then begin

                    templateM.CALCFIELDS("Message Text");

                    templateM."Message Text".CREATEINSTREAM(IStream);
                    SadrzajNotifikacije.Read(IStream);

                    SadrzajNotifikacije.GETSUBTEXT(Sadrzaj_notifikacije_text, Pos, 10000);

                    Sadrzaj_notifikacije_text := ReplaceString(Sadrzaj_notifikacije_text, '@CustomerName', Customer.Name);
                    CompInf.get;

                    SMTPMail.CreateMessage(CompInf."Sender Name", TemplateMessages."E-mail sender", Customer."E-Mail", templateM."Message Subject", Sadrzaj_notifikacije_text, TRUE);


                    LocationFile := "Request File Name";
                    duzina := strlen(TemporaryPath);
                    CompInf.get();
                    duzina1 := StrLen(CompInf."Path for Documents");

                    if StrPos(LocationFile, TemporaryPath) <> 0 then
                        SMTPMail.AddAttachment(LocationFile, copystr(LocationFile, duzina, StrLen(LocationFile)))
                    else
                        SMTPMail.AddAttachment(LocationFile, copystr(LocationFile, duzina1, StrLen(LocationFile)));

                    SMTPMail.Send;
                    MESSAGE('Notifikacije su uspješno poslane!');


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
                group("Chose Template Message")
                {
                    Caption = 'Chose Template Message';

                    field(MessageC; MessageC)

                    {
                        Caption = 'Message Code';
                        TableRelation = Template_Message."Message Code";
                    }

                }
            }


        }
    }
    var
        myInt: Integer;
        TempM: Record Template_Message;
        LocationFile: Text;
        duzina: Integer;
        MessageC: code[20];
        templateM: Record Template_Message;

        SadrzajNotifikacije: BigText;
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
        DocumforOffer: Record "A-B Attachments";
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
        CompInf: Record "Company Information";
        duzina1: Integer;

    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO

            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}