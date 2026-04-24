page 50095 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';
    PageType = List;
    SourceTable = "Points per Experience Years";
    SourceTableView = where("Points Category" = filter("Points per Disability Status"));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                //ED 02 START
                field(Category; Category)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Years; Years)
                {
                    Visible = VisibleYears;
                }
                field(Points; Points)
                {
                    ApplicationArea = all;
                }
                field("Lower Limit Months"; "Lower Limit Months")
                {
                    Visible = VisibleMonths;
                }
                field("Upper Limit Months"; "Upper Limit Months")
                {
                    Visible = VisibleMonths;
                }
            }
        }
    }

    var
        VisibleYears: Boolean;
        VisibleMonths: Boolean;

    trigger OnAfterGetRecord()
    begin

        IF Rec.Category = 0 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 0);
            Rec.FILTERGROUP(0);
            VisibleYears := true;
            VisibleMonths := false;
        END;
        IF Rec.Category = 1 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 1);
            Rec.FILTERGROUP(0);
            VisibleYears := false;
            VisibleMonths := true;
        END;
        IF Rec.Category = 2 THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE(Category, 2);
            Rec.FILTERGROUP(0);
            VisibleYears := false;
            VisibleMonths := false;
        end;

    end;
    //ED 02 END
}

