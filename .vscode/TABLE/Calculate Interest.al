report 50185 "Calculate Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    //  DefaultRenderingLayout = LayoutName;
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem("Accusation Line"; "Accusation Line")
        {

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter(Archived, '%1', false);
                SetFilter(Withdrawn, '%1', false);
                if Doc <> '' then
                    SetFilter("Document No.", Doc);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                CI: Record "Interest Calculation";
                Diff: Integer;
                GLS: Record "General Ledger Setup";
                Uplll: Record "Cust. Ledger Entry";
                dateDifference: Date;
                TaxD: Record "Tax deduction list";
                Upl: Record "Cust. Ledger Entry";
                DatesV: Record "Employee Absence" temporary;
                DatesV2: Record "Employee Absence" temporary;
                FIrstDate: date;
                LastDate: Date;
                OnlyPayment: Decimal;
                CalcInterest: Record "Interest Calculation";
                firstPart: Decimal;
                poweredPart: Decimal;
                AccHeader: Record "Accusation Header";
                finalPart: Decimal;
                broj: Integer;
                TotAmount: Decimal;
                StartB: Integer;


            begin

                CI.Reset();
                CI.SetCurrentKey("Line No.");
                CI.Ascending;
                if CI.FindLast() then
                    StartB += Ci."Line No."
                else
                    StartB := 1;

                DatesV.deleteall;
                broj := 0;
                DatesV.Reset();
                AccHeader.Reset();
                AccHeader.SetFilter("Document No.", "Accusation Line"."Document No.");
                if AccHeader.FindFirst() then
                    TaxD.Reset();
                TaxD.SetFilter("Interest Date From", '<=%1', today);
                TaxD.SetFilter("Interest Date To", '%1|>=%2', 0D, "Accusation Line"."Due Date");
                TaxD.SetFilter(Type, '%1', TaxD.Type::"Interest Setup");
                if TaxD.FindSet() then
                    repeat
                        DatesV.Init();
                        broj += 1;
                        DatesV."Entry No." := broj;
                        DatesV."From Date" := TaxD."Interest Date From";
                        if TaxD."Interest Date From" <= "Accusation Line"."Due Date" then
                            DatesV."From Date" := "Accusation Line"."Due Date";
                        /*   if (TaxD."Interest Date To" = 0D) then
                               DatesV."To Date" := today;
                           if DatesV."To Date" < today then
                               DatesV."To Date" := TaxD."Interest Date To";
                           if DatesV."To Date" > today then
                               DatesV."To Date" := today;*/

                        DatesV.Quantity := TaxD."Interest Amount";//iznos kamatne stope

                        DatesV.Insert();
                    until TaxD.Next() = 0;


                Upl.Reset();
                Upl.SetFilter("Document Type", '%1', Upl."Document Type"::Payment);
                Upl.SetFilter("Closed by Entry No.", '%1', "Accusation Line"."Cust. Ledger Entry No.");
                if upl.FindSet() then
                    repeat
                        DatesV.Init();
                        broj += 1;
                        DatesV."Entry No." := broj;
                        DatesV."From Date" := upl."Posting Date";
                        TaxD.Reset();
                        TaxD.SetFilter("Interest Date From", '<=%1', Upl."Posting Date");
                        TaxD.SetFilter(Type, '%1', TaxD.Type::"Interest Setup");
                        TaxD.Ascending;
                        if TaxD.FindLast() then
                            DatesV.Quantity := TaxD."Interest Amount"
                        else
                            DatesV.Quantity := 0;
                        TotAmount := 0;

                        DatesV.Insert();

                    until upl.Next() = 0;

                //sada radimo i uplatu


                CalcInterest.Reset();
                CalcInterest.SetFilter("Document No.", '%1', "Accusation Line"."Document No.");
                CalcInterest.SetFilter("Cust. Ledger Entry No.", '%1', "Accusation Line"."Cust. Ledger Entry No.");
                if CalcInterest.FindSet() then
                    repeat
                        CalcInterest.Delete();
                    until CalcInterest.Next() = 0;
                DatesV2.DeleteAll();
                DatesV.Reset();
                if DatesV.FindSet() then
                    repeat
                        DatesV2.Init();
                        DatesV2.TransferFields(DatesV);
                        DatesV2.Insert();
                    until DatesV.Next() = 0;

                DatesV.Reset();
                DatesV.SetCurrentKey("From Date");
                DatesV.Ascending;
                if DatesV.FindSet() then
                    repeat

                        gls.get();

                        FIrstDate := DatesV."From Date";
                        DatesV2.Reset();
                        DatesV2.SetFilter("From Date", '>%1', DatesV."From Date");
                        DatesV2.SetCurrentKey("From Date");
                        DatesV2.Ascending;
                        if DatesV2.FindFirst() then
                            LastDate := calcdate('<0D>', DatesV2."From Date")
                        else
                            LastDate := today;
                        TotAmount := 0;
                        Uplll.Reset();
                        Uplll.SetFilter("Posting Date", '<=%1', calcdate('<-1D>', LastDate));
                        Uplll.SetFilter("Customer No.", '%1', AccHeader."Customer No.");
                        //     Uplll.SetFilter("Entry No.", '<=%1', Upl."Entry No.");
                        if Uplll.Findset then
                            repeat
                                Uplll.CalcFields(Amount);
                                TotAmount += Uplll.Amount;
                            until Uplll.Next() = 0;

                        DatesV."Quantity (Base)" := TotAmount;

                        Diff := LastDate - FIrstDate;


                        if Diff < 365 then begin
                            //comforni


                            CalcInterest.Init();



                            /*   if CI.FindFirst() then
                                   CalcInterest."Line No." := CI."Line No." + 1
                               else
                                   CalcInterest."Line No." := 1;*/

                            CalcInterest.TransferFields("Accusation Line");
                            TotAmount := 0;
                            Uplll.Reset();
                            Uplll.SetFilter("Posting Date", '%1..%2', FIrstDate, calcdate('<-1D>', LastDate));
                            Uplll.SetFilter("Customer No.", '%1', AccHeader."Customer No.");
                            Uplll.SetFilter("Document Type", '%1', Uplll."Document Type"::Payment);
                            //     Uplll.SetFilter("Entry No.", '<=%1', Upl."Entry No.");
                            if Uplll.Findset then
                                repeat
                                    Uplll.CalcFields(Amount);
                                    TotAmount += Uplll.Amount;
                                until Uplll.Next() = 0;

                            CalcInterest."Payment Amount" := abs(TotAmount);
                            CalcInterest."Interest Yearly Rate" := DatesV."Quantity";
                            CalcInterest."Date from" := FIrstDate;
                            CalcInterest."Date to" := LastDate;
                            CalcInterest."Line No." := StartB;
                            CalcInterest."Difference Days" := Diff;
                            CalcInterest."Remaining Amount" := DatesV."Quantity (Base)";
                            StartB += 1;
                            CalcInterest."Interest Calculation Type" := CalcInterest."Interest Calculation Type"::Comfort;
                            firstPart := 1 + (DatesV.Quantity / 100);
                            poweredPart := Power(firstPart, ((LastDate - FIrstDate) / 365));
                            finalPart := poweredPart - 1;
                            CalcInterest."Interest Coefficient" := finalPart;
                            //ovdje da kažem otvoreni iznos prema toj uplati (prije uplate)
                            CalcInterest."Interest Amount" := CalcInterest."Interest Coefficient" * DatesV."Quantity (Base)";
                            //i sada samo ddodatno izračun iznosa

                            CalcInterest.Insert();

                        end
                        else begin



                            CalcInterest.Init();

                            /*   if CI.FindFirst() then
                                   CalcInterest."Line No." := CI."Line No." + 1
                               else
                                   CalcInterest."Line No." := 1;*/
                            CalcInterest.TransferFields("Accusation Line");

                            TotAmount := 0;
                            Uplll.Reset();
                            Uplll.SetFilter("Posting Date", '%1..%2', FIrstDate, calcdate('<-1D>', LastDate));
                            Uplll.SetFilter("Customer No.", '%1', AccHeader."Customer No.");
                            Uplll.SetFilter("Document Type", '%1', Uplll."Document Type"::Payment);
                            //     Uplll.SetFilter("Entry No.", '<=%1', Upl."Entry No.");
                            if Uplll.Findset then
                                repeat
                                    Uplll.CalcFields(Amount);
                                    TotAmount += Uplll.Amount;
                                until Uplll.Next() = 0;

                            CalcInterest."Payment Amount" := abs(TotAmount);
                            CalcInterest."Line No." := StartB;
                            StartB += 1;
                            CalcInterest."Date from" := FIrstDate;
                            CalcInterest."Interest Yearly Rate" := DatesV."Quantity";
                            CalcInterest."Date to" := LastDate;
                            CalcInterest."Difference Days" := Diff;
                            CalcInterest."Remaining Amount" := DatesV."Quantity (Base)";
                            CalcInterest."Interest Calculation Type" := CalcInterest."Interest Calculation Type"::Standard;
                            CalcInterest."Interest Amount" := (DatesV.Quantity / 36500) * DatesV."Quantity (Base)" * (LastDate - FIrstDate);
                            CalcInterest."Interest Coefficient" := (DatesV.Quantity / 36500) * (LastDate - FIrstDate);
                            CalcInterest.Insert();
                        end;





                    until DatesV.Next() = 0;


            end;
        }




    }

    procedure Setparam(DocumentNo: code[20])
    begin
        Doc := DocumentNo;
    end;


    var
        myInt: Integer;
        Doc: code[20];


}