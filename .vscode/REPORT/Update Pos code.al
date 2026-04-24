/*report 50108 "Update Pos Code"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update Pos Code.rdlc';
    Caption = 'Update ECL';
    UsageCategory = Lists;
    ApplicationArea = all;

    dataset
    {
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        Employee: Record Employee;
        WB: Record "Work Booklet";
    begin
        //Code,Description,Department Code,Org. Structure
        Employee.Reset();
        if Employee.FindSet() then
            repeat

                WB.Reset();
                WB.SetFilter("Employee No.", '%1', Employee."No.");
                WB.SetFilter("Current Company", '%1', true);
                WB.SetCurrentKey("Starting Date");
                WB.Ascending;
                if WB.FindLast() then begin
                    Employee."Employment Date" := WB."Starting Date";
                    Employee.Modify();

                end;


            until Employee.Next() = 0;


    end;

    var
        OrgShema: Record "ORG Shema";
        ECLOrgKojiSeVidi: Record "Employee Contract Ledger";
        ECLNeVidi: Record "Employee Contract Ledger";
        DeleteUpdate: Record "Employee Contract Ledger";
        DeleteUpdate2: Record "Employee Contract Ledger";
        ECLNeVidi2: Record "Employee Contract Ledger";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        GroupOrginal: Record "Group";
        TeamOrginal: Record "TeamT";
        //ĐK DepartmentOrginal: Record "Record";
        HeadOfOrginal: Record "Head Of's";
        DimensionOrginalPos: Record "Dimension for position";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuOrginal: Record "Position Menu";
        SectorTemp: Record "Sector temporary";
        SectorOrginal1: Record "Sector";
        DepCatTemp: Record "Department Category temporary";
        DepCatOrginal1: Record "Department Category";
        GroupTemp: Record "Group temporary";
        GroupOrginal1: Record "Group";
        TeamTemp: Record "Team temporary";
        TeamOrginal1: Record "TeamT";
        DepartmentTemp: Record "Department temporary";
        DepartmentOrginal1: Record "Department";
        HeadOfTemp: Record "Head Of's temporary";
        HeadOfOrginal1: Record "Head Of's";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal1: Record "Position Benefits";
        PositionMenuOrginal1: Record "Position Menu";
        PositionMenuTemp: Record "Position Menu temporary";
        PoSMenDUp: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        PositionMenuTemp1: Record "Position Menu temporary";
}

*/