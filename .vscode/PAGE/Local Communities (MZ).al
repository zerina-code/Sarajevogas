page 50155 "MZ-s"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = MZ;
    Caption = 'Local Communities';

    layout
    {
        area(Content)
        {
            repeater("")
            {

                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';

                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    Caption = 'Description';
                }
                field(MZHSR; MZHSR) { ApplicationArea = all; }
                field(Zone; Zone)
                {
                    ApplicationArea = all;
                }

            }
        }

    }


    var
        myInt: Integer;
}