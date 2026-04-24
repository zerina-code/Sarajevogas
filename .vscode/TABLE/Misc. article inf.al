/*table 50118 "Misc. article information new"
{
    DataClassification = ToBeClassified;
    Caption = 'Misc. article information';
    DrillDownPageId = "Misc Article Informations";
    LookupPageId = "Misc Article Informations";


    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
            trigger OnValidate()
            var
                myInt: Integer;
                E: Record Employee;
            begin
                e.Get("Employee No.");
                "Employee Name" := e."First Name" + ' ' + e."Last Name";

            end;
        }
        field(2; "Misc. Article Code"; Code[10])
        {
            Caption = 'Misc. Article Code';
            NotBlank = true;
            TableRelation = "Misc. Article";

            trigger OnValidate()
            begin
                if MiscArticle.Get("Misc. Article Code") then
                    Description := MiscArticle.Description
                else
                    Description := '';
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(5; "From Date"; Date)
        {
            Caption = 'From Date';
        }
        field(6; "To Date"; Date)
        {
            Caption = 'To Date';
        }
        field(7; "In Use"; Boolean)
        {
            Caption = 'In Use';
        }
        field(8; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Misc. Article Information"),
                                                                     "No." = FIELD("Employee No."),
                                                                     "Alternative Address Code" = FIELD("Misc. Article Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Serial No."; Text[50])
        {
            Caption = 'Serial No.';
        }
        field(50000; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(50001; "Position Code"; Code[20])
        {
            Caption = 'Position Code';
        }
        field(50002; "Emp. Contract Ledg. Entry No."; Integer)
        {
            //ĐK AutoIncrement = false;
            Caption = 'Emp. Contract Ledg. Entry No.';
        }
        field(50003; "Org Shema"; Code[10])
        {
            Caption = 'Org Shema';
            TableRelation = "ORG Shema".Code;
        }
        field(50004; Active; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger".Active WHERE("No." = FIELD("Emp. Contract Ledg. Entry No."),
                                                                          "Org. Structure" = FIELD("Org Shema"),
                                                                          Active = CONST(TRUE),
                                                                          "Employee No." = FIELD("Employee No.")));
            Caption = 'Active';

        }
        field(50005; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';

        }
    }


    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Line No.")
        {
        }
    }


    trigger OnInsert()
    var
        MiscArticleInfo: Record "Misc. article information new";
        UserSetup: Record "User Setup";
    begin
        MiscArticleInfo.SetCurrentKey("Line No.");
        if MiscArticleInfo.FindLast then
            "Line No." := MiscArticleInfo."Line No." + 1
        else
            "Line No." := 1;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            "Emp. Contract Ledg. Entry No." := UserSetup."Last ECL No.";
            "Org Shema" := UserSetup."Last Org Shema";

        end;


    end;

    var
        Text000: Label 'You cannot delete information if there are comments associated with it.';
        MiscArticle: Record "Misc. Article";

}*/