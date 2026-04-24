page 50149 "Purchase Plan"
{

    //ED 

    Caption = 'Purchase Plan';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Purchase Plan";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                Editable = true;
                Enabled = true;
                field("Purchase Plan Code"; "Purchase Plan Code")
                {
                    ApplicationArea = all;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Direktni sporazum";"Direktni sporazum")
                {
                    ApplicationArea = All;
                }
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Komercijala - rebalans"; "Komercijala - rebalans")
                {
                    ApplicationArea = All;
                }
                field("Investiciono - rebalans"; "Investiciono - rebalans")
                {
                    ApplicationArea = All;
                }
                field("Tekuće potrebe - rebalans"; "Tekuće potrebe - rebalans")
                {
                    ApplicationArea = All;
                }
                field("Total - rebalans"; "Total - rebalans")
                {
                    ApplicationArea = All;
                }
                field("Komercijala - realizacija"; "Komercijala - realizacija")
                {
                    ApplicationArea = All;
                }
                field("Investiciono - realizacija"; "Investiciono - realizacija")
                {
                    ApplicationArea = All;
                }
                field("Tekuće potrebe - realizacija"; "Tekuće potrebe - realizacija")
                {
                    ApplicationArea = All;
                }
                field("Total - realizacija"; "Total - realizacija")
                {
                    ApplicationArea = All;
                }
                field(Remained; Remained)
                {
                    ApplicationArea = All;
                }
                field(Index; Index)
                {
                    ApplicationArea = All;
                }
                field("Contracts Count"; "Contracts Count")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            action("Purchase Plan Report")
            {
                Caption = 'Purchase Plan Report';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Today: Date;
                begin
                    PurchasePlanTable.Reset();
                    PurchasePlanTable.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code"); //da filtrira tabelu za tačan plan na koji sam ušla iz popisa planova
                    PurchasePlanReport.SetTableView(PurchasePlanTable);
                    PurchasePlanReport.Run();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Remained := Rec."Total - rebalans" - Rec."Total - realizacija";
        if Rec."Total - rebalans" <> 0 then
            Rec.Index := (Rec."Total - realizacija" / Rec."Total - rebalans") * 100
        else
            Rec.Index := 0;
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Remained := Rec."Total - rebalans" - Rec."Total - realizacija";
        if Rec."Total - rebalans" <> 0 then
            Rec.Index := (Rec."Total - realizacija" / Rec."Total - rebalans") * 100
        else
            Rec.Index := 0;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Purchase Plan Code" := GetFilter("Purchase Plan Code");
    end;

    var
        PurchasePlanTable: Record "Purchase Plan";
        PurchasePlanReport: Report "Purchase Plan Report";
}

