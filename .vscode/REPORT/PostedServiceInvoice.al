/*
report 50148 "PostedServiceInvoice"
{
    // BH1.00, FAKTURA
    DefaultLayout = RDLC;
    RDLCLayout = './PostedServiceInvoice.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Service Invoice Header")
        {

            RequestFilterFields = "No.";
            column(No; "No.")
            {

            }

            column(Document_Date; FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(ShipmentDate; FORMAT("Order Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(FiscalNumber; "Fiscal No.") { }
            column(PageNoCaption; PageNoCaptionLbl) { }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(Project; Description) { }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(City; CompInfo.City) { }
            column(CompPage; CompInfo."Home Page")
            {

            }
            column(registrationNumber; registrationNumber) { }
            column(vatNumber; vatNumber) { }
            column(registrationVATNumber; registrationVATNumber) { }
            column(court; court) { }
            column(activityCode; activityCode) { }
            column(transBBI; transBBI) { }
            column(transIntesa; transIntesa) { }
            column(transRaif; transRaif) { }
            column(transUni; transUni) { }
            column(transactionPrivredna; transactionPrivredna) { }
            column(transUnion; transUnion) { }
            column(courtNumber; courtNumber) { }

            column(PhoneNo; CompInfo."Phone No.")

            {

            }
            column(PhoneNo2; CompInfo."Phone No. 2")
            {

            }
            column(FaxNo; CompInfo."Fax No.")
            {

            }
            column(Dispatch; CompInfo."Dispatch Center") { }
            column(CEO_Phone; CEO_Phone)
            {

            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CustomerName; Customer.Name)
            {

            }
            column(amount; amount) { }
            column(CustomerAddress; Customer.Address)
            {

            }
            column(CustomerCity; Customer."Post Code" + ' ' + Customer.City)
            {

            }
            column(totalAmount; totalAmount)
            {

            }
            column(vatAmount; vatAmount) { }
            column(Description; Description) { }


            dataitem(DataItem2; "Service Invoice Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);
                column(LineName;
                Description)
                { }
                column(UnitOfMeasure; GetBaseUoMText("No.")) { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(AmountWithoutVAT; Amount) { }

                trigger OnAfterGetRecord()
                var
                    invoiceNo: Record "Sales Invoice Header";
                    firstPart: Text;
                begin

                    vatAmount += "Amount Including VAT" - Amount;
                    totalAmount += "Amount Including VAT";
                    amount += Amount;

                end;

            }

            trigger OnPreDataItem()
            var

                sh: Record "Service Invoice Header";
                banacc: record "Bank Account";
            begin
                CompInfo.CALCFIELDS(Picture);
                CurrReport.PAGENO := 1;
                lineCounter := 2;
                sh.SetFilter("No.", '%1', GetFilter("No."));
                if sh.FindFirst() then begin
                    Customer.Get(sh."Customer No.");
                end;

                banacc.Reset();
                banacc.SetFilter("No.", 'BANK01');
                if banacc.FindFirst() then begin
                    transUni := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK02');
                if banacc.FindFirst() then begin
                    transUnion := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK05');
                if banacc.FindFirst() then begin
                    transRaif := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK06');
                if banacc.FindFirst() then begin
                    transBBI := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK03');
                if banacc.FindFirst() then begin
                    transIntesa := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'BANK07');
                if banacc.FindFirst() then begin
                    transactionPrivredna := banacc."Bank Account No.";
                end;
                registrationNumber := CompInfo."Registration No.";
                registrationVATNumber := CompInfo."VAT Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";
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
        trigger OnOpenPage()
        begin
            DataItem1.SetFilter("No.", RecNo);
        end;
    }

    labels
    {
    }



    trigger OnPreReport()
    begin
        CompInfo.GET;

    end;

    var
        RecNo: Code[20];
        CompInfo: Record "Company Information";
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        CEO_Phone: Text[100];
        Customer: Record Customer;
        InvoiceNos: Text;
        lineCounter: Integer;
        invoiceDescription: Text;
        transUnion: Text;
        transactionPrivredna: Text;
        transRaif: Text;
        transUni: Text;
        transIntesa: Text;
        transBBI: Text;
        court: Text;
        courtNumber: Text;
        numberOfDecision: Text;
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        vatAmount: Decimal;
        amount: Decimal;
        totalAmount: Decimal;
        PageNoCaptionLbl: Label 'Page';

    procedure GetBaseUoMText(ItemNo: Code[20]): Text[50]
    var
        UoM: Record "Unit of Measure";
        Item: Record "Item";
    begin
        IF Item.GET(ItemNo) THEN BEGIN
            IF UoM.GET(Item."Base Unit of Measure") THEN
                EXIT(UoM.Code);
        END;
    end;
}
*/
