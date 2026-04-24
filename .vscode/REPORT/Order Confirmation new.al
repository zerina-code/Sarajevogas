/*report 50099 "Order Confirmation new"
{
    RDLCLayout = './Order Confirmation.rdl';
    Caption = 'Order Confirmation';
    DefaultLayout = RDLC;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem6640; "Sales Header")
        {
            DataItemTableView = SORTING("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Order';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(PaymentTermsDesc; PaymentTerms.Description)
            {
            }
            column(AmountIncludingVAT_SalesHeader; DataItem6640."Amount Including VAT")
            {
            }
            column(Amount_SalesHeader; DataItem6640.Amount)
            {
            }
            column(ShipmentMethodDesc; ShipmentMethod.Description)
            {
            }
            column(InvDiscAmtCaption; InvDiscAmtCaptionLbl)
            {
            }
            column(PhoneNoCaption; PhoneNoCaptionLbl)
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
            column(TotalCaption; TotalCaptionLbl)
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
            column(AllowInvDiscCaption; AllowInvDiscCaptionLbl)
            {
            }
            column(naslov; naslov)
            {
            }
            column(CustomerCaption; CustomerCaption)
            {
            }
            column(Valid; Valid)
            {
            }
            column(DateAndPlace; DateAndPlace)
            {
            }
            column(DDate; DataItem6640."Due Date")
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
            column(br; br)
            {
            }
            column(br2; br2)
            {
            }
            column(ShowCountryofOrigin; ShowCountryofOrigin)
            {
            }
            column(Totalletters; DataItem6640."Total Value Letters")
            {
            }
            column(TotalLet; TotalLet)
            {
            }
            column(QNo; DataItem6640."Quote No.")
            {
            }
            column(Q; q)
            {
            }
            column(DueDate2; DueDate2)
            {
            }
            column(Country; DataItem6640."Country of Origin")
            {
            }
            column(Note1; note1)
            {
            }
            column(Note21; DataItem6640."Note 2")
            {
            }
            column(Note3; DataItem6640."Note 3")
            {
            }
            column(TM; DataItem6640."Transport Method")
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
            column(ExpDate; DataItem6640."Due Date 2")
            {
            }
            column(UpDisc; UpDisc)
            {
            }
            column(CompanyInfoGiroNo; PaymentInfoGiroNo)
            {
            }
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        WHERE(Number = CONST(1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(CompanyInfoChief; CompanyInfo."Chief Executive (Sign.)")
                    {

                    }

                    column(OrderConfirmCopyCaption; STRSUBSTNO(Text004, CopyText))
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
                    column(CompanyInfoPhNo; CompanyInfo."Phone No.")
                    {
                        IncludeCaption = false;
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfoBankName; PaymentBankName)
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(Adress; CompanyInfo.Address)
                    {
                    }
                    column(IBAN; PaymentIBAN)
                    {
                    }
                    column(SWIFT; PaymentSWIFT)
                    {
                    }
                    column(CEO; CompanyInfo."Country Name")
                    {
                    }
                    column(PaymentInstr; PaymentInstr)
                    {
                    }
                    column(BilltoCustNo_SalesHeader; DataItem6640."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT(DataItem6640."Document Date"))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesHeader; DataItem6640."VAT Registration No.")
                    {
                    }
                    column(ShptDate_SalesHeader; FORMAT(DataItem6640."Shipment Date"))
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
                    column(SalesOrderReference_SalesHeader; DataItem6640."Your Reference")
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
                    column(PricesInclVAT_SalesHeader; DataItem6640."Prices Including VAT")
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PmntTermsDesc; PaymentTerms.Description)
                    {
                    }
                    column(ShptMethodDesc; ShipmentMethod.Description)
                    {
                    }
                    column(PricesInclVATYesNo_SalesHeader; FORMAT(DataItem6640."Prices Including VAT"))
                    {
                    }
                    column(VATRegNoCaption; VATRegNoCaptionLbl)
                    {
                    }
                    column(GiroNoCaption; GiroNoCaptionLbl)
                    {
                    }
                    column(BankCaption; BankCaptionLbl)
                    {
                    }
                    column(AccountNoCaption; AccountNoCaptionLbl)
                    {
                    }
                    column(ShipmentDateCaption; ShipmentDateCaptionLbl)
                    {
                    }
                    column(OrderNoCaption; OrderNoCaptionLbl)
                    {
                    }
                    column(HomePageCaption; HomePageCaptionCap)
                    {
                    }
                    column(EmailCaption; EmailCaptionLbl)
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
                    column(ItemCapt; ItemCapt)
                    {
                    }
                    column(ItemNameCapt; ItemNameCapt)
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
                    column(Ordinal; FORMAT(Ordinal))
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
                    column(PTC; DataItem6640."Payment Terms Code")
                    {
                    }
                    column(No; DataItem6640."No.")
                    {
                    }
                    column(CustomerName; DataItem6640."Sell-to Customer Name")
                    {
                    }
                    column(SellToAdress; DataItem6640."Sell-to Address")
                    {
                    }
                    column(SellToCity; DataItem6640."Sell-to Post Code")
                    {
                    }
                    column(SellToCity2; DataItem6640."Sell-to City")
                    {
                    }
                    column(CustVatNo; CustVatNo)
                    {
                    }
                    column(ShipToName; DataItem6640."Ship-to Name")
                    {
                    }
                    column(ShipToAdress; DataItem6640."Ship-to Address")
                    {
                    }
                    column(shipToCity; DataItem6640."Ship-to Post Code")
                    {
                    }
                    column(CurrCode; DataItem6640."Currency Code")
                    {
                    }
                    column(DocumentDate; DataItem6640."Document Date")
                    {
                    }
                    column(ExternalDoc; DataItem6640."External Document No.")
                    {
                    }
                    column(SalesCode; DataItem6640."Salesperson Code")
                    {
                    }
                    column(TotalPack; DataItem6640."Total Packaging")
                    {
                    }
                    column(SalesPersona; SalesPersona)
                    {
                    }
                    column(OrderNoCaptionLbl; OrderNoCaptionLbl)
                    {
                    }
                    column(DueDate; DataItem6640."Due Date")
                    {
                    }
                    column(PostingDate; DataItem6640."Posting Date")
                    {
                    }
                    column(CustRegNo; CustRegNo)
                    {
                    }
                    column(ShipDate2; DataItem6640."Shipment Date")
                    {
                    }
                    column(BilltoCustNo_SalesHeaderCaption; DataItem6640.FIELDCAPTION("Bill-to Customer No."))
                    {
                    }
                    column(PricesInclVAT_SalesHeaderCaption; DataItem6640.FIELDCAPTION("Prices Including VAT"))
                    {
                    }
                    column(Name; CompanyInfo.Name)
                    {
                    }
                    column(Picture; CompanyInfo.Picture)
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
                    column(EMail; CompanyInfo."E-Mail")
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
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = DataItem6640;
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
                                IF NOT DimSetEntry1.FIND('-') THEN
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
                            if DataItem2844.Type <> DataItem2844.Type::" " then begin
                                Ordinal += 1;
                                EmptyRow := false;
                            end
                            else begin
                                EmptyRow := true;
                            end;
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowInternalInfo THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(DataItem2844; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD("Document Type"),
                                       "Document No." = FIELD("No.");
                        DataItemLinkReference = DataItem6640;
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");

                        trigger OnAfterGetRecord()
                        begin
                            CompanyInfo.GET;
                            TotalLineDiscountAndAmount += DataItem2844."Line Discount Amount" + Amount;
                            VATPost.RESET;
                            VATPost.SETFILTER(Code, '%1', DataItem2844."VAT Prod. Posting Group");
                            IF VATPost.FINDFIRST THEN
                                VATDesc := VATPost.Description
                            ELSE
                                VATDesc := PDV;
                            SumaTotal := 0;
                            SumaLine := 0;
                            SalesLine.RESET;
                            SalesLine.SETFILTER("Document No.", '%1', DataItem2844."Document No.");
                            IF SalesLine.FINDSET THEN
                                REPEAT
                                    SumaTotal := SumaTotal + (SalesLine."Unit Price") * SalesLine.Quantity;
                                    SumaLine := SumaLine + SalesLine."Line Amount";
                                UNTIL SalesLine.NEXT = 0;
                            Razlika := SumaTotal - SumaLine;
                        end;

                        trigger OnPreDataItem()
                        begin
                            //CurrReport.BREAK;
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(vatn; vatn)
                        {
                        }
                        column(SalesLineAmt; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalLineDiscountAndAmount; TotalLineDiscountAndAmount)
                        {
                        }
                        column(Razlika; Razlika)
                        {
                        }
                        column(SumaLine; SumaLine)
                        {
                        }
                        column(SumaTotal; SumaTotal)
                        {
                        }
                        column(LineDiscount; DataItem2844."Line Discount Amount")
                        {
                        }
                        column(VAT; VATDesc)
                        {
                        }
                        column(Desc_SalesLine; DataItem2844.Description + ' ' + DataItem2844."Description 2")
                        {
                        }
                        column(vatperc; DataItem2844."VAT %")
                        {
                        }
                        column(NNCSalesLineLineAmt; NNCSalesLineLineAmt)
                        {
                        }
                        column(NNCSalesLineInvDiscAmt; NNCSalesLineInvDiscAmt)
                        {
                        }
                        column(NNCTotalLCY; NNCTotalLCY)
                        {
                        }
                        column(NNCTotalExclVAT; NNCTotalExclVAT)
                        {
                        }
                        column(NNCVATAmt; NNCVATAmt)
                        {
                        }
                        column(NNCTotalInclVAT; NNCTotalInclVAT)
                        {
                        }
                        column(NNCPmtDiscOnVAT; NNCPmtDiscOnVAT)
                        {
                        }
                        column(NNCTotalInclVAT2; NNCTotalInclVAT2)
                        {
                        }
                        column(NNCVATAmt2; NNCVATAmt2)
                        {
                        }
                        column(NNCTotalExclVAT2; NNCTotalExclVAT2)
                        {
                        }
                        column(VATBaseDisc_SalesHeader; DataItem6640."VAT Base Discount %")
                        {
                        }
                        column(DisplayAssemblyInfo; DisplayAssemblyInformation)
                        {
                        }
                        column(LTxtTotalAmount; LTxtTotalAmount)
                        {
                        }
                        column(ShowInternalInfo; ShowInternalInfo)
                        {
                        }
                        column(No2_SalesLine; DataItem2844."No.")
                        {
                        }
                        column(Qty_SalesLine; FORMAT(DataItem2844.Quantity))
                        {
                        }
                        column(UOM_SalesLine; DataItem2844."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesLine; FORMAT(DataItem2844."Unit Price", 0, '<Integer Thousand><Decimals,3>'))
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 2;
                            IncludeCaption = false;
                        }
                        column(Cijena; Cijena)
                        {

                        }
                        column(LineDisc_SalesLine; DataItem2844."Line Discount %")
                        {
                        }
                        column(LineAmt_SalesLine; DataItem2844."Line Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(AllowInvDisc_SalesLine; DataItem2844."Allow Invoice Disc.")
                        {
                        }
                        column(VATIdentifier_SalesLine; DataItem2844."VAT Identifier")
                        {
                        }
                        column(Type_SalesLine; FORMAT(DataItem2844.Type))
                        {
                        }
                        column(LineDiscPrec; SalesLine."Line Discount %")
                        {
                        }
                        column(LineDiscAmount; SalesLine."Line Discount Amount")
                        {
                        }
                        column(No_SalesLine; DataItem2844."Line No.")
                        {
                        }
                        column(AllowInvDiscountYesNo_SalesLine; FORMAT(DataItem2844."Allow Invoice Disc."))
                        {
                        }
                        column(AsmInfoExistsForLine; AsmInfoExistsForLine)
                        {
                        }
                        column(SalesLineInvDiscAmt; SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalsLinAmtExclLineDiscAmt; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATAmtLineVATAmtText3; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLineAmtExclLineDisc; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; VATDiscountAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(DiscountPercentCaption; DiscountPercentCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(PaymentDiscountVATCaption; PaymentDiscountVATCaptionLbl)
                        {
                        }
                        column(Desc_SalesLineCaption; DataItem2844.FIELDCAPTION(Description))
                        {
                        }
                        column(No2_SalesLineCaption; DataItem2844.FIELDCAPTION("No."))
                        {
                        }
                        column(Qty_SalesLineCaption; DataItem2844.FIELDCAPTION(Quantity))
                        {
                        }
                        column(UOM_SalesLineCaption; DataItem2844.FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATIdentifier_SalesLineCaption; DataItem2844.FIELDCAPTION("VAT Identifier"))
                        {
                        }
                        column(AmountIncludingPDV; DataItem2844."Amount Including VAT")
                        {
                        }
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText2; DimText)
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

                                DimSetEntry2.SETRANGE("Dimension Set ID", DataItem2844."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(AsmLineType; AsmLine.Type)
                            {
                            }
                            column(AsmLineNo; BlanksForIndent + AsmLine."No.")
                            {
                            }
                            column(AsmLineDescription; BlanksForIndent + AsmLine.Description)
                            {
                            }
                            column(AsmLineQuantity; AsmLine.Quantity)
                            {
                            }
                            column(AsmLineUOMText; GetUnitOfMeasureDescr(AsmLine."Unit of Measure Code"))
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN
                                    AsmLine.FINDSET
                                ELSE
                                    AsmLine.NEXT;
                            end;

                            trigger OnPreDataItem()
                            begin
                                IF NOT DisplayAssemblyInformation THEN
                                    CurrReport.BREAK;
                                IF NOT AsmInfoExistsForLine THEN
                                    CurrReport.BREAK;
                                AsmLine.SETRANGE("Document Type", AsmHeader."Document Type");
                                AsmLine.SETRANGE("Document No.", AsmHeader."No.");
                                SETRANGE(Number, 1, AsmLine.COUNT);
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN
                                SalesLine.FIND('-')
                            ELSE
                                SalesLine.NEXT;
                            DataItem2844 := SalesLine;


                            Cijena := DataItem2844."Unit Price" * DataItem2844.Quantity;
                            IF DisplayAssemblyInformation THEN
                                AsmInfoExistsForLine := SalesLine.AsmToOrderExists(AsmHeader);

                            IF NOT DataItem6640."Prices Including VAT" AND
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            THEN
                                SalesLine."Line Amount" := 0;

                            IF (SalesLine.Type = SalesLine.Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                                DataItem2844."No." := '';

                            NNCSalesLineLineAmt += SalesLine."Line Amount";
                            NNCSalesLineInvDiscAmt += SalesLine."Inv. Discount Amount";

                            NNCTotalLCY := NNCSalesLineLineAmt - NNCSalesLineInvDiscAmt;

                            NNCTotalExclVAT := NNCTotalLCY;
                            NNCVATAmt := VATAmount;
                            NNCTotalInclVAT := NNCTotalLCY - NNCVATAmt;

                            NNCPmtDiscOnVAT := -VATDiscountAmount;

                            NNCTotalInclVAT2 := TotalAmountInclVAT;

                            NNCVATAmt2 := VATAmount;
                            NNCTotalExclVAT2 := VATBaseAmount;
                            if DataItem2844.Type <> DataItem2844.Type::" " then begin
                                Ordinal += 1;
                                EmptyRow := false;
                            end
                            else begin
                                EmptyRow := true;
                            end;

                            vatn := SalesLine."VAT %";
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DELETEALL;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines AND (SalesLine.Description = '') AND (SalesLine."Description 2" = '') AND
                                  (SalesLine."No." = '') AND (SalesLine.Quantity = 0) AND
                                  (SalesLine.Amount = 0)
                            DO
                                MoreLines := SalesLine.NEXT(-1) <> 0;
                            IF NOT MoreLines THEN
                                CurrReport.BREAK;
                            SalesLine.SETRANGE("Line No.", 0, SalesLine."Line No.");
                            SETRANGE(Number, 1, SalesLine.COUNT);
                            CurrReport.CREATETOTALS(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VATAmountLineVATBase; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercentage; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(VATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF VATAmount = 0 THEN
                                CurrReport.BREAK;
                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
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
                        column(VATAmtLineVATPercentage2; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmtLineVATIdentifier2; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                DataItem6640."Posting Date", DataItem6640."Currency Code", DataItem6640."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                DataItem6640."Posting Date", DataItem6640."Currency Code", DataItem6640."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               (DataItem6640."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0)
                            THEN
                                CurrReport.BREAK;

                            SETRANGE(Number, 1, VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY, VALVATAmountLCY);

                            IF GLSetup."LCY Code" = '' THEN
                                VALSpecLCYHeader := Text007 + Text008
                            ELSE
                                VALSpecLCYHeader := Text007 + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency(DataItem6640."Posting Date", DataItem6640."Currency Code", 1);
                            VALExchRate := STRSUBSTNO(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(SelltoCustNo_SalesHeader; DataItem6640."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; DataItem6640.FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT ShowShippingAddr THEN
                                CurrReport.BREAK;
                        end;
                    }
                    dataitem(PrepmtLoop; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = FILTER(1 ..));
                        column(PrepmtLineAmount; PrepmtLineAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvBufDesc; PrepmtInvBuf.Description)
                        {
                        }
                        column(PrepmtInvBufGLAccNo; PrepmtInvBuf."G/L Account No.")
                        {
                        }
                        column(TotalExclVATText2; TotalExclVATText)
                        {
                        }
                        column(PrepmtVATAmtLineVATAmtTxt; PrepmtVATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText2; TotalInclVATText)
                        {
                        }
                        column(PrepmtInvAmount; PrepmtInvBuf.Amount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmount; PrepmtVATAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtInvAmtInclVATAmt; PrepmtInvBuf.Amount + PrepmtVATAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText2; VATAmountLine.VATAmountText)
                        {
                        }
                        column(PrepmtTotalAmountInclVAT; PrepmtTotalAmountInclVAT)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATBaseAmount; PrepmtVATBaseAmount)
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtLoopNumber; Number)
                        {
                        }
                        column(DescriptionCaption; DescriptionCaptionLbl)
                        {
                        }
                        column(GLAccountNoCaption; GLAccountNoCaptionLbl)
                        {
                        }
                        column(PrepaymentSpecCaption; PrepaymentSpecCaptionLbl)
                        {
                        }
                        dataitem(PrepmtDimLoop; Integer)
                        {
                            DataItemTableView = SORTING(Number)
                                                WHERE(Number = FILTER(1 ..));
                            column(DimText3; DimText)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF Number = 1 THEN BEGIN
                                    IF NOT TempPrepmtDimSetEntry.FIND('-') THEN
                                        CurrReport.BREAK;
                                END ELSE
                                    IF NOT Continue THEN
                                        CurrReport.BREAK;

                                CLEAR(DimText);
                                Continue := FALSE;
                                REPEAT
                                    OldDimText := DimText;
                                    IF DimText = '' THEN
                                        DimText :=
                                          STRSUBSTNO('%1 %2', TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code")
                                    ELSE
                                        DimText :=
                                          STRSUBSTNO(
                                            '%1, %2 %3', DimText,
                                            TempPrepmtDimSetEntry."Dimension Code", TempPrepmtDimSetEntry."Dimension Value Code");
                                    IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
                                        DimText := OldDimText;
                                        Continue := TRUE;
                                        EXIT;
                                    END;
                                UNTIL TempPrepmtDimSetEntry.NEXT = 0;
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            IF Number = 1 THEN BEGIN
                                IF NOT PrepmtInvBuf.FIND('-') THEN
                                    CurrReport.BREAK;
                            END ELSE
                                IF PrepmtInvBuf.NEXT = 0 THEN
                                    CurrReport.BREAK;

                            IF ShowInternalInfo THEN
                                DimMgt.GetDimensionSet(TempPrepmtDimSetEntry, PrepmtInvBuf."Dimension Set ID");

                            IF DataItem6640."Prices Including VAT" THEN
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            ELSE
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CREATETOTALS(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; Integer)
                    {
                        DataItemTableView = SORTING(Number);
                        column(PrepmtVATAmtLineVATAmt; PrepmtVATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATBase; PrepmtVATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineLineAmt; PrepmtVATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = DataItem6640."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PrepmtVATAmtLineVATPerc; PrepmtVATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(PrepmtVATAmtLineVATIdent; PrepmtVATAmountLine."VAT Identifier")
                        {
                        }
                        column(PrepmtVATCounterNumber; Number)
                        {
                        }
                        column(PrepaymentVATAmtSpecCap; PrepaymentVATAmtSpecCapLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SETRANGE(Number, 1, PrepmtVATAmountLine.COUNT);
                        end;
                    }
                    dataitem(PrepmtTotal; Integer)
                    {
                        DataItemTableView = SORTING(Number)
                                            WHERE(Number = CONST(1));
                        column(PrepmtPmtTermsDesc; PrepmtPaymentTerms.Description)
                        {
                        }
                        column(PrepmtPmtTermsDescCaption; PrepmtPmtTermsDescCaptionLbl)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT PrepmtInvBuf.FIND('-') THEN
                                CurrReport.BREAK;
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtSalesLine: Record "Sales Line" temporary;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line" temporary;
                begin
                    CLEAR(SalesLine);
                    CLEAR(SalesPost);
                    VATAmountLine.DELETEALL;
                    SalesLine.DELETEALL;
                    SalesPost.GetSalesLines(DataItem6640, SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, DataItem6640, SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, DataItem6640, SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(DataItem6640."Currency Code", DataItem6640."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DELETEALL;
                    SalesPostPrepmt.GetSalesLines(DataItem6640, 0, PrepmtSalesLine);

                    IF NOT PrepmtSalesLine.ISEMPTY THEN BEGIN
                        SalesPostPrepmt.GetSalesLinesToDeduct(DataItem6640, TempSalesLine);
                        IF NOT TempSalesLine.ISEMPTY THEN
                            SalesPostPrepmt.CalcVATAmountLines(DataItem6640, TempSalesLine, PrepmtVATAmountLineDeduct, 1);
                    END;
                    SalesPostPrepmt.CalcVATAmountLines(DataItem6640, PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    IF PrepmtVATAmountLine.FINDSET THEN
                        REPEAT
                            PrepmtVATAmountLineDeduct := PrepmtVATAmountLine;
                            IF PrepmtVATAmountLineDeduct.FIND THEN BEGIN
                                PrepmtVATAmountLine."VAT Base" := PrepmtVATAmountLine."VAT Base" - PrepmtVATAmountLineDeduct."VAT Base";
                                PrepmtVATAmountLine."VAT Amount" := PrepmtVATAmountLine."VAT Amount" - PrepmtVATAmountLineDeduct."VAT Amount";
                                PrepmtVATAmountLine."Amount Including VAT" := PrepmtVATAmountLine."Amount Including VAT" -
                                  PrepmtVATAmountLineDeduct."Amount Including VAT";
                                PrepmtVATAmountLine."Line Amount" := PrepmtVATAmountLine."Line Amount" - PrepmtVATAmountLineDeduct."Line Amount";
                                PrepmtVATAmountLine."Inv. Disc. Base Amount" := PrepmtVATAmountLine."Inv. Disc. Base Amount" -
                                  PrepmtVATAmountLineDeduct."Inv. Disc. Base Amount";
                                PrepmtVATAmountLine."Invoice Discount Amount" := PrepmtVATAmountLine."Invoice Discount Amount" -
                                  PrepmtVATAmountLineDeduct."Invoice Discount Amount";
                                PrepmtVATAmountLine."Calculated VAT Amount" := PrepmtVATAmountLine."Calculated VAT Amount" -
                                  PrepmtVATAmountLineDeduct."Calculated VAT Amount";
                                PrepmtVATAmountLine.MODIFY;
                            END;
                        UNTIL PrepmtVATAmountLine.NEXT = 0;

                    SalesPostPrepmt.UpdateVATOnLines(DataItem6640, PrepmtSalesLine, PrepmtVATAmountLine, 0);
                    //ĐK SalesPostPrepmt.BuildInvLineBuffer2(DataItem6640, PrepmtSalesLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    IF Number > 1 THEN BEGIN
                        CopyText := Text003;
                        OutputNo += 1;
                    END;
                    CurrReport.PAGENO := 1;

                    NNCTotalLCY := 0;
                    NNCTotalExclVAT := 0;
                    NNCVATAmt := 0;
                    NNCTotalInclVAT := 0;
                    NNCPmtDiscOnVAT := 0;
                    NNCTotalInclVAT2 := 0;
                    NNCVATAmt2 := 0;
                    NNCTotalExclVAT2 := 0;
                    NNCSalesLineLineAmt := 0;
                    NNCSalesLineInvDiscAmt := 0;
                end;

                trigger OnPostDataItem()
                begin
                    IF Print THEN
                        SalesCountPrinted.RUN(DataItem6640);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                    TotalLineDiscountAndAmount := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInfo.GET;

                Cust.SETFILTER("No.", "Sell-to Customer No.");
                IF Cust.FIND('-') THEN BEGIN
                    CustVatNo := Cust."VAT Registration No.";
                    CustRegNo := Cust."Registration No.";
                END;

                Euro := DataItem6640."Amount Including VAT";

                CurrExchRate.Reset();
                CurrExchRate.SetFilter("Currency Code", '%1', DataItem6640."Currency Code");
                CurrExchRate.SetCurrentKey("Starting Date");
                CurrExchRate.Ascending;
                if CurrExchRate.FindLast() then begin
                    Euro := Euro * CurrExchRate."Relational Exch. Rate Amount";
                    Euro := Round(Euro, 0.01, '>');
                end;

                Note1 := ReplaceString(DataItem6640."Note 1", '@VrijednostIznosa', format(Euro, 0, '<Integer Thousand><Decimals,3>'));
                Note1 := ReplaceString(DataItem6640."Note 1", '@DatumIzdavanjaFakture', format(DataItem6640."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'));

                CompanyInfo1.CALCFIELDS(Picture);
                CurrReport.LANGUAGE := GetLanguage.GetLanguageID("Language Code");

                CASE "Document Type" OF
                    "Document Type"::Order:
                        BEGIN
                            naslov := OrderNoCaptionLbl;
                            br := InvNo2;
                            q := "Quote No.";
                            vrijedido := Exp;
                            datum := "Due Date 2";
                            br2 := OrderNo;
                            DateAndPlace := IssueCapt;
                            CustomerCapt := CustomerCaption2;
                            CustomerCaption := CustNo;
                        END;
                    "Document Type"::Quote:
                        BEGIN
                            naslov := Quote;
                            vrijedido := Valid;
                            datum := "Due Date";
                            br := OrderNo;
                            DateAndPlace := Date;
                            CustomerCapt := Client;
                            CustomerCaption := ClientNo;

                        END;


                    "Document Type"::Invoice:
                        BEGIN
                            naslov := OrderNoCaptionLbl;
                            br := InvNo2;
                            q := "Quote No.";
                            vrijedido := Exp;
                            datum := "Due Date 2";
                            br2 := OrderNo;
                            DateAndPlace := IssueCapt;
                            CustomerCapt := CustomerCaption2;
                            CustomerCaption := CustNo;
                        END;

                END;

              

                IF RespCenter.GET("Responsibility Center") THEN BEGIN
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                END ELSE
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");

                IF "Salesperson Code" = '' THEN BEGIN
                    CLEAR(SalesPurchPerson);
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
                FormatAddr.SalesHeaderBillTo(CustAddr, DataItem6640);

                IF "Payment Terms Code" = '' THEN
                    PaymentTerms.INIT
                ELSE BEGIN
                    PaymentTerms.GET("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Prepmt. Payment Terms Code" = '' THEN
                    PrepmtPaymentTerms.INIT
                ELSE BEGIN
                    PrepmtPaymentTerms.GET("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                END;

                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, DataItem6640);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                FOR i := 1 TO ARRAYLEN(ShipToAddr) DO
                    IF ShipToAddr[i] <> CustAddr[i] THEN
                        ShowShippingAddr := TRUE;

                IF Print THEN BEGIN
                    IF ArchiveDocument THEN
                        ArchiveManagement.StoreSalesDocument(DataItem6640, LogInteraction);

                    IF LogInteraction THEN BEGIN
                        CALCFIELDS("No. of Archived Versions");
                        IF "Bill-to Contact No." <> '' THEN
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No."
                              , "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        ELSE
                            SegManagement.LogDocument(
                              3, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    END;
                END;

                //SP01 start
                SalesHeaderTemp.SETFILTER("No.", '%1', "No.");
                IF SalesHeaderTemp.FINDFIRST THEN
                    BankAccountTemp.SETFILTER("No.", '%1', SalesHeaderTemp."Bank No.");
                IF BankAccountTemp.FINDFIRST THEN
                    PaymentBankName := BankAccountTemp.Name;
                PaymentInfoGiroNo := BankAccountTemp."Bank Account No.";
                PaymentIBAN := BankAccountTemp.IBAN;
                PaymentSWIFT := BankAccountTemp."SWIFT Code";
                //SP01 end

               
                CurrenyCodeText := GLSetup."LCY Code";
                LTxtTotalAmount := STRSUBSTNO(Text50004, CurrenyCodeText);

            end;

            trigger OnPreDataItem()
            begin
                Print := Print OR NOT CurrReport.PREVIEW;
                AsmInfoExistsForLine := FALSE;
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
            ArchiveDocument := SalesSetup."Archive Quotes and Orders";
            LogInteraction := SegManagement.FindInteractTmplCode(3) <> '';

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
        PaymentIBAN := '';
        PaymentSWIFT := '';
        PaymentBankName := '';
        PaymentInfoGiroNo := '';
    end;

    var
        Text000: Label 'Salesperson';
        GetLanguage: Codeunit Language;

        Cijena: Decimal;
        EmptyRow: Boolean;
        Text001: Label 'Total %1';
        Text50004: Label 'Amount Excl. Disc. (%1)';
        Text002: Label 'Total %1 Incl. VAT';
        Text003: Label 'COPY';
        Text004: Label 'Order Confirmation %1';
        PageCaptionCap: Label 'Page %1 of %2';
        Text006: Label 'Total %1 Excl. VAT';
        PaymentInfoGiroNo: Code[20];
        PaymentBankName: Text[50];
        PaymentSWIFT: Text[20];
        PaymentIBAN: Text[20];
        Cust: Record Customer;
        vatn: Decimal;
        CustomerCapt: Text[100];
        CustomerCaption: Text[100];
        ExpireCapt: Text[100];
        DateAndPlace: Text[100];
        Period: Text[250];
        delterms: Record "Travel Line";
        SumaLine: Decimal;
        Razlika: Decimal;
        OnesText: array[20] of Text[30];
        RefreshMessageText: Text;
        ExponentText: array[5] of Text[30];
        SumaTotal: Decimal;
        TensText: array[10] of Text[30];
        TotalLineDiscountAndAmount: Decimal;
        q: Code[30];
        TotalAmountStyle: Text;
        InvDiscAmountEditable: Boolean;
        DocumentTotals: Codeunit "Document Totals";
        br2: Text[50];
        VATAmount3: Decimal;
        ShowCountryofOrigin: Boolean;
        RefreshMessageEnabled: Boolean;
        LTxtTotalAmount: Text;
        VATDesc: Text;
        VATPost: Record "VAT Product Posting Group";
        ShowNote1: Boolean;
        ShowNote2: Boolean;
        ShowNote3: Boolean;
        br: Text[20];
        vrijedido: Text;
        datum: Date;
        CurrenyCodeText: Text;
        naslov: Text[50];
        CustRegNo: Code[20];
        SalesPersona: Code[20];
        CustVatNo: Code[20];
        Ordinal: Integer;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLineDeduct: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        TempPrepmtDimSetEntry: Record "Dimension Set Entry" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Record "Language";
        CurrExchRate: Record "Currency Exchange Rate";
        AsmHeader: Record "Assembly Header";
        AsmLine: Record "Assembly Line";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit "SegManagement";
        ArchiveManagement: Codeunit "ArchiveManagement";
        SalesPostPrepmt: Codeunit "Sales-Post Prepayments";
        DimMgt: Codeunit "DimensionManagement";
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
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
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        Text007: Label 'VAT Amount Specification in ';
        Text008: Label 'Local Currency';
        Text009: Label 'Exchange rate: %1/%2';
        VALExchRate: Text[50];
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        NNCTotalLCY: Decimal;
        NNCTotalExclVAT: Decimal;
        NNCVATAmt: Decimal;
        NNCTotalInclVAT: Decimal;
        NNCPmtDiscOnVAT: Decimal;
        NNCTotalInclVAT2: Decimal;
        NNCVATAmt2: Decimal;
        NNCTotalExclVAT2: Decimal;
        NNCSalesLineLineAmt: Decimal;
        NNCSalesLineInvDiscAmt: Decimal;
        Euro: Decimal;
        Print: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        DisplayAssemblyInformation: Boolean;
        AsmInfoExistsForLine: Boolean;
        InvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        VATRegNoCaptionLbl: Label 'VAT Registration No.';
        GiroNoCaptionLbl: Label 'Giro No.';
        BankCaptionLbl: Label 'Bank';
        AccountNoCaptionLbl: Label 'Account No.';
        ShipmentDateCaptionLbl: Label 'Shipment Date';
        OrderNoCaptionLbl: Label 'Invoice';
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
        ItemNameCapt: Label 'Description';
        QuantityCapt: Label 'Qty';
        UMCapt: Label 'Unit of measure';
        UnitPriceCapt: Label 'Unit price';
        DiscountCapt: Label 'Discount %';
        AmountCapt: Label 'Amount';
        TotalCapt: Label 'Total Amount';
        TotalExclVAT: Label 'Total Excl. VAT';
        TotalInclVAT: Label 'Total Incl. VAT';
        PDV: Label 'VAT ';
        SalesTerms: Label 'Terms of Sale';
        OtherComments: Label 'and other comments';
        Note: Label 'Delivery time becomes valid after the agreed payment terms are met and when BOM is arrived at the factory.';
        Note2: Label 'Upon issuance of the invoice in foreign currencies, middle currency exchange rate of Central Bank of Bosnia and Herzegovina as of the invoice date will be applied.';
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
        ShipDate: Label 'Shipment date:';
        Pack: Label 'Total package';
        PaymentTermsCapt: Label 'Payment Terms';
        CountryCapt: Label 'Country of origin';
        DueDate: Label 'Shipment due';
        InvNo2: Label 'P. Invoice No';
        FInvNo: Label 'Fiscal invoice No.';
        OrderNo: Label 'Quotation No.';
        ShiomentMethod: Record "Shipment Method";
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
        Note1: Text[2000];
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
        PaymentInstr: Label 'Payment instructions';
        DueDate2: Label 'Due Date';
        BankAccountTemp: Record "Bank Account";
        SalesHeaderTemp: Record "Sales Header";

    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
        DisplayAssemblyInformation := DisplayAsmInfo;
    end;

    procedure GetUnitOfMeasureDescr(UOMCode: Code[10]): Text[10]
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

    procedure FormatNoText(var NoText: array[2] of Text; No: Decimal; CurrencyCode: Code[10])
    var
        NoTextIndex: Integer;
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
    begin
        //NK start
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                Ones := No DIV POWER(1000, Exponent - 1);
                Hundreds := Ones DIV 100;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Ones > 0 THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);

                IF (Tens >= 2) THEN BEGIN
                    IF (Ones <> 0) THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028 + ' ' + TensText[Tens])
                    ELSE
                        AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                END ELSE
                    IF ((Tens * 10 + Ones) > 0) AND (Tens <> 0) THEN
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100) + '/100');

        IF CurrencyCode <> '' THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; PrintExponent: Boolean; AddText: Text[30])
    begin

        //NK start
        PrintExponent := TRUE;

        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN
                ERROR(Text029, AddText);
        END;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
        //NK end
    end;

    procedure ReplaceString(var String: Text; FindWhat: Text; ReplaceWIth: Text) NewString: Text

    begin
        while StrPos(String, FindWhat) > 0 do
            String := DelStr(String, StrPos(String, FindWhat)) + ReplaceWIth + CopyStr(String, StrPos(String, FindWhat) + StrLen(FindWhat));
        NewString := String;

    end;



    procedure InitTextVariable()
    begin
       
        //NK02 end


    end;
}
*/
