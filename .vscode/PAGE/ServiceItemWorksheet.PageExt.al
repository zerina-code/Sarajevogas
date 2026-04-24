pageextension 50006 ServiceItemWorksheet extends "Service Item Worksheet"
{
    Caption = 'Worksheet', Comment = 'Radni list';
    layout
    {


        modify(General)
        {
            Visible = false;
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify(Details)
        {
            Visible = false;
        }

        addfirst(content)
        {
            group(RequestGeneral)
            {
                Caption = 'General';
                field("Request Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'Measuring Point', Comment = 'Mjerno mjesto';
                    Editable = false;
                }
                field("Request Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("MM Category"; Rec."MM Category")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Consent ID"; Rec."Consent ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                Field(SumValue; SumValue)
                {
                    Caption = 'Sum Value';
                }

            }
        }
    }
    actions
    {
        modify("&Worksheet")
        {
            Visible = false;
        }
        modify("Service &Item")
        {
            Caption = 'Measure Point', Comment = 'Mjerno mjesto';
        }
        modify("Demand Overview")
        {
            Visible = false;
        }
        modify("&Troubleshooting")
        {
            Visible = false;
        }
        modify("&Fault/Resol. Codes Relationships")
        {
            Visible = false;
        }
        modify("F&unctions")
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin


        SumValue := 0;
        SL.Reset();
        SL.SetFilter("Document No.", '%1', rec."Document No.");
        sl.SetFilter("Document Type", '%1', rec."Document Type");
        if sl.FindSet() then
            repeat
                SumValue += sl."Amount Including VAT";
            until sl.Next() = 0;

    end;

    trigger OnOpenPage()
    var
        myInt: Integer;

    begin

        SumValue := 0;
        SL.Reset();
        SL.SetFilter("Document No.", '%1', rec."Document No.");
        sl.SetFilter("Document Type", '%1', rec."Document Type");
        if sl.FindSet() then
            repeat
                SumValue += sl."Amount Including VAT";
            until sl.Next() = 0;

    end;

    var
        SumValue: Decimal;
        SL: Record "Service Line";
}
