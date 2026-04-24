table 50083 "Head Of's temporary"
{
    Caption = 'Head Off''s';
    DrillDownPageID = "Head Of's temporary sist";
    LookupPageID = "Head Of's temporary sist";

    fields
    {
        field(1; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = "Department temporary".Code WHERE("ORG Shema" = FIELD("ORG Shema"));
        }
        field(2; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
            TableRelation = "Position Menu temporary".Code;
        }
        field(3; n; Text[30])
        {
        }
        field(6; "Employee No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ECL systematization"."Employee No." WHERE("Org. Structure" = FIELD("ORG Shema"),
                                                                             "Position Code" = FIELD("Position Code"),
                                                                             "Department Cat. Description" = FIELD("Department Categ.  Description"),
                                                                             "Group Description" = FIELD("Group Description"),
                                                                             "Team Description" = FIELD("Team Description"),
                                                                             "Department Code" = FIELD("Department Code")));
            Caption = 'Employee No.';

        }
        field(7; "Table Position"; Text[250])
        {
            Caption = 'Table Position';
        }
        field(50000; "ORG Shema"; Code[10])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(50001; "Employee Name"; Text[100])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50002; "Employee Last Name"; Text[250])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            FieldClass = FlowField;
        }
        field(50003; "Department Name"; Text[130])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Department temporary".Description WHERE(Code = FIELD("Department Code"),
                                                                           "ORG Shema" = FIELD("ORG Shema")));
            Caption = 'Department Name';
            Editable = false;

        }
        field(50004; "Position Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Position Menu temporary".Description WHERE("Org. Structure" = FIELD("ORG Shema"),
                                                                              Code = FIELD("Position Code")));
            Caption = 'Position Description';
            Editable = false;

        }
        field(50005; NonActive; Boolean)
        {
            Caption = 'NonActive';
        }
        field(50006; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = "Sector temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50007; "Department Category"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Department Category temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                ;
            end;
        }
        field(50008; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = "Group temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50009; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = "Sector temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    IF Department.FIND('-') THEN BEGIN

                        "Sector  Description" := Department."Sector  Description";
                        IF "Sector  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department.Sector);

                            VALIDATE(Sector, Department.Sector);

                        END;
                        Sector := Department.Code;
                        "Department Code" := Department.Sector;
                        "Department Categ.  Description" := '';
                        "Department Category" := '';
                        "Group Code" := '';
                        "Group Description" := '';
                        "Team Code" := '';
                        "Team Description" := '';
                    END
                    ELSE BEGIN
                        Sector := '';
                        "Department Code" := '';
                        "Sector  Description" := '';
                        "Department Categ.  Description" := '';
                        "Department Category" := '';
                        "Group Code" := '';
                        "Group Description" := '';
                        "Team Code" := '';
                        "Team Description" := '';
                    END;
                END
            end;
        }
        field(50010; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Department Categ.  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Department Category");
                            VALIDATE("Department Category", Department."Department Category");

                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                        "Department Code" := Department."Department Category";
                        Sector := Department.Sector;
                        "Sector  Description" := Department."Sector  Description";
                        "Department Category" := Department."Department Category";
                        "Department Categ.  Description" := Department."Department Categ.  Description";

                        "Group Code" := '';
                        "Group Description" := '';
                        "Team Code" := '';
                        "Team Description" := '';
                    END
                    ELSE BEGIN
                        "Department Code" := '';
                        Sector := '';
                        "Sector  Description" := '';
                        "Department Category" := '';
                        "Department Categ.  Description" := '';

                        "Group Code" := '';
                        "Group Description" := '';
                        "Team Code" := '';
                        "Team Description" := '';


                    END;
                END
            end;
        }
        field(50011; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group temporary".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Team Code" = '' THEN BEGIN
                    Department.RESET;
                    Department.SETFILTER("Group Description", '%1', "Group Description");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Group Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Group Code");
                            VALIDATE("Group Code", Department."Group Code");
                            VALIDATE("Department Category", Department."Department Category");
                            VALIDATE("Department Categ.  Description", Department."Department Categ.  Description");
                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                        "Department Code" := Department."Group Code";
                        "Group Code" := Department."Group Code";
                        "Group Description" := Department."Group Description";
                        Sector := Department.Sector;
                        "Sector  Description" := Department."Sector  Description";
                        "Department Category" := Department."Department Category";
                        "Department Categ.  Description" := Department."Department Categ.  Description";

                        "Team Code" := '';
                        "Team Description" := '';
                    END
                    ELSE BEGIN
                        Sector := '';
                        "Sector  Description" := '';
                        "Department Category" := '';
                        "Department Categ.  Description" := '';
                        "Group Code" := '';
                        "Group Description" := '';
                        "Department Code" := '';
                        "Team Code" := '';
                        "Team Description" := '';

                    END;
                END
            end;
        }
        field(50012; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = "Team temporary".Code WHERE("Org Shema" = FIELD("ORG Shema"));

        }
        field(50013; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = "Team temporary".Name WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                Department.RESET;
                Department.SETFILTER("Team Description", '%1', "Team Description");
                IF Department.FIND('-') THEN BEGIN

                    "Team Description" := Department."Team Description";
                    IF "Team Description" <> '' THEN BEGIN
                        VALIDATE("Team Code", Department."Team Code");
                        VALIDATE("Department Code", Department."Team Code");
                        VALIDATE("Group Code", Department."Group Code");
                        VALIDATE("Group Description", Department."Group Description");
                        VALIDATE("Department Category", Department."Department Category");
                        VALIDATE("Department Categ.  Description", Department."Department Categ.  Description");
                        VALIDATE(Sector, Department.Sector);
                        VALIDATE("Sector  Description", Department."Sector  Description");
                    END;
                    "Department Code" := Department."Team Code";
                    "Group Code" := Department."Group Code";
                    "Group Description" := Department."Group Description";
                    Sector := Department.Sector;
                    "Sector  Description" := Department."Sector  Description";
                    "Department Category" := Department."Department Category";
                    "Department Categ.  Description" := Department."Department Categ.  Description";
                    "Team Code" := Department."Team Code";
                    "Team Description" := Department."Team Description";

                END
                ELSE BEGIN
                    Sector := '';
                    "Sector  Description" := '';
                    "Department Category" := '';
                    "Department Categ.  Description" := '';
                    "Group Code" := '';
                    "Group Description" := '';
                    "Department Code" := '';
                    "Team Code" := '';
                    "Team Description" := '';

                END;
            end;
        }
        field(50365; "Management Level"; enum "Management Level")
        {
            Caption = 'Management Level';

        }
        field(50366; "Head's number of employee"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Position WHERE("Manager 1 Code" = FIELD("Employee No."),
                                                "Org. Structure" = FIELD("ORG Shema")));
            Caption = 'Head''s number of employee';

        }
    }

    keys
    {
        key(Key1; "Department Code", "ORG Shema", "Department Categ.  Description", "Group Description", "Team Description", "Management Level", "Position Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        OS: Record "ORG Shema";
        Sec: Record "Sector temporary";
        Dep: Record "Department Category temporary";
        Gr: Record "Group temporary";
        Team: Record "Team temporary";
        Department: Record "Department temporary";
}

