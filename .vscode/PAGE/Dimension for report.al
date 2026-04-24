table 50164 "Dimension for report"
{
    Caption = 'Dimension temporary';
    //  DrillDownPageID = "Dimensions for report";
    // LookupPageID = "Dimensions for report";

    fields
    {
        field(1; "Code"; Code[30])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin



            end;
        }
        field(2; Description; Text[200])
        {
            Caption = 'Description';

            trigger OnValidate()
            begin


            end;
        }
        field(7; "ORG Shema"; Code[6])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(8; Sector; Code[30])
        {
            Caption = 'Sector';
            // TableRelation = WBank."Employee No";

            trigger OnValidate()
            begin



            end;
        }
        field(9; "Department Category"; Code[30])
        {
            Caption = 'Department';
            Editable = true;
            //ĐK TableRelation = Table60002.Field1;

            trigger OnValidate()
            begin


            end;
        }
        field(10; "Group Code"; Code[30])
        {
            Caption = 'Group';
            Editable = true;
            //ĐK  TableRelation = Table60003.Field1;

            trigger OnValidate()
            begin



            end;
        }
        field(11; "Sector  Description"; Text[200])
        {
            Caption = 'Sector Description';
            Editable = true;
            //TableRelation = WBank."Bank Account No";

            trigger OnValidate()
            begin


            end;
        }
        field(12; "Department Categ.  Description"; Text[85])
        {
            Caption = 'Department (description)';
            Editable = true;
            // ĐKTableRelation = Table60002.Field50000 WHERE (Field50001=FIELD(ORG Shema));

            trigger OnValidate()
            begin


            end;
        }
        field(13; "Group Description"; Text[85])
        {
            Caption = 'Group Description';
            Editable = true;
            // ĐK TableRelation = Table60003.Field10 WHERE (Field50000=FIELD(ORG Shema));

            trigger OnValidate()
            begin


            end;
        }
        field(21; "Department Type"; Option)
        {
            Caption = 'Department Type';
            OptionCaption = ' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team';
            OptionMembers = " ",GM,Group,CEO,Department,"Branch Office",Region,"Regional Center",Sector,Team;
        }
        field(39; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            Editable = false;

            trigger OnValidate()
            begin


            end;
        }
        field(40; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';
            //ĐK  Editable = false;
            TableRelation = "Dimension Value".Code WHERE(Status = CONST(A));

            trigger OnValidate()
            begin

                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Code, '%1', Rec."Dimension Value Code");
                DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                IF DimensionValueTable.FINDFIRST THEN BEGIN
                    "Dimension  Name" := DimensionValueTable.Name;

                END
                ELSE BEGIN
                    "Dimension  Name" := '';

                END;
                VALIDATE("Dimension  Name", rec."Dimension  Name");

            end;
        }
        field(41; "Dimension  Name"; Text[250])
        {
            Caption = 'Dimension Code';
            Editable = true;
            FieldClass = Normal;
            TableRelation = "Dimension Value".Name WHERE(Status = CONST(A));


            trigger OnValidate()
            begin


                DimensionValueTable.RESET;
                DimensionValueTable.SETFILTER(Name, '%1', Rec."Dimension  Name");
                DimensionValueTable.SETFILTER(Status, '%1', DimensionValueTable.Status::A);
                IF DimensionValueTable.FINDFIRST THEN BEGIN
                    "Dimension Value Code" := DimensionValueTable.Code;

                END
                ELSE BEGIN
                    "Dimension Value Code" := '';

                END;


                //Position Code,Dimension Value Code,ORG Shema,Position Description

            end;
        }
        field(43; "Team Code"; Code[30])
        {
            Caption = 'Team';
            // ĐK TableRelation = Table60004.Field1;
        }
        field(44; "Team Description"; Text[100])
        {
            Caption = 'Team Description';
            Editable = true;
            //ĐK   TableRelation = Table60004.Field2 WHERE (Field50000=FIELD(ORG Shema));

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
        field(50005; Belongs; Text[200])
        {
            Caption = 'belong';

            trigger OnValidate()
            begin


            end;
        }
    }

    keys
    {
        key(Key1; "Code", "Dimension Value Code", "Team Description", "Department Categ.  Description", "Group Description", "Group Code", "ORG Shema")
        {
        }
        key(Key2; "Dimension Value Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, Sector, "Department Category", "Group Code", "Sector  Description", "Department Categ.  Description", "Group Description", "Team Code", "Team Description")
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
        //  WPConnSetup: Record "Web portal connection setup";

        Employee: Record "Employee";
        WC: Record "Wage Calculation";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";
        Emp: Record "Employee";

        // Position: Record "Confidential Clerks";
        //Position2: Record "Confidential Clerks";
        OS: Record "ORG Shema";
        //     TeamRec: Record "Team temporary";
        LengthCode: Integer;
        // Tip: Record "Type";
        OrgStr: Record "ORG Shema";
        Dimension: Record "Dimension";
        String: Text;
        Brojac: Integer;
        String1: Text;
        LengthString: Integer;
        I: Integer;
        DimensionValueTable: Record "Dimension Value";
}

