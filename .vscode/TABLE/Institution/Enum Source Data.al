enum 50072 "Import Data"
{
    //ED
    Extensible = true;
    AssignmentCompatibility = true;
    /*
    Aktivan, Privremeno odjavljen, Trajno odjavljen i sl.*/

    /*
    ⦁	direktno sa mjernih uređaja
⦁	indirektno posredstvom uređaja za daljinsko očitanje
⦁	kupac dostavlja stanje sa brojčanika (telefonom, poštom ili e-mailom)
*/

    value(0; "Unknown")
    {
        Caption = 'Unknown';
    }

    value(1; "Manual")
    {
        Caption = 'Manual';
    }
    value(2; "Remotely")
    {
        Caption = 'Remotely';
    }
    value(3; "By Phone")
    {
        Caption = 'By Phone';
    }
    value(4; "By Post")
    { Caption = 'By Post'; }

    value(5; "By E-mail")
    {
        Caption = 'By E-mail';
    }

    value(6; "Control")
    {
        Caption = 'Control';
    }


    value(7; "Unobvious")
    {
        Caption = 'Unobvious';
    }
    value(8; "Budget")
    {
        Caption = 'Budget';
    }
    value(9; "Per Year")
    {
        Caption = 'Per Year';
    }


}