/*table 50107 Concealer
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
        field(3; "Impulse transmitter "; Decimal) { Caption = 'Impulse transmitter LF/HE'; }

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
            OptionMembers = ,radio,mbus;
            OptionCaption = ' ,radio,mbus';
            Caption = 'Reading Type';
        }
        field(18; "Serial Number"; Integer) { Caption = 'Serial Number'; }
        field(20; "Installation Date"; Date) { Caption = 'Installation Date'; }
        field(21; "Dismantling date"; Date) { Caption = 'Dismantling date'; }
        field(22; "Programming date"; Date) { Caption = 'Programming date'; }
        field(23; "Date of rescheduling"; date) { Caption = 'Date of rescheduling'; }

        field(25; "Measurer Size"; Integer) { Caption = 'Measurer size'; }

        field(27; "Qmax"; Integer) { Caption = 'Qmax'; }
        field(28; "Qmin"; Integer) { Caption = 'Qmin'; }
        field(29; "No"; Integer) { Caption = 'No'; }
        field(30; Pmax; Integer) { Caption = 'Pmax'; }
        field(31; "N2 %"; Decimal) { Caption = 'N2 %'; }
        field(32; "CO2%"; Decimal) { Caption = 'CO2%'; }

        field(33; Pul; Integer) { Caption = 'Pul'; }//ovo je pritisak rang
        field(34; Piz; Integer) { Caption = 'Piz'; }

        field(35; "Base P"; Decimal) { Caption = 'Base P'; }
        field(36; "Base Temp"; Decimal) { Caption = 'Base Temp'; }
        field(37; "Set up"; Text[250]) { Caption = 'Set up'; }
        field(38; "Air density "; Text[250]) { Caption = 'Air density'; }
        field(39; "Z. formula"; Text[250]) { Caption = 'Z. formula'; }

        field(41; "Rel density"; Decimal)
        {
            Caption = 'Rel density';
        }
        field(42; "DD calibration"; Integer) { Caption = 'DD calibration'; }
        field(43; "Dismantling Reason"; text[250]) { Caption = 'Dismantling Reason'; TableRelation = "Dismantling Reason".Description; }//šifarnik
        field(44; "Ownership"; Text[250]) { Caption = 'Ownership'; }
        field(45; "Upper Cal."; Decimal) { Caption = 'Upper Cal.'; }
        field(46; "Model"; text[250]) { Caption = 'Model'; }
        field(47; "IMP. W"; Integer) { Caption = 'IMP. W'; }





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