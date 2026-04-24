table 50054 "Types Of Diseases"
{
    Caption = 'Types Of Diseases';
    DrillDownPageID = "Types Of Diseases";
    LookupPageID = "Types Of Diseases";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Types"; Option)
        {
            Caption = 'Types';
            OptionMembers = "Types Of Diseases","Types of Activities","KIF KUF Logs","Gauge Type","Languages","Box","Disability Level","Gauge size","Statement","Status_Request","Pressure";
            OptionCaption = 'Types Of Diseases,Types of Activities,KIF KUF Logs,Gauge Type,Languages,Box,Disability Level,Gauge size,Statement,Status_Request, Pressure';
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,KIF,KUF';
            OptionMembers = " ",KIF,KUF;
        }
        field(6; "Number No. from"; Integer)
        {
            Caption = 'Number No.';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
        }
        field(8; "Number No. to"; Integer)
        {
            Caption = 'Number No.';
        }
        field(9; "Level of Disability"; Text[10])
        {
            Caption = 'Level of Disability';
        }
        field(11; "Qmax"; Integer)
        {
            Caption = 'Qmax';
        }
        field(12; "Measuring Area 1"; Decimal)
        {
            Caption = 'Measuring Area 1';
            DecimalPlaces = 1 : 3;
        }
        field(13; "Measuring Area 2"; Decimal)
        {
            Caption = 'Measuring Area 2';
            DecimalPlaces = 1 : 3;
        }
        field(14; Mistake; Text[250])
        {
            Caption = 'Mistake';
        }
        field(15; "Initial flow"; Text[250])
        {
            Caption = 'Initial flow';
        }
        field(16; "Stop flow"; Text[250])
        {
            Caption = 'Stop flow';
        }
        field(17; "LF Impulse"; Integer)
        {
            Caption = 'LF impulse';
        }
        field(18; "VF impulse"; Decimal)
        { Caption = 'VF impulse'; }
        field(19; "VF frequency"; Integer)
        { Caption = 'VFfrequency'; }

        field(20; "Maintenance Resource No."; code[20])
        {
            Caption = 'Maintenance Resource No. Corr';
            TableRelation = Resource."No.";
        }
        field(21; "Maintenance Resource without"; code[20])
        {
            Caption = 'Maintenance Resource No. without Corr';
            TableRelation = Resource."No.";
        }





    }

    keys
    {
        key(Key1; "Code", Description, Types, Type, Year, Month)
        {
        }
        key(Key2; Description)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Description) { }
    }
}

