tableextension 50012 BaseCalendarChange extends "Base Calendar Change"
{


    fields
    {
        // Add chafienges to table fields here
        field(50000; "Paid Holiday"; Boolean)
        {
            Caption = 'Paid Holiday';
        }

        field(50001; "Holiday Cause of Absence"; Code[10])
        {
            Caption = 'Holiday Cause of Absence';
            TableRelation = "Cause of Absence";

        }
    }


    var
        myInt: Integer;
}