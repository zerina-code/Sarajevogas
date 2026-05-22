enum 50039 "Travel Order Status"
{
    Extensible = true;

    value(1; "Open")
    {
        Caption = 'Otvoren';
    }
    value(2; "Approved")
    {
        Caption = 'Odobreno';
    }
    value(3; "Closed")
    {
        Caption = 'Zatvoreno';
    }
    value(4; "ClosedPosted")
    {
        Caption = 'Zatvoreno knjiženo';
    }
    value(5; "ClosedCancelled")
    {
        Caption = 'Zatvoreno otkazano';
    }
    value(6; "Cancelled")
    {
        Caption = 'Otkazano';
    }
}
