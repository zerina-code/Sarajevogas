table 50048 "Gas Appliance Type"
{
    Caption = 'Gas Appliance Type';
    DrillDownPageId = "Gas Appliance Types";
    LookupPageId = "Gas Appliance Types";
    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Type"; Option)
        {
            OptionCaption = ' ,GAS Appliance,GAS Device';
            OptionMembers = " ","GAS Appliance","GAS Device";
        }
        field(4; "Gas Appliance Type"; Enum "Gas Appliance Types")
        {
            Caption = 'Gas Appliance Type';

        }
    }
    keys
    {
        key(PK; Code, Description)
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }
}