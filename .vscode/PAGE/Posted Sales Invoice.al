pageextension 50061 PostedSalesInvoice extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter("Document Date")
        {
            field("Bill type"; "Bill type")
            {
                ApplicationArea = all;
            }
            field("Bill Category"; "Bill Category") { }
            field(KIF_Entry; KIF_Entry)
            {
                ApplicationArea = all;

            }
        }
        addafter("Order No.")
        {
            field(Subsidies; Subsidies) { }
            field("Subsidies Amount"; "Subsidies Amount") { }
        }
        addafter("Due Date")
        {
            field("VAT Date"; "VAT Date") { }
        }

        addafter("No.")
        {
            field("Document No_"; "Document No_") { ApplicationArea = all; }


        }

        // addbefore("Posting Date") { field("Bill type"; "Bill type") { Visible = false; ApplicationArea = all; } }

        addafter("Order No.") { field("Payment Reference 2"; "Payment Reference 2") { ApplicationArea = all; } }
        addafter("No. Printed")
        {
            field("Language Code"; "Language Code")
            {
                Caption = 'Language Code for print';
            }
        }
        modify("Your Reference") { Visible = false; }



        addafter(SalesInvLines)
        {
            group(NewPrice)
            {
                Visible = not cng;

                Caption = 'New Price';
                field("New Price"; "New Price") { Visible = not cng; ApplicationArea = all; }
                field("Old Price Date"; "Old Price Date") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal printed"; "Fiscal printed") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal No."; "Fiscal No.") { Visible = not cng; }
                field("Fiscal DateTime"; "Fiscal DateTime") { Visible = not cng; ApplicationArea = all; }
                field("Fiscal User"; "Fiscal User") { Visible = not cng; ApplicationArea = all; }

            }
        }






    }

    actions
    {

        addafter(Print)
        {
            action("Fiscal print")

            {
                Caption = 'Fiscal print';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Fiskalniprinter2.SetParam(Rec."No.", FALSE);
                    Fiskalniprinter2.RUN;
                end;
            }

            action("Fiscal print Correction")

            {
                Caption = 'Fiscal print Correction';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ShowF;

                trigger OnAction()
                var
                    UF: Report "Update Fiscal";

                begin
                    UF.run;
                end;
            }
            action("Posted Order confirmation")
            {
                Caption = 'Posted Order confirmation action';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;


                trigger OnAction()
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", "No.");
                    Report.RunModal(50139, true, true, SalesInvoiceHeader);
                end;
            }
            //"Update Fiscal"

            //report layout stanoa


            action("Print CNG")
            {
                Caption = 'Print CNG';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Visible = true;



                trigger OnAction()
                var
                    ServiceInvoice: report "Tax Invoice";
                    US: Record "User Setup";

                begin

                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if US.FindFirst() then begin
                        US."Bill type" := rec."Bill type";
                        US.modify;
                        Commit();
                    end;
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", "No.");
                    ServiceInvoice.SetParam(Rec."No.");

                    CRL.Reset();
                    CRL.SetFilter("Report ID", '%1', 50131);

                    if rec."Bill Type" = '08' then
                        crl.setfilter("Description", '%1', 'CNG - NN fizičko lice')
                    else
                        crl.setfilter("Description", '<>%1', 'CNG - NN fizičko lice');
                    if crl.FindFirst() then begin
                        RLS.SetTempLayoutSelected(crl.Code);

                        US.Reset();
                        US.SetFilter("User ID", '%1', UserId);
                        if US.FindFirst() then begin
                            US."Bill type" := rec."Bill type";
                            US.modify;
                        end;
                        Commit();

                        //  ServiceInvoice.Run();

                        Report.RunModal(50131, true, false, SalesInvoiceHeader);
                        Commit();

                    end;
                end;
            }

            //kraj

        }


    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        US: Record "User Setup";


    begin


        if Rec."Bill type" <> '' then begin
            Cut.Reset();
            Cut.SetFilter(Code, '%1', Rec."Bill type");
            cut.SetFilter(CNG, '%1', true);
            if cut.FindFirst() then
                CNG := false
            else
                CNG := true;
        end
        else begin
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            us.SetFilter("CNG User", '%1', true);
            if us.FindFirst() then
                cng := false
            else
                CNG := true;
        end;

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        US: Record "User Setup";


    begin

        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if US."Allowed update F" = true then
                ShowF := True
            else
                ShowF := false;

        end;

        if Rec."Bill type" <> '' then begin
            Cut.Reset();
            Cut.SetFilter(Code, '%1', Rec."Bill type");
            cut.SetFilter(CNG, '%1', true);
            if cut.FindFirst() then
                CNG := false
            else
                CNG := true;
        end
        else begin
            US.Reset();
            US.SetFilter("User ID", '%1', UserId);
            us.SetFilter("CNG User", '%1', true);
            if us.FindFirst() then
                cng := false
            else
                CNG := true;
        end;

    end;

    procedure SetParam(No: code[20])
    begin
        "RecNo" := No;
    end;

    var
        myInt: Integer;
        RecNo: Code[20];
        CRL: record "Custom Report Layout";
        RLS: record "Report Layout Selection";
        Fiskalniprinter2: Codeunit FiscalPrinter;
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Cut: Record "Customer Templ.";
        ShowF: Boolean;
        cng: Boolean;
    //   PostedOrderConf: Report "Posted Order Confirmation";
}