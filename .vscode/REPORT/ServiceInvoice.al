report 50147 "ServiceInvoice"
{
    // BH1.00, PROFAKTURA
    DefaultLayout = RDLC;
    RDLCLayout = './ServiceInvoice.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "Service Header")
        {

            RequestFilterFields = "No.";
            column(No; "No.")
            {

            }

            column(Document_Date; FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }


            column(PageNoCaption; PageNoCaptionLbl) { }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(SigPosText; SigPosText) { }
            column(SigName; SigName) { }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(Municipality_Name; "Municipality Name") { }
            column(City; City) { }
            column(Post_Code; "Post Code") { }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(CityComp; CompInfo.City) { }
            column(DispatchCenter; CompInfo."Dispatch Center")
            {

            }
            column(BillingSIgnatory; CompInfo."Billing Signatory") { }

            column(CZkPhoneNumber; CZkPhoneNumber) { }
            column(FaxNoCZK; FaxNoCZK) { }
            column(EmployeSignatory; Signatory)
            {

            }
            column(CompPage; CompInfo."Home Page")
            {

            }
            column(Kontakt; PhoneNo)
            {

            }
            column(EmplPosition; Position) { }

            column(RokPlacanja; RokPlacanja) { }
            column(registrationNumber; registrationVATNumber) { }
            column(vatNumber; vatNumber) { }
            column(registrationVATNumber; registrationNumber) { }
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
            column(CEO_Phone; CEO_Phone)
            {

            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(Picture1; CompInfo.Picture1)
            {

            }
            column(CustomerName; Customer.Name)
            {

            }
            column(CustomerNo; Customer."No.")
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")

            {

            }
            column(Bill_to_Registration_No_; "Bill-to Registration No.") { }
            column(Bill_to_VAT_Registration_No_; "Bill-to VAT Registration No.") { }
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
            column(transaction4; transaction4)
            {

            }
            column(SlovimaRez; SlovimaRez) { }

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



            column(amount; AmountRez) { }
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


            dataitem(DataItem2; "Service Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                             ORDER(Ascending);
                column(counter; FORMAT(counter) + '.') { }
                column(LineName;
                DescriptionValue)
                { }
                column(UnitOfMeasure; GetBaseUoMText("Unit of Measure Code")) { }
                column(Quantity; Quantity) { }
                column(UnitPrice; "Unit Price") { }
                column(AmountWithoutVAT; Amount) { }

                trigger OnAfterGetRecord()
                var
                    invoiceNo: Record "Sales Invoice Header";
                    firstPart: Text;
                begin

                    if type = type::Resource then
                        DescriptionValue := Description
                    else
                        DescriptionValue := "No." + ' ' + Description;

                    /*   vatAmount += "Amount Including VAT" - Amount;
                       totalAmount += "Amount Including VAT";
                       amount += Amount;*/

                    vatAmount += DataItem2."Amount Including VAT" - DataItem2.Amount;
                    totalAmount += DataItem2."Amount Including VAT";

                    STotal.Reset();
                    STotal.SetFilter("Document No.", '%1', DataItem1."No.");
                    if STotal.FindFirst() then begin
                        STotal.CalcSums("Amount", "Amount Including VAT");
                        AmountRez := STotal.Amount;
                        vatAmount := STotal."Amount Including VAT" - STotal.Amount;
                        totalAmount := STotal."Amount Including VAT";

                    end
                    else begin
                        AmountRez := 0;
                        vatAmount := 0;
                        totalAmount := 0;

                    end;

                    SlovimaRez := MyCU.NumberToWordsBillingCNG(round(totalAmount), TRUE);
                    counter += 1;
                end;

            }
            dataitem("Service Comment Line"; "Service Comment Line")
            {

                column(Comment; Comment) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("Table Name", '%1', "Table Name"::"Service Header");
                    SetFilter("Table Subtype", '%1', 1);
                    SetFilter(Type, '%1', Type::General);
                    SetFilter("No.", '%1', DataItem1."No.");
                end;
            }

            trigger OnPreDataItem()
            var

                sh: Record "Service Header";
                banacc: record "Bank Account";
                EmployeC: Record "Employee Contract Ledger";
            begin
                //EK CompInfo.CALCFIELDS(Picture);

                CompInfo.CalcFields(Picture1);
                CurrReport.PAGENO := 1;
                lineCounter := 2;
                sh.SetFilter("No.", '%1', GetFilter("No."));
                if sh.FindFirst() then begin
                    Customer.Get(sh."Customer No.");
                end;

                EmployeC.Reset();
                EmployeC.SetFilter("Employee No.", '%1', CompInfo."Employee Signatory");
                EmployeC.SetFilter(Active, '%1', true);
                EmployeC.Ascending;
                if EmployeC.FindLast() then begin
                    Position := EmployeC."Position Description";
                    Signatory := EmployeC."Employee Name";
                end
                else begin
                    Position := '';
                    Signatory := '';
                end;
                /*
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
                                end;*/
                CompInfo.GET;
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 1");
                if banacc.FindFirst() then begin

                    transaction1 := banacc."Bank Account No.";
                    transaction1Name := banacc.Name;
                end;

                if DataItem1."Due Date" = DataItem1."Document Date" then
                    RokPlacanja := 'Odmah'
                else
                    RokPlacanja := format(DataItem1."Due Date");

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 2");
                if banacc.FindFirst() then begin
                    transaction2name := banacc.Name;
                    transaction2 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 3");
                if banacc.FindFirst() then begin
                    transaction3Name := banacc.Name;
                    transaction3 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 4");
                if banacc.FindFirst() then begin
                    transaction4Name := banacc.Name;
                    transaction4 := banacc."Bank Account No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 5");
                if banacc.FindFirst() then begin

                    transaction5Name := banacc.Name;
                    transaction5 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 6");
                if banacc.FindFirst() then begin

                    transaction6Name := banacc.Name;
                    transaction6 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 7");
                if banacc.FindFirst() then begin

                    transaction7Name := banacc.Name;
                    transaction7 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 8");
                if banacc.FindFirst() then begin

                    transaction8Name := banacc.Name;
                    transaction8 := banacc."Bank Account No.";
                end;


                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 9");
                if banacc.FindFirst() then begin

                    transaction9Name := banacc.Name;
                    transaction9 := banacc."Bank Account No.";
                end;

                banacc.Reset();
                banacc.SetFilter("No.", CompInfo."Bank No. 10");
                if banacc.FindFirst() then begin

                    transaction10Name := banacc.Name;
                    transaction10 := banacc."Bank Account No.";
                end;


                registrationNumber := CompInfo."VAT Registration No.";
                registrationVATNumber := CompInfo."Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";


            end;

            trigger OnAfterGetRecord()
            var
                UserSetupRec: Record "User Setup";
                BankAccountRec: Record "Bank Account";
                SerHed: Record "Service Header";
            begin



                SigPosText := '';
                SigName := '';

                CompInfo.GET;
                CompInfo.CalcFields("Billing Signatory", "Billing Sign");

                SignatoryPos.reset;
                SignatoryPos.setfilter("No.", '%1', CompInfo."Billing Signatory Emp");

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


                /* PhoneNo := '';
                 EmployeeID := SerHed."Employee Prepare Responsible";
                 UserSetupRec.Reset();
                 UserSetupRec.SetRange("Employee No.", EmployeeID);
                 if UserSetupRec.FindFirst() then begin
                     BankAccountRec.Reset();
                     BankAccountRec.SetRange("No.", UserSetupRec."CZK");
                     if BankAccountRec.FindFirst() then
                         PhoneNo := BankAccountRec."Phone No.";
                 end;*/
                PhoneNo := '';
                UserSetupRec.reset;
                UserSetupRec.setfilter("User ID", '%1', USERID);
                if UserSetupRec.findfirst then begin
                    BankAccountRec.reset;
                    BankAccountRec.setfilter("No.", '%1', UserSetupRec.CZK);
                    if BankAccountRec.findfirst then begin
                        PhoneNo := BankAccountRec."Phone No.";
                    end;
                end;

                /*    if CompInfo.Get() then begin
                        if Employee.Get(CompInfo."Employee Signatory") then begin
                            Signatory := Employee."Last Name" + ' ' + Employee."First Name";
                            Position := Employee."Position Description";
                        end else begin
                            Signatory := '';
                            Position := '';
                        end;
                    end;*/
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
        MyCU: Codeunit TestSubsCu;
        SignatoryPos: Record Employee;
        RLS: Record "Report Layout Selection";
        CZkPhone: Record "Bank Account";
        DescriptionValue: text;
        UserM: record "User Setup";

        CZkPhoneNumber: text[250];
        FaxNoCZK: text[250];
        SigPosText: text;
        SigName: text;
        ECL: record "Employee COntract Ledger";
        CRL: Record "Custom Report Layout";
        counter: Integer;
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
        STotal: Record "Service Line";
        court: Text;
        courtNumber: Text;
        numberOfDecision: Text;
        registrationNumber: Text;
        AmountRez: Decimal;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        vatAmount: Decimal;

        totalAmount: Decimal;
        PageNoCaptionLbl: Label 'Page';
        transaction7Name: text[100];
        transaction7: Text[100];
        transaction1Name: text[100];
        transaction2: text[100];
        transaction1: text[100];
        transaction3: text[100];

        transaction3Name: text[100];

        transaction2Name: text[100];
        transaction4Name: text[100];
        transaction4: Text[100];
        transaction5: Text[100];

        transaction5Name: text[100];
        transaction6Name: TEXT[100];
        transaction6: TEXT[100];

        IznosSaldo: Decimal;

        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];

        transaction10: TEXT[100];
        Signatory: text[100];
        PhoneNo: Text[100];
        RokPlacanja: text[250];
        Employee: Record Employee;
        Position: Text[100];
        EmployeeID: Code[20];
        SlovimaRez: text;

    procedure GetBaseUoMText(UOMCode: Code[20]): Text[50]
    var
        UoM: Record "Unit of Measure";
        Item: Record "Item";
    begin

        IF UoM.GET(UOMCode) THEN
            EXIT(UoM.Code);
    END;

    procedure SetParam(No: code[20])
    begin
        "RecNo" := No;
    end;
}

