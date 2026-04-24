page 50011 "Work Performance"
//ED 01 START
{
    Caption = 'Work Performance';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Work performance";

    layout
    {

        area(content)
        {
            repeater(s)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Employee No."; "Employee No.")
                {
                    Editable = true;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Month Of Performance"; "Month Of Performance")
                {
                    Editable = true;
                }
                field("Year Of Performance"; "Year Of Performance")
                {
                    Editable = true;
                }
                field("Quality of performed work"; "Quality of performed work")
                {
                    Editable = true;
                }
                field("Scope of performed work"; "Scope of performed work")
                {
                    Editable = true;
                }
                field("Deadline for completion of w"; "Deadline for completion of w")
                {
                    Editable = true;
                }
                field("Attitude towards work obligati"; "Attitude towards work obligati")
                {
                    Editable = true;
                }
                field(Grade; Grade)
                {
                    Editable = false;
                }
                field("Increase in basic salary(%)"; "Increase in basic salary(%)")
                {
                    Editable = false;
                }
                field(Approved; Approved)
                {
                    Editable = true;
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

    trigger OnDeleteRecord(): Boolean
    begin

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Validate(Rec."Quality of performed work", "Quality of performed work"::"3.00");
        Validate(Rec."Scope of performed work", "Scope of performed work"::"3.00");
        Validate(Rec."Deadline for completion of w", "Deadline for completion of w"::"3.00");
        Validate(Rec."Attitude towards work obligati", "Attitude towards work obligati"::"3.00");
        MonthFilter := DATE2DMY(WORKDATE, 2);
        Validate(Rec."Month Of Performance", MonthFilter);
        YearFilter := DATE2DMY(WORKDATE, 3);
        Validate(Rec."Year Of Performance", YearFilter);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

    end;

    trigger OnModifyRecord(): Boolean
    begin

    end;

    var
        Employee: Record "Employee";
        MonthFilter: Integer;
        YearFilter: Integer;
    //ED 01 END
}