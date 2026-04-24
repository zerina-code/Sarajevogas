table 50181 TeamT
{
    Caption = 'Team';
    //ĐK DataCaptionFields = "Code", Name;
    //  DrillDownPageID = TeamsP;
    // LookupPageID = TeamsP;

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
        }
        field(3; "Next To-do Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Min("To-do"."Date" WHERE("Team Code" = FIELD("Code"),
                                                "Closed" = CONST(false)));
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
            FieldClass = FlowFilter;
            Caption = 'Contact Company Filter';

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
                                             "Status" = FIELD("To-do Status Filter"),
                                             "Closed" = FIELD("To-do Closed Filter"),
                                             "Priority" = FIELD("Priority Filter"),
                                             "Date" = FIELD("Date Filter")));
            Caption = 'To-do Entry Exists';
            Editable = false;

        }
        field(50000; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema"."Code";
        }
        field(50001; Description; Text[30])
        {

            trigger OnValidate()
            begin


            end;
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
        field(50018; "Belongs to Group"; Text[250])
        {
            Caption = 'Belongs to Group';
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("Org Shema"));

            trigger OnValidate()
            begin
                IF "Belongs to Group" <> '' THEN BEGIN
                    DepartmentRename.RESET;
                    DepartmentRename.SETFILTER("Department Type", '%1', 9);
                    DepartmentRename.SETFILTER("Team Code", '%1', Rec.Code);
                    DepartmentRename.SETFILTER("Team Description", '%1', Rec.Description);
                    IF DepartmentRename.FINDFIRST THEN BEGIN
                        DepartmentRename."Group Description" := "Belongs to Group";

                        IF DepartmentRename.GET(DepartmentRename.Code, DepartmentRename."ORG Shema", DepartmentRename."Team Description",
                          DepartmentRename."Department Categ.  Description", DepartmentRename."Group Description", DepartmentRename.Description)
                          THEN
                            DepartmentRename.RENAME(DepartmentRename.Code, DepartmentRename."ORG Shema", DepartmentRename."Team Description",
                            DepartmentRename."Department Categ.  Description", "Belongs to Group", DepartmentRename.Description);
                        FindCodeForDep.RESET;
                        FindCodeForDep.SETFILTER(Description, '%1', "Belongs to Group");
                        IF FindCodeForDep.FINDFIRST THEN BEGIN
                            DepartmentRename."Group Code" := FindCodeForDep.Code;
                        END
                        ELSE BEGIN
                            DepartmentRename."Group Code" := '';
                        END;
                        DepartmentRename.MODIFY;
                        DepartmentRename1.RESET;
                        DepartmentRename1.SETFILTER("Department Type", '%1', 2);
                        DepartmentRename1.SETFILTER("Group Code", '%1', FindCodeForDep.Code);
                        DepartmentRename1.SETFILTER("Group Description", '%1', "Belongs to Group");
                        IF DepartmentRename1.FINDFIRST THEN BEGIN
                            IF DepartmentRename.GET(DepartmentRename.Code, DepartmentRename."ORG Shema", DepartmentRename."Team Description",
                          DepartmentRename1."Department Categ.  Description", DepartmentRename."Group Description", DepartmentRename.Description)
                          THEN
                                DepartmentRename."Department Category" := DepartmentRename1."Department Category";
                            DepartmentRename.Sector := DepartmentRename1.Sector;
                            DepartmentRename."Sector  Description" := DepartmentRename1."Sector  Description";
                        END;

                        DepartmentRename.MODIFY;



                    END;
                END;

            end;
        }
        field(50019; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;

            trigger OnValidate()
            begin
                IF FORMAT(Rec."Residence/Network") <> '' THEN BEGIN
                    IF Code <> '' THEN BEGIN
                        IF Name <> '' THEN BEGIN
                            DepartmentTemp.RESET;
                            DepartmentTemp.SETFILTER("Team Code", '%1', Rec.Code);
                            DepartmentTemp.SETFILTER("Team Description", '%1', Rec.Name);
                            DepartmentTemp.SETFILTER("Department Type", '%1', 9);
                            IF DepartmentTemp.FINDFIRST THEN BEGIN
                                "Residence/Network" := DepartmentTemp."Residence/Network";
                                DepartmentTemp.MODIFY;
                            END;

                        END;
                    END;
                END;
            end;
        }
        field(50020; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(50021; Belongs; Text[30])
        {
        }
        field(50022; Identity; Integer)
        {
            AutoIncrement = true;
            Editable = false;
        }
        field(50023; "Group Identity"; Integer)
        {
        }
        field(50025; "Identity Sector"; Integer)
        {
        }
        field(50029; "Entity Code"; Option)
        {
            Caption = 'Entity Code';
            FieldClass = Normal;
            OptionCaption = ' ,FBIH,RS';
            OptionMembers = " ",FBIH,RS;
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
        fieldgroup(DropDown; Name, "Code", "Org Shema", "Entity Code")
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
        DepartmentRename: Record "Department";
        FindCodeForDep: Record "Group";
        DepartmentRename1: Record "Department";
        DepartmentTemp: Record "Department";
        ECLSET: Record "Employee Contract Ledger";
}

