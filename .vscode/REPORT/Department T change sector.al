/*report 50016 "Department T change sector"
{
    Caption = 'Department Temp change new';
    ProcessingOnly = true;
    UseRequestPage = true;

    dataset
    {
        dataitem(DataItem1; "Department temporary")
        {

            trigger OnAfterGetRecord()
            begin


                String := FORMAT(Code);
                LengthString := STRLEN(String);
                Brojac := 0;
                FOR i := 1 TO LengthString DO BEGIN
                    IF String[i] = '.' THEN BEGIN
                        Brojac := Brojac + 1;
                        IF Brojac = 2 THEN BEGIN
                            j := i;
                        END;
                    END;
                END;
                //radim nad department tabelom
                IF Promjena = 1 THEN BEGIN
                    SETFILTER("ORG Shema", '%1', "ORG Shema");
                    SETFILTER(Sector, '%1', OldCode);
                    SETFILTER(Code, '<>%1', OldCode);
                    IF FIND('-') THEN
                        REPEAT


                            //NPR STRING
                            String := FORMAT(Code);
                            LengthString := STRLEN(String);
                            Brojac := 0;
                            FOR i := 1 TO LengthString DO BEGIN
                                IF String[i] = '.' THEN BEGIN
                                    Brojac := Brojac + 1;
                                    IF Brojac = 2 THEN BEGIN
                                        j := i;
                                    END;
                                END;
                            END;

                            IF "Department Type".AsInteger() = 4 THEN BEGIN //ako je odjel
                                SecondPartDepCat := COPYSTR(Code, j + 1, LengthString);
                                NewCodeDepCat := NewCode + SecondPartDepCat; //nova šifra odjela

                                IF DepartmentTempNew.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN
                                    DepartmentTempNew.RENAME(NewCodeDepCat, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description);
                                DepartmentTempNew.Sector := NewCode;
                                DepartmentTempNew."Sector  Description" := NewDescription;
                                DepartmentTempNew."Department Category" := NewCodeDepCat;
                                DepartmentTempNew.MODIFY;


                                //PRONAĐI MI TROŠKOVNE CENTRE PO POZICIJI KOJA ODGOVARA TOM ODJELU - TO ZNAČI SLJEDEĆE, ukoliko je (Imamo 10 odjela koji odgovaraju D.2. sektoru, uzmi svih 10 tih odjela i pronađi sve njihove troškovne centre po pozicijama
                                DimensionForPos.RESET;
                                DimensionForPos.SETFILTER("Department Category", '%1', "Department Category");
                                DimensionForPos.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                                DimensionForPos.SETFILTER(Sector, '%1', OldCode);
                                DimensionForPos.SETFILTER("Sector  Description", '%1', OldDescription);
                                DimensionForPos.SETFILTER("Group Code", '%1', '');
                                DimensionForPos.SETFILTER("Group Description", '%1', '');
                                DimensionForPos.SETFILTER("Team Code", '%1', '');
                                DimensionForPos.SETFILTER("Team Description", '%1', '');
                                DimensionForPos.SETCURRENTKEY("Position Code");
                                DimensionForPos.ASCENDING;
                                IF DimensionForPos.FINDSET THEN
                                    REPEAT
                                        FindZero := 0;
                                        FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                            StringPOs := DimensionForPos."Position Code";
                                            IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                                FindZero := i;
                                                FoundOne := TRUE;
                                            END;
                                            IF FindZero = 0 THEN
                                                FindZero := 4
                                        END;
                                        //pronađe izmjenu do sektora

                                        LengthPosition := STRLEN(DimensionForPos."Position Code");
                                        IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                        DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                            //Ukoliko nisu 9-ke
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                NewPositionCode := DimensionForPos."Position Code"; //ostaje pozicija
                                            END
                                            ELSE BEGIN
                                                NewPositionCode := NewCodeDepCat + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code")); //ili mijenjaj u novu
                                            END;
                                            DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", "ORG Shema",
                                            DimensionForPos."Position Description", DimensionForPos."Org Belongs");
                                            DimensionForPos1.Sector := NewCode;
                                            DimensionForPos1."Sector  Description" := NewDescription;
                                            DimensionForPos1."Department Category" := NewCodeDepCat;
                                            DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            DimensionForPos1.MODIFY;


                                            FoundOne := FALSE;
                                        END;
                                        //Potom slijedi izmjena u PositionMenu
                                        PositionMenu.RESET;
                                        PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                        PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                        PositionMenu.SETCURRENTKEY(Code);
                                        PositionMenu.ASCENDING;
                                        IF PositionMenu.FINDSET THEN
                                            REPEAT
                                                IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                                  THEN BEGIN
                                                    DepartmentTempFind.RESET;
                                                    DepartmentTempFind.SETFILTER("Department Type", '%1', 4);
                                                    DepartmentTempFind.SETFILTER("Department Category", '%1', NewCodeDepCat);
                                                    IF DepartmentTempFind.FINDFIRST THEN BEGIN
                                                        DepartmnetPOs := DepartmentTempFind.Code;
                                                    END;

                                                    //Position Code,Code,Description,Position Name,Org. Structure
                                                    PositionBenefits.RESET;
                                                    PositionBenefits.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                    PositionBenefits.SETFILTER("Position Name", '%1', PositionMenu.Description);
                                                    IF PositionBenefits.FINDSET THEN
                                                        REPEAT
                                                            IF PositionBenefits1.GET(PositionBenefits."Position Code", PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", PositionBenefits."Org. Structure") THEN
                                                                PositionBenefits1.RENAME(NewPositionCode, PositionBenefits.Code, PositionBenefits.Description, PositionBenefits."Position Name", RealOrgShema)
                       //Position Code,Code,Description,Position Name

                       UNTIL PositionBenefits.NEXT = 0;


                                                    //Rukovodioci Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description
                                                    IF PositionMenu."Management Level".AsInteger() <> 6 THEN BEGIN
                                                        //izmjena šifre pozicije

                                                        //pošto si na odjelu treba da izmijeniš svima šifru sektora a nivoe ispod gledaš preko opisa



                                                        Head.RESET;
                                                        Head1.RESET;
                                                        Head.SETFILTER("Sector  Description", '%1', DimensionForPos."Sector  Description");
                                                        Head.SETFILTER("Department Categ.  Description", '%1', DimensionForPos."Department Categ.  Description");
                                                        Head.SETFILTER("Group Description", '%1', '');
                                                        Head.SETFILTER("Team Description", '%1', '');
                                                        Head.SETFILTER("Team Code", '%1', '');
                                                        //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description
                                                        IF Head.FINDSET THEN
                                                            REPEAT
                                                                IF Head1.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                    IF NOT Head1.GET(NewCodeDepCat, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                        Head1.RENAME(NewCodeDepCat, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description");
                                                                        Head1.Sector := NewCode;
                                                                        Head1."Sector  Description" := NewDescription;
                                                                        Head1."Position Code" := NewPositionCode;
                                                                        PositionMenFind.RESET;
                                                                        PositionMenFind.SETFILTER("Management Level", '<>%1|<>%2', PositionMenu."Management Level"::E, PositionMenu."Management Level"::Empty);
                                                                        PositionMenFind.SETFILTER(Code, '%1', PositionMenu.Code);

                                                                        IF PositionMenFind.FINDFIRST THEN BEGIN
                                                                            Head1."Position Code" := PositionMenFind.Code;
                                                                        END;
                                                                        Head1.MODIFY;
                                                                    END;
                                                                END;
                                                            UNTIL Head.NEXT = 0;

                                                    END;
                                                    IF OldDescription <> NewDescription THEN BEGIN
                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                        ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                        ECLSystematization.SETFILTER("Department Cat. Description", '%1', "Department Categ.  Description");
                                                        ECLSystematization.SETFILTER(Group, '%1', '');
                                                        ECLSystematization.SETFILTER("Group Description", '%1', '');
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN
                                                                    ECLSystematization1.Sector := NewCode;
                                                                    ECLSystematization1."Department Category" := NewCodeDepCat;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1."Department Code" := NewCodeDepCat;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;
                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END
                                                    ELSE BEGIN

                                                        ECLSystematization.RESET;
                                                        ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                        ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                        ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                        ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                        ECLSystematization.SETFILTER("Department Cat. Description", '%1', "Department Categ.  Description");
                                                        IF ECLSystematization.FINDSET THEN
                                                            REPEAT
                                                                ECLSystematization1.RESET;
                                                                ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                    ECLSystematization1.Sector := NewCode;
                                                                    ECLSystematization1."Department Category" := NewCodeDepCat;
                                                                    ECLSystematization1."Department Code" := NewCodeDepCat;
                                                                    ECLSystematization1.Group := '';
                                                                    ECLSystematization1."Group Description" := '';
                                                                    ECLSystematization1.Team := '';
                                                                    ECLSystematization1."Team Description" := '';
                                                                    ECLSystematization1."Department Code" := NewCodeDepCat;
                                                                    ECLSystematization1."Position Code" := NewPositionCode;
                                                                    ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                    ECLSystematization1.MODIFY;
                                                                END;
                                                            UNTIL ECLSystematization.NEXT = 0;
                                                    END;

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






                                                    //    PositionMenu1.MODIFY;
                                                END;
                                            UNTIL PositionMenu.NEXT = 0;

                                    UNTIL DimensionForPos.NEXT = 0;
                                //KEYS Code,Description,Department Code,Org. Structure
                                // KEYS Position Code,Dimension Value Code,ORG Shema,Position Description
                                //izmjena na pozicijama

                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 4);
                                DimensionsTemporery.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                                DimensionsTemporery.SETFILTER("Department Category", '%1', "Department Category");
                                DimensionsTemporery.SETFILTER("Sector  Description", '%1', OldDescription);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF DimensionsTemporery.FINDFIRST THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code",
                                          DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description", DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", "ORG Shema") THEN BEGIN
                                            DimensionsTemporery1.RENAME(NewCodeDepCat, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                            DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema");
                                            DimensionsTemporery1.Sector := NewCode;
                                            DimensionsTemporery1."Sector  Description" := NewDescription;
                                            //DimensionsTemporery1.Description:=NewDescription;
                                            DimensionsTemporery1.Description := DimensionsTemporery1."Department Categ.  Description";
                                            DimensionsTemporery1."Department Category" := NewCodeDepCat;
                                            DimensionsTemporery1.MODIFY;
                                        END;
                                    UNTIL DimensionsTemporery.NEXT = 0;

                            END;



                            IF "Department Type".AsInteger() = 2 THEN BEGIN //ako je grupa
                                SecondPartGroup := COPYSTR(Code, j + 1, LengthString);
                                NewCodeGroup := NewCode + SecondPartGroup;
                                IF DepartmentTempNew.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN
                                    DepartmentTempNew.RENAME(NewCodeGroup, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description);
                                DepartmentTempNew.Sector := NewCode;
                                DepartmentTempNew."Sector  Description" := NewDescription;
                                DepartmentTempNew."Group Code" := NewCodeGroup;
                                DepartmentTempNew.MODIFY;

                                DimensionForPos.RESET;
                                DimensionForPos.SETFILTER("Group Code", '%1', "Group Code");
                                DimensionForPos.SETFILTER("Group Description", '%1', "Group Description");
                                DimensionForPos.SETFILTER(Sector, '%1', OldCode);
                                DimensionForPos.SETFILTER("Sector  Description", '%1', OldDescription);
                                DimensionForPos.SETFILTER("Team Code", '%1', '');
                                DimensionForPos.SETFILTER("Team Description", '%1', '');
                                IF DimensionForPos.FINDSET THEN
                                    REPEAT
                                        FindZero := 0;
                                        FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                            StringPOs := DimensionForPos."Position Code";
                                            IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                                FindZero := i;
                                                FoundOne := TRUE;
                                            END;
                                            IF FindZero = 0 THEN
                                                FindZero := 4;
                                        END;
                                        LengthPosition := STRLEN(DimensionForPos."Position Code");


                                        IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                        DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                NewPositionCode := DimensionForPos."Position Code";
                                            END
                                            ELSE BEGIN
                                                NewPositionCode := NewCodeGroup + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                            END;
                                            DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                            DimensionForPos."Position Description", DimensionForPos."Org Belongs");
                                            DimensionForPos1.Sector := NewCode;
                                            DimensionForPos1."Sector  Description" := NewDescription;
                                            DimensionForPos1."Group Code" := NewCodeGroup;
                                            DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            DimensionForPos1.MODIFY;

                                            FoundOne := FALSE;
                                            PositionMenu.RESET;
                                            PositionMenu1.RESET;
                                            PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                            PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                            IF PositionMenu.FINDSET THEN
                                                REPEAT
                                                    IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                                      THEN BEGIN
                                                        DepartmentTempFind.RESET;
                                                        DepartmentTempFind.SETFILTER("Department Type", '%1', 2);
                                                        DepartmentTempFind.SETFILTER("Group Code", '%1', NewCodeGroup);
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
                                                        //AKO JE GRUŠA
                                                        IF PositionMenu."Management Level".AsInteger() <> 6 THEN BEGIN
                                                            Head.RESET;
                                                            Head1.RESET;
                                                            Head.SETFILTER("Sector  Description", '%1', DimensionForPos."Sector  Description");
                                                            Head.SETFILTER("Department Categ.  Description", '%1', DimensionForPos."Department Categ.  Description");
                                                            Head.SETFILTER("Group Description", '%1', DimensionForPos."Group Description");
                                                            Head.SETFILTER("Team Description", '%1', '');
                                                            Head.SETFILTER("Team Code", '%1', '');

                                                            IF Head.FINDSET THEN
                                                                REPEAT
                                                                    IF Head1.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                        IF NOT Head1.GET(NewCodeGroup, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                            Head1.RENAME(NewCodeGroup, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description");
                                                                            Head1.Sector := NewCode;
                                                                            Head1."Sector  Description" := NewDescription;
                                                                            Head1."Position Code" := NewPositionCode;
                                                                            PositionMenFind.RESET;
                                                                            PositionMenFind.SETFILTER("Management Level", '<>%1|<>%2', PositionMenu."Management Level"::E, PositionMenu."Management Level"::Empty);
                                                                            PositionMenFind.SETFILTER(Code, '%1', PositionMenu.Code);

                                                                            IF PositionMenFind.FINDFIRST THEN BEGIN
                                                                                Head1."Position Code" := PositionMenFind.Code;
                                                                            END;
                                                                            Head1.MODIFY;
                                                                        END;
                                                                    END;
                                                                UNTIL Head.NEXT = 0;



                                                        END;
                                                        IF OldDescription <> NewDescription THEN BEGIN
                                                            ECLSystematization.RESET;
                                                            ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                            ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                            ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                            ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                            ECLSystematization.SETFILTER("Group Description", '%1', "Group Description");
                                                            IF ECLSystematization.FINDSET THEN
                                                                REPEAT
                                                                    ECLSystematization1.RESET;
                                                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                        ECLSystematization1.Sector := NewCode;
                                                                        ECLSystematization1."Sector Description" := NewDescription;
                                                                        ECLSystematization1.Group := NewCodeGroup;
                                                                        ECLSystematization1."Department Code" := NewCodeGroup;
                                                                        ECLSystematization1."Position Code" := NewPositionCode;
                                                                        // ECLSystematization1."Org Belong":='';
                                                                        ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                        ECLSystematization1.MODIFY;
                                                                    END;
                                                                UNTIL ECLSystematization.NEXT = 0;
                                                        END
                                                        ELSE BEGIN

                                                            ECLSystematization.RESET;
                                                            ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                            ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                            ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                            ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                            ECLSystematization.SETFILTER("Group Description", '%1', "Group Description");
                                                            ECLSystematization.SETFILTER(Team, '%1', '');
                                                            ECLSystematization.SETFILTER("Team Description", '%1', '');
                                                            IF ECLSystematization.FINDSET THEN
                                                                REPEAT
                                                                    ECLSystematization1.RESET;
                                                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                        ECLSystematization1.Sector := NewCode;
                                                                        ECLSystematization1.Group := NewCodeGroup;
                                                                        ECLSystematization1."Department Code" := NewCodeGroup;
                                                                        ECLSystematization1.Team := '';
                                                                        ECLSystematization1."Team Description" := '';
                                                                        ECLSystematization1."Department Code" := NewCodeGroup;
                                                                        ECLSystematization1."Position Code" := NewPositionCode;
                                                                        ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                        ECLSystematization1.MODIFY;
                                                                    END;
                                                                UNTIL ECLSystematization.NEXT = 0;
                                                        END;

                                                       
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
                                                UNTIL PositionMenu.NEXT = 0;
                                        END;
                                    UNTIL DimensionForPos.NEXT = 0;


                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 2);
                                DimensionsTemporery.SETFILTER("Group Description", '%1', "DataItem1"."Group Description");
                                DimensionsTemporery.SETFILTER("Group Code", '%1', "DataItem1"."Group Code");
                                DimensionsTemporery.SETFILTER("Sector  Description", '%1', OldDescription);
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF DimensionsTemporery.FINDFIRST THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(DimensionsTemporery.Code, DimensionsTemporery."Dimension Value Code",
                                          DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                          DimensionsTemporery."Group Description", DimensionsTemporery."Group Code", "ORG Shema") THEN BEGIN
                                            DimensionsTemporery1.RENAME(NewCodeGroup, DimensionsTemporery."Dimension Value Code", DimensionsTemporery."Team Description", DimensionsTemporery."Department Categ.  Description",
                                            DimensionsTemporery."Group Description", NewCodeGroup, "ORG Shema");
                                            DimensionsTemporery1.Sector := NewCode;

                                            DimensionsTemporery1."Sector  Description" := NewDescription;
                                            DimensionsTemporery1.MODIFY;
                                        END;
                                    UNTIL DimensionsTemporery.NEXT = 0;
                            END;

                            IF "Department Type".AsInteger() = 9 THEN BEGIN
                                SecondPartTeam := COPYSTR(Code, j + 1, LengthString);
                                NewCodeTeam := NewCode + SecondPartTeam;
                                IF DepartmentTempNew.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN
                                    DepartmentTempNew.RENAME(NewCodeTeam, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description);
                                DepartmentTempNew.Sector := NewCode;
                                DepartmentTempNew."Sector  Description" := NewDescription;
                                DepartmentTempNew."Team Code" := NewCodeTeam;
                                DepartmentTempNew.MODIFY;


                                DimensionForPos.RESET;
                                DimensionForPos.SETFILTER("Team Code", '%1', "Team Code");
                                DimensionForPos.SETFILTER("Team Description", '%1', "Team Description");
                                DimensionForPos.SETFILTER(Sector, '%1', OldCode);
                                DimensionForPos.SETFILTER("Sector  Description", '%1', OldDescription);
                                IF DimensionForPos.FINDSET THEN
                                    REPEAT
                                        FindZero := 0;
                                        FOR i := 1 TO STRLEN(DimensionForPos."Position Code") DO BEGIN
                                            StringPOs := DimensionForPos."Position Code";
                                            IF (StringPOs[i] = '0') AND (FoundOne = FALSE) THEN BEGIN
                                                FindZero := i;
                                                FoundOne := TRUE;
                                            END;
                                            IF FindZero = 0 THEN
                                                FindZero := 4;
                                        END;
                                        LengthPosition := STRLEN(DimensionForPos."Position Code");
                                        SecondPart1 := COPYSTR(DimensionForPos."Position Code", FindZero, LengthPosition);

                                        NewPositionCode := NewCodeTeam + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                        DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN BEGIN
                                            IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                                NewPositionCode := DimensionForPos."Position Code";
                                            END
                                            ELSE BEGIN
                                                NewPositionCode := NewCodeGroup + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                            END;
                                            DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                            DimensionForPos."Position Description", DimensionForPos."Org Belongs");
                                            DimensionForPos1.Sector := NewCode;
                                            DimensionForPos1."Sector  Description" := NewDescription;
                                            DimensionForPos1."Team Code" := NewCodeTeam;
                                            DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                            DimensionForPos1.MODIFY;

                                            Found := FALSE;
                                            PositionMenu.RESET;
                                            PositionMenu1.RESET;
                                            PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                            PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                            IF PositionMenu1.FINDSET THEN
                                                REPEAT
                                                    IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                                      THEN BEGIN
                                                        DepartmentTempFind.RESET;
                                                        DepartmentTempFind.SETFILTER("Department Type", '%1', 9);
                                                        DepartmentTempFind.SETFILTER("Team Code", '%1', NewCodeTeam);
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
                                                        IF PositionMenu."Management Level".AsInteger() <> 6 THEN BEGIN
                                                            Head.RESET;
                                                            Head1.RESET;
                                                            Head.SETFILTER("Sector  Description", '%1', DimensionForPos."Sector  Description");
                                                            Head.SETFILTER("Department Categ.  Description", '%1', DimensionForPos."Department Categ.  Description");
                                                            Head.SETFILTER("Group Description", '%1', DimensionForPos."Group Description");
                                                            Head.SETFILTER("Team Description", '%1', DimensionForPos."Team Description");
                                                            Head.SETFILTER("Team Code", '%1', DimensionForPos."Team Code");


                                                            IF Head.FINDSET THEN
                                                                REPEAT
                                                                    IF Head1.GET(Head."Department Code", Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                        IF NOT Head1.GET(NewCodeTeam, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description") THEN BEGIN
                                                                            Head1.RENAME(NewCodeTeam, Head."ORG Shema", Head."Department Categ.  Description", Head."Group Description", Head."Team Description");
                                                                            Head1.Sector := NewCode;
                                                                            Head1."Sector  Description" := NewDescription;
                                                                            Head1."Position Code" := NewPositionCode;
                                                                            PositionMenFind.RESET;
                                                                            PositionMenFind.SETFILTER("Management Level", '<>%1|<>%2', PositionMenu."Management Level"::E, PositionMenu."Management Level"::Empty);
                                                                            PositionMenFind.SETFILTER(Code, '%1', PositionMenu.Code);

                                                                            IF PositionMenFind.FINDFIRST THEN BEGIN
                                                                                Head1."Position Code" := PositionMenFind.Code;
                                                                            END;
                                                                            Head1.MODIFY;
                                                                        END;
                                                                    END;
                                                                UNTIL Head.NEXT = 0;



                                                        END;
                                                        IF OldDescription <> NewDescription THEN BEGIN
                                                            ECLSystematization.RESET;
                                                            ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                            ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                            ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                            ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                            ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                            IF ECLSystematization.FINDSET THEN
                                                                REPEAT
                                                                    ECLSystematization1.RESET;
                                                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                        ECLSystematization1.Sector := NewCode;
                                                                        ECLSystematization1."Sector Description" := NewDescription;
                                                                        ECLSystematization1.Team := NewCodeTeam;
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
                                                            ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                            ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                            ECLSystematization.SETFILTER("Team Description", '%1', "Team Description");
                                                            IF ECLSystematization.FINDSET THEN
                                                                REPEAT
                                                                    ECLSystematization1.RESET;
                                                                    ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                                    IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                                        ECLSystematization1.Sector := NewCode;
                                                                        ECLSystematization1.Team := NewCodeTeam;
                                                                        ECLSystematization1."Department Code" := NewCodeTeam;
                                                                        ECLSystematization1."Position Code" := NewPositionCode;
                                                                        ECLSystematization1.VALIDATE("Org Belongs", ECLSystematization1."Org Belongs");
                                                                        ECLSystematization1.MODIFY;
                                                                    END;
                                                                UNTIL ECLSystematization.NEXT = 0;
                                                        END;

                                                    
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





                                                        // PositionMenu1.MODIFY;
                                                    END;
                                                UNTIL PositionMenu.NEXT = 0;
                                        END;
                                    UNTIL DimensionForPos.NEXT = 0;

                                DimensionsTemporery.RESET;
                                DimensionsTemporery1.RESET;
                                DimensionsTemporery.SETFILTER("Department Type", '%1', 9);
                                DimensionsTemporery.SETFILTER("Team Description", '%1', "Team Description");
                                DimensionsTemporery.SETFILTER("Team Code", '%1', "Team Code");
                                DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                                IF DimensionsTemporery.FINDSET THEN
                                    REPEAT
                                        IF DimensionsTemporery1.GET(Code, DimensionsTemporery."Dimension Value Code", "Team Description", "Department Categ.  Description", "Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema") THEN BEGIN
                                            DimensionsTemporery1.RENAME(NewCodeTeam, DimensionsTemporery."Dimension Value Code", "Team Description", "Department Categ.  Description", "Group Description", DimensionsTemporery."Group Code", DimensionsTemporery."ORG Shema");
                                            DimensionsTemporery1.Sector := NewCode;
                                            DimensionsTemporery1."Sector  Description" := NewDescription;
                                            DimensionsTemporery1."Team Code" := NewCodeTeam;
                                            DimensionsTemporery1.MODIFY;
                                        END;
                                    UNTIL DimensionsTemporery.NEXT = 0;


                            END;

                            IF "Department Type".AsInteger() = 4 THEN BEGIN
                                DepCatTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                                DepCatTemp.SETFILTER(Code, '%1', Code);
                                DepCatTemp.SETFILTER(Description, '%1', "Department Categ.  Description");
                                IF DepCatTemp.FINDFIRST THEN BEGIN
                                    DepCatTemp.RENAME(NewCodeDepCat, DepCatTemp."Org Shema", DepCatTemp.Description);
                                END;
                            END;

                            IF "Department Type".AsInteger() = 2 THEN BEGIN
                                GroupTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                                GroupTemp.SETFILTER(Code, '%1', Code);
                                GroupTemp.SETFILTER(Description, '%1', "Group Description");
                                IF GroupTemp.FINDFIRST THEN BEGIN
                                    GroupTemp.RENAME(NewCodeGroup, GroupTemp."Org Shema", GroupTemp.Description);
                                END;
                            END;


                            IF "Department Type".AsInteger() = 9 THEN BEGIN
                                TeamTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                                TeamTemp.SETFILTER(Code, '%1', Code);
                                TeamTemp.SETFILTER(Name, '%1', "Team Description");
                                IF TeamTemp.FINDFIRST THEN BEGIN
                                    TeamTemp.RENAME(NewCodeTeam, TeamTemp.Name, TeamTemp."Org Shema", TeamTemp.Description);
                                END;
                            END;

                        UNTIL NEXT = 0;
                END;

                IF Promjena = 2 THEN BEGIN

                END;


                IF Promjena = 1 THEN BEGIN
                    RESET;
                    SETFILTER("ORG Shema", '%1', "ORG Shema");
                    SETFILTER("DataItem1".Sector, '%1', OldCode);
                    SETFILTER("DataItem1"."Sector  Description", '%1', OldDescription);
                    SETFILTER("DataItem1"."Department Type", '%1', 8);

                    IF FIND('-') THEN BEGIN

                        IF (OldDescription <> NewDescription) OR (NewCode <> OldCode) THEN BEGIN
                            Head.RESET;
                            Head.SETFILTER("Department Category", '%1', '');
                            Head.SETFILTER("Department Categ.  Description", '%1', '');
                            // Head.SETFILTER(Sector,'%1',OldCode);
                            Head.SETFILTER("Sector  Description", '%1', OldDescription);
                            IF Head.FINDSET THEN
                                REPEAT
                                    Head.DELETE;
                                UNTIL Head.NEXT = 0
                        END;
                        //Code,ORG Shema,Team Description,Department Categ.  Description,Group Description,Description
                        IF DepartmentTempNewCorrect.GET(Code, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description) THEN
                            DepartmentTempNewCorrect.RENAME(NewCode, "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", NewDescription);
                        DepartmentTempNewCorrect.Sector := NewCode;
                        DepartmentTempNewCorrect."Sector  Description" := NewDescription;
                        DepartmentTempNewCorrect."Residence/Network" := CentralaInsert;
                        DepartmentTempNewCorrect.MODIFY;
                        DepartmentTempNewCorrect.RESET;
                        DepartmentTempNewCorrect.SETFILTER(Sector, '%1', OldCode);
                        DepartmentTempNewCorrect.SETFILTER("Sector  Description", '%1', OldDescription);
                        IF DepartmentTempNewCorrect.FINDSET THEN
                            REPEAT
                                DepartmentTempNewCorrect.Sector := NewCode;
                                DepartmentTempNewCorrect."Sector  Description" := NewDescription;
                                DepartmentTempNewCorrect.MODIFY;
                            UNTIL DepartmentTempNewCorrect.NEXT = 0;
                        DimensionsTemporery.RESET;
                        DimensionsTemporery.SETFILTER("Department Type", '%1', 8);
                        DimensionsTemporery.SETFILTER(Sector, '%1', OldCode);
                        DimensionsTemporery.SETFILTER("Sector  Description", '%1', OldDescription);
                        DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimensionsTemporery.FINDSET THEN
                            REPEAT
                                IF DimensionsTemporery1.GET(OldCode, DimensionsTemporery."Dimension Value Code", '', '', '', '', "ORG Shema") THEN BEGIN
                                    DimensionsTemporery1.RENAME(NewCode, DimensionsTemporery."Dimension Value Code", '', '', '', '', "ORG Shema");
                                    DimensionsTemporery1.Sector := NewCode;
                                    DimensionsTemporery1."Sector  Description" := NewDescription;
                                    DimensionsTemporery1.Description := NewDescription;
                                    DimensionsTemporery1.Belongs := FORMAT(NewCode) + '-' + NewDescription;
                                    DimensionsTemporery1.MODIFY;
                                END;
                            UNTIL DimensionsTemporery.NEXT = 0;
                        DimensionForPos.RESET;
                        DimensionForPos.SETFILTER(Sector, '%1', OldCode);
                        DimensionForPos.SETFILTER("Sector  Description", '%1', OldDescription);
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);
                        DimensionForPos.SETFILTER("Group Code", '%1', '');
                        DimensionForPos.SETFILTER("Group Description", '%1', '');
                        DimensionForPos.SETFILTER("Team Code", '%1', '');
                        DimensionForPos.SETFILTER("Team Description", '%1', '');
                        DimensionForPos.SETFILTER("Department Categ.  Description", '%1', '');
                        DimensionForPos.SETFILTER("Department Category", '%1', '');
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
                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                        NewPositionCode := DimensionForPos."Position Code";
                                    END
                                    ELSE BEGIN


                                        NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        IF STRLEN(DimensionForPos."Position Code") <> STRLEN(NewPositionCode) THEN BEGIN
                                            FindZero := STRLEN(NewCode);
                                            NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero + 1, STRLEN(DimensionForPos."Position Code"));
                                        END;
                                    END;

                                    DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                    DimensionForPos1.Sector := NewCode;
                                    DimensionForPos1."Sector  Description" := NewDescription;
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
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 8);
                                            DepartmentTempFind.SETFILTER(Sector, '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Sector  Description", '%1', NewDescription);
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
                                            IF PositionMenu."Management Level".AsInteger() <> 6 THEN BEGIN
                                                //izmjena šifre pozicije
                                                Head.RESET;
                                                Head.INIT;
                                                Head."Department Code" := NewCode;
                                                Head.Sector := NewCode;
                                                Head."Sector  Description" := NewDescription;
                                                Head."Department Categ.  Description" := '';
                                                Head."Department Category" := '';
                                                Head."Group Code" := '';
                                                Head."Group Description" := '';
                                                Head."Team Code" := '';
                                                Head."Team Description" := '';
                                                Head."ORG Shema" := RealOrgShema;
                                                Head."Position Code" := NewPositionCode;
                                                Head."Management Level" := PositionMenu."Management Level";
                                                Head."ORG Shema" := RealOrgShema;
                                                //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description
                                                HeadExsist.RESET;
                                                HeadExsist.SETFILTER("Department Code", '%1', NewCode);
                                                HeadExsist.SETFILTER("ORG Shema", '%1', RealOrgShema);
                                                HeadExsist.SETFILTER("Department Categ.  Description", '%1', '');
                                                HeadExsist.SETFILTER("Group Description", '%1', '');
                                                HeadExsist.SETFILTER("Team Description", '%1', '');
                                                IF NOT HeadExsist.FINDFIRST THEN
                                                    Head.INSERT;

                                            END;

                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := NewCode;
                                                            ECLSystematization1."Sector Description" := NewDescription;
                                                            ECLSystematization1."Department Category" := '';
                                                            ECLSystematization1."Department Cat. Description" := '';
                                                            ECLSystematization1.Group := '';
                                                            ECLSystematization1."Group Description" := '';
                                                            ECLSystematization1.Team := '';
                                                            ECLSystematization1."Team Description" := '';
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1."Dimension Value Code" := '';
                                                            ECLSystematization1."Dimension  Name" := '';
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            // ECLSystematization1."Org Belong":='';
                                                            //  ECLSystematization1."Changing Position":=TRUE;
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END
                                            ELSE BEGIN

                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER(Sector, '%1', OldCode);
                                                ECLSystematization.SETFILTER("Sector Description", '%1', OldDescription);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := NewCode;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            //ECLSystematization1."Org Belong":=NewDescription;
                                                            ECLSystematization1."Sector Description" := NewDescription;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;

                                          
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
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;

                            UNTIL DimensionForPos.NEXT = 0;


                        SectorTemp.SETFILTER(Code, '%1', Code);
                        SectorTemp.SETFILTER("Org Shema", '%1', "ORG Shema");
                        SectorTemp.SETFILTER(Description, '%1', OldDescription);
                        SectorTemp.SETFILTER(Code, '%1', OldCode);
                        IF SectorTemp.FINDSET THEN BEGIN
                            IF SectorTemp1.GET(OldCode, SectorTemp."Org Shema", OldDescription) THEN
                                SectorTemp1.RENAME(NewCode, SectorTemp."Org Shema", NewDescription);
                            SectorTemp1.IsTrue := TRUE;
                            // SectorTemp1."Official Translate of Sector":=
                            SectorTemp1."Residence/Network" := CentralaInsert;
                            SectorTemp1."Official Translate of Sector" := OldDef;
                            SectorTemp1."Department Type" := SectorTemp1."Department Type"::Sector;
                            SectorTemp1."Fields for change" := UPPERCASE('***');
                            SectorTemp1.MODIFY;

                        END;

                        DimesnionFind.RESET;
                        DimesnionFind.SETFILTER(Code, '%1', NewCode);
                        DimesnionFind.SETFILTER(Description, '%1', NewDescription);
                        DimesnionFind.SETFILTER("Department Type", '%1', 8);
                        DimesnionFind.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimesnionFind.FINDSET THEN
                            REPEAT
                                DimesnionFind.DELETE;
                            UNTIL DimesnionFind.NEXT = 0;
                        DimensionForReport.RESET;
                        DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
                        IF DimensionForReport.FINDSET THEN
                            REPEAT
                                IF DimensionForReport1.GET(DimensionForReport.Code, DimensionForReport."Dimension Value Code", '', '', '', '', DimensionForReport."ORG Shema") THEN BEGIN

                                    //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema

                                    DimensionForReport1.RENAME(NewCode, DimensionForReport."Dimension Value Code", '', '', '', '', RealOrgShema);
                                    DimensionForReport1.Description := NewDescription;
                                    IF DimensionForReport1.Sector <> NewCode THEN
                                        DimensionForReport1.Sector := NewCode;
                                    IF DimensionForReport1."Sector  Description" <> NewDescription THEN
                                        DimensionForReport1."Sector  Description" := NewDescription;
                                    IF DimensionForReport1."Dimension Code" <> 'TC' THEN
                                        DimensionForReport1."Dimension Code" := 'TC';
                                    DimensionForReport1.Belongs := NewCode + '-' + NewDescription;
                                    IF DimensionForReport1."Department Type" <> 8 THEN
                                        DimensionForReport1."Department Type" := 8;
                                    DimensionForReport1.MODIFY;
                                END;

                            UNTIL DimensionForReport.NEXT = 0;

                        DimensionForReport.RESET;
                        DimensionForReport.SETFILTER(Code, '<>%1', '');
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

                        DimensionsForPositionTC.RESET;
                        DimensionsForPositionTC.SETFILTER(Sector, '%1', NewCode);
                        DimensionsForPositionTC.SETFILTER("Sector  Description", '%1', NewDescription);
                        //DimensionsForPositionTC.SETFILTER("Org Belongs",'%1',NewDescription);
                        DimensionsForPositionTC.SETFILTER("Department Category", '%1', '');
                        DimensionsForPositionTC.SETFILTER("Department Categ.  Description", '%1', '');
                        DimensionsForPositionTC.SETFILTER("Group Code", '%1', '');
                        DimensionsForPositionTC.SETFILTER("Group Description", '%1', '');
                        DimensionsForPositionTC.SETFILTER("Team Code", '%1', '');
                        DimensionsForPositionTC.SETFILTER("Team Description", '%1', '');
                        IF DimensionsForPositionTC.FINDSET THEN
                            REPEAT
                                // Position Code,Dimension Value Code,ORG Shema,Position Description -KEY
                                IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code", DimensionsForPositionTC."Dimension Value Code", DimensionsForPositionTC."ORG Shema",
                                  DimensionsForPositionTC."Position Description", DimensionsForPositionTC."Org Belongs") THEN BEGIN
                                    DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code", DimensionForReport."Dimension Value Code", DimensionsForPositionTC."ORG Shema", DimensionsForPositionTC."Position Description", NewDescription);
                                    DimensionsForPositionTC1."Dimension  Name" := DimensionForReport."Dimension  Name";
                                    DimensionsForPositionTC1.MODIFY;
                                END;
                            UNTIL DimensionsForPositionTC.NEXT = 0;
                        DimensionsTemporery.RESET;
                        DimensionsTemporery.SETFILTER("Department Type", '%1', 8);
                        DimensionsTemporery.SETFILTER(Sector, '%1', NewCode);
                        DimensionsTemporery.SETFILTER("Sector  Description", '%1', NewDescription);
                        DimensionsTemporery.SETFILTER("ORG Shema", '%1', "ORG Shema");
                        IF DimensionsTemporery.FINDSET THEN
                            REPEAT
                                IF DimensionsTemporery1.GET(OldCode, DimensionsTemporery."Dimension Value Code", '', '', '', '', "ORG Shema") THEN BEGIN
                                    DimensionsTemporery1.RENAME(NewCode, DimensionsTemporery."Dimension Value Code", '', '', '', '', "ORG Shema");
                                    DimensionsTemporery1.Sector := NewCode;
                                    DimensionsTemporery1."Sector  Description" := NewDescription;
                                    DimensionsTemporery1.Description := NewDescription;
                                    DimensionsTemporery1.Belongs := FORMAT(NewCode) + '-' + NewDescription;
                                    DimensionsTemporery1.MODIFY;
                                END;
                            UNTIL DimensionsTemporery.NEXT = 0;
                        DimensionForPos.RESET;
                        DimensionForPos.SETFILTER(Sector, '%1', NewCode);
                        DimensionForPos.SETFILTER("Sector  Description", '%1', NewDescription);
                        //DimensionForPos.SETFILTER("Org Belongs",'%1',OldDescription);
                        DimensionForPos.SETFILTER("Group Code", '%1', '');
                        DimensionForPos.SETFILTER("Group Description", '%1', '');
                        DimensionForPos.SETFILTER("Team Code", '%1', '');
                        DimensionForPos.SETFILTER("Team Description", '%1', '');
                        DimensionForPos.SETFILTER("Department Categ.  Description", '%1', '');
                        DimensionForPos.SETFILTER("Department Category", '%1', '');
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
                                    IF COPYSTR(DimensionForPos."Position Code", 1, STRLEN(DimensionForPos.Sector)) <> DimensionForPos.Sector THEN BEGIN
                                        NewPositionCode := DimensionForPos."Position Code";
                                    END
                                    ELSE BEGIN
                                        NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));

                                        NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        IF STRLEN(DimensionForPos."Position Code") <> STRLEN(NewPositionCode) THEN BEGIN
                                            FindZero := STRLEN(NewCode);
                                            NewPositionCode := NewCode + COPYSTR(DimensionForPos."Position Code", FindZero, STRLEN(DimensionForPos."Position Code"));
                                        END;
                                    END;

                                    DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                    DimensionForPos1.Sector := NewCode;
                                    DimensionForPos1."Sector  Description" := NewDescription;
                                    DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                    DimensionForPos1.MODIFY;
                                END;

                                IF DimensionForPos1.GET(DimensionForPos."Position Code", DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema",
                                DimensionForPos."Position Description", DimensionForPos."Org Belongs") THEN
                                    DimensionForPos1.RENAME(NewPositionCode, DimensionForPos."Dimension Value Code", DimensionForPos."ORG Shema", DimensionForPos."Position Description", NewDescription);
                                DimensionForPos1.Sector := NewCode;
                                DimensionForPos1."Sector  Description" := NewDescription;
                                DimensionForPos1.Belongs := NewPositionCode + ' ' + '-' + ' ' + DimensionForPos."Position Description";
                                DimensionForPos1.MODIFY;
                                PositionMenu.RESET;
                                PositionMenu1.RESET;
                                PositionMenu.SETFILTER(Code, '%1', DimensionForPos."Position Code");
                                PositionMenu.SETFILTER(Description, '%1', DimensionForPos."Position Description");
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        IF PositionMenu1.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure")
                                          THEN BEGIN
                                            DepartmentTempFind.RESET;
                                            DepartmentTempFind.SETFILTER("Department Type", '%1', 8);
                                            DepartmentTempFind.SETFILTER(Sector, '%1', NewCode);
                                            DepartmentTempFind.SETFILTER("Sector  Description", '%1', NewDescription);
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
                                            IF PositionMenu."Management Level".AsInteger() <> 6 THEN BEGIN
                                                //izmjena šifre pozicije

                                                Head.RESET;
                                                Head.INIT;
                                                Head."Department Code" := NewCode;
                                                Head.Sector := NewCode;
                                                Head."Sector  Description" := NewDescription;
                                                Head."ORG Shema" := RealOrgShema;
                                                Head."Position Code" := NewPositionCode;
                                                Head."Management Level" := PositionMenu."Management Level";
                                                Head."Department Categ.  Description" := '';
                                                Head."Department Category" := '';
                                                Head."Group Code" := '';
                                                Head."Group Description" := '';
                                                Head."Team Code" := '';
                                                Head."Team Description" := '';
                                                Head."ORG Shema" := RealOrgShema;
                                                //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description
                                                HeadExsist.RESET;
                                                HeadExsist.SETFILTER("Department Code", '%1', NewCode);
                                                HeadExsist.SETFILTER("ORG Shema", '%1', RealOrgShema);
                                                HeadExsist.SETFILTER("Department Categ.  Description", '%1', '');
                                                HeadExsist.SETFILTER("Group Description", '%1', '');
                                                HeadExsist.SETFILTER("Team Description", '%1', '');
                                                IF NOT HeadExsist.FINDFIRST THEN
                                                    Head.INSERT;

                                            END;


                                            IF OldDescription <> NewDescription THEN BEGIN
                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER(Sector, '%1', NewCode);
                                                ECLSystematization.SETFILTER("Sector Description", '%1', NewDescription);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := NewCode;
                                                            ECLSystematization1."Sector Description" := NewDescription;
                                                            ECLSystematization1."Department Category" := '';
                                                            ECLSystematization1."Department Cat. Description" := '';
                                                            ECLSystematization1.Group := '';
                                                            ECLSystematization1."Group Description" := '';
                                                            ECLSystematization1.Team := '';
                                                            ECLSystematization1."Team Description" := '';
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            ECLSystematization1."Dimension Value Code" := '';
                                                            ECLSystematization1."Dimension  Name" := '';
                                                            //ECLSystematization1."Org Belong":='';
                                                            //ECLSystematization1."Changing Position":=TRUE;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END
                                            ELSE BEGIN

                                                ECLSystematization.RESET;
                                                ECLSystematization.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                                ECLSystematization.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                                ECLSystematization.SETFILTER(Sector, '%1', NewCode);
                                                ECLSystematization.SETFILTER("Sector Description", '%1', NewDescription);
                                                ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                                                IF ECLSystematization.FINDSET THEN
                                                    REPEAT
                                                        ECLSystematization1.RESET;
                                                        ECLSystematization1.SETFILTER("Employee No.", '%1', ECLSystematization."Employee No.");
                                                        IF ECLSystematization1.FINDFIRST THEN BEGIN

                                                            ECLSystematization1.Sector := NewCode;
                                                            ECLSystematization1."Department Code" := NewCode;
                                                            ECLSystematization1."Position Code" := NewPositionCode;
                                                            //ECLSystematization1."Org Belong":=NewDescription;
                                                            ECLSystematization1."Sector Description" := NewDescription;
                                                            ECLSystematization1.VALIDATE("Org Belongs", NewDescription);
                                                            ECLSystematization1.MODIFY;
                                                        END;
                                                    UNTIL ECLSystematization.NEXT = 0;
                                            END;
                                           
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
                                    UNTIL PositionMenu.NEXT = 0;
                                FoundOne := FALSE;
                            UNTIL DimensionForPos.NEXT = 0;

                    END;
                    ECLSystematization.RESET;
                    ECLSystematization.SETFILTER(Sector, '%1', NewCode);
                    ECLSystematization.SETFILTER("Sector Description", '%1', NewDescription);
                    ECLSystematization.SETFILTER("Department Category", '%1', '');
                    ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                    IF ECLSystematization.FINDSET THEN
                        REPEAT
                            DimensionForPos.RESET;
                            DimensionForPos.SETFILTER("Position Code", '%1', ECLSystematization."Position Code");
                            DimensionForPos.SETFILTER("Position Description", '%1', ECLSystematization."Position Description");
                            DimensionForPos.SETFILTER(Sector, '%1', ECLSystematization.Sector);
                            DimensionForPos.SETFILTER("Sector  Description", '%1', ECLSystematization."Sector Description");
                            DimensionForPos.SETFILTER("Department Category", '%1', '');
                            DimensionForPos.SETFILTER("Department Categ.  Description", '%1', '');
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



                    DimensionForReport.RESET;
                    DimensionForReport.SETFILTER("Dimension Value Code", '<>%1', '');
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
                    field(CentralaInsert; CentralaInsert)
                    {
                        ApplicationArea = all;
                        Caption = 'Residence/Network';
                    }
                    field(OldCode; OldCode)
                    {
                        ApplicationArea = all;
                        Caption = 'Old code';
                        TableRelation = "Sector temporary".Code;
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
                    field(OldDef; OldDef)
                    {
                        ApplicationArea = all;
                        Caption = 'New official translate';
                    }

                    part("Dimensions for report"; "Dimensions for report")

                    {
                        ApplicationArea = All;
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
        OldCode: Code[50];
        DepartmentTempNew: Record "Department temporary";
        i: Integer;
        LengthString: Integer;
        String: Text;
        Brojac: Integer;
        CreateNew: Text;
        OldDef: Text;
        FirstPart: Text;
        j: Integer;
        SecondPart: Text;
        NewCode: Text;
        NewCode1: Text;
        SectorTemp: Record "Sector temporary";
        K: Integer;
        Sector2: Record "Sector temporary";
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
        DepartmnetPOs: Code[50];
        DimensionTemp: Record "Dimension temporary";
        RealOrgShema: Code[50];
        DimensionTempor: Page "Dimensions temporary";
        OrgShema: Record "ORG Shema";
        TC: Integer;
        TC2: Integer;
        F: FilterPageBuilder;
        ForFilter: Code[50];
        DimesnionFind: Record "Dimension temporary";
        DimensionForReport: Record "Dimension for report";
        SectorFindForUpdate: Record "Sector temporary";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        DimensionForReport1: Record "Dimension for report";
        PositionBenefits: Record "Position Benefits temporery";
        PositionBenefits1: Record "Position Benefits temporery";
        Head: Record "Head Of's temporary";
        Head1: Record "Head Of's temporary";
        HeadChange: Record "Head Of's temporary";
        DepartmentTempNewCorrect: Record "Department temporary";
        ECLSystematization: Record "ECL systematization";
        ECLSystematization1: Record "ECL systematization";
        PositionForDepartmentCode: Record "Position Menu temporary";
        SectorDuplicate: Record "Sector temporary";
        DepartmentDuplicate: Record "Position Menu";
        SectorFind: Record "Sector temporary";
        DepartmentC: Record "Department Category temporary";
        GroupTempHead: Record "Group temporary";
        TeamTempHead: Record "Team temporary";
        HeadExsist: Record "Head Of's temporary";
        PositionMenFind: Record "Position Menu temporary";
        PosNew: Record "Position Menu temporary";
        TempPosition: Record "Dimension temp for position";

    procedure SetParam(OldCodeSent: Code[10]; OldNameSent: Text; Centrala: Option; PromjenaInsert: Integer; OrgS: Code[10])
    begin
        OldCode := OldCodeSent;
        OldDescription := OldNameSent;
        OldCentrala := Centrala;
        Sector2.RESET;
        Sector2.SETFILTER(Code, '%1', OldCode);
        Sector2.SETFILTER(Description, '%1', OldDescription);
        Sector2.SETFILTER("Org Shema", '%1', OrgS);
        IF Sector2.FINDFIRST THEN
            OldDef := Sector2."Official Translate of Sector"
        ELSE
            OldDef := '';
        NewCode := OldCode;
        NewDescription := OldDescription;
        CentralaInsert := Centrala;
        Promjena := PromjenaInsert;
        RealOrgShema := OrgS;
    end;
}

*/