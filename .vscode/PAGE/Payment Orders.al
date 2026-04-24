page 50042 "Payment Orders"
{
    Caption = 'Payment Orders';
    Editable = true;
    PageType = List;
    Permissions = TableData 50042 = d;
    SourceTable = "Payment Order";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                    Editable = false;
                }
                field(Code; Code)
                {
                    Editable = false;
                }
                field(Contributon; Contributon)
                {
                    Editable = false;
                }
                field(SvrhaDoznake1; SvrhaDoznake1)
                {
                    Editable = false;
                }
                field(RacunPrimaoca; RacunPrimaoca)
                {
                    Editable = true;
                }
                field(SvrhaDoznake2; SvrhaDoznake2)
                {
                    Editable = false;
                }
                field(SvrhaDoznake3; SvrhaDoznake3)
                {
                    Editable = false;
                }
                field(Primalac1; Primalac1)
                {
                    Editable = false;
                }
                field(Primalac2; Primalac2)
                {
                    Editable = false;
                }
                field(Primalac3; Primalac3)
                {
                    Editable = false;
                }
                field(Iznos; Iznos)
                {
                    Editable = true;
                }
                field(DatumUplate; DatumUplate)
                {
                    Editable = true;
                }
                field(VrstaPrihoda; VrstaPrihoda)
                {
                }
                field(PozivNaBroj; PozivNaBroj)
                {
                }
                field(Opstina; Opstina)
                {
                }
                field(BrojPoreznogObaveznika; BrojPoreznogObaveznika)
                {
                }
                field("User ID"; "User ID")
                {
                    Editable = false;
                }
                field("Date and Time Created"; "Date and Time Created")
                {
                    Editable = false;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    Editable = false;
                }
                field(PorezniPeriodOd; PorezniPeriodOd)
                {
                }
                field(PorezniPeriodDo; PorezniPeriodDo)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Sumarry per Payment Orders")
            {
                Caption = 'Sumarry per Payment Orders';
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Summary per Payment Orders";

                trigger OnAction()
                begin

                    //CurrPage.SETSELECTIONFILTER(PayOrder);
                    //Rec.PrintIt(PayOrder);
                end;
            }
            action("Zaključi UPP naloge")
            {
                Image = Report2;
                //ĐK  RunObject = Report 50093;
                Visible = false;
            }
            action("Ažuriraj datum uplate")
            {
                Image = "Report";
                Promoted = true;
                //ĐK  RunObject = Report 50096;
                Visible = false;
            }
            action(Print)
            {
                Caption = 'Print';
                Image = "Report";
                //ĐK RunObject = Report 99003803;vi
                Visible = false;

            }
        }
    }

    trigger OnOpenPage()
    var
        CU: Codeunit TestSubsCu;
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            Error(CU.WagesNotAllowed());
        //INT1.0 end
    end;

    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
        WA: Record "Wage Addition";
        AddTaxPE: Record "Contribution Per Employee";
        TAXPerEmployee: Record "Tax Per Employee";
    begin

        if "Wage Calculation Type" = "Wage Calculation Type"::Additions then begin
            WA.reset;
            WA.SetFilter(Paid, '%1', true);
            WA.SetFilter("Wage Header No.", '%1', "Wage Header No.");
            WA.SetFilter("Closing Date", '%1', DatumUplate);
            if WA.FindSet() then
                repeat
                    wa.Paid := false;
                    wa.Modify();
                until wa.Next() = 0;
            AddTaxPE.Reset();
            AddTaxPE.SETRANGE("Wage Header No.", "Wage Header No.");
            AddTaxPE.SETRANGE("Wage Calculation Type", 4);
            AddTaxPE.SETRANGE(Paid, true);
            AddTaxPE.SetFilter("Payment Date", '%1', DatumUplate);
            if AddTaxPE.FindSet() then
                repeat
                    AddTaxPE.Paid := false;
                    AddTaxPE."Payment Date" := 0D;
                    AddTaxPE.Modify();
                until AddTaxPE.Next() = 0;

            TAXPerEmployee.Reset();
            TAXPerEmployee.SETRANGE("Wage Header No.", "Wage Header No.");
            TAXPerEmployee.SETRANGE("Wage Calculation Type", 4);
            TAXPerEmployee.SETRANGE(Paid, true);
            TAXPerEmployee.SetFilter("Payment Date", '%1', DatumUplate);
            if TAXPerEmployee.FindSet() then
                repeat
                    TAXPerEmployee.Paid := false;
                    TAXPerEmployee."Payment Date" := 0D;
                    TAXPerEmployee.Modify();
                until TAXPerEmployee.Next() = 0;


        end;
    end;

    var
        PayOrder: Record "Payment Order";

}

