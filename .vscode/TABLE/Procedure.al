/*ĐK table 50161 "Procedure"
{
    Caption = 'Procedures';
    //   DrillDownPageID = "Procedure list";
    //  LookupPageID = "Procedure list";

    fields
    {
        field(1; "Type of procedure"; Option)
        {
            Caption = 'Type of procedure';
            OptionCaption = 'First instance procedure,Second instance procedure';
            OptionMembers = "First instance procedure","Second instance procedure";
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; "Type of procedure", Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Type of procedure", Description)
        {
        }
    }
}

*/