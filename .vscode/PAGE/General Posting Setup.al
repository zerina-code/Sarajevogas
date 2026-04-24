pageextension 50122 General_Posting_Setup extends "General Posting Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Direct Cost Applied Account")
        {
            field("Retail Account No."; "Retail Account No.") { }
            field("Retail Receipt Account No."; "Retail Receipt Account No.") { }
            field("Retail Receipt Account No. MP"; "Retail Receipt Account No. MP") { }
            field("Update General Posting Group"; "Update General Posting Group") { }
            field("HTZ Account"; "HTZ Account") { }
            field("Previous HTZ Account"; "Previous HTZ Account") { }
            field("HTZ Account 2"; "HTZ Account 2") { }
            field("Previous HTZ Account 2"; "Previous HTZ Account 2") { }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}