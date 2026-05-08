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

    value(2; PostedClosed)
    {
        Caption = 'Zatvoreno-knjizeno';
    }

    value(3; CancelledClosed)
    {
        Caption = 'Zatvoreno-okazano';
    }
}