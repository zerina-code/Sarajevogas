tableextension 50053 "Purch Inv Line Extends" extends "Purch. Inv. Line"
{
    fields
    {
        field(50010; "Cost Type"; Enum "Cost Type Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Cost Type';
        }
        field(50011; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract No.';
        }
        field(50012; "Plan No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan No.';
        }
        field(50013; "Purchase Plan Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Plan Code';
        }
        field(50014; "Direktni sporazum"; Enum "Procedure Type Enum")
        {
            DataClassification = ToBeClassified;
            Caption = 'Vrsta postupka';
        }
        field(50015; "Purchase Type"; Enum "Purchase Type Enum")
        {
            Caption = 'Purchase Type';
        }
        field(50017; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
            DataClassification = ToBeClassified;
        }
        field(50021; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            DataClassification = ToBeClassified;
        }


    }
}
