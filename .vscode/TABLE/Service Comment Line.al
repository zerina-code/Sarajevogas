tableextension 50104 "Service Comment Line" extends "Service Comment Line"
{
    fields
    {
        // Add changes to table fields here
        field(5000; "Comment Option"; Option)
        {
            Caption = 'Comment Option';
            OptionCaption = ',Internal,Customer';
            OptionMembers = " ",Internal,Customer;
        }
        field(5001; "Problems"; Boolean)
        {
            Caption = 'Problems';

        }
    }

    var
        myInt: Integer;
}