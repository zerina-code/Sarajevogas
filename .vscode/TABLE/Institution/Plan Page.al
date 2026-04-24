page 50227 "Plan Page"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Plan RN";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Year; Year) { }
                field("Activity Code"; "Activity Code")
                {

                }
                field("Activity Name"; "Activity Name")
                {

                }
                field("Plan Value"; "Plan Value") { }
                field
                (Realised; Realised)
                {

                    DrillDownPageId = "Page by Intervention";
                }

            }
        }
    }


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if Year <> 0 then
            SetFilter("Plan Filter", '%1..%2', DMY2Date(1, 1, Year), DMY2Date(31, 12, Year));
        CalcFields(Realised);

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        if Year <> 0 then
            SetFilter("Plan Filter", '%1..%2', DMY2Date(1, 1, Year), DMY2Date(31, 12, Year));

        CalcFields(Realised);
    end;

    var
        myInt: Integer;
}