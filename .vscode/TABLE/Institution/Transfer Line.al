tableextension 50111 "Transfer Line" extends "Transfer Line"
{
    fields
    {

        field(501156; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Caption = 'G/L Account No.';
        }

        field(50022; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        modify("Item No.")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
                GPS: Record "General Posting Setup";
                TH: Record "Transfer Header";
                ItemNoRec: record "Item";

            begin
                if rec."Gen. Prod. Posting Group" <> '' then begin

                    ItemNoRec.Reset();
                    ItemNoRec.SetFilter("No.", '%1', Rec."Item No.");
                    if ItemNoRec.findfirst then begin
                        rec."G/L Account No." := ItemNoRec."Inventory Posting Group";

                    end;

                    GPS.Reset();
                    GPS.SetFilter("Gen. Prod. Posting Group", '%1', rec."Gen. Prod. Posting Group");
                    GPS.SetFilter("Update General Posting Group", '%1', true);
                    if gps.FindFirst() then begin
                        TH.Reset();
                        th.SetFilter("No.", '%1', rec."Document No.");
                        if th.FindFirst() then begin
                            th.Validate("Gen. Bus. Posting Group", rec."Gen. Prod. Posting Group");
                            th.Modify();
                        end;
                    end;
                    TH.Reset();
                    th.SetFilter("No.", '%1', rec."Document No.");
                    if th.FindFirst() then begin


                        ItemNoRec.Reset();
                        ItemNoRec.SetFilter("No.", '%1', Rec."Item No.");
                        if ItemNoRec.findfirst then begin
                            th."G/L Account No." := ItemNoRec."Inventory Posting Group";
                            th.modify;

                        end;
                    end;
                end;

            end;
        }
    }

    var
        myInt: Integer;
}