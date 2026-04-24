enum 50005 "Pipe/Connection Type"
{
    Caption = 'Pipe/Connection Type', Comment = 'Vrsta cijevi/spoja';
    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Steel)
    {
        Caption = 'Steel';
    }
    value(2; Copper)
    {
        Caption = 'Copper';
    }
    value(3; "Steel/Copper")
    {
        Caption = 'Steel/Copper';
    }
    value(4; "Flexible pipe")
    {
        Caption = 'Flexible pipe';
    }
    value(5; "Flexible pipe-copper")
    {
        Caption = 'Flexible pipe-copper';
    }

    value(6; "Flexible pipe-steel")
    {
        Caption = 'Flexible pipe-steel';
    }
}
