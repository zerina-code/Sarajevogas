page 50063 Group
{
    Caption = 'Group';
    PageType = List;
    SourceTable = Group;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Official Translate of Group"; "Official Translate of Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                }
                field("Identity Sector"; "Identity Sector")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Belongs to Department Category"; "Belongs to Department Category")
                {
                    ApplicationArea = all;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Identity; Identity)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("ID for GPS"; "ID for GPS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Remove changes")
            {
                Caption = 'Remove changes';
                Image = Change;

                trigger OnAction()
                begin
                    SETFILTER("Changing Department", '%1', TRUE);
                    SETFILTER("Org Shema", '%1', "Org Shema");
                    IF FIND('-') THEN
                        REPEAT
                            "Changing Department" := FALSE;
                            MODIFY;
                        UNTIL NEXT = 0;
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        OS.SETFILTER(Status, '%1', OS.Status::Active);
        IF OS.FINDFIRST THEN
            SETFILTER("Org Shema", '%1', OS.Code);
    end;

    var
        OS: Record "ORG Shema";
        Text000: Label 'You must to redistribute people who belongs this sector';
        ECL: Record "Employee Contract Ledger";
        Found: Boolean;
}

