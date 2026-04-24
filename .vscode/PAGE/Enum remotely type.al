enum 50071 "Remotely Type"
{
    //ED
    Extensible = true;
    AssignmentCompatibility = true;
    /*
    -	Radijsko 
-	GPRS/ Mbus
-	GPRS/ Mbus/LORA
-	GPRS/ Mbus/SKADA
-	Ostalo
*/
value(0;" ")
{
    caption=' ',Locked=true;
}


    value(1; "Radio")
    {
        Caption = 'Radio';
    }

    value(2; "Mbus")
    {
        Caption = 'Mbus';
    }
    value(3; "Mbus LORA")
    {
        Caption = 'Mbus LORA';
    }
    value(4; "M-Bus Skada")
    {
        Caption = 'M-Bus Skada';
    }
    value(5; "Others")
    { Caption = 'Others'; }



}