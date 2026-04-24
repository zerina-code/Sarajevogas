page 50098 "Radio Module"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Radio Module";
    CardPageId = "Radio Module Card";

    layout
    {
        area(Content)
        {

            repeater("")
            {

                field(Code; Code) { ApplicationArea = All; }
                field("Type Radio Module"; "Type Radio Module") { ApplicationArea = all; }
                field("Meter Manufacturer"; "Meter Manufacturer") { ApplicationArea = all; }
                field("Meter Manufacturer Desc"; "Meter Manufacturer Desc") { ApplicationArea = all; }
                field("Serial Number I"; "Serial Number I") { ApplicationArea = all; }
                field("Serial Number II"; "Serial Number II") { ApplicationArea = all; }
                field("Gauge Code"; "Gauge Code") { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }

            }
        }


    }

    var
        myInt: Integer;
}