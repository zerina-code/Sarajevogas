/*page 50099 "Position Benefits"
{
    Caption = 'Position Benefits';
    PageType = List;
    SourceTable = "Position Benefits";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                    Visible = true;
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
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field("Position Name"; "Position Name")
                {

                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    var
        Qualification: Record "Qualification";
}

*/