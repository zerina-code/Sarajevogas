pageextension 50079 "Sales Invoice Extends" extends "Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Payment Type Invoice"; "Payment Type Invoice")
            {
                ApplicationArea = all;
                Editable = false;

            }

        }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Validate(Rec."Posting Date", Rec."Document Date");
                //Rec."Posting Date" := Rec."Document Date";
            end;
        }
        addafter("Payment Type Invoice")
        {
            field(KIF_Entry; KIF_Entry)
            {
                ApplicationArea = all;
            }
        }

    }

    actions
    {

    }
    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        CustomerT: Record "Customer Templ.";
        CustomerPage: page "Customer Templ. List";
        UserSetup: Record "User Setup";
        SalesH: Record "Sales Header";
        SalesO: page "Sales Order";
        SalesOH: Record "Sales Header";
        Docno: text[250];
        NoSeriesMgt: Codeunit NoSeriesExtented;


        SalesSetup: Record "Sales & Receivables Setup";

    begin
        SalesSetup.Get();

        CLEAR(CustomerPage);
        CustomerT.Reset();
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if (UserSetup.Household <> 0) or (UserSetup.Household <> 0) then begin
                CustomerPage.SetTableView(CustomerT);
            end;


        end;

        // CustomerPage.Run();
        CustomerPage.LOOKUPMODE(TRUE);
        IF CustomerPage.RUNMODAL = ACTION::LookupOK THEN BEGIN
            CustomerPage.GETRECORD(CustomerT);
            "Payment Type Invoice" := CustomerT.Code;


            /* if CustomerT.NN = true then begin

                 SalesH.Init();
                 SalesH."Bill type" := CustomerT.Code;
                 SalesH.Validate("Document Type", SalesH."Document Type"::Order);
                 SalesH.validate("Document Date", Today);
                 SalesH.validate("VAT Date", today);
                 Docno := NoSeriesMgt.GetNextNo(SalesSetup."Order Nos.", TODAY, false);
                 SalesH.Validate("No.", Docno);
                 SalesH.Validate("Assigned User ID", UserId);
                 SalesH.validate("Order Date", today);
                 SalesH.validate("Posting Date", today);
                 SalesH.Validate("Sell-to Customer No.", SalesSetup."NN Customer Code");
                 SalesH.Insert();

                 SalesH.Reset();
                 SalesH.SetFilter("No.", '%1', Docno);
                 CurrPage.Close();
                 SalesO.SetTableView(SalesH);
                 Commit();
                 SalesO.Run();
                 Commit();




             end;*/




        END;






    end;


    var
        myInt: Integer;
}