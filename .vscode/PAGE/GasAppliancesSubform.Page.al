page 50108 "Gas Appliances Subform"
{
    Caption = 'Gas Appliances';
    PageType = ListPart;
    SourceTable = "Gas Appliance";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Power From"; Rec."Power From")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Power To"; Rec."Power To")
                {
                    ApplicationArea = All;
                }
                field("Gas Appliance Type"; Rec."Gas Appliance Type")
                {
                    ApplicationArea = All;
                }
                field("Excerpt armored with a stopper"; "Excerpt armored with a stopper") { }
                field("Number of pieces"; "Number of pieces") { }
                field("Excerpt armored without"; "Excerpt armored without") { }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Measure Point No."; "Measure Point No.") { }
                field(Total; Total)
                {
                    Caption = 'Total';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NumberOfLines; NumberOfLines)
                {
                    Caption = 'Number Of Lines';
                    ApplicationArea = All;
                    Editable = false;
                }
            }

            group(Control51)
            {
                ShowCaption = false;
                field(TotalGA; Total)
                {
                    Caption = 'Total Gas Applience';
                    Editable = false;
                    ToolTip = 'Specifies the sum of the value in the Power To field on all lines in the document.';

                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateTotalQtyAndNumberOfLines();
    end;



    trigger OnDeleteRecord(): Boolean
    begin
        UpdateTotalQtyAndNumberOfLines();
    end;



    //insert permissions EK
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then
            CanModify := UserSetup.MM_UGI_GASNI_APARATI;
        if not CanModify then begin
            Error('Nemate dozvolu da modifikujete ovu listu.');
        end;

        UpdateTotalQtyAndNumberOfLines();
    end;




    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
        TotalPower: Decimal;
        DisplayRec: Record "Gas Appliance" temporary;
        RequestCardID: Code[20];
        Total: Decimal;
        NumberOfLines: Integer;


    procedure UpdateTotalQtyAndNumberOfLines()
    var
        GasApplienceLine: Record "Gas Appliance";
    begin
        Total := 0;
        NumberOfLines := 0;
        GasApplienceLine.Reset();
        GasApplienceLine.CopyFilters(Rec);
        // GasApplienceLine.CalcSums("Power To");
        if GasApplienceLine.FindSet() then
            repeat
                Total += GasApplienceLine.Quantity * GasApplienceLine."Power To";
            until GasApplienceLine.next = 0;
        NumberOfLines := GasApplienceLine.Count;
    end;
}
