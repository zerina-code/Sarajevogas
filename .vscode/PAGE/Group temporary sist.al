page 50062 "Group temporary sist"
{
    Caption = 'Group wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Group temporary";
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

                    /*    trigger OnValidate()
                        begin
                            OsPreparation.RESET;
                            OsPreparation.SETFILTER(Status, '%1', 2);
                            IF OsPreparation.FINDLAST THEN BEGIN
                                "Org Shema" := OsPreparation.Code;
                            END
                            ELSE BEGIN
                                "Org Shema" := '';
                            END;
                            "Department Type" := 2;
                            /*SectorCheckLength.RESET;
                            IF SectorCheckLength.FINDSET THEN REPEAT
                            IF STRLEN(Rec.Code)<STRLEN(SectorCheckLength.Code) THEN ERROR(Text002);
                            UNTIL SectorCheckLength.NEXT=0;
                            IF Code <> '' THEN BEGIN
                                IF Description = '' THEN BEGIN
                                    DepartmentTemp.INIT;
                                    DepartmentTemp.VALIDATE(Code, Code);
                                    String := Rec.Code;
                                    //IF String[STRLEN(Rec.Code)]='.' THEN
                                    DepartmentTemp.Code := Rec.Code;
                                    DepartmentTemp."Group Code" := Rec.Code;
                                    DepartmentTemp."Department Type" := 2;
                                    DepartmentTemp.INSERT;
                                END
                                ELSE BEGIN
                                    DepartmentTemp.SETFILTER("Group Code", '%1', xRec.Code);
                                    DepartmentTemp.SETFILTER("Group Description", '%1', Description);
                                    DepartmentTemp.SETFILTER("Department Type", '%1', 2);
                                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                                        IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", DepartmentTemp."Team Description", DepartmentTemp."Department Categ.  Description", DepartmentTemp."Group Description", DepartmentTemp.Description) THEN BEGIN
                                            // IF String[STRLEN(Rec.Code)]='.' THEN BEGIN
                                            DepartmentTemp1.RENAME(Rec.Code, "Org Shema", DepartmentTemp."Team Description", Rec."Belongs to Department Category", Rec.Description, Rec.Description);
                                        END;
                                        /* ELSE BEGIN
                                         String:=FORMAT(Rec.Code);
                                            LengthString:=STRLEN(String);
                                            Brojac:=0;
                                            FOR I:=1 TO LengthString DO BEGIN
                                            IF String[I]='.'THEN BEGIN
                                               Brojac:=Brojac+1;
                                               IF Brojac=3 THEN
                                               CodeDifferent:=I;
                                                  END;
                                                   END;
                                         DepartmentTemp1.RENAME(COPYSTR(Rec.Code,1,CodeDifferent),"Org Shema",DepartmentTemp."Team Description",Rec."Belongs to Department Category",Rec.Description,'Glavna filijala');
                                                END;
                                        SectorFind.RESET;
                                        String := FORMAT(Rec.Code);
                                        LengthString := STRLEN(String);
                                        Brojac := 0;
                                        FOR I := 1 TO LengthString DO BEGIN
                                            IF String[I] = '.' THEN BEGIN
                                                Brojac := Brojac + 1;

                                                IF Brojac = 2 THEN
                                                    SectorFind1 := I;

                                            END;
                                        END;
                                        SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorFind1));
                                        IF SectorFind.FINDFIRST THEN BEGIN

                                            DepartmentTemp1.Sector := SectorFind.Code;
                                            DepartmentTemp1."Sector  Description" := SectorFind.Description;
                                            DepartmentTemp1."Sector Identity" := SectorFind.Identity;
                                            DepartmentTemp1."Department Idenity" := Rec.Identity;
                                            FindDep.RESET;
                                            FindDep.SETFILTER(Description, '%1', Rec."Belongs to Department Category");
                                            IF FindDep.FINDFIRST THEN BEGIN
                                                DepartmentTemp1."Department Category" := FindDep.Code;
                                                "Dep Cat Identity" := FindDep.Identity;
                                            END;
                                        END;

                                        DepartmentTemp1.MODIFY;
                                    END;
                                END;
                            END;
                            //END;


                            SectorFind.RESET;
                            String := FORMAT(Rec.Code);
                            LengthString := STRLEN(String);
                            Brojac := 0;
                            FOR I := 1 TO LengthString DO BEGIN
                                IF String[I] = '.' THEN BEGIN
                                    Brojac := Brojac + 1;

                                    IF Brojac = 2 THEN
                                        SectorFind1 := I;

                                END;
                            END;
                            SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorFind1));
                            IF SectorFind.FINDFIRST THEN BEGIN
                                Rec."Identity Sector" := SectorFind.Identity;
                            END;

                        end;*/

                }
                field(Description; Description)
                {

                    ApplicationArea = all;

                    /*  trigger OnValidate()
                      begin
                          OsPreparation.RESET;
                          OsPreparation.SETFILTER(Status, '%1', 2);
                          IF OsPreparation.FINDLAST THEN BEGIN
                              "Org Shema" := OsPreparation.Code;
                          END
                          ELSE BEGIN
                              "Org Shema" := '';
                          END;
                          //ĐK "Department Type" := 2;
                          IF Rec.Description <> '' THEN BEGIN
                              IF Rec.Code <> '' THEN BEGIN
                                  DepartmentTemp.SETFILTER("Group Code", '%1', Rec.Code);
                                  DepartmentTemp.SETFILTER("Department Type", '%1', 2);


                                  IF DepartmentTemp.FIND('-') THEN BEGIN
                                      /*IF STRPOS(Description,'Filijala')<>0 THEN BEGIN
                                 NewDescription:='Filijala';
                                 END
                                 ELSE BEGIN 
                                      NewDescription := Description;
                                      // END;
                                      String := FORMAT(Rec.Code);
                                      LengthString := STRLEN(String);
                                      Brojac := 0;
                                      TheLastCharacter := STRLEN(Rec.Code);
                                      CheckPoint := Rec.Code;
                                      // IF CheckPoint[TheLastCharacter]<>'.' THEN BEGIN
                                      Brojac := 0;
                                      FOR I := 1 TO STRLEN(Rec.Code) DO BEGIN
                                          IF String[I] = '.' THEN BEGIN
                                              Brojac := Brojac + 1;
                                              IF Brojac = 2 THEN BEGIN
                                                  SectorFind1 := I;
                                              END;
                                          END;
                                      END;


                                      IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", '', '', DepartmentTemp."Group Description", DepartmentTemp.Description) THEN
                                          DepartmentTemp1.RENAME(Rec.Code, "Org Shema", '', Rec."Belongs to Department Category", Rec.Description, NewDescription);

                                      /*
                                      ELSE BEGIN
                                      IF DepartmentTemp1.GET(DepartmentTemp.Code,DepartmentTemp."ORG Shema",'','',DepartmentTemp."Group Description",DepartmentTemp.Description) THEN
                                      DepartmentTemp1.RENAME(Code,"Org Shema",'',Rec."Belongs to Department Category",Description,NewDescription);
                                      END;
                                      SectorFind.RESET;
                                      String := FORMAT(Rec.Code);
                                      LengthString := STRLEN(String);
                                      Brojac := 0;
                                      FOR I := 1 TO LengthString DO BEGIN
                                          IF String[I] = '.' THEN BEGIN
                                              Brojac := Brojac + 1;

                                              IF Brojac = 2 THEN BEGIN
                                                  SectorFind1 := I;
                                              END;
                                          END;
                                      END;
                                      SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorFind1));
                                      IF SectorFind.FINDFIRST THEN BEGIN

                                          DepartmentTemp1.Sector := SectorFind.Code;
                                          DepartmentTemp1."Sector  Description" := SectorFind.Description;
                                          DepartmentTemp1."Sector Identity" := SectorFind.Identity;
                                          "Dep Cat Identity" := FindDep.Identity;
                                          FindDep.RESET;
                                          FindDep.SETFILTER(Description, '%1', "Belongs to Department Category");
                                          IF FindDep.FINDFIRST THEN BEGIN
                                              DepartmentTemp1."Department Category" := FindDep.Code;
                                              DepartmentTemp1."Department Idenity" := FindDep.Identity;
                                              "Dep Cat Identity" := FindDep.Identity;
                                          END;
                                      END;

                                      DepartmentTemp1.MODIFY;

                                  END
                                  ELSE BEGIN
                                      DepartmentTemp1.INIT;
                                      /*IF STRPOS(Description,'Filijala')=0 THEN BEGIN
                                      DepartmentTemp1.Description:='Filijala';
                                      END
                                      ELSE BEGIN
                                      DepartmentTemp1.Description:=Description;
                                      END;
                                      DepartmentTemp1.Description := Rec.Description;
                                      SectorFind.RESET;
                                      String := FORMAT(Rec.Code);
                                      LengthString := STRLEN(String);
                                      Brojac := 0;
                                      FOR I := 1 TO LengthString DO BEGIN
                                          IF String[I] = '.' THEN BEGIN
                                              Brojac := Brojac + 1;

                                              IF Brojac = 2 THEN BEGIN
                                                  SectorFind1 := I;
                                              END;
                                          END;
                                      END;
                                      SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorFind1));
                                      IF SectorFind.FINDFIRST THEN BEGIN
                                          DepartmentTemp1.Sector := SectorFind.Code;
                                          DepartmentTemp1."Sector  Description" := SectorFind.Description;
                                          DepartmentTemp1."Sector Identity" := SectorFind.Identity;
                                          FindDep.RESET;
                                          FindDep.SETFILTER(Description, '%1', "Belongs to Department Category");
                                          IF FindDep.FINDFIRST THEN BEGIN
                                              DepartmentTemp1."Department Category" := FindDep.Code;
                                              DepartmentTemp1."Department Idenity" := FindDep.Identity;
                                              "Dep Cat Identity" := FindDep.Identity;
                                          END;
                                      END;
                                      DepartmentTemp1.INSERT;
                                  END;
                              END;
                          END;



                          CurrPage.UPDATE;

                      end;*/
                }
                field("Official Translate of Group"; "Official Translate of Group")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Belongs to Department Category"; "Belongs to Department Category")
                {

                    ApplicationArea = all;

                    /*   trigger OnValidate()
                       var
                           SectorFi: Record "Sector temporary";
                       begin
                           IF "Belongs to Department Category" <> '' THEN BEGIN
                               DepartmentRename.RESET;
                               DepartmentRename.SETFILTER("Department Type", '%1', 2);
                               DepartmentRename.SETFILTER("Group Code", '%1', Rec.Code);
                               DepartmentRename.SETFILTER("Group Description", '%1', Rec.Description);
                               IF DepartmentRename.FINDFIRST THEN BEGIN

                                   IF DepartmentRename1.GET(DepartmentRename.Code, DepartmentRename."ORG Shema", '', '', DepartmentRename."Group Description", DepartmentRename.Description)
                                     THEN
                                       DepartmentRename1.RENAME(DepartmentRename.Code, DepartmentRename."ORG Shema", '', "Belongs to Department Category", DepartmentRename."Group Description", DepartmentRename.Description);
                                   FindCodeForDep.RESET;
                                   FindCodeForDep.SETFILTER(Description, '%1', "Belongs to Department Category");
                                   IF FindCodeForDep.FINDFIRST THEN BEGIN
                                       DepartmentRename1."Department Category" := FindCodeForDep.Code;
                                       SectorFi.Reset();
                                       SectorFi.SetFilter(Description, '%1', FindCodeForDep."Sector Belongs");
                                       SectorFi.SetFilter("Org Shema", '%1', FindCodeForDep."Org Shema");
                                       if SectorFi.FindFirst() then begin
                                           DepartmentRename1.Sector := SectorFi.Code;
                                           DepartmentRename1."Sector  Description" := SectorFi.Description;
                                       end;


                                       DepartmentRename1."Department Idenity" := FindCodeForDep.Identity;
                                       Rec."Dep Cat Identity" := FindCodeForDep.Identity;
                                   END
                                   ELSE BEGIN
                                       DepartmentRename1."Department Category" := '';
                                   END;
                                   DepartmentRename1.MODIFY;
                               END;
                           END;
                           CurrPage.UPDATE;
                       end;*/
                }
                field("Residence/Network"; "Residence/Network")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;

                    /*   trigger OnValidate()
                       begin
                           IF FORMAT(Rec."Residence/Network") <> '' THEN BEGIN
                               IF Rec.Code <> '' THEN BEGIN
                                   IF Rec.Description <> '' THEN BEGIN
                                       DepartmentTemp.RESET;
                                       DepartmentTemp.SETFILTER("Group Code", '%1', Rec.Code);
                                       DepartmentTemp.SETFILTER("Group Description", '%1', Rec.Description);
                                       DepartmentTemp.SETFILTER("Department Type", '%1', 2);
                                       IF DepartmentTemp.FINDFIRST THEN BEGIN
                                           DepartmentTemp."Residence/Network" := "Residence/Network";
                                           DepartmentTemp.MODIFY;
                                       END;

                                   END;
                               END;
                           END;
                       end;*/
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
                field("Org Shema"; "Org Shema")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
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

                    // StepNext.SETRECORD(Rec);
                    InsertSectoR.RESET;
                    InsertSectoR.SETFILTER("Group Code", '<>%1', '');
                    InsertSectoR.SETFILTER("Group Description", '<>%1', '');
                    IF InsertSectoR.FINDSET THEN
                        REPEAT
                            SectorTempIdentity.RESET;
                            SectorTempIdentity.SETFILTER(Code, '%1', InsertSectoR."Group Code");
                            SectorTempIdentity.SETFILTER(Description, '%1', InsertSectoR."Group Description");
                            IF SectorTempIdentity.FINDFIRST THEN BEGIN
                                InsertSectoR."Department Group identity" := SectorTempIdentity.Identity;
                            END;
                        UNTIL InsertSectoR.NEXT = 0;

                    SectorTemp1.RESET;
                    SectorTemp1.SETFILTER(Code, '<>%1', '');
                    IF SectorTemp1.FINDSET THEN
                        REPEAT
                            ECLSystematization.RESET;
                            ECLSystematization.SETFILTER("Sector Description", '%1', SectorTemp1.Description);
                            ECLSystematization.SETFILTER("Group Description", '<>%1', '');
                            ECLSystematization.SETFILTER("Team Description", '%1', '');
                            IF ECLSystematization.FINDFIRST THEN
                                REPEAT
                                    ECLSystematization."Sector Identity" := SectorTemp1.Identity;
                                    ECLSystematization.MODIFY;
                                UNTIL ECLSystematization.NEXT = 0;
                        UNTIL SectorTemp1.NEXT = 0;

                    //StepNextTabela.SETFILTER("Group Identity",'%1',Rec.Identity);
                    IF Rec."Identity Sector" = 0 THEN BEGIN
                        ValueSector1 := Rec.GETFILTER("Identity Sector");
                        IF EVALUATE(ValueSector, ValueSector1) THEN
                            StepNextTabela.SETFILTER("Identity Sector", '%1', ValueSector);
                    END
                    ELSE BEGIN
                        StepNextTabela.SETFILTER("Identity Sector", '%1', Rec."Identity Sector");
                    END;
                    //ĐK  StepNext.SETTABLEVIEW(StepNextTabela);
                    StepNext.RUN;
                    /*NextMessage.RESET;
                  NextMessage.SETFILTER(LastModified,'<>%1','');
                   IF NextMessage.FINDFIRST THEN BEGIN

                   MESSAGE('Poslednji izmijenjeni tim je' +' '+' ' +NextMessage.LastModified);
                   END;*/


                    /*

                    DimensionCorect.RESET;
                    DimensionCorect.SETFILTER("Department Type",'%1',2);
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

                    GroupCheck.RESET;
                    GroupCheck.SETFILTER(Description,'%1',DimensionCorect."Group Description");
                    IF GroupCheck.FINDFIRST THEN BEGIN
                    IF DimensionCorrect1.GET(DimensionCorect.Code,DimensionCorect."Dimension Value Code",DimensionCorect."Team Description",
                    DimensionCorect."Department Categ.  Description",DimensionCorect."Group Description",DimensionCorect."Group Code","Org Shema") THEN BEGIN
                    IF DimensionCorect."Group Code"<>GroupCheck.Code THEN
                    DimensionCorrect1.RENAME(DimensionCorect.Code,DimensionCorect."Dimension Value Code",DimensionCorect."Team Description",
                    DimensionCorect."Department Categ.  Description",DimensionCorect."Group Description",GroupCheck.Code,"Org Shema") ;
                     END;
                      END;
                    UNTIL DimensionCorect.NEXT=0;
                    //Code,Dimension Value Code,Team Description,Department Categ.  Description,Group Description,Group Code,ORG Shema


                    DimensiontempfoRposition.RESET;
                    DimensiontempfoRposition.SETFILTER("Position Code",'<>%1','');
                    DimensiontempfoRposition.SETFILTER(Sector,'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Sector  Description",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Department Categ.  Description",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Department Category",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Group Code",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Group Description",'<>%1','');
                    DimensiontempfoRposition.SETFILTER("Team Code",'%1','');
                    DimensiontempfoRposition.SETFILTER("Team Description",'%1','');

                    IF DimensiontempfoRposition.FINDSET THEN REPEAT
                      PositionMenuCorrect.RESET;
                      PositionMenuCorrect.SETFILTER(Code,'%1',DimensiontempfoRposition."Position Code");
                      PositionMenuCorrect.SETFILTER(Description,'%1',DimensiontempfoRposition."Position Description");
                      IF PositionMenuCorrect.FINDFIRST THEN BEGIN
                          IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
                            IF PositionMenuCorrect."Department Code"<>DimensiontempfoRposition."Group Code" THEN
                              PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,DimensiontempfoRposition."Group Code",PositionMenuCorrect."Org. Structure");
                            END;
                              END;
                               PositionMenuCorrect.CALCFIELDS("Number of dimension value");
                               IF PositionMenuCorrect."Number of dimension value"<>1 THEN BEGIN
                                  IF PositionMenuCorrect1.GET(PositionMenuCorrect.Code,PositionMenuCorrect.Description,PositionMenuCorrect."Department Code",PositionMenuCorrect."Org. Structure") THEN BEGIN
                               PositionMenuCorrect1.RENAME(PositionMenuCorrect.Code,PositionMenuCorrect.Description,'',PositionMenuCorrect."Org. Structure");
                                    END;
                                      END;
                              UNTIL DimensiontempfoRposition.NEXT=0;*/
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


                    IF Rec."Identity Sector" = 0 THEN BEGIN
                        ValueSector1 := Rec.GETFILTER("Identity Sector");
                        IF EVALUATE(ValueSector, ValueSector1) THEN
                            PrevoiusTabela.SETFILTER("Identity Sector", '%1', ValueSector);
                    END
                    ELSE BEGIN
                        PrevoiusTabela.SETFILTER("Identity Sector", '%1', Rec."Identity Sector");
                    END;
                    //ĐK PreviousStep.SETTABLEVIEW(PrevoiusTabela);

                    PreviousStep.RUN;
                    /* PreviousMessage.RESET;
                     PreviousMessage.SETFILTER(LastModified,'<>%1','');
                     IF PreviousMessage.FINDFIRST THEN BEGIN
                       MESSAGE('Poslednja izmijenjena grupa je' +' '+' ' +PreviousMessage.LastModified);
                      END;*/
                    CurrPage.CLOSE();

                END;


            }
            action("Change Code for levels below")
            {
                Caption = 'Change Code';
                Image = Change;
                ApplicationArea = all;
                Promoted = true;
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



                    GroupTemp.SETFILTER(Code, '%1', Rec.Code);
                    GroupTemp.SETFILTER("Org Shema", '%1', Rec."Org Shema");
                    GroupTemp.SETFILTER(Description, '%1', Rec.Description);
                    IF GroupTemp.FINDFIRST THEN BEGIN

                        CALCFIELDS("Number Of Team  levels below");
                        Text1 := TextPart1 + ' ' + Rec.Code + ' Grupe ' + ' ' + ' ' + 'Broj timova je ' + ' ' + ' ' + FORMAT("Number Of Team  levels below");
                    END;
                    IF ResponseChange <> CONFIRM(Text1, TRUE) THEN BEGIN

                        //DepartmentChange.SetP(xRec.Code,Rec.Code,Rec."Org Shema",Rec.Description);
                        //       DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 1, Rec."Belongs to Department Category", Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        //     DepartmentChange.RUN;
                    END
                    ELSE BEGIN
                        //   DepartmentChange.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", 2, Rec."Belongs to Department Category", Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        // DepartmentChange.RUN;
                    END;
                end;
            }
            action("Insert Group")
            {
                Caption = 'Insert Group';
                Image = Change;
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
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
                        //      NewReport.SetParam('', '', 0, FilterC, '');
                        //    NewReport.RUN;

                        EXIT;
                    END;
                end;
            }
            action("Copy Group")
            {
                Caption = 'Copy Group';
                Image = Copy;
                ApplicationArea = all;
                Promoted = true;
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

                        //       ForCopyReport.SetParam(Rec.Code, Rec.Description, Rec."Residence/Network", Rec."Org Shema", Rec."Belongs to Department Category");
                        //     ForCopyReport.RUN;
                        EXIT;
                    END;
                end;
            }
            group("Dimension temporary1")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = false;
                /*   action("Dimension temporary2")
                   {
                       Caption = 'Dimension temporary';
                       RunObject = Page "Dimensions temporary";
                       ApplicationArea = all;
                       RunPageLink = "Group Description" = FIELD(Description),
                                     "Department Type" = CONST(Group),
                                     "ORG Shema" = FIELD("Org Shema");
                       Visible = false;
                   }*/
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin


        IF Potvrda <> CONFIRM(Text007, TRUE) THEN BEGIN
            DepartmentTempDelete.SETFILTER("Group Code", '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Group Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER("Department Type", '<>%1', 2);
            IF DepartmentTempDelete.FINDSET THEN
                REPEAT
                    IF DepartmentTempDelete."Department Type".AsInteger() = 9 THEN BEGIN
                        DepCatDelete2.SETFILTER(Name, '%1', DepartmentTempDelete."Team Description");
                        IF DepCatDelete2.FINDFIRST THEN BEGIN
                            DepartmentTempDeletefOR.RESET;
                            DepartmentTempDeletefOR.SETFILTER("Team Description", '%1', DepartmentTempDelete."Team Description");
                            DepartmentTempDeletefOR.SETFILTER("Department Type", '%1', 9);
                            IF DepartmentTempDeletefOR.FINDFIRST THEN BEGIN
                                DepartmentTempDeletefOR.DELETE;
                            END;
                            DimensionsTempFor.RESET;
                            DimensionsTempFor.SETFILTER("Team Description", '%1', DepartmentTempDelete."Team Description");
                            DimensionsTempFor.SETFILTER("Department Type", '%1', 9);
                            DimensionsTempFor.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                                DimensionsTempFor.DELETE;
                            END;
                            DepCatDelete2.DELETE;
                        END;
                    END;

                UNTIL DepartmentTempDelete.NEXT = 0;

            DimensionsForPos.SETFILTER("Group Code", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Group Description", '%1', Rec.Description);
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
            DepOrginalDelete.SETFILTER("Group Code", '%1', Rec.Code);
            DepOrginalDelete.SETFILTER("Group Description", '%1', Rec.Description);
            DepOrginalDelete.SETFILTER("Department Type", '%1', 2);
            IF DepOrginalDelete.FINDFIRST THEN BEGIN
                DepOrginalDelete.DELETE;
            END;
            DimensipnTemp.RESET;
            DimensipnTemp.SETFILTER("Group Code", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Group Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            IF DimensipnTemp.FINDSET THEN
                REPEAT
                    DimensipnTemp.DELETE;
                UNTIL DimensipnTemp.NEXT = 0;


            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Group Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    ECLSystematization.VALIDATE("Org Belongs", '');
                    ECLSystematization.VALIDATE("Position Description", '');

                UNTIL ECLSystematization.NEXT = 0;
        END


        ELSE BEGIN
            DepartmentTempDelete.SETFILTER("Group Code", '%1', Rec.Code); //BRIŠE 1 STAVKU GRUPE
            DepartmentTempDelete.SETFILTER("Group Description", '%1', Rec.Description);
            DepartmentTempDelete.SETFILTER("Department Type", '%1', 2);
            IF DepartmentTempDelete.FINDFIRST THEN BEGIN
                DepartmentTempDelete.DELETE;
            END;

            DimensionsTempFor.SETFILTER("Group Code", '%1', Rec.Code); //BRIŠE PRVU STAVKU U TROŠKOVNIM CENTRIMA
            DimensionsTempFor.SETFILTER("Group Description", '%1', Rec.Description);
            DimensionsTempFor.SETFILTER("Department Type", '%1', 2);
            DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                DimensionsTempFor.DELETE;
            END;


            DepartmentTempDelete2.RESET;
            DepartmentTempDelete2.SETFILTER("Group Code", '%1', Rec.Code);
            DepartmentTempDelete2.SETFILTER("Group Description", '%1', Rec.Description);
            DepartmentTempDelete2.SETFILTER("Department Type", '<>%1', 2);
            IF DepartmentTempDelete2.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DepartmentTempDelete2.GET(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", DepartmentTempDelete2."Team Description",
                        DepartmentTempDelete2."Department Categ.  Description", DepartmentTempDelete2."Group Description", DepartmentTempDelete2.Description) THEN
                            DepartmentTempDelete2.RENAME(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", DepartmentTempDelete2."Team Description",
                            DepartmentTempDelete2."Department Categ.  Description", Sectortemptable.Description, DepartmentTempDelete2.Description);
                        DepartmentTempDelete2."Department Group identity" := Sectortemptable.Identity;


                        DimensionsTempFor.RESET;
                        DimensionsTempFor.SETFILTER("Group Code", '%1', DepartmentTempDelete2."Group Code");
                        DimensionsTempFor.SETFILTER("Group Description", '%1', Rec.Description);
                        DimensionsTempFor.SETFILTER("Department Type", '<>%1', 2);
                        DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF DimensionsTempFor.FINDSET THEN
                            REPEAT
                                IF DimensionsTempFor.GET(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", DimensionsTempFor."Team Description",
                                DimensionsTempFor."Department Categ.  Description", DimensionsTempFor."Group Description", DimensionsTempFor."Group Code", DimensionsTempFor."ORG Shema") THEN
                                    DimensionsTempFor.RENAME(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", DimensionsTempFor."Team Description",
                                    DimensionsTempFor."Department Categ.  Description", Sectortemptable.Description, DimensionsTempFor."Group Code", DimensionsTempFor."ORG Shema");
                                DimensionsTempFor.Belongs := DimensionsTempFor.Code + '-' + Sectortemptable.Description;
                            UNTIL DimensionsTempFor.NEXT = 0;


                        DepartmentTempDelete2.MODIFY;
                    END;
                UNTIL DepartmentTempDelete2.NEXT = 0;





            DimensionsForPos.RESET;
            DimensionsForPos.SETFILTER("Group Code", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Group Description", '%1', Rec.Description);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        FindTC.RESET;
                        FindTC.SETFILTER("Group Description", '%1', Sectortemptable.Description);
                        FindTC.SETFILTER("Department Type", '%1', 2);
                        FindTC.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                        IF FindTC.FINDFIRST THEN BEGIN
                            IF DimensionForPosition.GET(DimensionsForPos."Position Code", DimensionsForPos."Dimension Value Code", Rec."Org Shema", DimensionsForPos."Position Description") THEN BEGIN
                                DimensionForPosition.RENAME(DimensionsForPos."Position Code", FindTC."Dimension Value Code", Rec."Org Shema", DimensionsForPos."Position Description");
                                DimensionForPosition."Dimension  Name" := FindTC."Dimension  Name";
                                DimensionForPosition."Group Description" := Sectortemptable.Description;
                                DimensionForPosition.MODIFY;
                            END;
                        END;
                        //Position Code,Dimension Value Code,ORG Shema,Position Description
                    END;
                    DimensionsForPos1.RESET;
                    DimensionsForPos1.SETFILTER("Position Code", '%1', DimensionsForPos."Position Code");
                    DimensionsForPos1.SETFILTER("Position Description", '%1', DimensionsForPos."Position Description");
                    DimensionsForPos1.SETFILTER("Team Code", '%1', '');
                    DimensionsForPos1.SETFILTER("Team Description", '%1', '');
                    IF DimensionsForPos1.FINDSET THEN
                        REPEAT
                            DimensionsForPos2.SETFILTER("Position Code", '%1', DimensionsForPos1."Position Code");
                            DimensionsForPos2.SETFILTER("Position Description", '%1', DimensionsForPos1."Position Description");
                            IF DimensionsForPos2.FINDFIRST THEN BEGIN
                                IF DimensionsForPos2.GET(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", DimensionsForPos2."ORG Shema", DimensionsForPos2."Position Description", DimensionsForPos2."Org Belongs") THEN BEGIN
                                    DimensionsForPos2.RENAME(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", DimensionsForPos2."ORG Shema", DimensionsForPos2."Position Description", Sectortemptable.Description);
                                    DimensionsForPos2."Group Description" := Sectortemptable.Description;
                                    DimensionsForPos2.MODIFY;
                                END;
                            END;
                        UNTIL DimensionsForPos1.NEXT = 0;
                UNTIL DimensionsForPos.NEXT = 0;


            DepCatZem.RESET;
            DepCatZem.SETFILTER("Group Identity", '%1', Rec.Identity);
            IF DepCatZem.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        DepCatZem."Group Identity" := Sectortemptable.Identity;
                        DepCatZem.MODIFY;
                    END;
                UNTIL DepCatZem.NEXT = 0;
            DimensipnTemp.RESET;
            DimensipnTemp.SETFILTER("Group Code", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Group Description", '%1', Rec.Description);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            DimensipnTemp.SETFILTER("Department Type", '%1', 2);
            IF DimensipnTemp.FINDFIRST THEN BEGIN
                DimensipnTemp.DELETE;
            END;

            BelongGroupChange.RESET;
            BelongGroupChange.SETFILTER("Belongs to Group", '%1', Rec.Description);
            IF BelongGroupChange.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        BelongGroupChange."Belongs to Group" := Sectortemptable.Description;
                        BelongGroupChange.MODIFY;
                    END;

                UNTIL BelongGroupChange.NEXT = 0;

            DimensionTempPos.RESET;
            DimensionTempPos.SETFILTER("Group Description", '%1', Rec.Description);
            IF DimensionTempPos.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DimensionTempPos1.GET(DimensionTempPos."Position Code", DimensionTempPos."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", DimensionTempPos."Org Belongs") THEN BEGIN
                            DimensionTempPos2.RESET;
                            DimensionTempPos2.SETFILTER("Group Description", '%1', Sectortemptable.Description);
                            DimensionTempPos2.SETFILTER("Team Description", '%1', '');
                            IF DimensionTempPos2.FINDFIRST THEN BEGIN
                                DimensionTempPos1.RENAME(DimensionTempPos."Position Code", DimensionTempPos2."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", Sectortemptable.Description);
                                DimensionTempPos1."Dimension  Name" := DimensionTempPos2."Dimension  Name";
                                DimensionTempPos1."Group Description" := Sectortemptable.Description;
                                DimensionTempPos1.MODIFY;
                            END;
                        END;
                    END;
                //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                UNTIL DimensionTempPos.NEXT = 0;

            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Group Description", '%1', Rec.Description);
            IF ECLSystematization.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN
                        NewGroupCode := Sectortemptable.Description;

                    IF ECLSystematization."Team Description" <> '' THEN BEGIN

                        DepartmentValue.RESET;
                        DepartmentValue.SETFILTER("Team Description", '%1', ECLSystematization."Team Description");
                        DepartmentValue.SETFILTER("Group Description", '%1', NewGroupCode);
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
                        DepartmentValue.SETFILTER("Group Description", '%1', NewGroupCode);
                        DepartmentValue.SETFILTER("Department Type", '%1', 2);
                        IF DepartmentValue.FINDFIRST THEN BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", NewGroupCode);
                        END

                        ELSE BEGIN
                            ECLSystematization.VALIDATE("Org Belongs", '');
                        END;
                        ECLSystematization.MODIFY;
                    END;


                UNTIL ECLSystematization.NEXT = 0;
            HeadOf.RESET;
            HeadOf.SETFILTER("Group Code", '%1', Rec.Code);
            HeadOf.SETFILTER("Group Description", '%1', Rec.Description);
            HeadOf.SETFILTER("Team Code", '%1', '');
            HeadOf.SETFILTER("Team Description", '%1', '');
            IF HeadOf.FINDFIRST THEN BEGIN
                HeadOf.DELETE;
            END;
            HeadOf1.RESET;
            HeadOf1.SETFILTER("Group Code", '%1', Rec.Code);
            HeadOf.SETFILTER("Group Description", '%1', Rec.Description);
            IF HeadOf1.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Description, '<>%1', Rec.Description);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        Change := Sectortemptable.Description;
                    END;

                    IF HeadChange.GET(HeadOf1."Department Code", HeadOf1."ORG Shema", HeadOf1."Department Categ.  Description", HeadOf1."Group Description", HeadOf1."Team Description") THEN BEGIN
                        IF NOT HeadChange.GET(HeadOf1."Department Code", Rec."Org Shema", HeadOf1."Department Categ.  Description", Sectortemptable.Description, HeadOf1."Team Description") THEN BEGIN
                            HeadChange.RENAME(HeadOf1."Department Code", Rec."Org Shema", HeadOf1."Department Categ.  Description", Sectortemptable.Description, HeadOf1."Team Description")
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

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        //ĐK   IsEditble := TRUE;
    end;

    trigger OnOpenPage()
    begin
        /*HRsetup.FINDFIRST;
        CALCFIELDS("Position Code", "Position ID");
        SETFILTER(Status,'%1',Status::Active);
        SETRANGE("Employment Date", CALCDATE('-'+ FORMAT(HRsetup."New employee period"),TODAY),TODAY);
        SETFILTER(Testing,'%1',TRUE);*/
        //CurrPage.EDITABLE(FALSE);
        //đK  IsEditble := FALSE;
        /*SectorInsertModify.RESET;
            SectorInsertModify.SETFILTER(LastModified,'<>%1','');
            IF SectorInsertModify.FINDFIRST THEN BEGIN
        
            MESSAGE('Poslednja izmijenjena grupa je' +' '+' ' +SectorInsertModify.LastModified);
            END;
            */
        /* GroupTempBelong.RESET;
       DimensionsTempTabela.RESET;
     GroupTempBelong.SETFILTER(Code,'<>%1','');
     IF GroupTempBelong.FINDSET THEN REPEAT
        GroupTempBelong.CALCFIELDS("Number of dimension value");
        IF GroupTempBelong."Number of dimension value"=1  THEN BEGIN
         GroupTempBelong1:=GroupTempBelong;
         DimensionsTempTabela.RESET;
         DimensionsTempTabela.SETFILTER("Department Type",'%1',2);
         DimensionsTempTabela.SETFILTER("Group Description",'%1',GroupTempBelong.Description);
         IF DimensionsTempTabela.FINDFIRST THEN BEGIN
         GroupTempBelong1."Name of TC":=DimensionsTempTabela."Dimension Value Code"+' '+'-'+' '+DimensionsTempTabela."Dimension  Name";
           GroupTempBelong1.MODIFY;
           END;
             END;
       UNTIL GroupTempBelong.NEXT=0;*/

    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        StepNext: Page "Position menu temp";
        PreviousStep: Page "Dep.Category temporary sist";
        Text1: Text;
        ResponseChange: Boolean;
        GroupTemp: Record "Group temporary";
        //  DepartmentChange: Report "Department Temporary GROUP";
        TextPart1: Label 'Do you want to change all level below';
        Text007: Label 'Do you want to delete  all level below';
        Potvrda: Boolean;
        DepartmentTempDelete: Record "Department temporary";
        Position: Record "Position temporery";
        SecYes: Record "Group temporary";
        DepartmentTempDelete2: Record "Department temporary";
        Sectortemptable: Record "Group temporary";
        PositionTempor: Record "Position temporery";
        DepCatZem: Record "Team temporary";
        StepNextTabela: Record "Team temporary";
        PrevoiusTabela: Record "Department Category temporary";
        IsEditble: Boolean;
        DepCatDelete2: Record "Team temporary";
        DepCatDeleteD2: Record "Team temporary";
        DepartmentTempDeletefOR: Record "Department temporary";
        DepOrginalDelete: Record "Department temporary";
        DimensionsTempFor: Record "Dimension temporary";
        SectorInsertModify: Record "Group temporary";
        InsertSectoR: Record "Department temporary";
        SectorTempIdentity: Record "Group temporary";
        NextMessage: Record "Team temporary";
        PreviousMessage: Record "Department Category temporary";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        Text008: Label 'You are forgot to insert dimension value';
        Text009: Label 'You are forgot to insert is this sector Residence/Network';
        Found1: Boolean;
        Found2: Boolean;
        SectorCheck: Record "Group temporary";
        DimensionsForPos: Record "Dimension temp for position";
        PositionMenu: Record "Position Menu temporary";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong: Record "Sector temporary";
        SectorTempBelong1: Record "Sector temporary";
        DepTempBelong: Record "Department Category temporary";
        DepTempBelong1: Record "Department Category temporary";
        TeamTempBelong: Record "Team temporary";
        TeamTempBelong1: Record "Team temporary";
        GroupTempBelong: Record "Group temporary";
        GroupTempBelong1: Record "Group temporary";
        DimensionNew: Record "Dimension temporary";
        DimensionsForPos1: Record "Dimension temp for position";
        DimensionCorect: Record "Dimension temporary";
        DepCatCode: Record "Department Category temporary";
        SectorCode: Record "Sector temporary";
        GroupCheck: Record "Group temporary";
        DimensionCorrect1: Record "Dimension temporary";
        DimensipnTemp: Record "Dimension temporary";
        FindTC: Record "Department temporary";
        DimensionForPosition: Record "Dimension temp for position";
        DimensionsForPos2: Record "Dimension temp for position";
        Dep: Record "Department";
        DepartmentTemp: Record "Department temporary";
        OsPreparation: Record "ORG Shema";
        SectorFind: Record "Sector temporary";
        DepartmentTemp1: Record "Department temporary";
        String: Text;
        LengthString: Integer;
        Brojac: Integer;
        I: Integer;
        SectorFind1: Integer;
        NewDescription: Text;
        TheLastCharacter: Integer;
        CheckPoint: Code[20];
        TheSame: Integer;
        NewCode: Code[20];
        DepartmentRename: Record "Department temporary";
        FindCodeForDep: Record "Department Category temporary";
        CodeDifferent: Integer;
        FindDep: Record "Department Category temporary";
        DepartmentRename1: Record "Department temporary";
        SectorCheckLength: Record "Department Category temporary";
        DimesnionForReport: Record "Dimension for report";
        DimensionCopy: Record "Dimension temporary";
        Responsenew: Boolean;
        //ĐK        NewReport: Report "Department group New";
        FilterC: Code[30];
        Text6: Label 'Do you want to insert a new group';
        ValueSector1: Text;
        ValueSector: Integer;
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        DimensiontempfoRposition: Record "Dimension temp for position";
        HeadOf: Record "Head Of's temporary";
        Change: Text;
        HeadChange: Record "Head Of's temporary";
        HeadOf1: Record "Head Of's temporary";
        BelongGroupChange: Record "Team temporary";
        ECLSystematization: Record "ECL systematization";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionTempPos1: Record "Dimension temp for position";
        DimensionTempPos2: Record "Dimension temp for position";
        //    ForCopyReport: Report "Department group New";
        Text7: Label 'Do you want to copy a group';
        SectorTemp1: Record "Sector temporary";
        NewGroupCode: Text;
        DepartmentValue: Record "Department temporary";
        PositionMenu5: Record "Position Menu temporary";
}

