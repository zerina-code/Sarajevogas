report 50073 "Purchase VAT Book-Import"
{
    // BH1.00, VAT Books
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase VAT Book-Import.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase VAT Book-Import';

    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST(Purchase),
                                      Import = FILTER(true));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "VAT Date";
            column(ReportCaption; ReportCaption)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompVATNo; CompInfo."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(TodayFormatted; FORMAT(TODAY))
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(VendorOrder; VendorOrder)
            {
            }
            column(VendorOrderCaption; VendorOrderCaption)
            {
            }

            column(Redni; Redni_ISPIS) { }
            column(ExternalDocumentNo; ExternalDocumentNo)
            {
                IncludeCaption = false;
            }
            column(PostingDate; PostingDate)
            {
                IncludeCaption = false;
            }
            column(VendorName; VendorName)
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CounterCaption; CounterCaption)
            {
            }
            column(PostingDateCapt; PostingDateCapt)
            {
            }
            column(ExtDoc; ExtDoc)
            {
            }
            column(VendorCaption; VendorCaption)
            {
            }
            column(Column1Caption; Column1Caption)
            {
            }
            column(Column2Caption; Column2Caption)
            {
            }
            column(Column3Caption; Column3Caption)
            {
            }
            column(Column4Caption; Column4Caption)
            {
            }
            column(Column5Caption; Column5Caption)
            {
            }
            column(Column6Caption; Column6Caption)
            {
            }
            column(HeaderDocumentCaption; HeaderDocumentCaption)
            {
            }
            column(HeaderVendorCaption; HeaderVendorCaption)
            {
            }
            column(HeaderVATCaption; HeaderVATCaption)
            {
            }
            column(TotalCaption; TotalCaption)
            {
            }
            column(VATdate; "VAT Date")
            {
            }
            column(Osnovica; Osnovica)
            {
            }
            dataitem(DataItem2; "Detailed VAT Entry")
            {
                DataItemLink = "VAT Entry No." = FIELD("Entry No."),
                               Type = FIELD(Type);
                DataItemTableView = SORTING("VAT Entry No.")
                                    ORDER(Ascending);
                column(Column1; Column1)
                {
                }
                column(Column2; Column2)
                {
                }
                column(Column3; Column3)
                {
                }
                column(Column4; Column4)
                {
                }
                column(Column5; Column5)
                {
                }
                column(Column6; Column6)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF
                      (Column1 = 0) AND
                      (Column2 = 0) AND
                      (Column3 = 0) AND
                      (Column4 = 0) AND
                      (Column5 = 0) AND
                      (Column6 = 0)
                    THEN
                        CurrReport.SKIP;


                end;
            }

            trigger OnAfterGetRecord()
            var
                PIH2: Record "Purch. Inv. Header";
            begin

                Redni_ISPIS := Redni;
                Redni := Redni + 1;

                VendorOrder := '';
                VendorName := '';
                /* PIH.SETFILTER("No.", '%1', "Document No.");
                 IF PIH.FIND('-') THEN
                     VendorOrder := PIH."Vendor Order No.";

                 IF (("VAT Calculation Type" = "VAT Calculation Type"::"Full VAT") OR ("VAT Prod. Posting Group" = 'PUNI PDV')) THEN BEGIN
                     PIH2.SETFILTER("Vendor Order No.", '%1', VendorOrder);
                     // PIH2.SETFILTER("Order No.",'%1',VendorOrder);
                     PIH2.SETFILTER("Currency Code", '<>%1', '');
                     IF PIH2.FIND('-') THEN BEGIN
                         VendorName := PIH2."Pay-to Name";
                         PostingDate := PIH2."Posting Date";
                         ExternalDocumentNo := PIH2."Vendor Invoice No.";
                     END

                 END
                 //IF "VAT Calculation Type"<>"VAT Calculation Type"::"Full VAT" THEN
                 ELSE BEGIN*/

                IF Vendor.GET("Bill-to/Pay-to No.") THEN BEGIN

                    VendorName := Vendor.Name;
                    "VAT Registration No." := Vendor."VAT Registration No.";
                    PostingDate := "Posting Date";
                    ExternalDocumentNo := "External Document No.";
                END;
                Osnovica := 0;
                IF (("VAT Calculation Type" = "VAT Calculation Type"::"Full VAT") OR ("VAT Prod. Posting Group" = 'PUNI PDV')) THEN BEGIN
                    Osnovica := "VAT Base (retro.)";

                END;

            end;


            trigger OnPreDataItem()
            var
                myInt: Integer;
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

                WorkType.RESET;
                WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
                WorkType.SETFILTER(Type, '%1', WorkType.Type::KUF);
                WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
                WorkType.SETFILTER(Description, '%1', FORMAT('DOMAĆI'));
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
                    WorkType.SETFILTER(Description, '%1', FORMAT('DOMAĆI'));
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
        CompInfo.GET;
        ReportFilters := DataItem1.GETFILTERS;
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

        WorkType.RESET;
        WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
        WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
        WorkType.SETFILTER(Type, '%1', WorkType.Type::KUF);
        WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
        WorkType.SETFILTER(Description, '%1', FORMAT('DOMAĆI'));
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
                WorkType.Description := FORMAT('DOMAĆI');
                WorkType.Type := WorkType.Type::KUF;
                WorkType.Types := WorkType.Types::"KIF KUF Logs";
                WorkType."Number No. to" := Redni - 1;
                WorkType."Number No. from" := IDOd;
                WorkType.Year := DATE2DMY(PorezniOdDate, 3);
                WorkType.Month := DATE2DMY(PorezniOdDate, 2);
                WorkType.INSERT;
            END;
        END;


    end;



    var
        CompInfo: Record "Company Information";
        Vendor: Record "Vendor";
        ReportCaption: Label 'Purchase VAT Book - import';
        PageNoCaptionLbl: Label 'Page';
        CounterCaption: Label 'No.';
        VendorCaption: Label 'Name, City';
        Column1Caption: Label 'Amount excl. VAT';
        Column2Caption: Label 'Amount incl. VAT';
        Column3Caption: Label 'Flat fee';
        Column4Caption: Label 'Total';
        Column5Caption: Label 'Deductable';
        Column6Caption: Label 'Nondeductable';
        HeaderDocumentCaption: Label 'Document';
        HeaderVendorCaption: Label 'Vendor';
        HeaderVATCaption: Label 'VAT';
        TotalCaption: Label 'Total';
        ReportFilters: Text[1024];
        VendorOrder: Code[30];
        PIH: Record "Purch. Inv. Header";
        VendorOrderCaption: Label 'Vendor Order No.';
        VendorName: Text[250];
        PostingDate: Date;
        PostingDateCapt: Label 'Posting Date';
        ExtDoc: Label 'External Document No.';
        ExternalDocumentNo: Code[30];
        Osnovica: Decimal;
        PorezniOdDate: Date;
        Redni: Integer;

        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        WorkType: Record "Types Of Diseases";
        Redni_ISPIS: Integer;
        IDOd: Integer;
}

