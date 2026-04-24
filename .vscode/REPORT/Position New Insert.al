/*report 50065 "Position New Insert"
{
    Caption = 'Position New Insert';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Position Menu temporary")
        {

            trigger OnAfterGetRecord()
            begin
                PositionMenuTemp.RESET;
                PositionMenuTemp.SETFILTER(Code, '%1', NewCode);
                PositionMenuTemp.SETFILTER(Description, '%1', NewDescription);
                IF NOT PositionMenuTemp.FINDFIRST THEN BEGIN



                    "DataItem1".INIT;
                    "DataItem1".Code := NewCode;
                    "DataItem1".Description := NewDescription;
                    "DataItem1"."Role Name" := Roles;
                    // DimensionTable.SETFILTER(Name,'%1',Roles);
                    // IF DimensionTable.FINDFIRST THEN
                    RoleTabela.RESET;
                    RoleTabela.SETFILTER(Description, '%1', Roles);
                    RoleTabela.SETFILTER(Status, '%1', RoleTabela.Status::A);
                    IF RoleTabela.FINDFIRST THEN
                        RoleTabela.VALIDATE(Description, Roles);
                    "DataItem1".Role := RoleTabela.Code;
                    IF RoleTabela.Code = '' THEN BEGIN
                        "DataItem1".Role := '';
                        "DataItem1"."Role Name" := '';
                    END;
                    "DataItem1".Role := DimensionTable.Code;
                    "DataItem1"."BJF/GJF" := BJF_GJF;
                    "DataItem1"."Key Function" := Key;
                    "DataItem1"."Control Function" := Control;
                    GradeTabela.RESET;
                    GradeTabela.SETFILTER("Position Code", '%1', NewCode);
                    GradeTabela.SETFILTER("Position Description", '%1', NewDescription);
                    IF NOT GradeTabela.FIND('-') THEN BEGIN
                        GradesChange1.INIT;
                        GradesChange1."Position Code" := NewCode;
                        GradesChange1."Position Description" := NewDescription;
                        GradesChange1."Org Shema" := RealOrgShema;
                        GradesChange1.Code := GradeNew;
                        GradesChange1.INSERT;
                    END;
                    "DataItem1".Grade := GradeNew;
                    "DataItem1"."Management Level" := ManagmentLevel;
                    ForReport.RESET;
                    IF ForReport.FINDFIRST THEN BEGIN
                        DepartmentTempFind.RESET;
                        DepartmentTempFind.SETFILTER(Description, '%1', ForReport."Org Belongs");
                        IF DepartmentTempFind.FINDFIRST THEN BEGIN
                            "DataItem1"."Department Code" := DepartmentTempFind.Code;
                            "DataItem1"."Sector Identity" := DepartmentTempFind."Sector Identity";
                        END;
                    END;
                    "DataItem1"."Fields for change" := UPPERCASE('***');
                    "DataItem1"."Official Translation" := NewOffTranslate;
                    "DataItem1".INSERT;
                    ForReport.RESET;
                    IF ForReport.FINDSET THEN
                        REPEAT
                            // Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                            IF ForReport."Position Code" <> NewCode THEN BEGIN
                                IF ForReport1.GET(ForReport."Position Code", ForReport."Dimension Value Code", ForReport."ORG Shema", ForReport."Position Description", ForReport."Org Belongs") THEN BEGIN
                                    ForReport1.RENAME(NewCode, ForReport."Dimension Value Code", ForReport."ORG Shema", NewDescription, ForReport."Org Belongs");
                                    ForReport1."Dimension Code" := 'TC';
                                    ForReport1.MODIFY;
                                END;
                            END;
                        UNTIL ForReport.NEXT = 0;


                    ForReport.RESET;
                    IF ForReport.FINDSET THEN
                        REPEAT
                            IF (ManagmentLevel.AsInteger() <> 6) AND (ManagmentLevel.AsInteger() <> 0) THEN BEGIN
                                DepartmentTempNew.RESET;
                                DepartmentTempNew.SETFILTER(Description, '%1', ForReport."Org Belongs");
                                IF DepartmentTempNew.FINDFIRST THEN BEGIN
                                    Head.RESET;
                                    Head.SETFILTER("Position Code", '%1', NewCode);
                                    Head.SETFILTER("Department Code", '%1', DepartmentTempNew.Code);
                                    IF NOT Head.FINDFIRST THEN BEGIN
                                        Head.INIT;
                                        Head."Management Level" := ManagmentLevel;
                                        Head."Position Code" := NewCode;
                                        Head."Department Code" := DepartmentTempNew.Code;
                                        Head.Sector := DepartmentTempNew.Sector;
                                        Head."Sector  Description" := DepartmentTempNew."Sector  Description";
                                        Head."Department Category" := DepartmentTempNew."Department Category";
                                        Head."Department Categ.  Description" := DepartmentTempNew."Department Categ.  Description";
                                        Head."Group Code" := DepartmentTempNew."Group Code";
                                        Head."Group Description" := DepartmentTempNew."Group Description";
                                        Head."Team Code" := DepartmentTempNew."Team Code";
                                        Head."Team Description" := DepartmentTempNew."Team Description";
                                        Head."ORG Shema" := RealOrgShema;
                                        HeadOrgCheck.RESET;
                                        HeadOrgCheck.SETFILTER("ORG Shema", '%1', RealOrgShema);
                                        HeadOrgCheck.SETFILTER("Sector  Description", '%1', DepartmentTempNew."Sector  Description");
                                        HeadOrgCheck.SETFILTER("Department Categ.  Description", '%1', DepartmentTempNew."Department Categ.  Description");
                                        HeadOrgCheck.SETFILTER("Group Description", '%1', DepartmentTempNew."Group Description");
                                        HeadOrgCheck.SETFILTER("Team Description", '%1', DepartmentTempNew."Team Description");
                                        IF HeadOrgCheck.FINDFIRST THEN BEGIN
                                            Head."Position Code" := NewCode;
                                        END
                                        ELSE BEGIN
                                            Head.INSERT;
                                        END;
                                    END;
                                END;
                            END;
                        UNTIL ForReport.NEXT = 0;
                    ForReport2.RESET;
                    IF ForReport2.FINDSET THEN
                        REPEAT
                            ForReport3.INIT;
                            ForReport3.TRANSFERFIELDS(ForReport2);
                            ForReport3.INSERT;
                        UNTIL ForReport2.NEXT = 0;


                    ForReportdELETE.RESET;
                    IF ForReportdELETE.FINDSET THEN
                        REPEAT
                            ForReportdELETE.DELETE;
                        UNTIL ForReportdELETE.NEXT = 0;

                END;




                PositionBenefitsReport.RESET;
                IF PositionBenefitsReport.FINDSET THEN
                    REPEAT
                        IF PositionBenefitsReport1.GET(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description, PositionBenefitsReport."Position Name", PositionBenefitsReport."Org. Structure") THEN BEGIN
                            IF (PositionBenefitsReport."Position Code" <> NewCode) AND (PositionBenefitsReport."Position Name" = NewDescription) THEN
                                PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, PositionBenefitsReport."Position Name", RealOrgShema);

                            IF (PositionBenefitsReport1."Position Name" <> NewDescription) AND (PositionBenefitsReport1."Position Code" = NewCode) THEN
                                PositionBenefitsReport1.RENAME(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, RealOrgShema);
                            IF (PositionBenefitsReport1."Position Name" <> NewDescription) AND (PositionBenefitsReport1."Position Code" <> NewCode) THEN
                                PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, RealOrgShema);
                            //Position Code,Code,Description,Position Name
                        END;
                    UNTIL PositionBenefitsReport.NEXT = 0;

                PositionBenefitsReport.RESET;
                IF PositionBenefitsReport.FINDSET THEN
                    REPEAT
                        PositionBenefits.INIT;
                        PositionBenefits.TRANSFERFIELDS(PositionBenefitsReport);
                        PositionBenefits.INSERT;
                    UNTIL PositionBenefitsReport.NEXT = 0;


                //trebalo bi dodati i dio koji mijenja department code
                PositionBenefitsReport.RESET;
                IF PositionBenefitsReport.FINDSET THEN
                    PositionBenefitsReport.DELETEALL;
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
                group(Pozicije)
                {
                    Caption = 'Pozicije';
                    field(NewCode; NewCode)
                    {
                        ApplicationArea = all;
                        Caption = 'New Position Code';
                    }
                    field(NewDescription; NewDescription)
                    {
                        ApplicationArea = all;
                        Caption = 'New Position Description';
                    }
                    field(NewOffTranslate; NewOffTranslate)
                    {
                        ApplicationArea = all;
                        Caption = 'New Official translate';
                    }
                    field(Roles; Roles)
                    {
                        ApplicationArea = all;
                        Caption = 'Roles';
                        TableRelation = Role.Description;
                    }
                    field(BJF_GJF; BJF_GJF)
                    {
                        ApplicationArea = all;
                        Caption = 'BJF/GJF';
                    }
                    field("Key"; "Key")
                    {
                        ApplicationArea = all;
                        Caption = 'Key function';
                    }
                    field(Control; Control)
                    {
                        ApplicationArea = all;
                        Caption = 'Control Function';
                    }
                    field(GradeNew; GradeNew)
                    {
                        ApplicationArea = all;
                        Caption = 'Grade';
                    }
                    field(ManagmentLevel; ManagmentLevel)
                    {
                        ApplicationArea = all;
                        Caption = 'Managment level';
                    }

                    part("Dimensions for posisitons"; "Dimensions for pos reports")
                    {
                        ApplicationArea = all;
                        Caption = 'Dimensions for posisitons';
                    }
                    part(Benefits; "Position Benefits report")
                    {
                        ApplicationArea = all;
                        Caption = 'Benefits';
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
        DepTemp1: Record "Group temporary";
        SectorFInd: Integer;
        SectorCheckLength: Record "Sector temporary";
        NewBelongs: Text;
        CodeForDep: Code[50];
        BJF_GJF: Option " ",BJF,GJF;
        Roles: Text;
        "Key": Boolean;
        Control: Boolean;
        GradeNew: Integer;
        ManagmentLevel: enum "Management Level";
        PositionMenuTemp: Record "Position Menu temporary";
        DimensionTable: Record "Dimension Value";
        GradesChange1: Record "Grade";
        ForReport: Record "Dimension Pos for report";
        ForReport1: Record "Dimension Pos for report";
        ForReport2: Record "Dimension Pos for report";
        ForReport3: Record "Dimension temp for position";
        ForReportdELETE: Record "Dimension Pos for report";
        Head: Record "Head Of's temporary";
        PositionBenefitsReport: Record "Position Benefits report";
        PositionBenefitsReport1: Record "Position Benefits report";
        PositionBenefits: Record "Position Benefits temporery";
        GradeTabela: Record "Grade";
        HeadOrgCheck: Record "Head Of's temporary";
        NewOffTranslate: Text[250];
        NewOfficialTranslate: Text;
        RoleTabela: Record "Role";

    procedure SetParam(OldCodeSent: Code[10]; OldNameSent: Text; Centrala: Option; PromjenaInsert: Integer; OrgS: Code[10]; OldTranslate: Text[250])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        NewCode := OldCode;
        NewDescription := OldDescription;
        CentralaInsert := Centrala;
        Promjena := PromjenaInsert;
        RealOrgShema := OrgS;
        NewOffTranslate := OldTranslate;
        NewOffTranslate := NewOffTranslate;
    end;
}

*/