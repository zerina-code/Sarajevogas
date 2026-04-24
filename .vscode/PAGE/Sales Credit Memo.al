pageextension 50078 "Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Due Date")
        {
            field(KUF_Entry; KIF_Entry)
            {
                ApplicationArea = all;
            }
        }
        modify("Foreign Trade")
        {
            Visible
        = false;
        }

        // Add changes to page layout here
        addafter("Document Date")
        {
            field("VAT Date"; "VAT Date")
            {
            }

        }
        addafter("Salesperson Code")
        {
            field("Bal. Account No."; "Bal. Account No.")
            {
            }
        }
        modify("Posting Description") { Visible = true; }
        modify("EU 3-Party Trade") { Visible = false; }
        modify("Pmt. Discount Date") { Visible = false; }
        modify("Payment Discount %") { Visible = false; }
        modify("Responsibility Center") { Visible = false; }
        modify("Campaign No.") { Visible = false; }
        modify("Work Description") { Visible = false; }
        modify("Your Reference") { Visible = false; }
        modify("Document Date")
        {
            trigger OnAfterValidate()
            begin
                Validate(Rec."Posting Date", Rec."Document Date");
                //Rec."Posting Date" := Rec."Document Date";
            end;
        }
        addafter("Applies-to ID")
        {
            field("Bill type"; "Bill type")
            {
                visible = true;
                editable = false;
            }

            field
            ("Control Employee USERID"; "Control Employee USERID")
            { }
            field("Posting Employee USERID"; "Posting Employee USERID") { Editable = false; }
            field("Exe Employee USERID"; "Exe Employee USERID") { Editable = false; Visible = false; }
        }
    }
    //
    actions
    {
        // Add changes to page actions here
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
            "Bill type" := CustomerT.Code;
            "Bill Category" := CustomerT."Bill Category";



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


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
        GS: Record "Company Information";
    begin
        GS.Get();
        "Exe Employee USERID" := gs."Employee Signatory";
    end;


    var
        myInt: Integer;


}