report 50069 "Print of journal entries"
{
    // AS1.00 Added function SetDetail(Bool) for setting detailed view, called from codeunit
    // 50005
    DefaultLayout = RDLC;
    RDLCLayout = './Print of journal entries.rdl';

    PreviewMode = PrintLayout;
    ShowPrintStatus = true;
    UseRequestPage = true;
    UseSystemPrinter = true;

    dataset
    {
        dataitem(DataItem17; "Company Information")
        {
            column(CompanyName; Name)
            {
            }
            column(CompanyAdress; Address)
            {
            }
            column(CompanyCity; "City")
            {
            }
            column(CompanyLogo; Picture)
            {
            }
            column(CompanyPostCode; "Post Code")
            {
            }
            column(Detail; DetailVar)
            {
            }
            dataitem(DataItem13; "G/L Entry")
            {
                RequestFilterFields = "G/L Account No.", "Posting Date", "Document No.";
                column(PostingDate; "Posting Date")
                {
                }
                column(DocumentNumber; "Document No.")
                {
                }
                column(DocumentDate; "Document Date")
                {
                }
                column(ExternalDocNumber; "External Document No.")
                {
                }
                column(GLAccountNumber; "G/L Account No.")
                {
                }
                column(Description; Description)
                {
                }
                column(DebitAmount; "Debit Amount")
                {
                }
                column(CreditAmount; "Credit Amount")
                {
                }
                column(BusinessUnit; "Business Unit Code")
                {
                }
                column(AccountName; AccName)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(ShowDetails; ShowDetails)
                {
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

    trigger OnPreReport()
    begin
        ShowDetails := TRUE;
    end;

    var
        GLEntry: Record "TempGLE";
        TotalGLEntry: Record "G/L Account Net Change";
        TotalCredit: Decimal;
        TotalDebit: Decimal;
        ShowDetails: Boolean;
        HeaderText: Text[1024];
        Item: Record "Item";
        desc: Text[30];
        AccName: Text[50];
        DetailVar: Boolean;
}

