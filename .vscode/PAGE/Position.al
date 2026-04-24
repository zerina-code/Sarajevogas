page 50075 Position
{
    PageType = List;
    SourceTable = "Position Menu";
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
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;
                }
                field("Key Function"; "Key Function")
                {
                    ApplicationArea = all;
                }
                /*   field("Role Name"; "Role Name")
                   {
                       ApplicationArea = all;
                   }*/
                field(Role; Role)
                {
                    ApplicationArea = all;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                }
                field("Position Menu Identity"; "Position Menu Identity")
                {
                    ApplicationArea = all;
                }
                field("BJF/GJF"; "BJF/GJF")
                {
                    ApplicationArea = all;
                }
                field("Control Function"; "Control Function")
                {
                    ApplicationArea = all;
                }
                field("Official Translation"; "Official Translation")
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

