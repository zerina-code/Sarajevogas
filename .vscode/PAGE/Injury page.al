/*page 50245 "Injury List"
{
    Caption = 'Injury List';
    PageType = List;
    SourceTable = Injury;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Injury Name"; "Injury Name")
                {
                    ApplicationArea = all;
                }
                field("Measure Type"; "Measure Type")
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

*/