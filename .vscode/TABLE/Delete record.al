/*table 50101 "Record Deletion Table"
{
    // version BCGOLIVE
    fields
    {
        field(1; "Table ID"; Integer)
        {
            Editable = true;  //INSERT TABLE No.
        }
        field(5; "Delete Records"; Boolean)
        {
        }
        field(6; Company; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Table ID")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Company := CompanyName;
    end;
}

*/