page 50053 "Union Employees"
{
    Caption = 'Union Employees';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Employee Diseases";
    SourceTableView = where(Types = filter("Union Employees"));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Code; Code_Union)
                {
                    ApplicationArea = all;
                }
                field("Union Name"; "Union Name")
                {
                    ApplicationArea = all;
                }
                field("Union Membership No."; "Union Membership No.")
                {
                    ApplicationArea = all;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }

                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("Team Name"; "Team Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Sector Name"; "Sector Name")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

