/*report 50035 Timesheets
{
    Caption = 'Absences Workbook';
    ProcessingOnly = true;

    dataset
    {
        dataitem(DataItem1; Department)
        {
            dataitem(DataItem2; Employee)
            {
                DataItemTableView = WHERE(Status = CONST(Active),
                                          "Potential Employee" = CONST(false));

                trigger OnAfterGetRecord()
                var
                    "Row No.": Text[2000];
                    "Column No.": Text[200];
                    TempExcelBuffer: Record "Excel Buffer";


                begin
                    //Postoji i ova funkcija TempExcelBuffer.CreateNewBook('Customers');



                    IF Status.AsInteger() = 0 THEN BEGIN
                        excLine += 1;
                        excLineSum += 1;


                        //Employee.SETFILTER(Status,FORMAT('Aktivan'));




                        // Sheet.Range('A1:B10').Borders.Item(7).Linestyle := 1;

                        Sheet.Range('B6').Value2 := FORMAT(DATE2DMY(startDate, 2)) + '.' + FORMAT(DATE2DMY(startDate, 3));
                        Sheet.Range('A' + FORMAT(excLine)).Value2 := DataItem2."No.";
                        Sheet.Range('B' + FORMAT(excLine)).Value2 := DataItem2."Last Name" + ' ' + DataItem2."First Name";
                        Sheet.Range('C' + FORMAT(excLine)).Value2 := '-';
                        Sheet.Range('A' + FORMAT(excLine)).Value2 := FORMAT(DATE2DMY(startDate, 2)) + '.' + FORMAT(DATE2DMY(startDate, 3));
                        Sheet.Range('A' + FORMAT(excLine) + ':AR' + FORMAT(excLine)).Borders.Item(9).Linestyle := 7;








                        i := 4;
                        k := 4;
                        IF CA.FINDFIRST() THEN
                            REPEAT
                            BEGIN
                                Sheet.Range(excelString[i] + FORMAT(excLine + COUNT + 3)).NumberFormat := 'General';
                                Sheet.Range(excelString[i] + FORMAT(excLine + COUNT + 3)).Formula := '=COUNTIF(' + excelString[k] + FORMAT(excLine) + ':AR' + FORMAT(excLine) + ';"' + CA.Code + '")*8';

                                i := i + 1;
                            END
                            UNTIL CA.NEXT = 0;

                        //NK Sheet.Range('A'+FORMAT(excLine+COUNT+3)).Value:=Employee."No.";
                        Sheet.Range('B' + FORMAT(excLine + COUNT + 3)).Value2 := DataItem2."Last Name" + ' ' + DataItem2."First Name";


                        j := 4;

                        SumaE := DataItem2.COUNT;


                        mydate := startDate;

                        CurrDayC := DATE2DWY(mydate, 1);

                        WHILE (mydate <= endDate) DO BEGIN
                            Holiday := FALSE;
                            CalendarChange.SETFILTER(Date, '%1', mydate);
                            IF CalendarChange.FIND('-') THEN BEGIN
                                IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                    Holiday := TRUE;
                            END;
                            Weekend := FALSE;
                            CurrDayC := DATE2DWY(mydate, 1);
                            IF ((CurrDayC = 6) OR (CurrDayC = 7)) THEN BEGIN
                                Weekend := TRUE;
                            END;


                            IF Holiday THEN BEGIN
                                IF WgS.FIND('-') THEN
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := WgS."Holiday Code";
                            END
                            ELSE
                                IF Weekend THEN BEGIN
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := '-';
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).HorizontalAlignment(3);
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Interior.ColorIndex := 15;
                                END
                                ELSE
                                    // Sheet.Range(excelString[j]+FORMAT(excLine)).Value:='8';
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := '';

                            mydate := CALCDATE('+1D', mydate);
                            Sheet.Range(excelString[j] + FORMAT(excLine)).Borders.ColorIndex := 1;
                            Sheet.Range(excelString[j] + FORMAT(excLine - 1)).Borders.ColorIndex := 1;



                            j += 1;

                        END;
                    END;
                    i += 1;
                end;

                trigger OnPostDataItem()
                begin
                    j := 4;

                    Sheet.Range(excelString[j] + FORMAT(excLine + 2)).Value2 := Text013;
                    IF CA.FINDFIRST() THEN
                        REPEAT
                        BEGIN
                            //Sheet.Range(excelString[j]+FORMAT(excLine+COUNT+1)).Borders.Item(9).LineStyle:=7;
                            Sheet.Range(excelString[j] + FORMAT(excLine + 3)).Value2 := CA.Code;
                            j := j + 1;
                        END
                        UNTIL CA.NEXT = 0;



                    IF (ImeFilea <> '') THEN BEGIN
                        IF EXISTS(ImeFilea) THEN IF ERASE(ImeFilea) THEN;

                        //ĐK korekcija greške Book.SaveAs(ImeFilea);

                        Excel.Save(ImeFilea);
                        Excel.Quit;

                        CLEAR(FileManagement);
                        CLEAR(Excel);
                        CLEAR(Book);
                        //DOWNLOAD(ImeFilea, '', '', '', ImeFilea);
                        //EC FileManagement.DownloadToFile(ImeFilea,ImeFilea);

                    END;
                    //EC DOWNLOAD(ImeFilea, '', 'C:\Temp', '',ImeFilea);
                end;

                trigger OnPreDataItem()
                begin
                    IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN
                        SETFILTER("Department code", '')
                    ELSE
                        IF byDim THEN BEGIN
                            SETFILTER("Department code", DataItem1.Code);
                            Sheet.Range('G4').Value2 := 'SEKTOR'
                        END
                        ELSE
                            IF (NOT (byDim) AND (byDep)) THEN BEGIN
                                SETFILTER("Department code", DataItem1.Code);
                                Sheet.Range('G4').Value2 := 'ODJEL';
                            END;

                    //ERROR(FORMAT(GETFILTERS));


                    //  excLine+=13;

                    excelString[1] := 'A';
                    excelString[2] := 'B';
                    excelString[3] := 'C';
                    excelString[4] := 'D';
                    excelString[5] := 'E';
                    excelString[6] := 'F';
                    excelString[7] := 'G';
                    excelString[8] := 'H';
                    excelString[9] := 'I';
                    excelString[10] := 'J';
                    excelString[11] := 'K';
                    excelString[12] := 'L';
                    excelString[13] := 'M';
                    excelString[14] := 'N';
                    excelString[15] := 'O';
                    excelString[16] := 'P';
                    excelString[17] := 'Q';
                    excelString[18] := 'R';
                    excelString[19] := 'S';
                    excelString[20] := 'T';
                    excelString[21] := 'U';
                    excelString[22] := 'V';
                    excelString[23] := 'W';
                    excelString[24] := 'X';
                    excelString[25] := 'Y';
                    excelString[26] := 'Z';
                    excelString[27] := 'AA';
                    excelString[28] := 'AB';
                    excelString[29] := 'AC';
                    excelString[30] := 'AD';
                    excelString[31] := 'AE';
                    excelString[32] := 'AF';
                    excelString[33] := 'AG';
                    excelString[34] := 'AH';
                    excelString[35] := 'AI';
                    excelString[36] := 'AJ';
                    excelString[37] := 'AK';
                    excelString[38] := 'AL';
                    excelString[39] := 'AM';
                    excelString[40] := 'AN';

                    Sheet.Range('A1:AR500').NumberFormat := '@';
                    j := 4;

                    //Sheet.Range('G4').Value:='SEKTOR';



                    CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

                    CurrDayC := 0;

                    mydate := startDate;

                    WHILE (mydate <= endDate) DO BEGIN
                        Holiday := FALSE;
                        CalendarChange.SETFILTER(Date, '%1', mydate);
                        IF CalendarChange.FIND('-') THEN BEGIN
                            IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                Holiday := TRUE
                        END;



                        // Sheet.Range(excelString[j]+FORMAT(excLine)).Value:=DATE2DMY(mydate, 1);
                        day := DATE2DMY(mydate, 1);
                        Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := day;
                        mydate := CALCDATE('+1D', mydate);
                        j += 1;
                    END;
                    EmployeeCount.SETFILTER(Status, '%1', 0);
                    IF EmployeeCount.FINDSET THEN
                        Sum := EmployeeCount.COUNT;
                    excLineSum := Sum + 20;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF ImeFilea <> '' THEN
                    ImeFilea := '';

                IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN BEGIN
                    IF (firstE = 0) THEN BEGIN
                        firstE := firstE + 1;
                        CreateE;
                        ImeFilea := path + FORMAT(IME) + '_' + Code + '_' + FORMAT(Dow) + '.xlsx';
                        Sheet.Range('L4').Value2 := 'SVE';

                        MESSAGE(Text009)
                    END
                    ELSE
                        CurrReport.SKIP;
                END
                ELSE
                    IF byDim THEN BEGIN
                        //NK EmpTEMP.SETFILTER("Department Code", Code);
                        IF EmpTEMP.FIND('-') THEN BEGIN
                            CreateE;
                            ImeFilea := path + FORMAT(IME) + '_' + Code + '_' + FORMAT(Dow) + '.xlsx';
                            Sheet.Range('L4').Value2 := Code + '-' + Description;
                        END
                        ELSE
                            CurrReport.SKIP;

                    END

                    ELSE
                        IF ((byDep) AND NOT (byDim)) THEN BEGIN
                            EmpTEMP.SETFILTER("Department code", Code);
                            IF (EmpTEMP.FIND('-')) THEN BEGIN
                                CreateE;
                                ImeFilea := path + FORMAT(IME) + '_' + Code + '_' + FORMAT(Dow) + '.xlsx';    //!!!!
                                Sheet.Range('L4').Value2 := Code + '-' + Description;
                            END
                            ELSE
                                CurrReport.SKIP;
                        END;
            end;

            trigger OnPreDataItem()
            begin
                IF WS.FIND('-') THEN
                    path2 := WS."Export Report Path";
                path := path2 + 'SIHTARICE\';
            end;
        }
        dataitem(Department2; Department)
        {
            dataitem(Employee2; Employee)
            {
                DataItemTableView = WHERE(Status = CONST(Active),
                                          "Potential Employee" = CONST(false));

                trigger OnAfterGetRecord()
                begin
                    IF Status.AsInteger() = 0 THEN BEGIN

                        excLine += 1;

                        Employee2.SETFILTER(Status, '%1', 0);

                        Sheet.Range('B6').Value2 := FORMAT(DATE2DMY(startDate, 2)) + '.' + FORMAT(DATE2DMY(startDate, 3));
                        Sheet.Range('A' + FORMAT(excLine)).Value2 := Employee2."No.";
                        Sheet.Range('B' + FORMAT(excLine)).Value2 := Employee2."Last Name" + ' ' + Employee2."First Name";
                        Sheet.Range('C' + FORMAT(excLine)).Value2 := Employee2."Global Dimension 1 Code";
                        //Sheet.Range('A'+FORMAT(excLine)+':AR'+FORMAT(excLine)).Borders.Item(9).LineStyle:=7;
                        IF KOD = 'PREVENT' THEN
                            Sheet.Range('A' + FORMAT(excLine) + ':AK' + FORMAT(excLine)).Borders.Item(9).LineStyle := 7
                        ELSE
                            Sheet.Range('A' + FORMAT(excLine) + ':AR' + FORMAT(excLine)).Borders.Item(9).LineStyle := 7;

                        i := 4;
                        k := 4;
                        IF CA.FINDFIRST() THEN
                            REPEAT
                            BEGIN
                                Sheet.Range(excelString[i] + FORMAT(excLine + COUNT + 3)).NumberFormat := 'General';
                                Sheet.Range(excelString[i] + FORMAT(excLine + COUNT + 3)).Value2 := '=COUNTIF(' + excelString[k] + FORMAT(excLine) + ':AR' + FORMAT(excLine) + ';"' + CA.Code + '")*8';
                                i := i + 1;
                            END
                            UNTIL CA.NEXT = 0;

                        //NK Sheet.Range('A'+FORMAT(excLine+COUNT+3)).Value:=Employee."No.";
                        Sheet.Range('B' + FORMAT(excLine + COUNT + 3)).Value2 := Employee2."Last Name" + ' ' + Employee2."First Name";


                        SumaE := Employee2.COUNT;

                        j := 4;

                        mydate := startDate;

                        CurrDayC := DATE2DWY(mydate, 1);

                        WHILE (mydate <= endDate) DO BEGIN
                            Holiday := FALSE;
                            CalendarChange.SETFILTER(Date, '%1', mydate);
                            IF CalendarChange.FIND('-') THEN BEGIN
                                IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                    Holiday := TRUE;
                            END;
                            Weekend := FALSE;
                            CurrDayC := DATE2DWY(mydate, 1);
                            IF ((CurrDayC = 6) OR (CurrDayC = 7)) THEN BEGIN
                                Weekend := TRUE;
                            END;


                            IF Holiday THEN BEGIN
                                IF WgS.FIND('-') THEN
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := WgS."Holiday Code";
                            END
                            ELSE
                                IF Weekend THEN BEGIN
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := '-';
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).HorizontalAlignment(3);
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Interior.ColorIndex := 15;
                                END
                                ELSE
                                    // Sheet.Range(excelString[j]+FORMAT(excLine)).Value:='8';
                                    Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := '';

                            mydate := CALCDATE('+1D', mydate);
                            Sheet.Range(excelString[j] + FORMAT(excLine)).Borders.ColorIndex := 1;
                            Sheet.Range(excelString[j] + FORMAT(excLine - 1)).Borders.ColorIndex := 1;

                            j += 1;

                        END;
                    END;

                end;

                trigger OnPostDataItem()
                begin
                    j := 4;

                    Sheet.Range(excelString[j] + FORMAT(excLine + 2)).Value2 := Text013;
                    IF CA.FINDFIRST() THEN
                        REPEAT
                        BEGIN
                            //Sheet.Range(excelString[j]+FORMAT(excLine+COUNT+1)).Borders.Item(9).LineStyle:=7;
                            Sheet.Range(excelString[j] + FORMAT(excLine + 3)).Value2 := CA.Code;
                            j := j + 1;
                        END
                        UNTIL CA.NEXT = 0;


                    IF (ImeFilea <> '') THEN BEGIN
                        IF EXISTS(ImeFilea) THEN IF ERASE(ImeFilea) THEN;

                        //ĐK  Book.SaveAs(ImeFilea);
                        SaveAsExcel(ImeFilea);
                        Excel.Quit;
                        CLEAR(FileManagement);
                        CLEAR(Excel);
                        CLEAR(Book);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN
                        SETFILTER("Department code", '')
                    ELSE
                        IF ((byDim) AND ("Department code" = '')) THEN
                            SETFILTER("Department code", Department2.Code)
                        ELSE
                            IF ((byDep) AND NOT (byDim)) THEN
                                CurrReport.SKIP;



                    //ERROR(FORMAT(GETFILTERS));


                    //  excLine+=13;

                    excelString[1] := 'A';
                    excelString[2] := 'B';
                    excelString[3] := 'C';
                    excelString[4] := 'D';
                    excelString[5] := 'E';
                    excelString[6] := 'F';
                    excelString[7] := 'G';
                    excelString[8] := 'H';
                    excelString[9] := 'I';
                    excelString[10] := 'J';
                    excelString[11] := 'K';
                    excelString[12] := 'L';
                    excelString[13] := 'M';
                    excelString[14] := 'N';
                    excelString[15] := 'O';
                    excelString[16] := 'P';
                    excelString[17] := 'Q';
                    excelString[18] := 'R';
                    excelString[19] := 'S';
                    excelString[20] := 'T';
                    excelString[21] := 'U';
                    excelString[22] := 'V';
                    excelString[23] := 'W';
                    excelString[24] := 'X';
                    excelString[25] := 'Y';
                    excelString[26] := 'Z';
                    excelString[27] := 'AA';
                    excelString[28] := 'AB';
                    excelString[29] := 'AC';
                    excelString[30] := 'AD';
                    excelString[31] := 'AE';
                    excelString[32] := 'AF';
                    excelString[33] := 'AG';
                    excelString[34] := 'AH';
                    excelString[35] := 'AI';
                    excelString[36] := 'AJ';
                    excelString[37] := 'AK';
                    excelString[38] := 'AL';
                    excelString[39] := 'AM';
                    excelString[40] := 'AN';

                    Sheet.Range('A1:AR500').NumberFormat := '@';
                    j := 4;

                    Sheet.Range('G4').Value2 := 'ODJEL';



                    CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

                    CurrDayC := 0;

                    mydate := startDate;

                    WHILE (mydate <= endDate) DO BEGIN
                        Holiday := FALSE;
                        CalendarChange.SETFILTER(Date, '%1', mydate);
                        IF CalendarChange.FIND('-') THEN BEGIN
                            IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                Holiday := TRUE
                        END;



                        // Sheet.Range(excelString[j]+FORMAT(excLine)).Value:=DATE2DMY(mydate, 1);
                        day := DATE2DMY(mydate, 1);
                        Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := day;
                        mydate := CALCDATE('+1D', mydate);
                        j += 1;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                ImeFilea := '';
                IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN BEGIN
                    IF (firstE = 0) THEN BEGIN
                        firstE := firstE + 1;
                        CreateE;
                        ImeFilea := path + FORMAT(IME) + '_' + FORMAT(Dow) + '_' + FORMAT(IDYear) + '.xls';   //!!!!
                        Sheet.Range('L4').Value2 := 'SVE';

                        MESSAGE(Text009)
                    END
                    ELSE
                        CurrReport.SKIP;
                END
                ELSE
                    IF byDim THEN BEGIN
                        EmpTEMP.SETRANGE("Department code");
                        EmpTEMP.SETFILTER("Department code", Code);
                        IF (EmpTEMP.FIND('-')) AND (EmpTEMP."Department code" = '') THEN BEGIN
                            CreateE;
                            ImeFilea := path + FORMAT(IME) + Code + '_' + FORMAT(Dow) + '_' + FORMAT(IDYear) + '.xls';    //!!!!
                            Sheet.Range('L4').Value2 := Code + '-' + Description;

                        END
                        ELSE
                            CurrReport.SKIP;

                    END

                    ELSE
                        IF ((byDep) AND NOT (byDim)) THEN
                            CurrReport.SKIP


                        ELSE
                            IF ((byDep) AND NOT (byDim)) THEN BEGIN
                                EmpTEMP.SETRANGE("Department Code");
                                EmpTEMP.SETFILTER("Department Code", Code);
                                IF (EmpTEMP.FIND('-')) THEN BEGIN
                                    CreateE;
                                    ImeFilea := path + FORMAT(IME) + Code + FORMAT(Dow) + FORMAT(IDYear) + '.xls';    //!!!!
                                    Sheet.Range('L4').Value2 := Code + '-' + Description;
                                    //Sheet.Range('M4').Value:=Description;
                                END
                                ELSE
                                    CurrReport.SKIP;

                            END;


            end;

            trigger OnPreDataItem()
            begin
                IF WS.FIND('-') THEN
                    path2 := WS."Export Report Path";

                path := path2 + 'SIHTARICE\';
            end;
        }
        dataitem(Department3; Department)
        {
            dataitem(Employee3; Employee)
            {
                DataItemTableView = WHERE(Status = CONST(Active),
                                          "Potential Employee" = CONST(false));

                trigger OnAfterGetRecord()
                begin
                    IF Status.AsInteger() = 0 THEN BEGIN

                        excLine += 1;

                        Employee3.SETFILTER(Status, '%1', 0);

                        Sheet.Range('B6').Value2 := FORMAT(DATE2DMY(startDate, 2)) + '.' + FORMAT(DATE2DMY(startDate, 3));
                        Sheet.Range('A' + FORMAT(excLine)).Value2 := Employee3."No.";
                        Sheet.Range('B' + FORMAT(excLine)).Value2 := Employee3."Last Name" + ' ' + Employee3."First Name";
                        Sheet.Range('C' + FORMAT(excLine)).Value2 := '-';
                        Sheet.Range('A' + FORMAT(excLine) + ':AR' + FORMAT(excLine)).Borders.Item(9).LineStyle := 7;
                        i := 4;
                        k := 4;
                        IF CA.FINDFIRST() THEN
                            REPEAT
                            BEGIN
                                //NK Sheet.Range(excelString[i]+FORMAT(excLine+COUNT+3)).NumberFormat:= 'General';
                                Sheet.Range(excelString[i] + FORMAT(excLine + COUNT + 3)).Value2 := '=COUNTIF(' + excelString[k] + FORMAT(excLine) + ':AR' + FORMAT(excLine) + ';"' + CA.Code + '")*8';
                                i := i + 1;
                            END
                            UNTIL CA.NEXT = 0;

                        Sheet.Range('A' + FORMAT(excLine + COUNT + 3)).Value2 := Employee3."No.";
                        Sheet.Range('B' + FORMAT(excLine + COUNT + 3)).Value2 := Employee3."Last Name" + ' ' + Employee3."First Name";

                        SumaE := Employee2.COUNT;

                        j := 4;

                        mydate := startDate;

                        CurrDayC := DATE2DWY(mydate, 1);

                        WHILE (mydate <= endDate) DO BEGIN
                            Holiday := FALSE;
                            CalendarChange.SETFILTER(Date, '%1', mydate);
                            IF CalendarChange.FIND('-') THEN BEGIN
                                IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                    Holiday := TRUE;
                            END;
                            Weekend := FALSE;
                            CurrDayC := DATE2DWY(mydate, 1);
                            IF ((CurrDayC = 6) OR (CurrDayC = 7)) THEN BEGIN
                                Weekend := TRUE;
                            END;




                        END;
                    END;
                end;

                trigger OnPostDataItem()
                begin
                    j := 4;

                    Sheet.Range(excelString[j] + FORMAT(excLine + 2)).Value2 := Text013;
                    IF CA.FINDFIRST() THEN
                        REPEAT
                        BEGIN
                            //Sheet.Range(excelString[j]+FORMAT(excLine+COUNT+1)).Borders.Item(9).LineStyle:=7;
                            Sheet.Range(excelString[j] + FORMAT(excLine + 3)).Value2 := CA.Code;
                            j := j + 1;
                        END
                        UNTIL CA.NEXT = 0;


                    IF (ImeFilea <> '') THEN BEGIN
                        IF EXISTS(ImeFilea) THEN IF ERASE(ImeFilea) THEN;
                        //đk Book.SaveAs(ImeFilea);

                        SaveAsExcel(ImeFilea);

                        Excel.Quit;

                        CLEAR(Excel);
                        CLEAR(Book);
                        CLEAR(FileManagement);
                    END;
                end;

                trigger OnPreDataItem()
                begin
                    IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN
                        SETFILTER("Department code", '')
                    ELSE
                        IF ((byDep) AND ("Department code" = '')) THEN
                            SETFILTER("Department code", Department3.Code)
                        ELSE
                            IF (NOT (byDep) AND (byDim)) THEN
                                CurrReport.SKIP;


                    excelString[1] := 'A';
                    excelString[2] := 'B';
                    excelString[3] := 'C';
                    excelString[4] := 'D';
                    excelString[5] := 'E';
                    excelString[6] := 'F';
                    excelString[7] := 'G';
                    excelString[8] := 'H';
                    excelString[9] := 'I';
                    excelString[10] := 'J';
                    excelString[11] := 'K';
                    excelString[12] := 'L';
                    excelString[13] := 'M';
                    excelString[14] := 'N';
                    excelString[15] := 'O';
                    excelString[16] := 'P';
                    excelString[17] := 'Q';
                    excelString[18] := 'R';
                    excelString[19] := 'S';
                    excelString[20] := 'T';
                    excelString[21] := 'U';
                    excelString[22] := 'V';
                    excelString[23] := 'W';
                    excelString[24] := 'X';
                    excelString[25] := 'Y';
                    excelString[26] := 'Z';
                    excelString[27] := 'AA';
                    excelString[28] := 'AB';
                    excelString[29] := 'AC';
                    excelString[30] := 'AD';
                    excelString[31] := 'AE';
                    excelString[32] := 'AF';
                    excelString[33] := 'AG';
                    excelString[34] := 'AH';
                    excelString[35] := 'AI';
                    excelString[36] := 'AJ';
                    excelString[37] := 'AK';
                    excelString[38] := 'AL';
                    excelString[39] := 'AM';
                    excelString[40] := 'AN';

                    Sheet.Range('A1:AR500').NumberFormat := '@';
                    j := 4;

                    Sheet.Range('G4').Value2 := Text010;

                    CalendarChange.SETFILTER("Base Calendar Code", Calendar.Code);

                    CurrDayC := 0;

                    mydate := startDate;

                    WHILE (mydate <= endDate) DO BEGIN
                        Holiday := FALSE;
                        CalendarChange.SETFILTER(Date, '%1', mydate);
                        IF CalendarChange.FIND('-') THEN BEGIN
                            IF ((CalendarChange."Paid Holiday") AND (CalendarChange.Nonworking = TRUE)) THEN
                                Holiday := TRUE
                        END;


                        day := DATE2DMY(mydate, 1);
                        Sheet.Range(excelString[j] + FORMAT(excLine)).Value2 := day;
                        mydate := CALCDATE('+1D', mydate);
                        j += 1;
                    END;
                end;
            }

            trigger OnAfterGetRecord()
            begin

                ImeFilea := '';
                IF (NOT (byDim) AND (dimFilter = '') AND NOT (byDep)) THEN BEGIN
                    IF (firstE = 0) THEN BEGIN
                        firstE := firstE + 1;
                        CreateE;
                        ImeFilea := path + FORMAT(IME) + '_' + FORMAT(Dow) + '.xls';   //!!!!
                        Sheet.Range('L4').Value2 := 'SVE';

                        MESSAGE(Text009)
                    END
                    ELSE
                        CurrReport.SKIP;
                END
                ELSE
                    IF byDep THEN BEGIN
                        EmpTEMP.SETRANGE("Department code");
                        EmpTEMP.SETFILTER("Department code", Code);
                        IF (EmpTEMP.FIND('-')) AND (EmpTEMP."Department code" = '') THEN BEGIN
                            CreateE;
                            ImeFilea := path + FORMAT(IME) + '_' + Code + '_' + FORMAT(Dow) + '.xls';    //!!!!
                            Sheet.Range('L4').Value2 := Code + '-' + Description;
                            //Sheet.Range('M4').Value:=Description;
                        END
                        ELSE
                            CurrReport.SKIP;

                    END

                    ELSE
                        IF (NOT (byDep) AND (byDim)) THEN
                            CurrReport.SKIP;
            end;

            trigger OnPreDataItem()
            begin

                IF WS.FIND('-') THEN
                    path2 := WS."Export Report Path";

                path := path2 + 'SIHTARICE\';
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Period';
                    field(startDate; startDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(endDate; endDate)
                    {
                        Caption = 'End Date';
                    }
                    field(byDep; byDep)
                    {
                        Caption = 'By Department';
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

    trigger OnInitReport()
    begin
        fExcel := TRUE;

        AutoFilterLine := 0;

        IDMonth := DATE2DMY(CALCDATE('-1M', TODAY), 2);
        IDYear := DATE2DMY(CALCDATE('-1M', TODAY), 3);
        byDep := TRUE;
    end;

    trigger OnPostReport()
    begin
        MESSAGE(Text008);
    end;

    trigger OnPreReport()
    begin

        CASE DATE2DMY(startDate, 2) OF
            1:
                Dow := 'Januar';
            2:
                Dow := 'Februar';
            3:
                Dow := 'Mart';
            4:
                Dow := 'April';
            5:
                Dow := 'Maj';
            6:
                Dow := 'Juni';
            7:
                Dow := 'Juli';
            8:
                Dow := 'August';
            9:
                Dow := 'Septembar';
            10:
                Dow := 'Oktobar';
            11:
                Dow := 'Novembar';
            12:
                Dow := 'Decembar';
        END;


        dimFilter := DataItem1.GETFILTER(Code);
    end;

    var
        FileManagement: Codeunit "File Management";

        WS: Record "Wage Setup";
        path: Text[60];
        path2: Text[100];
        ImeFilea: Text[250];
        byDim: Boolean;
        byDep: Boolean;
        dimFilter: Text[250];
        firstE: Integer;
        IME: Text[250];
        Dow: Text[30];
        EmpTEMP: Record Employee;
        fExcel: Boolean;
        Excel: DotNet "Application";

        Sheet: DotNet WorkSheet2;
        Sheet2: DotNet WorkSheet2;


        Book: DotNet Workbooks;
        Company: Record "Company Information";
        Comp: Record "Company";
        KOD: Code[20];
        br: Integer;
        CA: Record "Cause of Absence";
        excLine: Integer;
        AutoFilterLine: Integer;
        excelString: array[40] of Text[2];
        CalendarChange: Record "Base Calendar Change";
        CurrDayC: Integer;
        mydate: Date;
        startDate: Date;
        endDate: Date;
        day: Integer;
        j: Integer;
        SumaE: Integer;
        Weekend: Boolean;
        WgS: Record "Wage Setup";
        IDMonth: Integer;
        IDYear: Integer;
        Calendar: Record "Base Calendar";
        Holiday: Boolean;
        MsoAppLanguageID: Integer;
        Text000: Label 'ABSENCE REGISTRATION BOOK';
        Text001: Label 'MONTH';
        Text002: Label 'YEAR';
        Text003: Label 'COMPANY NAME';
        Text004: Label 'DEPARTMENT';
        Text005: Label 'LEGEND';
        Text006: Label 'FIRST AND LAST NAME';
        Text007: Label 'CODE';
        Text008: Label 'Absence registration book is created!';
        Text009: Label 'All employees go to one excel file.';
        Text010: Label 'SECTOR';
        Text011: Label 'NAME';
        Text012: Label 'E';
        EmployeeCount: Record Employee;
        "Sum": Integer;
        excLineSum: Integer;
        i: Integer;
        k: Integer;
        Text013: Label 'RECAPITULATION BY EMPLOYEES';
        Text014: Label 'File saved as:';
        TimeSheetYear: Integer;

    procedure CreateE()
    begin
        IF fExcel THEN BEGIN
            CLEAR(Excel);




            //ĐK potreba korekcija CREATE(Excel, FALSE, TRUE);


            //Book:=Excel.Workbooks.Add(-4167);
            //TEST    Excel := Excel.Application();


            Book := Excel.Worksheets.Add(-1467);


            Sheet := Excel.ActiveSheet;

            excLine := 11;
            // excLine:=4;

            Sheet.PageSetup.Zoom := FALSE;
            Sheet.Range('D1:AR1').ColumnWidth := 5;

            Sheet.Range('A1:AR1').Font.Size := 12;
            Sheet.Range('A1:A1').ColumnWidth := 10;
            Sheet.Range('B1:B1').ColumnWidth := 20;
            Sheet.Range('C1:C1').ColumnWidth := 8;


            Sheet.Range('A1:AR1').Borders.Item(9).LineStyle := 9;
            Sheet.Range('G3:AQ3').Borders.Item(9).LineStyle := 9;
            Sheet.Range('S3:AR3').Borders.Item(9).LineStyle := 9;
            Sheet.PageSetup.Orientation(2);


            Sheet.Range('H2').NumberFormat := '@';
            Sheet.Range('B6').NumberFormat := '@';
            Sheet.Range('I1').Value2 := Text000;
            IF Company.FIND('-') THEN
                IME := Company.Name;
            Comp.SETFILTER(Name, COMPANYNAME);
            IF Comp.FIND('-') THEN
                Sheet.Range('L3').Value2 := IME;
            Sheet.Range('B3').Value2 := FORMAT(Text001) + '  ' + FORMAT(Dow);
            Sheet.Range('B4').Value2 := FORMAT(Text002) + ' ' + FORMAT(IDYear);
            Sheet.Range('B6').Value2 := FORMAT(IDMonth) + '.' + FORMAT(IDYear);
            Sheet.Range('G3').Value2 := FORMAT(Text003);
            Sheet.Range('G4').Value2 := FORMAT(Text004);
            Sheet.Range('V3').Value2 := FORMAT(Text005);
            br := 3;

            excLine := 15;
            IF CA.FIND('-') THEN
                REPEAT
                    br := br + 1;
                    IF (br < 12) THEN BEGIN
                        Sheet.Range('V' + FORMAT(br)).Value2 := CA.Code;
                        //IF GLOBALLANGUAGE<>1033 THEN
                        Sheet.Range('W' + FORMAT(br)).Value2 := '-' + CA.Description

                    END
                    ELSE
                        IF (br < 23) THEN BEGIN
                            Sheet.Range('AA' + FORMAT(excLine - 11)).Value2 := CA.Code;
                            // IF GLOBALLANGUAGE<>1033 THEN
                            Sheet.Range('AC' + FORMAT(excLine - 11)).Value2 := '-' + CA.Description

                        END
                        ELSE BEGIN
                            Sheet.Range('AH' + FORMAT(excLine - 22)).Value2 := CA.Code;
                            //  IF GLOBALLANGUAGE<>1033 THEN
                            Sheet.Range('AJ' + FORMAT(excLine - 22)).Value2 := '-' + CA.Description

                        END;
                    excLine += 1;
                UNTIL CA.NEXT = 0;
            excLine -= 9;

            Sheet.Range('B' + FORMAT(excLine)).Value2 := Text006;
            Sheet.Range('A' + FORMAT(excLine)).Value2 := Text007;
            Sheet.Range('C' + FORMAT(excLine)).ColumnWidth := 0;



            IF WS."Add. Columns" THEN BEGIN
                Sheet.Range('A' + FORMAT(excLine) + ':AK' + FORMAT(excLine)).Borders.Item(9).LineStyle := 9;
                Sheet.Range('A' + FORMAT(excLine - 2) + ':AK' + FORMAT(excLine - 2)).Borders.Item(9).LineStyle := 9;
            END
            ELSE BEGIN
                Sheet.Range('A' + FORMAT(excLine) + ':AR' + FORMAT(excLine)).Borders.Item(9).LineStyle := 9;
                Sheet.Range('A' + FORMAT(excLine) + ':AR' + FORMAT(excLine)).Borders.Item(9).LineStyle := 9;

            END;

            Sheet.Range('P' + FORMAT(excLine - 1)).Value2 := 'D';
            Sheet.Range('Q' + FORMAT(excLine - 1)).Value2 := 'A';
            Sheet.Range('R' + FORMAT(excLine - 1)).Value2 := 'T';
            Sheet.Range('S' + FORMAT(excLine - 1)).Value2 := Text012;
            IF GLOBALLANGUAGE <> 1033 THEN
                Sheet.Range('T' + FORMAT(excLine - 1)).Value2 := 'M';



            Sheet.PageSetup.PaperSize := 1;
            Sheet.PageSetup.FitToPagesWide := 1;
            Sheet.PageSetup.RightFooter := '&P';
            Sheet.PageSetup.LeftFooter := FORMAT(TODAY);
            IF AutoFilterLine <> 0 THEN
                Sheet.Range('A' + FORMAT(AutoFilterLine) + ':Q' + FORMAT(AutoFilterLine)).AutoFilter;

        END;
    end;


    procedure GiveUserControl()
    var

        XlWrkBkDotNet: DotNet Workbooks;
        MemoryStream: DotNet MemoryStream;
        ExcelApp: DotNet Application;
        ExcelAppClass: DotNet ApplicationClass2;
        Workbook: DotNet Workbooks;
        Workbooks: DotNet Workbooks;
        // MsoAppLanguageID: DotNet Adjustments;
        // ReflectionBindingFlags: DotNet BindingFlags;
        CultureInfo: DotNet CultureInfo;
        Type: DotNet Type;
        RuntimeTypeHandle: DotNet RuntimeTypeHandle;
        Args: DotNet Array;
        DummyArray: DotNet Array;
        NVInStream: InStream;
        ThreeTierMgt: Codeunit "File Management";
        FileNameRTC: Text[1024];
        CultureID: Integer;
    begin
        BEGIN


        END;
    end;
}

*/

