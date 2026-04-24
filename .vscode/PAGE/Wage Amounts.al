page 50141 "Wage Amounts"
{
    Caption = 'Wage Amount';
    PageType = List;
    SourceTable = "Wage Amounts";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    Caption = 'Employee No.';
                    ApplicationArea = all;
                }
                field("Net Amount"; "Net Amount")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Net Basis Includes Tax"; "Net Basis Includes Tax")
                {
                    Visible = false;
                    ApplicationArea = all;

                }
                field("Net Amount Including Tax"; "Net Amount Including Tax")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Wage Amount"; "Wage Amount")
                {
                    ApplicationArea = all;
                }
                field("Net Amount 2"; "Net Amount 2")
                {

                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Old Amount"; "Old Amount")
                {
                    ApplicationArea = all;
                }
                field("Application Date"; "Application Date")
                {
                    ApplicationArea = all;
                }
            }
        }


    }

    trigger OnOpenPage()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());
    end;


}

