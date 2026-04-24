page 50027 "Tax Classes"
{
    // //SPNPL01.00 JB 08.06.2004.
    // 
    // //Purpose:
    // //Tax Class info
    // 
    // //Functionality:
    // //Data entry

    Caption = 'Tax Classes';
    PageType = List;
    SourceTable = "Tax Class";
    UsageCategory = Administration;
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
                field("Entity Code"; "Entity Code")
                {
                }
                field(Percentage; Percentage)
                {
                }
                field("Valid From Amount"; "Valid From Amount")
                {
                }
                field("Valid To Amount"; "Valid To Amount")
                {
                }
                field(Active; Active)
                {
                }
                field("Posting Group"; "Posting Group")
                {

                }
                field("G/L Account No."; "G/L Account No.")
                {

                }
                field("G/L Balance Account No."; "G/L Balance Account No.")
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

