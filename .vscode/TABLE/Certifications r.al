/*ĐK table 50251 "Certifications r"
{
    // HR01-30.11.2016 HR customization

    Caption = 'Certifications and solutions';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = 5221;
    LookupPageID = 5221;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(50011; "Employee Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;

        }
        field(50012; "Employee Last Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;

        }
        field(50013; "Date Of Input Info"; Date)
        {
            Caption = 'Date of input information';
        }
        field(50015; "Sector Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(50016; "Group Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;

        }
        field(50017; "Team Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;

        }
        field(50018; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;

        }
        field(50020; "Agreement Code"; Code[30])
        {
            Caption = 'Agreement code';
        }
        field(50021; Group; Option)
        {
            Caption = 'Group';
            FieldClass = Normal;
            OptionCaption = ' ,Certification,Solutions,Decisions';
            OptionMembers = " ",Certification,Solutions,Decisions;
        }
        field(50022; "Document Description"; Text[90])
        {
            Caption = 'Document description';
            TableRelation = "Certication and solu"."Document Description" WHERE(Group = FIELD(Group),
                                                                                 "Show Template" = FILTER(TRUE));

            trigger OnValidate()
            begin
                IF "Document Description" <> '' THEN BEGIN
                    CerAndSol.RESET;
                    CerAndSol.SETFILTER("Document Description", '%1', "Document Description");
                    CerAndSol.SETFILTER("Show Template", '%1', TRUE);
                    IF CerAndSol.FINDFIRST THEN BEGIN
                        "Agreement Code" := CerAndSol."Agreement Code";
                        Group := CerAndSol.Group;
                    END;
                END
                ELSE BEGIN
                    "Agreement Code" := '';
                    Group := 0;
                END;

 
                CLEAR(FileManagement);


                IF CerAndSol."NAV Agreement Code" = 88 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK  Contract88.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract88.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 87 THEN BEGIN
                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract87.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract87.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 115 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract115.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract115.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;




                IF CerAndSol."NAV Agreement Code" = 5061 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract5061.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5061.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5062 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract5062.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract5062.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5063 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract5063.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5063.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 129 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract129.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract129.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 187 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract187.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract187.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 188 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract188.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract188.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 189 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract189.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract189.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 190 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract190.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract190.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 191 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract191.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract191.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 192 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract192.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract192.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 193 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract193.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract193.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 215 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract215.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract215.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 216 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract216.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract216.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 291 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK    Contract291.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract291.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 292 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract292.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract292.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 296 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract296.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract296.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 297 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract297.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract297.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 298 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract298.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract298.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 319 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract319.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract319.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 322 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract322.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract322.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 324 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract324.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract324.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 406 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract406.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract406.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 407 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract407.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract407.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 408 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK            Contract408.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK           Contract408.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
                IF CerAndSol."NAV Agreement Code" = 410 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK               Contract410.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK         Contract410.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 412 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract412.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract412.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 415 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract415.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract415.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 416 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract416.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract416.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 417 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK          Contract417.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract417.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 418 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract418.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract418.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 491 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK            Contract491.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract491.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 496 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK  Contract496.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract496.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 497 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK Contract497.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK Contract497.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 498 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK   Contract498.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract498.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 499 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract499.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract499.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;



                IF CerAndSol."NAV Agreement Code" = 5064 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5064.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5064.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5066 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5066.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5066.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5178 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5178.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5178.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;


                IF CerAndSol."NAV Agreement Code" = 5179 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5179.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5179.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5180 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK     Contract5180.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK  Contract5180.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5188 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5188.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5188.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5189 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5189.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5189.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5190 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5190.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5190.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5193 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5193.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5193.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5194 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract5194.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5194.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5195 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5195.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5195.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5196 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5196.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5196.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5197 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5197.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5197.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5198 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5198.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5198.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5199 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5199.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK   Contract5199.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5606 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK      Contract5606.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5606.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5607 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5607.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5607.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5608 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK         Contract5608.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5608.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5610 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5610.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5610.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5611 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5611.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5611.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5620 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK          Contract5620.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK     Contract5620.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5621 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK        Contract5621.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK      Contract5621.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5622 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK           Contract5622.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK       Contract5622.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;

                IF CerAndSol."NAV Agreement Code" = 5623 THEN BEGIN


                    CRL.SETFILTER("Report ID", '%1', CerAndSol."NAV Agreement Code");
                    IF CRL.FINDLAST THEN BEGIN
                        ReportLayoutSelection.SetTempLayoutSelected(FORMAT(CRL."REPORT ID"));
                        Cert.SETFILTER("Employee No.", '%1', Rec."Employee No.");

                        BrojPotvrda := 0;
                        Cert1.RESET;
                        Cert1.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                        Cert1.SETFILTER(Group, '%1', Rec.Group);
                        IF Cert1.FIND('-') THEN BEGIN
                            BrojPotvrda := Cert1.COUNT;
                        END;
                        //ĐK       Contract5623.SetParam("Employee No.",Rec."Agreement Code",0,Rec."Date Of certifications");
                        hr.GET;

                        tempSaveDest := hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx';
                        //ĐK    Contract5623.SAVEASWORD(tempSaveDest);
                        FileManagement.DownloadToFile(tempSaveDest, tempSaveDest);
                        IF Attachment.GET("Attachment No.") THEN
                            Attachment.TESTFIELD("Read Only", FALSE);

                        IF "Attachment No." <> 0 THEN BEGIN
                            IF NOT CONFIRM(Text004, FALSE) THEN
                                EXIT;
                            RemoveAttachment(FALSE);
                            "Attachment No." := 0;
                            MODIFY(FALSE);
                            COMMIT;
                        END;

                        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
                        IF NewAttachNo <> 0 THEN BEGIN
                            "Attachment No." := NewAttachNo;

                            COMMIT;
                        END;


                    END;
                    ImportAttachment;
                END;
            end;
        }
        field(50023; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(50024; "Date Of certifications"; Date)
        {
            Caption = 'Date Of certifications';
        }
        field(50025; "NAV Agreement Code"; Integer)
        {
            Caption = 'Agreement code';
        }
        field(50026; "Attachment No."; Integer)
        {
        }
        field(50405; Change; Boolean)
        {
            Caption = 'Change';
        }
        field(50406; "Number for Certification"; Integer)
        {
            Caption = 'Number for Certification';
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Document Description", "Agreement Code", ID)
        {
        }
        key(Key2; "Document Description")
        {
        }
    }

    fieldgroups
    {

    }

    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
    end;

    trigger OnInsert()
    begin
        "Date Of Input Info" := TODAY;
        "Number for Certification" := 2;
    end;

    var
        Employee: Record "Employee";
        EmployeeRelative: Record "Employee Relative";
        Relative: Record "Relative";
        CerAndSol: Record "Certication and solu";
        Text001: Label 'End Date must not be before Start date.';
        //ĐK   InteractTmplLanguage: Record "Awards";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        CertCheck: Record "Certifications r";
        BrojPotvrda: Integer;
        Text004: Label 'Replace existing attachment?';
        AttachmentRecord: Record "Attachment";
        Text005: Label 'You have canceled the import process.';
        Text006: Label 'Export Attachment';
        //ĐK ContractR: Report "60524";
        DR: Record "Certication and solu";
        Cert: Record "Certifications r";
        Cert1: Record "Certifications r";
        FileManagement: Codeunit "File Management";
        CRL: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        tempSaveDest: Text;
        Text000: Label 'Start Date must have value.';
        Text002: Label 'Personalni broj ne smije biti prazan!';
        Text003: Label 'You have canceled the create process.';
        Text007: Label 'Da li ste sigurni da zelite promijeniti vrijednost polja iz %1 u %2?';
        NewAttachNo: Integer;
        //ĐK Contract2Rreport: Report "60525";
        //ĐK  Contract3: Report "60526";
        //ContractStazIStrucna: Report "65549";
        // ContractOPlacenomFBIH: Report "65550";
        hr: Record "Human Resources Setup";
    

    procedure CreateAttachment()
    var
        Attachment: Record "Attachment";
        InteractTmplLanguage: Record "Employee Contract Ledger";
        WordManagement: Codeunit "WordManagement";
        NewAttachNo: Integer;
    begin
      

    end;

    procedure OpenAttachment()
    var
        Attachment: Record "Attachment";
    begin

        IF "Attachment No." = 0 THEN
            EXIT;
        Attachment.GET("Attachment No.");
        Attachment.OpenAttachment("Employee No.", FALSE, '');
    end;

    procedure CopyFromAttachment()
    var
        InteractTmplLanguage: Record "Interaction Tmpl. Language";
        Attachment: Record "Attachment";
        AttachmentManagement: Codeunit "AttachmentManagement";
        NewAttachNo: Integer;
    begin
        IF Attachment.GET("Attachment No.") THEN
            Attachment.TESTFIELD("Read Only", FALSE);

        IF "Attachment No." <> 0 THEN BEGIN
            IF NOT CONFIRM(Text004, FALSE) THEN
                EXIT;
            RemoveAttachment(FALSE);
            "Attachment No." := 0;
            MODIFY;
            COMMIT;
        END;


        NewAttachNo := AttachmentManagement.InsertAttachment("Attachment No.");
        IF NewAttachNo <> 0 THEN BEGIN
            "Attachment No." := NewAttachNo;
            MODIFY;
        END;
    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;

        CertCheck.RESET;
        CertCheck.SETFILTER("Employee No.", '%1', Rec."Employee No.");
        CertCheck.SETFILTER(Group, '%1', Rec.Group);
        IF CertCheck.FIND('-') THEN BEGIN
            BrojPotvrda := CertCheck.COUNT;
        END;
        IF Group = Group::Certification THEN BEGIN
            //ĐK  Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;
        IF Group = Group::Solutions THEN BEGIN
            //ĐK Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;
        IF Group = Group::Decisions THEN BEGIN
            //ĐK  Attachment.SetParam1(Rec."Employee No.", 3, Rec.ID);
            hr.GET;
            IF Attachment.ImportAttachmentFromClientFile(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx', FALSE, FALSE) THEN BEGIN
                "Attachment No." := Attachment."No.";
            END;
        END;


        IF EXISTS(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx') THEN
            ERASE(hr."File Path" + "Employee No." + '-' + FORMAT(BrojPotvrda) + '.docx');
    end;

    procedure ExportAttachment()
    var
        //   TempBlob: Record "TempBlob";
        MarketingSetup: Record "Marketing Setup";
        FileMgt: Codeunit "File Management";
        FileName: Text[1024];
        FileFilter: Text;
        ExportToFile: Text;
    begin
        MarketingSetup.GET;
        ExportToFile := '';
        IF AttachmentRecord.GET("Attachment No.") THEN
            WITH AttachmentRecord DO BEGIN
                IF "Storage Type" = "Storage Type"::Embedded THEN BEGIN
                   
                END ELSE BEGIN
                    IF "Storage Type" = "Storage Type"::"Disk File" THEN BEGIN
                        IF MarketingSetup."Attachment Storage Type" = MarketingSetup."Attachment Storage Type"::"Disk File" THEN
                            MarketingSetup.TESTFIELD("Attachment Storage Location");
                        FileFilter := UPPERCASE("File Extension") + ' (*.' + "File Extension" + ')|*.' + "File Extension";
                    END;

                    ExportToFile := "Employee No." + '.' + "File Extension";
                    DOWNLOAD(ConstDiskFileName, Text005, '', FileFilter, ExportToFile);
                END;
            END;
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        IF Attachment.GET("Attachment No.") THEN
            IF Attachment.RemoveAttachment(Prompt) THEN BEGIN
                "Attachment No." := 0;
                MODIFY;
            END;

    end;
}

*/