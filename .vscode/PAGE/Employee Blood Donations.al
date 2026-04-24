page 50173 "Employee Bood Donations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Diseases";
    SourceTableView = where(Types = filter("Employee Bood Donations"));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = All;

                }
                field(Date; Date)
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
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetFilter("No.", '%1', "Employee No.");
        if Employee.FindFirst() then begin
            Employee."Blood Donor" := true;
        end
        else begin
            Employee."Blood Donor" := false;
        end;
    end;

    var
        myInt: Integer;

}