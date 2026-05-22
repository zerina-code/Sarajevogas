/*codeunit 50094 
{
    // Version BCGOLIVE -- DELETE TABLES FOR GO-LIVE (TRANSACTIONAL,ASSIGN YOUR TABLES)
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd,
    TableData "G/L Entry" = rimd;

    TableNo = "Item Ledger Entry";

    //... ADD COUNTRY LOCALIZATION TABLES, FA, SERVICE etc. etc.
    trigger OnRun()
    var


    //InsertGLEntry(GenJnlLine, GLEntry, true);
    begin


        Rec.Modify();


    end;




    var
        Text0001: Label 'Delete Records?';
        Text0002: Label 'Deleting Records!\Table: #1#######';






}*/
codeunit 50009 "Modiy Permissions"
{
    // Version BCGOLIVE -- DELETE TABLES FOR GO-LIVE (TRANSACTIONAL,ASSIGN YOUR TABLES)
    Permissions = TableData "Item Ledger Entry" = rimd, TableData "Value Entry" = rimd,
    TableData "G/L Entry" = rimd, TableData "Cust. Ledger Entry" = rimd,
    TableData "Vendor Ledger Entry" = rimd, TableData "Item Vendor" = rimd,
    tabledata "Issued Reminder Header" = rimd,
    TableData "G/L Register" = rimd, TableData "Item Register" = rimd,
    TableData "Sales Shipment Header" = rimd, TableData "Sales Shipment Line" = rimd,
    TableData "Sales Invoice Header" = rimd, TableData "Sales Invoice Line" = rimd,
    TableData "Sales Cr.Memo Header" = rimd, TableData "Sales Cr.Memo Line" = rimd,
    TableData "Purch. Rcpt. Header" = rimd, TableData "Purch. Rcpt. Line" = rimd,
    TableData "Purch. Inv. Header" = rimd, TableData "Purch. Inv. Line" = rimd,
    TableData "Purch. Cr. Memo Hdr." = rimd, TableData "Purch. Cr. Memo Line" = rimd,
    TableData "Reservation Entry" = rimd, TableData "Entry Summary" = rimd,
    TableData "Detailed Cust. Ledg. Entry" = rimd, TableData "Detailed Vendor Ledg. Entry" = rimd,
    TableData "Deferral Header" = rimd, TableData "Deferral Line" = rimd,
    TableData "Item Application Entry" = rimd,
    TableData "Production Order" = rimd, TableData "Prod. Order Line" = rimd,
    TableData "Prod. Order Component" = rimd, TableData "Prod. Order Routing Line" = rimd,
    TableData "Posted Deferral Header" = rimd, TableData "Posted Deferral Line" = rimd,
    TableData "Item Variant" = rimd, TableData "Unit of Measure Translation" = rimd,
    TableData "Item Unit of Measure" = rimd,
    TableData "Transfer Header" = rimd, TableData "Transfer Line" = rimd,
    TableData "Transfer Route" = rimd, TableData "Transfer Shipment Header" = rimd,
    TableData "Transfer Shipment Line" = rimd, TableData "Transfer Receipt Header" = rimd,
    TableData "Transfer Receipt Line" = rimd,
    TableData "Capacity Ledger Entry" = rimd, TableData "Lot No. Information" = rimd,
    TableData "Serial No. Information" = rimd, TableData "Item Entry Relation" = rimd,
    TableData "Return Shipment Header" = rimd, TableData "Return Shipment Line" = rimd,
    TableData "Return Receipt Header" = rimd, TableData "Return Receipt Line" = rimd,
    TableData "G/L Budget Entry" = rimd, TableData "Res. Capacity Entry" = rimd,
    TableData "Job Ledger Entry" = rimd, TableData "Res. Ledger Entry" = rimd,
    TableData "VAT Entry" = rimd, TableData "Document Entry" = rimd,
    TableData "Bank Account Ledger Entry" = rimd, TableData "Phys. Inventory Ledger Entry" = rimd,
    TableData "Approval Entry" = rimd, TableData "Posted Approval Entry" = rimd,
    TableData "Cost Entry" = rimd, TableData "Employee Ledger Entry" = rimd,
    TableData "Detailed Employee Ledger Entry" = rimd, TableData "FA Ledger Entry" = rimd,
    TableData "Maintenance Ledger Entry" = rimd, TableData "Service Ledger Entry" = rimd,
    TableData "Warranty Ledger Entry" = rimd, TableData "Item Budget Entry" = rimd,
    TableData "Production Forecast Entry" = rimd, TableData "Location" = rimd, TableData "Bin" = rimd,
    TableData "Customer" = rimd, TableData "Vendor" = rimd, TableData "Item" = rimd,
    tabledata "Customer Posting Group" = rimd,
    TableData "Warehouse Entry" = rimd,
    tabledata "Bank Account Posting Group" = rimd,
    tabledata "G/L Account" = rimd,
    tabledata "Country/Region" = rimd,
    TableData "Bank Account" = rimd,
 tabledata "Travel Order Header SG" = rimd,
    tabledata "Service Cr.Memo Header" = rimd,
    TableData "Service Invoice Header" = rimd;




    //... ADD COUNTRY LOCALIZATION TABLES, FA, SERVICE etc. etc.
    trigger OnRun()
    var

    begin





        /*IF STRPOS(FORMAT(RecRef.Open(50061)),'Sales Invoice Header') <>0 then begin


                RecRef.Open(Database::"Sales Invoice Header");
                RecRef.Modify();
            end;*/

    end;

    procedure ModifyRecords(RecRef: RecordRef)


    var

    begin

        Field.Get(RecRef.Number, RecRef.KeyIndex(1).FieldIndex(1).Number);


        if Field.FindFirst() then begin
            //Opens the table provided by Field table
            //  RecRef.Open(Field.TableNo);
            RecRef.Modify();
            //Filters the field with the value of the primary key of RecordRef

        end;


    end;

    procedure DeleteRecords(RecRef: RecordRef)


    var

    begin

        Field.Get(RecRef.Number, RecRef.KeyIndex(1).FieldIndex(1).Number);


        if Field.FindFirst() then begin
            //Opens the table provided by Field table
            //  RecRef.Open(Field.TableNo);
            RecRef.Delete();
            //Filters the field with the value of the primary key of RecordRef

        end;


    end;

    procedure InsertRecords(RecRef: RecordRef)


    var

    begin

        //    Field.Get(RecRef.Number, RecRef.KeyIndex(1).FieldIndex(1).Number);


        //  if Field.FindFirst() then begin
        //Opens the table provided by Field table
        //  RecRef.Open(Field.TableNo);
        RecRef.insert();
        //Filters the field with the value of the primary key of RecordRef

    end;




    var
        Window: Dialog;
        RecRef: RecordRef;
        Field: Record Field;


}