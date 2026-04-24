page 50187 "Meter Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Meter Type";
    Caption = 'Meter Type';

    layout
    {
        area(Content)
        {

            repeater("")
            {
                field("Meter type"; "Meter type") { ApplicationArea = all; }
                field("Gauge Size"; "Gauge Size") { ApplicationArea = all; }
                field("Minimum flow"; "Minimum flow") { ApplicationArea = all; }
                field("Maximum flow"; "Maximum flow") { ApplicationArea = all; }
                field("Minimum pressure"; "Minimum pressure") { ApplicationArea = all; }
                field("Maximum pressure"; "Maximum pressure") { ApplicationArea = all; }
                field("Minimum temperature"; "Minimum temperature") { ApplicationArea = all; }
                field("Moderation period"; "Moderation period") { ApplicationArea = all; }
            }
        }
    }


    var
        myInt: Integer;
}