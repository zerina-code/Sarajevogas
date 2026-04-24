report 50107 "Whse. - Posted Receipt Copy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './WhsePostedReceiptCopy.rdl';
    ApplicationArea = Warehouse;
    Caption = 'Warehouse Posted Receipt Copy';
    UsageCategory = Documents;

    dataset
    {
        dataitem("Posted Whse. Receipt Header"; "Posted Whse. Receipt Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(User; UserName)
            {

            }
            column("DestinationTest"; location.Name)
            {

            }
            column(PosName; PosName) { }

            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(CompanyName; COMPANYPROPERTY.DisplayName)
                {
                }


                column(TodayFormatted; Format(Today))
                {
                }
                column(Assgnd_PostedWhseRcpHeader; "Posted Whse. Receipt Header"."Assigned User ID")
                {
                    IncludeCaption = true;
                }
                column(LocCode_PostedWhseRcpHeader; "Posted Whse. Receipt Header"."Location Code")
                {
                    IncludeCaption = true;
                }
                column(No_PostedWhseRcpHeader; "Posted Whse. Receipt Header"."No.")
                {
                    IncludeCaption = true;
                }
                column(VendorShipmentNo; "Posted Whse. Receipt Header"."Vendor Shipment No.") //R
                {
                    IncludeCaption = true;
                }
                column(WhseReceiptNo; "Posted Whse. Receipt Header"."Whse. Receipt No.") { }
                column(BinMandatoryShow1; not Location."Bin Mandatory")
                {
                }
                column(BinMandatoryShow2; Location."Bin Mandatory")
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                column(WarehousePostedReceiptCaption; WarehousePostedReceiptCaptionLbl)
                {
                }

                column(Vendor_Date; "Posted Whse. Receipt Header"."Vendor Date")
                {

                }
                column(Order_Date; "Posted Whse. Receipt Header"."Posting Date")
                {

                }
                column(VendorNo; "Posted Whse. Receipt Header"."Vendor No.")
                {

                }
                column(Vendor_Name; "Posted Whse. Receipt Header"."Vendor Name")
                {

                }
                column("Responsible"; Location."Responsible Person Name")
                {

                }
                column("ResponsiblePos"; Location."Responsible Person Position")
                {

                }



                dataitem("Posted Whse. Receipt Line"; "Posted Whse. Receipt Line")
                {
                    DataItemLink = "No." = FIELD("No.");
                    DataItemLinkReference = "Posted Whse. Receipt Header";
                    DataItemTableView = SORTING("No.", "Line No.");
                    column(ShelfNo_PostedWhseRcpLine; "Shelf No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Broj; Broj) { }

                    column(ItemNo_PostedWhseRcpLine; "Item No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Desc_PostedWhseRcptLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(UOM_PostedWhseRcpLine; "Unit of Measure Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocCode_PostedWhseRcpLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(Qty_PostedWhseRcpLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(SourceNo_PostedWhseRcpLine; "Source No.")
                    {
                        IncludeCaption = true;
                    }
                    column(SourceDoc_PostedWhseRcpLine; "Source Document")
                    {
                        IncludeCaption = true;
                    }
                    column(ZoneCode_PostedWhseRcpLine; "Zone Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_PostedWhseRcpLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(SerialNumbersText; SerialNumbersText) { }
                    trigger OnAfterGetRecord()
                    var
                        ItemLedgerEntry: Record "Item Ledger Entry";
                    begin
                        SerialNumbersText := '';
                        ItemLedgerEntry.SetFilter("Item No.", '%1', "Posted Whse. Receipt Line"."Item No.");
                        ItemLedgerEntry.SetFilter("Document No.", '%1', "Posted Whse. Receipt Line"."Posted Source No.");
                        if ItemLedgerEntry.FindSet() then
                            repeat
                                if SerialNumbersText <> '' then
                                    SerialNumbersText += ', ';
                                SerialNumbersText += ItemLedgerEntry."Serial No.";
                            until ItemLedgerEntry.Next() = 0;

                        GetLocation("Location Code");
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                UserSet: Record "User Setup";

                EMp: Record Employee;
                ECL: Record "Employee Contract Ledger";
                //  OtherF.SetFilter(SystemCreatedBy, '%1', UserId);
                USF: Record User;

            begin
                PosName := '';
                UserName := '';


                UserSet.reset();
                USF.Reset();
                USF.SetFilter("User Security ID", '%1', SystemCreatedBy);
                if USF.FindFirst() then
                    UserSet.SetFilter("User ID", '%1', USF."User Name");
                if UserSet.FindFirst() then begin
                    UserName := User."Full Name";
                end;
                EMp.Reset();
                EMp.SetFilter("No.", '%1', UserSet."Employee No. for Wage");
                if emp.FindFirst() then begin
                    UserName := EMp."First Name" + ' ' + emp."Last Name";
                end;
                ECL.Reset();
                ECL.SetFilter("Starting Date", '<=%1', "Posting Date");
                ecl.SetFilter("Employee No.", '%1', emp."No.");
                ecl.SetCurrentKey("Starting Date");
                ecl.Ascending;
                if ecl.FindLast() then begin
                    PosName := ecl."Position Description";
                end;

                Location.reset();
                Location.SetFilter("Responsible Person", '%1', "Posted Whse. Receipt Header"."Responsible Name");
                Location.SetFilter("Responsible Person Position", '%1', "Posted Whse. Receipt Header"."Responsible Position");
                if Location.FindFirst() then begin
                    if "Location Code" = "Posted Whse. Receipt Line"."Location Code" then begin
                        "Responsible Name" := location."Responsible Person";
                        "Responsible Position" := Location."Responsible Person Position";

                    end;
                end;
                Broj += 1;


                GetLocation("Location Code");
            end;

        }

    }





    requestpage
    {
        Caption = 'Warehouse Posted Receipt';

        layout
        {
        }

        actions
        {
        }
    }




    labels
    {
    }

    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        Broj := 0;

    end;

    var
        UserName: Text[150];
        PosName: text[250];
        User: Record User;
        Location: Record Location;
        CurrReportPageNoCaptionLbl: Label 'Page';
        WarehousePostedReceiptCaptionLbl: Label 'Warehouse - Posted Receipt';
        WRH: Record "Warehouse Receipt Header";
        VendorShipmentNo: Code[35];
        Broj: Integer;
        SerialNumbersText: Text;

    local procedure GetLocation(LocationCode: Code[10])
    begin
        if LocationCode = '' then
            Location.Init
        else
            if Location.Code <> LocationCode then
                Location.Get(LocationCode);
    end;

}