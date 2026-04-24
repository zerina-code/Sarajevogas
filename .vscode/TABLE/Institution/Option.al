enum 50099 "Options for boolean"
{
    Extensible = true;
    AssignmentCompatibility = true;

    //' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team'
    value(0; " ")
    {
        Caption = ' ', Locked = true;
    }
    value(1; "No")
    {
        Caption = 'No';
    }

    value(2; "Yes")
    {
        Caption = 'Yes';
    }
    value(3; "No need")
    {
        Caption = 'No need';
    }



}