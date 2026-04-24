/*ĐK zašto table 50117 "Payment Order by Branch Office"
{
    Caption = 'Wage Calculation Summary';
    DataCaptionFields = "No.", Description;
    // DrillDownPageID = "Types Of Activities";
    //LookupPageID = Types Of Activities;

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
        field(10; Primalac1; Text[50])
        {
            Caption = 'Payee 1';
        }
        field(12; Primalac2; Text[50])
        {
            Caption = 'Payee 3';
        }
        field(20; Primalac3; Text[50])
        {
            Caption = 'Payee 3';
        }
        field(21; "Type 2"; Code[10])
        {
        }
        field(50; MjestoUplate; Text[30])
        {
            Caption = 'Payment Place';
        }
        field(51; DatumUplate; Date)
        {
            Caption = 'Payment Date';
        }
        field(50001; RacunPosiljaoca; Text[16])
        {
            Caption = 'Payer Account';
        }
        field(50002; RacunPrimaoca; Text[16])
        {
            Caption = 'Payee Account';
        }
        field(50003; Iznos; Decimal)
        {
            Caption = 'Amount';
        }
        field(50004; BrojPoreznogObaveznika; Text[13])
        {
            Caption = 'Tax Payer No.';
        }
        field(50005; VrstaPrihoda; Text[6])
        {
            Caption = 'Income Type';
        }
        field(50006; Opstina; Text[4])
        {
            Caption = 'Municipality';
        }
        field(50007; PozivNaBroj; Text[10])
        {
            Caption = 'Call to No.';
        }
        field(50008; PorezniPeriodOd; Date)
        {
            Caption = 'Tax Period From';
        }
        field(50009; PorezniPeriodDo; Date)
        {
            Caption = 'Tax Period To';
        }
        field(50010; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(50011; "Date and Time Created"; DateTime)
        {
            Caption = 'Date and Time Created';
        }
        field(50012; Printed; Boolean)
        {
            Caption = 'Printed';
        }
        field(50013; Uplatio1; Text[30])
        {
            Caption = 'Paid 1';
        }
        field(50014; Uplatio2; Text[30])
        {
            Caption = 'Paid 2';
        }
        field(50015; Uplatio3; Text[30])
        {
            Caption = 'Paid 3';
        }
        field(50016; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(50017; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(50018; "Wage Payment Type"; Option)
        {
            Caption = 'Wage Payment Type';
            OptionCaption = 'Wage,Add. Tax,Tax,Reduction,Chamber';
            OptionMembers = Wage,"Add. Tax",Tax,Reduction,Chamber;
        }
        field(50019; Contributon; Text[150])
        {
            Caption = 'Contribution';
        }
        field(50020; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Entity,Canton,Municipality';
            OptionMembers = Entity,Canton,Municipality;
        }
        field(50021; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(50022; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts";
        }
        field(50023; OrgDio; Code[10])
        {
            Caption = 'Org Part';
        }
        field(50024; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(50025; Description; Text[50])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                SvrhaDoznake3 := SvrhaDoznake1;
            end;
        }
        field(50026; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
        }
        field(50027; "Search Description"; Code[50])
        {
            Caption = 'Search Description';
        }
        field(50028; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50029; Comment; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist(Vocation WHERE("Table Name" = CONST("Routing Header"),
                                                "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;

        }
        field(50030; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'New,Certified,Under Development,Closed';
            OptionMembers = New,Certified,"Under Development",Closed;
        }
        field(50031; "Org. part"; Code[10])
        {
            Caption = 'Org. part';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; SvrhaDoznake3)
        {
        }
        key(Key3; SvrhaDoznake1)
        {
        }
        key(Key4; Primalac3)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", SvrhaDoznake1, Primalac3)
        {
        }
    }

    trigger OnDelete()
    var
        Item: Record "Item";
        RtngLine: Record "Routing Line";
        MfgComment: Record "Vocation";
    begin
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
        DatumUplate := TODAY;
    end;

    var
        Text000: Label 'This Routing is being used on Items.';
        Text001: Label 'All versions attached to the routing will be closed. Close routing?';
        MfgSetup: Record "Manufacturing Setup";
        RoutingHeader: Record "Payment Order by Branch Office";
        // RtngVersion: Record "Transfered Orders";
        CheckRouting: Codeunit "Check Routing Lines";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text002: Label 'You cannot rename the %1 when %2 is %3.';
        PayOrder: Record "Payment Order by Branch Office";
        NextEntryNo: Integer;
        CompInfo: Record "Company Information";

    procedure PrintIt(var POrder: Record "Payment Order")
    begin
        //ĐK   REPORT.RUNMODAL(REPORT::"TS_knjizenja 1", TRUE, TRUE, POrder);
    end;

    procedure InitPaymentOrder()
    begin
        CLEAR(PayOrder);
        PayOrder.RESET;
        PayOrder.INIT;
    end;

    procedure InsertPaymentOrderValues1(aSvrhaDoznake1: Text[150]; aSvrhaDoznake2: Text[50]; aSvrhaDoznake3: Text[50]; aPrimalac1: Text[50]; aPrimalac2: Text[50]; aPrimalac3: Text[50]; aRacunPosiljaoca: Text[16]; aRacunPrimaoca: Text[16]; aIznos: Decimal; aContribution: Text[150]; aTip: Integer; aSifra: Text[100]; vTip: Integer; aOrgDio: Code[10]; BranchOfficeCode: Text)
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
        PayOrder."Org. part" := BranchOfficeCode;
    end;

    procedure InsertPaymentOrderValues2(aBrojPoreznogObaveznika: Text[13]; aVrstaPrihoda: Text[6]; aOpstina: Text[4]; aPozivNaBroj: Text[10]; aPorezniPeriodOd: Date; aPorezniPeriodDo: Date; aWageHeaderNo: Code[20]; aWageHeaderEntryNo: Integer; aWagePaymentType: Integer; aContribution: Text[150]; aTip: Integer; aSifra: Text[100]; vTip: Integer; aOrgDio: Code[10])
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
    end;

    procedure InsertPaymentOrder(): Integer
    begin
        PayOrder.INSERT(TRUE);
        EXIT(PayOrder."Entry No.");
    end;

    procedure AssistEdit(OldRtngHeader: Record "Payment Order by Branch Office"): Boolean
    begin
    end;
}

*/