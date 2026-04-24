page 50221 "Employee Surname"
{
    AutoSplitKey = false;
    Caption = 'List of Surnames';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "Employee Surname";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; "First Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; "Last Name")
                {
                    Caption = 'Last Name';
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin

                        CurrPage.UPDATE;
                    end;
                }
                field("Old Surname"; "Old Surname")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Old; Old)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Oldsurname: Text[100];
        EmployeeSurname: Record "Employee Surname";
        Text01: Label 'Do you want to save change';
}

