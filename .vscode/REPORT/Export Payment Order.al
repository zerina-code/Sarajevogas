report 50100 "Export Payment Order"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Izvoz virmana';
    ProcessingOnly = true;
    ShowPrintStatus = true;


    dataset
    {
        dataitem(DataItemName; "Payment Order")
        {

            RequestFilterFields = "Wage Header No.", "Wage Calculation Type";


            column(Wage_Header_No_; "Wage Header No.")
            {
            }


            trigger OnPreDataItem()
            var
                myInt: Integer;
                POP: Record "Payment Order";
            begin
                WS.Get();
                WH.Reset();
                POP.reset;
                POP.CopyFilters(DataItemName);
                POP.FindFirst();
                WH.SetFilter("No.", '%1', POP."Wage Header No.");
                WH.FindFirst();


                IF EXISTS(WS."Path for CBS" + 'Virmani za obračunsku platu mjesec ' + format(WH."Month Of Wage") + ' godina ' + format(WH."Year Of Wage") + '.txt') THEN
                    ERASE(WS."Path for CBS" + 'Virmani za obračunsku platu mjesec ' + format(WH."Month Of Wage") + ' godina ' + format(WH."Year Of Wage") + '.txt');


                File1.CREATE(WS."Path for CBS" + 'Virmani za obračunsku platu mjesec ' + format(WH."Month Of Wage") + ' godina ' + format(WH."Year Of Wage") + '.txt', TextEncoding::UTF8);
                File1.CREATEOUTSTREAM(OutStreamObj);
                Brojac := 0;
                CharTab := 9;
                PO.Reset();
                PO.CopyFilters(DataItemName);
                if PO.FindFirst() then begin
                    PO.CalcSums(Iznos);
                end;
                StringV := '';

                IznosTe := format(PO.Iznos);
                IznosTe := ReplaceString(IznosTe, '.', '');

                StringV += format(PO.Count) + Format(CharTab) + format(ReplaceString(IznosTe, ',', '.'));
                OutStreamObj.WRITETEXT(StringV);
                OutStreamObj.WRITETEXT();




            end;



            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin

                CharTab := 9;
                Brojac += 1;
                StringV := '';
                StringV += Format(Brojac);
                CompInf.get();
                StringV += Format(CharTab);
                StringV += CompInf.Name + ' ' + CompInf.Address;
                StringV += Format(CharTab);
                StringV += RacunPrimaoca;
                StringV += Format(CharTab);
                StringV += Format(SvrhaDoznake1);
                StringV += Format(CharTab);
                IznosT := format(Iznos);
                IznosT := ReplaceString(IznosT, '.', '');
                StringV += Format(ReplaceString(IznosT, ',', '.'));

                StringV += Format(CharTab);
                StringV += Format(SvrhaDoznake2);
                StringV += Format(CharTab);
                StringV += Format('F');
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format(CompInf."Registration No.");
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format(0);
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format(VrstaPrihoda);
                StringV += Format(CharTab);

                //Format(date,0,'<Day,2>/<Month,2>/<Year4>');
                //2022-10-31 00:00:00
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then begin
                    StringV += Format('');
                end

                else begin
                    if (PorezniPeriodOd <> 0D) and (PorezniPeriodDo <> 0D) then
                        StringV += Format(format(Date2DMY(PorezniPeriodOd, 3)) + '-' + format(+Date2DMY(PorezniPeriodOd, 2)) + '-' + format(+Date2DMY(PorezniPeriodOd, 1)) + ' 00:00:00')
                    else
                        StringV += '';
                end;


                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then begin
                    StringV += Format('');
                end
                else begin

                    if (PorezniPeriodOd <> 0D) and (PorezniPeriodDo <> 0D) then
                        StringV += format(format(Date2DMY(PorezniPeriodDo, 3)) + '-' + format(+Date2DMY(PorezniPeriodDo, 2)) + '-' + format(+Date2DMY(PorezniPeriodDo, 1)) + ' 00:00:00')
                    else
                        StringV += '';
                end;
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format(Opstina);
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format("Budget Organisation");
                StringV += Format(CharTab);
                if (DataItemName.Contributon = 'PLAĆA') or (DataItemName.Contributon = 'Obustava') then
                    StringV += Format('')
                else
                    StringV += Format(PozivNaBroj);
                StringV += Format(CharTab);
                StringV += Format('');
                StringV += Format(CharTab);
                StringV += Format(RacunPosiljaoca);
                OutStreamObj.WRITETEXT(StringV);
                OutStreamObj.WRITETEXT();

















            end;


        }






    }
    trigger OnPostReport()
    var
        myInt: Integer;
    begin
        File1.CLOSE;
        FileM.DownloadToFile(WS."Path for CBS" + 'Virmani za obračunsku platu mjesec ' + format(WH."Month Of Wage") + ' godina ' + format(WH."Year Of Wage") + '.txt', 'Virmani za obračunsku platu mjesec ' + format(WH."Month Of Wage") + ' godina ' + format(WH."Year Of Wage") + '.txt');

        Message('Obrada je završena!');

    end;






    var
        myInt: Integer;
        CharTab: Char;
        PO: Record "Payment Order";
        OutStreamObj: OutStream;
        Brojac: Integer;
        File1: File;
        StringV: Text;
        IznosTe: Text[250];
        CompInf: Record "Company Information";
        IznosT: text[250];
        WS: Record "Wage Setup";
        WH: Record "Wage Header";
        FileM: Codeunit "File Management";


    procedure ReplaceString(var String: Text; FindWhat: Text; ReplaceWIth: Text) NewString: Text

    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWIth + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;

    end;

}