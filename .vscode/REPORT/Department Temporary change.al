/*report 50019 "Department Temporary change"
{
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
                    // "DataItem1".Role:=DimensionTable.Code;
                    RoleTabela.RESET;
                    RoleTabela.SETFILTER(Description, '%1', Roles);
                    RoleTabela.SETFILTER(Status, '%1', RoleTabela.Status::A);
                    IF RoleTabela.FINDFIRST THEN BEGIN
                        RoleTabela.VALIDATE(Description, Roles);
                        "DataItem1".Role := RoleTabela.Code;
                    END;

                    IF RoleTabela.Code = '' THEN BEGIN
                        "DataItem1".Role := '';
                        "DataItem1"."Role Name" := '';
                    END;
                    "DataItem1"."BJF/GJF" := BJF_GJF;
                    "DataItem1"."Key Function" := "Key";
                    "DataItem1"."Control Function" := Control;
                    "DataItem1"."Official Translation" := NewOfficialTranslate;
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
                            IF ForReport.COUNT = 1 THEN BEGIN
                                "DataItem1"."Department Code" := DepartmentTempFind.Code;
                            END
                            ELSE BEGIN
                                "DataItem1"."Department Code" := '';
                            END;
                            "DataItem1"."Sector Identity" := DepartmentTempFind."Sector Identity";
                        END;
                    END;
                    "DataItem1"."Fields for change" := UPPERCASE('***');
                    "DataItem1".INSERT;
                    ForReport.RESET;
                    IF ForReport.FINDSET THEN
                        REPEAT
                            // Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                            IF (ForReport."Position Code" <> NewCode) OR (ForReport."Position Description" <> NewDescription) THEN BEGIN
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
                            IF (ManagmentLevel.AsInteger() <> 7) AND (ManagmentLevel.AsInteger() <> 0) THEN BEGIN
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




                OrgShema.RESET;
                OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
                IF OrgShema.FINDFIRST THEN BEGIN
                    PositionBenefitsReport.RESET;
                    IF PositionBenefitsReport.FINDSET THEN
                        REPEAT
                            IF PositionBenefitsReport1.GET(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description,
                              PositionBenefitsReport."Position Name", PositionBenefitsReport."Org. Structure") THEN BEGIN
                                IF (PositionBenefitsReport."Position Code" <> NewCode) OR (PositionBenefitsReport."Position Name" = NewDescription) THEN
                                    PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, PositionBenefitsReport."Position Name", OrgShema.Code);

                                IF (PositionBenefitsReport1."Position Name" <> NewDescription) OR (PositionBenefitsReport1."Position Code" = NewCode) THEN
                                    PositionBenefitsReport1.RENAME(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, OrgShema.Code);
                                IF (PositionBenefitsReport1."Position Name" <> NewDescription) OR (PositionBenefitsReport1."Position Code" <> NewCode) THEN
                                    PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, OrgShema.Code);
                                //Position Code,Code,Description,Position Name
                            END;
                        UNTIL PositionBenefitsReport.NEXT = 0;
                END;
                PositionBenefitsReport.RESET;
                IF PositionBenefitsReport.FINDSET THEN
                    REPEAT
                        PositionBenefits.INIT;
                        PositionBenefits.TRANSFERFIELDS(PositionBenefitsReport);
                        OrgShema.RESET;
                        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
                        IF OrgShema.FINDFIRST THEN
                            PositionBenefits."Org. Structure" := OrgShema.Code;
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

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(OldCode; OldCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Old code';
                        TableRelation = "Sector temporary".Code;
                        Visible = false;
                    }
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
                    field(NewOfficialTranslate; NewOfficialTranslate)
                    {
                        ApplicationArea = all;
                        Caption = 'New Official translate';
                    }
                    field(Roles; Roles)
                    {
                        ApplicationArea = all;
                        Caption = 'Roles';
                        TableRelation = Role.Description WHERE(Status = FILTER('A'));
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
        IDC: Code[30];
        CCode: Code[30];
        OCode: Code[30];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        OldDescription: Text;
        PositionC: Record "Position";
        OldCode: Code[30];
        DepartmentTempNew: Record "Department temporary";
        i: Integer;
        LengthString: Integer;
        String: Text;
        Brojac: Integer;
        CreateNew: Text;
        OrgShema: Record "ORG Shema";
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
        Roles: Text;
        BJF_GJF: Option " ",BJF,GJF;
        CentralaInsert: Option ,Centrala,"Mreža";
        ManagmentLevel: enum "Management Level";
        "Key": Boolean;
        Control: Boolean;
        GradeNew: Integer;
        OldGradeReport: Integer;
        OldRolesReport: Text;
        OldBJFReport: Option;
        OldControlReport: Boolean;
        OldKeyReport: Boolean;
        OldMLReport: enum "Management Level";
        OldCentralaReport: Option;
        RealOrg: Code[30];
        OldDepChange: Code[30];
        PositionMenuTemp: Record "Position Menu temporary";
        DimensionTable: Record "Dimension Value";
        GradeTabela: Record "Grade";
        GradesChange1: Record "Grade";
        RealOrgShema: Code[30];
        ForReport: Record "Dimension Pos for report";
        ForReport1: Record "Dimension Pos for report";
        ForReport2: Record "Dimension Pos for report";
        ForReport3: Record "Dimension temp for position";
        ForReportdELETE: Record "Dimension Pos for report";
        Head: Record "Head Of's temporary";
        PositionBenefitsReport: Record "Position Benefits report";
        PositionBenefitsReport1: Record "Position Benefits temporery";
        PositionBenefits: Record "Position Benefits temporery";
        HeadOrgCheck: Record "Head Of's temporary";
        DepartmentTempFind: Record "Department temporary";
        NewOfficialTranslate: Text[250];
        NewOfficialTranslateSent: Text[250];
        RoleTabela: Record "Role";

    procedure SetParam(OldCodeSent: Code[30]; OldDescriptionSent: Text[250]; OldGrade: Integer; OldRoles: Text; OldBJF: Option; OldControl: Boolean; OldKey: Boolean; OldManagmentLevel: enum "Management Level"; RealorgShema: Code[10]; OldDepartmentCode: Code[50]; NewTranslate: Text[250])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldDescriptionSent;
        NewCode := OldCode;
        NewDescription := OldDescriptionSent;
        OldGradeReport := OldGrade;
        GradeNew := OldGrade;
        OldRolesReport := OldRoles;
        Roles := OldRoles;
        OldBJFReport := OldBJF;
        BJF_GJF := OldBJFReport;
        OldKeyReport := OldKey;
        Key := OldKeyReport;
        OldControlReport := OldControl;
        Control := OldControlReport;
        OldMLReport := OldManagmentLevel;
        ManagmentLevel := OldMLReport;
        RealOrg := RealorgShema;
        OldDepChange := OldDepartmentCode;
        NewOfficialTranslateSent := NewTranslate; //stari opis kada kopira
        NewOfficialTranslate := NewTranslate;
    end;
}

*/