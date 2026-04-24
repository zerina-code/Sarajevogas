/*page 50098 "Position Benefits temp"
{
    Caption = 'Position Benefits';
    PageType = List;
    SourceTable = "Position Benefits temporery";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            field(Description; Description)
            {
                ApplicationArea = all;
            }
            field(Code; Code)
            {
                ApplicationArea = all;

                trigger OnValidate()
                begin
                    //HR01 start
                    IF Qualification.GET(Code) THEN BEGIN
                        Description := Qualification.Description;
                    END;
                    //HR01 end
                end;
            }
            field(Amount; Amount)
            {
                ApplicationArea = all;
            }
            field(Belongs; Belongs)
            {
                ApplicationArea = all;
                Style = Unfavorable;
                StyleExpr = TRUE;
            }

        }
    }

    actions
    {
        area(Processing)
        {

            group("Dimension temporary")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = true;
                action("Position temporery benefits")
                {
                    Caption = 'Position temporery benefits';
                    RunObject = Page "Position menu temp";
                    RunPageLink = Code = FIELD("Position Code"),
                              Description = FIELD("Position Name");
                    Visible = false;
                }
            }
        }
    }

    var
        myInt: Integer;
        Qualification: Record "Qualification";
}*/