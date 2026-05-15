enum 50038 "Travel Order Status"
{
    Extensible = false;

    value(0; Open)
    {
        Caption = 'Otvoreno';
    }

    value(1; Approved)
    {
        Caption = 'Odobreno';
    }

    value(2; ClosedPosted)
    {
        Caption = 'Zatvoreno-knjizeno';
    }
    
    value(3; ClosedCancelled)
    {
        Caption = 'Zatvoreno-okazano';
    }
}