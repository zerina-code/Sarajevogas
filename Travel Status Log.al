table 50502 "Travel Status Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry number"; Integer)
        {
            AutoIncrement = true;
        }

        field(2; "Travel Order Status number"; Code[20]) { }

        field(3; "Previous Status"; Enum "Travel Order Status")
        {
            DataClassification = CustomerContent;
            // The status of the travel order before the change.
        }

        field(4; "New Status"; Enum "Travel Order Status")
        {
            DataClassification = CustomerContent;
            // The status of the travel order after the change.
        }
    }
    // Additional indexes can be added here if needed for performance optimization.
}