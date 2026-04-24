report 50155 "IssuedAccusationReminder"
{
    // BH1.00, OPOMENA PRED TUŽBU
    DefaultLayout = Word;
    WordLayout = './Opomena pred utuzenje.docx';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Issued Reminder Header")
        {

            RequestFilterFields = "No.";
            column(No; "No.")
            {

            }
            column(InvoiceNos; InvoiceNos)
            {

            }
            column(Document_Date; format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(DocumentNo; "No.")
            {

            }
            column(PageNoCaption; PageNoCaptionLbl) { }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(CompPage; CompInfo."Home Page")
            {

            }
            column(registrationNumber; registrationNumber) { }
            column(vatNumber; vatNumber) { }
            column(CompInfo_mbs; CompInfo.MBS) { }
            column(registrationVATNumber; registrationVATNumber) { }
            column(court; court) { }
            column(activityCode; activityCode) { }
            column(transBBI; transBBI) { }
            column(transIntesa; transIntesa) { }
            column(transRaif; transRaif) { }
            column(transUni; transUni) { }
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
            column(CEO_Phone; CEO_Phone)
            {

            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Picture1; CompInfo.Picture1) { }
            column(CustomerName; Customer.Name)
            {

            }
            column(CustomerAddress; Customer.Address)
            {

            }
            column(CustomerCity; Customer."Post Code" + ' ' + Customer.City)
            {

            }
            column(Description; "Posting Description") { }
            column(Debt; "Remaining Amount")
            {

            }
            column(DeadlineDate; format("Document Date" + 15, 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(RespPerson; CompInfo."Accusation Responsible Person Name") { }
            column(RespPosition; CompInfo."Accusation Responsible Person Position") { }
            column(AccusationPhone; CompInfo."Accusation Phone No.") { }
            dataitem(DataItem2; "Issued Reminder Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                              ORDER(Ascending);


                column(lineCounter;
                FORMAT(lineCounter) + '.')
                {
                }
                column(InvoiceDescription; invoiceDescription) { }


                trigger OnAfterGetRecord()
                var
                    invoiceNo: Record "Sales Invoice Header";
                    firstPart: Text;
                begin

                    lineCounter := lineCounter + 1;
                    invoiceNo.SetFilter("No.", '%1', DataItem2."Document No.");
                    if invoiceNo.FindFirst() then begin
                        if invoiceNo.Prepayment then firstPart := 'Avansni račun br.' else firstPart := 'Račun br.';
                        invoiceDescription := firstPart + ' ' + invoiceNo."No." + ' od ' + FORMAT(invoiceNo."Document Date", 0, '<Day,2>.<Month,2>.<Year4>') + '. godine.';
                    end;

                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                emp: Record Employee;
            begin

                Customer.get(DataItem1."Customer No.");
                ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetFilter(status, '%1', ORG.Status::Active);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                ORG.FindFirst();

                Head.Reset();
                Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                Head.SetFilter("ORG Shema", '%1', ORG.Code);
                if Head.FindFirst() then begin
                    Head.CalcFields("Employee Name", "Employee Last Name", "Employee No.");
                    Head.CalcFields("Position Description");
                    emp.SetFilter("No.", '%1', Head."Employee No.");
                    if emp.FindFirst() then begin
                        CEO_Phone := emp."Company Phone No.";
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                emp: Record Employee;
                acc: Record "Accusation Header";
                accLine: Record "Accusation Line";
                banacc: record "Bank Account";
            begin
                CompInfo.get;

                CompInfo.CALCFIELDS(Picture, Picture1);
                CurrReport.PAGENO := 1;
                lineCounter := 2;
                acc.SetFilter("No.", '%1', GetFilter("No."));
                if acc.FindFirst() then begin
                    Customer.Get(acc."Customer No.");
                end;
                accLine.SetFilter("Document No.", '%1', acc."No.");
                if accLine.FindSet() then
                    repeat
                        InvoiceNos := InvoiceNos + ',' + DataItem2."Document No.";
                    until accLine.Next = 0;
                if StrLen(InvoiceNos) >= 2 then
                    InvoiceNos := CopyStr(InvoiceNos, 2, StrLen(InvoiceNos));


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
            if RecNo <> '' then begin
                DataItem1.SetFilter("No.", RecNo);
            end;
            /*   if cat = Category::Household then begin
                   DataItem1.SetFilter("Category", '%1', Category::Household);
               end;
               if cat = Category::"Small Economy" then begin
                   DataItem1.SetFilter(Category, '%1', Category::"Small Economy");
               end;
               if cat = Category::"Large Economy" then begin
                   DataItem1.SetFilter(Category, '%1', Category::"Large Economy");
               end;
               if cat = Category::"KJKP Heating plant" then begin
                   DataItem1.SetFilter(Category, '%1', Category::"KJKP Heating plant");
               end;*/
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

        PageNoCaptionLbl: Label 'Page';
        cat: Enum Category;

    procedure setCategory(category: Enum Category)
    begin
        cat := category;
    end;

    procedure SetAccusation(accRec: Code[20])
    begin
        RecNo := accRec;
    end;
}

