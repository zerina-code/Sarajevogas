page 50182 "Gauge sizes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Types Of Diseases";
    SourceTableView = where(Types = filter("Gauge size"));
    Caption = 'Gauge sizes';


    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { }
                field(Qmax; Qmax) { visible = false; }
                field("Measuring Area 1"; "Measuring Area 1") { }
                field("Measuring Area 2"; "Measuring Area 2") { }
                field(Mistake; Mistake) { visible = false; }
                field("Initial flow"; "Initial flow") { visible = false; }
                field("Stop flow"; "Stop flow") { visible = false; }
                field("LF Impulse"; "LF Impulse") { visible = false; }
                field("VF impulse"; "VF impulse") { visible = false; }
                field("VF frequency"; "VF frequency") { visible = false; }
                field("Maintenance Resource No."; "Maintenance Resource No.") { }
                field("Maintenance Resource without"; "Maintenance Resource without") { }


            }
        }
    }


    var
        myInt: Integer;
}