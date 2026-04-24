report 50131 "Tax Invoice"
{
    // BH1.00, Fiscal Process
    // BH1.01, Invoice elements
    DefaultLayout = RDLC;
    RDLCLayout = './Sales - Invoice - Albin - Backup.rdl';

    Caption = 'Tax - Invoice';
    Permissions = TableData 7190 = rimd;
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(DataItem5581; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(OrderNo_SalesInvoiceHeader; "No.")
            {
            }
            column(CountryofOrigin_SalesInvoiceHeader; "Country of Origin")
            {
            }
            column(DiscountCapt2; DiscountCapt2)
            {
            }
            column(Note1_SalesInvoiceHeader; "Note 1")
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
            column(BillingSIgnatory; CompanyInfo."Billing Signatory") { }
            column(caption; caption)
            {
            }
            column(sd; SaldoText) { }
            column(SignaturePicture; SalesSetup.Picture) { }

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
            column(DatumRacuna; "Order Date")
            {
            }
            column(CalculationPeriodStartDate; FORMAT(GetStartingDayOfMonth("Shipment Date"), 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(CalculationPeriodEndDate; FORMAT(GetLastDayOfMonth("Shipment Date"), 0, '<Day,2>.<Month,2>.<Year4>.'))
            {
            }
            column(CustomerIDNumber; Customer."Registration No.") { }
            column(CustomerVATRegistrationNumber; GetCustomerVATRegistrationNumber) { }
            column(VATNo; Customer."VAT Registration No.")
            {
            }
            column(comp_djelatnost; CompanyInfo."Industrial Classification") { }
            column(comp_MBS; CompanyInfo.MBS) { }

            column(BillingSignatoryName; BillingSignatoryName) { }
            column(BillingSignatoryPos; BillingSignatoryPos) { }


            column(CustomerStroke; Customer."Customer Stroke") { }
            column(CustomerContract; CustomerContract) { }
            column(CustomerCode; Customer."No.") { }
            column(Contract; Contract) { }
            column(LowerContractDate; FORMAT(lowerContractDate, 0, '<Day,2>.<Month,2>.<Year4>.')) { }
            column(CustPhone;
            Customer."Phone No.")
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
            column(Deadline; CalculateDateDistance("Shipment Date", "Due Date")) { }
            column(FORMAT_ShipmentDate; FORMAT("Shipment Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
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
            column(IBAN; CompanyInfo.IBAN)
            {
            }
            column(PhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(PhoneNo2; CompanyInfo."Contact Phone")
            {
            }
            column(DispatchCenter; CompanyInfo."Dispatch Center") { }
            column(FaxNo; CompanyInfo."Fax No.")
            {
            }

            column(Name2; CompanyInfo."Name 2")
            {
            }
            column(EMail; CompanyInfo."E-Mail")
            {
            }
            column(VATRegNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(SigPosText; SigPosText) { }
            column(SigName; SigName) { }
            column(RespPerson; ResponsiblePerson) { }
            column(RespPosition; ResponsiblePersonPosition) { }
            column(LS; LowerPartSubvention) { }
            column(LowerSubvention; LowerSubvention) { }
            column(LowerQuantity; LowerQuantity) { }
            column(BalanceBeforeInvoice; GJBalance) { }
            column(LowerTotal; LowerPartSubvention * QuantityNote) { }
            column(LowerVAT; SubTest * 17 / 100) { }
            column(LowerBase; SubTest - (SubTest * 17 / 100)) { }
            column(TotalWithoutVAT; TotalWithoutVAT) { }
            column(TotalVAT; TotalWithVAT - TotalWithoutVAT) { }

            column(SlovimaText; SlovimaText) { }
            column(TotalWithVAT; TotalWithVAT) { }
            column(EndAmount; (TotalWithoutVAT * 1.17) - SubTest + GJBalance) { }
            column(SubventionText; 'Subvencija Vlade Kantona Sarajevo za ' + FORMAT(Date2DMY("Shipment Date", 2)) + ' ' + FORMAT(Date2DMY("Shipment Date", 3)) + '. godine') { }
            column(Counter; counter) { }
            column(Year; Date2DMY("Shipment Date", 3)) { }
            column(Month; Date2DMY("Shipment Date", 2)) { }
            column(MBS; CompanyInfo.MBS)
            {
            }
            column(FiscalInvoiceNumbers; FiscalInvoice) { }
            column(BankName; CompanyInfo."Bank Name")
            {
            }

            column(CountryComp; CountryComp)
            {
            }
            column(ContactName; Customer.Contact)
            {
            }
            column(VATBaseDiscount_SalesInvoiceHeader; "VAT Base Discount %")
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
            column(Pict; CompanyInfo.Picture1)
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
            column(typeOfInvoice; typeOfInvoice) { }
            column(Advance; advance) { }
            column(TotalAmountText; TotalAmountText) { }
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
            column(Note31; Note31)
            {
            }
            column(Note4; Note4)
            {
            }
            column(CZkPhoneNumber; CZkPhoneNumber) { }
            column(FaxNoCZK; FaxNoCZK) { }
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
            column(shOrAddress; shOrAddress) { }
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
            column(SellToCity; "Sell-to Post Code" + ', ' + "Sell-to City")
            {
            }
            column(SubTest; SubTest) { }
            column(Stroke; CompanyInfo.City + ' OH: ' + FORMAT(Customer."Customer Stroke")) { }
            column(InvoiceOnlyFlag; InvoiceOnlyFlag)
            {
            }
            column(CustVatNo; CustVatNo)
            {
            }
            column(ShipToName; "Ship-to Name")
            {
            }
            column(ShipToAdress; "Ship-to Address 2" + ', ' + "Ship-to City")
            {
            }
            column(ShipToCity; "Ship-to Post Code")
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
            column(transaction4; transaction4)
            {

            }

            column(transaction4Name; transaction4Name)
            {

            }

            column(transaction1Name; transaction1Name)
            {

            }

            column(transaction2Name; transaction2Name)
            {

            }

            column(transaction3Name; transaction3Name)
            {

            }
            column(transaction5Name; transaction5Name)
            {

            }
            column(transaction5; transaction5)
            {

            }

            column(transaction2; transaction2)
            {

            }
            column(transaction1; transaction1)
            {

            }

            column(transaction3; transaction3)
            {

            }

            column(CompanyInfoVATRegtnNo; CompanyInfo."VAT Registration No.")
            {
            }
            column(TypeVehnicle; TypeVehnicleText)
            {

            }

            column(transaction6Name; transaction6Name)
            {

            }
            column(transaction6; transaction6)
            {

            }
            column(transaction7Name; transaction7Name)
            {

            }

            column(transaction7; transaction7)
            {

            }


            column(transaction8; transaction8)
            {

            }
            column(transaction8Name; transaction8name)
            {

            }
            column(transaction9Name; transaction9name)
            {

            }

            column(transaction9; transaction9)
            {

            }

            column(transaction10; transaction10)
            {

            }
            column(transaction10Name; transaction10name)
            {

            }



            column(NameCenter; CompanyInfo."Name")
            {

            }

            column(RegistrationCompany; CompanyInfo."Registration No.")
            {

            }

            column(MuniciplityCompany; CompanyInfo."Municipality Name")
            {

            }
            column(TaxNo; CompanyInfo."Tax No.")
            {

            }

            column(IndustrialClasification; companyinfo."Industrial Classification")
            {

            }
            column(RegistrationText; CompanyInfo."Registration Text")
            {

            }
            column(Companyemail; CompanyInfo."E-Mail")
            {

            }

            column(Companyweb; CompanyInfo."Home Page")
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
                    column(CompanyInfo2Picture; CompanyInfo2.Picture1)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture1)
                    {
                    }
                    column(CompanyInfoPicture; CompanyInfo.Picture1)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture1)
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
                    column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
                    {
                    }
                    column(CompanyInfoBankName; CompanyInfo."Bank Name")
                    {
                    }
                    column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; DataItem5581."Bill-to Customer No.")
                    {
                    }
                    column(PostingDate_SalesInvHdr; FORMAT(DataItem5581."Posting Date", 0, '<Day,2>.<Month,2>.<Year4>.'))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(VATRegNo_SalesInvHdr; DataItem5581."VAT Registration No.")
                    {
                    }
                    column(DueDate_SalesInvHdr; FORMAT(DataItem5581."Due Date"))
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
                    column(DocDate_SalesInvHdr; FORMAT(DataItem5581."Document Date", 0, 4))
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; DataItem5581."Prices Including VAT")
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PricesInclVATYesNo_SalesInvHdr; FORMAT(DataItem5581."Prices Including VAT"))
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
                    column(ShipmentDate; FORMAT(DataItem5581."Shipment Date"))
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
                            Commm := DataItem1000000179.Comment;

                        end;

                        trigger OnPreDataItem()

                        begin
                            SETFILTER("No.", '%1', DataItem5581."No.");
                            CompanyInfo.GET;
                            CompanyInfo.CALCFIELDS(Picture1, "Billing Signatory");
                            CompanyInfo1.GET;
                            CompanyInfo1.CALCFIELDS(Picture1, "Billing Signatory");
                            CompanyInfo2.GET;
                            CompanyInfo2.CALCFIELDS(Picture1, "Billing Signatory");
                            CompanyInfo3.GET;
                            CompanyInfo3.CALCFIELDS(Picture1, "Billing Signatory");
                        end;
                    }
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = DataItem5581;
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
                        DataItemLinkReference = DataItem5581;
                        DataItemTableView = SORTING("Document No.", "Line No.");


                        column(LineAmt_SalesInvLine;
                        GetGroupedPrice("Document No.", "No."))
                        {
                            AutoFormatExpression = GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; createCNGDescription(Type, "No.", DataItem1570."Shipment Date"))
                        {
                        }
                        column(No_SalesInvLine; "No.")
                        {
                        }
                        column(Caption_No; FIELDCAPTION("No."))
                        {
                        }
                        column(PrecVAT; DataItem1570."VAT %")
                        {
                        }
                        column(Qty_SalesInvLine; GetGroupedQuantity("Document No.", "No."))
                        {
                        }
                        column(VATPercentageCaptionLbl; VATPercentageCaptionLbl)
                        {
                        }
                        column(VAT_SalesInvoiceLine; DataItem1570."VAT %")
                        {
                        }
                        column(UOM_SalesInvLine; "Unit of Measure Code")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Unit Price")
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
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount; TotalInvDiscAmount)
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
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
                            AutoFormatExpression = DataItem5581."Currency Code";
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
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmtAfterInvDiscAmt; -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT"))
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
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
                        column(LDA; DataItem1570."Line Discount Amount")
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


                        dataitem("Sales Shipment Buffer";
                        Integer)
                        {
                            DataItemTableView = SORTING(Number);
                            column(SalesShptBufferPostDate;
                            FORMAT(SalesShipmentBuffer."Posting Date"))
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
                                SalesShipmentBuffer.SETRANGE("Document No.", DataItem1570."Document No.");
                                SalesShipmentBuffer.SETRANGE("Line No.", DataItem1570."Line No.");

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

                                DimSetEntry2.SETRANGE("Dimension Set ID", DataItem1570."Dimension Set ID");
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

                            /*IF (Type = Type::"G/L Account") AND (NOT ShowInternalInfo) THEN
                              "No." := '';*/
                            CalcSetup.GET;
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
                            Ordinal += 1;
                            //Subvention += Quantity * CalcSetup.Subsidies;
                            QuantityNote := Quantity;



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
                            AutoFormatExpression = DataItem1570.GetCurrencyCode;
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = DataItem5581."Currency Code";
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
                            QuantityNote += VATAmountLine."Quantity";

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
                            AutoFormatExpression = DataItem5581."Currency Code";
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
                            //           VATClause.TranslateDescription(DataItem5581."Language Code");
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
                    CalcSetup.GET;
                    LowerPartSubvention := CalcSetup.Subsidies;

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
            var
                saleLine: Record "Sales Invoice Line";
                saleLineChecker: Record "Sales Invoice Line";
                saleHeader: Record "Sales Invoice Header";
                sd: Date;
                ed: Date;
                ledgerEntry: Record "Customer Ledger Entry";
                CLEntry: Record "Cust. Ledger Entry";
                purchLine: Record "Purch. Inv. Line";
                test: Decimal;
                test2: Decimal;
                test3: Text[10000];
                year: Integer;
                banacc: Record "Bank account";
                Type: Enum "Sales Line Type";
                SLT: Enum "Sales Line Type";
                MyCU: Codeunit TestSubsCu;
                ECL: record "Employee COntract Ledger";
                US: Record "User Setup";

            begin

                CRL.Reset();
                CRL.SetFilter("Report ID", '%1', 50131);


                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.FindFirst() then begin


                    if US."Bill Type" = '08' then
                        crl.setfilter("Description", '%1', 'CNG - NN fizičko lice')
                    else
                        crl.setfilter("Description", '<>%1', 'CNG - NN fizičko lice')

                end;
                if crl.FindFirst() then begin
                    RLS.SetTempLayoutSelected(crl.Code);

                end;
                SigPosText := '';
                SigName := '';

                CompanyInfo.GET;
                CompanyInfo.CalcFields("Billing Signatory", "Billing Sign");

                SignatoryPos.reset;
                SignatoryPos.setfilter("No.", '%1', CompanyInfo."Billing Signatory Emp");

                if SignatoryPos.findfirst then begin

                    ECL.reset;
                    ECL.setfilter("Employee No.", '%1', SignatoryPos."No.");
                    ECL.setfilter("Active", '%1', true);
                    if ecl.findfirst then begin
                        SigPosText := ecl."Position Description";

                    end
                    else begin
                        SigPosText := '';
                    end;

                    SigName := SignatoryPos."First Name" + ' ' + SignatoryPos."Last Name";
                end;


                EmpBilling.Reset();
                EmpBilling.SetFilter("No.", '%1', CompanyInfo."Billing Signatory Emp");
                if EmpBilling.FindFirst() then
                    BillingSignatoryName := EmpBilling."First Name" + ' ' + EmpBilling."Last Name"
                else
                    BillingSignatoryName := '';


                ecl.SetFilter("Employee No.", '%1', CompanyInfo."Billing Signatory Emp");
                ecl.SetFilter("Starting Date", '<=%1', DataItem5581."Posting Date");
                ecl.SetCurrentKey("Starting Date");
                ecl.Ascending;
                if ecl.FindLast() then begin
                    BillingSignatoryPos := ecl."Position Description";

                end
                else begin
                    BillingSignatoryPos := '';
                end;



                /*

                        SigPosText: text;
                        SigName: text;*/

                CZkPhoneNumber := '';
                FaxNoCZK := '';
                UserM.reset;
                UserM.setfilter("User ID", '%1', USERID);
                if UserM.findfirst then begin
                    CZkPhone.reset;
                    CZkPhone.setfilter("No.", '%1', UserM.CZK);
                    if CZkPhone.findfirst then begin
                        CZkPhoneNumber := CZKPhone."Phone No.";
                        FaxNoCZK := CZKPhone."Fax No.";

                    end;
                end;

                //EK 
                IF DataItem5581."Prepayment" = true then begin

                    advance := 'avans';
                    TotalAmountText := 'Ukupan iznos sa PDV-om';
                    shOrAddress := 'ADRESA';
                    if (DataItem5581.Amount < 0) then
                        typeOfInvoice := 'Storno avansni račun broj'

                    else
                        typeOfInvoice := 'Avansni račun broj';

                end
                else begin
                    advance := '';
                    typeOfInvoice := 'Broj računa';
                    TotalAmountText := 'Ukupno zaduženje sa PDV-om';
                    shOrAddress := 'DOSTAVA';
                end;

                saleLine.Reset();
                saleLine.SETFILTER("Document No.", '%1', DataItem5581."No.");


                if saleLine.FindFirst() THEN
                    saleHeader.reset();
                sd := GetStartingDayOfMonth("Shipment Date");
                ed := GetLastDayOfMonth("Shipment Date");
                saleHeader.SETRANGE("Shipment Date", sd, ed);
                QuantityNote += saleLine."Quantity";

                purchLine.Reset();
                purchLine.SETFILTER("No.", saleLine."No.");
                saleLineChecker.reset();
                saleLineChecker.SETFILTER("Document No.", '%1', DataItem5581."No.");
                //           saleLineChecker.SetFilter("Fiscal No.", '<>%1', '');
                if saleLineChecker.findset() then
                    repeat begin
                        if saleLineChecker."New Fiscal No." <> '' then begin
                            FiscalInvoice := FiscalInvoice + ',' + saleLineChecker."New Fiscal No.";
                        end
                        else
                            if saleLineChecker."R. Fiscal No." <> '' then begin
                                FiscalInvoice := FiscalInvoice + ',' + saleLineChecker."R. Fiscal No.";
                            end
                            else
                                if saleLineChecker."Fiscal No." <> '' then begin
                                    FiscalInvoice := FiscalInvoice + ',' + saleLineChecker."Fiscal No.";
                                end;

                        IF saleLineChecker."Type of vehicle" = saleLineChecker."Type of vehicle"::"Cargo vehicles"
                        then
                            TypeVehnicleText := 'TERETNA VOZILA'

                        else
                            IF saleLineChecker."Type of vehicle" = saleLineChecker."Type of vehicle"::"Passenger vehicles"
                            then
                                TypeVehnicleText := 'PUTNIČKA VOZILA'
                            ELSE
                                TypeVehnicleText := '';

                    end;
                    until saleLineChecker.next = 0;
                if StrLen(FiscalInvoice) >= 2 then
                    FiscalInvoice := CopyStr(FiscalInvoice, 2, StrLen(FiscalInvoice));
                saleLineChecker.Reset();

                saleLineChecker.SETFILTER("Document No.", '%1', DataItem5581."No.");
                saleLineChecker.setfilter(Subsidies, '%1', true);
                //ĐK   saleLineChecker.SETFILTER("Type", '%1', saleLineChecker."Type"::Resource);
                if saleLineChecker.findFirst() then begin
                    saleLineChecker.CalcSums(Quantity);
                    SubTest := DataItem5581."Subsidies Amount";
                    if saleLineChecker.Quantity <> 0 then
                        LowerSubvention := DataItem5581."Subsidies Amount" / saleLineChecker.Quantity
                    else
                        LowerSubvention := 0;
                    LowerQuantity := saleLineChecker.Quantity;
                end
                else begin
                    SubTest := 0;
                    LowerSubvention := 0;
                    LowerQuantity := 0;
                end;
                saleLineChecker.Reset();
                saleLineChecker.SETFILTER("Document No.", '%1', DataItem5581."No.");

                if saleLineChecker.FindSet() then
                    repeat
                        if saleLineChecker."Type" <> saleLineChecker."Type"::Resource then begin
                            TotalWithoutVAT += saleLineChecker."Amount";
                        end;
                    until saleLineChecker.NEXT = 0;

                SlovimaText := MyCU.NumberToWordsBillingCNG(round(TotalWithoutVAT), TRUE);

                saleLineChecker.Reset();
                saleLineChecker.SETFILTER("Document No.", '%1', DataItem5581."No.");
                //     saleLineChecker.SETFILTER("Type", '%1', saleLineChecker."Type"::Item);
                if saleLineChecker.FindSet() then
                    repeat
                        if saleLineChecker."Type" <> saleLineChecker."Type"::Resource then
                            TotalWithVAT += saleLineChecker."Amount Including VAT";
                    until saleLineChecker.NEXT = 0;


                SlovimaText := MyCU.NumberToWordsBillingCNG(round(TotalWithVAT), TRUE);

                /* Djemina koment   counter := 0;
                    saleLineChecker.Reset();
                    saleLineChecker.SETFILTER("Document No.", '%1', DataItem5581."No.");
                    if saleLineChecker.FindSet() then
                        repeat
                            counter += counter + 1;
                        until saleLineChecker.NEXT = 0;*/

                //      LowerSubvention := DataItem5581."Subsidies Amount";
                ledgerEntry.Reset();
                ledgerEntry.SETFILTER("Customer No.", '%1', DataItem5581."Bill-to Customer No.");
                if ledgerEntry.FindFirst() THEN begin
                    Contract := ledgerEntry.Code;
                    lowerContractDate := ledgerEntry."Starting Date";
                    CustomerContract := ledgerEntry.Description;
                end;
                CLEntry.Reset();
                year := Date2DMY("Document Date", 3);
                CLEntry.Reset();
                CLEntry.setfilter("Posting Date", '<=%1', DataItem5581."Posting Date");
                CLEntry.SetRange("Customer No.", DataItem5581."Bill-to Customer No.");
                CLEntry.setfilter("Document No.", '<>%1', DataItem5581."No.");
                IF CLEntry.FindSet() then
                    repeat
                        CLEntry.calcfields("Amount (LCY)");
                        GJBalance := GJBalance + CLEntry."Amount (LCY)";
                    until CLEntry.Next = 0;

                Customer.GET("Bill-to Customer No.");

                SM.SETFILTER(Code, '%1', "Shipment Method Code");
                IF SM.FINDFIRST THEN
                    ShipmentMethod2 := SM.Description;
                PT.RESET;
                PT.SETFILTER(Code, '%1', "Payment Method Code");
                IF PT.FINDFIRST THEN
                    PaymentMethod := PT.Description;
                Refno := "Order No.";
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
                Cust.RESET;
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture1, "Billing Signatory");

                SalespersonTable.SETFILTER(Code, "Salesperson Code");
                IF SalespersonTable.FIND('-') THEN BEGIN
                    SalesPersona := SalespersonTable.Name;
                END;
                //END

                saleLine.Reset();
                Location.Reset();
                saleLine.SETFILTER("Document No.", '%1', DataItem5581."No.");

                if saleLine.FindFirst() THEN begin
                    Location.SETFILTER(Code, '%1', saleLine."Location Code");
                    if Location.FindFirst() then begin
                        ResponsiblePerson := Location."Invoice Responsible Person N";
                        ResponsiblePersonPosition := Location."Invoice Responsible Person Pos";
                    end
                    else begin
                        Location.SETFILTER(Code, '%1', 'CNG VLP');
                        if Location.FindFirst() then begin
                            ResponsiblePerson := Location."Invoice Responsible Person N";
                            ResponsiblePersonPosition := Location."Invoice Responsible Person Pos";
                        end;
                    end


                end;

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
                    //     PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                END;
                IF "Shipment Method Code" = '' THEN
                    ShipmentMethod.INIT
                ELSE BEGIN
                    ShipmentMethod.GET("Shipment Method Code");
                    //           ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
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
                //bankacc
                CompanyInfo.GET;
                CompanyInfo.CalcFields("Billing Signatory", "Billing Sign");
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 1");
                if banacc.FindFirst() then begin

                    transaction1 := banacc."Bank Account No.";
                    transaction1Name := banacc.Name;
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 2");
                if banacc.FindFirst() then begin
                    transaction2name := banacc.Name;
                    transaction2 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 3");
                if banacc.FindFirst() then begin
                    transaction3Name := banacc.Name;
                    transaction3 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 4");
                if banacc.FindFirst() then begin
                    transaction4Name := banacc.Name;
                    transaction4 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 5");
                if banacc.FindFirst() then begin

                    transaction5Name := banacc.Name;
                    transaction5 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 6");
                if banacc.FindFirst() then begin

                    transaction6Name := banacc.Name;
                    transaction6 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 7");
                if banacc.FindFirst() then begin

                    transaction7Name := banacc.Name;
                    transaction7 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 8");
                if banacc.FindFirst() then begin

                    transaction8Name := banacc.Name;
                    transaction8 := banacc."Bank Account No.";
                end;


                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 9");
                if banacc.FindFirst() then begin

                    transaction9Name := banacc.Name;
                    transaction9 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompanyInfo."Bank No. 10");
                if banacc.FindFirst() then begin

                    transaction10Name := banacc.Name;
                    transaction10 := banacc."Bank Account No.";
                end;



            end;

            trigger OnPreDataItem()
            begin

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
                    field(Saldo; Saldo)
                    {
                        Caption = 'Choose Balance View:';
                        OptionCaption = 'Sa saldom, Bez salda';
                    }
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

                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        var
            CRL: Record "Custom Report Layout";
            RLS: record "Report Layout Selection";
            US: Record "User Setup";
        begin
            LogInteractionEnable := TRUE;

            CRL.Reset();
            CRL.SetFilter("Report ID", '%1', 50131);

            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            if US.FindFirst() then begin
                crl.setfilter("Description", '%1', 'CNG - NN fizičko lice');
            end
            else begin
                crl.setfilter("Description", '<>%1', 'CNG - NN fizičko lice');
            end;
            if crl.FindFirst() then begin
                RLS.SetTempLayoutSelected(crl.Code);

            end;

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
        CompanyInfo.CalcFields(Picture1, "Billing Signatory");
        SalesSetup.GET;
        CASE SalesSetup."Logo Position on Documents" OF
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                BEGIN
                    CompanyInfo3.GET;
                    CompanyInfo3.CALCFIELDS(Picture1);
                END;
            SalesSetup."Logo Position on Documents"::Center:
                BEGIN
                    CompanyInfo1.GET;
                    CompanyInfo1.CALCFIELDS(Picture1);
                END;
            SalesSetup."Logo Position on Documents"::Right:
                BEGIN
                    CompanyInfo2.GET;
                    CompanyInfo2.CALCFIELDS(Picture1);
                END;

        END;
        SalesSetup.CALCFIELDS(Picture);
    end;

    trigger OnPreReport()
    begin
        IF NOT CurrReport.USEREQUESTPAGE THEN
            InitLogInteraction;
        Ordinal := 0;
        saldoText := FORMAT(Saldo);


        CRL.Reset();
        CRL.SetFilter("Report ID", '%1', 50131);

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if US.FindFirst() then begin
            if US."Bill type" = '08' then
                crl.setfilter("Description", '%1', 'CNG - NN fizičko lice')
            else
                crl.setfilter("Description", '<>%1', 'CNG - NN fizičko lice');
            if crl.FindFirst() then begin
                RLS.SetTempLayoutSelected(crl.Code);
            end;
        end;
    end;

    var
        DiscountCapt2: Label 'Discount ';
        US: record "User Setup";

        SignatoryPos: Record Employee;
        RecNo: code[20];
        SigPosText: text;
        SigName: text;

        CRL: record "Custom Report Layout";
        RLS: record "Report Layout Selection";
        GetLanguage: Codeunit Language;
        CalcSetup: Record "Calculation Setup";
        Subvention: Decimal;
        GJLine: Record "Gen. Journal Line";
        GJBalance: Decimal;
        LowerPartSubvention: Decimal;
        FiscalNoCaption: Text[1000];
        SubventionText: Text[1000];
        QuantityNote: Decimal;
        Location: Record Location;
        ProformaCapt: Label 'Proforma Invoice No.';
        naslovAvans: Label 'Prepayment Invoice';
        naslov: Label 'Invoice';
        UpDisc: Label 'Unit price with discount';
        TotalAmountText: Text;
        advance: Text;
        typeOfInvoice: Text;
        shOrAddress: Text;
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
        //LL    Doc: Record "Document Footer";
        PostCode: Record "Post Code";
        SIH: Record "Sales Invoice Header";
        CR: Record "Country/Region";
        PT: Record "Payment Method";
        SM: Record "Shipment Method";
        FiscalInvoice: Text[3000];
        ShowCountryofOrigin: Boolean;
        txtDocumentName: Text;
        UserName: Text;
        FooterText: Text;
        Ordinal: Integer;
        Customer: Record Customer;
        ShipmentNO: Text;
        ShipmentMethod2: Text;
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
        Cust: Record Customer;
        VATAmountLine: Record "VAT Amount Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language2: Record "Language";
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
        counter: Integer;

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
        CustomerContract: Text[100];
        Contract: Text[100];
        lowerContractDate: Date;
        Stroke: Text[1000];
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        Balance: Decimal;
        FinalBalance: Decimal;
        ResponsiblePerson: Text[300];
        ResponsiblePersonPosition: Text[300];
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
        TotalWithoutVAT: Decimal;
        Saldo: Option "Sa","Bez";
        saldoText: Text;

        SalesPersona: Text;
        SalespersonTable: Record "Salesperson/Purchaser";
        CustRegNo: Text;
        CustVatNo: Text;
        RUC: Decimal;
        OrdinalNo: Label 'No.';
        ItemCapt: Label 'Part No.';
        ItemNameCapt: Label 'Part name';
        ItemCodeCapt: Label 'Part code';
        QuantityCapt: Label 'Quantity';
        UMCapt: Label 'Unit of measure';
        UnitPriceCapt: Label 'Unit price';
        DiscountCapt: Label 'Discount';
        AmountCapt: Label 'Amount';
        TotalCapt: Label 'Total';
        LowerSubvention: Decimal;
        LowerQuantity: Decimal;
        TotalExclVAT: Label 'Total Excl. VAT';
        TotalInclVAT: Label 'Total Incl. VAT';
        TotalWithVAT: Decimal;
        PDV: Label '17% VAT';
        SubTest: Decimal;
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
        TypeVehnicle: text[100];
        IdentificationNumber: text;
        IdentificationNumberVAT: text;
        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        UserM: record "User Setup";
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];

        BillingSignatoryName: text[250];
        BillingSignatoryPos: text[250];
        transaction4: Text[100];

        EmpBilling: Record Employee;
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];


        transaction8Name: TEXT[100];
        SlovimaText: text;
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];
        transaction10: TEXT[100];

        TypeVehnicleText: TEXT[100];

        CZkPhone: Record "Bank Account";

        CZkPhoneNumber: text[250];
        FaxNoCZK: text[250];




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
        IF DataItem1570."Shipment No." <> '' THEN
            IF SalesShipmentHeader.GET(DataItem1570."Shipment No.") THEN
                EXIT(SalesShipmentHeader."Posting Date");

        IF DataItem5581."Order No." = '' THEN
            EXIT(DataItem5581."Posting Date");

        CASE DataItem1570.Type OF
            DataItem1570.Type::Item:
                GenerateBufferFromValueEntry(DataItem1570);
            DataItem1570.Type::"G/L Account", DataItem1570.Type::Resource,
          DataItem1570.Type::"Charge (Item)", DataItem1570.Type::"Fixed Asset":
                GenerateBufferFromShipment(DataItem1570);
            DataItem1570.Type::" ":
                EXIT(0D);
        END;

        SalesShipmentBuffer.RESET;
        SalesShipmentBuffer.SETRANGE("Document No.", DataItem1570."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", DataItem1570."Line No.");
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer2 := SalesShipmentBuffer;
            IF SalesShipmentBuffer.NEXT = 0 THEN BEGIN
                SalesShipmentBuffer.GET(
                  SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                QuantityNote := SalesShipmentBuffer.Quantity;
                SalesShipmentBuffer.DELETE;
                EXIT(SalesShipmentBuffer2."Posting Date");
            END;

            SalesShipmentBuffer.CALCSUMS(Quantity);
            IF SalesShipmentBuffer.Quantity <> DataItem1570.Quantity THEN BEGIN
                QuantityNote := DataItem1570.Quantity;
                SalesShipmentBuffer.DELETEALL;
                EXIT(DataItem5581."Posting Date");
            END;
        END ELSE
            EXIT(DataItem5581."Posting Date");
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
                    IF SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 THEN BEGIN
                        Quantity := ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure";
                        QuantityNote := Quantity;
                    END
                    ELSE
                        Quantity := ValueEntry."Invoiced Quantity";
                    QuantityNote := Quantity;
                    AddBufferEntry(
                      SalesInvoiceLine2,
                      -Quantity,
                      ItemLedgerEntry."Posting Date");
                    TotalQuantity := TotalQuantity + ValueEntry."Invoiced Quantity";
                    QuantityNote += TotalQuantity;

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
                        QuantityNote := SalesInvoiceLine2.Quantity;
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
                    QuantityNote += TotalQuantity;
                    SalesInvoiceLine.Quantity := SalesInvoiceLine.Quantity - Quantity;
                    QuantityNote := SalesInvoiceLine.Quantity;

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
                QuantityNote := SalesShipmentLine.Quantity;

            UNTIL SalesInvoiceLine.NEXT = 0;
    end;

    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SETRANGE("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SETRANGE("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SETRANGE("Posting Date", PostingDate);
        IF SalesShipmentBuffer.FIND('-') THEN BEGIN
            SalesShipmentBuffer.Quantity := SalesShipmentBuffer.Quantity + QtyOnShipment;
            QuantityNote := SalesShipmentBuffer.Quantity;
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
            QuantityNote := Quantity;
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
        IF DataItem1570.Type <> DataItem1570.Type::Item THEN
            EXIT;
        WITH ValueEntry DO BEGIN
            SETCURRENTKEY("Document No.");
            SETRANGE("Document No.", DataItem1570."Document No.");
            SETRANGE("Document Type", "Document Type"::"Sales Invoice");
            SETRANGE("Document Line No.", DataItem1570."Line No.");
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
            QuantityNote := PostedAsmLine.Quantity;
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


    procedure GetStartingDayOfMonth(DateToProcess: Date): Date;
    var
        StartingDate: Date;
        month: Integer;
        year: Integer;

    begin
        year := Date2DMY("DateToProcess", 3);
        month := Date2DMY("DateToProcess", 2);
        StartingDate := DMY2DATE(1, month, year);
        EXIT(StartingDate);
    end;

    procedure GetLastDayOfMonth(DateToProcess: Date): Date;
    var
        LastDate: Date;
        StartDate: Date;
    begin
        StartDate := GetStartingDayOfMonth(DateToProcess);
        LastDate := CALCDATE('<-1D>', CALCDATE('<+1M>', StartDate));
        EXIT(LastDate);
    end;

    procedure GetMonthNameFromDate(DateToProcess: Date): Text[20];
    begin
        EXIT(FORMAT(DateToProcess, 0, 'MMMM'));
    end;

    procedure CalculateDateDistance(FromDate: Date; ToDate: Date): Integer;
    var
        Difference: Integer;
    begin
        Difference := ToDate - FromDate;
        EXIT(Difference);
    end;

    procedure RoundDecimalToTwoDecimals(Number: Decimal): Decimal;
    begin
        EXIT(ROUND(Number, 2));
    end;

    procedure GetDayBeforeGivenDate(GivenDate: Date): Date;
    var
        DayBefore: Date;
    begin
        DayBefore := GivenDate - 1;
        EXIT(DayBefore);
    end;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

    local procedure GetGroupedPrice(docNo: Text; ItemNo: Code[20]): Decimal;
    var
        amount: Decimal;
        sl: Record "Sales Invoice Line";
        counter: Integer;
    begin
        sl.SETFILTER("Document No.", '%1', docNo);
        sl.SetFilter("No.", '%1', ItemNo);
        if sl.FindSet() then
            repeat
                amount += sl.Amount;
            until sl.next = 0;
        exit(amount);
    end;

    local procedure GetGroupedQuantity(docNo: Text; ItemNo: Code[20]): Decimal;
    var
        amount: Decimal;
        sl: Record "Sales Invoice Line";
        counter: Integer;
    begin
        sl.SETFILTER("Document No.", '%1', docNo);
        sl.SetFilter("No.", '%1', ItemNo);
        if sl.FindSet() then
            repeat
                amount += sl.Quantity;
            until sl.next = 0;
        exit(amount);
    end;

    procedure TrimLastChar(var t: Text[100]): Text[100]
    begin
        if StrLen(t) > 0 then
            t := DelStr(t, StrLen(t), 1);
        exit(t);
    end;

    procedure SetParam(No: code[20])
    begin
        "RecNo" := No;
    end;

    //EK 
    /*
procedure createCNGDescription(ItemNo: Code[20]; dateForTitle: Date): Text[200]
var
    item: Record Item;
    createdText: Text;
    Year: Integer;
    Month: Integer;
    SLT: Enum "Sales Line Type";


begin

    IF Item.GET(ItemNo) THEN BEGIN
        if item.Description = 'Prirodni gas' then begin
            Year := Date2DMY(dateForTitle, 3);
            Month := Date2DMY(dateForTitle, 2);
            createdText := 'CNG - potrošnja za ' + FORMAT(Month) + '/' + FORMAT(Year);
            exit(createdText);
        end else
            exit(item.Description);
    end
    ELSE
        exit('Uplata za CNG');


end;*/
    procedure createCNGDescription(Type: Enum "Sales Line Type"; ItemNo: Code[20];
                                             dateForTitle: Date): Text[200]
    var
        item: Record Item;
        createdText: Text;
        Year: Integer;
        Month: Integer;
        CS: Record "Calculation Setup";
        SLT: Enum "Sales Line Type";
        Res: Record Resource;
        GL: Record "G/L Account";
    begin
        Year := Date2DMY(dateForTitle, 3);
        Month := Date2DMY(dateForTitle, 2);
        CS.Get();

        if Type = SLT::Item then begin
            IF Item.GET(ItemNo) THEN BEGIN
                if Item."No." = CS."Item No." then begin
                    //prodaja je CNG
                    createdText := 'CNG potrošnja za ' + FORMAT(Month) + '/' + FORMAT(Year);
                end else
                    if Item."No." = CS."Item No. 2" then begin
                        //nabava je prirodni gas
                        createdText := 'Potrošnja za ' + FORMAT(Month) + '/' + FORMAT(Year);
                    end else begin
                        createdText := Item.Description;
                    end;

            end else begin
                createdText := 'Nema artikla';
            end;
        end else
            if Type = SLT::Resource then begin
                if Res.Get(ItemNo) then begin
                    createdText := Res.Name;
                end;

            end else
                if Type = SLT::"G/L Account" then begin
                    GL.Reset();
                    GL.SetRange("No.", ItemNo);
                    if GL.FindFirst() then begin
                        createdText := GL.Name;
                    end;
                end;

        if createdText = '' then
            createdText := 'Nema opisa';

        exit(createdText);
    end;





}
