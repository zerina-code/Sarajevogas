table 50167 "Logs"
{


    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,Customer,MM';
            OptionMembers = " ",Customer,MM,CEO;

        }
        field(2; "Customer Old"; code[20])
        {
            Caption = 'Customer Old';
        }
        field(3; "Customer New"; code[20])
        {
            Caption = 'Customer New';
        }
        field(4; "MM Old"; code[20])
        {
            Caption = 'MM Old';
        }
        field(5; "MM New"; code[20])
        {
            Caption = 'MM New';
        }
        field(6; "Autoincrement"; Integer)
        {
            Caption = 'Autoincrement';
            AutoIncrement = true;
        }

    }

    keys
    {
        key(Key1; type, Autoincrement)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;



}