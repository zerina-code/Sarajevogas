report 50163 "RBBH report 2"
{
    Caption = 'RBBH report 2';

    DefaultLayout = RDLC;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem2; "Wage/Reduction Bank Accounts")
        {
            dataitem(DataItem1; "Payment Order")
            {
                column(RacunPrimaoca; SvrhaDoznake1)
                {
                }
                column(DatumUplate; DatumUplate)
                {

                }

                column(RedniBroj; RedniBroj)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    Brojac += 1;
                    RedniBroj := 'DATP' + PADSTR('', 12 - STRLEN(FORMAT(Brojac)), '0') + FORMAT(Brojac, 0);

                    if Brojac = 1 then
                        GenerateTextFile();
                end;

                trigger OnPreDataItem()
                begin
                    SETFILTER("Wage Header No.", '%1', ZaglavljePlate);
                    SETFILTER(Contributon, '%1', 'PLAĆA');
                    SETFILTER(RacunPrimaoca, '%1', DataItem2."Account No");
                end;
            }

            trigger OnPreDataItem()
            begin
                SetFilter("Bank Code", '%1|%2', 'RBBH', 'RAIFFEISEN');
            end;
        }
    }

    procedure SetParam(BrojZaglavljaPlate: Code[20])
    begin
        ZaglavljePlate := BrojZaglavljaPlate;
    end;

    procedure GenerateTextFile()
    var
        Instr: InStream;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        FirstString: Text;
        FormattedAmount: Text;
        IntegerPart: Text;
        DecimalPart: Text;
        SplitPos: Integer;
        TotalAmount: Decimal;
        PayMentOrder2: Record "Payment Order";
        K: Integer;
        BrojNula: Integer;
        BrojCifaraIznos: Integer;
        CompanyInfo: Record "Company Information";
        WageRed: Record "Wage/Reduction Bank Accounts";
        BankAcc: Record "Bank Account";
        SWIFTCode: Code[20];
    begin
        FileName := 'Spisak Raiffeisen 2.txt';
        TempBlob.CreateOutStream(OutStr, TextEncoding::UTF8);

        CompanyInfo.Get();

        Brojac := 0;
        //  TotalAmount := 0;
        WageRed.SetFilter("Bank Code", '%1|%2', 'RBBH', 'RAIFFEISEN');
        if WageRed.FindSet() then
            repeat
                PayMentOrder2.Reset();
                PayMentOrder2.SetFilter("Wage Header No.", ZaglavljePlate);
                PayMentOrder2.SetFilter(Contributon, 'PLAĆA');
                PayMentOrder2.SetFilter(RacunPrimaoca, WageRed."Account No");
                //   PayMentOrder2.SETFILTER(RacunPrimaoca, '%1', WageRed."Account No");


                // PayMentOrder2.RESET;
                //PayMentOrder2.CopyFilters(PaymentOrder);
                if PayMentOrder2.FINDSET then
                    repeat
                        FirstString := '';
                        Brojac += 1;
                        FirstString += 'DATP' + PADSTR('', 12 - STRLEN(FORMAT(Brojac)), '0') + FORMAT(Brojac, 0);
                        // Formatiraj broj sa 15 cifara
                        //  FirstString += '\t';
                        FirstString += PADSTR('', 11, ' ');

                        if PayMentOrder2."DatumUplate" <> 0D then
                            FirstString += FORMAT(PayMentOrder2."DatumUplate", 0, '<Year4><Month,2><Day,2>');


                        if CompanyInfo."Name 2" <> '' then
                            FirstString += CompanyInfo."Name 2";



                        FirstString += PADSTR('', 19, ' ');

                        // Adresa firme
                        if CompanyInfo.Address <> '' then
                            FirstString += CompanyInfo.Address;

                        FirstString += PADSTR('', 224, ' ');

                        BankAcc.Reset();
                        BankAcc.SetFilter("Bank Account No.", '161*');
                        if BankAcc.FindFirst() then begin

                            FirstString += BankAcc."SWIFT Code";

                        end;




                        FirstString += PADSTR('', 35, ' ');

                        FirstString += PayMentOrder2.SvrhaDoznake1;
                        FirstString += PADSTR('', 3, ' ');


                        if Employee.Get(PayMentOrder2.SvrhaDoznake3) then begin
                            if Employee."Employee ID" <> '' then
                                FirstString += '518' + Employee."Employee ID";
                            FirstString += PADSTR('', 5, ' ');
                        end;
                        FirstString += PADSTR('', 113, ' ');

                        FormattedAmount := FORMAT(ROUND(PayMentOrder2.Iznos, 0.01), 0, 9);
                        SplitPos := STRPOS(FormattedAmount, ',');
                        IF SplitPos = 0 THEN
                            SplitPos := STRPOS(FormattedAmount, '.');

                        IF SplitPos > 0 THEN BEGIN
                            IntegerPart := DELSTR(FormattedAmount, SplitPos);
                            DecimalPart := COPYSTR(FormattedAmount, SplitPos + 1);
                            IF STRLEN(DecimalPart) = 1 THEN
                                DecimalPart += '0';
                        END ELSE BEGIN
                            IntegerPart := FormattedAmount;
                            DecimalPart := '00';
                        END;

                        // Dodavanje prefiksa BAM + 12 cifara prije tačke
                        LastString := 'BAM';
                        BrojCifaraIznos := STRLEN(IntegerPart);
                        NumberZero := 12 - BrojCifaraIznos; // 12 cifara prije tačke
                        FOR K := 1 TO NumberZero DO
                            LastString += '0';

                        LastString += IntegerPart + '.' + DecimalPart;
                        FirstString += '  ' + LastString;

                        OutStr.WRITETEXT(FirstString);
                        OutStr.WRITETEXT();

                    // TotalAmount += PayMentOrder2.Iznos;
                    until PayMentOrder2.Next() = 0;
            until WageRed.Next() = 0;


        //  FirstString := '';
        // FormattedAmount := FORMAT(ROUND(TotalAmount, 0.01), 0, 9);
        /*   SplitPos := STRPOS(FormattedAmount, ',');
           if SplitPos = 0 then
               SplitPos := STRPOS(FormattedAmount, '.');

           if SplitPos > 0 then begin
               IntegerPart := DELSTR(FormattedAmount, SplitPos);
               DecimalPart := COPYSTR(FormattedAmount, SplitPos + 1);
               if STRLEN(DecimalPart) = 1 then
                   DecimalPart += '0';
           end else begin
               IntegerPart := FormattedAmount;
               DecimalPart := '00';
           end;

           BrojCifaraIznos := STRLEN(IntegerPart);
           BrojNula := 12 - BrojCifaraIznos; // 12 cifara prije tačke
           for K := 1 to BrojNula do
               FirstString += '0';

           FirstString += IntegerPart + '.' + DecimalPart;*/
        //  OutStr.WRITETEXT(FirstString);
        //  OutStr.WRITETEXT();


        TempBlob.CreateInStream(Instr, TextEncoding::UTF8);
        DownloadFromStream(Instr, '', '', '', FileName);
    end;


    var
        RedniBroj: Code[50];
        Employee: Record "Employee";
        Brojac: Integer;
        MaticniBroj: Code[13];
        File1: File;
        OutStreamObj: OutStream;
        FirstString: Text;
        TempB: Codeunit "Temp Blob";
        Vrijednost: Text;
        IznosStvarni: Text;
        PayMentOrder: Record "Payment Order";
        IntegerValue: Integer;
        PayMentOrder2: Record "Payment Order";
        ZaglavljePlate: Code[50];
        BrojCifaraIznos: Integer;
        K: Integer;
        BrojNula: Integer;
        Decimal: Integer;
        Brojaccc: Integer;
        NumberOfRecord: Integer;
        PayMentOrder3: Record "Payment Order";
        LastString: Text;
        NumberZero: Integer;
        Suma: Decimal;
        IntegerValueSuma: Integer;
        DecimalSuma: Integer;
}
