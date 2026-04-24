/*report 50137 "Posted Order Confirmation"
{
    RDLCLayout = './Posted order Confirmation.rdl';
    Caption = 'Order Confirmation from posted document';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;
    // BH1.00, Fiscal Process
    // BH1.01, Invoice elements

    dataset
    {
        dataitem(DataItem5581; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';
            column(OrderNo_SalesInvoiceHeader; "Order No.")
            {
            }
            column(CountryofOrigin_SalesInvoiceHeader; "Country of Origin")
            {
            }
            column(DiscountCapt2; DiscountCapt2)
            {
            }
            column(Note1_SalesInvoiceHeader; Note1)
            {
            }
            column(Note2_SalesInvoiceHeader; "Note 2")
            {
            }
            column(Note3_SalesInvoiceHeader; "Note 3")
            {
            }
            column(Showcomment; Showcomment)
            {
            }
            column(caption; caption)
            {
            }
            column(PrepaymentInvoice_SalesInvoiceHeader; "Prepayment Invoice")
            {
            }
            column(ShipmentNo; ShipmentNO)
            {
            }
            column(No_SalesInvHdr; "No.")
            {
            }
            column(Q; q)
            {
            }
            column(naslovF; naslovF)
            {
            }
            column(txtDocumentName; txtDocumentName + "No.")
            {
            }
            column(FiskalniRacun; "Fiscal No.")
            {
            }
            column(ShipmentMethod2; ShipmentMethod2)
            {
            }
            column(DatumRacuna; "Fiscal No.")
            {
            }
            column(VATNo; Customer."VAT Registration No.")
            {
            }
            column(CustPhone; Customer."Phone No.")
            {
            }
            column(RefNo; Refno)
            {
            }
            column(PaymentMethod; PaymentMethod)
            {
            }
            column(DueDate; FORMAT("Due Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(FORMAT_ShipmentDate; "Shipment Date")
            {
            }
            column(shipCity; shipCity)
            {
            }
            column(UserName; UserName)
            {
            }
            column(Footertext; FooterText)
            {
            }
            column(UpDisc; UpDisc)
            {
            }
            column(Addres; CompanyInfo.Address)
            {
            }
            column(web; CompanyInfo."Home Page")
            {
                IncludeCaption = true;
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(RegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(IBAN; PaymentIBAN)
            {
            }
            column(PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(PhoneNo2; CompanyInfo."Phone No. 2")
            {
            }
            column(FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(EMail; CompanyInfo."E-Mail")
            {
            }
            column(VATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(MBS; CompanyInfo."National Classification Number")
            {
            }
            column(BankName; CompanyInfo."Bank Name")
            {
            }
            column(CountryComp; CountryComp)
            {
            }
            column(ContactName; Customer.Contact)
            {
            }
            column(VATBaseDiscount_SalesInvsoiceHeader; "VAT Base Discount %")
            {
            }
            column(TotalPackaging_SalesInvoiceHeader; "Total Packaging")
            {
            }
            column(TransportMethod_SalesInvoiceHeader; "Transport Method")
            {
            }
            column(AmountIncludingVAT_SalesInvoiceHeader; "Amount Including VAT")
            {
            }
            column(Amount_SalesInvoiceHeader; Amount)
            {
            }
            column(naslovAvans; naslovAvans)
            {
            }
            column(naslov; naslov)
            {
            }
            column(ProformaCapt; ProformaCapt)
            {
            }
            column(ShipDate2; "Shipment Date")
            {
            }
            column(Pict; CompanyInfo.Picture)
            {
            }
            column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShptMethodDescCaption; ShptMethodDescCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
            {
            }
            column(HomePageCaption; HomePageCaptionLbl)
            {
            }
            column(EMailCaption; EMailCaptionLbl)
            {
            }
            column(ShowCountryofOrigin; ShowCountryofOrigin)
            {
            }
            column(Totalletters; "Total Value Letters")
            {
            }
            column(Country; "Country of Origin")
            {
            }
            column(TotalLet; TotalLet)
            {
            }
            column(IssueCapt; IssueCapt)
            {
            }
            column(NoCapt; NoCapt)
            {
            }
            column(ShipTermsCapt; ShipTermsCapt)
            {
            }
            column(ShipMethod; ShipMethod)
            {
            }
            column(ShipDate; ShipDate)
            {
            }
            column(Pack; Pack)
            {
            }
            column(InvNo; InvNo)
            {
            }
            column(Value; Value)
            {
            }
            column(CustNo; CustNo)
            {
            }
            column(OrdinalNo; OrdinalNo)
            {
            }

            column(EmptyRow; EmptyRow)
            {

            }

            column(Cijena; Cijena)
            {

            }

            column(ItemCapt; ItemCapt)
            {
            }
            column(ItemNameCapt; ItemNameCapt)
            {
            }
            column(ItemCodeCapt; ItemCodeCapt)
            {
            }
            column(QuantityCapt; QuantityCapt)
            {
            }
            column(UMCapt; UMCapt)
            {
            }
            column(DiscountCapt; DiscountCapt)
            {
            }
            column(UnitPriceCapt; UnitPriceCapt)
            {

            }
            column(AmountCapt; AmountCapt)
            {
            }
            column(TotalExclVAT; TotalExclVAT)
            {
            }
            column(TotalInclVAT; TotalInclVAT)
            {
            }
            column(TotalCapt; TotalCapt)
            {
            }
            column(Controlled; Controlled)
            {
            }
            column(Invoiced; Invoiced)
            {
            }
            column(VAT; PDV)
            {
            }
            column(SalesTerms; PaymentSWIFT)
            {
            }
            column(OtherComments; OtherComments)
            {
            }
            column(Director; CompanyInfo."Chief Executive (Sign.)")
            {

            }
            column(Note; Note)
            {
            }
            column(Note2; Note2)
            {
            }
            column(Note31; Note31)
            {
            }
            column(Note4; Note4)
            {
            }
            column(InvNoCaptionLbl; InvNoCaptionLbl)
            {
            }
            column(Ordinal; Ordinal)
            {
            }
            column(CustomerCapt; CustomerCapt)
            {
            }
            column(ShipCapt; ShipCapt)
            {
            }
            column(ShipDetailCapt; ShipDetailCapt)
            {
            }
            column(InvNo2; InvNo2)
            {
            }
            column(FInvNo; FInvNo)
            {
            }
            column(PaymentTermsCapt; PaymentTermsCapt)
            {
            }
            column(OrderNo; "Order No.")
            {
            }
            column(CountryCapt; CountryCapt)
            {
            }
            column(FNo; "Fiscal No.")
            {
            }
            column(PTC; "Payment Terms Code")
            {
            }
            column(No; "No.")
            {
            }
            column("Order"; "Order No.")
            {
            }
            column(CustomerName; "Sell-to Customer Name")
            {
            }
            column(SellToAdress; "Sell-to Address")
            {
            }
            column(SellToCity; "Sell-to Post Code")
            {
            }
            column(InvoiceOnlyFlag; InvoiceOnlyFlag)
            {
            }
            column(CustVatNo; CustVatNo)
            {
            }
            column(ShipToName; "Ship-to Name")
            {
            }
            column(ShipToAdress; "Ship-to Address")
            {
            }
            column(shipToCity; "Ship-to Post Code")
            {
            }
            column(CurrCode; "Currency Code")
            {
            }
            column(DocumentDate; FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(ExternalDoc; ShipmentNO)
            {
            }
            column(SalesCode; "Salesperson Code")
            {
            }
            column(SalesPersona; SalesPersona)
            {
            }
            column(PostingDate; "Posting Date")
            {
            }
            column(CustRegNo; CustRegNo)
            {
            }
            column(Note1; "Note 1")
            {
            }
            column(Note21; "Note 2")
            {
            }
            column(Note3; "Note 3")
            {
            }
            column(ShowNote1; ShowNote1)
            {
            }
            column(ShowNote2; ShowNote2)
            {
            }
            column(ShowNote3; ShowNote3)
            {
            }
            column(Ponuda; "Quote No.")
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(CompanyCity; CompanyInfo.City)
                    {
                    }
                    column(HomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyAdress; CompanyInfo.Address)
                    {
                    }
                    column(CFax; CompanyInfo."Fax No.")
                    {
                    }
                    column(CPhone; CompanyInfo."Phone No.")
                    {
                    }
                    column(CPost; CompanyInfo."Post Code")
                    {
                    }
                    column(CCity; CompanyInfo.City)
                    {
                    }
                    column(CRegistration; CompanyInfo."Registration No.")
                    {
                    }
                    column(CVat; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(DocumentCaptionCopyText; STRSUBSTNO(DocumentCaption, CopyText))
                    {
                    }
                    column(CurrReportPageNo; STRSUBSTNO(Text005, FORMAT(CurrReport.PAGENO)))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfoGiroNo)
                    {
                    }
                    column(CompanyInfoBankName; PaymentBankName)
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; DataItem5581."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT("DataItem5581"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; DataItem5581."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; FORMAT("DataItem5581"."Due Date"))
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourReference_SalesInvHdr; DataItem5581."Your Reference")
                    {
                    }
                    column(OrderNoText; OrderNoText)
                    {
                    }
                    column(HdrOrderNo_SalesInvHdr; DataItem5581."Order No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocDate_SalesInvHdr; FORMAT("DataItem5581"."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; DataItem5581."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesInvHdr; FORMAT("DataItem5581"."Prices Including VAT"))
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text005, ''))
                    {
                    }
                    column(PaymentTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShipmentMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCptn; CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCaption; CompanyInfoGiroNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoBankNameCptn; CompanyInfoBankNameCptnLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCptn; CompanyInfoBankAccNoCptnLbl)
                    {
                    }
                    column(SalesInvDueDateCaption; SalesInvDueDateCaptionLbl)
                    {
                    }
                    column(InvNoCaption; InvNoCaptionLbl)
                    {
                    }
                    column(SalesInvPostingDateCptn; SalesInvPostingDateCptnLbl)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdrCaption; DataItem5581.FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdrCaption; DataItem5581.FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(IssuedBySignature; IssuedBySignature)
                    {
                    }
                    column(ReceivedBySignature; ReceivedBySignature)
                    {
                    }
                    column(FiscalNo; DataItem5581."Fiscal No.")
                    {
                    }
                    column(FiscalNoCaption; FiscalNoCaption)
                    {
                    }
                    column(ShipmentDate; FORMAT("DataItem5581"."Shipment Date"))
                    {
                    }
                    column(ShipmentDateCaption; DataItem5581.FIELDCAPTION("Shipment Date"))
                    {
                    }
                    column(IssuedIn; CompanyInfo.City)
                    {
                    }
                    column(IssuedInCaption; IssuedInCaption)
                    {
                    }
                    dataitem(DataItem1000000179; "Sales Comment Line")
                    {
                        column(Date; Date)
                        {
                        }
                        column(Comment; Comment)
                        {
                        }
                        column(CommmentDocNo; "No.")
                        {
                        }
                        column(COM; Commm)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            Commm := "DataItem1000000179".Comment;
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETFILTER("No.", '%1', "DataItem5581"."No.");
                        end;
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "DataItem5581";
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin



                            IF Number = 1 THEN BEGIN
                                IF NOT DimSetEntry1.FINDSET THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF NOT Continue THEN
                                    CurrReport.BREAK;

                            CLEAR(DimText);
                            Continue := FALSE;
                            REPEAT
                                OldDimText := DimText;
                                IF DimText = '' THEN
                                    DimText := STRSUBSTNO('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                ELSE
                                    DimText :=
                                      STRSUBSTNO(
                                        '%1, %2 %3', DimText,
                                        DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                    DimText := OldDimText;
                                    Continue := TRUE;
                                    EXIT;
                                END;
                            UNTIL DimSetEntry1.NEXT = 0;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DataItem1570; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = "DataItem5581";
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(LineAmt_SalesInvLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; Description)
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Caption_No; FIELDCAPTION("No."))
                        {
                        }
                        column(PrecVAT; "DataItem1570"."VAT %")
                        {
                        }
                        column(Qty_SalesInvLine; FORMAT(Quantity))
                        {
                        }
                        column(VATPercentageCaptionLbl; VATPercentageCaptionLbl)
                        {
                        }
                        column(VAT_SalesInvoiceLine; "DataItem1570"."VAT %")
                        {
                        }
                        column(UOM_SalesInvLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesInvLine; FORMAT("Unit Price", 0, '<Integer Thousand><Decimals,3>'))
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Discount_SalesInvLine; "Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; FORMAT("VAT %") + '%')
                        {
                        }
                        column(PostedShipmentDate; FORMAT(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvLine; FORMAT(Type))
                        {
                        }
                        column(InvDiscLineAmt_SalesInvLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount; TotalInvDiscAmount)
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amount_SalesInvLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Amount_AmtInclVAT; "Amount Including VAT" - Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Amount Including VAT")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmtAfterInvDiscAmt; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; DataItem5581."VAT Base Discount %")
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscOnVAT)
                        {
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText_SalesInvLine; TotalInclVATText)
                        {
                        }
                        column(VATAmtText_SalesInvLine; VATAmountLine.VATAmountText)
                        {
                        }
                        column(DocNo_SalesInvLine; "Document No.")
                        {
                        }
                        column(LineNo_SalesInvLine; "Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesInvLineDiscCaption; SalesInvLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(LDA; "DataItem1570"."Line Discount Amount")
                        {
                        }
                        column(LineAmtAfterInvDiscCptn; LineAmtAfterInvDiscCptnLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesInvLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesInvLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesInvLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; FIELDCAPTION("VAT %"))
                        {
                        }
                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShptBufferPostDate; FORMAT(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQty; SalesShipmentBuffer.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;


                            end;

                            trigger OnPreDataItem()
                            begin
                                SalesShipmentBuffer.SETRANGE("Document No.", "DataItem1570"."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", "DataItem1570"."Line No.");

                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_DimLoop; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FINDSET THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText := STRSUBSTNO('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL DimSetEntry2.NEXT = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT ShowInternalInfo THEN
                                    CurrReport.BREAK;

                                DimSetEntry2.SETRANGE("Dimension Set ID", "DataItem1570"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                                DecimalPlaces = 0 : 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostAsmLineVartCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {

                            }
                            column(TempPostedAsmLineUOM; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {

                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    TempPostedAsmLine.FINDSET
                                ELSE
                                    TempPostedAsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                CLEAR(TempPostedAsmLine);
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                CollectAsmInformation;
                                CLEAR(TempPostedAsmLine);
                                SETRANGE(Number, 1, TempPostedAsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PostedShipmentDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedShipmentDate := FindPostedShipmentDate;

                           

                            VATAmountLine.INIT;
                            VATAmountLine."VAT Identifier" := "VAT Identifier";
                            VATAmountLine."VAT Calculation Type" := "VAT Calculation Type";
                            VATAmountLine."Tax Group Code" := "Tax Group Code";
                            VATAmountLine."VAT %" := "VAT %";
                            VATAmountLine."VAT Base" := Amount;
                            VATAmountLine."Amount Including VAT" := "Amount Including VAT";
                            VATAmountLine."Line Amount" := "Line Amount";
                            IF "Allow Invoice Disc." THEN
                                VATAmountLine."Inv. Disc. Base Amount" := "Line Amount";
                            VATAmountLine."Invoice Discount Amount" := "Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code" := "VAT Clause Code";
                            VATAmountLine.InsertLine;

                            TotalSubTotal += "Line Amount";
                            TotalInvDiscAmount -= "Inv. Discount Amount";
                            TotalAmount += Amount;
                            TotalAmountVAT += "Amount Including VAT" - Amount;
                            TotalAmountInclVAT += "Amount Including VAT";
                            TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");
                            if DataItem1570.Type <> DataItem1570.Type::" " then begin

                                Ordinal += 1;
                                EmptyRow := false;
                            end
                            else begin
                                EmptyRow := true;

                            end;
                            Cijena := DataItem1570."Unit Price" * DataItem1570.Quantity;

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                            No_SalesInvLine := "No.";
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "DataItem1570".GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            //+BH1.01
                            IF NOT GLSetup."Print VAT specification" THEN
                                CurrReport.BREAK;
                            //-BH1.01
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATClauseEntryCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "DataItem5581"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(VATAmountLine."VAT Clause Code") THEN
                                CurrReport.SKIP;
                            VATClause.TranslateDescription("DataItem5581"."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATPer_VATCounterLCY; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / DataItem5581."Currency Factor");
                            VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / DataItem5581."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (DataItem5581."Currency Code" = '')
                               OR (NOT GLSetup."Print VAT specification") //BH1.01
                            THEN
                                CurrReport.BREAK;

                            CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(DataItem5581."Posting Date", DataItem5581."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / DataItem5581."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesInvHdr; DataItem5581."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; DataItem5581.FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    TotalSubTotal := 0;
                    TotalInvDiscAmount := 0;
                    TotalAmount := 0;
                    TotalAmountVAT := 0;
                    TotalAmountInclVAT := 0;
                    TotalPaymentDiscOnVAT := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesInvCountPrinted.RUN(DataItem5581);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + Cust."Invoice Copies" + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                BankAccountTemp.Reset();
                BankAccountTemp.SETFILTER("No.", '%1', DataItem5581."Bank No.");
                IF BankAccountTemp.FINDFIRST THEN begin
                    CompanyInfoGiroNo := BankAccountTemp."Bank Account No.";
                    PaymentBankName := BankAccountTemp.Name;
                    PaymentInfoGiroNo := BankAccountTemp."Bank Account No.";
                    PaymentIBAN := BankAccountTemp.IBAN;
                    PaymentSWIFT := BankAccountTemp."SWIFT Code";

                end;
                CurrReport.LANGUAGE := GetLanguage.GetLanguageID("Language Code");
                IF CR.GET(CompanyInfo."Country/Region Code") THEN
                    CountryComp := CR."Name 2"
                ELSE
                    CountryComp := '';
                User.RESET;
                User.SETFILTER("User Name", '%1', USERID);
                IF User.FINDFIRST
                  THEN
                    UserName := User."Full Name";
                txtDocumentName := FORMAT(Text50016);
                //CustomerText:=Text003;
                FooterText := '';
                Doc.RESET;
                Doc.SETFILTER("Language Code", '%1', 'BOS');
                Doc.SETCURRENTKEY("Primary key");
                Doc.ASCENDING(TRUE);
                IF Doc.FINDSET THEN
                    REPEAT
                        FooterText := FooterText + ' ' + Doc."Footer Text";
                    UNTIL Doc.NEXT = 0;
               
                Customer.GET("Bill-to Customer No.");

               

                SM.SETFILTER(Code, '%1', "Shipment Method Code");
                IF SM.FINDFIRST THEN
                    ShipmentMethod2 := SM.Description;
                PT.RESET;
                PT.SETFILTER(Code, '%1', "Payment Method Code");
                IF PT.FINDFIRST THEN
                    PaymentMethod := PT.Description;
                Refno := "Order No.";
                //DueDate:="Sales Header"."Due Date";
                //RefNo:="No.";
                IF PostCode.GET("Ship-to Post Code") THEN shipCity := PostCode.City;
                SH.SETFILTER("Order No.", '%1', "Order No.");
                IF SH.FINDFIRST THEN
                    ShipmentNO := SH."No.";

                //AS1
                Cust.SETFILTER("No.", "Sell-to Customer No.");

                IF Cust.FIND('-') THEN BEGIN
                    CustVatNo := Cust."VAT Registration No.";
                    CustRegNo := Cust."Registration No.";
                END;
                Euro := DataItem5581."Amount Including VAT";

                CurrExchRate.Reset();
                CurrExchRate.SetFilter("Currency Code", '%1', DataItem5581."Currency Code");
                CurrExchRate.SetCurrentKey("Starting Date");
                CurrExchRate.Ascending;
                if CurrExchRate.FindLast() then begin
                    Euro := Euro * CurrExchRate."Relational Exch. Rate Amount";
                    Euro := Round(Euro, 0.01, '>');
                end;

                Note1 := ReplaceString(DataItem5581."Note 1", '@VrijednostIznosa', format(Euro, 0, '<Integer Thousand><Decimals,3>'));
                Note1 := ReplaceString(DataItem5581."Note 1", '@DatumIzdavanjaFakture', format(DataItem5581."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'));




                Cust.RESET;
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                SalespersonTable.SETFILTER(Code, "Salesperson Code");
                IF SalespersonTable.FIND('-') THEN BEGIN
                    SalesPersona := SalespersonTable.Name;
                END;
                //END

                IF NOT Prepayment THEN
                    naslovF := naslov
                ELSE
                    naslovF := naslovAvans;

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Order No." = '' THEN
                    OrderNoText := ''
                ELSE
                    OrderNoText := FIELDCAPTION("Order No.");
                IF "Salesperson Code" = '' THEN BEGIN
                    SalesPurchPerson.INIT;
                    SalesPersonText := '';
                END ELSE BEGIN
                    SalesPurchPerson.GET("Salesperson Code");
                    SalesPersonText := Text000;
                END;
                IF "Your Reference" = '' THEN
                    ReferenceText := ''
                ELSE
                    ReferenceText := FIELDCAPTION("Your Reference");
                IF "VAT Registration No." = '' THEN
                    VATNoText := ''
                ELSE
                    VATNoText := FIELDCAPTION("VAT Registration No.");
                IF "Currency Code" = '' THEN BEGIN
                    GLSetup.TESTFIELD("LCY Code");
                    TotalText := STRSUBSTNO(Text001, GLSetup."LCY Code");
                    TotalInclVATText := STRSUBSTNO(Text002, GLSetup."LCY Code");
                    TotalExclVATText := STRSUBSTNO(Text006, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text006, "Currency Code");
                END;
                FormatAddr.SalesInvBillTo(CustAddr, DataItem5581);
                IF NOT Cust.GET("Bill-to Customer No.") THEN
                    CLEAR(Cust);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, DataItem5581);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN BEGIN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              4, "No.", 0, 0, DATABASE::Customer, "Bill-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');
                    END;

                SalesHeaderTemp.SETFILTER("No.", '%1', "No.");
                IF SalesHeaderTemp.FINDFIRST THEN
                    BankAccountTemp.SETFILTER("No.", '%1', SalesHeaderTemp."Bal. Account No.");
                IF BankAccountTemp.FINDFIRST THEN
                    PaymentBankName := BankAccountTemp.Name;
                PaymentInfoGiroNo := BankAccountTemp."Bank Account No.";
                PaymentIBAN := BankAccountTemp.IBAN;
                PaymentSWIFT := BankAccountTemp."SWIFT Code";

            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopies; NoOfCopies)
                    {
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
                    }
                    field(Showcomment; Showcomment)
                    {
                        Caption = 'Show comment';
                    }
                    field(InvoiceFlag; InvoiceOnlyFlag)
                    {
                        Caption = 'Not a shipment';
                    }
                    field(ShowCountryofOrigin; ShowCountryofOrigin)
                    {
                        Caption = 'ShowCountryofOrigin';
                    }
                    field(ShowNote1; ShowNote1)
                    {
                        Caption = 'Show Note 1';
                    }
                    field(ShowNote2; ShowNote2)
                    {
                        Caption = 'Show Note 2';
                    }
                    field(ShowNote3; ShowNote3)
                    {
                        Caption = 'Show Note 3';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := TRUE;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
            ShowNote1 := TRUE;

            ShowNote2 := TRUE;
            ShowNote3 := TRUE;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);

        CompanyInfo1.GET;
        CompanyInfo1.CALCFIELDS(Picture);

        CompanyInfo2.GET;
        CompanyInfo2.CALCFIELDS(Picture);

        CompanyInfo3.GET;
        CompanyInfo3.CALCFIELDS(Picture);

        SalesSetup.GET;

        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture);
                END;
        END;
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
        Ordinal := 0;
    end;

    var
        DiscountCapt2: Label 'Discount ';
        GetLanguage: Codeunit Language;
        FiscalNoCaption: Text[1000];

        Cijena: Decimal;
        EmptyRow: Boolean;
        ProformaCapt: Label 'Proforma Invoice No.';
        naslovAvans: Label 'Prepayment Invoice';
        naslov: Label 'Invoice';
        UpDisc: Label 'Unit price with discount';
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text50016: Label 'Bill No.';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Invoice - Shipment %1';
        Text005: Label 'Page';
        Text006: Label 'Total %1 Excl. VAT';
        ShowNote1: Boolean;
        Showcomment: Boolean;
        ShowNote2: Boolean;
        ShowNote3: Boolean;
        Commm: Text;
        No_SalesInvLine: Text;
        CountryComp: Text;
        q: Code[30];
        caption: Text[150];
        DisplayAdditionalFeeNote: Boolean;
        User: Record "User";
        Refno: Code[30];
        SH: Record "Sales Shipment Header";
        Doc: Record "Document Footer";
        PostCode: Record "Post Code";
        SIH: Record "Sales Invoice Header";
        CR: Record "Country/Region";
        PT: Record "Payment Method";
        PaymentInfoGiroNo: Text;
        PaymentBankName: Text;
        SM: Record "Shipment Method";
        ShowCountryofOrigin: Boolean;
        txtDocumentName: Text;
        PaymentSWIFT: Text;
        UserName: Text;
        FooterText: Text;
        Ordinal: Integer;
        Customer: Record "Customer";
        BankAccountTemp: Record "Bank Account";
        ShipmentNO: Text;
        ShipmentMethod2: Text;
        PaymentIBAN: Text;
        SalesHeaderTemp: Record "Sales Invoice Header";
        shipCity: Text;
        PaymentMethod: Text;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        Cust: Record "Customer";
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record "Language";
        CurrExchRate: Record "Currency Exchange Rate";
        TempPostedAsmLine: Record "Posted Assembly Line" temporary;
        VATClause: Record "VAT Clause";
        SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit "SegManagement";
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        PostedShipmentDate: Date;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        OrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        NextEntryNo: Integer;
        FirstValueEntryNo: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        VALExchRate: Text[50];
        Text009: Label 'Exchange rate: %1/%2';
        CalculatedExchRate: Decimal;
        Text010: Label 'Sales - Prepayment Invoice %1';
        OutputNo: Integer;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        Text50000: Label 'Invoice %1';
        IssuedBySignature: Label 'Issued by';
        ReceivedBySignature: Label 'Received by';
        IssuedInCaption: Label 'Issued in';
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCptnLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCaptionLbl: Label 'Giro No.';
        CompanyInfoBankNameCptnLbl: Label 'Bank';
        CompanyInfoBankAccNoCptnLbl: Label 'Account No.';
        SalesInvDueDateCaptionLbl: Label 'Due Date';
        InvNoCaptionLbl: Label 'INVOICE';
        SalesInvPostingDateCptnLbl: Label 'Posting Date';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesInvLineDiscCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        VATClausesCap: Label 'VAT Clause';
        PostedShipmentDateCaptionLbl: Label 'Posted Shipment Date';
        SubtotalCaptionLbl: Label 'Subtotal';
        LineAmtAfterInvDiscCptnLbl: Label 'Payment Discount on VAT';
        ShipmentCaptionLbl: Label 'Shipment';
        LineDimCaptionLbl: Label 'Line Dimensions';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        LineAmtCaptionLbl: Label 'Line Amount';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        InvDiscountAmtCaptionLbl: Label 'Invoice Discount Amount';
        DocumentDateCaptionLbl: Label 'Document Date';
        PaymentTermsDescCaptionLbl: Label 'Payment Terms';
        ShptMethodDescCaptionLbl: Label 'Shipment Method';
        VATPercentageCaptionLbl: Label 'VAT %';
        TotalCaptionLbl: Label 'Total';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        HomePageCaptionLbl: Label 'Home Page';
        EMailCaptionLbl: Label 'E-Mail';
        InvoiceOnlyFlag: Boolean;
        SalesPersona: Text;
        SalespersonTable: Record "Salesperson/Purchaser";
        CustRegNo: Text;
        CustVatNo: Text;
        OrdinalNo: Label 'No.';
        ItemCapt: Label 'Part No.';
        CompanyInfoGiroNo: Code[20];
        ItemNameCapt: Label 'Part name';
        ItemCodeCapt: Label 'Part code';
        QuantityCapt: Label 'Quantity';
        UMCapt: Label 'Unit of measure';
        UnitPriceCapt: Label 'Unit price';
        DiscountCapt: Label 'Discount';
        Note1: Text;
        AmountCapt: Label 'Amount';
        TotalCapt: Label 'Total';
        TotalExclVAT: Label 'Total Excl. VAT';
        TotalInclVAT: Label 'Total Incl. VAT';
        Euro: Decimal;
        PDV: Label '17% VAT';
        SalesTerms: Label 'Sales terms';
        OtherComments: Label 'and other comments';
        Note: Label 'This document is printed in electronic form and it is valid without signatures and seals.';
        Note2: Label 'Please settle your obligations in time because we will otherwise determine the statutory default interest.';
        Note31: Label 'Dear Sirs,';
        Note4: Label 'Complaints are considered within 8 days of receipt of the garment.';
        CustomerCapt: Label 'Cusomer/Invoice';
        ShipCapt: Label 'Shiping';
        ShipDetailCapt: Label 'Shiping details';
        IssueCapt: Label 'Place and date of issue';
        Value: Label 'Valid until';
        NoCapt: Label 'No.';
        InvNo: Label 'Fiscal invoice no.';
        CustNo: Label 'Customer No.';
        ShipTermsCapt: Label 'Shipment terms';
        ShipMethod: Label 'Shipment Method';
        ShipDate: Label 'Delivery Date';
        Pack: Label 'Total packaging';
        PaymentTermsCapt: Label 'Payment Terms';
        CountryCapt: Label 'Country of origin';
        DueDate: Label 'Shipment due';
        InvNo2: Label 'Invoice No.';
        FInvNo: Label 'Fiscal invoice No.';
        OrderNo: Label 'Order No.';
        TotalLet: Label 'Total value:';
        AdvInv: Label 'Advance Invoice';
        naslovF: Text[50];
        Controlled: Label 'Controlled';
        Invoiced: Label 'Approved';

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(4) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        IF "DataItem1570"."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET("DataItem1570"."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF DataItem5581."Order No." = '' THEN
            EXIT(DataItem5581."Posting Date");

        CASE "DataItem1570".Type OF
            "DataItem1570".Type::Item:
                GenerateBufferFromValueEntry("DataItem1570");
            "DataItem1570".Type::"G/L Account", "DataItem1570".Type::Resource,
          "DataItem1570".Type::"Charge (Item)", "DataItem1570".Type::"Fixed Asset":
                GenerateBufferFromShipment("DataItem1570");
            "DataItem1570".Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", "DataItem1570"."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", "DataItem1570"."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> "DataItem1570".Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT(DataItem5581."Posting Date");
            END;
        END ELSE
            EXIT(DataItem5581."Posting Date");
    end;

    procedure ReplaceString(var String: Text; FindWhat: Text; ReplaceWIth: Text) NewString: Text

    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWIth + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;

    end;

    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", DataItem5581."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesInvoiceHeader.SETCURRENTKEY("Order No.");
        SalesInvoiceHeader.SETFILTER("No.", '..%1', DataItem5581."No.");
        SalesInvoiceHeader.SETRANGE("Order No.", DataItem5581."Order No.");
        IF SalesInvoiceHeader.FIND('-') THEN
            REPEAT
                SalesInvoiceLine2.SETRANGE("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SETRANGE(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SETRANGE("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                IF SalesInvoiceLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesInvoiceLine2.Quantity;
                    UNTIL SalesInvoiceLine2.NEXT = 0;
            UNTIL SalesInvoiceHeader.NEXT = 0;

        SalesShipmentLine.SETCURRENTKEY("Order No.", "Order Line No.");
        SalesShipmentLine.SETRANGE("Order No.", DataItem5581."Order No.");
        SalesShipmentLine.SETRANGE("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SETRANGE(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SETRANGE("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SETRANGE("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SETFILTER(Quantity, '<>%1', 0);

        IF SalesShipmentLine.FIND('-') THEN
            REPEAT
                IF DataItem5581."Get Shipment Used" THEN
                    CorrectShipment(SalesShipmentLine);
                IF ABS(SalesShipmentLine.Quantity) <= ABS(TotalQuantity - SalesInvoiceLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity
                ELSE BEGIN
                    IF ABS(SalesShipmentLine.Quantity) > ABS(TotalQuantity) THEN
                        SalesShipmentLine.Quantity := TotalQuantity;
                    Quantity :=
                      SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);

                    TotalQuantity := TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;

                    IF SalesShipmentHeader.GET(SalesShipmentLine."Document No.") THEN
                        AddBufferEntry(
                          SalesInvoiceLine,
                          Quantity,
                          SalesShipmentHeader."Posting Date");
                END;
            UNTIL (SalesShipmentLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SETCURRENTKEY("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SETRANGE("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SETRANGE("Shipment Line No.", SalesShipmentLine."Line No.");
        IF SalesInvoiceLine.FIND('-') THEN
            REPEAT
                SalesShipmentLine.Quantity := SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            "Document No." := SalesInvoiceLine."Document No.";
            "Line No." := SalesInvoiceLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesInvoiceLine.Type;
            "No." := SalesInvoiceLine."No.";
            Quantity := QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT;
            NextEntryNo := NextEntryNo + 1
        END;
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        IF DataItem5581."Prepayment Invoice" THEN
            EXIT(Text010);

        //+BH1.01
        IF InvoiceOnlyFlag THEN
            EXIT(Text50000)
        ELSE
            EXIT(Text004);
        //-BH1.01
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DELETEALL;
        IF "DataItem1570".Type <> "DataItem1570".Type::Item THEN
            EXIT;
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", "DataItem1570"."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", "DataItem1570"."Line No.");
            IF NOT FINDSET THEN
                EXIT;
        END;
        REPEAT
            IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN
                IF ItemLedgerEntry."Document Type" = ItemLedgerEntry."Document Type"::"Sales Shipment" THEN BEGIN
                    SalesShipmentLine.GET(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    IF SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader) THEN BEGIN
                        PostedAsmLine.SETRANGE("Document No.", PostedAsmHeader."No.");
                        IF PostedAsmLine.FINDSET THEN
                            REPEAT
                                TreatAsmLineBuffer(PostedAsmLine);
                            UNTIL PostedAsmLine.NEXT = 0;
                    END;
                END;
        UNTIL ValueEntry.NEXT = 0;
    end;

    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        CLEAR(TempPostedAsmLine);
        TempPostedAsmLine.SETRANGE(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SETRANGE("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SETRANGE("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SETRANGE(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SETRANGE("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        IF TempPostedAsmLine.FINDFIRST THEN BEGIN
            TempPostedAsmLine.Quantity += PostedAsmLine.Quantity;
            TempPostedAsmLine.MODIFY;
        END ELSE BEGIN
            CLEAR(TempPostedAsmLine);
            TempPostedAsmLine := PostedAsmLine;
            TempPostedAsmLine.INSERT;
        END;
    end;

    procedure GetUOMText(UOMCode: Code[10]): Text[10]
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF NOT UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UOMCode);
        EXIT(UnitOfMeasure.Description);
    end;

    procedure BlanksForIndent(): Text[10]
    begin
        EXIT(PADSTR('', 2, ' '));
    end;

}*/