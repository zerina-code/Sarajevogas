page 50114 "Sector temporary sist"
{
    Caption = 'Sector temporary sist wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Sector temporary";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;

                }
                field(Description; Description)
                {
                    ApplicationArea = all;

                }
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

                field(CEO; CEO)
                {
                    ApplicationArea = all;

                }
                field(Parent; Parent)
                {
                    ApplicationArea = all;
                }
                field("Official Translate of Sector"; "Official Translate of Sector")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                }

                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                }
                field("Number Of Dep Cat levels below"; "Number Of Dep Cat levels below")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;

                }
                field("Number Of Group levels below"; "Number Of Group levels below")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Number Of Team  levels below"; "Number Of Team  levels below")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Number of dimension value"; "Number of dimension value")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = false;
                }
                field("Name of TC"; "Name of TC")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Fields for change"; "Fields for change")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = IsTrue;
                    Visible = false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {

            action(Next)
            {
                Image = NextSet;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Next step';




                trigger OnAction()
                begin


                    /*Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        // StepNext.SETRECORD(Rec);
                        InsertSector.RESET;
                        InsertSector.SETFILTER(Sector, '<>%1', '');
                        InsertSector.SETFILTER("Sector  Description", '%1', '');
                        IF InsertSector.FINDSET THEN
                            REPEAT
                                SectorTempIdentity.RESET;
                                SectorTempIdentity.SETFILTER(Code, '%1', InsertSector.Code);
                                SectorTempIdentity.SETFILTER(Description, '%1', InsertSector.Description);
                                IF SectorTempIdentity.FINDFIRST THEN BEGIN
                                    InsertSector."Sector Identity" := SectorTempIdentity.Identity;
                                    DimensionTemp.SETFILTER(Sector, '%1', SectorTempIdentity.Code);
                                    DimensionTemp.SETFILTER("Sector  Description", '%1', SectorTempIdentity.Description);
                                    IF DimensionTemp.FINDSET THEN
                                        REPEAT
                                            PosMen.SETFILTER(Code, '%1', DimensionTemp."Position Code");
                                            PosMen.SETFILTER(Description, '%1', DimensionTemp."Position Description");
                                            IF PosMen.FINDFIRST THEN BEGIN
                                                PosMen."Sector Identity" := SectorTempIdentity.Identity;
                                                PosMen.MODIFY;
                                            END;
                                        UNTIL DimensionTemp.NEXT = 0;
                                    ECLSystematization.RESET;
                                    ECLSystematization.SETFILTER("Sector Description", '%1', SectorTempIdentity.Description);
                                    IF ECLSystematization.FINDSET THEN
                                        REPEAT
                                            ECLSystematization."Sector Identity" := SectorTempIdentity.Identity;
                                            ECLSystematization.MODIFY;
                                        UNTIL ECLSystematization.NEXT = 0;
                                END;



                            UNTIL InsertSector.NEXT = 0;

                        StepNextTabela.SETFILTER("Identity Sector", '%1', Rec.Identity);
                        StepNext.SETTABLEVIEW(StepNextTabela);
                        StepNext.RUN;
                        SectorCheck.RESET;
                        SectorCheck.SETFILTER(Identity, '%1', Rec.Identity);
                        IF SectorCheck.FINDFIRST THEN BEGIN
                            SectorCheck.CALCFIELDS("Number of dimension value");
                            IF SectorCheck."Number of dimension value" = 0 THEN BEGIN
                                MESSAGE(Text008);
                            END;
                            IF SectorCheck."Residence/Network" = SectorCheck."Residence/Network"::" " THEN BEGIN
                                MESSAGE(Text009);
                                Found2 := TRUE;
                            END;
                        END;
                        SectorCheck.RESET;
                        IF SectorCheck.FINDSET THEN
                            REPEAT
                                DepartmentCheck.RESET;
                                DepartmentCheck.SETFILTER(Sector, '%1', SectorCheck.Code);
                                DepartmentCheck.SETFILTER("Sector  Description", '%1', SectorCheck.Description);
                                IF DepartmentCheck.FINDSET THEN
                                    REPEAT
                                        DepartmentCheck."Sector Identity" := SectorCheck.Identity;
                                        DimensionsForPos.RESET;
                                        DimensionsForPos.SETFILTER("Sector  Description", '%1', SectorCheck.Description);
                                        IF DimensionsForPos.FINDSET THEN
                                            REPEAT
                                                DimensionsForPos."Sector Identity" := SectorCheck.Identity;
                                            UNTIL DimensionsForPos.NEXT = 0;
                                    UNTIL DepartmentCheck.NEXT = 0;
                            UNTIL SectorCheck.NEXT = 0;
                        DepartmentCategoryCheck1.RESET;
                        IF DepartmentCategoryCheck1.FINDSET THEN
                            REPEAT
                                DepartmentCheck.RESET;
                                DepartmentCheck.SETFILTER("Group Code", '%1', DepartmentCategoryCheck1.Code);
                                DepartmentCheck.SETFILTER("Group Description", '%1', DepartmentCategoryCheck1.Description);
                                DepartmentCheck.SETFILTER("Department Type", '%1', 2);
                                IF DepartmentCheck.FINDFIRST THEN BEGIN
                                    DepartmentCategoryCheck1."Identity Sector" := DepartmentCheck."Sector Identity";
                                END
                                ELSE BEGIN
                                    DepartmentCategoryCheck1."Identity Sector" := 0;
                                END;
                                DepartmentCategoryCheck1.MODIFY;
                            UNTIL DepartmentCategoryCheck1.NEXT = 0;

                        DepartmentCategoryCheck2.RESET;
                        IF DepartmentCategoryCheck2.FINDSET THEN
                            REPEAT
                                DepartmentCheck.RESET;
                                DepartmentCheck.SETFILTER("Team Code", '%1', DepartmentCategoryCheck2.Code);
                                DepartmentCheck.SETFILTER("Team Description", '%1', DepartmentCategoryCheck2.Name);
                                DepartmentCheck.SETFILTER("Department Type", '%1', 9);
                                IF DepartmentCheck.FINDFIRST THEN BEGIN
                                    DepartmentCategoryCheck2."Identity Sector" := DepartmentCheck."Sector Identity";
                                END
                                ELSE BEGIN
                                    DepartmentCategoryCheck2."Identity Sector" := 0;
                                END;
                                DepartmentCategoryCheck2.MODIFY;
                            UNTIL DepartmentCategoryCheck2.NEXT = 0;









                        /*SectorTemp.RESET;
                        SectorTemp.SETFILTER(Code,'<>%1','');
                        IF SectorTemp.FINDSET THEN BEGIN
                          DimensionTempValue.RESET;
                          DimensionTempValue.SETFILTER("Department Type",'%1',8);
                          DimensionTempValue.SETFILTER("Sector  Description",'%1',SectorTemp.Description);
                          IF DimensionTempValue.FINDFIRST THEN BEGIN
                          DimensionsForPositionTC.RESET;
                        DimensionsForPositionTC.SETFILTER(Sector,'%1',SectorTemp.Code);
                        DimensionsForPositionTC.SETFILTER("Sector  Description",'%1',SectorTemp.Description);
                        DimensionsForPositionTC.SETFILTER("Department Category",'%1','');
                        DimensionsForPositionTC.SETFILTER("Department Categ.  Description",'%1','');
                        DimensionsForPositionTC.SETFILTER("Group Code",'%1','');
                        DimensionsForPositionTC.SETFILTER("Group Description",'%1','');
                        DimensionsForPositionTC.SETFILTER("Team Code",'%1','');
                        DimensionsForPositionTC.SETFILTER("Team Description",'%1','');
                        IF DimensionsForPositionTC.FINDSET THEN REPEAT
                          IF DimensionsForPositionTC1.GET(DimensionsForPositionTC."Position Code",DimensionsForPositionTC."Dimension Value Code",DimensionsForPositionTC."ORG Shema",DimensionsForPositionTC."Position Description") THEN BEGIN
                            DimensionsForPositionTC1.RENAME(DimensionsForPositionTC."Position Code",DimensionTempValue."Dimension Value Code",DimensionsForPositionTC."ORG Shema",DimensionsForPositionTC."Position Description");
                            DimensionsForPositionTC1."Dimension  Name":=DimensionTempValue."Dimension  Name";
                            DimensionsForPositionTC1.MODIFY;
                            END;
                          UNTIL DimensionsForPositionTC.NEXT=0;
                           END;
                             END;



                        DimensiontempfoRposition.RESET;
                        DimensiontempfoRposition.SETFILTER("Position Code",'<>%1','');
                        DimensiontempfoRposition.SETFILTER(Sector,'<>%1','');
                        DimensiontempfoRposition.SETFILTER("Sector  Description",'<>%1','');
                        DimensiontempfoRposition.SETFILTER("Department Categ.  Description",'%1','');
                        DimensiontempfoRposition.SETFILTER("Department Category",'%1','');
                        DimensiontempfoRposition.SETFILTER("Group Code",'%1','');
                        DimensiontempfoRposition.SETFILTER("Group Description",'%1','');
                        DimensiontempfoRposition.SETFILTER("Team Code",'%1','');
                        DimensiontempfoRposition.SETFILTER("Team Description",'%1','');

                        IF DimensiontempfoRposition.FINDSET THEN REPEAT
                          PositionMenuCorrect.RESET;
                          PositionMenuCorrect.SETFILTER(Code,'%1',DimensiontempfoRposition."Position Code");
                          PositionMenuCorrect.SETFILTER(Description,'%1',DimensiontempfoRposition."Position Description");
                          IF PositionMenuCorrect.FINDFIRST THEN BEGIN
                              IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
                                IF PositionMenuCorrect."Department Code"<>DimensiontempfoRposition.Sector THEN
                                  PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,DimensiontempfoRposition.Sector,PositionMenuCorrect."Org. Structure");
                                END;
                                  END;
                                   PositionMenuCorrect.CALCFIELDS("Number of dimension value");
                                   IF PositionMenuCorrect."Number of dimension value"<>1 THEN BEGIN
                                      IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
                                   PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,'',PositionMenuCorrect."Org. Structure");
                                        END;
                                          END;
                                  UNTIL DimensiontempfoRposition.NEXT=0;*/
                    StepNext.RUN;
                    CurrPage.CLOSE();

                END;


            }
            action("Change Code/Description for levels below")
            {
                Caption = 'Change Code';
                Image = Change;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                begin
                    IF NOT DimesnionForReport.ISEMPTY THEN
                        DimesnionForReport.DELETEALL;
                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER(Code, '%1', Rec.Code);
                    DimensionCopy.SETFILTER(Description, '%1', Rec.Description);
                    DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT
                            DimesnionForReport.INIT;
                            DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                            DimesnionForReport.INSERT;
                        UNTIL DimensionCopy.NEXT = 0;
                    COMMIT;



                    //                    CLEAR(DepartmentChange);
                    SectorTemp.SETFILTER(Code, '%1', Rec.Code);
                    SectorTemp.SETFILTER("Org Shema", '%1', Rec."Org Shema");
                    IF SectorTemp.FINDFIRST THEN BEGIN
                        // CALCFIELDS("Number Of Position below");
                        // CALCFIELDS("Number Of Dep Cat levels below");
                        CALCFIELDS("Number Of Dep Cat levels below");
                        CALCFIELDS("Number Of Group levels below");
                        CALCFIELDS("Number Of Team  levels below");
                        Text1 := TextPart1 + ' ' + Rec.Code + ' Sektora ' + 'Broj odjela je ' + ' ' + FORMAT("Number Of Dep Cat levels below") + ' ' +
                        'Broj grupa je ' + ' ' + ' ' + FORMAT("Number Of Group levels below") + ' ' + 'Broj timova je ' + ' ' + ' ' + FORMAT("Number Of Team  levels below");
                        //MESSAGE(Text1);
                    END;


                    IF ResponseChange <> CONFIRM(Text1, TRUE) THEN BEGIN
                        /*DepartmentTemp.RESET;
                          DepartmentTemp.SETFILTER(Sector,'%1',xRec.Code);
                          IF DepartmentTemp.FINDSET THEN REPEAT
                        IF DepartmentTemp.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",DepartmentTemp."Team Description",DepartmentTemp."Department Categ.  Description",DepartmentTemp."Group Description",DepartmentTemp.Description) THEN BEGIN
                          DepartmentTemp.Sector:=FORMAT('A.7.');
                          DepartmentTemp1.RESET;
                          DepartmentTemp1.SETFILTER(Sector,'%1',Rec.Code);
                          IF DepartmentTemp1.FINDSET THEN REPEAT

                        String:=FORMAT(DepartmentTemp1.Code);
                        LengthString:=STRLEN(String);
                        FOR i:=1 TO LengthString DO BEGIN
                          IF String[i]='.'THEN BEGIN
                          Brojac:=Brojac+1;
                            IF Brojac=2 THEN BEGIN
                              LengthChange:=i;
                          END;
                          END;
                          END;
                          //OnePart:=COPYSTR(FORMAT(DepartmentTemp1),1,LengthChange);
                          TwoPart:=COPYSTR(FORMAT(DepartmentTemp1),LengthChange,LengthString);
                          RealCode:=STRSUBSTNO('A.7.',TwoPart);
                          DepartmentTemp1.RENAME(RealCode,DepartmentTemp."ORG Shema",DepartmentTemp."Team Description",DepartmentTemp."Department Categ.  Description",DepartmentTemp."Group Description",DepartmentTemp.Description);

                            UNTIL DepartmentTemp1.NEXT=0;

                        END;

                            UNTIL DepartmentTemp.NEXT=0;
                        END;
                        */
                        /*
                        */

                        //DepartmentChange.SetP(xRec.Code,Rec.Code,Rec."Org Shema",Rec.Description);
                        //         DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 1, Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        //       DepartmentChange.RUN;
                    END
                    ELSE BEGIN
                        //     DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 2, Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        //   DepartmentChange.RUN;

                    END;
                    /*SectorInsertModify.RESET;
                    SectorInsertModify.SETFILTER(Code,'<>%1','');
                    IF SectorInsertModify.FINDSET THEN REPEAT
                    SectorInsertModify.LastModified:='';
                    SectorInsertModify.MODIFY;
                    UNTIL SectorInsertModify.NEXT=0;
                    SectorInsertModify.RESET;
                    SectorInsertModify.SETFILTER(Code,'<>%1','');
                    SectorInsertModify.SETFILTER(Identity,'%1',Rec.Identity);
                    IF SectorInsertModify.FINDSET THEN REPEAT
                    SectorInsertModify.LastModified:=FORMAT(SectorInsertModify.Code)+' '+SectorInsertModify.Description;
                    SectorInsertModify.MODIFY;
                    UNTIL SectorInsertModify.NEXT=0;
                    */

                end;
            }
            action("Insert Sector")
            {
                Caption = 'Insert Sector';
                Image = Change;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                begin
                    IF Responsenew <> CONFIRM(Text6, TRUE) THEN BEGIN
                        //CLEAR(NewReport);
                        IF NOT DimesnionForReport.ISEMPTY THEN
                            DimesnionForReport.DELETEALL;
                        COMMIT;
                        OsPreparation.RESET;
                        OsPreparation.SETFILTER(Status, '%1', 2);
                        IF OsPreparation.FINDLAST THEN BEGIN
                            FilterC := OsPreparation.Code;
                        END;
                        //       NewReport.SetParam(FilterC);
                        //     NewReport.RUN;
                        EXIT;
                    END;
                end;
            }
            action("Copy Sector")
            {
                Caption = 'Copy Sector';
                //Image = copy;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;
                Visible = false;

                trigger OnAction()
                begin
                    IF Responsenew <> CONFIRM(Text7, TRUE) THEN BEGIN
                        IF NOT DimesnionForReport.ISEMPTY THEN
                            DimesnionForReport.DELETEALL;
                        DimensionCopy.RESET;
                        DimensionCopy.SETFILTER(Code, '%1', Rec.Code);
                        DimensionCopy.SETFILTER(Description, '%1', Rec.Description);
                        DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                        IF DimensionCopy.FINDSET THEN
                            REPEAT
                                DimesnionForReport.INIT;
                                DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                                DimesnionForReport.INSERT;
                            UNTIL DimensionCopy.NEXT = 0;
                        COMMIT;

                        // ForCopyReport.SetParam(Rec."Org Shema", Rec.Code, Rec.Description, Rec."Residence/Network");
                        // ForCopyReport.RUN;
                        EXIT;
                    END;
                end;
            }
            /*     action("Troškovni centri po organizaciji sektor")
                 {
                     RunObject = Page "Dimensions temporary";
                     ApplicationArea = all;
                     Visible = false;
                 }*/
            group("Dimension temporary")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = false;

                /*    action("Dimensions temporary")
                    {
                        Caption = 'Dimensions temporary';
                        RunObject = Page "Dimensions temporary";
                        RunPageLink = Code = FIELD(Code),
                                      "Sector  Description" = FIELD(Description),
                                      "Department Type" = CONST(Sector);
                        RunPageOnRec = false;
                        Visible = false;
                        ApplicationArea = all;
                    }*/
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin


        IF Potvrda <> CONFIRM(Text007, TRUE) THEN BEGIN
            DepartmentTempDelete.SETFILTER(Sector, '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Sector  Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER(Code, '<>%1', Rec.Code);
            IF DepartmentTempDelete.FINDSET THEN
                REPEAT
                    IF DepartmentTempDelete."Department Type".AsInteger() = 5 THEN BEGIN
                        DepCatDelete.SETFILTER(Description, '%1', DepartmentTempDelete."Department Categ.  Description");
                        IF DepCatDelete.FINDFIRST THEN BEGIN
                            DepartmentTempDeletefOR.RESET;
                            DepartmentTempDeletefOR.SETFILTER("Department Categ.  Description", '%1', DepartmentTempDelete."Department Categ.  Description");
                            DepartmentTempDeletefOR.SETFILTER("Department Type", '%1', 4);
                            IF DepartmentTempDeletefOR.FINDFIRST THEN BEGIN
                                DepartmentTempDeletefOR.DELETE;
                            END;
                            DimensionsTempFor.RESET;
                            DimensionsTempFor.SETFILTER("Department Categ.  Description", '%1', DepartmentTempDelete."Department Categ.  Description");
                            DimensionsTempFor.SETFILTER("Department Type", '%1', 4);
                            DimensionsTempFor.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                                DimensionsTempFor.DELETE;
                            END;
                            DepCatDelete.DELETE;
                        END;
                    END;
                    IF DepartmentTempDelete."Department Type".AsInteger() = 3 THEN BEGIN
                        DepCatDelete1.SETFILTER(Description, '%1', DepartmentTempDelete."Group Description");
                        IF DepCatDelete1.FINDFIRST THEN BEGIN
                            DepartmentTempDeletefOR.RESET;
                            DepartmentTempDeletefOR.SETFILTER("Group Description", '%1', DepartmentTempDelete."Group Description");
                            DepartmentTempDeletefOR.SETFILTER("Department Type", '%1', 2);
                            IF DepartmentTempDeletefOR.FINDFIRST THEN BEGIN
                                DepartmentTempDeletefOR.DELETE;
                            END;
                            DimensionsTempFor.RESET;
                            DimensionsTempFor.SETFILTER("Group Description", '%1', DepartmentTempDelete."Group Description");
                            DimensionsTempFor.SETFILTER("Department Type", '%1', 2);
                            DimensionsTempFor.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                                DimensionsTempFor.DELETE;
                            END;
                            DepCatDelete1.DELETE;
                        END;
                    END;



                UNTIL DepartmentTempDelete.NEXT = 0;
            DimensionsForPos.SETFILTER(Sector, '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Sector  Description", '%1', Rec.Description);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    PositionMenu.RESET;
                    PositionMenu.SETFILTER(Code, '%1', DimensionsForPos."Position Code");
                    PositionMenu.SETFILTER(Description, '%1', DimensionsForPos."Position Description");
                    IF PositionMenu.FINDSET THEN
                        REPEAT
                            PositionMenu.DELETE;
                        UNTIL PositionMenu.NEXT = 0;
                    HeadDelete.RESET;
                    HeadDelete.SETFILTER("Position Code", '%1', DimensionsForPos."Position Code");
                    HeadDelete.SETFILTER("Position Description", '%1', DimensionsForPos."Position Description");
                    IF HeadDelete.FINDSET THEN
                        REPEAT
                            HeadDelete.DELETE
UNTIL HeadDelete.NEXT = 0;
                    ContractDelete.RESET;
                    ContractDelete.SETFILTER("Position Code", '%1', DimensionsForPos."Position Code");
                    ContractDelete.SETFILTER("Position Description", '%1', DimensionsForPos."Position Description");
                    IF ContractDelete.FINDSET THEN
                        REPEAT
                            ContractDelete."Position Code" := '';
                            ContractDelete."Position Description" := '';
                        UNTIL ContractDelete.NEXT = 0;

                    DimensionsForPos.DELETE;
                UNTIL DimensionsForPos.NEXT = 0;

            SecYes.RESET;
            SecYes.SETFILTER(Code, '%1', Rec.Code);
            SecYes.SETFILTER(Description, '%1', Rec.Description);
            IF SecYes.FINDFIRST THEN BEGIN
                SecYes.DELETE;
            END;
            DepOrginalDelete.RESET;
            DepOrginalDelete.SETFILTER(Code, '%1', Rec.Code);
            DepOrginalDelete.SETFILTER(Description, '%1', Rec.Description);
            IF DepOrginalDelete.FINDFIRST THEN BEGIN
                DepOrginalDelete.DELETE;
            END;
            DimensipnTemp.RESET;
            DimensipnTemp.SETFILTER(Sector, '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Sector  Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            IF DimensipnTemp.FINDSET THEN
                REPEAT
                    DimensipnTemp.DELETE;
                UNTIL DimensipnTemp.NEXT = 0;
            Head.RESET;
            Head.SETFILTER("Department Code", '%1', Rec.Code);
            IF Head.FINDFIRST THEN BEGIN
                Head.DELETE;
            END;
            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Sector Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    ECLSystematization.VALIDATE("Org Belongs", '');
                    ECLSystematization.VALIDATE("Position Description", '');
                UNTIL ECLSystematization.NEXT = 0;

        END


        ELSE BEGIN
            DepartmentTempDelete.SETFILTER(Sector, '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Sector  Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER("Department Type", '%1', 8);
            IF DepartmentTempDelete.FINDFIRST THEN BEGIN
                DepartmentTempDelete.DELETE;
            END;

            DimensionsTempFor.SETFILTER(Sector, '%1', Rec.Code);
            DimensionsTempFor.SETFILTER("Sector  Description", '%1', Rec.Description);
            DimensionsTempFor.SETFILTER("Department Type", '%1', 8);
            DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                DimensionsTempFor.DELETE;
            END;


            DepartmentTempDelete2.RESET;
            DepartmentTempDelete2.SETFILTER(Sector, '%1', Rec.Code);
            DepartmentTempDelete2.SETFILTER("Sector  Description", '%1', Rec.Description);
            IF DepartmentTempDelete2.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        DepartmentTempDelete2."Sector  Description" := Sectortemptable.Description;
                        DepartmentTempDelete2."Sector Identity" := Sectortemptable.Identity;
                        DimensionsTempFor.RESET;
                        //  DimensionsTempFor.SETFILTER(Sector,'%1',Rec.Code);
                        DimensionsTempFor.SETFILTER("Sector  Description", '%1', Rec.Description);
                        DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF DimensionsTempFor.FINDSET THEN
                            REPEAT
                                DimensionsTempFor."Sector  Description" := Sectortemptable.Description;
                                DimensionsTempFor.Sector := Sectortemptable.Code;

                                DimensionsTempFor.Belongs := DimensionsTempFor.Code + '-' + Sectortemptable.Description;
                            UNTIL DimensionsTempFor.NEXT = 0;

                        DepartmentTempDelete2.MODIFY;
                    END;
                UNTIL DepartmentTempDelete2.NEXT = 0;


            DimensionsForPos.RESET;
            DimensionsForPos.SETFILTER(Sector, '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Sector  Description", '%1', Rec.Description);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    DimensionsForPos2.SETFILTER("Position Code", '%1', DimensionsForPos."Position Code");
                    DimensionsForPos2.SETFILTER("Position Description", '%1', DimensionsForPos."Position Description");
                    IF DimensionsForPos2.FINDSET THEN
                        REPEAT
                            Sectortemptable.RESET;
                            Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                            Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                            IF Sectortemptable.FINDFIRST THEN BEGIN
                                Change := Sectortemptable.Description;
                            END;
                            DepartmentTempDelete1.RESET;
                            DepartmentTempDelete1.SETFILTER("Sector  Description", '%1', Change);
                            DepartmentTempDelete1.SETFILTER("Department Type", '%1', 8);
                            DepartmentTempDelete1.SETFILTER("ORG Shema", '%1', "Org Shema");
                            IF DepartmentTempDelete1.FINDFIRST THEN BEGIN
                                Value := DepartmentTempDelete1."Dimension Value Code";
                            END;

                            //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                            IF DimensionsoRG.GET(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", Rec."Org Shema", DimensionsForPos2."Position Description", DimensionsForPos2."Org Belongs") THEN BEGIN
                                IF (DimensionsoRG."Department Category" = '') AND (DimensionsoRG."Department Categ.  Description" = '') THEN BEGIN
                                    DimensionsoRG.RENAME(DimensionsoRG."Position Code", Value, Rec."Org Shema", DimensionsoRG."Position Description", Change);
                                    DimensionsoRG."Sector  Description" := Change;
                                    DimensionsoRG.MODIFY;

                                    DepartmentTempDelete1.RESET;
                                    DepartmentTempDelete1.SETFILTER("Sector  Description", '%1', Change);
                                    DepartmentTempDelete1.SETFILTER("Department Type", '%1', 8);
                                    DepartmentTempDelete1.SETFILTER("ORG Shema", '%1', "Org Shema");
                                    IF DepartmentTempDelete1.FINDFIRST THEN BEGIN
                                        DimensionsoRG."Dimension  Name" := DepartmentTempDelete1."Dimension  Name";
                                        DimensionsoRG."Sector  Description" := Change;
                                        DimensionsoRG.MODIFY;
                                    END;
                                END
                                ELSE BEGIN
                                    DimensionsoRG.RENAME(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", Rec."Org Shema", DimensionsForPos2."Position Description", DimensionsForPos2."Org Belongs");
                                    DimensionsoRG."Sector  Description" := Change;
                                    DimensionsoRG.MODIFY;

                                END;


                            END;


                        //;Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs


                        UNTIL DimensionsForPos2.NEXT = 0;
                UNTIL DimensionsForPos.NEXT = 0;



            DimensipnTemp.RESET;

            DimensipnTemp.SETFILTER("Sector  Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("Department Type", '%1', 8);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            IF DimensipnTemp.FINDSET THEN
                REPEAT
                    DimensipnTemp.DELETE;
                UNTIL DimensipnTemp.NEXT = 0;


            DepCatZem.RESET;
            DepCatZem.SETFILTER("Identity Sector", '%1', Rec.Identity);
            IF DepCatZem.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        DepCatZem."Identity Sector" := Sectortemptable.Identity;
                        DepCatZem.MODIFY;
                    END;
                UNTIL DepCatZem.NEXT = 0;

            DimensionTempPos.RESET;
            DimensionTempPos.SETFILTER("Sector  Description", '%1', Rec.Description);
            IF DimensionTempPos.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DimensionTempPos1.GET(DimensionTempPos."Position Code", DimensionTempPos."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", DimensionTempPos."Org Belongs") THEN BEGIN
                            DimensionTempPos2.RESET;
                            DimensionTempPos2.SETFILTER("Sector  Description", '%1', Sectortemptable.Description);
                            DimensionTempPos2.SETFILTER("Department Categ.  Description", '%1', '');
                            IF DimensionTempPos2.FINDFIRST THEN BEGIN
                                DimensionTempPos1.RENAME(DimensionTempPos."Position Code", DimensionTempPos2."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", Sectortemptable.Description);
                                DimensionTempPos1."Dimension  Name" := DimensionTempPos2."Dimension  Name";
                                DimensionTempPos1."Sector  Description" := Sectortemptable.Description;
                                DimensionTempPos1.MODIFY;
                            END;
                        END;
                    END;
                //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                UNTIL DimensionTempPos.NEXT = 0;

            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Sector Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN
                        NewSECTOR := Sectortemptable.Description;

                    IF ECLSystematization."Team Description" <> '' THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Team Description", '%1', ECLSystematization."Team Description");
                        DepartmentValue.SETFILTER("Sector  Description", '%1', NewSECTOR);
                        DepartmentValue.SETFILTER("Department Type", '%1', 9);
                        IF DepartmentValue.FINDFIRST THEN
                            ECLSystematization.VALIDATE("Org Belongs", ECLSystematization."Team Description");
                    END;
                    IF (ECLSystematization."Group Description" <> '') AND (ECLSystematization."Team Description" = '') THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Group Description", '%1', ECLSystematization."Group Description");
                        DepartmentValue.SETFILTER("Sector  Description", '%1', NewSECTOR);
                        DepartmentValue.SETFILTER("Department Type", '%1', 2);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", ECLSystematization."Group Description");
                        END
                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                    END;
                    IF (ECLSystematization."Group Description" = '') AND (ECLSystematization."Department Cat. Description" <> '') THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Department Categ.  Description", '%1', ECLSystematization."Department Cat. Description");
                        DepartmentValue.SETFILTER("Sector  Description", '%1', NewSECTOR);
                        DepartmentValue.SETFILTER("Department Type", '%1', 4);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", ECLSystematization."Department Cat. Description")
                        END

                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                    END;

                    IF (ECLSystematization."Sector Description" <> '') AND (ECLSystematization."Department Cat. Description" = '') THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Sector  Description", '%1', NewSECTOR);
                        DepartmentValue.SETFILTER("Department Type", '%1', 8);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", NewSECTOR);
                        END
                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                    END;
                    ECLSystematization.MODIFY;
                UNTIL ECLSystematization.NEXT = 0;






            Head.RESET;
            Head.SETFILTER("Sector  Description", '%1', Rec.Description);
            //Head.SETFILTER(Sector,'%1',Rec.Code);
            Head.SETFILTER("Department Categ.  Description", '%1', '');
            Head.SETFILTER("Department Category", '%1', '');
            IF Head.FINDFIRST THEN
                Head.DELETE;
            Head.RESET;
            Head.SETFILTER("Sector  Description", '%1', Rec.Description);
            Head.SETFILTER(Sector, '%1', Rec.Code);
            IF Head.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        Head."Sector  Description" := Sectortemptable.Description;
                        Head.MODIFY;
                    END;
                UNTIL Head.NEXT = 0;
        END;
        DimensiontempfoRposition.RESET;
        DimensiontempfoRposition.SETFILTER("Org Belongs", '%1', '');
        IF DimensiontempfoRposition.FINDSET THEN
            REPEAT


                PositionMenu.RESET;
                PositionMenu.SETFILTER(Code, '%1', DimensiontempfoRposition."Position Code");
                PositionMenu.SETFILTER(Description, '%1', DimensiontempfoRposition."Position Description");
                IF PositionMenu.FINDSET THEN
                    REPEAT
                        //Code,Description,Department Code,Org. Structure
                        IF PositionMenu5.GET(DimensiontempfoRposition."Position Code", DimensiontempfoRposition."Position Description", PositionMenu."Department Code", Rec."Org Shema") THEN
                            PositionMenu5.RENAME(DimensiontempfoRposition."Position Code", DimensiontempfoRposition."Position Description", '', Rec."Org Shema")
UNTIL PositionMenu.NEXT = 0;

            UNTIL DimensiontempfoRposition.NEXT = 0;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IsEditable := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditable := TRUE;
        /*OsPreparation.RESET;
        OsPreparation.SETFILTER(Status,'%1',2);
        IF OsPreparation.FINDLAST THEN BEGIN
          "Org Shema":=OsPreparation.Code;
          END
          ELSE BEGIN
            "Org Shema":='';
            END;
            */

    end;

    trigger OnOpenPage()
    begin
        /*HRsetup.FINDFIRST;
        CALCFIELDS("Position Code", "Position ID");
        SETFILTER(Status,'%1',Status::Active);
        SETRANGE("Employment Date", CALCDATE('-'+ FORMAT(HRsetup."New employee period"),TODAY),TODAY);
        SETFILTER(Testing,'%1',TRUE);*/
        //CurrPage.EDITABLE(FALSE);
        IsEditable := FALSE;
        /*SectorInsertModify.RESET;
            SectorInsertModify.SETFILTER(LastModified,'<>%1','');
            IF SectorInsertModify.FINDFIRST THEN BEGIN
        
            MESSAGE('Poslednji izmjenjeni sektor je' +' '+' ' +SectorInsertModify.LastModified);
            END;*/
        /* SectorTempBelong.RESET;
     SectorTempBelong.SETFILTER(Code,'<>%1','');
     IF SectorTempBelong.FINDSET THEN REPEAT
        SectorTempBelong.CALCFIELDS("Number of dimension value");
        IF SectorTempBelong."Number of dimension value"=1  THEN BEGIN
         SectorTempBelong1:=SectorTempBelong;
         DimensionsTempTabela.RESET;
         DimensionsTempTabela.SETFILTER("Department Type",'%1',8);
         DimensionsTempTabela.SETFILTER("Sector  Description",'%1',SectorTempBelong.Description);
         IF DimensionsTempTabela.FINDFIRST THEN BEGIN
         SectorTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
           SectorTempBelong1.MODIFY;
           END;
             END;
       UNTIL SectorTempBelong.NEXT=0;*/

    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        Txt003: Label 'Do you want to go in next step';
        ConfirmClose2: Boolean;
        Txt006: Label 'Do you want to back in previous step';
        StepNext: Page "Dep.Category temporary sist";
        Text1: Text;
        NumberPositions: Integer;
        PositionTemp: Record "Position temporery";
        ResponseChange: Boolean;
        SectorTemp: Record "Sector temporary";
        DepartmentTemp: Record "Department temporary";
        DepartmentTemp1: Record "Department temporary";
        CodeChange: Code[10];
        String: Text;
        Brojac: Integer;
        LengthChange: Integer;
        i: Integer;
        LengthString: Integer;
        RealCode: Code[10];
        OnePart: Text;
        TwoPart: Text;
        //  DepartmentChange: Report "Department T change sector";
        TextPart1: Label 'Do you want to change all level below';
        Text007: Label 'Do you want to delete  all level below';
        Potvrda: Boolean;
        DepartmentTempDelete: Record "Department temporary";
        Position: Record "Position temporery";
        DepartmentTempDelete1: Record "Dimension temporary";
        DimensionNewTemp: Record "Dimension temporary";
        Sectortemptable: Record "Sector temporary";
        DepartmentTempDelete2: Record "Department temporary";
        PositionTempor: Record "Position temporery";
        StepNextTabela: Record "Department Category temporary";
        DepartmentTempTry: Record "Department temporary";
        Pocetak: Code[10];
        DepCatZem: Record "Department Category temporary";
        OrgJed: Record "Department temporary";
        PositionTempor1: Record "Position temporery";
        IsEditable: Boolean;
        SecYes: Record "Sector temporary";
        OsPreparation: Record "ORG Shema";
        SectorInsertModify: Record "Sector temporary";
        TextM: Text;
        InsertSector: Record "Department temporary";
        SectorTempIdentity: Record "Sector temporary";
        DepCatDelete: Record "Department Category temporary";
        DepCatDelete1: Record "Group temporary";
        DepCatDelete2: Record "Team temporary";
        DepCatDeleteD: Record "Department Category temporary";
        DepCatDeleteD1: Record "Group temporary";
        DepCatDeleteD2: Record "Team temporary";
        DepartmentTempDeletefOR: Record "Department temporary";
        DepOrginalDelete: Record "Department temporary";
        DimensionsTempFor: Record "Dimension temporary";
        SectorInsertModifyDep: Record "Department Category temporary";
        SectorCheck: Record "Sector temporary";
        Text008: Label 'You are forgot to insert dimension value';
        Text009: Label 'You are forgot to insert is this sector Residence/Network';
        Found1: Boolean;
        Found2: Boolean;
        DepartmentCheck: Record "Department temporary";
        DepartmentCategoryCheck: Record "Department Category temporary";
        GroupTempo: Record "Group temporary";
        Teamtem: Record "Team temporary";
        DepartmentCategoryCheck1: Record "Group temporary";
        DepartmentCategoryCheck2: Record "Team temporary";
        PositionMenu: Record "Position Menu temporary";
        DimensionsForPos: Record "Dimension temp for position";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong: Record "Sector temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        TeamTempBelong: Record "Team temporary";
        TeamTempBelong1: Record "Team temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        DimensipnTemp: Record "Dimension temporary";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        DimensionTempValue: Record "Dimension for report";
        DimensionsForPos1: Record "Dimension temp for position";
        DimensionsForPos2: Record "Dimension temp for position";
        BrojTroskovni: Integer;
        //        DimensionPage: Page "Dimensions temporary";
        DimesnionForReport: Record "Dimension for report";
        DimensionCopy: Record "Dimension temporary";
        Responsenew: Boolean;
        Text6: Label 'Do you want to insert a new sector';
        //   NewReport: Report "Department T New";
        FilterC: Code[10];
        DimensionsoRG: Record "Dimension temp for position";
        Change: Text;
        Value: Code[50];
        Head: Record "Head Of's temporary";
        HeadDelete: Record "Head Of's temporary";
        ContractDelete: Record "ECL systematization";
        ECLSystematization: Record "ECL systematization";
        DimensionTempFor: Record "Dimension temp for position";
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        DimensiontempfoRposition: Record "Dimension temp for position";
        DimensionsoRG2: Record "Dimension temp for position";
        HeadOf: Record "Head Of's temporary";
        DimensionPosHead: Record "Dimension temp for position";
        PositionMenuHead: Record "Position Menu temporary";
        HeadOfNew: Record "Head Of's temporary";
        PosMen: Record "Position Menu temporary";
        DimensionTemp: Record "Dimension temp for position";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionTempPos1: Record "Dimension temp for position";
        DimensionTempPos2: Record "Dimension temp for position";
        Text7: Label 'Do you want to copy a sector';
        //ĐK ForCopyReport: Report "CopySector";
        NewSECTOR: Text;
        DepartmentValue: Record "Department temporary";
        PositionMenu5: Record "Position Menu temporary";
        DepartmentTempDelete10: Record "Department temporary";
}

