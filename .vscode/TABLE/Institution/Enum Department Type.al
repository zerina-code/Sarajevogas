enum 50032 "Department Type"
{
    Extensible = false;
    AssignmentCompatibility = true;

    //' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team'
    value(0; Empty)
    {
        Caption = 'Empty';
    }
    value(1; "CEO")
    {
        Caption = 'CEO';
    }

    value(2; "Sector")
    {
        Caption = 'Sector';
    }

    value(3; "Department Category")
    {
        Caption = 'Department Category';
    }
    value(4; "Group")
    {
        Caption = 'Group';
    }
    value(5; "Main office")
    {
        Caption = 'Main office';
    }


}