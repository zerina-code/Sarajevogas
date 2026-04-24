report 50153 "UnpaidInvoices"
{
    // BH1.00, NEPLAĆENE FAKTURE
    DefaultLayout = RDLC;
    RDLCLayout = './UnpaidInvoices.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(AccusationLine; "Accusation Line")
        {
            DataItemTableView = SORTING("Document No.");

            column(AccLineDocumentNo; AccLineDocumentNo) { }
            column(AccLineAmountPaid; AccLineAmountPaid) { }
            column(AccLineDebtAmount; AccLineDebtAmount) { }
            column(AccLineInterestAmount; AccLineInterestAmount) { }
            column(AccLineSalesInvoiceNo; AccLineSalesInvoiceNo) { }
            column(AccLineTransferDate; FORMAT(AccLineTransferDate, 0, '<Day,2>.<Month,2>.<Year4>')) { }

            column(CompInfoName; CompInfo.Name)
            {
            }
            column(Acc2_Name; Acc2_Name) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExe_Pos; AccExe_Pos) { }
            column(AccExeName; AccExeName) { }
            column(CompInfo_name2; CompInfo."Name 2") { }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(ProtocolNo; ProtocolNo) { }
            column(CompPage; CompInfo."Home Page")
            {

            }
            column(registrationNumber; registrationNumber) { }
            column(vatNumber; vatNumber) { }
            column(registrationVATNumber; registrationVATNumber) { }
            column(court; court) { }
            column(activityCode; activityCode) { }
            column(StartDate; FORMAT(firstDate, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(EndDate; FORMAT(secondDate, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(CompanyInformation; CompInfo.Picture1) { }
            column(PhoneNo; CompInfo."Phone No.")

            {

            }
            column(MBS; CompInfo.MBS)
            {
            }
            column(CompanyInformation_reg; CompInfo."Registration No.") { }


            column(BankName; CompInfo."Bank Name")
            {
            }


            column(PhoneNo2; CompInfo."Phone No. 2")
            {

            }
            column(TotalSum; TotalSum) { }
            column(transBBI; transBBI) { }
            column(transIntesa; transIntesa) { }
            column(transRaif; transRaif) { }
            column(transUni; transUni) { }
            column(transactionPrivredna; transactionPrivredna) { }
            column(transUnion; transUnion) { }
            column(courtNumber; courtNumber) { }
            column(FaxNo; CompInfo."Fax No.")
            {

            }
            column(CEO_Phone; CEO_Phone)
            {

            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CustomerName; Customer.Name)
            {

            }

            column(CustomerCode; Customer."No.") { }
            column(CustomerAddress; Customer.Address)
            {

            }
            column(CustomerCity; Customer."Post Code" + ' ' + Customer.City)
            {

            }
            column(DocumentNo; "Document No.") { }
            column(DocumentDate; FORMAT(Today, 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(DueDate; FORMAT("Due Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Amount; amount) { }
            column(totalAmtOldDebt; totalAmtOldDebt) { }
            column(totalDebtOldDebt; totalDebtOldDebt) { }
            column(totalInterestOldDebt; totalInterestOldDebt) { }
            column(oldInvoiceNo; oldInvoiceNo) { }
            column(oldDate; FORMAT("oldDate", 0, '<Day,2>.<Month,2>.<Year4>')) { }

            //accusation line dataitem
            trigger OnPreDataItem()
            var
                emp: Record Employee;
                acc: Record "Accusation Header";
                AccHeader: Record "Accusation Header";
                accLine: Record "Accusation Line";
                banacc: record "Bank Account";
            begin
                SetRange("Document No.", RecNo);

                //preuzeto
                //  if DataItem1.FindSet() then repeat DataItem1.CalcFields("Remaining Amount") until DataItem1.Next() = 0;
                //firstDate := GetRangeMin("Posting Date");
                //secondDate := GetRangeMax("Posting Date");
                //  DataItem1.SetFilter("Remaining Amount", '>%1', 0);
                //DataItem1.SetFilter(Open, '%1', true);
                //DataItem1.SetFilter("Document Type", '%1', DataItem1."Document Type"::Invoice);
                CompInfo.get;


                CompInfo.CALCFIELDS(Picture, Picture1);
                CurrReport.PAGENO := 1;
                lineCounter := 2;
                //  acc.SetFilter("No.", '%1', GetFilter("No."));

                AccHeader.Get(RecNo);
                Customer.Get(AccHeader."Customer No.");

                registrationNumber := CompInfo."Registration No.";
                registrationVATNumber := CompInfo."VAT Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";
                ORG.Reset();
                ORG.SetFilter("Date From", '<=%1', Today);
                ORG.SetCurrentKey("Date From");
                ORG.Ascending;
                ORG.FindFirst();

                Head.Reset();
                Head.SetFilter("Management Level", '%1', Head."Management Level"::CEO);
                Head.SetFilter("ORG Shema", '%1', ORG.Code);
                if Head.FindFirst() then begin
                    Head.CalcFields("Employee Name", "Employee Last Name");
                    Head.CalcFields("Position Description");
                    emp.SetFilter("No.", '%1', Head."Employee No.");
                    if emp.FindFirst() then begin
                        CEO_Phone := emp."Company Phone No.";
                    end;
                end;
                TotalSum := 0;

                // 9.dec.2024., Amir: Kako sam razumio Đeminu, ukupan dug predstavlja zbir iz redaka tužbe 
                // te ću zato ovaj CLE blok zakomentarisati. 
                // vrijednost varijable totalDebtOldDebt dolazi iz akcije na PAGE 50111
                /*
                CLE.reset;
                cle.CopyFilters(DataItem1);
                if cle.FindSet() then
                    repeat

                        cle.CalcFields("Amount (LCY)");
                        TotalSum += cle."Amount (LCY)" + totalDebtOldDebt;

                    until cle.Next() = 0;
                */

                TotalSum := totalDebtOldDebt;

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

            trigger OnAfterGetRecord()
            var
                EmpN: Record Employee;
                ecl: Record "Employee Contract Ledger";
            begin
                CalcFields("Amount Payed", "Interest Amount");

                if "Sales Invoice No. - Transfer" <> '' then
                    AccLineDocumentNo := "Sales Invoice No. - Transfer"
                else
                    AccLineDocumentNo := "Sales Invoice No.";

                AccLineDebtAmount := "Debt Amount - Transfer" + "Line Amount";

                AccLineAmountPaid := "Amount Paid - Transfer" + "Amount Payed";

                AcclineInterestAmount := "Interest Amount - Transfer" + "Interest Amount";

                AccLineSalesInvoiceNo := "Sales Invoice No. - Transfer";

                if "Due Date - Transfer" <> 0D then
                    AccLineTransferDate := "Due Date - Transfer"
                else
                    AccLineTransferDate := "Due Date";


                //preuzeto
                //DataItem1.CalcFields("Remaining Amount");
                //amount := "Remaining Amount";
                //Customer.get(DataItem1."Customer No.");
                AccExe_Pos := '';
                Acc2_Name := '';
                AccExeName := '';
                Acc2_Pos_ := '';
                CompInfo.get;
                CompInfo.CalcFields(Picture, Picture1);
                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person");
                if EmpN.FindFirst() then begin
                    AccExeName := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        AccExe_Pos := ecl."Position Description";

                end;

                EmpN.Reset();
                EmpN.SetFilter("No.", '%1', CompInfo."Accusation Responsible Person Exe");
                if EmpN.FindFirst() then begin
                    Acc2_Name := EmpN."First Name" + ' ' + EmpN."Last Name";
                    ecl.Reset();
                    ecl.SetFilter("Employee No.", '%1', EmpN."No.");
                    ecl.SetFilter(Active, '%1', true);
                    if ecl.FindFirst() then
                        Acc2_Pos_ := ecl."Position Description";

                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group("Required Fields")
                {
                    Caption = 'Required Fields';
                    //  Visible = Visible_D;

                    field(ProtocolNo; ProtocolNo)
                    {
                        Caption = 'Protocol No.';
                    }
                }
            }
        }

        actions
        {
        }
        trigger OnOpenPage()
        begin
            /*   if FORMAT(pDate) <> '' then begin
                   DataItem1.SetRange("Posting Date", DMY2Date(1, 1, 2020), pDate);
               end;
               if custNo <> '' then begin
                   DataItem1.SetFilter("Customer No.", '%1', custNo);
               end;
               */
        end;
    }


    labels
    {
    }




    trigger OnPreReport()
    begin
        CompInfo.GET;

        CompInfo.CALCFIELDS(Picture, Picture1);

    end;

    var
        RecNo: Code[20];
        CompInfo: Record "Company Information";
        ORG: Record "ORG Shema";
        Head: Record "Head Of's";
        CEO_Phone: Text[100];
        Customer: Record Customer;
        InvoiceNos: Text;
        firstDate: Date;
        secondDate: Date;
        lineCounter: Integer;
        invoiceDescription: Text;

        court: Text;
        courtNumber: Text;
        numberOfDecision: Text;
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        ProtocolNo: code[20];
        Visible_D: Boolean;
        pDate: Date;
        custNo: Code[20];

        PageNoCaptionLbl: Label 'Page';
        banacc: record "Bank Account";
        transUnion: Text;
        transactionPrivredna: Text;
        AccExe_Pos: text[250];
        AccExeName: Text[250];

        Acc2_Pos_: text[250];
        Acc2_Name: Text[250];
        transRaif: Text;
        transUni: Text;
        transIntesa: Text;
        CLE: Record "Cust. Ledger Entry";
        TotalSum: Decimal;
        transBBI: Text;
        amount: Decimal;
        totalAmtOldDebt: Decimal;
        totalDebtOldDebt: Decimal;
        totalInterestOldDebt: Decimal;
        oldInvoiceNo: Code[20];
        oldDate: Date;

        AccLineDocumentNo: Text;
        AccLineAmountPaid: Decimal;
        AccLineDebtAmount: Decimal;
        AccLineInterestAmount: Decimal;
        AccLineSalesInvoiceNo: Text;
        AccLineTransferDate: Date;

    procedure SetAccusation(accRec: Code[20])
    begin
        RecNo := accRec;
    end;

    procedure setPostingDate(postingDate: Date)
    begin
        pDate := postingDate;
    end;

    procedure setCustomer(cust: Code[20])
    begin
        custNo := cust;
    end;

    procedure setVisible(Vis: Boolean)
    begin
        Visible_D := Vis;
    end;

    procedure setTotalAmt(AmtPaid: Decimal; AmtDebt: Decimal; AmtInterest: Decimal; OldInNo: Code[20]; StariDate: Date)
    begin
        totalAmtOldDebt := AmtPaid;
        totalDebtOldDebt := AmtDebt;
        totalInterestOldDebt := AmtInterest;
        oldInvoiceNo := OldInNo;
        oldDate := StariDate;
    end;
}

