page 50100 "Misc Article Informations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Misc. article information";
    Caption = 'Misc Article Informations';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }

                field("Misc. Article Code"; "Misc. Article Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                { ApplicationArea = all; }
                field(Amount; Amount)
                { ApplicationArea = all; }
            }
        }
    }



    var
        myInt: Integer;
}