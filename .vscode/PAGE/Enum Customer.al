enum 50103 "Status Cust/MM"
{
    //ED
    Extensible = true;
    AssignmentCompatibility = true;
    /*
    Aktivan, Privremeno odjavljen, Trajno odjavljen i sl.*/

    value(0; " ")
    {
        Caption = ' ';
    }



    value(18; "Potential")
    {
        Caption = 'Potential';
    }

    value(19; "Active")
    {
        Caption = 'Active';
    }
    value(20; "Temporarily deregistered")
    {
        Caption = 'Temporarily deregistered';
    }
    value(21; "Permanently deregistered")
    {
        Caption = 'Permanently deregistered';
    }

    value(49; "Terminated")
    {
        Caption = 'Terminated';
    }
    value(50; "Permanently inactive")
    {
        Caption = 'Permanently inactive';
    }





}