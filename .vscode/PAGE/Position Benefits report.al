/*page 50097 "Position Benefits report"
{
    Caption = 'Position Benefits';
    PageType = ListPart;
    SourceTable = "Position Benefits report";


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Description; Description)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        OrgShema.RESET;
                        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
                        IF OrgShema.FINDLAST THEN BEGIN
                            "Org. Structure" := OrgShema.Code;
                        END
                        ELSE BEGIN
                            "Org. Structure" := '';
                        END;

                        "Benefit Type".SETFILTER(Description, '%1', Description);
                        IF "Benefit Type".FINDFIRST THEN BEGIN
                            Evaluate(myInt, "Benefit Type"."Code");
                            Code := myInt;
                        END
                        ELSE BEGIN
                            Code := 0;
                        END;
                        "Position Code" := Rec."Position Code";
                        "Position Name" := Rec."Position Name";
                        CurrPage.UPDATE;
                    end;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;

                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        CurrPage.UPDATE;
                    end;
                }
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
        OrgShema: Record "ORG Shema";
        "Benefit Type": Record "Misc. Article";
}*/