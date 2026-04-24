/*table 50091 Measurer
{
    DataClassification = ToBeClassified;


    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
            //Broj mjerača

        }
        field(2; "Description"; text[250])
        {
            Caption = 'Description';
        }
        field(3; "Customer No."; Code[20]) { Caption = 'Customer NO.'; TableRelation = Customer."No."; }
        field(4; "Customer Name"; Code[20]) { Caption = 'Customer Name'; }
        field(5; "Customer Category"; Code[20]) { Caption = 'Customer Category'; }
        //  field(6; "Customer Type"; enum "Customer Status Enum") { Caption = 'Customer Category'; }
        field(7; "Measuring Point Code"; Code[20]) { Caption = 'Measuring Point Code'; TableRelation = "Service Item"."No."; }
        field(8; "Measuring Point Adress"; Text[250]) { Caption = 'Measuring Point Adress'; }
        field(9; "Measurer Type"; Code[20]) { Caption = 'Measurer type'; TableRelation = "Measurer Type".Code; }
        field(10; "Measurer manufacturer"; Text[250]) { Caption = 'Measurer manufacturer'; }
        field(11; "Production Year"; Integer) { Caption = 'Production Year'; }
        field(12; "Calibration Year"; Integer) { Caption = 'Calibration Year'; }
        field(13; "Inventory Number"; Code[20]) { Caption = 'Inventory Number'; }
        field(14; "Measurer Condition"; Option)
        {
            OptionMembers = ,"1";
            Caption = 'Measurer Condition';
        }
        field(15; "Read modul"; Boolean) { Caption = 'Read modul'; }
        field(16; "Read Module - digital"; Option)
        {
            OptionMembers = ,investment,current_maintenance,commercial;
            OptionCaption = ' ,investment,current maintenance, commercial';
            Caption = 'Read Module - digital';
        }

        field(17; "Reading Type"; Option)
        {
            OptionMembers = ,"Manual","Remote","Remote MBAS";
            OptionCaption = ' ,Manual,Remote,Remote MBAS';
            Caption = 'Reading Type';
        }
        field(18; "Serial Number I"; Integer) { Caption = 'Serial Number I'; }
        field(19; "Serial Number II"; Integer) { Caption = 'Serial Number II'; }
        field(20; "Installation Date"; Date) { Caption = 'Installation Date'; }
        field(21; "Dismantling date"; Date) { Caption = 'Dismantling date'; }
        field(22; "Programming date"; Date) { Caption = 'Programming date'; }
        field(23; "Date of rescheduling"; date) { Caption = 'Date of rescheduling'; }
        field(24; "Measurer Status"; Option)
        {
            OptionMembers = ,Active,Replaced,Off;
            OptionCaption = ' ,Active, Replaced, Off';
            Caption = 'Measurer Status';
        }
        field(25; "Measurer Size"; Integer) { Caption = 'Measurer size'; }
        field(26; "Measurer Type2"; Option)
        {
            OptionMembers = ,turbine,rotary,meh;
            Caption = ' ,turbine, rotary, meh';
        }
        field(27; "Qmax"; Integer) { Caption = 'Qmax'; }
        field(28; "Qmin"; Integer) { Caption = 'Qmin'; }
        field(29; "No"; Integer) { Caption = 'No'; }
        field(30; Pmax; Integer) { Caption = 'Pmax'; }
        field(31; Tul; Integer) { Caption = 'Tul'; }
        field(32; Tizl; Integer) { Caption = 'Tizl'; }

        field(33; Pul; Integer) { Caption = 'Pul'; }
        field(34; Piz; Integer) { Caption = 'Piz'; }

        field(35; "Decimal Places"; Decimal) { Caption = 'Decimal Places'; }
        field(36; Tr; Decimal) { Caption = 'Tr'; }
        field(37; "Impulse number"; Decimal) { Caption = 'Impulse number (Imp/m3)'; }
        field(38; "Impulse transmitter "; Decimal) { Caption = 'Impulse transmitter LF/HE'; }
        field(39; "Montage length"; Decimal) { Caption = 'Montage length'; }
        field(40; "connection type"; Option)
        {
            OptionMembers = ,threaded,flanged;
            OptionCaption = ' ,threaded, flanged';
        }
        field(41; "Mounted"; Option)
        {
            OptionMembers = ,horizontally,vertically;
            OptionCaption = 'horizontally,vertically';
        }
        field(42; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(43; "Dismantling Reason"; text[250]) { Caption = 'Dismantling Reason'; TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling")); }//šifarnik
        field(44; "Flow direction"; enum "Flow Direction") { Caption = 'Flow direction'; }
        field(45; "Weight"; Decimal) { Caption = 'Weight'; }
        field(46; "Model"; text[250]) { Caption = 'Model'; }





    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}*/