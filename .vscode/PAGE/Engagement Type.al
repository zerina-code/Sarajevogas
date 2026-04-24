/*page 50098 "Engagement Type"
{
    PageType = List;
    SourceTable = "Engagement Type";
    Caption = 'Engagement Type';
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;

                }

                field(Description; Description)
                {
                    ApplicationArea = all;

                }
                field("No. of Contracts"; "No. of Contracts")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Hours in Day"; "Hours in Day")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Calculation Type"; "Calculation Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Termination Date Mandatory"; "Termination Date Mandatory")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Operator No."; "Operator No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
    }
}

*/