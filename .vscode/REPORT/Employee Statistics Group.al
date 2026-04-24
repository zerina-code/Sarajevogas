tableextension 50103 "Employee Statistics Group" extends "Employee Statistics Group"
{
    fields
    {
        // Add changes to table fields here
        field(50005; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';

        }

        field(50006; "Customer No."; Code[30])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
        }
    }

    var
        myInt: Integer;
}