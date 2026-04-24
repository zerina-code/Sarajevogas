page 50046 "Wage/Reduction Banks"
{
    Caption = 'Reduction Banks';
    PageType = List;
    SourceTable = "Wage/Reduction Bank";
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
                field(Name; Name)
                {
                }
                field("Contact E-mail"; "Contact E-mail")
                {
                    Visible = true;

                }
                field(Fax; Fax) { Visible = true; }
                field("Phone No."; "Phone No.") { Visible = true; }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        if USERID = 'TENEO\DJEMINA.KARALIC' then
            Probably := true
        else
            Probably := false;
        //INT1.0 end
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        if USERID = 'TENEO\DJEMINA.KARALIC' then
            Probably := true
        else
            Probably := false;

    end;

    var
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
        Probably: Boolean;
}

