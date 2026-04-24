page 50087 "ORG Shema"
{
    Caption = 'ORG Shema';
    Editable = true;
    PageType = List;
    SourceTable = "ORG Shema";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        StartingDateOnAfterValidate;
                    end;
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Change Org"; "Change Org")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("Change Dimension"; "Change Dimension")
                {
                    ApplicationArea = all;
                    Caption = 'Change Dimension';
                    Visible = false;
                }
                field("Sent Mail Systematization"; "Sent Mail Systematization")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
                field("Create date of org.prep"; "Create date of org.prep")
                {
                    ApplicationArea = all;
                    Visible = false;

                }
            }
        }
        area(factboxes)
        {


        }
    }

    actions
    {
        area(processing)
        {
            group(Systematization1)
            {
                Caption = 'Systematization';
                Image = Hierarchy;

                action("Create New Org. structure")
                {
                    Caption = 'Create New Org. structure';
                    ApplicationArea = all;
                    Image = Hierarchy;


                    trigger OnAction()
                    begin


                        IF Response <> CONFIRM(Text002, TRUE) THEN BEGIN


                            OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                            IF OSNew.FINDLAST THEN BEGIN
                                /*   Grade.RESET;
                                   Grade.SETFILTER("Org Shema", '%1', OSNew.Code);
                                   IF Grade.FINDSET THEN
                                       Grade.DELETEALL;*/

                                UpdatePostTableInit.Reset();
                                UpdatePostTableInit.SetFilter("Org Shema", '%1', OSNew.Code);
                                if UpdatePostTableInit.FindSet() then
                                    UpdatePostTableInit.DeleteAll();
                                ExeManagerInit.Reset();
                                ExeManagerInit.SetFilter("ORG Shema", '%1', OSNew.Code);
                                if ExeManagerInit.FindSet() then
                                    ExeManagerInit.DeleteAll();


                            END;


                            IF NOT SectorNew.ISEMPTY THEN BEGIN
                                SectorNew.DELETEALL;
                            END;

                            OS.Reset();
                            OS.SETFILTER(Status, '%1', OS.Status::Active);
                            IF OS.FINDLAST THEN BEGIN
                                UpdatePostTable.Reset();
                                UpdatePostTable.SetFilter("Org Shema", '%1', OS.Code);
                                if UpdatePostTable.FindSet() then
                                    repeat
                                        UpdatePostTableInit.Init();
                                        UpdatePostTableInit.TransferFields(UpdatePostTable);
                                        OSNew.Reset();
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN
                                            UpdatePostTableInit."Org Shema" := OSNew.Code;
                                        UpdatePostTableInit.Insert();

                                    until UpdatePostTable.Next() = 0;
                            end;


                            OS.Reset();
                            OS.SETFILTER(Status, '%1', OS.Status::Active);
                            IF OS.FINDLAST THEN BEGIN

                                ExeManager.Reset();
                                ExeManager.SetFilter("Org Shema", '%1', OS.Code);
                                if ExeManager.FindSet() then
                                    repeat
                                        ExeManagerInit.Init();
                                        ExeManagerInit.TransferFields(ExeManager);
                                        OSNew.Reset();
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN
                                            ExeManagerInit."Org Shema" := OSNew.Code;
                                        ExeManagerInit.Insert();

                                    until ExeManager.Next() = 0;
                            end;



                            Sector.RESET;
                            Sector.SETFILTER(Code, '<>%1', '');
                            Sector.SETCURRENTKEY(Identity);
                            Sector.ASCENDING;
                            IF Sector.FINDLAST THEN
                                SectorIdentityNew := Sector.Identity;

                            OS.SETFILTER(Status, '%1', OS.Status::Active);
                            IF OS.FINDLAST THEN BEGIN
                                Sector.SETFILTER("Org Shema", '%1', OS.Code);
                                IF Sector.FINDSET THEN
                                    REPEAT
                                        SectorNew.INIT;
                                        // SectorNew.COPY(Sector,FALSE);
                                        SectorNew.TRANSFERFIELDS(Sector);

                                        SectorIdentityNew := SectorIdentityNew + 1;
                                        SectorNew."Department Type" := SectorNew."Department Type"::Sector;
                                        SectorNew.Identity := SectorIdentityNew;

                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            SectorNew."Org Shema" := OSNew.Code;
                                            SectorNew."ID for GPS" := 0;
                                            SectorNewCheck.RESET;
                                            SectorNewCheck.SETFILTER(Code, '%1', SectorNew.Code);
                                            SectorNewCheck.SETFILTER(Description, '%1', SectorNew.Description);
                                            SectorNewCheck.SETFILTER("Org Shema", '%1', OSNew.Code);
                                            IF NOT SectorNewCheck.FINDFIRST THEN
                                                SectorNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL Sector.NEXT = 0;





                                IF NOT DepCatNew.ISEMPTY THEN BEGIN
                                    DepCatNew.DELETEALL;
                                END;
                                DepCat.RESET;
                                DepCat.SETFILTER(Code, '<>%1', '');
                                DepCat.SETCURRENTKEY(Identity);
                                DepCat.ASCENDING;
                                IF DepCat.FINDLAST THEN
                                    DepCatNewIndentity := DepCat.Identity;



                                DepCat.SETFILTER("Org Shema", '%1', OS.Code);
                                IF DepCat.FINDSET THEN
                                    REPEAT
                                        DepCatNew.INIT;
                                        //DepCatNew.COPY(DepCat,FALSE);
                                        DepCatNew.TRANSFERFIELDS(DepCat);
                                        DepCatNewIndentity := DepCatNewIndentity + 1;
                                        DepCatNew.Identity := DepCatNewIndentity;
                                        //OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            DepCatNew."Org Shema" := OSNew.Code;
                                            DepCatNew."ID for GPS" := 0;

                                            DepCatNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL DepCat.NEXT = 0;

                                IF NOT GroupNew.ISEMPTY THEN BEGIN
                                    GroupNew.DELETEALL;
                                END;

                                Group.RESET;
                                Group.SETFILTER(Code, '<>%1', '');
                                Group.SETCURRENTKEY(Identity);
                                Group.ASCENDING;
                                IF Group.FINDLAST THEN
                                    GroupIdentityNew := Group.Identity;



                                Group.SETFILTER("Org Shema", '%1', OS.Code);
                                IF Group.FINDSET THEN
                                    REPEAT
                                        GroupNew.INIT;
                                        //GroupNew.COPY(Group,FALSE);
                                        GroupNew.TRANSFERFIELDS(Group);
                                        GroupIdentityNew := GroupIdentityNew + 1;
                                        GroupNew.Identity := GroupIdentityNew;
                                        //OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            GroupNew."Org Shema" := OSNew.Code;
                                            GroupNew."ID for GPS" := 0;
                                            GroupNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL Group.NEXT = 0;

                                IF NOT TeamNew.ISEMPTY THEN BEGIN
                                    TeamNew.DELETEALL;
                                END;
                                Team.RESET;
                                Team.SETFILTER(Code, '<>%1', '');
                                Team.SETCURRENTKEY(Identity);
                                Team.ASCENDING;
                                IF Team.FINDLAST THEN
                                    TeamIdentityNew := Team.Identity;

                                Team.SETFILTER("Org Shema", '%1', OS.Code);
                                IF Team.FINDSET THEN
                                    REPEAT
                                        TeamNew.INIT;
                                        //TeamNew.COPY(Team,FALSE);
                                        TeamNew.TRANSFERFIELDS(Team);
                                        TeamIdentityNew := TeamIdentityNew + 1;
                                        TeamNew.Identity := TeamIdentityNew;
                                        // OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            TeamNew."Org Shema" := OSNew.Code;
                                            TeamNew."ID for GPS" := 0;
                                            TeamNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL Team.NEXT = 0;



                                IF NOT DepartmentNew.ISEMPTY THEN BEGIN
                                    DepartmentNew.DELETEALL;
                                END;
                                Department.RESET;
                                Department.SETFILTER("ORG Shema", '%1', OS.Code);
                                IF Department.FINDSET THEN
                                    REPEAT
                                        DepartmentNew.INIT;
                                        //TeamNew.COPY(Team,FALSE);
                                        DepartmentNew.TRANSFERFIELDS(Department);
                                        // OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            DepartmentNew."ORG Shema" := OSNew.Code;
                                            IF DepartmentNew.Sector <> '' THEN BEGIN
                                                SectorOrg.RESET;
                                                SectorOrg.SETFILTER(Description, '%1', DepartmentNew."Sector  Description");
                                                IF SectorOrg.FINDFIRST THEN
                                                    DepartmentNew."Sector Identity" := SectorOrg.Identity;
                                            END;
                                            IF DepartmentNew."Department Category" <> '' THEN BEGIN
                                                DepCatNew.RESET;
                                                DepCatNew.SETFILTER(Description, '%1', DepartmentNew."Department Categ.  Description");
                                                IF DepCatNew.FINDFIRST THEN
                                                    DepartmentNew."Department Idenity" := DepCatNew.Identity;
                                            END;
                                            IF DepartmentNew."Group Code" <> '' THEN BEGIN
                                                GroupNew.RESET;
                                                GroupNew.SETFILTER(Description, '%1', DepartmentNew."Group Description");
                                                IF GroupNew.FINDFIRST THEN
                                                    DepartmentNew."Department Group identity" := GroupNew.Identity;
                                            END;
                                            IF DepartmentNew."Team Code" <> '' THEN BEGIN
                                                TeamNew.RESET;
                                                TeamNew.SETFILTER(Name, '%1', DepartmentNew."Team Description");
                                                IF TeamNew.FINDFIRST THEN
                                                    DepartmentNew."Department Team identity" := TeamNew.Identity;
                                            END;
                                            DepartmentNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL Department.NEXT = 0;
                                OSNew.RESET;
                                OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                IF OSNew.FINDLAST THEN BEGIN
                                    DimesnionTempOrg.RESET;
                                    DimesnionTempOrg.SETFILTER("ORG Shema", '%1', OSNew.Code);
                                    IF NOT DimesnionTempOrg.ISEMPTY THEN BEGIN
                                        DimesnionTempOrg.DELETEALL;
                                    END;
                                END;


                                IF NOT PositionNew.ISEMPTY THEN BEGIN
                                    PositionNew.DELETEALL;
                                END;

                                IF NOT PositionMenuNew.ISEMPTY THEN BEGIN
                                    PositionMenuNew.DELETEALL;
                                END;
                                PositionFind.RESET;
                                PositionFind.SETFILTER(Code, '<>%1', '');
                                PositionFind.SETCURRENTKEY("Position Menu Identity");
                                PositionFind.ASCENDING;
                                IF PositionFind.FINDLAST THEN
                                    PositionNewIdentity := PositionFind."Position Menu Identity";


                                PositionMenu.SETFILTER("Org. Structure", '%1', OS.Code);
                                IF PositionMenu.FINDSET THEN
                                    REPEAT
                                        PositionMenuNew.INIT;
                                        PositionMenuNew.TRANSFERFIELDS(PositionMenu);






                                        Sector.RESET;
                                        Sector.SETFILTER(Identity, '%1', PositionMenu."Sector Identity");
                                        IF Sector.FINDFIRST THEN BEGIN
                                            SectorOrg.RESET;
                                            SectorOrg.SETFILTER(Description, '%1', Sector.Description);
                                            IF SectorOrg.FINDFIRST THEN
                                                PositionMenuNew."Sector Identity" := SectorOrg.Identity;
                                        END;
                                        // OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            PositionMenuNew."Org. Structure" := OSNew.Code;
                                            PositionNewIdentity := PositionNewIdentity + 1;
                                            PositionMenuNew."Position Menu Identity" := PositionNewIdentity;

                                            PositionMenuNew.INSERT;
                                            PositionMenuNew.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL PositionMenu.NEXT = 0;

                                PositionMenuNew.RESET;
                                PositionMenuNew.SETFILTER(Code, '<>%1', '');
                                IF PositionMenuNew.FINDSET THEN
                                    REPEAT
                                        PositionNew.RESET;
                                        PositionNew.SETFILTER(Code, '%1', PositionMenuNew.Code);
                                        PositionNew.SETFILTER(Description, '%1', PositionMenuNew.Description);
                                        IF PositionNew.FINDFIRST THEN BEGIN
                                            DimesnionsForPos.RESET;
                                            DimesnionsForPos.SETFILTER("Position Code", '%1', PositionNew.Code);
                                            DimesnionsForPos.SETFILTER("Position Description", '%1', PositionNew.Description);
                                            DimesnionsForPos.SETFILTER("ORG Shema", '%1', OS.Code);
                                            IF DimesnionsForPos.FINDSET THEN BEGIN
                                                BrojPozicija := DimesnionsForPos.COUNT;
                                            END;
                                            IF BrojPozicija > 1 THEN BEGIN
                                                PosMenuForDelete.SETFILTER(Code, '%1', PositionNew.Code);
                                                PosMenuForDelete.SETFILTER(Description, '%1', PositionNew.Description);
                                                PosMenuForDelete.SETFILTER("Department Code", '<>%1', PositionNew."Department Code");
                                                IF PosMenuForDelete.FINDSET THEN
                                                    REPEAT
                                                        PosMenuForDelete.DELETE;
                                                    UNTIL PosMenuForDelete.NEXT = 0;
                                                IF OrginalDepCode.GET(PositionNew.Code, PositionNew.Description, PositionNew."Department Code", PositionNew."Org. Structure") THEN
                                                    OrginalDepCode.RENAME(PositionNew.Code, PositionNew.Description, '', PositionNew."Org. Structure");

                                                //Code,Description,Department Code,Org. Structure


                                            END;
                                        END;
                                    UNTIL PositionMenuNew.NEXT = 0;







                                IF NOT BenefitsTemp.ISEMPTY THEN BEGIN
                                    BenefitsTemp.DELETEALL;
                                END;

                                BenefitsTemp1.SETFILTER("Org. Structure", '%1', OS.Code);
                                IF BenefitsTemp1.FINDSET THEN
                                    REPEAT
                                        BenefitsTempNew.INIT;
                                        BenefitsTempNew.TRANSFERFIELDS(BenefitsTemp1);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            BenefitsTempNew."Org. Structure" := OSNew.Code;
                                            BenefitsTempNew.INSERT;
                                            BenefitsTempNew.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL BenefitsTemp1.NEXT = 0;





                                IF NOT DimesnionsForPosNew.ISEMPTY THEN BEGIN
                                    DimesnionsForPosNew.DELETEALL;
                                END;
                                DimesnionsForPos.RESET;
                                DimesnionsForPos.SETFILTER("ORG Shema", '%1', OS.Code);
                                IF DimesnionsForPos.FINDSET THEN
                                    REPEAT
                                        DimesnionsForPosNew.INIT;
                                        DimesnionsForPosNew.TRANSFERFIELDS(DimesnionsForPos);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            DimesnionsForPosNew."ORG Shema" := OSNew.Code;
                                            DimesnionsForPosNew.INSERT;
                                            DimesnionsForPosNew.MODIFY;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL DimesnionsForPos.NEXT = 0;


                                IF NOT ECLCopy.ISEMPTY THEN
                                    ECLCopy.DELETEALL;
                                ECLCh.RESET;
                                ECLCh.SETFILTER("Employee No.", '<>%1', '');
                                ECLCh.SETCURRENTKEY("No.");
                                ECLCh.ASCENDING;
                                IF ECLCh.FINDLAST THEN
                                    NewNo := ECLCh."No.";

                                ECLOrginal.RESET;
                                ECLOrginal.SETFILTER(Active, '%1', TRUE);
                                ECLOrginal.SETFILTER("Org. Structure", '%1', OS.Code);
                                ECLOrginal.SETFILTER("Grounds for Term. Description", '%1', '');
                                IF ECLOrginal.FINDSET THEN
                                    REPEAT
                                        EmployeeRec.RESET;
                                        EmployeeRec.SETFILTER("No.", '%1', ECLOrginal."Employee No.");
                                        IF EmployeeRec.Status <> EmployeeRec.Status::Terminated THEN BEGIN
                                            //KOPIRA SVE PO STAROM
                                            ECLCopy.RESET;
                                            ECLCopy.INIT;
                                            ECLCopy.TRANSFERFIELDS(ECLOrginal);
                                            NewNo := NewNo + 1;
                                            ECLCopy."No." := NewNo;
                                            ECLCopy.Active := FALSE;
                                            ECLCopy."Org. Structure" := OSNew.Code;
                                            ECLCopy."Sent Mail Change Pos" := FALSE;
                                            ECLCopy."Sent Mail Duration" := FALSE;
                                            ECLCopy."Sent Mail Employment" := FALSE;
                                            ECLCopy."Sent Mail Termination" := FALSE;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::CEO THEN
                                                ECLCopy."Order By Managment" := 1;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::Exe THEN
                                                ECLCopy."Order By Managment" := 2;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::Sector THEN
                                                ECLCopy."Order By Managment" := 3;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::"Department Category" THEN
                                                ECLCopy."Order By Managment" := 4;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::Group THEN
                                                ECLCopy."Order By Managment" := 5;
                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::E THEN
                                                ECLCopy."Order By Managment" := 6;

                                            IF ECLOrginal."Management Level" = ECLOrginal."Management Level"::Empty THEN
                                                ECLCopy."Order By Managment" := 7;
                                            EmployeeDefaultDimension.RESET;
                                            EmployeeDefaultDimension.SETFILTER("No.", '%1', ECLOrginal."Employee No.");
                                            IF EmployeeDefaultDimension.FINDFIRST THEN BEGIN
                                                ECLCopy."Dimension Value Code" := EmployeeDefaultDimension."Dimension Value Code";
                                                DV.RESET;
                                                DV.SETFILTER(Code, '%1', ECLCopy."Dimension Value Code");
                                                IF DV.FINDFIRST THEN
                                                    ECLCopy."Dimension  Name" := DV.Name;
                                            END;
                                            SectorOrg.RESET;
                                            SectorOrg.SETFILTER(Description, '%1', ECLCopy."Sector Description");
                                            IF SectorOrg.FINDFIRST THEN
                                                ECLCopy."Sector Identity" := SectorOrg.Identity;
                                            ECLCopy.INSERT;
                                        END;
                                    UNTIL ECLOrginal.NEXT = 0;

                                /*
                               DepartmentNew.RESET;
                               IF DepartmentNew.FINDSET THEN REPEAT
                               IF DepartmentNew."Sector  Description"<>'' THEN BEGIN
                               DepNew.RESET;
                               DepNew.SETFILTER(Code,'%1',DepartmentNew.Code);
                               DepNew.SETFILTER(Description,'%1',DepartmentNew.Description);
                               DepNew.SETFILTER("Department Categ.  Description",'%1',DepartmentNew."Department Categ.  Description");
                               DepNew.SETFILTER("Group Description",'%1',DepartmentNew."Group Description");
                               DepNew.SETFILTER("Team Description",'%1',DepartmentNew."Team Description");
                               IF DepNew.FINDFIRST THEN BEGIN
                               SectorNew.RESET;
                               SectorNew.SETFILTER(Description,'%1',DepNew."Sector  Description");
                               IF SectorNew.FINDFIRST THEN BEGIN
                               DepNew."Sector Identity":=SectorNew.Identity;
                               DepNew.MODIFY;
                                END;
                                  END;
                                   END;

                               IF DepartmentNew."Department Categ.  Description"<>'' THEN BEGIN
                               DepNew.RESET;
                               DepNew.SETFILTER(Code,'%1',DepartmentNew.Code);
                               DepNew.SETFILTER(Description,'%1',DepartmentNew.Description);
                               DepNew.SETFILTER("Department Categ.  Description",'%1',DepartmentNew."Department Categ.  Description");
                               DepNew.SETFILTER("Group Description",'%1',DepartmentNew."Group Description");
                               DepNew.SETFILTER("Team Description",'%1',DepartmentNew."Team Description");
                               IF DepNew.FINDFIRST THEN BEGIN
                               DepCatNew.RESET;
                               DepCatNew.SETFILTER(Description,'%1',DepNew."Department Categ.  Description");
                               IF DepCatNew.FINDFIRST THEN BEGIN
                               DepNew."Department Idenity":=DepCatNew.Identity;
                               DepNew.MODIFY;
                                END;
                                  END;
                                   END;

                               IF DepartmentNew."Group Description"<>'' THEN BEGIN
                               DepNew.RESET;
                               DepNew.SETFILTER(Code,'%1',DepartmentNew.Code);
                               DepNew.SETFILTER(Description,'%1',DepartmentNew.Description);
                               DepNew.SETFILTER("Department Categ.  Description",'%1',DepartmentNew."Department Categ.  Description");
                               DepNew.SETFILTER("Group Description",'%1',DepartmentNew."Group Description");
                               DepNew.SETFILTER("Team Description",'%1',DepartmentNew."Team Description");
                               IF DepNew.FINDFIRST THEN BEGIN
                               GroupNew.RESET;
                               GroupNew.SETFILTER(Description,'%1',DepNew."Group Description");
                               IF GroupNew.FINDFIRST THEN BEGIN
                               DepNew."Department Group identity":=GroupNew.Identity;
                               DepNew.MODIFY;
                                END;
                                  END;
                                   END;


                               IF DepartmentNew."Team Description"<>'' THEN BEGIN
                               DepNew.RESET;
                               DepNew.SETFILTER(Code,'%1',DepartmentNew.Code);
                               DepNew.SETFILTER(Description,'%1',DepartmentNew.Description);
                               DepNew.SETFILTER("Department Categ.  Description",'%1',DepartmentNew."Department Categ.  Description");
                               DepNew.SETFILTER("Group Description",'%1',DepartmentNew."Group Description");
                               DepNew.SETFILTER("Team Description",'%1',DepartmentNew."Team Description");
                               IF DepNew.FINDFIRST THEN BEGIN
                               TeamNew.RESET;
                               TeamNew.SETFILTER(Name,'%1',DepNew."Team Description");
                               IF TeamNew.FINDFIRST THEN BEGIN
                               DepNew."Department Idenity":=TeamNew.Identity;
                               DepNew.MODIFY;
                                END;
                                  END;
                                   END;

                               UNTIL DepartmentNew.NEXT=0;*/
                                DepCatNew.RESET;
                                DepCatNew.SETFILTER(Code, '<>%1', '');
                                IF DepCatNew.FINDSET THEN
                                    REPEAT
                                        DepNew.RESET;
                                        DepNew.SETFILTER("Department Category", '%1', DepCatNew.Code);
                                        DepNew.SETFILTER("Department Categ.  Description", '%1', DepCatNew.Description);
                                        DepNew.SETFILTER("Department Type", '%1', 4);
                                        IF DepNew.FINDFIRST THEN BEGIN
                                            DepCatNew."Identity Sector" := DepNew."Sector Identity";
                                            DepCatNew.MODIFY;
                                        END;
                                    UNTIL DepCatNew.NEXT = 0;

                                GroupNew.RESET;
                                GroupNew.SETFILTER(Code, '<>%1', '');
                                IF GroupNew.FINDSET THEN
                                    REPEAT
                                        DepNew.RESET;
                                        DepNew.SETFILTER("Group Code", '%1', GroupNew.Code);
                                        DepNew.SETFILTER("Group Description", '%1', GroupNew.Description);
                                        DepNew.SETFILTER("Department Type", '%1', 2);
                                        IF DepNew.FINDFIRST THEN BEGIN
                                            GroupNew."Identity Sector" := DepNew."Sector Identity";
                                            GroupNew.MODIFY;
                                        END;
                                    UNTIL GroupNew.NEXT = 0;

                                TeamNew.RESET;
                                TeamNew.SETFILTER(Code, '<>%1', '');
                                IF TeamNew.FINDSET THEN
                                    REPEAT
                                        DepNew.RESET;
                                        DepNew.SETFILTER("Team Code", '%1', TeamNew.Code);
                                        DepNew.SETFILTER("Team Description", '%1', TeamNew.Name);
                                        DepNew.SETFILTER("Department Type", '%1', 9);
                                        IF DepNew.FINDFIRST THEN BEGIN
                                            TeamNew."Identity Sector" := DepNew."Sector Identity";
                                            TeamNew.MODIFY;
                                        END;
                                    UNTIL TeamNew.NEXT = 0;



                                IF NOT HeadOfNew.ISEMPTY THEN BEGIN
                                    HeadOfNew.DELETEALL;
                                END;
                                HeadOf.SETFILTER("ORG Shema", '%1', OS.Code);
                                IF HeadOf.FINDSET THEN
                                    REPEAT
                                        HeadOfNew.INIT;
                                        //TeamNew.COPY(Team,FALSE);
                                        HeadOfNew.TRANSFERFIELDS(HeadOf);
                                        // OSNew.SETFILTER(Status,'%1',OS.Status::Active);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            HeadOfNew."ORG Shema" := OSNew.Code;
                                            HeadOfNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL HeadOf.NEXT = 0;



                                /*    Grade.RESET;
                                    Grade.SETFILTER("Org Shema", '%1', OS.Code);
                                    IF Grade.FINDSET THEN
                                        REPEAT
                                            GradeNew.INIT;
                                            GradeNew.Code := Grade.Code;
                                            GradeNew."Position Code" := Grade."Position Code";
                                            GradeNew."Position Description" := Grade."Position Description";
                                            OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                            IF OSNew.FINDLAST THEN BEGIN
                                                GradeNew."Org Shema" := OSNew.Code;
                                                GradeNew.INSERT;
                                            END
                                            ELSE BEGIN
                                                ERROR(Text001);
                                            END;
                                        UNTIL Grade.NEXT = 0;
    */


                                DimensionTemp.RESET;
                                DimensionTemp.SETFILTER("ORG Shema", '%1', OS.Code);
                                IF DimensionTemp.FINDSET THEN
                                    REPEAT
                                        DimensionTempNew.INIT;
                                        DimensionTempNew.COPY(DimensionTemp);
                                        OSNew.SETFILTER(Status, '%1', OS.Status::Preparation);
                                        IF OSNew.FINDLAST THEN BEGIN
                                            DimensionTempNew."ORG Shema" := OSNew.Code;
                                            DimensionTempNew.INSERT;
                                        END
                                        ELSE BEGIN
                                            ERROR(Text001);
                                        END;
                                    UNTIL DimensionTemp.NEXT = 0;
                                NumberOfDimensionTempRecord.RESET;
                                SectorNew.RESET;
                                IF SectorNew.FINDSET THEN
                                    REPEAT
                                        NumberOfDimensionTempRecord.RESET;
                                        NumberOfDimensionTempRecord.SETFILTER("Department Type", '%1', 8);
                                        NumberOfDimensionTempRecord.SETFILTER("Sector  Description", '%1', SectorNew.Description);
                                        NumberOfDimensionTempRecord.SETFILTER("ORG Shema", '%1', OSNew.Code);
                                        IF NumberOfDimensionTempRecord.FINDSET THEN BEGIN
                                            BrojTroškovnihcentara := NumberOfDimensionTempRecord.COUNT;
                                            IF BrojTroškovnihcentara = 1 THEN BEGIN
                                                SectorNew."Name of TC" := NumberOfDimensionTempRecord."Dimension Value Code" + '-' + NumberOfDimensionTempRecord."Dimension  Name";
                                                SectorNew.MODIFY;
                                            END;
                                        END;

                                    UNTIL SectorNew.NEXT = 0;

                                NumberOfDimensionTempRecord.RESET;
                                DepCatNew.RESET;
                                IF DepCatNew.FINDSET THEN
                                    REPEAT
                                        NumberOfDimensionTempRecord.RESET;
                                        NumberOfDimensionTempRecord.SETFILTER("Department Type", '%1', 4);
                                        NumberOfDimensionTempRecord.SETFILTER("Department Categ.  Description", '%1', DepCatNew.Description);
                                        NumberOfDimensionTempRecord.SETFILTER("ORG Shema", '%1', OSNew.Code);
                                        IF NumberOfDimensionTempRecord.FINDSET THEN BEGIN
                                            BrojTroškovnihcentara := NumberOfDimensionTempRecord.COUNT;
                                            IF BrojTroškovnihcentara = 1 THEN BEGIN
                                                DepCatNew."Name of TC" := NumberOfDimensionTempRecord."Dimension Value Code" + '-' + NumberOfDimensionTempRecord."Dimension  Name";
                                                DepCatNew.MODIFY;
                                            END;
                                        END;

                                    UNTIL DepCatNew.NEXT = 0;



                                NumberOfDimensionTempRecord.RESET;
                                GroupNew.RESET;
                                IF GroupNew.FINDSET THEN
                                    REPEAT
                                        NumberOfDimensionTempRecord.RESET;
                                        NumberOfDimensionTempRecord.SETFILTER("Department Type", '%1', 2);
                                        NumberOfDimensionTempRecord.SETFILTER("Group Description", '%1', GroupNew.Description);
                                        NumberOfDimensionTempRecord.SETFILTER("ORG Shema", '%1', OSNew.Code);
                                        IF NumberOfDimensionTempRecord.FINDSET THEN BEGIN
                                            BrojTroškovnihcentara := NumberOfDimensionTempRecord.COUNT;
                                            IF BrojTroškovnihcentara = 1 THEN BEGIN
                                                GroupNew."Name of TC" := NumberOfDimensionTempRecord."Dimension Value Code" + '-' + NumberOfDimensionTempRecord."Dimension  Name";
                                                GroupNew.MODIFY;
                                            END;
                                        END;

                                    UNTIL GroupNew.NEXT = 0;


                                NumberOfDimensionTempRecord.RESET;
                                TeamNew.RESET;
                                IF TeamNew.FINDSET THEN
                                    REPEAT
                                        NumberOfDimensionTempRecord.RESET;
                                        NumberOfDimensionTempRecord.SETFILTER("Department Type", '%1', 9);
                                        NumberOfDimensionTempRecord.SETFILTER("Team Description", '%1', TeamNew.Name);
                                        NumberOfDimensionTempRecord.SETFILTER("ORG Shema", '%1', OSNew.Code);
                                        IF NumberOfDimensionTempRecord.FINDSET THEN BEGIN
                                            BrojTroškovnihcentara := NumberOfDimensionTempRecord.COUNT;
                                            IF BrojTroškovnihcentara = 1 THEN BEGIN
                                                TeamNew."Name of TC" := NumberOfDimensionTempRecord."Dimension Value Code" + '-' + NumberOfDimensionTempRecord."Dimension  Name";
                                                TeamNew.MODIFY;
                                            END;
                                        END;

                                    UNTIL TeamNew.NEXT = 0;

                                Orgs.RESET;
                                Orgs.SETFILTER(Status, '%1', Orgs.Status::Preparation);
                                IF Orgs.FINDLAST THEN BEGIN
                                    Orgs."Create date of org.prep" := TODAY;
                                    Orgs."Operator No." := USERID;
                                    Orgs."Last Date Modified" := TODAY;
                                    Orgs.MODIFY;
                                END;

                                MESSAGE(Text000);
                                SectorTemp.RUN;
                            END;
                        END;

                    end;
                }
                action(Sector)
                {
                    Caption = 'Sector';
                    Image = DimensionSets;
                    RunObject = Page "Sector temporary sist";
                    ApplicationArea = all;
                }
                action(Department)
                {
                    Caption = 'Department';
                    Image = DimensionSets;
                    RunObject = Page "Dep.Category temporary sist";
                    ApplicationArea = all;
                }
                action(Group)
                {
                    Caption = 'Group';
                    Image = DefaultDimension;
                    RunObject = Page "Group temporary sist";
                    ApplicationArea = all;
                }
                /*    action(Teams)
                    {
                        Caption = 'Teams';
                        Image = TeamSales;
                        RunObject = Page "Team temporary sist";
                        ApplicationArea = all;
                        Visible = false;
                    }*/
                action("Positions and TC")
                {
                    Caption = 'Positions and TC';
                    Image = DistributionGroup;
                    RunObject = Page "Position menu temp";
                    ApplicationArea = all;
                }
                action(ECL)
                {
                    Caption = 'Employee contract ledger';
                    Image = DistributionGroup;
                    RunObject = Page "ECL Systematizations";
                    ApplicationArea = all;
                }
                action("Heaf of's")
                {
                    Caption = 'Heaf of''s';
                    Image = DistributionGroup;
                    RunObject = Page "Head Of's temporary sist";
                    ApplicationArea = all;
                }
                action(Departments)
                {
                    Caption = 'Departments';
                    Image = DistributionGroup;
                    RunObject = Page "Department temporary sist";
                    ApplicationArea = all;
                }
                action("Position with employee")
                {
                    Caption = 'Position with employee';
                    Image = DistributionGroup;
                    RunObject = Page "Position temporary sist";
                    Visible = false;
                    ApplicationArea = all;

                }
            }

            action("Org Correction")
            {
                Caption = 'Org Correction';
                Image = "Report";
                Promoted = false;
                Visible = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = false;
                //   RunObject = Report "Update Pos Code";
            }

        }
    }

    var
        Sector: Record "Sector";
        UpdatePostTable: Record "Position Minimal Education";
        ExeManager: Record "Exe Manager";
        ExeManagerInit: Record "Exe Manager temporery";
        UpdatePostTableInit: Record "Position Minimal Educ Temp";
        SectorNew: Record "Sector temporary";
        OS: Record "ORG Shema";
        DepCat: Record "Department Category";
        DepCatNew: Record "Department Category temporary";
        Group: Record Group;
        GroupNew: Record "Group temporary";
        OSNew: Record "ORG Shema";
        Text000: Label 'New hierarchy is created.';
        Text001: Label 'There is no active hierarchy.';
        Team: Record "TeamT";
        TeamNew: Record "Team temporary";
        Department: Record "Department";
        DepartmentNew: Record "Department temporary";
        Position: Record "Position";
        PositionNew: Record "Position Menu temporary";
        HeadOf: Record "Head Of's";
        HeadOfNew: Record "Head Of's temporary";
        ECL: Record "Employee Contract Ledger";
        PosECL: Record "Position";
        PosECL2: Record "Position";
        ECLCh: Record "Employee Contract Ledger";
        ECLCopy: Record "ECL systematization";
        ECLCopy2: Record "Employee Contract Ledger";
        GrECL: Record "Group";
        PositionMenu: Record "Position Menu";
        PositionMenuNew: Record "Position Menu temporary";
        PositionTry: Record "Position";
        OrgShema1: Record "ORG Shema";
        OrgShema2: Record "ORG Shema";
        datum: Date;
        SetChange: Record "ORG Shema";
        Text002: Label 'Do you want to create a new hierarchy?';
        Response: Boolean;
        SectorTemp: Page "Sector temporary sist";
        DimesnionsForPos: Record "Dimension for position";
        DimesnionsForPosNew: Record "Dimension temp for position";
        DimesnionTempOrg: Record "Dimension temporary";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsTempNew: Record "Position Benefits temporery";
        BenefitsTemp1: Record "Position Benefits";
        ECLSystematization: Record "ECL systematization";
        ECLOrginal: Record "Employee Contract Ledger";
        ECLRename: Record "ECL systematization";
        NewNo: Integer;
        ECLRename1: Record "ECL systematization";
        PositionTemp: Record "Position temporery";
        ECLSys: Record "ECL systematization";
        NewNumber: Integer;
        ECLSys1: Record "ECL systematization";
        SectorIdentityNew: Integer;
        DepCatNewIndentity: Integer;
        GroupIdentityNew: Integer;
        TeamIdentityNew: Integer;
        PosMneNuw: Record "Position Menu temporary";
        BrojPozicija: Integer;
        PosMenuForDelete: Record "Position Menu temporary";
        OrginalDepCode: Record "Position Menu temporary";
        DepNew: Record "Department temporary";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        DV: Record "Dimension Value";
        SectorNewCheck: Record "Sector temporary";
        SectorOrg: Record "Sector temporary";
        EmployeeRec: Record "Employee";
        DimensionTemp: Record "Dimension temporary";
        DimensionTempNew: Record "Dimension temporary";
        NumberOfDimensionTempRecord: Record "Dimension temporary";
        "BrojTroškovnihcentara": Integer;
        Orgs: Record "ORG Shema";
        //   RES: Report "Azuriraj troskovni centar";
        Pos: Record "Position Menu";
        //    Grade: Record "Grade";
        //  GradeNew: Record "Grade";
        PositionFind: Record "Position";
        PositionNewIdentity: Integer;

    local procedure StartingDateOnAfterValidate()
    begin
        CurrPage.UPDATE;
    end;
}

