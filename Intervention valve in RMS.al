enum 50097 "Intervention valve in RMS"
{
    Extensible = true;
    AssignmentCompatibility = true;

    //' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team'

    value(0; " ")
    {
        Caption = ' ', Locked = true;
        ;
    }

    value(1; "Open")
    {
        Caption = 'Open';
    }
    value(2; "Closed")
    {
        Caption = 'Closed';
    }

}