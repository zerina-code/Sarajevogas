page 50013 "Contribution Category List"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Additional Tax Category List
    // 
    // //Functionality:
    // //Lookup (list form)

    Caption = 'Contribution Category List';
    PageType = List;
    SourceTable = "Contribution Category";
    UsageCategory = Lists;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Tax Payment Percentage"; "Tax Payment Percentage")
                {
                }

            }
        }
    }

    actions
    {
    }

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
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

