/*report 50090 "Systematization e-mail"
{
    Caption = 'Systematization e-mail';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Employee Contract Ledger")
        {

            trigger OnAfterGetRecord()
            begin
                OrgF.RESET;
                OrgF.SETFILTER(Status, '%1', OrgF.Status::Preparation);
                IF OrgF.FINDLAST THEN BEGIN
                    OrgC := OrgF.Code;
                    DatumVazenjaSis := OrgF."Date From";

                END;

                IF OrgF."Sent Mail Systematization" = FALSE THEN BEGIN
                    SETFILTER("Org. Structure", '%1', OrgC);
                    SETFILTER("Show Record", '%1', TRUE);
                    SETFILTER("Position Description", '<>%1', '');
                    SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                    IF FINDFIRST THEN BEGIN


                        ECL.RESET;
                        ECL.SETFILTER("Show Record", '%1', TRUE);
                        ECL.SETFILTER("Position Description", '<>%1', '');
                        ECL.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                        ECL.SETFILTER("Reason for Change", '%1', "Reason for Change"::"New Contract");
                        ECL.SETFILTER("Org. Structure", '%1', OrgC);
                        IF ECL.FINDFIRST THEN BEGIN



                            EmailBodyText += '<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
                            EmailBodyText += '<br /> <br /> Molim da poduzmete potrebne aktivnosti u vezi sa početkom rada/angažmana navedene osobe. ';
                            EmailBodyText += '<br /> <br />';
                            EmailBodyText += '<br /> <br />';
                            EmailBodyText += '<table cellpadding="5" style="border-collapse: collapse; border-left: solid 1px black; " border="1">';
                            //EmailBodyText += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
                            EmailBodyText += '<tr style="Border:solid 1px black;">';
                            EmailBodyText += '<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
                            EmailBodyText += ' <td  width="250"  style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
                            EmailBodyText += '<td  width="200" style="border-bottom:solid 1px black;width:200px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MATIČNI &nbsp; &nbsp; BROJ&nbsp</strong> </td>';
                            EmailBodyText += '<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> ORGANIZACIJSKA PRIPADNOST&nbsp</strong></td>';
                            EmailBodyText += '<td width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;RADNO&nbsp;  MJESTO&nbsp;</strong></td>';
                            EmailBodyText += '<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;MJESTO&nbsp;  RADA&nbsp;</strong></td>';
                            ;
                            EmailBodyText += '<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> VRSTA ANGAŽMANA/PERSON TYPE/&nbsp</strong></td>';
                            EmailBodyText += '<td  width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">DATUM POČETKA RADA/ANGAŽMANA&nbsp</strong> </td>';
                            EmailBodyText += '<td style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA   &nbsp;&nbsp;&nbsp;</strong></td>';
                            EmailBodyText += '<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; Neposredni  &nbsp; rukovodilac&nbsp</strong></td>';
                            EmailBodyText += '</tr>';

                            ECL1.SETFILTER("Show Record", '%1', TRUE);
                            ECL1.SETFILTER("Position Description", '<>%1', '');
                            ECL1.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                            ECL1.SETFILTER("Reason for Change", '%1', "Reason for Change"::"New Contract");
                            ECL1.SETFILTER("Org. Structure", '%1', OrgC);
                            IF ECL1.FINDSET THEN
                                REPEAT

                                    CLEAR(TextMsg);
                                    CLEAR(IStream);
                                    CLEAR(Mail);


                                    IF ECL1."Team Description" <> '' THEN BEGIN
                                        OrgUnit := ECL1."Sector Description" + '/' + ECL1."Department Cat. Description" + '/' + ECL1."Group Description" + '/' + ECL1."Team Description";
                                    END;
                                    IF (ECL1."Group Description" <> '') AND (ECL1."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL1."Sector Description" + '/' + ECL1."Department Cat. Description" + '/' + ECL1."Group Description";

                                    END;
                                    IF (ECL1."Department Cat. Description" <> '') AND (ECL1."Group Description" = '') AND (ECL1."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL1."Sector Description" + '/' + ECL1."Department Cat. Description";

                                    END;
                                    IF (ECL1."Sector Description" <> '') AND (ECL1."Department Cat. Description" = '') AND (ECL1."Group Description" = '') AND (ECL1."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL1."Sector Description";

                                    END;
                                    IF (ECL1."Sector Description" = '') AND (ECL1."Department Cat. Description" = '') AND (ECL1."Group Description" = '') AND (ECL1."Team Description" = '') THEN BEGIN
                                        OrgUnit := '';
                                    END;
                                    PositionPlace := ECL1."Position Description";
                                    StartingDate := ECL1."Starting Date";
                                    ECL1.CALCFIELDS("Residence/Network");
                                    ECL1.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");
                                    ECL1.CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name");
                                    ManagerFull := ECL1."Manager 1 First Name" + ' ' + ECL1."Manager 1 Last Name";
                                    IF ECL1."Manager 1 First Name" = '' THEN
                                        ManagerFull := ECL1."Manager 2 First Name" + ' ' + ECL1."Manager 2 Last Name";
                                    Tip := '';
                                    Emp.SETFILTER("No.", '%1', ECL1."Employee No.");
                                    IF Emp.FINDFIRST THEN BEGIN
                                        // Emp.CALCFIELDS("Role Code");
                                        // Emp.CALCFIELDS("Role Name");}

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', ECL1."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECL1."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', OrgF.Code);
                                        IF PositionMenuOrginal.FINDFIRST THEN BEGIN
                                            RoleCode := PositionMenuOrginal.Role;
                                            RoleName := PositionMenuOrginal."Role Name";
                                        END
                                        ELSE BEGIN
                                            RoleCode := '';
                                            RoleName := '';
                                        END;

                                        IF ECL1."Engagement Type" = 'EXTERNI ANGAZMAN' THEN
                                            Tip := 'Eksterni saradnik'
                                        ELSE
                                            Tip := 'Zaposlenik';
                                    END;

                                    IF ECL1."Org Unit Name" <> '' THEN
                                        MjestoRada := ECL1."Org Unit Name";
                                    IF ECL1."GF of work Description" <> '' THEN
                                        MjestoRada := ECL1."GF of work Description";

                                    EmailBodyText += '<tr>';

                                    EmailBodyText += STRSUBSTNO('<td style="border-left:solid 0px black;width:250px" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
                                    EmailBodyText += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."First Name" + ' ' + Emp."Last Name");
                                    EmailBodyText += STRSUBSTNO('<td  width="200" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Emp."Employee ID");
                                    EmailBodyText += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', OrgUnit);
                                    EmailBodyText += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', PositionPlace);
                                    EmailBodyText += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF" ><span style="font-size: 10.0pt;">%1</td>', MjestoRada + '/' + ECL1."Phisical Department Desc");
                                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Tip);
                                    EmailBodyText += STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', FORMAT(StartingDate, 0, '<Day,2>.<Month,2>.<Year4>.'));
                                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px"  bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', RoleCode + '-' + RoleName);
                                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', ManagerFull);
                                    EmailBodyText += '</tr>';
                                    MailNo.RESET;
                                    MailNo.SETFILTER("No.", '%1', ECL1."No.");
                                    MailNo.SETFILTER("Employee No.", '%1', ECL1."Employee No.");
                                    IF MailNo.FINDFIRST THEN BEGIN
                                        MailNo."Sent Mail Employment" := TRUE;
                                        MailNo.MODIFY;
                                    END;


                                UNTIL ECL1.NEXT = 0;

                            EmailBodyText += '</table>';
                            HRSetup.GET;

                            Recipients.Add(HRSetup."E-mail Receiver");
                            SMTPMail.CreateMessage(HRSetup."Sender Name", HRSetup."E-mail Sender", Recipients, 'Obavijest o zapošljavanju/angažmanu', EmailBodyText, TRUE);
                            SMTPMail.Send();

                        END;


                       //DURATION
                        ECL2.RESET;
                        ECL2.SETFILTER("Show Record", '%1', TRUE);
                        ECL2.SETFILTER("Position Description", '<>%1', '');
                        ECL2.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                        ECL2.SETFILTER("Reason for Change", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 3, 7, 8, 9, 10, 12, 4, 11, 15, 16);
                        ECL2.SETFILTER("Org. Structure", '%1', OrgC);
                        IF ECL2.FINDFIRST THEN BEGIN


                            EmailBodyText1 += '<p><span style="font-size: 10.0pt; font-family: "Tahoma">Po&scaron;tovani,';
                            EmailBodyText1 += '<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadležnosti, u vezi sa izmjenom trenutnog rasporeda koji važi do datuma kako je navedeno u tabeli';
                            EmailBodyText1 += '<br /> <br />';
                            EmailBodyText1 += '<br /> <br />';
                            EmailBodyText1 += '<table cellpadding="5" style="border-collapse: collapse; border-left: solid 1px black;   " border="1">';
                            // EmailBodyText1 += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
                            EmailBodyText1 += '<tr style="Border:solid 1px black;">';
                            EmailBodyText1 += '<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
                            EmailBodyText1 += ' <td width="250" style="border-bottom:solid 1px black" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
                            EmailBodyText1 += '<td width="200"  style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   JMBG  &nbsp; &nbsp</strong> </td>';
                            EmailBodyText1 += '<td  width="270" style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;"> STARI RASPORED&nbsp</strong></td>';
                            EmailBodyText1 += '<td  width="200" style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAŽI &nbsp; DO&nbsp;</strong></td>';
                            EmailBodyText1 += '<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MJESTO RADA &nbsp;&nbsp;</strong></td>';
                            EmailBodyText1 += '<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;  ROLA   &nbsp;&nbsp;&nbsp;</strong></td>';
                            EmailBodyText1 += '<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni &nbsp; rukovodilac&nbsp</strong></td>';
                            EmailBodyText1 += '</tr>';


                            ECL3.RESET;
                            ECL3.SETFILTER("Show Record", '%1', TRUE);
                            ECL3.SETFILTER("Position Description", '<>%1', '');
                            ECL3.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                            ECL3.SETFILTER("Reason for Change", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 3, 7, 8, 9, 10, 12, 4, 11, 15, 16);
                            ECL3.SETFILTER("Org. Structure", '%1', OrgC);
                            IF ECL3.FINDSET THEN
                                REPEAT

                                    CLEAR(TextMsg);
                                    CLEAR(IStream);
                                    CLEAR(Mail);
                                    OrgShemaActive.RESET;
                                    OrgShemaActive.SETFILTER(Status, '%1', Status::Active);
                                    IF OrgShemaActive.FINDFIRST THEN
                                        ActiveOrg := OrgShemaActive.Code;

                                    EMPCL1.SETFILTER("Employee No.", ECL3."Employee No.");
                                    EMPCL1.SETFILTER("Org. Structure", '%1', ActiveOrg);
                                    //EMPCL1.SETFILTER("Starting Date",'<=%1',WORKDATE);
                                    EMPCL1.SETFILTER(Active, '%1', TRUE);
                                    EMPCL1.SETCURRENTKEY("Starting Date");
                                    EMPCL1.ASCENDING;
                                    IF EMPCL1.FINDFIRST THEN BEGIN


                                       
                                        IF EMPCL1."Team Description" <> '' THEN BEGIN
                                            OrgUnit := EMPCL1."Sector Description" + '/' + EMPCL1."Department Cat. Description" + '/' + EMPCL1."Group Description" + '/' + EMPCL1."Team Description";
                                        END;
                                        IF (EMPCL1."Group Description" <> '') AND (EMPCL1."Team Description" = '') THEN BEGIN

                                            OrgUnit := EMPCL1."Sector Description" + '/' + EMPCL1."Department Cat. Description" + '/' + EMPCL1."Group Description";
                                        END;
                                        IF (EMPCL1."Group Description" = '') AND (EMPCL1."Team Description" = '') AND (EMPCL1."Department Cat. Description" <> '') THEN BEGIN
                                            OrgUnit := EMPCL1."Sector Description" + '/' + EMPCL1."Department Cat. Description";
                                        END;
                                        IF (EMPCL1."Group Description" = '') AND (EMPCL1."Team Description" = '') AND (EMPCL1."Department Cat. Description" = '') AND (EMPCL1."Sector Description" <> '') THEN BEGIN
                                            OrgUnit := EMPCL1."Sector Description";
                                        END;
                                        EMPCL1.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");
                                        EMPCL1.CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name");
                                        ManagerFull := EMPCL1."Manager 1 First Name" + ' ' + EMPCL1."Manager 1 Last Name";
                                        IF EMPCL1."Manager 1 First Name" = '' THEN
                                            ManagerFull := EMPCL1."Manager 2 First Name" + ' ' + EMPCL1."Manager 2 Last Name";
                                        EndingDateOFPosition := EMPCL1."Ending Date";
                                        EMPCL1.CALCFIELDS("Residence/Network");
                                        Reg := FORMAT(EMPCL1."Regionalni Head Office");

                                    END;
                                    //  UNTIL (Found=TRUE) OR (EMPCL1.NEXT = 0);


                                    EMPCL1.CALCFIELDS("Residence/Network");
                                    "PositionPlace¸2" := EMPCL1."Position Description";

                                    Emp.SETFILTER("No.", '%1', EMPCL1."Employee No.");
                                    IF Emp.FINDFIRST THEN BEGIN
                                        //  Emp.CALCFIELDS("Role Code");
                                        //Emp.CALCFIELDS("Role Name");


                                    END;
                                    IF EMPCL1."Org Unit Name" <> '' THEN
                                        MjestoRada := EMPCL1."Org Unit Name";
                                    IF EMPCL1."GF of work Description" <> '' THEN
                                        MjestoRada := EMPCL1."GF of work Description";

                                    OrgShemaActive.RESET;
                                    OrgShemaActive.SETFILTER(Status, '%1', OrgShemaActive.Status::Active);
                                    IF OrgShemaActive.FINDFIRST THEN BEGIN
                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Code, '%1', EMPCL1."Position Code");
                                        PositionMenuOrginal.SETFILTER(Description, '%1', EMPCL1."Position Description");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', OrgShemaActive.Code);
                                        IF PositionMenuOrginal.FINDFIRST THEN BEGIN
                                            RoleCode := PositionMenuOrginal.Role;
                                            RoleName := PositionMenuOrginal."Role Name";
                                        END
                                        ELSE BEGIN
                                            RoleCode := '';
                                            RoleName := '';
                                        END;
                                    END;
                                    EmailBodyText1 += '<tr>';
                                    EmailBodyText1 += STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
                                    EmailBodyText1 += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', Emp."First Name" + ' ' + Emp."Last Name");
                                    EmailBodyText1 += STRSUBSTNO('<td  width="200" style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>', Emp."Employee ID");
                                    EmailBodyText1 += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', OrgUnit + '/' + "PositionPlace¸2");
                                    EmailBodyText1 += STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', FORMAT(EndingDateOFPosition, 0, '<Day,2>.<Month,2>.<Year4>.'));
                                    EmailBodyText1 += STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>', MjestoRada + '/' + EMPCL1."Phisical Department Desc");
                                    EmailBodyText1 += STRSUBSTNO('<td style="border-bottom:solid 1px black ;width:250px" ><span style="font-size: 10.0pt;">%1</td>', RoleCode + '-' + RoleName);
                                    EmailBodyText1 += STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', ManagerFull);
                                    EmailBodyText1 += '</tr>';

                                    MailNo.RESET;
                                    MailNo.SETFILTER("No.", '%1', ECL3."No.");
                                    MailNo.SETFILTER("Employee No.", '%1', ECL3."Employee No.");
                                    IF MailNo.FINDFIRST THEN BEGIN
                                        MailNo."Sent Mail Duration" := TRUE;
                                        MailNo.MODIFY;
                                    END;


                                UNTIL ECL3.NEXT = 0;
                            EmailBodyText1 += '</table>';
                            HRSetup.GET;
                            Recipients.Add(HRSetup."E-mail Receiver");
                            SMTPMail.CreateMessage(HRSetup."Sender Name", HRSetup."E-mail Sender", Recipients, 'Obavijest o trajanju rasporeda na trenutnoj poziciji', EmailBodyText1);
                            //CreateMessage(FromName: Text; FromAddress: Text; Recipients: List of [Text]; Subject: Text; Body: Text)
                            SMTPMail.Send();
                        END;




                      //"CHANGE POSITION PLACE"

                        ECL4.RESET;
                        ECL4.SETFILTER("Show Record", '%1', TRUE);
                        ECL4.SETFILTER("Position Description", '<>%1', '');
                        ECL4.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                        ECL4.SETFILTER("Reason for Change", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 3, 7, 8, 9, 10, 12, 4, 11, 15, 16);
                        ECL4.SETFILTER("Org. Structure", '%1', OrgC);
                        IF ECL4.FINDFIRST THEN BEGIN


                            EmailBodyText2 += '<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
                            EmailBodyText2 += '<br /> <br />Molim da poduzmete sve aktivnosti iz svoje nadležnosti u vezi sa početkom rada navedene osobe na novoj poziciji i/ili organizaciji.';
                            EmailBodyText2 += '<br /> <br />';
                            EmailBodyText2 += '<br /> <br />';
                            EmailBodyText2 += '<table cellpadding="5" style="border-collapse: collapse;border-left: solid 1px black;  " border="1">';
                            // EmailBodyText2 += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
                            EmailBodyText2 += '<tr style="Border:solid 1px black;">';
                            EmailBodyText2 += '<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" ><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
                            EmailBodyText2 += ' <td width="250 style="border-bottom:solid 1px black" align="center" > <strong><span style="font-size: 10.0pt;">PREZIME I IME&nbsp</strong></td>';
                            EmailBodyText2 += '<td  width="200" style="border-bottom:solid 1px black ;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;  JMBG  &nbsp</strong> </td>';
                            EmailBodyText2 += '<td  width="270" style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;"> NOVI RASPORED &nbsp</strong></td>';
                            EmailBodyText2 += '<td   width="200" style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;VAŽI&nbsp; OD&nbsp;</strong></td>';
                            EmailBodyText2 += '<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; MJESTO  &nbsp;  RADA&nbsp;</strong></td>';
                            EmailBodyText2 += '<td style="border-bottom:solid 1px black;width:250px" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA  &nbsp;&nbsp;&nbsp;</strong></td>';
                            EmailBodyText2 += '<td style="border-bottom:solid 1px black" align="center" ><strong><span style="font-size: 10.0pt;">Neposredni &nbsp; rukovodilac&nbsp</strong></td>';
                            EmailBodyText2 += '</tr>';

                            ECL5.RESET;
                            ECL5.SETFILTER("Show Record", '%1', TRUE);
                            ECL5.SETFILTER("Position Description", '<>%1', '');
                            ECL5.SETFILTER("Starting Date", '%1', DatumVazenjaSis);
                            ECL5.SETFILTER("Reason for Change", '%1|%2|%3|%4|%5|%6|%7|%8|%9|%10', 3, 7, 8, 9, 10, 12, 4, 11, 15, 16);
                            IF ECL5.FINDSET THEN
                                REPEAT

                                    CLEAR(TextMsg);
                                    CLEAR(IStream);
                                    CLEAR(Mail);

                                    IF ECL5."Team Description" <> '' THEN BEGIN
                                        OrgUnit := ECL5."Sector Description" + '/' + ECL5."Department Cat. Description" + '/' + ECL5."Group Description" + '/' + ECL5."Team Description";
                                    END;
                                    IF (ECL5."Group Description" <> '') AND (ECL5."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL5."Sector Description" + '/' + ECL5."Department Cat. Description" + '/' + ECL5."Group Description";
                                    END;
                                    IF (ECL5."Department Cat. Description" <> '') AND (ECL5."Group Description" = '') AND (ECL5."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL5."Sector Description" + '/' + ECL5."Department Cat. Description";
                                    END;
                                    IF (ECL5."Sector Description" <> '') AND (ECL5."Department Cat. Description" = '') AND (ECL5."Group Description" = '') AND (ECL5."Team Description" = '') THEN BEGIN
                                        OrgUnit := ECL5."Sector Description"
                                    END;
                                    IF (ECL5."Sector Description" = '') AND (ECL5."Department Cat. Description" = '') AND (ECL5."Group Description" = '') AND (ECL5."Team Description" = '') THEN BEGIN
                                        OrgUnit := '';
                                        WorkPlace := '';
                                    END;
                                    IF ECL5."Org Unit Name" <> '' THEN BEGIN
                                        WorkPlace := ECL5."Org Unit Name";
                                    END
                                    ELSE BEGIN
                                        WorkPlace := ECL5."GF of work Description";
                                    END;

                                    IF ECL5."Org Unit Name" <> '' THEN
                                        MjestoRada := ECL5."Org Unit Name";
                                    IF ECL5."GF of work Description" <> '' THEN
                                        MjestoRada := ECL5."GF of work Description";

                                    StartingDate := ECL5."Starting Date";
                                    ECL5.CALCFIELDS("Residence/Network");
                                    ECL5.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");
                                    ECL5.CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name");
                                    ManagerFull := ECL5."Manager 1 First Name" + ' ' + ECL5."Manager 1 Last Name";
                                    IF ECL5."Manager 1 First Name" = '' THEN
                                        ManagerFull := ECL5."Manager 2 First Name" + ' ' + ECL5."Manager 2 Last Name";
                                    Emp.SETFILTER("No.", '%1', ECL5."Employee No.");

                                    IF Emp.FINDFIRST THEN BEGIN

                                    END;

                                    PositionMenuOrginal.RESET;
                                    PositionMenuOrginal.SETFILTER(Code, '%1', ECL5."Position Code");
                                    PositionMenuOrginal.SETFILTER(Description, '%1', ECL5."Position Description");
                                    PositionMenuOrginal.SETFILTER("Org. Structure", '%1', OrgF.Code);
                                    IF PositionMenuOrginal.FINDFIRST THEN BEGIN
                                        RoleCode := PositionMenuOrginal.Role;
                                        RoleName := PositionMenuOrginal."Role Name";
                                    END
                                    ELSE BEGIN

                                        RoleCode := '';
                                        RoleName := '';
                                    END;

                                    //EmailBodyText2+= '<tr><span style="font-size: 10.0pt;">';
                                    EmailBodyText2 += '<tr>';
                                    EmailBodyText2 += STRSUBSTNO('<td style="border-left:solid 0px black;;width:250px" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."Internal ID");
                                    EmailBodyText2 += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black" ><span style="font-size: 10.0pt;">%1</td>', Emp."First Name" + ' ' + Emp."Last Name");
                                    EmailBodyText2 += STRSUBSTNO('<td  width="200" style="border-bottom:solid 1px black ;width:250px" ><span style="font-size: 10.0pt;">%1</td>', Emp."Employee ID");
                                    EmailBodyText2 += STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', OrgUnit + '/' + ECL5."Position Description");
                                    EmailBodyText2 += STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', FORMAT(StartingDate, 0, '<Day,2>.<Month,2>.<Year4>.'));
                                    EmailBodyText2 += STRSUBSTNO('<td width="250" style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', MjestoRada + '/' + ECL5."Phisical Department Desc");
                                    EmailBodyText2 += STRSUBSTNO('<td style="border-bottom:solid 1px black;width:250px" ><span style="font-size: 10.0pt;">%1</td>', RoleCode + '-' + RoleName);
                                    EmailBodyText2 += STRSUBSTNO('<td style="border-bottom:solid 1px black"><span style="font-size: 10.0pt;">%1</td>', ManagerFull);
                                    EmailBodyText2 += '</tr>';
                                    MailNo.RESET;
                                    MailNo.SETFILTER("No.", '%1', ECL5."No.");
                                    MailNo.SETFILTER("Employee No.", '%1', ECL5."Employee No.");
                                    IF MailNo.FINDFIRST THEN BEGIN
                                        MailNo."Sent Mail Change Pos" := TRUE;
                                        MailNo.MODIFY;
                                    END;

                                UNTIL ECL5.NEXT = 0;

                            EmailBodyText2 += '</table>';
                            // SMTPMail.CreateMessage('HR test','test.hr@raiffeisengroup.ba','infodom.test@raiffeisengroup.ba','Obavijest o početku rada na novoj poziciji',EmailBodyText2,TRUE);
                            HRSetup.GET;

                            Recipients.Add(HRSetup."E-mail Receiver");
                            SMTPMail.CreateMessage(HRSetup."Sender Name", HRSetup."E-mail Sender", Recipients, 'Obavijest o početku rada na novoj poziciji', EmailBodyText2, TRUE);
                            SMTPMail.Send();
                        END;

                        OrgF."Sent Mail Systematization" := TRUE;
                        OrgF.MODIFY;
                    END;
                END;

            end;
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

    var
        Text000: Label 'It''s wrong code';
        Recipients: List of [Text];
        OrgUnit: Text;
        PositionPlace: Text;
        StartingDate: Date;
        OrgF: Record "ORG Shema";
        Position: Record "Position";
        ManagerFull: Text;
        PositionMenu: Record "Position Menu temporary";
        RoleCode: Code[10];
        RoleName: Text;
        WorkPlace: Text;
        EmpCL: Record "ECL systematization";
        OrgC: Code[10];
        EmailBodyText: Text;
        FileManagement: codeunit "File Management";
        filename: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit "Mail";
        TextMsg: BigText;
        IStream: InStream;
        MessageBody: Text;
        SMTPMail: Codeunit "SMTP Mail";
        Tip: Text;
        Emp: Record "Employee";
        EMPCL1: Record "Employee Contract Ledger";
        Found: Boolean;
        EndingDateOFPosition: Date;
        Reg: Text;
        EmployeeContract: Record "Employee Contract Ledger";
        Stavka: Integer;
        Zaposlenik: Code[10];
        MjestoRada: Text;
        ECL: Record "Employee Contract Ledger";
        ECL1: Record "Employee Contract Ledger";
        ECL2: Record "Employee Contract Ledger";
        ECL3: Record "Employee Contract Ledger";
        Brojac: Integer;
        ECL4: Record "Employee Contract Ledger";
        ECL5: Record "Employee Contract Ledger";
        PositionMenuOrginal: Record "Position Menu";
        OrgShemaActive: Record "ORG Shema";
        EmailBodyText1: Text;
        EmailBodyText2: Text;
        "PositionPlace¸2": Text;
        ActiveOrg: Code[10];
        MailNo: Record "Employee Contract Ledger";
        HRSetup: Record "Human Resources Setup";
        DatumVazenjaSis: Date;
}

*/