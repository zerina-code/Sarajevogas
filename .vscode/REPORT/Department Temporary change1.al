/*report 50120 "Department Temporary change1"
{
    Caption = 'Department Temporary change';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Department temporary")
        {

            trigger OnAfterGetRecord()
            begin


                IF Promjena = 1 THEN BEGIN
                    SETFILTER("ORG Shema", '%1', "ORG Shema");
                    SETFILTER("Department Category", '%1', OldCode);
                    SETFILTER("Department Categ.  Description", '%1', OldDescription);
                    SETFILTER(Code, '<>%1', OldCode);
                    SETFILTER("Department Type", '<>%1', 4);
                    IF FIND('-') THEN
                        REPEAT

                            String := FORMAT(Code);
                            LengthString := STRLEN(String);
                            IF "Department Type".AsInteger() = 2 THEN BEGIN //ako je grupa         1. THEN BEGIN
                                SecondPartGroup := COPYSTR(Code, STRLEN(OldCode) + 1, LengthString); //npr A.6.1.1. aa kod je meni je kod grupa, treba da mi OldCode kolika je dužina npr A.6.1. da kopira od dužine odjela
                                Brojac := 0;        //ako je tim a.6.1.1.1. treba da mi kopira od stare dužine odjela tj. A.6.1. DO KRAJA
                                FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                                    IF String[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 2 THEN
                                            SectorFInd := i;
                                    END;
                                END;
                                NewCodeGroup := NewCode + SecondPartGroup; //nova grupa u tom slučaju obzirom da ne uzima taj zadnji broj
                                IF STRLEN(NewCodeGroup) <> STRLEN(String) THEN
                                    NewCodeGroup := COPYSTR(NewCodeGroup, 1, STRLEN(String));
                                DepartmentTempNew.RESET;
                                DepartmentTempNew.SETFILTER("Department Type", '%1', 2);  //AKO JE GRUPA NIVO ISPOD ODABRANOG ODJELA
                                DepartmentTempNew.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                DepartmentTempNew.SETFILTER("Department Category", '%1', OldCode);
                                IF DepartmentTempNew.FINDFIRST THEN BEGIN
                                    IF DepartmentTempNew1.GET(DepartmentTempNew.Code, DepartmentTempNew."ORG Shema", DepartmentTempNew."Team Description",
                                      DepartmentTempNew."Department Categ.  Description", DepartmentTempNew."Group Description", DepartmentTempNew.Description) THEN
                                        DepartmentTempNew1.RENAME(NewCodeGroup, DepartmentTempNew."ORG Shema", DepartmentTempNew."Team Description", NewDescription, DepartmentTempNew."Group Description", DepartmentTempNew.Description);
                                    //TREBA DA IMA NOVU ŠIFRU GRUPE NPR AKO D.2.5.1 TO JE D.2.5.1.1. A AKO JE A.6.1. ODJEL ISPOD A.6.1.1. PRELAZU U A.2.1.1. ONDA TREBA DA NOVA GRUPA BUDE A.2.1.1.
                                    SectorPronadji.RESET;
                                    SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                    IF SectorPronadji.FINDFIRST THEN BEGIN
                                        DepartmentTempNew1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                        DepartmentTempNew1."Sector  Description" := SectorPronadji.Description;
                                        DepartmentTempNew1."Sector Identity" := SectorPronadji.Identity;
                                    END;
                                    DepartmentTempNew1."Department Categ.  Description" := NewDescription; //MIJENJA ODJEL
                                    DepartmentTempNew1."Department Category" := NewCode;
                                    DepartmentTempNew1."Group Code" := NewCodeGroup;
                                    IF CentralaInsert = CentralaInsert::"Mreža" THEN //PROMJENA DA LI JE MREŽA AKO JE MEŽA ISPOD SVI SU MREŽA
                                        DepartmentTempNew1."Residence/Network" := 2;
                                    DepartmentTempNew1.MODIFY;
                                END;
                               //IZMJENA TROŠKOVA
                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 2);
                                DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                DimensionsTemporery.SETFILTER("Department Category", '%1', OldCode);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                DimensionsTemporery.SETFILTER(Code, '%1', Code);
                                DimensionsTemporery.SETFILTER(Description, '%1', Description);
                                IF DimensionsTemporery.FINDSET THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                        DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", "ORG Shema") THEN
                                            DimensionsTemporery1.RENAME(NewCodeGroup, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", NewDescription, DimensionsTemporery."Group Description", NewCodeGroup, "ORG Shema");
                                        SectorPronadji.RESET;
                                        //stala
                                        SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                        IF SectorPronadji.FINDFIRST THEN BEGIN
                                            DimensionsTemporery1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                            DimensionsTemporery1."Sector  Description" := SectorPronadji.Description;

                                        END;
                                        DimensionsTemporery1."Department Category" := NewCode;
                                        DimensionsTemporery1.MODIFY;

                                    UNTIL DimensionsTemporery.NEXT = 0;
                                //zatvori grupu


                                //izmjena POZICIJA ZA GRUPU
                                DimensionForPos.RESET;
                                DimensionForPos.SETFILTER("Department Category", '%1', OldCode);
                                DimensionForPos.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                DimensionForPos.SETFILTER("Team Code", '%1', '');
                                DimensionForPos.SETFILTER("Team Description", '%1', '');
                                DimensionForPos.SETFILTER("Group Description", '%1', "Group Description");
                                DimensionForPos.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF DimensionForPos.FINDSET THEN
                                    REPEAT
                                        FindZero := 0;
                                        FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                            StringPOs := DimensionForPos."Position Code";
                                            IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                                FindZero := i;
                                                FoundOne := TRUE;
                                            END;
                                        END;
                                        IF FindZero = 0 THEN
                                            FindZero := 7;


                                        NewPositionCode := COPYSTR(NewCodeGroup, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        PositionMenu.RESET;
                                        PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                        IF PositionMenu.FINDSET THEN
                                            REPEAT
                                                IF PositionMenuNew.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", "ORG Shema")
                                                  THEN BEGIN
                                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                        NewPositionCode := DimensionForPos."Position Code";
                                                    END
                                                    ELSE BEGIN
                                                        NewPositionCode := COPYSTR(NewCodeGroup, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                                        DepartmentCheckResidence.RESET;
                                                        DepartmentCheckResidence.SETFILTER("Group Description", '%1', DimensionForPos."Group Description");
                                                        DepartmentCheckResidence.SETFILTER("Department Type", '%1', 2);
                                                        IF DepartmentCheckResidence.FINDFIRST THEN BEGIN
                                                            IF DepartmentCheckResidence."Residence/Network" = DepartmentCheckResidence."Residence/Network"::Network THEN BEGIN
                                                                Sifra := NewCodeGroup;
                                                                Brojac := 0;
                                                                FOR i := 1 TO STRLEN(Sifra) DO BEGIN
                                                                    IF Sifra[i] = '.' THEN BEGIN
                                                                        Brojac := Brojac + 1;
                                                                        IF Brojac = 3 THEN
                                                                            NaciTacke := i;
                                                                    END;
                                                                END;
                                                                NewPositionCode := COPYSTR(NewCodeGroup, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));

                                                            END;
                                                        END;
                                                    END;
                                                    DepartmentTempFind.RESET;
                                                    DepartmentTempFind.SETFILTER("Department Type", '%1', 2);
                                                    DepartmentTempFind.SETFILTER("Group Code", '%1', NewCodeGroup);
                                                    IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                        DepartmentCode := DepartmentTempFind.Code;
                                                    END
                                                    ELSE BEGIN
                                                        DepartmentCode := '';
                                                    END;
                                                    PositionBenefits.RESET;
                                                    PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                    PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                                    IF PositionBenefits.FINDSET THEN
                                                        REPEAT
                                                            IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", PositionBenefits."Org. Structure") THEN
                                                                PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", RealOrgShema)
                       //Position Code,Code,Description,Position Name

                       UNTIL PositionBenefits.NEXT = 0;

                                                    IF OldDescription <> NewDescription THEN BEGIN
                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER("Department Category", '%1', OldCode);
                                                        ECLSystematization.SETFILTER("Department Cat. Description", '%1', OldDescription);
                                                        ECLSystematization.SETFILTER(Group, '%1', "Group Code");
                                                        ECLSystematization.SETFILTER("Group Description", '%1', "Group Description");
                                                        ECLSystematization.SETFILTER(Team, '%1', '');
                                                        ECLSystematization.SETFILTER("Team Description", '%1', '');
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                                    ECLSystematization1."Department Category" := NewCode;
                                                                    ECLSystematization1.Group := NewCodeGroup;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1."Department Code" := NewCodeGroup;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;
                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END
                                                    ELSE BEGIN

                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER("Department Category", '%1', OldCode);
                                                        ECLSystematization.SETFILTER("Department Cat. Description", '%1', OldDescription);
                                                        ECLSystematization.SETFILTER(Group, '%1', "Group Code");
                                                        ECLSystematization.SETFILTER("Group Description", '%1', "Group Description");
                                                        ECLSystematization.SETFILTER(Team, '%1', '');
                                                        ECLSystematization.SETFILTER("Team Description", '%1', '');
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                                    ECLSystematization1."Department Category" := NewCode;
                                                                    ECLSystematization1.Group := NewCodeGroup;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1."Department Code" := NewCodeGroup;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;

                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END;
                                                    //AKO JE GRUPA
                                                    Head.RESET;
                                                    Head.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                                    Head.SETFILTER("Group Description", '%1', "Group Description");
                                                    Head.SETFILTER("Team Code", '%1', '');
                                                    Head.SETFILTER("Team Description", '%1', '');
                                                    IF Head.FINDFIRST THEN BEGIN
                                                        IF OldDescription = NewDescription THEN BEGIN
                                                            Head1.RESET;
                                                            Head1.SETFILTER(Sector, '%1', Head.Sector);
                                                            Head1.SETFILTER("Sector  Description", '%1', Head."Sector  Description");
                                                            Head1.SETFILTER("Department Category", '%1', Head."Department Category");
                                                            Head1.SETFILTER("Department Categ.  Description", '%1', Head."Department Categ.  Description");
                                                            Head1.SETFILTER("Group Code", '%1', Head."Group Code");
                                                            Head1.SETFILTER("Group Description", '%1', Head."Group Description");
                                                            Head1.SETFILTER("Team Code", '%1', Head."Team Code");
                                                            Head1.SETFILTER("Team Description", '%1', Head."Team Description");
                                                            IF Head1.FINDFIRST THEN BEGIN
                                                                Head1."Department Category" := NewCode;
                                                                Head1."Group Code" := NewCodeGroup;
                                                                Head1.MODIFY;
                                                            END;
                                                        END;

                                                        IF OldCode = NewCode THEN BEGIN
                                                            IF Head1.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                Head1.RENAME(Head."Department Code", Head."ORG Shema", NewDescription, Head."Group Description", Head."Team Description");
                                                                Head1."Department Category" := NewCode;
                                                            END;
                                                        END;
                                                       
                                                    END;
                                                    IF PositionMenuNew.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", "ORG Shema")
                                                       THEN BEGIN
                                                        IF PositionMenu."Department Code" <> '' THEN BEGIN

                                                            PositionMenuNew.RENAME(NewPositionCode, PositionMenu.Description, NewCodeGroup, "ORG Shema");
                                                        END
                                                        ELSE BEGIN
                                                            PositionMenuNew.RENAME(NewPositionCode, PositionMenu.Description, '', "ORG Shema");
                                                        END;
                                                        PosNew.RESET;
                                                        PosNew.SETFILTER(Code, '%1', PositionMenu.Code);
                                                        PosNew.SETFILTER(Description, '%1', PositionMenu.Description);
                                                        IF PosNew.FINDFIRST THEN BEGIN
                                                            PosNew."Sector Identity" := SectorPronadji.Identity;
                                                            PosNew.MODIFY;
                                                        END;


                                                    END;
                                                END;
                                            UNTIL PositionMenu.NEXT = 0;
                                        IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", "ORG Shema",
                                        DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                DimensionForPos1.Belongs := DimensionForPos."Position Code" + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            END
                                            ELSE BEGIN
                                                DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                                DimensionForPos."Position Description", DimensionForPos."Org Belongs");
                                                DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";

                                            END;
                                            SectorPronadji.RESET;
                                            //stala
                                            SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                            IF SectorPronadji.FINDFIRST THEN BEGIN
                                                DimensionForPos1.Sector := SectorPronadji.Code;
                                                DimensionForPos1."Sector  Description" := SectorPronadji.Description;
                                                DimensionForPos1."Sector Identity" := SectorPronadji.Identity;
                                            END;
                                            DimensionForPos1."Department Category" := NewCode;
                                            DimensionForPos1."Department Categ.  Description" := NewDescription;
                                            DimensionForPos1."Group Code" := NewCodeGroup;
                                            DimensionForPos1.MODIFY;
                                            FoundOne := FALSE;
                                        END;

                                    UNTIL DimensionForPos.NEXT = 0;
                            END;



                            IF "Department Type".AsInteger() = 9 THEN BEGIN //ako je TEAM       1. THEN BEGIN
                                LengthString := STRLEN(Code);
                                SecondPartTeam := COPYSTR(Code, STRLEN(OldCode) + 1, LengthString);

                                NewCodeTeam := NewCode + SecondPartTeam; //nova grupa u tom slučaju obzirom da ne uzima taj zadnji broj
                                IF STRLEN(NewCodeTeam) <> STRLEN(String) THEN
                                    NewCodeTeam := COPYSTR(NewCodeTeam, 1, STRLEN(String));
                                DepartmentTempNew.RESET;
                                DepartmentTempNew.SETFILTER("Department Type", '%1', 9);  //AKO JE GRUPA NIVO ISPOD ODABRANOG ODJELA
                                DepartmentTempNew.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                DepartmentTempNew.SETFILTER("Department Category", '%1', OldCode);
                                IF DepartmentTempNew.FINDFIRST THEN BEGIN
                                    IF DepartmentTempNew1.GET(DepartmentTempNew.Code, DepartmentTempNew."ORG Shema", DepartmentTempNew."Team Description",
                                      DepartmentTempNew."Department Categ.  Description", DepartmentTempNew."Group Description", DepartmentTempNew.Description) THEN
                                        DepartmentTempNew1.RENAME(NewCodeTeam, DepartmentTempNew."ORG Shema", DepartmentTempNew."Team Description", NewDescription, DepartmentTempNew."Group Description", DepartmentTempNew.Description);
                                    SectorPronadji.RESET;
                                    SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                    IF SectorPronadji.FINDFIRST THEN BEGIN
                                        DepartmentTempNew1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                        DepartmentTempNew1."Sector  Description" := SectorPronadji.Description;
                                        DepartmentTempNew1."Sector Identity" := SectorPronadji.Identity;
                                    END;
                                    DepartmentTempNew1."Department Categ.  Description" := NewDescription; //MIJENJA ODJEL
                                    DepartmentTempNew1."Department Category" := NewCode;
                                    DepartmentTempNew1."Team Code" := NewCodeTeam;
                                    IF CentralaInsert = CentralaInsert::"Mreža" THEN //PROMJENA DA LI JE MREŽA AKO JE MEŽA ISPOD SVI SU MREŽA
                                        DepartmentTempNew1."Residence/Network" := 2;
                                    DepartmentTempNew1.MODIFY;
                                END;

                                //IZMJENA TROŠKOVA
                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 9);
                                DimensionsTemporery.SETFILTER("Department Category", '%1', OldCode);
                                DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                DimensionsTemporery.SETFILTER(Code, '%1', Code);
                                DimensionsTemporery.SETFILTER(Description, '%1', Description);
                                IF DimensionsTemporery.FINDFIRST THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                        DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema") THEN BEGIN
                                            DepartmentNewFind.RESET;
                                            DepartmentNewFind.SETFILTER("Team Code", '%1', NewCodeTeam);
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DimensionsTemporery1.RENAME(NewCodeTeam, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description",
                                                NewDescription, DimensionsTemporery."Group Description", DepartmentTempFind."Group Code", DimensionsTemporery."ORG Shema");
                                            END;
                                        END;
                                        SectorPronadji.RESET;
                                        //stala
                                        SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                        IF SectorPronadji.FINDFIRST THEN BEGIN
                                            DimensionsTemporery1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                            DimensionsTemporery1."Sector  Description" := SectorPronadji.Description;

                                        END;
                                        DimensionsTemporery1."Department Category" := NewCode;
                                        DimensionsTemporery1."Team Code" := NewCodeTeam;
                                    UNTIL DimensionsTemporery.NEXT = 0;
                                //zatvori tim


                                DimensionForPos.RESET;
                                DimensionForPos.SETFILTER("Department Category", '%1', OldCode);
                                DimensionForPos.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                //DimensionForPos.SETFILTER("Team Code",'<>%1','');
                                DimensionForPos.SETFILTER("Team Description", '%1', "Team Description");
                                // DimensionForPos.SETFILTER("Group Code",'<>%1','');
                                //  DimensionForPos.SETFILTER("Group Description",'<>%1','');
                                DimensionForPos.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF DimensionForPos.FINDSET THEN
                                    REPEAT
                                        FindZero := 0;
                                        FoundOne := FALSE;
                                        FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                            StringPOs := DimensionForPos."Position Code";
                                            IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                                FindZero := i;
                                                FoundOne := TRUE;
                                            END;
                                        END;
                                        IF FindZero = 0 THEN
                                            FindZero := 11;
                                        LengthPosition := STRLEN(DimensionForPos."Position Code");
                                        NewPositionCode := COPYSTR(NewCodeTeam, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        PositionMenu.RESET;
                                        //PositionMenu.SETFILTER(Code,'%1',DimensionForPos."Position Code");
                                        PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                        IF PositionMenu.FINDSET THEN
                                            REPEAT
                                                IF PositionMenu.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                                  THEN BEGIN
                                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) < DimensionForPos.Sector THEN BEGIN
                                                        NewPositionCode := DimensionForPos."Position Code";
                                                    END
                                                    ELSE BEGIN
                                                        NewPositionCode := COPYSTR(NewCodeTeam, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
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
                                                                        IF Brojac = 3 THEN
                                                                            NaciTacke := i;
                                                                    END;
                                                                END;
                                                                NewPositionCode := COPYSTR(NewCodeTeam, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));

                                                            END;
                                                        END;
                                                    END;
                                                    DepartmentTempFind.RESET;
                                                    DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                                    DepartmentTempFind.SETFILTER("Team Code", '%1', NewCodeTeam);
                                                    IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                        DepartmentCode := DepartmentTempFind.Code;
                                                    END
                                                    ELSE BEGIN
                                                        DepartmentCode := '';
                                                    END;
                                                    PositionBenefits.RESET;
                                                    PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                    PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                                    IF PositionBenefits.FINDSET THEN
                                                        REPEAT
                                                            IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", PositionBenefits."Org. Structure") THEN
                                                                PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", RealOrgShema)
                       //Position Code,Code,Description,Position Name

                       UNTIL PositionBenefits.NEXT = 0;

                                                    IF OldDescription <> NewDescription THEN BEGIN
                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER("Department Cat. Description", '%1', OldDescription);
                                                        ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                                    ECLSystematization1.Sector := SectorPronadji.Code;
                                                                    ECLSystematization1.Team := NewCodeTeam;
                                                                    ECLSystematization1."Department Category" := NewCode;
                                                                    ECLSystematization1."Department Cat. Description" := NewDescription;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1."Department Code" := NewCodeTeam;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;
                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END
                                                    ELSE BEGIN

                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                    ECLSystematization1.Sector := SectorPronadji.Code;
                                                                    ECLSystematization1."Department Category" := NewCode;
                                                                    ECLSystematization1.Team := NewCodeTeam;
                                                                    ECLSystematization1."Department Code" := NewCodeTeam;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;
                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END;
                                                    Head.RESET;

                                                    //AKO JE TIM
                                                    Head.RESET;
                                                    Head.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                                                    Head.SETFILTER("Team Description", '%1', "Team Description");
                                                    IF Head.FINDFIRST THEN BEGIN
                                                        IF OldDescription = NewDescription THEN BEGIN
                                                            Head1.RESET;
                                                            Head1.SETFILTER(Sector, '%1', Head.Sector);
                                                            Head1.SETFILTER("Sector  Description", '%1', Head."Sector  Description");
                                                            Head1.SETFILTER("Department Category", '%1', Head."Department Category");
                                                            Head1.SETFILTER("Department Categ.  Description", '%1', Head."Department Categ.  Description");
                                                            Head1.SETFILTER("Group Code", '%1', Head."Group Code");
                                                            Head1.SETFILTER("Group Description", '%1', Head."Group Description");
                                                            Head1.SETFILTER("Team Code", '%1', Head."Team Code");
                                                            Head1.SETFILTER("Team Description", '%1', Head."Team Description");
                                                            IF Head1.FINDFIRST THEN BEGIN
                                                                Head1."Department Category" := NewCode;
                                                                Head1.MODIFY;
                                                            END;
                                                        END;

                                                        IF OldCode = NewCode THEN BEGIN
                                                            IF Head1.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                Head1.RENAME(Head."Department Code", Head."ORG Shema", NewDescription, Head."Group Description", Head."Team Description");
                                                                Head1."Department Category" := NewCode;
                                                            END;
                                                        END;
                                                       
                                                    END;
                                                    IF PositionMenuNew.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", "ORG Shema")
                                               THEN BEGIN
                                                        IF PositionMenu."Department Code" <> '' THEN BEGIN
                                                            IF DepartmentCode <> PositionMenu."Department Code" THEN
                                                                PositionMenuNew.RENAME(NewPositionCode, PositionMenu.Description, DepartmentCode, "ORG Shema");
                                                        END
                                                        ELSE BEGIN
                                                            PositionMenuNew.RENAME(NewPositionCode, PositionMenu.Description, '', "ORG Shema");
                                                        END;
                                                        PosNew.RESET;
                                                        PosNew.SETFILTER(Code, '%1', PositionMenu.Code);
                                                        PosNew.SETFILTER(Description, '%1', PositionMenu.Description);
                                                        IF PosNew.FINDFIRST THEN BEGIN
                                                            PosNew."Sector Identity" := SectorPronadji.Identity;
                                                            PosNew.MODIFY;
                                                        END;
                                                    END;
                                                END;
                                            UNTIL PositionMenu.NEXT = 0;
                                        IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                        DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                DimensionForPos1.Belongs := DimensionForPos."Position Code" + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            END
                                            ELSE BEGIN
                                                DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                                DimensionForPos."Position Description", DimensionForPos."Org Belongs");
                                                DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            END;
                                            IF SectorPronadji.FINDFIRST THEN BEGIN
                                                DimensionForPos1.Sector := SectorPronadji.Code;
                                                DimensionForPos1."Sector  Description" := SectorPronadji.Description;
                                                DimensionForPos1."Sector Identity" := SectorPronadji.Identity;
                                            END;
                                            DimensionForPos1."Department Category" := NewCode;
                                            DimensionForPos1."Department Categ.  Description" := NewDescription;
                                            DimensionForPos1."Team Code" := NewCodeTeam;
                                            DimensionForPos1.MODIFY;


                                        END;


                                        Found := FALSE;
                                    UNTIL DimensionForPos.NEXT = 0;
                            END;

                            IF "Department Type".AsInteger() = 2 THEN BEGIN
                                GroupTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                                GroupTemp.SETFILTER(Code, '%1', Code);
                                GroupTemp.SETFILTER(Description, '%1', "Group Description");
                                IF GroupTemp.FINDFIRST THEN BEGIN
                                    GroupTemp.RENAME(NewCodeGroup, GroupTemp."Org Shema", GroupTemp.Description);
                                END;
                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 2);
                                DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                                DimensionsTemporery.SETFILTER("Department Category", '%1', NewCode);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                DimensionsTemporery.SETFILTER("Group Code", '%1', GroupTemp.Code);
                                DimensionsTemporery.SETFILTER("Group Description", '%1', GroupTemp.Description);
                                IF DimensionsTemporery.FINDSET THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                        DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", "ORG Shema") THEN BEGIN

                                            DepartmentNewFind.RESET;
                                            DepartmentNewFind.SETFILTER("Group Code", '%1', GroupTemp.Code);
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 2);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DimensionsTemporery1.RENAME(DepartmentTempFind."Group Code", DimensionsTemporery."Dimension Value Code",
                                                DimensionsTemporery."Team Description", NewDescription, DimensionsTemporery."Group Description", DepartmentTempFind."Group Code", "ORG Shema");
                                            END;

                                        END;
                                        SectorPronadji.RESET;
                                        //stala
                                        SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                        IF SectorPronadji.FINDFIRST THEN BEGIN
                                            DimensionsTemporery1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                            DimensionsTemporery1."Sector  Description" := SectorPronadji.Description;

                                        END;
                                        DimensionsTemporery1."Department Category" := NewCode;
                                        DimensionsTemporery1.MODIFY;

                                    UNTIL DimensionsTemporery.NEXT = 0;


                            END;


                            IF "Department Type".AsInteger() = 9 THEN BEGIN
                                TeamTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                                TeamTemp.SETFILTER(Code, '%1', Code);
                                TeamTemp.SETFILTER(Name, '%1', "Team Description");
                                IF TeamTemp.FINDFIRST THEN BEGIN
                                    TeamTemp.RENAME(NewCodeTeam, TeamTemp.Name, TeamTemp."Org Shema", TeamTemp.Description);
                                END;

                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 9);
                                DimensionsTemporery.SETFILTER("Department Category", '%1', NewCode);
                                DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                DimensionsTemporery.SETFILTER("Team Code", '%1', TeamTemp.Code);
                                DimensionsTemporery.SETFILTER("Team Description", '%1', TeamTemp.Name);
                                IF DimensionsTemporery.FINDFIRST THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                        DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema") THEN BEGIN
                                            DepartmentNewFind.RESET;
                                            DepartmentNewFind.SETFILTER("Team Code", '%1', TeamTemp.Code);
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DimensionsTemporery1.RENAME(DepartmentTempFind."Team Code", DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description",
                                                NewDescription, DimensionsTemporery."Group Description", DepartmentTempFind."Group Code", DimensionsTemporery."ORG Shema");
                                            END;
                                        END;
                                        SectorPronadji.RESET;
                                        //stala
                                        SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                        IF SectorPronadji.FINDFIRST THEN BEGIN
                                            DimensionsTemporery1.Sector := SectorPronadji.Code; //MIJENJA SEKTOR
                                            DimensionsTemporery1."Sector  Description" := SectorPronadji.Description;

                                        END;
                                        DimensionsTemporery1."Department Category" := NewCode;
                                        DimensionsTemporery1."Team Code" := DepartmentTempFind."Team Code";
                                    UNTIL DimensionsTemporery.NEXT = 0;




                            END;


                        UNTIL NEXT = 0;
                END;


                IF Promjena = 1 THEN BEGIN // 1. then begin

                    FindLastCode.RESET;
                    FindLastCode.SETFILTER("Department Type", '%1', 4);
                    FindLastCode.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                    FindLastCode.SETFILTER("Department Category", '%1', OldCode);
                    IF FindLastCode.FINDFIRST THEN BEGIN
                        FilterCode := FindLastCode.Code;
                    END
                    ELSE BEGIN
                        FilterCode := '';
                    END;


                    SETFILTER("ORG Shema", '%1', "ORG Shema");
                    SETFILTER("Department Type", '%1', 4);
                    SETFILTER("Department Categ.  Description", '%1', OldDescription);
                    SETFILTER("Department Category", '%1', OldCode);
                    SETFILTER(Code, '%1', FilterCode);


                    IF FIND('-') THEN BEGIN // 2. THEN BEGIN
                        Brojac := 0;
                        String := FORMAT(NewCode);
                        FOR i := 1 TO STRLEN(NewCode) DO BEGIN
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 3 THEN
                                    TheSame := i;
                                IF Brojac = 2 THEN
                                    SectorFInd := i;
                            END;
                        END;
                        IF (OldDescription <> NewDescription) OR (OldCode <> NewCode) THEN BEGIN
                            Head.RESET;
                            // Head.SETFILTER("Department Code",'%1',OldCode);
                            Head.SETFILTER("Department Category", '%1', OldCode);
                            Head.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                            Head.SETFILTER("Group Code", '%1', '');
                            Head.SETFILTER("Group Description", '%1', '');
                            Head.SETFILTER("Position Code", '%1', '');


                            IF Head.FINDFIRST THEN BEGIN
                                IF Head."Department Category" = NewCode THEN BEGIN
                                    HeadExsist.RESET;
                                    IF HeadExsist.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN
                                        HeadExsist.RENAME(NewCode, Head."ORG Shema", NewDescription, Head."Group Description", Head."Team Description");
                                END
                                ELSE BEGIN
                                    Head.DELETE;
                                END;
                            END;




                        END;
                        DepartmentTempNewW.RESET;
                        DepartmentTempNewW.SETFILTER("Department Type", '%1', 4);
                        DepartmentTempNewW.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                        DepartmentTempNewW.SETFILTER("Department Category", '%1', OldCode);
                        IF DepartmentTempNewW.FINDFIRST THEN BEGIN

                            IF DepartmentTempNewW.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN BEGIN
                                DepartmentTempNewW.RENAME(NewCode, "ORG Shema", "Team Description", NewDescription, "Group Description", NewDescription);
                                DepartmentTempNewW."Department Category" := NewCode;
                                DepartmentTempNewW."Residence/Network" := CentralaInsert;
                                DepartmentTempNewW.MODIFY;

                                SectorPronadji.RESET;
                                SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                IF SectorPronadji.FINDFIRST THEN BEGIN
                                    DepartmentTempNewW.Sector := SectorPronadji.Code;
                                    DepartmentTempNewW."Sector  Description" := SectorPronadji.Description;
                                    DepartmentTempNew."Sector Identity" := SectorPronadji.Identity;
                                    DepartmentTempNewW.MODIFY;
                                END;
                            END;
                        END;

                        //TROŠKOVI
                        DimensionsTemporery.RESET;
                        DimensionsTemporery1.RESET;
                        DimensionsTemporery.SETFILTER("Department Type", '%1', 4);
                        DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', OldDescription);
                        DimensionsTemporery.SETFILTER("Department Category", '%1', OldCode);
                        DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimensionsTemporery.FINDSET THEN
                            REPEAT
                                IF DimensionsTemporery1.GET(OldCode, DimensionsTemporery."Dimension Value Code", '', OldDescription, '', '', "ORG Shema") THEN BEGIN
                                    DimensionsTemporery1.RENAME(NewCode, DimensionsTemporery."Dimension Value Code", '', NewDescription, '', '', "ORG Shema");
                                    DimensionsTemporery1.Sector := SectorPronadji.Code;
                                    DimensionsTemporery1."Sector  Description" := SectorPronadji.Description;
                                    DimensionsTemporery1.Description := NewDescription;
                                    DimensionsTemporery1.Belongs := FORMAT(NewCode) + '-' + NewDescription;
                                    DimensionsTemporery1.MODIFY;
                                    //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema
                                END;
                            UNTIL DimensionsTemporery.NEXT = 0;


                        DimensionForPos.RESET;
                        DimensionForPos.SETFILTER("Department Category", '%1', NewCode);
                        DimensionForPos.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);
                        DimensionForPos.SETFILTER("Group Code", '%1', '');
                        DimensionForPos.SETFILTER("Group Description", '%1', '');
                        DimensionForPos.SETFILTER("Team Code", '%1', '');
                        DimensionForPos.SETFILTER("Team Description", '%1', '');
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
                                END;
                                LengthPosition := STRLEN(DimensionForPos."Position Code");
                                SecondPart1 := COPYSTR(DimensionForPos."Position Code", FindZero, LengthPosition);
                                IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos."Department Category")) <> DimensionForPos."Department Category" THEN BEGIN
                                        NewPositionCode := DimensionForPos."Position Code";
                                    END
                                    ELSE BEGIN
                                        NewPositionCode := COPYSTR(NewCode, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        DepartmentCheckResidence.RESET;
                                        DepartmentCheckResidence.SETFILTER("Department Categ.  Description", '%1', DimensionForPos."Department Categ.  Description");
                                        DepartmentCheckResidence.SETFILTER("Department Type", '%1', 4);
                                        IF DepartmentCheckResidence.FINDFIRST THEN BEGIN
                                            IF DepartmentCheckResidence."Residence/Network" = DepartmentCheckResidence."Residence/Network"::Network THEN BEGIN
                                                Sifra := NewCode;
                                                Brojac := 0;
                                                FOR i := 1 TO STRLEN(Sifra) DO BEGIN
                                                    IF Sifra[i] = '.' THEN BEGIN
                                                        Brojac := Brojac + 1;
                                                        IF Brojac = 3 THEN
                                                            NaciTacke := i;
                                                    END;
                                                END;
                                                NewPositionCode := COPYSTR(NewCode, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));

                                            END;
                                        END;
                                    END;
                                    DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                    SectorPronadji.RESET;

                                    SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                                    IF SectorPronadji.FINDFIRST THEN BEGIN
                                        SectorCode := SectorPronadji.Code;
                                        SectorDescription := SectorPronadji.Description;
                                    END;
                                    DimensionForPos1.Sector := SectorCode;
                                    DimensionForPos1."Sector  Description" := SectorDescription;
                                    DimensionForPos1."Department Category" := NewCode;
                                    DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                    DimensionForPos1."Org Belongs" := NewDescription;
                                    DimensionForPos1.MODIFY;
                                END;
                                PositionMenu.RESET;
                                PositionMenu1.RESET;
                                PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                          THEN BEGIN
                                            DepartmentTempFind.RESET;
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 4);
                                            DepartmentTempFind.SETFILTER("Department Category", '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DepartmnetPOs := DepartmentTempFind.Code;
                                            END;
                                            PositionBenefits.RESET;
                                            PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                            PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                            IF PositionBenefits.FINDSET THEN
                                                REPEAT
                                                    IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", PositionBenefits."Org. Structure") THEN
                                                        PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", RealOrgShema)
               //Position Code,Code,Description,Position Name

               UNTIL PositionBenefits.NEXT = 0;

                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', OldDescription);
                                                ECLSystematization.SETFILTER("Group Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := SectorPronadji.Code;
                                                            ECLSystematization1."Department Category" := NewCode;
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
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', OldDescription);
                                                ECLSystematization.SETFILTER("Group Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := SectorPronadji.Code;
                                                            ECLSystematization1."Department Category" := NewCode;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;


                                            IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", "ORG Shema")
                                               THEN BEGIN
                                                
                                               
                                                IF PositionMenu."Department Code" <> '' THEN BEGIN
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




                                        END;
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;
                            UNTIL DimensionForPos.NEXT = 0;

                        DepCategorytemp.RESET;
                        DepCategorytemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                        DepCategorytemp.SETFILTER(Description, '%1', OldDescription);
                        DepCategorytemp.SETFILTER(Code, '%1', OldCode);
                        IF DepCategorytemp.FINDSET THEN BEGIN
                            IF DepCategorytemp1.GET(OldCode, DepCategorytemp."Org Shema", OldDescription) THEN
                                DepCategorytemp1.RENAME(NewCode, DepCategorytemp."Org Shema", NewDescription);
                            DepCategorytemp1.IsTrue := TRUE;
                            DepCategorytemp1."Fields for change" := UPPERCASE('***');
                            DepCategorytemp1."Residence/Network" := CentralaInsert;
                            DepCategorytemp1."Official Translate of DepCat" := NewDescriptionDef;
                            DepCategorytemp1."Department Type" := DepCategorytemp1."Department Type"::Group;
                            DepCategorytemp1.MODIFY;
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
                                DepCategorytemp1."Identity Sector" := SectorPronadji.Identity;
                                DepCategorytemp1.MODIFY;
                            END;
                        END;




                        DimesnionFind.RESET;
                        DimesnionFind.SETFILTER("Department Category", '%1', NewCode);
                        DimesnionFind.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                        DimesnionFind.SETFILTER("Department Type", '%1', 4);
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

                                    DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", '', NewDescription, '', '', RealOrgShema);
                                    IF DimensionForReport1.Description <> NewDescription THEN
                                        DimensionForReport1.Description := NewDescription;
                                    IF DimensionForReport1.Sector <> SectorCode THEN
                                        DimensionForReport1.Sector := SectorCode;
                                    IF DimensionForReport1."Sector  Description" <> SectorDescription THEN
                                        DimensionForReport1."Sector  Description" := SectorDescription;
                                    IF DimensionForReport1."Department Category" <> NewCode THEN
                                        DimensionForReport1."Department Category" := NewCode;
                                    IF DimensionForReport1."Dimension Code" <> 'TC' THEN
                                        DimensionForReport1."Dimension Code" := 'TC';
                                    DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                    IF DimensionForReport1."Department Type" <> 4 THEN
                                        DimensionForReport1."Department Type" := 4;
                                    DimensionForReport1.MODIFY;
                                END;

                            UNTIL DimensionForReport.NEXT = 0;

                        DimensionForReport.RESET;
                        // DimensionForReport.SETFILTER(Code,'<>%1','');
                        IF DimensionForReport.FINDSET THEN
                            REPEAT
                                DimesnionFind.RESET;
                                DimesnionFind.INIT;
                                DimesnionFind.TRANSFERFIELDS(DimensionForReport);
                                DimesnionFind.INSERT;
                            UNTIL DimensionForReport.NEXT = 0;
                        SectorFindForUpdate.RESET;
                        SectorFindForUpdate.SETFILTER(Code, '%1', NewCode);
                        SectorFindForUpdate.SETFILTER(Description, '%1', NewDescription);
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



















                        SectorPronadji.RESET;

                        SectorPronadji.SETFILTER(Code, '%1', COPYSTR(NewCode, 1, SectorFInd));
                        IF SectorPronadji.FINDFIRST THEN BEGIN
                            SectorCode := SectorPronadji.Code;
                            SectorDescription := SectorPronadji.Description;
                        END;

                        DimensionsTemporery.RESET;
                        DimensionsTemporery.SETFILTER("Department Type", '%1', 4);
                        DimensionsTemporery.SETFILTER("Department Category", '%1', NewCode);
                        DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                        DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimensionsTemporery.FINDSET THEN
                            REPEAT
                                IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code", '', DimensionsTemporery."Department Categ.  Description", '', '', DimensionsTemporery."ORG Shema") THEN BEGIN
                                    DimensionsTemporery1.RENAME(NewCode, DimensionsTemporery."Dimension Value Code", '', NewDescription, '', '', "ORG Shema");
                                    DimensionsTemporery1."Department Category" := NewCode;
                                    DimensionsTemporery1."Department Categ.  Description" := NewDescription;
                                    DimensionsTemporery1.Description := NewDescription;
                                    DimensionsTemporery1.Sector := SectorCode;
                                    DimensionsTemporery1."Sector  Description" := SectorDescription;
                                    DimensionsTemporery1.Belongs := FORMAT(NewCode) + '-' + NewDescription;
                                    DimensionsTemporery1.MODIFY;
                                END;
                            UNTIL DimensionsTemporery.NEXT = 0;
                        DimensionForPos.RESET;
                        DimensionForPos.SETFILTER("Department Category", '%1', NewCode);
                        DimensionForPos.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);
                        DimensionForPos.SETFILTER("Group Code", '%1', '');
                        DimensionForPos.SETFILTER("Group Description", '%1', '');
                        DimensionForPos.SETFILTER("Team Code", '%1', '');
                        DimensionForPos.SETFILTER("Team Description", '%1', '');

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
                                        FindZero := 7;
                                END;
                                LengthPosition := STRLEN(DimensionForPos."Position Code");
                                SecondPart1 := COPYSTR(DimensionForPos."Position Code", FindZero, LengthPosition);
                                // NewPositionCode:=NewCode+COPYSTR(DimensionForPos."Position Code",FindZero,STRLEN(DimensionForPos."Position Code"));
                                IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                        NewPositionCode := DimensionForPos."Position Code";
                                    END
                                    ELSE BEGIN
                                        NewPositionCode := COPYSTR(NewCode, 1, FindZero - 1) + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        DepartmentCheckResidence.RESET;
                                        DepartmentCheckResidence.SETFILTER("Department Categ.  Description", '%1', DimensionForPos."Department Categ.  Description");
                                        DepartmentCheckResidence.SETFILTER("Department Type", '%1', 4);
                                        IF DepartmentCheckResidence.FINDFIRST THEN BEGIN
                                            IF DepartmentCheckResidence."Residence/Network" = DepartmentCheckResidence."Residence/Network"::Network THEN BEGIN
                                                Sifra := NewCode;
                                                Brojac := 0;
                                                FOR i := 1 TO STRLEN(Sifra) DO BEGIN
                                                    IF Sifra[i] = '.' THEN BEGIN
                                                        Brojac := Brojac + 1;
                                                        IF Brojac = 3 THEN
                                                            NaciTacke := i;
                                                    END;
                                                END;
                                                NewPositionCode := COPYSTR(NewCode, 1, NaciTacke) + COPYSTR(DimensionForPos."Position Code", NaciTacke + 1, STRLEN(DimensionForPos."Position Code"));

                                            END;
                                        END;
                                    END;
                                    DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                    DimensionForPos1."Department Category" := NewCode;
                                    DimensionForPos1."Department Categ.  Description" := NewDescription;
                                    DimensionForPos1.Sector := SectorCode;
                                    DimensionForPos1."Sector  Description" := SectorDescription;
                                    DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                    DimensionForPos1."Org Belongs" := NewDescription;
                                    DimensionForPos1.MODIFY;
                                END;
                                PositionMenu.RESET;
                                PositionMenu1.RESET;
                                PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                          THEN BEGIN
                                            DepartmentTempFind.RESET;
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 4);
                                            DepartmentTempFind.SETFILTER("Department Category", '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                                            IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                DepartmnetPOs := DepartmentTempFind.Code;
                                            END;
                                            PositionBenefits.RESET;
                                            PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                            PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                            IF PositionBenefits.FINDSET THEN
                                                REPEAT
                                                    IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", PositionBenefits."Org. Structure") THEN
                                                        PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", RealOrgShema)
               //Position Code,Code,Description,Position Name

               UNTIL PositionBenefits.NEXT = 0;
                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', NewDescription);
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1."Department Category" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END
                                            ELSE BEGIN

                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', NewDescription);
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                           
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1.VALIDATE("Department Cat. Description", ECLSystematization."Department Cat. Description");
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;

                                            IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", "ORG Shema")
                                               THEN BEGIN
                                           
                                                IF PositionMenu."Department Code" <> '' THEN BEGIN
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
                                        END;
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;
                            UNTIL DimensionForPos.NEXT = 0;

                    END;
                    DimensionsForPositionTC.RESET;
                    DimensionsForPositionTC.SETFILTER("Org Belongs", '%1', NewDescription);
                    DimensionsForPositionTC.SETFILTER("Department Category", '%1', NewCode);
                    DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', NewDescription);
                    DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                    DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                    IF DimensionsForPositionTC.FINDSET THEN
                        REPEAT
                            // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                            IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema",
                              DimensionsForPositionTC."Position Description", DimensionsForPositionTC."Org Belongs") THEN BEGIN
                                IF DimensionForReport.COUNT = 1 THEN BEGIN
                                    DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", DimensionForReport."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description", NewDescription);
                                    DimensionsForPositionTC1."Dimension  Name" := DimensionForReport."Dimension  Name";
                                    DimensionsForPositionTC1.MODIFY;
                                END;
                            END;
                        UNTIL DimensionsForPositionTC.NEXT = 0;
                    ECLSystematization.RESET;
                    ECLSystematization.SETFILTER("Department Category", '%1', NewCode);
                    ECLSystematization.SETFILTER("Department Cat. Description", '%1', NewDescription);
                    ECLSystematization.SETFILTER(Group, '%1', '');
                    ECLSystematization.SETFILTER("Group Description", '%1', '');
                    IF ECLSystematization.FINDSET THEN
                        REPEAT
                            DimensionForPos.RESET;
                            DimensionForPos.SETFILTER("Position Code", '%1', ECLSystematization."Position Code");
                            DimensionForPos.SETFILTER("Position Description", '%1', ECLSystematization."Position Description");
                            DimensionForPos.SETFILTER(Sector, '%1', ECLSystematization.Sector);
                            DimensionForPos.SETFILTER("Sector  Description", '%1', ECLSystematization."Sector Description");
                            DimensionForPos.SETFILTER("Department Category", '%1', ECLSystematization."Department Category");
                            DimensionForPos.SETFILTER("Department Categ.  Description", '%1', ECLSystematization."Department Cat. Description");
                            DimensionForPos.SETFILTER("Group Code", '%1', '');
                            DimensionForPos.SETFILTER("Group Description", '%1', '');
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
                group("L")
                {
                    Caption = '';
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
                    field(OldCode; OldCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Old code';
                        TableRelation = "Department Category temporary".Code;
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

                    Part("Dimensions for report"; "Dimensions for report")
                    {
                        SubPageLink = "Department Type" = FILTER(4);
                        ApplicationArea = all;

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
        NewDescriptionDef: Text;
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
        FilterCode: Code[10];
        DepartmentTempNewW: Record "Department temporary";
        TheLastCharacter: Integer;
        PositionChangeAlready: Record "Position temporery";
        DepartmentTempNewW1: Record "Department temporary";
        DimensionsTemporery1: Record "Dimension temporary";
        DescriptionFind: Record "Department Category temporary";
        DepartmentTempNew1: Record "Department temporary";
        DimensionsTemporery: Record "Dimension temporary";
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
        DepartmentNewFind: Record "Department temporary";
        NewDimensionTempForPos: Record "Dimension temp for position";
        PositionMenuNew: Record "Position Menu temporary";
        PositionMenu1: Record "Position Menu temporary";
        DepartmnetPOs: Code[50];
        DimesnionFind: Record "Dimension temporary";
        DimensionForReport: Record "Dimension for report";
        DimensionForReport1: Record "Dimension for report";
        SectorCode: Code[50];
        SectorDescription: Text;
        SectorFindForUpdate: Record "Department Category temporary";
        RealOrgShema: Code[50];
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        SectorCheckLength: Record "Sector temporary";
        PositionBenefits: Record "Position Benefits temporery";
        PositionBenefits1: Record "Position Benefits temporery";
        Head: Record "Head Of's temporary";
        Head1: Record "Head Of's temporary";
        HeadChange: Record "Head Of's temporary";
        ECLSystematization: Record "ECL systematization";
        ECLSystematization1: Record "ECL systematization";
        SectorDuplicate: Record "Department Category temporary";
        DepartmentDuplicate: Record "Department temporary";
        HeadExsist: Record "Head Of's temporary";
        DepartmentCheckResidence: Record "Department temporary";
        NaciTacke: Integer;
        Sifra: Code[50];
        PosNew: Record "Position Menu temporary";
        BrojZapisa: Integer;
        TempPosition: Record "Dimension temp for position";

    procedure SetParam(OldCodeSent: Code[30]; OldNameSent: Text; Centrala: Option; PromjenaInsert: Integer; OrgS: Code[10])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        NewCode := OldCode;
        DepCatTemp.RESET;
        DepCatTemp.SETFILTER(Code, '%1', OldCodeSent);
        DepCatTemp.SETFILTER(Description, '%1', OldDescription);
        DepCatTemp.SETFILTER("Org Shema", '%1', OrgS);
        IF DepCatTemp.FINDFIRST THEN
            NewDescriptionDef := DepCatTemp."Official Translate of DepCat"
        ELSE
            NewDescriptionDef := '';
        NewDescription := OldDescription;
        CentralaInsert := Centrala;
        Promjena := PromjenaInsert;
        RealOrgShema := OrgS;
    end;
}

*/