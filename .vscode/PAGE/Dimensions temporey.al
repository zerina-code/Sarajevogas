/*page 50040 "Dimensions temporary"
{
    Caption = 'Dimensions temporary';
    PageType = List;
    SourceTable = "Dimension temporary";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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
                    Visible = true;
                    ApplicationArea = all;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Type"; "Department Type")
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

        IF Rec."Department Type" = Rec."Department Type"::Sector THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Department Type", 8);
            Rec.SETRANGE(Code, Rec.Code);
            Rec.SETRANGE(Description, '%1', Rec.Description);

            Rec.FILTERGROUP(0);
        END;
        IF Rec."Department Type" = Rec."Department Type"::"Department Category" THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Department Type", 4);
            Rec.SETRANGE("Department Category", Rec."Department Category");
            Rec.SETRANGE("Department Categ.  Description", Rec."Department Categ.  Description");
            Rec.FILTERGROUP(0);
        END;


        IF Rec."Department Type" = Rec."Department Type"::Group THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SETRANGE("Department Type", 2);
            Rec.SETRANGE("Group Code", Rec."Group Code");
            Rec.SETRANGE("Group Description", Rec."Group Description");
            Rec.FILTERGROUP(0);
        END;


    end;

    trigger OnDeleteRecord(): Boolean
    begin
        IF Rec."Department Type" = rec."Department Type"::Sector THEN BEGIN
            SectorTempBelong.RESET;
            SectorTempBelong.SETFILTER(Description, '%1', Rec.Description);
            IF SectorTempBelong.FINDFIRST THEN BEGIN
                SectorTempBelong.CALCFIELDS("Number of dimension value");
                IF SectorTempBelong."Number of dimension value" = 2 THEN BEGIN
                    DimensionTempYes.RESET;
                    DimensionTempYes.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                    IF DimensionTempYes.FINDFIRST THEN BEGIN
                        SectorTempBelong."Name of TC" := DimensionTempYes."Dimension Value Code" + ' ' + '-' + ' ' + DimensionTempYes."Dimension  Name";
                        SectorTempBelong.MODIFY;
                    END
                    ELSE BEGIN
                        SectorTempBelong."Name of TC" := '';
                        SectorTempBelong.MODIFY;
                    END;
                END;
            END;
        END;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
       


        DepTempBelong.RESET;
        DimensionsTempTabela.RESET;
        DepTempBelong.SETFILTER(Code, '<>%1', '');
        IF DepTempBelong.FINDSET THEN
            REPEAT
                DepTempBelong.CALCFIELDS("Number of dimension value");
                IF DepTempBelong."Number of dimension value" = 1 THEN BEGIN
                    DepTempBelong1 := DepTempBelong;
                    DimensionsTempTabela.RESET;
                    DimensionsTempTabela.SETFILTER("Department Type", '%1', 4);
                    DimensionsTempTabela.SETFILTER("Department Categ.  Description", '%1', DepTempBelong.Description);
                    IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                        DepTempBelong1."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                        DepTempBelong1.MODIFY;
                    END;

                END;
            UNTIL DepTempBelong.NEXT = 0;
        GroupTempBelong.RESET;
        DimensionsTempTabela.RESET;
        GroupTempBelong.SETFILTER(Code, '<>%1', '');
        IF GroupTempBelong.FINDSET THEN
            REPEAT
                GroupTempBelong.CALCFIELDS("Number of dimension value");
                IF GroupTempBelong."Number of dimension value" = 1 THEN BEGIN
                    GroupTempBelong1 := GroupTempBelong;
                    DimensionsTempTabela.RESET;
                    DimensionsTempTabela.SETFILTER("Department Type", '%1', 2);
                    DimensionsTempTabela.SETFILTER("Group Description", '%1', GroupTempBelong.Description);
                    IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                        GroupTempBelong1."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                        GroupTempBelong1.MODIFY;
                    END;
                END;
            UNTIL GroupTempBelong.NEXT = 0;
        TeamTempBelong.RESET;
        DimensionsTempTabela.RESET;
        TeamTempBelong.SETFILTER(Code, '<>%1', '');
        IF TeamTempBelong.FINDSET THEN
            REPEAT
                TeamTempBelong.CALCFIELDS("Number of dimension value");
                IF TeamTempBelong."Number of dimension value" = 1 THEN BEGIN
                    TeamTempBelong1 := TeamTempBelong;
                    DimensionsTempTabela.RESET;
                    DimensionsTempTabela.SETFILTER("Department Type", '%1', 9);
                    DimensionsTempTabela.SETFILTER("Team Description", '%1', TeamTempBelong.Name);
                    IF DimensionsTempTabela.FINDFIRST THEN BEGIN
                        TeamTempBelong1."Name of TC" := DimensionsTempTabela."Dimension Value Code" + ' ' + '-' + ' ' + DimensionsTempTabela."Dimension  Name";
                        TeamTempBelong1.MODIFY;
                    END;
                END;
            UNTIL TeamTempBelong.NEXT = 0;



    end;

    var
        CM: Record "Comission Members";
        // CMPage: Page "Comission Members";
        //Compensation: Record "Compensation";
        //CompensationPage: Page "Compensations";
        ContractPhase: Record "Contract Phase t";
        ECL: Record "Employee Contract Ledger";
        TeamRec: Record "Team temporary";
        LengthCode: Integer;
        //  Tip: Record "Type";
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
        //DepartmentTchangesector: Report "Department T change sector";
        oRG: Code[20];
        CODEBack: Code[20];
        descBack: Text;
}

*/