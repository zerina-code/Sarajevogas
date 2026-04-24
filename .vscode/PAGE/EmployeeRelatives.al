pageextension 50034 EmployeeRelatives extends "Employee Relatives"
{
    layout
    {
        // Add changes to page layout here
        modify("Relative's Employee No.")
        {
            ApplicationArea = all;
        }
        modify(Comment)
        { Visible = false; }

        //ĐK    moveafter("Birth Date"; Age);
        addafter("Birth Date")
        {
            field(Age; Age)
            {
                ApplicationArea = all;
            }
        }

        addbefore("Relative Code")
        {
            field("Line No."; "Line No.")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("Employee No."; "Employee No.")
            {
                ApplicationArea = all;
            }
            field("Internal ID"; "Internal ID")
            {
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

        }
        addafter("Relative Code")
        {
            field("Relative Description"; "Relative Description")
            {
                ApplicationArea = all;
            }


        }
        addafter("First Name")
        {
            field("Last Name"; "Last Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Middle Name")
        {
            field("Mother's Maiden Name"; "Mother's Maiden Name")
            {
                ApplicationArea = all;
            }

        }
        addafter("Relative's Employee No.")
        {

            field(Sex; Sex)
            {
                ApplicationArea = all;
            }

            field("Health Insurance"; "Health Insurance")
            {
                ApplicationArea = all;
            }
            field("Disabled Child"; "Disabled Child")
            {
                ApplicationArea = all;
            }
        }
        addafter(Comment)
        {
            field("Date Of Input Info"; "Date Of Input Info")
            {
                ApplicationArea = all;
            }
            field("Place of work"; "Place of work")
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

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}