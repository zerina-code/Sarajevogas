page 50089 "Position menu temp"
{
    Caption = 'Position menu temp';
    PageType = List;
    SourceTable = "Position Menu temporary";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = all;


                    trigger OnValidate()
                    begin
                        OsPreparation.RESET;
                        OsPreparation.SETFILTER(Status, '%1', 2);
                        IF OsPreparation.FINDLAST THEN BEGIN
                            "Org. Structure" := OsPreparation.Code;
                        END
                        ELSE BEGIN
                            "Org. Structure" := '';
                        END;
                        FOR i := 1 TO STRLEN(Rec.Code) DO BEGIN
                            String := Rec.Code;
                            IF String[i] = '.' THEN BEGIN
                                brojac := brojac + 1;
                                IF brojac = 2 THEN
                                    SectorLength := i;
                            END;
                        END;
                        SectorFind.RESET;
                        SectorFind.SETFILTER(Code, '%1', COPYSTR(Rec.Code, 1, SectorLength));
                        IF SectorFind.FINDFIRST THEN BEGIN
                            Rec."Sector Identity" := SectorFind.Identity;
                        END;
                        CurrPage.UPDATE;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;

                }

                field("Official Translation"; "Official Translation")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                /*   field("Role Name"; "Role Name")
                   {
                       ApplicationArea = all;
                       Editable = false;
                       Visible = false;
                   }*/
                field(Role; Role)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("BJF/GJF"; "BJF/GJF")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }


                field("Management Level"; "Management Level")
                {
                    ApplicationArea = all;

                }
                field("Key Function"; "Key Function")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Control Function"; "Control Function")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field(Grade; Grade)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }

                field("Number of benefits"; "Number of benefits")
                {
                    ApplicationArea = all;
                }
                field("Number of dimension value"; "Number of dimension value")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Org. Structure"; "Org. Structure")
                {
                    ApplicationArea = all;
                }
                field(School; School)
                {
                    ApplicationArea = all;
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        UpdatePostTable.RESET;
                        UpdatePostTable.SETFILTER("Position Code", Rec.Code);
                        UpdatePostTable.SETFILTER("Position Name", Description);
                        UpdatePostTable.SETFILTER("Org Shema", rec."Org. Structure");
                        UpdatePositionPage.SETTABLEVIEW(UpdatePostTable);
                        UpdatePositionPage.RUN;
                        CurrPage.UPDATE;

                    end;

                }
                field("Position complexity"; "Position complexity")
                {
                    ApplicationArea = all;
                }
                field("Position Responsibility"; "Position Responsibility")
                {
                    ApplicationArea = all;
                }
                field("Workplace conditions"; "Workplace conditions")
                {
                    ApplicationArea = all;
                }
                field("Position Coefficient for Wage"; "Position Coefficient for Wage")
                {
                    ApplicationArea = all;
                    // Editable = false;
                }
                field("Position Coefficient Director"; "Position Coefficient Director")
                {
                    ApplicationArea = all;

                }

                field("Fields for change"; "Fields for change")
                {
                    ApplicationArea = all;
                    Editable = false;

                    ShowCaption = false;
                    Style = Unfavorable;
                    StyleExpr = TRUE;
                    Visible = false;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            /*  action("Position benefits")
              {
                  Caption = 'Dimensions temporary';
                  RunObject = Page "Position Benefits temp";
                  RunPageLink = "Position Code" = FIELD(Code),
                                "Position Name" = FIELD(Description);

                  RunPageOnRec = false;
                  Visible = false;
              }*/
            action("Exe Manager List")
            {
                Caption = 'Exe Manager List';
                Image = ListPage;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Exe Manager List temporery";
                RunPageLink = "ORG Shema" = field("Org. Structure");
                //RunPageLink = "ORG Shema" = field("ORG Shema");


            }



            /*     action("Position TC")
                 {
                     Caption = 'Dimensions temporary';
                     RunObject = Page "Dimensions temp for positions";
                     RunPageLink = "Position Code" = FIELD(Code),
                                   "Position Description" = FIELD(Description);
                     RunPageOnRec = false;
                     Visible = false;
                 }*/
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Next step';


                trigger OnAction()
                begin


                    //CurrPage.SAVERECORD;

                    /*
                      PositionMenuFind.RESET;
                      PositionMenuFind.SETFILTER("Management Level",'<>%1',PositionMenuFind."Management Level"::E);
                      IF PositionMenuFind.FINDSET THEN REPEAT
                      DimensionCopy.RESET;
                      DimensionCopy.SETFILTER("Position Code",'%1',PositionMenuFind.Code);
                      DimensionCopy.SETFILTER("Position Description",'%1',PositionMenuFind.Description);
                      IF DimensionCopy.FINDSET THEN REPEAT
                      IF PositionMenuFind."Management Level"<>0 THEN BEGIN
                        HeadCheck."Department Code":='';
                        HeadCheck.Sector:='';
                        HeadCheck."Sector  Description":='';
                        HeadCheck."Department Category":='';
                        HeadCheck."Department Categ.  Description":='';
                        HeadCheck."Group Code":='';
                        HeadCheck."Group Description":='';
                        HeadCheck."Team Code":='';
                        HeadCheck."Team Description":='';
                      HeadCheck.RESET;
                      HeadCheck.SETFILTER("Sector  Description",'%1',DimensionCopy."Sector  Description");
                      HeadCheck.SETFILTER("Department Categ.  Description",'%1',DimensionCopy."Department Categ.  Description");
                      HeadCheck.SETFILTER("Department Category",'%1',DimensionCopy."Department Category");
                      HeadCheck.SETFILTER("Group Description",'%1',DimensionCopy."Group Description");
                      HeadCheck.SETFILTER("Team Description",'%1',DimensionCopy."Team Description");
                      HeadCheck.SETFILTER("ORG Shema",'%1',DimensionCopy."ORG Shema");
                    // HeadCheck.SETFILTER("Management Level",'%1',PositionMenuFind."Management Level");
                    // HeadCheck.SETFILTER("Position Code",'%1',PositionMenuFind.Code);
                      IF NOT HeadCheck.FIND('-') THEN BEGIN

                    //IF (PositionMenuFind."Management Level"<> PositionMenuFind."Management Level"::B4 ) AND ( DimensionCopy."Team Description"<>'') THEN BEGIN
                    IF (PositionMenuFind."Management Level"<> PositionMenuFind."Management Level"::B4)  THEN BEGIN
                      IF  DimensionCopy."Team Description"='' THEN BEGIN
                      HeadOfDelete.INIT;
                      HeadOfDelete.Sector:=DimensionCopy.Sector;
                      HeadOfDelete."Sector  Description":=DimensionCopy."Sector  Description";
                      HeadOfDelete."Department Category":=DimensionCopy."Department Category";
                      HeadOfDelete."Department Categ.  Description":=DimensionCopy."Department Categ.  Description";
                      HeadOfDelete."Group Code":=DimensionCopy."Group Code";
                      HeadOfDelete."Group Description":=DimensionCopy."Group Description";
                      HeadOfDelete."Team Code":=DimensionCopy."Team Code";
                      HeadOfDelete."Team Description":=DimensionCopy."Team Description";
                      IF HeadOfDelete."Team Description"<>'' THEN
                        HeadOfDelete."Department Code":=DimensionCopy."Team Code";
                      IF (HeadOfDelete."Group Description"<>'') AND (HeadOfDelete."Team Description"='') THEN
                        HeadOfDelete."Department Code":=DimensionCopy."Group Code";
                        IF (HeadOfDelete."Department Categ.  Description"<>'') AND (HeadOfDelete."Group Description"='') THEN
                        HeadOfDelete."Department Code":=DimensionCopy."Department Category";
                          IF (HeadOfDelete."Department Categ.  Description"='') AND (HeadOfDelete."Sector  Description"<>'') THEN
                        HeadOfDelete."Department Code":=DimensionCopy.Sector;
                      HeadOfDelete."Position Code":=PositionMenuFind.Code;
                      HeadOfDelete."ORG Shema":=DimensionCopy."ORG Shema";
                      HeadOfDelete."Management Level":=PositionMenuFind."Management Level";
                      HeadOfDelete.INSERT;
                       END;
                       END;
                      END
                      ELSE BEGIN
                      IF HeadCheck."Position Code"<>DimensionCopy."Position Code" THEN BEGIN
                      HeadCheck."Position Code":=DimensionCopy."Position Code";
                      IF HeadCheck."Team Description"<>'' THEN BEGIN
                        IF HeadCheck."Department Code"<>HeadCheck."Team Code" THEN
                          HeadCheck.RENAME(HeadCheck."Team Code",HeadCheck."ORG Shema",HeadCheck."Department Categ.  Description",HeadCheck."Group Description",HeadCheck."Team Description");
                        END;
                        IF (HeadCheck."Team Description"='') AND (HeadCheck."Group Description"<>'')THEN BEGIN
                        IF HeadCheck."Department Code"<>HeadCheck."Team Code" THEN
                          HeadCheck.RENAME(HeadCheck."Group Code",HeadCheck."ORG Shema",HeadCheck."Department Categ.  Description",HeadCheck."Group Description",HeadCheck."Team Description");
                        END;
                            IF (HeadCheck."Group Description"='') AND (HeadCheck."Department Categ.  Description"<>'')THEN BEGIN
                        IF HeadCheck."Department Code"<>HeadCheck."Team Code" THEN
                          HeadCheck.RENAME(HeadCheck."Department Category",HeadCheck."ORG Shema",HeadCheck."Department Categ.  Description",HeadCheck."Group Description",HeadCheck."Team Description");
                        END;
                            IF (HeadCheck."Department Categ.  Description"='') AND (HeadCheck.Sector<>'')THEN BEGIN
                        IF HeadCheck."Department Code"<>HeadCheck."Team Code" THEN
                          HeadCheck.RENAME(HeadCheck.Sector,HeadCheck."ORG Shema",HeadCheck."Department Categ.  Description",HeadCheck."Group Description",HeadCheck."Team Description");
                        END;
                          //Department Code,ORG Shema,Department Categ.  Description,Group Description,Team Description

                      HeadCheck.MODIFY;
                        END;
                         END;
                           END;
                            UNTIL DimensionCopy.NEXT=0;
                         UNTIL PositionMenuFind.NEXT=0;*/
                    /*  HeadCheck.DELETEALL;
                      COMMIT;
                      //ĐK Report958.RUN;
                      COMMIT;*/
                    Eclsystematization.RESET;
                    IF Eclsystematization.FINDSET THEN
                        REPEAT
                            IF Eclsystematization."Position Description" <> '' THEN BEGIN
                                TroskovniCentri.RESET;
                                TroskovniCentri.SETFILTER("Position Description", '%1', Eclsystematization."Position Description");
                                TroskovniCentri.SETFILTER("Org Belongs", '%1', Eclsystematization."Org Belongs");
                                IF TroskovniCentri.FINDFIRST THEN BEGIN
                                    PositionMenuCorrect.RESET;
                                    PositionMenuCorrect.SETFILTER(Description, '%1', Eclsystematization."Position Description");
                                    PositionMenuCorrect.SETFILTER(Code, '%1', TroskovniCentri."Position Code");
                                    IF PositionMenuCorrect.FINDFIRST THEN BEGIN
                                        Eclsystematization."Position Code" := PositionMenuCorrect.Code;
                                        Eclsystematization.MODIFY;
                                    END;
                                END;
                            END;
                        UNTIL Eclsystematization.NEXT = 0;
                    /*  Eclsystematization.RESET;
              IF Eclsystematization.FINDSET THEN REPEAT
                IF Eclsystematization."Sector Description"='' THEN BEGIN
                //  Eclsystematization."Changing Position":=TRUE;
                  Eclsystematization.MODIFY;
                   END;
                UNTIL  Eclsystematization.NEXT=0;*/
                    OrgDiff.RESET;


                    OrgDiff.RESET;
                    OrgDiff.SETFILTER("Org Belongs", '<>%1', '');
                    OrgDiff.SETFILTER("Position Description", '<>%1', '');
                    IF OrgDiff.FINDSET THEN
                        REPEAT
                            DimensionTempForPosDiff.RESET;
                            DimensionTempForPosDiff.SETFILTER("Org Belongs", '%1', OrgDiff."Org Belongs");
                            DimensionTempForPosDiff.SETFILTER("Position Description", '%1', OrgDiff."Position Description");
                            DimensionTempForPosDiff.SETFILTER("Position Code", '%1', OrgDiff."Position Code");
                            IF DimensionTempForPosDiff.FINDFIRST THEN
                                OrgDiff."Difference Org/Position" := FALSE
                            ELSE
                                OrgDiff."Difference Org/Position" := TRUE;

                            OrgDiff.MODIFY;
                        UNTIL OrgDiff.NEXT = 0;

                    HeadCheck.RESET;
                    IF HeadCheck.FINDSET THEN
                        REPEAT
                            IF HeadCheck."ORG Shema" = '' THEN
                                HeadCheck.DELETE;
                        UNTIL HeadCheck.NEXT = 0;
                    StepNext.RUN;
                    CurrPage.CLOSE();

                END;


            }
            action(Previous)
            {
                Image = PreviousSet;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Previous step';

                trigger OnAction()
                begin


                    IF Rec."Sector Identity" = 0 THEN BEGIN
                        ValueSector1 := Rec.GETFILTER("Sector Identity");
                        IF EVALUATE(ValueSector, ValueSector1) THEN
                            PrevoiusTabela.SETFILTER("Identity Sector", '%1', ValueSector);
                    END
                    ELSE BEGIN
                        PrevoiusTabela.SETFILTER("Identity Sector", '%1', Rec."Sector Identity");
                    END;
                    /*PrevoiusTabela.SETFILTER(Identity,'%1',"Group Identity");
                      PreviousStep.SETTABLEVIEW(PrevoiusTabela);*/
                    //  PreviousStep.SETTABLEVIEW(PrevoiusTabela);
                    //ĐK    PreviousStep.RUN;
                    CurrPage.CLOSE();

                END;


            }
            action("Change Code for levels below")
            {
                Caption = 'Change Code';
                Image = Change;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF NOT DimesnionForReport.ISEMPTY THEN
                        DimesnionForReport.DELETEALL;
                    DimensionCopy.RESET;
                    DimensionCopy.SETFILTER("Position Code", '%1', Rec.Code);
                    DimensionCopy.SETFILTER("Position Description", '%1', Rec.Description);
                    DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                    IF DimensionCopy.FINDSET THEN
                        REPEAT
                            DimesnionForReport.INIT;
                            DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                            DimesnionForReport.INSERT;
                        UNTIL DimensionCopy.NEXT = 0;
                    COMMIT;

                    IF NOT BenefitsReport.ISEMPTY THEN
                        BenefitsReport.DELETEALL;
                    BenefitsOrginal.RESET;
                    BenefitsOrginal.SETFILTER("Position Code", '%1', Rec.Code);
                    BenefitsOrginal.SETFILTER("Position Name", '%1', Rec.Description);
                    BenefitsOrginal.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                    IF BenefitsOrginal.FINDSET THEN
                        REPEAT
                            BenefitsReport.INIT;
                            BenefitsReport.TRANSFERFIELDS(BenefitsOrginal);
                            BenefitsReport.INSERT;
                        UNTIL BenefitsOrginal.NEXT = 0;
                    COMMIT;

                    IF ResponseChange <> CONFIRM(Text1, TRUE) THEN BEGIN
                        //DepartmentChange.SetP(xRec.Code,Rec.Code,Rec."Org Shema",Rec.Description);

                        PositionChange.SetParam(Rec.Code, Rec.Description, Rec.Grade, '', Rec."BJF/GJF", Rec."Control Function", Rec."Key Function", Rec."Management Level", Rec."Org. Structure", Rec."Department Code", Rec."Official Translation");
                        PositionChange.RUN;

                    END;
                end;
            }
            action("Insert Position")
            {
                Caption = 'Insert position';
                Image = Change;
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
                        IF NOT BenefitsReport.ISEMPTY THEN
                            BenefitsReport.DELETEALL;
                        COMMIT;
                        OsPreparation.RESET;
                        OsPreparation.SETFILTER(Status, '%1', 2);
                        IF OsPreparation.FINDLAST THEN BEGIN
                            FilterC := OsPreparation.Code;
                        END;
                        //     NewReport.SetParam('', '', 0, 1, Rec."Org. Structure", '');
                        //   NewReport.RUN;

                        EXIT;
                    END;
                end;
            }
            action("Copy Position")
            {
                Caption = 'Copy position';
                Image = Copy;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    IF Responsenew <> CONFIRM(Text7, TRUE) THEN BEGIN
                        IF NOT DimesnionForReport.ISEMPTY THEN
                            DimesnionForReport.DELETEALL;
                        DimensionCopy.RESET;
                        DimensionCopy.SETFILTER("Position Code", '%1', Rec.Code);
                        DimensionCopy.SETFILTER("Position Description", '%1', Rec.Description);
                        DimensionCopy.SETFILTER("ORG Shema", '%1', Rec."Org. Structure");
                        IF DimensionCopy.FINDSET THEN
                            REPEAT
                                DimesnionForReport.INIT;
                                DimesnionForReport.TRANSFERFIELDS(DimensionCopy);
                                DimesnionForReport.INSERT;
                            UNTIL DimensionCopy.NEXT = 0;
                        COMMIT;

                        IF NOT BenefitsReport.ISEMPTY THEN
                            BenefitsReport.DELETEALL;
                        BenefitsOrginal.RESET;
                        BenefitsOrginal.SETFILTER("Position Code", '%1', Rec.Code);
                        BenefitsOrginal.SETFILTER("Position Name", '%1', Rec.Description);
                        BenefitsOrginal.SETFILTER("Org. Structure", '%1', Rec."Org. Structure");
                        IF BenefitsOrginal.FINDSET THEN
                            REPEAT
                                BenefitsReport.INIT;
                                BenefitsReport.TRANSFERFIELDS(BenefitsOrginal);
                                BenefitsReport.INSERT;
                            UNTIL BenefitsOrginal.NEXT = 0;
                        COMMIT;
                        //kopiraj svee znači šalji po starom svee

                        //    ForCopyReport.SetParam(Rec.Code, Rec.Description, Rec.Grade, Rec."Role Name", Rec."BJF/GJF", Rec."Control Function", Rec."Key Function", Rec."Management Level", Rec."Org. Structure", Rec."Department Code", Rec."Official Translation");
                        //      ForCopyReport.RUN;
                        EXIT;
                    END;
                end;
                //    }
            }
            group("Dimension temporary")
            {
                Caption = 'Dimension temporary';
                Image = Administration;
                Visible = false;
                /*     action("Position temporery dimension")
                     {
                         Caption = 'Position temporery dimension';
                         RunObject = Page "Dimensions temp for positions";
                         RunPageLink = "Position Code" = FIELD(Code),
                                   "Position Description" = FIELD(Description);
                         Visible = false;
                     }*/
            }
        }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        DimensionTempForPos.RESET;
        DimensionTempForPos.SETFILTER("Position Code", '%1', Rec.Code);
        DimensionTempForPos.SETFILTER("Position Description", '%1', Rec.Description);
        IF DimensionTempForPos.FINDSET THEN
            REPEAT
                DimensionTempForPos.DELETE;
            UNTIL DimensionTempForPos.NEXT = 0;


        HeadOfDelete.RESET;
        HeadOfDelete.SETFILTER("Position Code", '%1', Rec.Code);
        HeadOfDelete.SETFILTER("Position Description", '%1', Rec.Description);
        HeadOfDelete.SetFilter("ORG Shema", '%1', rec."Org. Structure");
        IF HeadOfDelete.FINDFIRST THEN
            HeadOfDelete.DELETE;

        Benefits.RESET;
        Benefits.SETFILTER("Position Code", '%1', Rec.Code);
        Benefits.SETFILTER("Position Name", '%1', Rec.Description);
        IF Benefits.FINDSET THEN
            REPEAT
                Benefits.DELETE;
            UNTIL Benefits.NEXT = 0;

        Eclsystematization.RESET;
        Eclsystematization.SETFILTER("Position Code", '%1', Rec.Code);
        Eclsystematization.SETFILTER("Position Description", '%1', Rec.Description);
        IF Eclsystematization.FINDSET THEN
            REPEAT
                Eclsystematization1.RESET;
                Eclsystematization1.SETFILTER("Employee No.", '%1', Eclsystematization."Employee No.");
                Eclsystematization1.SETFILTER("No.", '%1', Eclsystematization."No.");
                IF Eclsystematization1.FINDFIRST THEN BEGIN
                    Eclsystematization1."Position Code" := '';
                    Eclsystematization1."Position Description" := '';
                    Eclsystematization1.MODIFY;
                END;
            UNTIL Eclsystematization.NEXT = 0;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        IsChange := FALSE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    trigger OnOpenPage()
    begin
        PositionMenuFind.RESET;
    end;

    var
        Response: Boolean;
        UpdatePostTable: Record "Position Minimal Educ Temp";
        UpdatePositionPage: page "Positions Minimal Education t";
        Txt003: Label 'Do you want to go in next step';
        Txt006: Label 'Do you want to back in previous step';
        //    PreviousStep: Page "Team temporary sist";
        StepNext: Page "ECL Systematizations";
        IsEditable: Boolean;
        PositionMenuTemp: Record "Position Menu";
        Text1: Label 'Do you want to change code/name for position?';
        PositionChange: Report "Position Menu Change";
        ResponseChange: Boolean;
        IsChange: Boolean;
        FM: Codeunit "File Management";
        TempBlob: Codeunit "Temp Blob";
        PositionMenuTemp1: Record "Position Menu temporary";
        PositionMenuTemp12: Record "Position Menu temporary";
        MyyFile: File;
        Stream: InStream;
        StreamOut: OutStream;
        ItemRec: Record "Item";
        Found: Boolean;
        IsTrue: Boolean;
        FindZero: Integer;
        StringPOs: Text;
        i: Integer;
        FoundOne: Boolean;
        PositionMenuFind: Record "Position Menu temporary";
        DimensionTempFor: Record "Dimension temp for position";
        PositionMenuCorrect: Record "Position Menu temporary";
        PositionMenuCorrect1: Record "Position Menu temporary";
        OsPreparation: Record "ORG Shema";
        String: Code[50];
        brojac: Integer;
        SectorLength: Integer;
        SectorFind: Record "Sector temporary";
        ValueSector1: Text;
        ValueSector: Integer;
        Report958: Report "Update Head Of table";
        PrevoiusTabela: Record "Team temporary";
        DimesnionForReport: Record "Dimension Pos for report";
        DimensionCopy: Record "Dimension temp for position";
        Responsenew: Boolean;
        Text6: Label 'Do you want to insert a new position';
        //  NewReport: Report "Position New Insert";
        FilterC: Code[50];
        BenefitsOrginal: Record "Position Benefits temporery";
        BenefitsReport: Record "Position Benefits report";
        DimensionTempForPos: Record "Dimension temp for position";
        HeadOfDelete: Record "Head Of's temporary";
        HeadCheck: Record "Head Of's temporary";
        Benefits: Record "Position Benefits temporery";
        Text7: Label 'Do you want to copy a position';
        //  ForCopyReport: Report "Department Temporary change";
        Eclsystematization: Record "ECL systematization";
        Eclsystematization1: Record "ECL systematization";
        OrgDiff: Record "ECL systematization";
        DimensionTempForPosDiff: Record "Dimension temp for position";
        TroskovniCentri: Record "Dimension temp for position";
}

