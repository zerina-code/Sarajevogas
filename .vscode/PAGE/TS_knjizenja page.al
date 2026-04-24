page 50085 "TS_knjizenja_Wage"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = TS_knjizenja;
    RefreshOnActivate = true;
    Caption = 'TS_Posting Group';

    layout
    {
        area(Content)
        {
            repeater("Wage Posting")
            {
                field(vrnaloga; vrnaloga)
                {
                    ApplicationArea = All;


                }
                field(opis; opis)
                {
                    ApplicationArea = all;

                }
                field(D_C; D_C)
                {
                    ApplicationArea = all;
                }
                field(konto; konto)
                {
                    ApplicationArea = all;
                }

            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}