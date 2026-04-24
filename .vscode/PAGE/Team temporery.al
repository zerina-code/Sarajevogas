table 50168 "Team temporary"
{
    Caption = 'Team';
    DataCaptionFields = "Code", Name;
    //  DrillDownPageID = "Team temporary sist";
    //LookupPageID = "Team temporary sist";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;

            trigger OnValidate()
            begin


            end;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';

            trigger OnValidate()
            begin


            end;
        }
        field(3; "Next To-do Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("To-do"."Date" WHERE("Team Code" = FIELD("Code"),
                                                Closed = CONST(false)));
            Caption = 'Next To-do Date';
            Editable = false;

        }
        field(4; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(5; "Contact Filter"; Code[20])
        {
            Caption = 'Contact Filter';
            FieldClass = FlowFilter;
            TableRelation = Contact;
        }
        field(6; "Contact Company Filter"; Code[20])
        {
            Caption = 'Contact Company Filter';
            FieldClass = FlowFilter;
            TableRelation = Contact WHERE(Type = CONST(Company));
        }
        field(7; "To-do Status Filter"; Option)
        {
            Caption = 'To-do Status Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Not Started,In Progress,Completed,Waiting,Postponed';
            OptionMembers = "Not Started","In Progress",Completed,Waiting,Postponed;
        }
        field(8; "To-do Closed Filter"; Boolean)
        {
            Caption = 'To-do Closed Filter';
            FieldClass = FlowFilter;
        }
        field(9; "Priority Filter"; Option)
        {
            Caption = 'Priority Filter';
            FieldClass = FlowFilter;
            OptionCaption = 'Low,Normal,High';
            OptionMembers = Low,Normal,High;
        }
        field(11; "Salesperson Filter"; Code[20])
        {
            Caption = 'Salesperson Filter';
            FieldClass = FlowFilter;
            TableRelation = "Salesperson/Purchaser";
        }
        field(12; "Campaign Filter"; Code[20])
        {
            Caption = 'Campaign Filter';
            FieldClass = FlowFilter;
            TableRelation = Campaign;
        }
        field(13; "To-do Entry Exists"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Exist("To-do" WHERE("Team Code" = FIELD("Code"),
                                            "Contact No." = FIELD("Contact Filter"),
                                             "Contact Company No." = FIELD("Contact Company Filter"),
                                             "Salesperson Code" = FIELD("Salesperson Filter"),
                                             "Campaign No." = FIELD("Campaign Filter"),
                                             Status = FIELD("To-do Status Filter"),
                                             Closed = FIELD("To-do Closed Filter"),
                                             Priority = FIELD("Priority Filter"),
                                             "Date" = FIELD("Date Filter")));
            Caption = 'To-do Entry Exists';
            Editable = false;

        }
        field(50000; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50001; Description; Text[30])
        {
        }
        field(50002; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin


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
        field(50010; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension temporary"."Dimension Value Code" WHERE(Code = FIELD(Code));

            trigger OnValidate()
            begin

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


            end;
        }
        field(50012; "Number of dimension value"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Dimension temporary" WHERE("Team Description" = FIELD(Name),
                                                             // "Department Type" = CONST(Team),
                                                             "ORG Shema" = FIELD("Org Shema"),
                                                             "Group Description" = FIELD("Belongs to Group")));
            Caption = 'Number of dimension value';

        }
        field(50018; "Belongs to Group"; Text[250])
        {
            Caption = 'Belongs to Group';
            TableRelation = "Group temporary".Description;

            trigger OnValidate()
            begin


            end;
        }
        field(50019; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin



            end;
        }
        field(50020; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;

            trigger OnValidate()
            begin
                IF Code <> '' THEN BEGIN
                    IF Description <> '' THEN BEGIN
                        DepartmentTemp.RESET;
                        DepartmentTemp.SETFILTER("Team Code", '%1', Rec.Code);
                        DepartmentTemp.SETFILTER("Team Description", '%1', Rec.Description);
                        DepartmentTemp.SETFILTER("Department Type", '%1', 9);
                        IF DepartmentTemp.FINDFIRST THEN BEGIN
                            DepartmentTemp."Residence/Network" := "Department Type";
                            DepartmentTemp.MODIFY;
                        END;

                    END;
                END;
            end;
        }
        field(50022; Identity; Integer)
        {
            AutoIncrement = true;
        }
        field(50023; "Group Identity"; Integer)
        {
        }
        field(50024; LastModified; Text[250])
        {
            Caption = 'Last modified code';
        }
        field(50025; "Identity Sector"; Integer)
        {
        }
        field(50026; "Name of TC"; Text[250])
        {
            Caption = 'Name of TC';
        }
        field(50029; "Entity Code"; Option)
        {
            Caption = 'Entity Code';
            OptionCaption = ' ,FBIH,RS';
            OptionMembers = " ",FBIH,RS;
        }
        field(500400; "Fields for change"; Text[30])
        {
            Caption = 'Fields for change';
        }
        field(500401; IsTrue; Boolean)
        {
        }
        field(500402; "Official Translate of Team"; Text[250])
        {
            Caption = 'Official Translate of team';
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
        key(Key1; "Code", Name, "Org Shema", Description)
        {
        }
        key(Key2; Name)
        {
        }
        key(Key3; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Name, "Code", "Org Shema")
        {
        }
    }

    trigger OnDelete()
    var
        TeamSalesperson: Record "Team Salesperson";
    begin
        TeamSalesperson.RESET;
        TeamSalesperson.SETRANGE("Team Code", Code);
        TeamSalesperson.DELETEALL;
        DepTemDelete.RESET;
        DepTemDelete.SETFILTER("Department Type", '%1', 9);
        DepTemDelete.SETFILTER("Team Code", '%1', Rec.Code);
        DepTemDelete.SETFILTER("Team Description", '%1', Rec.Name);
        IF DepTemDelete.FINDFIRST THEN
            DepTemDelete.DELETE;
    end;

    trigger OnInsert()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)
    end;

    var
        Dep: Record "Department";
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
        brojac: Integer;
        LengthString: Integer;
        i: Integer;
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
        Text002: Label 'This code is wrong';
        SectorLength: Integer;
        TeamTempInt: Record "Team temporary";
        DepTemDelete: Record "Department temporary";

    procedure SetParam("Code": Code[10]; Description: Text)
    begin
        Code := Rec.Code;
        Description := Rec.Description;
    end;
}

