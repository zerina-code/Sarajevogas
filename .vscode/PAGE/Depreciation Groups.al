pageextension 50110 "Depreciation Groups" extends "Insurance Types"
{

    layout
    {

        addafter(Description)
        {
            field("Percentage"; "Percentage")
            {
                ApplicationArea = all;
            }
        }
    }
}