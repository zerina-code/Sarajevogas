codeunit 50020 "Export TimeSheet 2 Excel"
{
    /*
    var
        BookNameTxt: Label 'Export Timesheet';
        SheetNameTxt: Label 'Timesheet';
        HeaderTxt: Label 'Export Timesheet';
        ChoiceTxt: Label 'Open as File,Email as Attachment';
        Company: Record "Company Information";
        IDMonth: Integer;
        IDYear: Integer;

        Dow: Text[2000];
        Comp: Record Company;
        Text000: Text;
        Text001: Text;
        Text002: Text;
        Text003: Text;
        Text004: Text;
        Text005: Text;
        Text006: Text;
        Text007: Text;
        Text008: Text;
        Text009: Text;
        Text0010: Text;
        Text011: Text;
        Text012: Text;
        Text013: Text;
        Text014: Text;
        Startdate: Date;
        Enddate: Date;




    trigger OnRun()
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


        Export2Excel();
    end;

    local procedure Export2Excel()
    var
        TempExcelBuf: Record "Excel Buffer" temporary;
        Choice: Integer;
    begin

        InitExcel(TempExcelBuf);
        FillExcelBuffer(TempExcelBuf);
        TempExcelBuf.CloseBook();
        TempExcelBuf.OpenExcel();


    end;

local procedure InitExcel(var TempExcelBuf:Record)
var
    myInt: Integer;
begin
    
end;

    local procedure FillExcelBuffer(var TempExcelBuf: Record "Excel Buffer" temporary)
    var
        COA: Record "Cause of Absence";
    begin
        if COA.FindSet() then
            repeat
                FillExcelRow(TempExcelBuf, COA);
            until COA.Next() = 0;
    end;

    local procedure FillExcelRow(
        var TempExcelBuf: Record "Excel Buffer" temporary;
        COA: Record "Cause of Absence")
    begin

        TempExcelBuf.EnterCell(TempExcelBuf, 1, 9, 'PREGLED PRISUSTVA NA POSLU I ODSUSTVA SA POSLA', false, false, false);

        with COA do begin
            TempExcelBuf.NewRow();
            TempExcelBuf.AddColumn(Description, false, '', false, false, false, '', TempExcelBuf."Cell Type"::Text);
            TempExcelBuf.NewRow();
            TempExcelBuf.NewRow();

            IF Company.FIND('-') THEN
                Comp.SETFILTER(Name, COMPANYNAME);
            IF Comp.FIND('-') THEN
                TempExcelBuf.EnterCell(TempExcelBuf, 3, 12, Company.Name, false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 3, 2, Text001 + ' ' + Format(Dow), false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 4, 2, Text002 + ' ' + Format(IDYear), false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 6, 2, Format(IDMonth) + ' ' + Format(IDYear), false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 3, 7, Format(Text003), false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 4, 7, Format(Text004), false, false, false);
            TempExcelBuf.EnterCell(TempExcelBuf, 3, 22, Format(Text005), false, false, false);


        end;
    end;

    local procedure OpenExcelFile(var TempExcelBuf: Record "Excel Buffer" temporary)
    begin
        TempExcelBuf.CreateNewBook('Timesheet');
        TempExcelBuf.WriteSheet('Timesheet', CompanyName(), UserId());
        TempExcelBuf.CloseBook();
        TempExcelBuf.OpenExcel();
    end;

    procedure SetParam(var StartDatee: Date; var EndDatee: Date)
    begin
        Startdate := StartDatee;
        Enddate := EndDatee;
        Text000 := 'PREGLED PRISUSTVA NA POSLU I ODSUSTVA SA POSLA';
        Text001 := 'MJESEC';
        Text002 := 'GODINA';
        Text003 := 'ORGANIZACIJA PREDUZEĆE';
        Text004 := 'ODJEL';
        Text005 := 'LEGENDA';
        Text006 := 'IME I PREZIME';
        Text007 := 'ŠIFRA';
        Text008 := 'Satnice su kreirane';
        Text009 := 'Svi uposlenici idu u jedan excel';
        Text0010 := 'ODJEL';
        Text011 := 'IME';
        Text012 := 'U';
        Text013 := 'REKAPITULACIJA PO UPOSLENICIMA PREMA BROJU SATI';
        Text014 := 'Excel je sačuvan kao:';

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
        IDMonth := DATE2DMY(CALCDATE('-1M', TODAY), 2);
        IDYear := DATE2DMY(CALCDATE('-1M', TODAY), 3);

        Message(Format(Dow));



    end;*/
}
