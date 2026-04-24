page 50130 "Department Category"
{
    Caption = 'Department Category';
    PageType = List;
    SourceTable = "Department Category";
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
                field("Official Translate of DepCat"; "Official Translate of DepCat")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                }
                field("Sector Belongs"; "Sector Belongs")
                {
                    ApplicationArea = all;

                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;

                }
                field("Identity Sector"; "Identity Sector")
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
                field(Direction; Direction) { ApplicationArea = all; }

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

    trigger OnDeleteRecord(): Boolean
    begin
        /*ECL.RESET;
        ECL.SETFILTER(Status,'%1',ECL.Status::Active);
        ECL.SETFILTER("Org. Structure",'%1',"Org Shema");
        Found:=FALSE;
        IF ECL.FINDSET THEN REPEAT
        IF (ECL."Department Category"=Code) AND (ECL."Department Cat. Description"=Description) AND (ECL.Team='')
          AND (ECL."Team Description"='') AND (ECL.Group='') AND (ECL."Group Description"='')THEN BEGIN
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
        Text000: Label 'You must to redistribute people who belongs this department';
        ECL: Record "Employee Contract Ledger";
        Found: Boolean;
}

