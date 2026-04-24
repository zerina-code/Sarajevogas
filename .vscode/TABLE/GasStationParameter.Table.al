table 50154 "Gas Station Parameter"
{
    Caption = 'Gas Station Parameter';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Gas Station Parameters";
    LookupPageId = "Gas Station Parameters";

    fields
    {
        field(1; "Gas Station No."; Code[20])
        {
            Caption = 'Gas Station No.';
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = "Fixed Asset";
        }
        field(2; "Gas Station Line No."; Integer)
        {
            Caption = 'Gas Station Line No.';
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Text[50])
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(4; Pul; Decimal)
        {
            Caption = 'Pul';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(5; Piz; Decimal)
        {
            Caption = 'Piz';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(6; "Security Blocking Device"; Decimal)
        {
            Caption = 'Security Blocking Device';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(7; "Security Vent Valve"; Decimal)
        {
            Caption = 'Security Vent Valve';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(8; "AFV Working Regulator"; Decimal)
        {
            Caption = 'AFV Working Regulator';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(9; "AFV Monitor Regulator"; Decimal)
        {
            Caption = 'AFV Monitor Regulator';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(10; "Valve Blocking Activation"; Decimal)
        {
            Caption = 'Valve Blocking Activation';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
        field(11; "Second Security Device"; Decimal)
        {
            Caption = 'Second Security Device';
            DataClassification = CustomerContent;
            DecimalPlaces = 1 : 3;
        }
    }
    keys
    {
        key(PK; "Gas Station No.", "Gas Station Line No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        CheckMandatoryData();
    end;

    trigger OnModify()
    begin
        CheckMandatoryData();
    end;

    local procedure CheckMandatoryData()
    begin
        TestField("Line No.");
    end;
}
