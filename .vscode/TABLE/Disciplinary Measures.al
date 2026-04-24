/*ĐK table 50164 "Disciplinary Measures"
{
    Caption = 'Disciplinary Measures';
    DrillDownPageID = "Disciplinary Measure List";
    LookupPageID = "Disciplinary Measure List";

    fields
    {
        field(1; Category; Code[20])
        {
            Caption = 'Category No.';
            TableRelation = "Category Disciplinary Measure".Category;

            trigger OnValidate()
            begin
                CategoryDisciplinaryMeasure.RESET;
                CategoryDisciplinaryMeasure.SETFILTER(Category, '%1', Category);
                IF CategoryDisciplinaryMeasure.FINDFIRST THEN
                    "Category Name" := CategoryDisciplinaryMeasure.Name;
            end;
        }
        field(2; "Category Name"; Text[100])
        {
            Caption = 'Category Name';
            TableRelation = "Category Disciplinary Measure".Name;
        }
        field(3; Note; Text[250])
        {
            Caption = 'Note';
        }
        field(4; "Document Template"; Integer)
        {
            Caption = 'Document Template';
        }
        field(5; "Subcategory Name"; Text[250])
        {
            Caption = 'Subcategory Name';
        }
        field(8; Test; Integer)
        {
        }
        field(9; Test2; Integer)
        {
        }
        field(10; "Competent Authority"; Text[100])
        {
            Caption = 'Competent Authority';
            TableRelation = "Competent Authority"."Competent Authority Name" WHERE("Category Name" = FIELD("Category Name"));
        }
        field(11; "Measure Type"; Option)
        {
            Caption = 'Measure Type';
            OptionCaption = ' ,Lighter,Heavier';
            OptionMembers = " ",Lighter,Heavier;
        }
        field(12; "Injury Name"; Text[250])
        {
            Caption = 'Injury Name';
            TableRelation = Injury."Injury Name" WHERE("Measure Type" = FIELD("Measure Type"));
        }
    }

    keys
    {
        key(Key1; "Category Name", "Subcategory Name", "Measure Type")
        {
        }
    }

    fieldgroups
    {
    }

    var
        CategoryDisciplinaryMeasure: Record "Category Disciplinary Measure";
}

*/