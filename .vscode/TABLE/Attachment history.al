table 50153 "A-B Attachments"
{
    Caption = 'A-B Attachments';
    DrillDownPageID = "A-B Attachment";
    LookupPageID = "A-B Attachment";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'No.';
            Editable = false;

            //ipak ne

        }
        field(2; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = True;
        }

        field(50395; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
        }
        field(3; "Document Type"; Text[250])
        {
            Caption = 'No.';
            TableRelation = "Employment Contract".Code where(Type = field(Type));

            trigger OnValidate()
            var
                myInt: Integer;
                EC: Record "Employment Contract";
                crl: Record "Custom Report Layout";
                ReportLayoutSelection: Record "Report Layout Selection";
                HRSetup: Record "Human Resources Setup";

                Report50101: Report "INF-TU-03-10-01";
                Report50103: Report "SG-TU-03-09-01";
                FileManagement: Codeunit "File Management";
                Attachment: Record Attachment;
                Text004: Label 'Replace existing attachment?';
                ECL: Record "Employee Contract Ledger";
                AttachmentManagement: codeunit AttachmentManagement;
                DOcNew: code[20];
                NoSeriesMgt: Codeunit NoSeriesExtented;

            begin
                ec.reset;
                ec.setfilter(Code, '%1', rec."Document Type");
                if ec.FindFirst() then begin

                    if ec."Custom Report Layout" <> '' then begin
                        crl.Reset();
                        crl.SetFilter("Report ID", '%1', ec."NAV ID");
                        crl.SetFilter(Code, '%1', ec."Custom Report Layout");
                        IF CRL.FindFirst() THEN BEGIN


                            ReportLayoutSelection.SetTempLayoutSelected(format(CRL.Code));

                            //    Contract1.SetParam("Employee No.", Rec."Agremeent Code", Rec."No.", 0D);
                            HRSetup.GET;

                            tempSaveDest := HRSetup."File Path" + crl.Description + '-' + FORMAT(rec."Document No.") + '.docx';
                            if crl."Report ID" = 50101 then begin
                                DOcNew := NoSeriesMgt.GetNextNo(ec."No Series", TODAY, false);
                                Report50101.SetParam(Code, DOcNew);
                                rec."Document No." := DOcNew;
                                Report50101.SAVEASWORD(tempSaveDest);

                            end;

                            if crl."Report ID" = 50103 then begin
                                DOcNew := NoSeriesMgt.GetNextNo(ec."No Series", TODAY, false);
                                Report50103.SetParam(Code, DOcNew);
                                rec."Document No." := DOcNew;
                                Report50103.SAVEASWORD(tempSaveDest);

                            end;


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

                    end;
                end;
            end;

        }

        field(4; "Document Type Code"; Code[20])
        {
            Caption = 'No.';

        }
        field(50004; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Customer,Reason,Service Order,Customer Documents';
            OptionMembers = Employee,Customer,Reason,"Service Order","Customer Documents";
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; "Notary Name"; Text[250])
        {
            Caption = 'Notary Name';
        }
        field(7; "OPU-IP"; Text[250])
        {
            Caption = 'OPU-IP';
        }
        field(8; "Court Number"; Text[250])
        {
            Caption = 'Court Number';
        }
        field(9; "Decision No."; Text[250])
        {
            Caption = 'Desicion No.';
        }
        field(10; "File Name"; text[250])
        {
            Caption = 'File Name';
        }
        field(11; "File Extension"; text[250])
        {
            Caption = 'File Extension';
        }
        field(12; "Content"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Source"; enum "Attachment Source")
        {
            Caption = 'Source';
        }
        field(14; "No. Series"; code[20])
        {
            Caption = 'No. Series';
        }
        field(15; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(60020; "Real. Process. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Real. Process. Empl. Name" := FindEmployee("Real. Process. Empl. No.");


            end;
        }
        field(60021; "Real. Contr. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Real. Contr. Empl. Name" := FindEmployee("Real. Contr. Empl. No.");

            end;

        }
        field(60022; "Real. Verif. Empl. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Real. Verif. Empl. Name" := FindEmployee("Real. Verif. Empl. No.");

            end;
        }

        field(70118; "Real. Process. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Processing Employee Name';

        }
        field(70119; "Real. Contr. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Controlling Employee Name';

        }
        field(70120; "Real. Verif. Empl. Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Realisation - Verification Employee Name';

        }
        field(70122; "Real. Exe Employee Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Real. Exe Employee Name';

        }
        field(70123; "Real. Exe No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Real. Exe No';

        }
        field(70124; "Real. Exe Postion Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Real. Postion Name';

        }
        field(60070; "Request File"; Blob)
        {
            Caption = 'Request File', Comment = 'Datoteka zahtjeva';
            DataClassification = CustomerContent;
        }
        field(60071; "Request File Name"; Text[100])
        {
            Caption = 'Request File Name', Comment = 'Naziv priložene datoteke';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60072; "Descendants"; Text[250])
        {
            Caption = 'Descendants';


            //ipak ne

        }
        field(60073; "BR"; Text[250])
        {
            Caption = 'BR';


            //ipak ne

        }
        field(60074; "ZK No."; Text[250])
        {
            Caption = 'ZK No.';


            //ipak ne

        }
        field(60075; "KPU"; Text[250])
        {
            Caption = 'KPU';


            //ipak ne

        }
        field(60076; "Previous Customer"; Text[250])
        {
            Caption = 'Previous Customer';


            //ipak ne

        }
        field(60077; "JIB Customer"; Text[250])
        {
            Caption = 'JIB Customer';


            //ipak ne

        }
        field(60078; "Dispatch"; Text[250])
        {
            Caption = 'Dispatch';


            //ipak ne

        }
        field(60079; "K.O"; Text[250])
        {
            Caption = 'K.O';


            //ipak ne

        }
        field(60080; "Customer buyer"; Text[250])
        {
            Caption = 'Customer buyer';


            //ipak ne

        }
        field(60081; Municipality; Code[20])
        {
            Caption = 'Municipality';
            TableRelation = Municipality;
            trigger OnValidate()
            var
                myInt: Integer;
                Mun: Record Municipality;
            begin
                Mun.Reset();
                mun.SetFilter(Code, '%1', Municipality);
                if Mun.FindFirst() then begin
                    "Municipality Name" := Mun.Name;

                end
                else begin
                    "Municipality Name" := '';

                end;

            end;


            //ipak ne

        }
        field(60082; "Municipality Name"; text[250])
        {
            Caption = 'Municipality';


            //ipak ne

        }










    }

    keys
    {
        key(Key1; Code, "No.", Source, Type)
        {
        }
    }

    var
        NewAttachNo: Integer;
        tempSaveDest: Text[250];
        HRSetup: Record "Human Resources Setup";
        Comp: Record "Company Information";

    trigger OnInsert()
    var
        myInt: Integer;
        SH: Record "Service Header";
        ecl_x: Record "Employee Contract Ledger";
        empg: Record Employee;
    begin
        if "Document Date" = 0D then
            "Document Date" := Today;

        Comp.get;
        if (rec."Real. Verif. Empl. No." = '') and (rec."Real. Contr. Empl. No." = '') and (rec."Real. Process. Empl. No." = '') and (rec."Real. Exe No" = '') then begin
            sh.Reset();
            sh.SetFilter("No.", '%1', Code);

            if sh.findfirst then begin
                rec."Real. Contr. Empl. No." := sh."Real. Contr. Empl. No.";
                rec."Real. Process. Empl. No." := sh."Real. Process. Empl. No.";
                rec."Real. Verif. Empl. No." := sh."Real. Verif. Empl. No.";
                rec."Real. Contr. Empl. Name" := sh."Real. Contr. Empl. Name";
                rec."Real. Process. Empl. Name" := sh."Real. Process. Empl. Name";
                rec."Real. Verif. Empl. Name" := sh."Real. Verif. Empl. Name";
                rec."Real. Exe No" := comp."Spending Plan Responsible Person";
                if empg.get(rec."Real. Exe No") then begin
                    rec."Real. Exe Employee Name" := empg."First Name" + ' ' + empg."Last Name";
                    ecl_x.Reset();
                    ecl_x.SetFilter("Employee No.", '%1', empg."No.");
                    ecl_x.SetFilter(Active, '%1', true);
                    if ecl_x.FindFirst() then
                        rec."Real. Exe Postion Name" := ecl_x."Position Description"
                    else
                        rec."Real. Exe Postion Name" := '';
                end;

            end;
        end;
    end;


    procedure FindEmployee(var No: code[20]) EmployeeName: Text[250]
    var
        Empl: Record employee;
    begin
        empl.Reset();
        empl.SetFilter("No.", '%1', No);
        if empl.FindFirst() then begin
            EmployeeName := Empl."First Name" + ' ' + Empl."Last Name";
        end
        else begin
            EmployeeName := '';
        end;


    end;

    procedure ImportAttachment()
    var
        Attachment: Record "Attachment";
    begin
        IF "Attachment No." <> 0 THEN BEGIN
            IF Attachment.GET("Attachment No.") THEN
                Attachment.TESTFIELD("Read Only", FALSE);

        END;

        //Attachment.SetParam(Rec."Employee No.", "No.", 1);
        IF Attachment.ImportAttachmentFromClientFile2(tempSaveDest, FALSE, FALSE)

       THEN BEGIN
            "Attachment No." := Attachment."No.";
            MODIFY;
        END;
        HRSetup.GET;
        IF EXISTS(tempSaveDest) THEN
            ERASE(tempSaveDest);


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
