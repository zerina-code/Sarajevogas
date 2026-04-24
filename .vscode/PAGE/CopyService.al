report 50151 "Copy Service Document SA"
{
    Caption = 'Copy Service Document';
    //  ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
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

                    field(IncludeOnlyNotInvoice; IncludeOnlyNotInvoice)
                    {
                        Caption = 'IncludeOnlyNotInvoice';
                        Visible = false;
                    }
                    field(DocType; DocType)
                    {
                        ApplicationArea = Service;
                        Caption = 'Document Type';
                        OptionCaption = 'Quote,Order,Invoice,Credit Memo,Posted Invoice Service,Posted Credit Memo';
                        ToolTip = 'Specifies the type of service document that you want to copy.';

                        trigger OnValidate()
                        begin
                            DocNo := '';
                            ValidateDocNo;
                        end;
                    }
                    field(DocNo; DocNo)
                    {
                        ApplicationArea = Service;
                        Caption = 'Document No.';
                        ToolTip = 'Specifies the document number that you want to copy from by choosing the field.';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            LookupDocNo;
                        end;

                        trigger OnValidate()
                        begin
                            ValidateDocNo;
                        end;
                    }
                    field("FromServContractHeader.""Customer No."""; FromServContractHeader."Customer No.")
                    {
                        ApplicationArea = Service;
                        Caption = 'Customer No.';
                        Editable = false;
                        ToolTip = 'Specifies the number of the customer.';
                    }
                    field("FromServContractHeader.Name"; FromServContractHeader.Name)
                    {
                        ApplicationArea = Service;
                        Caption = 'Customer Name';
                        Editable = false;
                        ToolTip = 'Specifies the customer name from a document that you have selected to copy the information from.';
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnInit()
        var
            myInt: Integer;
        begin
            DocType := DocType::"Posted Credit Memo";

        end;



    }

    labels
    {
    }

    trigger OnPostReport()
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin


        //END;
        CopyIntoHeader(FromServContractHeader);
        CopyIntoLine;

        DocNo := '';
        //  DocType := DocType::Quote;
    end;

    trigger OnPreReport()
    var
        ConfirmManagement: Codeunit "Confirm Management";
    begin

        IF DocNo = '' THEN
            ERROR(Text004);
        ValidateDocNo;
        IF FromServContractHeader."Ship-to Code" <> ServContractHeader."Ship-to Code" THEN
            IF NOT CONFIRM(Text003, FALSE) THEN BEGIN
                CurrReport.QUIT;
                EXIT;
            END;

    end;

    var
        ServContractHeader: Record "Service Header";
        UpdateHeader: code[20];
        CustomerFilter: code[20];
        CUstomerFind: code[20];
        FromServContractHeader: Record "Service Header";
        NextLineNo: Integer;
        Servvv: Record "Service Header";
        UnitCost: Decimal;
        ServSetup: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        NoserisOrg: Codeunit NoSeriesManagement;
        ServiceCreditMemo: page "Service Credit Memo";
        ServiceLineNo: Record "Service Line";
        FromServContractLine2: Record "Service Line";

        FromServiceHeadr: Record "Service Header";
        ServDocType2: Option Quote,Invoice,"Credit Memo",Order,"Posted Invoice","Posted Credit Memo";
        ServiceInvoiceHeader: Record "Service Invoice Header";
        ServiceCrMemoHeader: Record "Service Cr.Memo Header";
        ServiceInvoiceHeaderF: Record "Service Invoice Header";
        ServTemp: Record "Service Header" temporary;
        ServOrgCustomer: Record "Service Header";
        IncludeOnlyNotInvoice: Boolean;
        MemoF: Boolean;
        CustFInd: code[20];
        ServReal: Record "Service Header";
        FromServContractLine: Record "Service Line";
        ServHeader: Record "Service Header";
        ServHeaderInv: Record "Service Invoice Header";
        FromServContractLineTemp: Record "Service Line" temporary;
        OrgDocument: code[20];
        orgType: Option "Quote","Order","Invoice","Credit Memo","Posted Invoice Service","Posted Credit Memo";
        ServiceInvoiceLine: Record "Service Invoice Line";

        ServiceCrMemoLine: Record "Service Cr.Memo Line";
        OutServContractLine: Record "Service Contract Line";
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        DocType: Option "Quote","Order","Invoice","Credit Memo","Posted Invoice Service","Posted Credit Memo";
        DocNo: Code[20];
        AllLinesCopied: Boolean;
        Text000: Label 'It was not possible to copy all of the service contract lines.\\Do you want to see these lines?';
        Text002: Label 'You can only copy the document with the same %1.';
        Text003: Label 'The document has a different ship-to code.\\Do you want to continue?';
        Text004: Label 'You must fill in the Document No. field.';
        Text015: Label '%1 %2:';
        Text013: Label 'Shipment No.,Invoice No.,Return Receipt No.,Credit Memo No.';


    procedure SetServContractHeader(var NewServContractHeader: Record "Service Header")
    begin
        ServContractHeader := NewServContractHeader;
    end;

    local procedure ValidateDocNo()
    var
        OrgD: code[20];
    begin


        //   FromServContractHeader.DeleteAll();

        //FromServContractLineTemp.DELETEALL;

        OrgD := FromServContractHeader."No.";
        FromServContractHeader.INIT;



        CASE DocType OF
            DocType::"Credit Memo",
            DocType::Invoice,
            DocType::Order,
            DocType::Quote:
                BEGIN
                    if DocType = DocType::Invoice then begin
                        FromServContractHeader.Reset();
                        FromServContractHeader.SetFilter("Document Type", '%1', FromServContractHeader."Document Type"::Invoice);
                        FromServContractHeader.SetFilter("No.", '%1', DocNo);
                        FromServContractHeader.FindFirst();
                    end;
                    if DocType = DocType::Order then begin
                        FromServContractHeader.Reset();
                        FromServContractHeader.SetFilter("Document Type", '%1', FromServContractHeader."Document Type"::Order);
                        FromServContractHeader.SetFilter("No.", '%1', DocNo);
                        FromServContractHeader.FindFirst();
                    end;
                    if DocType = DocType::"Credit Memo" then begin
                        FromServContractHeader.Reset();
                        FromServContractHeader.SetFilter("Document Type", '%1', FromServContractHeader."Document Type"::"Credit Memo");
                        FromServContractHeader.SetFilter("No.", '%1', DocNo);
                        FromServContractHeader.FindFirst();
                    end;

                    if DocType = DocType::Quote then begin
                        FromServContractHeader.Reset();
                        FromServContractHeader.SetFilter("Document Type", '%1', FromServContractHeader."Document Type"::Quote);
                        FromServContractHeader.SetFilter("No.", '%1', DocNo);
                        FromServContractHeader.FindFirst();
                    end;
                END;
            DocType::"Posted Invoice Service":
                BEGIN
                    if ServiceInvoiceHeader.GET(DocNo) then begin
                        FromServContractHeader.TRANSFERFIELDS(ServiceInvoiceHeader);
                    end;



                END;

            DocType::"Posted Credit Memo":
                BEGIN
                    if ServiceCrMemoHeader.GET(DocNo) then begin
                        FromServContractHeader.TRANSFERFIELDS(ServiceCrMemoHeader);
                    end;

                END;

        END;
        ServTemp.Reset();
        ServTemp.SetFilter("No.", '%1', FromServContractHeader."No.");
        if not ServTemp.FindFirst() then begin
            ServTemp.DELETEALL;
            ServTemp.INIT;
            ServTemp.TRANSFERFIELDS(FromServContractHeader);
            ServTemp."Document Type" := ServHeader."Document Type";

            ServTemp."No." := FromServContractHeader."No.";
            ServTemp."Posting Description" := FromServContractHeader.Description;
            ServTemp.INSERT;
        end;
    end;

    local procedure LookupDocNo()
    begin

        CASE DocType OF
            DocType::Quote,
            DocType::Order,
            DocType::Invoice,
            DocType::"Credit Memo":
                BEGIN

                    //'Quote,Invoice,Credit Memo,Order,Posted Invoice Service,Posted Credit Memo';
                    FromServContractHeader.FILTERGROUP := 0;
                    if DocType = DocType::Quote then
                        FromServContractHeader.SETRANGE("Document Type", FromServContractHeader."Document Type"::Quote);
                    if DocType = DocType::Order then
                        FromServContractHeader.SETRANGE("Document Type", FromServContractHeader."Document Type"::Order);
                    if DocType = DocType::Invoice then
                        FromServContractHeader.SETRANGE("Document Type", FromServContractHeader."Document Type"::Invoice);
                    if DocType = DocType::"Credit Memo" then
                        FromServContractHeader.SETRANGE("Document Type", FromServContractHeader."Document Type"::"Credit Memo");

                    if CustomerFilter <> '' then
                        FromServContractHeader.SETRANGE("Customer No.", CustomerFilter);

                    IF ServHeader."Document Type" = CopyDocMgt.SalesHeaderDocType(DocType) THEN
                        FromServContractHeader.SETFILTER("No.", '<>%1', ServHeader."No.");
                    FromServContractHeader.FILTERGROUP := 2;
                    FromServContractHeader."Document Type" := ServHeaderDocType(DocType);
                    FromServContractHeader."No." := DocNo;
                    IF (DocNo = '') AND (ServHeader."Bill-to Customer No." <> '') THEN
                        IF FromServContractHeader.SETCURRENTKEY("Document Type", "Bill-to Customer No.") THEN BEGIN
                            FromServContractHeader."Bill-to Customer No." := ServHeader."Bill-to Customer No.";
                            IF FromServContractHeader.FIND('=><') THEN;
                        END;
                    IF PAGE.RUNMODAL(0, FromServContractHeader) = ACTION::LookupOK THEN
                        DocNo := FromServContractHeader."No.";
                END;

            DocType::"Posted Invoice Service":
                BEGIN
                    ServiceInvoiceHeader."No." := DocNo;
                    if CustomerFilter <> '' then
                        ServiceInvoiceHeader.SETRANGE("Customer No.", CustomerFilter);
                    IF (DocNo = '') AND (ServHeader."Bill-to Customer No." <> '') THEN
                        IF ServiceInvoiceHeader.SETCURRENTKEY("Bill-to Customer No.") THEN BEGIN
                            ServiceInvoiceHeader."Bill-to Customer No." := ServHeader."Bill-to Customer No.";
                            IF ServiceInvoiceHeader.FIND('=><') THEN;
                        END;
                    ServiceInvoiceHeader.FILTERGROUP(2);
                    //ĐK ServiceInvoiceHeader.SETRANGE("Prepayment Invoice",FALSE);
                    ServiceInvoiceHeader.FILTERGROUP(0);
                    IF PAGE.RUNMODAL(0, ServiceInvoiceHeader) = ACTION::LookupOK THEN
                        DocNo := ServiceInvoiceHeader."No.";
                END;


            DocType::"Posted Credit Memo":
                BEGIN
                    ServiceCrMemoHeader."No." := DocNo;
                    if CustomerFilter <> '' then
                        ServiceCrMemoHeader.SETRANGE("Customer No.", CustomerFilter);
                    IF (DocNo = '') AND (ServHeader."Bill-to Customer No." <> '') THEN
                        IF ServiceCrMemoHeader.SETCURRENTKEY("Bill-to Customer No.") THEN BEGIN
                            ServiceCrMemoHeader."Bill-to Customer No." := ServHeader."Bill-to Customer No.";
                            IF ServiceCrMemoHeader.FIND('=><') THEN;
                        END;
                    ServiceCrMemoHeader.FILTERGROUP(2);
                    //đk ServiceCrMemoHeader.SETRANGE("Prepayment Credit Memo",FALSE);
                    ServiceCrMemoHeader.FILTERGROUP(0);
                    IF PAGE.RUNMODAL(0, ServiceCrMemoHeader) = ACTION::LookupOK THEN
                        DocNo := ServiceCrMemoHeader."No.";
                END;
        END;
        ValidateDocNo;
        IF FromServContractHeader."Customer No." <> CustomerFilter THEN
            ERROR(Text002, ServContractHeader.FIELDCAPTION("Customer No."));
    end;

    procedure InitializeRequest(DocumentType: Option; DocumentNo: Code[20]; Memo: Boolean; CustF: code[20])
    var
        US: Record "User Setup";

    begin
        DocType := DocumentType;
        DocNo := DocumentNo;
        UpdateHeader := DocumentNo;
        US.Reset();
        Us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            Commit();
            us."New Username" := DocumentNo;
            us.modify;
            Commit();
        end;
        MemoF := Memo;
        CustomerFilter := CustF;
        if Memo = false then begin
            ServOrgCustomer.Reset();
            ServOrgCustomer.SetFilter("Document Type", '%1', DocType);
            ServOrgCustomer.setfilter("No.", '%1', DocumentNo);
            if ServOrgCustomer.FindFirst()
     then
                CustFInd := ServOrgCustomer."Customer No.";
            FromServContractHeader."Customer No." := CustFInd;
            FromServContractHeader."Bill-to Name" := ServOrgCustomer."Bill-to Name";
            FromServContractHeader."Posting Description" := OrgDocument;
            OrgDocument := DocumentNo;
            if ServOrgCustomer."Document Type" = ServOrgCustomer."Document Type"::"Credit Memo" then
                orgType := orgType::"Invoice";
            if ServOrgCustomer."Document Type" = ServOrgCustomer."Document Type"::"Invoice" then
                orgType := orgType::"Invoice";
            if ServOrgCustomer."Document Type" = ServOrgCustomer."Document Type"::"Order" then
                orgType := orgType::"Order";
            if ServOrgCustomer."Document Type" = ServOrgCustomer."Document Type"::"Quote" then
                orgType := orgType::"Quote";
        end;
    end;

    procedure CopyIntoHeader(FromTable: Record "Service Header")
    var
        OrgDocument2: Record "Service Header";
        SIH: Record "Service Invoice Header";
        US: record "User Setup";
    begin
        IF orgType <> orgType::"Credit Memo" THEN BEGIN
            COMMIT;
            //     ServHeader.TRANSFERFIELDS(FromTable);
            if OrgDocument = '' then begin
                ServTemp.reset;
                if ServTemp.FindFirst() then
                    OrgDocument := ServTemp."No.";
            end;
            US.Reset();
            Us.SetFilter("User ID", '%1', UserId);
            if us.FindFirst() then begin
                UpdateHeader := us."New Username";
            end;

            ServHeader.Reset();
            ServHeader.SetFilter("No.", '%1', UpdateHeader);
            if ServHeader.FindFirst() then begin
                ServHeader."Applies-to Doc. Type" := FromTable."Document Type";

                ServHeader."Applies-to Doc. No." := FromTable."No.";
                ServHeader."Shipping No." := '';
                ServHeader."Posting No." := '';
                ServHeader."Last Shipping No." := '';
                ServHeader."Last Posting No." := '';
                ServHeader."Pmt. Discount Date" := 0D;
                ServHeader."Customer No." := FromTable."Customer No.";
                ServHeader."Bill-to Customer No." := FromTable."Bill-to Customer No.";
                ServHeader."Bill-to Name" := FromTable."Bill-to Name";
                ServHeader."Bill-to Name 2" := FromTable."Bill-to Name 2";
                ServHeader."Bill-to Address" := FromTable."Bill-to Address";
                ServHeader."Bill-to Address 2" := FromTable."Bill-to Address 2";
                ServHeader."Bill-to City" := FromTable."Bill-to City";
                ServHeader."Bill-to Contact" := FromTable."Bill-to Contact";
                ServHeader."Your Reference" := FromTable."Your Reference";
                ServHeader."Ship-to Code" := FromTable."Ship-to Code";
                ServHeader."Ship-to Name" := FromTable."Ship-to Name";
                ServHeader."Ship-to Name 2" := FromTable."Ship-to Name 2";
                ServHeader."Ship-to Address" := FromTable."Ship-to Address";
                ServHeader."Ship-to Address 2" := FromTable."Ship-to Address 2";
                ServHeader."Ship-to City" := FromTable."Ship-to City";
                ServHeader."Ship-to Contact" := FromTable."Ship-to Contact";
                ServHeader."Order Date" := FromTable."Order Date";
                ServHeader."Posting Date" := FromTable."Posting Date";
                ServHeader."Posting Description" := FromTable."Posting Description";
                ServHeader."Payment Terms Code" := FromTable."Payment Terms Code";
                ServHeader."Due Date" := FromTable."Due Date";
                ServHeader."Payment Discount %" := FromTable."Payment Discount %";
                ServHeader."Pmt. Discount Date" := FromTable."Pmt. Discount Date";
                ServHeader."Shipment Method Code" := FromTable."Shipment Method Code";
                ServHeader."Location Code" := FromTable."Location Code";
                ServHeader."Shortcut Dimension 1 Code" := FromTable."Shortcut Dimension 1 Code";
                ServHeader."Shortcut Dimension 2 Code" := FromTable."Shortcut Dimension 2 Code";
                ServHeader."Customer Posting Group" := FromTable."Customer Posting Group";
                ServHeader."Currency Code" := FromTable."Currency Code";
                ServHeader."Currency Factor" := FromTable."Currency Factor";
                ServHeader."Customer Price Group" := FromTable."Customer Price Group";
                ServHeader."Prices Including VAT" := FromTable."Prices Including VAT";
                ServHeader."Invoice Disc. Code" := FromTable."Invoice Disc. Code";
                ServHeader."Customer Disc. Group" := FromTable."Customer Disc. Group";
                ServHeader."Language Code" := FromTable."Language Code";
                ServHeader."Salesperson Code" := FromTable."Salesperson Code";
                ServHeader."No. Printed" := FromTable."No. Printed";
                ServHeader."Applies-to Doc. Type" := FromTable."Document Type";
                //ServHeader."Applies-to Doc. No.":=FromTable."Applies-to Doc. No.";
                ServHeader."Bal. Account No." := FromTable."Bal. Account No.";
                //ServHeader."Shipping No.":=FromTable."Shipping No.";
                //ServHeader."Posting No.":=FromTable."Posting No.";
                //ServHeader."Last Shipping No.":=FromTable."Last Shipping No.";
                //ServHeader."Last Posting No.":=FromTable."Last Posting No.";
                ServHeader."VAT Registration No." := FromTable."VAT Registration No.";
                ServHeader."Reason Code" := FromTable."Reason Code";
                ServHeader."Gen. Bus. Posting Group" := FromTable."Gen. Bus. Posting Group";
                ServHeader."EU 3-Party Trade" := FromTable."EU 3-Party Trade";
                ServHeader."Transaction Type" := FromTable."Transaction Type";
                ServHeader."Transport Method" := FromTable."Transport Method";
                ServHeader."VAT Country/Region Code" := FromTable."VAT Country/Region Code";
                ServHeader.Name := FromTable.Name;
                ServHeader."Name 2" := FromTable."Name 2";
                ServHeader.Address := FromTable.Address;
                ServHeader."Address 2" := FromTable."Address 2";
                ServHeader.City := FromTable.City;
                ServHeader."Contact Name" := FromTable."Contact Name";
                ServHeader."Bill-to Post Code" := FromTable."Bill-to Post Code";
                ServHeader."Bill-to County" := FromTable."Bill-to County";
                ServHeader."Bill-to Country/Region Code" := FromTable."Bill-to Country/Region Code";
                ServHeader."Post Code" := FromTable."Post Code";
                ServHeader.County := FromTable.County;
                ServHeader."Country/Region Code" := FromTable."Country/Region Code";
                ServHeader."Ship-to Post Code" := FromTable."Ship-to Post Code";
                ServHeader."Ship-to County" := FromTable."Ship-to County";
                ServHeader."Ship-to Country/Region Code" := FromTable."Ship-to Country/Region Code";
                ServHeader."Bal. Account Type" := FromTable."Bal. Account Type";
                ServHeader."Exit Point" := FromTable."Exit Point";
                ServHeader.Correction := FromTable.Correction;
                ServHeader."Document Date" := FromTable."Document Date";
                ServHeader.Area := FromTable.Area;
                ServHeader."Transaction Specification" := FromTable."Transaction Specification";
                ServHeader."Payment Method Code" := FromTable."Payment Method Code";
                ServHeader."Shipping Agent Code" := FromTable."Shipping Agent Code";
                ServHeader."No. Series" := FromTable."No. Series";
                ServHeader."Posting No. Series" := FromTable."Posting No. Series";
                //ServHeader."Shipping No. Series":=FromTable."Shipping No. Series";
                ServHeader."Tax Area Code" := FromTable."Tax Area Code";
                ServHeader."Tax Liable" := FromTable."Tax Liable";
                ServHeader."VAT Bus. Posting Group" := FromTable."VAT Bus. Posting Group";
                ServHeader.Reserve := FromTable.Reserve;
                ServHeader."Applies-to ID" := FromTable."Applies-to ID";
                ServHeader."VAT Base Discount %" := FromTable."VAT Base Discount %";
                ServHeader.Status := FromTable.Status;
                ServHeader."Invoice Discount Calculation" := FromTable."Invoice Discount Calculation";
                ServHeader."Invoice Discount Value" := FromTable."Invoice Discount Value";
                ServHeader."Release Status" := FromTable."Release Status";
                ServHeader."Dimension Set ID" := FromTable."Dimension Set ID";
                ServHeader."Contact No." := FromTable."Contact No.";
                ServHeader."Bill-to Contact No." := FromTable."Bill-to Contact No.";
                ServHeader."Responsibility Center" := FromTable."Responsibility Center";
                ServHeader."Shipping Advice" := FromTable."Shipping Advice";
                ServHeader."Shipping Time" := FromTable."Shipping Time";
                ServHeader."Shipping Agent Service Code" := FromTable."Shipping Agent Service Code";
                ServHeader.Description := FromTable.Description;
                ServHeader."Service Order Type" := FromTable."Service Order Type";
                ServHeader."Link Service to Service Item" := FromTable."Link Service to Service Item";
                ServHeader.Priority := FromTable.Priority;
                ServHeader."Phone No." := FromTable."Phone No.";
                ServHeader."E-Mail" := FromTable."E-Mail";
                ServHeader."Phone No. 2" := FromTable."Phone No. 2";
                ServHeader."Fax No." := FromTable."Fax No.";
                ServHeader."Order Time" := FromTable."Order Time";
                ServHeader."Default Response Time (Hours)" := FromTable."Default Response Time (Hours)";
                ServHeader."Actual Response Time (Hours)" := FromTable."Actual Response Time (Hours)";
                ServHeader."Service Time (Hours)" := FromTable."Service Time (Hours)";
                ServHeader."Response Date" := FromTable."Response Date";
                ServHeader."Response Time" := FromTable."Response Time";
                //uklonila Đemina
                /*   ServHeader."Starting Date" := FromTable."Starting Date";
                   ServHeader."Starting Time" := FromTable."Starting Time";
                   ServHeader."Finishing Date" := FromTable."Finishing Date";
                   ServHeader."Finishing Time" := FromTable."Finishing Time";*/
                ServHeader."Notify Customer" := FromTable."Notify Customer";
                ServHeader."Max. Labor Unit Price" := FromTable."Max. Labor Unit Price";
                ServHeader."Warning Status" := FromTable."Warning Status";
                ServHeader."Contract No." := FromTable."Contract No.";
                ServHeader."Ship-to Fax No." := FromTable."Ship-to Fax No.";
                ServHeader."Ship-to E-Mail" := FromTable."Ship-to E-Mail";
                ServHeader."Ship-to Phone" := FromTable."Ship-to Phone";
                ServHeader."Ship-to Phone 2" := FromTable."Ship-to Phone 2";
                ServHeader."Service Zone Code" := FromTable."Service Zone Code";
                ServHeader."Expected Finishing Date" := FromTable."Expected Finishing Date";
                ServHeader."Allow Line Disc." := FromTable."Allow Line Disc.";
                ServHeader."Assigned User ID" := FromTable."Assigned User ID";
                ServHeader."Quote No." := FromTable."Quote No.";
                ServHeader."VAT Date" := FromTable."VAT Date";

                ServHeader."Shipping No. Series" := '';
                ServSetup.GET;
                // TestNoSeries;
                /*     NoSeriesMgt.InitSeries(GetNoSeriesCode, '', 0D, ServHeader."Last Posting No.", ServHeader."No. Series");
                     ServHeader."Posting No. Series" := GetPostingNoSeriesCode;

                     NoserisOrg.TestSeries(GetPostingNoSeriesCode, ServHeader."Posting No. Series");*/

                ServHeader."Pmt. Discount Date" := 0D;
                ServHeader.MODIFY;
            end;

        END
        ELSE BEGIN
            US.Reset();
            Us.SetFilter("User ID", '%1', UserId);
            if us.FindFirst() then begin
                UpdateHeader := us."New Username";
            end;

            ServHeader.Reset();
            ServHeader.SetFilter("No.", '%1', UpdateHeader);
            if ServHeader.FindFirst() then begin
                ServHeader.TransferFields(FromTable);
                ServHeader."No." := UpdateHeader;
                ServHeader."Posting Date" := FromTable."Posting Date";
                ServHeader."Customer No." := FromTable."Customer No.";
                ServHeader."Bill-to Customer No." := FromTable."Bill-to Customer No.";
                ServHeader."Bill-to Name" := FromTable."Bill-to Name";
                ServHeader."Bill-to Name 2" := FromTable."Bill-to Name 2";
                ServHeader."Bill-to Address" := FromTable."Bill-to Address";
                ServHeader."Bill-to Address 2" := FromTable."Bill-to Address 2";
                ServHeader."Bill-to City" := FromTable."Bill-to City";
                ServHeader."Bill-to Contact" := FromTable."Bill-to Contact";
                ServHeader."Your Reference" := FromTable."Your Reference";
                ServHeader."Ship-to Code" := FromTable."Ship-to Code";
                ServHeader."Ship-to Name" := FromTable."Ship-to Name";
                ServHeader."Ship-to Name 2" := FromTable."Ship-to Name 2";
                ServHeader."Ship-to Address" := FromTable."Ship-to Address";
                ServHeader."Ship-to Address 2" := FromTable."Ship-to Address 2";
                ServHeader."Ship-to City" := FromTable."Ship-to City";
                ServHeader."Ship-to Contact" := FromTable."Ship-to Contact";
                ServHeader."Order Date" := FromTable."Order Date";
                ServHeader."Posting Date" := FromTable."Posting Date";
                ServHeader."Posting Description" := FromTable."Posting Description";
                ServHeader."Payment Terms Code" := FromTable."Payment Terms Code";
                ServHeader."Due Date" := FromTable."Due Date";
                ServHeader."Payment Discount %" := FromTable."Payment Discount %";
                ServHeader."Pmt. Discount Date" := FromTable."Pmt. Discount Date";
                ServHeader."Shipment Method Code" := FromTable."Shipment Method Code";
                ServHeader."Location Code" := FromTable."Location Code";
                ServHeader."Shortcut Dimension 1 Code" := FromTable."Shortcut Dimension 1 Code";
                ServHeader."Shortcut Dimension 2 Code" := FromTable."Shortcut Dimension 2 Code";
                ServHeader."Customer Posting Group" := FromTable."Customer Posting Group";
                ServHeader."Currency Code" := FromTable."Currency Code";
                ServHeader."Currency Factor" := FromTable."Currency Factor";
                ServHeader."Customer Price Group" := FromTable."Customer Price Group";
                ServHeader."Prices Including VAT" := FromTable."Prices Including VAT";
                ServHeader."Invoice Disc. Code" := FromTable."Invoice Disc. Code";
                ServHeader."Customer Disc. Group" := FromTable."Customer Disc. Group";
                ServHeader."Language Code" := FromTable."Language Code";
                ServHeader."Salesperson Code" := FromTable."Salesperson Code";
                ServHeader."No. Printed" := FromTable."No. Printed";
                ServHeader."Applies-to Doc. Type" := FromTable."Document Type";
                //ServHeader."Applies-to Doc. No.":=FromTable."Applies-to Doc. No.";
                ServHeader."Bal. Account No." := FromTable."Bal. Account No.";
                //ServHeader."Shipping No.":=FromTable."Shipping No.";
                //ServHeader."Posting No.":=FromTable."Posting No.";
                //ServHeader."Last Shipping No.":=FromTable."Last Shipping No.";
                //ServHeader."Last Posting No.":=FromTable."Last Posting No.";
                ServHeader."VAT Registration No." := FromTable."VAT Registration No.";
                ServHeader."Reason Code" := FromTable."Reason Code";
                ServHeader."Gen. Bus. Posting Group" := FromTable."Gen. Bus. Posting Group";
                ServHeader."EU 3-Party Trade" := FromTable."EU 3-Party Trade";
                ServHeader."Transaction Type" := FromTable."Transaction Type";
                ServHeader."Transport Method" := FromTable."Transport Method";
                ServHeader."VAT Country/Region Code" := FromTable."VAT Country/Region Code";
                ServHeader.Name := FromTable.Name;
                ServHeader."Name 2" := FromTable."Name 2";
                ServHeader.Address := FromTable.Address;
                ServHeader."Address 2" := FromTable."Address 2";
                ServHeader.City := FromTable.City;
                ServHeader."Contact Name" := FromTable."Contact Name";
                ServHeader."Bill-to Post Code" := FromTable."Bill-to Post Code";
                ServHeader."Bill-to County" := FromTable."Bill-to County";
                ServHeader."Bill-to Country/Region Code" := FromTable."Bill-to Country/Region Code";
                ServHeader."Post Code" := FromTable."Post Code";
                ServHeader.County := FromTable.County;
                ServHeader."Country/Region Code" := FromTable."Country/Region Code";
                ServHeader."Ship-to Post Code" := FromTable."Ship-to Post Code";
                ServHeader."Ship-to County" := FromTable."Ship-to County";
                ServHeader."Ship-to Country/Region Code" := FromTable."Ship-to Country/Region Code";
                ServHeader."Bal. Account Type" := FromTable."Bal. Account Type";
                ServHeader."Exit Point" := FromTable."Exit Point";
                ServHeader.Correction := FromTable.Correction;
                ServHeader."Document Date" := FromTable."Document Date";
                ServHeader.Area := FromTable.Area;
                ServHeader."Transaction Specification" := FromTable."Transaction Specification";
                ServHeader."Payment Method Code" := FromTable."Payment Method Code";
                ServHeader."Shipping Agent Code" := FromTable."Shipping Agent Code";
                ServHeader."No. Series" := FromTable."No. Series";
                ServHeader."Posting No. Series" := FromTable."Posting No. Series";
                //ServHeader."Shipping No. Series":=FromTable."Shipping No. Series";
                ServHeader."Tax Area Code" := FromTable."Tax Area Code";
                ServHeader."Tax Liable" := FromTable."Tax Liable";
                ServHeader."VAT Bus. Posting Group" := FromTable."VAT Bus. Posting Group";
                ServHeader.Reserve := FromTable.Reserve;
                ServHeader."Applies-to ID" := FromTable."Applies-to ID";
                ServHeader."VAT Base Discount %" := FromTable."VAT Base Discount %";
                ServHeader.Status := FromTable.Status;
                ServHeader."Invoice Discount Calculation" := FromTable."Invoice Discount Calculation";
                ServHeader."Invoice Discount Value" := FromTable."Invoice Discount Value";
                ServHeader."Release Status" := FromTable."Release Status";
                ServHeader."Dimension Set ID" := FromTable."Dimension Set ID";
                ServHeader."Contact No." := FromTable."Contact No.";
                ServHeader."Bill-to Contact No." := FromTable."Bill-to Contact No.";
                ServHeader."Responsibility Center" := FromTable."Responsibility Center";
                ServHeader."Shipping Advice" := FromTable."Shipping Advice";
                ServHeader."Shipping Time" := FromTable."Shipping Time";
                ServHeader."Shipping Agent Service Code" := FromTable."Shipping Agent Service Code";
                ServHeader.Description := FromTable.Description;
                ServHeader."Service Order Type" := FromTable."Service Order Type";
                ServHeader."Link Service to Service Item" := FromTable."Link Service to Service Item";
                ServHeader.Priority := FromTable.Priority;
                ServHeader."Phone No." := FromTable."Phone No.";
                ServHeader."E-Mail" := FromTable."E-Mail";
                ServHeader."Phone No. 2" := FromTable."Phone No. 2";
                ServHeader."Fax No." := FromTable."Fax No.";
                ServHeader."Order Time" := FromTable."Order Time";
                ServHeader."Default Response Time (Hours)" := FromTable."Default Response Time (Hours)";
                ServHeader."Actual Response Time (Hours)" := FromTable."Actual Response Time (Hours)";
                ServHeader."Service Time (Hours)" := FromTable."Service Time (Hours)";
                ServHeader."Response Date" := FromTable."Response Date";
                ServHeader."Response Time" := FromTable."Response Time";
                //uklonila Đemina
                /*   ServHeader."Starting Date" := FromTable."Starting Date";
                   ServHeader."Starting Time" := FromTable."Starting Time";
                   ServHeader."Finishing Date" := FromTable."Finishing Date";
                   ServHeader."Finishing Time" := FromTable."Finishing Time";*/
                ServHeader."Notify Customer" := FromTable."Notify Customer";
                ServHeader."Max. Labor Unit Price" := FromTable."Max. Labor Unit Price";
                ServHeader."Warning Status" := FromTable."Warning Status";
                ServHeader."Contract No." := FromTable."Contract No.";
                ServHeader."Ship-to Fax No." := FromTable."Ship-to Fax No.";
                ServHeader."Ship-to E-Mail" := FromTable."Ship-to E-Mail";
                ServHeader."Ship-to Phone" := FromTable."Ship-to Phone";
                ServHeader."Ship-to Phone 2" := FromTable."Ship-to Phone 2";
                ServHeader."Service Zone Code" := FromTable."Service Zone Code";
                ServHeader."Expected Finishing Date" := FromTable."Expected Finishing Date";
                ServHeader."Allow Line Disc." := FromTable."Allow Line Disc.";
                ServHeader."Assigned User ID" := FromTable."Assigned User ID";
                ServHeader."Quote No." := FromTable."Quote No.";
                ServHeader."VAT Date" := FromTable."VAT Date";

                ServHeader."Shipping No. Series" := '';
                ServSetup.GET;
                // TestNoSeries;
                /*     NoSeriesMgt.InitSeries(GetNoSeriesCode, '', 0D, ServHeader."Last Posting No.", ServHeader."No. Series");
                     ServHeader."Posting No. Series" := GetPostingNoSeriesCode;

                     NoserisOrg.TestSeries(GetPostingNoSeriesCode, ServHeader."Posting No. Series");*/

                ServHeader."Pmt. Discount Date" := 0D;
                ServHeader.MODIFY(FALSE);
            end;
        end;

    END;


    Procedure CopyIntoLine()

    begin
        NextLineNo := 10000;
        CASE DocType OF
            DocType::Quote,
            DocType::Order,
            DocType::Invoice,
            DocType::"Credit Memo":
                BEGIN



                    FromServContractLine.RESET;
                    //ĐK  FromServContractLine.SETFILTER("Document Type",'%1',DocType);
                    IF DocType = DocType::Quote THEN
                        FromServContractLine.SETFILTER("Document Type", '%1', FromServContractLine."Document Type"::Quote);

                    IF DocType = DocType::Order THEN
                        FromServContractLine.SETFILTER("Document Type", '%1', FromServContractLine."Document Type"::Order);


                    IF DocType = DocType::Invoice THEN
                        FromServContractLine.SETFILTER("Document Type", '%1', FromServContractLine."Document Type"::Invoice);



                    IF DocType = DocType::"Credit Memo" THEN
                        FromServContractLine.SETFILTER("Document Type", '%1', FromServContractLine."Document Type"::"Credit Memo");




                    FromServContractLine.SETFILTER("Document No.", '%1', DocNo);
                    FromServContractLine.SETFILTER("No.", '<>%1', '');
                    if (MemoF = false) then
                        FromServContractLine.SetFilter("Invoiced Quantity", '%1', 0);

                    IF FromServContractLine.FINDSET THEN
                        REPEAT
                            FromServContractLineTemp.INIT;
                            FromServContractLineTemp.TRANSFERFIELDS(FromServContractLine);
                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;

                            FromServContractLineTemp.VALIDATE("No.", FromServContractLineTemp."No.");

                            UnitCost := FromServContractLineTemp."Unit Cost";
                            FromServContractLineTemp.TRANSFERFIELDS(FromServContractLine);

                            FromServContractLineTemp."Unit Cost" := UnitCost;
                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;




                            FromServContractLineTemp.Quantity := FromServContractLineTemp.Quantity;
                            FromServContractLineTemp.VALIDATE("Outstanding Quantity", FromServContractLineTemp.Quantity);
                            FromServContractLineTemp.VALIDATE("Outstanding Qty. (Base)", FromServContractLineTemp."Outstanding Qty. (Base)");
                            FromServContractLineTemp.VALIDATE("Qty. to Invoice", FromServContractLineTemp.Quantity);

                            // FromServContractLineTemp.VALIDATE("Qty. to Ship",FromServContractLineTemp.Quantity);


                            FromServContractLineTemp.INSERT;
                            ServiceLineNo.Reset();
                            ServiceLineNo.SetFilter("Document No.", '%1', FromServContractLineTemp."Document No.");
                            ServiceLineNo.SetFilter("Document Type", '%1', FromServContractLineTemp."Document Type");
                            ServiceLineNo.SetFilter("Line No.", '%1', FromServContractLineTemp."Line No.");
                            if not ServiceLineNo.FindFirst() then begin
                                Commit();
                                ServiceLineNo.init;
                                ServiceLineNo.TransferFields(FromServContractLineTemp);
                                ServiceLineNo.Insert();
                                Commit();
                            end;

                        UNTIL FromServContractLine.NEXT = 0;



                END;

            DocType::"Posted Invoice Service":
                BEGIN
                    NextLineNo := NextLineNo + 10000;
                    FromServContractLineTemp.INIT;
                    FromServContractLineTemp."Line No." := NextLineNo;
                    FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                    FromServContractLineTemp."Document No." := ServHeader."No.";
                    FromServContractLineTemp.Description := STRSUBSTNO(Text015, SELECTSTR(2, Text013), DocNo);
                    FromServContractLine2.RESET;
                    FromServContractLine2.SETFILTER("Document No.", '%1', FromServContractLineTemp."Document No.");
                    FromServContractLine2.SETFILTER("Line No.", '%1', FromServContractLineTemp."Line No.");
                    IF NOT FromServContractLine2.FINDFIRST THEN begin
                        ServiceLineNo.Reset();
                        ServiceLineNo.SetFilter("Document No.", '%1', FromServContractLineTemp."Document No.");
                        ServiceLineNo.SetFilter("Document Type", '%1', FromServContractLineTemp."Document Type");
                        ServiceLineNo.SetFilter("Line No.", '%1', FromServContractLineTemp."Line No.");
                        if not ServiceLineNo.FindFirst() then begin
                            Commit();
                            ServiceLineNo.init;
                            ServiceLineNo.TransferFields(FromServContractLineTemp);
                            ServiceLineNo.Insert();
                            Commit();
                        end;
                        FromServContractLineTemp.INSERT;
                    end;

                    ServiceInvoiceLine.RESET;
                    ServiceInvoiceLine.SETFILTER("Document No.", '%1', DocNo);
                    ServiceInvoiceLine.SETFILTER("No.", '<>%1', '');
                    IF ServiceInvoiceLine.FINDSET THEN
                        REPEAT
                            FromServContractLineTemp.INIT;

                            FromServContractLineTemp.TRANSFERFIELDS(ServiceInvoiceLine);
                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;

                            FromServContractLineTemp.VALIDATE("No.", FromServContractLineTemp."No.");

                            UnitCost := FromServContractLineTemp."Unit Cost";
                            FromServContractLineTemp.TRANSFERFIELDS(ServiceInvoiceLine);
                            FromServContractLineTemp."Unit Cost" := UnitCost;
                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;


                            FromServContractLineTemp.Quantity := FromServContractLineTemp.Quantity;
                            FromServContractLineTemp.VALIDATE("Outstanding Quantity", FromServContractLineTemp.Quantity);
                            FromServContractLineTemp.VALIDATE("Outstanding Qty. (Base)", FromServContractLineTemp."Outstanding Qty. (Base)");
                            FromServContractLineTemp.VALIDATE("Qty. to Invoice", FromServContractLineTemp.Quantity);
                            //  FromServContractLineTemp.VALIDATE("Qty. to Ship",FromServContractLineTemp.Quantity);
                            FromServContractLineTemp.INSERT;

                            ServiceLineNo.Reset();
                            ServiceLineNo.SetFilter("Document No.", '%1', FromServContractLineTemp."Document No.");
                            ServiceLineNo.SetFilter("Document Type", '%1', FromServContractLineTemp."Document Type");
                            ServiceLineNo.SetFilter("Line No.", '%1', FromServContractLineTemp."Line No.");
                            if not ServiceLineNo.FindFirst() then begin
                                Commit();
                                ServiceLineNo.init;
                                ServiceLineNo.TransferFields(FromServContractLineTemp);
                                ServiceLineNo.Insert();
                                Commit();
                            end;

                        UNTIL ServiceInvoiceLine.NEXT = 0;




                END;
            DocType::"Posted Credit Memo":
                BEGIN
                    NextLineNo := NextLineNo + 10000;
                    FromServContractLineTemp.INIT;
                    FromServContractLineTemp."Line No." := NextLineNo;
                    FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                    FromServContractLineTemp."Document No." := ServHeader."No.";
                    FromServContractLineTemp.Description := STRSUBSTNO(Text015, SELECTSTR(4, Text013), DocNo);
                    FromServContractLine2.RESET;
                    FromServContractLine2.SETFILTER("Document No.", '%1', FromServContractLineTemp."Document No.");
                    FromServContractLine2.SETFILTER("Line No.", '%1', FromServContractLineTemp."Line No.");
                    IF NOT FromServContractLine2.FINDFIRST THEN begin
                        FromServContractLineTemp.INSERT;
                        ServiceLineNo.Reset();
                        ServiceLineNo.SetFilter("Document No.", '%1', FromServContractLineTemp."Document No.");
                        ServiceLineNo.SetFilter("Document Type", '%1', FromServContractLineTemp."Document Type");
                        ServiceLineNo.SetFilter("Line No.", '%1', FromServContractLineTemp."Line No.");
                        if not ServiceLineNo.FindFirst() then begin
                            Commit();
                            ServiceLineNo.init;
                            ServiceLineNo.TransferFields(FromServContractLineTemp);
                            ServiceLineNo.Insert();
                            Commit();
                        end;
                    end;


                    ServiceCrMemoLine.RESET;
                    ServiceCrMemoLine.SETFILTER("Document No.", '%1', DocNo);
                    ServiceCrMemoLine.SETFILTER("No.", '<>%1', '');
                    IF ServiceCrMemoLine.FINDSET THEN
                        REPEAT
                            FromServContractLineTemp.INIT;
                            FromServContractLineTemp.TRANSFERFIELDS(ServiceCrMemoLine);
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;

                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;

                            FromServContractLineTemp.VALIDATE("No.", FromServContractLineTemp."No.");
                            UnitCost := FromServContractLineTemp."Unit Cost";
                            FromServContractLineTemp.TRANSFERFIELDS(ServiceCrMemoLine);
                            FromServContractLineTemp."Unit Cost" := UnitCost;
                            FromServContractLineTemp."Document No." := ServHeader."No.";
                            FromServContractLineTemp."Document Type" := ServHeader."Document Type";
                            NextLineNo := NextLineNo + 10000;
                            FromServContractLineTemp."Line No." := NextLineNo;
                            FromServContractLineTemp."Appl.-to Service Entry" := 0;
                            FromServContractLineTemp."Service Item Line No." := 0;

                            FromServContractLineTemp.Quantity := FromServContractLineTemp.Quantity;
                            FromServContractLineTemp.VALIDATE("Outstanding Quantity", FromServContractLineTemp.Quantity);
                            FromServContractLineTemp.VALIDATE("Outstanding Qty. (Base)", FromServContractLineTemp."Outstanding Qty. (Base)");
                            FromServContractLineTemp.VALIDATE("Qty. to Invoice", FromServContractLineTemp.Quantity);
                            // FromServContractLineTemp.VALIDATE("Qty. to Ship",FromServContractLineTemp.Quantity);

                            FromServContractLineTemp.INSERT;
                            ServiceLineNo.Reset();
                            ServiceLineNo.SetFilter("Document No.", '%1', FromServContractLineTemp."Document No.");
                            ServiceLineNo.SetFilter("Document Type", '%1', FromServContractLineTemp."Document Type");
                            ServiceLineNo.SetFilter("Line No.", '%1', FromServContractLineTemp."Line No.");
                            if not ServiceLineNo.FindFirst() then begin
                                Commit();
                                ServiceLineNo.init;
                                ServiceLineNo.TransferFields(FromServContractLineTemp);
                                ServiceLineNo.Insert();
                                Commit();
                            end;
                        UNTIL ServiceCrMemoLine.NEXT = 0;



                END;
        END;
    end;

    procedure GetNoSeriesCode(): Code[10]
    begin
        EXIT(ServSetup."Service Credit Memo Nos.");
    end;

    procedure GetPostingNoSeriesCode(): Code[10]
    begin

        EXIT(ServSetup."Posted Serv. Credit Memo Nos.");
    end;

    procedure ServHeaderDocType(DocType: Option): Integer
    var
        ServiceHeaderE: Record "Service Header";
    begin
        CASE DocType OF
            ServDocType2::Quote:
                EXIT(ServiceHeaderE."Document Type"::Quote);
            ServDocType2::Invoice:
                EXIT(ServiceHeaderE."Document Type"::Invoice);
            ServDocType2::"Credit Memo":
                EXIT(ServiceHeaderE."Document Type"::"Credit Memo");
            ServDocType2::Order:
                EXIT(ServiceHeaderE."Document Type"::Order);
        END;
    end;
}