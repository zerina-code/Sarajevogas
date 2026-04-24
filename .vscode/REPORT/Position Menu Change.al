report 50064 "Position Menu Change"
{
    Caption = 'Position Menu Change';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Position Menu temporary")
        {

            trigger OnAfterGetRecord()
            begin


                //Dimensions for pos reports
                SETFILTER("Org. Structure", '%1', RealOrg);
                SETFILTER(Code, '%1', OldCode);
                SETFILTER(Description, '%1', OldDescription);
                IF FIND('-') THEN BEGIN
                    IF PositionMenuTemp.GET("DataItem1".Code, "DataItem1".Description, "DataItem1"."Department Code", "DataItem1"."Org. Structure") THEN BEGIN
                        DimensionForPosReport.RESET;
                        // DimensionForPosReport.SETFILTER("Dimension Value Code",'<>%1','');
                        IF DimensionForPosReport.FINDFIRST THEN BEGIN

                            DepartmentTemporery.RESET;
                            DepartmentTemporery.SETFILTER(Description, '%1', DimensionForPosReport."Org Belongs");
                            IF DepartmentTemporery.FINDFIRST THEN BEGIN
                                DepartmentCode := DepartmentTemporery.Code;
                            END
                            ELSE BEGIN
                                DepartmentCode := '';
                            END;
                        END;



                        PositionMenuTemp.RENAME(NewCode, NewDescription, DepartmentCode, "DataItem1"."Org. Structure");
                        PositionMenuTemp1 := PositionMenuTemp;
                        //     PositionMenuTemp1.VALIDATE("Role Name", Roles);
                        PositionMenuTemp1."Official Translation" := NewOfficialTranslate;
                        PositionMenuTemp1."BJF/GJF" := BJF_GJF;
                        PositionMenuTemp1."Control Function" := Control;
                        PositionMenuTemp1."Key Function" := Key;
                        /*         GradesChange.RESET;
                                 GradesChange.SETFILTER("Position Code", '%1', OldCode);
                                 GradesChange.SETFILTER("Position Description", '%1', OldDescription);
                                 GradesChange.SETFILTER("Org Shema", '%1', RealOrg);
                                 IF GradesChange.FINDFIRST THEN BEGIN
                                     IF GradesChange1.GET(GradesChange.Code, GradesChange."Position Code", GradesChange."Position Description", GradesChange."Org Shema") THEN
                                         GradesChange1.RENAME(GradeNew, NewCode, NewDescription, GradesChange."Org Shema");


                                     //Code,Position Code,"Position Description ",Org Shema
                                 END
                                 ELSE BEGIN
                                     GradesChange1.INIT;
                                     GradesChange1."Position Code" := NewCode;
                                     GradesChange1."Position Description" := NewDescription;
                                     GradesChange1."Org Shema" := RealOrg;
                                     GradesChange1.Code := GradeNew;
                                     IF GradeNew <> 0 THEN
                                         GradesChange1.INSERT;
                                 END;
                                 PositionMenuTemp1.Grade := GradeNew;*/
                        PositionMenuTemp1."Management Level" := ManagmentLevel;
                        PositionMenuTemp1."Fields for change" := UPPERCASE('***');
                        PositionMenuTemp1.MODIFY;

                        ECLSystematization.RESET;
                        ECLSystematization.SETFILTER("Position Code", '%1', OldCode);
                        ECLSystematization.SETFILTER("Position Description", '%1', OldDescription);
                        IF ECLSystematization.FINDSET THEN
                            REPEAT
                                IF DepartmentCode <> OldDepChange THEN BEGIN
                                    //IF OldDescription<>NewDescription THEN BEGIN
                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                        ECLSystematization1.VALIDATE("Position Description", '');
                                        ECLSystematization1.MODIFY;
                                    END;
                                END
                                ELSE BEGIN
                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                        ECLSystematization1.VALIDATE("Position Description", NewDescription);
                                        ECLSystematization1.MODIFY;
                                    END;
                                END;
                            UNTIL ECLSystematization.NEXT = 0;

                        FindZero := 0;
                        FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                            StringPos := NewCode;
                            IF (StringPos[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                FindZero := i;
                                FoundOne := TRUE;
                            END;
                            IF FindZero = 0 THEN
                                FindZero := STRLEN(DepTemporary.Code);
                        END;
                        IF COPYSTR(NewCode, 1, FindZero - 1) <> PositionMenuTemp."Department Code" THEN BEGIN
                            PositionMenuTemp.IsTrue := TRUE;
                        END
                        ELSE BEGIN
                            PositionMenuTemp.IsTrue := FALSE;
                        END;
                        FoundOne := FALSE;
                    END;

                    DimensionForPosReport.RESET;
                    // DimensionForPosReport.SETFILTER("Dimension Value Code",'<>%1','');
                    //DimensionForPosReport.SETFILTER("Org Belongs",'<>%1','');
                    IF DimensionForPosReport.FINDSET THEN
                        REPEAT
                            /*  IF COPYSTR(DimensionsTempForPos."Position Code",1,STRLEN(OldDepChange))<>OldDepChange THEN
                             NewCode:=DimensionsTempForPos."Position Code";*/
                            IF DimensionForPosReport1.GET(DimensionForPosReport."Position Code", DimensionForPosReport."Dimension Value Code", DimensionForPosReport."ORG Shema", DimensionForPosReport."Position Description", DimensionForPosReport."Org Belongs") THEN BEGIN
                                DimensionForPosReport1.RENAME(NewCode, DimensionForPosReport."Dimension Value Code", DimensionForPosReport."ORG Shema", NewDescription, DimensionForPosReport."Org Belongs");
                                DimensionForPosReport1.Belongs := NewCode + '-' + NewDescription;
                                DepForCode.RESET;
                                DepForCode.SETFILTER(Description, '%1', DimensionForPosReport."Org Belongs");
                                IF DepForCode.FINDFIRST THEN BEGIN
                                    DimensionForPosReport1.Sector := DepForCode.Sector;
                                    DimensionForPosReport1."Group Code" := DepForCode."Group Code";
                                    DimensionForPosReport1."Department Category" := DepForCode."Department Category";
                                    DimensionForPosReport1."Team Code" := DepForCode."Team Code";
                                    DimensionForPosReport1."Team Description" := DepForCode."Team Description";
                                    DimensionForPosReport1."Group Description" := DepForCode."Group Description";
                                    DimensionForPosReport1."Department Categ.  Description" := DepForCode."Department Categ.  Description";
                                    DimensionForPosReport1."Sector  Description" := DepForCode."Sector  Description";
                                END;
                                DimensionForPosReport1."Dimension Code" := 'TC';
                                DimensionForPosReport1.MODIFY;
                            END;
                        UNTIL DimensionForPosReport.NEXT = 0;
                    DimensionForPosReportHead.RESET;
                    IF DimensionForPosReportHead.FINDSET THEN
                        REPEAT
                            IF DimensionForPosReportHead.COUNT = 1 THEN BEGIN
                                IF (ManagmentLevel.AsInteger() <> 6) AND (ManagmentLevel.AsInteger() <> 0) THEN BEGIN
                                    Head.RESET;
                                    Head.SETFILTER("Sector  Description", '%1', DimensionForPosReportHead."Sector  Description");
                                    Head.SETFILTER("Department Categ.  Description", '%1', DimensionForPosReportHead."Department Categ.  Description");
                                    Head.SETFILTER("Group Description", '%1', DimensionForPosReportHead."Group Description");
                                    Head.SETFILTER("Team Description", '%1', DimensionForPosReportHead."Team Description");
                                    IF Head.FINDSET THEN
                                        REPEAT
                                            Head.DELETE;
                                        UNTIL Head.NEXT = 0;
                                    DimensionForPosReportHead.RESET;
                                    IF DimensionForPosReportHead.FINDFIRST THEN BEGIN
                                        HeadChange.RESET;
                                        HeadChange.INIT;
                                        HeadChange.Sector := DimensionForPosReportHead.Sector;
                                        HeadChange."Sector  Description" := DimensionForPosReportHead."Sector  Description";
                                        HeadChange."Department Category" := DimensionForPosReportHead."Department Category";
                                        HeadChange."Department Categ.  Description" := DimensionForPosReportHead."Department Categ.  Description";
                                        HeadChange."Group Code" := DimensionForPosReportHead."Group Code";
                                        HeadChange."Group Description" := DimensionForPosReportHead."Group Description";
                                        HeadChange."Team Code" := DimensionForPosReportHead."Team Code";
                                        HeadChange."Team Description" := DimensionForPosReportHead."Team Description";
                                        HeadChange."Position Code" := NewCode;
                                        HeadChange."Position Description" := NewDescription;
                                        HeadChange."ORG Shema" := "DataItem1"."Org. Structure";
                                        HeadChange."Management Level" := ManagmentLevel;
                                        DepartmentTempForHead.RESET;
                                        DepartmentTempForHead.SETFILTER(Description, '%1', DimensionForPosReport1."Org Belongs");
                                        IF DepartmentTempForHead.FINDFIRST THEN BEGIN
                                            HeadChange."Department Code" := DepartmentTempForHead.Code;
                                        END
                                        ELSE BEGIN
                                            HeadChange."Department Code" := '';
                                        END;
                                        HeadCheck.RESET;
                                        HeadCheck.SETFILTER(Sector, '%1', DimensionForPosReport1.Sector);
                                        HeadCheck.SETFILTER("Sector  Description", '%1', DimensionForPosReport1."Sector  Description");
                                        HeadCheck.SETFILTER("Department Category", '%1', DimensionForPosReport1."Department Category");
                                        HeadCheck.SETFILTER("Department Categ.  Description", '%1', DimensionForPosReport1."Department Categ.  Description");
                                        HeadCheck.SETFILTER("Group Code", '%1', DimensionForPosReport1."Group Code");
                                        HeadCheck.SETFILTER("Group Description", '%1', DimensionForPosReport1."Group Description");
                                        HeadCheck.SETFILTER("Team Code", '%1', DimensionForPosReport1."Team Code");
                                        HeadCheck.SETFILTER("Team Description", '%1', DimensionForPosReport1."Team Description");
                                        IF NOT HeadCheck.FINDFIRST THEN
                                            HeadChange.INSERT;
                                    END;


                                END;
                            END;

                        UNTIL DimensionForPosReportHead.NEXT = 0;


                    DimensionsTemp.SETFILTER("Position Code", '%1', OldCode);
                    DimensionsTemp.SETFILTER("Position Description", '%1', OldDescription);
                    DimensionsTemp.SETFILTER("ORG Shema", '%1', RealOrg);
                    IF DimensionsTemp.FINDSET THEN
                        REPEAT
                            DimensionsTemp.DELETE;
                        UNTIL DimensionsTemp.NEXT = 0;

                    DimensionForReport.RESET;
                    // DimensionForReport.SETFILTER("Dimension Value Code",'<>%1','');
                    IF DimensionForReport.FINDSET THEN
                        REPEAT
                            DimesnionFind.RESET;
                            DimesnionFind.INIT;
                            DimesnionFind.TRANSFERFIELDS(DimensionForReport);
                            DimensionsTemp.SETFILTER("Position Code", '%1', OldCode);
                            DimensionsTemp.SETFILTER("Position Description", '%1', OldDescription);
                            DimensionsTemp.SETFILTER("ORG Shema", '%1', RealOrg);
                            DimensionsTemp.SETFILTER("Dimension  Name", '%1', DimesnionFind."Dimension  Name");
                            IF NOT DimensionsTemp.FIND('-') THEN
                                DimesnionFind.INSERT;
                        UNTIL DimensionForReport.NEXT = 0;


                    PositionBenefits.RESET;
                    PositionBenefits.SETFILTER("Position Code", '%1', OldCode);
                    PositionBenefits.SETFILTER("Position Name", '%1', OldDescription);
                    PositionBenefits.SETFILTER("Org. Structure", '%1', RealOrg);
                    IF PositionBenefits.FINDSET THEN
                        REPEAT
                            PositionBenefits.DELETE;
                        UNTIL PositionBenefits.NEXT = 0;



                    PositionBenefitsReport.RESET;
                    IF PositionBenefitsReport.FINDSET THEN
                        REPEAT
                            IF PositionBenefitsReport1.GET(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description, PositionBenefitsReport."Position Name", PositionBenefitsReport."Org. Structure") THEN BEGIN
                                IF (PositionBenefitsReport."Position Code" <> NewCode) AND (PositionBenefitsReport."Position Name" = NewDescription) THEN
                                    PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, PositionBenefitsReport."Position Name", RealOrg);

                                IF (PositionBenefitsReport1."Position Name" <> NewDescription) AND (PositionBenefitsReport1."Position Code" = NewCode) THEN
                                    PositionBenefitsReport1.RENAME(PositionBenefitsReport."Position Code", PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, RealOrg);
                                IF (PositionBenefitsReport1."Position Name" <> NewDescription) AND (PositionBenefitsReport1."Position Code" <> NewCode) THEN
                                    PositionBenefitsReport1.RENAME(NewCode, PositionBenefitsReport.Code, PositionBenefitsReport.Description, NewDescription, RealOrg);
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
                END;
                IF DimensionForReport.COUNT > 1 THEN BEGIN
                    PositionMenuTemp.RESET;
                    PositionMenuTemp.SETFILTER(Code, '%1', NewCode);
                    PositionMenuTemp.SETFILTER(Description, '%1', NewDescription);
                    IF PositionMenuTemp.FINDFIRST THEN BEGIN
                        IF PositionMenuTemp.GET(PositionMenuTemp.Code, PositionMenuTemp.Description, PositionMenuTemp."Department Code", PositionMenuTemp."Org. Structure") THEN
                            PositionMenuTemp.RENAME(NewCode, NewDescription, '', "DataItem1"."Org. Structure");
                    END;
                END;
                PositionMenuTemp.RESET;
                PositionMenuTemp.SETFILTER(Code, '%1', NewCode);
                PositionMenuTemp.SETFILTER(Description, '%1', NewDescription);
                IF PositionMenuTemp.FINDFIRST THEN BEGIN
                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Description, '%1', DepForCode."Sector  Description");
                    IF SectorTemp1.FINDFIRST THEN BEGIN
                        PositionMenuTemp."Sector Identity" := SectorTemp1.Identity;
                        PositionMenuTemp.MODIFY;
                    END;
                END;


                /* DimensionForReport.RESET;
                  DimensionForReport.SETFILTER("Dimension Value Code",'<>%1','');
                  IF  DimensionForReport.FINDSET THEN REPEAT
                    DimensionForReport.DELETE;
                    UNTIL DimensionForReport.NEXT=0;*/



            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Positions)
                {
                    Caption = 'Positions';
                    field(OldCode; OldCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Old code';
                        TableRelation = "Position Menu temporary".Code;
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
                    /*    field(Roles; Roles)
                        {
                            ApplicationArea = all;
                            Caption = 'Roles';
                            TableRelation = Role.Description WHERE(Status = FILTER('A'));
                        }*/
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
                    /*    part("Dimensions for posisitons"; "Dimensions for pos reports")

                        {
                            ApplicationArea = all;
                            Caption = 'Dimensions for posisitons';
                        }*/
                    /*    part(Benefits; "Position Benefits report")
                        {
                            ApplicationArea = all;
                            Caption = 'Benefits';
                        }*/
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
        NewDescription: Text[250];
        OldCode: Code[30];
        OldDescription: Text[250];
        NewCode: Code[30];
        PositionMenuTemp: Record "Position Menu temporary";
        DimensionsTemp: Record "Dimension temp for position";
        DimensionsTemp1: Record "Dimension temp for position";
        PositionBenefits: Record "Position Benefits temporery";
        PositionBenefits1: Record "Position Benefits temporery";
        FindZero: Integer;
        StringPos: Text;
        FoundOne: Boolean;
        i: Integer;
        DimensionsTempForPos: Record "Dimension temp for position";
        DepartmentCode: Code[30];
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
        OldMLReport: Enum "Management Level";
        OldCentralaReport: Option;
        DimensionForPosReport: Record "Dimension Pos for report";
        DepTemporary: Record "Dimension temporary";
        DimensionForPosReport1: Record "Dimension Pos for report";
        DimensionForReport: Record "Dimension Pos for report";
        DimesnionFind: Record "Dimension temp for position";
        RealOrg: Code[10];
        PositionMenuTemp1: Record "Position Menu temporary";
        //     GradesChange: Record "Grade";
        //   GradesChange1: Record "Grade";
        OldDepChange: Code[50];
        DimensionForPosReport2: Record "Dimension Pos for report";
        CoundTable1: Integer;
        CountTable2: Integer;
        Brojac: Integer;
        DimensionForPosReportNEW: Record "Dimension for report";
        PositionBenefitsReport: Record "Position Benefits report";
        Head: Record "Head Of's temporary";
        Head1: Record "Head Of's temporary";
        HeadChange: Record "Head Of's temporary";
        DepartmentTempForHead: Record "Department temporary";
        PositionBenefitsReport1: Record "Position Benefits report";
        ECLSystematization: Record "ECL systematization";
        ECLSystematization1: Record "ECL systematization";
        PositionMenuCheck: Record "Position Menu temporary";
        HeadCheck: Record "Head Of's temporary";
        DimensionForPosReportHead: Record "Dimension Pos for report";
        DepForCode: Record "Department temporary";
        //    UpDate: Page "Dimensions for report";
        SectorTemp1: Record "Sector temporary";
        NewOfficialTranslate: Text;
        OldTranslationSent: Text[250];
        DimensionTemp: Record "Dimension temp for position";
        BrojTroskovnihCentara: Integer;
        DepartmentTemporery: Record "Department temporary";

    procedure SetParam(OldCodeSent: Code[30]; OldDescriptionSent: Text[250]; OldGrade: Integer; OldRoles: Text; OldBJF: Option; OldControl: Boolean; OldKey: Boolean; OldManagmentLevel: Enum "Management Level"; RealorgShema: Code[10]; OldDepartmentCode: Code[50]; OldTranslation: Text[250])
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
        OldTranslationSent := OldTranslation;
        NewOfficialTranslate := OldTranslation;
    end;
}

