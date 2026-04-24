pageextension 50048 ItemCategories extends "Item Categories"
{

    //ED

    layout
    {
        addbefore(Description)
        {
            field("Category Label"; "Category Label")
            {
                ApplicationArea = all;
            }
        }
        addafter(Description)
        {
            field("Code Category Text"; "Code Category Text")
            {
                ApplicationArea = all;
            }
        }
    }

}