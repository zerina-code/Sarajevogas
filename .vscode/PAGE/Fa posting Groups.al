pageextension 50035 FaPostingGroups extends "FA Posting Groups"
{
    layout
    {
        // Add changes to page layout here

        addafter("Code")
        {
            field("Description"; "Description")
            {
                ApplicationArea = all;
            }
        }

        addafter("Acquisition Cost Account")
        {
            field("Investment Account"; "Investment Account")
            {
                ApplicationArea = all;
            }
        }
        modify("Appreciation Account")
        {
            Visible = true;
        }
        modify("Write-Down Account")
        {
            Visible = true;
        }
        modify("Write-Down Acc. on Disposal")
        {
            Visible = true;
        }
        modify("Appreciation Acc. on Disposal")
        {
            Visible = true;
        }
        modify("Write-Down Bal. Acc. on Disp.")
        {
            Visible = true;
        }
        modify("Apprec. Bal. Acc. on Disp.")
        {
            Visible = true;
        }


        addafter("Depreciation Expense Acc.")
        {
            field("Depreciation Expense Acc. D."; "Depreciation Expense Acc. D.") { }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnOpenPage()
    begin
        SETFILTER(Description, '<>%1', '');
    end;


    var
        myInt: Integer;
}