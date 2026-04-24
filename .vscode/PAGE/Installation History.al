page 50174 "Installation History"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Installation History";
    Caption = 'Installation History';

    layout
    {
        area(Content)
        {
            field(CountV; CountV)
            {
                ShowCaption = false;
                Caption = 'Count';
                Editable = False;
                Style = Unfavorable;
            }


            repeater("")
            {
                field("Installation Date"; "Installation Date") { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field("Measuring Point Adress"; "Measuring Point Adress") { ApplicationArea = all; }
                field("Measuring Point string"; "Measuring Point string") { }
                field("Measuring Point Stroke"; "Measuring Point Stroke") { }
                field("Gauge Code"; "Gauge Code") { }
                field("Gauge Description"; "Gauge Description") { }
                field("Measuring point off"; "Measuring point off") { }
                field("Measuring point off Date"; "Measuring point off Date") { }


                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("Customer Stroke"; "Customer Stroke") { }
                field("Customer string"; "Customer string") { }
                field("Customer Zone stroke"; "Customer Zone stroke") { }
                field(Code; Code) { ApplicationArea = all; }
                field("Production Year"; "Production Year") { ApplicationArea = all; Visible = false; }
                field("Calibration Year"; "Calibration Year") { ApplicationArea = all; }
                field("Programming date"; "Programming date") { ApplicationArea = all; }
                field("Date of rescheduling"; "Date of rescheduling") { ApplicationArea = all; }
                field("Serial Number I"; "Serial Number I") { ApplicationArea = all; }
                field("Serial Number II"; "Serial Number II") { ApplicationArea = all; }
                field("Reason for dismantling"; "Reason for dismantling") { }
                field("Dismantling date"; "Dismantling date") { }
                field(Active; Active) { }
                field("Date of consumption"; "Date of consumption") { }
                field(Reading; Reading) { }
                field("Gauge Size"; "Gauge Size") { LookupPageId = "Gauge sizes"; DrillDownPageId = "Gauge sizes"; }
                field("Gauge Type"; "Gauge Type") { }
                field("Radio Type"; "Radio Type") { }
                field("Year of Production"; "Year of Production") { }
                field(Billing; Billing) { }





            }

        }






    }

    procedure GetF(DocumentNO: code[20]) Source: Text
    var
        Gauge2: Record "Installation History";
        CJL: Record "Calculation Journal Line";
        MM: Record "Service Item";
        CH: Record "Calcuation Header";
        CU: Record Customer;
        CJL2: Record "Calculation Journal Line";
        Gaug2: Record Gauge;
        iHC: Record "Installation History";
        Csetup: Record "Calculation Setup";
        ELV: Record "El. Volume Corr";
        SalesPr: Record "Sales Price";
        SaldoFirst: Decimal;
        RezDecimal: Decimal;
        Prepayment: Decimal;
        CustomerLedgerEntry: Record "Cust. Ledger Entry";
        CJLUnReadBefore: Record "Calculation Journal Line";
        CJLUnReadBefore2: Record "Calculation Journal Line";
        StreetInt: integer;

        BrojNeocitanihMjeseci: Integer;
        Progress: Dialog;
        CurrRecNo: Integer;
        BrojI: Integer;
        TotalRecNo: Integer;
        StartDaT: Time;
        CurrentDateT: Time;
        CJL2Count: Record "Calculation Journal Line";
        ExportG: Report "Export Gauge";
        Gaug2FirstAutoincrement: Record Gauge;
        CJL2CountEx: Record "Calculation Journal Line";
    begin
        Source := GETFILTERS;
        BrojNeocitanihMjeseci := 0;
        CurrRecNo := 0;
        BrojI := 0;

        StartDaT := Time;

        /*  Progress.OPEN('Otvaranje obračunskih linija do ukupnog broja mjerača ------ #1. Startno vrijeme pokretanja izvještaja je ' + format(StartDaT) + ' .Trenutno vrijeme je ------ #2');
          Progress.UPDATE(1, 0);
          Progress.UPDATE(2, 0);*/

        Gauge2.Reset();
        Gauge2.CopyFilters(Rec);
        Gauge2.SetFilter(Type, '%1', Gauge2.Type::Gauge);
        CH.Reset();
        CH.SetFilter(Code, '%1', DocumentNO);
        if ch.FindSet() then begin
            if ch."All Customer" then
                Gauge2.SetFilter("Customer Category", '<>%1', gauge2."Customer Category"::" ");

            if ch."Category Calculation" = ch."Category Calculation"::"Large Economy" then
                Gauge2.SetFilter("Customer Category", '%1|%2', gauge2."Customer Category"::"Large Economy", gauge2."Customer Category"::"KJKP Heating plant")

            else
                Gauge2.SetFilter("Customer Category", '%1', rec."Customer Category");
            //   if ch."Include Neactive" = true then
            Gauge2.SetFilter("Status MM", '%1|%2', Gauge2."Status MM"::Active, Gauge2."Status MM"::Terminated);
            // else
            //   Gauge2.SetFilter("Status MM", '%1', Gauge2."Status MM"::Active);
            Gauge2.SetFilter("Installation Date", '<=%1', ch."Calculation Date To");
            Gauge2.SetFilter("Dismantling date", '<=%1 & >=%2|>=%3|%4', calcdate('<-1M>', ch."Calculation Date From"), ch."Calculation Date To", ch."Calculation Date From", 0D);
            Gauge2.SetFilter("Measuring Point Code", '<>%1', '');
            Gauge2.SetFilter("Customer No.", '<>%1', '');

        end;
        Gauge2.SetLoadFields("Measuring Point Code", "Customer No.", Code);

        if (CH."Category Calculation" = CH."Category Calculation"::Household) and (ch.Split = true) then begin

            if ch.I = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 0, 1);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 0, 1);
                if CJL2CountEx.FindFirst() then begin
                    ch.I := true;
                    ch.Modify();
                    Commit();
                end;
            end;

            if ch.II = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1', 2);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1', 2);
                if CJL2CountEx.FindFirst() then begin
                    ch.II := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.III = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1', 3);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1', 3);
                if CJL2CountEx.FindFirst() then begin
                    ch.III := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.IV = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 4, 5);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 4, 5);
                if CJL2CountEx.FindFirst() then begin
                    ch.IV := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.V = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 6, 7);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 6, 7);
                if CJL2CountEx.FindFirst() then begin
                    ch.V := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.VI = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 8, 9);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 8, 9);
                if CJL2CountEx.FindFirst() then begin
                    ch.VI := true;
                    ch.Modify();
                    Commit();
                end;
            end;

            if ch.VII = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 10, 11);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 10, 11);
                if CJL2CountEx.FindFirst() then begin
                    ch.VII := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.VIII = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 12, 13);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 12, 13);
                if CJL2CountEx.FindFirst() then begin
                    ch.VIII := true;
                    ch.Modify();
                    Commit();
                end;
            end;
            if ch.IX = false then begin
                Gauge2.SetFilter("Measuring Point string", '%1..%2', 14, 20);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '%1..%2', 14, 20);
                if CJL2CountEx.FindFirst() then begin
                    ch.IX := true;
                    ch.Modify();
                    Commit();
                end;
            end;

            if ch.X = false then begin
                Gauge2.SetFilter("Measuring Point string", '>%1', 20);
                Report.Run(50208, true, true, Gauge2);
                Commit();
                CJL2CountEx.Reset();
                CJL2CountEx.SetFilter(Code, '%1', Ch.Code);
                CJL2CountEx.SetFilter("Measuring Point string", '>%1', 20);
                if CJL2CountEx.FindFirst() then begin
                    ch.X := true;
                    ch.Modify();
                    Commit();
                end;
            end;


        end
        else begin

            Report.Run(50208, true, true, Gauge2);
        end;


    end;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;
        CalcFields("Status MM", "Measuring point off", "Measuring point off Date");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;
        CalcFields("Status MM", "Measuring point off", "Measuring point off Date");

        us.reset;
        us.setfilter("User ID", '%1', UserId);
        if us.FindFirst() then begin

            if us."Calc Date from" <> 0D then begin
                /*   SetFilter("Date Filter 2", '<=%1|>=%2|%3', us."Calc Date from", us."Calc Date to", 0D);
                   //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023
                   SetFilter("Date Filter", '<=%1', us."Calc Date from");
                   SetFilter(Type, '%1', Type::Gauge);*/
            end;
        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CountV := rec.Count;

    end;

    var
        us: Record "User Setup";
        CountV: Integer;
        myInt: Integer;
}