page 50181 "Calc. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Calcuation Header";
    Caption = 'Calculation List';
    CardPageId = "Calculation Step 1";


    layout
    {
        area(Content)
        {
            repeater("")
            {
                field(Code; Code) { ApplicationArea = all; }
                field("Year Of GAS Calculation"; "Year Of GAS Calculation")
                {
                    ApplicationArea = all;
                }
                field("Month Of GAS Calculation"; "Month Of GAS Calculation") { ApplicationArea = all; }
                field("Category Calculation"; "Category Calculation")
                {
                    ApplicationArea = all;
                }
                field("Undo Calculation";"Undo Calculation"){ApplicationArea=all;}

            }
        }
    }
    actions

    {
        area(Processing)
        {
            action("Locked")
            {

                Caption = 'Locked';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin

                    Rec.Status := Rec.Status::Locked;
                    Rec.Modify();
                end;


            }
        }
    }


    var
        myInt: Integer;
}