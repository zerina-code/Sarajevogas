/* report 50123 "Create Timesheet final"
{
    Caption = 'Export Item Budget to Excel';
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Integer")
        {
            DataItemTableView = SORTING(Number)
                                WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            var
                Window: Dialog;
                ClientFileName: Text;
                RecNo: Integer;
                TotalRecNo: Integer;
                RowNo: Integer;
                ColumnNo: Integer;
            begin


                Window.OPEN(
                  Text000 +
                  '@1@@@@@@@@@@@@@@@@@@@@@\');

                TempExcelBuffer.DELETEALL;
                CLEAR(TempExcelBuffer);

                TotalRecNo := 50;


                CompanyInformation.GET;
                RowNo := 1;
                FOR Brojac := 1 TO 8 DO BEGIN
                    EnterCell(RowNo, Brojac, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                END;
                EnterCell(RowNo, 9, Text001, FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', TRUE, FALSE, TRUE);
                //EnterCell(RowNo,2,'',FALSE,FALSE,TRUE,'',TempExcelBuffer."Cell Type"::Text);
                FOR Brojac := 10 TO 32 DO BEGIN
                    EnterCell(RowNo, Brojac, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                END;


                RowNo := RowNo + 2;
                //EnterFilterInCell(RowNo,BudgetName,ItemBudgetName.TABLECAPTION);

                EnterCell(RowNo, 2, Text002 + ' ' + Dow, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 6, 'ORGANIZACIJA PREDUZEĆE', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                FOR Brojac := 7 TO 10 DO BEGIN
                    EnterCell(RowNo, Brojac, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                END;

                EnterCell(RowNo, 11, CompanyInformation.Name, FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                FOR Brojac := 12 TO 20 DO BEGIN
                    EnterCell(RowNo, Brojac, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                END;
                EnterCell(RowNo, 21, 'LEGENDA', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                FOR Brojac := 22 TO 32 DO BEGIN
                    EnterCell(RowNo, Brojac, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                END;

                RowNo := RowNo + 1;

                EnterCell(RowNo, 2, 'GODINA ' + FORMAT(DATE2DMY(StartDate, 3)), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 6, 'ODJEL', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 11, 'SVE', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                Uvecaj := 0;
                CauseofAbsence.RESET;
                IF CauseofAbsence.FINDSET THEN
                    REPEAT
                        Uvecaj := Uvecaj + 1;
                        RowNo := RowNo + 1;
                        EnterCell(RowNo, 21, FORMAT(Uvecaj), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                        EnterCell(RowNo, 22, FORMAT(CauseofAbsence.Code), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                        EnterCell(RowNo, 23, FORMAT(CauseofAbsence.Description), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                    UNTIL CauseofAbsence.NEXT = 0;


                RowNo := RowNo + 1;
                RowNo := RowNo + 1;

                FOR KUnder := 3 TO 15 DO BEGIN
                    EnterCell(RowNo, KUnder, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);

                END;

                EnterCell(RowNo, 16, 'D', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 17, 'A', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 18, 'T', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 19, 'U', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                EnterCell(RowNo, 20, 'M', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);

                Date.RESET;
                Date.SETFILTER("Period Type", '%1', Date."Period Type"::Date);
                Date.SETFILTER("Period Start", '>=%1', StartDate);
                Date.SETFILTER("Period End", '<=%1', CALCDATE('<+1D>', EndDate));
                IF Date.FINDFIRST THEN BEGIN


                    FOR KUnder := 21 TO Date.COUNT + 2 DO BEGIN
                        EnterCell(RowNo, KUnder, '', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);

                    END;
                END;

                RowNo := RowNo + 1;
                Kolona := 3;

                Uvecaj := 0;

                EnterCell(RowNo, 1, 'ŠIFRA', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                EnterCell(RowNo, 2, 'IME I PREZIME', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, TRUE);
                //EnterCell(RowNo,3,'',FALSE,FALSE,TRUE,'',TempExcelBuffer."Cell Type"::Text,'','',FALSE,FALSE,TRUE);
                //Kolona := Kolona - 1;
                Date.RESET;
                Date.SETFILTER("Period Type", '%1', Date."Period Type"::Date);
                Date.SETFILTER("Period Start", '>=%1', StartDate);
                Date.SETFILTER("Period End", '<=%1', CALCDATE('<+1D>', EndDate));
                IF Date.FINDSET THEN
                    REPEAT
                        Uvecaj := Uvecaj + 1;


                        IF (Date."Period No." = 6) OR (Date."Period No." = 7) then begin
                            EnterCell(RowNo, Kolona, FORMAT(Uvecaj), FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', FORMAT(Uvecaj), FALSE, TRUE, FALSE);
                            Kolona := Kolona + 1
                        end
                        else begin
                            EnterCell(RowNo, Kolona, FORMAT(Uvecaj), FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', FORMAT(Uvecaj), FALSE, TRUE, FALSE);
                            EnterCell(RowNo, Kolona + 1, FORMAT(Uvecaj) + ' - REDOVNO PREKOVREMENI', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', FORMAT(Uvecaj), FALSE, TRUE, FALSE);
                            Kolona := Kolona + 2;
                        end;
                    UNTIL Date.NEXT = 0;

                Uvecaj := 0;
                Kolona := 0;
                RowNo := RowNo + 1;
                Employee.RESET;
                Employee.SetFilter("For Calculation", '%1', true);
                IF Employee.FINDFIRST THEN
                    BrojZaposlenika := Employee.COUNT;

                Employee.RESET;
                Employee.SetFilter("For Calculation", '%1', true);
                IF Employee.FINDSET THEN
                    REPEAT

                        Kolona := 0;
                        IF Uvecaj = 0 THEN
                            PrviZaposlenik := RowNo;
                        Uvecaj := Uvecaj + 1;
                        Kolona := Kolona + 1;

                        EnterCell(RowNo, Kolona, Employee."No.", FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, TRUE, FALSE);
                        Kolona := Kolona + 1;
                        EnterCell(RowNo, Kolona, Employee."First Name" + ' ' + Employee."Last Name", FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, TRUE, FALSE);
                        // Kolona := Kolona - 1;
                        Kolona := 3;
                        Date.RESET;
                        Date.SETFILTER("Period Type", '%1', Date."Period Type"::Date);
                        Date.SETFILTER("Period Start", '>=%1', StartDate);
                        Date.SETFILTER("Period End", '<=%1', CALCDATE('<+1D>', EndDate));
                        IF Date.FINDSET THEN
                            REPEAT

                                Uvecaj := Uvecaj + 1;
                                //ĐK   Kolona := Kolona + 2;

                                IF (Date."Period No." = 6) OR (Date."Period No." = 7) THEN BEGIN
                                    TempExcelBuffer.AddColumnWithFonts('-', FALSE, '', FALSE, TRUE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', 0, 0, 2, TRUE, RowNo, Kolona, TRUE);
                                    Kolona := Kolona + 1;
                                    //Value ;IsFormula ;CommentText ;IsBold ;IsItalics ;IsUnderline ;NumFormat;CellType;FontName;FontSize;FontColor;BGColour ;Usingcustomformat;RowValue;ColumnValue;BorderYesUpit

                                    //EnterCell(RowNo,Kolona,'-',FALSE,FALSE,TRUE,'',TempExcelBuffer."Cell Type"::Text,'','');

                                END
                                ELSE BEGIN
                                    //EnterCell(RowNo,Kolona,'',FALSE,FALSE,TRUE,'',TempExcelBuffer."Cell Type"::Text,'','',FALSE,TRUE);

                                    EnterCell(RowNo, Kolona, 'REDOVNO', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, TRUE, TRUE);
                                    EnterCell(RowNo, Kolona + 1, '0', FALSE, FALSE, TRUE, '', TempExcelBuffer."Cell Type"::Number, '', '', FALSE, TRUE, TRUE);
                                    Kolona := Kolona + 2;
                                    //TempExcelBuffer.AddColumnWithFonts('',FALSE,'',FALSE,TRUE,TRUE,'',TempExcelBuffer."Cell Type"::Text,'',0,0,0,TRUE,RowNo,Kolona,TRUE);
                                END;




                            UNTIL Date.NEXT = 0;


                        RowNo := RowNo + 1;




                    UNTIL Employee.NEXT = 0;

                RowNo := RowNo + 1;
                Kolona := 2;
                Uvecaj := 0;
                EnterCell(RowNo, 3, 'REKAPITULACIJA PO UPOSLENICIMA PREMA BROJU SATI', FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                RowNo := RowNo + 1;
                Kolona := Kolona + 1;
                CauseofAbsence.RESET;
                IF CauseofAbsence.FINDSET THEN
                    REPEAT

                        EnterCell(RowNo, Kolona, CauseofAbsence.Code, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);

                        Uvecaj := Uvecaj + 1;
                        Kolona := Kolona + 1;
                    UNTIL CauseofAbsence.NEXT = 0;
                //REKAPITULACIJA PO UPOSLENICIMA PREMA BROJU SATI
                RowNo := RowNo + 1;
                Kolona := 2;
                Employee.RESET;

                //uvecaj je broj stavki koliko ima vrsta odsustava
                excLine := 20;
                Employee.SetFilter("For Calculation", '%1', true);
                IF Employee.FINDSET THEN
                    REPEAT
                        Kolona := 2;

                        EnterCell(RowNo, Kolona, Employee."First Name" + ' ' + Employee."Last Name", FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
                        //Kolona:=Kolona+1;
                        CauseofAbsence.RESET;
                        IF CauseofAbsence.FINDSET THEN
                            REPEAT
                                Kolona := Kolona + 1;




                                Dani := EndDate - StartDate;



                                EnterFormula(
                                            RowNo,
                                          Kolona,
                                            FORMAT(Dani),
                                            FALSE,
                                            FALSE,
                                            '#,##0.00');




                                HasFormulaError := TempExcelBuffer.ExportBudgetFilterToFormula2(TempExcelBuffer, CauseofAbsence.Code, TempExcelBuffer."Row No.", TempExcelBuffer."Column No.", CauseofAbsence."Added To Hour Pool");



                            UNTIL CauseofAbsence.NEXT = 0;
                        RowNo := RowNo + 1;

                    UNTIL Employee.NEXT = 0;

                Window.CLOSE;
                Company.get;
                IME := Company.Name;

                //ĐK  ServerFileName := IME + '_' + Dow;

                TempExcelBuffer.CreateBook(ServerFileName, TempExcelBuffer.GetExcelReference(10));
                TempExcelBuffer.AutoFit('B15;B15');
                TempExcelBuffer.SetBorderStyle;
                TempExcelBuffer.SetColumnWidth('B', 20);
                TempExcelBuffer.SetColumnWidth('A', 8);
                TempExcelBuffer.WriteSheet(
                  PADSTR(STRSUBSTNO('%1 %2', ItemBudgetName.Name, ItemBudgetName.Description), 30),
                  COMPANYNAME, USERID);

                //kao ovdje se dodaje merge TempExcelBuffer.MergeCells(6,5,6,8)
                TempExcelBuffer.CloseBook;
                IF NOT TestMode THEN
                    TempExcelBuffer.OpenExcel;


                //ovdje se kao dodaje


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(StartDate; StartDate)
                {
                    Caption = 'Start Date';
                    ApplicationArea = all;
                }
                field(EndDate; EndDate)
                {
                    Caption = 'End Date';
                    ApplicationArea = all;
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

    trigger OnPreReport()
    begin
        CASE DATE2DMY(StartDate, 2) OF
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
    end;

    var
        Text000: Label 'Analyzing Data...\\';
        IME: Text[1000];
        Company: Record "Company Information";
        Text001: Label 'Organizational';
        Text002: Label 'Month';
        ItemBudgetName: Record "Item Budget Name";
        Dim: Record "Dimension";
        LineDimCodeBuffer: Record "Dimension Code Buffer";
        ColumnDimCodeBuffer: Record "Dimension Code Buffer";
        ItemStatisticsBuffer: Record "Item Statistics Buffer";
        TempExcelBuffer: Record "Excel Buffer";
        GLSetup: Record "General Ledger Setup";
        ItemBudgetManagement: Codeunit "Item Budget Management";
        MatrixMgt: Codeunit "Matrix Management";
        FileMgt: Codeunit "File Management";
        LineDimCode: Text[250];
        ColumnDimCode: Text[250];
        DateFilter: Text;
        CompanyInformation: Record "Company Information";
        Dani: Integer;
        HasFormulaError: Boolean;
        Employee: Record "Employee";
        InternalDateFilter: Text;
        ExcellBuff: Record "Excel Buffer";
        PrviZaposlenik: Integer;
        BrojZaposlenika: Integer;
        excLine: Integer;
        ShowValueAsText: Text[250];
        ServerFileName: Text;
        KUnder: Integer;
        Dow: Text;
        SheetName: Text[250];
        Kolona: Integer;
        BudgetName: Code[10];
        GlobalDim1Filter: Text;
        Date: Record "Date";
        GlobalDim2Filter: Text;
        BudgetDim1Filter: Text;
        Brojac: Integer;
        CauseofAbsence: Record "Cause of Absence";
        Uvecaj: Integer;
        BudgetDim2Filter: Text;
        BudgetDim3Filter: Text;
        SourceNoFilter: Text;
        ItemFilter: Text;
        ColumnValue: Decimal;
        AnalysisArea: Option Sales,Purchase,Inventory;
        ValueType: Option "Sales Amount","Cost Amount",Quantity;
        Text003: Label 'Date Filter';
        Text004: Label 'Item Filter';
        Text005: Label 'Customer Filter';
        Text006: Label 'Vendor Filter';
        SourceTypeFilter: Option " ",Customer,Vendor,Item;
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        LineDimOption: Option Item,Customer,Vendor,Period,Location,"Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        ColumnDimOption: Option Item,Customer,Vendor,Period,Location,"Global Dimension 1","Global Dimension 2","Budget Dimension 1","Budget Dimension 2","Budget Dimension 3","Budget Dimension 4";
        RoundingFactor: Option "None","1","1000","1000000";
        PeriodInitialized: Boolean;
        Text007: Label 'Table Data';
        Text008: Label 'Show as Lines';
        Text009: Label 'Show as Columns';
        Text010: Label '%1 must not be blank.';
        Text011: Label 'Show Value as';
        Text012: Label 'Sales Amount';
        Text013: Label 'Cost Amount';
        Text014: Label 'COGS Amount';
        Text015: Label 'Quantity';
        DoUpdateExistingWorksheet: Boolean;
        ExcelFileExtensionTok: Label '.xlsx', Locked = true;
        TestMode: Boolean;
        StartDate: Date;
        EndDate: Date;


    procedure SetOptions(NewAnalysisArea: Integer; NewBudgName: Code[10]; NewValueType: Integer; NewGlobalDim1Filter: Text; NewGlobalDim2Filter: Text; NewBudgDim1Filter: Text; NewBudgDim2Filter: Text; NewBudgDim3Filter: Text; NewDateFilter: Text; NewSourceTypeFilter: Integer; NewSourceNoFilter: Text; NewItemFilter: Text; NewInternalDateFilter: Text; NewPeriodInitialized: Boolean; NewPeriodType: Integer; NewLineDimOption: Integer; NewColumnDimOption: Integer; NewLineDimCode: Text[30]; NewColumnDimCode: Text[30]; NewRoundingFactor: Option "None","1","1000","1000000")
    begin
        AnalysisArea := NewAnalysisArea;
        BudgetName := NewBudgName;
        ValueType := NewValueType;
        GlobalDim1Filter := NewGlobalDim1Filter;
        GlobalDim2Filter := NewGlobalDim2Filter;
        BudgetDim1Filter := NewBudgDim1Filter;
        BudgetDim2Filter := NewBudgDim2Filter;
        BudgetDim3Filter := NewBudgDim3Filter;
        DateFilter := NewDateFilter;
        ItemFilter := NewItemFilter;
        SourceTypeFilter := NewSourceTypeFilter;
        SourceNoFilter := NewSourceNoFilter;
        InternalDateFilter := NewInternalDateFilter;
        PeriodInitialized := NewPeriodInitialized;
        PeriodType := NewPeriodType;
        LineDimOption := NewLineDimOption;
        ColumnDimOption := NewColumnDimOption;
        LineDimCode := NewLineDimCode;
        ColumnDimCode := NewColumnDimCode;
        RoundingFactor := NewRoundingFactor;
    end;



    local procedure EnterFilterInCell(RowNo: Integer; "Filter": Text; FieldName: Text[100])
    begin
        EnterCell(RowNo, 1, FieldName, FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
        EnterCell(RowNo, 2, COPYSTR(Filter, 1, 250), FALSE, FALSE, FALSE, '', TempExcelBuffer."Cell Type"::Text, '', '', FALSE, FALSE, FALSE);
    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option; Formula: Text; Comment: Text; Mergee: Boolean; Boorder: Boolean; DoubleU: Boolean)
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := NumberFormat;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.Comment := Comment;
        IF Mergee = TRUE THEN
            TempExcelBuffer.MergeCells('I1:N1');
        TempExcelBuffer.BorderYes := Boorder;
        IF Boorder = TRUE THEN
            TempExcelBuffer."Border Style" := 1
        ELSE
            TempExcelBuffer."Border Style" := 0;
        TempExcelBuffer."Double Underline" := DoubleU;
        TempExcelBuffer.INSERT;
    end;

    local procedure FindLine(Which: Text[1024]): Boolean
    begin
        EXIT(
          ItemBudgetManagement.FindRec(
            ItemBudgetName, LineDimOption, LineDimCodeBuffer, Which,
            ItemFilter, SourceNoFilter, PeriodType, DateFilter, PeriodInitialized, InternalDateFilter,
            GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter, BudgetDim2Filter, BudgetDim3Filter));
    end;

    local procedure NextLine(Steps: Integer): Integer
    begin
        EXIT(
          ItemBudgetManagement.NextRec(
            ItemBudgetName, LineDimOption, LineDimCodeBuffer, Steps,
            ItemFilter, SourceNoFilter, PeriodType, DateFilter,
            GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter, BudgetDim2Filter, BudgetDim3Filter));
    end;

    local procedure FindColumn(Which: Text[1024]): Boolean
    begin
        EXIT(
          ItemBudgetManagement.FindRec(
            ItemBudgetName, ColumnDimOption, ColumnDimCodeBuffer, Which,
            ItemFilter, SourceNoFilter, PeriodType, DateFilter, PeriodInitialized, InternalDateFilter,
            GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter, BudgetDim2Filter, BudgetDim3Filter));
    end;

    local procedure NextColumn(Steps: Integer): Integer
    begin
        EXIT(
          ItemBudgetManagement.NextRec(
            ItemBudgetName, ColumnDimOption, ColumnDimCodeBuffer, Steps,
            ItemFilter, SourceNoFilter, PeriodType, DateFilter,
            GlobalDim1Filter, GlobalDim2Filter, BudgetDim1Filter, BudgetDim2Filter, BudgetDim3Filter));
    end;


    procedure SetUpdateExistingWorksheet(UpdateExistingWorksheet: Boolean)
    begin
        DoUpdateExistingWorksheet := UpdateExistingWorksheet;
    end;


    procedure SetFileNameSilent(NewFileName: Text)
    begin
        ServerFileName := NewFileName;
    end;


    procedure SetTestMode(NewTestMode: Boolean)
    begin
        TestMode := NewTestMode;
    end;



    /* procedure GetCellDecorator2(IsBold: Boolean; IsItalic: Boolean; IsUnderlined: Boolean; IsDoubleUnderlined: Boolean; var Decorator: DotNet CellDecorator; CustomBorder: DotNet Border2; BorderYes: Boolean)
     var
         XlWrkBkWriter: DotNet WorkbookWriter;
         XlWrkBkReader: DotNet WorkbookReader;
         XlWrkShtWriter: DotNet WorksheetWriter;
         XlWrkShtReader: DotNet WorksheetReader;
     begin
         IF IsBold AND IsItalic THEN BEGIN
             IF IsDoubleUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultBoldItalicDoubleUnderlinedCellDecorator;
                 EXIT;
             END;
             IF IsUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultBoldItalicUnderlinedCellDecorator;
                 EXIT;
             END;
         END;

         IF IsBold AND IsItalic THEN BEGIN
             Decorator := XlWrkShtWriter.DefaultBoldItalicCellDecorator;
             EXIT;
         END;

         IF IsBold THEN BEGIN
             IF IsDoubleUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultBoldDoubleUnderlinedCellDecorator;
                 EXIT;
             END;
             IF IsUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultBoldUnderlinedCellDecorator;
                 EXIT;
             END;
         END;

         IF IsBold THEN BEGIN
             Decorator := XlWrkShtWriter.DefaultBoldCellDecorator;
             EXIT;
         END;

         IF IsItalic THEN BEGIN
             IF IsDoubleUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultItalicDoubleUnderlinedCellDecorator;
                 EXIT;
             END;
             IF IsUnderlined THEN BEGIN
                 Decorator := XlWrkShtWriter.DefaultItalicUnderlinedCellDecorator;
                 EXIT;
             END;
         END;

         IF IsItalic THEN BEGIN
             Decorator := XlWrkShtWriter.DefaultItalicCellDecorator;
             EXIT;
         END;

         IF IsDoubleUnderlined THEN
             Decorator := XlWrkShtWriter.DefaultDoubleUnderlinedCellDecorator
         ELSE BEGIN
             IF IsUnderlined THEN
                 Decorator := XlWrkShtWriter.DefaultUnderlinedCellDecorator
             ELSE
                 Decorator := XlWrkShtWriter.DefaultCellDecorator;
         END;
     end;

    local procedure EnterFormula(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; UnderLine: Boolean; NumberFormat: Text[30])
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := '';
        TempExcelBuffer.Formula := CellValue; // is converted to formula later.
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := '';
        TempExcelBuffer.INSERT;
    end;
}
*/