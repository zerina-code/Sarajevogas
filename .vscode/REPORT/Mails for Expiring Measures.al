/*report 50119 "Mails for Expiring Measures"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; "Company Information")
        {
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin

        WorkDutiesViolation.RESET;
        WorkDutiesViolation.SETFILTER("Page Type", '%1', WorkDutiesViolation."Page Type"::"Disciplinary measures");
        IF WorkDutiesViolation.FINDFIRST THEN
            REPEAT
                IF (WorkDutiesViolation."Measure From" <= TODAY) AND (WorkDutiesViolation."Expiration Measure" >= TODAY) THEN BEGIN
                    WorkDutiesViolation."Active Measure" := TRUE;
                    WorkDutiesViolation.MODIFY;
                END ELSE BEGIN
                    WorkDutiesViolation."Active Measure" := FALSE;
                    WorkDutiesViolation.MODIFY;
                END;
            UNTIL WorkDutiesViolation.NEXT = 0;

        DateP := CALCDATE('<+15D>', TODAY);
        WorkDutiesViolation.RESET;
        WorkDutiesViolation.SETFILTER("Page Type", '%1', WorkDutiesViolation."Page Type"::"Disciplinary measures");
        WorkDutiesViolation.SETFILTER("Expiration Measure", '%1', DateP);
        IF WorkDutiesViolation.FINDFIRST THEN
            REPEAT

                Subject := 'Obavjestenje o isteku disciplinske mjere';

                Body.ADDTEXT('<p>Po&scaron;tovani,</p>');
                Body.ADDTEXT('<p>Obavje&scaron;tavamo Vas da za radnika ' + WorkDutiesViolation."First Name" + ' dana ' + FORMAT(WorkDutiesViolation."Expiration Measure", 0, '<Day,2>.<Month,2>.<Year,4>'));
                Body.ADDTEXT('. godine istice izrecena disciplinska ');
                Body.ADDTEXT('mjera ' + WorkDutiesViolation.Measure + ' od ' + FORMAT(WorkDutiesViolation."Measure From", 0, '<Day,2>.<Month,2>.<Year,4>') + '. godine, ');
                IF WorkDutiesViolation."Measure Type" = WorkDutiesViolation."Measure Type"::Heavier THEN BEGIN
                    Body.ADDTEXT('za pocinjenu tezu ')
                END ELSE
                    Body.ADDTEXT('za pocinjenu laksu ');
                Body.ADDTEXT('povredu radne obaveze zbog ' + WorkDutiesViolation."Injury Name" + '.</p>');
                Body.ADDTEXT('<p>Srdacan pozdrav</p>');

                //ĐK    SMTPSetup.GET;
                Recipients.add('muhamed.dzafo@raiffeisengroup.ba');
                Recipients.add('aida.bosankic@raiffeisengroup.ba');
                Recipients.add('elvis.goloman@raiffeisengroup.ba');
                Recipients.add('nezla.muftic@raiffeisengroup.ba');
            //SMTPMail.CreateMessage('RAIFFAISEN BANK', 'itops.notifikacije@rbbh.ba', 'semin.palalic@infodom.ba', Subject, FORMAT(Body), TRUE);
            //ĐK   SMTPMail.CreateMessage('RAIFFAISEN BANK', 'itops.notifikacije@rbbh.ba', Recipients, Subject, FORMAT(Body), TRUE);
            //ĐK   SMTPMail.Send();

          

            //Ne postoji verzija za mail
            UNTIL WorkDutiesViolation.NEXT = 0;
    end;

    var
        WorkDutiesViolation: Record "Work Duties Violation";
        DateP: Date;
        Recipients: List of [Text];
        // SMTPMail: Codeunit "SMTP Mail";
        //  SMTPSetup: Record "SMTP Mail Setup";

        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";

        Body: BigText;
        Subject: Text;
}

*/