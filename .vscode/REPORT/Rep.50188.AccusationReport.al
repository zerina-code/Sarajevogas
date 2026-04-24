report 50090 "Accusation Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Accusation Report';
    RDLCLayout = 'src\Reports\RDLC\Accusation Report.rdl';

    dataset
    {


        dataitem("Accusation Header"; "Accusation Header")
        {
            RequestFilterFields = "No.", "Customer No.", "Document Date", "Accusation Referal Person";


            column(No_; "No.")
            {

            }
            column(Customer_No_; "Customer No.")
            {

            }
            column(Customer_Name; "Customer Name")
            {
            }
            /*
             AccExe_Pos := '';
                Acc2_Name := '';
                AccExeName := '';
                Acc2_Pos_ := '';*/
            column(AccExe_Pos; AccExe_Pos) { }
            column(Acc2_Pos_; Acc2_Pos_) { }
            column(AccExeName; AccExeName) { }
            column(Acc2_Name; Acc2_Name) { }

            column(statusText; statusText) { }
            column(malsText; malsText) { }
            column(CustomerAddress; cust.Address) { }
            column(Status; Status)
            {

            }
            column(ReportDate; FORMAT(ReportDate, 0, '<day,2>.<month,2>.<year4>')) { }
            column(ProtocolNo; ProtocolNo) { }
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
            column(CompanyInformationPicture; CompanyInformation.Picture)
            {
            }
            column(CurrentUser; CurrentUser) { }
            column(CompanyInformation; CompanyInformation.Picture1) { }
            column(CompanyInformationAdress; CompanyInformation.Address)
            {
            }
            column(CompanyInformation_Nam2; CompanyInformation."Name 2") { }
            column(CompanyInformationVatRegNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(CompanyInformationGiroNo; CompanyInformation."Giro No.")
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CompanyInformationPhonNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyInformationCounty; CompanyInformation.County)
            {
            }
            column(CompanyInformationCity; CompanyInformation.City)
            {

            }
            column(CompanyInformationPostCode; CompanyInformation."Post Code")
            {

            }
            column(MBS; CompanyInformation."National Classification Number")
            {
            }
            column(CompanyInformation_reg; CompanyInformation."Registration No.") { }

            column(Court_number; "Court number")
            {

            }
            column(BankName; CompanyInformation."Bank Name")
            {
            }
            column(TotalVS; TotalVS) { }

            column(Status_Date; statusDate)
            {

            }
            column(EmployeeNoForWage; EmployeeNoForWage) { }
            column(SearchName; SearchName) { }
            column(totalAmount; totalAmount) { }
            column(totalCourtExpensePaidAmount; totalCourtExpensePaidAmount) { }
            column(totalCourtExpensesAmount; totalCourtExpensesAmount) { }
            column(totalCourtExpensesPaidAmount; totalCourtExpensesPaidAmount) { }
            column(totalDebtAmount; totalDebtAmount) { }
            column(totalDebtPaidAmount; totalDebtPaidAmount) { }
            column(totalInterestAmount; totalInterestAmount) { }
            column(totalInterestPaidAmount; totalInterestPaidAmount) { }
            column(Stroke; cust."Customer Stroke")
            { }
            column(CustomerCode; cust."No.") { }
            column(SelectedReport; SelectedReport) { }
            column(MonthLabelTxt; MonthLabelTxt) { }
            column(FilterYear; FilterYear) { }
            column(PreviousYear; PreviousYear) { }
            column(ReportNameLbl; ReportNameLbl) { }
            column(HhCountCurr; HhCountCurr) { }
            column(LECountCurr; LECountCurr) { }
            column(SECountCurr; SECountCurr) { }
            column(SvCountCurr; SvCountCurr) { }
            column(Monthly2_HHCount; Monthly2_HHCount) { }
            column(Monthly2_LECount; Monthly2_LECount) { }
            column(Monthly2_SECount; Monthly2_SECount) { }
            column(Monthly2_SCount; Monthly2_SCount) { }
            column(CountTotalCurr; CountTotalCurr) { }
            column(HhValueAccCurr; HhValueAccCurr) { }
            column(LEValueAccCurr; LEValueAccCurr) { }
            column(SEValueAccCurr; SEValueAccCurr) { }
            column(SvValueAccCurr; SvValueAccCurr) { }
            column(ValueAccTotalCurr; ValueAccTotalCurr) { }
            column(HhPaidTaxesCurr; HhPaidTaxesCurr) { }
            column(LEPaidTaxesCurr; LEPaidTaxesCurr) { }
            column(SEPaidTaxesCurr; SEPaidTaxesCurr) { }
            column(SvPaidTaxesCurr; SvPaidTaxesCurr) { }
            column(Monthly2_HHValuePaidDebt; Monthly2_HHValuePaidDebt) { }
            column(Monthly2_HHValuePaidDebtPrev; Monthly2_HHValuePaidDebtPrev) { }
            column(Monthly2_LEValuePaidDebt; Monthly2_LEValuePaidDebt) { }
            column(Monthly2_LEValuePaidDebtPrev; Monthly2_LEValuePaidDebtPrev) { }
            column(Monthly2_SEValuePaidDebt; Monthly2_SEValuePaidDebt) { }
            column(Monthly2_SEValuePaidDebtPrev; Monthly2_SEValuePaidDebtPrev) { }
            column(Monthly2_SValuePaidDebt; Monthly2_SValuePaidDebt) { }
            column(Monthly2_SValuePaidDebtPrev; Monthly2_SValuePaidDebtPrev) { }
            column(Montly2_HHPaidCourtExp; Montly2_HHPaidCourtExp) { }
            column(Montly2_HHPaidCourtExpPrev; Montly2_HHPaidCourtExpPrev) { }
            column(Montly2_LEPaidCourtExp; Montly2_LEPaidCourtExp) { }
            column(Montly2_LEPaidCourtExpPrev; Montly2_LEPaidCourtExpPrev) { }
            column(Montly2_SEPaidCourtExp; Montly2_SEPaidCourtExp) { }
            column(Montly2_SEPaidCourtExpPrev; Montly2_SEPaidCourtExpPrev) { }
            column(Montly2_SPaidCourtExp; Montly2_SPaidCourtExp) { }
            column(Montly2_SPaidCourtExpPrev; Montly2_SPaidCourtExpPrev) { }
            column(Monthly2_HHTotal; Monthly2_HHTotal) { }
            column(Monthly2_HHTotalPrev; Monthly2_HHTotalPrev) { }
            column(Monthly2_LETotal; Monthly2_LETotal) { }
            column(Monthly2_LETotalPrev; Monthly2_LETotalPrev) { }
            column(Monthly2_SETotal; Monthly2_SETotal) { }
            column(Monthly2_SETotalPrev; Monthly2_SETotalPrev) { }
            column(Monthly2_STotal; Monthly2_STotal) { }
            column(Monthly2_STotalPrev; Monthly2_STotalPrev) { }
            column(Montly2_HHPaidInterest; Montly2_HHPaidInterest) { }
            column(Montly2_HHPaidInterestPrev; Montly2_HHPaidInterestPrev) { }
            column(Montly2_LEPaidInterest; Montly2_LEPaidInterest) { }
            column(Montly2_LEPaidInterestPrev; Montly2_LEPaidInterestPrev) { }
            column(Montly2_SEPaidInterest; Montly2_SEPaidInterest) { }
            column(Montly2_SEPaidInterestPrev; Montly2_SEPaidInterestPrev) { }
            column(Montly2_SPaidInterest; Montly2_SPaidInterest) { }
            column(Montly2_SPaidInterestPrev; Montly2_SPaidInterestPrev) { }
            column(Monthly2_CountDebt; Monthly2_CountDebt) { }
            column(Monthly2_CountInterest; Monthly2_CountInterest) { }
            column(Monthly2_CountCourtExp; Monthly2_CountCourtExp) { }
            column(Monthly2_CountDebtPrev; Monthly2_CountDebtPrev) { }
            column(Monthly2_CountInterestPrev; Monthly2_CountInterestPrev) { }
            column(Monthly2_CountCourtExpPrev; Monthly2_CountCourtExpPrev) { }
            column(Monthly2_Total; Monthly2_Total) { }

            column(Monthly2_TotalPrev; Monthly2_TotalPrev) { }
            column(Monthly2_HHPerc; Monthly2_HHPerc) { }
            column(Monthly2_HHPercPrev; Monthly2_HHPercPrev) { }
            column(Monthly2_LEPerc; Monthly2_LEPerc) { }
            column(Monthly2_LEPercPrev; Monthly2_LEPercPrev) { }
            column(Monthly2_SEPerc; Monthly2_SEPerc) { }
            column(Monthly2_SEPercPrev; Monthly2_SEPercPrev) { }
            column(Monthly2_SPerc; Monthly2_SPerc) { }
            column(Monthly2_SPercPrev; Monthly2_SPercPrev) { }
            column(Monthly2_TotalPerc; Monthly2_TotalPerc) { }
            column(Monthly2_TotalPercPrev; Monthly2_TotalPercPrev) { }
            column(PaidTaxesTotalCurr; PaidTaxesTotalCurr) { }
            column(HhCountPrev; HhCountPrev) { }
            column(LECountPrev; LECountPrev) { }
            column(SECountPrev; SECountPrev) { }
            column(SvCountPrev; SvCountPrev) { }
            column(CountTotalPrev; CountTotalPrev) { }
            column(HhValueAccPrev; HhValueAccPrev) { }
            column(LEValueAccPrev; LEValueAccPrev) { }
            column(SEValueAccPrev; SEValueAccPrev) { }
            column(SvValueAccPrev; SvValueAccPrev) { }
            column(ValueAccTotalPrev; ValueAccTotalPrev) { }
            column(HhPaidTaxesPrev; HhPaidTaxesPrev) { }
            column(LEPaidTaxesPrev; LEPaidTaxesPrev) { }
            column(SEPaidTaxesPrev; SEPaidTaxesPrev) { }
            column(SvPaidTaxesPrev; SvPaidTaxesPrev) { }
            column(PaidTaxesTotalPrev; PaidTaxesTotalPrev) { }
            dataitem("Accusation Line"; "Accusation Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Line_No_; "Line No.")
                {
                }
                column(Sales_Invoice_No_; "Sales Invoice No.")
                {
                }

                column("PaymentDate"; "Date of Payment")
                {

                }
                column(AmountPaid; "Amount Payed")
                {

                }
                column(PaymentType; "Accusation Line Type")
                {

                }

                column(LineAmount; "Line Amount") { }
                column(Sales_Invoice_No____Transfer; "Sales Invoice No. - Transfer") { }
                trigger OnAfterGetRecord()
                begin
                    if SelectedReport = SelectedReport::accReport then begin
                        //prvobitna varijanta reporta, Pregled/kartica tužbe:
                        //           if "Accusation Line Type" = AccusationLineType::Debt then begin
                        totalDebtAmount += ("Line Amount" + "Debt Amount - Transfer");

                        totalDebtPaidAmount += ("Amount Payed" + "Amount Paid - Transfer");
                        totalInterestAmount += ("Interest Amount" + "Interest Amount - Transfer");
                        totalInterestPaidAmount += "Interest Paid";
                        // TotalVS += "Line Amount";
                        //         end
                        //       else
                        //         if "Accusation Line Type" = "Accusation Line Type"::"Court expenses" then begin
                        //       totalCourtExpensePaidAmount += "Amount Payed";
                        //         totalCourtExpensesAmount += "Line Amount"
                        //       end;

                        "Line Amount" += "Debt Amount - Transfer";
                        "Amount Payed" += "Amount Paid - Transfer";
                    end else
                        if SelectedReport = SelectedReport::accMonthlyOverview then begin
                            //novododata varijanta reporta, Mjesečni pregled:

                        end else
                            if SelectedReport = SelectedReport::accMonthlyOverview2 then begin
                            end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                ALLine: Decimal;
                Accus: Record "Accusation Line";
                CompInfo: Record "Company Information";
                ecl: Record "Employee Contract Ledger";

            begin
                if SelectedReport = SelectedReport::accReport then begin
                    //prvobitna varijanta reporta, Pregled/kartica tužbe:
                    "Accusation Header"."Protocol No." := ProtocolNo;
                    if ProtocolNo <> "Accusation Header"."Protocol No." then begin
                        "Accusation Header"."Protocol No." := ProtocolNo;
                        "Accusation Header".modify;
                    end;
                    AccExe_Pos := '';
                    Acc2_Name := '';
                    AccExeName := '';
                    Acc2_Pos_ := '';
                    CompInfo.get;

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




                    ReportDate := today;
                    cust.Get("Accusation Header"."Customer No.");
                    CompanyInformation.get;
                    CompanyInformation.CalcFields(Picture, Picture1);
                    if "Actual Court Number" <> '' then
                        malsText := "Actual Court Number"
                    else
                        malsText := "Current IP";

                    Accus.Reset();
                    Accus.SetFilter("Document No.", '%1', "Accusation Header"."No.");
                    if Accus.FindFirst() then begin
                        Accus.CalcSums("Line Amount");
                        Accus.CalcSums("Debt Amount - Transfer");
                        TotalVS := Accus."Line Amount" + Accus."Debt Amount - Transfer";
                    end;
                    /*     mals.Reset();
                         mals.SetFilter(Accusation, '%1', "Accusation Header"."No.");
                      //   accStatus.SetFilter(Accusation, '%1', "Accusation Header"."No.");
                         mals.SetFilter(Type, '%1', AccusationRecordType::MALS);
                         accStatus.SetFilter(Type, '%1', AccusationRecordType::"Accusation Status");
                         if mals.findLast then begin
                             malsText := mals.Code;
                         end;
                         if accStatus.FindLast() then begin
                             statusText := accStatus.Status;
                             statusDate := accStatus."Date";
                         end;*/
                    totalCourtExpensesAmount += ("Court Expenses Amount" + "Court Expenses Amt - Transfer");
                    totalCourtExpensesPaidAmount += ("Court Expenses Amount Paid" + "Court Expenses Amt Paid - Tr");
                end else
                    if SelectedReport = SelectedReport::accMonthlyOverview then begin
                        // Filter za tužbe unutar unesenog mjeseca
                        AccHeader.Reset();
                        AccHeader.SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);

                        if AccHeader.FindSet() then
                            repeat
                                // Dohvati potrebna polja za "Court Expenses Amount" i "Bill Category"
                                AccHeader.CalcFields("Court Expenses Amount", "Bill Category");

                                // Obrada za kategoriju Household
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::Household then begin
                                    HhCountCurr += 1;
                                    HhPaidTaxesCurr += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetRange("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindSet() then
                                        repeat
                                            AccLine.CalcSums(AccLine."Line Amount");
                                            AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                            HhValueAccCurr += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                        until AccLine.Next() = 0;
                                end;

                                // (Ostale kategorije: Large Economy, Small Economy, Service)
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::"Large Economy" then begin
                                    LECountCurr += 1;
                                    LEPaidTaxesCurr += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetRange("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindSet() then
                                        repeat
                                            AccLine.CalcSums(AccLine."Line Amount");
                                            AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                            LEValueAccCurr += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                        until AccLine.Next() = 0;
                                end;

                                if AccHeader."Bill Category" = AccHeader."Bill Category"::"Small Economy" then begin
                                    SECountCurr += 1;
                                    SEPaidTaxesCurr += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetRange("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindSet() then
                                        repeat
                                            AccLine.CalcSums(AccLine."Line Amount");
                                            AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                            SEValueAccCurr += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                        until AccLine.Next() = 0;

                                end;
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::Resource then begin
                                    SvCountCurr += 1;
                                    SvPaidTaxesCurr += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetRange("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindSet() then
                                        repeat
                                            AccLine.CalcSums(AccLine."Line Amount");
                                            AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                            SvValueAccCurr += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                        until AccLine.Next() = 0;

                                end;

                            until AccHeader.Next() = 0;

                        // Ukupni rezultati za mjesec
                        CountTotalCurr := HhCountCurr + LECountCurr + SECountCurr + SvCountCurr;
                        ValueAccTotalCurr := HhValueAccCurr + LEValueAccCurr + SEValueAccCurr + SvValueAccCurr;
                        PaidTaxesTotalCurr := HhPaidTaxesCurr + LEPaidTaxesCurr + SEPaidTaxesCurr + SvPaidTaxesCurr;
                    end else
                        if SelectedReport = SelectedReport::accMonthlyOverview2 then begin
                            AccHeader.Reset();
                            AccHeader.SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);

                            if AccHeader.FindSet() then
                                repeat
                                    AccHeader.CalcFields("Court Expenses Amount", "Bill Category");

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::Household then begin
                                        Monthly2_HHCount += 1;

                                        Montly2_HHPaidCourtExp += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_HHPaidInterest += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_HHValuePaidDebt += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_HHTotal := Montly2_HHPaidCourtExp + Montly2_HHPaidInterest + Monthly2_HHValuePaidDebt;


                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::"Large Economy" then begin
                                        Monthly2_LECount += 1;

                                        Montly2_LEPaidCourtExp += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_LEPaidInterest += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_LEValuePaidDebt += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_LETotal := Montly2_LEPaidCourtExp + Montly2_LEPaidInterest + Monthly2_LEValuePaidDebt;

                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::"Small Economy" then begin
                                        Monthly2_SECount += 1;

                                        Montly2_SEPaidCourtExp += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_SEPaidInterest += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_SEValuePaidDebt += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_SETotal := Montly2_SEPaidCourtExp + Montly2_SEPaidInterest + Monthly2_SEValuePaidDebt;



                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::Resource then begin
                                        Monthly2_SECount += 1;

                                        Montly2_SPaidCourtExp += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_SPaidInterest += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_SValuePaidDebt += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_STotal := Montly2_SPaidCourtExp + Montly2_SPaidInterest + Monthly2_SValuePaidDebt;



                                    end;

                                until AccHeader.Next() = 0;
                        end;

                // Ukupni rezultati
                Monthly2_CountDebt := Monthly2_HHValuePaidDebt + Monthly2_LEValuePaidDebt + Monthly2_SEValuePaidDebt + Monthly2_SValuePaidDebt;
                Monthly2_CountInterest := Montly2_HHPaidInterest + Montly2_LEPaidInterest + Montly2_SEPaidInterest + Montly2_SPaidInterest;
                Monthly2_CountCourtExp := Montly2_HHPaidCourtExp + Montly2_LEPaidCourtExp + Montly2_SEPaidCourtExp + Montly2_SPaidCourtExp;
                Monthly2_Total := Monthly2_HHTotal + Monthly2_LETotal + Monthly2_SETotal + Monthly2_STotal;
                if Monthly2_Total <> 0 then
                    Monthly2_HHPerc := Round((Monthly2_HHTotal / Monthly2_Total) * 100, 0.01)
                else
                    Monthly2_HHPerc := 0;

                if Monthly2_Total <> 0 then
                    Monthly2_LEPerc := Round((Monthly2_LETotal / Monthly2_Total) * 100, 0.01)
                else
                    Monthly2_LEPerc := 0;

                if Monthly2_Total <> 0 then
                    Monthly2_SEPerc := Round((Monthly2_SETotal / Monthly2_Total) * 100, 0.01)
                else
                    Monthly2_SEPerc := 0;

                if Monthly2_Total <> 0 then
                    Monthly2_SPerc := Round((Monthly2_STotal / Monthly2_Total) * 100, 0.01)
                else
                    Monthly2_SPerc := 0;

                Monthly2_TotalPerc := Monthly2_HHPerc + Monthly2_LEPerc + Monthly2_SEPerc + Monthly2_SPerc;

            end;



            trigger OnPreDataItem()
            begin
                if SelectedReport = SelectedReport::accReport then begin
                    //prvobitna varijanta reporta, Pregled/kartica tužbe:
                    ReportNameLbl := 'KARTICA-TUŽBE KUPACA';
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
                    registrationNumber := CompanyInformation."Registration No.";
                    registrationVATNumber := CompanyInformation."VAT Registration No.";
                    courtNumber := CompanyInformation.MBS;
                    court := CompanyInformation."Registration Text";
                    activityCode := CompanyInformation."Activity Code";
                    vatNumber := CompanyInformation."Tax No.";

                    totalCourtExpensesAmount := 0;
                    totalCourtExpensesPaidAmount := 0;
                end else
                    if SelectedReport = SelectedReport::accMonthlyOverview then begin
                        //novododata varijanta reporta, Mjesečni pregled:
                        CurrentUser := UserId;
                        if UserSetup.Get(CurrentUser) then begin
                            EmployeeNoForWage := UserSetup."Employee No. for Wage";

                            if Employee.Get(EmployeeNoForWage) then
                                SearchName := Employee."Search Name"
                            else
                                SearchName := '';
                        end else begin
                            EmployeeNoForWage := '';
                            SearchName := '';
                        end;

                        if FilterMonth = 0 then begin
                            Message(EnterAMonthLbl);
                            CurrReport.BREAK;
                        end;
                        if (FilterMonth < 1) or (FilterMonth > 12) then begin
                            Message(MonthValidationLbl);
                            CurrReport.BREAK;
                        end;
                        if FilterYear = 0 then begin
                            Message(EnterAYearLbl);
                            CurrReport.BREAK;
                        end;
                        if (FilterYear <= 1980) or (FilterYear > 9999) then begin
                            Message(YearValidationLbl);
                            CurrReport.BREAK;
                        end;
                        ReportNameLbl := 'Mjesečni izvještaj o poslovanju Preduzeća - Pregled utuženih potraživanja';
                        PreviousYear := FilterYear - 1;
                        MonthLabelTxt := GetMonthName(FilterMonth);

                        StartDateFilterCurr := DMY2DATE(1, FilterMonth, FilterYear);
                        EndDateFilterCurr := GetLastDayOfMonth(StartDateFilterCurr);

                        StartDateFilterPrev := DMY2DATE(1, FilterMonth, FilterYear - 1);
                        EndDateFilterPrev := GetLastDayOfMonth(StartDateFilterPrev);

                        AccHeader.Reset();
                        AccHeader.SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);
                        if not AccHeader.FindFirst() then begin
                            Message(NoDataLbl);
                            CurrReport.BREAK;
                        end;



                        //Za trenutnu godinu isfiltriraj dataitem Accusation Header:
                        SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);

                        HhCountPrev := 0;
                        HhCountCurr := 0;
                        HhValueAccPrev := 0;
                        HhValueAccCurr := 0;
                        HhPaidTaxesPrev := 0;
                        HhPaidTaxesCurr := 0;

                        //Category Large Economy (LE):
                        LECountPrev := 0;
                        LECountCurr := 0;
                        LEValueAccPrev := 0;
                        LEValueAccCurr := 0;
                        LEPaidTaxesPrev := 0;
                        LEPaidTaxesCurr := 0;

                        //Category Small Economy (SE):
                        SECountPrev := 0;
                        SECountCurr := 0;
                        SEValueAccPrev := 0;
                        SEValueAccCurr := 0;
                        SEPaidTaxesPrev := 0;
                        SEPaidTaxesCurr := 0;

                        //Category Service (Sv):
                        SvCountPrev := 0;
                        SvCountCurr := 0;
                        SvValueAccPrev := 0;
                        SvValueAccCurr := 0;
                        SvPaidTaxesPrev := 0;
                        SvPaidTaxesCurr := 0;

                        //Totals:
                        CountTotalPrev := 0;
                        CountTotalCurr := 0;
                        ValueAccTotalPrev := 0;
                        ValueAccTotalCurr := 0;
                        PaidTaxesTotalPrev := 0;
                        PaidTaxesTotalCurr := 0;



                        //amir test

                        AccHeader.Reset();
                        AccHeader.SetRange("Document Date", StartDateFilterPrev, EndDateFilterPrev);
                        if AccHeader.FindSet() then
                            repeat
                                AccHeader.CalcFields(AccHeader."Court Expenses Amount");
                                AccHeader.CalcFields(AccHeader."Bill Category");
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::Household then begin
                                    HhCountPrev += 1;
                                    HhPaidTaxesPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetFilter("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindFirst() then begin
                                        AccLine.CalcSums(AccLine."Line Amount");
                                        AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                        HhValueAccPrev += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                    end;
                                end;
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::"Large Economy" then begin
                                    LECountPrev += 1;
                                    LEPaidTaxesPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetFilter("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindFirst() then begin
                                        AccLine.CalcSums(AccLine."Line Amount");
                                        AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                        LEValueAccPrev += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                    end;
                                end;
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::"Small Economy" then begin
                                    SECountPrev += 1;
                                    SEPaidTaxesPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetFilter("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindFirst() then begin
                                        AccLine.CalcSums(AccLine."Line Amount");
                                        AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                        SEValueAccPrev += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                    end;
                                end;
                                if AccHeader."Bill Category" = AccHeader."Bill Category"::Resource then begin
                                    SvCountPrev += 1;
                                    SvPaidTaxesPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                    AccLine.Reset();
                                    AccLine.SetFilter("Document No.", AccHeader."No.");
                                    AccLine.SetFilter("Accusation Line Type", 'Debt');
                                    if AccLine.FindFirst() then begin
                                        AccLine.CalcSums(AccLine."Line Amount");
                                        AccLine.CalcSums(AccLine."Debt Amount - Transfer");
                                        SvValueAccPrev += AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                    end;
                                end;

                            until AccHeader.Next() = 0;

                        CountTotalPrev := HhCountPrev + LECountPrev + SECountPrev + SvCountPrev;
                        ValueAccTotalPrev := HhValueAccPrev + LEValueAccPrev + SEValueAccPrev + SvValueAccPrev;
                        PaidTaxesTotalPrev := HhPaidTaxesPrev + LEPaidTaxesPrev + SEPaidTaxesPrev + SvPaidTaxesPrev;
                    end else
                        if SelectedReport = SelectedReport::accMonthlyOverview2 then begin
                            ReportNameLbl := 'Mjesečni izvještaj o poslovanju Preduzeća - Pregled naplaćenih potraživanja od utuženih kupaca';

                            CurrentUser := UserId;
                            if UserSetup.Get(CurrentUser) then begin
                                EmployeeNoForWage := UserSetup."Employee No. for Wage";

                                if Employee.Get(EmployeeNoForWage) then
                                    SearchName := Employee."Search Name"
                                else
                                    SearchName := '';
                            end else begin
                                EmployeeNoForWage := '';
                                SearchName := '';
                            end;

                            if FilterMonth = 0 then begin
                                Message(EnterAMonthLbl);
                                CurrReport.BREAK;
                            end;
                            if (FilterMonth < 1) or (FilterMonth > 12) then begin
                                Message(MonthValidationLbl);
                                CurrReport.BREAK;
                            end;
                            if FilterYear = 0 then begin
                                Message(EnterAYearLbl);
                                CurrReport.BREAK;
                            end;
                            if (FilterYear <= 1980) or (FilterYear > 9999) then begin
                                Message(YearValidationLbl);
                                CurrReport.BREAK;
                            end;
                            PreviousYear := FilterYear - 1;
                            MonthLabelTxt := GetMonthName(FilterMonth);

                            StartDateFilterCurr := DMY2DATE(1, FilterMonth, FilterYear);
                            EndDateFilterCurr := GetLastDayOfMonth(StartDateFilterCurr);

                            StartDateFilterPrev := DMY2DATE(1, FilterMonth, FilterYear - 1);
                            EndDateFilterPrev := GetLastDayOfMonth(StartDateFilterPrev);

                            AccHeader.Reset();
                            AccHeader.SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);
                            if not AccHeader.FindFirst() then begin
                                Message(NoDataLbl);
                                CurrReport.BREAK;
                            end;


                            SetRange("Document Date", StartDateFilterCurr, EndDateFilterCurr);

                            //Ena mjesecni izvještaj 

                            //Household(HH)

                            Monthly2_HHCount := 0;
                            Monthly2_HHCountPrev := 0;
                            Monthly2_HHValuePaidDebt := 0;
                            Monthly2_HHValuePaidDebtPrev := 0;
                            Montly2_HHPaidCourtExp := 0;
                            Montly2_HHPaidCourtExpPrev := 0;
                            Montly2_HHPaidInterest := 0;
                            Montly2_HHPaidInterestPrev := 0;
                            Monthly2_HHTotal := 0;
                            Monthly2_HHTotalPrev := 0;

                            //Large Economy(LE)
                            Monthly2_LECount := 0;
                            Monthly2_LECountPrev := 0;
                            Monthly2_LEValuePaidDebt := 0;
                            Monthly2_LEValuePaidDebtPrev := 0;
                            Montly2_LEPaidCourtExp := 0;
                            Montly2_LEPaidCourtExpPrev := 0;
                            Montly2_LEPaidInterest := 0;
                            Montly2_LEPaidInterestPrev := 0;
                            Monthly2_LETotal := 0;
                            Monthly2_LETotalPrev := 0;

                            //Small Economy
                            Monthly2_SECount := 0;
                            Monthly2_SECountPrev := 0;
                            Monthly2_SEValuePaidDebt := 0;
                            Monthly2_SEValuePaidDebtPrev := 0;
                            Montly2_SEPaidCourtExp := 0;
                            Montly2_SEPaidCourtExpPrev := 0;
                            Montly2_SEPaidInterest := 0;
                            Montly2_SEPaidInterestPrev := 0;
                            Monthly2_SETotal := 0;
                            Monthly2_SETotalPrev := 0;

                            //Service
                            Monthly2_SCount := 0;
                            Monthly2_SCountPrev := 0;
                            Monthly2_SValuePaidDebt := 0;
                            Monthly2_SValuePaidDebtPrev := 0;
                            Montly2_SPaidCourtExp := 0;
                            Montly2_SPaidCourtExpPrev := 0;
                            Montly2_SPaidInterest := 0;
                            Montly2_SPaidInterestPrev := 0;
                            Monthly2_STotal := 0;
                            Monthly2_STotalPrev := 0;

                            //Totals
                            Monthly2_CountDebt := 0;
                            Monthly2_CountInterest := 0;
                            Monthly2_CountCourtExp := 0;
                            Monthly2_CountDebtPrev := 0;
                            Monthly2_CountInterestPrev := 0;
                            Monthly2_CountCourtExpPrev := 0;
                            Monthly2_Total := 0;
                            Monthly2_TotalPrev := 0;

                            //Percentage

                            Monthly2_HHPerc := 0;
                            Monthly2_HHPercPrev := 0;
                            Monthly2_LEPerc := 0;
                            Monthly2_LEPercPrev := 0;
                            Monthly2_SEPerc := 0;
                            Monthly2_SEPercPrev := 0;
                            Monthly2_SPerc := 0;
                            Monthly2_SPercPrev := 0;
                            Monthly2_TotalPerc := 0;
                            Monthly2_TotalPercPrev := 0;



                            //ena test

                            AccHeader.Reset();
                            AccHeader.SetRange("Document Date", StartDateFilterPrev, EndDateFilterPrev);

                            if AccHeader.FindSet() then
                                repeat
                                    // AccHeader.CalcFields("Court Expenses Amount", "Bill Category");
                                    AccHeader.CalcFields(AccHeader."Court Expenses Amount");
                                    AccHeader.CalcFields(AccHeader."Bill Category");

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::Household then begin
                                        Monthly2_HHCountPrev += 1;

                                        Montly2_HHPaidCourtExpPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_HHPaidInterestPrev += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_HHValuePaidDebtPrev += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_HHTotalPrev := Montly2_HHPaidCourtExpPrev + Montly2_HHPaidInterestPrev + Monthly2_HHValuePaidDebtPrev;

                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::"Large Economy" then begin
                                        Monthly2_LECountPrev += 1;

                                        Montly2_LEPaidCourtExpPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_LEPaidInterestPrev += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_LEValuePaidDebtPrev += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_LETotalPrev := Montly2_LEPaidCourtExpPrev + Montly2_LEPaidInterestPrev + Monthly2_LEValuePaidDebtPrev;

                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::"Small Economy" then begin
                                        Monthly2_SECountPrev += 1;

                                        Montly2_SEPaidCourtExpPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_SEPaidInterestPrev += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_SEValuePaidDebtPrev += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_SETotalPrev := Montly2_SEPaidCourtExpPrev + Montly2_SEPaidInterestPrev + Monthly2_SEValuePaidDebtPrev;

                                    end;

                                    if AccHeader."Bill Category" = AccHeader."Bill Category"::Resource then begin
                                        Monthly2_SECountPrev += 1;

                                        Montly2_SPaidCourtExpPrev += AccHeader."Court Expenses Amount Paid" + AccHeader."Court Expenses Amt Paid - Tr";
                                        Montly2_SPaidInterestPrev += AccHeader."Interest amount paid" + AccHeader."Interest amount paid-Transfer";

                                        AccLine.Reset();
                                        AccLine.SetRange("Document No.", AccHeader."No.");
                                        AccLine.SetFilter("Accusation Line Type", 'Debt');

                                        if AccLine.FindSet() then
                                            repeat
                                                // Izračunaj FlowField vrijednosti
                                                AccLine.CalcFields("Amount Payed");
                                                AccLine.CalcSums("Amount Paid - Transfer");

                                                // Saberi vrijednosti u sumu
                                                Monthly2_SValuePaidDebtPrev += AccLine."Amount Payed" + AccLine."Amount Paid - Transfer";
                                            until AccLine.Next() = 0;
                                        Monthly2_STotalPrev := Montly2_SPaidCourtExpPrev + Montly2_SPaidInterestPrev + Monthly2_SValuePaidDebtPrev;

                                    end;

                                until AccHeader.Next() = 0;


                        end;
                Monthly2_CountDebtPrev := Monthly2_HHValuePaidDebtPrev + Monthly2_LEValuePaidDebtPrev + Monthly2_SEValuePaidDebtPrev + Monthly2_SValuePaidDebtPrev;
                Monthly2_CountInterestPrev := Montly2_HHPaidInterestPrev + Montly2_LEPaidInterestPrev + Montly2_SEPaidInterestPrev + Montly2_SPaidInterestPrev;
                Monthly2_CountCourtExpPrev := Montly2_HHPaidCourtExpPrev + Montly2_LEPaidCourtExpPrev + Montly2_SEPaidCourtExpPrev + Montly2_SPaidCourtExpPrev;
                Monthly2_TotalPrev := Monthly2_HHTotalPrev + Monthly2_LETotalPrev + Monthly2_SETotalPrev + Monthly2_STotalPrev;
                if Monthly2_TotalPrev <> 0 then
                    Monthly2_HHPercPrev := Round((Monthly2_HHTotalPrev / Monthly2_TotalPrev) * 100, 0.01)
                else
                    Monthly2_HHPercPrev := 0;

                if Monthly2_TotalPrev <> 0 then
                    Monthly2_LEPercPrev := Round((Monthly2_LETotalPrev / Monthly2_TotalPrev) * 100, 0.01)
                else
                    Monthly2_LEPercPrev := 0;

                if Monthly2_TotalPrev <> 0 then
                    Monthly2_SEPercPrev := Round((Monthly2_SETotalPrev / Monthly2_TotalPrev) * 100, 0.01)
                else
                    Monthly2_SEPercPrev := 0;

                if Monthly2_TotalPrev <> 0 then
                    Monthly2_SPercPrev := Round((Monthly2_STotalPrev / Monthly2_TotalPrev) * 100, 0.01)
                else
                    Monthly2_SPercPrev := 0;

                Monthly2_TotalPercPrev := Monthly2_HHPercPrev + Monthly2_LEPercPrev + Monthly2_SEPercPrev + Monthly2_SPercPrev;

            end;
        }


    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group("SelectReport")
                {
                    Caption = 'Select a report';

                    field(SelectedReport; SelectedReport)
                    {
                        Caption = 'Select';
                        OptionCaption = 'Accusation Report,Monthly Overview of Accusations,Monthly Overview of Accusations2 ';
                    }
                    field(FilterMonth; FilterMonth)
                    {
                        Caption = 'Enter a month';
                    }
                    field(FilterYear; FilterYear)
                    {
                        Caption = 'Enter a year';
                    }
                }
                group("Required Fields")
                {
                    Caption = 'Required Fields';

                    field(ProtocolNo; ProtocolNo)
                    {
                        Caption = 'Protocol No.';
                    }
                }
            }
        }

    }

    labels
    {
        KupacLbl = 'Kupac:';
        AdresaLbl = 'Adresa:';
        ŠifaLbl = 'Šifra:';
        Plnlbl = 'Pln:';
        HodNizLbl = 'Hod/Niz:';
        TužbaStatuslbl = 'Tužba status';
        DatumStatusalbl = 'Datum statusa';
        Pocetnolbl = 'Početno:';
        Presudalbl = 'Presuda:';
        Naloglbl = 'Nalog';
        DatumUplatelbl = 'Datum uplate';
        TipUplatelbl = 'Tip uplate';
        Zaduzenjalbl = 'Zaduženja';
        UplateLbl = 'Uplate';
        DugLbl = 'Dug';
        KamataLbl = 'Kamata';
        SudskaTaksalbl = 'Sudska Taksa';
    }


    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture, Picture1);
        ReportNameLbl := '';
        MonthLabelTxt := '';
    end;

    procedure GetMonthName(month: Integer) Result: Text
    begin
        case month of
            1:
                exit(FirstMonth);
            2:
                exit(SecondMonth);
            3:
                exit(ThirdMonth);
            4:
                exit(FourthMonth);
            5:
                exit(FifthMonth);
            6:
                exit(SixthMonth);
            7:
                exit(SeventhMonth);
            8:
                exit(EighthMonth);
            9:
                exit(NinthMonth);
            10:
                exit(TenthMonth);
            11:
                exit(EleventhMonth);
            12:
                exit(TwelfthMonth);
            else
                Error('Invalid month');
        end;
    end;

    procedure GetLastDayOfMonth(FirstDayOfMonth: Date): Date;
    var
        LastDate: Date;
    begin
        LastDate := CALCDATE('<-1D>', CALCDATE('<+1M>', FirstDayOfMonth));
        EXIT(LastDate);
    end;

    var
        CompanyInformation: Record "Company Information";
        cust: Record "Customer";

        totalDebtAmount: Decimal;
        totalDebtPaidAmount: Decimal;
        totalInterestAmount: Decimal;
        totalInterestPaidAmount: Decimal;
        totalCourtExpensesAmount: Decimal;
        totalCourtExpensePaidAmount: Decimal;
        totalAmount: Decimal;
        accStatus: Record Territory;
        mals: Record Territory;
        statusText: Enum AccusationStatus;
        banacc: record "Bank Account";
        transUnion: Text;
        transactionPrivredna: Text;
        transRaif: Text;
        transUni: Text;
        transIntesa: Text;
        transBBI: Text;
        malsText: Text;
        statusDate: Date;
        totalCourtExpensesPaidAmount: Decimal;
        ProtocolNo: text[20];
        ReportDate: Date;
        TotalVS: decimal;
        court: Text;
        courtNumber: Text;
        numberOfDecision: Text;
        registrationNumber: Text;
        vatNumber: Text;
        registrationVATNumber: Text;
        activityCode: Text;
        AccExe_Pos: Text;
        Acc2_Name: Text;
        AccExeName: Text;
        EmpN: record "Employee";
        Acc2_Pos_: Text;
        SelectedReport: Option "accReport","accMonthlyOverview","accMonthlyOverview2";
        FilterMonth, FilterYear : Integer;
        EnterAMonthLbl: Label 'You must enter a month for this report to render';
        EnterAYearLbl: Label 'You must enter a year for this report to render';
        MonthValidationLbl: Label 'You may only enter a number from 1 to 12';
        YearValidationLbl: Label 'You must enter a 4-digit number greater than 1980';
        NoDataLbl: Label 'There is no data for this month and year';
        MonthLabelTxt: Text;
        FirstMonth: Label 'January';
        SecondMonth: Label 'February';
        ThirdMonth: Label 'March';
        FourthMonth: Label 'April';
        FifthMonth: Label 'May';
        SixthMonth: Label 'June';
        SeventhMonth: Label 'July';
        EighthMonth: Label 'August';
        NinthMonth: Label 'September';
        TenthMonth: Label 'October';
        EleventhMonth: Label 'November';
        TwelfthMonth: Label 'December';
        PreviousYear: Integer;

        //Category Household (Hh):
        HhCountPrev, HhCountCurr : Integer;
        HhValueAccPrev, HhValueAccCurr : Decimal;
        HhPaidTaxesPrev, HhPaidTaxesCurr : Decimal;

        //Category Large Economy (LE):
        LECountPrev, LECountCurr : Integer;
        LEValueAccPrev, LEValueAccCurr : Decimal;
        LEPaidTaxesPrev, LEPaidTaxesCurr : Decimal;

        //Category Small Economy (SE):
        SECountPrev, SECountCurr : Integer;
        SEValueAccPrev, SEValueAccCurr : Decimal;
        SEPaidTaxesPrev, SEPaidTaxesCurr : Decimal;

        //Category Service (Sv):
        SvCountPrev, SvCountCurr : Integer;
        SvValueAccPrev, SvValueAccCurr : Decimal;
        SvPaidTaxesPrev, SvPaidTaxesCurr : Decimal;

        //Totals:
        CountTotalPrev, CountTotalCurr : Integer;
        ValueAccTotalPrev, ValueAccTotalCurr : Decimal;
        PaidTaxesTotalPrev, PaidTaxesTotalCurr : Decimal;
        ReportNameLbl: Text;
        StartDateFilterPrev, StartDateFilterCurr : Date;
        EndDateFilterPrev, EndDateFilterCurr : Date;

        AccHeader: Record "Accusation Header";
        AccLine: Record "Accusation Line";
        Monthly2_HHCount: Integer;
        Monthly2_HHValuePaidDebt: Decimal;
        Montly2_HHPaidCourtExp: Decimal;
        Montly2_HHPaidInterest: Decimal;
        Monthly2_HHTotal: Decimal;

        Monthly2_LECount: Integer;
        Monthly2_LEValuePaidDebt: Decimal;
        Montly2_LEPaidCourtExp: Decimal;
        Montly2_LEPaidInterest: Decimal;
        Monthly2_LETotal: Decimal;

        Monthly2_SECount: Integer;
        Monthly2_SEValuePaidDebt: Decimal;
        Montly2_SEPaidCourtExp: Decimal;
        Montly2_SEPaidInterest: Decimal;
        Monthly2_SETotal: Decimal;

        Monthly2_SCount: Integer;
        Monthly2_SValuePaidDebt: Decimal;
        Montly2_SPaidCourtExp: Decimal;
        Montly2_SPaidInterest: Decimal;
        Monthly2_STotal: Decimal;
        Monthly2_HHCountPrev: Integer;
        Monthly2_HHValuePaidDebtPrev: Decimal;
        Montly2_HHPaidCourtExpPrev: Decimal;
        Montly2_HHPaidInterestPrev: Decimal;
        Monthly2_HHTotalPrev: Decimal;

        Monthly2_LECountPrev: Integer;
        Monthly2_LEValuePaidDebtPrev: Decimal;
        Montly2_LEPaidCourtExpPrev: Decimal;
        Montly2_LEPaidInterestPrev: Decimal;
        Monthly2_LETotalPrev: Decimal;

        Monthly2_SECountPrev: Integer;
        Monthly2_SEValuePaidDebtPrev: Decimal;
        Montly2_SEPaidCourtExpPrev: Decimal;
        Montly2_SEPaidInterestPrev: Decimal;
        Monthly2_SETotalPrev: Decimal;

        Monthly2_SCountPrev: Integer;
        Monthly2_SValuePaidDebtPrev: Decimal;
        Montly2_SPaidCourtExpPrev: Decimal;
        Montly2_SPaidInterestPrev: Decimal;
        Monthly2_STotalPrev: Decimal;

        Monthly2_CountDebt: Decimal;
        Monthly2_CountInterest: Decimal;
        Monthly2_CountCourtExp: Decimal;
        Monthly2_CountDebtPrev: Decimal;
        Monthly2_CountInterestPrev: Decimal;
        Monthly2_CountCourtExpPrev: Decimal;
        Monthly2_Total: Decimal;
        Monthly2_TotalPrev: Decimal;



        Monthly2_HHPerc: Decimal;
        Monthly2_HHPercPrev: Decimal;
        Monthly2_LEPerc: Decimal;
        Monthly2_LEPercPrev: Decimal;
        Monthly2_SEPerc: Decimal;
        Monthly2_SEPercPrev: Decimal;
        Monthly2_SPerc: Decimal;
        Monthly2_SPercPrev: Decimal;

        Monthly2_TotalPerc: Decimal;
        Monthly2_TotalPercPrev: Decimal;
        CurrentUser: Text;
        UserSetup: Record "User Setup";

        EmployeeNoForWage: Code[20];
        SearchName: Text[100];
        Employee: Record Employee;

}