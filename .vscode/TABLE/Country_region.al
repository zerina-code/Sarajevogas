tableextension 50016 CountryRegion extends "Country/Region"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(50001; "Country Code"; Code[4])
        {
            Caption = 'Country Code';
        }
    }

    var
        myInt: Integer;
}