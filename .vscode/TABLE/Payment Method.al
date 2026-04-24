enum 50037 "Payment Method"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; Cash)
    {
        Caption = 'Gotovina';
    }
    value(2; Card)
    {
        Caption = 'Kartično';
    }
}