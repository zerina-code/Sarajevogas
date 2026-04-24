table 50100 "Dismantling Reason"

{
    Caption = 'Dismantling Reason';
    LookupPageId = "Dismantling Reasons";
    DrillDownPageId = "Dismantling Reasons";

    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';

        }
        field(3; Type; option)
        {
            OptionCaption = ' ,Reason for dismantling,Reason for Service Order,Reason for Control';
            OptionMembers = " ","Reason for dismantling","Reason for Service Order","Reason for Control";
        }
        field(4; "RN No. Series"; code[20])
        {
            Caption = 'RN No. series';
            TableRelation = "No. Series";
        }
        field(5; "Verification"; Boolean)
        {
            Caption = 'Verification';
        }
        field(6; "Gauge replacement"; Boolean)
        {
            Caption = 'Gauge replacement';
        }
        field(7; "Gauge cut off"; Boolean)
        {
            Caption = 'Gauge cut off';
        }
        field(8; "InActive"; Boolean)
        {
            Caption = 'InActive';
        }
        field(9; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(10; "Temporery"; Boolean)
        {
            Caption = 'Temporery';
        }
        field(11; "Permanently"; Boolean)
        {
            Caption = 'Permanently';
        }
        field(12; "Short Text"; Text[250])
        {
            Caption = 'Short Text';
        }
        field(13; "Default reason"; Boolean)
        {
            Caption = 'Default reason';
        }
        field(14; "Is not in Calibration facility"; Boolean)
        {
            Caption = 'Is not in Calibration facility';
        }
        field(15; "Type G_R"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Gauge,Corrector,Radio_Module,Gauge_RM,Corrector_RM;
            OptionCaption = ' ,Gauge,Corrector,Radio_Module,Gauge_Radio_Module,Corrector_RadioModule';
        }
        field(16; "Only Status Active"; Boolean)
        {
            Caption = 'Only Status Active';

        }


    }

    keys
    {
        key(Key1; Code, Description, type)
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
        if (xRec.Description = '') and (rec.Description <> '') then
            Error('Ne možete prazni preimenovati!');

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        if (xRec.Description = '') and (rec.Description <> '') then
            Error('Ne možete prazni preimenovati!');
    end;

}