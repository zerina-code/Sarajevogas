/*page 50235 "Dimension for Position"
{
    Caption = 'Dimension for Position';
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "Dimension for position";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("Org Belongs"; "Org Belongs")
                {
                    ApplicationArea = all;
                }
                field("Dimension Code"; "Dimension Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                }
                field("Operator No."; "Operator No.")
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; "Last Date Modified")
                {
                    ApplicationArea = all;
                }
                field(Belongs; Belongs)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                }
                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sector Identity"; "Sector Identity")
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

    trigger OnOpenPage()
    begin
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', 0);
        IF OrgShema.FINDLAST THEN BEGIN
            SETFILTER("ORG Shema", '%1', OrgShema.Code);
        END;
    end;

    var
        OrgShema: Record "Org SHema";

}

*/