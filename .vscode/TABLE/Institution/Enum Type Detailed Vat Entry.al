enum 50030 "Type Detailed VAT Entry"
{
    Extensible = false;
    AssignmentCompatibility = true;
    value(0; Empty)
    {
        Caption = 'Empty';
    }
    value(1; "Purchase")
    {
        Caption = 'Purchase';
    }

    value(2; "Sale")
    {
        Caption = 'Sale';
    }

    value(3; "Settlement")
    {
        Caption = 'Settlement';
    }

}