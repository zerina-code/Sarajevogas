page 50039 "Wage Wizard Step 3 Subform RT"
{
    Caption = 'Wage Wizard Step 3 Subform Red';
    PageType = ListPart;
    SourceTable = "Reduction per Wage Temp";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Reduction No."; "Reduction No.")
                {
                }
                field(Amount; Amount)
                {
                }
                field(Type; Type)
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
        Reduction: Record Reduction;
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure RefreshMe(ReductionNo: Code[20])
    begin
        Rec.SETRANGE("Reduction No.", ReductionNo);

        CurrPage.UPDATE(TRUE);
    end;
}

