report 50149 "Posted Service Invoice"
{
    // BH1.00, FAKTURA
    DefaultLayout = RDLC;
    RDLCLayout = './PostedServiceInvoice_2.rdl';

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
            column(Napomena1; Napomena1) { }
            column(Napomena2; Napomena2) { }
            column(Licnekarte_niz_novi; Licnekarte_niz_novi) { }
            column(Add_Description; "Add Description") { }

            column(Document_Date; FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(SigPosText; SigPosText) { }
            column(SigName; SigName) { }
            column(CustomerNo; Customer."No.")
            {

            }
            column(Municipality_Name; "Municipality Name") { }
            column(Order_No_; "Order No.") { }
            column(Order_Date; "Order Date") { }

            column(BillingSIgnatory; CompInfo."Billing Signatory") { }

            column(CZkPhoneNumber; CZkPhoneNumber) { }
            column(FaxNoCZK; FaxNoCZK) { }
            column(EmplPosition; Position) { }
            column(EmployeSignatory; Signatory)
            {

            }
            column(DispatchCenter; CompInfo."Dispatch Center")
            {

            }



            column(PageNoCaption; PageNoCaptionLbl) { }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(SlovimaTextRez; SlovimaTextRez) { }

            column(VAT_Registration_No_; registrationVATNumber) { }
            column(Registration_No_; registrationNumber) { }
            column(Bill_to_Registration_No_; "Bill-to Registration No.") { }
            column(Bill_to_VAT_Registration_No_; "Bill-to VAT Registration No.") { }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(Kontakt; PhoneNo)
            {

            }
            column(NazivPoz; NazivPoz) { }
            column(ImePo; ImePo) { }
            column(CompInfoCity; CompInfo."Post Code" + ' ' + CompInfo.City)
            {

            }
            column(CompInfo; CompInfo."Employee Signatory") { }
            column(Fiscal_No_; "Fiscal No.") { }
            column(City; CompInfo.City) { }
            column(CompPage; CompInfo."Home Page")
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
            column(CEO_Phone; CEO_Phone)
            {

            }
            column(Picture; CompInfo.Picture)
            {
            }
            column(CompInfo_Disp; CompInfo."Dispatch Center") { }
            column(CustomerName; Customer.Name)
            {

            }
            column(Bill_to__Name_; "Bill-to Name")
            {
            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(RokPlacanja; RokPlacanja) { }
            column(amount; amount_2) { }
            column(CustomerAddress; Customer.Address)
            {

            }
            column(CustomerCity; Customer."Post Code" + ' ' + Customer.City)
            {

            }
            column(totalAmount; totalAmount_2)
            {

            }
            column(vatAmount; vatAmount_2) { }
            column(Description; Description) { }


            dataitem(DataItem2; "Service Invoice Line")
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
                column(AmountWithoutVAT; Amount_3) { }

                trigger OnAfterGetRecord()
                var
                    invoiceNo: Record "Sales Invoice Header";
                    firstPart: Text;
                    STotal: Record "Service Invoice Line";
                    UserSetupRec: Record "User Setup";
                    BankAccountRec: Record "Bank Account";
                    SerHed: Record "Service Header";
                begin




                    if type = type::Resource then
                        DescriptionValue := Description
                    else
                        DescriptionValue := "No." + ' ' + Description;


                    // vatAmount += "Amount Including VAT" - Amount;
                    //  totalAmount += "Amount Including VAT";

                    STotal.Reset();
                    STotal.SetFilter("Document No.", '%1', DataItem1."No.");
                    if STotal.FindFirst() then begin
                        STotal.CalcSums("Amount", "Amount Including VAT");
                        Amount_2 := STotal.Amount;
                        vatAmount_2 := STotal."Amount Including VAT" - STotal.Amount;
                        totalAmount_2 := STotal."Amount Including VAT";
                        Amount_3 := STotal.Amount;

                    end
                    else begin
                        Amount_2 := 0;
                        vatAmount_2 := 0;
                        totalAmount_2 := 0;

                    end;
                    // amount += Amount;
                    counter += 1;


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


                    if CompInfo.Get() then begin
                        CompInfo.CalcFields("Billing Signatory", "Billing Sign");
                        if Employee.Get(CompInfo."Employee Signatory") then begin
                            Signatory := Employee."Last Name" + ' ' + Employee."First Name";
                            Position := Employee."Position Description";
                        end else begin
                            Signatory := '';
                            Position := '';
                        end;
                    end;
                end;

            }

            dataitem("Service Comment Line"; "Service Comment Line")
            {

                column(Comment; Comment) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("Table Name", '%1', "Table Name"::"Service Invoice Header");
                    SetFilter("Table Subtype", '%1', 1);
                    SetFilter(Type, '%1', Type::General);
                    SetFilter("No.", '%1', DataItem1."No.");
                end;
            }

            trigger OnPreDataItem()
            var

                sh: Record "Service Invoice Header";
                banacc: record "Bank Account";
                EmployeC: Record "Employee Contract Ledger";
            begin
                CompInfo.CALCFIELDS(Picture);




                CurrReport.PAGENO := 1;
                lineCounter := 2;
                sh.SetFilter("No.", '%1', GetFilter("No."));
                if sh.FindFirst() then begin
                    Customer.Get(sh."Customer No.");
                end;

                //  CompInfo.get;
                EmployeC.Reset();
                EmployeC.SetFilter("Employee No.", '%1', CompInfo."Employee Signatory");
                EmployeC.SetFilter(Active, '%1', true);
                EmployeC.Ascending;
                if EmployeC.FindLast() then begin
                    NazivPoz := EmployeC."Position Description";
                    ImePo := EmployeC."Employee Name";
                end
                else begin
                    NazivPoz := '';
                    ImePo := '';
                end;

                if DataItem1."Due Date" = DataItem1."Document Date" then
                    RokPlacanja := 'Odmah'
                else
                    RokPlacanja := format(DataItem1."Due Date");

                /*  banacc.Reset();
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

                banacc.Reset();
                banacc.SetFilter("No.", 'CZK4');
                if banacc.FindFirst() then begin
                    czk3 := 'Centar za kupce 3: ' + banacc.Address + ', tel: ' + banacc."Phone No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'CZK6');
                if banacc.FindFirst() then begin
                    czk5 := 'Centar za kupce 5: ' + banacc.Address + ', tel: ' + banacc."Phone No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'CZK7');
                if banacc.FindFirst() then begin
                    czk3 := 'Centar za kupce 6: ' + banacc.Address + ', tel: ' + banacc."Phone No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'CZK1');
                if banacc.FindFirst() then begin
                    cku1 := 'Centar za komunalne usluge: ' + banacc.Address + ', tel: ' + banacc."Phone No." + ', fax: ' + banacc."Fax No.";
                end;
                banacc.Reset();
                banacc.SetFilter("No.", 'CZK2');
                if banacc.FindFirst() then begin
                    cku2 := 'Centar za komunalne usluge: ' + banacc.Address + ', tel: ' + banacc."Phone No.";
                end;
                CompInfo.get;
                registrationNumber := CompInfo."Registration No.";
                registrationVATNumber := CompInfo."VAT Registration No.";
                courtNumber := CompInfo.MBS;
                court := CompInfo."Registration Text";
                activityCode := CompInfo."Activity Code";
                vatNumber := CompInfo."Tax No.";
            end;


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                MyCU: Codeunit TestSubsCu;

            begin
                Napomena1 := '';
                Napomena2 := '';



                CalcFields("Amount Including VAT");
                SlovimaTextRez := MyCU.NumberToWordsBillingCNG(round("Amount Including VAT"), TRUE);
                SUmaiZnosUplate := 0;
                IznosUplateDoTada.Reset();
                IznosUplateDoTada.SetFilter("Posting Date", '<=%1', DataItem1."Posting Date");
                IznosUplateDoTada.SetFilter("Request Document", '%1', DataItem1."Order No.");
                IznosUplateDoTada.SetFilter("Source No.", '%1', DataItem1."Bill-to Customer No.");
                if IznosUplateDoTada.FindFirst() then begin
                    IznosUplateDoTada.CalcSums(Amount);
                    SUmaiZnosUplate := IznosUplateDoTada.Amount;
                end;

                if (ROUND("Amount Including VAT" - abs(SUmaiZnosUplate)) MOD 1 * 100) = 0 then
                    PriceZero1 := '.00';

                if (ROUND(abs(SUmaiZnosUplate) - "Amount Including VAT") MOD 1 * 100) = 0 then
                    PriceZero2 := '.00';

                SlovimaText := MyCU.NumberToWordsBillingCNG(round("Amount Including VAT" - abs(SUmaiZnosUplate)), TRUE);
                SlovimaText2 := MyCU.NumberToWordsBillingCNG(round(abs(SUmaiZnosUplate) - "Amount Including VAT"), TRUE);
                if SUmaiZnosUplate <> 0 then begin

                    //kupac plation 50, faktura 100= -50+100= 50 (doplata), iznos >0.

                    if SUmaiZnosUplate + "Amount Including VAT" < 0 then
                        Napomena1 := 'U odnosu na profakturu br. ' + "Order No." + ' od ' + Format("Order Date", 0, '<Day,2>.<Month,2>.<Year4>') + ' potrebno je izvršiti ' + 'povrat u iznosu od ' + Replacestring_T(format("Amount Including VAT" - abs(SUmaiZnosUplate)), ',', '.') + PriceZero1 + ' (' + SlovimaText + ') KM.'

                    else
                        Napomena1 := 'U odnosu na profakturu br. ' + "Order No." + ' od ' + Format("Order Date", 0, '<Day,2>.<Month,2>.<Year4>') + ' potrebno je izvršiti ' + 'doplatu u iznosu od ' + Replacestring_T(format(abs(SUmaiZnosUplate) - "Amount Including VAT"), ',', '.') + PriceZero2 + ' (' + SlovimaText2 + ') KM.';


                    if Selected = Selected::"Povrat opcija da se iznos povrata usmjeri na izmirenje obaveza za potrošnju prirodnog gasa" then begin

                        Napomena2 := 'Kupac je saglasan da se iznos povrata usmjeri na izmirenje obaveza za potrošnju prirodnog gasa';
                    end;
                    if Selected = Selected::"Povrat da se izvrši na transakcijski račun" then begin

                        Napomena2 := 'Povrat novčanih sredstava izvršiti na transakcijski račun ________________ za kupca ' + DataItem1."Bill-to Name" + ' na adresi ' + DataItem1.Address + ' .';
                    end;

                end;
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

                LK.Reset(); //ovdje sad kupi lične karte novog korisnika
                LK.SETFILTER(Active, '%1', true);
                LK.SETFILTER("Customer No.", '%1', DataItem1."Bill-to Customer No.");
                IF LK.FindSet() then
                    repeat
                        if Licnekarte_niz_novi = '' then begin
                            if LK."Identity card issuer" <> '' then
                                Licnekarte_niz_novi := LK.Code + ', ' + LK."Identity card issuer"
                            else
                                Licnekarte_niz_novi := LK.Code;
                        end

                        else begin

                            if LK."Identity card issuer" <> '' then
                                Licnekarte_niz_novi += '; ' + LK.Code + ', ' + LK."Identity card issuer"
                            else
                                Licnekarte_niz_novi += '; ' + LK.Code;
                        end;
                    until LK.Next() = 0;

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

            end;
        }


    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Izaberi izvještaj")
                {
                    Caption = 'Izaberi izvještaj';
                    field(Selected; Selected)
                    {
                        ApplicationArea = all;
                        Caption = 'Izbor:';
                        OptionCaption = ' ,Povrat opcija da se iznos povrata usmjeri na izmirenje obaveza za potrošnju prirodnog gasa,Povrat da se izvrši na transakcijski račun';
                    }
                }
            }
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
        CompInfo.CalcFields("Billing Signatory", "Billing Sign");

    end;

    var
        RecNo: Code[20];
        PriceZero1: text;
        SlovimaTextRez: text;
        Selected: Option " ","Povrat opcija da se iznos povrata usmjeri na izmirenje obaveza za potrošnju prirodnog gasa","Povrat da se izvrši na transakcijski račun";
        PriceZero2: text;
        LK: Record "Customer ID";
        Licnekarte_niz_novi: text;
        CZkPhone: Record "Bank Account";
        SignatoryPos: Record Employee;
        IznosUplateDoTada: Record "G/L Entry";
        SUmaiZnosUplate: Decimal;
        UserM: record "User Setup";

        CZkPhoneNumber: text[250];
        FaxNoCZK: text[250];
        SigPosText: text;
        SigName: text;
        ECL: record "Employee COntract Ledger";
        DescriptionValue: Text;
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

        NazivPoz: text[250];
        ImePo: text[250];
        transIntesa: Text;
        transBBI: Text;
        court: Text;
        courtNumber: Text;
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
        transaction8Name: TEXT[100];
        transaction8: TEXT[100];

        transaction9Name: TEXT[100];
        transaction9: TEXT[100];
        transaction10Name: TEXT[100];

        transaction10: TEXT[100];
        Napomena1: text;

        Napomena2: text;


        PhoneNo: Text[100];
        numberOfDecision: Text;
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        vatAmount: Decimal;
        amount: Decimal;
        totalAmount: Decimal;

        PageNoCaptionLbl: Label 'Page';
        RokPlacanja: text[250];

        czk3: Text;
        czk5: Text;
        czk6: Text;

        SlovimaText: text;
        cku1: Text;
        SlovimaText2: text;
        cku2: Text;
        Amount_2: Decimal;
        Amount_3: Decimal;
        totalAmount_2: Decimal;
        vatAmount_2: Decimal;
        Employee: Record Employee;
        Position: Text[100];
        EmployeeID: Code[20];
        Signatory: text[100];

    procedure Replacestring_TTacka(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure Replacestring_T(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    var
        ValueD: Integer;
        StrIn: Integer;
    begin
        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), '.', 'LLL');
        end;
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));

        if FindWhat = ',' then begin
            String := Replacestring_TTacka(format(String), 'LLL', ',');
        end;


        NewString := String;

        if strpos(NewString, '.') <> 0 then begin
            ValueD := strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString)));
            StrIn := strpos(NewString, '.');

            if strlen(copystr(NewString, strpos(NewString, '.') + 1, StrLen(NewString))) = 1 then
                NewString += '0';

        end;

    end;

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

