table 50043 Department
{
    // //

    Caption = 'Department';
    DrillDownPageID = "Department";
    LookupPageID = "Department";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                //Sektor
                SectorT.RESET;
                SectorT.SETFILTER(Code, '%1', Rec.Code);
                SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
                IF SectorT.FINDFIRST THEN BEGIN

                    if SectorT.CEO = true then
                        Rec."Department Type" := Rec."Department Type"::CEO
                    else
                        Rec."Department Type" := Rec."Department Type"::Sector;


                    VALIDATE("Sector  Description", SectorT.Description);

                    Description := SectorT.Description;
                    SectorT.RESET;
                    SectorT.SETFILTER(Description, '%1', SectorT.Description);
                    IF SectorT.FINDFIRST THEN
                        Sector := SectorT.Code;


                END;

                //Služba
                DepartmentCategoryT.RESET;
                DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
                DepartmentCategoryT.SETFILTER(Code, '%1', Rec.Code);
                IF DepartmentCategoryT.FINDFIRST THEN BEGIN

                    "Department Type" := "Department Type"::"Department Category";

                    Description := DepartmentCategoryT.Description;

                    VALIDATE("Department Categ.  Description", DepartmentCategoryT.Description);
                    Validate("Sector  Description", DepartmentCategoryT."Sector Belongs");


                END;

                //Odjel
                GroupT.RESET;
                GroupT.SETFILTER("Org Shema", '%1', "ORG Shema");
                GroupT.SETFILTER(Code, '%1', Rec.Code);
                IF GroupT.FINDFIRST THEN BEGIN


                    "Department Type" := "Department Type"::Group;

                    Description := GroupT.Description;
                    VALIDATE("Group Description", GroupT.Description);

                    "Group Code" := Rec.Code;

                    VALIDATE("Department Categ.  Description", GroupT."Belongs to Department Category");
                    //Služba
                    DepartmentCategoryT.RESET;
                    DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
                    DepartmentCategoryT.SETFILTER(Description, '%1', GroupT."Belongs to Department Category");
                    IF DepartmentCategoryT.FINDFIRST THEN BEGIN
                        VALIDATE("Sector  Description", DepartmentCategoryT."Sector Belongs");
                    end
                    else begin
                        Validate("Sector  Description", '');
                    end;


                END;
            END;

        }
        field(2; Description; Text[130])
        {
            Caption = 'Description';


        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Direction,Sector,Department';
            OptionMembers = " ",Direction,Sector,Department;
        }
        field(4; "Sector Code"; Code[30])
        {
            Caption = 'Sector code';
            TableRelation = IF (Type = CONST(Department)) Department.Code WHERE(Type = CONST(Sector));
        }
        field(5; Address; Text[50])
        {
            Caption = 'Address';
            FieldClass = Normal;


        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            TableRelation = "Post Code".City;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(8; Sector; Code[30])
        {
            Caption = 'Sector';
            TableRelation = Sector.Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF Sector <> '' THEN BEGIN
                    "B-1Rec".RESET;
                    "B-1Rec".SETFILTER(Code, Sector);
                    "B-1Rec".SETFILTER("Org Shema", "ORG Shema");
                    IF "B-1Rec".FINDFIRST THEN
                        "Sector  Description" := "B-1Rec".Description;

                END
                ELSE
                    "Sector  Description" := '';
                if ("Department Type" = "Department Type"::CEO) or ("Department Type" = "Department Type"::Sector) then
                    Description := Rec."Sector  Description";

            end;
        }
        field(9; "Department Category"; Code[20])
        {
            Caption = 'Department';
            Editable = true;
            TableRelation = "Department Category".Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Department Category" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Code, "Department Category");
                    "B-1WithRegions".SETFILTER("Org Shema", "ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN
                        "Department Categ.  Description" := "B-1WithRegions".Description;


                END
                ELSE
                    "Department Categ.  Description" := '';

                if ("Department Type" = "Department Type"::"Department Category") then
                    Description := Rec."Department Categ.  Description";

            end;
        }
        field(10; "Group Code"; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            TableRelation = Group.Code WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                GroupT.Reset();
                GroupT.SetFilter(Code, '%1', Rec."Group Code");
                GroupT.SetFilter("Org Shema", '%1', Rec."ORG Shema");
                if GroupT.FindFirst() then begin
                    "Group Description" := GroupT.Description;
                    Validate("Group Description", "Group Description");

                end


            end;
        }
        field(11; "Sector  Description"; Text[130])
        {
            Caption = 'Sector Description';
            Editable = true;
            TableRelation = Sector.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Sector  Description" <> '' THEN BEGIN
                    SectorR.RESET;
                    SectorR.SETFILTER(Description, '%1', "Sector  Description");
                    SectorR.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF SectorR.FINDFIRST THEN BEGIN
                        Sector := SectorR.Code;

                    END
                    ELSE BEGIN
                        Sector := '';

                    END;
                END
                ELSE BEGIN
                    "Sector  Description" := '';
                    Sector := '';

                END;
                if ("Department Type" = "Department Type"::CEO) or ("Department Type" = "Department Type"::Sector) then
                    Description := Rec."Sector  Description";


            end;
        }
        field(12; "Department Categ.  Description"; Text[85])
        {
            Caption = 'Department (description)';
            Editable = true;
            TableRelation = "Department Category".Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Department Categ.  Description" <> '' THEN BEGIN
                    "B-1WithRegions".RESET;
                    "B-1WithRegions".SETFILTER(Description, '%1', "Department Categ.  Description");
                    "B-1WithRegions".SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF "B-1WithRegions".FINDFIRST THEN BEGIN
                        "Department Category" := "B-1WithRegions".Code;
                        Validate("Sector  Description", "B-1WithRegions"."Sector Belongs");

                    END;
                END;
                IF "Department Categ.  Description" = '' THEN BEGIN
                    "Department Category" := '';
                    //   Validate("Sector  Description", '');

                END;
                if ("Department Type" = "Department Type"::"Department Category") then
                    Description := Rec."Department Categ.  Description";
            end;
        }
        field(13; "Group Description"; Text[85])
        {
            Caption = 'Group Description';
            Editable = true;
            TableRelation = Group.Description WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin

                IF "Group Description" <> '' THEN BEGIN
                    StreamRec.RESET;
                    StreamRec.SETFILTER(Description, '%1', "Group Description");
                    StreamRec.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF StreamRec.FINDFIRST THEN BEGIN
                        "Group Code" := StreamRec.Code;
                        Validate("Department Categ.  Description", StreamRec."Belongs to Department Category");

                        DepartmentCategoryT.Reset();
                        DepartmentCategoryT.SetFilter(Description, StreamRec."Belongs to Department Category");
                        DepartmentCategoryT.SetFilter("Org Shema", StreamRec."Org Shema");
                        if DepartmentCategoryT.FindFirst() then
                            Validate("Sector  Description", DepartmentCategoryT."Sector Belongs")
                        else
                            Validate("Sector  Description", '');

                    END;
                END
                ELSE BEGIN
                    "Group Code" := '';
                    "Department Category" := '';
                    "Department Categ.  Description" := '';
                    "Sector Code" := '';
                    "Sector  Description" := '';

                END;

                if ("Department Type" = "Department Type"::Group) then
                    Description := Rec."Group Description";
            end;
        }
        field(14; Municipality; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("ORG Dijelovi"."Municipality Code" WHERE("Code" = FIELD("ORG Dio")));
            Caption = 'Municipality';

        }
        field(15; "Department ID"; Text[50])
        {
            Caption = 'Department ID';
        }
        field(16; "Department IC"; Text[30])
        {
            Caption = 'IC';
        }
        field(18; "Residence/Network"; Option)
        {
            Caption = 'Residence/Network';
            OptionCaption = ' ,Residence,Network';
            OptionMembers = " ",Residence,Network;
        }
        field(19; "Timesheets administrator"; Code[10])
        {
            Caption = 'Timesheets administrator';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin

            end;
        }
        field(20; "ORG Dio"; Code[10])
        {
            Caption = 'ORG Part';
            TableRelation = "ORG Dijelovi";
        }
        field(21; "Department Type"; enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(22; Amount; Decimal)
        {
        }
        field(23; "Timesheets administrator 2"; Code[10])
        {
            Caption = 'Timesheets administrator 2';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin

            end;
        }
        field(24; "Timesheets Manager"; Code[10])
        {
            Caption = 'Timesheets Manager';
            TableRelation = Employee WHERE(Status = CONST(Active));

            trigger OnValidate()
            begin

            end;
        }
        field(25; AmountHealth; Decimal)
        {
        }
        field(26; AmountTax; Decimal)
        {
        }
        field(27; "Cnfidential Clerk 1"; Code[10])
        {
            Caption = 'Cnfidential Clerk 1';

            trigger OnValidate()
            begin

            end;
        }
        field(28; "Confidential Clerk 1 Position"; Text[250])
        {
            Caption = 'Confidential Clerk 1 Position';
        }
        field(29; "Cnfidential Clerk 2"; Code[10])
        {
            Caption = 'Cnfidential Clerk 2';
            //  TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin

            end;
        }
        field(30; "Confidential Clerk 2 Position"; Text[250])
        {
            Caption = 'Confidential Clerk 2 Position';
        }
        field(31; "Confidential Clerk 1 Full Name"; Text[150])
        {
            Caption = 'Confidential Clerk 1 Full Name';
        }
        field(32; "Confidential Clerk 2 Full Name"; Text[150])
        {
            Caption = 'Confidential Clerk 1 Full Name';
        }
        field(33; "Start Date"; Date)
        {
            Caption = 'Start Date';
        }
        field(34; "Managing Org 1"; Code[30])
        {
            Caption = 'Managing Org 1';
            TableRelation = Department;
        }
        field(35; "Managing Org 2"; Code[30])
        {
            Caption = 'Managing Org 2';
            TableRelation = Department;
        }
        field(36; "Managing Org 3"; Code[30])
        {
            Caption = 'Managing Org 3';
            TableRelation = Department;
        }
        field(37; "Managing Org 4"; Code[30])
        {
            Caption = 'Managing Org 4';
            TableRelation = Department;
        }
        field(38; "Managing Org 5"; Code[30])
        {
            Caption = 'Managing Org 5';
            TableRelation = Department;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = true;
            TableRelation = Dimension;

            trigger OnValidate()
            begin


            end;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                          "Dimension Value Type" = FILTER("Standard"));

            trigger OnValidate()
            begin

            end;
        }
        field(41; "Dimension  Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE("Dimension Code" = FIELD("Dimension Code"),
                                                               "Code" = FIELD("Dimension Value Code")));
            Caption = 'Dimension Code';
            Editable = false;


            trigger OnValidate()
            begin
                /*IF NOT DimMgt.CheckDim("Dimension Code") THEN
                  ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(42; "Team Code"; Code[30])
        {
            Caption = 'Team';
            TableRelation = TeamT."Code" WHERE("Org Shema" = FIELD("ORG Shema"));
        }
        field(43; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            TableRelation = TeamT."Name" WHERE("Org Shema" = FIELD("ORG Shema"));

            trigger OnValidate()
            begin
                IF "Team Description" <> '' THEN BEGIN
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Name, "Team Description");
                    TeamRec.SETFILTER("Org Shema", "ORG Shema");
                    IF TeamRec.FINDFIRST THEN
                        "Team Code" := TeamRec.Code;
                    // "Team Description":= LOWERCASE(TeamRec.Name);
                END
                ELSE
                    "Team Code" := '';



                //

                IF "Team Description" <> '' THEN BEGIN
                    TeamRec.RESET;
                    TeamRec.SETFILTER(Description, '%1', "Team Description");
                    TeamRec.SETFILTER("Org Shema", '%1', "ORG Shema");
                    IF TeamRec.FINDFIRST THEN BEGIN
                        "Team Code" := TeamRec.Code;
                        "Department Team identity" := "B-1WithRegions".Identity;
                    END
                    ELSE BEGIN
                        "Team Code" := '';
                        "Department Team identity" := 0;
                    END;
                END
                ELSE BEGIN
                    "Team Code" := '';
                    "Department Team identity" := 0;
                    "Team Description" := '';
                END;
            end;
        }
        field(45; "Signatory 1"; Code[10])
        {
            Caption = 'Signatory person 1 ';
            // TableRelation = "Confidential Clerks"."Employee No.";
            TableRelation = Employee."No.";

            //kontrola

            trigger OnValidate()
            begin

            end;
        }
        field(46; "Signatory 2"; Code[10])
        {
            Caption = 'Signatory person 2';
            // TableRelation = "Confidential Clerks"."Employee No.";

            TableRelation = Employee."No.";

            trigger OnValidate()
            begin

            end;
        }
        field(47; "Signatory 1 Position"; Text[250])
        {
            Caption = 'Signatory person 1 Position';
            // Editable = false;
            TableRelation = Employee."No.";
        }
        field(48; "Signatory 2 Position"; Text[250])
        {
            Caption = 'Signatory person 2 Position';
            Editable = false;
        }
        field(49; "Signatory 1 Full Name"; Text[150])
        {
            Caption = 'Signatory person 1 Full Name';
        }
        field(50; "Signatory 2 Full Name"; Text[150])
        {
            Caption = 'Signatory person 2 Full Name';
        }
        field(51; "Signatory 1 Contr With Benef"; Code[10])
        {
            Caption = 'Signatory 1 Contract With Benefits';
            // TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin

            end;
        }
        field(52; "Signatory 1 With Benef Name"; Text[250])
        {
            Caption = 'Signatory 1 Contract With Benefits Full Name';
        }
        field(53; "Signatory 2 Contr With Benef"; Code[10])
        {
            Caption = 'Signatory 2 - Contract With Benefits';
            //   TableRelation = "Confidential Clerks"."Employee No.";

            trigger OnValidate()
            begin

            end;
        }
        field(54; "Signatory 2 With Benef Name"; Text[250])
        {
            Caption = 'Signatory 1 Contract With Benefits Full Name;';
        }
        field(55; "Changing Department"; Boolean)
        {
            Caption = 'Changing Department';

            trigger OnValidate()
            begin


            end;
        }
        field(56; "Changing Group"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Group"."Changing Department" WHERE("Code" = FIELD("Code"),
                                                                    "Org Shema" = FIELD("ORG Shema")));
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
        field(50005; "Sector Identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50006; "Department Idenity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50007; "Department Changing"; Boolean)
        {
            Caption = 'Department Changing';
        }
        field(50008; "Department Group identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50009; "Department Team identity"; Integer)
        {
            BlankZero = true;
            NotBlank = false;
        }
        field(50026; "Entity of Agency"; Option)
        {
            Caption = 'Entity of Agency';
            OptionCaption = ' ,FBIH,RS';
            OptionMembers = " ",FBIH,RS;
        }
        field(50027; "Prip Realisation"; code[20])
        {
            Caption = 'Prip Realisation';
            TableRelation = Employee."No.";
        }
        field(50028; "Prip Control"; code[20])
        {
            Caption = 'Prip Control';
            TableRelation = Employee."No.";
        }
        field(50029; "Prip Verif"; code[20])
        {
            Caption = 'Prip Verif';
            TableRelation = Employee."No.";
        }
        field(50030; "Short Code"; code[20])
        {
            Caption = 'Short Code';

        }
    }

    keys
    {
        key(Key1; "Code", "ORG Shema", "Team Description", "Department Categ.  Description", "Group Description", Description)
        {
        }
        key(Key2; Description)
        {
        }
        key(Key3; "ORG Shema", "ORG Dio")
        {
        }
        key(Key4; "Team Description")
        {
        }
        key(Key5; "Department Categ.  Description")
        {
        }
        key(Key6; "Group Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Team Description", "Group Description", "Department Categ.  Description", "Sector  Description")
        {
        }
    }

    trigger OnDelete()
    begin
        //zabraniti da obrišu šta ne smiju
        SectorT.RESET;
        SectorT.SETFILTER(Code, '%1', Rec.Code);
        SectorT.SETFILTER("Org Shema", '%1', "ORG Shema");
        IF SectorT.FINDFIRST THEN BEGIN
            Error('Prvobitno morate obrisati podatke u šifarniku Sektora!');
        end;


        DepartmentCategoryT.RESET;
        DepartmentCategoryT.SETFILTER(Code, '%1', Rec.Code);
        DepartmentCategoryT.SETFILTER("Org Shema", '%1', "ORG Shema");
        IF DepartmentCategoryT.FINDFIRST THEN BEGIN
            Error('Prvobitno morate obrisati podatke u šifarniku Službe!');
        end;



        GroupT.RESET;
        GroupT.SETFILTER(Code, '%1', Rec.Code);
        GroupT.SETFILTER("Org Shema", '%1', "ORG Shema");
        IF GroupT.FINDFIRST THEN BEGIN
            Error('Prvobitno morate obrisati podatke u šifarniku Odjeli!');
        end;




        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)
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

        lvarActiveConnection: Variant;
        "B-1Rec": Record "Sector";
        "B-1WithRegions": Record "Department Category";
        StreamRec: Record "Group";
        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";

        lvarActiveConnectionAdm2: Variant;

        OS: Record "ORG Shema";
        TeamRec: Record "TeamT";
        LengthCode: Integer;

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
        SectorT: Record "Sector";
        Zapis: Integer;
        DepartmentCategoryT: Record "Department Category";
        GroupT: Record "Group";
        TeamT: Record "TeamT";
        String: Text;
        Brojac: Integer;
        i: Integer;
        j: Integer;
        K: Integer;
        z: Integer;
}

