report 50091 "Systematization job"
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    Caption = 'Systematization job';
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
    var
        DirectionYes: Record "Department Category";
    begin

        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
        IF OrgShema.FINDLAST THEN BEGIN
            IF WORKDATE = CALCDATE('<-1D>', OrgShema."Date From") THEN BEGIN
                /*   //IF OrgShema."Change Org"=FALSE THEN BEGIN
                   SectorOrginal.RESET;
                   SectorOrginal.SETFILTER("Org Shema",'%1',OrgShema.Code);
                   IF SectorOrginal.FINDSET THEN REPEAT
                     SectorOrginal.DELETE;
                 UNTIL SectorOrginal.NEXT=0;

                    DepCatOrginal.RESET;
                    DepCatOrginal.SETFILTER("Org Shema",'%1',OrgShema.Code);
                   IF  DepCatOrginal.FINDSET THEN  REPEAT
                      DepCatOrginal.DELETE;
                   UNTIL DepCatOrginal.NEXT=0;

               GroupOrginal.RESET;
                GroupOrginal.SETFILTER("Org Shema",'%1',OrgShema.Code);
                   IF  GroupOrginal.FINDSET THEN  REPEAT
                      GroupOrginal.DELETE;
                   UNTIL GroupOrginal.NEXT=0;
                   TeamOrginal.RESET;
                TeamOrginal.SETFILTER("Org Shema",'%1',OrgShema.Code);
                   IF TeamOrginal.FINDSET THEN  REPEAT
                      TeamOrginal.DELETE;
                   UNTIL TeamOrginal.NEXT=0;


                DepartmentOrginal.RESET;
                DepartmentOrginal.SETFILTER("ORG Shema",'%1',OrgShema.Code);
                   IF   DepartmentOrginal.FINDSET THEN  REPEAT
                       DepartmentOrginal.DELETE;
                 UNTIL DepartmentOrginal.NEXT=0;

                HeadOfOrginal.RESET;
                HeadOfOrginal.SETFILTER("ORG Shema",'%1',OrgShema.Code);
                   IF   HeadOfOrginal.FINDSET THEN  REPEAT
                       HeadOfOrginal.DELETE;
                 UNTIL HeadOfOrginal.NEXT=0;

                DimensionOrginalPos.RESET;
               DimensionOrginalPos.SETFILTER("ORG Shema",'%1',OrgShema.Code);
                   IF   DimensionOrginalPos.FINDSET THEN  REPEAT
                     DimensionOrginalPos.DELETE;
                UNTIL  DimensionOrginalPos.NEXT=0;
                  BenefitsOrginal.RESET;
                BenefitsOrginal.SETFILTER("Org. Structure",'%1',OrgShema.Code);
                   IF   BenefitsOrginal.FINDSET THEN  REPEAT
                       BenefitsOrginal.DELETE;
                 UNTIL  BenefitsOrginal.NEXT=0;
                    PositionMenuOrginal.RESET;
                PositionMenuOrginal.SETFILTER("Org. Structure",'%1',OrgShema.Code);
                   IF   PositionMenuOrginal.FINDSET THEN  REPEAT
                       PositionMenuOrginal.DELETE;
                UNTIL   PositionMenuOrginal.NEXT=0;

               //HeadOfOrginal



               SectorOrginal.RESET;
               SectorOrginal.SETFILTER("Org Shema",'%1',OrgShema.Code);
               IF NOT SectorOrginal.FINDFIRST THEN BEGIN
               IF  SectorTemp.FINDSET THEN REPEAT
                    SectorOrginal.INIT;
                    SectorOrginal.TRANSFERFIELDS(SectorTemp);
                    OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                      SectorOrginal."Last Date Modified":=OrgSNew."Date From";
                      SectorOrginal."Operator No.":=OrgSNew."Operator No.";
                      END;
                    SectorOrginal1.SETFILTER(Code,'%1',SectorOrginal.Code);
                    SectorOrginal1.SETFILTER(Description,'%1',SectorOrginal.Description);
                    SectorOrginal1.SETFILTER("Org Shema",'%1',OrgShema.Code);
                    IF NOT SectorOrginal1.FINDFIRST THEN
                    SectorOrginal.INSERT;
                    UNTIL SectorTemp.NEXT=0;
                    END;
                    IF DepCatTemp.FINDSET THEN REPEAT
                    DepCatOrginal.INIT;
                    DepCatOrginal.TRANSFERFIELDS(DepCatTemp);
                        OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                     DepCatOrginal."Last Date Modified":=OrgSNew."Date From";
                      DepCatOrginal."Operator No.":=OrgSNew."Operator No.";
                      END;

                    DepCatOrginal1.SETFILTER(Description,'%1',DepCatOrginal.Description);
                    DepCatOrginal1.SETFILTER(Code,'%1',DepCatOrginal.Code);
                    DepCatOrginal1.SETFILTER("Org Shema",'%1',OrgShema.Code);
                    IF NOT DepCatOrginal1.FINDFIRST THEN
                    DepCatOrginal.INSERT;
                    UNTIL DepCatTemp.NEXT=0;
                    IF GroupTemp.FINDSET THEN REPEAT
                     GroupOrginal.INIT;
                     GroupOrginal.TRANSFERFIELDS(GroupTemp);
                         OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                      GroupOrginal."Last Date Modified":=OrgSNew."Date From";
                      GroupOrginal."Operator No.":=OrgSNew."Operator No.";
                      END;
                     GroupOrginal1.SETFILTER(Description,'%1',GroupOrginal.Description);
                   GroupOrginal1.SETFILTER(Code,'%1',GroupOrginal.Code);
                    GroupOrginal1.SETFILTER("Org Shema",'%1',OrgShema.Code);
                    IF NOT GroupOrginal1.FINDFIRST THEN
                     GroupOrginal.INSERT;
                 UNTIL GroupTemp.NEXT=0;

                      IF TeamTemp.FINDSET THEN REPEAT
                     TeamOrginal.INIT;
                     TeamOrginal.TRANSFERFIELDS(TeamTemp);
                         OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                      TeamOrginal."Last Date Modified":=OrgSNew."Date From";
                      TeamOrginal."Operator No.":=OrgSNew."Operator No.";
                      END;
                      TeamOrginal1.SETFILTER(Name,'%1',TeamOrginal.Name);
                   TeamOrginal1.SETFILTER(Code,'%1',TeamOrginal.Code);
                    TeamOrginal1.SETFILTER("Org Shema",'%1',OrgShema.Code);
                    IF NOT TeamOrginal1.FINDFIRST THEN

                     TeamOrginal.INSERT;
                 UNTIL TeamTemp.NEXT=0;
                      IF DepartmentTemp.FINDSET THEN REPEAT
                     DepartmentOrginal.INIT;
                     DepartmentOrginal.TRANSFERFIELDS(DepartmentTemp);
                      DepartmentOrginal1.SETFILTER(Description,'%1', DepartmentOrginal.Description);
                    DepartmentOrginal1.SETFILTER(Code,'%1', DepartmentOrginal.Code);
                    DepartmentOrginal1.SETFILTER("Department Categ.  Description",'%1',DepartmentOrginal."Department Categ.  Description");
                    DepartmentOrginal1.SETFILTER("Group Description",'%1',DepartmentOrginal."Group Description");
                    DepartmentOrginal1.SETFILTER("Team Description",'%1',DepartmentOrginal."Team Description");
                     DepartmentOrginal1.SETFILTER("ORG Shema",'%1',OrgShema.Code);
                    IF NOT  DepartmentOrginal1.FINDFIRST THEN
                     DepartmentOrginal.INSERT;
                 UNTIL DepartmentTemp.NEXT=0;
                  IF HeadOfTemp.FINDSET THEN REPEAT
                     HeadOfOrginal.INIT;
                     HeadOfOrginal.TRANSFERFIELDS(HeadOfTemp);
                     HeadOfOrginal1.SETFILTER("Department Code",'%1', HeadOfOrginal."Department Code");
                     HeadOfOrginal1.SETFILTER("Sector  Description",'%1', HeadOfOrginal."Sector  Description");
                      HeadOfOrginal1.SETFILTER("Department Categ.  Description",'%1', HeadOfOrginal."Department Categ.  Description");
                       HeadOfOrginal1.SETFILTER("Group Description",'%1', HeadOfOrginal."Group Description");
                        HeadOfOrginal1.SETFILTER("Team Description",'%1', HeadOfOrginal."Team Description");
                    HeadOfOrginal1.SETFILTER("ORG Shema",'%1',OrgShema.Code);
                    IF NOT HeadOfOrginal1.FINDFIRST THEN
                     HeadOfOrginal.INSERT;
                 UNTIL HeadOfTemp.NEXT=0;
                  IF DimensionTempPos.FINDSET THEN REPEAT
                     DimensionOrginalPos.INIT;
                     DimensionOrginalPos.TRANSFERFIELDS(DimensionTempPos);
                    DimensionOrginalPos1.RESET;
                    DimensionOrginalPos1.SETFILTER("Position Code",'%1',DimensionOrginalPos."Position Code");
                    DimensionOrginalPos1.SETFILTER("Position Description",'%1',DimensionOrginalPos."Position Description");
                    DimensionOrginalPos1.SETFILTER("Dimension Value Code",'%1',DimensionOrginalPos."Dimension Value Code");
                    DimensionOrginalPos1.SETFILTER("Org Belongs",'%1',DimensionOrginalPos."Org Belongs");
                    IF NOT DimensionOrginalPos1.FIND('-') THEN
                     DimensionOrginalPos.INSERT;
                 UNTIL DimensionTempPos.NEXT=0;
                 IF BenefitsTemp.FINDSET THEN REPEAT
                     BenefitsOrginal.INIT;
                     BenefitsOrginal.TRANSFERFIELDS(BenefitsTemp);
                     BenefitsOrginal1.RESET;
                     BenefitsOrginal1.SETFILTER("Position Code",'%1',BenefitsOrginal."Position Code");
                     BenefitsOrginal1.SETFILTER("Position Name",'%1',BenefitsOrginal."Position Name");
                     BenefitsOrginal1.SETFILTER(Code,'%1',BenefitsOrginal.Code);
                     BenefitsOrginal1.SETFILTER("Org. Structure",'%1',BenefitsOrginal."Org. Structure");
                     IF NOT BenefitsOrginal1.FINDFIRST THEN
                    BenefitsOrginal.INSERT;
                 UNTIL BenefitsTemp.NEXT=0;
                  IF PositionMenuTemp.FINDSET THEN REPEAT
                     PositionMenuOrginal.INIT;
                     PositionMenuOrginal.TRANSFERFIELDS(PositionMenuTemp);
                         OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                      PositionMenuOrginal."Last Date Modified":=OrgSNew."Date From";
                      PositionMenuOrginal."Operator No.":=OrgSNew."Operator No.";
                      END;

                     PoSMenDUp.RESET;
                     PoSMenDUp.SETFILTER(Code,'%1',PositionMenuOrginal.Code);
                     PoSMenDUp.SETFILTER(Description,'%1',PositionMenuOrginal.Description);
                     PoSMenDUp.SETFILTER("Department Code",'%1',PositionMenuOrginal."Department Code");
                     PoSMenDUp.SETFILTER("Org. Structure",'%1',OrgShema.Code);
                     IF NOT PoSMenDUp.FINDFIRST THEN
                   PositionMenuOrginal.INSERT;
                 UNTIL PositionMenuTemp.NEXT=0;
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
                             OrgSNew.RESET;
                    OrgSNew.SETFILTER(Status,'%1',OrgSNew.Status::Preparation);
                    IF OrgSNew.FINDFIRST THEN BEGIN
                      PositionMenuOrginal1."Last Date Modified":=OrgSNew."Date From";
                      PositionMenuOrginal1."Operator No.":=OrgSNew."Operator No.";
                      END;

                         PositionMenuOrginal1.Description:=DimensionTempPos."Position Description";
                         PositionMenuOrginal1."Org. Structure":=DimensionTempPos."ORG Shema";
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

                 IF NOT PosMenOrg.GET(PositionMenuOrginal1.Code,PositionMenuOrginal1.Description,PositionMenuOrginal1."Department Code",PositionMenuOrginal1."Org. Structure") THEN
                 //Code,Description,Department Code,Org. Structure
                 PositionMenuOrginal1.INSERT;

                  UNTIL DimensionTempPos.NEXT=0
                  UNTIL PositionMenuOrginal.NEXT=0;
                  PositionMenuOrginal.RESET;
                  PositionMenuOrginal.SETFILTER("Department Code",'%1','');
                        IF PositionMenuOrginal.FINDSET THEN REPEAT
                  PositionMenuOrginal.DELETE;
                  UNTIL PositionMenuOrginal.NEXT=0;
                  */


                Commit();
                UpdateDep.run();
                Commit();
                OrgShema."Change Org" := TRUE;
                OrgShema.MODIFY;
            END;

            //  END;


            IF WORKDATE = CALCDATE('<-1D>', OrgShema."Date From") THEN BEGIN
                ECLSis.RESET;
                ECLSis.SETFILTER("Changing Position", '%1', FALSE);
                ECLSis.SETFILTER("Will Be Changed Later", '%1', FALSE);
                IF ECLSis.FINDSET THEN BEGIN
                    Brojac := ECLSis.COUNT;
                END;

            END;
            OrgShema.RESET;
            OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
            IF OrgShema.FINDLAST THEN BEGIN
                IF WORKDATE = CALCDATE('<-1D>', OrgShema."Date From") THEN BEGIN
                    Novi := 0;
                    ECLSyst.SETCURRENTKEY("Order By Managment");
                    ECLSyst.SETFILTER("Changing Position", '%1', FALSE);
                    ECLSyst.SETFILTER("Will Be Changed Later", '%1', FALSE);
                    ECLSyst.ASCENDING;
                    IF ECLSyst.FINDSET THEN
                        REPEAT
                            ECLSis.SETFILTER("Employee No.", '%1', ECLSyst."Employee No.");
                            IF ECLSis.FINDFIRST THEN BEGIN
                                ECLOrg11.RESET;
                                ECLOrg11.SETFILTER("Employee No.", '%1', ECLSis."Employee No.");
                                ECLOrg11.SETFILTER("Org. Structure", '%1', ECLSis."Org. Structure");
                                IF NOT ECLOrg11.FINDFIRST THEN BEGIN
                                    Novi := Novi + 1;

                                    ECLOrg.INIT;
                                    BR.RESET;
                                    BR.SETCURRENTKEY("No.");
                                    BR.ASCENDING;
                                    IF BR.FINDLAST THEN BEGIN
                                        IF BR."No." + 1 <> ECLSis."No." THEN BEGIN
                                            IF ECLSYSTChangeBR.GET(ECLSis."No.", ECLSis."Employee No.") THEN
                                                ECLSYSTChangeBR.RENAME(BR."No." + 1, ECLSis."Employee No.");
                                        END;
                                    END;
                                    //ECLOrg.TRANSFERFIELDS(ECLSis);
                                    IzUgovora.RESET;
                                    IzUgovora.SETFILTER("Employee No.", '%1', ECLSis."Employee No.");
                                    IzUgovora.SETFILTER(Active, '%1', TRUE);
                                    IzUgovora.SETFILTER("Ending Date", '>=%1|%2', OrgShema."Date From", 0D);
                                    IF IzUgovora.FINDFIRST THEN BEGIN
                                        ECLOrg.COPY(IzUgovora, FALSE);
                                        ECLCopy2.RESET;
                                        ECLCopy2.SETFILTER("No.", '<>%1', 0);
                                        ECLCopy2.SETCURRENTKEY("No.");
                                        ECLCopy2.ASCENDING;
                                        IF ECLCopy2.FINDLAST THEN
                                            ECLOrg."No." := ECLCopy2."No." + 1
                                        ELSE
                                            ECLOrg."No." := 1;









                                        ECLOrg."Org. Structure" := OrgShema.Code;

                                        IF (ECLOrg."Group Description" <> '') AND (ECLOrg."Team Description" = '') THEN BEGIN
                                            GroupOrginal.RESET;
                                            GroupOrginal.SETFILTER(Description, '%1', ECLOrg."Group Description");
                                            GroupOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
                                            IF GroupOrginal.FINDFIRST THEN BEGIN
                                                ECLOrg.VALIDATE("Group Description", ECLOrg."Group Description");
                                                ECLOrg."Department Name" := ECLOrg."Group Description";
                                            END
                                            ELSE BEGIN
                                                ECLOrg.VALIDATE("Group Description", '');
                                            END;
                                        END;
                                        IF (ECLOrg."Department Cat. Description" <> '') AND (ECLOrg."Group Description" = '') THEN BEGIN
                                            DepCatOrginal.RESET;
                                            DepCatOrginal.SETFILTER(Description, '%1', ECLOrg."Department Cat. Description");
                                            DepCatOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
                                            IF DepCatOrginal.FINDFIRST THEN BEGIN
                                                ECLOrg.VALIDATE("Department Cat. Description", ECLOrg."Department Cat. Description");
                                                ECLOrg."Department Name" := ECLOrg."Department Cat. Description";
                                            END
                                            ELSE BEGIN
                                                ECLOrg.VALIDATE("Department Cat. Description", '');
                                            END;


                                        END;
                                        IF (ECLOrg."Sector Description" <> '') AND (ECLOrg."Department Cat. Description" = '') THEN BEGIN
                                            SectorOrginal.RESET;
                                            SectorOrginal.SETFILTER(Description, '%1', ECLOrg."Sector Description");
                                            SectorOrginal.SETFILTER("Org Shema", '%1', OrgShema.Code);
                                            IF SectorOrginal.FINDFIRST THEN BEGIN
                                                ECLOrg.VALIDATE("Sector Description", ECLOrg."Sector Description");
                                                ECLOrg."Department Name" := ECLOrg."Sector Description";

                                            END
                                            ELSE BEGIN
                                                ECLOrg.VALIDATE("Sector Description", '');
                                            END;
                                        END;

                                        PositionMenuOrginal.RESET;
                                        PositionMenuOrginal.SETFILTER(Description, '%1', ECLOrg."Position Description");
                                        //PositionMenuOrginal.SETFILTER(Code,'%1',ECLOrg."Position Code");
                                        PositionMenuOrginal.SETFILTER("Org. Structure", '%1', ECLOrg."Org. Structure");
                                        PositionMenuOrginal.SETFILTER("Department Code", '%1', ECLOrg."Department Code");
                                        IF PositionMenuOrginal.FINDFIRST THEN BEGIN
                                            DepartmentOrginal.RESET;
                                            DepartmentOrginal.SETFILTER(Description, '%1', ECLOrg."Org Belongs");
                                            DepartmentOrginal.SETFILTER("ORG Shema", '%1', ECLOrg."Org. Structure");
                                            IF DepartmentOrginal.FINDFIRST THEN BEGIN
                                                DepartmentCodeForpos := DepartmentOrginal.Code;
                                            END;
                                            ECLOrg.VALIDATE("Position Description", ECLOrg."Position Description");


                                        END

                                        ELSE BEGIN
                                            ECLOrg.VALIDATE("Position Description", '');
                                            ECLOrg."Starting Date" := 0D;
                                            ECLOrg."Ending Date" := 0D;
                                            ECLOrg."Work Days" := 0;
                                            ECLOrg."Work Months" := 0;
                                            ECLOrg."Work Years" := 0;
                                            ECLOrg."Probation Days" := 0;
                                            ECLOrg."Probation Months" := 0;
                                            ECLOrg."Probation Year" := 0;
                                            ECLOrg."Attachment No." := 0;
                                            //   ECLOrg."Agreement Name" := '';
                                            ECLOrg."Agremeent Code" := '';
                                            ECLOrg."Sent Mail Change Pos" := FALSE;
                                            ECLOrg."Sent Mail Duration" := FALSE;
                                            ECLOrg."Sent Mail Employment" := FALSE;
                                            ECLOrg."Sent Mail Termination" := FALSE;
                                        END;

                                        IF ECLOrg."Org Unit Name" <> '' THEN BEGIN
                                            ORGDijelovi.RESET;
                                            ORGDijelovi.SETFILTER(Description, '%1', ECLOrg."Org Unit Name");
                                            ORGDijelovi.SETFILTER(Active, '%1', TRUE);
                                            IF ORGDijelovi.FINDFIRST THEN BEGIN

                                                ECLOrg.VALIDATE("Org Unit Name", ECLOrg."Org Unit Name");
                                            END
                                            ELSE BEGIN
                                                ECLOrg.VALIDATE("Org Unit Name", '');
                                                ECLOrg."Sent Mail Change Pos" := FALSE;
                                                ECLOrg."Sent Mail Duration" := FALSE;
                                                ECLOrg."Sent Mail Employment" := FALSE;
                                                ECLOrg."Sent Mail Termination" := FALSE;
                                                ECLOrg."Ending Date" := 0D;
                                                ECLOrg."Work Days" := 0;
                                                ECLOrg."Work Months" := 0;
                                                ECLOrg."Work Years" := 0;
                                                ECLOrg."Probation Days" := 0;
                                                ECLOrg."Probation Months" := 0;
                                                ECLOrg."Probation Year" := 0;
                                                ECLOrg."Attachment No." := 0;
                                                //       ECLOrg."Agreement Name" := '';
                                                ECLOrg."Agremeent Code" := '';
                                                ECLOrg."Starting Date" := 0D;
                                            END;

                                        END;
                                        IF ECLOrg."GF of work Description" <> '' THEN BEGIN
                                            ORGDijelovi.RESET;
                                            ORGDijelovi.SETFILTER(Description, '%1', ECLOrg."GF of work Description");
                                            ORGDijelovi.SETFILTER(Active, '%1', TRUE);
                                            IF ORGDijelovi.FINDFIRST THEN BEGIN
                                                ECLOrg.VALIDATE("GF of work Description", ECLOrg."GF of work Description");
                                            END
                                            ELSE BEGIN
                                                ECLOrg.VALIDATE("GF of work Description", '');
                                                ECLOrg."Sent Mail Change Pos" := FALSE;
                                                ECLOrg."Sent Mail Duration" := FALSE;
                                                ECLOrg."Sent Mail Employment" := FALSE;
                                                ECLOrg."Sent Mail Termination" := FALSE;
                                                ECLOrg."Ending Date" := 0D;
                                                ECLOrg."Starting Date" := 0D;
                                                ECLOrg."Work Days" := 0;
                                                ECLOrg."Work Months" := 0;
                                                ECLOrg."Work Years" := 0;
                                                ECLOrg."Probation Days" := 0;
                                                ECLOrg."Probation Months" := 0;
                                                ECLOrg."Probation Year" := 0;
                                                ECLOrg."Attachment No." := 0;
                                                //    ECLOrg."Agreement Name" := '';
                                                ECLOrg."Agremeent Code" := '';
                                            END;
                                        END;
                                        ECLOrg."Employee No." := ECLSyst."Employee No.";
                                        ECLOrg."Employee Name" := ECLSyst."Employee Name";
                                        IF ECLOrg."Operator No." = '' THEN
                                            ECLOrg."Operator No." := USERID;
                                        PositionIDFind.RESET;
                                        PositionIDFind.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                                        PositionIDFind.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                        IF PositionIDFind.FINDFIRST THEN BEGIN
                                            ECLOrg."Position ID" := PositionIDFind."Position ID";
                                        END;
                                        ECLOrg."Org. Structure" := OrgShema.Code;
                                        ECLOrg1.RESET;
                                        ECLOrg1.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                        ECLOrg1.SETFILTER("No.", '%1', ECLOrg."No.");
                                        ECLOrg1.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                                        IF NOT ECLOrg1.FINDFIRST THEN BEGIN
                                            ECLOrg.Active := FALSE;
                                            ECLOrg.Status := ECLOrg.Status::Active;
                                            PositionBenef.RESET;
                                            PositionBenef.SETFILTER("Position Code", '%1', ECLOrg."Position Code");
                                            PositionBenef.SETFILTER("Position Name", '%1', ECLOrg."Position Description");
                                            PositionBenef.SETFILTER("Org. Structure", '%1', ECLOrg."Org. Structure");
                                            IF PositionBenef.FINDSET THEN
                                                REPEAT
                                                    MAIS.INIT;
                                                    MAIS."Employee No." := ECLOrg."Employee No.";
                                                    MAIS."Misc. Article Code" := PositionBenef.Code;
                                                    MAIS.Description := PositionBenef.Description;
                                                    MAI1.RESET;
                                                    EmployeeContractLedger2.RESET;
                                                    EmployeeContractLedger2.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                                    EmployeeContractLedger2.SETFILTER(Active, '%1', TRUE);
                                                    IF EmployeeContractLedger2.FINDLAST THEN BEGIN
                                                        //      MAI1.SETFILTER("Emp. Contract Ledg. Entry No.", '%1', EmployeeContractLedger2."No.");
                                                        //      MAI1.SETFILTER("Misc. Article Code", '%1', MAIS."Misc. Article Code");
                                                        //      MAI1.SETFILTER(Description, '%1', MAIS.Description);
                                                        IF MAI1.FINDFIRST THEN
                                                            MAIS."From Date" := MAI1."From Date";
                                                    END;
                                                    MAIS.Amount := PositionBenef.Amount;
                                                    MAIS."Position Code" := ECLOrg."Position Code";
                                                    MAIS."Emp. Contract Ledg. Entry No." := ECLOrg."No.";
                                                    MAIS."Org Shema" := ECLOrg."Org. Structure";
                                                //    MAIS.INSERT;

                                                UNTIL PositionBenef.NEXT = 0;
                                        END;
                                        ECLOrg.INSERT(FALSE);

                                        ECLOrg11.RESET;
                                        ECLOrg11.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                                        ECLOrg11.SETFILTER(Active, '%1', TRUE);
                                        IF ECLOrg11.FINDFIRST THEN BEGIN

                                            IF ((ECLOrg11."Sector Description" = ECLOrg."Sector Description") AND (ECLOrg11."Department Cat. Description" = ECLOrg."Department Cat. Description")
                                             AND (ECLOrg11."Group Description" = ECLOrg."Group Description")
                                            AND (ECLOrg11."Team Description" = ECLOrg."Team Description") AND
                                            (ECLOrg11."Reason for Change" = ECLOrg."Reason for Change") AND (ECLOrg11."Branch Agency" = ECLOrg."Branch Agency")
                                            AND (ECLOrg11."Org Unit Name" = ECLOrg."Org Unit Name") AND (ECLOrg11."GF of work Description" = ECLOrg."GF of work Description")
                                            AND (ECLOrg11.IS = ECLOrg.IS)
                                            AND (ECLOrg11."IS Date From" = ECLOrg."IS Date From") AND (ECLOrg11."IS Date To" = ECLOrg."IS Date To")
                                            AND (ECLOrg11."Position Description" = ECLOrg."Position Description")) THEN BEGIN
                                                ECLOrg."Show Record" := FALSE;
                                                ECLOrg.MODIFY(FALSE);
                                            END
                                            ELSE BEGIN
                                                ECLOrg."Show Record" := TRUE;
                                                IF (ECLOrg."Position Description" <> '') AND (ECLOrg."Starting Date" <> 0D) THEN
                                                    ECLOrg."Reason for Change" := ECLOrg."Reason for Change"::Systematization;
                                                //ĐKif ECLOrg."Starting Date" <> OrgShema."Date From" then begin
                                                //ĐK ECLOrg.Validate("Starting Date", OrgShema."Date From");
                                                //    ECLOrg."Starting Date" := OrgShema."Date From";
                                                // end;
                                                ECLOrg.MODIFY(FALSE);
                                            END;

                                        END;
                                    END;
                                END;
                            END;
                        UNTIL ECLSyst.NEXT = 0;
                END;
            END;

        END;
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
        IF OrgShema.FINDLAST THEN BEGIN
            IF WORKDATE = CALCDATE('<-1D>', OrgShema."Date From") THEN BEGIN
                /* IF OrgShema."Sent Mail Systematization" = FALSE THEN BEGIN
                     CLEAR(ECLSYSEmail);
                     ECLOrg.RESET;
                     ECLOrg.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                     ECLOrg.SETFILTER("Show Record", '%1', TRUE);
                     ECLOrg.SETFILTER("Position Description", '<>%1', '');
                     ECLOrg.SETFILTER("Starting Date", '<>%1', 0D);
                     IF ECLOrg.FINDSET THEN BEGIN
                         REPORT.RUNMODAL(206, FALSE, FALSE, ECLOrg);
                         COMMIT;

                     END;
                 END*/
                PositionBenef.RESET;
                PositionBenef.SETFILTER("Position Code", '%1', ECLOrg."Position Code");
                PositionBenef.SETFILTER("Position Name", '%1', ECLOrg."Position Description");
                PositionBenef.SETFILTER("Org. Structure", '%1', OrgShema.Code);
                IF PositionBenef.FINDSET THEN
                    REPEAT


                        //Line No.,Employee No.,Misc. Article Code,Emp. Contract Ledg. Entry No.
                        Misc2.INIT;
                        //   Misc2.VALIDATE("Employee No.", ECLOrg."Employee No.");
                        //  Misc2.VALIDATE("Misc. Article Code", PositionBenef.Code);
                        Misc2."Emp. Contract Ledg. Entry No." := ECLOrg."No.";
                        Misc2."From Date" := ECLOrg."Starting Date";
                        Misc2."To Date" := ECLOrg."Ending Date";
                        Misc2."Org Shema" := OrgShema.Code;
                        Misc2.Amount := PositionBenef.Amount;
                    //    Misc2.INSERT;


                    UNTIL PositionBenef.NEXT = 0;


            END;
        END;


        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Active);
        IF OrgShema.FINDLAST THEN BEGIN

            /*  ECLOrg9.RESET;
              ECLOrg9.SETFILTER("Org. Structure", '%1', OrgShema.Code);
              ECLOrg9.SETFILTER("Show Record", '%1', TRUE);
              ECLOrg9.SETFILTER("Position Description", '<>%1', '');
              ECLOrg9.SETFILTER("Starting Date", '%1', CALCDATE('<+1D>', WORKDATE));
              IF ECLOrg9.FINDSET THEN BEGIN
                  REPORT.RUNMODAL(213, FALSE, FALSE, ECLOrg9);
                  COMMIT;
              END;*/
        END;

        //na taj dan briše troškovne centre i dodjeljuje im nove troškovne centre
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
        IF OrgShema.FINDLAST THEN BEGIN
            IF WORKDATE = OrgShema."Date From" THEN BEGIN
                IF OrgShema."Change Dimension" = FALSE THEN BEGIN
                    /*  IF NOT EmployeeDefaultDimension.ISEMPTY THEN
                  EmployeeDefaultDimension.DELETEALL;*/

                    EmployeeSistematizacija.RESET;
                    IF EmployeeSistematizacija.FINDSET THEN
                        REPEAT
                            EmployeeDefaultDimension.RESET;
                            EmployeeDefaultDimension.SETFILTER("No.", '%1', EmployeeSistematizacija."Employee No.");
                            IF EmployeeDefaultDimension.FINDFIRST THEN
                                EmployeeDefaultDimension.DELETE;

                        UNTIL EmployeeSistematizacija.NEXT = 0;



                    ECLSis.RESET;
                    IF ECLSis.FINDSET THEN
                        REPEAT
                            ECLSyst.RESET;
                            ECLSyst.SETFILTER("No.", '%1', ECLSis."No.");
                            ECLSyst.SETFILTER("Employee No.", '%1', ECLSis."Employee No.");
                            IF ECLSyst.FINDFIRST THEN BEGIN
                                EmployeeDefaultDimension.INIT;
                                EmployeeDefaultDimension.VALIDATE("No.", ECLSyst."Employee No.");
                                if ECLSyst."Dimension Value Code" = '' then begin


                                    DVCheck.Reset();
                                    DVCheck.SetFilter("Dimension Code", '%1', 'TC');
                                    DirectionYes.Reset();
                                    DirectionYes.SetFilter(Code, '%1', ECLSyst."Department Code");
                                    DirectionYes.SetFilter(Direction, '%1', true);
                                    DirectionYes.SetFilter("Org Shema", '%1', ECLSyst."Org. Structure");
                                    if DirectionYes.FindFirst() then
                                        DVCheck.SetFilter(Code, '%1', DirectionYes.Code)
                                    else
                                        DVCheck.SetFilter(code, '%1', ECLSyst.Sector);
                                    if not DVCheck.FindFirst() then begin
                                        DVCheck.Init();
                                        DVCheck."Dimension Code" := 'TC';
                                        DirectionYes.Reset();
                                        DirectionYes.SetFilter(Code, '%1', ECLSyst."Department Code");
                                        DirectionYes.SetFilter(Direction, '%1', true);
                                        DirectionYes.SetFilter("Org Shema", '%1', ECLSyst."Org. Structure");
                                        if DirectionYes.FindFirst() then begin

                                            DVCheck.Code := ECLSyst."Department Category";
                                            DVCheck.Name := ECLSyst."Department Cat. Description";

                                        end
                                        else begin
                                            DVCheck.Code := ECLSyst.Sector;
                                            DVCheck.Name := copystr(ECLSyst."Sector Description", 1, 50);
                                        end;
                                        DVCheck.Status := DVCheck.Status::A;
                                    end;

                                    DVCheck.Reset();
                                    DVCheck.SetFilter(Name, '%1', '');
                                    if DVCheck.FindFirst() then begin

                                        DirectionYes.SetFilter(Code, '%1', ECLSyst."Department Code");
                                        DirectionYes.SetFilter(Direction, '%1', true);
                                        DirectionYes.SetFilter("Org Shema", '%1', ECLSyst."Org. Structure");
                                        if DirectionYes.FindFirst() then
                                            ECLSyst.validate("Dimension  Name", ECLSyst."Department Category")
                                        else
                                            ECLSyst.validate("Dimension  Name", ECLSyst.Sector);
                                    end;

                                    EmployeeDefaultDimension."Dimension Value Code" := ECLSyst."Dimension Value Code";


                                end
                                else begin


                                    EmployeeDefaultDimension."Dimension Value Code" := ECLSyst."Dimension Value Code";
                                end;
                                EmployeeDefaultDimension."Dimension Code" := 'TC';
                                EmployeeDefaultDimension."Amount Distribution Coeff." := 1;
                                EmployeeDefaultDimension.INSERT;
                            END;
                        UNTIL ECLSis.NEXT = 0;
                    //MiscArticleInformation.RESET;

                    //   MiscArticleInformation.SETFILTER("Employee No.", '%1', ECLSyst."Employee No.");
                    IF MiscArticleInformation.FINDSET THEN
                        REPEAT
                            ECL.RESET;
                            ECL.SETFILTER("No.", '%1', MiscArticleInformation."Emp. Contract Ledg. Entry No.");
                            IF ECL.FINDFIRST THEN BEGIN
                                //   IF ECL."Show Record" = FALSE THEN
                                //  MiscArticleInformation.DELETE;
                            END;
                        UNTIL MiscArticleInformation.NEXT = 0;



                    OrgShema."Change Dimension" := TRUE;
                    OrgShema.MODIFY;
                END;
            END;
        END;



        //Ukoliko je prelazak sa stare na novu svi na novoj trebaju biti aktivni, a oni kod kojih se ništa nije mijenjalo (Show record false postaju po staroj sistematizaciji false)
        OrgShema.RESET;
        OrgShema.SETFILTER(Status, '%1', OrgShema.Status::Preparation);
        IF OrgShema.FINDLAST THEN BEGIN
            IF WORKDATE = OrgShema."Date From" THEN BEGIN
                ECLOrg.RESET;
                ECLOrg.SETFILTER("Org. Structure", '%1', OrgShema.Code); //u pripremi
                ECLOrg.SETFILTER("Show Record", '%1', FALSE);
                IF ECLOrg.FINDSET THEN
                    REPEAT
                        ECLOrg1.RESET;
                        ECLOrg1.SETFILTER("Employee No.", '%1', ECLOrg."Employee No.");
                        ECLOrg1.SETFILTER(Active, '%1', TRUE);
                        OrgShema1.RESET;
                        OrgShema1.SETFILTER(Status, '%1', OrgShema1.Status::Active);
                        ECLOrg1.SETCURRENTKEY("Starting Date");
                        ECLOrg1.ASCENDING;
                        IF OrgShema1.FINDLAST THEN BEGIN
                            ECLOrg1.SETFILTER("Org. Structure", '%1', OrgShema1.Code); //aktivna
                        END;
                        IF ECLOrg1.FINDLAST THEN BEGIN
                            IF (ECLOrg1."Starting Date" = ECLOrg."Starting Date") AND (ECLOrg1."Org Belongs" = ECLOrg."Org Belongs") THEN BEGIN
                                ECLOrg1."Show Record" := FALSE;
                                ECLOrg."Show Record" := TRUE;

                                ECLOrg1.Active := FALSE;


                                ECLOrg1.Status := ECLOrg1.Status::Active;
                                IF ECLOrg."Starting Date" <= WORKDATE THEN BEGIN
                                    ECLOrg.Active := TRUE;
                                    ECLOrg.Status := ECLOrg.Status::Active;
                                    //
                                END;
                                ECLOrg.MODIFY(FALSE);
                                /*IF eclorg1111.GET(ECLOrg1."No.",ECLOrg1."Employee No.",ECLOrg1."Org. Structure") THEN
                          eclorg1111.MODIFY(FALSE);*/
                                ECLOrg1.MODIFY;
                                //No.,Employee No.,Org. Structure
                                IF ECLOrg1."Reason for Change" = ECLOrg1."Reason for Change"::"New Contract" THEN BEGIN
                                    Radnaknjizica.RESET;
                                    Radnaknjizica.SETFILTER("Contract Ledger Entry No.", '%1', ECLOrg1."No.");
                                    Radnaknjizica.SETFILTER("Employee No.", '%1', ECLOrg1."Employee No.");
                                    IF Radnaknjizica.FINDFIRST THEN BEGIN
                                        Radnaknjizica."Contract Ledger Entry No." := ECLOrg."No.";
                                        Radnaknjizica.MODIFY;
                                    END;
                                END;
                                //    TokUgovora.RESET;
                                //    TokUgovora.SETFILTER("Employee No.", '%1', ECLOrg1."Employee No.");
                                //   TokUgovora.SETFILTER("Contract Ledger Entry No.", '%1', ECLOrg1."No.");
                                //   IF TokUgovora.FINDFIRST THEN BEGIN
                                //No.,Employee No.,Contract Ledger Entry No.
                                //       IF TokUgovora2.GET(TokUgovora."No.", TokUgovora."Employee No.", TokUgovora."Contract Ledger Entry No.") THEN
                                //          TokUgovora2.RENAME(TokUgovora."No.", TokUgovora."Employee No.", ECLOrg."No.");
                                //  END;


                            END
                            ELSE BEGIN

                                ECLOrg1."Show Record" := TRUE;
                                ECLOrg."Show Record" := TRUE;
                                ECLOrg1.Active := FALSE;
                                ECLOrg.Active := TRUE;
                                ECLOrg.Status := ECLOrg.Status::Active;
                                // ECLOrg1.Status:=ECLOrg1.Status::Active;
                                ECLOrg1.MODIFY(FALSE);
                                ECLOrg.MODIFY(FALSE);
                            END;
                        END;

                    UNTIL ECLOrg.NEXT = 0;




            END;
        END;



        OrgShema1.RESET;
        OrgShema2.RESET;
        OrgShema1.SETFILTER(Status, '%1', OrgShema1.Status::Preparation);
        IF OrgShema1.FINDLAST THEN BEGIN
            IF OrgShema1."Date From" = WORKDATE THEN BEGIN
                OrgShema2.SETFILTER(Status, '%1', OrgShema2.Status::Active);
                IF OrgShema2.FINDLAST THEN BEGIN
                    EmployeeContractChangeOrg.RESET;
                    EmployeeContractChangeOrg.SETFILTER("Starting Date", '>=%1', OrgShema1."Date From");
                    IF EmployeeContractChangeOrg.FINDSET THEN
                        REPEAT
                            IF EmployeeContractChangeOrgRename.GET(EmployeeContractChangeOrg."No.", EmployeeContractChangeOrg."Employee No.", EmployeeContractChangeOrg."Org. Structure") THEN
                                EmployeeContractChangeOrgRename.RENAME(EmployeeContractChangeOrg."No.", EmployeeContractChangeOrg."Employee No.", OrgShema1.Code);
                            IF EmployeeContractChangeOrgRename."Team Description" <> '' THEN BEGIN
                                TemOrg.RESET;
                                TemOrg.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                TemOrg.SETFILTER(Name, '%1', EmployeeContractChangeOrgRename."Team Description");
                                IF TemOrg.FINDFIRST THEN BEGIN
                                    EmployeeContractChangeOrgRename.VALIDATE("Team Description", TemOrg.Name);
                                    EmployeeContractChangeOrgRename.MODIFY;
                                END;
                            END;

                            IF (EmployeeContractChangeOrgRename."Team Description" = '') AND (EmployeeContractChangeOrgRename."Group Description" <> '') THEN BEGIN
                                GroupOrg.RESET;
                                GroupOrg.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                GroupOrg.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Group Description");
                                IF GroupOrg.FINDFIRST THEN BEGIN
                                    EmployeeContractChangeOrgRename.VALIDATE("Group Description", GroupOrg.Description);
                                    EmployeeContractChangeOrgRename.MODIFY;
                                END;
                            END;

                            IF (EmployeeContractChangeOrgRename."Department Category" <> '') AND (EmployeeContractChangeOrgRename."Group Description" = '') THEN BEGIN
                                DepoRG.RESET;
                                DepoRG.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                DepoRG.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Department Cat. Description");
                                IF DepoRG.FINDFIRST THEN BEGIN
                                    EmployeeContractChangeOrgRename.VALIDATE("Department Cat. Description", DepoRG.Description);
                                    EmployeeContractChangeOrgRename.MODIFY;
                                END;
                            END;

                            IF (EmployeeContractChangeOrgRename."Department Category" = '') AND (EmployeeContractChangeOrgRename."Sector Description" <> '') THEN BEGIN
                                SecOrg.RESET;
                                SecOrg.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                SecOrg.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Sector Description");
                                IF SecOrg.FINDFIRST THEN BEGIN
                                    EmployeeContractChangeOrgRename.VALIDATE("Sector Description", SecOrg.Description);
                                    EmployeeContractChangeOrgRename.MODIFY;
                                END;
                            END;

                            PosMenOrgFind.RESET;
                            PosMenOrgFind.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Position Description");
                            PosMenOrgFind.SETFILTER("Org. Structure", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                            PosMenOrgFind.SETFILTER("Department Code", '%1', EmployeeContractChangeOrgRename."Department Code");
                            IF PosMenOrgFind.FINDFIRST THEN BEGIN
                                EmployeeContractChangeOrgRename.VALIDATE("Position Description", PosMenOrgFind.Description);
                                EmployeeContractChangeOrgRename.MODIFY;
                            END;









                            ECLCheck.RESET;
                            ECLCheck.SETFILTER("Starting Date", '<%1', EmployeeContractChangeOrgRename."Starting Date");
                            ECLCheck.SETFILTER("Employee No.", '%1', EmployeeContractChangeOrgRename."Employee No.");
                            ECLCheck.SETFILTER("Org. Structure", '%1', OrgShema1.Code);
                            ECLCheck.SETFILTER("No.", '<>%1', EmployeeContractChangeOrgRename."No.");
                            ECLCheck.SETCURRENTKEY("Starting Date");
                            ECLCheck.ASCENDING;
                            IF ECLCheck.FINDLAST THEN BEGIN
                                IF ((ECLCheck."Sector Description" = EmployeeContractChangeOrgRename."Sector Description") AND (ECLCheck."Department Cat. Description" = EmployeeContractChangeOrgRename."Department Cat. Description")
                                AND (ECLCheck."Group Description" = EmployeeContractChangeOrgRename."Group Description")
                               AND (ECLCheck."Team Description" = EmployeeContractChangeOrgRename."Team Description") AND
                               (ECLCheck."Reason for Change" = EmployeeContractChangeOrgRename."Reason for Change") AND (EmployeeContractChangeOrgRename."Branch Agency" = ECLOrg."Branch Agency")
                               AND (ECLCheck."Org Unit Name" = EmployeeContractChangeOrgRename."Org Unit Name") AND (ECLCheck."GF of work Description" = EmployeeContractChangeOrgRename."GF of work Description")
                               AND (ECLCheck.IS = EmployeeContractChangeOrgRename.IS)
                               AND (ECLCheck."IS Date From" = EmployeeContractChangeOrgRename."IS Date From") AND (EmployeeContractChangeOrgRename."IS Date To" = ECLOrg."IS Date To")
                               AND (ECLCheck."Position Description" = EmployeeContractChangeOrgRename."Position Description")) THEN BEGIN
                                END
                                ELSE BEGIN
                                    IF EmployeeContractChangeOrgRename."The Change is update" = FALSE THEN BEGIN

                                        IF ((ECLCheck."Sector Description" = EmployeeContractChangeOrgRename."Sector Description") AND (ECLCheck."Department Cat. Description" = EmployeeContractChangeOrgRename."Department Cat. Description")
                                     AND (ECLCheck."Group Description" = EmployeeContractChangeOrgRename."Group Description")
                                    AND (ECLCheck."Team Description" = EmployeeContractChangeOrgRename."Team Description") AND (EmployeeContractChangeOrgRename."Branch Agency" = ECLOrg."Branch Agency")
                                    AND (ECLCheck."Org Unit Name" = EmployeeContractChangeOrgRename."Org Unit Name") AND (ECLCheck."GF of work Description" = EmployeeContractChangeOrgRename."GF of work Description")
                                    AND (ECLCheck.IS = EmployeeContractChangeOrgRename.IS)
                                    AND (ECLCheck."IS Date From" = EmployeeContractChangeOrgRename."IS Date From") AND (EmployeeContractChangeOrgRename."IS Date To" = ECLOrg."IS Date To")
                                    AND (ECLCheck."Position Description" = EmployeeContractChangeOrgRename."Position Description")) THEN BEGIN


                                            IF (EmployeeContractChangeOrgRename."Reason for Change".AsInteger() = 6) OR (EmployeeContractChangeOrgRename."Reason for Change".AsInteger() = 17)
                                              OR (EmployeeContractChangeOrgRename."Reason for Change".AsInteger() = 1) THEN BEGIN
                                                IF EmployeeContractChangeOrgRename."Wage Change" = ECLCheck."Wage Change" THEN BEGIN
                                                    EmployeeContractChangeOrgRename.Conflict := FALSE;
                                                    EmployeeContractChangeOrgRename.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    EmployeeContractChangeOrgRename.Conflict := TRUE;
                                                    EmployeeContractChangeOrgRename.MODIFY;
                                                END;
                                            END
                                            ELSE BEGIN
                                                EmployeeContractChangeOrgRename.Conflict := TRUE;
                                                EmployeeContractChangeOrgRename.MODIFY;
                                            END;
                                        END
                                        ELSE BEGIN
                                            EmployeeContractChangeOrgRename.Conflict := TRUE;
                                            EmployeeContractChangeOrgRename.MODIFY;
                                        END;


                                        IF ((ECLCheck."Sector Description" = EmployeeContractChangeOrgRename."Sector Description") AND (ECLCheck."Department Cat. Description" = EmployeeContractChangeOrgRename."Department Cat. Description")
                                        AND (ECLCheck."Group Description" = EmployeeContractChangeOrgRename."Group Description")
                                       AND (ECLCheck."Team Description" = EmployeeContractChangeOrgRename."Team Description") AND (EmployeeContractChangeOrgRename."Branch Agency" = ECLOrg."Branch Agency")
                                       AND (ECLCheck."Org Unit Name" = EmployeeContractChangeOrgRename."Org Unit Name") AND (ECLCheck."GF of work Description" = EmployeeContractChangeOrgRename."GF of work Description")
                                       AND (ECLCheck.IS = EmployeeContractChangeOrgRename.IS)
                                       AND (ECLCheck."IS Date From" = EmployeeContractChangeOrgRename."IS Date From") AND (EmployeeContractChangeOrgRename."IS Date To" = ECLOrg."IS Date To")
                                       AND (ECLCheck."Position Description" = EmployeeContractChangeOrgRename."Position Description")) THEN BEGIN

                                            IF (ECLCheck."Reason for Change".AsInteger() = 6) OR (ECLCheck."Reason for Change".AsInteger() = 17) OR (ECLCheck."Reason for Change".AsInteger() = 1) THEN BEGIN
                                                IF EmployeeContractChangeOrgRename."Wage Change" = ECLCheck."Wage Change" THEN BEGIN
                                                    EmployeeContractChangeOrgRename.Conflict := FALSE;
                                                    EmployeeContractChangeOrgRename.MODIFY;
                                                END
                                                ELSE BEGIN

                                                    EmployeeContractChangeOrgRename.Conflict := TRUE;
                                                    EmployeeContractChangeOrgRename.MODIFY;
                                                END;
                                            END
                                            ELSE BEGIN
                                                EmployeeContractChangeOrgRename.Conflict := TRUE;
                                                EmployeeContractChangeOrgRename.MODIFY;
                                            END;

                                        END
                                        ELSE BEGIN
                                            EmployeeContractChangeOrgRename.Conflict := TRUE;
                                            EmployeeContractChangeOrgRename.MODIFY;
                                        END;

                                    END;




                                END;
                            END;








                            CheckConflict.RESET;
                            CheckConflict.SETFILTER("No.", '%1', EmployeeContractChangeOrg."No.");
                            IF CheckConflict.FINDFIRST THEN BEGIN
                                SectorOrginal.RESET;
                                SectorOrginal.SETFILTER(Code, '%1', EmployeeContractChangeOrgRename.Sector);
                                SectorOrginal.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Sector Description");
                                SectorOrginal.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                IF NOT SectorOrginal.FINDFIRST THEN BEGIN
                                    IF EmployeeContractChangeOrgRename."Modify the change is update" = FALSE THEN BEGIN
                                        EmployeeContractChangeOrgRename.Conflict := TRUE;
                                        EmployeeContractChangeOrgRename.MODIFY;
                                    END;
                                END;
                                IF EmployeeContractChangeOrgRename."Department Cat. Description" <> '' THEN BEGIN
                                    DepCatOrginal.RESET;
                                    DepCatOrginal.SETFILTER(Code, '%1', EmployeeContractChangeOrgRename."Department Category");
                                    DepCatOrginal.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Department Cat. Description");
                                    DepCatOrginal.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                    IF NOT DepCatOrginal.FINDFIRST THEN BEGIN
                                        IF EmployeeContractChangeOrgRename."Modify the change is update" = FALSE THEN BEGIN
                                            EmployeeContractChangeOrgRename.Conflict := TRUE;
                                            EmployeeContractChangeOrgRename.MODIFY;
                                        END;
                                    END;
                                END;

                                IF EmployeeContractChangeOrgRename."Group Description" <> '' THEN BEGIN
                                    GroupOrginal.RESET;
                                    GroupOrginal.SETFILTER(Code, '%1', EmployeeContractChangeOrgRename.Group);
                                    GroupOrginal.SETFILTER(Description, '%1', EmployeeContractChangeOrgRename."Group Description");
                                    GroupOrginal.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                    IF NOT GroupOrginal.FINDFIRST THEN BEGIN
                                        IF EmployeeContractChangeOrgRename."Modify the change is update" = FALSE THEN BEGIN
                                            EmployeeContractChangeOrgRename.Conflict := TRUE;
                                            EmployeeContractChangeOrgRename.MODIFY;
                                        END;
                                    END;
                                END;

                                IF EmployeeContractChangeOrgRename."Team Description" <> '' THEN BEGIN
                                    TeamOrginal.RESET;
                                    TeamOrginal.SETFILTER(Code, '%1', EmployeeContractChangeOrgRename.Team);
                                    TeamOrginal.SETFILTER(Name, '%1', EmployeeContractChangeOrgRename."Team Description");
                                    TeamOrginal.SETFILTER("Org Shema", '%1', EmployeeContractChangeOrgRename."Org. Structure");
                                    IF NOT TeamOrginal.FINDFIRST THEN BEGIN
                                        IF EmployeeContractChangeOrgRename."Modify the change is update" = FALSE THEN BEGIN
                                            EmployeeContractChangeOrgRename.Conflict := TRUE;
                                            EmployeeContractChangeOrgRename.MODIFY;
                                        END;
                                    END;
                                END;





                            END;

                        UNTIL EmployeeContractChangeOrg.NEXT = 0;




                    ECLOrg8.RESET;
                    ECLOrg8.SETFILTER("Org. Structure", '%1', OrgShema.Code); //u pripremi
                    ECLOrg8.SETFILTER("Show Record", '%1', FALSE);
                    IF ECLOrg8.FINDSET THEN
                        REPEAT
                            ECLOrg8."Show Record" := TRUE;
                            IF ECLOrg8."Starting Date" <= WORKDATE THEN
                                ECLOrg8.Active := TRUE;
                            ECLOrg8.MODIFY(FALSE);
                        UNTIL ECLOrg8.NEXT = 0;


                    OrgShema2.Status := 1;
                    OrgShema1.Status := 0;
                    OrgShema1.MODIFY;
                    OrgShema2.MODIFY;
                END;
            END;
        END;

        //  ReportStatusUpdate.RUN;

    end;

    trigger OnPreReport()
    begin
        //ReportStatusUpdate.RUN;
    end;

    var
        ECL: Record "Employee Contract Ledger";
        DVCheck: Record "Dimension Value";
        ReportStatusUpdate: Report "StatusExt update";
        Employee: Record "Employee";
        ECL2: Record "Employee Contract Ledger";
        Employee2: Record "Employee";
        OrgShema: Record "ORG Shema";
        SistematizationCode: Code[10];
        OrgSNew: Record "ORG Shema";
        OrgShema1: Record "ORG Shema";
        OrgShema2: Record "ORG Shema";
        //     Employeebenef: Record "Employee Benefits";
        Misc2: Record "Misc. article information";
        IzUgovora: Record "Employee Contract Ledger";
        ECLOrgR: Record "Employee Contract Ledger";
        SectorTemp: Record "Sector temporary";
        SectorOrginal: Record "Sector";
        Radnaknjizica: Record "Work Booklet";
        Radnaknjizica2: Record "Work Booklet";
        //    TokUgovora: Record "Contract Phase t";
        MiscArticleInformation: Record "Misc. article information";
        //  TokUgovora2: Record "Contract Phase t";
        DepCatOrginal: Record "Department Category";
        DepCatTemp: Record "Department Category temporary";
        eclorg1111: Record "Employee Contract Ledger";
        GroupOrginal: Record "Group";
        EmployeeSistematizacija: Record "ECL systematization";
        GroupTemp: Record "Group temporary";
        TeamOrginal: Record "TeamT";
        ECLCopy2: Record "Employee Contract Ledger";
        TeamTemp: Record "Team temporary";
        DepartmentOrginal: Record "Department";
        DepartmentTemp: Record "Department temporary";
        HeadOfOrginal: Record "Head Of's";
        HeadOfTemp: Record "Head Of's temporary";
        DimensionOrginalPos: Record "Dimension for position";
        UpdateDep: Report "Update dep";
        DimensionTempPos: Record "Dimension temp for position";
        BenefitsTemp: Record "Position Benefits temporery";
        BenefitsOrginal: Record "Position Benefits";
        PositionMenuTemp: Record "Position Menu temporary";
        PositionMenuOrginal: Record "Position Menu";
        ECLOrg11: Record "Employee Contract Ledger";
        PositionMenuOrginal1: Record "Position Menu";
        PosMenOrg: Record "Position Menu";
        ECLSyst: Record "ECL systematization";
        ECLOrg: Record "Employee Contract Ledger";
        PoSMenDUp: Record "Position Menu";
        Brojac: Integer;
        ECLSis: Record "ECL systematization";
        Novi: Integer;
        PositionIDFind: Record "Position";
        DimensionForPos: Record "Dimension for position";
        EmployeeDefaultDimension: Record "Employee Default Dimension";
        ECLBefore: Record "Employee Contract Ledger";
        OrgShemaA: Record "ORG Shema";
        //    ReportNotification: Report "Systematization e-mail";
        SectorOrginal1: Record "Sector";
        DepCatOrginal1: Record "Department Category";
        GroupOrginal1: Record "Group";
        TeamOrginal1: Record "TeamT";
        DepartmentOrginal1: Record "Department";
        HeadOfOrginal1: Record "Head Of's";
        DimensionOrginalPos1: Record "Dimension for position";
        BenefitsOrginal1: Record "Position Benefits";
        ECLOrg1: Record "Employee Contract Ledger";
        PositionBenef: Record "Position Benefits";
        MAIS: Record "Misc. article information";
        MAI1: Record "Misc. article information";
        EmployeeContractLedger2: Record "Employee Contract Ledger";
        DepartmentCodeForpos: Code[30];
        ORGDijelovi: Record "ORG Dijelovi";
        //  ECLSYSEmail: Report "Systematization e-mail";
        ECLForEmail: Record "Employee Contract Ledger";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        WorkBooklet: Record "Work Booklet";
        EmployeeContractChangeOrgRename: Record "Employee Contract Ledger";
        EmployeeContractChangeOrg: Record "Employee Contract Ledger";
        CheckConflict: Record "Employee Contract Ledger";
        BR: Record "Employee Contract Ledger";
        ECLSYSTChangeBR: Record "ECL systematization";
        ECLCheck: Record "Employee Contract Ledger";
        ECLOrg8: Record "Employee Contract Ledger";
        ECLOrg9: Record "Employee Contract Ledger";
        TemOrg: Record "TeamT";
        DepoRG: Record "Department Category";
        SecOrg: Record "Sector";
        GroupOrg: Record "Group";
        PosMenOrgFind: Record "Position Menu";
}

