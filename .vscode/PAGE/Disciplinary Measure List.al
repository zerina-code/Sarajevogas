/*ĐK page 50223 "Disciplinary Measure List"
{
    Caption = 'Disciplinary Measure List';
    PageType = List;
    SourceTable = "Disciplinary Measures";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Category; Category)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Category Name"; "Category Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Subcategory Name"; "Subcategory Name")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Competent Authority"; "Competent Authority")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Measure Type"; "Measure Type")
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
                field("Injury Name"; "Injury Name")
                {
                    ShowMandatory = true;
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Note; Note)
                {
                    ShowMandatory = true;
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        TESTFIELD("Category Name");
        TESTFIELD("Subcategory Name");
        TESTFIELD("Competent Authority");
        TESTFIELD("Measure Type");
        //TESTFIELD("Injury Name");
        TESTFIELD(Note);
    end;
}

*/