report 50060 "Posted Sales - Credit Memo"
{
    // BH1.00, Fiscal Process
    // BH1.01, Invoice elements
    DefaultLayout = RDLC;
    RDLCLayout = './Posted Sales - Credit Memo.rdl';

    Caption = 'Sales - Credit Memo';

    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem8098; "Sales Cr.Memo Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';
            column(No_SalesCrMemoHeader; "No.")
            {
            }
            column(VATAmtLineVATCptn; VATAmtLineVATCptnLbl)
            {
            }
            column(SumaTotal; SumaTotal)
            {
            }
            column(SumaRabat; SumaRabat)
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
            {
            }
            column(txtDocumentName; txtDocumentName + "DataItem8098"."No.")
            {
            }
            column(ShipmentMethod2; naslovi)
            {
            }
            column(SalesPersona; SalesPersona)
            {
            }
            column(NoOfCopies; NoOfCopies)
            {
            }
            column(DatumRacuna; "DataItem8098"."Document Date")
            {
            }
            column(VATNo; Customer."VAT Registration No.")
            {
            }
            column(CustPhone; Customer."Phone No.")
            {
            }
            column(RefNo; Pack)
            {
            }
            column(PaymentMethod; PaymentMethod)
            {
            }
            column(DueDate; FORMAT("DataItem8098"."Due Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(FORMAT_ShipmentDate; "DataItem8098"."Shipment Date")
            {
            }
            column(UserName; UserName)
            {
            }
            column(shipCity; shipCity)
            {
            }
            column(Footertext; FooterText)
            {
            }
            column(Addres; CompanyInfo.Address)
            {
            }
            column(web; CompanyInfo."Home Page")
            {
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
            column(IBAN; Ibaan)
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
            column(ExternalDoc; CompanyInfo."Chief Executive (Sign.)")
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
            column(CustomerName; Customer.Name)
            {
            }
            column(PaymentTermsCode_SalesCrMemoHeader; "DataItem8098"."Payment Terms Code")
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATAmtSpecCaption; VATAmtSpecCaptionLbl)
            {
            }
            column(LineAmtCaption; LineAmtCaptionLbl)
            {
            }
            column(TotalCaption; TotalExclVAT)
            {
            }
            column(UnitPriceCaption; UnitPriceCaptionLbl)
            {
            }
            column(PaymentTermsCaption; PaymentTermsCaptionLbl)
            {
            }
            column(ShipmentMethodCaption; ShipmentMethodCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(AllowInvDiscCaption; Text002)
            {
            }
            column(naslov; Swiftt)
            {
            }
            column(CustomerCaption; CustomerCaption)
            {
            }
            column(Valid; Valid)
            {
            }
            column(DateAndPlace; IssueCapt)
            {
            }
            column(vrijedido; vrijedido)
            {
            }
            column(DeliveryPerCapt; DeliveryPerCapt)
            {
            }
            column(Period; Period)
            {
            }
            column(datum; datum)
            {
            }
            column(br; OrdinalNo)
            {
            }
            column(br2; br2)
            {
            }
            column(ShowCountryofOrigin; ShowCountryofOrigin)
            {
            }
            column(TotalLet; TotalLet)
            {
            }
            column(Q; q)
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
            column(Exp; Exp)
            {
            }
            column(UpDisc; UpDisc)
            {
            }
            column(VATAmtLineVATBaseCptn; VATAmtLineVATBaseCptnLbl)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CustVatNo; CustVATNo)
            {
            }
            column(CustRegNo; CustRegNo)
            {
            }
            column(SelltoCustomerNo_SalesCrMemoHeader; "DataItem8098"."Sell-to Customer No.")
            {
            }
            column(BilltoCustomerNo_SalesCrMemoHeader; "DataItem8098"."Bill-to Customer No.")
            {
            }
            column(BilltoName_SalesCrMemoHeader; "DataItem8098"."Bill-to Name")
            {
            }
            column(BilltoAddress_SalesCrMemoHeader; "DataItem8098"."Bill-to Address")
            {
            }
            column(BilltoCity_SalesCrMemoHeader; "DataItem8098"."Bill-to Post Code")
            {
            }
            column(ShiptoCode_SalesCrMemoHeader; "DataItem8098"."Ship-to Code")
            {
            }
            column(ShiptoName_SalesCrMemoHeader; "DataItem8098"."Ship-to Name")
            {
            }
            column(ShiptoAddress_SalesCrMemoHeader; "DataItem8098"."Ship-to Address")
            {
            }
            column(ShiptoCity_SalesCrMemoHeader; "DataItem8098"."Ship-to City")
            {
            }
            column(ShiptoContact_SalesCrMemoHeader; "DataItem8098"."Ship-to Contact")
            {
            }
            column(PostingDate_SalesCrMemoHeader; "DataItem8098"."Posting Date")
            {
            }
            column(ShipmentDate_SalesCrMemoHeader; "DataItem8098"."Shipment Date")
            {
            }
            column(DueDate_SalesCrMemoHeader; "DataItem8098"."Due Date")
            {
            }
            column(PaymentDiscount_SalesCrMemoHeader; "DataItem8098"."Payment Discount %")
            {
            }
            column(ShipmentMethodCode_SalesCrMemoHeader; "DataItem8098"."Shipment Method Code")
            {
            }
            column(LocationCode_SalesCrMemoHeader; "DataItem8098"."Location Code")
            {
            }
            column(CurrencyCode_SalesCrMemoHeader; "DataItem8098"."Currency Code")
            {
            }
            column(SalespersonCode_SalesCrMemoHeader; "DataItem8098"."Salesperson Code")
            {
            }
            column(Amount_SalesCrMemoHeader; "DataItem8098".Amount)
            {
            }
            column(AmountIncludingVAT_SalesCrMemoHeader; "DataItem8098"."Amount Including VAT")
            {
            }
            column(TransportMethod_SalesCrMemoHeader; "DataItem8098"."Transport Method")
            {
            }
            column(SelltoCustomerName_SalesCrMemoHeader; "DataItem8098"."Sell-to Customer Name")
            {
            }
            column(SelltoAddress_SalesCrMemoHeader; "DataItem8098"."Sell-to Address")
            {
            }
            column(SelltoCity_SalesCrMemoHeader; "DataItem8098"."Sell-to City")
            {
            }
            column(SelltoContact_SalesCrMemoHeader; "DataItem8098"."Sell-to Contact")
            {
            }
            column(CompanyInfoAddress; CompanyInfo.Address)
            {
            }
            column(CompanyInfoBankName; CompanyInfoBankName)
            {
            }
            column(CompanyInfoBankAccounNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyInfoVATRegistrationNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(CompanyInfoRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfoCity; CompanyInfo.City)
            {
            }
            column(CompanyInfoPostCode; CompanyInfo."Post Code")
            {
            }
            column(VATAmtLineVATAmtCptn; VATAmtLineVATAmtCptnLbl)
            {
            }
            column(PmtDiscountDate_SalesCrMemoHeader; "DataItem8098"."Pmt. Discount Date")
            {
            }
            column(ShiptoPostCode_SalesCrMemoHeader; "DataItem8098"."Ship-to Post Code")
            {
            }
            column(ShiptoCounty_SalesCrMemoHeader; "DataItem8098"."Ship-to County")
            {
            }
            column(ShiptoCountryRegionCode_SalesCrMemoHeader; "DataItem8098"."Ship-to Country/Region Code")
            {
            }
            column(DocumentDate_SalesCrMemoHeader; "DataItem8098"."Document Date")
            {
            }
            column(ExternalDocumentNo_SalesCrMemoHeader; "DataItem8098"."External Document No.")
            {
            }
            column(VATAmtLineVATIdentifierCptn; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalCptn; TotalCptnLbl)
            {
            }
            column(SalesCrMemoLineDiscCaption; SalesCrMemoLineDiscCaptionLbl)
            {
            }
            column(InvoiceOnlyFlag; InvoiceOnlyFlag)
            {
            }
            /* column(InternalCorrection;DataItem8098."Internal Correction")
             {
             }*/
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(DocCptnCopyTxt; STRSUBSTNO(DocumentCaption, CopyText))
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
                    column(ShipDate; ShipmentDateCaptionLbl)
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
                    column(VAT; PDV)
                    {
                    }
                    column(SalesTerms; SalesTerms)
                    {
                    }
                    column(OtherComments; OtherComments)
                    {
                    }
                    column(Note; Note)
                    {
                    }
                    column(Note2; Note2)
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
                    column(DiscountCapt2; DiscountCapt2)
                    {
                    }
                    column(PaymentTermsCapt; PaymentTermsCapt)
                    {
                    }
                    column(OrderNo; OrderNo)
                    {
                    }
                    column(CountryCapt; CountryCapt)
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
                    column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoGiroNo; CompanyInfoGiroNo)
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "DataItem8098"."Bill-to Customer No.")
                    {
                    }
                    column(PostDate_SalesCrMemoHeader; FORMAT("DataItem8098"."Posting Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesCrMemoHeader; "DataItem8098"."VAT Registration No.")
                    {
                    }
                    column(SalesPersonText; SalesPersonText)
                    {
                    }
                    column(SalesPurchPersonName; SalesPurchPerson.Name)
                    {
                    }
                    column(AppliedToText; AppliedToText)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(YourRef_SalesCrMemoHeader; "DataItem8098"."Your Reference")
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
                    column(DocDt_SalesCrMemoHeader; FORMAT("DataItem8098"."Document Date", 0, 4))
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeader; "DataItem8098"."Prices Including VAT")
                    {
                    }
                    column(ReturnOrderNoText; ReturnOrderNoText)
                    {
                    }
                    column(ReturnOrdNo_SalesCrMemoHeader; "DataItem8098"."Return Order No.")
                    {
                    }
                    column(PageCaption; STRSUBSTNO(Text006, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo; FORMAT("DataItem8098"."Prices Including VAT"))
                    {
                    }
                    column(VATBaseDiscPrc_SalesCrMemoLine; "DataItem8098"."VAT Base Discount %")
                    {
                    }
                    column(CompanyInfoPhoneNoCptn; CompanyInfoPhoneNoCptnLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCptn; CompanyInfoVATRegNoCptnLbl)
                    {
                    }
                    column(CompanyInfoGiroNoCptn; CompanyInfoGiroNoCptnLbl)
                    {
                    }
                    column(CompanyInfoBankNameCptn; CompanyInfoBankNameCptnLbl)
                    {
                    }
                    column(CompanyInfoBankAccNoCptn; CompanyInfoBankAccNoCptnLbl)
                    {
                    }
                    column(No1_SalesCrMemoHeaderCptn; No1_SalesCrMemoHeaderCptnLbl)
                    {
                    }
                    column(SalesCrMemoHeaderPostDtCptn; SalesCrMemoHeaderPostDtCptnLbl)
                    {
                    }
                    column(DocumentDate; DocumentDateLbl)
                    {
                    }
                    column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
                    {
                    }
                    column(CompanyINfoEmailCaption; CompanyINfoEmailCaptionLbl)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeaderCaption; "DataItem8098".FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeaderCaption; "DataItem8098".FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(IssuedBySignature; IssuedBySignature)
                    {
                    }
                    column(ReceivedBySignature; ReceivedBySignature)
                    {
                    }
                    column(FiscalNo; "DataItem8098"."Fiscal No.")
                    {
                    }
                    column(RecFiscal; RecFiscal)
                    {

                    }
                    column(FiscalNoCaption; "DataItem8098".FIELDCAPTION("Fiscal No."))
                    {
                    }
                    column(ShipmentDate; FORMAT("DataItem8098"."Shipment Date"))
                    {
                    }
                    column(ShipmentDateCaption; "DataItem8098".FIELDCAPTION("Shipment Date"))
                    {
                    }
                    column(IssuedIn; CompanyInfo.City)
                    {
                    }
                    column(IssuedInCaption; IssuedInCaption)
                    {
                    }
                    column(CreditMemoNote1; CreditMemoNote1)
                    {
                    }
                    column(CreditMemoNote2; CreditMemoNote2)
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
                            SETFILTER("No.", '%1', DataItem8098."No.");
                        end;
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = DataItem8098;
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Num; Number)
                        {
                        }
                        column(HeaderDimCptn; HeaderDimCptnLbl)
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
                    dataitem(DataItem3364; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No." = FIELD("No.");
                        DataItemLinkReference = DataItem8098;
                        DataItemTableView = SORTING("Document No.", "Line No.");
                        column(CountPosText; CountPosText)
                        {
                        }
                        column(LineAmt_SalesCrMemoLine; "Line Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine; Description)
                        {
                        }
                        column(No_SalesCrMemoLine; "No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine; Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Unit Price")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 2;
                        }
                        column(Disc_SalesCrMemoLine; "Line Discount %")
                        {
                        }
                        column(VATIdentif_SalesCrMemoLine; FORMAT("VAT %") + '%')
                        {
                        }
                        column(PostedReceiptDate; FORMAT(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine; FORMAT(Type))
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                        }
                        column(InvDiscAmt_SalesCrMemoLine; -"Inv. Discount Amount")
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesCrMemoLine; Amount)
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtTxt; VATAmountLine.VATAmountText)
                        {
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLine; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineNo_SalesCrMemoLine; "Line No.")
                        {
                        }
                        column(Description_SalesCrMemoLine; DataItem3364.Description)
                        {
                        }
                        column(UnitPriceCptn; UnitPriceCptnLbl)
                        {
                        }
                        column(AmountCptn; AmountCptnLbl)
                        {
                        }
                        column(PostedReceiptDateCptn; PostedReceiptDateCptnLbl)
                        {
                        }
                        column(InvDiscAmt_SalesCrMemoLineCptn; InvDiscAmt_SalesCrMemoLineCptnLbl)
                        {
                        }
                        column(SubtotalCptn; SubtotalCptnLbl)
                        {
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLineCptn; LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption; FIELDCAPTION(Description))
                        {
                        }
                        column(No_SalesCrMemoLineCaption; FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption; FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption; FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentif_SalesCrMemoLineCaption; FIELDCAPTION("VAT %"))
                        {
                        }
                        dataitem("Sales Shipment Buffer"; Integer)
                        {
                            DataItemTableView = SORTING(Number);

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    SalesShipmentBuffer.FIND('-')
                                ELSE
                                    SalesShipmentBuffer.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SETRANGE(Number, 1, SalesShipmentBuffer.COUNT);
                            end;
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimCptn; LineDimCptnLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT DimSetEntry2.FIND('-') THEN
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", DataItem3364."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            NNC_TotalLineAmount += "Line Amount";



                            CountPosText := '';
                            IF (Type <> Type::" ") AND ("No." <> '') THEN BEGIN
                                CountPos += 1;
                                CountPosText := FORMAT(CountPos) + '.';
                            END;
                            NNC_TotalAmountInclVat += "Amount Including VAT";
                            NNC_TotalInvDiscAmount += "Inv. Discount Amount";
                            NNC_TotalAmount += Amount;

                            SalesShipmentBuffer.DELETEALL;
                            PostedReceiptDate := 0D;
                            IF Quantity <> 0 THEN
                                PostedReceiptDate := FindPostedShipmentDate;

                            /*IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "No." := '';*/

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

                        end;

                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DELETEALL;
                            CountPos := 0;

                            Ordinal := Ordinal + 1;


                            SalesShipmentBuffer.RESET;
                            SalesShipmentBuffer.DELETEALL;
                            FirstValueEntryNo := 0;
                            MoreLines := FIND('+');
                            WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) AND (Amount = 0) DO
                                MoreLines := NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SETRANGE("Line No.", 0, "Line No.");
                            CurrReport.CREATETOTALS(Amount, "Amount Including VAT", "Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
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
                            IF VATAmountLine.GetTotalVATAmount = 0 THEN
                                CurrReport.BREAK;
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
                            AutoFormatExpression = DataItem8098."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATAmtLineVATIdentifierCptnLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtLineVATAmtCptnLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if DataItem8098."Language Code" = '' then
                                DataItem8098."Language Code" := 'BOS';
                            VATAmountLine.GetLine(Number);
                            IF NOT VATClause.GET(VATAmountLine."VAT Clause Code") THEN
                                CurrReport.SKIP;
                            VATClause.TranslateDescription(DataItem8098."Language Code");
                        end;

                        trigger OnPreDataItem()
                        begin
                            CLEAR(VATClause);
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercent; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(VATAmountLine."VAT Base" / DataItem8098."Currency Factor");
                            VALVATAmountLCY := ROUND(VATAmountLine."VAT Amount" / DataItem8098."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (DataItem8098."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                               OR (NOT GLSetup."Print VAT specification")//BH1.01
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text008 + Text009
                            ELSE
                                VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(DataItem8098."Posting Date", DataItem8098."Currency Code", 1);
                            CalculatedExchRate := ROUND(1 / DataItem8098."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate := STRSUBSTNO(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesCrMemoHeader; "DataItem8098"."Sell-to Customer No.")
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
                        column(ShiptoAddressCptn; ShiptoAddressCptnLbl)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeaderCaption; "DataItem8098".FIELDCAPTION("Sell-to Customer No."))
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
                    CurrReport.PAGENO := 1;
                    IF Number > 1 THEN BEGIN
                        CopyText := Text004;
                        OutputNo += 1;
                    END;

                    NNC_TotalLineAmount := 0;
                    NNC_TotalAmountInclVat := 0;
                    NNC_TotalInvDiscAmount := 0;
                    NNC_TotalAmount := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF NOT CurrReport.PREVIEW THEN
                        SalesCrMemoCountPrinted.RUN(DataItem8098);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;
                SalesMemo.RESET;
                SalesMemo.SETFILTER("Document No.", '%1', DataItem8098."No.");
                IF SalesMemo.FINDSET THEN
                    REPEAT
                        SumaTotal := SumaTotal + SalesMemo."Unit Price" * SalesMemo.Quantity;
                        SumaRabat := SumaRabat + SalesMemo."Line Discount %";
                    UNTIL SalesMemo.NEXT = 0;


                BankAccount.RESET;
                BankAccount.SETFILTER("No.", '%1', DataItem8098."Bal. Account No.");
                IF BankAccount.FINDFIRST THEN BEGIN

                    CompanyInfoBankName := BankAccount.Name;
                    CompanyInfoGiroNo := BankAccount."Bank Account No.";
                    Ibaan := BankAccount.IBAN;
                    Swiftt := BankAccount."SWIFT Code";
                END;

                CompanyInfoBankName := CompanyInfo."Bank Name";
                CompanyInfoGiroNo := CompanyInfo."Giro No.";
                Ibaan := CompanyInfo.IBAN;
                Swiftt := CompanyInfo."SWIFT Code";

                CompanyInfo1.CALCFIELDS(Picture);
                txtDocumentName := FORMAT(Text50016);
                FooterText := '';
                /*   Doc.RESET;
                   Doc.SETFILTER("Language Code", '%1', 'BOS');
                   Doc.SETCURRENTKEY("Primary key");
                   Doc.ASCENDING(TRUE);
                   IF Doc.FINDSET THEN
                       REPEAT
                           FooterText := FooterText + ' ' + Doc."Footer Text";
                       UNTIL Doc.NEXT = 0;
   */
                IF CR.GET(CompanyInfo."Country/Region Code") THEN
                    CountryComp := CR.Name
                ELSE
                    CountryComp := '';
                Customer.GET("Bill-to Customer No.");

                IF PostCode.GET("Ship-to Post Code") THEN shipCity := PostCode.City;
                User.RESET;
                User.SETFILTER("User Name", '%1', USERID);
                IF User.FINDFIRST
                  THEN
                    UserName := User."Full Name";

                if DataItem8098."Language Code" = '' then
                    DataItem8098."Language Code" := 'BOS';
                CurrReport.LANGUAGE := GetLanguage.GetLanguageID("Language Code");
                /*IF CurrReport.LANGUAGE=1033 THEN
                naslov:='Sales Credit Memo'
                ELSE
                naslov:='Knjižno odobrenje';         */
                CompanyInfo.GET;
                SM.RESET;
                SM.SETFILTER(Code, '%1', "Shipment Method Code");
                IF SM.FINDFIRST THEN BEGIN
                    ShipmentMethod2 := SM.Description;
                    //SH.SETFILTER("Order No.",'%1',"Order No.");
                    IF SH.FINDFIRST THEN
                        ShipmentNO := SH."Order No.";
                END;
                PT.SETFILTER(Code, '%1', "Payment Method Code");
                IF PT.FINDFIRST THEN
                    PaymentMethod := PT.Description;
                // Refno:=DataItem8098.
                SalespersonTable.RESET;
                SalespersonTable.SETFILTER(Code, "Salesperson Code");
                IF SalespersonTable.FIND('-') THEN BEGIN
                    SalesPersona := SalespersonTable.Name;
                END;


                //AS1

                Cust.SETFILTER("No.", "Sell-to Customer No.");
                IF Cust.FIND('-') THEN BEGIN
                    CustVATNo := Cust."VAT Registration No.";
                    CustRegNo := Cust."Registration No.";
                END;
                //Applies-to Doc. No.
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetFilter("No.", '%1', DataItem8098."Applies-to Doc. No.");
                if SalesInvoiceHeader.FindFirst() then begin
                    RecFiscal := SalesInvoiceHeader."Fiscal No.";
                end;




                /* IF NOT Prepayment THEN naslov:=naslovi
                 ELSE naslov:=naslovAvans;
                */

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Return Order No." = '' THEN
                    ReturnOrderNoText := ''
                ELSE
                    ReturnOrderNoText := FIELDCAPTION("Return Order No.");
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
                    TotalExclVATText := STRSUBSTNO(Text007, GLSetup."LCY Code");
                END ELSE BEGIN
                    TotalText := STRSUBSTNO(Text001, "Currency Code");
                    TotalInclVATText := STRSUBSTNO(Text002, "Currency Code");
                    TotalExclVATText := STRSUBSTNO(Text007, "Currency Code");
                END;
                FormatAddr.SalesCrMemoBillTo(CustAddr, DataItem8098);
                IF "Applies-to Doc. No." = '' THEN
                    AppliedToText := ''
                ELSE
                    AppliedToText := STRSUBSTNO(Text003, "Applies-to Doc. Type", "Applies-to Doc. No.");

                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, DataItem8098);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF LogInteraction THEN
                    IF NOT CurrReport.PREVIEW THEN
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Contact, "Bill-to Contact No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '')
                        ELSE
                            SegManagement.LogDocument(
                              6, "No.", 0, 0, DATABASE::Customer, "Sell-to Customer No.", "Salesperson Code",
                              "Campaign No.", "Posting Description", '');

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
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        Caption = 'Archive Document';
                        Visible = false;

                        trigger OnValidate()
                        begin
                            IF NOT ArchiveDocument THEN
                                LogInteraction := FALSE;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            IF LogInteraction THEN
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ShowAssemblyComponents; DisplayAssemblyInformation)
                    {
                        Caption = 'Show Assembly Components';
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
            LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
            LogInteractionEnable := LogInteraction;
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.GET;
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
    end;

    var
        naslovAvans: Label 'Prepayment credit memo';
        GetLanguage: Codeunit Language;
        naslovi: Label 'Credit memo';
        Text50016: Label 'Bill No.';
        Text000: Label 'Salesperson';
        Text001: Label 'Total %1';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label '(Applies to %1 %2)';
        Text004: Label 'COPY';
        Text005: Label 'Return receipt %1';
        Text006: Label 'Page ';
        Text007: Label 'Total %1 Excl. VAT';
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankCaptionLbl: Label 'Bank';
        AccountNoCaptionLbl: Label 'Account No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Proforma invoice';
        HomePageCaptionCap: Label 'Home Page';
        EmailCaptionLbl: Label 'E-Mail';
        HeaderDimCaptionLbl: Label 'Header Dimensions';
        DiscountPercentCaptionLbl: Label 'Discount %';
        SubtotalCaptionLbl: Label 'Subtotal';
        PaymentDiscountVATCaptionLbl: Label 'Payment Discount on VAT';
        LineDimCaptionLbl: Label 'Line Dimensions';
        InvDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        VATIdentifierCaptionLbl: Label 'VAT Identifier';
        ShiptoAddrCaptionLbl: Label 'Ship-to Address';
        DescriptionCaptionLbl: Label 'Description';
        GLAccountNoCaptionLbl: Label 'G/L Account No.';
        PrepaymentSpecCaptionLbl: Label 'Prepayment Specification';
        PrepaymentVATAmtSpecCapLbl: Label 'Prepayment VAT Amount Specification';
        PrepmtPmtTermsDescCaptionLbl: Label 'Prepmt. Payment Terms';
        PhoneNoCaptionLbl: Label 'Phone No.';
        AmountCaptionLbl: Label 'Amount';
        VATPercentageCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT (KM)';
        VATAmtSpecCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        TotalCaptionLbl: Label 'Total Gross Amount';
        UnitPriceCaptionLbl: Label 'Unit Price';
        PaymentTermsCaptionLbl: Label 'Payment Terms';
        ShipmentMethodCaptionLbl: Label 'Shipment Method';
        DocumentDateCaptionLbl: Label 'Document Date';
        AllowInvDiscCaptionLbl: Label 'Allow Invoice Discount';
        OrdinalNo: Label 'No.';
        ItemCapt: Label 'Product code';
        ItemNameCapt: Label 'Product name';
        ItemCodeCapt: Label 'Product code';
        QuantityCapt: Label 'Qty';
        UMCapt: Label 'Unit of measure';
        UnitPriceCapt: Label 'Unit price';
        DiscountCapt: Label 'Discount %';
        AmountCapt: Label 'Gross Amount';
        TotalCapt: Label 'Total Gross Amount';
        TotalExclVAT: Label 'Total Excl. VAT';
        TotalInclVAT: Label 'Total Incl. VAT';
        PDV: Label 'VAT (KM)';
        SalesTerms: Label 'Terms of Sale';
        OtherComments: Label 'and other comments';
        Note: Label 'This document is printed in electronic form and it is valid without signatures and seals.';
        Note2: Label 'If no one is there, please delivery stuff leave in the coffee next to door.';
        CustomerCaption2: Label 'Customer/Bill to';
        ShipCapt: Label 'Ship to';
        ShipDetailCapt: Label 'Shipping details';
        IssueCapt: Label 'Date and Place';
        Value: Label 'Valid until';
        NoCapt: Label 'No.';
        InvNo: Label 'Fiscal invoice no.';
        CustNo: Label 'Customer No.';
        ShipTermsCapt: Label 'Delivery terms';
        ShipMethod: Label 'Delivery Method';
        ShipDate: Label 'Delivery Date Expected';
        Pack: Label 'Total package';
        PaymentTermsCapt: Label 'Payment Terms';
        CountryCapt: Label 'Country of origin';
        DueDate: Label 'Shipment due';
        InvNo2: Label 'P. Invoice No';
        FInvNo: Label 'Fiscal invoice No.';
        OrderNo: Label 'Quotation No.';
        Quote: Label 'Quotation';
        Valid: Label 'Offer Expire Date';
        TotalLet: Label 'Total value:';
        Exp: Label 'Expiration Date';
        UpDisc: Label 'Unit price with discount';
        DiscountCapt2: Label 'Discount ';
        DeliveryPerCapt: Label 'Delivery Period*';
        Date: Label 'Date';
        ClientNo: Label 'Client No';
        Client: Label 'CUSTOMER / BILL TO';
        Text026: Label '';
        Text027: Label 'hundred';
        Text028: Label '';
        Text029: Label '';
        Text032: Label 'one';
        Text033: Label 'two';
        Text034: Label 'three';
        Text035: Label 'four';
        Text036: Label 'five';
        Text037: Label 'six';
        Text038: Label 'seven';
        Text039: Label 'eight';
        Text040: Label 'nine';
        Text041: Label 'ten';
        Text042: Label 'eleven';
        Text043: Label 'twelve';
        Text044: Label 'thirteen';
        Text045: Label 'fourteen';
        Text046: Label 'fifteen';
        Text047: Label 'sixteen';
        Text048: Label 'seventeen';
        Text049: Label 'eighteen';
        Text050: Label 'nineteen';
        Text051: Label 'twenty';
        Text052: Label 'thirty';
        Text053: Label 'fourty';
        Text054: Label 'fifty';
        Text055: Label 'sixty';
        Text056: Label 'seventy';
        Text057: Label 'eighty';
        Text058: Label 'ninety';
        Text059: Label 'thousand';
        Text008: Label 'VAT Amount Specification in ';
        Text009: Label 'Local Currency';
        Text010: Label 'Exchange rate: %1/%2';
        Text011: Label 'Sales - Prepmt. Credit Memo %1';
        Text50000: Label 'Credit Memo %1';
        Text50001: Label ' - Internal correction';
        CreditMemoNote1: Label 'We ask you kindly to sign this document and approve that you have deducted the VAT amount calculated in the document from your purchase VAT and send back one signed copy of the document as soon as possible.';
        CreditMemoNote2: Label 'Purchase VAT is deducted';
        IssuedBySignature: Label 'Issued by';
        ReceivedBySignature: Label 'Received by';
        IssuedInCaption: Label 'Issued in';
        CompanyInfoPhoneNoCptnLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCptnLbl: Label 'VAT Reg. No.';
        CompanyInfoGiroNoCptnLbl: Label 'Giro No.';
        CompanyInfoBankNameCptnLbl: Label 'Bank';
        CompanyInfoBankAccNoCptnLbl: Label 'Account No.';
        No1_SalesCrMemoHeaderCptnLbl: Label 'Credit Memo No.';
        SalesCrMemoHeaderPostDtCptnLbl: Label 'Posting Date';
        DocumentDateLbl: Label 'Document Date';
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyINfoEmailCaptionLbl: Label 'E-Mail';
        HeaderDimCptnLbl: Label 'Header Dimensions';
        UnitPriceCptnLbl: Label 'Unit Price';
        AmountCptnLbl: Label 'Amount';
        PostedReceiptDateCptnLbl: Label 'Posted Return Receipt Date';
        InvDiscAmt_SalesCrMemoLineCptnLbl: Label 'Invoice Discount Amount';
        SubtotalCptnLbl: Label 'Subtotal';
        LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl: Label 'Payment Discount on VAT';
        VATClausesCap: Label 'VAT Clause';
        LineDimCptnLbl: Label 'Line Dimensions';
        VATAmtSpecificationCptnLbl: Label 'VAT Amount Specification';
        VATAmtLineInvDiscBaseAmtCptnLbl: Label 'Invoice Discount Base Amount';
        VATAmtLineLineAmtCptnLbl: Label 'Line Amount';
        VATAmtLineInvoiceDiscAmtCptnLbl: Label 'Invoice Discount Amount';
        ShiptoAddressCptnLbl: Label 'Ship-to Address';
        VATAmtLineVATCptnLbl: Label 'VAT %';
        VATAmtLineVATBaseCptnLbl: Label 'VAT Base';
        VATAmtLineVATAmtCptnLbl: Label 'VAT Amount';
        VATAmtLineVATIdentifierCptnLbl: Label 'VAT Identifier';
        TotalCptnLbl: Label 'Total';
        SalesCrMemoLineDiscCaptionLbl: Label 'Discount %';
        naslovF: Text[150];
        Commm: Text;
        Cust: Record Customer;
        CustRegNo: Code[30];
        SalesMemo: Record "Sales Cr.Memo Line";
        SalespersonTable: Record "Salesperson/Purchaser";
        //ĐK         DF: Record "Document Footer";
        SumaTotal: Decimal;
        SumaRabat: Decimal;
        txtDocumentName: Text;
        CountPos: Integer;
        CustVATNo: Code[30];
        ShipmentMethod2: Text;
        FooterText: Text;
        CountPosText: Text;
        CountryComp: Text;
        CompanyInfoGiroNo: Text;
        SalesPersona: Text;
        shipCity: Text;
        ShipmentNO: Text;
        ArchiveDocument: Boolean;
        SH: Record "Sales Shipment Header";
        BankAccount: Record "Bank Account";
        CompanyInfoBankName: Text;
        Customer: Record Customer;
        Ibaan: Text;
        Swiftt: Text;
        //ĐK   Doc: Record "Document Footer";
        SIH: Record "Sales Invoice Header";
        CR: Record "Country/Region";
        UserName: Text;
        PT: Record "Payment Method";
        SM: Record "Shipment Method";
        PaymentMethod: Text;
        Ordinal: Integer;
        naslov: Text[30];
        vatn: Decimal;
        CustomerCapt: Text[100];
        CustomerCaption: Text[100];
        SalesInvoiceHeader: Record "Sales Invoice Header";
        ExpireCapt: Text[100];
        DateAndPlace: Text[100];
        Period: Text[250];
        //    delterms: Record "Travel Line";
        OnesText: array[20] of Text[30];
        ExponentText: array[5] of Text[30];
        TensText: array[10] of Text[30];
        q: Code[30];
        Refno: Text;
        br2: Text[50];
        ShowCountryofOrigin: Boolean;
        ShowNote1: Boolean;
        ShowNote2: Boolean;
        ShowNote3: Boolean;
        br: Text[20];
        User: Record User;
        PostCode: Record "Post Code";
        vrijedido: Text;
        datum: Date;
        GLSetup: Record "General Ledger Setup";
        SalesSetup: Record "Sales & Receivables Setup";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        VATAmountLine: Record "VAT Amount Line" temporary;
        VATClause: Record "VAT Clause";
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        Language2: Record Language;
        SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        RespCenter: Record "Responsibility Center";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        ReturnOrderNoText: Text[80];
        SalesPersonText: Text[30];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        AppliedToText: Text[40];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        LogInteraction: Boolean;
        FirstValueEntryNo: Integer;
        PostedReceiptDate: Date;
        NextEntryNo: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        CalculatedExchRate: Decimal;
        OutputNo: Integer;
        NNC_TotalLineAmount: Decimal;
        NNC_TotalAmountInclVat: Decimal;
        NNC_TotalInvDiscAmount: Decimal;
        RecFiscal: Code[20];
        NNC_TotalAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        InvoiceOnlyFlag: Boolean;
        ArchiveDocumentEnable: Boolean;
        DisplayAssemblyInformation: Boolean;

    procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(6) <> '';
    end;

    procedure FindPostedShipmentDate(): Date
    var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo := 1;
        IF DataItem3364."Return Receipt No." <> '' THEN
            IF ReturnReceiptHeader.GET(DataItem3364."Return Receipt No.") THEN
                EXIT(ReturnReceiptHeader."Posting Date");
        IF DataItem8098."Return Order No." = '' THEN
            EXIT(DataItem8098."Posting Date");

        CASE DataItem3364.Type OF
            DataItem3364.Type::Item:
                GenerateBufferFromValueEntry("DataItem3364");
            DataItem3364.Type::"G/L Account", DataItem3364.Type::Resource,
          DataItem3364.Type::"Charge (Item)", DataItem3364.Type::"Fixed Asset":
                GenerateBufferFromShipment("DataItem3364");
            DataItem3364.Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", DataItem3364."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", DataItem3364."Line No.");

        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;
            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> DataItem3364.Quantity THEN BEGIN
                SalesShipmentBuffer.DELETEALL;
                EXIT(DataItem8098."Posting Date");
            END;
        END ELSE
            EXIT(DataItem8098."Posting Date");
    end;

    procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin

        TotalQuantity := SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SETCURRENTKEY("Document No.");
        ValueEntry.SETRANGE("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SETRANGE("Posting Date", DataItem8098."Posting Date");
        ValueEntry.SETRANGE("Item Charge No.", '');
        ValueEntry.SETFILTER("Entry No.", '%1..', FirstValueEntryNo);
        IF ValueEntry.FIND('-') THEN
            REPEAT
                IF ItemLedgerEntry.GET(ValueEntry."Item Ledger Entry No.") THEN BEGIN
                    IF SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 THEN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    AddBufferEntry(
                      SalesCrMemoLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity - ValueEntry."Invoiced Quantity";
                END;
                FirstValueEntryNo := ValueEntry."Entry No." + 1;
            UNTIL (ValueEntry.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity := 0;
        SalesCrMemoHeader.SETCURRENTKEY("Return Order No.");
        SalesCrMemoHeader.SETFILTER("No.", '..%1', DataItem8098."No.");
        SalesCrMemoHeader.SETRANGE("Return Order No.", DataItem8098."Return Order No.");
        IF SalesCrMemoHeader.FIND('-') THEN
            REPEAT
                SalesCrMemoLine2.SETRANGE("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SETRANGE(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SETRANGE("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                IF SalesCrMemoLine2.FIND('-') THEN
                    REPEAT
                        TotalQuantity := TotalQuantity + SalesCrMemoLine2.Quantity;
                    UNTIL SalesCrMemoLine2.NEXT = 0;
            UNTIL SalesCrMemoHeader.NEXT = 0;

        ReturnReceiptLine.SETCURRENTKEY("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SETRANGE("Return Order No.", DataItem8098."Return Order No.");
        ReturnReceiptLine.SETRANGE("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SETRANGE(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SETRANGE("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SETRANGE("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SETFILTER(Quantity, '<>%1', 0);

        IF ReturnReceiptLine.FIND('-') THEN
            REPEAT
                IF DataItem8098."Get Return Receipt Used" THEN
                    CorrectShipment(ReturnReceiptLine);
                IF ABS(ReturnReceiptLine.Quantity) <= ABS(TotalQuantity - SalesCrMemoLine.Quantity) THEN
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity
                ELSE BEGIN
                    IF ABS(ReturnReceiptLine.Quantity) > ABS(TotalQuantity) THEN
                        ReturnReceiptLine.Quantity := TotalQuantity;
                    Quantity :=
                      ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);

                    SalesCrMemoLine.Quantity := SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity := TotalQuantity - ReturnReceiptLine.Quantity;

                    IF ReturnReceiptHeader.GET(ReturnReceiptLine."Document No.") THEN
                        AddBufferEntry(
                          SalesCrMemoLine,
                          -Quantity,
                          ReturnReceiptHeader."Posting Date");
                END;
            UNTIL (ReturnReceiptLine.NEXT = 0) OR (TotalQuantity = 0);
    end;

    procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SETCURRENTKEY("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SETRANGE("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SETRANGE("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        IF SalesCrMemoLine.FIND('-') THEN
            REPEAT
                ReturnReceiptLine.Quantity := ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            UNTIL SalesCrMemoLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.MODIFY;
            EXIT;
        END;

        WITH SalesShipmentBuffer DO BEGIN
            INIT;
            "Document No." := SalesCrMemoLine."Document No.";
            "Line No." := SalesCrMemoLine."Line No.";
            "Entry No." := NextEntryNo;
            Type := SalesCrMemoLine.Type;
            "No." := SalesCrMemoLine."No.";
            Quantity := -QtyOnShipment;
            "Posting Date" := PostingDate;
            INSERT;
            NextEntryNo := NextEntryNo + 1
        END;
    end;

    local procedure DocumentCaption(): Text[250]
    var
        InternalCorrectionText: Text[30];
    begin
        //+BH1.01
        InternalCorrectionText := '';
        IF DataItem8098."Internal Correction" THEN
            InternalCorrectionText := Text50001;

        IF DataItem8098."Prepayment Credit Memo" THEN
            EXIT(Text011 + InternalCorrectionText);

        IF InvoiceOnlyFlag THEN
            EXIT(Text50000 + InternalCorrectionText)
        ELSE
            EXIT(Text005 + InternalCorrectionText);
        //-BH1.01
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies := NewNoOfCopies;
        ShowInternalInfo := NewShowInternalInfo;
        LogInteraction := NewLogInteraction;
    end;
}

