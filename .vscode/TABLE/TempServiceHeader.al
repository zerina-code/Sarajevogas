table 50175 "Temp Service Header"
{
    Caption = 'Temp Service Header';
    DrillDownPageID = "Temp Requests";
    LookupPageID = "Temp Requests";
    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'Redni broj';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(4; "Source Table"; Text[50])
        {
            Caption = 'Source Table';
        }
        field(5; "Request Type"; Enum "Request Type")
        {
            Caption = 'Request Type';
        }
        field(6; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
    }
    keys
    {
        key(PK; ID, "No.")
        {
            Clustered = true;
        }
    }
}
