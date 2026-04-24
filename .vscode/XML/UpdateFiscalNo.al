report 50222 "Update Fiscal"
{
    Caption = 'Update Fiscal';

    DefaultLayout = RDLC;
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true; // mora biti true ako želiš koristiti requestpage

    dataset
    {
        dataitem("Service Invoice Header"; "Service Invoice Header")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                SIH: Record "Service Invoice Header";
            begin
                if FiscalNo = '' then
                    Error('Broj fiskalnog računa mora biti popunjen');
                if SIH.get("Service Invoice Header"."No.") then begin
                    SIH."Fiscal No." := FiscalNo;
                    SIH."Fiscal No. Printed" := true;
                    SIH."Fiscal DateTime" := CurrentDateTime;
                    SIH."Fiscal User" := USERID;
                    RecRef.GetTable(SIH);
                    RecordRefExample.ModifyRecords(RecRef);
                end;
            end;

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(FiscalNo; FiscalNo)
                {
                    Caption = 'FiscalNo';
                }


            }
        }
    }



    trigger OnPostReport()
    begin
        // Tvoja logika ide ovdje





    end;

    var
        Selected: Option " ","Proknjižene Izlazne fakture CNG","Proknjižene izlazne fakture","Proknjižena izlazna odobrenja","Proknjižene servisne fakture","Proknjižena servisna odobrenja";
        DocumentNo: Code[20];
        SalesInvHdr: Record "Sales Invoice Header";
        SalesCrMemoHdr: Record "Sales Cr.Memo Header";
        SalesInvLine: Record "Sales Invoice Line";
        ServInvHdr: Record "Service Invoice Header";
        ServCrMemoHdr: Record "Service Cr.Memo Header";
        Line_No: Integer;
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";
        FiscalNo: code[20];
        SalesShipmentLine: Record "Sales Shipment Line";
}