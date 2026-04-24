page 50129 "Dep.Category temporary sist"
{
    Caption = 'Department Category wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Department Category temporary";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(Code; Code)
                {

                    ApplicationArea = all;


                }
                field(Description; Description)
                {

                    ApplicationArea = all;


                }
                field("Org Shema"; "Org Shema") { ApplicationArea = all; }
                field("Sector Belongs"; "Sector Belongs")
                {
                    ApplicationArea = all;

                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                }

                field("Official Translate of DepCat"; "Official Translate of DepCat")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    Editable = false;
                    ApplicationArea = all;
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
                }
                field("Name of TC"; "Name of TC")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Fields for change"; "Fields for change")
                {
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = IsTrue;
                    ApplicationArea = all;
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
                PromotedCategory = New;
                PromotedIsBig = true;
                Caption = 'Next step';


                trigger OnAction()
                begin
                    /*Response :=CONFIRM(Txt003);
                    IF Response THEN
                      BEGIN
                       // StepNext.SETRECORD(Rec);
                    
                    
                      StepNextTabela.SETFILTER("Dep Cat Identity",'%1',Rec.Identity);
                        StepNext.SETTABLEVIEW(StepNextTabela);
                        StepNext.RUN;
                        SectorInsertModify.RESET;
                        SectorInsertModify.SETFILTER(LastModified,'<>%1','');
                        IF SectorInsertModify.FINDFIRST THEN BEGIN
                    
                        MESSAGE('Poslednji izmjenjeni sektor je' +' '+' ' +LastModified);
                        END;
                    
                    
                          CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;*/
                    /* Response := CONFIRM(Txt003);
                     IF Response THEN BEGIN
                         // StepNext.SETRECORD(Rec);
                         InsertSector.RESET;
                         InsertSector.SETFILTER("Department Category", '<>%1', '');
                         InsertSector.SETFILTER("Department Categ.  Description", '<>%1', '');
                         IF InsertSector.FINDSET THEN
                             REPEAT
                                 SectorTempIdentity.RESET;
                                 SectorTempIdentity.SETFILTER(Code, '%1', InsertSector."Department Category");
                                 SectorTempIdentity.SETFILTER(Description, '%1', InsertSector."Department Categ.  Description");
                                 IF SectorTempIdentity.FINDFIRST THEN BEGIN
                                     InsertSector."Department Idenity" := SectorTempIdentity.Identity;
                                     InsertSector.MODIFY;
                                 END;
                             UNTIL InsertSector.NEXT = 0;
                         SectorTemp1.RESET;
                         SectorTemp1.SETFILTER(Code, '<>%1', '');
                         IF SectorTemp1.FINDSET THEN
                             REPEAT
                                 ECLSystematization.RESET;
                                 ECLSystematization.SETFILTER("Sector Description", '%1', SectorTemp1.Description);
                                 ECLSystematization.SETFILTER("Department Cat. Description", '%1', '');
                                 ECLSystematization.SETFILTER("Group Description", '%1', '');
                                 IF ECLSystematization.FINDFIRST THEN
                                     REPEAT
                                         ECLSystematization."Sector Identity" := SectorTemp1.Identity;
                                         ECLSystematization.MODIFY;
                                     UNTIL ECLSystematization.NEXT = 0;
                             UNTIL SectorTemp1.NEXT = 0;

                         InsertSector.RESET;
                         InsertSector.SETFILTER(Sector, '<>%1', '');
                         InsertSector.SETFILTER("Sector  Description", '<>%1', '');
                         IF InsertSector.FINDSET THEN
                             REPEAT
                                 SectorIdentityInsert.RESET;
                                 SectorIdentityInsert.SETFILTER(Description, '%1', InsertSector."Sector  Description");
                                 IF SectorIdentityInsert.FINDFIRST THEN BEGIN
                                     InsertSector."Sector Identity" := SectorIdentityInsert.Identity;
                                     InsertSector.MODIFY;
                                 END;

                             UNTIL InsertSector.NEXT = 0;
                         IF Rec."Identity Sector" = 0 THEN BEGIN
                             ValueSector1 := Rec.GETFILTER("Identity Sector");
                             IF EVALUATE(ValueSector, ValueSector1) THEN
                                 StepNextTabela.SETFILTER("Identity Sector", '%1', ValueSector);
                         END ELSE BEGIN

                             StepNextTabela.SETFILTER("Identity Sector", '%1', Rec."Identity Sector");
                         END;
                         //ĐK  StepNext.SETTABLEVIEW(StepNextTabela);*/
                    StepNext.RUN;


                    /*NextMessage.RESET;
                     NextMessage.SETFILTER(LastModified,'<>%1','');
                      IF NextMessage.FINDFIRST THEN BEGIN

                      MESSAGE('Poslednja izmjenjena grupa je' +' '+' ' +NextMessage.LastModified);
                      END;*/





                    /*DimensionCorect.RESET;
                    DimensionCorect.SETFILTER("Department Type",'%1',4);
                    IF DimensionCorect.FINDSET THEN REPEAT
                    DepCatCode.RESET;
                    DepCatCode.SETFILTER(Description,'%1',DimensionCorect."Department Categ.  Description");
                    IF DepCatCode.FINDFIRST THEN BEGIN
                    DimensionCorect."Department Category":=DepCatCode.Code;
                    END
                     ELSE BEGIN
                     DimensionCorect."Department Category":='';
                     END;
                     SectorCode.RESET;
                     SectorCode.SETFILTER(Description,'%1',DimensionCorect."Sector  Description");
                     IF SectorCode.FINDFIRST THEN BEGIN
                     DimensionCorect.Sector:=SectorCode.Code;
                     END
                     ELSE BEGIN
                     DimensionCorect.Sector:='';
                     END;
                     DimensionCorect.MODIFY;
                    UNTIL DimensionCorect.NEXT=0;



                    DimensiontempfoRposition.RESET;
                    DimensiontempfoRposition.SETFILTER("Position Code",'<>%1','');
                    DimensiontempfoRposition.SETFILTER(Sector,'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Sector  Description",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Department Categ.  Description",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Department Category",'<>%1','');
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
                            IF PositionMenuCorrect."Department Code"<>DimensiontempfoRposition."Department Category" THEN
                              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,DimensiontempfoRposition."Department Category",PositionMenuCorrect."Org. Structure");
                            END;
                              END;
                               PositionMenuCorrect.CALCFIELDS("Number of dimension value");
                               IF PositionMenuCorrect."Number of dimension value"<>1 THEN BEGIN
                                  IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
                               PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,'',PositionMenuCorrect."Org. Structure");
                                    END;
                                      END;
                              UNTIL DimensiontempfoRposition.NEXT=0;
                              */

                    CurrPage.CLOSE();

                END;


            }
            action(Previous)
            {
                Image = PreviousSet;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

                Caption = 'Previous step';

                trigger OnAction()
                begin

                    Response := CONFIRM(Txt006);
                    IF Response THEN BEGIN
                        IF Rec."Identity Sector" = 0 THEN BEGIN
                            ValueSector1 := Rec.GETFILTER("Identity Sector");
                            IF EVALUATE(ValueSector, ValueSector1) THEN
                                PrevoiusTabela.SETFILTER(Identity, '%1', ValueSector);
                        END
                        ELSE BEGIN
                            PrevoiusTabela.SETFILTER(Identity, '%1', Rec."Identity Sector");
                        END;
                        //   PreviousStep.SETTABLEVIEW(PrevoiusTabela);
                        PreviousStep.RUN;
                        /* PrevoiusMessage.RESET;
                          PrevoiusMessage.SETFILTER(LastModified,'<>%1','');

                           IF PrevoiusMessage.FINDFIRST THEN BEGIN

                           MESSAGE('Poslednji izmjenjeni sektor je' +' '+' ' +PrevoiusMessage.LastModified);
                           END;*/
                        CurrPage.CLOSE();

                    END;

                end;
            }
            /*     action("Change Code for levels below")
                 {
                     Caption = 'Change Code';
                     Image = Change;
                     ApplicationArea = all;
                     Promoted = true;
                     PromotedCategory = New;
                     PromotedIsBig = true;
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



                         DepCatTemp.SETFILTER(Code, '%1', Rec.Code);
                         DepCatTemp.SETFILTER("Org Shema", '%1', Rec."Org Shema");
                         DepCatTemp.SETFILTER(Description, '%1', Rec.Description);
                         IF DepCatTemp.FINDFIRST THEN BEGIN


                             CALCFIELDS("Number Of Group levels below");
                             CALCFIELDS("Number Of Team  levels below");
                             Text1 := TextPart1 + ' ' + Rec.Code + ' Odjela ' + ' ' +
                             'Broj grupa je ' + ' ' + ' ' + FORMAT("Number Of Group levels below") + ' ' + 'Broj timova je ' + ' ' + ' ' + FORMAT("Number Of Team  levels below");
                         END;
                         IF ResponseChange <> CONFIRM(Text1, TRUE) THEN BEGIN

                             //DepartmentChange.SetP(xRec.Code,Rec.Code,Rec."Org Shema",Rec.Description);
                             //        DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 1, Rec."Org Shema");
                             //DepartmentChange.SetParam(Rec.Code);
                             //      DepartmentChange.RUN;
                         END
                         ELSE BEGIN
                             //    DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 2, Rec."Org Shema");
                             //DepartmentChange.SetParam(Rec.Code);
                             //  DepartmentChange.RUN;
                         END;
                     end;
                 }*/
            /*     action("Insert DepCat")
                 {
                     Caption = 'Insert DepCat';
                     Image = Change;
                     ApplicationArea = all;
                     Promoted = true;
                     PromotedIsBig = true;
                     Visible = false;

                     trigger OnAction()
                     begin
                         IF Responsenew <> CONFIRM(Text6, TRUE) THEN BEGIN
                             //  CLEAR(NewReport);
                             IF NOT DimesnionForReport.ISEMPTY THEN
                                 DimesnionForReport.DELETEALL;
                             COMMIT;
                             OsPreparation.RESET;
                             OsPreparation.SETFILTER(Status, '%1', 2);
                             IF OsPreparation.FINDLAST THEN BEGIN
                                 FilterC := OsPreparation.Code;
                             END;
                             //      NewReport.SetParam('', '', 0, 1, FilterC);
                             //    NewReport.RUN;


                             EXIT;
                         END;
                     end;
                 }*/
            /*    action("Copy DepCat")
                {
                    Caption = 'Copy Department Category';
                    Image = Copy;
                    Promoted = true;
                    ApplicationArea = all;
                    PromotedIsBig = true;
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

                            //   ForCopyReport.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", Rec."Org Shema");
                            // ForCopyReport.RUN;
                            EXIT;
                        END;
                    end;
                }*/
            group("Dimension temporary1")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = false;

                /*     action("Dimension temporary")
                     {
                         Caption = 'Dimension temporary';
                         ApplicationArea = all;
                         RunObject = Page "Dimensions temporary";
                         RunPageLink = "Department Categ.  Description" = FIELD(Description),
                                       "Department Type" = CONST("Department Category");
                         Visible = false;
                     }*/
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin


        IF Potvrda <> CONFIRM(Text007, TRUE) THEN BEGIN
            DepartmentTempDelete.SETFILTER("Department Category", '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER(Code, '<>%1', Rec.Code);
            IF DepartmentTempDelete.FINDSET THEN
                REPEAT

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
            DimensionsForPos.SETFILTER("Department Category", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    PositionMenu.RESET;
                    PositionMenu.SETFILTER(Code, '%1', DimensionsForPos."Position Code");
                    PositionMenu.SETFILTER(Description, '%1', DimensionsForPos."Position Description");
                    IF PositionMenu.FINDSET THEN
                        REPEAT
                            PositionMenu.DELETE;
                        UNTIL PositionMenu.NEXT = 0;
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
            DimensipnTemp.SETFILTER("Department Category", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensipnTemp.FINDSET THEN
                REPEAT
                    DimensipnTemp.DELETE;
                UNTIL DimensipnTemp.NEXT = 0;

            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Department Cat. Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    ECLSystematization.VALIDATE("Org Belongs", '');
                    ECLSystematization.VALIDATE("Position Description", '');
                UNTIL ECLSystematization.NEXT = 0;

        END


        ELSE BEGIN
            DepartmentTempDelete.SETFILTER("Department Category", '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER("Department Type", '%1', 4);
            IF DepartmentTempDelete.FINDFIRST THEN BEGIN
                DepartmentTempDelete.DELETE;
            END;

            DimensionsTempFor.SETFILTER("Department Category", '%1', Rec.Code);
            DimensionsTempFor.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            DimensionsTempFor.SETFILTER("Department Type", '%1', 4);
            DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                DimensionsTempFor.DELETE;
            END;


            DepartmentTempDelete2.RESET;
            DepartmentTempDelete2.SETFILTER("Department Category", '%1', Rec.Code);
            DepartmentTempDelete2.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            IF DepartmentTempDelete2.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DepartmentTempDelete2.GET(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", DepartmentTempDelete2."Team Description", DepartmentTempDelete2."Department Categ.  Description",
                        DepartmentTempDelete2."Group Description", DepartmentTempDelete2.Description) THEN
                            DepartmentTempDelete2.RENAME(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", DepartmentTempDelete2."Team Description", Sectortemptable.Description,
                            DepartmentTempDelete2."Group Description", DepartmentTempDelete2.Description);
                        DepartmentTempDelete2."Department Category" := Sectortemptable.Code;
                        DepartmentTempDelete2."Department Idenity" := Sectortemptable.Identity;
                        DepartmentTempDelete2.MODIFY;
                        DimensionsTempFor.RESET;
                        DimensionsTempFor.SETFILTER("Department Category", '%1', Rec.Code);
                        DimensionsTempFor.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
                        DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF DimensionsTempFor.FINDSET THEN
                            REPEAT
                                IF DimensionsTempFor1.GET(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", DimensionsTempFor."Team Description",
                                DimensionsTempFor."Department Categ.  Description", DimensionsTempFor."Group Description", DimensionsTempFor."Group Code", Sectortemptable."Org Shema") THEN
                                    DimensionsTempFor1.RENAME(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", DimensionsTempFor."Team Description",
                                    Sectortemptable.Description, DimensionsTempFor."Group Description", Sectortemptable.Code, Sectortemptable."Org Shema");
                                IF (DimensionsTempFor."Group Code" = '') AND (DimensionsTempFor."Group Description" = '') THEN BEGIN
                                    DimensionsTempFor1.Belongs := DimensionsTempFor.Code + '-' + Sectortemptable.Description;
                                    DimensionsForPos1.MODIFY;
                                END;
                            UNTIL DimensionsTempFor.NEXT = 0;

                        DepartmentTempDelete2.MODIFY;
                    END;
                UNTIL DepartmentTempDelete2.NEXT = 0;


            DimensionsForPos.RESET;
            DimensionsForPos.SETFILTER("Department Category", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    DimensionsForPos2.RESET;
                    DimensionsForPos2.SETFILTER("Position Code", '%1', DimensionsForPos1."Position Code");
                    DimensionsForPos2.SETFILTER("Position Description", '%1', DimensionsForPos1."Position Description");
                    IF DimensionsForPos2.FINDSET THEN
                        REPEAT
                            Sectortemptable.RESET;
                            Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                            Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                            IF Sectortemptable.FINDFIRST THEN BEGIN
                                Change := Sectortemptable.Description;
                            END;
                            DepartmentTempDelete1.RESET;
                            DepartmentTempDelete1.SETFILTER("Department Categ.  Description", '%1', Change);
                            DepartmentTempDelete1.SETFILTER("Department Type", '%1', 2);
                            DepartmentTempDelete1.SETFILTER("ORG Shema", '%1', "Org Shema");
                            IF DepartmentTempDelete1.FINDFIRST THEN BEGIN
                                value := DepartmentTempDelete1."Dimension Value Code";
                            END;
                            //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                            IF DimensionsoRG.GET(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", Rec."Org Shema", DimensionsForPos2."Position Description", DimensionsForPos2."Org Belongs") THEN BEGIN
                                IF (DimensionsoRG."Group Code" = '') AND (DimensionsoRG."Group Description" = '') THEN BEGIN
                                    DimensionsoRG.RENAME(DimensionsoRG."Position Code", value, Rec."Org Shema", DimensionsoRG."Position Description", Change);
                                    DimensionsoRG."Department Categ.  Description" := Change;
                                    DimensionsoRG.MODIFY;

                                    DepartmentTempDelete1.RESET;
                                    DepartmentTempDelete1.SETFILTER("Department Categ.  Description", '%1', Change);
                                    DepartmentTempDelete1.SETFILTER("ORG Shema", '%1', "Org Shema");
                                    DepartmentTempDelete1.SETFILTER("Department Type", '%1', 4);
                                    IF DepartmentTempDelete1.FINDFIRST THEN BEGIN
                                        DimensionsoRG."Dimension  Name" := DepartmentTempDelete1."Dimension  Name";
                                        DimensionsoRG."Department Categ.  Description" := Change;
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
            DimensipnTemp.SETFILTER("Department Category", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("Department Type", '%1', 4);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            IF DimensipnTemp.FINDFIRST THEN
                DimensipnTemp.DELETE;


            DepCatZem.RESET;
            DepCatZem.SETFILTER("Dep Cat Identity", '%1', Rec.Identity);
            IF DepCatZem.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    IF Sectortemptable.FINDFIRST THEN BEGIN

                        DepCatZem."Dep Cat Identity" := Sectortemptable.Identity;
                        DepCatZem."Belongs to Department Category" := Sectortemptable.Description;
                        DepCatZem.MODIFY;
                    END;
                UNTIL DepCatZem.NEXT = 0;
            BelongGroupChange.RESET;
            BelongGroupChange.SETFILTER("Belongs to Department Category", '%1', Rec.Description);
            IF BelongGroupChange.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        BelongGroupChange."Belongs to Department Category" := Sectortemptable.Description;
                        BelongGroupChange.MODIFY;
                    END;

                UNTIL BelongGroupChange.NEXT = 0;



            DimensionTempPos.RESET;
            DimensionTempPos.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            IF DimensionTempPos.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DimensionTempPos1.GET(DimensionTempPos."Position Code", DimensionTempPos."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", DimensionTempPos."Org Belongs") THEN BEGIN
                            DimensionTempPos2.RESET;
                            DimensionTempPos2.SETFILTER("Department Categ.  Description", '%1', Sectortemptable.Description);
                            DimensionTempPos2.SETFILTER("Group Description", '%1', '');
                            IF DimensionTempPos2.FINDFIRST THEN BEGIN
                                DimensionTempPos1.RENAME(DimensionTempPos."Position Code", DimensionTempPos2."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", Sectortemptable.Description);
                                DimensionTempPos1."Dimension  Name" := DimensionTempPos2."Dimension  Name";
                                DimensionTempPos1."Department Categ.  Description" := Sectortemptable.Description;
                                DimensionTempPos1.MODIFY;
                            END;
                        END;
                    END;
                //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                UNTIL DimensionTempPos.NEXT = 0;

            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Department Cat. Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN
                        NewDepCat := Sectortemptable.Description;

                    IF ECLSystematization."Team Description" <> '' THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Team Description", '%1', ECLSystematization."Team Description");
                        DepartmentValue.SETFILTER("Department Categ.  Description", '%1', NewDepCat);
                        DepartmentValue.SETFILTER("Department Type", '%1', 9);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", ECLSystematization."Team Description");
                        END
                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                    END;
                    IF (ECLSystematization."Group Description" <> '') AND (ECLSystematization."Team Description" = '') THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Group Description", '%1', ECLSystematization."Group Description");
                        DepartmentValue.SETFILTER("Department Categ.  Description", '%1', NewDepCat);
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
                        DepartmentValue.SETFILTER("Department Categ.  Description", '%1', NewDepCat);
                        DepartmentValue.SETFILTER("Department Type", '%1', 4);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", NewDepCat);
                        END

                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                    END;
                    ECLSystematization.MODIFY;
                UNTIL ECLSystematization.NEXT = 0;

            HeadOf.RESET;
            HeadOf.SETFILTER("Department Category", '%1', Rec.Code);
            HeadOf.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            HeadOf.SETFILTER("Group Code", '%1', '');
            HeadOf.SETFILTER("Group Description", '%1', '');
            HeadOf.SETFILTER("Team Code", '%1', '');
            HeadOf.SETFILTER("Team Description", '%1', '');
            IF HeadOf.FINDFIRST THEN BEGIN
                HeadOf.DELETE;
            END;
            HeadOf1.RESET;
            HeadOf1.SETFILTER("Department Category", '%1', Rec.Code);
            HeadOf1.SETFILTER("Department Categ.  Description", '%1', Rec.Description);
            IF HeadOf1.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        Change := Sectortemptable.Description;
                    END;
                    IF HeadChange.GET(HeadOf1."Department Code", HeadOf1."ORG Shema", HeadOf1."Department Categ.  Description", HeadOf1."Group Description", HeadOf1."Team Description") THEN BEGIN
                        IF NOT HeadChange.GET(HeadOf1."Department Code", Rec."Org Shema", Sectortemptable.Description, HeadOf1."Group Description", HeadOf1."Team Description") THEN BEGIN
                            HeadChange.RENAME(HeadOf1."Department Code", Rec."Org Shema", Sectortemptable.Description, HeadOf1."Group Description", HeadOf1."Team Description")
                        END
                        ELSE BEGIN
                            HeadChange.DELETE;
                        END;
                        //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description

                    END;
                UNTIL HeadOf1.NEXT = 0;
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
        IsEditble := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditble := TRUE;
    end;

    trigger OnOpenPage()
    begin
        /*HRsetup.FINDFIRST;
        CALCFIELDS("Position Code", "Position ID");
        SETFILTER(Status,'%1',Status::Active);
        SETRANGE("Employment Date", CALCDATE('-'+ FORMAT(HRsetup."New employee period"),TODAY),TODAY);
        SETFILTER(Testing,'%1',TRUE);*/
        //CurrPage.EDITABLE(FALSE);

        /*SectorInsertModify.RESET;
            SectorInsertModify.SETFILTER(LastModified,'<>%1','');
            IF SectorInsertModify.FINDFIRST THEN BEGIN
        
            MESSAGE('Poslednji izmjenjeni odjel je' +' '+' ' +SectorInsertModify.LastModified);
            END;*/
        /* DepTempBelong.RESET;
      DimensionsTempTabela.RESET;
     DepTempBelong.SETFILTER(Code,'<>%1','');
     IF DepTempBelong.FINDSET THEN REPEAT
        DepTempBelong.CALCFIELDS("Number of dimension value");
        IF DepTempBelong."Number of dimension value"=1  THEN BEGIN
         DepTempBelong1:=DepTempBelong;
         DimensionsTempTabela.RESET;
         DimensionsTempTabela.SETFILTER("Department Type",'%1',4);
         DimensionsTempTabela.SETFILTER("Department Categ.  Description",'%1',DepTempBelong.Description);
         IF DimensionsTempTabela.FINDFIRST THEN BEGIN
         DepTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
           DepTempBelong1.MODIFY;
           END;
             END;
       UNTIL DepTempBelong.NEXT=0;*/

    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        StepNext: Page "Group temporary sist";
        DepartmentCategroyTemp: Record "Department Category temporary";
        PreviousStep: Page "Sector temporary sist";
        Text1: Text;
        ResponseChange: Boolean;
        DepCatTemp: Record "Department Category temporary";
        //     DepartmentChange: Report "Department Temporary change1";
        TextPart1: Label 'Do you want to change all level below';
        Text007: Label 'Do you want to delete  all level below';
        Potvrda: Boolean;
        Position: Record "Position temporery";
        DepartmentTempDelete: Record "Department temporary";
        Sectortemptable: Record "Department Category temporary";
        DepartmentTempDelete2: Record "Department temporary";
        PositionTempor: Record "Position temporery";
        GroupTempChange: Record "Group temporary";
        StepNextTabela: Record "Group temporary";
        PrevoiusTabela: Record "Sector temporary";
        OrgJed: Record "Department temporary";
        Depcat: Record "Department Category temporary";
        DepCatZem: Record "Group temporary";
        SecYes: Record "Department Category temporary";
        DepartmentTempDeleteNew: Record "Department temporary";
        IsEditble: Boolean;
        SectorInsertModify: Record "Department Category temporary";
        InsertSector: Record "Department temporary";
        SectorTempIdentity: Record "Department Category temporary";
        DepOrginalDelete: Record "Department temporary";
        DimensionsTempFor: Record "Dimension temporary";
        //     DepCatDelete2: Record "Team temporary";
        DepCatDelete1: Record "Group temporary";
        DepartmentTempDeletefOR: Record "Department temporary";
        PrevoiusMessage: Record "Sector temporary";
        NextMessage: Record "Group temporary";
        SectorIdentityInsert: Record "Sector temporary";
        DimensionsTempFor1: Record "Dimension temporary";
        SectorCheck: Record "Department Category temporary";
        Found1: Boolean;
        Found2: Boolean;
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        Text008: Label 'You are forgot to insert dimension value';
        Text009: Label 'You are forgot to insert is this sector Residence/Network';
        DimensionsForPos: Record "Dimension temp for position";
        PositionMenu: Record "Position Menu temporary";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong: Record "Sector temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        //    TeamTempBelong: Record "Team temporary";
        //  TeamTempBelong1: Record "Team temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        DimensionsForPos1: Record "Dimension temp for position";
        DimensionCorect: Record "Dimension temporary";
        DimensionCorect1: Record "Dimension temporary";
        DepCatCode: Record "Department Category temporary";
        SectorCode: Record "Sector temporary";
        DimensipnTemp: Record "Dimension temporary";
        DimensionsForPos2: Record "Dimension temp for position";
        SectorTemp: Record "Department Category temporary";
        DimensionTempValue: Record "Dimension temporary";
        DimensionsForPositionTC: Record "Dimension temp for position";
        DimensionsForPositionTC1: Record "Dimension temp for position";
        FindTC: Record "Dimension temporary";
        DimensionForPosition: Record "Dimension temp for position";
        Dep: Record "Department";
        DimensionNew: Record "Dimension temporary";
        OsPreparation: Record "ORG Shema";
        SectorFind: Record "Sector temporary";
        String: Text;
        Brojac: Integer;
        i: Integer;
        DepartmentTemp: Record "Department temporary";
        LengthString: Integer;
        SectorFind1: Integer;
        DepartmentTemp1: Record "Department temporary";
        NewDescription: Text;
        TheLastCharacter: Integer;
        TheSame: Integer;
        NewCode: Code[20];
        LastCharacter: Integer;
        CheckPoint: Code[20];
        CodeDifferent: Integer;
        SectorCheckLength: Record "Sector temporary";
        //ĐK    DimesnionForReport: Record "Dimension for report";
        DimensionCopy: Record "Dimension temporary";
        Change: Text;
        DepartmentTempDelete1: Record "Dimension temporary";
        value: Code[50];
        DimensionsoRG: Record "Dimension temp for position";
        Responsenew: Boolean;
        FilterC: Code[10];
        // NewReport: Report "Department dep New";
        Text6: Label 'Do you want to insert a new department category';
        BrojacReport: Integer;
        ValueSector1: Text;
        ValueSector: Integer;
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        DimensiontempfoRposition: Record "Dimension temp for position";
        HeadOf: Record "Head Of's temporary";
        HeadChange: Record "Head Of's temporary";
        HeadOf1: Record "Head Of's temporary";
        HeadOfChange: Record "Head Of's temporary";
        HeadOfNew: Record "Head Of's temporary";
        DimensionPosHead: Record "Dimension temp for position";
        PositionMenuHead: Record "Position Menu temporary";
        BelongGroupChange: Record "Group temporary";
        ECLSystematization: Record "ECL systematization";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionTempPos1: Record "Dimension temp for position";
        DimensionTempPos2: Record "Dimension temp for position";
        Text7: Label 'Do you want to copy a department category';
        //   ForCopyReport: Report "Department dep copy";
        SectorTemp1: Record "Sector temporary";
        NewDepCat: Text;
        DepartmentValue: Record "Department temporary";
        PositionMenu5: Record "Position Menu temporary";
}

