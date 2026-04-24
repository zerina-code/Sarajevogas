tableextension 50063 salesLineExtends extends "Sales Line"
{

    fields
    {
        //    VAT Base (retro.)
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50001; "Manufacturer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }
        field(50049; "Payment Type Invoice"; Code[10]) //ED
        {
            Caption = 'Payment Type Invoice';
            TableRelation = "Customer Templ.";
        }
        field(50050; "Fiscal printed"; Boolean)
        {
            Caption = 'Fiscal printed';


        }
        field(50200; "CNG BLG"; Boolean)
        {
            Caption = 'CNG BLG';
        }
        field(50051; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                SalesShipmentLine: Record "Sales Shipment Line";
                GLSetup: Record "General Ledger Setup";
                T_GJL: Record "Gen. Journal Line";
                LineNo: Integer;
                SH: Record "Sales Header";

                GenJBatch: Record "Gen. Journal Batch";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                Docno: text[250];
            begin

                SalesShipmentLine.Reset();
                SalesShipmentLine.SetFilter(Quantity, '%1', rec.Quantity);
                SalesShipmentLine.SetFilter("Order No.", '%1', rec."Document No.");
                SalesShipmentLine.SetFilter("Order Line No.", '%1', rec."Line No.");
                if SalesShipmentLine.FindSet() then
                    repeat
                        SalesShipmentLine."Fiscal No." := rec."Fiscal No.";
                        SalesShipmentLine."Fiscal printed" := rec."Fiscal printed";
                        SalesShipmentLine."Fiscal User" := rec."Fiscal User";
                        SalesShipmentLine."Fiscal DateTime" := rec."Fiscal DateTime";
                        RecRef.GetTable(SalesShipmentLine);
                        RecordRefExample.ModifyRecords(RecRef);
                    until SalesShipmentLine.Next() = 0;

                if ((Rec."Payment Method Code" = 'GOTOVINA') or (Rec."Payment Method Code" = 'KARTIČNO')) and (rec."CNG BLG" = false) then begin

                    GLSetup.GET;
                    T_GJL.SETFILTER("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");

                    T_GJL.SETFILTER("Journal Batch Name", '%1', GLSetup."Cash Batch Name");
                    IF T_GJL.FIND('+') THEN
                        LineNo := T_GJL."Line No." + 100
                    ELSE
                        LineNo := 100;
                    T_GJL.validate("Journal Template Name", GLSetup."Cash Receipt Journal Template");
                    T_GJL.validate("Journal Batch Name", GLSetup."Cash Batch Name");
                    T_GJL.validate("Document Type", T_GJL."Document Type"::Payment);
                    sh.get("Document Type", "Document No.");
                    T_GJL.Validate("Payment Type", sh."Bill type");
                    T_GJL.validate("Bill type", sh."Bill type");
                    T_GJL.validate("Bill Category", sh."Bill Category");
                    T_GJL.validate("Account Type", T_GJL."Account Type"::"Customer");
                    T_GJL.validate("Account No.", Rec."Bill-to Customer No.");

                    T_GJL."Line No." := LineNo;

                    T_GJL.validate("Posting Date", Rec."Posting Date2");
                    T_GJL.validate("Document Date", Rec."Posting Date2");
                    T_GJL.Validate("Payment Method Code", Rec."Payment Method Code");


                    GenJBatch.Reset();
                    GenJBatch.SetFilter("Journal Template Name", '%1', GLSetup."Cash Receipt Journal Template");
                    GenJBatch.SetFilter(Name, '%1', GLSetup."Cash Batch Name");
                    if GenJBatch.FindFirst() then
                        Docno := NoSeriesMgt.GetNextNo(GenJBatch."No. Series", Rec."Posting Date", false);



                    T_GJL."Document No." := Docno;
                    T_GJL.VALIDATE("External Document No.", Rec."Document No.");
                    T_GJL.Description := '';
                    T_GJL.VALIDATE(Amount, -abs(round(Rec."Amount Including VAT", 0.01, '=')));
                    //   T_GJL.VALIDATE("Posting Group", "Customer Posting Group");

                    T_GJL.Validate("Bal. Account Type", GenJBatch."Bal. Account Type"::"Bank Account");
                    T_GJL.Validate("Bal. Account No.", GenJBatch."Bal. Account No.");
                    T_GJL.validate("Posting Date", Rec."Posting Date2");
                    T_GJL.validate("Document Date", Rec."Posting Date2");
                    IF (Rec."Payment Method Code" = 'GOTOVINA') or (Rec."Payment Method Code" = 'KARTIČNO') then begin
                        if strpos(T_GJL."External Document No.", '08-') <> 0 then begin
                            T_GJL."Bill type" := '08';
                            T_GJL."Payment Type" := '08';
                        end;

                        if strpos(T_GJL."External Document No.", '04-') <> 0 then begin
                            T_GJL."Bill type" := '04';
                            T_GJL."Payment Type" := '04';
                        end;
                        T_GJL.INSERT(TRUE);
                        LineNo += 100;
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post Line", T_GJL);
                        Rec."CNG BLG" := true;
                    end;

                end;
            end;

        }
        field(50052; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                SalesShipmentLine: Record "Sales Shipment Line";
            begin
                SalesShipmentLine.Reset();
                SalesShipmentLine.SetFilter(Quantity, '%1', rec.Quantity);
                SalesShipmentLine.SetFilter("Order No.", '%1', rec."Document No.");
                SalesShipmentLine.SetFilter("Order Line No.", '%1', rec."Line No.");
                if SalesShipmentLine.FindSet() then
                    repeat
                        SalesShipmentLine."Fiscal No." := rec."Fiscal No.";
                        SalesShipmentLine."Fiscal printed" := rec."Fiscal printed";
                        SalesShipmentLine."Fiscal User" := rec."Fiscal User";
                        SalesShipmentLine."Fiscal DateTime" := rec."Fiscal DateTime";
                        RecRef.GetTable(SalesShipmentLine);
                        RecordRefExample.ModifyRecords(RecRef);
                    until SalesShipmentLine.Next() = 0;
            end;
        }

        field(50053; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                SalesShipmentLine: Record "Sales Shipment Line";
            begin
                SalesShipmentLine.Reset();
                SalesShipmentLine.SetFilter(Quantity, '%1', rec.Quantity);
                SalesShipmentLine.SetFilter("Order No.", '%1', rec."Document No.");
                SalesShipmentLine.SetFilter("Order Line No.", '%1', rec."Line No.");
                if SalesShipmentLine.FindSet() then
                    repeat
                        SalesShipmentLine."Fiscal No." := rec."Fiscal No.";
                        SalesShipmentLine."Fiscal printed" := rec."Fiscal printed";
                        SalesShipmentLine."Fiscal User" := rec."Fiscal User";
                        SalesShipmentLine."Fiscal DateTime" := rec."Fiscal DateTime";
                        RecRef.GetTable(SalesShipmentLine);
                        RecordRefExample.ModifyRecords(RecRef);
                    until SalesShipmentLine.Next() = 0;
            end;
        }
        field(50054; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record Customer;
            begin
                if ("Type of vehicle" = "Type of vehicle"::"Cargo vehicles") and (rec."Driver type" = rec."Driver type"::Internal) then begin

                    Cust.GET("Sell-to Customer No.");
                    IF Cust."Internal Customer" then
                        validate("VAT Prod. Posting Group", 'PDV0');

                end;

            end;
        }



        field(50055; "Vehicle Registration"; Text[250])
        {
            Caption = 'Vehicle Registration';
        }
        field(50058; "VAT Difference CNG"; Decimal)
        {
            Caption = 'VAT Difference CNG';
            DecimalPlaces = 1 : 10;
        }

        field(50056; "Driver type"; Option)
        {
            Caption = 'Driver type';
            OptionCaption = ' ,External,Internal';
            OptionMembers = " ",External,Internal;

            trigger OnValidate()
            var
                myInt: Integer;
                EmployeeD: Record Employee;
                ContactD: Record Contact;
                Cust: Record Customer;
            begin

                if ("Type of vehicle" = "Type of vehicle"::"Cargo vehicles") and (rec."Driver type" = rec."Driver type"::Internal) then begin

                    Cust.GET("Sell-to Customer No.");
                    IF Cust."Internal Customer" then
                        validate("VAT Prod. Posting Group", 'PDV0');

                end;


                if "Driver type" = "Driver type"::Internal then begin
                    EmployeeD.Reset();
                    EmployeeD.SetFilter("No.", '%1', "Driver ID");
                    if EmployeeD.FindFirst() then
                        "Driver Name" := EmployeeD."First Name" + ' ' + EmployeeD."Last Name"
                    else
                        "Driver Name" := '';

                end
                else begin
                    ContactD.Reset();
                    ContactD.SetFilter("No.", '%1', "Driver ID");
                    ContactD.SetFilter("Type Relation", '%1', ContactD."Type Relation"::Driver);
                    if ContactD.FindFirst() then
                        "Driver Name" := ContactD.Name
                    else
                        "Driver Name" := '';


                end;

            end;
        }
        field(50057; "Driver ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver ID';
            TableRelation = if ("Driver type" = const(Internal)) Employee where("CNG Employee" = filter(true), StatusExt = filter(Active))
            else
            Contact where("Type Relation" = filter(Driver), "Active CNG" = filter(true));
            trigger OnValidate()
            var
                myInt: Integer;
                EmployeeD: Record Employee;
                ContactD: Record Contact;
            begin

                if "Driver type" = "Driver type"::Internal then begin
                    EmployeeD.Reset();
                    EmployeeD.SetFilter("No.", '%1', "Driver ID");
                    if EmployeeD.FindFirst() then begin
                        "Driver Name" := EmployeeD."First Name" + ' ' + EmployeeD."Last Name";


                    end

                    else begin
                        "Driver Name" := '';

                    end;


                end
                else begin
                    ContactD.Reset();
                    ContactD.SetFilter("No.", '%1', "Driver ID");
                    ContactD.SetFilter("Type Relation", '%1', ContactD."Type Relation"::Driver);
                    if ContactD.FindFirst() then begin

                        "Driver Name" := ContactD.Name;

                    end
                    else begin

                        "Driver Name" := '';

                    end;





                end;
            end;







        }

        field(50578; "Driver Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Name';



        }
        field(50579; "Driver Registration No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';
            TableRelation = "Employee Statistics Group";
            trigger OnValidate()
            var
                myInt: Integer;
                ESG: Record "Employee Statistics Group";
            begin
                ESG.Reset();
                ESG.SetFilter(Code, '%1', "Driver Registration No.");
                if ESG.FindFirst() then begin
                    validate(Rec."Type of vehicle", esg."Type of vehicle");
                end;
            end;




        }
        field(50594; "Avans Amount"; Decimal)
        {
            Caption = 'Avans Amount';

            //đemina poruka: ovo polje sam morala prerangirati. Sig ti znaš zašto ti je ovo s validacijom zakucan broj, međutim zbog operacije transferfield i kreiranje iz prodajnih naloga u otpremnice i slično, postavila si bila da ti polje "Payment Method Code" 50580  (Sales Shipment Line) dodjeli ovu vrijednost u tvoje polje Avans koje je tipa decimal. Ne može se čak nastaviti ni knjižizi. Molim te pogledaj ovu poruku da znaš za ubuduće i slobodno je kasnije obriši.
            trigger OnValidate()

            begin

                validate("Unit price", "Avans Amount" - ("Avans Amount" * 14.5299 / 100));
                //Validate("Unit price");

            end;
        }

        field(50583; "Old Price"; Decimal)
        {

            Caption = 'Old Price';

            trigger Onvalidate()
            var
                myInt: Integer;
            begin


                //             Difference := Amount - "Total Old Price";


            end;


        }
        field(50584; "Difference"; Decimal)
        {

            Caption = 'Difference between New and Old Price';

        }

        field(50585; "R. Fiscal printed"; Boolean)
        {
            Caption = 'R. Fiscal printed';
        }
        field(50586; "R. Fiscal No."; COde[20])
        {
            Caption = 'R. Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50587; "R. Fiscal DateTime"; DateTime)
        {
            Caption = 'R. Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50588; "R. Fiscal User"; COde[250])
        {
            Caption = 'R. Fiscal User';
            DataClassification = ToBeClassified;

        }


        field(50589; "New Fiscal printed"; Boolean)
        {
            Caption = 'New Fiscal printed';
        }
        field(50590; "New Fiscal No."; COde[20])
        {
            Caption = 'New Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50591; "New Fiscal DateTime"; DateTime)
        {
            Caption = 'New Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50592; "New Fiscal User"; COde[250])
        {
            Caption = 'New Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50593; "Total Old Price"; Decimal)
        {

            Caption = 'Total Old Price';

            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                //    Difference := Amount - "Total Old Price";

            end;



        }

        field(50595; "Internal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Internal';


        }
        field(50596; "NN"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NN';


        }

        field(50597; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code';
            TableRelation = "Payment Method";

            trigger OnValidate()
            var
                SEPADirectDebitMandate: Record "SEPA Direct Debit Mandate";
                SH: Record "Sales Header";
                Cus: Record Customer;
            begin

                SH.Reset();
                SH.SetFilter("No.", '%1', "Document No.");
                Sh.SetFilter("Bill type", '%1', '04');
                if sh.FindFirst() then begin
                    Cus.Reset();
                    Cus.setfilter("No.", '%1', sh."Bill-to Customer No.");
                    if cus.FindFirst() then begin
                        if ((cus."Tax Liable" = true) and not (Cus."Internal Customer")) then begin
                            if "Payment Method Code" <> 'VIRMAN' then
                                Error('Način plaćanja kod pravnih lica mora biti virman!');

                        end;

                    end;


                end;

            end;
        }

        field(50598; "Subsidies"; Boolean)
        {
            Caption = 'Subsidies - yes';
        }
        field(50599; "Old Quantity"; Decimal)
        {
            Caption = 'Old Quantity';
        }

        field(50600; "Cargo done"; Boolean)
        {
            Caption = 'Cargo done';
        }
        field(50601; "Shipment create"; Boolean)
        {
            Caption = 'Shipment create';
        }
        field(50602; "New Price"; Boolean)
        {
            Caption = 'New Price';
        }
        field(50603; "Posting Date2"; date)
        {
            Caption = 'Posting Date2';
        }
        field(50604; "Cost Type"; Enum "Cost Type Enum")
        {
            DataClassification = ToBeClassified;
        }

        modify("Unit Price")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                US: Record "User Setup";
                GS: Record "General Ledger Setup";
                SHeader: Record "Sales Header";
                CustInternal: Record Customer;
            begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if US.findfirst then begin
                    if (us."CNG User") or (us."CNG Administrator") then begin
                        gs.get;
                        "Unit Price" := gs."CNG Amount Rounding Precision";

                        SHeader.Reset();
                        SHeader.SetFilter("No.", '%1', rec."Document No.");
                        SHeader.SetFilter("Document Type", '%1', rec."Document Type");
                        if SHeader.FindFirst() then begin
                            CustInternal.Reset();
                            CustInternal.setfilter("Customer Category", '%1', CustInternal."Customer Category"::CNG);
                            CustInternal.SetFilter("Internal Customer", '%1', true);
                            if CustInternal.FindFirst() then begin
                                //ĐK  if (SHeader."Bill-to Customer No." = CustInternal."No.") and (US."Type of vehicle" = "Type of vehicle"::"Cargo vehicles") then
                                //ĐK      "Unit Price" := gs."CNG Amount SG";
                            end;

                        end;
                        "Line Amount" := round("Unit Price" * Quantity, 0.0000000000001);
                        "Shipped Not Inv. (LCY) No VAT" := "Line Amount";
                        Amount := "Line Amount";
                        "VAT Base Amount" := "Line Amount";
                        "Amount Including VAT" := round("VAT Base Amount" * (1 + "VAT %" / 100), 0.0000000000001);
                        if (Round("Amount Including VAT" * 10000, 1) MOD 100 = 99) then
                            "Amount Including VAT" := Round("Amount Including VAT", 0.00001, '>');

                        "Shipped Not Invoiced" := "Amount Including VAT";
                        "Shipped Not Invoiced (LCY)" := "Amount Including VAT";
                    end;
                end;
            end;
        }

        modify("Location Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                Location: Record Location;
                SH: Record "Sales Header";
                Customer: Record Customer;
                SalesSetup: Record "Sales & Receivables Setup";
                US: Record "User Setup";
                Cust: Record Customer;
            begin



                //     Validate("No.", Rec."No.");
                if rec."Location Code" <> '' then begin
                    SH.Reset();
                    SH.SetFilter("No.", '%1', rec."Document No.");
                    sh.SetFilter("Document Type", '%1', rec."Document Type");
                    if sh.FindFirst() then begin
                        Location.Reset();
                        Location.SetFilter(Code, '%1', Location.Code);
                        if Location.FindFirst() then begin

                            sh."Invoice Responsible Code" := Location."Invoice Responsible Person";
                            sh."Invoice Responsible Person" := Location."Invoice Responsible Person N";
                            sh."Invoice Position Descr" := Location."Invoice Responsible Person Pos";

                        end;
                    end;

                end;
                SalesSetup.GET;
                IF SalesSetup."NN Customer Code" <> rec."Sell-to Customer No."
                then
                    rec."Payment Method Code" := 'VIRMAN'
                ELSE
                    rec."Payment Method Code" := '';

                Customer.SetFilter("No.", '%1', rec."Sell-to Customer No.");
                IF customer.FindFirst() then begin
                    IF Customer."Internal Customer" = TRUE
                    then
                        rec."Payment Method Code" := 'VLASTITA';
                end;
            end;
        }

        modify("Payment Method Code")
        {
            trigger OnAfterValidate()

            begin

            end;

        }


    }



    local procedure UpdateUnitPriceByField(CalledByFieldNo: Integer)
    var
        IsHandled: Boolean;
        PriceCalculation: Interface "Price Calculation";
    begin
        if not IsPriceCalcCalledByField(CalledByFieldNo) then
            exit;

        IsHandled := false;

        if IsHandled then
            exit;

        GetSalesHeader();
        TestField("Qty. per Unit of Measure");

        case Type of
            Type::Item,
            Type::Resource:
                begin
                    IsHandled := false;

                    if not IsHandled then begin
                        GetPriceCalculationHandler(PriceType::Sale, SalesHeader, PriceCalculation);
                        if not ("Copied From Posted Doc." and IsCreditDocType()) then begin
                            PriceCalculation.ApplyDiscount();
                            ApplyPrice(CalledByFieldNo, PriceCalculation);
                        end;
                    end;
                end;
        end;

        if "Copied From Posted Doc." and IsCreditDocType() and ("Appl.-from Item Entry" <> 0) then
            if xRec."Unit Price" <> "Unit Price" then
                if GuiAllowed then
                    ShowMessageOnce(StrSubstNo(UnitPriceChangedMsg, Type, "No."));

        Validate("Unit Price");

        ClearFieldCausedPriceCalculation();

    end;


    local procedure GetPriceCalculationHandler(PriceType: Enum "Price Type"; SalesHeader: Record "Sales Header"; var PriceCalculation: Interface "Price Calculation")
    var
        PriceCalculationMgt: codeunit "Price Calculation Mgt.";
        LineWithPrice: Interface "Line With Price";
    begin
        if (SalesHeader."No." = '') and ("Document No." <> '') then
            SalesHeader.Get("Document Type", "Document No.");
        GetLineWithPrice(LineWithPrice);
        LineWithPrice.SetLine(PriceType, SalesHeader, Rec);
        PriceCalculationMgt.GetHandler(LineWithPrice, PriceCalculation);
    end;

    local procedure ShowMessageOnce(MessageText: Text)
    begin
        TempErrorMessage.SetContext(Rec);
        if TempErrorMessage.FindRecord(RecordId, 0, TempErrorMessage."Message Type"::Warning, MessageText) = 0 then begin
            TempErrorMessage.LogMessage(Rec, 0, TempErrorMessage."Message Type"::Warning, MessageText);
            Message(MessageText);
        end;
    end;

    var
        SalesHeader: Record "Sales Header";
        SaleslineupdateCNG: Record "Sales Line";
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";
        TempErrorMessage: Record "Error Message" temporary;
        UnitPriceChangedMsg: Label 'The unit price for %1 %2 that was copied from the posted document has been changed.', Comment = '%1 = Type caption %2 = No.';
        PriceType: Enum "Price Type";

}
