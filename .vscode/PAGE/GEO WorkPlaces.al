//staviti ću izvan ranga- nisam sigurna da li će mi trebati kao šifarnik
page 50191 "GEO WorkPlaces"
{
    Caption = 'GEO WorkPlaces';
    SourceTable = "GEO WorkPlace";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field("Open Date"; "Open Date") { }
                field(Status; Status)
                {
                    DrillDown = true;
                    Editable = false;


                }

                field(Class; Class) { }
                field(Investor; Investor) { Visible = false; }
                field("Investor Name"; "Investor Name") { Visible = false; }
                field("GEO Construction Manager"; "GEO Construction Manager") { Visible = false; }
                field("GEO Construction Manager Name"; "GEO Construction Manager Name") { Visible = false; }
                field(Comment; Comment) { }
                field("RN Number"; "RN Number")
                {
                    ApplicationArea = all;
                    DrillDownPageId = 50189;
                    LookupPageId = 50189;
                }




            }
        }

    }
}

