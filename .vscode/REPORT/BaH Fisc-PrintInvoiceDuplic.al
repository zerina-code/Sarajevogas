/*report 50001 "BaH Fisc-PrintInvoiceDuplic"
{
    // BH1.00, Fiscal Process

    Caption = 'Document copy';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {

                // InstructionalText = 'Printer dependable options';
                field(FromDateTime; FromDateTime)
                {
                    Caption = 'From datetime:';
                }
                field(ToDateTime; ToDateTime)
                {
                    Caption = 'To datetime:';
                }
                field(InvoiceNo; InvoiceNo)
                {
                    Caption = 'Invoice No.:';
                }

            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin

        FromDateTime := CREATEDATETIME(TODAY, TIME);
        ToDateTime := CREATEDATETIME(TODAY, TIME);
    end;

    trigger OnPreReport()
    begin
        //     FiscalPrinterMgmt.PrintInvoiceDuplicate(FromDateTime, ToDateTime, InvoiceNo);
    end;

    var
        // FiscalPrinterMgmt: Codeunit "BaH FiscalPrintersMgmt";
        FromDateTime: DateTime;
        ToDateTime: DateTime;
        InvoiceNo: Integer;
}

*/