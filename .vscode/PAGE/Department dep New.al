/*report 50014 "Department dep New"
{
    Caption = 'Department Temp change new';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Department Category temporary")
        {

            trigger OnAfterGetRecord()
            begin
                DepTemp1.RESET;
                DepTemp1.SETFILTER(Code, '%1', NewCode);
                DepTemp1.SETFILTER(Description, '%1', NewDescription);
                IF NOT DepTemp1.FINDFIRST THEN BEGIN

                    DataItem1.INIT;
                    DataItem1.Code := NewCode;
                    DataItem1.Description := NewDescription;
                    DataItem1."Residence/Network" := CentralaInsert;
                    DataItem1."Department Type" := DataItem1."Department Type"::"Department Category";
                    DataItem1."Official Translate of DepCat" := NewDescriptionDef;
                    DataItem1."Fields for change" := UPPERCASE('***');
                    DataItem1.IsTrue := TRUE;
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
                        DataItem1."Identity Sector" := SectorTemp1.Identity;
                    END;
                    DataItem1."Org Shema" := RealOrgShema;
                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FIND('-') THEN BEGIN
                        IF DimensionForReport.COUNT = 1 THEN BEGIN
                            DataItem1."Name of TC" := DimensionForReport."Dimension Value Code" + '-' + DimensionForReport."Dimension  Name";
                        END;
                    END;
                    DepTemp1.RESET;
                    DepTemp1.SETFILTER(Code, '%1', NewCode);
                    DepTemp1.SETFILTER(Description, '%1', NewDescription);
                    IF NOT DepTemp1.FINDFIRST THEN BEGIN
                        DataItem1.INSERT;
                    END;
                    DepartmentTempNew.RESET;
                    DepartmentTempNew.INIT;
                    DepartmentTempNew.Code := NewCode;
                    DepartmentTempNew.Description := NewDescription;
                    DepartmentTempNew."Department Type" := DepartmentTempNew."Department Type"::"Department Category";
                    DepartmentTempNew."Residence/Network" := CentralaInsert;
                    DepartmentTempNew."Department Category" := NewCode;
                    DepartmentTempNew."Department Categ.  Description" := NewDescription;
                    DepartmentTempNew."ORG Shema" := RealOrgShema;
                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                    IF SectorTemp1.FINDFIRST THEN BEGIN
                        DepartmentTempNew."Sector Identity" := SectorTemp1.Identity;
                        DepartmentTempNew.Sector := SectorTemp1.Code;
                        DepartmentTempNew."Sector  Description" := SectorTemp1.Description;
                    END;

                    DepartmentTempFind.RESET;
                    DepartmentTempFind.SETFILTER(Code, '%1', NewCode);
                    DepartmentTempFind.SETFILTER(Description, '%1', NewDescription);
                    DepartmentTempFind.SETFILTER("Department Type", '%1', DepartmentTempFind."Department Type"::"Department Category");
                    DepartmentTempFind.SETFILTER("ORG Shema", '%1', RealOrgShema);
                    IF NOT DepartmentTempFind.FINDFIRST THEN BEGIN
                        DepartmentTempNew.INSERT;
                    END;



                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            IF DimensionForReport1.GET(DimensionForReport.Code, DimensionForReport."Dimension Value Code", '', DimensionForReport."Department Categ.  Description", '', '', DimensionForReport."ORG Shema") THEN BEGIN

                                //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema

                                DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", '', NewDescription, '', '', RealOrgShema);
                                DimensionForReport1.Description := NewDescription;
                                DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                IF DimensionForReport1."Department Type" <> 4 THEN
                                    DimensionForReport1."Department Type" := 4;
                                SectorTemp1.RESET;
                                SectorTemp1.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                IF SectorTemp1.FINDFIRST THEN BEGIN
                                    IF DimensionForReport1.Sector <> SectorTemp1.Code THEN
                                        DimensionForReport1.Sector := SectorTemp1.Code;
                                    IF DimensionForReport1."Sector  Description" <> SectorTemp1.Description THEN
                                        DimensionForReport1."Sector  Description" := SectorTemp1.Description;
                                END;
                                DimensionForReport1."Department Category" := NewCode;
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
                group("Department Category")
                {
                    Caption = 'Department Category';
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

                    Part("Dimensions for report"; "Dimensions for report")
                    {
                        ApplicationArea = all;
                        SubPageLink = "Department Type" = FILTER(4);
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
        String: Text;
        Brojac: Integer;
        NewDescriptionDef: Text;
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
        TeamTemp: Record "TeamT";
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
        DepartmentTempFind: Record "Dimension temporary";
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
        DepTemp1: Record "Department Category temporary";
        SectorFInd: Integer;
        SectorCheckLength: Record "Sector temporary";

    procedure SetParam(OldCodeSent: Code[10]; OldNameSent: Text; Centrala: Option; PromjenaInsert: Integer; OrgS: Code[10])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        DepCatTemp.RESET;
        DepCatTemp.SETFILTER(Code, '%1', OldCodeSent);
        DepCatTemp.SETFILTER(Description, '%1', OldNameSent);
        DepCatTemp.SETFILTER("Org Shema", '%1', OrgS);
        IF DepCatTemp.FINDFIRST THEN
            NewDescriptionDef := DepCatTemp."Official Translate of DepCat"

        ELSE
            NewDescriptionDef := '';
        NewCode := OldCode;
        NewDescription := OldDescription;
        CentralaInsert := Centrala;
        Promjena := PromjenaInsert;
        RealOrgShema := OrgS;
    end;
}

*/