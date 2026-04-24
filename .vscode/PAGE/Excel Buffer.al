tableextension 50109 "Excel" extends "Excel Buffer"
{
    fields
    {
        // Add changes to table fields here
        field(50006; BorderYes; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Custom Font Size"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Custom BGColor"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Custom Font Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Custom Font Color"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Using Custom Decorator"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Custom Border"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50007; "Border Style"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,xlLineStyleNone,xlContinuous,xlDash,xlDashDot,xlDashDotDot,xlDot,xlDouble,xlSlantDashDot';
            OptionMembers = " ",xlLineStyleNone,xlContinuous,xlDash,xlDashDot,xlDashDotDot,xlDot,xlDouble,xlSlantDashDot;
        }

    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }


    procedure SetBorderStyle() BorderS: Integer
    begin

        CASE "Border Style" OF
            "Border Style"::" ":
                BEGIN
                    EXIT(-4142);
                END;
            "Border Style"::xlLineStyleNone:
                BEGIN
                    EXIT(1);
                END;
            "Border Style"::xlContinuous:
                BEGIN
                    EXIT(-4115);
                END;
            "Border Style"::xlDash:
                BEGIN
                    EXIT(4);
                END;
            "Border Style"::xlDashDot:
                BEGIN
                    EXIT(5);
                END;
            "Border Style"::xlDashDotDot:
                BEGIN
                    EXIT(-4118);
                END;
            "Border Style"::xlDot:
                BEGIN
                    EXIT(-4119);
                END;
            "Border Style"::xlDouble:
                BEGIN
                    EXIT(13);
                END;
            ELSE
                EXIT(-4142);
        END;
    end;

    procedure MergeCells(RangeText: Text)
    begin

        IF ISNULL(MergedCellsList) THEN
            MergedCellsList := MergedCellsList.List;

        MergedCellsList.Add(RangeText);
    end;

    procedure GetFormula(): Text[1000]
    begin
        EXIT(Formula + Formula2 + Formula3 + Formula4);
    end;

    procedure SetFormula(LongFormula: Text[1000])
    begin
        ClearFormula;
        IF LongFormula = '' THEN
            EXIT;

        Formula := COPYSTR(LongFormula, 1, MAXSTRLEN(Formula));
        IF STRLEN(LongFormula) > MAXSTRLEN(Formula) THEN
            Formula2 := COPYSTR(LongFormula, MAXSTRLEN(Formula) + 1, MAXSTRLEN(Formula2));
        IF STRLEN(LongFormula) > MAXSTRLEN(Formula) + MAXSTRLEN(Formula2) THEN
            Formula3 := COPYSTR(LongFormula, MAXSTRLEN(Formula) + MAXSTRLEN(Formula2) + 1, MAXSTRLEN(Formula3));
        IF STRLEN(LongFormula) > MAXSTRLEN(Formula) + MAXSTRLEN(Formula2) + MAXSTRLEN(Formula3) THEN
            Formula4 := COPYSTR(LongFormula, MAXSTRLEN(Formula) + MAXSTRLEN(Formula2) + MAXSTRLEN(Formula3) + 1, MAXSTRLEN(Formula4));
    end;

    procedure AddToFormula(Text: Text[50]): Boolean
    var
        Overflow: Boolean;
        LongFormula: Text[1000];
    begin
        LongFormula := GetFormula;
        IF LongFormula = '' THEN
            LongFormula := '=';
        IF LongFormula <> '=' THEN
            IF STRLEN(LongFormula) + 1 > MAXSTRLEN(LongFormula) THEN
                Overflow := TRUE
            ELSE
                LongFormula := LongFormula + '+';
        IF STRLEN(LongFormula) + STRLEN(Text) > MAXSTRLEN(LongFormula) THEN
            Overflow := TRUE
        ELSE
            SetFormula(LongFormula + Text);
        EXIT(Overflow);
    end;

    procedure AddColumnWithFonts(Value: Variant; IsFormula: Boolean; CommentText: Text; IsBold: Boolean; IsItalics: Boolean; IsUnderline: Boolean; NumFormat: Text[30]; CellType: Option; FontName: Text; FontSize: Integer; FontColor: Integer; BGColour: Integer; Usingcustomformat: Boolean; RowValue: Integer; ColumnValue: Integer; BorderYesUpit: Boolean)
    begin




        INIT;
        VALIDATE("Row No.", RowValue);
        VALIDATE("Column No.", ColumnValue);
        IF IsFormula THEN
            SetFormula(FORMAT(Value))
        ELSE
            "Cell Value as Text" := FORMAT(Value);
        Comment := CommentText;
        Bold := IsBold;
        Italic := IsItalics;
        Underline := IsUnderline;
        NumberFormat := NumFormat;
        NumberFormat := NumFormat;
        "Cell Type" := CellType;


        "Custom Font Name" := FontName;
        "Custom Font Size" := FontSize;
        "Custom Font Color" := FontColor;
        "Custom BGColor" := BGColour;
        "Using Custom Decorator" := Usingcustomformat;
        BorderYes := TRUE;
        "Border Style" := 1;
        "Double Underline" := TRUE;



        INSERT;
    end;

    procedure ExportBudgetFilterToFormula2(var ExcelBuf: Record "Excel Buffer"; Cause: Code[20]; Red: Integer; Kolona: Integer; SumDa: Boolean): Boolean
    var
        TempExcelBufFormula: Record "Excel Buffer" temporary;
        TempExcelBufFormula2: Record "Excel Buffer" temporary;
        FirstRow: Integer;
        LastRow: Integer;
        HasFormulaError: Boolean;
        ThisCellHasFormulaError: Boolean;
    begin

        TempExcelBufFormula4.DELETEALL;
        TempExcelBufFormula5.DELETEALL;
        ExcelBuf3.DELETEALL;
        ExcelBuf.RESET;
        IF ExcelBuf.FINDSET THEN
            REPEAT
                TempExcelBufFormula4 := ExcelBuf;

                TempExcelBufFormula4.INSERT;
                TempExcelBufFormula5 := ExcelBuf;

                TempExcelBufFormula5.INSERT;

                ExcelBuf3 := ExcelBuf;

                ExcelBuf3.INSERT;


            UNTIL ExcelBuf.NEXT = 0;



        ExcelBuf.RESET;
        ExcelBuf.SETFILTER(Formula, '<>%1', '');
        IF ExcelBuf.FINDSET THEN
            REPEAT
                TempExcelBufFormula := ExcelBuf;
                TempExcelBufFormula.INSERT;
            UNTIL ExcelBuf.NEXT = 0;

        TempExcelBufFormula4.RESET;
        TempExcelBufFormula4.SETFILTER(Comment, '<>%1', '');
        TempExcelBufFormula4.SETCURRENTKEY(xlRowID);
        TempExcelBufFormula4.ASCENDING;
        IF TempExcelBufFormula4.FINDFIRST THEN
            Slovo := TempExcelBufFormula4.xlColID;

        TempExcelBufFormula4.RESET;
        TempExcelBufFormula4.SETFILTER(Comment, '<>%1', '');
        TempExcelBufFormula4.SETCURRENTKEY(xlRowID);
        TempExcelBufFormula4.ASCENDING;
        IF TempExcelBufFormula4.FINDLAST THEN
            Slovo2 := TempExcelBufFormula4.xlColID;

        UserSetup.RESET;
        UserSetup.SETFILTER("User ID", '%1', USERID);
        IF UserSetup.FINDFIRST THEN BEGIN
            UserSetup.Slovo := Slovo;
            UserSetup."Slovo 2" := Slovo2;
            UserSetup.MODIFY;
        END;

        ExcelBuf.RESET;

        ExcelBuf.SETFILTER(Formula, '<>%1', '');
        ExcelBuf.SETFILTER("Row No.", '%1', Red);
        ExcelBuf.SETFILTER("Column No.", '%1', Kolona);
        IF ExcelBuf.FINDSET THEN
            REPEAT

                TempExcelBufFormula2 := TempExcelBufFormula;
                TempExcelBufFormula := TempExcelBufFormula2;
                ClearFormula;


                //najveći slovo 2

                TempExcelBufFormula5.RESET;
                TempExcelBufFormula5.SETFILTER("Row No.", '%1', Rec."Row No.");
                TempExcelBufFormula5.SETCURRENTKEY(xlRowID);
                TempExcelBufFormula5.ASCENDING;
                IF TempExcelBufFormula5.FINDFIRST THEN BEGIN
                    Inteer := TempExcelBufFormula5."Column No.";

                END;



                TempExcelBufFormula4.RESET;
                TempExcelBufFormula4.SETFILTER("Column No.", '%1', Inteer);
                TempExcelBufFormula4.SETFILTER("Row No.", '%1', TempExcelBufFormula5."Row No.");
                TempExcelBufFormula4.SETCURRENTKEY(xlRowID);
                TempExcelBufFormula4.ASCENDING;
                IF TempExcelBufFormula4.FINDFIRST THEN BEGIN


                    // UserSetup.RESET;
                    UserSetup.SETFILTER("User ID", '%1', USERID);
                    IF UserSetup.FINDFIRST THEN BEGIN
                        UserSetup.Red := TempExcelBufFormula4."Cell Value as Text";
                        UserSetup.MODIFY;
                    END;

                END;
                UserSetup.RESET;
                UserSetup.SETFILTER("User ID", '%1', USERID);
                IF UserSetup.FINDFIRST THEN BEGIN
                    TempExcelBufFormula4.RESET;
                    TempExcelBufFormula4.SETFILTER("Cell Value as Text", '%1', UserSetup.Red);
                    TempExcelBufFormula4.SETFILTER("Row No.", '<>%1', TempExcelBufFormula5."Row No.");
                    TempExcelBufFormula4.SETCURRENTKEY(xlRowID);
                    TempExcelBufFormula4.ASCENDING;
                    IF TempExcelBufFormula4.FINDFIRST THEN BEGIN



                        /*


                        TempExcelBufFormula4.RESET;
                        TempExcelBufFormula4.SETFILTER("Column No.",'%1',Inteer);
                        TempExcelBufFormula4.SETFILTER("Row No.",'%1',Rec."Row No.");
                        IF TempExcelBufFormula4.FINDFIRST THEN BEGIN */


                        if SumDa = false then
                            UserSetup.Final := '=COUNTIF(' + UserSetup.Slovo + FORMAT(TempExcelBufFormula4."Row No.") + ':' + UserSetup."Slovo 2" + FORMAT(TempExcelBufFormula4."Row No.") + ',"' + Cause + '")*8'
                        else
                            UserSetup.Final := '=SUMIF(' + UserSetup.Slovo + FORMAT(TempExcelBufFormula4."Row No.") + ':' + UserSetup."Slovo 2" + FORMAT(TempExcelBufFormula4."Row No.") + ',"' + '<=24' + '")';


                        //UserSetup.Final:='COUNT(' + UserSetup.Slovo + FORMAT(TempExcelBufFormula4."Row No.") + ':' + UserSetup."Slovo 2" + FORMAT(TempExcelBufFormula4."Row No.") + ')';
                        UserSetup.MODIFY;
                        if SumDa = false then
                            ThisCellHasFormulaError := AddToFormula('COUNTIF(' + UserSetup.Slovo + FORMAT(TempExcelBufFormula4."Row No.") + ':' + UserSetup."Slovo 2" + FORMAT(TempExcelBufFormula4."Row No.") + ',"' + Cause + '")*8')
                        else
                            ThisCellHasFormulaError := AddToFormula('SUMIF(' + UserSetup.Slovo + FORMAT(TempExcelBufFormula4."Row No.") + ':' + UserSetup."Slovo 2" + FORMAT(TempExcelBufFormula4."Row No.") + ',"' + '<=24' + '")');


                        //ThisCellHasFormulaError:=AddToFormula('COUNTIF('+UserSetup.Slovo+FORMAT(TempExcelBufFormula4."Row No.")+':'+UserSetup."Slovo 2"+FORMAT(TempExcelBufFormula4."Row No.")+';"'+Cause+'")*8');

                    END;
                END;
                SetFormula(ExcelBuf.GetExcelReference(7));


                ExcelBuf.RESET;
                UserSetup.RESET;
                UserSetup.SETFILTER("User ID", '%1', USERID);
                IF UserSetup.FINDFIRST THEN BEGIN
                    ExcelBuf.GET("Row No.", "Column No.");
                    ExcelBuf.SetFormula(UserSetup.Final);
                    IF ExcelBuf."Cell Value as Text" = '' THEN
                        ExcelBuf.MODIFY;
                    HasFormulaError := HasFormulaError OR ThisCellHasFormulaError;

                END;
            UNTIL ExcelBuf.NEXT = 0;
        EXIT(HasFormulaError);

    end;

    /* procedure AutoFit(RangeName: Text[50])
     var
         XlHelper: DotNet ExcelHelper2;
         XlWrkBk: DotNet Workbook2;
     begin
         IF NOT ISNULL(XlWrkBk) THEN
             XlHelper.AutoFitRangeColumns(XlWrkBk, 'Proračun', RangeName);
     end;*/


    var
        myInt: Integer;
        MergedCellsList: DotNet List_Of_T2;
        UserSetup: Record "User Setup";
        TempExcelBufFormula4: Record "Excel Buffer" temporary;
        TempExcelBufFormula5: Record "Excel Buffer" temporary;
        ExcelBuf3: Record "Excel Buffer" temporary;
        Slovo: Text;
        Slovo2: Text;
        Intt: Integer;
        Inteer: Integer;
}