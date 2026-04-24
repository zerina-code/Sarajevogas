table 50049 "Gas Appliance"
{
    Caption = 'Gas Appliance';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Gas Install. Data Entry No."; Integer)
        {
            Caption = 'Gas Installation Data Entry No.';
            DataClassification = CustomerContent;
            TableRelation = "Gas Installation Data";
        }
        field(3; "Gas Station No."; Code[20])
        {
            Caption = 'Gas Station No.';
            FieldClass = FlowField;
            CalcFormula = lookup("Gas Installation Data"."Gas Station No." where("Entry No." = field("Gas Install. Data Entry No.")));
            Editable = false;
        }
        field(4; "Measure Point No."; Code[20])
        {
            Caption = 'Measure Point No.';
            DataClassification = CustomerContent;
            TableRelation = "Service Item";
        }
        field(5; "Gas Appliance Type"; Text[250])
        {
            Caption = 'Gas Appliance Type';
            DataClassification = CustomerContent;
            TableRelation = "Gas Appliance Type".Description where(Type = filter("GAS Appliance"));
        }
        field(6; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
            TableRelation = "Gas Appliance Type".Description where(Type = filter("GAS Device"));
        }
        field(7; Quantity; Integer)
        {
            Caption = 'Quantity';
            DataClassification = CustomerContent;
        }
        field(8; "Power From"; Decimal)
        {
            Caption = 'Power From';
            DataClassification = CustomerContent;
        }
        field(9; "Power To"; Decimal)
        {
            Caption = 'Power To';
            DataClassification = CustomerContent;
        }
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = CustomerContent;
        }
        field(12; "Excerpt armored with a stopper"; Boolean)
        {
            Caption = 'Excerpt armored with a stopper';
            DataClassification = CustomerContent;
        }
        field(13; "Number of pieces"; Integer)
        {
            Caption = 'Number of pieces';
            DataClassification = CustomerContent;
        }
        field(14; "Excerpt armored without"; Boolean)
        {
            Caption = 'Excerpt armored without a stopper';
            DataClassification = CustomerContent;
        }


        //tabela za gasne aparate
    }
    keys
    {
        key(PK; "Entry No.", "Document No.")
        {
            Clustered = true;
        }
        key(MeasurePoint; "Measure Point No.")
        {

        }
        key(GasInstallationEntry; "Gas Install. Data Entry No.")
        {

        }
    }
    trigger OnInsert()
    begin
        if ("Measure Point No." = '') and ("Gas Install. Data Entry No." = 0) then
            Error(WrongDataInitErr);
    end;

    var
        WrongDataInitErr: Label 'Wrong data initialization!';
}
