pageextension 50003 "Service Item Line FactBox" extends "Service Item Line FactBox"
{
    Caption = 'Measuring Point Details';
    layout
    {
        modify("Service Item No.")
        {
            Caption = 'Measuring Point';
        }
        modify(ComponentList)
        {
            Visible = false;
        }
        modify(SkilledResources)
        {
            Visible = false;
        }
        modify(Troubleshooting)
        {
            Visible = false;
        }
        addafter("Service Item No.")
        {
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
            }
            field("Consent ID"; Rec."Consent ID")
            {
                ApplicationArea = All;
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    Header: Record "Service Header";
                    ServiceItemLine: Record "Service Item Line";
                    BrojEE: Code[20];
                    RequestCaard: page "Request Card";
                begin

                    ServiceItemLine.Reset();
                    ServiceItemLine.SetFilter("Request type", '%1', ServiceItemLine."Request type"::"Project and Energy Accordance");
                    ServiceItemLine.SetFilter("Service Item No. - Relation", rec."Service Item No. - Relation");
                    ServiceItemLine.SetCurrentKey(SystemCreatedAt);
                    ServiceItemLine.Ascending;
                    if ServiceItemLine.FindLast() then begin
                        Header.Reset();
                        Header.SetFilter("No.", '%1', ServiceItemLine."Document No.");
                        RequestCaard.SetTableView(Header);
                        RequestCaard.Run();



                    end
                    else begin

                        Header.Reset();
                        Header.SetFilter("Customer No.", rec."Customer No.");
                        Header.SetFilter("Request Type", '%1', "Request type"::"Project and Energy Accordance");
                        RequestCaard.SetTableView(Header);
                        RequestCaard.Run();

                    end;
                end;




                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    Header: Record "Service Header";
                    ServiceItemLine: Record "Service Item Line";
                    BrojEE: Code[20];
                    RequestCaard: page "Request Card";
                begin

                    ServiceItemLine.Reset();
                    ServiceItemLine.SetFilter("Request type", '%1', ServiceItemLine."Request type"::"Project and Energy Accordance");
                    ServiceItemLine.SetFilter("Service Item No. - Relation", rec."Service Item No. - Relation");
                    ServiceItemLine.SetCurrentKey(SystemCreatedAt);
                    ServiceItemLine.Ascending;
                    if ServiceItemLine.FindLast() then begin
                        Header.Reset();
                        Header.SetFilter("No.", ServiceItemLine."Document No.");
                        RequestCaard.SetTableView(Header);
                        RequestCaard.Run();



                    end
                    else begin

                        Header.Reset();
                        Header.SetFilter("Customer No.", rec."Customer No.");
                        Header.SetFilter("Request Type", '%1', "Request type"::"Project and Energy Accordance");
                        RequestCaard.SetTableView(Header);
                        RequestCaard.Run();

                    end;
                end;
            }
            field("Gas Appliance"; "Gas Appliance")
            {
                DrillDownPageId = "Gas Appliances List";
                LookupPageId = "Gas Appliances List";
            }
            field("Gas Installation Data"; "Gas Installation Data") { }

            //


            field(Gauge; Rec.Gauge)
            {
                ApplicationArea = All;
            }
            field(Corrector; Rec.Corrector)
            {
                ApplicationArea = All;
            }
            field("Status MM"; Rec."Status MM")
            {
                ApplicationArea = All;
            }
            field(StartingMeasuring; ServiceItem."Starting Measuring")
            {
                Caption = 'Starting Measuring';
                ApplicationArea = All;
            }
        }
    }
    var
        ServiceItem: Record "Service Item";

    trigger OnAfterGetRecord()
    begin
        CollectServiceItemData();
    end;

    local procedure CollectServiceItemData()
    begin
        if rec."Service Item No." = '' then begin
            ServiceItem.Init();
            ServiceItem."No." := '';
        end;
        ServiceItem.SetLoadFields("Starting Measuring");
        if not ServiceItem.Get(Rec."Service Item No.") then begin
            ServiceItem.Init();
            ServiceItem."No." := '';
        end;
    end;
}
