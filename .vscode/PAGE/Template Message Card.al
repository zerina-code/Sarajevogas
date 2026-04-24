page 50211 "E.mail templates"
{
    Caption = 'Template Messages';
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = Template_Message;

    layout
    {
        area(Content)
        {
            group(General)
            {

                field(Type; Type)
                {

                }
                field("Document No."; "Document No.")
                {

                }
                field(ID; ID)
                {
                }
                field("Print Confirmation"; "Print Confirmation")
                {

                }
            }
            group("Mail")
            {
                field("Message Code"; "Message Code")
                {
                    Editable = true;
                }
                field("E-mail receiver"; "E-mail receiver")
                {
                    Editable = true;
                }
                field(MailCC; MailCC)
                {

                }
                field("E-mail sender"; "E-mail sender")
                {
                    Editable = true;

                }
                field("Message Subject"; "Message Subject")
                {
                    Editable = true;
                }
            }


            group("Text")
            {
                field(TextMsg; TextMsg)
                {
                    Caption = 'TextMsg';
                    MultiLine = true;

                    trigger OnValidate()
                    begin

                        //TextMsg.ADDTEXT(TextMsg);
                        "Message Text".CREATEOUTSTREAM(OStream);
                        TextMsg.WRITE(OStream);
                        MODIFY;
                        /*"Message Text".CREATEINSTREAM(IStream);
                        TextMsg.READ(IStream);
                        
                        MODIFY;
                        CurrPage.UPDATE;*/

                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        CALCFIELDS("Message Text");
        "Message Text".CREATEINSTREAM(IStream);
        TextMsg.READ(IStream);
    end;

    var
        TextMsg: BigText;
        OStream: OutStream;
        IStream: InStream;
        TM: Record Template_Message;
}

