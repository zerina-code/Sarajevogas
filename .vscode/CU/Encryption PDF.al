codeunit 50008 EncryptPDF
{

    trigger OnRun()
    begin
    end;

    var
        PdfReader: DotNet PdfReader;
        PdfDocument: DotNet PdfDocument;
        securitySettings: DotNet PdfSecuritySettings;
        FileMgt: Codeunit "File Management";
        FileNameWithPassword: Text;
        SleepForMs: Integer;
        ownerPassword: Text;
        ServerTempFileName2: Text;
        PdfDocumentOpenMode: DotNet PdfDocumentOpenMode;
        PayList: Report "Pay List Final";
        ServerTempFileName: Text;
        ClientTempFileName: Text;
        accReminder: Report AccusationReminder;
        accReminder_Issued: Report IssuedAccusationReminder;
        Serv: Text;
        Serv2: Text;
        ClientFile: Text;
        nativeReminder: Report "30DReminder";

    procedure CreatePdfWithPasswordForEmployee(PdfFileName: Text; Employee: Record "Employee"; IdM: Integer; IdY: Integer) PathV: Text
    begin
        ownerPassword := Employee."Employee ID";

        // IF Setup.GET() THEN
        //   SleepForMs := Setup.Sleep;
        IF SleepForMs < 3000 THEN
            SleepForMs := 3000;



        FileNameWithPassword := EncryptPdf(PdfFileName, Employee."Employee ID", ownerPassword, IdM, IdY, Employee);

        SLEEP(SleepForMs);

        EXIT(FileNameWithPassword);
        PathV := FileNameWithPassword;
    end;

    local procedure EncryptPdf(iFileName: Text; userPassword: Text; ownerPassword: Text; IdM1: Integer; IdY1: Integer; Emp: Record Employee): Text
    var
        employeeR: Record employee;
        Zaposlenik: Text[1000];
    begin
        // odpri pdf, ki je shranjen na disku

        //ĐK ClientFile := FileMgt.ClientTempFileName('pdf');

        ServerTempFileName := FileMgt.ServerTempFileName('pdf');


        Zaposlenik := Emp."No.";

        employeeR.Reset();
        employeeR.SetFilter("No.", '%1', Zaposlenik);
        employeeR.FindFirst();

        //\\SERVER3\ProgramData\Microsoft\Microsoft Dynamics NAV\90\Server\MicrosoftDynamicsNavServer$RAIFFEISEN\users\default\SARAJEVO-INFODO\DJEMINA.KARALIC\TEMP

        //C:\ProgramData\Microsoft\Microsoft Dynamics NAV\90\Server\MicrosoftDynamicsNavServer$RAIFFEISEN\users\default\SARAJEVO-INFODO\DJEMINA.KARALIC\TEMP

        Clear(PayList);
        PayList.SetPayList(IdM1, IdY1);
        PayList.SETTABLEVIEW(employeeR);
        PayList.SAVEASPDF(ServerTempFileName);


        Serv := '\\SERVER6\' + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName));

        PdfDocument := PdfReader.Open(ServerTempFileName);


        // manipulacija s pdf-fom

        //*****************************
        // zaščita z geslom
        //*****************************
        securitySettings := PdfDocument.SecuritySettings();
        // Setting one of the passwords automatically sets the security level to
        // PdfDocumentSecurityLevel.Encrypted128Bit.
        securitySettings.UserPassword := userPassword;
        securitySettings.OwnerPassword := ownerPassword;

        // Restrict some rights.
        securitySettings.PermitAccessibilityExtractContent := FALSE;
        securitySettings.PermitAnnotations := FALSE;
        securitySettings.PermitAssembleDocument := FALSE;
        securitySettings.PermitExtractContent := FALSE;
        securitySettings.PermitFormsFill := FALSE;
        securitySettings.PermitFullQualityPrint := FALSE;
        securitySettings.PermitModifyDocument := FALSE;
        securitySettings.PermitPrint := TRUE;

        // zapiši popravljen pdf

        ServerTempFileName2 := FileMgt.ServerTempFileName('pdf');

        Serv2 := '\\SERVER6\' + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName2));


        PdfDocument.Save(ServerTempFileName2);



        EXIT(ServerTempFileName2);
    end;

    procedure EncryptPdfForAccusation(iFileName: Text; IdM1: Integer; IdY1: Integer; Acc: Record "Reminder Header"; reportType: Enum ReminderReportType): Text
    var
        accusation: Record "Reminder Header";
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
    begin
        IF SleepForMs < 3000 THEN
            SleepForMs := 3000;
        ServerTempFileName := FileMgt.ServerTempFileName('pdf');
        Clear(accReminder);
        Clear(nativeReminder);
        if reportType = ReminderReportType::Custom then begin

            CRL.Reset();
            CRL.SetFilter("Report ID", '%1', 50144);
            crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
            if crl.FindFirst() then begin
                RLS.SetTempLayoutSelected(crl.Code);
                accReminder.SetAccusation(Acc."No.");
                accReminder.SETTABLEVIEW(Acc);
                accReminder.SAVEASPDF(ServerTempFileName);

            end;

        end else begin
            nativeReminder.SetParam(Acc."No.");
            nativeReminder.SETTABLEVIEW(Acc);
            nativeReminder.SAVEASPDF(ServerTempFileName);
        end;
        Serv := '\\SERVER6\' + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName));

        PdfDocument := PdfReader.Open(ServerTempFileName);

        securitySettings := PdfDocument.SecuritySettings();

        securitySettings.PermitAccessibilityExtractContent := FALSE;
        securitySettings.PermitAnnotations := FALSE;
        securitySettings.PermitAssembleDocument := FALSE;
        securitySettings.PermitExtractContent := FALSE;
        securitySettings.PermitFormsFill := FALSE;
        securitySettings.PermitFullQualityPrint := FALSE;
        securitySettings.PermitModifyDocument := FALSE;
        securitySettings.PermitPrint := TRUE;

        ServerTempFileName2 := FileMgt.ServerTempFileName('pdf');

        Serv2 := '\\SERVER6\' + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName2));

        PdfDocument.Save(ServerTempFileName2);
        SLEEP(SleepForMs);
        EXIT(ServerTempFileName2);
    end;

    procedure EncryptPdfForAccusationIss(iFileName: Text; IdM1: Integer; IdY1: Integer; Acc: Record "Issued Reminder Header"; reportType: Enum ReminderReportType): Text
    var
        accusation: Record "Issued Reminder Header";
        Comp: Record "Company Information";
        CRL: Record "Custom Report Layout";
        RLS: Record "Report Layout Selection";
    begin
        Comp.get;
        IF SleepForMs < 3000 THEN
            SleepForMs := 3000;
        ServerTempFileName := FileMgt.ServerTempFileName('pdf');
        Clear(accReminder_Issued);
        Clear(nativeReminder);
        if reportType = ReminderReportType::Custom then begin
            /* accReminder_Issued.SetAccusation(Acc."No.");
             accReminder_Issued.SETTABLEVIEW(Acc);
             accReminder_Issued.SAVEASPDF(ServerTempFileName);*/
            CRL.Reset();
            CRL.SetFilter("Report ID", '%1', 50155);
            crl.SetFilter(Description, '%1', 'Kopija Ugrađeni izgled');
            if crl.FindFirst() then begin
                RLS.SetTempLayoutSelected(crl.Code);
                accReminder_Issued.SetAccusation(Acc."No.");
                accReminder_Issued.SETTABLEVIEW(Acc);
                accReminder_Issued.SAVEASPDF(ServerTempFileName);

            end;


        end else begin
            nativeReminder.SetParam(Acc."No.");
            nativeReminder.SETTABLEVIEW(Acc);
            nativeReminder.SAVEASPDF(ServerTempFileName);
        end;
        Serv := Comp."Path for Documents" + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName));

        PdfDocument := PdfReader.Open(ServerTempFileName);

        securitySettings := PdfDocument.SecuritySettings();

        securitySettings.PermitAccessibilityExtractContent := FALSE;
        securitySettings.PermitAnnotations := FALSE;
        securitySettings.PermitAssembleDocument := FALSE;
        securitySettings.PermitExtractContent := FALSE;
        securitySettings.PermitFormsFill := FALSE;
        securitySettings.PermitFullQualityPrint := FALSE;
        securitySettings.PermitModifyDocument := FALSE;
        securitySettings.PermitPrint := TRUE;

        ServerTempFileName2 := FileMgt.ServerTempFileName('pdf');

        Serv2 := Comp."Path for Documents" + COPYSTR(ServerTempFileName, 4, STRLEN(ServerTempFileName2));

        PdfDocument.Save(ServerTempFileName2);
        SLEEP(SleepForMs);
        EXIT(ServerTempFileName2);
    end;
}