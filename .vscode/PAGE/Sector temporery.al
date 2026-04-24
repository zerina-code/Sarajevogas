table 50000 "Sector temporary"
{
    Caption = 'Sector';
    DrillDownPageID = "Sector temporary sist";
    LookupPageID = "Sector temporary sist";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

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



                IF Code <> xRec.Code THEN BEGIN
                    DepT.Reset();
                    DepT.SETFILTER(Code, '%1', xRec.Code);
                    DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF DepT.FINDSET THEN
                        REPEAT
                            IF DepT.GET(xRec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description)
                                                 THEN
                                DepT.RENAME(Rec.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description);

                            DepT."Department Type" := Rec."Department Type";
                            DepT.Sector := Rec.Code;
                            DepT."Sector  Description" := Rec.Description;
                            DepT.Modify();


                        until DepT.Next() = 0;

                    if xRec.Code <> '' then begin
                        HeadOrg.Reset();
                        HeadOrg.SETFILTER("Sector", '%1', xRec.Code);
                        HeadOrg.SETFILTER("ORG Shema", '%1', "Org Shema");
                        IF HeadOrg.FINDSET THEN
                            REPEAT
                                //"Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code"
                                HeadOrg.Sector := Rec.Code;
                                HeadOrg."Sector  Description" := Rec.Description;

                                HeadOrg.Modify();


                                if (HeadOrg."Department Categ.  Description" = '') and (HeadOrg."Group Description" = '') then begin

                                    IF HeadU.GET(HeadOrg."Department Code", HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                     HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")
                                                            THEN
                                        HeadU.RENAME(Rec.Code, HeadOrg."ORG Shema", HeadOrg."Department Categ.  Description", HeadOrg."Group Description",
                                  HeadOrg."Team Description", HeadOrg."Management Level", HeadOrg."Position Code")

                                end;
                            until HeadOrg.Next() = 0;
                    end;


                    "Department Type" := "Department Type"::Sector;

                    //Dep
                    DepT.Reset();
                    DepT.SetFilter(Code, '%1', Rec.Code);
                    DepT.setfilter("ORG Shema", '%1', Rec."Org Shema");
                    if not DepT.FindFirst() then begin
                        DepT.Init();
                        DepT.Validate("ORG Shema", Rec."Org Shema");
                        DepT.validate(Code, Rec.Code);
                        DepT.validate(Description, Rec.Description);
                        DepT."Sector Code" := Rec.Code;
                        DepT.Sector := Rec.Code;
                        DepT."Sector  Description" := Rec.Description;
                        DepT."Department Type" := Rec."Department Type";
                        DepT.Insert();

                    end
                    else begin

                        DepT."Sector Code" := Rec.Code;
                        DepT.Sector := Rec.Code;
                        DepT."Sector  Description" := Rec.Description;
                        DepT.Modify();

                    end;


                end;


            end;

        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';

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

                IF Description <> xRec.Description THEN BEGIN
                    DepT.Reset();
                    DepT.SETFILTER(Description, '%1', xRec.Description);
                    DepT.SETFILTER("ORG Shema", '%1', "Org Shema");
                    IF DepT.FINDSET THEN
                        REPEAT
                            IF DepT.GET(DepT.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", xRec.Description)
                                                 THEN
                                DepT.RENAME(DepT.Code, DepT."ORG Shema", DepT."Team Description", DepT."Department Categ.  Description", DepT."Group Description", Rec.Description);
                            DepT.Sector := Rec.Code;
                            DepT."Sector  Description" := Rec.Description;
                            DepT.Modify();
                        until DepT.Next() = 0;

                end;
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
        field(50002; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50004; "Changing Department"; Boolean)
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
        field(50005; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50006; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50007; Identity; Integer)
        {
            AutoIncrement = true;
            Caption = 'Identity';
        }
        field(50008; "Number Of Dep Cat levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER(4),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Department Categroy levels below';

        }
        field(50011; "Dimension Value Code"; Code[20])
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
        field(50012; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(50013; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Code" = FIELD("Code"),
                                                             Description = FIELD(Description),
                                                             "Department Type" = FIELD("Department Type"),
                                                             "ORG Shema" = FIELD("Org Shema")));
            Caption = 'Number of dimension value';

        }
        field(50014; "Number Of Group levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER("Group"),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Group levels below';

        }
        field(50015; "Number Of Team  levels below"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Department temporary" WHERE(Sector = FIELD("Code"),
                                                              "Department Type" = FILTER(Sector),
                                                              "Sector  Description" = FIELD(Description)));
            Caption = 'Number Of Team  levels below';

        }
        field(50016; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                IF FORMAT(Rec."Residence/Network") <> '' THEN BEGIN
                    IF Code <> '' THEN BEGIN
                        IF Description <> '' THEN BEGIN

                            DepartmentTemp.RESET;
                            DepartmentTemp.SETFILTER(Code, '%1', Code);
                            DepartmentTemp.SETFILTER(Description, '%1', Description);
                            DepartmentTemp.SETFILTER("Department Type", '%1', 8);
                            IF DepartmentTemp.FINDFIRST THEN BEGIN
                                DepartmentTemp."Residence/Network" := "Residence/Network";
                                DepartmentTemp.MODIFY;
                            END;

                        END;
                    END;
                END;
            end;
        }
        field(50017; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50018; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50019; "Name of TC"; Text[250])
        {
            Caption = 'Name of TC';
            FieldClass = Normal;
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of Sector"; Text[250])
        {
            Caption = 'Official Translate of Sector';
        }
        field(500403; "ID for GPS"; Integer)
        {
            Caption = 'ID for GPS';
        }
        field(500404; Ispis; Boolean)
        {
        }
        field(500405; Parent; Text[250])
        {
            Caption = 'Parent';
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(500406; CEO; Boolean)
        {


            Caption = 'CEO';
            trigger OnValidate()
            begin
                if CEO = true then
                    "Department Type" := "Department Type"::CEO
                else
                    "Department Type" := "Department Type"::Sector;

            end;

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

    trigger OnDelete()
    begin
        /*
        ShopCalendarWorkDays.SETRANGE(Code,Code);
        ShopCalendarWorkDays.DELETEALL;
        
        ShopCalHoliday.SETRANGE(Code,Code);
        ShopCalHoliday.DELETEALL;
        */
        IF Rec."Department Type" = Rec."Department Type"::Sector THEN BEGIN
            SectorTempBelong.RESET;
            SectorTempBelong.SETFILTER(Description, '%1', Rec.Description);
            IF SectorTempBelong.FINDFIRST THEN BEGIN
                SectorTempBelong.CALCFIELDS("Number of dimension value");
                IF SectorTempBelong."Number of dimension value" = 2 THEN BEGIN
                    DimensionTempYes.RESET;
                    DimensionTempYes.SETFILTER("Sector  Description", '%1', Rec.Description);
                    IF DimensionTempYes.FINDFIRST THEN BEGIN
                        SectorTempBelong."Name of TC" := DimensionTempYes."Dimension Value Code" + ' ' + '-' + ' ' + DimensionTempYes."Dimension  Name";
                        SectorTempBelong.MODIFY;
                    END
                    ELSE BEGIN
                        SectorTempBelong."Name of TC" := '';
                        SectorTempBelong.MODIFY;
                    END;
                END;
            END;
        END;

    end;

    trigger OnInsert()
    begin
        IF Code = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("B-1 Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."B-1 Nos.", xRec."No. Series", 0D, Code, "No. Series");
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
        "Department Type" := "Department Type"::Sector;
        DepartmentTemp.RESET;
        DepartmentTemp.SETFILTER(Sector, '%1', Rec.Code);
        DepartmentTemp.SETFILTER("Sector  Description", '%1', Rec.Description);
        DepartmentTemp.SETFILTER("Department Type", '%1', 8);
        IF DepartmentTemp.FINDFIRST THEN BEGIN
            DepartmentTemp."Sector Identity" := Rec.Identity;
            DepartmentTemp.MODIFY;
        END;

        SectorInsertModify.RESET;
        SectorInsertModify.SETFILTER(Code, '<>%1', Rec.Code);
        IF SectorInsertModify.FINDSET THEN
            REPEAT
                SectorInsertModify.LastModified := '';
                SectorInsertModify.LastModified := FORMAT(Rec.Code) + ' ' + Rec.Description;
                SectorInsertModify.MODIFY;
            UNTIL SectorInsertModify.NEXT = 0;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        ShopCalendarWorkDays: Record "Department Category";
        HeadOrg: Record "Head Of's temporary";
        HeadU: Record "Head Of's temporary";
        DepT: Record "Department temporary";
        ShopCalHoliday: Record "Group";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Dep: Record "Department";
        //    DepartmentChange: Report "Department Temporary change";
        DimensionNew: Record "Dimension temporary";
        DepartmentTemp: Record "Department temporary";
        OsPreparation: Record "ORG Shema";
        DepartmentTemp1: Record "Department temporary";
        Sec: Record "Sector temporary";
        DA: Integer;
        SectorInsertModify: Record "Sector temporary";
        SectorTempBelong: Record "Sector temporary";
        DimensionsTempTabela: Record "Dimension temporary";
        SectorTempBelong1: Record "Sector temporary";
        DimensionTempYes: Record "Dimension temporary";
}

