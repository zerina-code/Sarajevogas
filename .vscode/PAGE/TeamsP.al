/*page 50120 TeamsP
{
    Caption = 'Teams';
    PageType = List;
    SourceTable = TeamT;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                }
                field("Official Translate of Team"; "Official Translate of Team")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;


                }
                field("Belongs to Group"; "Belongs to Group")
                {
                    ApplicationArea = all;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                }
                field(Identity; Identity)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Identity"; "Group Identity")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Identity Sector"; "Identity Sector")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entity Code"; "Entity Code")
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
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Team")
            {
                Caption = '&Team';
                Image = SalesPurchaseTeam;

                action(Salespeople)
                {
                    ApplicationArea = all;
                    Caption = 'Salespeople';
                    Image = ExportSalesPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Team Salespeople";
                    RunPageLink = "Team Code" = FIELD(Code);
                }
            }
        }
        area(reporting)
        {
            action("Team To-dos")
            {
                Caption = 'Team To-dos';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5059;
            }
            action("Salesperson - To-dos")
            {
                Caption = 'Salesperson - To-dos';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report 5057;
            }
            action("Salesperson - Opportunities")
            {
                Caption = 'Salesperson - Opportunities';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 5058;
            }
        }
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

*/