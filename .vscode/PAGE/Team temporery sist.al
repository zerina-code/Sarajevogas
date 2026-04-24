/*page 50119 "Team temporary sist"
{
    Caption = 'Team wizard';
    PageType = List;
    ShowFilter = true;
    SourceTable = "Team temporary";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field(S; Code)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        OsPreparation.RESET;
                        OsPreparation.SETFILTER(Status, '%1', 2);
                        IF OsPreparation.FINDLAST THEN BEGIN
                            "Org Shema" := OsPreparation.Code;
                        END
                        ELSE BEGIN
                            "Org Shema" := '';
                        END;
                        "Department Type" := 9;
                        FOR i := 1 TO STRLEN(Rec.Code) DO BEGIN
                            String := Rec.Code;
                            IF String[i] = '.' THEN BEGIN
                                Brojac := Brojac + 1;
                                IF Brojac = 2 THEN
                                    SectorLength := i;
                            END;
                        END;
                        SectorFind.RESET;
                        SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorLength));
                        IF SectorFind.FINDFIRST THEN BEGIN
                            Rec."Identity Sector" := SectorFind.Identity;
                        END;

                        SectorCheckLength.RESET;
                        IF SectorCheckLength.FINDSET THEN
                            REPEAT
                                IF STRLEN(Rec.Code) < STRLEN(SectorCheckLength.Code) THEN ERROR(Text002);
                            UNTIL SectorCheckLength.NEXT = 0;
                        IF Code <> '' THEN BEGIN
                            IF Name = '' THEN BEGIN
                                DepartmentTemp.INIT;
                                DepartmentTemp.VALIDATE(Code, Code);

                                String := Rec.Code;
                                DepartmentTemp.Code := Rec.Code;
                                DepartmentTemp."Team Code" := Rec.Code;
                                //    DepartmentTemp."Department Type" := 9;


                                DepartmentTemp.INSERT;
                            END
                            ELSE BEGIN
                                DepartmentTemp.SETFILTER("Team Code", '%1', xRec.Code);
                                DepartmentTemp.SETFILTER("Team Description", '%1', Name);
                                DepartmentTemp.SETFILTER("Department Type", '%1', 9);
                                IF DepartmentTemp.FINDFIRST THEN BEGIN
                                    IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", DepartmentTemp."Team Description", DepartmentTemp."Department Categ.  Description", DepartmentTemp."Group Description", DepartmentTemp.Description) THEN
                                        DepartmentTemp1.RENAME(Rec.Code, "Org Shema", Rec.Name, DepartmentTemp."Department Categ.  Description", Rec."Belongs to Group", Rec.Name);
                                    FindLevels.RESET;
                                    FindLevels.SETFILTER("Group Description", '%1', "Belongs to Group");
                                    FindLevels.SETFILTER("Department Type", '%1', 2);
                                    IF FindLevels.FINDFIRST THEN BEGIN
                                        IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", DepartmentTemp."Team Description", DepartmentTemp."Department Categ.  Description", DepartmentTemp."Group Description", DepartmentTemp.Description) THEN
                                            DepartmentTemp1.RENAME(Rec.Code, "Org Shema", Rec.Name, FindLevels."Department Categ.  Description", Rec."Belongs to Group", Rec.Name);
                                    END;
                                END;


                                DepartmentTemp1.Sector := FindLevels.Sector;
                                DepartmentTemp1."Sector  Description" := FindLevels."Sector  Description";
                                DepartmentTemp1."Sector Identity" := FindLevels."Sector Identity";
                                DepartmentTemp1."Department Category" := FindLevels."Department Category";
                                DepartmentTemp1."Department Idenity" := FindLevels."Department Idenity";
                                FindDep.RESET;
                                FindDep.SETFILTER(Description, '%1', Rec."Belongs to Group");
                                IF FindDep.FINDFIRST THEN BEGIN
                                    DepartmentTemp1."Group Code" := FindDep.Code;
                                    DepartmentTemp1."Department Group identity" := FindDep.Identity;
                                    DepartmentTemp1."Team Code" := Rec.Code;
                                    "Group Identity" := FindDep.Identity;
                                    DepartmentTemp1."Department Team identity" := Rec.Identity;
                                END;


                                DepartmentTemp1.MODIFY;
                            END;
                        END;
                    end;
                }
                field(Name; Name)
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin






                        OsPreparation.RESET;
                        OsPreparation.SETFILTER(Status, '%1', 2);
                        IF OsPreparation.FINDLAST THEN BEGIN
                            "Org Shema" := OsPreparation.Code;
                        END
                        ELSE BEGIN
                            "Org Shema" := '';
                        END;
                        "Department Type" := 9;
                        IF Code <> '' THEN BEGIN
                            IF Name = '' THEN BEGIN
                                DepartmentTemp.INIT;
                                DepartmentTemp.VALIDATE(Code, Code);

                                String := Rec.Code;
                                DepartmentTemp.Code := Rec.Code;
                                DepartmentTemp."Team Code" := Rec.Code;
                                // DepartmentTemp."Department Type" := 9;
                                DepartmentTemp.INSERT;
                            END
                            ELSE BEGIN
                                DepartmentTemp.SETFILTER("Team Code", '%1', xRec.Code);
                                DepartmentTemp.SETFILTER("Department Type", '%1', 9);
                                IF DepartmentTemp.FINDFIRST THEN BEGIN
                                    IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", DepartmentTemp."Team Description", DepartmentTemp."Department Categ.  Description", DepartmentTemp."Group Description", DepartmentTemp.Description) THEN
                                        DepartmentTemp1.RENAME(Rec.Code, "Org Shema", Rec.Name, DepartmentTemp."Department Categ.  Description", Rec."Belongs to Group", Rec.Name);
                                    FindLevels.RESET;
                                    FindLevels.SETFILTER("Group Description", '%1', "Belongs to Group");
                                    FindLevels.SETFILTER("Department Type", '%1', 2);
                                    IF FindLevels.FINDFIRST THEN BEGIN
                                        IF DepartmentTemp1.GET(DepartmentTemp.Code, DepartmentTemp."ORG Shema", DepartmentTemp."Team Description", DepartmentTemp."Department Categ.  Description", DepartmentTemp."Group Description", DepartmentTemp.Description) THEN
                                            DepartmentTemp1.RENAME(Rec.Code, "Org Shema", Rec.Name, FindLevels."Department Categ.  Description", Rec."Belongs to Group", Rec.Name);
                                    END;
                                END;

                                DepartmentTemp1.Sector := FindLevels.Sector;
                                DepartmentTemp1."Sector  Description" := FindLevels."Sector  Description";
                                DepartmentTemp1."Sector Identity" := FindLevels."Sector Identity";
                                DepartmentTemp1."Department Category" := FindLevels."Department Category";
                                DepartmentTemp1."Department Idenity" := FindLevels."Department Idenity";
                                DepartmentTemp1."Team Code" := Rec.Code;
                                DepartmentTemp1."Department Team identity" := Rec.Identity;

                                FindDep.RESET;
                                FindDep.SETFILTER(Description, '%1', Rec."Belongs to Group");
                                IF FindDep.FINDFIRST THEN BEGIN
                                    DepartmentTemp1."Group Code" := FindDep.Code;
                                    DepartmentTemp1."Department Group identity" := FindDep.Identity;
                                    "Group Identity" := FindDep.Identity;
                                END;


                                DepartmentTemp1.MODIFY;
                            END;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field("Official Translate of Team"; "Official Translate of Team")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Belongs to Group"; "Belongs to Group")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin




                        DepartmentRename.RESET;
                        DepartmentRename.SETFILTER("Department Type", '%1', 9);
                        DepartmentRename.SETFILTER("Team Code", '%1', Rec.Code);
                        DepartmentRename.SETFILTER("Team Description", '%1', Rec.Name);
                        IF DepartmentRename.FINDFIRST THEN BEGIN
                            IF DepartmentRename1.GET(DepartmentRename.Code, DepartmentRename."ORG Shema", DepartmentRename."Team Description", DepartmentRename."Department Categ.  Description", DepartmentRename."Group Description", DepartmentRename.Description)
                              THEN
                                FindLevels.RESET;
                            FindLevels.SETFILTER("Group Description", '%1', Rec."Belongs to Group");
                            FindLevels.SETFILTER("Department Type", '%1', 2);
                            IF FindLevels.FINDFIRST THEN BEGIN
                                DepartmentRename1.RENAME(DepartmentRename.Code, DepartmentRename."ORG Shema", Rec.Name, FindLevels."Department Categ.  Description", Rec."Belongs to Group", DepartmentRename.Description);
                                FindCodeForDep.RESET;
                                FindCodeForDep.SETFILTER(Description, '%1', "Belongs to Group");
                                IF FindCodeForDep.FINDFIRST THEN BEGIN
                                    DepartmentRename1."Group Code" := FindCodeForDep.Code;
                                    DepartmentRename1."Department Group identity" := FindCodeForDep.Identity;
                                    "Group Identity" := FindCodeForDep.Identity;
                                    "Identity Sector" := FindCodeForDep."Identity Sector";
                                END
                                ELSE BEGIN
                                    DepartmentRename1."Group Code" := '';
                                END;
                                DepartmentRename1.Sector := FindLevels.Sector;
                                DepartmentRename1."Sector  Description" := FindLevels."Sector  Description";
                                DepartmentRename1."Sector Identity" := FindLevels."Sector Identity";
                                DepartmentRename1."Department Category" := FindLevels."Department Category";
                                FindDep.RESET;
                                FindDep.SETFILTER(Description, '%1', Rec."Belongs to Group");
                                IF FindDep.FINDFIRST THEN BEGIN
                                    DepartmentRename1."Group Code" := FindDep.Code;
                                    DepartmentRename1."Department Group identity" := FindDep.Identity;
                                    "Group Identity" := FindDep.Identity;
                                END;
                                //  DepartmentRename1."Department Type" := 9;
                                DepartmentRename1.MODIFY;
                            END;
                        END;
                        "Group Identity" := FindDep.Identity;
                        CurrPage.UPDATE;
                    end;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        IF Code <> '' THEN BEGIN
                            IF Name <> '' THEN BEGIN
                                DepartmentTemp.RESET;
                                DepartmentTemp.SETFILTER("Team Code", '%1', Rec.Code);
                                DepartmentTemp.SETFILTER("Team Description", '%1', Rec.Name);
                                DepartmentTemp.SETFILTER("Department Type", '%1', 9);
                                IF DepartmentTemp.FINDFIRST THEN BEGIN
                                    DepartmentTemp."Residence/Network" := Rec."Residence/Network";
                                    DepartmentTemp.MODIFY;
                                END;

                            END;
                        END;
                    end;
                }
                field("Number of dimension value"; "Number of dimension value")
                {
                    ApplicationArea = all;
                }
                field("Name of TC"; "Name of TC")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Fields for change"; "Fields for change")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Style = Unfavorable;
                    StyleExpr = IsTrue;
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

                    Response := CONFIRM(Txt003);
                    IF Response THEN BEGIN
                        CurrPage.SAVERECORD;
                        InsertSectoR.RESET;
                        InsertSectoR.SETFILTER("Team Code", '<>%1', '');
                        InsertSectoR.SETFILTER("Team Description", '<>%1', '');
                        IF InsertSectoR.FINDSET THEN
                            REPEAT
                                SectorTempIdentity.RESET;
                                SectorTempIdentity.SETFILTER(Code, '%1', InsertSectoR."Team Code");
                                SectorTempIdentity.SETFILTER(Description, '%1', InsertSectoR."Team Description");
                                IF SectorTempIdentity.FINDFIRST THEN BEGIN
                                    InsertSectoR."Department Team identity" := SectorTempIdentity.Identity;

                                END;
                            UNTIL InsertSectoR.NEXT = 0;
                        SectorTemp1.RESET;
                        SectorTemp1.SETFILTER(Code, '<>%1', '');
                        IF SectorTemp1.FINDSET THEN
                            REPEAT
                                ECLSystematization.RESET;
                                ECLSystematization.SETFILTER("Sector Description", '%1', SectorTemp1.Description);
                                ECLSystematization.SETFILTER("Team Description", '<>%1', '');
                                IF ECLSystematization.FINDFIRST THEN
                                    REPEAT
                                        ECLSystematization."Sector Identity" := SectorTemp1.Identity;
                                        ECLSystematization.MODIFY;
                                    UNTIL ECLSystematization.NEXT = 0;
                            UNTIL SectorTemp1.NEXT = 0;

                        SectorCheck.RESET;
                        SectorCheck.SETFILTER("Identity Sector", '%1', Rec."Identity Sector");
                        IF SectorCheck.FINDSET THEN
                            REPEAT
                                SectorCheck.CALCFIELDS("Number of dimension value");
                                IF (SectorCheck."Number of dimension value" = 0) AND (Found1 = FALSE) THEN BEGIN
                                    MESSAGE(Text008);
                                    Found1 := TRUE;
                                END;
                                IF (SectorCheck."Residence/Network" = SectorCheck."Residence/Network"::" ") AND (Found2 = FALSE) THEN BEGIN
                                    MESSAGE(Text009);
                                    Found2 := TRUE;
                                END;
                            UNTIL SectorCheck.NEXT = 0;
                        PositionMenuFindSector.RESET;
                        PositionMenuFindSector.SETFILTER(Code, '<>%1', '');
                        IF PositionMenuFindSector.FINDSET THEN
                            REPEAT
                                StringValue := PositionMenuFindSector.Code;
                                Brojac := 0;
                                FOR i := 1 TO STRLEN(StringValue) DO BEGIN
                                    IF StringValue[i] = '.' THEN BEGIN
                                        Brojac := Brojac + 1;
                                        IF Brojac = 2 THEN BEGIN
                                            SectorPosition := i;
                                            IF StringValue[i - 1] = '0' THEN
                                                SectorPosition := i - 2;
                                        END;
                                    END;
                                END;
                                DimensionsForPos.RESET;
                                DimensionsForPos.SETFILTER("Position Code", '%1', PositionMenuFindSector.Code);
                                IF DimensionsForPos.FINDSET THEN
                                    REPEAT
                                        IF COPYSTR(DimensionsForPos."Position Code", 1, STRLEN(DimensionsForPos.Sector)) <> DimensionsForPos.Sector THEN BEGIN
                                        END
                                        ELSE BEGIN
                                            IF PositionMenuFindSector1.GET(PositionMenuFindSector.Code, PositionMenuFindSector.Description, PositionMenuFindSector."Department Code", PositionMenuFindSector."Org. Structure") THEN BEGIN
                                                FindSectorIdentity.RESET;
                                                FindSectorIdentity.SETFILTER(Code, '%1', COPYSTR(StringValue, 1, SectorPosition));
                                                IF FindSectorIdentity.FINDFIRST THEN BEGIN
                                                    PositionMenuFindSector1."Sector Identity" := FindSectorIdentity.Identity;
                                                    PositionMenuFindSector1.MODIFY;
                                                END
                                                ELSE BEGIN
                                                    PositionMenuFindSector1."Sector Identity" := 0;
                                                    PositionMenuFindSector1.MODIFY;
                                                END;
                                                DimensionForPosCopy.RESET;
                                                DimensionForPosCopy.SETFILTER("Position Code", '%1', PositionMenuFindSector1.Code);
                                                DimensionForPosCopy.SETFILTER("Position Description", '%1', PositionMenuFindSector1.Description);
                                                IF DimensionForPosCopy.FINDSET THEN
                                                    REPEAT
                                                        DimensionForPosCopy."Sector Identity" := PositionMenuFindSector1."Sector Identity";
                                                    UNTIL DimensionForPosCopy.NEXT = 0;

                                            END;
                                        END;
                                    UNTIL DimensionsForPos.NEXT = 0;
                            UNTIL PositionMenuFindSector.NEXT = 0;



                        IF Rec."Identity Sector" = 0 THEN BEGIN
                            ValueSector1 := Rec.GETFILTER("Identity Sector");
                            IF EVALUATE(ValueSector, ValueSector1) THEN
                                StepNextTabela.SETFILTER("Sector Identity", '%1', ValueSector);
                        END
                        ELSE BEGIN
                            StepNextTabela.SETFILTER("Sector Identity", '%1', Rec."Identity Sector");
                        END;
                        StepNext.SETTABLEVIEW(StepNextTabela);
                        StepNext.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
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
                                    IF PosMen2.GET(DimensiontempfoRposition."Position Code", DimensiontempfoRposition."Position Description", PositionMenu."Department Code", Rec."Org Shema") THEN
                                        PosMen2.RENAME(DimensiontempfoRposition."Position Code", DimensiontempfoRposition."Position Description", '', Rec."Org Shema")
   UNTIL PositionMenu.NEXT = 0;

                        UNTIL DimensiontempfoRposition.NEXT = 0;
                    PositionMenu.RESET;
                    IF PositionMenu.FINDSET THEN
                        REPEAT
                            PositionMenu.CALCFIELDS("Number of dimension value");
                            IF PositionMenu."Number of dimension value" > 1 THEN BEGIN
                                IF PosMen2.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure") THEN
                                    PosMen2.RENAME(PositionMenu.Code, PositionMenu.Description, '', PositionMenu."Org. Structure")
                            END;
                        UNTIL PositionMenu.NEXT = 0;
                    PositionMenu.RESET;
                    IF PositionMenu.FINDSET THEN
                        REPEAT
                            PositionMenu.CALCFIELDS("Number of dimension value");
                            IF PositionMenu."Number of dimension value" = 1 THEN BEGIN
                                IF PosMen2.GET(PositionMenu.Code, PositionMenu.Description, PositionMenu."Department Code", PositionMenu."Org. Structure") THEN BEGIN
                                    DimensionsForPos.RESET;
                                    DimensionsForPos.SETFILTER("ORG Shema", '%1', PositionMenu."Org. Structure");
                                    DimensionsForPos.SETFILTER("Position Code", '%1', PositionMenu.Code);
                                    DimensionsForPos.SETFILTER("Position Description", '%1', PositionMenu.Description);
                                    IF DimensionsForPos.FINDFIRST THEN BEGIN
                                        DepartmentTempDelete.RESET;
                                        DepartmentTempDelete.SETFILTER(Description, '%1', DimensionsForPos."Org Belongs");
                                        DepartmentTempDelete.SETFILTER("ORG Shema", '%1', PositionMenu."Org. Structure");
                                        IF DepartmentTempDelete.FINDFIRST THEN
                                            PosMen2.RENAME(PositionMenu.Code, PositionMenu.Description, DepartmentTempDelete.Code, PositionMenu."Org. Structure");
                                    END;
                                END;
                            END;
                        UNTIL PositionMenu.NEXT = 0;

                end;
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
                                PrevoiusTabela.SETFILTER("Identity Sector", '%1', ValueSector);
                        END
                        ELSE BEGIN
                            PrevoiusTabela.SETFILTER("Identity Sector", '%1', Rec."Identity Sector");
                        END;
                        PreviousStep.SETTABLEVIEW(PrevoiusTabela);
                        PreviousStep.RUN;
                        CurrPage.CLOSE();
                        CurrPage.EDITABLE(FALSE);
                    END;
                end;
            }
            action("Change Code for levels below")
            {
                Caption = 'Change Code';
                Image = Change;
                Promoted = true;
                ApplicationArea = all;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin



                    IF NOT DimesnionForReport.ISEMPTY THEN
                        DimesnionForReport.DELETEALL;


                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER(Code, '%1', Rec.Code);
                    DimensionCopy.SETFILTER(Description, '%1', Rec.Name);
                    DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT
                            DimesnionForReport.INIT;
                            DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                            DimesnionForReport.INSERT;
                        UNTIL DimensionCopy.NEXT = 0;
                    COMMIT;
                    TeamTemp.SETFILTER(Code, '%1', Rec.Code);
                    TeamTemp.SETFILTER("Org Shema", '%1', Rec."Org Shema");
                    TeamTemp.SETFILTER(Name, '%1', Rec.Name);
                    IF TeamTemp.FINDFIRST THEN BEGIN


                        Text1 := TextPart1 + ' ' + Rec.Code + ' tim ';
                    END;
                    IF ResponseChange <> CONFIRM(Text1, TRUE) THEN BEGIN

                        //DepartmentChange.SetP(xRec.Code,Rec.Code,Rec."Org Shema",Rec.Description);
                        //       DepartmentChange.SetParam(Rec.Code, Rec.Name, Rec."Residence/Network", 1, Rec."Belongs to Group", Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        //     DepartmentChange.RUN;
                    END
                    ELSE BEGIN
                        //   DepartmentChange.SetParam(Rec.Code, Rec.Name, Rec."Residence/Network", 2, Rec."Belongs to Group", Rec."Org Shema");
                        //DepartmentChange.SetParam(Rec.Code);
                        // DepartmentChange.RUN;
                    END;
                end;
            }
            action("Insert team")
            {
                Caption = 'Insert Team';
                Image = Change;
                Promoted = true;
                ApplicationArea = all;
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
                        //       NewReport.SetParam('', '', 0, FilterC, '');
                        //     NewReport.RUN;

                        EXIT;
                    END;
                end;
            }
            action("Copy Team")
            {
                Caption = 'Copy Tim';
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
                        DimensionCopy.SETFILTER(Description, '%1', Rec.Name);
                        DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
                        IF DimensionCopy.FINDSET THEN
                            REPEAT
                                DimesnionForReport.INIT;
                                DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                                DimesnionForReport.INSERT;
                            UNTIL DimensionCopy.NEXT = 0;
                        COMMIT;

                        //        ForCopyReport.SetParam(Rec.Code, Rec.Name, Rec."Residence/Network", Rec."Org Shema", Rec."Belongs to Group");
                        //      ForCopyReport.RUN;
                        EXIT;
                    END;
                end;
            }
            group("Dimension temporary1")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = true;
                action("Dimension temporary2")
                {
                    Caption = 'Dimension temporary';
                    ApplicationArea = all;
                    RunObject = Page "Dimensions temporary";
                    RunPageLink = "Team Description" = FIELD(Name),
                                  // "Department Type" = CONST(Team),
                                  "ORG Shema" = FIELD("Org Shema");
                    Visible = false;
                }
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin

        IF Potvrda <> CONFIRM(Text007, TRUE) THEN BEGIN
            DepartmentTempDelete.SETFILTER("Team Code", '%1', Rec.Code);
            DepartmentTempDelete.SETFILTER("Team Description", '%1', Rec.Name);
            DepartmentTempDelete.SETFILTER("Department Type", '<>%1', 9);
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
            DepartmentTemp.RESET;
            DepartmentTemp.SETFILTER(Code, '%1', Rec.Code);
            DepartmentTemp.SETFILTER(Description, '%1', Rec.Name);
            DepartmentTemp.SETFILTER("Department Type", '%1', 9);
            IF DepartmentTemp.FINDFIRST THEN BEGIN
                DepartmentTemp.DELETE;
            END;
            DimensionsForPos.SETFILTER("Team Code", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Team Description", '%1', Rec.Name);
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
            SecYes.SETFILTER(Name, '%1', Rec.Name);
            IF SecYes.FINDFIRST THEN BEGIN
                SecYes.DELETE;
            END;
            DepOrginalDelete.RESET;
            DepOrginalDelete.SETFILTER("Team Code", '%1', Rec.Code);
            DepOrginalDelete.SETFILTER("Team Description", '%1', Rec.Name);
            DepOrginalDelete.SETFILTER("Department Type", '%1', 9);
            IF DepOrginalDelete.FINDFIRST THEN BEGIN
                DepOrginalDelete.DELETE;
            END;
            DimensipnTemp.SETFILTER("Team Code", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Team Description", '%1', Rec.Name);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensipnTemp.FINDSET THEN
                REPEAT
                    DimensipnTemp.DELETE;
                UNTIL DimensipnTemp.NEXT = 0;



            ECLSystematization.RESET;
            ECLSystematization.SETFILTER("Team Description", '%1', Rec.Name);
            IF ECLSystematization.FINDSET THEN
                REPEAT

                    ECLSystematization.VALIDATE("Org Belongs", '');


                    ECLSystematization.MODIFY;
                UNTIL ECLSystematization.NEXT = 0;




        END


        ELSE BEGIN
            DepartmentTempDelete.SETFILTER("Team Code", '%1', Rec.Code); //BRIŠE 1 STAVKU GRUPE
            DepartmentTempDelete.SETFILTER("Team Description", '%1', Rec.Name);
            DepartmentTempDelete.SETFILTER("Department Type", '%1', 9);
            IF DepartmentTempDelete.FINDFIRST THEN BEGIN
                DepartmentTempDelete.DELETE;
            END;

            DimensionsTempFor.SETFILTER("Team Code", '%1', Rec.Code); //BRIŠE PRVU STAVKU U TROŠKOVNIM CENTRIMA
            DimensionsTempFor.SETFILTER("Team Description", '%1', Rec.Name);
            DimensionsTempFor.SETFILTER("Department Type", '%1', 9);
            DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
            IF DimensionsTempFor.FINDFIRST THEN BEGIN
                DimensionsTempFor.DELETE;
            END;


            DepartmentTempDelete2.RESET;
            DepartmentTempDelete2.SETFILTER("Team Code", '%1', Rec.Code);
            DepartmentTempDelete2.SETFILTER("Team Description", '%1', Rec.Name);
            DepartmentTempDelete2.SETFILTER("Department Type", '<>%1', 9);
            IF DepartmentTempDelete2.FINDSET THEN
                REPEAT
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Name, '<>%1', Rec.Name);
                    IF Sectortemptable.FINDFIRST THEN BEGIN
                        IF DepartmentTempDelete2.GET(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", DepartmentTempDelete2."Team Description",
                        DepartmentTempDelete2."Department Categ.  Description", DepartmentTempDelete2."Group Description", DepartmentTempDelete2.Description) THEN
                            DepartmentTempDelete2.RENAME(DepartmentTempDelete2.Code, DepartmentTempDelete2."ORG Shema", Sectortemptable.Name,
                            DepartmentTempDelete2."Department Categ.  Description", DepartmentTempDelete2."Group Description", DepartmentTempDelete2.Description);
                        DepartmentTempDelete2."Department Team identity" := Sectortemptable.Identity;
                        DimensionsTempFor.RESET;
                        DimensionsTempFor.SETFILTER("Team Code", '%1', DepartmentTempDelete2."Team Code");
                        DimensionsTempFor.SETFILTER("Team Description", '%1', Rec.Name);
                        DimensionsTempFor.SETFILTER("Department Type", '<>%1', 2);
                        DimensionsTempFor.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF DimensionsTempFor.FINDSET THEN
                            REPEAT
                                IF DimensionsTempFor.GET(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", DimensionsTempFor."Team Description",
                                DimensionsTempFor."Department Categ.  Description", DimensionsTempFor."Group Description", DimensionsTempFor."Group Code", DimensionsTempFor."ORG Shema") THEN
                                    DimensionsTempFor.RENAME(DimensionsTempFor.Code, DimensionsTempFor."Dimension Value Code", Sectortemptable.Name,
                                    DimensionsTempFor."Department Categ.  Description", DimensionsTempFor."Group Description", DimensionsTempFor."Group Code", DimensionsTempFor."ORG Shema");
                                DimensionsTempFor.Belongs := DimensionsTempFor.Code + '-' + Sectortemptable.Name;




                            UNTIL DimensionsTempFor.NEXT = 0;


                        DepartmentTempDelete2.MODIFY;
                    END;
                UNTIL DepartmentTempDelete2.NEXT = 0;


            DimensionsForPos.RESET;
            DimensionsForPos.SETFILTER("Team Code", '%1', Rec.Code);
            DimensionsForPos.SETFILTER("Team Description", '%1', Rec.Name);
            IF DimensionsForPos.FINDSET THEN
                REPEAT
                    Sectortemptable.RESET;
                    Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                    Sectortemptable.SETFILTER(Name, '<>%1', Rec.Name);
                    IF Sectortemptable.FINDFIRST THEN BEGIN

                        FindTC.RESET;
                        FindTC.SETFILTER("Department Categ.  Description", '%1', Sectortemptable.Description);
                        FindTC.SETFILTER("Department Type", '%1', 4);
                        IF FindTC.FINDFIRST THEN BEGIN
                            IF DimensionForPosition.GET(DimensionsForPos."Position Code", DimensionsForPos."Dimension Value Code", Rec."Org Shema", DimensionsForPos."Position Description") THEN BEGIN
                                DimensionForPosition.RENAME(DimensionsForPos."Position Code", FindTC."Dimension Value Code", Rec."Org Shema", DimensionsForPos."Position Description");
                                //DimensionsForPos."Team Description":=Sectortemptable.Name;
                                DimensionForPosition."Dimension  Name" := FindTC."Dimension  Name";
                                DimensionForPosition."Team Description" := Sectortemptable.Name;
                                DimensionForPosition.MODIFY;
                            END;

                            //Position Code,Dimension Value Code,ORG Shema,Position Description
                        END;
                    END;


                    DimensionTempPos.RESET;
                    DimensionTempPos.SETFILTER("Team Description", '%1', Rec.Name);
                    IF DimensionTempPos.FINDSET THEN
                        REPEAT
                            Sectortemptable.RESET;
                            Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                            Sectortemptable.SETFILTER(Name, '<>%1', Rec.Name);
                            IF Sectortemptable.FINDFIRST THEN BEGIN
                                IF DimensionTempPos1.GET(DimensionTempPos."Position Code", DimensionTempPos."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", DimensionTempPos."Org Belongs") THEN BEGIN
                                    DimensionTempPos2.RESET;
                                    DimensionTempPos2.SETFILTER("Team Description", '%1', Rec.Name);
                                    IF DimensionTempPos2.FINDFIRST THEN BEGIN
                                        DimensionTempPos1.RENAME(DimensionTempPos."Position Code", DimensionTempPos2."Dimension Value Code", DimensionTempPos."ORG Shema", DimensionTempPos."Position Description", Sectortemptable.Name);
                                        DimensionTempPos1."Dimension  Name" := DimensionTempPos2."Dimension  Name";
                                        DimensionTempPos1."Team Description" := Sectortemptable.Name;
                                        DimensionTempPos1.MODIFY;
                                    END;
                                END;
                            END;
                        //Position Code,Dimension Value Code,ORG Shema,Position Description,Org Belongs
                        UNTIL DimensionTempPos.NEXT = 0;



                    HeadOf.RESET;

                    HeadOf.SETFILTER("Team Code", '%1', Code);
                    HeadOf.SETFILTER("Team Description", '%1', Name);
                    IF HeadOf.FINDFIRST THEN BEGIN
                        HeadOf.DELETE;
                    END;
                    HeadOf1.RESET;
                    HeadOf1.SETFILTER("Team Code", '%1', Rec.Code);
                    HeadOf.SETFILTER("Team Description", '%1', Rec.Name);
                    IF HeadOf1.FINDSET THEN
                        REPEAT
                            Sectortemptable.RESET;
                            Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                            Sectortemptable.SETFILTER(Description, '<>%1', Rec.Name);
                            IF Sectortemptable.FINDFIRST THEN BEGIN
                                Change := Sectortemptable.Name;
                            END;

                            IF HeadChange.GET(HeadOf1."Department Code", HeadOf1."ORG Shema", HeadOf1."Department Categ.  Description", HeadOf1."Group Description", HeadOf1."Team Description") THEN BEGIN
                                IF NOT HeadChange.GET(HeadOf1."Department Code", Rec."Org Shema", HeadOf1."Department Categ.  Description", HeadOf1."Group Description", Sectortemptable.Description) THEN BEGIN
                                    HeadChange.RENAME(HeadOf1."Department Code", Rec."Org Shema", HeadOf1."Department Categ.  Description", HeadOf1."Group Description", Sectortemptable.Description)
                                END
                                ELSE BEGIN
                                    HeadChange.DELETE;
                                END;
                                //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description

                            END;
                        UNTIL HeadOf1.NEXT = 0;
                    ECLSystematization.RESET;
                    ECLSystematization.SETFILTER("Team Description", '%1', Rec.Name);
                    IF ECLSystematization.FINDSET THEN
                        REPEAT
                            Sectortemptable.RESET;
                            Sectortemptable.SETFILTER(Code, '%1', Rec.Code);
                            Sectortemptable.SETFILTER(Name, '<>%1', Rec.Name);
                            IF Sectortemptable.FINDFIRST THEN
                                NewTeam := Sectortemptable.Name;

                            IF ECLSystematization."Team Description" <> '' THEN BEGIN

                                DepartmentValue.RESET;
                                DepartmentValue.SETFILTER("Team Description", '%1', NewTeam);
                                DepartmentValue.SETFILTER("Department Type", '%1', 9);
                                IF DepartmentValue.FINDFIRST THEN BEGIN
                                    ECLSystematization.VALIDATE("Org Belongs", NewTeam);
                                END
                                ELSE BEGIN
                                    ECLSystematization.VALIDATE("Org Belongs", '');
                                END;
                            END;


                            ECLSystematization.MODIFY;
                        UNTIL ECLSystematization.NEXT = 0;




                    DimensionsForPos1.RESET;
                    DimensionsForPos1.SETFILTER("Position Code", '%1', DimensionsForPos."Position Code");
                    DimensionsForPos1.SETFILTER("Position Description", '%1', DimensionsForPos."Position Description");
                    IF DimensionsForPos1.FINDSET THEN
                        REPEAT
                            DimensionsForPos2.SETFILTER("Position Code", '%1', DimensionsForPos1."Position Code");
                            DimensionsForPos2.SETFILTER("Position Description", '%1', DimensionsForPos1."Position Description");
                            IF DimensionsForPos2.FINDFIRST THEN BEGIN
                                IF DimensionsForPos2.GET(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", DimensionsForPos2."ORG Shema", DimensionsForPos2."Position Description", DimensionsForPos2."Org Belongs") THEN
                                    DimensionsForPos2.RENAME(DimensionsForPos2."Position Code", DimensionsForPos2."Dimension Value Code", DimensionsForPos2."ORG Shema", DimensionsForPos2."Position Description", Sectortemptable.Description);
                            END;
                        UNTIL DimensionsForPos1.NEXT = 0;
                UNTIL DimensionsForPos.NEXT = 0;


            DimensipnTemp.SETFILTER("Team Code", '%1', Rec.Code);
            DimensipnTemp.SETFILTER("Team Description", '%1', Rec.Name);
            DimensipnTemp.SETFILTER("ORG Shema", '%1', Rec."Org Shema");
            DimensipnTemp.SETFILTER("Department Type", '%1', 9);
            IF DimensipnTemp.FINDFIRST THEN BEGIN
                DimensipnTemp.DELETE;
            END;

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
        IsEditable := TRUE;
    end;

    trigger OnOpenPage()
    begin
      
        //CurrPage.EDITABLE(FALSE);
        IsEditable := FALSE;


    end;

    var
        Pos: Record "Position";
        HRsetup: Record "Human Resources Setup";
        Response: Boolean;
        StepNext: Page "Position menu temp";
        PreviousStep: Page "Group temporary sist";
        Text1: Text;
        ResponseChange: Boolean;
        TeamTemp: Record "TeamT";
        //    DepartmentChange: Report "Department Temporary TEAM";
        TextPart1: Label 'Do you want to change all level below';
        Text007: Label 'Do you want to delete  all level below';
        Potvrda: Boolean;
        DepartmentTempDelete: Record "Department temporary";
        Position: Record "Position temporery";
        DimensionNewPage: Page "Dimensions temporary";
        PrevoiusTabela: Record "Group temporary";
        SecYes: Record "Team temporary";
        DepartmentTempDelete2: Record "Department temporary";
        Sectortemptable: Record "Team temporary";
        PositionTempor: Record "Position temporery";
        IsEditable: Boolean;
        SectorInsertModify: Record "Team temporary";
        InsertSectoR: Record "Department temporary";
        SectorTempIdentity: Record "Team temporary";
        DepOrginalDelete: Record "Department temporary";
        DimensionsTempFor: Record "Dimension temporary";
        DepCatDelete2: Record "Team temporary";
        DepartmentTempDeletefOR: Record "Department temporary";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        Text008: Label 'You are forgot to insert dimension value';
        Text009: Label 'You are forgot to insert is this sector Residence/Network';
        SectorCheck: Record "Team temporary";
        Found1: Boolean;
        Found2: Boolean;
        DimensionsForPos: Record "Dimension temp for position";
        PositionMenu: Record "Position Menu temporary";
        StepNextTabela: Record "Position Menu temporary";
        FilterSector: Record "Sector temporary";
        PositionMenuFindSector: Record "Position Menu temporary";
        Brojac: Integer;
        StringValue: Code[30];
        i: Integer;
        SectorPosition: Integer;
        FindSectorIdentity: Record "Sector temporary";
        PositionMenuFindSector1: Record "Position Menu temporary";
        DimensionForPosCopy: Record "Dimension temp for position";
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
        DimensionCorect: Record "Dimension temporary";
        DepCatCode: Record "Team temporary";
        GroupCheck: Record "Group temporary";
        SectorCode: Record "Sector temporary";
        DimensionCorrect1: Record "Dimension temporary";
        FindTC: Record "Department temporary";
        DimensionForPosition: Record "Dimension temp for position";
        DimensionsForPos2: Record "Dimension temp for position";
        DimensionsForPos1: Record "Dimension temp for position";
        Dep: Record "Department temporary";
        DimensionNew: Record "Dimension temporary";
        DepartmentRename: Record "Department temporary";
        DepartmentRename1: Record "Department temporary";
        FindCodeForDep: Record "Group temporary";
        OsPreparation: Record "ORG Shema";
        DepartmentTemp: Record "Department temporary";
        FindHighLevel: Record "Department temporary";
        DepartmentTempNewW: Record "Department temporary";
        SectorFind: Record "Sector temporary";
        String: Text;
        LengthString: Integer;
        SectorFind1: Integer;
        NewDescription: Text;
        TheLastCharacter: Integer;
        CheckPoint: Text;
        TheSame: Integer;
        NewCode: Text;
        DepartmentTemp1: Record "Department temporary";
        DepartmentTempNewW1: Record "Department temporary";
        FindLevels: Record "Department temporary";
        FindDep: Record "Group temporary";
        CodeDifferent: Integer;
        Conditional: Code[20];
        TeamLength: Integer;
        GroupLength: Integer;
        RealLength: Integer;
        GroupFilter: Record "Group temporary";
        SectorCheckLength: Record "Group temporary";
        SectorLength: Integer;
        TeamTempInt: Record "Team temporary";
        DepTemDelete: Record "Department temporary";
        Text002: Label 'FA';
        Responsenew: Boolean;
        Text6: Label 'Do you want to insert a new team';
        DimesnionForReport: Record "Dimension for report";
        DimensionCopy: Record "Dimension temporary";
        FilterC: Code[10];
        //    NewReport: Report "Department team New";
        ValueSector1: Text;
        ValueSector: Integer;
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        DimensiontempfoRposition: Record "Dimension temp for position";
        PosM: Record "Position Menu temporary";
        ECLSystematization: Record "ECL systematization";
        HeadOf: Record "Head Of's temporary";
        HeadOf1: Record "Head Of's temporary";
        Change: Text;
        HeadChange: Record "Head Of's temporary";
        DimensionTempPos: Record "Dimension temp for position";
        DimensionTempPos1: Record "Dimension temp for position";
        DimensionTempPos2: Record "Dimension temp for position";
        Text7: Label 'Do you want to copy a new team';
        //   ForCopyReport: Report "Department team New";
        SectorTemp1: Record "Sector temporary";
        NewTeam: Text;
        DepartmentValue: Record "Department temporary";
        PosMen2: Record "Position Menu temporary";
        PositionMenu5: Record "Position Menu temporary";
}

*/