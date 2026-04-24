tableextension 50107 Reminder_Line extends "Reminder Line"
{
    fields
    {
        // Add changes to table fields here
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }
        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
        }
    }

    var
        myInt: Integer;
}