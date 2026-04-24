enum 50056 "Type of Person"
{
    Extensible = false;
    AssignmentCompatibility = true;
    //'Active,Inactive,Unpaid,Terminated,On boarding,Practicians'
    value(0; Empty)
    {
        Caption = '';
    }
    value(1; "Phisical Person")
    {
        Caption = 'Phisical Person';
    }
    value(2; "Legal Person")
    {
        Caption = 'Legal Person';
    }


}



