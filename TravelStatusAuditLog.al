table 50009 "Travel Status Audit Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Travel Order No."; Code[20]) { }
        field(3; "Old Status"; Enum "Travel Order Status") { }
        field(4; "New Status"; Enum "Travel Order Status") { }
        field(5; "Changed By"; Code[50]) { }
        field(6; "Changed At"; DateTime) { }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}