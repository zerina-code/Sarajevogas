table 50084 "Head Of's"
{
    Caption = 'Head Off''s';
    DrillDownPageID = "Head Of's";
    LookupPageID = "Head Of's";

    fields
    {
        field(1; "Department Code"; Code[30])
        {
            Caption = 'Department Code';
            TableRelation = Department."Code" WHERE("ORG Shema" = FIELD("ORG Shema"));
        }
        field(2; "Position Code"; Code[30])
        {
            Caption = 'Position Code';
            TableRelation = "Position Menu"."Code" WHERE("Org. Structure" = FIELD("ORG Shema"));
        }
        field(6; "Employee No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee No." WHERE("Org. Structure" = FIELD("ORG Shema"),
                                                                                  "Position Code" = FIELD("Position Code"),
                                                                                  "Department Cat. Description" = FIELD("Department Categ.  Description"),
                                                                                  "Group Description" = FIELD("Group Description"),
                                                                                  "Team Description" = FIELD("Team Description"),
                                                                                  "Department Code" = FIELD("Department Code"),
                                                                                  Status = FILTER(Active),
                                                                                  "Show Record" = FILTER(false | true)));
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
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));

        }
        field(50002; "Employee Last Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));

        }
        field(50003; "Department Name"; Text[200])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department.Description WHERE("Code" = FIELD("Department Code"),
                                                               "ORG Shema" = FIELD("ORG Shema")));
            Caption = 'Department Name';
            Editable = false;

        }
        field(50004; "Position Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Position Menu".Description WHERE("Code" = FIELD("Position Code"),
                                                            "Org. Structure" = FIELD("ORG Shema"),
                                                            "Department Code" = field("Department Code")
                                                            ));
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
            TableRelation = Sector."Code" WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50007; "Department Category"; Code[30])
        {
            Caption = 'Department';
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                ;

            end;
        }
        field(50008; "Group Code"; Code[30])
        {
            Caption = 'Group';
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(50009; "Sector  Description"; Text[250])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '') AND ("Department Category" = '')) THEN BEGIN
                    Department.SETFILTER("Sector  Description", '%1', "Sector  Description");
                    Department.SETFILTER("ORG Shema", '%1', Rec."ORG Shema");
                    IF Department.FIND('-') THEN BEGIN

                        "Sector  Description" := Department."Sector  Description";
                        IF "Sector  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department.Sector);

                            VALIDATE(Sector, Department.Sector);

                        END;
                    END;
                END
            end;
        }
        field(50010; "Department Categ.  Description"; Text[150])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF (("Team Code" = '') AND ("Group Code" = '')) THEN BEGIN
                    Department.SETFILTER("Department Categ.  Description", '%1', "Department Categ.  Description");
                    Department.SETFILTER("ORG Shema", '%1', Rec."ORG Shema");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Department Categ.  Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Department Category");
                            VALIDATE("Department Category", Department."Department Category");

                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                    END;
                END
            end;
        }
        field(50011; "Group Description"; Text[150])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = "Group".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Team Code" = '' THEN BEGIN
                    Department.SETFILTER("Group Description", '%1', "Group Description");
                    Department.SETFILTER("ORG Shema", '%1', Rec."ORG Shema");
                    IF Department.FIND('-') THEN BEGIN


                        IF "Group Description" <> '' THEN BEGIN

                            VALIDATE("Department Code", Department."Group Code");
                            VALIDATE("Group Code", Department."Group Code");
                            VALIDATE("Department Category", Department."Department Category");
                            VALIDATE("Department Categ.  Description", Department."Department Categ.  Description");
                            VALIDATE(Sector, Department.Sector);
                            VALIDATE("Sector  Description", Department."Sector  Description");
                        END;
                    END;
                END
            end;
        }
        field(50012; "Team Code"; Code[30])
        {
            Caption = 'Team';
            Editable = false;
        }
        field(50013; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT.Name WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                Department.SETFILTER("Team Description", '%1', "Team Description");
                Department.SETFILTER("ORG Shema", '%1', Rec."ORG Shema");
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
                END;
            end;
        }
        field(50365; "Management Level"; Enum "Management Level")
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
        Sec: Record "Sector";
        Dep: Record "Department Category";
        Gr: Record "Group";
        Team: Record "TeamT";
        Department: Record "Department";
}

