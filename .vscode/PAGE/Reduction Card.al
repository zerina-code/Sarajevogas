/*page 50022 "Reduction Card"
{
    Caption = 'Reduction Card';
    PageType = Card;
    SourceTable = Reduction;

    layout
    {
        area(content)
        {
            group(General)
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
                field(Status; Status)
                {
                }
                field(Type; Type)
                {
                }
                field(BankAccountCode; BankAccountCode)
                {
                }
                field("Bank Name"; "Bank Name")
                {
                    Editable = false;
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
                field("Reduction has instalments"; "Reduction has instalments")
                {
                }
                field("No. of Installments"; "No. of Installments")
                {
                    Editable = "Reduction has instalments";
                }
                field("Installment Amount"; "Installment Amount")
                {
                    Caption = 'Installment Amount';
                }
                field("Opening balance"; "Opening balance")
                {
                }
                field("Paid Amount"; "Paid Amount")
                {
                    Editable = false;
                }
                field("No. of Installments paid"; "No. of Installments paid")
                {
                    Visible = false;
                }
                field("Payment Start"; "Payment Start")
                {
                    Caption = 'Payment Start';
                }
                field("Payment End"; "Payment End")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SETRANGE("No.");
        IF NOT Emp.GET("Employee No.") THEN Emp.INIT;
    end;

    trigger OnOpenPage()
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        Emp: Record "Employee";
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

*/