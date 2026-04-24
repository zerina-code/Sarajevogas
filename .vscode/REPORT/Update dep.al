report 50015 "Update dep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Update dep.rdlc';
    Caption = 'Update ECL';
    ProcessingOnly = false;
    ShowPrintStatus = true;
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

    trigger OnPreReport()
    begin
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
        IF OrgShema.FINDFIRST THEN BEGIN

            SectorOrginal.RESET;
            SectorOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
            IF SectorOrginal.FINDSET THEN
                REPEAT
                    SectorOrginal.DELETE;
                UNTIL SectorOrginal.NEXT = 0;

            PosMinimal.Reset();
            PosMinimal.SetFilter("Org Shema", '%1', OrgShema.code);
            if PosMinimal.FindSet() then
                repeat
                    PosMinimal.Delete();
                until PosMinimal.Next() = 0;

            ExeManager.Reset();
            ExeManager.SetFilter("ORG Shema", '%1', OrgShema.Code);
            if ExeManager.FindSet() then
                repeat
                    ExeManager.Delete();
                until ExeManager.Next() = 0;

            DepCatOrginal.RESET;
            DepCatOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
            IF DepCatOrginal.FINDSET THEN
                REPEAT
                    DepCatOrginal.DELETE;
                UNTIL DepCatOrginal.NEXT = 0;

            GroupOrginal.RESET;
            GroupOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
            IF GroupOrginal.FINDSET THEN
                REPEAT
                    GroupOrginal.DELETE;
                UNTIL GroupOrginal.NEXT = 0;
            TeamOrginal.RESET;
            TeamOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
            IF TeamOrginal.FINDSET THEN
                REPEAT
                    TeamOrginal.DELETE;
                UNTIL TeamOrginal.NEXT = 0;


            DepartmentOrginal.RESET;
            DepartmentOrginal.SETFILTER("ORG Shema", '%1', OrgShema.Code);
            IF DepartmentOrginal.FINDSET THEN
                REPEAT
                    DepartmentOrginal.DELETE;
                UNTIL DepartmentOrginal.NEXT = 0;

            HeadOfOrginal.RESET;
            HeadOfOrginal.SETFILTER("ORG Shema", '%1', OrgShema.Code);
            IF HeadOfOrginal.FINDSET THEN
                REPEAT
                    HeadOfOrginal.DELETE;
                UNTIL HeadOfOrginal.NEXT = 0;

            DimensionOrginalPos.RESET;
            DimensionOrginalPos.SETFILTER("ORG Shema", '%1', OrgShema.Code);
            IF DimensionOrginalPos.FINDSET THEN
                REPEAT
                    DimensionOrginalPos.DELETE;
                UNTIL DimensionOrginalPos.NEXT = 0;
            BenefitsOrginal.RESET;
            BenefitsOrginal.SETFILTER("Org. Structure", '%1', OrgShema.Code);
            IF BenefitsOrginal.FINDSET THEN
                REPEAT
                    BenefitsOrginal.DELETE;
                UNTIL BenefitsOrginal.NEXT = 0;
            PositionMenuOrginal.RESET;
            PositionMenuOrginal.SETFILTER("Org. Structure", '%1', OrgShema.Code);
            IF PositionMenuOrginal.FINDSET THEN
                REPEAT
                    PositionMenuOrginal.DELETE;
                UNTIL PositionMenuOrginal.NEXT = 0;

            //HeadOfOrginal



            SectorOrginal.RESET;
            SectorOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
            IF NOT SectorOrginal.FINDFIRST THEN BEGIN
                IF SectorTemp.FINDSET THEN
                    REPEAT
                        SectorOrginal.INIT;
                        SectorOrginal.TRANSFERFIELDS(SectorTemp);
                        SectorOrginal1.SETFILTER(Code, '%1', SectorOrginal.Code);
                        SectorOrginal1.SETFILTER(Description, '%1', SectorOrginal.Description);
                        SectorOrginal1.SETFILTER("Org Shema", '%1', OrgShema.Code);
                        IF NOT SectorOrginal1.FINDFIRST THEN BEGIN
                            OrgSNew.RESET;
                            OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                            IF OrgSNew.FINDFIRST THEN BEGIN
                                SectorOrginal."Last Date Modified" := OrgSNew."Date From";
                                SectorOrginal."Operator No." := OrgSNew."Operator No.";
                            END;

                            //ovdje da pronađem id za gps ako postoji




                            /*    SectorParent22.RESET;
                                SectorParent22.SETFILTER("ORG Shema", '%1', SectorTemp."Org Shema");
                                SectorParent22.SETFILTER(Sector, '%1', COPYSTR(SectorTemp.Code, 1, 2));
                                SectorParent22.SETFILTER("Management Level", '%1|%2|%3', SectorParent22."Management Level"::CEO, SectorParent22."Management Level"::Exe, SectorParent22."Management Level"::Sector);
                                SectorParent22.SETCURRENTKEY("ORG Shema");
                                SectorParent22.ASCENDING(FALSE);
                                IF SectorParent22.FINDFIRST THEN BEGIN
                                    SectorOrginal.Parent := SectorParent22."Sector  Description";
                                END
                                ELSE BEGIN
                                    SectorOrginal.Parent := '';
                                END;*/

                            SectorParent2.RESET;
                            SectorParent2.SETFILTER("Org Shema", '<>%1', SectorTemp."Org Shema");
                            SectorParent2.SETFILTER(Code, '%1', SectorOrginal.Code);
                            SectorParent2.SETFILTER(Description, '%1', SectorOrginal.Description);
                            SectorParent2.SETFILTER(Parent, '%1', SectorOrginal.Parent);
                            IF SectorParent2.FINDFIRST THEN BEGIN
                                SectorOrginal."ID for GPS" := SectorParent2."ID for GPS";
                                SectorOrginal.Ispis := FALSE;
                            END
                            ELSE BEGIN
                                SectorOrginal."ID for GPS" := 0;
                                SectorOrginal.Ispis := FALSE;
                            END;

                            //ID za gps završava


                            SectorOrginal.INSERT;
                        END;
                    UNTIL SectorTemp.NEXT = 0;
            END;




            IF DepCatTemp.FINDSET THEN
                REPEAT
                    DepCatOrginal.INIT;
                    DepCatOrginal.TRANSFERFIELDS(DepCatTemp);
                    DepCatOrginal1.SETFILTER(Description, '%1', DepCatOrginal.Description);
                    DepCatOrginal1.SETFILTER(Code, '%1', DepCatOrginal.Code);
                    DepCatOrginal1.SETFILTER("Org Shema", '%1', OrgShema.Code);
                    IF NOT DepCatOrginal1.FINDFIRST THEN BEGIN
                        OrgSNew.RESET;
                        OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                        IF OrgSNew.FINDFIRST THEN BEGIN
                            DepCatOrginal."Last Date Modified" := OrgSNew."Date From";
                            DepCatOrginal."Operator No." := OrgSNew."Operator No.";
                        END;



                        DepCat22.RESET;
                        DepCat22.SETFILTER("Org Shema", '<>%1', DepCatOrginal."Org Shema");
                        DepCat22.SETFILTER(Code, '%1', DepCatOrginal.Code);
                        DepCat22.SETFILTER(Description, '%1', DepCatOrginal.Description);
                        DepCat22.SETFILTER(Parent, '%1', DepCatOrginal.Parent);
                        IF DepCat22.FINDFIRST THEN BEGIN
                            DepCatOrginal."ID for GPS" := DepCat22."ID for GPS";
                            DepCatOrginal.Ispis := FALSE;
                        END
                        ELSE BEGIN
                            DepCatOrginal."ID for GPS" := 0;
                            DepCatOrginal.Ispis := FALSE;
                        END;

                        DepCatOrginal.INSERT;
                    END;
                UNTIL DepCatTemp.NEXT = 0;

            if PosMinimalTemp.FindSet() then
                repeat
                    PosMinimalInit.Init();
                    PosMinimalInit.TransferFields(PosMinimalTemp);
                    PosMinimal.Reset();
                    PosMinimal.SetFilter("Org Shema", '%1', PosMinimalInit."Org Shema");
                    PosMinimal.SetFilter("Position Code", '%1', PosMinimalInit."Position Code");
                    PosMinimal.SetFilter("Minimal Education Level", '%1', PosMinimalInit."Minimal Education Level");
                    PosMinimal.SetFilter("School of Graduation", '%1', PosMinimalInit."School of Graduation");
                    if not PosMinimal.FindFirst() then
                        PosMinimalInit.Insert();
                until PosMinimalTemp.Next() = 0;


            if ExeMTemp.FindSet() then
                repeat
                    ExeManagerInit.Init();
                    ExeManagerInit.TransferFields(ExeMTemp);
                    ExeManager.Reset();
                    ExeManager.SetFilter("Org Shema", '%1', ExeManagerInit."Org Shema");
                    ExeManager.SetFilter("Position Code", '%1', ExeManagerInit."Position Code");
                    ExeManager.SetFilter("Subordinate Org Description", '%1', ExeManagerInit."Subordinate Org Description");

                    if not ExeManager.FindFirst() then
                        ExeManagerInit.Insert();
                until ExeMTemp.Next() = 0;







            IF GroupTemp.FINDSET THEN
                REPEAT
                    GroupOrginal.INIT;
                    GroupOrginal.TRANSFERFIELDS(GroupTemp);
                    GroupOrginal1.SETFILTER(Description, '%1', GroupOrginal.Description);
                    GroupOrginal1.SETFILTER(Code, '%1', GroupOrginal.Code);
                    GroupOrginal1.SETFILTER("Org Shema", '%1', OrgShema.Code);
                    IF NOT GroupOrginal1.FINDFIRST THEN BEGIN
                        OrgSNew.RESET;
                        OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                        IF OrgSNew.FINDFIRST THEN BEGIN
                            GroupOrginal."Last Date Modified" := OrgSNew."Date From";
                            GroupOrginal."Operator No." := OrgSNew."Operator No.";
                        END;
                        //ID za gps
                        GroupCat22.RESET;
                        GroupCat22.SETFILTER("Org Shema", '<>%1', GroupOrginal."Org Shema");
                        GroupCat22.SETFILTER(Code, '%1', GroupOrginal.Code);
                        GroupCat22.SETFILTER(Description, '%1', GroupOrginal.Description);
                        GroupCat22.SETFILTER("Belongs to Department Category", '%1', GroupOrginal."Belongs to Department Category");
                        IF GroupCat22.FINDFIRST THEN BEGIN
                            GroupOrginal."ID for GPS" := GroupCat22."ID for GPS";
                            GroupOrginal.Ispis := FALSE;
                        END
                        ELSE BEGIN
                            GroupOrginal."ID for GPS" := 0;
                            GroupOrginal.Ispis := FALSE;
                        END;
                        //ID za gps
                        GroupOrginal.INSERT;
                    END;
                UNTIL GroupTemp.NEXT = 0;

            IF TeamTemp.FINDSET THEN
                REPEAT
                    TeamOrginal.INIT;
                    TeamOrginal.TRANSFERFIELDS(TeamTemp);
                    TeamOrginal1.SETFILTER(Name, '%1', TeamOrginal.Name);
                    TeamOrginal1.SETFILTER(Code, '%1', TeamOrginal.Code);
                    TeamOrginal1.SETFILTER("Org Shema", '%1', OrgShema.Code);
                    IF NOT TeamOrginal1.FINDFIRST THEN BEGIN
                        OrgSNew.RESET;
                        OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                        IF OrgSNew.FINDFIRST THEN BEGIN
                            TeamOrginal."Last Date Modified" := OrgSNew."Date From";
                            TeamOrginal."Operator No." := OrgSNew."Operator No.";
                        END;
                        //ID za gps
                        TeamCat22.RESET;
                        TeamCat22.SETFILTER("Org Shema", '<>%1', TeamOrginal."Org Shema");
                        TeamCat22.SETFILTER(Code, '%1', TeamOrginal.Code);
                        TeamCat22.SETFILTER(Name, '%1', TeamOrginal.Name);
                        TeamCat22.SETFILTER("Belongs to Group", '%1', TeamOrginal."Belongs to Group");
                        IF TeamCat22.FINDFIRST THEN BEGIN
                            TeamOrginal."ID for GPS" := TeamCat22."ID for GPS";
                            TeamOrginal.Ispis := FALSE;
                        END
                        ELSE BEGIN
                            TeamOrginal."ID for GPS" := 0;
                            TeamOrginal.Ispis := FALSE;
                        END;
                        //ID za gps
                        TeamOrginal.INSERT;
                    END;
                UNTIL TeamTemp.NEXT = 0;
            IF DepartmentTemp.FINDSET THEN
                REPEAT
                    DepartmentOrginal.INIT;
                    DepartmentOrginal.TRANSFERFIELDS(DepartmentTemp);
                    DepartmentOrginal1.SETFILTER(Description, '%1', DepartmentOrginal.Description);
                    DepartmentOrginal1.SETFILTER(Code, '%1', DepartmentOrginal.Code);
                    DepartmentOrginal1.SETFILTER("Department Categ.  Description", '%1', DepartmentOrginal."Department Categ.  Description");
                    DepartmentOrginal1.SETFILTER("Group Description", '%1', DepartmentOrginal."Group Description");
                    DepartmentOrginal1.SETFILTER("Team Description", '%1', DepartmentOrginal."Team Description");
                    DepartmentOrginal1.SETFILTER("ORG Shema", '%1', OrgShema.Code);
                    IF NOT DepartmentOrginal1.FINDFIRST THEN
                        DepartmentOrginal.INSERT;
                UNTIL DepartmentTemp.NEXT = 0;
            IF HeadOfTemp.FINDSET THEN
                REPEAT
                    HeadOfOrginal.INIT;
                    HeadOfOrginal.TRANSFERFIELDS(HeadOfTemp);
                    HeadOfOrginal1.SETFILTER("Department Code", '%1', HeadOfOrginal."Department Code");
                    HeadOfOrginal1.SETFILTER("Sector  Description", '%1', HeadOfOrginal."Sector  Description");
                    HeadOfOrginal1.SETFILTER("Department Categ.  Description", '%1', HeadOfOrginal."Department Categ.  Description");
                    HeadOfOrginal1.SETFILTER("Group Description", '%1', HeadOfOrginal."Group Description");
                    HeadOfOrginal1.SETFILTER("Team Description", '%1', HeadOfOrginal."Team Description");
                    HeadOfOrginal1.SETFILTER("ORG Shema", '%1', OrgShema.Code);
                    IF NOT HeadOfOrginal1.FINDFIRST THEN
                        HeadOfOrginal.INSERT;
                UNTIL HeadOfTemp.NEXT = 0;
            IF DimensionTempPos.FINDSET THEN
                REPEAT
                    DimensionOrginalPos.INIT;
                    DimensionOrginalPos.TRANSFERFIELDS(DimensionTempPos);
                    DimensionOrginalPos1.RESET;
                    DimensionOrginalPos1.SETFILTER("Position Code", '%1', DimensionOrginalPos."Position Code");
                    DimensionOrginalPos1.SETFILTER("Position Description", '%1', DimensionOrginalPos."Position Description");
                    DimensionOrginalPos1.SETFILTER("Dimension Value Code", '%1', DimensionOrginalPos."Dimension Value Code");
                    DimensionOrginalPos1.SETFILTER("Org Belongs", '%1', DimensionOrginalPos."Org Belongs");
                    DimensionOrginalPos1.SETFILTER("ORG Shema", '%1', OrgShema.Code);
                    IF NOT DimensionOrginalPos1.FIND('-') THEN
                        DimensionOrginalPos.INSERT;
                UNTIL DimensionTempPos.NEXT = 0;
            BenefitsTemp.RESET;
            BenefitsTemp.SETFILTER("Org. Structure", '%1', '');
            IF BenefitsTemp.FINDSET THEN
                REPEAT
                    //Position Code,Code,Description,Position Name,Org. Structure
                    IF BenefitsTemp2.GET(BenefitsTemp."Position Code", BenefitsTemp.Code, BenefitsTemp.Description, BenefitsTemp."Position Name", BenefitsTemp."Org. Structure") THEN
                        BenefitsTemp2.RENAME(BenefitsTemp."Position Code", BenefitsTemp.Code, BenefitsTemp.Description, BenefitsTemp."Position Name", OrgShema.Code)
UNTIL BenefitsTemp.NEXT = 0;
            BenefitsTemp.RESET;
            IF BenefitsTemp.FINDSET THEN
                REPEAT
                    BenefitsOrginal.INIT;
                    BenefitsOrginal.TRANSFERFIELDS(BenefitsTemp);
                    BenefitsOrginal1.RESET;
                    BenefitsOrginal1.SETFILTER("Position Code", '%1', BenefitsOrginal."Position Code");
                    BenefitsOrginal1.SETFILTER("Position Name", '%1', BenefitsOrginal."Position Name");
                    BenefitsOrginal1.SETFILTER(Code, '%1', BenefitsOrginal.Code);
                    BenefitsOrginal1.SETFILTER("Org. Structure", '%1', BenefitsOrginal."Org. Structure");
                    IF NOT BenefitsOrginal1.FINDFIRST THEN
                        BenefitsOrginal.INSERT;
                UNTIL BenefitsTemp.NEXT = 0;
            PositionMenuTemp.CALCFIELDS("Number of dimension value");
            PositionMenuTemp.SETFILTER("Number of dimension value", '<=%1', 1);
            IF PositionMenuTemp.FINDSET THEN
                REPEAT
                    PositionMenuTemp.CALCFIELDS("Number of dimension value");
                    IF PositionMenuTemp."Number of dimension value" <= 1 THEN BEGIN
                        PositionMenuOrginal.INIT;
                        PositionMenuOrginal.TRANSFERFIELDS(PositionMenuTemp);
                        Dimens.RESET;
                        Dimens.SETFILTER("Position Code", '%1', PositionMenuTemp.Code);
                        Dimens.SETFILTER("Position Description", '%1', PositionMenuTemp.Description);
                        Dimens.SETFILTER("ORG Shema", '%1', PositionMenuTemp."Org. Structure");
                        IF Dimens.FINDFIRST THEN BEGIN
                            DepartmentTemp.RESET;
                            DepartmentTemp.SETFILTER(Description, '%1', Dimens."Org Belongs");
                            DepartmentTemp.SETFILTER("ORG Shema", '%1', PositionMenuTemp."Org. Structure");
                            IF DepartmentTemp.FINDFIRST THEN
                                PositionMenuOrginal."Department Code" := DepartmentTemp.Code;
                        END;
                        PoSMenDUp.RESET;
                        PoSMenDUp.SETFILTER(Code, '%1', PositionMenuOrginal.Code);
                        PoSMenDUp.SETFILTER(Description, '%1', PositionMenuOrginal.Description);
                        PoSMenDUp.SETFILTER("Department Code", '%1', PositionMenuOrginal."Department Code");
                        PoSMenDUp.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                        IF NOT PoSMenDUp.FINDFIRST THEN BEGIN
                            PositionMenuOrginal."Org. Structure" := OrgShema.Code;
                            OrgSNew.RESET;
                            OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                            IF OrgSNew.FINDFIRST THEN BEGIN
                                PositionMenuOrginal."Last Date Modified" := OrgSNew."Date From";
                                PositionMenuOrginal."Operator No." := OrgSNew."Operator No.";
                                PosLast.RESET;
                                PosLast.SETCURRENTKEY("Position Menu Identity");
                                PosLast.ASCENDING;
                                IF PosLast.FINDLAST THEN
                                    PositionMenuOrginal."Position Menu Identity" := PosLast."Position Menu Identity" + 1;
                            END;

                            PositionMenuOrginal.INSERT;
                        END;
                    END;
                UNTIL PositionMenuTemp.NEXT = 0;


            /*


              PositionMenuOrginal.RESET;
                     PositionMenuOrginal.SETFILTER("Department Code",'%1','');
                     PositionMenuOrginal.SETFILTER("Org. Structure",'%1',OrgShema.Code);
                     IF PositionMenuOrginal.FINDSET THEN REPEAT
                    DimensionTempPos.RESET;
                    DimensionTempPos.SETFILTER("Position Code",'%1',PositionMenuOrginal.Code);
                    DimensionTempPos.SETFILTER("Position Description",'%1',PositionMenuOrginal.Description);
                    IF DimensionTempPos.FINDSET THEN REPEAT
                        PositionMenuOrginal1.INIT;
                      PositionMenuOrginal1.Code:=DimensionTempPos."Position Code";
                      PositionMenuOrginal1.Description:=DimensionTempPos."Position Description";
                      PositionMenuOrginal1."Org. Structure":=OrgShema.Code;
                      PositionMenuOrginal1."Key Function":=PositionMenuOrginal."Key Function";
                       PositionMenuOrginal1."Control Function":=PositionMenuOrginal."Control Function";
                        PositionMenuOrginal1."BJF/GJF":=PositionMenuOrginal."BJF/GJF";
                         PositionMenuOrginal1."Management Level":=PositionMenuOrginal."Management Level";
                          PositionMenuOrginal1.Role:=PositionMenuOrginal.Role;
                           PositionMenuOrginal1."Role Name":=PositionMenuOrginal."Role Name";
                           PositionMenuOrginal1.Grade:=PositionMenuOrginal.Grade;
                           PositionMenuOrginal1."Official Translation":=PositionMenuOrginal."Official Translation";

                             IF DimensionTempPos."Team Description"<>'' THEN
                     PositionMenuOrginal1."Department Code":=DimensionTempPos."Team Code";
                                IF (DimensionTempPos."Group Description"<>'') AND (DimensionTempPos."Team Description"='')  THEN
                     PositionMenuOrginal1."Department Code":=DimensionTempPos."Group Code";
                                IF (DimensionTempPos."Department Categ.  Description"<>'') AND (DimensionTempPos."Group Description"='')  THEN
                     PositionMenuOrginal1."Department Code":=DimensionTempPos."Department Category";
                                IF (DimensionTempPos."Sector  Description"<>'') AND (DimensionTempPos."Department Categ.  Description"='')  THEN
                     PositionMenuOrginal1."Department Code":=DimensionTempPos.Sector;

              IF NOT PosMenOrg.GET(PositionMenuOrginal1.Code,PositionMenuOrginal1.Description,PositionMenuOrginal1."Department Code",OrgShema.Code) THEN BEGIN
                OrgSNew.RESET;
                 OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                 IF OrgSNew.FINDFIRST THEN BEGIN
                   PositionMenuOrginal1."Last Date Modified":=OrgSNew."Date From";
                   PositionMenuOrginal1."Operator No.":=OrgSNew."Operator No.";
                   END;
              //Code,Description,Department Code,Org. Structure
              PositionMenuOrginal1.INSERT;
              END;

               UNTIL DimensionTempPos.NEXT=0
               UNTIL PositionMenuOrginal.NEXT=0;
               PositionMenuOrginal.RESET;
               PositionMenuOrginal.SETFILTER("Department Code",'%1','');
                     IF PositionMenuOrginal.FINDSET THEN REPEAT
               PositionMenuOrginal.DELETE;
               UNTIL PositionMenuOrginal.NEXT=0;*/




            //
            PositionMenuTemp.CALCFIELDS("Number of dimension value");
            PositionMenuTemp.SETFILTER("Number of dimension value", '>%1', 1);
            IF PositionMenuTemp.FINDSET THEN
                REPEAT
                    PositionMenuTemp.CALCFIELDS("Number of dimension value");
                    IF PositionMenuTemp."Number of dimension value" > 1 THEN BEGIN
                        PositionMenuOrginal.INIT;
                        Dimens.RESET;
                        Dimens.SETFILTER("Position Code", '%1', PositionMenuTemp.Code);
                        Dimens.SETFILTER("Position Description", '%1', PositionMenuTemp.Description);
                        Dimens.SETFILTER("ORG Shema", '%1', PositionMenuTemp."Org. Structure");
                        IF Dimens.FINDSET THEN
                            REPEAT
                                DepartmentTemp.RESET;
                                DepartmentTemp.SETFILTER(Description, '%1', Dimens."Org Belongs");
                                DepartmentTemp.SETFILTER("ORG Shema", '%1', PositionMenuTemp."Org. Structure");
                                IF DepartmentTemp.FINDFIRST THEN
                                    PositionMenuOrginal."Department Code" := DepartmentTemp.Code;

                                PositionMenuOrginal.Code := PositionMenuTemp.Code;
                                PositionMenuOrginal.Description := PositionMenuTemp.Description;
                                PositionMenuOrginal."Org. Structure" := OrgShema.Code;
                                PositionMenuOrginal."Key Function" := PositionMenuTemp."Key Function";
                                PositionMenuOrginal."Control Function" := PositionMenuTemp."Control Function";
                                PositionMenuOrginal."BJF/GJF" := PositionMenuTemp."BJF/GJF";
                                PositionMenuOrginal."Management Level" := PositionMenuTemp."Management Level";
                                //      PositionMenuOrginal.Role := PositionMenuTemp.Role;
                                //        PositionMenuOrginal."Role Name" := PositionMenuTemp."Role Name";
                                PositionMenuOrginal.Grade := PositionMenuTemp.Grade;
                                PositionMenuOrginal."Official Translation" := PositionMenuTemp."Official Translation";
                                IF Dimens."Team Description" <> '' THEN
                                    PositionMenuOrginal."Department Code" := Dimens."Team Code";
                                IF (Dimens."Group Description" <> '') AND (Dimens."Team Description" = '') THEN
                                    PositionMenuOrginal."Department Code" := Dimens."Group Code";
                                IF (Dimens."Department Categ.  Description" <> '') AND (Dimens."Group Description" = '') THEN
                                    PositionMenuOrginal."Department Code" := Dimens."Department Category";
                                IF (Dimens."Sector  Description" <> '') AND (Dimens."Department Categ.  Description" = '') THEN
                                    PositionMenuOrginal."Department Code" := Dimens.Sector;


                                PoSMenDUp.RESET;
                                PoSMenDUp.SETFILTER(Code, '%1', PositionMenuOrginal.Code);
                                PoSMenDUp.SETFILTER(Description, '%1', PositionMenuOrginal.Description);
                                PoSMenDUp.SETFILTER("Department Code", '%1', PositionMenuOrginal."Department Code");
                                PoSMenDUp.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                                IF NOT PoSMenDUp.FINDFIRST THEN BEGIN
                                    PositionMenuOrginal."Org. Structure" := OrgShema.Code;
                                    OrgSNew.RESET;
                                    OrgSNew.SETFILTER(Status, '%1', OrgSNew.Status::Preparation);
                                    IF OrgSNew.FINDFIRST THEN BEGIN
                                        PositionMenuOrginal."Last Date Modified" := OrgSNew."Date From";
                                        PositionMenuOrginal."Operator No." := OrgSNew."Operator No.";
                                    END;
                                    PosLast.RESET;
                                    PosLast.SETCURRENTKEY("Position Menu Identity");
                                    PosLast.ASCENDING;
                                    IF PosLast.FINDLAST THEN
                                        PositionMenuOrginal."Position Menu Identity" := PosLast."Position Menu Identity" + 1;

                                    PositionMenuOrginal.INSERT;
                                END;


                            UNTIL Dimens.NEXT = 0;
                    END;
                UNTIL PositionMenuTemp.NEXT = 0;


            OrgShema."Change Org" := TRUE;
            OrgShema.MODIFY;

            //ovdje dodajem update

            /*      if OrgShema."Date From" = calcdate('<+1D>', WorkDate()) then begin
                      ECLSysInst.Reset();
                      ECLSysInst.SetFilter("Changing Position", '%1', false);
                      ECLSysInst.SetFilter("Will Be Changed Later", '%1', false);
                      if ECLSysInst.FindSet() then
                          repeat

                              ECLUgCon.RESET;
                              ECLUgCon.SETFILTER("Employee No.", '%1', ECLSysInst."Employee No.");
                              ECLUgCon.SETFILTER(Active, '%1', TRUE);
                              if ECLUgCon.FindFirst() then begin

                                  IF ((ECLSysInst."Sector Description" = ECLUgCon."Sector Description") AND
                                   (ECLSysInst."Department Cat. Description" = ECLUgCon."Department Cat. Description")
                                                  AND (ECLSysInst."Group Description" = ECLUgCon."Group Description")
                                                 AND (ECLSysInst."Team Description" = ECLUgCon."Team Description") AND
                                                 (ECLSysInst."Reason for Change" = ECLUgCon."Reason for Change") AND

                                                  (ECLSysInst."Org Unit Name" = ECLUgCon."Org Unit Name")

                                                 AND (ECLSysInst.IS = ECLUgCon.IS)
                                                 AND (ECLSysInst."IS Date From" = ECLUgCon."IS Date From")
                                                 AND (ECLSysInst."IS Date To" = ECLUgCon."IS Date To")
                                                 AND (ECLSysInst."Position Description" = ECLUgCon."Position Description")) THEN BEGIN
                                  end
                                  else begin
                                      ECLSysInst.Validate("Changing Position", true);
                                  end;



                              end;



                          until ECLSysInst.Next() = 0;

        end;*/
        END;

    end;

    var
        OrgShema: Record "ORG Shema";
        PosMinimal: Record "Position Minimal Education";

        ExeManager: Record "Exe Manager";
        PosMinimalInit: Record "Position Minimal Education";
        PosMinimalTemp: Record "Position Minimal Educ Temp";
        ExeMTemp: Record "Exe Manager temporery";

        ExeManagerInit: Record "Exe Manager";
        ECLSysInst: Record "ECL systematization";
        ECLUgCon: Record "Employee Contract Ledger";
        ECLOrgKojiSeVidi: Record "Employee Contract Ledger";
        ECLNeVidi: Record "Employee Contract Ledger";
        DeleteUpdate: Record "Employee Contract Ledger";
        DeleteUpdate2: Record "Employee Contract Ledger";
        ECLNeVidi2: Record "Employee Contract Ledger";
        SectorOrginal: Record "Sector";
        DepCatOrginal: Record "Department Category";
        GroupOrginal: Record "Group";
        TeamOrginal: Record "TeamT";
        DepartmentOrginal: Record "Department";
        HeadOfOrginal: Record "Head Of's";
        SectorParent2: Record "Sector";
        DimensionOrginalPos: Record "Dimension for position";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuOrginal: Record "Position Menu";
        SectorTemp: Record "Sector temporary";
        SectorParent22: Record "Head Of's temporary";
        SectorOrginal1: Record "Sector";
        DepCat22: Record "Department Category";
        GroupCat22: Record "Group";
        TeamCat22: Record "TeamT";
        DepCatTemp: Record "Department Category temporary";
        DepCatOrginal1: Record "Department Category";
        GroupTemp: Record "Group temporary";
        GroupOrginal1: Record "Group";
        TeamTemp: Record "TeamT";
        TeamOrginal1: Record "TeamT";
        DepartmentTemp: Record "Department temporary";
        DepartmentOrginal1: Record "Department";
        HeadOfTemp: Record "Head Of's temporary";
        HeadOfOrginal1: Record "Head Of's";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal1: Record "Position Benefits";
        PositionMenuOrginal1: Record "Position Menu";
        PositionMenuTemp: Record "Position Menu temporary";
        PoSMenDUp: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        OrgSNew: Record "ORG Shema";
        Dimens: Record "Dimension for position";
        BenefitsTemp2: Record "Position Benefits temporery";
        PosLast: Record "Position Menu";
}

