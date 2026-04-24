enum 50028 "Employee Abs "
{
    Extensible = false;
    AssignmentCompatibility = true;
    //'Active,Inactive,Unpaid,Terminated,On boarding,Practicians'
    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; Inactive)
    {
        Caption = 'Inactive';
    }

    value(2; Unpaid)
    {
        Caption = 'Unpaid';
    }

    value(3; Terminated)
    {
        Caption = 'Terminated';
    }
    value(4; "On boarding")
    {
        Caption = 'On boarding';
    }
    value(5; "Practicians")
    {
        Caption = 'Practicians';
    }



}