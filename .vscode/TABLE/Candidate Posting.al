/*table 50213 "Candidate/Posting"
{
    Caption = 'Candidates/Postings';
    DrillDownPageID = 50147;
    LookupPageID = 50147;

    fields
    {
        field(1; "Serial Number"; Integer)
        {
            Caption = 'Serial number';
            TableRelation = Candidates."Serial Number";

            trigger OnValidate()
            begin
                Candidates.RESET;
                Candidates.SETFILTER("Serial Number", '%1', "Serial Number");
                IF Candidates.FINDFIRST THEN BEGIN
                    Candidate := Candidates.Candidate;
                    Surname := Candidates.Surname;
                    Name := Candidates.Name;
                    "Date of Birth" := Candidates."Date of Birth";
                    "Appropriate Profile for Bank" := Candidates."Appropriate Profile for Bank";
                END;
            end;
        }
        field(2; Candidate; Option)
        {
            Caption = 'Candidate';
            Editable = false;
            OptionCaption = ',Internal,External,Candidate by base';
            OptionMembers = ,Internal,External,"Candidate by base";
        }
        field(3; Surname; Text[150])
        {
            Caption = 'Surname';
            Editable = false;
        }
        field(4; Name; Text[150])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(5; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            Editable = false;
        }

      
        field(8; Position; Text[250])
        {
            Caption = 'Position';
            Editable = false;
            TableRelation = "Position Menu".Description;
        }
        field(9; "HR Note"; Text[250])
        {
            Caption = 'HR Note';
        }
        field(10; "No."; Integer)
        {
            AutoIncrement = true;
        }
        field(11; Feedback; Text[250])
        {
            Caption = 'Feedback';
            TableRelation = "Candidate Feedback".Feedback;

            trigger OnValidate()
            begin
                CLEAR(Body);
                CLEAR(Body1);
                Subject := '';
                CandidateMail := '';

                Candidates.RESET;
                Candidates.SETFILTER("Serial Number", '%1', "Serial Number");
                IF Candidates.FINDFIRST THEN
                    CandidateMail := Candidates."E-mail";

                Pos := 1;
                IF "Feedback Sent" = FALSE THEN BEGIN
                    IF Feedback = 'Eksterni oglas - nije uključen u selekcijski proces nakon testiranja' THEN BEGIN

                        IF CONFIRM('Da li želite poslati mail obavještenja kandidatu?') = TRUE THEN BEGIN

                            TemplateMessages.RESET;
                            TemplateMessages.SETFILTER("Message Code", '%1', 'EXTERNAL AD 1');
                            IF TemplateMessages.FINDFIRST THEN BEGIN

                                TemplateMessages.CALCFIELDS("Message Text");
                                TemplateMessages."Message Text".CREATEINSTREAM(IStream);
                                TextMsg.READ(IStream);

                                Body.ADDTEXT(ReplaceString(FORMAT(TextMsg), '@RadnoMjesto', Rec.Position));

                                Subject := 'Povratna informacija_' + Rec.Position + ', Raiffeisen Bank';

                                SMTPSetup.GET;
                               
                                MESSAGE('Mail je uspješno poslan!');
                                "Feedback Sent" := TRUE;

                            END;

                        END ELSE BEGIN
                            Feedback := '';
                        END;

                    END ELSE
                        IF Feedback = 'Eksterni oglas - nije izabran nakon razgovora' THEN BEGIN

                            IF CONFIRM('Da li želite poslati mail obavještenja kandidatu?') = TRUE THEN BEGIN

                                TemplateMessages.RESET;
                                TemplateMessages.SETFILTER("Message Code", '%1', 'EXTERNAL AD 2');
                                IF TemplateMessages.FINDFIRST THEN BEGIN

                                    TemplateMessages.CALCFIELDS("Message Text");
                                    TemplateMessages."Message Text".CREATEINSTREAM(IStream);
                                    TextMsg.READ(IStream);

                                    Body.ADDTEXT(ReplaceString(FORMAT(TextMsg), '@RadnoMjesto', Rec.Position));

                                    Subject := 'Povratna informacija_' + Rec.Position + ', Raiffeisen Bank';

                                    //HRSetup.GET;
                                    //SMTPMail.CreateMessage(HRSetup."Sender Name",HRSetup."E-mail Sender", CandidateMail, Subject, FORMAT(Body),TRUE);
                                    //SMTPMail.Send();
                                    //MESSAGE('Mail je uspješno poslan!');
                                    //"Feedback Sent" := TRUE;

                                    SMTPSetup.GET;
                                  
                                    MESSAGE('Mail je uspješno poslan!');
                                    "Feedback Sent" := TRUE;

                                END;

                            END ELSE BEGIN
                                Feedback := '';
                            END;

                        END ELSE
                            IF Feedback = 'Interni oglas - nije izabran nakon razgovora' THEN BEGIN

                                IF CONFIRM('Da li želite poslati mail obavještenja kandidatu?') = TRUE THEN BEGIN

                                    TemplateMessages.RESET;
                                    TemplateMessages.SETFILTER("Message Code", '%1', 'INTERNAL AD 1');
                                    IF TemplateMessages.FINDFIRST THEN BEGIN

                                        TemplateMessages.CALCFIELDS("Message Text");
                                        TemplateMessages."Message Text".CREATEINSTREAM(IStream);
                                        TextMsg.READ(IStream);

                                        Body.ADDTEXT(ReplaceString(FORMAT(TextMsg), '@RadnoMjesto', Rec.Position));

                                        NameAndSurrnameList := '';
                                        CandidatePosting.RESET;
                                        //ĐK      CandidatePosting.SETFILTER("Posting No.", '%1', Rec."Posting No.");
                                        CandidatePosting.SETFILTER("Employment Date", '<>%1', 0D);
                                        IF CandidatePosting.FINDFIRST THEN
                                            REPEAT
                                                NameAndSurrnameList := NameAndSurrnameList + CandidatePosting.Name + ' ' + CandidatePosting.Surname + ', ';
                                            UNTIL CandidatePosting.NEXT = 0;

                                        Body1.ADDTEXT(ReplaceString(FORMAT(Body), '@ImePrezime', Rec.Name + ' ' + Rec.Surname));

                                        Subject := 'Povratna informacija_prijava na interni oglas za radno mjesto ' + Rec.Position;

                                        SMTPSetup.GET;
                                      
                                        MESSAGE('Mail je uspješno poslan!');
                                        "Feedback Sent" := TRUE;

                                        //HRSetup.GET;
                                        //SMTPMail.CreateMessage(HRSetup."Sender Name",HRSetup."E-mail Sender", CandidateMail, Subject, FORMAT(Body1),TRUE);
                                        //SMTPMail.Send();
                                        //MESSAGE('Mail je uspješno poslan!');
                                        //"Feedback Sent" := TRUE;

                                    END;

                                END ELSE BEGIN
                                    Feedback := '';
                                END;

                            END;
                END;


            end;
        }
        field(12; "Feedback Sent"; Boolean)
        {
            Caption = 'Feedback Sent';
            Editable = false;
        }
        field(20; "Employment Date"; Date)
        {
            Caption = 'Employment Date';

            trigger OnValidate()
            begin
                IF "Employment Date" <> 0D THEN BEGIN


                    IF CONFIRM('Da li zelite prebaciti kandidata u listu zaposlenika?') = TRUE THEN BEGIN

                        Candidates.RESET;
                        Candidates.SETFILTER("Serial Number", '%1', "Serial Number");
                        IF Candidates.FINDFIRST THEN BEGIN

                            IF Candidates.Candidate = Candidates.Candidate::Internal THEN BEGIN
                                ERROR('Odabrali ste internog kandidata koji vec postoji u bazi!');
                            END ELSE BEGIN
                                Employee.INIT;
                                //Employee.VALIDATE("No.",'');
                                Employee.VALIDATE("First Name", Candidates.Name);
                                Employee.VALIDATE("Last Name", Candidates.Surname);
                                Employee.VALIDATE("Maiden Name", Candidates."Maiden Name");
                                Employee.VALIDATE("Father Name", Candidates."Father Name");
                                Employee.VALIDATE(Gender, Candidates.Gender);
                                Employee.VALIDATE("Place Of Living", Candidates."Place of living");
                                Employee.VALIDATE("Birth Date", Candidates."Date of Birth");
                                Employee.VALIDATE("E-Mail", Candidates."E-mail");
                                Employee.VALIDATE("Country/Region Code Home", Candidates."Country/Region Code Home");
                                Employee.VALIDATE("Dial Code Home", Candidates."Dial Code Home");
                                IF Candidates."Phone No." <> '' THEN
                                    Employee.VALIDATE("Phone No.", Candidates."Phone No.");
                                Employee.VALIDATE("Full Phone No.", Candidates."Full Phone No.");
                                Employee.VALIDATE("Driving Licence", Candidates."Driving License");
                                Employee.VALIDATE(Status, Candidates."Candidate status at the moment");

                                //Employee.VALIDATE("School of Graduation", Candidates."Name of edu. institution");

                                Employee.INSERT;
                                EmployeeCard.RUN;


                            END;

                        END;

                    END;

                END;
            end;
        }
        field(21; Selection; Text[30])
        {
            Caption = 'Selection';
            Editable = false;
        }
        field(22; "Appropriate Profile for Bank"; Boolean)
        {
            Caption = 'Appropriate Profile for Bank';
            Editable = false;
        }


    }

    keys
    {
        key(Key1; "Serial Number", Selection)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Candidates: Record "Candidates";
        //    Posting: Record "Posting";
        //ĐK  SMTPMail2: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        TemplateMessages: Record "Template Messages";
        TextMsg: BigText;
        IStream: InStream;
        Subject: Text;
        "E-mail": Text;
        HRSetup: Record "Human Resources Setup";
        EmailBodyText: Text;
        i: Integer;
        Pos: Integer;
        Body: BigText;
        Body1: BigText;
        CandidatePosting: Record "Candidate/Posting";
        NameAndSurrnameList: Text;
        CandidateMail: Text;
        Mail: Codeunit "Mail";
        Employee: Record "Employee";
        EmployeeCard: Page "Employee Card";

    procedure WhereToSplit(InText: Text; Pozicija: Integer) Rezultat: Text
    begin
        i := STRLEN(InText);
        IF i = 0 THEN
            EXIT;
        WHILE (NOT (InText[i] IN [' ', ',', '.'])) AND (i > 1) DO
            i -= 1;
        Pos += i;
        IF i > 0 THEN
            Rezultat := COPYSTR(InText, 1, i);
    end;

    procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO

            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;
}

*/