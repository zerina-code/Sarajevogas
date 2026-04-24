page 50224 "Tax Per Employee Page"
{
    Caption = 'Tax Per Employee';
    Editable = false;
    PageType = List;
    SourceTable = "Tax Per Employee";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Wage Header No."; "Wage Header No.")
                {

                }
                field("Entry No."; "Entry No.")
                {

                }
                field("Wage Calculation No."; "Wage Calculation No.")
                {

                }
                field("Tax Code"; "Tax Code")
                {

                }

                field("Employee No."; "Employee No.")
                {

                }
                field("Contribution Category Code"; "Contribution Category Code")
                {

                }
                field("Amount"; "Amount")
                {

                }
                field("Added Tax Per City Amount"; "Added Tax Per City Amount")
                {

                }
                field("Tax Number"; "Tax Number")
                {

                }
                field("Canton Code"; "Canton Code")
                {

                }
                field("Percentage"; Percentage)
                {

                }
                field("Wage Calculation Entry No."; "Wage Calculation Entry No.")
                {

                }
                field("D"; D)
                {

                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {

                }
                field("Calculated"; Calculated)
                {

                }
                field("JIB Contributes"; "JIB Contributes")
                {

                }
                field("Paid"; Paid)
                {

                }
                field("JIB Contributes DL"; "JIB Contributes DL")
                {

                }
                field("Org Jed"; "Org Jed")
                {

                }
                field("GF"; GF)
                {

                }
                field("Payment date"; "Payment date")
                {

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