/*page 50071 "Blocked By"
{
    Caption = 'Blocked By';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Blocked By";


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("Blocked By"; "Blocked By")
                {
                }
                field(Date; Date)
                {
                }
                field(User; User)
                {
                }
                field(Blocked; Blocked)
                {
                    //test
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        CurrPage.UPDATE;
    end;
}

*/