page 50156 "Streets"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Street;
    Caption = 'Streets';

    layout
    {
        area(Content)
        {

            repeater("")
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description) { ApplicationArea = all; }
                field("Home No."; "Home No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Floor; Floor) { ApplicationArea = all; Visible = false; }
                field("Apartment No."; "Apartment No.") { ApplicationArea = all; Visible = false; }
            }
        }

    }


    var
        myInt: Integer;
}