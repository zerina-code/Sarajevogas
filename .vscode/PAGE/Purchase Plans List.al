page 50138 "Purchase Plans List"
{

    //ED 

    Caption = 'Purchase Plans List';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = false;
    SourceTable = "Purchase Plans List";
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
                    ApplicationArea = All;

                    /*trigger OnDrillDown()
                    begin
                        PurchasePlanTable.Reset();
                        PurchasePlanTable.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code");
                        PurchasePlanPage.SetTableView(PurchasePlanTable);
                        PurchasePlanPage.Run();
                    end;*/
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Year; Year)
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
            action("Pregled stavki Plana nabavke")
            {
                Caption = 'Pregled stavki';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Today: Date;
                begin
                    PurchasePlanTable.Reset();
                    PurchasePlanTable.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code");
                    PurchasePlanPage.SetTableView(PurchasePlanTable);
                    PurchasePlanPage.Run();
                end;
            }
            action("Pregled ugovora")
            {
                Caption = 'Pregled ugovora';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Today: Date;
                begin
                    PurchaseContractTable.Reset();
                    PurchaseContractTable.SetFilter("Purchase Plan Code", '%1', Rec."Purchase Plan Code");
                    PurchaseContractPage.SetTableView(PurchaseContractTable);
                    PurchaseContractPage.Run();
                end;
            }
        }
    }

    var
        PurchasePlanTable: Record "Purchase Plan";
        PurchasePlanPage: Page "Purchase Plan";
        PurchaseContractTable: Record "Purchase Contract";
        PurchaseContractPage: Page "Purchase Contract";
}

