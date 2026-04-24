
pageextension 50096 WhseShipment extends "Warehouse Shipment"
{
    layout
    {
        addafter("No.")
        {

            field("Employee No."; "Employee No.")
            {
                ApplicationArea = All;
            }
            field("Employee Name"; "Employee Name")
            {
                ApplicationArea = All;
            }
            field("Shipping No. Series"; "Shipping No. Series")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Shipping No."; "Shipping No.")
            {
                ApplicationArea = all;
                Visible = false;
            }

            field("Document No."; "Document No.")
            {
                ApplicationArea = all;
                Visible = false;

            }
            field("Order Date"; "Order Date")
            {
                ApplicationArea = all;

            }
            field("Sales Header No."; "Sales Header No.") { Editable = false; }
            field("RN Source"; "RN Source") { Editable = false; }
            field(Address; Address) { Editable = false; }
            field("G/L Account No."; "G/L Account No.") { Editable = false; }
        }

        modify("Zone Code") { Visible = false; }
        modify("Bin Code") { Visible = false; }
        modify("Assigned User ID") { Visible = false; }
        modify("Assignment Date") { Visible = false; }
        modify("Assignment Time") { Visible = false; }

        addfirst(factboxes)
        {
            part(ResEntr; "Reservation Entries")
            {
                ApplicationArea = Warehouse;
                Caption = 'Serial numbers';
                Provider = WhseShptLines;
                SubPageLink = "Item No." = FIELD("Item No."), "Source ID" = FIELD("Source No."), Positive = filter(true);
                //  Visible = true;
            }
        }
    }
    actions
    {
        /*modify("P&ost Shipment")
        //ako je otpremnica kreirana iz naloga prenosa i skladiste odredište ne zahtijeva zaprimanje trebam odmah proknjižiti i taj nalog
        {
            trigger OnAfterAction()
            var
                TransferHeader: Record "Transfer Header";
                LocationTable: Record Location;
            begin
                TransferHeader.Reset();
                TransferHeader.SetFilter("No.", '%1', "Transfer Header No."); //broj naloga prenosa ako je upisan
                if TransferHeader.FindFirst() then begin
                    LocationTable.Reset();
                    LocationTable.SetFilter(Code, '%1', TransferHeader."Transfer-to Code"); //skladište odredište
                    if LocationTable.FindFirst() then
                        if LocationTable."Require Receive" = false then //ako skladište ne zahtijeva zaprimanje
                            CODEUNIT.Run(CODEUNIT::"TransferOrder-Post (Yes/No)", TransferHeader);
                end;
            end;
        }*/
        //ISTE AKCIJE TREBAM KOPIRATI I ZA POST AND PRINT
    }
}