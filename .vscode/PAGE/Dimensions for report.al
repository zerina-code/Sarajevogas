/*page 50138 "Dimensions for report"
{
    Caption = 'Dimensions temporary';
    PageType = ListPart;
    SourceTable = "Dimension for report";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Value Code"; "Dimension Value Code")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //ĐK  CurrPage.UPDATE;

                    end;
                }
                field("Dimension  Name"; "Dimension  Name")
                {
                    ApplicationArea = all;
                    Editable = false;

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
    }

    trigger OnAfterGetRecord()
    begin


    end;

    trigger OnDeleteRecord(): Boolean
    begin
      

    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
       



    end;

    var
        
        ContractPhase: Record "Contract Phase t";
        ECL: Record "Employee Contract Ledger";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        //ĐK Tip: Record "Type";
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
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong: Record "Sector temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        TeamTempBelong: Record "Team temporary";
        TeamTempBelong1: Record "Team temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        SectorTempPage: Page "Sector temporary sist";
        DimensionTempYes: Record "Dimension temporary";
        OutReport: Boolean;
        //   DepartmentTchangesector: Report "Department T change sector";
        oRG: Code[10];
        CODEBack: Code[10];
        descBack: Text;
}

*/