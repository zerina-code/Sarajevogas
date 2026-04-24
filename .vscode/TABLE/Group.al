table 50082 Group
{
    Caption = 'Group';
    DrillDownPageID = "Group";
    LookupPageID = "Group";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
                dep.Reset();
                Dep.SETFILTER(Code, '%1', xRec.Code);
                Dep.SETFILTER("ORG Shema", '%1', "Org Shema");
                IF Dep.FINDSET THEN
                    REPEAT
                        IF Dep.GET(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description")
                          THEN
                            Dep.RENAME(Rec.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description")
      UNTIL Dep.NEXT = 0;



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

                Dep.Reset();
                Dep.SetFilter(Code, '%1', Rec.Code);
                Dep.SetFilter(Description, '%1', rec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not Dep.FindFirst() then begin

                    Dep.Init();
                    Dep.Validate("ORG Shema", Rec."Org Shema");
                    Dep.validate(Code, Rec.Code);
                    Dep.validate(Description, Rec.Description);
                    Dep."Group Description" := Rec.Description;
                    Dep."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin

                        Dep.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        Dep.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            dep.Validate("Sector Code", SectorF.Code);
                            Dep.Validate(Sector, SectorF.Code);
                            Dep.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            dep.Validate("Sector Code", '');
                            Dep.Validate(Sector, '');
                            Dep.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        Dep.Validate("Department Categ.  Description", '');
                        Dep.Validate("Department Category", '');
                        dep.Validate("Sector Code", '');
                        Dep.Validate(Sector, '');
                        Dep.Validate("Sector  Description", '');

                    end;


                    Dep."Department Type" := Rec."Department Type";
                    Dep.Insert();

                end;

                Dep.Reset();
                Dep.SetFilter(Code, '%1', xRec.Code);
                Dep.SetFilter(Description, '%1', rec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if Dep.FindFirst() then
                    Dep.Delete();

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
                Dep.Reset();
                Dep.SETFILTER(Code, '%1', Rec.Code);
                Dep.SETFILTER("ORG Shema", '%1', "Org Shema");
                IF Dep.FINDSET THEN
                    REPEAT
                        IF Dep.GET(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", xRec.Description)
                          THEN BEGIN
                            Dep.RENAME(Dep.Code, Dep."ORG Shema", Dep."Team Description", Dep."Department Categ.  Description", Dep."Group Description", Rec.Description);
                            //Dep.Description:=Rec.Description;
                            // Dep.MODIFY;
                        END;
                    UNTIL Dep.NEXT = 0;

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

                Dep.Reset();
                Dep.SetFilter(Code, '%1', Rec.Code);
                Dep.SetFilter(Description, '%1', rec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not Dep.FindFirst() then begin

                    Dep.Init();
                    Dep.Validate("ORG Shema", Rec."Org Shema");
                    Dep.validate(Code, Rec.Code);
                    Dep.validate(Description, Rec.Description);
                    Dep."Group Description" := Rec.Description;
                    Dep."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin

                        Dep.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        Dep.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            dep.Validate("Sector Code", SectorF.Code);
                            Dep.Validate(Sector, SectorF.Code);
                            Dep.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            dep.Validate("Sector Code", '');
                            Dep.Validate(Sector, '');
                            Dep.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        Dep.Validate("Department Categ.  Description", '');
                        Dep.Validate("Department Category", '');
                        dep.Validate("Sector Code", '');
                        Dep.Validate(Sector, '');
                        Dep.Validate("Sector  Description", '');

                    end;


                    Dep."Department Type" := Rec."Department Type";
                    Dep.Insert();

                end;

                Dep.Reset();
                Dep.SetFilter(Code, '%1', Rec.Code);
                Dep.SetFilter(Description, '%1', xRec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if Dep.FindFirst() then
                    Dep.Delete();


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
                  Dep.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                  Dep.SETFILTER(Code,'%1',Rec.Code);
                  Dep.SETFILTER("Changing Department",'%1',FALSE);
                  IF Dep.FINDSET THEN REPEAT
                    Dep."Changing Department":=TRUE;
                   Dep.MODIFY(TRUE);
                
                     Dep.GET(Dep.Code,Dep."ORG Shema",Dep."Team Description",Dep."Department Categ.  Description",Dep."Group Description");
                    UNTIL Dep.NEXT=0;
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
            Editable = false;
        }
        field(50015; "Dep Cat Identity"; Integer)
        {
        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(50017; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50018; "Belongs to Department Category"; Text[250])
        {
            Caption = 'Belongs to Department Category';
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("Org Shema"));

            trigger OnValidate()
            begin

                Dep.Reset();
                Dep.SetFilter(Code, '%1', Rec.Code);
                Dep.SetFilter(Description, '%1', rec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if Dep.FindFirst() then
                    Dep.Delete();


                Dep.Reset();
                Dep.SetFilter(Code, '%1', Rec.Code);
                Dep.SetFilter(Description, '%1', rec.Description);
                Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
                if not Dep.FindFirst() then begin

                    Dep.Init();
                    Dep.Validate("ORG Shema", Rec."Org Shema");
                    Dep.validate(Code, Rec.Code);
                    Dep.validate(Description, Rec.Description);
                    Dep."Group Description" := Rec.Description;
                    Dep."Group Code" := rec.Code;

                    DepartmentCatF.Reset();
                    DepartmentCatF.SetFilter("Org Shema", '%1', Rec."Org Shema");
                    DepartmentCatF.SetFilter(Description, '%1', "Belongs to Department Category");
                    if DepartmentCatF.FindFirst() then begin

                        Dep.Validate("Department Categ.  Description", DepartmentCatF.Description);
                        Dep.Validate("Department Category", DepartmentCatF.Code);
                        SectorF.Reset();
                        SectorF.SetFilter("Org Shema", '%1', rec."Org Shema");
                        SectorF.SetFilter(Description, DepartmentCatF."Sector Belongs");
                        if SectorF.FindFirst() then begin
                            dep.Validate("Sector Code", SectorF.Code);
                            Dep.Validate(Sector, SectorF.Code);
                            Dep.Validate("Sector  Description", SectorF.Description);
                        end


                        else begin

                            dep.Validate("Sector Code", '');
                            Dep.Validate(Sector, '');
                            Dep.Validate("Sector  Description", '');
                        end;


                    end
                    else begin
                        Dep.Validate("Department Categ.  Description", '');
                        Dep.Validate("Department Category", '');
                        dep.Validate("Sector Code", '');
                        Dep.Validate(Sector, '');
                        Dep.Validate("Sector  Description", '');

                    end;


                    Dep."Department Type" := Rec."Department Type";
                    Dep.Insert();

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
        field(50019; Belongs; Text[30])
        {
        }
        field(50020; "Identity Sector"; Integer)
        {
        }
        field(500402; "Official Translate of Group"; Text[250])
        {
            Caption = 'Official Translate of Group';
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
        "Department Type" := "Department Type"::Group;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    trigger OnDelete()
    begin
        Dep.Reset();
        Dep.SetFilter(Code, '%1', Rec.Code);
        Dep.SetFilter(Description, '%1', rec.Description);
        Dep.SetFilter("ORG Shema", '%1', rec."Org Shema");
        if Dep.FindFirst() then
            Dep.Delete();
    end;

    var
        Text000: Label '%1 must be higher than %2.';
        SectorF: Record Sector;
        DepartmentCatF: Record "Department Category";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        DepartmentTemp: Record "Department";
        HeadOrg: Record "Head Of's";
        HeadU: Record "Head Of's";

    local procedure UpdateDatetime()
    begin
        /*"Starting Date-Time" := CREATEDATETIME(Date,"Starting Time");
        "Ending Date-Time" := CREATEDATETIME(Date,"Ending Time");
        */

    end;
}

