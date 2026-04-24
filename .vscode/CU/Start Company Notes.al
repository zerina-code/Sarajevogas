codeunit 50015 "Start Company Notes"
{
    //  NK01 01.04.2014 CUSTOMIZATION
    //  Test posting
    // AS 1.00 08.04.2014
    // Test Posting togle body visibility

    SingleInstance = true;

    trigger OnRun()
    var
        //    CompanyNotesSetup: Record "BaH Fiscal Item";
        ErrMsg: Text[30];
    begin
    end;

    var
        globDBSERVER: Text[50];
        globDATABASE: Text[50];
        TXT0001: Label 'Invalid parameter';
        PostingPrediction: Boolean;
        TempGLE: Record TempGLE temporary;
        TestDoneOk: Boolean;
        tempEntryNo: Integer;
        TXT50001: Label 'Test posting finished';
        TXT50002: Label 'Fatal error';
        TXT50003: Label 'Posting Error is not identified. Run test report first.';
        HeaderText: Text[1024];
        //đk  TestPostReport: Report "Test Posting";
        Username: Text;

    procedure GetParamT(ParameterName: Code[20]) ParamValue: Text[255]
    begin

        CASE ParameterName OF
            'DBSERVER':
                ParamValue := globDBSERVER;
            'DATABASE':
                ParamValue := globDATABASE;
            'ERR50001':
                ParamValue := TXT50001;
            'ERR50002':
                ParamValue := TXT50002;
            'ERR50003':
                ParamValue := TXT50003;
            ELSE
                ERROR(TXT0001);
        END
    end;

    procedure SetParamT(ParameterName: Code[20]; ParamValue: Text[255])
    begin

        CASE ParameterName OF
            'DBSERVER':
                globDBSERVER := ParamValue;
            'DATABASE':
                globDATABASE := ParamValue;
            'HEADERTEXT':
                HeaderText := ParamValue;
            ELSE
                ERROR(TXT0001);
        END
    end;

    procedure ClearTempGLE()
    begin
        CLEAR(TempGLE);
        TempGLE.RESET;
        TempGLE.DELETEALL;
        tempEntryNo := 0;
    end;

    procedure InsertGLEIntoTempGLE(GLE: Record "G/L Entry")
    var
        TempDebitAmount: Text[30];
        TempCreditAmount: Text[30];
    begin
        tempEntryNo := tempEntryNo + 1;
        TempGLE.TRANSFERFIELDS(GLE, FALSE);
        TempGLE."Entry No." := tempEntryNo;
        TempGLE.INSERT;
    end;

    procedure SetPostingPrediction()
    begin
        PostingPrediction := TRUE;
        TestDoneOk := FALSE;
    end;

    procedure ResetPostingPrediction()
    begin
        PostingPrediction := FALSE;
    end;

    procedure GetPostingPrediction() PP: Boolean
    begin
        PP := PostingPrediction;
    end;

    procedure GetPostingPredictionData(DetailsVar: Boolean)
    var
        //ĐK TestPosting: Report "Test Posting";
        ReportName: Text;
        FileVar: File;
        IStream: InStream;
        MagicPath: Text;
        //ĐK  FileSystemObject: Automation ;
        DestinationFileName: Text;
    begin
        //FORM.RUN(20,TempGLE);
        //đk   TestPosting.SetHeaderText(HeaderText);
        // đk TestPosting.SetGLEntry(TempGLE);

        //AS 1.00 START
        //TestPosting.SETTABLEVIEW(TempGLE);
        //đk  TestPosting.SetDetail(DetailsVar);
        //TestPosting.RUN;
        //END
        //-------
        Username := CONVERTSTR(USERID, '\', '-');
        Username := CONVERTSTR(Username, '/', '-');
        Username := CONVERTSTR(Username, '.', '-');
        ReportName := Username + ' Testposting report.pdf';
        //Save report as PDF on server
        //đk  TestPosting.SAVEASPDF('C:\Temp\'+ ReportName);

        //Move file to RTC client. '<TEMP>' gives us a temporary location without a savedialog. Magicpath is the location on the RTC
        IF NOT ISSERVICETIER THEN
            EXIT;
        FileVar.OPEN('C:\Temp\' + ReportName);
        FileVar.CREATEINSTREAM(IStream);
        DOWNLOADFROMSTREAM(IStream, '', '<TEMP>', '', MagicPath);
        FileVar.CLOSE;

        /*    CREATE(FileSystemObject,TRUE,TRUE);
            DestinationFileName := 'C:\Temp\'+ReportName;
            IF FileSystemObject.FileExists(DestinationFileName) THEN
              FileSystemObject.DeleteFile(DestinationFileName,TRUE);
            FileSystemObject.MoveFile(MagicPath,DestinationFileName);

            HYPERLINK(DestinationFileName);*/

        //HYPERLINK('C:\Temp\'+ ReportName);
        //----

        HeaderText := '';
    end;

    procedure GetTestDoneOk() TstDoneOk: Boolean
    begin
        TstDoneOk := TestDoneOk;
    end;

    procedure SetTestDoneOk(TstDoneOk: Boolean)
    begin
        TestDoneOk := TstDoneOk;
    end;
}

