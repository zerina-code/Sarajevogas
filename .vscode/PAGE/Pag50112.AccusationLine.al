page 50112 "Accusation Line"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Accusation Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Accusation Line Type"; "Accusation Line Type")
                {
                    ApplicationArea = All;
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Bill Category"; Rec."Bill Category")
                {
                    ApplicationArea = All;
                }
                field("Sales Invoice No."; Rec."Sales Invoice No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        si: Record "Sales Invoice Header";
                        amount: Decimal;
                    begin
                        si.SetFilter("No.", '%1', Rec."Sales Invoice No.");
                        if si.FindFirst() then begin
                            si.CalcFields("Amount Including VAT");
                            "Line Amount" := si."Amount Including VAT";
                            Rec.Modify();
                            //    Modify();
                        end;
                    end;
                }
                field("Sales Invoice No. - Transfer"; Rec."Sales Invoice No. - Transfer")
                {
                    ApplicationArea = All;
                }

                field("Line Amount"; "Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        AccHeader: Record "Accusation Header";
                        AccLine: Record "Accusation Line";
                        TotalDebt: Decimal;
                    begin
                        if Rec.Modify(true) then;

                        if AccHeader.Get(Rec."Document No.") then begin
                            TotalDebt := 0;
                            AccLine.Reset();
                            AccLine.SetRange("Document No.", Rec."Document No.");
                            AccLine.SetFilter("Accusation Line Type", '%1', Rec."Accusation Line Type"::Debt);
                            if AccLine.FindSet() then
                                repeat
                                    TotalDebt := TotalDebt + AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                until AccLine.Next() = 0;

                            AccHeader.Debt := TotalDebt;
                            if AccHeader.Modify(true) then;
                        end;
                        Rec."Interest Amount" := CalculateInterest(Rec, false);
                    end;
                    /*
                    Amir: triger koji sam zatekao,
                           sa ovim gore kodom, umjesto zateknutog, nema 
                           validacijskih gresaka... 
                           ostaje pitanje: kako se generišu tužbe, te da li nekako treba
                           zaštiti redak i vrijednost Line Amount ako je nastalo
                           automatizmom... 
                    trigger OnValidate()
                    var
                        acc: Record "Accusation Header";
                        accLine: Record "Accusation Line";
                        tempLine: Record "Accusation Line";
                        debt: Decimal;
                        interest: Decimal;
                    begin
                        acc.SetFilter("No.", '%1', "Document No.");
                        tempLine.SetFilter("Document No.", '%1', "Document No.");
                        tempLine.SetFilter("Line No.", '%1', Rec."Line No.");
                        if tempLine.FindFirst() then begin
                            tempLine."Line Amount" := Rec."Line Amount";
                            tempLine.Modify();
                        end;
                        if acc.FindFirst() then begin
                            accLine.SetFilter("Document No.", '%1', Rec."Document No.");
                            accLine.SetFilter("Accusation Line Type", '%1', AccusationLineType::"Debt");
                            if accLine.FindSet() then
                                repeat
                                begin
                                    debt := debt + accLine."Line Amount" + accLine."Debt Amount - Transfer"
                                end;
                                until accLine.next = 0;

                            acc.Debt := debt;
                            "Interest Amount" := CalculateInterest(Rec);
                            acc.Modify();
                        end;
                    end;
*/
                }
                field("Date of Debt"; "Date of Debt")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Debt Amount - Transfer"; Rec."Debt Amount - Transfer")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        AccHeader: Record "Accusation Header";
                        AccLine: Record "Accusation Line";
                        TotalDebt: Decimal;
                    begin
                        if Rec.Modify(true) then;

                        if AccHeader.Get(Rec."Document No.") then begin
                            TotalDebt := 0;
                            AccLine.Reset();
                            AccLine.SetRange("Document No.", Rec."Document No.");
                            AccLine.SetFilter("Accusation Line Type", '%1', Rec."Accusation Line Type"::Debt);
                            if AccLine.FindSet() then
                                repeat
                                    TotalDebt := TotalDebt + AccLine."Line Amount" + AccLine."Debt Amount - Transfer";
                                until AccLine.Next() = 0;

                            AccHeader.Debt := TotalDebt;
                            if AccHeader.Modify(true) then;
                        end;
                        Rec."Interest Amount - Transfer" := CalculateInterest(Rec, true);

                    end;
                }
                field("Date of Payment"; "Date of Payment")
                {
                    ApplicationArea = All;
                }
                field("Amount Payed"; "Amount Payed")
                {
                    ApplicationArea = All;
                }
                field("Amount Paid - Transfer"; Rec."Amount Paid - Transfer")
                {
                    ApplicationArea = All;
                }
                field("Date - Transfer"; Rec."Date - Transfer")
                {
                    ApplicationArea = All;
                }
                field("Due Date - Transfer"; Rec."Due Date - Transfer")
                {
                    ApplicationArea = All;
                }
                field(Differen; Differen)
                {
                    Caption = 'Difference';


                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    ApplicationArea = All;
                }
                /*  field("Interest Calculation Type"; "Interest Calculation Type")
                  {
                      ApplicationArea = All;
                  }
                  field("Interest Coefficient"; "Interest Coefficient")
                  {
                      ApplicationArea = All;


                  }

  */
                field("Interest Amount"; "Interest Amount")
                {
                    // ApplicationArea = All;
                    LookupPageId = 50199;
                    DrillDownPageId = 50199;
                    /* trigger OnValidate()
                     var
                         acc: Record "Accusation Header";
                         accLine: Record "Accusation Line";
                         tempLine: Record "Accusation Line";
                         debt: Decimal;
                         interest: Decimal;
                     begin
                         acc.SetFilter("No.", '%1', "Document No.");
                         tempLine.SetFilter("Document No.", '%1', "Document No.");
                         tempLine.SetFilter("Line No.", '%1', Rec."Line No.");
                         if tempLine.FindFirst() then begin
                             tempLine."Interest Amount" := Rec."Interest Amount";
                             tempLine.Modify();
                         end;
                         if acc.FindFirst() then begin
                             accLine.SetFilter("Document No.", '%1', Rec."Document No.");
                             if accLine.FindSet() then
                                 repeat
                                 begin
                                     interest := interest + accLine."Interest Amount"
                                 end;
                                 until accLine.next = 0;
                             acc.Interest := interest;
                             acc.Modify();
                         end;
                     end;

 */
                }
                field("Interest Amount - Transfer"; Rec."Interest Amount - Transfer")
                {
                    ApplicationArea = All;
                }

                /*field("Interest Paid"; "Interest Paid")
                {
                    ApplicationArea = All;
                }*/
                field(Description; Description)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        acc: Record "Accusation Header";
                        accLine: Record "Accusation Line";
                        tempLine: Record "Accusation Line";
                        debt: Decimal;
                        interest: Decimal;
                    begin
                        acc.SetFilter("No.", '%1', "Document No.");
                        tempLine.SetFilter("Document No.", '%1', "Document No.");
                        tempLine.SetFilter("Line No.", '%1', Rec."Line No.");
                        if tempLine.FindFirst() then begin
                            tempLine."Line Amount" := Rec."Line Amount";
                            tempLine.Modify();
                        end;
                        if acc.FindFirst() then begin
                            accLine.SetFilter("Document No.", '%1', Rec."Document No.");
                            accLine.SetFilter("Accusation Line Type", '%1', AccusationLineType::"Debt");
                            if accLine.FindSet() then
                                repeat
                                begin
                                    debt := debt + accLine."Line Amount" + accLine."Debt Amount - Transfer"
                                end;
                                until accLine.next = 0;

                            acc.Debt := debt;
                            "Interest Amount" := CalculateInterest(Rec, false);
                            MESSAGE(FORMAT("Interest Amount"));
                        end;
                    end;
                }
                field(Note; Note)
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        InitNewLine(Rec);
    end;

    local procedure InitNewLine(var NewAccLine: Record "Accusation Line")
    var
        AccusationLine: Record "Accusation Line";
        gls: Record "General Ledger Setup";
    begin
        NewAccLine.Copy(Rec);
        AccusationLine.SetRange("Document No.", NewAccLine."Document No.");
        if AccusationLine.FindLast then begin
            NewAccLine."Line No." := AccusationLine."Line No." + 1
        end
        else begin
            NewAccLine."Line No." := 1;
        end;
        gls.get();
        NewAccLine."Interest Yearly Rate" := gls."Interest Yearly Rate";
        NewAccLine."Interest Calculation Type" := NewAccLine."Interest Calculation Type"::Comfort;

    end;

    local procedure CalculateInterest(accLine: Record "Accusation Line"; OldDebt: Boolean): Decimal;
    var
        amount: Decimal;
        coeff: Decimal;
        saleInvoice: Record "Sales Invoice Header";
        dateDifference: Integer;
        gls: Record "General Ledger Setup";
        firstPart: Decimal;
        poweredPart: Decimal;
        //ISKORISTITI iz GLS Yearly Interest Rate i Number of Days
        finalPart: Decimal;
    begin

        //

        gls.get();
        if OldDebt then begin
            if accLine."Due Date - Transfer" = 0D then
                Error('Datum dospijeća prenos polje je prazno.');
            dateDifference := Today - accLine."Due Date - Transfer"
        end
        else begin
            if accLine."Due Date" = 0D then
                Error('Datum dospijeća polje je prazno.');
            dateDifference := Today - accLine."Due Date";
        end;
        if dateDifference > 0 then begin
            if accLine."Interest Calculation Type" = InterestCalculationType::Standard then begin
                coeff := gls."Interest Yearly Rate" * dateDifference / 36500;
                if OldDebt then
                    amount := gls."Interest Yearly Rate" * accLine."Debt Amount - Transfer" * dateDifference / 36500
                else
                    amount := gls."Interest Yearly Rate" * accLine."Line Amount" * dateDifference / 36500;
            end else
                if accLine."Interest Calculation Type" = InterestCalculationType::Comfort then begin
                    firstPart := 1 + (gls."Interest Yearly Rate" / 100);
                    poweredPart := Power(firstPart, (dateDifference / 365));
                    finalPart := poweredPart - 1;
                    coeff := finalPart;
                    if OldDebt then
                        amount := finalPart * accLine."Debt Amount - Transfer"
                    else
                        amount := finalPart * accLine."Line Amount";
                end;
        end;
        exit(amount);
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Amount Payed");
        Differen := (Rec."Line Amount" + Rec."Debt Amount - Transfer") - (Rec."Amount Payed" + Rec."Amount Paid - Transfer");
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Amount Payed");
        Differen := (Rec."Line Amount" + Rec."Debt Amount - Transfer") - (Rec."Amount Payed" + Rec."Amount Paid - Transfer");
    end;

    var
        Differen: Decimal;
}