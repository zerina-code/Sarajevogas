pageextension 50153 PostedWhseShipmentist extends "Posted Whse. Shipment List"
{
    layout
    {
        // Add changes to page layout here
        addafter("Whse. Shipment No.")
        {
            field("RN Source"; "RN Source") { }
            field(Address; Address) { }
            field("Sales Header No."; "Sales Header No.")
            {
                trigger OnDrillDown()
                var
                    myInt: Integer;
                    ServiceHeader: Record "Service Header";
                    PostedServiceHeader: Record "Service Invoice Header";
                    RCard: page "Request Card";
                    PostedRCard: page "Posted Service Invoice";
                begin
                    ServiceHeader.Reset();
                    ServiceHeader.SetFilter("No.", '%1', "Sales Header No.");
                    if ServiceHeader.FindFirst() then begin
                        RCard.SetTableView(ServiceHeader);
                        RCard.Run();

                    end
                    else begin
                        PostedServiceHeader.reset;
                        PostedServiceHeader.SetFilter("Order No.", '%1', "Sales Header No.");
                        if PostedServiceHeader.findfirst then begin
                            PostedRCard.SetTableView(PostedServiceHeader);
                            PostedRCard.Run();
                        end
                        else begin
                            PostedServiceHeader.reset;
                            PostedServiceHeader.SetFilter("No.", '%1', "Sales Header No.");
                            if PostedServiceHeader.findfirst then begin
                                PostedRCard.SetTableView(PostedServiceHeader);
                                PostedRCard.Run();
                            end;

                        end;

                    end;
                end;

                trigger OnLookup(var Text: Text): Boolean
                var
                    myInt: Integer;
                    ServiceHeader: Record "Service Header";
                    PostedServiceHeader: Record "Service Invoice Header";
                    RCard: page "Request Card";
                    PostedRCard: page "Posted Service Invoice";
                begin
                    ServiceHeader.Reset();
                    ServiceHeader.SetFilter("No.", '%1', "Sales Header No.");
                    if ServiceHeader.FindFirst() then begin
                        RCard.SetTableView(ServiceHeader);
                        RCard.Run();

                    end
                    else begin
                        PostedServiceHeader.reset;
                        PostedServiceHeader.SetFilter("Order No.", '%1', "Sales Header No.");
                        if PostedServiceHeader.findfirst then begin
                            PostedRCard.SetTableView(PostedServiceHeader);
                            PostedRCard.Run();
                        end
                        else begin
                            PostedServiceHeader.reset;
                            PostedServiceHeader.SetFilter("No.", '%1', "Sales Header No.");
                            if PostedServiceHeader.findfirst then begin
                                PostedRCard.SetTableView(PostedServiceHeader);
                                PostedRCard.Run();
                            end;

                        end;

                    end;
                end;




            }
            field("G/L Account No."; "G/L Account No.") { }
            field("Transferred"; Transferred) { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetCurrentKey("No.");
        Ascending(false);

    end;

    var
        myInt: Integer;
}