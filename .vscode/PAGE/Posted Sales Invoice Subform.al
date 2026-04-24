pageextension 50128 Posted_Sales_Invoice_Subform extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here

        addafter("Line Amount")
        {

            field("VAT %"; "VAT %") { ApplicationArea = all; }

            field("Amount Including VAT"; "Amount Including VAT") { Visible = true; }
            field("Old Price"; "Old Price") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field("Total Old Price"; "Total Old Price") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field(Difference; Difference) { ApplicationArea = all; Editable = false; Visible = DifferenceV; }

            field("Posting Date"; "Posting Date") { ApplicationArea = all; Visible = not cng; }
            field("Payment Method Code"; "Payment Method Code") { ApplicationArea = all; Visible = not cng; Editable = false; }

            field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; Editable = false; }
            field("Driver type"; "Driver type") { ApplicationArea = all; Editable = false; }
            field("Driver ID"; "Driver ID") { ApplicationArea = all; Editable = false; }
            field("Driver Name"; "Driver Name") { ApplicationArea = all; Editable = false; }
            field("Driver Registration No."; "Driver Registration No.") { ApplicationArea = all; Editable = false; }
            field("Fiscal printed"; "Fiscal printed")
            {
                ApplicationArea = all;
                Editable = false;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;

            }
            field("Fiscal No."; "Fiscal No.") { ApplicationArea = all; }
            field("Fiscal User"; "Fiscal User") { ApplicationArea = all; Editable = false; }
            field("Fiscal DateTime"; "Fiscal DateTime") { ApplicationArea = all; Editable = false; }



            field("R. Fiscal printed"; "R. Fiscal printed")
            {
                ApplicationArea = all;
                Visible = true;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;
            }


            field("R. Fiscal No."; "R. Fiscal No.") { ApplicationArea = all; Visible = true; }
            field("R. Fiscal User"; "R. Fiscal User") { ApplicationArea = all; Editable = false; Visible = true; }
            field("R. Fiscal DateTime"; "R. Fiscal DateTime") { ApplicationArea = all; Editable = false; Visible = true; }

            field("New Fiscal printed"; "New Fiscal printed")
            {
                ApplicationArea = all;
                Visible = DifferenceV;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                    if (xRec."Fiscal printed" = true) and (rec."Fiscal printed" = false) then
                        Error(Permission);
                end;
            }
            field("New Fiscal No."; "New Fiscal No.") { ApplicationArea = all; Visible = DifferenceV; }
            field("New Fiscal User"; "New Fiscal User") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }
            field("New Fiscal DateTime"; "New Fiscal DateTime") { ApplicationArea = all; Editable = false; Visible = DifferenceV; }


        }

        modify("Line Discount %") { Visible = cng; }






        modify("Unit Price") { Editable = false; }

        modify("Tax Area Code") { Visible = false; }
        modify("Tax Group Code") { Visible = false; }

        modify("Shortcut Dimension 1 Code") { Visible = cng; }

    }

    actions
    {
        // Add changes to page actions here


    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        SH: Record "Sales Invoice Header";
        Cut: Record "Customer Templ.";
    begin

        if rec."Fiscal printed" = true then
            EditableD := false
        else
            EditableD := true;


        DifferenceV := false;
        sh.Reset;
        sh.SetFilter("No.", '%1', "Document No.");
        if sh.FindFirst() then begin

            if (sh."Old Price Date" <> 0D) and (sh."New Price" <> 0) then
                DifferenceV := true
            else
                DifferenceV := false;

            if DifferenceV = true then DifferenceR := true;

            if rec."R. Fiscal printed" = true then DifferenceR := true;

            if sh."Bill type" <> '' then begin
                Cut.Reset();
                Cut.SetFilter(Code, '%1', sh."Bill type");
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
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
        SH: Record "Sales Invoice Header";
        Cut: Record "Customer Templ.";

    begin

        DifferenceV := false;
        DifferenceR := false;
        sh.Reset;
        sh.SetFilter("No.", '%1', "Document No.");
        if sh.FindFirst() then begin

            if (sh."Old Price Date" <> 0D) and (sh."New Price" <> 0) then
                DifferenceV := true
            else
                DifferenceV := false;


            if DifferenceV = true then DifferenceR := true;

            if rec."R. Fiscal printed" = true then DifferenceR := true;



            if sh."Bill type" <> '' then begin
                Cut.Reset();
                Cut.SetFilter(Code, '%1', sh."Bill type");
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
    end;





    var
        myInt: Integer;

        CNG: Boolean;
        US: Record "User Setup";
        DifferenceV: Boolean;
        DifferenceR: Boolean;
        Permission: Label 'You cannot change the value!';
        EditableD: Boolean;
}