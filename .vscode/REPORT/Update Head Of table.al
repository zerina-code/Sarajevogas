report 50028 "Update Head Of table"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

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

    trigger OnPostReport()
    begin
        DepartmentTemp.RESET;
        IF DepartmentTemp.FINDSET THEN
            REPEAT
                HeadCheck.INIT;
                HeadCheck."ORG Shema" := DepartmentTemp."ORG Shema";

                OrgShemaPriprema := DepartmentTemp."ORG Shema";
                HeadCheck."Department Code" := DepartmentTemp.Code;

                //AKO JE SEKTOR
                IF DepartmentTemp."Department Type".AsInteger() = 8 THEN BEGIN
                    FindSek := FALSE;
                    HeadCheck.VALIDATE("Sector  Description", DepartmentTemp."Sector  Description");

                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Sector  Description", '%1', DepartmentTemp."Sector  Description");
                    DimensionCopy.SETFILTER("Org Belongs", '%1', DepartmentTemp."Sector  Description");
                    DimensionCopy.SETFILTER("Department Categ.  Description", '%1', '');
                    DimensionCopy.SETCURRENTKEY("Position Code");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT
                            PositionMenuFind.RESET;
                            PositionMenuFind.SETFILTER("Management Level", '%1|%2|%3', PositionMenuFind."Management Level"::Sector, PositionMenuFind."Management Level"::CEO, PositionMenuFind."Management Level"::Exe);
                            PositionMenuFind.SETFILTER(Code, '%1', DimensionCopy."Position Code");
                            PositionMenuFind.SETFILTER(Description, '%1', DimensionCopy."Position Description");
                            PositionMenuFind.SETCURRENTKEY(Code);
                            IF PositionMenuFind.FINDFIRST THEN BEGIN

                                HeadCheck."Position Code" := PositionMenuFind.Code;
                                HeadCheck."Management Level" := PositionMenuFind."Management Level";
                                HeadCheck.INSERT;
                                FindSek := TRUE;
                            END;

                        UNTIL (DimensionCopy.NEXT = 0) OR FindSek = TRUE;

                END;


                //AKO JE ODJEL

                IF DepartmentTemp."Department Type".AsInteger() = 4 THEN BEGIN
                    HeadCheck.VALIDATE("Department Categ.  Description", DepartmentTemp."Department Categ.  Description");
                    FindOdjel := FALSE;

                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Sector  Description", '%1', DepartmentTemp."Sector  Description");
                    DimensionCopy.SETFILTER("Department Categ.  Description", '%1', DepartmentTemp."Department Categ.  Description");
                    DimensionCopy.SETFILTER("Group Description", '%1', '');
                    DimensionCopy.SETFILTER("Org Belongs", '%1', DepartmentTemp."Department Categ.  Description");
                    DimensionCopy.SETCURRENTKEY("Position Code");
                    IF DimensionCopy.FINDFIRST THEN
                        REPEAT
                            PositionMenuFind.RESET;
                            PositionMenuFind.SETFILTER("Management Level", '%1', PositionMenuFind."Management Level"::"Department Category");
                            PositionMenuFind.SETFILTER(Code, '%1', DimensionCopy."Position Code");
                            PositionMenuFind.SETFILTER(Description, '%1', DimensionCopy."Position Description");
                            PositionMenuFind.SETCURRENTKEY(Code);
                            IF PositionMenuFind.FINDFIRST THEN BEGIN

                                HeadCheck."Position Code" := PositionMenuFind.Code;
                                HeadCheck."Management Level" := PositionMenuFind."Management Level";
                                HeadCheck.INSERT;
                                FindOdjel := TRUE;
                            END;

                        UNTIL (DimensionCopy.NEXT = 0) OR FindOdjel = TRUE;

                END;


                //AKO JE GRUPA

                IF DepartmentTemp."Department Type".AsInteger() = 2 THEN BEGIN
                    HeadCheck.VALIDATE("Group Description", DepartmentTemp."Group Description");
                    FindGrupa := FALSE;

                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Sector  Description", '%1', DepartmentTemp."Sector  Description");
                    DimensionCopy.SETFILTER("Department Categ.  Description", '%1', DepartmentTemp."Department Categ.  Description");
                    DimensionCopy.SETFILTER("Group Description", '%1', DepartmentTemp."Group Description");
                    DimensionCopy.SETFILTER("Team Description", '%1', '');
                    DimensionCopy.SETFILTER("Org Belongs", '%1', DepartmentTemp."Group Description");
                    DimensionCopy.SETCURRENTKEY("Position Code");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT
                            PositionMenuFind.RESET;
                            PositionMenuFind.SETFILTER("Management Level", '%1', PositionMenuFind."Management Level"::Group);
                            PositionMenuFind.SETFILTER(Code, '%1', DimensionCopy."Position Code");
                            PositionMenuFind.SETFILTER(Description, '%1', DimensionCopy."Position Description");
                            PositionMenuFind.SETCURRENTKEY(Code);
                            IF PositionMenuFind.FINDFIRST THEN BEGIN

                                HeadCheck."Position Code" := PositionMenuFind.Code;
                                HeadCheck."Management Level" := PositionMenuFind."Management Level";
                                HeadCheck.INSERT;
                                FindGrupa := TRUE;
                            END;
                        UNTIL (DimensionCopy.NEXT = 0) OR (FindGrupa = TRUE);
                END;


                IF DepartmentTemp."Department Type".AsInteger() = 9 THEN BEGIN
                    IF DepartmentTemp."Entity of Agency" <> DepartmentTemp."Entity of Agency"::" " THEN BEGIN
                        HeadCheck."Team Description" := DepartmentTemp."Team Description";
                        HeadCheck."Team Code" := DepartmentTemp."Team Code";
                        HeadCheck."Group Code" := DepartmentTemp."Group Code";
                        HeadCheck."Group Description" := DepartmentTemp."Group Description";
                        HeadCheck."Sector  Description" := DepartmentTemp."Sector  Description";
                        HeadCheck.Sector := DepartmentTemp.Sector;
                        HeadCheck."Department Category" := DepartmentTemp."Department Category";
                        HeadCheck."Department Categ.  Description" := DepartmentTemp."Department Categ.  Description";
                        HeadCheck."Department Code" := DepartmentTemp."Team Code";
                    END
                    ELSE BEGIN

                        HeadCheck.VALIDATE("Team Description", DepartmentTemp."Team Description");
                    END;
                    FindTim := FALSE;
                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Sector  Description", '%1', DepartmentTemp."Sector  Description");
                    DimensionCopy.SETFILTER("Department Categ.  Description", '%1', DepartmentTemp."Department Categ.  Description");
                    DimensionCopy.SETFILTER("Group Description", '%1', DepartmentTemp."Group Description");
                    DimensionCopy.SETFILTER("Team Description", '%1', DepartmentTemp."Team Description");
                    DimensionCopy.SETFILTER("Org Belongs", '%1', DepartmentTemp."Team Description");
                    DimensionCopy.SETCURRENTKEY("Position Code");
                    IF DimensionCopy.FINDFIRST THEN
                        REPEAT
                            PositionMenuFind.RESET;
                            PositionMenuFind.SETFILTER("Management Level", '%1', 7);
                            PositionMenuFind.SETFILTER(Code, '%1', DimensionCopy."Position Code");
                            PositionMenuFind.SETFILTER(Description, '%1', DimensionCopy."Position Description");
                            PositionMenuFind.SETCURRENTKEY(Code);
                            IF PositionMenuFind.FINDFIRST THEN BEGIN

                                HeadCheck."Position Code" := PositionMenuFind.Code;
                                HeadCheck."Management Level" := PositionMenuFind."Management Level";
                                HeadCheck.INSERT;
                                FindTim := TRUE;
                            END;

                        UNTIL (DimensionCopy.NEXT = 0) OR (FindTim = TRUE);
                END;

            UNTIL DepartmentTemp.NEXT = 0;



        //azuriraj podatke za GPS.


        SectorParent.RESET;
        SectorParent.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF SectorParent.FINDSET THEN
            REPEAT
                IF STRLEN(SectorParent.Code) >= 3 THEN BEGIN
                    SectorParent2.RESET;
                    SectorParent2.SETFILTER("ORG Shema", '%1', SectorParent."Org Shema");
                    SectorParent2.SETFILTER(Sector, '%1', COPYSTR(SectorParent.Code, 1, 2));
                    SectorParent2.SETFILTER("Management Level", '%1|%2', SectorParent2."Management Level"::CEO, SectorParent2."Management Level"::Exe);
                    IF SectorParent2.FINDFIRST THEN BEGIN
                        SectorParent.Parent := SectorParent2."Sector  Description";
                        SectorParent.MODIFY;
                    END
                    ELSE BEGIN
                        /* SectorParent2.RESET;
                         SectorParent2.CHANGECOMPANY(CompanyInf.Name);
                          SectorParent2.SETFILTER("ORG Shema",'%1',SectorParent."Org Shema");
                          SectorParent2.SETFILTER("Management Level",'%1',SectorParent2."Management Level"::CEO);
                          IF SectorParent2.FINDFIRST THEN BEGIN
                            SectorParent.Parent:=SectorParent2."Sector  Description";
                            SectorParent.MODIFY;
                            END;*/
                        Positiiiiiooo.RESET;
                        Positiiiiiooo.SETFILTER(Sector, '%1', SectorParent.Code);
                        Positiiiiiooo.SETFILTER("Sector  Description", '%1', SectorParent.Description);
                        Positiiiiiooo.SETFILTER("Org. Structure", '%1', SectorParent."Org Shema");
                        Positiiiiiooo.SETFILTER("Management Level", '<>%1 & <>%2', Positiiiiiooo."Management Level"::Empty, Positiiiiiooo."Management Level"::E);
                        IF Positiiiiiooo.FINDFIRST THEN BEGIN
                            SectorParent2.RESET;
                            SectorParent2.SETFILTER("ORG Shema", '%1', SectorParent."Org Shema");
                            SectorParent2.SETFILTER("Department Code", '%1', Positiiiiiooo."Disc. Department Code");
                            IF Positiiiiiooo."Disc. Department Name" <> '' THEN
                                SectorParent2.SETFILTER("Sector  Description", '%1', Positiiiiiooo."Disc. Department Name");

                            IF SectorParent2.FINDFIRST THEN BEGIN
                                SectorParent.Parent := SectorParent2."Sector  Description";
                                SectorParent.MODIFY;
                            END;


                        END
                        ELSE BEGIN
                            SectorParent2.RESET;
                            SectorParent2.SETFILTER("ORG Shema", '%1', SectorParent."Org Shema");
                            SectorParent2.SETFILTER("Management Level", '%1', SectorParent2."Management Level"::CEO);
                            IF SectorParent2.FINDFIRST THEN BEGIN
                                SectorParent.Parent := SectorParent2."Sector  Description";
                                SectorParent.MODIFY;
                            END;

                        END;


                    END;

                END;


            UNTIL SectorParent.NEXT = 0;


        DepParent22.RESET;
        DepParent22.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF DepParent22.FINDSET THEN
            REPEAT

                SectorParent.RESET;
                SectorParent.SETFILTER(Code, '%1', COPYSTR(DepParent22.Code, 1, 4));
                SectorParent.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
                IF SectorParent.FINDFIRST THEN BEGIN

                    DepParent22.Parent := SectorParent.Description;
                    DepParent22.MODIFY;
                END;


            UNTIL DepParent22.NEXT = 0;










        SectorGPsNew.RESET;
        SectorGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF SectorGPsNew.FINDSET THEN
            REPEAT

                SectorGPsOld.RESET;
                SectorGPsOld.SETFILTER(Description, '%1', SectorGPsNew.Description);
                SectorGPsOld.SETFILTER("Official Translate of Sector", '%1', SectorGPsNew."Official Translate of Sector");
                SectorGPsOld.SETFILTER(Parent, '%1', SectorGPsNew.Parent);
                SectorGPsOld.SETFILTER("Org Shema", '<>%1', OrgShemaPriprema);
                SectorGPsOld.SETCURRENTKEY("Org Shema");
                SectorGPsOld.ASCENDING(FALSE);
                IF SectorGPsOld.FINDFIRST THEN BEGIN
                    SectorGPsNew."ID for GPS" := SectorGPsOld."ID for GPS";
                    SectorGPsNew.MODIFY;
                END;

            UNTIL SectorGPsNew.NEXT = 0;





        DepGPsNew.RESET;
        DepGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF DepGPsNew.FINDSET THEN
            REPEAT

                DepGPsOld.RESET;
                DepGPsOld.SETFILTER(Description, '%1', DepGPsNew.Description);
                DepGPsOld.SETFILTER(Parent, '%1', DepGPsNew.Parent);
                DepGPsOld.SETFILTER("Official Translate of DepCat", '%1', DepGPsNew."Official Translate of DepCat");
                DepGPsOld.SETFILTER("Org Shema", '<>%1', OrgShemaPriprema);
                DepGPsOld.SETCURRENTKEY("Org Shema");
                DepGPsOld.ASCENDING(FALSE);
                IF DepGPsOld.FINDFIRST THEN BEGIN
                    DepGPsNew."ID for GPS" := DepGPsOld."ID for GPS";
                    DepGPsNew.MODIFY;
                END;

            UNTIL DepGPsNew.NEXT = 0;




        GroupGPsNew.RESET;
        GroupGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF GroupGPsNew.FINDSET THEN
            REPEAT

                GroupGPsOld.RESET;
                GroupGPsOld.SETFILTER("Official Translate of Group", '%1', GroupGPsNew."Official Translate of Group");
                GroupGPsOld.SETFILTER(Description, '%1', GroupGPsNew.Description);
                GroupGPsOld.SETFILTER("Belongs to Department Category", '%1', GroupGPsNew."Belongs to Department Category");
                GroupGPsOld.SETFILTER("Org Shema", '<>%1', OrgShemaPriprema);
                GroupGPsOld.SETCURRENTKEY("Org Shema");
                GroupGPsOld.ASCENDING(FALSE);
                IF GroupGPsOld.FINDFIRST THEN BEGIN
                    GroupGPsNew."ID for GPS" := GroupGPsOld."ID for GPS";
                    GroupGPsNew.MODIFY;
                END;

            UNTIL GroupGPsNew.NEXT = 0;



        TeamGPsNew.RESET;
        TeamGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        IF TeamGPsNew.FINDSET THEN
            REPEAT

                TeamOld.RESET;
                TeamOld.SETFILTER("Official Translate of Team", '%1', TeamGPsNew."Official Translate of Team");
                TeamOld.SETFILTER(Description, '%1', TeamGPsNew.Description);
                TeamOld.SETFILTER("Belongs to Group", '%1', TeamGPsNew."Belongs to Group");
                TeamOld.SETFILTER("Org Shema", '<>%1', OrgShemaPriprema);
                TeamOld.SETCURRENTKEY("Org Shema");
                TeamOld.ASCENDING(FALSE);
                IF TeamOld.FINDFIRST THEN BEGIN
                    TeamGPsNew."ID for GPS" := TeamOld."ID for GPS";
                    TeamGPsNew.MODIFY;
                END;

            UNTIL TeamGPsNew.NEXT = 0;


        SljedeciBroj := 0;

        CompanyInf.RESET;
        IF CompanyInf.FINDSET THEN
            REPEAT
                InformationOfCompany.RESET;
                InformationOfCompany.CHANGECOMPANY(CompanyInf.Name);
                InformationOfCompany.GET;
                IF InformationOfCompany."Company Prefix" <> '' THEN BEGIN


                    SectorSljedeci.RESET;
                    SectorSljedeci.CHANGECOMPANY(CompanyInf.Name);
                    SectorSljedeci.SETCURRENTKEY("ID for GPS");
                    SectorSljedeci.ASCENDING;
                    IF SectorSljedeci.FINDLAST THEN BEGIN
                        IF SectorSljedeci."ID for GPS" > SljedeciBroj THEN
                            SljedeciBroj := SectorSljedeci."ID for GPS";
                    END;


                    DepartmentSljedeci.RESET;
                    DepartmentSljedeci.CHANGECOMPANY(CompanyInf.Name);
                    DepartmentSljedeci.SETCURRENTKEY("ID for GPS");
                    DepartmentSljedeci.ASCENDING;
                    IF DepartmentSljedeci.FINDLAST THEN BEGIN
                        IF DepartmentSljedeci."ID for GPS" > SljedeciBroj THEN
                            SljedeciBroj := DepartmentSljedeci."ID for GPS";
                    END;

                    GroupSljedeci.RESET;
                    GroupSljedeci.CHANGECOMPANY(CompanyInf.Name);
                    GroupSljedeci.SETCURRENTKEY("ID for GPS");
                    GroupSljedeci.ASCENDING;
                    IF GroupSljedeci.FINDLAST THEN BEGIN
                        IF GroupSljedeci."ID for GPS" > SljedeciBroj THEN
                            SljedeciBroj := GroupSljedeci."ID for GPS";
                    END;

                    TeamSljedeci.RESET;
                    TeamSljedeci.CHANGECOMPANY(CompanyInf.Name);
                    TeamSljedeci.SETCURRENTKEY("ID for GPS");
                    TeamSljedeci.ASCENDING;
                    IF TeamSljedeci.FINDLAST THEN BEGIN
                        IF TeamSljedeci."ID for GPS" > SljedeciBroj THEN
                            SljedeciBroj := TeamSljedeci."ID for GPS";
                    END;

                END;
            UNTIL CompanyInf.NEXT = 0;



        //NOVI BROJEVi

        SectorGPsNew.RESET;
        SectorGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        SectorGPsNew.SETFILTER("ID for GPS", '%1', 0);
        SectorGPsNew.SETFILTER(Code, '<>%1', '0');
        IF SectorGPsNew.FINDSET THEN
            REPEAT


                SectorGPsNew."ID for GPS" := SljedeciBroj + 1;
                SljedeciBroj := SljedeciBroj + 1;
                SectorGPsNew.MODIFY;

            UNTIL SectorGPsNew.NEXT = 0;





        DepGPsNew.RESET;
        DepGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        DepGPsNew.SETFILTER("ID for GPS", '%1', 0);
        DepGPsNew.SETFILTER(Code, '<>%1', '0');
        IF DepGPsNew.FINDSET THEN
            REPEAT

                DepGPsNew."ID for GPS" := SljedeciBroj + 1;
                SljedeciBroj := SljedeciBroj + 1;
                DepGPsNew.MODIFY;


            UNTIL DepGPsNew.NEXT = 0;




        GroupGPsNew.RESET;
        GroupGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        GroupGPsNew.SETFILTER("ID for GPS", '%1', 0);
        GroupGPsNew.SETFILTER(Code, '<>%1', '0');
        IF GroupGPsNew.FINDSET THEN
            REPEAT


                GroupGPsNew."ID for GPS" := SljedeciBroj + 1;
                SljedeciBroj := SljedeciBroj + 1;
                GroupGPsNew.MODIFY;


            UNTIL GroupGPsNew.NEXT = 0;



        TeamGPsNew.RESET;
        TeamGPsNew.SETFILTER("Org Shema", '%1', OrgShemaPriprema);
        TeamGPsNew.SETFILTER("ID for GPS", '%1', 0);
        TeamGPsNew.SETFILTER(Code, '<>%1', '0');
        IF TeamGPsNew.FINDSET THEN
            REPEAT


                TeamGPsNew."ID for GPS" := SljedeciBroj + 1;
                SljedeciBroj := SljedeciBroj + 1;
                TeamGPsNew.MODIFY;


            UNTIL TeamGPsNew.NEXT = 0;





    end;

    trigger OnPreReport()
    begin
        HeadCheck.RESET;
        HeadCheck.DELETEALL;
    end;

    var
        DepartmentTemp: Record "Department temporary";
        HeadCheck: Record "Head Of's temporary";
        DimensionCopy: Record "Dimension temp for position";
        PositionMenuFind: Record "Position Menu temporary";
        FindSek: Boolean;
        FindOdjel: Boolean;
        FindGrupa: Boolean;
        FindTim: Boolean;
        OrgShemaPriprema: Code[20];
        SectorGPsNew: Record "Sector";
        SectorGPsOld: Record "Sector";
        DepGPsNew: Record "Department Category";
        DepGPsOld: Record "Department Category";
        GroupGPsNew: Record "Group";
        GroupGPsOld: Record "Group";
        TeamGPsNew: Record "TeamT";
        TeamOld: Record "TeamT";
        SectorParent: Record "Sector";
        DepParent: Record "Department Category";
        SectorParent2: Record "Head Of's";
        DepParent2: Record "Department Category";
        Positiiiiiooo: Record "Position";
        DepParent22: Record "Department Category";
        SljedeciBroj: Integer;
        SectorSljedeci: Record "Sector";
        DepartmentSljedeci: Record "Department Category";
        GroupSljedeci: Record "Group";
        TeamSljedeci: Record "TeamT";
        CompanyInf: Record "Company";
        InformationOfCompany: Record "Company Information";
}

