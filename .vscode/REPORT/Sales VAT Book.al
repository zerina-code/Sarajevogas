report 50021 "Sales VAT Book"
{
    // BH1.00, VAT Books
    DefaultLayout = RDLC;
    RDLCLayout = './Sales VAT Book.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    Caption = 'Sales VAT Book report';
    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "VAT Date", "Document Type", Prepayment;
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
            column(PostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(Redni_ISPIS; Redni_ISPIS) { }
            column(CustomerName; Customer.Name + ', ' + Customer.City)
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CounterCaption; CounterCaption)
            {
            }
            column(CustomerCaption; VendorCaption)
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
            column(HeaderCustomerCaption; HeaderCustomerCaption)
            {
            }
            column(HeaderVATCaption; HeaderVATCaption)
            {
            }
            column(TotalCaption; TotalCaption)
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
                SINV: Record "Sales Invoice Header";
            begin
                IF (Type = Type::Purchase) AND ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")
                THEN
                    Type := Type::Sale;


                IF Type <> Type::Sale THEN
                    CurrReport.SKIP;
                //   Redni_ISPIS := Redni;

                //  Redni := Redni + 1;

                IF NOT Customer.GET("Bill-to/Pay-to No.") THEN BEGIN
                    //Customer.INIT;
                    //Customer.Name := CompInfo.Name;
                    //"VAT Registration No." := CompInfo."VAT Registration No.";
                    Vendor.GET("Bill-to/Pay-to No.");
                    Customer.INIT;
                    Customer.Name := Vendor.Name;
                    "VAT Registration No." := Vendor."VAT Registration No.";

                END;
                Redni_ISPIS := '';
                SINV.reset;
                SINV.SetFilter("No.", '%1', "Document No.");
                if SINV.FindFirst() then begin

                    Redni_ISPIS := sinv.KIF_Entry;
                end;

            end;

            trigger OnPreDataItem()
            begin


                PorezniPeriod := DataItem1.GETFILTER("VAT Date");
                VrstaDokumenta := DataItem1.GETFILTER("Document Type");
                Prepay := DataItem1.GETFILTER("Prepayment");
                IF Prepay <> '' then
                    EVALUATE(Prepayment, Prepay);
                IF not ShowAll then
                    SETFILTER("Prepayment", '%1', Prepayment);

                EVALUATE("Document Type", VrstaDokumenta);
                IF VrstaDokumenta <> '' then
                    SETFILTER("Document Type", '%1', "Document Type");

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

                /*    WorkType.RESET;
                    WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
                    WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
                    WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
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
                        WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
                        WorkType.SetFilter(Types, '%1', WorkType.Types::"KIF KUF Logs");
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
    */
            end;

        }
    }

    requestpage
    {

        layout
        {


            area(content)
            {


                field(ShowAll; ShowAll)
                {
                    ApplicationArea = all;
                    Caption = 'Prikaži sve';
                }
            }
        }

    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
        ReportFilters := DataItem1.GETFILTERS;
        ShowAll := True;
    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

        /*   WorkType.RESET;
           WorkType.SETFILTER(Year, '%1', DATE2DMY(PorezniOdDate, 3));
           WorkType.SETFILTER(Month, '%1', DATE2DMY(PorezniOdDate, 2));
           WorkType.SETFILTER(Type, '%1', WorkType.Type::KIF);
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
                   WorkType.Types := WorkType.Types::"KIF KUF Logs";
                   WorkType.Type := WorkType.Type::KIF;
                   WorkType."Number No. to" := Redni - 1;
                   WorkType."Number No. from" := IDOd;
                   WorkType.Year := DATE2DMY(PorezniOdDate, 3);
                   WorkType.Month := DATE2DMY(PorezniOdDate, 2);
                   WorkType.INSERT;
               END;
           END;
   */
    end;

    var
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        ReportCaption: Label 'Sales VAT Book';
        PageNoCaptionLbl: Label 'Page';
        CounterCaption: Label 'No.';
        VendorCaption: Label 'Name, City';
        Column1Caption: Label 'Amount incl. VAT';
        Column2Caption: Label 'Internal invoices';
        Column3Caption: Label 'Export';
        Column4Caption: Label 'Other';
        Column5Caption: Label 'VAT Base for VAT obligators';
        Column6Caption: Label 'VAT Amount for all invoices';
        HeaderDocumentCaption: Label 'Document';
        HeaderCustomerCaption: Label 'Customer';
        HeaderVATCaption: Label 'VAT';
        TotalCaption: Label 'Total';
        ReportFilters: Text[1024];
        Vendor: Record Vendor;
        WorkType: Record "Types Of Diseases";
        PorezniOdDate: Date;
        Type2: Option "DOMAĆI",INO,AVANSI;
        Redni: Integer;
        IDOd: Integer;
        PorezniPeriod: Text;
        PorezniPeriod2: Text;
        Redni_ISPIS: Code[20];
        VrstaDokumenta: Text;
        Prepay: Text;
        ShowAll: Boolean;


}

