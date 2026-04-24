page 50023 "Reduction List"
{
    Caption = 'Reduction List';
    // CardPageID = "Reduction Card";
    Editable = true;
    PageType = List;
    SourceTable = Reduction;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field(Type; Type)
                {
                }
                field(BankAccountCode; BankAccountCode)
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                field(BankAccountCodeNo; BankAccountCodeNo)
                {
                }
                field("Party No."; "Party No.")
                {
                }
                field("Reduction Amount"; "Reduction Amount")
                {
                }

                field("Payment Start"; "Payment Start")
                {
                }
                field("Payment End"; "Payment End")
                {
                }
                field(ContractNo; ContractNo)
                {
                    Visible = false;
                }
                field("No. of Installments"; "No. of Installments")
                {
                }

                field("Installment Amount"; "Installment Amount")
                {
                }


                field("Paid Amount"; "Paid Amount")
                {
                }
                field(Description; Description)
                {

                }
                field(Status; Status)
                {
                }
                field("Employee Status"; "Employee Status")
                {
                    Visible = false;
                }
                field("Opening balance"; "Opening balance")
                {
                }
                field("Remaining Due"; "Remaining Due")
                {

                }
                field("No. of Installments paid"; "No. of Installments paid")
                { }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

