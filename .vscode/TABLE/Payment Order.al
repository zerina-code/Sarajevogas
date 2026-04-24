table 50042 "Payment Order"
{
    Caption = 'Payment Order';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; SvrhaDoznake1; Text[150])
        {
            Caption = 'Allocation Purpose 1';
        }
        field(3; SvrhaDoznake2; Text[50])
        {
            Caption = 'Allocation Purpose 2';
        }
        field(4; SvrhaDoznake3; Text[50])
        {
            Caption = 'Allocation Purpose 3';
        }
        field(5; Primalac1; Text[50])
        {
            Caption = 'Payee 1';
        }
        field(6; Primalac2; Text[50])
        {
            Caption = 'Payee 3';
        }
        field(7; Primalac3; Text[50])
        {
            Caption = 'Payee 3';
        }
        field(8; MjestoUplate; Text[30])
        {
            Caption = 'Payment Place';
        }
        field(9; DatumUplate; Date)
        {
            Caption = 'Payment Date';
        }
        field(10; RacunPosiljaoca; Text[16])
        {
            Caption = 'Payer Account';
        }
        field(11; RacunPrimaoca; Text[20])
        {
            Caption = 'Payee Account';
        }
        field(12; Iznos; Decimal)
        {
            Caption = 'Amount';
        }
        field(13; BrojPoreznogObaveznika; Text[13])
        {
            Caption = 'Tax Payer No.';
        }
        field(14; VrstaPrihoda; Text[6])
        {
            Caption = 'Income Type';
        }
        field(15; Opstina; Text[6])
        {
            Caption = 'Municipality';
        }
        field(16; PozivNaBroj; Text[10])
        {
            Caption = 'Call to No.';
        }
        field(17; PorezniPeriodOd; Date)
        {
            Caption = 'Tax Period From';
        }
        field(18; PorezniPeriodDo; Date)
        {
            Caption = 'Tax Period To';
        }
        field(100; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(101; "Date and Time Created"; DateTime)
        {
            Caption = 'Date and Time Created';
        }
        field(102; Printed; Boolean)
        {
            Caption = 'Printed';
        }
        field(103; Uplatio1; Text[100])
        {
            Caption = 'Paid 1';
        }
        field(104; Uplatio2; Text[100])
        {
            Caption = 'Paid 2';
        }
        field(105; Uplatio3; Text[30])
        {
            Caption = 'Paid 3';
        }
        field(106; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
            TableRelation = "Wage Header";
        }
        field(107; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(108; "Wage Payment Type"; Option)
        {
            Caption = 'Wage Payment Type';
            OptionCaption = 'Wage,Add. Tax,Tax,Reduction,Chamber';
            OptionMembers = Wage,"Add. Tax",Tax,Reduction,Chamber;
        }
        field(109; Contributon; Text[150])
        {
            Caption = 'Contribution';
        }
        field(110; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Entity,Canton,Municipality';
            OptionMembers = Entity,Canton,Municipality;
        }
        field(111; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(112; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(113; OrgDio; Code[10])
        {
            Caption = 'Org Part';
        }
        field(114; Loan; Boolean)
        {
        }
        field(115; "Reduction Type"; Code[10])
        {
            Caption = 'Reduction Type';
        }
        field(116; "Budget Organisation"; Text[100])
        {
            Caption = 'Budžetska organizacija';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        if Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::Regular then begin
            WH.GET("Wage Header No.");
        end
        else begin
            WH.Reset();
            WH.SetFilter("No.", '%1', Rec."Wage Header No.");
            WH.FindFirst();
        end;
        IF WH.Status = WH.Status::Closed THEN
            ERROR('Ne možete obrisati virmane plate koja je zaključena');
    end;


    trigger OnInsert()
    begin
        NextEntryNo := 0;
        //PayOrder.RESET;
        IF PayOrder.FIND('+') THEN NextEntryNo := PayOrder."Entry No.";
        NextEntryNo += 1;
        "Entry No." := NextEntryNo;
        "User ID" := USERID;
        "Date and Time Created" := CREATEDATETIME(TODAY, TIME);
        CompInfo.GET;
        Uplatio2 := UPPERCASE(CompInfo.Name);
        Uplatio3 := UPPERCASE(CompInfo."Post Code" + ' ' + CompInfo.City);
        MjestoUplate := UPPERCASE(CompInfo."Post Code" + ' ' + CompInfo.City);
        //DatumUplate := TODAY;
    end;

    var
        PayOrder: Record "Payment Order";
        NextEntryNo: Integer;
        CompInfo: Record "Company Information";
        WH: Record "Wage Header";

    procedure PrintIt(var POrder: Record "Payment Order")
    begin
        //ĐK    REPORT.RUNMODAL(REPORT::"TS_knjizenja 1", TRUE, TRUE, POrder);
    end;

    procedure InitPaymentOrder()
    begin
        CLEAR(PayOrder);
        PayOrder.RESET;
        PayOrder.INIT;
    end;

    procedure InsertPaymentOrderValues1(aSvrhaDoznake1: Text[150]; aSvrhaDoznake2: Text[50]; aSvrhaDoznake3: Text[50]; aPrimalac1: Text[50]; aPrimalac2: Text[50]; aPrimalac3: Text[50]; aRacunPosiljaoca: Text[16]; aRacunPrimaoca: Text[20]; aIznos: Decimal; aContribution: Text[150]; aTip: Integer; aSifra: Text[100]; vTip: Integer; aOrgDio: Code[10]; aDatum: Date; aRType: Code[30]; BudgetO: text[100])
    begin
        PayOrder.SvrhaDoznake1 := aSvrhaDoznake1;
        PayOrder.SvrhaDoznake2 := aSvrhaDoznake2;
        PayOrder.SvrhaDoznake3 := aSvrhaDoznake3;
        PayOrder.Primalac1 := aPrimalac1;
        PayOrder.Primalac2 := aPrimalac2;
        PayOrder.Primalac3 := aPrimalac3;
        PayOrder.RacunPosiljaoca := aRacunPosiljaoca;
        PayOrder.RacunPrimaoca := aRacunPrimaoca;
        PayOrder.Iznos := aIznos;
        PayOrder.Contributon := aContribution;
        PayOrder.Type := aTip;
        PayOrder.Code := aSifra;
        PayOrder."Wage Calculation Type" := vTip;
        PayOrder.OrgDio := aOrgDio;
        PayOrder."Budget Organisation" := BudgetO;
        PayOrder.DatumUplate := aDatum;
        PayOrder."Reduction Type" := aRType;
    end;

    procedure InsertPaymentOrderValues2(aBrojPoreznogObaveznika: Text[13]; aVrstaPrihoda: Text[6]; aOpstina: Text[6]; aPozivNaBroj: Text[10]; aPorezniPeriodOd: Date; aPorezniPeriodDo: Date; aWageHeaderNo: Code[20]; aWageHeaderEntryNo: Integer; aWagePaymentType: Integer; aContribution: Text[150]; aTip: Integer; aSifra: Text[100]; vTip: Integer; aOrgDio: Code[10]; aDatum: Date; aRType: Code[30]; BudgetO: text[100])
    begin
        PayOrder.BrojPoreznogObaveznika := aBrojPoreznogObaveznika;
        PayOrder.VrstaPrihoda := aVrstaPrihoda;
        PayOrder.PozivNaBroj := aPozivNaBroj;
        PayOrder.PorezniPeriodOd := aPorezniPeriodOd;
        PayOrder.PorezniPeriodDo := aPorezniPeriodDo;
        PayOrder.Opstina := aOpstina;
        PayOrder."Wage Header No." := aWageHeaderNo;
        PayOrder."Wage Header Entry No." := aWageHeaderEntryNo;
        PayOrder."Wage Payment Type" := aWagePaymentType;
        PayOrder.Contributon := aContribution;
        PayOrder.Type := aTip;
        PayOrder.Code := aSifra;
        PayOrder."Wage Calculation Type" := vTip;
        PayOrder.OrgDio := aOrgDio;
        PayOrder.DatumUplate := aDatum;
        PayOrder."Reduction Type" := aRType;
        PayOrder."Budget Organisation" := BudgetO;
    end;

    procedure InsertPaymentOrder(): Integer
    begin
        PayOrder.INSERT(TRUE);
        EXIT(PayOrder."Entry No.");
    end;
}

