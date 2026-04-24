/*report 50009 CopySector
{
    Caption = 'Department Temp change new';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Sector temporary")
        {

            trigger OnAfterGetRecord()
            begin
                SectorTemp1.RESET;
                SectorTemp1.SETFILTER(Code, '%1', NewCode);
                SectorTemp1.SETFILTER(Description, '%1', NewDescription);
                IF NOT SectorTemp1.FINDFIRST THEN BEGIN

                    "DataItem1".INIT;
                    "DataItem1".Code := NewCode;
                    "DataItem1".Description := NewDescription;
                    "DataItem1"."Official Translate of Sector" := NewDescriptionDef;
                    "DataItem1"."Residence/Network" := CentralaInsert;
                    "DataItem1"."Department Type" := "DataItem1"."Department Type"::Sector;
                    "DataItem1"."Fields for change" := UPPERCASE('***');
                    "DataItem1".IsTrue := TRUE;
                    "DataItem1"."Org Shema" := RealOrgShema;
                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FIND('-') THEN BEGIN
                        IF DimensionForReport.COUNT = 1 THEN BEGIN
                            "DataItem1"."Name of TC" := DimensionForReport."Dimension Value Code" + '-' + DimensionForReport."Dimension  Name";
                        END;
                    END;
                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Code, '%1', NewCode);
                    SectorTemp1.SETFILTER(Description, '%1', NewDescription);
                    IF NOT SectorTemp1.FINDFIRST THEN BEGIN
                        "DataItem1".INSERT;
                    END;
                    DepartmentTempNew.RESET;
                    DepartmentTempNew.INIT;
                    DepartmentTempNew.Code := NewCode;
                    DepartmentTempNew.Description := NewDescription;
                    DepartmentTempNew."Department Type" := DepartmentTempNew."Department Type"::Sector;
                    DepartmentTempNew."Residence/Network" := CentralaInsert;
                    DepartmentTempNew.Sector := NewCode;
                    DepartmentTempNew."Sector  Description" := NewDescription;
                    DepartmentTempNew."ORG Shema" := RealOrgShema;
                    SectorTemp.RESET;
                    SectorTemp.SETFILTER(Code, '%1', NewCode);
                    SectorTemp.SETFILTER(Description, '%1', NewDescription);
                    IF SectorTemp.FINDFIRST THEN BEGIN
                        DepartmentTempNew."Sector Identity" := SectorTemp.Identity;
                    END;
                    DepartmentTempFind.RESET;
                    DepartmentTempFind.SETFILTER("Department Type", '%1', 8);
                    DepartmentTempFind.SETFILTER("ORG Shema", '%1', RealOrgShema);
                    DepartmentTempFind.SETFILTER(Code, '%1', NewCode);
                    DepartmentTempFind.SETFILTER(Description, '%1', NewDescription);
                    IF NOT DepartmentTempFind.FINDFIRST THEN BEGIN
                        DepartmentTempNew.INSERT;
                    END;



                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            IF DimensionForReport1.GET(DimensionForReport.Code, DimensionForReport."Dimension Value Code", '', '', '', '', DimensionForReport."ORG Shema") THEN BEGIN

                                //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema

                                DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", '', '', '', '', RealOrgShema);
                                DimensionForReport1.Description := NewDescription;
                                DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                IF DimensionForReport1."Department Type" <> 8 THEN
                                    DimensionForReport1."Department Type" := 8;
                                IF DimensionForReport1.Sector <> NewCode THEN
                                    DimensionForReport1.Sector := NewCode;
                                IF DimensionForReport1."Sector  Description" <> NewDescription THEN
                                    DimensionForReport1."Sector  Description" := NewDescription;
                                DimensionForReport1."Dimension Code" := 'TC';
                                DimensionForReport1.MODIFY;
                            END;
                        UNTIL DimensionForReport1.NEXT = 0;

                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER(Code, '<>%1', '');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            DimesnionFind.RESET;
                            DimesnionFind.INIT;
                            DimesnionFind.TRANSFERFIELDS(DimensionForReport);
                            DimesnionFind.INSERT;
                        UNTIL DimensionForReport.NEXT = 0;

                   
                END;

            end;
        }
    }

    requestpage
    {
        Caption = 'Insert Sector';

        layout
        {
            area(content)
            {
                group(Sectors)
                {
                    Caption = 'Sectors';
                    field(NewCode; NewCode)
                    {
                        ApplicationArea = all;
                        Caption = 'NewCode';
                    }
                    field(NewDescription; NewDescription)
                    {
                        ApplicationArea = all;
                        Caption = 'New Description';
                    }
                    field(NewDescriptionDef; NewDescriptionDef)
                    {
                        ApplicationArea = all;
                        Caption = 'NewDescriptionDef';
                    }
                    field(CentralaInsert; CentralaInsert)
                    {
                        ApplicationArea = all;
                        Caption = 'Residence/Network';
                    }

                    part("Dimensions for report"; "Dimensions for report")
                    {
                        ApplicationArea = all;
                        SubPageLink = "Department Type" = FILTER(8);
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CheckNewCode := STRLEN(NewCode);
        StringNew := FORMAT(NewCode);
        Brojac := 0;
        FOR i := 1 TO CheckNewCode DO BEGIN
            IF StringNew[i] = '.' THEN BEGIN
                Brojac := Brojac + 1;
            END;
        END;
        IF StringNew[CheckNewCode] <> '.' THEN BEGIN
            ERROR(Text000);
        END;
        IF (Brojac <> 1) AND (Brojac <> 2) THEN BEGIN
            ERROR(Text000);
        END;
    end;

    var
        posC: Record "Position";
        OrgC: Code[10];
        DescriptionC: Text;
        IDC: Code[10];
        CCode: Code[20];
        OCode: Code[20];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        OldDescription: Text;
        PositionC: Record "Position";
        NewDescriptionDef: Text;
        OldCode: Code[10];
        DepartmentTempNew: Record "Department temporary";
        i: Integer;
        LengthString: Integer;
        String: Text;
        Brojac: Integer;
        CreateNew: Text;
        FirstPart: Text;
        j: Integer;
        SecondPart: Text;
        NewCode: Text;
        NewCode1: Text;
        SectorTemp: Record "Sector temporary";
        K: Integer;
        SecondPartDepCat: Text;
        NewCodeDepCat: Text;
        g: Integer;
        t: Integer;
        SecondPartGroup: Text;
        SecondPartTeam: Text;
        NewCodeGroup: Text;
        NewCodeTeam: Text;
        DepCatTemp: Record "Department Category temporary";
        GroupTemp: Record "Group temporary";
        TeamTemp: Record "Team temporary";
        PositionChange: Record "Position temporery";
        PositionFirst: Text;
        PositionSecond: Text;
        StringPosition: Text;
        LengthStringPosition: Integer;
        NewPositionCode: Text;
        PositionChange1: Record "Position temporery";
        NumberPosition: Integer;
        BrojacPozicija: Integer;
        PositionNumber: Record "Position temporery";
        Found: Boolean;
        Found1: Boolean;
        Found2: Boolean;
        PositionChange2: Record "Position temporery";
        SectorTemp1: Record "Sector temporary";
        NewDescription: Text;
        CentralaInsert: Option " ",Centrala,"Mreža";
        OldCentrala: Option ,Centrala,"Mreža";
        CheckNewCode: Integer;
        Text000: Label 'It''s wrong code';
        StringNew: Text;
        Promjena: Integer;
        DimensionsTemporery: Record "Dimension temporary";
        DimensionsTemporery1: Record "Dimension temporary";
        PositionMenu: Record "Position Menu temporary";
        DimensionForPos: Record "Dimension temp for position";
        FindZero: Integer;
        StringPOs: Text;
        DimensionForPos1: Record "Dimension temp for position";
        DepartmentTempFind: Record "Department temporary";
        DepartmentCode: Code[30];
        FoundOne: Boolean;
        LengthPosition: Integer;
        SecondPart1: Text;
        FindZero1: Integer;
        SectorFindForMenu: Record "Sector temporary";
        PositionMenu1: Record "Position Menu temporary";
        DepartmnetPOs: Code[10];
        DimensionTemp: Record "Dimension temporary";
        RealOrgShema: Code[10];
        DimensionTempor: Page "Dimensions temporary";
        OrgShema: Record "ORG Shema";
        TC: Integer;
        TC2: Integer;
        F: FilterPageBuilder;
        ForFilter: Code[10];
        DimesnionFind: Record "Dimension temporary";
        DimensionForReport: Record "Dimension for report";
        SectorFindForUpdate: Record "Sector temporary";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        DimensionForReport1: Record "Dimension for report";

    procedure SetParam(OrgS: Code[10]; NewC: Code[30]; NewDesc: Text; Centrala: Option)
    begin
        RealOrgShema := OrgS;
        NewDescription := NewDesc;
        NewCode := NewC;
        SectorFindForMenu.RESET;
        SectorFindForMenu.SETFILTER(Code, '%1', NewC);
        SectorFindForMenu.SETFILTER(Description, '%1', NewDesc);
        SectorFindForMenu.SETFILTER("Org Shema", '%1', OrgS);
        IF SectorFindForMenu.FINDFIRST THEN
            NewDescriptionDef := SectorFindForMenu."Official Translate of Sector"
        ELSE
            NewDescriptionDef := '';
        CentralaInsert := Centrala;
    end;
}

*/