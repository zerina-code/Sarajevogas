tableextension 50062 SalesHeaderExtends extends "Sales Header"
{

    fields
    {
        //    VAT Base (retro.)
        field(50006; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }
        modify("Posting Date")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                SL: Record "Sales Line";
            begin
                SL.reset;
                SL.SetFilter("Fiscal printed", '%1', false);
                sl.SetFilter("Cargo done", '%1', false);
                SL.SetFilter("Document No.", '%1', rec."Document No_");
                if sl.findset then
                    repeat
                        sl."Posting Date2" := rec."Posting Date";
                        sl.Modify();
                    until sl.Next() = 0;
            end;
        }
        field(50079; "Bin Checked"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50007; "Internal Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50008; "Prepayment"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(50015; "Due Date 2"; Date)
        {

            DataClassification = ToBeClassified;

        }

        field(50016; "Due Date 3"; Date)
        {

            DataClassification = ToBeClassified;

        }
        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
        }

        field(828; "Internal Customer"; Boolean)
        {
            Caption = 'Internal Customer';
        }



        field(50018; "Payment Terms Code 3"; Code[10])
        {

            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin

                IF ("Payment Terms Code 3" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code 3");
                    IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                        NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                    THEN BEGIN
                        //INT1.00 start
                        VALIDATE("Due Date 3", "Document Date");
                        //INT1.00 end
                    END ELSE BEGIN
                        IF "Payment Terms Code 3" <> '' THEN
                            "Due Date 3" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date 2")
                        ELSE
                            "Due Date 3" := 0D;
                    END;
                END ELSE BEGIN
                    VALIDATE("Due Date", "Due Date");
                    IF "Payment Terms Code 3" <> '' THEN
                        VALIDATE("Due Date 3", "Due Date 3")
                    ELSE
                        VALIDATE("Due Date 3", 0D);
                END;
            end;
        }


        field(50017; "Payment Terms Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin

                IF ("Payment Terms Code 2" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code 2");
                    IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                        NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                    THEN BEGIN
                        //INT1.00 start
                        VALIDATE("Due Date 2", "Document Date");
                        //INT1.00 end
                    END ELSE BEGIN
                        IF "Payment Terms Code 2" <> '' THEN
                            "Due Date 2" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date")
                        ELSE
                            "Due Date 2" := 0D;
                    END;
                END ELSE BEGIN
                    VALIDATE("Due Date", "Due Date");
                    IF "Payment Terms Code 2" = '' THEN
                        VALIDATE("Due Date 2", 0D)
                    ELSE
                        VALIDATE("Due Date 2", "Due Date 2");
                END;


            end;
        }
        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Document Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Total Value Letters"; Text[2])
        {
            Caption = 'Total Value Letters';
        }
        field(50027; "Country of Origin"; Code[20])
        {
            Caption = 'Country of Origin';
            TableRelation = "Country/Region";
        }
        field(50025; "Total Packaging"; Text[2])
        {
            Caption = 'Total Packaging';
        }
        field(50033; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50028; "Note 1"; Text[250])
        {
            Caption = 'Note 1';
        }
        field(50029; "Note 2"; Text[250])
        {
            Caption = 'Note 2';
        }
        field(50030; "Note 3"; Text[250])
        {
            Caption = 'Note 3';
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                TM2: Record Template_Message;
                TM: Record Template_Message;
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeries: Record "No. Series Line";
                CustI: record Customer;

            begin
                Commit();
                SalesSetup.get;
                Rec.Picture := SalesSetup.Picture;
                if Prepayment = true then begin
                    if "Document Type" = "Document Type"::"Credit Memo" then
                        "Posting Description" := 'Storno avansne fakture ' + Rec."No."
                    else
                        "Posting Description" := 'Avansna Faktura ' + Rec."No.";
                end;
                CompanyInfo.get;
                customer.Reset;
                customer.SetFilter("No.", '%1', "Sell-to Customer No.");
                if customer.FindFirst() then begin
                    "Customer Category" := customer."Customer Category";

                    "Internal Customer" := customer."Internal Customer";
                    if strpos(customer."Gen. Bus. Posting Group", 'INO') <> 0 then
                        "Note 1" := CompanyInfo."Note 1";
                    "Note 2" := CompanyInfo."Note 2";
                    Orderer := customer.Orderer;
                    "Order person" := customer."Order person";
                    "Responsible Person" := customer."Responsible Person";
                    "Contract Number" := customer."Contract Number";
                    Designer := customer.Designer;
                    "Project manager" := customer."Project manager";
                    "Responsible Person Infodom" := customer."Responsible Person Infodom";
                    "Message Code" := customer."Message Code";

                    if "Message Code" <> '' then begin
                        TM2.Reset();
                        TM2.SetFilter("Message Code", '%1', Rec."Message Code");
                        TM2.SetFilter(CustomerCOde, '%1', customer."No.");
                        // TemplateM2.SetFilter(Type, '%1', TemplateM2.Type::"Mail notification");
                        if TM2.FindFirst() then begin

                            TM.Init();
                            TM.TransferFields(TM2);
                            TM2.CalcFields("Message Text");
                            TM."Document No." := rec."No.";
                            TM.CustomerCOde := '';
                            TM."Message Text" := TM2."Message Text";


                            if Rec."No." = '' then begin
                                SalesSetup.Get();
                                NoSeries.Reset();
                                NoSeries.SetFilter("Series Code", '%1', SalesSetup."Order Nos.");
                                NoSeries.SetFilter("Starting Date", '<=%1', Today);
                                NoSeries.SetCurrentKey("Starting Date");
                                NoSeries.Ascending;
                                if NoSeries.FindLast() then begin
                                    TM."Document No." := IncStr(NoSeries."Last No. Used");
                                end;


                            end;
                            TM.Insert();
                        end;

                    end;
                end;
                SalesSetup.get;
                if Prepayment = true then begin
                    validate("Posting No. Series", SalesSetup."Posted Prepmt. Inv. Nos.");
                    "Posting No. Series" := SalesSetup."Posted Prepmt. Inv. Nos.";
                end

            end;
        }
        field(50031; "Orderer"; text[1000])
        {
            Caption = 'Orderer';
        }
        field(50032; "Contract Number"; Text[1000])
        {
            Caption = 'Contract Number';
        }
        field(50034; "Order person"; Text[1000])
        {
            Caption = 'Order person';
        }
        field(50035; "Responsible Person"; Text[1000])
        {
            Caption = 'Responsible Person';

        }
        field(50036; "Designer"; Text[1000])
        {
            Caption = 'Designer';
        }
        field(50037; "Project manager"; Text[1000])
        {
            Caption = 'Project manager';
        }
        field(50038; "HD Number"; Text[1000])
        {
            Caption = 'HD Number';
        }
        field(50039; "Area covered by changes"; Text[1000])
        {
            Caption = 'Area covered by changes';
        }
        field(50040; "Person/hours"; Text[1000])
        {
            Caption = 'Person/hours';
        }
        field(50041; "Amount without VAT"; Decimal)
        {
            Caption = 'Amount without VAT';
        }
        field(50042; "Deadline"; Text[1000])
        {
            Caption = 'Deadline';
        }
        field(50043; "seriousness"; Integer)
        {
            Caption = 'seriousness';
        }
        field(50044; "CR included"; Boolean)
        {
            Caption = 'CR';
        }
        field(50045; "Responsible Person Infodom"; Text[1000])
        {
            Caption = 'Responsible Person Infodom';
        }
        field(50046; "Templates for CR"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Templates for CR';
            CalcFormula = count(Template_Message where("Type" = FILTER(3 | 2), "Document No." = field("No.")));

        }
        field(50047; "Message Code"; Text[30])
        {
            TableRelation = Template_Message."Message Code" where("Type" = filter("Mail notification"), "Document No." = field("No."));
            Caption = 'Message Code';
        }
        /*  field(50048; "Documents"; Integer)
          {
              FieldClass = FlowField;
              Caption = 'Documents';
              CalcFormula = count(Documents where("Document No" = field("No.")));
          }*/
        field(50049; "Payment Type Invoice"; Code[10]) //ED
        {
            Caption = 'Payment Type Invoice';
            TableRelation = "Customer Templ.";
        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";

            trigger OnValidate()
            var
                CustomerTemp: Record "Customer Templ.";
            begin
                CustomerTemp.GET("bill type");
                If CustomerTemp."Bill Category" = CustomerTemp."Bill Category"::Resource
                then
                    "Customer Posting Group" := 'USLUGE';

            end;
        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(50051; "Created Receipt"; Boolean)
        {
            Caption = 'Created Receipt';
        }
        field(50052; "Posted Receipt"; Boolean)
        {
            Caption = 'Posted Receipt';
        }
        field(50053; "Posted Purchase"; Boolean)
        {
            Caption = 'Posted Purchase';
        }
        field(50059; "Transfer Receipt Created"; Boolean)
        {
            Caption = 'Transfer Receipt Created';
        }
        field(50060; "Posted Transfer Order"; Boolean)
        {
            Caption = 'Posted Transfer Order';
        }
        field(50061; "Payment Reference"; Text[50])
        {
            Caption = 'Payment Reference';
        }
        field(50062; "New Price"; Decimal)
        {
            Caption = 'New Price';

            trigger OnValidate()
            var
                myInt: Integer;
                SalesL: Record "Sales Line";
            begin




            end;


        }
        field(50063; "Old Price Date"; Date)
        {
            Caption = 'Old Price Date';


        }
        field(50065; "Fiscal printed"; Boolean)
        {
            Caption = 'Fiscal printed';
        }
        field(50067; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }

        field(50066; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50068; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50069; "Document No_"; COde[22])
        {
            Caption = 'Document No_';
            DataClassification = ToBeClassified;

        }

        field(50070; "Subsidies"; Boolean)
        {
            Caption = 'Subsidies - yes';
        }
        field(50071; "Subsidies Amount"; Decimal)
        {
            Caption = 'Subsidies Amount';
        }
        field(50072; "Subsidies Line"; Integer)
        {
            Caption = 'Subsidies Line';
            FieldClass = FlowField;
            CalcFormula = count("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), Subsidies = filter(false)));
        }

        field(50073; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(50074; "Invoice Responsible Person"; Text[250])
        {
            Caption = 'Invoice Responsible Person';
        }
        field(50075; "Invoice Responsible Code"; Code[20])
        {
            Caption = 'Invoice Responsible Code';
        }
        field(50076; "Invoice Position Descr"; Text[250])
        {
            Caption = 'Invoice Position Descr';
        }
        field(50077; "KIF_Entry"; code[20])

        {
            Caption = 'KIF Entry';
        }

        field(50011; "Posting Employee USERID"; code[250])

        {
            Caption = 'Posting Employee USERID';

        }
        field(50012; "Control Employee USERID"; code[250])

        {
            Caption = 'Control Employee USERID';

        }
        field(50013; "Exe Employee USERID"; code[20])

        {
            Caption = 'Exe Employee USERID';

        }
        field(50014; "Remark for CR Memo"; Text[250])

        {
            Caption = 'Remark for CR Memo';

        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(50100; "Billing Credit Memo"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Credit Memo';

        }
        field(50101; "Billing Created"; Boolean)
        {
            Caption = 'Billing Created';
        }
        field(50102; "CZK Request"; code[20])
        {
            Caption = 'CZK Request';
        }

        field(50103; "CZK Credit Memo"; Boolean)
        {
            Caption = 'CZK Credit Memo';
        }






    }




    trigger OnModify()
    var
        myInt: Integer;
    begin

        if "No." <> '' then
            "Document No_" := "No." + '\' + format(copystr(format(Date2DMY("Posting Date", 3)), 3, 2));

    end;

    trigger OnInsert()
    var
        myInt: Integer;
        //CustomerRecord: Record "Customer Template";
        salesSetup: Record "Sales & Receivables Setup";
        CustTemp: record "Customer Templ.";
    begin
        if "Bill type" <> '' then begin

            CustTemp.Reset();
            CustTemp.SetFilter(Code, '%1', "Bill type");
            if CustTemp.FindFirst() then begin
                if rec."Document Type" = rec."Document Type"::Order then begin
                    "Posting No. Series" := CustTemp."Posting No. Series Bill";
                    validate("No. Series", CustTemp."No. Series Bill");
                end;

                if rec."Document Type" = rec."Document Type"::"Credit Memo" then begin
                    "Posting No. Series" := CustTemp."Undo Posting No. Series Bill";
                    validate("No. Series", CustTemp."Undo No. Series Bill");
                end;
                If CustTemp."Bill Category" = CustTemp."Bill Category"::Resource
                                then
                    "Customer Posting Group" := 'USLUGE';

            end;

        end;


        if "No." <> '' then
            "Document No_" := "No." + '\' + format(copystr(format(Date2DMY("Posting Date", 3)), 3, 2));
        "Assigned User ID" := UserId;

        "VAT Date" := Today;
        "Language Code" := 'HRV';
        CompanyInfo.get;



        if Prepayment = true then begin

            salesSetup.Get();
            IF "Document Type" = "Document Type"::Invoice then begin

                "Posting Description" := 'Avansna Faktura ' + Rec."No.";
                "Posting No. Series" := salesSetup."Posted Prepmt. Inv. Nos."


            end


            ELSE
                if "Document Type" = "Document Type"::"Credit Memo" then begin
                    "Posting Description" := 'Storno avansne fakture ' + Rec."No.";
                    "Posting No. Series" := salesSetup."Posted Prepmt. Cr. Memo Nos."

                end


                else
                    "Posting No. Series" := salesSetup."Posted Prepmt. Cr. Memo Nos."
        end;


        /* "Note 1" := CompanyInfo."Note 1";
         "Note 2" := CompanyInfo."Note 2";*/


    end;


    /*  local  procedure InitRecord2()
    var
        ArchiveManagement: Codeunit "ArchiveManagement";
        IsHandled: Boolean;
          SalesSetup: Record "Sales & Receivables Setup";
          NoSeriesMgt: Codeunit "NoSeriesManagement";
          UserSetupMgt : Codeunit "User Setup Management";
          Cust: Record Customer;
          GLSetup: Record "General Ledger Setup";

    begin
   
        SalesSetup.GET;
        IsHandled := FALSE;
        OnBeforeInitRecord(Rec,IsHandled);
        IF NOT IsHandled THEN
          CASE "Document Type" OF
            "Document Type"::Quote,"Document Type"::Order:
              BEGIN
                NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
                NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",SalesSetup."Posted Prepmt. Inv. Nos.");
                  NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",SalesSetup."Posted Prepmt. Cr. Memo Nos.");
                END;
              END;
            "Document Type"::Invoice:
              BEGIN
                IF ("No. Series" <> '') AND
                   (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
                THEN
                  "Posting No. Series" := "No. Series"
                ELSE
                  NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                  NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
              END;
            "Document Type"::"Return Order":
              BEGIN
                NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
              END;
            "Document Type"::"Credit Memo":
              BEGIN
                IF ("No. Series" <> '') AND
                   (SalesSetup."Credit Memo Nos." = SalesSetup."Posted Credit Memo Nos.")
                THEN
                  "Posting No. Series" := "No. Series"
                ELSE
                  NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
                IF SalesSetup."Return Receipt on Credit Memo" THEN
                  NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
              END;
          END;

        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote] THEN
          BEGIN
          "Shipment Date" := WORKDATE;
          "Order Date" := WORKDATE;
        END;
        IF "Document Type" = "Document Type"::"Return Order" THEN
          "Order Date" := WORKDATE;

        IF NOT ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
           ("Posting Date" = 0D)
        THEN
          "Posting Date" := WORKDATE;

        IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN
          "Posting Date" := 0D;

        "Document Date" := WORKDATE;
        IF "Document Type" = "Document Type"::Quote THEN
          CalcQuoteValidUntilDate;

        VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

        IF IsCreditDocType THEN BEGIN
          GLSetup.GET;
          Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;

        "Posting Description" := FORMAT("Document Type") + ' ' + "No.";

        UpdateOutboundWhseHandlingTime;

        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,"Responsibility Center");
        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");

        OnAfterInitRecord(Rec);
    end;
    */
    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        customer: Record Customer;
        ConfirmLbl: Label 'Do you want to update a new price?';


}