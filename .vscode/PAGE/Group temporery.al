table 50106 "Group temporary"
{
    Caption = 'Group';
    DrillDownPageID = "Group temporary sist";
    LookupPageID = "Group temporary sist";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = false;

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

                if (xRec.Code <> '') and (Rec."Belongs to Department Category" <> '') then begin
                    DepT.Reset();
                    DepT.SETFILTER(Code, '%1', xRec.Code);
                    DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF DepT.FINDSET THEN
                        REPEAT
                            IF DepT.GET(DepT.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description")
                              THEN
                                DepT.RENAME(Rec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description");
                            Dept."Department Type" := DepT."Department Type"::Group;
                            DepT.Modify();

                        UNTIL DepT.NEXT = 0;
                end;


                //promjena šifre odjela

                if (xRec.Code <> '') and (Rec."Belongs to Department Category" <> '') then begin

                    HeadOrg.Reset();
                    HeadOrg.SETFILTER("Group Code", '%1', xRec.Code);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"
                            HeadOrg."Group Code" := Rec.Code;

                            HeadOrg.Modify();


                            if (HeadOrg."Group Description" <> '') then begin

                                IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                 HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                        THEN
                                    HeadU.RENAME(Rec.Code, HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                              HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                            end;
                        until HeadOrg.Next() = 0;
                end;

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Group Description" := Rec.Description;
                    DepT."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin

                        DepT.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        DepT.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            DepT.Validate("Sector Code", SectorF.Code);
                            DepT.Validate(Sector, SectorF.Code);
                            DepT.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            DepT.Validate("Sector Code", '');
                            DepT.Validate(Sector, '');
                            DepT.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        DepT.Validate("Department Categ.  Description", '');
                        DepT.Validate("Department Category", '');
                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');

                    end;


                    DepT."Department Type" := Rec."Department Type";
                    Dept."Department Type" := DepT."Department Type"::Group;

                    DepT.Insert();

                end;

                DepT.Reset();
                DepT.SetFilter(Code, '%1', xRec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if DepT.FindFirst() then
                    DepT.Delete();

            end;

        }
        field(2; Date; Date)
        {
            Caption = 'Date';
            NotBlank = true;

            trigger OnValidate()
            begin
                "Starting Date-Time" := CREATEDATETIME(Date, "Starting Time");
                IF "Ending Date-Time" <> 0DT THEN
                    "Ending Date-Time" := CREATEDATETIME(Date, "Ending Time");
            end;
        }
        field(3; "Starting Time"; Time)
        {
            Caption = 'Starting Time';

            trigger OnValidate()
            begin
                IF ("Ending Time" = 0T) OR
                   ("Ending Time" < "Starting Time")
                THEN
                    "Ending Time" := "Starting Time";

                VALIDATE("Ending Time");
            end;
        }
        field(4; "Ending Time"; Time)
        {
            Caption = 'Ending Time';

            trigger OnValidate()
            begin
                IF "Ending Time" < "Starting Time" THEN
                    ERROR(Text000, FIELDCAPTION("Ending Time"), FIELDCAPTION("Starting Time"));

                UpdateDatetime;
            end;
        }
        field(5; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';

            trigger OnValidate()
            begin
                "Starting Time" := DT2TIME("Starting Date-Time");
                Date := DT2DATE("Starting Date-Time");
                VALIDATE("Starting Time");
            end;
        }
        field(6; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';

            trigger OnValidate()
            begin
                /*"Ending Time" := DT2TIME("Ending Date-Time");
                Date := DT2DATE("Ending Date-Time");
                VALIDATE("Ending Time");
                */

            end;
        }
        field(10; Description; Text[250])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin
                DepT.Reset();
                DepT.SETFILTER(Code, '%1', Rec.Code);
                DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                IF DepT.FINDSET THEN
                    REPEAT
                        IF DepT.GET(DepT.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", xRec.Description)
                          THEN BEGIN
                            DepT.RENAME(DepT.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description);
                            //DepT.Description:=Rec.Description;
                            // DepT.MODIFY;
                            Dept."Department Type" := DepT."Department Type"::Group;
                            DepT.Modify();
                        END;
                    UNTIL DepT.NEXT = 0;

                //promjena šifre odjela

                if (Rec.Code <> '') and (Rec."Belongs to Department Category" <> '') then begin
                    HeadOrg.Reset();
                    HeadOrg.SetFilter("Group Code", '%1', rec.Code);
                    HeadOrg.SETFILTER("Group Description", '%1', xRec.Description);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"



                            if (HeadOrg."Group Description" <> '') then begin

                                IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                 HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                        THEN
                                    HeadU.RENAME(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", Rec.Description,
                              HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                            end;
                        until HeadOrg.Next() = 0;
                end;

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Group Description" := Rec.Description;
                    DepT."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin

                        DepT.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        DepT.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            DepT.Validate("Sector Code", SectorF.Code);
                            DepT.Validate(Sector, SectorF.Code);
                            DepT.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            DepT.Validate("Sector Code", '');
                            DepT.Validate(Sector, '');
                            DepT.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        DepT.Validate("Department Categ.  Description", '');
                        DepT.Validate("Department Category", '');
                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');

                    end;


                    DepT."Department Type" := Rec."Department Type";
                    Dept."Department Type" := DepT."Department Type"::Group;

                    DepT.Insert();

                end;

                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', xRec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if DepT.FindFirst() then
                    DepT.Delete();


            end;



        }
        field(50000; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50001; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(50002; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin
                /*IF Rec."Changing Department" THEN BEGIN
                  DepT.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  DepT.SETFILTER(Code,'%1',Rec.Code);
                  DepT.SETFILTER("Changing Department",'%1',FALSE);
                  IF DepT.FINDSET THEN REPEAT
                    DepT."Changing Department":=TRUE;
                   DepT.MODIFY(TRUE);
                
                     DepT.GET(DepT.Code,DepT."ORG Shema",DepT."Team Description",DepT."Department Categ.  Description",DepT."Group Description");
                    UNTIL DepT.NEXT=0;
                    END;*/

            end;
        }
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50006; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
        }
        field(50010; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension temporary"."Dimension Value Code" WHERE(Code = FIELD(Code));

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDimValue("Dimension Code","Dimension Value Code") THEN
                  ERROR(DimMgt.GetDimErr);*/
                IF "Dimension Value Code" <> '' THEN BEGIN
                    DimensionNew.SETFILTER("Dimension Value Code", '%1', Rec."Dimension Value Code");
                    IF DimensionNew.FINDFIRST THEN BEGIN
                        DimensionNew.CALCFIELDS("Dimension  Name");
                        "Dimension  Name" := DimensionNew."Dimension  Name";
                    END;
                END
                ELSE BEGIN
                    "Dimension  Name" := '';
                END;

            end;
        }
        field(50011; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(50012; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Group Description" = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                            "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';


        }
        field(50013; "Number Of Team  levels below"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE("Group Code" = FIELD("Code"),
                                                              "Department Type" = FILTER(Sector),
                                                              "Group Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50015; "Dep Cat Identity"; Integer)
        {
        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                /*IF FORMAT(Rec."Residence/Network")<>'' THEN BEGIN
                  IF Rec.Code<>'' THEN BEGIN
                  IF Rec.Description<>'' THEN BEGIN
                    DepartmentTemp.RESET;
                    DepartmentTemp.SETFILTER("Group Code",'%1',Rec.Code);
                    DepartmentTemp.SETFILTER("Group Description",'%1',Rec.Description);
                    DepartmentTemp.SETFILTER("Department Type",'%1',2);
                    IF DepartmentTemp.FINDFIRST THEN BEGIN
                      DepartmentTemp."Residence/Network":="Residence/Network";
                      DepartmentTemp.MODIFY;
                      END;
                
                END;
                    END;
                       END;
                       */

            end;
        }
        field(50017; "Department Type"; enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50018; "Belongs to Department Category"; Text[250])
        {
            Caption = 'Belongs to Department Category';
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("Org Shema"));

            trigger OnValidate()
            begin


                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if DepT.FindFirst() then
                    DepT.Delete();


                DepT.Reset();
                DepT.SetFilter(Code, '%1', Rec.Code);
                DepT.SetFilter(Description, '%1', rec.Description);
                DepT.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not DepT.FindFirst() then begin

                    DepT.Init();
                    DepT.Validate("ORG Shema", Rec."Org Shema");
                    DepT.validate(Code, Rec.Code);
                    DepT.validate(Description, Rec.Description);
                    DepT."Group Description" := Rec.Description;
                    DepT."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin
                        DepT."Department Category" := DepartmentCatF.Code;

                        DepT.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        DepT.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            DepT.Validate("Sector Code", SectorF.Code);
                            DepT.Validate(Sector, SectorF.Code);
                            DepT.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            DepT.Validate("Sector Code", '');
                            DepT.Validate(Sector, '');
                            DepT.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        DepT.Validate("Department Categ.  Description", '');
                        DepT.Validate("Department Category", '');
                        DepT.Validate("Sector Code", '');
                        DepT.Validate(Sector, '');
                        DepT.Validate("Sector  Description", '');

                    end;


                    DepT."Department Type" := Rec."Department Type";
                    Dept."Department Type" := DepT."Department Type"::Group;

                    DepT.Insert();

                end;

                if (Rec.Code <> '') and (Rec."Belongs to Department Category" <> '') then begin

                    HeadOrg.Reset();
                    HeadOrg.SETFILTER("Department Code", '%1', Rec.Code);
                    HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF HeadOrg.FINDSET THEN
                        REPEAT
                            //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"

                            DepartmentCatF.Reset();
                            DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                            DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                            if DepartmentCatF.FindFirst() then begin
                                HeadOrg.Validate("Department Category", DepartmentCatF.Code);
                                SectorF.Reset();
                                SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                                SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                                if SectorF.FindFirst() then begin
                                    HeadOrg.Validate("Sector", SectorF.Code);
                                    HeadOrg.Validate("Sector  Description", SectorF.Description);
                                end


                                else begin

                                    HeadOrg.Validate("Sector", '');
                                    HeadOrg.Validate("Sector  Description", '');
                                end;
                            end
                            else begin
                                HeadOrg.Validate("Sector", '');
                                HeadOrg.Validate("Sector  Description", '');
                                HeadOrg.Validate("Department Category", '');

                            end;
                            HeadOrg.Modify();



                            if (HeadOrg."Group Description" <> '') then begin

                                IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                 HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                        THEN
                                    HeadU.RENAME(HeadOrg."Department Code", HeadOrg."ORG Shema", Rec."Belongs to Department Category", Rec.Description,
                              HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                            end;
                        until HeadOrg.Next() = 0;
                end;
            end;


        }
        field(50019; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50020; "Identity Sector"; Integer)
        {
        }
        field(50021; "Name of TC"; Text[250])
        {
            Caption = 'Name of TC';
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of Group"; Text[250])
        {
            Caption = 'Official Translate of group';
        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Code", "Org Shema", Description)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Description, "Code", "Org Shema")
        {
        }
    }

    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Stream Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Stream Nos.", xRec."No. Series", 0D, Code, "No. Series");
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        OsPreparation.RESET;
        OsPreparation.SETFILTER(Status, '%1', 2);
        IF OsPreparation.FINDLAST THEN BEGIN
            "Org Shema" := OsPreparation.Code;
        END
        ELSE BEGIN
            "Org Shema" := '';
        END;
        "Department Type" := "Department Type"::Group;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        DepartmentCatF: Record "Department Category temporary";
        DepT: Record "Department temporary";
        HeadOrg: Record "Head Of's temporary";
        HeadU: Record "Head Of's temporary";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DimensionNew: Record "Dimension temporary";
        DepartmentTemp: Record "Department temporary";
        SectorF: Record "Sector temporary";
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
        Text002: Label 'This code is wrong';

    local procedure UpdateDatetime()
    begin
        /*"Starting Date-Time" := CREATEDATETIME(Date,"Starting Time");
        "Ending Date-Time" := CREATEDATETIME(Date,"Ending Time");
        */

    end;
}

