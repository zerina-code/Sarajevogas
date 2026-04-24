pageextension 50143 "Revaluation Journal" extends "Revaluation Journal"
{
    layout
    {


        // Add changes to page layout here
        addafter("Shortcut Dimension 1 Code")
        {

            field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group") { }

        }


        modify("Gen. Bus. Posting Group") { Visible = true; }

        modify("Unit Cost (Revalued)") { Visible = visi; }
        modify("Unit Cost (Calculated)") { Visible = visi; }
        modify("Inventory Value (Calculated)") { Visible = visi; }
        modify("Inventory Value (Revalued)") { Visible = visi; }
        addafter(Amount)
        {
            field("Unit Price Old"; "Unit Price Old") { Visible = not visi; }
            field("Unit Price New"; "Unit Price New") { Visible = not visi; }
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("Prepare Employee No."; "Prepare Employee No.") { }
            field("Prepare Employee Name"; "Prepare Employee Name") { }
            field("Control Employee No."; "Control Employee No.") { }
            field("Control Employee Name"; "Control Employee Name") { }
            field("Verif Employee No."; "Verif Employee No.") { }
            field("Verif Employee Name"; "Verif Employee Name") { }
        }


    }
    actions
    {
        addafter("Calculate Inventory Value - Test")
        {

            action("Leveling Report")
            {
                ApplicationArea = all;
                Caption = 'Leveling Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Category4;
                ShortCutKey = 'Shift+Ctrl+I';
                trigger OnAction()
                var
                    ValueEn: Record "Item Journal Line";
                begin

                    //

                    ValueEn.Reset();
                    ValueEn.SetFilter("Document No.", '%1', rec."Document No.");

                    Report.RUN(50191, TRUE, TRUE, ValueEn);


                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin




        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Nivelacija = true then
                visi := false
            else
                visi := true;



        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup.Nivelacija = true then
                visi := false
            else
                visi := true;
        end;
    end;




    var
        myInt: Integer;
        visi: Boolean;
        IJB: Record "Item Journal Batch";
        UserSetup: record "User Setup";


}