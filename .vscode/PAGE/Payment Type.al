page 50080 "Payment Types"
{
    AutoSplitKey = false;
    Caption = 'Payment Types';
    //DataCaptionFields = "Employee No.";
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Payment Type";
    InsertAllowed = true;
    Permissions = TableData "Payment Type" = imd;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {

                }

                field("Version Code"; "Version Code")
                {
                    Caption = 'Version Code';
                }
                field(Description; Description)
                {

                }

                field("LEvel Code"; "Level Code")
                {

                }
            }
        }
    }

    actions
    {
    }


    var
        t_CompInfo: Record "Company Information";
        enable: Boolean;
}