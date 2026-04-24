enum 50033 "Reason for Change"
{
    Extensible = false;
    AssignmentCompatibility = true;

    //' ,GM,Group,CEO,Department,Branch Office,Region,Regional Center,Sector,Team'
    value(0; Empty)
    {
        Caption = 'Empty';
    }
    value(1; "Migration")
    {
        Caption = 'Migration';
    }

    value(2; "New Contract")
    {
        Caption = 'New Contract';
    }

    value(3; "Contract Renewal")
    {
        Caption = 'Contract Renewal';
    }
    value(4; "Systematization")
    {
        Caption = 'Systematization';
    }
    value(5; "Relocation")
    {
        Caption = 'Relocation';
    }



}