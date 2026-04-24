/*page 50209 "EE Consents"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Consent;
    Caption = 'EE Consents';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field(Description; Description) { ApplicationArea = all; }
                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                field(Active; Active) { ApplicationArea = all; }

            }
        }
    }


    var
        myInt: Integer;
}*/