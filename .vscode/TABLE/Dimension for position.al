table 50161 "Dimension for position"
{
    Caption = 'Dimension temporary';
    //ĐK  DrillDownPageID = "Dimension for position";
    //ĐK LookupPageID = "Dimension for position";

    fields
    {
        field(1; "Position Code"; Code[20])
        {
            Caption = 'Code';
            TableRelation = "Position Menu".Code WHERE("Org. Structure" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                //Djemina;

                "Dimension Code" := 'TC';

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";

            end;
        }
        field(2; "Position Description"; Text[250])
        {
            Caption = 'Description';
            TableRelation = "Position Menu".Description WHERE("Org. Structure" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";


            end;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = true;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE(Status = CONST(A));

            trigger OnValidate()
            begin

                IF "Dimension Value Code" <> '' THEN BEGIN
                    DimensionValueTable.RESET;
                    DimensionValueTable.SETFILTER("Code", '%1', Rec."Dimension Value Code");
                    IF DimensionValueTable.FINDFIRST THEN BEGIN
                        "Dimension  Name" := DimensionValueTable.Name;
                    END;

                END

                ELSE BEGIN
                    "Dimension  Name" := '';
                END;
                Validate("Dimension  Name", Rec."Dimension  Name");

            end;
        }
        field(41; "Dimension  Name"; Text[100])
        {
            Caption = 'Dimension Code';
            Editable = true;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));

            trigger OnValidate()
            begin

                IF "Dimension  Name" <> '' THEN BEGIN
                    DimensionValueTable.RESET;
                    DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                    DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                    IF DimensionValueTable.FINDFIRST THEN BEGIN
                        "Dimension Value Code" := DimensionValueTable.Code;
                    END;
                END
                ELSE BEGIN
                    "Dimension Value Code" := '';
                END;
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
        field(50005; Belongs; Text[250])
        {
            Caption = 'belong';

            trigger OnValidate()
            begin

                Belongs := Rec."Position Code" + ' ' + '-' + ' ' + Rec."Position Description";
            end;
        }
        field(50370; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50371; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                ;
            end;
        }
        field(50372; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50373; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Departmenttemp.RESET;
                    Departmenttemp.SETFILTER("Sector  Description", '%1', Rec."Sector  Description");
                    //Departmenttemp.SETFILTER("ORG Shema",'%1',Rec."ORG Shema");
                    Departmenttemp.SETFILTER("Department Type", '%1', 8);

                    IF Departmenttemp.FINDFIRST THEN BEGIN

                        "Sector  Description" := Departmenttemp."Sector  Description";
                        IF "Sector  Description" <> '' THEN BEGIN

                            // VALIDATE("Department Code",Departmenttemp.Sector);

                            VALIDATE(Sector, Departmenttemp.Sector);

                        END;
                    END;
                END;
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '') AND ("Sector  Description" = '')) THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';


                END;



            end;
        }
        field(50374; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Departmenttemp.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF Departmenttemp.FIND('-') THEN BEGIN


                        IF "Department Categ.  Description" <> '' THEN BEGIN

                            //VALIDATE("Department Code",Departmenttemp."Department Category");
                            VALIDATE("Department Category", Departmenttemp."Department Category");

                            VALIDATE(Sector, Departmenttemp.Sector);
                            VALIDATE("Sector  Description", Departmenttemp."Sector  Description");
                        END;
                    END;
                END;
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Categ.  Description" = '')) THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;




            end;
        }
        field(50375; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Team Code" = '' THEN BEGIN
                    Departmenttemp.SETFILTER("Group Description", '%1', "Group Description");
                    IF Departmenttemp.FIND('-') THEN BEGIN


                        IF "Group Description" <> '' THEN BEGIN

                            // VALIDATE("Department Code",Departmenttemp."Group Code");
                            VALIDATE("Group Code", Departmenttemp."Group Code");
                            VALIDATE("Department Category", Departmenttemp."Department Category");
                            VALIDATE("Department Categ.  Description", Departmenttemp."Department Categ.  Description");
                            VALIDATE(Sector, Departmenttemp.Sector);
                            VALIDATE("Sector  Description", Departmenttemp."Sector  Description");
                        END;
                    END;
                END;
                IF ("Team Description" = '') AND ("Group Description" = '') THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;


            end;
        }
        field(50376; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = TeamT."Code" WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50377; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT.Name WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                Departmenttemp.SETFILTER("Team Description", '%1', "Team Description");
                IF Departmenttemp.FIND('-') THEN BEGIN

                    "Team Description" := Departmenttemp."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        VALIDATE("Team Code", Departmenttemp."Team Code");
                        // VALIDATE("Department Code",Departmenttemp."Team Code");
                        VALIDATE("Group Code", Departmenttemp."Group Code");
                        VALIDATE("Group Description", Departmenttemp."Group Description");
                        VALIDATE("Department Category", Departmenttemp."Department Category");
                        VALIDATE("Department Categ.  Description", Departmenttemp."Department Categ.  Description");
                        VALIDATE(Sector, Departmenttemp.Sector);
                        VALIDATE("Sector  Description", Departmenttemp."Sector  Description");
                    END;
                END;
                IF "Team Description" = '' THEN BEGIN
                    Sector := '';
                    "Department Category" := '';
                    "Group Code" := '';
                    "Team Code" := '';
                    "Sector  Description" := '';
                    "Department Categ.  Description" := '';
                    "Group Description" := '';
                    "Team Description" := '';
                END;




            end;
        }
        field(50378; "Org Belongs"; Text[130])
        {
            Caption = 'Org Belongs';
            Editable = true;
            TableRelation = Department.Description WHERE("ORG Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Org Belongs" <> '' THEN BEGIN
                    DepartmentTempReal.RESET;
                    DepartmentTempReal.SETFILTER(Description, '%1', "Org Belongs");
                    IF DepartmentTempReal.FINDFIRST THEN BEGIN
                        Sector := DepartmentTempReal.Sector;
                        "Sector  Description" := DepartmentTempReal."Sector  Description";
                        "Department Category" := DepartmentTempReal."Department Category";
                        "Department Categ.  Description" := DepartmentTempReal."Department Categ.  Description";
                        "Group Code" := DepartmentTempReal."Group Code";
                        "Group Description" := DepartmentTempReal."Group Description";
                        "Team Code" := DepartmentTempReal."Team Code";
                        "Team Description" := DepartmentTempReal."Team Description";
                    END;
                END;
                DimensionTempFindTC.RESET;
                DimensionTempFindTC.SETFILTER("Department Type", '%1', DepartmentTempReal."Department Type");
                DimensionTempFindTC.SETFILTER(Description, '%1', "Org Belongs");
                IF DimensionTempFindTC.FINDFIRST THEN BEGIN
                    "Dimension  Name" := DimensionTempFindTC."Dimension  Name";
                    "Dimension Value Code" := DimensionTempFindTC."Dimension Value Code";
                END;
                IF "Sector  Description" <> '' THEN BEGIN
                    SectorT.RESET;
                    SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                    SectorT.SETFILTER(Description, '%1', "Sector  Description");
                    IF SectorT.FINDFIRST THEN
                        "Sector Identity" := SectorT.Identity;
                END;
            end;
        }
        field(500378; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
    }

    keys
    {
        key(Key1; "Position Code", "Dimension Value Code", "ORG Shema", "Position Description", "Org Belongs")
        {
        }
        key(Key2; "Dimension Value Code")
        {
        }
        key(Key3; "Position Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Position Code", "Position Description", "Sector  Description", "Department Category", "Group Description", "Team Description")
        {
        }
    }

    trigger OnDelete()
    begin

        Rec.DELETE;
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);




    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
    end;

    var
        WPConnSetup: Record "Web portal connection setup";

        lvarActiveConnection: Variant;
        "B-1Rec": Record "Sector";
        "B-1WithRegions": Record "Department";
        StreamRec: Record "Group";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";

        lvarActiveConnectionAdm2: Variant;
        // Position: Record "Confidential Clerks";
        //  Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        TeamRec: Record "TeamT";
        LengthCode: Integer;
        //  Tip: Record "Type";
        Dep: Record "Department";
        DC: Record "Department Category";
        TEAM: Record "TeamT";
        GR: Record "Group";
        SectorR: Record "Sector";
        NewDepartment: Record "Department";
        DepartmentCategory: Record "Department Category";
        SectorNew: Record "Sector";
        GroupNew: Record "Group";
        Team1: Record "TeamT";
        DepartmentCheck: Record "Department";
        DepartmentValidate: Record "Department";
        OrgStr: Record "ORG Shema";
        Sec: Record "Sector";
        DepCat: Record "Department Category";
        Dimension: Record "Dimension";
        DepartmentTempTry: Record "Department";
        DepartmentTempTry1: Record "Department";
        DimensionNew: Record "Dimension temporary";
        DimensionNewTemp: Record "Dimension temporary";
        DepartmentTempNes: Record "Department";
        String: Text;
        Brojac: Integer;
        String1: Text;
        LengthString: Integer;
        I: Integer;
        DepartmentTabela: Record "Department";
        FindSector: Record "Sector";
        DimensionValueTable: Record "Dimension Value";
        Departmenttemp: Record "Department";
        DepartmentTempReal: Record "Department";
        DimensionTempFindTC: Record "Dimension temporary";
        PositionMenu: Record "Position Menu";
        SectorT: Record "Sector";
}

