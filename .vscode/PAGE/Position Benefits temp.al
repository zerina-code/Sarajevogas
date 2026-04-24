table 50165 "Position Benefits temporery"
{
    Caption = 'Position benefits';
    //ĐK DrillDownPageID = "Position Benefits temp";
    //ĐK LookupPageID = "Position Benefits temp";

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Position Code';

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
                IF "Position Code" <> '' THEN BEGIN
                    PositionMenu.RESET;
                    /* PositionMenu.SETFILTER(Code,'%1',"Position Code");
                     IF PositionMenu.FINDFIRST THEN BEGIN
                       "Position Name":=PositionMenu.Description;
                       END
                          ELSE BEGIN

                      "Position Name":='';*/
                END;
                //  END;

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Name";

            end;
        }
        field(2; "Code"; Code[20])
        {
            //ĐK BlankZero = true;
            Caption = 'Code';
            Editable = false;
            NotBlank = true;
            TableRelation = "Misc. Article".Code;

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
                "Benefit Type".SETFILTER(Code, '%1', Code);
                IF "Benefit Type".FINDFIRST
                  THEN
                    Description := "Benefit Type".Description;
                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Name";
            end;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            TableRelation = "Misc. Article".Description;

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
                IF Description <> '' THEN BEGIN
                    "Benefit Type".SETFILTER(Description, '%1', Description);
                    IF "Benefit Type".FINDFIRST THEN BEGIN
                        Code := "Benefit Type".Code;
                    END
                    ELSE BEGIN
                        Code := '';
                    END;
                END;
            end;
        }
        field(4; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(5; "Position Name"; Text[250])
        {
            Caption = 'Position Name';

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
                IF "Position Name" <> '' THEN BEGIN

                    PositionMenu.RESET;
                    PositionMenu.SETFILTER(Description, '%1', "Position Name");
                    IF PositionMenu.FINDFIRST THEN BEGIN
                        "Position Name" := PositionMenu.Description;
                    END
                    ELSE BEGIN

                        "Position Name" := '';
                    END;
                END;

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Name";
            end;
        }
        field(50005; Belongs; Text[200])
        {
            Caption = 'belong';

            trigger OnValidate()
            begin

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Name";
            end;
        }
        field(50006; "Org. Structure"; Code[20])
        {
            Caption = 'Org. Structure';
            TableRelation = "ORG Shema";
        }
    }

    keys
    {
        key(Key1; "Position Code", "Code", Description, "Position Name", "Org. Structure")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Benefit Type": Record "Misc. Article";
        PositionMenu: Record "Position Menu temporary";
        OrgShema: Record "ORG Shema";
}

