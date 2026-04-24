page 50014 "Wage Header List"
{
    Caption = 'Wage Header';
    CardPageID = "Wage Header Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Wage Header";
    UsageCategory = Administration;
    ApplicationArea = All;

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
                field("Month Of Wage"; "Month Of Wage")
                {
                }
                field("Year Of Wage"; "Year Of Wage")
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
        Txt001: Label 'Are you sure you want to transfer data?';
        Txt003: Label 'Data transffered.';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';

    procedure GetSelection(): Code[10]
    var
        WageHeader: Record "Wage Header";
    begin
        CurrPage.SETSELECTIONFILTER(WageHeader);
        WageHeader.FIND('-');
        EXIT(WageHeader."No.");
    end;
}

