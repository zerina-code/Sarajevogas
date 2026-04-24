/*table 50165 "Employee Benefits"
{
    // //

    Caption = 'Misc. Article Information';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = 50100;
    LookupPageID = 50100;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;
        }
        field(2; "Misc. Article Code"; Integer)
        {
            Caption = 'Misc. Article Code';
            NotBlank = false;
            TableRelation = "Misc. Article";

            trigger OnValidate()
            begin
               

            end;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(4; Description; Text[50])
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
            FieldClass = FlowField;
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Misc. Article Information"),
                                                                     "No." = FIELD("Employee No."),
                                                                     //"Alternative Address Code" = FIELD("Misc. Article Code"),
                                                                     "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;

        }
        field(9; "Serial No."; Text[30])
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
            AutoIncrement = false;
            Caption = 'Emp. Contract Ledg. Entry No.';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Employee No.", "Misc. Article Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        IF Comment THEN
            ERROR(Text000);
    end;

    trigger OnInsert()
    var
        MiscArticleInfo: Record "Misc. article information new";
    begin
        MiscArticleInfo.SETCURRENTKEY("Line No.");
        IF MiscArticleInfo.FINDLAST THEN
            "Line No." := MiscArticleInfo."Line No." + 1
        ELSE
            "Line No." := 1;
    end;

    var
        Text000: Label 'You cannot delete information if there are comments associated with it.';
        MiscArticle: Record "Misc. Article";
}

*/