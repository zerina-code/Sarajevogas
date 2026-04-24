/*page 50086 "Dimensions temp for positions"
{
    Caption = 'Dimensions temporary';
    PageType = List;
    SourceTable = "Dimension temp for position";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Org Belongs"; "Org Belongs")
                {
                    TableRelation = "Department temporary".Description;
                    ApplicationArea = all;
                }

                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                }
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                }
                field(Belongs; Belongs)
                {
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Position Code"; "Position Code")
                {
                    ApplicationArea = all;
                }
                field("Position Description"; "Position Description")
                {
                    ApplicationArea = all;
                }
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin





    end;

    trigger OnDeleteRecord(): Boolean
    begin
        PositionMenuCorrect.RESET;
        PositionMenuCorrect.SETFILTER(Code, '%1', Rec."Position Code");
        PositionMenuCorrect.SETFILTER(Description, '%1', Rec."Position Description");
        IF PositionMenuCorrect.FINDFIRST THEN BEGIN
            IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code, PositionMenuCorrect.Description, PositionMenuCorrect."Department Code", PositionMenuCorrect."Org. Structure") THEN BEGIN
                PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code, PositionMenuCorrect.Description, '', PositionMenuCorrect."Org. Structure");
                //Code,Description,Department Code,Org. Structure
            END;

        END;
    end;

    trigger OnOpenPage()
    begin
        DimensionForPos.RESET;
        DimensionForPos.SETFILTER(Sector, '<>%1', '');
        IF DimensionForPos.FINDSET THEN
            REPEAT
                SectorReal.RESET;
                SectorReal.SETFILTER(Description, '%1', DimensionForPos."Sector  Description");
                IF SectorReal.FINDFIRST THEN BEGIN
                    DimensionForPos1 := DimensionForPos;
                    DimensionForPos1."Sector Identity" := SectorReal.Identity;
                    DimensionForPos1.MODIFY;
                END;
            UNTIL DimensionForPos.NEXT = 0;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin

       

    end;

    var
       
        ECL: Record "Employee Contract Ledger";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        // Tip: Record "Type";
        Dep: Record "Department temporary";
        DC: Record "Department Category temporary";
        TEAM: Record "Team temporary";
        GR: Record "Group temporary";
        SectorR: Record "Sector temporary";
        NewDepartment: Record "Department temporary";
        DepartmentCategory: Record "Department Category temporary";
        SectorNew: Record "Sector temporary";
        GroupNew: Record "Group temporary";
        Team1: Record "Team temporary";
        DepartmentCheck: Record "Department temporary";
        DepartmentValidate: Record "Department temporary";
        OrgStr: Record "ORG Shema";
        Sec: Record "Sector temporary";
        DepCat: Record "Department Category temporary";
        Dimension: Record "Dimension temporary";
        DepartmentTempTry: Record "Department temporary";
        DepartmentTempTry1: Record "Department temporary";
        DimensionNewTemp: Record "Dimension temporary";
        Found: Boolean;
        SectorTemp: Record "Sector temporary";
        Broj: Integer;
        Dimensiontemp: Record "Dimension temporary";
        SectorReal: Record "Sector temporary";
        DimensionForPos: Record "Dimension temp for position";
        DimensionForPos1: Record "Dimension temp for position";
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
}
*/