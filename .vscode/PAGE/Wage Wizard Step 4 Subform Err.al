page 50043 "Wage Wizard Step 4 Subform Err"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Subform for Wage Wizard step 4-Error checking
    // 
    // //Functionality:
    // //View errors found

    Caption = 'Wage Wizard Step 4 Subform Err';
    PageType = ListPart;
    SourceTable = Error;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Description; Description)
                {
                }
                field(Table; Table)
                {
                }
                field(Value; Value)
                {
                }
                field(Status; Status)
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

    procedure RefreshMe()
    begin
        CurrPage.UPDATE(TRUE);
    end;
}

