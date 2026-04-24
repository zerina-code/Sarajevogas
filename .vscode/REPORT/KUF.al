report 50032 "Electronic Purchase VAT Book"
{
    // DefaultLayout = RDLC;
    //  RDLCLayout = './KUF.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Electronic Purchase VAT Book';
    ShowPrintStatus = false;

    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST(Purchase));
            RequestFilterFields = "VAT Date";
            UseTemporary = true;
            dataitem(DataItem2; "Detailed VAT Entry")
            {
                DataItemLink = "VAT Entry No." = FIELD("Entry No."),
                               Type = FIELD(Type);
                DataItemTableView = SORTING("VAT Entry No.")
                                    ORDER(Ascending);
                UseTemporary = true;

                trigger OnAfterGetRecord()
                begin
                    c0 := 0;
                    /*IF
                      (Column1 = 0) AND
                      (Column2 = 0) AND
                      (Column3 = 0) AND
                      (Column4 = 0) AND
                      (Column5 = 0) AND
                      (Column6 = 0)
                    THEN*/

                    //CurrReport.SKIP;


                    IF Type2 = Type2::INO THEN BEGIN

                        Total1 := Total1 + Column1;
                        Total2 := Total2 + Column2 - Amounttr2;


                    END
                    ELSE BEGIN

                        Total1 := Total1 + Column1 + Amounttr2;
                        Total2 := Total2 + Column2 + Amounttr2;

                    END;




                    Total3 := Total3 + Column3;
                    Total4 := Total4 + Column4;
                    Total5 := Total5 + Column5;
                    Total6 := Total6 + Column6;

                    IF Type2 = Type2::INO THEN BEGIN
                        OutStreamObj.WRITETEXT(FORMAT(Replace(Column1)) + ';');
                        OutStreamObj.WRITETEXT(FORMAT(Replace(Column2 - Amounttr2)) + ';');
                    END
                    ELSE BEGIN
                        OutStreamObj.WRITETEXT(FORMAT(Replace(Column1 + Amounttr2)) + ';');
                        OutStreamObj.WRITETEXT(FORMAT(Replace(Column2 + Amounttr2)) + ';');
                    END;
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column3)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column4)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column5)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(Column6)) + ';');

                    CoPoDoc := 0;
                    CoPoDoc1 := 0;
                    CoPoDoc2 := 0;
                    CoPoDoc8 := 0;
                    CoPoDoc20 := 0;
                    CoPoDocFullVat := 0;
                    CoPoDoc3 := 0;
                    CoPoDoc4 := 0;
                    CoPoDoc7 := 0;
                    CoPoDocRS := 0;
                    CoPoDoc5 := 0;
                    CoPoDoc6 := 0;
                    CoPoDoc9 := 0;
                    CoPoDocBD := 0;
                    ve10.RESET;
                    ve10.SETRANGE("VAT Date", StartDate, EndDate);
                    ve10.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve10.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve10.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve10.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve10.SETFILTER(Type, '%1', ve10.Type::Purchase);
                    //ĐK ve10.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve10.FIND('-')
                     THEN
                        REPEAT
                            c0 := c0 + ve10.Amount;
                            CoPoDoc := CoPoDoc + ve10.Amount;
                        UNTIL ve10.NEXT = 0;
                    ve11.RESET;
                    ve11.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve11.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV MANJAK');
                    ve11.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve11.SETFILTER(Type, '%1', ve11.Type::Purchase);
                    //ĐK ve11.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve11.FIND('-')
                     THEN
                        REPEAT
                            c1 := c1 + ABS(ve11.Amount);
                            CoPoDoc1 := CoPoDoc1 + ABS(ve11.Amount);

                        UNTIL ve11.NEXT = 0;

                    ve12.RESET;
                    ve12.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve12.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve12.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve12.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve12.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve12.SETFILTER(Type, '%1', ve12.Type::Purchase);
                    //ĐK ve12.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve12.FIND('-')
                     THEN
                        REPEAT
                            c2 := c2 + ve12."VAT Amount (retro.)";
                            CoPoDoc2 := CoPoDoc2 + ve12."VAT Amount (retro.)";
                        UNTIL ve12.NEXT = 0;

                    ve17.RESET;
                    ve17.SETRANGE("VAT Date", StartDate, EndDate);
                    ve17.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve17.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve17.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve17.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve17.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve17.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    ve17.SETFILTER(Type, '%1', ve17.Type::Purchase);
                    IF ve17.FIND('-')
                     THEN
                        REPEAT
                            c8 := c8 + ve17."VAT Amount (retro.)";
                            CoPoDoc8 := CoPoDoc8 + ve17."VAT Amount (retro.)";
                        UNTIL ve17.NEXT = 0;

                    ve19.RESET;
                    ve19.SETRANGE("VAT Date", StartDate, EndDate);
                    //NK ve19.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve19.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                    ve19.SETFILTER(Type, '%1', ve19.Type::Purchase);
                    ve19.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve19.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve19.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve19.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve19.FIND('-')
                     THEN
                        REPEAT
                            fullvat2 := fullvat2 + ve19."VAT Amount (retro.)";
                            CoPoDocFullVat := CoPoDocFullVat + ve19."VAT Amount (retro.)";
                        UNTIL ve19.NEXT = 0;

                    c20 := 0;
                    CoPoDoc20 := 0;
                    /*ve24.RESET;
                    ve24.SETRANGE("VAT Date", StartDate,EndDate);
                    //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve24.SETFILTER("VAT Prod. Posting Group",'%1','SAMO PDV');
                    ve24.SETFILTER("Document No.",'%1',DataItem1."Document No.");
                    //ĐK ve24.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    
                    ve24.SETFILTER(Type,'%1',ve24.Type::Purchase);
                    IF ve24.FIND('-')
                     THEN REPEAT
                       c20 :=c20+ABS(ve24.Amount);
                       CoPoDoc20:=CoPoDoc20+ABS(ve24.Amount);
                    UNTIL ve24.NEXT=0;*/

                    //ROUND(c0+c1+c2+c8+fullvat2+c20,1,'<');


                    //ĐK OutStreamObj.WRITETEXT(FORMAT(ROUND(c0+c1+c2+c8+fullvat2+c20,1,'<'))+';');

                    //rs:=ROUND(c3+c4+c7+fullvat2rs,1,'<');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(ROUND(CoPoDoc + CoPoDoc1 + CoPoDoc2 + CoPoDoc8 + CoPoDocFullVat + CoPoDoc20, 0.01, '<'))) + ';');


                    IF ROUND(CoPoDoc + CoPoDoc1 + CoPoDoc2 + CoPoDoc8 + CoPoDocFullVat + CoPoDoc20, 0.01, '<') <> 0 THEN
                        Total7 := Total7 + (ROUND(CoPoDoc + CoPoDoc1 + CoPoDoc2 + CoPoDoc8 + CoPoDocFullVat + CoPoDoc20, 0.01, '<'));

                    ve13.RESET;
                    ve13.SETRANGE("VAT Date", StartDate, EndDate);
                    ve13.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve13.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve13.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve13.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve13.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    ve13.SETFILTER(Type, '%1', ve13.Type::Purchase);
                    IF ve13.FIND('-')
                     THEN
                        REPEAT
                            c3 := c3 + ve13.Amount;
                            CoPoDoc3 := CoPoDoc3 + ve13.Amount;
                        UNTIL ve13.NEXT = 0;


                    ve14.RESET;
                    ve14.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve14.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve14.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve14.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve14.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve14.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    ve14.SETFILTER(Type, '%1', ve11.Type::Purchase);
                    IF ve14.FIND('-')
                     THEN
                        REPEAT
                            c4 := c4 + ve14."VAT Amount (retro.)";
                            CoPoDoc4 := CoPoDoc4 + ve14."VAT Amount (retro.)";
                        UNTIL ve14.NEXT = 0;
                    ve20.RESET;
                    ve20.SETRANGE("VAT Date", StartDate, EndDate);
                    ve20.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve20.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve20.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve20.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');

                    ve20.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve20.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    ve20.SETFILTER(Type, '%1', ve20.Type::Purchase);
                    IF ve20.FIND('-')

                    THEN
                        REPEAT
                            c7 := c7 + ve20."VAT Amount (retro.)";
                            CoPoDoc7 := CoPoDoc7 + ve20."VAT Amount (retro.)";
                        UNTIL ve20.NEXT = 0;

                    ve21.RESET;
                    ve21.SETRANGE("VAT Date", StartDate, EndDate);
                    ve21.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve21.SETFILTER("Vendor Entity Code", '%1', 'RS');
                    ve21.SETFILTER(Type, '%1', ve21.Type::Purchase);
                    ve21.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve21.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve21.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve21.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve21.FIND('-')
                     THEN
                        REPEAT
                            fullvat2rs := fullvat2rs + ve21."VAT Amount (retro.)";
                            CoPoDocRS := CoPoDocRS + ve21."VAT Amount (retro.)";
                        UNTIL ve21.NEXT = 0;



                    //ĐK OutStreamObj.WRITETEXT(FORMAT(ROUND(c3+c4+c7+fullvat2rs,1,'<'))+';');

                    //db:=ROUND(c5+c6+c9+fullvat2db,1,'<');

                    OutStreamObj.WRITETEXT(FORMAT(Replace(ROUND(CoPoDoc3 + CoPoDoc4 + CoPoDoc7 + CoPoDocRS, 0.01, '<'))) + ';');

                    IF ROUND(CoPoDoc3 + CoPoDoc4 + CoPoDoc7 + CoPoDocRS, 0.01, '<') <> 0 THEN
                        Total8 := Total8 + (ROUND(CoPoDoc3 + CoPoDoc4 + CoPoDoc7 + CoPoDocRS, 0.01, '<'));


                    ve15.RESET;
                    ve15.SETRANGE("VAT Date", StartDate, EndDate);
                    ve15.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve15.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve15.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');
                    ve15.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve15.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    ve15.SETFILTER(Type, '%1', ve15.Type::Purchase);
                    IF ve15.FIND('-')
                     THEN
                        REPEAT
                            c5 := c5 + ve15.Amount;
                            CoPoDoc5 := CoPoDoc5 + ve15.Amount;
                        UNTIL ve15.NEXT = 0;


                    ve16.RESET;
                    ve16.SETRANGE("VAT Date", StartDate, EndDate);
                    //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                    ve16.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve16.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                    ve16.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve16.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve16.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    //ve12.SETFILTER(Type,'%1',ve11.Type::Sale);
                    IF ve16.FIND('-')
                     THEN
                        REPEAT
                            c6 := c6 + ve16."VAT Amount (retro.)";
                            CoPoDoc6 := CoPoDoc6 + ve16."VAT Amount (retro.)";
                        UNTIL ve16.NEXT = 0;

                    ve23.RESET;
                    ve23.SETRANGE("VAT Date", StartDate, EndDate);
                    ve23.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve23.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve23.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');
                    ve23.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                    ve23.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    ve23.SETFILTER("Entry No.", '%1', DataItem1."Entry No.");
                    //ĐK ve23.SETFILTER(Type,'%1',ve23.Type::Purchase);
                    IF ve23.FIND('-')

                    THEN
                        REPEAT
                            c9 := c9 + ve23."VAT Amount (retro.)";
                            CoPoDoc9 := CoPoDoc9 + ve23."VAT Amount (retro.)";
                        UNTIL ve23.NEXT = 0;
                    ve22.RESET;
                    ve22.SETRANGE("VAT Date", StartDate, EndDate);
                    ve22.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                    ve22.SETFILTER("Vendor Entity Code", '%1', 'DB');
                    ve22.SETFILTER(Type, '%1', ve22.Type::Purchase);
                    ve22.SETFILTER("VAT Calculation Type", '%1', 2);
                    ve22.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                    ve22.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                    //ĐK ve22.SETFILTER("Entry No.",'%1',DataItem1."Entry No.");
                    IF ve22.FIND('-')
                     THEN
                        REPEAT
                            fullvat2db := fullvat2db + ve22."VAT Amount (retro.)";
                            CoPoDocBD := CoPoDocBD + ve22."VAT Amount (retro.)";
                        UNTIL ve22.NEXT = 0;



                    //ĐK OutStreamObj.WRITETEXT(FORMAT(ROUND(c5+c6+c9+fullvat2db,1,'<'))+';');


                    OutStreamObj.WRITETEXT(FORMAT(Replace(ROUND(CoPoDoc5 + CoPoDoc6 + CoPoDoc9 + CoPoDocBD, 0.01, '<'))));

                    IF ROUND(CoPoDoc5 + CoPoDoc6 + CoPoDoc9 + CoPoDocBD, 0.01, '<') <> 0 THEN
                        Total9 := Total9 + (ROUND(CoPoDoc5 + CoPoDoc6 + CoPoDoc9 + CoPoDocBD, 0.01, '<'));



                    OutStreamObj.WRITETEXT();
                    BrojRedova := BrojRedova + 1;



                    CALCFIELDS("Amount retro");
                    /*Total7:=Total7+ROUND(c0+c1+c2+c8+fullvat2+c20,0.01,'<');
                    Total8:=Total8+ROUND(c3+c4+c7+fullvat2rs,0.01,'<');
                    Total9:=Total9+ROUND(c5+c6+c9+fullvat2db,0.01,'<');
                    */

                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompIn.GET;
                Brojac := Brojac + 1;

                OutStreamObj.WRITETEXT('2;');
                OutStreamObj.WRITETEXT(PorezniPeriod);
                OutStreamObj.WRITETEXT(';');



                OutStreamObj.WRITETEXT(FORMAT(Redni));
                SumaRed := Brojac;
                Redni := Redni + 1;
                OutStreamObj.WRITETEXT(';');

                //tip dokumenta
                VendorLedgerEntry.RESET;
                VendorLedgerEntry.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                IF VendorLedgerEntry.FINDFIRST THEN BEGIN
                    IF VendorLedgerEntry.Prepayment = TRUE THEN BEGIN
                        //avansi

                        TipDokumenta := '03';

                    END
                    ELSE BEGIN



                        IF (STRPOS(DataItem1."Gen. Bus. Posting Group", 'DOMAĆI') <> 0) AND (DataItem1.Import = FALSE) THEN BEGIN


                            TipDokumenta := '01';

                        END
                        ELSE BEGIN

                            IF (DataItem1.Import = TRUE) THEN BEGIN


                                TipDokumenta := '04';

                            END
                            ELSE BEGIN


                                Vendorr.RESET;
                                Vendorr.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                                IF Vendor.FINDFIRST THEN BEGIN
                                    IF Vendor."VAT Registration No." = CompIn."VAT Registration No." THEN BEGIN

                                        TipDokumenta := '02';

                                    END
                                    ELSE BEGIN

                                        TipDokumenta := '05';

                                    END;

                                END;
                            END;
                        END;
                    END;
                END;

                VatEntryUpdate.RESET;
                VatEntryUpdate.SETFILTER("Entry No.", '%1', DataItem1."Entry No.");
                VatEntryUpdate.SETFILTER("VAT Prod. Posting Group", '%1', 'AV*');
                IF VatEntryUpdate.FINDFIRST THEN
                    TipDokumenta := '03';

                //OR ( DataItem1."VAT Prod. Posting Group"='SAMO PDV A')
                IF (DataItem1."VAT Prod. Posting Group" = 'SAMO PDV A') THEN
                    TipDokumenta := '03';


                VatEntryReverse.RESET;
                VatEntryReverse.SETFILTER("Document No.", '%1', DataItem1."Document No.");
                VatEntryReverse.SETFILTER("VAT Calculation Type", '%1', VatEntryReverse."VAT Calculation Type"::"Reverse Charge VAT");
                IF VatEntryReverse.FINDFIRST THEN
                    TipDokumenta := '05';





                OutStreamObj.WRITETEXT(TipDokumenta);
                OutStreamObj.WRITETEXT(';');
                PIH.RESET;
                PIH.SETFILTER("No.", '%1', "Document No.");
                IF PIH.FIND('-') THEN
                    VendorOrder := PIH."Vendor Order No.";


                IF (("VAT Prod. Posting Group" = 'PUNI PDV') OR ("VAT Prod. Posting Group" = 'PUNI PDV2')) THEN BEGIN
                    PIH2.RESET;
                    PIH2.SETFILTER("Vendor Order No.", '%1', VendorOrder);
                    IF PIH2.FIND('-') THEN BEGIN
                        VendorName := PIH2."Pay-to Name";
                        PostingDate := PIH2."Posting Date";
                        ExternalDocumentNo := PIH2."Vendor Invoice No.";
                        DocDate := PIH2."Document Date";
                        VendAddress := PIH2."Pay-to Address";
                        VATReg := PIH2."VAT Registration No.";
                        Vendor2.RESET;
                        Vendor2.GET(PIH2."Buy-from Vendor No.");
                        RegVat := Vendor2."Registration No."




                    END
                    ELSE BEGIN

                        VendorName := '';
                        PostingDate := 0D;
                        ExternalDocumentNo := '';
                        DocDate := 0D;
                        VendAddress := '';
                        RegVat := '';
                        VATReg := '';
                    END;


                END
                ELSE BEGIN

                    VendorName := '';
                    PostingDate := 0D;
                    ExternalDocumentNo := '';
                    DocDate := 0D;
                    VATReg := '';
                    VendAddress := '';
                    RegVat := '';
                END;





                IF ExternalDocumentNo = '' THEN BEGIN


                    IF (TipDokumenta = '01') OR (TipDokumenta = '02') OR (TipDokumenta = '03') THEN BEGIN
                        OutStreamObj.WRITETEXT(DataItem1."External Document No." + ';');
                    END
                    ELSE BEGIN
                        IF (TipDokumenta = '04') OR ((TipDokumenta = '05')) THEN
                            OutStreamObj.WRITETEXT(DataItem1."External Document No." + ';');
                    END;

                END
                ELSE BEGIN
                    OutStreamObj.WRITETEXT(ExternalDocumentNo + ';');

                END;



                IF DocDate <> 0D THEN
                    OutStreamObj.WRITETEXT(FORMAT(DocDate, 10, '<Year4>-<Month,2>-<Day,2>') + ';')
                ELSE
                    //OutStreamObj.WRITETEXT(DataItem1."Document No."+';');
                    OutStreamObj.WRITETEXT(FORMAT(DataItem1."Document Date", 10, '<Year4>-<Month,2>-<Day,2>') + ';');


                IF PostingDate <> 0D THEN
                    OutStreamObj.WRITETEXT(FORMAT(PostingDate, 10, '<Year4>-<Month,2>-<Day,2>') + ';')
                ELSE
                    OutStreamObj.WRITETEXT(FORMAT(DataItem1."Posting Date", 10, '<Year4>-<Month,2>-<Day,2>') + ';');





                Vendor.RESET;
                Vendor.SETFILTER("No.", '%1', DataItem1."Bill-to/Pay-to No.");
                IF Vendor.FINDFIRST THEN BEGIN

                    IF VendorName <> '' THEN
                        OutStreamObj.WRITETEXT(VendorName + ';')
                    ELSE
                        OutStreamObj.WRITETEXT(Vendor.Name + ';');


                    IF VendAddress <> '' THEN
                        OutStreamObj.WRITETEXT(VendAddress + ';')
                    ELSE
                        OutStreamObj.WRITETEXT(Vendor.Address + ';');

                    IF (TipDokumenta = '04') THEN BEGIN
                        OutStreamObj.WRITETEXT('000000000000' + ';');
                        OutStreamObj.WRITETEXT('0000000000000' + ';');


                    END

                    ELSE BEGIN


                        IF DataItem1."Gen. Bus. Posting Group" = 'D-0-PDV' THEN BEGIN
                            OutStreamObj.WRITETEXT('' + ';');
                            OutStreamObj.WRITETEXT('' + ';');

                        END
                        ELSE BEGIN
                            IF VendorName <> '' THEN
                                OutStreamObj.WRITETEXT(VATReg + ';')
                            ELSE
                                OutStreamObj.WRITETEXT(Vendor."VAT Registration No." + ';');

                            IF VendorName <> '' THEN
                                OutStreamObj.WRITETEXT(RegVat + ';')
                            ELSE
                                OutStreamObj.WRITETEXT(Vendor."Registration No." + ';');
                        END;
                    END;
                END
                ELSE BEGIN
                    OutStreamObj.WRITETEXT('' + ';');
                    OutStreamObj.WRITETEXT('' + ';');
                    OutStreamObj.WRITETEXT('' + ';');
                END;

                DetailedVATEntry.RESET;
                DetailedVATEntry.SETFILTER("VAT Entry No.", '%1', DataItem1."Entry No.");
                IF NOT DetailedVATEntry.FINDFIRST THEN BEGIN
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)) + ';');
                    OutStreamObj.WRITETEXT(FORMAT(Replace(0)));
                    OutStreamObj.WRITETEXT();
                END;





                Amounttr2 := 0;
                ve2.RESET;
                ve2.SETFILTER("Document No.", '%1', "Document No.");
                ve2.SETFILTER("VAT Prod. Posting Group", '%1|%2', 'PUNI PDV', 'PUNI PDV2');
                IF ve2.FIND('-') THEN BEGIN

                    Amounttr2 := ve2."VAT Amount (retro.)";
                END;


                //yymm format poreznog perioda}
            end;

            trigger OnPostDataItem()
            begin
                OutStreamObj.WRITETEXT('3' + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total1)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total2)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total3)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total4)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total5)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total6)) + ';');




                OutStreamObj.WRITETEXT(FORMAT(Replace(Total7)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total8)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(Replace(Total9)) + ';');
                OutStreamObj.WRITETEXT(FORMAT(SumaRed));

                FileDoc.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                PorezniPeriod := DataItem1.GETFILTER("VAT Date");

                IF PorezniPeriod = '' THEN
                    ERROR('Porezni period mora biti unesen');
                IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
                    PorezniPeriod2 := PorezniPeriod;
                    IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                        PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
                    EVALUATE(PorezniOdDate, PorezniPeriod);
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
                END
                ELSE BEGIN
                    PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
                    PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);

                    PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
                    EVALUATE(PorezniOdDate, PorezniPeriod);

                END;

                SETFILTER("Document No.", '<>%1|%2', 'PAF*', 'CPAF*');
                SETFILTER("Source Code", '<>%1', 'OPCINALOS');
                SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-0-NEPDV');



                WorkType.RESET;
                WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
                WorkType.SETFILTER(Type, '%1', WorkType.Type::KUF);
                WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
                WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
                WorkType.SETCURRENTKEY("Number No. from");
                WorkType.ASCENDING;

                IF WorkType.FINDLAST THEN BEGIN
                    Redni := WorkType."Number No. from"
                END
                ELSE BEGIN
                    WorkType.RESET;
                    WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                    WorkType.SETCURRENTKEY("Number No. from");
                    WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
                    WorkType.SETFILTER(Type, '%1', WorkType.Type::KUF);
                    WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
                    WorkType.ASCENDING;

                    IF WorkType.FINDLAST THEN BEGIN
                        Redni := WorkType."Number No. to" + 1;
                    END
                    ELSE BEGIN
                        Redni := Redni + 1;
                    END;



                END;

                IDOd := Redni;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                group("Choose type of print for KUF")
                {
                    caption = 'Choose type of print for KUF';
                    field(Type2; Type2)
                    {
                        Caption = 'Type';
                        ApplicationArea = all;
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
        Zaglavlje := '';
        NewLine := 13;
        Brojac := 0;
        Total1 := 0;
        Total3 := 0;
        Total2 := 0;
        Total10 := 0;
        Total4 := 0;
        Total5 := 0;
        Total6 := 0;
        Total7 := 0;
        Total8 := 0;
        Total9 := 0;
        BrojRedova := 0;
        Prvi := FALSE;


        SumaRed := 0;

        //32 - fbih vlastita potrošnja
        //33 - RS vlastita potrošnja
        //34 - Brčko - vlastita potrošnja
    end;

    trigger OnPostReport()
    begin
        //OutStreamObj.WRITETEXT('3'+';');


        WorkType.RESET;
        WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
        WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
        WorkType.SETFILTER(Type, '%1', WorkType.Type::KUF);
        WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
        WorkType.SETFILTER(Description, '%1', FORMAT(Type2));
        WorkType.SETCURRENTKEY("Number No. from");
        WorkType.ASCENDING;

        IF WorkType.FINDLAST THEN BEGIN
            WorkType."Number No. to" := Redni - 1;
            IF DataItem1.ISEMPTY THEN
                WorkType.DELETE
            ELSE
                WorkType.MODIFY;
        END
        ELSE BEGIN
            IF DataItem1.ISEMPTY THEN BEGIN

            END
            ELSE BEGIN
                WorkType.INIT;
                WorkType.Description := FORMAT(Type2);
                WorkType.Type := WorkType.Type::KUF;
                WorkType.Types := WorkType.Types::"KIF KUF Logs";
                WorkType."Number No. to" := Redni - 1;
                WorkType."Number No. from" := IDOd;
                WorkType.Year := DATE2DMY(PorezniOdDate, 3);
                WorkType.Month := DATE2DMY(PorezniOdDate, 2);
                WorkType.INSERT;
            END;
        END;


        IF Type2 = Type2::"DOMAĆI" THEN BEGIN
            IF EXISTS(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '01.csv')
               THEN
                ERASE(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '01.csv');
            FileManagement.DownloadToFile(Comp."Path value" + 'TestFile2.csv', Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '01.csv');
            MESSAGE('Dokument je kreiran na lokaciji ' + Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '01.csv');
        END;

        IF Type2 = Type2::AVANSI THEN BEGIN
            IF EXISTS(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '02.csv')
               THEN
                ERASE(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '02.csv');
            FileManagement.DownloadToFile(Comp."Path value" + 'TestFile2.csv', Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '02.csv');
            MESSAGE('Dokument je kreiran na lokaciji ' + Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '02.csv');
        END;

        IF Type2 = Type2::INO THEN BEGIN
            IF EXISTS(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '03.csv')
               THEN
                ERASE(Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '03.csv');
            FileManagement.DownloadToFile(Comp."Path value" + 'TestFile2.csv', Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '03.csv');
            MESSAGE('Dokument je kreiran na lokaciji ' + Comp."Path value" + '' + Comp."VAT Registration No." + '_' + PorezniPeriod + '_' + '1' + '_' + '03.csv');
        END;


        /*  IF EXISTS(Comp."Path value" + 'TestFile2.csv') THEN
              ERASE(Comp."Path value" + 'TestFile2.csv');*/
    end;

    trigger OnPreReport()
    begin
        Comp.GET;


        VatEntryUpdate.RESET;
        VatEntryUpdate.SETFILTER("Vendor Entity Code", '<>%1', '');
        IF VatEntryUpdate.FINDSET THEN
            REPEAT

                VatEntryUpdate."Vendor Entity Code" := '';
                VatEntryUpdate."Customer Entity Code" := '';
                VatEntryUpdate.MODIFY;
            UNTIL VatEntryUpdate.NEXT = 0;


        VendorOrder := '';
        VatEntryUpdate.RESET;
        IF VatEntryUpdate.FINDSET THEN
            REPEAT
                Vendorr.RESET;
                Vendorr.SETFILTER("No.", '%1', VatEntryUpdate."Bill-to/Pay-to No.");
                IF Vendorr.FINDFIRST THEN BEGIN
                    IF Vendorr."Entity Code" <> '' THEN BEGIN
                        VatEntryUpdate."Vendor Entity Code" := Vendorr."Entity Code";
                        VatEntryUpdate.MODIFY;

                    END;
                END;

                PIH.RESET;
                PIH.SETFILTER("No.", '%1', VatEntryUpdate."Document No.");
                IF PIH.FIND('-') THEN
                    VendorOrder := PIH."Vendor Order No.";


                IF ((VatEntryUpdate."VAT Prod. Posting Group" = 'PUNI PDV') OR (VatEntryUpdate."VAT Prod. Posting Group" = 'PUNI PDV2')) THEN BEGIN
                    PIH2.RESET;
                    PIH2.SETFILTER("Vendor Order No.", '%1', VendorOrder);
                    IF PIH2.FIND('-') THEN BEGIN

                        Vendor2.RESET;
                        Vendor2.GET(PIH2."Buy-from Vendor No.");
                        IF Vendor2."Entity Code" <> '' THEN BEGIN
                            VatEntryUpdate."Vendor Entity Code" := Vendor2."Entity Code";
                            VatEntryUpdate.MODIFY;

                        END;
                    END;
                END;


            UNTIL VatEntryUpdate.NEXT = 0;


        VendorOrder := '';


        VATTemp.DELETEALL;
        DVATTemp.DELETEALL;
        VATEOrg.RESET;
        VATEOrg.COPYFILTERS(DataItem1);
        IF Type2 = Type2::INO THEN BEGIN
            VATEOrg.SETFILTER(Import, '%1', TRUE);
            VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1  & <>%2', 'AV*', 'SAMO PDV A');
        END;


        IF Type2 = Type2::AVANSI THEN BEGIN
            VATEOrg.SETFILTER("VAT Prod. Posting Group", '%1|%2', 'AV*', 'SAMO PDV A');
        END;

        IF Type2 = Type2::"DOMAĆI" THEN BEGIN
            VATEOrg.SETFILTER(Import, '%1', FALSE);
            VATEOrg.SETFILTER("VAT Prod. Posting Group", '<>%1  & <>%2', 'AV*', 'SAMO PDV A');
        END;


        //AVASNI : NAV*|NSAV*
        //INO : Import

        //OSTALI SU VALJDA DOMAĆI


        IF VATEOrg.FINDSET THEN
            REPEAT

                VATTemp.RESET;
                VATTemp.SETFILTER("External Document No.", '%1', VATEOrg."External Document No.");
                VATTemp.SETFILTER("Document No.", '%1', VATEOrg."Document No.");
                VATTemp.SETFILTER("VAT Date", '%1', VATEOrg."VAT Date");
                IF VATTemp.FINDFIRST THEN BEGIN
                    VATTemp.Base := VATTemp.Base + VATEOrg.Base;
                    VATTemp.Amount := VATTemp.Amount + VATEOrg.Amount;
                    VATTemp."Unrealized Amount" := VATTemp."Unrealized Amount" + VATEOrg."Unrealized Amount";
                    VATTemp."Unrealized Base" := VATTemp."Unrealized Base" + VATEOrg."Unrealized Base";
                    VATTemp."Remaining Unrealized Amount" := VATTemp."Remaining Unrealized Amount" + VATEOrg."Remaining Unrealized Amount";

                    VATTemp."Remaining Unrealized Base" := VATTemp."Remaining Unrealized Base" + VATEOrg."Remaining Unrealized Base";

                    VATTemp."Remaining Unrealized Amount" := VATTemp."Remaining Unrealized Amount" + VATEOrg.Amount;
                    VATTemp.MODIFY;


                    DVATOrg.RESET;
                    DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                    IF DVATOrg.FINDFIRST THEN BEGIN
                        DVATTemp.RESET;
                        DVATTemp.SETFILTER("VAT Entry No.", '%1', VATTemp."Entry No.");
                        IF DVATTemp.FINDFIRST THEN BEGIN
                            DVATTemp.Column1 := DVATTemp.Column1 + DVATOrg.Column1;
                            DVATTemp.Column2 := DVATTemp.Column2 + DVATOrg.Column2;
                            DVATTemp.Column3 := DVATTemp.Column3 + DVATOrg.Column3;
                            DVATTemp.Column4 := DVATTemp.Column4 + DVATOrg.Column4;
                            DVATTemp.Column5 := DVATTemp.Column5 + DVATOrg.Column5;
                            DVATTemp.Column6 := DVATTemp.Column6 + DVATOrg.Column6;
                            DVATTemp.Column7 := DVATTemp.Column7 + DVATOrg.Column7;
                            DVATTemp.Column8 := DVATTemp.Column8 + DVATOrg.Column8;
                            DVATTemp.Column9 := DVATTemp.Column9 + DVATOrg.Column9;
                            DVATTemp.Column10 := DVATTemp.Column10 + DVATOrg.Column10;
                            DVATTemp."VAT retro" := DVATTemp."VAT retro" + DVATOrg."VAT retro";
                            DVATTemp."Amount retro" := DVATTemp."Amount retro" + DVATOrg."Amount retro";

                            DVATTemp.MODIFY;
                        END;
                    END;


                END
                ELSE BEGIN
                    VATTemp.INIT;
                    VATTemp.TRANSFERFIELDS(VATEOrg);

                    DVATOrg.RESET;
                    DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                    IF DVATOrg.FINDFIRST THEN
                        VATTemp.INSERT;
                    DVATOrg.RESET;
                    DVATOrg.SETFILTER("VAT Entry No.", '%1', VATEOrg."Entry No.");
                    IF DVATOrg.FINDFIRST THEN BEGIN
                        DVATTemp.INIT;
                        DVATTemp.TRANSFERFIELDS(DVATOrg);
                        DVATTemp.INSERT;
                    END;

                END;


            UNTIL VATEOrg.NEXT = 0;


        DataItem1.DELETEALL;
        DataItem2.DELETEALL;
        VATTemp.RESET;
        IF VATTemp.FINDSET THEN
            REPEAT
                DataItem1.INIT;
                DataItem1.TRANSFERFIELDS(VATTemp);
                DataItem1.INSERT;
            UNTIL VATTemp.NEXT = 0;


        DVATTemp.RESET;
        IF DVATTemp.FINDSET THEN
            REPEAT
                DataItem2.INIT;
                DataItem2.TRANSFERFIELDS(DVATTemp);
                DataItem2.INSERT;
            UNTIL DVATTemp.NEXT = 0;


        IF EXISTS(Comp."Path value" + 'TestFile2.csv') THEN
            ERASE(Comp."Path value" + 'TestFile2.csv');

        //Comp

        FileDoc.CREATE(Comp."Path value" + 'TestFile2.csv', TEXTENCODING::UTF8);
        FIleName := Comp."Path value" + 'TestFile2.csv';

        FileDoc.CREATEOUTSTREAM(OutStreamObj);

        //vrsta sloga


        Zaglavlje := Zaglavlje + '1;';
        Comp.GET;

        //PDV broj obveznika koji podnosi datoteku
        Zaglavlje := Zaglavlje + Comp."VAT Registration No." + ';';

        PorezniPeriod := DataItem1.GETFILTER("VAT Date");
        IF PorezniPeriod = '' THEN
            ERROR('Porezni period mora biti unesen');
        IF COPYSTR(PorezniPeriod, 1, 2) <> '..' THEN BEGIN
            PorezniPeriod2 := PorezniPeriod;
            IF STRPOS(PorezniPeriod2, '..') <> 0 THEN
                PorezniPeriod := COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..'));
            EVALUATE(StartDate, COPYSTR(PorezniPeriod2, 1, STRPOS(PorezniPeriod2, '..')));

            //1.1.2019..31.12.2019


            PorezniPeriod := COPYSTR(PorezniPeriod2, 7, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod2)));



        END
        ELSE BEGIN
            PorezniPeriod := DELCHR(PorezniPeriod2, '=', '..');
            PorezniPeriod := COPYSTR(PorezniPeriod2, 4, 2);
            PorezniPeriod := PorezniPeriod + COPYSTR(PorezniPeriod2, 4, 2);
            StartDate := 0D;
            EVALUATE(EndDate, COPYSTR(PorezniPeriod2, STRPOS(PorezniPeriod2, '..') + 2, STRLEN(PorezniPeriod)));

        END;

        Zaglavlje := Zaglavlje + PorezniPeriod + ';';

        Zaglavlje := Zaglavlje + '1;';

        IF Type2 = Type2::"DOMAĆI" THEN
            Zaglavlje := Zaglavlje + '01;';

        IF Type2 = Type2::AVANSI THEN
            Zaglavlje := Zaglavlje + '02;';

        IF Type2 = Type2::INO THEN
            Zaglavlje := Zaglavlje + '03;';



        Datum2 := FORMAT(WORKDATE, 0, '<Day,2>.<Month,2>.<Year,4>');//11.03.2020
        //EVALUATE(Datum,Datum2);

        //Zaglavlje:=Zaglavlje+COPYSTR(Datum2,7,4)+'-'+COPYSTR(Datum2,4,2)+'-'+COPYSTR(Datum2,1,2)+';';
        Zaglavlje := Zaglavlje + FORMAT(WORKDATE, 10, '<Year4>-<Month,2>-<Day,2>') + ';';
        Zaglavlje := Zaglavlje + FORMAT(TIME);





        OutStreamObj.WRITETEXT(Zaglavlje);
        OutStreamObj.WRITETEXT();
        BrojRedova := BrojRedova + 1;
    end;

    var

        FileDoc: File;
        FIleName: Text;
        Zaglavlje: Text;
        NewLine: Char;
        OutStreamObj: OutStream;
        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        Brojac: Integer;
        PIH: Record "Purch. Inv. Header";
        PIH2: Record "Purch. Inv. Header";
        VendAddress: Text;
        VendorOrder: Text;
        VatEntryUpdate: Record "VAT Entry";
        DocDate: Date;
        Comp: Record "Company Information";
        Vendor2: Record Vendor;
        Datum: Date;
        RegVat: Text;
        VATReg: Text;
        Datum2: Text;
        Vendor: Record Vendor;
        Type2: Option "DOMAĆI",INO,AVANSI;
        PostingDate: Date;
        ExternalDocumentNo: Code[250];
        Rezultat: Text;
        VendorName: Text;
        Amounttr2: Decimal;
        fullvat2db: Decimal;
        WorkType: Record "Types Of Diseases";
        Redni: Integer;
        ve14: Record "VAT Entry";
        Res: Decimal;
        Total1: Decimal;
        VatEntryReverse: Record "VAT Entry";
        PorezniOdDate: Date;
        CC: Integer;
        ve20: Record "VAT Entry";
        ve2: Record "VAT Entry";
        SumaRed: Integer;
        c5: Decimal;
        c6: Decimal;
        ve15: Record "VAT Entry";
        IDOd: Integer;
        ve23: Record "VAT Entry";
        ve22: Record "VAT Entry";
        ve13: Record "VAT Entry";
        ve16: Record "VAT Entry";
        CoPoDoc: Decimal;
        CoPoDoc1: Decimal;
        CoPoDoc5: Decimal;
        CoPoDoc6: Decimal;
        CoPoDoc9: Decimal;
        CoPoDocBD: Decimal;
        CoPoDoc2: Decimal;
        CoPoDoc8: Decimal;
        CoPoDoc20: Decimal;
        CoPoDoc3: Decimal;
        CoPoDoc4: Decimal;
        CoPoDoc7: Decimal;
        CoPoDocRS: Decimal;
        CoPoDocFullVat: Decimal;
        Prvi: Boolean;
        DetailedVATEntry: Record "Detailed VAT Entry";
        c9: Decimal;
        ve21: Record "VAT Entry";
        Total2: Decimal;
        Total3: Decimal;
        Total4: Decimal;
        c3: Decimal;
        fullvat2rs: Decimal;
        c4: Decimal;
        c7: Decimal;
        Total5: Decimal;
        Total6: Decimal;
        Total7: Decimal;
        fullvat2: Decimal;
        Total8: Decimal;
        Total9: Decimal;
        Total10: Decimal;
        BrojRedova: Integer;
        FileManagement: Codeunit "File Management";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CompIn: Record "Company Information";
        Vendorr: Record Vendor;
        TipDokumenta: Text;
        ve10: Record "VAT Entry";
        StartDate: Date;
        EndDate: Date;
        c0: Decimal;
        ve11: Record "VAT Entry";
        c1: Decimal;
        ve12: Record "VAT Entry";
        c2: Decimal;
        ve17: Record "VAT Entry";
        c8: Decimal;
        ve19: Record "VAT Entry";
        ve24: Record "VAT Entry";
        c20: Decimal;
        VATEOrg: Record "VAT Entry";
        DVATOrg: Record "Detailed VAT Entry";
        VATTemp: Record "VAT Entry" temporary;
        DVATTemp: Record "Detailed VAT Entry" temporary;
        VATOrg2: Record "VAT Entry";

    procedure Replace(InsertValue: Decimal) ResultValue: Text
    begin
        Rezultat := FORMAT(InsertValue, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>');
        //FORMAT(TotalAmt,0,'<Precision,2><sign><Integer Thousand><Decimals,3>')
        //1.053,51
        Rezultat := DELCHR(Rezultat, '=', '.');
        Rezultat := CONVERTSTR(Rezultat, ',', '.');

        EXIT(Rezultat);
    end;
}

