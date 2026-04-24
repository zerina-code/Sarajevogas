table 50122 Vocation
{
    Caption = 'Vocation';
    DrillDownPageID = "Vocation";
    LookupPageID = Vocation;

    fields
    {
        field(1; "Table Name"; Option)
        {
            Caption = 'Table Name';
            OptionCaption = 'Work Center,Machine Center,Routing Header,Production BOM Header';
            OptionMembers = "Work Center","Machine Center","Routing Header","Production BOM Header";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(6; Comment; Text[80])
        {
            Caption = 'Comment';
        }
        field(50000; "Description New"; Text[150])
        {
            Caption = 'Description';
        }
        field(50001; "No. Old"; Code[20])
        {
            Caption = 'No.';
        }
        field(50002; "Description Old"; Text[150])
        {
            Caption = 'Description';
            InitValue = '5';
            NotBlank = false;
        }
    }

    keys
    {
        key(Key1; "Code", "Description New", "No. Old", "Description Old")
        {
        }
        key(Key2; "Description New")
        {
        }
        key(Key3; "No. Old")
        {
        }
        key(Key4; "Description Old")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(FieldGoroup; "Code", "Description New", "No. Old", "Description New")
        {
        }
    }

    procedure SetUpNewLine()
    var
        CommentLine: Record "Vocation";
    begin
        /*CommentLine.SETRANGE("Table Name","Table Name");
        CommentLine.SETRANGE("No.","No.");
        CommentLine.SETRANGE(Date,WORKDATE);
        IF NOT CommentLine.FINDFIRST THEN
          Date := WORKDATE;
        */

    end;
}

