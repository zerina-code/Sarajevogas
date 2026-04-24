/*page 50137 "Dimensions for pos reports"
{
    Caption = 'Dimensions for pos reports';
    PageType = ListPart;
    SourceTable = "Dimension Pos for report";

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

                    trigger OnValidate()
                    begin
                        IF "Org Belongs" <> '' THEN BEGIN
                            DepartmentTempReal.RESET;
                            DepartmentTempReal.SETFILTER(Description, '%1', "Org Belongs");
                            IF DepartmentTempReal.FINDFIRST THEN BEGIN
                                Sector := DepartmentTempReal.Sector;
                                "Sector  Description" := DepartmentTempReal."Sector  Description";
                                "Department Category" := DepartmentTempReal."Department Category";
                                "Department Categ.  Description" := DepartmentTempReal."Department Categ.  Description";
                                "Group Code" := DepartmentTempReal."Group Code";
                                "Group Description" := DepartmentTempReal."Group Description";
                                "Team Code" := DepartmentTempReal."Team Code";
                                "Team Description" := DepartmentTempReal."Team Description";
                                "Sector Identity" := DepartmentTempReal."Sector Identity";
                            END;

                            DimensionTempFindTC.RESET;
                            DimensionTempFindTC.SETFILTER(Sector, '%1', Sector);
                            DimensionTempFindTC.SETFILTER("Sector  Description", '%1', "Sector  Description");
                            DimensionTempFindTC.SETFILTER("Department Category", '%1', "Department Category");
                            DimensionTempFindTC.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                            DimensionTempFindTC.SETFILTER("Group Code", '%1', "Group Code");
                            DimensionTempFindTC.SETFILTER("Group Description", '%1', "Group Description");
                            DimensionTempFindTC.SETFILTER("Team Code", '%1', "Team Code");
                            DimensionTempFindTC.SETFILTER("Team Description", '%1', "Team Description");
                            IF DimensionTempFindTC.FINDFIRST THEN BEGIN
                                "Dimension  Name" := DimensionTempFindTC."Dimension  Name";
                                VALIDATE("Dimension  Name", "Dimension  Name");
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        IF "Dimension  Name" <> '' THEN BEGIN
                            DimensionValueTable.RESET;
                            DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                            DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                            IF DimensionValueTable.FINDFIRST THEN BEGIN
                                "Dimension Value Code" := DimensionValueTable.Code;
                            END
                            ELSE BEGIN
                                "Dimension Value Code" := '';
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Dimension Value Code"; "Dimension Value Code")
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
       
        ContractPhase: Record "Contract Phase t";
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
        DimensionNewTemp: Record "Sector temporary";
        Found: Boolean;
        SectorTemp: Record "Sector temporary";
        Broj: Integer;
        Dimensiontemp: Record "Dimension temporary";
        SectorReal: Record "Sector temporary";
        DimensionForPos: Record "Dimension temp for position";
        DimensionForPos1: Record "Dimension temp for position";
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        DepartmentTempReal: Record "Department temporary";
        DimensionTempFindTC: Record "Dimension temporary";
        DimensionValueTable: Record "Dimension Value";
}

*/