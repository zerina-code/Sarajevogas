page 50055 "Employee Level Of Disability"
{
    Caption = 'Employee Level Of Disability';
    PageType = List;
    SourceTable = "Employee Level Of Disability";
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
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Internal ID"; "Internal ID")
                {
                    Caption = 'Internal ID';
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Employee Last Name"; "Employee Last Name")
                {
                    ApplicationArea = all;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Level of Disability"; "Level of Disability")
                {
                    ApplicationArea = all;
                }
                field("Decision On Disability"; "Decision On Disability")
                {
                    ApplicationArea = all;
                }
                field(Remark; Remark)
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
                field("Team Name"; "Team Name")
                {
                    ApplicationArea = all;
                    Visible=false;
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
                field(Active; Active)
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

