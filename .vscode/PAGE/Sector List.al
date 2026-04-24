page 50115 Sector
{
    Caption = 'Sector';
    PageType = List;
    SourceTable = Sector;
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
                field("Official Translate of Sector"; "Official Translate of Sector")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                }
                field(CEO; CEO)
                {
                    ApplicationArea = all;
                }
                field(Identity; Identity)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("ID for GPS"; "ID for GPS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Parent; Parent)
                {
                    ApplicationArea = all;
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
                Visible = false;

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

    trigger OnDeleteRecord(): Boolean
    begin
        /*ECL.RESET;
        ECL.SETFILTER(Status,'%1',ECL.Status::Active);
        Found:=FALSE;
        IF ECL.FINDSET THEN REPEAT
        IF (ECL.Sector=Code) AND (ECL."Sector Description"=Description) THEN BEGIN
        ERROR(Text000);
        Found:=TRUE;
        END;
        UNTIL (ECL.NEXT=0) OR (Found=TRUE);*/

    end;

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

