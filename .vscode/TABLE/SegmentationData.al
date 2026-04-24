/*table 50152 "Segmentation Data"
{
    Caption = 'Segmentation Data';
    DrillDownPageID = 5221;
    LookupPageID = 5221;

    fields
    {
        field(1; "Position No."; Code[20])
        {
            Caption = 'Position No.';
            NotBlank = true;
            TableRelation = Position;
        }
        field(2; "Segmentation Code"; Code[30])
        {
            Caption = 'Segmentation Code';
            NotBlank = true;
            TableRelation = "Segmentation Codes";

            trigger OnValidate()
            begin
                Confidential.GET("Segmentation Code");
                Description := Confidential.Description;
            end;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            NotBlank = true;
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(5; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
            Editable = true;
        }
        field(50000; "Segmentation Name"; Code[250])
        {
            Caption = 'Segmentation Name';
            TableRelation = Position.Description WHERE(Code = FIELD("Position No."));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(50001; "Starting Date"; Date)
        {
            Caption = 'Starting Date';

            trigger OnValidate()
            begin
              

               

               

            end;
        }
        field(50002; "Ending Date"; Date)
        {
            Caption = 'Ending Date';

            trigger OnValidate()
            begin
               

            end;
        }
        field(50006; "Management Level"; Enum "Management Level")
        {
            Caption = 'Management Level';

        }
    }

    keys
    {
        key(Key1; "Position No.", "Segmentation Code", "Line No.", "Segmentation Name", "Starting Date", "Ending Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label 'You can not delete confidential information if there are comments associated with it.';
        Confidential: Record "Segmentation Codes";
}

*/