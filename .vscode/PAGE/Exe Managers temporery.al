page 50074 "Exe Manager List temporery"
{
    AutoSplitKey = false;
    Caption = 'Exe Manager List';
    DelayedInsert = true;
    InsertAllowed = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Exe Manager temporery";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

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
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;

                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;

                }
                field("Subordinate Org Description"; "Subordinate Org Description")
                {
                    ApplicationArea = all;
                }
                field("Subordinate Org Code"; "Subordinate Org Code")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
        OS: Record "ORG Shema";
    begin
        OS.SETFILTER(Status, '%1', OS.Status::Preparation);
        IF OS.FINDFIRST THEN
            SETFILTER("Org Shema", '%1', OS.Code);

    end;

    var
        myInt: Integer;
}