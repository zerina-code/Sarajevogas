page 50012 "Contribution List"
{
    Caption = 'Contribution List';
    PageType = List;
    SourceTable = Contribution;
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
                field(Description; Description)
                {
                }
                field(Minimum; Minimum)
                {
                    Visible = false;
                }
                field(Maximum; Maximum)
                {
                    Visible = false;
                }
                field("Over Brutto"; "Over Brutto")
                {
                }
                field("From Brutto"; "From Brutto")
                {
                }
                field("Over Netto"; "Over Netto")
                {
                }
                field(Active; Active)
                {
                }
                field("Contract Payment Model"; "Contract Payment Model")
                {
                    Visible = false;
                }
                field("Contract Refer To No."; "Contract Refer To No.")
                {
                    Visible = false;
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
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

