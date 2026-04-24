/*report 50015 "Department group New"
{
    Caption = 'Department group New';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Group temporary")
        {

            trigger OnAfterGetRecord()
            begin
                DepTemp1.RESET;
                DepTemp1.SETFILTER(Code, '%1', NewCode);
                DepTemp1.SETFILTER(Description, '%1', NewDescription);
                IF NOT DepTemp1.FINDFIRST THEN BEGIN
                    "DataItem1".INIT;
                    "DataItem1".Code := NewCode;
                    "DataItem1".Description := NewDescription;
                    "DataItem1"."Residence/Network" := CentralaInsert;
                    "DataItem1"."Department Type" := "DataItem1"."Department Type"::Group;
                    "DataItem1"."Fields for change" := UPPERCASE('***');
                    "DataItem1"."Belongs to Department Category" := NewBelongs;
                    "DataItem1"."Official Translate of Group" := NewDescriptionDef;
                    "DataItem1".IsTrue := TRUE;
                    String := NewCode;
                    FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                        IF String[i] = '.' THEN BEGIN
                            Brojac := Brojac + 1;
                            IF Brojac = 2 THEN
                                SectorFInd := i;
                        END;
                    END;
                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                    IF SectorTemp1.FINDFIRST THEN BEGIN
                        IF "DataItem1"."Identity Sector" = 0 THEN
                            "DataItem1"."Identity Sector" := SectorTemp1.Identity;
                    END;
                    "DataItem1"."Org Shema" := RealOrgShema;
                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FIND('-') THEN BEGIN
                        IF DimensionForReport.COUNT = 1 THEN BEGIN
                            "DataItem1"."Name of TC" := DimensionForReport."Dimension Value Code" + '-' + DimensionForReport."Dimension  Name";
                        END;
                    END;
                    DepTemp1.RESET;
                    DepTemp1.SETFILTER(Code, '%1', NewCode);
                    DepTemp1.SETFILTER(Description, '%1', NewDescription);
                    IF NOT DepTemp1.FINDFIRST THEN BEGIN
                        "DataItem1".INSERT;
                    END;
                    DepartmentTempNew.RESET;
                    DepartmentTempNew.INIT;
                    DepartmentTempNew.Code := NewCode;
                    DepartmentTempNew.Description := NewDescription;
                    DepartmentTempNew."Department Type" := DepartmentTempNew."Department Type"::Group;
                    DepartmentTempNew."Residence/Network" := CentralaInsert;
                    DepartmentTempNew."Department Categ.  Description" := NewBelongs;
                    DepartmentTempNew."Group Code" := NewCode;
                    DepartmentTempNew."Group Description" := NewDescription;
                    DepCatTemp.RESET;
                    DepCatTemp.SETFILTER(Description, '%1', NewBelongs);
                    IF DepCatTemp.FINDFIRST THEN BEGIN
                        DepartmentTempNew."Department Category" := DepCatTemp.Code;
                        DepartmentTempNew."Department Idenity" := DepCatTemp.Identity;
                    END;
                    DepartmentTempNew."ORG Shema" := RealOrgShema;
                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                    IF SectorTemp1.FINDFIRST THEN BEGIN
                        DepartmentTempNew."Sector Identity" := SectorTemp1.Identity;
                        DepartmentTempNew.Sector := SectorTemp1.Code;
                        DepartmentTempNew."Sector  Description" := SectorTemp1.Description;
                    END;
                    DepTemp1.RESET;
                    DepTemp1.SETFILTER(Code, '%1', NewCode);
                    DepTemp1.SETFILTER(Description, '%1', NewDescription);
                    IF DepTemp1.FINDFIRST THEN BEGIN
                        DepartmentTempNew."Department Group identity" := DepTemp1.Identity;
                    END;

                    DepartmentTempFind.RESET;
                    DepartmentTempFind.SETFILTER("Group Code", '%1', NewCode);
                    DepartmentTempFind.SETFILTER("Group Description", '%1', NewDescription);
                    DepartmentTempFind.SETFILTER("Department Type", '%1', 2);
                    DepartmentTempFind.SETFILTER("ORG Shema", '%1', RealOrgShema);
                    IF NOT DepartmentTempFind.FINDFIRST THEN BEGIN
                        DepartmentTempNew.INSERT;
                    END;



                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            IF DimensionForReport1.GET(DimensionForReport.Code, DimensionForReport."Dimension Value Code", '', DimensionForReport."Department Categ.  Description",
                              DimensionForReport."Group Description", DimensionForReport."Group Code", DimensionForReport."ORG Shema") THEN BEGIN
                                DepCatTemp.RESET;
                                DepCatTemp.SETFILTER(Description, '%1', NewBelongs);
                                IF DepCatTemp.FINDFIRST THEN BEGIN
                                    CodeForDep := DepCatTemp.Code;
                                END;
                                //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema

                                DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", '', NewBelongs, NewDescription, NewCode, RealOrgShema);
                                DimensionForReport1.Description := NewDescription;
                                DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                IF DimensionForReport1."Department Type" <> 2 THEN
                                    DimensionForReport1."Department Type" := 2;
                                SectorTemp1.RESET;
                                SectorTemp1.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                IF SectorTemp1.FINDFIRST THEN BEGIN
                                    IF DimensionForReport1.Sector <> SectorTemp1.Code THEN
                                        DimensionForReport1.Sector := SectorTemp1.Code;
                                    IF DimensionForReport1."Sector  Description" <> SectorTemp1.Description THEN
                                        DimensionForReport1."Sector  Description" := SectorTemp1.Description;
                                END;
                                DimensionForReport1."Department Category" := CodeForDep;
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

                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER(Code, '<>%1', '');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            DimensionForReport.DELETE;
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
                group(Groups)
                {
                    Caption = 'Groups';
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
                    field(NewBelongs; NewBelongs)
                    {
                        ApplicationArea = all;
                        Caption = 'New Belongs ';
                        TableRelation = "Department Category temporary".Description;
                    }
                    part("Dimensions for report"; "Dimensions for report")

                    {
                        ApplicationArea = All;
                        SubPageLink = "Department Type" = CONST(2);
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
        SectorCheckLength.RESET;
        IF SectorCheckLength.FINDSET THEN
            REPEAT
                IF STRLEN(NewCode) < STRLEN(SectorCheckLength.Code) THEN ERROR(Text000);
            UNTIL SectorCheckLength.NEXT = 0;
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
        OldCode: Code[10];
        DepartmentTempNew: Record "Department temporary";
        i: Integer;
        LengthString: Integer;
        NewDescriptionDef: Text;
        String: Text;
        Brojac: Integer;
        CreateNew: Text;
        FirstPart: Text;
        j: Integer;
        SecondPart: Text;
        NewCode: Text;
        NewCode1: Text;
        SectorTemp: Record "Position Menu temporary";
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
        SectorFindForMenu: Record "Position Menu temporary";
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
        SectorFindForUpdate: Record "Position Menu temporary";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        DimensionForReport1: Record "Dimension for report";
        DepTemp1: Record "Group temporary";
        SectorFInd: Integer;
        SectorCheckLength: Record "Sector temporary";
        NewBelongs: Text;
        CodeForDep: Code[50];

    procedure SetParam(OldCodeSent: Code[10]; OldNameSent: Text; Centrala: Option; OrgS: Code[10]; OldBelong: Text)
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        GroupTemp.RESET;
        GroupTemp.SETFILTER(Code, '%1', OldCodeSent);
        GroupTemp.SETFILTER(Description, '%1', OldNameSent);
        GroupTemp.SETFILTER("Org Shema", '%1', OrgS);
        IF GroupTemp.FINDFIRST THEN
            NewDescriptionDef := GroupTemp."Official Translate of Group"
        ELSE
            NewDescriptionDef := '';
        NewCode := OldCode;
        NewDescription := OldDescription;
        CentralaInsert := Centrala;
        RealOrgShema := OrgS;
        NewBelongs := OldBelong;
    end;
}

*/