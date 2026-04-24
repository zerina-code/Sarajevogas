/*report 50122 "Department Temporary TEAM"
{
    Caption = 'Department change';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Department temporary")
        {

            trigger OnAfterGetRecord()
            begin


                IF Promjena = 1 THEN BEGIN // 1. then begin

                    FindLastCode.RESET;
                    FindLastCode.SETFILTER("Department Type", '%1', 9);
                    FindLastCode.SETFILTER("Team Description", '%1', OldDescription);
                    FindLastCode.SETFILTER("Team Code", '%1', OldCode);
                    IF FindLastCode.FINDFIRST THEN BEGIN
                        FilterCode := FindLastCode.Code;
                    END
                    ELSE BEGIN
                        FilterCode := '';
                    END;


                    SETFILTER("ORG Shema", '%1', "ORG Shema");
                    SETFILTER("Department Type", '%1', 9);
                    SETFILTER("Team Description", '%1', OldDescription);
                    SETFILTER("Team Code", '%1', OldCode);
                    SETFILTER(Code, '%1', FilterCode);


                    IF FIND('-') THEN BEGIN // 2. THEN BEGIN



                        String := NewCode;
                        FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;

                                IF Brojac = 2 THEN
                                    SectorFInd := i;
                            END;
                        END;
                        IF (OldDescription <> NewDescription) OR (NewCode <> OldCode) THEN BEGIN
                            Head.RESET;
                            //Head.SETFILTER("Department Code",'%1',OldCode);
                            Head.SETFILTER("Team Code", '%1', OldCode);
                            Head.SETFILTER("Team Description", '%1', OldDescription);

                            IF Head.FINDFIRST THEN BEGIN
                                IF Head."Team Code" = NewCode THEN BEGIN
                                    HeadExsist.RESET;
                                    IF HeadExsist.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                        HeadExsist.RENAME(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", NewDescription);
                                    END
                                    ELSE BEGIN
                                        Head.DELETE;
                                    END;
                                END;
                            END;
                        END;
                        DepartmentTempNewW.RESET;
                        DepartmentTempNewW.SETFILTER("Department Type", '%1', 9);
                        DepartmentTempNewW.SETFILTER("Team Description", '%1', OldDescription);
                        DepartmentTempNewW.SETFILTER("Team Code", '%1', OldCode);
                        IF DepartmentTempNewW.FINDFIRST THEN BEGIN
                            //IF DepartmentTempNewW.Description=DepartmentTempNewW."Team Description" THEN BEGIN

                            IF DepartmentTempNewW.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN BEGIN
                                DepartmentFindHighLevel.RESET;
                                DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                    OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                    OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                    DepartmentTempNewW.Sector := DepartmentFindHighLevel.Sector;
                                    DepartmentTempNewW."Sector  Description" := DepartmentFindHighLevel."Sector  Description";
                                    DepartmentTempNewW."Sector Identity" := DepartmentFindHighLevel."Sector Identity";
                                END;
                                DepartmentTempNewW.RENAME(NewCode, "ORG Shema", NewDescription, OdjelIznad, NewBelongs, NewDescription);
                                FindCodeForBelongs.RESET;
                                FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                    DepartmentTempNewW."Group Code" := FindCodeForBelongs.Code;

                                END;
                                DepartmentTempNewW."Department Category" := OdjelIznadCode;
                                DepartmentTempNewW."Department Group identity" := DepartmentFindHighLevel."Department Group identity";
                                DepartmentTempNewW.Sector := DepartmentFindHighLevel.Sector;
                                DepartmentTempNewW."Sector  Description" := DepartmentFindHighLevel."Sector  Description";
                                DepartmentTempNewW."Sector Identity" := DepartmentFindHighLevel."Sector Identity";
                                DepartmentTempNewW."Team Code" := NewCode;
                                DepartmentTempNewW."Residence/Network" := CentralaInsert;
                                DepartmentTempNewW.MODIFY;
                            END;
                        END;



                        DimensionForPos.RESET;
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);
                        //DimensionForPos.SETFILTER("Group Code",'%1',OldCode);
                        //DimensionForPos.SETFILTER("Group Description",'%1',OldDescription);
                        DimensionForPos.SETFILTER("Team Code", '%1', OldCode);
                        DimensionForPos.SETFILTER("Team Description", '%1', OldDescription);
                        //DimensionForPos.SETFILTER("Group Description",'%1',OldBelongs);
                        IF DimensionForPos.FINDSET THEN
                            REPEAT
                                FoundOne := FALSE;
                                StringPOs := DimensionForPos."Position Code";
                                FindZero := 0;
                                FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                    IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                        FindZero := i;
                                        FoundOne := TRUE;
                                    END;
                                    IF FindZero = 0 THEN
                                        FindZero := 9;
                                END;
                                LengthPosition := STRLEN(DimensionForPos."Position Code");
                                SecondPart1 := COPYSTR(DimensionForPos."Position Code", FindZero, LengthPosition);
                                NewPositionCode := COPYSTR(NewCode, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));

                                PositionMenu.RESET;
                                PositionMenu1.RESET;
                                PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                          THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos."Group Code")) <> DimensionForPos."Group Code" THEN BEGIN
                                                NewPositionCode := DimensionForPos."Position Code";
                                            END
                                            ELSE BEGIN
                                                NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                                DepartmentCheckResidence.RESET;
                                                DepartmentCheckResidence.SETFILTER("Team Description", '%1', DimensionForPos."Team Description");
                                                DepartmentCheckResidence.SETFILTER("Department Type", '%1', 9);
                                                IF DepartmentCheckResidence.FINDFIRST THEN BEGIN
                                                    IF DepartmentCheckResidence."Residence/Network" = DepartmentCheckResidence."Residence/Network"::Network THEN BEGIN
                                                        Sifra := NewCodeTeam;
                                                        Brojac := 0;
                                                        FOR i := 1 TO STRLEN(Sifra) DO BEGIN
                                                            IF Sifra[i] = '.' THEN BEGIN
                                                                Brojac := Brojac + 1;
                                                                IF Brojac = 4 THEN
                                                                    NaciTacke := i;
                                                            END;
                                                        END;
                                                        NewPositionCode := COPYSTR(NewCode, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));
                                                    END;
                                                END;
                                            END;
                                            DepartmentTempFind.RESET;
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                            DepartmentTempFind.SETFILTER("Team Code", '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Team Description", '%1', NewDescription);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DepartmnetPOs := DepartmentTempFind.Code;
                                            END;

                                            IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                            DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN
                                                DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                            DepartmentFindHighLevel.RESET;
                                            DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                            DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                            IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                                OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                                OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                                DimensionForPos1.Sector := DepartmentFindHighLevel.Sector;
                                                DimensionForPos1."Sector  Description" := DepartmentFindHighLevel."Sector  Description";
                                                DimensionForPos1."Department Categ.  Description" := OdjelIznad;
                                                DimensionForPos1."Department Category" := OdjelIznadCode;
                                            END;
                                            FindCodeForBelongs.RESET;
                                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                            IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                                DimensionForPos1."Group Code" := FindCodeForBelongs.Code;
                                                DimensionForPos1."Group Description" := NewBelongs;
                                            END;

                                            DimensionForPos1."Team Code" := NewCode;
                                            DimensionForPos1."Team Description" := NewDescription;
                                            DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            DimensionForPos1."Org Belongs" := NewDescription;
                                            DimensionForPos1.MODIFY;

                                            PositionBenefits.RESET;
                                            PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                            PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                            IF PositionBenefits.FINDSET THEN
                                                REPEAT
                                                    IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name") THEN
                                                        PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name")
               //Position Code,Code,Description,Position Name

               UNTIL PositionBenefits.NEXT = 0;
             

                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                ECLSystematization.SETFILTER(Team, '%1', "Team Code");
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                            DepartmentFindHighLevel.RESET;
                                                            DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                                            DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                                            IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                                                OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                                                OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                                                ECLSystematization1.Sector := DepartmentFindHighLevel.Sector;
                                                                ECLSystematization1."Sector Description" := DepartmentFindHighLevel."Sector  Description";
                                                                ECLSystematization1."Department Cat. Description" := OdjelIznad;
                                                                ECLSystematization1."Department Category" := OdjelIznadCode;
                                                                ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            END;
                                                            FindCodeForBelongs.RESET;
                                                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                                            IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                                                ECLSystematization1.Group := FindCodeForBelongs.Code;
                                                                ECLSystematization1."Group Description" := NewBelongs;
                                                            END;
                                                            ECLSystematization1.Team := NewCode;
                                                            ECLSystematization1."Team Description" := NewDescription;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END
                                            ELSE BEGIN

                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                ECLSystematization.SETFILTER(Team, '%1', "Team Code");
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                            DepartmentFindHighLevel.RESET;
                                                            DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                                            DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                                            IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                                                OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                                                OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                                                ECLSystematization1.Sector := DepartmentFindHighLevel.Sector;
                                                                ECLSystematization1."Sector Description" := DepartmentFindHighLevel."Sector  Description";
                                                                ECLSystematization1."Department Cat. Description" := OdjelIznad;
                                                                ECLSystematization1."Department Category" := OdjelIznadCode;
                                                            END;
                                                            FindCodeForBelongs.RESET;
                                                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                                            IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                                                ECLSystematization1.Group := FindCodeForBelongs.Code;
                                                                ECLSystematization1."Group Description" := NewBelongs;
                                                            END;
                                                            ECLSystematization1.Team := NewCode;
                                                            ECLSystematization1."Team Description" := NewDescription;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;




                                            IF DimensionForReport.COUNT = 1 THEN BEGIN


                                                // PositionMenu1.RENAME(NewPositionCode,PositionMenu.Description,DepartmnetPOs,"ORG Shema");
                                                // IF PositionMenu."Department Code"<>'' THEN BEGIN
                                                TempPosition.RESET;
                                                TempPosition.SETFILTER("Position Code", '%1', NewPositionCode);
                                                TempPosition.SETFILTER("Position Description", '%1', DimensionForPos."Position Description");
                                                TempPosition.SETFILTER("Dimension Value Code", '%1', DimensionForPos."Dimension Value Code");
                                                IF TempPosition.FINDFIRST THEN BEGIN
                                                    IF TempPosition."Org Belongs" <> '' THEN BEGIN
                                                        PositionMenu1.RENAME(NewPositionCode, PositionMenu.Description, DepartmnetPOs, "ORG Shema");
                                                    END
                                                    ELSE BEGIN
                                                        PositionMenu1.RENAME(NewPositionCode, PositionMenu.Description, '', "ORG Shema");
                                                    END;
                                                END;


                                            END
                                            ELSE BEGIN
                                                PositionMenu1.RENAME(NewPositionCode, PositionMenu.Description, '', "ORG Shema");
                                            END;
                                        END;
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;
                            UNTIL DimensionForPos.NEXT = 0;



                        TeamTempOrginal.RESET;
                        TeamTempOrginal.SETFILTER("Org Shema", '%1', "ORG Shema");
                        TeamTempOrginal.SETFILTER(Name, '%1', OldDescription);
                        TeamTempOrginal.SETFILTER(Code, '%1', OldCode);
                        IF TeamTempOrginal.FINDSET THEN BEGIN
                            IF TeamTempOrginal1.GET(OldCode, OldDescription, "ORG Shema", '') THEN
                                TeamTempOrginal1.RENAME(NewCode, NewDescription, "ORG Shema", '');
                            TeamTempOrginal1."Belongs to Group" := NewBelongs;
                            FindCodeForBelongs.RESET;
                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                            
                            FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                                IF String[i] = '.' THEN BEGIN
                                    Brojac := Brojac + 1;
                                    IF Brojac = 2 THEN
                                        SectorFInd := i;
                                END;
                            END;
                            SectorPronadji.RESET;

                            SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));

                            IF SectorPronadji.FINDFIRST THEN BEGIN
                                TeamTempOrginal1."Identity Sector" := SectorPronadji.Identity;
                                PosNew.RESET;
                                PosNew.SETFILTER(Code, '%1', PositionMenu.Code);
                                PosNew.SETFILTER(Description, '%1', PositionMenu.Description);
                                IF PosNew.FINDFIRST THEN BEGIN
                                    PosNew."Sector Identity" := SectorPronadji.Identity;
                                    PosNew.MODIFY;
                                END;
                            END;
                            TeamTempOrginal1.MODIFY;
                            TeamTempOrginal1.IsTrue := TRUE;
                            TeamTempOrginal1."Department Type" := 9;
                            TeamTempOrginal1."Official Translate of Team" := NewDescriptionDef;
                            TeamTempOrginal1."Residence/Network" := CentralaInsert;
                            TeamTempOrginal1."Fields for change" := UPPERCASE('***');
                            TeamTempOrginal1.MODIFY;

                        END;
                        DimesnionFind.RESET;
                        DimesnionFind.SETFILTER("Team Code", '%1', NewCode);
                        DimesnionFind.SETFILTER("Team Description", '%1', NewDescription);
                        DimesnionFind.SETFILTER("Department Type", '%1', 9);
                        DimesnionFind.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimesnionFind.FINDSET THEN
                            REPEAT
                                DimesnionFind.DELETE;
                            UNTIL DimesnionFind.NEXT = 0;
                        DimensionForReport.RESET;
                        DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                        IF DimensionForReport.FINDSET THEN
                            REPEAT
                                IF DimensionForReport1.GET(DimensionForReport.Code, DimensionForReport."Dimension Value Code", DimensionForReport."Team Description", DimensionForReport."Department Categ.  Description",
                                DimensionForReport."Group Description", DimensionForReport."Group Code", DimensionForReport."ORG Shema") THEN BEGIN

                                    //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema
                                    SectorPronadji.RESET;

                                    SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                    IF SectorPronadji.FINDFIRST THEN BEGIN
                                        SectorCode := SectorPronadji.Code;
                                        SectorDescription := SectorPronadji.Description;
                                    END;
                                    FindCodeForBelongs.RESET;
                                    FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                    IF FindCodeForBelongs.FINDFIRST THEN BEGIN

                                        FindHighLevel.RESET;
                                        FindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                        FindHighLevel.SETFILTER("Department Type", '%1', 2);
                                        IF FindHighLevel.FINDFIRST THEN BEGIN
                                            DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", NewDescription, FindHighLevel."Department Categ.  Description", NewBelongs, FindHighLevel.Code, RealOrgShema);
                                            IF DimensionForReport1.Sector <> FindHighLevel.Sector THEN
                                                DimensionForReport1.Sector := FindHighLevel.Sector;
                                            IF DimensionForReport1."Sector  Description" <> FindHighLevel."Sector  Description" THEN
                                                DimensionForReport1."Sector  Description" := FindHighLevel."Sector  Description";
                                            IF DimensionForReport1."Department Category" <> FindHighLevel."Department Category" THEN
                                                DimensionForReport1."Department Category" := FindHighLevel."Department Category";
                                            IF DimensionForReport1."Dimension Code" <> 'TC' THEN
                                                DimensionForReport1."Dimension Code" := 'TC';
                                            DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                            IF DimensionForReport1."Department Type" <> 9 THEN
                                                DimensionForReport1."Department Type" := 9;
                                            IF DimensionForReport1.Description <> NewDescription THEN
                                                DimensionForReport1.Description := NewDescription;
                                            IF DimensionForReport1."Team Code" <> NewCode THEN
                                                DimensionForReport1."Team Code" := NewCode;
                                            DimensionForReport1.MODIFY;
                                        END;
                                    END;
                                END;
                            UNTIL DimensionForReport.NEXT = 0;






















                        DimensionsTemporery.RESET;
                        DimensionsTemporery.SETFILTER("Department Type", '%1', 9);
                        DimensionsTemporery.SETFILTER("Team Code", '%1', OldCode);
                        DimensionsTemporery.SETFILTER("Team Description", '%1', OldDescription);
                        DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimensionsTemporery.FINDSET THEN
                            REPEAT
                                IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                 DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema") THEN BEGIN
                                    FindHighLevel.RESET;
                                    FindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                    FindHighLevel.SETFILTER("Department Type", '%1', 2);
                                    IF FindHighLevel.FINDFIRST THEN BEGIN
                                        DimensionsTemporery1.RENAME(NewCode, DimensionsTemporery."Dimension Value Code", NewDescription, FindHighLevel."Department Categ.  Description", NewBelongs, FindHighLevel.Code, "ORG Shema");
                                        //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema
                                        DimensionsTemporery1."Department Category" := FindHighLevel."Department Category";
                                        DimensionsTemporery1.Description := NewDescription;
                                        DimensionsTemporery1.Sector := FindHighLevel.Sector;
                                        DimensionsTemporery1."Sector  Description" := FindHighLevel."Sector  Description";
                                        DimensionsTemporery1.Belongs := FORMAT(NewCode) + '-' + NewDescription;
                                        DimensionsTemporery1."Team Code" := NewCode;
                                        DimensionsTemporery1.MODIFY;
                                    END;
                                END;

                            UNTIL DimensionsTemporery.NEXT = 0;

                        DimensionForPos.RESET;
                        DimensionForPos.SETFILTER("Team Code", '%1', NewCode);
                        DimensionForPos.SETFILTER("Team Description", '%1', NewDescription);
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);

                        IF DimensionForPos.FINDSET THEN
                            REPEAT
                                FoundOne := FALSE;
                                StringPOs := DimensionForPos."Position Code";
                                FindZero := 0;
                                FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                    IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                        FindZero := i;
                                        FoundOne := TRUE;
                                    END;
                                    IF FindZero = 0 THEN
                                        FindZero := 9;
                                END;
                                LengthPosition := STRLEN(DimensionForPos."Position Code");
                                SecondPart1 := COPYSTR(DimensionForPos."Position Code", FindZero, LengthPosition);
                                NewPositionCode := COPYSTR(NewCode, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));

                                PositionMenu.RESET;
                                PositionMenu1.RESET;
                                PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                          THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos."Group Code")) <> DimensionForPos."Group Code" THEN BEGIN
                                                NewPositionCode := DimensionForPos."Position Code";
                                            END
                                            ELSE BEGIN
                                                NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                                DepartmentCheckResidence.RESET;
                                                DepartmentCheckResidence.SETFILTER("Team Description", '%1', DimensionForPos."Team Description");
                                                DepartmentCheckResidence.SETFILTER("Department Type", '%1', 9);
                                                IF DepartmentCheckResidence.FINDFIRST THEN BEGIN
                                                    IF DepartmentCheckResidence."Residence/Network" = DepartmentCheckResidence."Residence/Network"::Network THEN BEGIN
                                                        Sifra := NewCode;
                                                        Brojac := 0;
                                                        FOR i := 1 TO STRLEN(Sifra) DO BEGIN
                                                            IF Sifra[i] = '.' THEN BEGIN
                                                                Brojac := Brojac + 1;
                                                                IF Brojac = 4 THEN
                                                                    NaciTacke := i;
                                                            END;
                                                        END;
                                                        NewPositionCode := COPYSTR(NewCode, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));
                                                    END;
                                                END;
                                            END;

                                            DepartmentTempFind.RESET;
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                            DepartmentTempFind.SETFILTER("Team Code", '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Team Description", '%1', NewDescription);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DepartmnetPOs := DepartmentTempFind.Code;
                                            END;






                                            IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                            DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN
                                                DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                            FindHighLevel.RESET;
                                            FindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                            FindHighLevel.SETFILTER("Department Type", '%1', 2);
                                            IF FindHighLevel.FINDFIRST THEN BEGIN
                                                DimensionForPos1."Department Category" := FindHighLevel."Department Category";
                                                DimensionForPos1."Department Categ.  Description" := FindHighLevel."Department Categ.  Description";
                                                DimensionForPos1.Sector := FindHighLevel.Sector;
                                                DimensionForPos1."Sector  Description" := FindHighLevel."Sector  Description";
                                                DimensionForPos1."Group Code" := FindCodeForBelongs.Code;
                                                DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                                DimensionForPos1."Org Belongs" := NewDescription;
                                            END;
                                            DimensionForPos1.MODIFY;

                                            PositionBenefits.RESET;
                                            PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                            PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                            IF PositionBenefits.FINDSET THEN
                                                REPEAT
                                                    IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name") THEN
                                                        PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name")
               //Position Code,Code,Description,Position Name

               UNTIL PositionBenefits.NEXT = 0;
                                            
                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                ECLSystematization.SETFILTER(Team, '%1', "Team Code");
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                            DepartmentFindHighLevel.RESET;
                                                            DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                                            DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                                            IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                                                OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                                                OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                                                ECLSystematization1.Sector := DepartmentFindHighLevel.Sector;
                                                                ECLSystematization1."Sector Description" := DepartmentFindHighLevel."Sector  Description";
                                                                ECLSystematization1."Department Cat. Description" := OdjelIznad;
                                                                ECLSystematization1."Department Category" := OdjelIznadCode;
                                                            END;
                                                            FindCodeForBelongs.RESET;
                                                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                                            IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                                                ECLSystematization1.Group := FindCodeForBelongs.Code;
                                                                ECLSystematization1."Group Description" := NewBelongs;
                                                            END;
                                                            ECLSystematization1.Team := NewCode;
                                                            ECLSystematization1."Team Description" := NewDescription;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END
                                            ELSE BEGIN

                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                ECLSystematization.SETFILTER(Team, '%1', "Team Code");
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                            DepartmentFindHighLevel.RESET;
                                                            DepartmentFindHighLevel.SETFILTER("Group Description", '%1', NewBelongs);
                                                            DepartmentFindHighLevel.SETFILTER("Department Type", '%1', 2);
                                                            IF DepartmentFindHighLevel.FINDFIRST THEN BEGIN
                                                                OdjelIznad := DepartmentFindHighLevel."Department Categ.  Description";
                                                                OdjelIznadCode := DepartmentFindHighLevel."Department Category";
                                                                ECLSystematization1.Sector := DepartmentFindHighLevel.Sector;
                                                                ECLSystematization1."Sector Description" := DepartmentFindHighLevel."Sector  Description";
                                                                ECLSystematization1."Department Cat. Description" := OdjelIznad;
                                                                ECLSystematization1."Department Category" := OdjelIznadCode;
                                                            END;
                                                            FindCodeForBelongs.RESET;
                                                            FindCodeForBelongs.SETFILTER(Description, '%1', NewBelongs);
                                                            IF FindCodeForBelongs.FINDFIRST THEN BEGIN
                                                                ECLSystematization1.Group := FindCodeForBelongs.Code;
                                                                ECLSystematization1."Group Description" := NewBelongs;
                                                            END;
                                                            ECLSystematization1.Team := NewCode;
                                                            ECLSystematization1."Team Description" := NewDescription;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;

                                            IF PositionMenu."Department Code" <> '' THEN BEGIN

                                                PositionMenu1.RENAME(NewPositionCode, PositionMenu.Description, DepartmnetPOs, "ORG Shema");
                                            END
                                            ELSE BEGIN
                                                PositionMenu1.RENAME(NewPositionCode, PositionMenu.Description, '', "ORG Shema");
                                            END;

                                        END;
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;
                            UNTIL DimensionForPos.NEXT = 0;

                    END;
                    DimensionsForPositionTC.RESET;
                    //DimensionsForPositionTC.SETFILTER(Sector,'%1',SectorCode);
                    //DimensionsForPositionTC.SETFILTER("Sector  Description",'%1',NewDescription);

                    DimensionsForPositionTC.SETFILTER("Team Code", '%1', NewCode);
                    DimensionsForPositionTC.SETFILTER("Team Description", '%1', NewDescription);
                    IF DimensionsForPositionTC.FINDSET THEN
                        REPEAT
                            // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                            IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema",
                              DimensionsForPositionTC."Position Description", DimensionsForPositionTC."Org Belongs") THEN BEGIN
                                IF DimensionForReport.COUNT = 1 THEN BEGIN
                                    DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", DimensionForReport."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description", NewDescription);
                                    DimensionsForPositionTC1."Dimension  Name" := DimensionForReport."Dimension  Name";
                                END;
                            END;
                        UNTIL DimensionsForPositionTC.NEXT = 0;
                    ECLSystematization.RESET;

                    ECLSystematization.SETFILTER(Team, '%1', NewCode);
                    ECLSystematization.SETFILTER("Team Description", '%1', NewDescription);
                    IF ECLSystematization.FINDSET THEN
                        REPEAT
                            DimensionForPos.RESET;
                            DimensionForPos.SETFILTER("Position Code", '%1', ECLSystematization."Position Code");
                            DimensionForPos.SETFILTER("Position Description", '%1', ECLSystematization."Position Description");
                            DimensionForPos.SETFILTER(Sector, '%1', ECLSystematization.Sector);
                            DimensionForPos.SETFILTER("Sector  Description", '%1', ECLSystematization."Sector Description");
                            DimensionForPos.SETFILTER("Department Category", '%1', ECLSystematization."Department Category");
                            DimensionForPos.SETFILTER("Department Categ.  Description", '%1', ECLSystematization."Department Cat. Description");
                            DimensionForPos.SETFILTER("Group Code", '%1', ECLSystematization.Group);
                            DimensionForPos.SETFILTER("Group Description", '%1', ECLSystematization."Group Description");
                            DimensionForPos.SETFILTER("Team Code", '%1', ECLSystematization.Team);
                            DimensionForPos.SETFILTER("Team Description", '%1', ECLSystematization."Team Description");
                            IF DimensionForPos.FINDFIRST THEN BEGIN
                                ECLSystematization."Dimension Value Code" := DimensionForPos."Dimension Value Code";
                                ECLSystematization."Dimension  Name" := DimensionForPos."Dimension  Name";
                                ECLSystematization.MODIFY;
                            END
                            ELSE BEGIN
                                ECLSystematization."Dimension Value Code" := '';
                                ECLSystematization."Dimension  Name" := '';
                                ECLSystematization.MODIFY;
                            END;
                        UNTIL ECLSystematization.NEXT = 0;
                END;

                DimensionForReport.RESET;
                DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                IF DimensionForReport.FINDSET THEN
                    REPEAT
                        DimesnionFind.RESET;
                        DimesnionFind.INIT;
                        DimesnionFind.TRANSFERFIELDS(DimensionForReport);
                        DimesnionFind.INSERT;
                    UNTIL DimensionForReport.NEXT = 0;
                SectorFindForUpdate.RESET;
                SectorFindForUpdate.SETFILTER(Code, '%1', NewCode);
                SectorFindForUpdate.SETFILTER(Name, '%1', NewDescription);
                IF SectorFindForUpdate.FINDFIRST THEN BEGIN
                    IF DimensionForReport.COUNT = 1 THEN BEGIN
                        SectorFindForUpdate."Name of TC" := DimensionForReport."Dimension Value Code" + '-' + DimensionForReport."Dimension  Name";
                        SectorFindForUpdate.MODIFY;
                    END;
                    IF DimensionForReport.COUNT > 1 THEN BEGIN
                        SectorFindForUpdate."Name of TC" := '';
                        SectorFindForUpdate.MODIFY;
                    END;
                END;

                IF Promjena = 2 THEN BEGIN

 
                END;


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
                    field(NewBelongs; NewBelongs)
                    {
                        ApplicationArea = all;
                        Caption = 'New Belongs ';
                        TableRelation = "Group temporary".Description;
                    }
                    field(CentralaInsert; CentralaInsert)
                    {
                        ApplicationArea = all;
                        Caption = 'Residence/Network';
                    }
                    field(OldCode; OldCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Old code';
                        TableRelation = "Team temporary".Code;
                        Visible = false;
                    }
                    field(OldDescription; OldDescription)
                    {
                        ApplicationArea = all;
                        Caption = 'Old Description';
                        Visible = false;
                    }
                    field(OldCentrala; OldCentrala)
                    {
                        ApplicationArea = all;
                        Caption = 'Old residence/network';
                        Visible = false;
                    }
                    field(OldBelongs; OldBelongs)
                    {
                        ApplicationArea = all;
                        Visible = false;
                    }
                    part(dfr; "Dimensions for report")

                    {
                        ApplicationArea = All;
                        SubPageLink = "Department Type" = FILTER('Team');
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


    end;

    var
        posC: Record "Position";
        OrgC: Code[30];
        DescriptionC: Text;
        IDC: Code[30];
        CCode: Code[20];
        OCode: Code[20];
        EmployeeContractLedger: Record "Employee Contract Ledger";
        OldDescription: Text;
        PositionC: Record "Position";
        OldCode: Code[30];
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
        DepCatw: Record "Department Category temporary";
        SectorTest: Record "Sector temporary";
        SectorTestCode: Text;
        SectorTest1: Record "Sector temporary";
        DepCatw1: Record "Department Category temporary";
        SectorBackPosition: Integer;
        SectorBackCode: Text;
        CentralaInsert: Option " ",Centrala,"Mreža";
        OldCentrala: Option ,Centrala,"Mreža";
        CheckNewCode: Integer;
        Promjena: Integer;
        NewDescription: Text;
        StringNew: Text;
        DepCategorytemp: Record "Department Category temporary";
        DepCategorytemp1: Record "Department Category temporary";
        Text000: Label 'It''s wrong code';
        SectorPronadji: Record "Sector temporary";
        SectorFInd: Integer;
        Text001: Label 'This sector doesn''t exsist';
        CheckPoint: Text;
        TheSame: Integer;
        NewCodeOrginal: Text;
        FindLastCode: Record "Department temporary";
        FilterCode: Code[30];
        DepartmentTempNewW: Record "Department temporary";
        TheLastCharacter: Integer;
        PositionChangeAlready: Record "Position temporery";
        DepartmentTempNewW1: Record "Department temporary";
        DepCatFind: Integer;
        OdjelPronadji: Record "Department Category temporary";
        DepTeamtemp: Record "Group temporary";
        DepTeamtemp1: Record "Group temporary";
        FindHighLevel: Record "Department temporary";
        ChangeGroupOrginal: Record "Team temporary";
        ChangeGroupOrginal1: Record "Team temporary";
        DepartmentOrginalTempFind: Record "Department temporary";
        OldBelongs: Text;
        NewBelongs: Text;
        DepartmentFindHighLevel: Record "Department temporary";
        OdjelIznad: Text;
        OdjelIznadCode: Code[30];
        FindCodeForBelongs: Record "Group temporary";
        DimensionsTemporery: Record "Dimension temporary";
        DimensionsTemporery1: Record "Dimension temporary";
        TeamTempOrginal: Record "Team temporary";
        TeamTempOrginal1: Record "Team temporary";
        GroupCodeForDImensions: Code[30];
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
        DimesnionFind: Record "Dimension temporary";
        DimensionForReport: Record "Dimension for report";
        DimensionForReport1: Record "Dimension for report";
        PositionMenu1: Record "Position Menu temporary";
        DepartmnetPOs: Code[50];
        SectorCode: Code[50];
        SectorDescription: Text;
        RealOrgShema: Code[10];
        SectorFindForUpdate: Record "Team temporary";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        DimensionsForPositionTC: Record "Dimension temp for position";
        PositionBenefits: Record "Position Benefits temporery";
        PositionBenefits1: Record "Position Benefits temporery";
        Head: Record "Head Of's temporary";
        Head1: Record "Head Of's temporary";
        HeadChange: Record "Head Of's temporary";
        ECLSystematization: Record "ECL systematization";
        ECLSystematization1: Record "ECL systematization";
        SectorDuplicate: Record "Team temporary";
        DepartmentDuplicate: Record "Department temporary";
        HeadExsist: Record "Head Of's temporary";
        DepartmentCheckResidence: Record "Department temporary";
        NaciTacke: Integer;
        Sifra: Code[50];
        PosNew: Record "Position Menu temporary";
        TempPosition: Record "Dimension temp for position";

    procedure SetParam(OldCodeSent: Code[30]; OldNameSent: Text; Centrala: Option; PromjenaInsert: Integer; OldBelongsSent: Text; OrgS: Code[10])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        OldBelongs := OldBelongsSent;
        TeamTemp.RESET;
        TeamTemp.SETFILTER(Code, '%1', OldCodeSent);
        TeamTemp.SETFILTER(Name, '%1', OldNameSent);
        TeamTemp.SETFILTER("Org Shema", '%1', OrgS);
        IF TeamTemp.FINDFIRST THEN
            NewDescriptionDef := TeamTemp."Official Translate of Team"
        ELSE
            NewDescriptionDef := '';
        NewCode := OldCode;
        NewDescription := OldNameSent;
        CentralaInsert := Centrala;
        Promjena := PromjenaInsert;
        NewBelongs := OldBelongs;
        RealOrgShema := OrgS;
    end;
}

*/