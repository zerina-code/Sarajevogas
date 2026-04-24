page 50019 "Wage Headers List"
{
    Caption = 'Wage Headers';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Wage Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    //KK
                }
                field(Description; Description)
                {
                    Editable = false;
                }
                field("Year Of Wage"; "Year Of Wage")
                {
                    Editable = false;
                }
                field("Month Of Wage"; "Month Of Wage")
                {
                    Editable = false;
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

    procedure GetSelectionFilter(): Code[80]
    var
        WH: Record "Wage Header";
        SelectionFilter: Code[80];
    begin
        CurrPage.SETSELECTIONFILTER(WH);
        SelectionFilter := '';
        IF WH.FIND('-') THEN
            SelectionFilter := WH."No." + ',' + FORMAT(WH."Entry No.");

        EXIT(SelectionFilter);
    end;
}

