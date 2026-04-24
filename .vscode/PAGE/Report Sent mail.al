report 50161 "Send Invoice via e-mail"
{
    Caption = 'Send Invoice via e-mail';
    ProcessingOnly = true;
    ShowPrintStatus = false;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CalSet: Record "Calculation Setup";
                CalcS: Record "Calculation Journal Line";
                CalcS2: Record "Calculation Journal Line";
            begin


                CalcS2.Reset();
                CalcS2.CopyFilters("Calculation Journal Line");
                CalcS2.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                CalcS2.SetFilter("Sent e-mail", '%1', true);
                CalcS2.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                if not CalcS2.FindFirst() then begin
                    CLEAR(TaInvoiceDOM);
                    CLEAR(FileManagement);
                    CLEAR(Mail);


                    TaInvoiceDOM.Setparam(LayoutF, "Calculation Journal Line"."Customer No.", "Calculation Journal Line"."Document No. Posting");



                    CalcS.Reset();
                    CalcS.CopyFilters("Calculation Journal Line");
                    CalcS.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                    CalcS.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                    if CalcS.FindFirst() then begin
                        TaInvoiceDOM.SETTABLEVIEW(CalcS);

                        Clear(Recipients);
                        CLEAR(FileManagement);
                        CalSet.get;
                        //filename:='C:\Temp\PayList-'+T_Employee."First Name"+' '+T_Employee."Last Name"+'.pdf';
                        filename := CalSet.Path + "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf';
                        TaInvoiceDOM.SAVEASPDF(filename);



                        FileManagement.DownloadToFile(filename, filename);
                        Commit();


                        if LayoutF2 <> '' then begin
                            CLEAR(TaInvoiceDOMSpec);
                            CLEAR(FileManagement);
                            TaInvoiceDOMSpec.SetTableView(CalcS);

                            TaInvoiceDOMSpec.Setparam(LayoutF2, "Calculation Journal Line"."Customer No.", "Calculation Journal Line"."Document No. Posting");


                            filename2 := CalSet.Path + 'Specifikacija' + "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf';
                            TaInvoiceDOMSpec.SaveAsPdf(filename2);
                            FileManagement.DownloadToFile(filename2, filename2);


                        end;
                        SMTPSetup.GET;
                        TempMessage.Reset();
                        TempMessage.SetFilter("Message Code", '%1', MessageC);
                        if TempMessage.FindFirst() then begin
                            TempMessage.CALCFIELDS("Message Text");
                            TempMessage."Message Text".CREATEINSTREAM(IStream);
                            TextMsg.READ(IStream);

                        end;
                        Recipient := '';
                        EmailAddresses := '';

                        SMTPSetup.get;
                        if ("Calculation Journal Line"."E-Mail 2" <> '') and (strpos("Calculation Journal Line"."E-Mail 2", ';') = 0) then begin

                            Recipients.Add("Calculation Journal Line"."E-Mail 2");
                        end
                        else begin

                            EmailAddresses := "Calculation Journal Line"."E-Mail 2";
                            while EmailAddresses <> '' do begin
                                // EmailAddresses := "Calculation Journal Line"."E-Mail 2";
                                Pos := StrPos(EmailAddresses, ';');

                                if Pos > 0 then begin
                                    Recipient := CopyStr(EmailAddresses, 1, Pos - 1);
                                    EmailAddresses := CopyStr(EmailAddresses, Pos + 1);
                                end else begin
                                    Recipient := EmailAddresses;
                                    EmailAddresses := '';
                                end;

                                // skini razmake (Trim zamena)
                                Recipient := DelChr(Recipient, '<>', ' ');

                                if Recipient <> '' then
                                    Recipients.Add(Recipient);
                            end;
                        end;
                        /*   Recipients.Add('djemina.karalic@teneo.ba');
                           Recipients.Add('kenankk@sarajevogas.ba');
                           Recipients.Add('kenankrka@gmail.com');*/
                        SMTPMail.CreateMessage(TempMessage."Message Subject", TempMessage."E-mail sender", Recipients, "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_'), format(TextMsg), TRUE);

                        filename := CalSet.Path + "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf';
                        filename2 := CalSet.Path + 'Specifikacija' + "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf';


                        SMTPMail.AddAttachment(filename, "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf');
                        // SMTPMail.TrySend();
                        if LayoutF2 <> '' then
                            SMTPMail.AddAttachment(filename2, 'Specifikacija' + "Calculation Journal Line"."Customer No." + '_' + Replacestring(Replacestring("Calculation Journal Line"."Document No. Posting", '/', '_'), '\', '_') + '.pdf');


                        SMTPMail.Send();

                        CalcS2.Reset();
                        CalcS2.CopyFilters("Calculation Journal Line");
                        CalcS2.SetFilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                        CalcS2.SetFilter("Document No. Posting", '%1', "Calculation Journal Line"."Document No. Posting");
                        if CalcS2.FindSet() then
                            repeat

                                CalcS2."Sent e-mail" := true;
                                CalcS2.Modify();
                                Commit();

                            until CalcS2.Next() = 0;
                        Commit();
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
                group(Options)
                {
                    Caption = 'Options';
                    field(LayoutF; LayoutF)
                    {
                        Caption = 'Layout';
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50182);
                            CRLPage.SetTableView(CustomReportLayout);

                            CRLPage.LOOKUPMODE(TRUE);
                            IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                CRLPage.GETRECORD(CustomReportLayout);
                                LayoutF := CustomReportLayout.Description;
                                ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
                            end;
                        end;
                    }
                    field(LayoutF2; LayoutF2)
                    {
                        Caption = 'Layout 2';
                        ApplicationArea = all;
                        trigger OnDrillDown()
                        var
                            myInt: Integer;
                            CustomReportLayout: Record "Custom Report Layout";
                            ReportLayoutSelection: Record "Report Layout Selection";
                            CRLPage: Page "Custom Report Layouts";
                        begin
                            clear(CRLPage);
                            CustomReportLayout.reset;
                            CustomReportLayout.SetFilter("Report ID", '%1', 50182);
                            CRLPage.SetTableView(CustomReportLayout);

                            CRLPage.LOOKUPMODE(TRUE);
                            IF CRLPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
                                CRLPage.GETRECORD(CustomReportLayout);
                                LayoutF2 := CustomReportLayout.Description;
                                ReportLayoutSelection.SetTempLayoutSelected(format(CustomReportLayout.Code));
                            end;
                        end;
                    }
                    field(MessageC; MessageC)
                    {
                        Caption = 'Message';
                        ApplicationArea = all;
                        TableRelation = Template_Message."Message Code";
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

    trigger OnPostReport()
    begin
        MESSAGE(Text001);
    end;



    var
        Recipients: List of [Text];

        TaInvoiceDOM: Report "Tax Invoice DOM";
        TaInvoiceDOMSpec: Report "Tax Invoice DOM";
        SMTPMail: Codeunit "SMTP Mail";
        Pos: Integer;
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit Mail;
        FileManagement: Codeunit "File Management";
        filename: Text;
        filename2: Text;
        Text001: Label 'Invoice sent.';
        TextMsg: BigText;
        EmailAddresses: text;
        PathDoc: Text[1000];
        TempMessage: Record Template_Message;
        LayoutF: Text[250];
        LayoutF2: Text[250];
        MessageC: code[20];
        IStream: InStream;
        Recipient: text;


    /*procedure ZipAllLabels(No: code[20])
    var
        datacompresion: Codeunit "Data Compression";
        ZipFileName: text;
        ItemCnt: Integer;
        FileName: text;
        TenantMedia: Record "Tenant Media";
        instrm: InStream;
        blobStorage: Codeunit "Temp Blob";
        ZipOutStream: OutStream;
        ZipInStream: InStream;
    begin
        ZipFileName := FileNo + '_' + Format(CurrentDateTime, 0, ':') + '.zip';
        datacompresion.CreateZipArchive();
        yourrecord.Reset();
        if yourrecord.findset then
            repeat
                if TenantMedia.get(yourrecord."Label URL File".MediaId) then BEGIN
                    TenantMedia.CalcFields(Content);
                    if TenantMedia.Content.HasValue then begin
                        FileName := "No." + '_' + format("Sequence No.") + '.pdf';
                        TenantMedia.Content.CreateInStream(instrm);
                        datacompresion.AddEntry(instrm, FileName);
                        ItemCnt := 1;
                    end;
                end;
            until yourrecord.Next() = 0;
        blobStorage.CreateOutStream(ZipOutStream);
        datacompresion.SaveZipArchive(ZipOutStream);
        datacompresion.CloseZipArchive();
        blobStorage.CreateInStream(ZipInStream);
        DownloadFromStream(ZipInStream, 'Download zip file', '', '', ZipFileName);
    end;
*/





    procedure Replacestring(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

}

