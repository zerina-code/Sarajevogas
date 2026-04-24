page 50060 "Payment Order"
{
    Caption = 'Payment Order';
    PageType = Card;
    SourceTable = "Payment Order";

    layout
    {
        area(content)
        {
            group("Payment Order")
            {
                Caption = 'Payment Order';
                field("Wage Header No."; "Wage Header No.")
                {
                    Editable = false;
                }
                field("Entry No."; "Entry No.")
                {
                }
                field(Uplatio1; Uplatio1)
                {
                }
                field(Uplatio2; Uplatio2)
                {
                }
                field(Uplatio3; Uplatio3)
                {
                }
                field(SvrhaDoznake1; SvrhaDoznake1)
                {
                }
                field(SvrhaDoznake2; SvrhaDoznake2)
                {
                }
                field(SvrhaDoznake3; SvrhaDoznake3)
                {
                }
                field(Primalac1; Primalac1)
                {
                    Visible = false;
                }
                field(Primalac2; Primalac2)
                {
                }
                field(Primalac3; Primalac3)
                {
                }
                field(MjestoUplate; MjestoUplate)
                {
                }
                field(DatumUplate; DatumUplate)
                {
                }
                field(RacunPosiljaoca; RacunPosiljaoca)
                {
                    Visible = false;
                }
                field(RacunPrimaoca; RacunPrimaoca)
                {
                    Visible = false;
                }
                field(Iznos; Iznos)
                {
                }
                field(BrojPoreznogObaveznika; BrojPoreznogObaveznika)
                {
                }
                field(VrstaPrihoda; VrstaPrihoda)
                {
                }
                field(Opstina; Opstina)
                {
                }
                field(PozivNaBroj; PozivNaBroj)
                {
                }
                field(PorezniPeriodOd; PorezniPeriodOd)
                {
                }
                field(PorezniPeriodDo; PorezniPeriodDo)
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Date and Time Created"; "Date and Time Created")
                {
                }
                field(Printed; Printed)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Filter za plate")
            {
                Caption = 'Wage Filter';
                Image = WageLines;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    frm: Page "Wage Header List";
                    WHNo: Code[10];
                    WageHeader: Record "Wage Header";
                begin

                    frm.LOOKUPMODE := TRUE;
                    IF frm.RUNMODAL = ACTION::LookupOK THEN BEGIN
                        WHNo := frm.GetSelection;
                        WageHeader.SETRANGE("No.", WHNo);
                        IF WageHeader.FIND('-') THEN BEGIN
                            SETRANGE("Wage Header No.", WHNo);
                        END;
                    END;
                end;
            }
            action("Skini filter za plate")
            {
                Visible = false;

                trigger OnAction()
                begin
                    RESET;
                end;
            }
            action("Ispiši sve")
            {
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    PayOrder.COPYFILTERS(Rec);
                    Rec.PrintIt(PayOrder);
                end;
            }
            action("Ispiši")
            {
                //ĐK Image = print;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin

                    CurrPage.SETSELECTIONFILTER(PayOrder);
                    Rec.PrintIt(PayOrder);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        compinfo: Record "Company Information";
        PayOrder: Record "Payment Order";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

