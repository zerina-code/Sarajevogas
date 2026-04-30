enum 50200 "Travel Order Status SG"
{
    Extensible = true;

    value(0; "Open")
    {
        Caption = 'Otvoren';
    }
    value(1; "Approved")
    {
        Caption = 'Odobreno';
    }
    value(2; "Closed")
    {
        Caption = 'Zatvoreno';
    }
    value(3; "Closed Posted")
    {
        Caption = 'Zatvoreno knjiženo';
    }
    value(4; "Closed Cancelled")
    {
        Caption = 'Zatvoreno otkazano';
    }
    value(5; "Cancelled")
    {
        Caption = 'Otkazano';
    }
}
