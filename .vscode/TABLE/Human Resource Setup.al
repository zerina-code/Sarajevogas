tableextension 50038 HumanResSetup extends "Human Resources Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Instructor Nos."; Code[10])
        {
            Caption = 'Instructor Nos.';
            TableRelation = "No. Series";
        }
        field(50001; "Training Catalogue Nos."; Code[10])
        {
            Caption = 'Training Catalogue Nos.';
            TableRelation = "No. Series";
        }
        field(50003; "Birthday warning (Days)"; Integer)
        {
            Caption = 'Birthday warning (Days)';
        }
        field(50004; "Training Nos."; Code[10])
        {
            Caption = 'Training Nos.';
            TableRelation = "No. Series";
        }
        field(50005; "Procedure No."; Integer)
        {
            Caption = 'Procedure No.';
        }
        field(50006; "Probation Expire Days"; DateFormula)
        {
            Caption = 'Probation Expire Days';
        }
        field(50007; "Objective Header Nos."; Code[10])
        {
            Caption = 'Objective Header Nos.';
            TableRelation = "No. Series";
        }
        field(50008; "Objective Line Nos."; Code[10])
        {
            Caption = 'Objective Line Nos.';
            TableRelation = "No. Series";
        }
        field(50009; "Objective Type Nos."; Code[10])
        {
            Caption = 'Objective Type Nos.';
            TableRelation = "No. Series";
        }
        field(50010; "Competency Nos."; Code[10])
        {
            Caption = 'Competency Nos.';
            TableRelation = "No. Series";
        }
        field(50011; "Expiry period (violations)"; DateFormula)
        {
            Caption = 'Expiry period (violations)';
        }
        field(50012; "Warning Period"; DateFormula)
        {
            Caption = 'Warning Period';
        }
        field(50013; "Reaching years in company"; DateFormula)
        {
            Caption = 'Reaching years in company';
        }
        field(50014; "Operator Nos."; Code[10])
        {
            Caption = 'Operator Nos.';
            TableRelation = "No. Series";
        }
        field(50015; "Personal Documents Nos."; Code[10])
        {
            Caption = 'Personal Documents Nos.';
            TableRelation = "No. Series";
        }
        field(50016; "Disability Nos."; Code[10])
        {
            Caption = 'Disability Nos.';
            TableRelation = "No. Series";
        }
        field(50017; "Work Booklet Nos."; Code[10])
        {
            Caption = 'Work Booklet Nos.';
            TableRelation = "No. Series";
        }
        field(50018; "Alternative Address Nos."; Code[10])
        {
            Caption = 'Alternative Address Nos..';
            TableRelation = "No. Series";
        }
        field(50019; "Institution Nos."; Code[10])
        {
            Caption = 'Institution Nos.';
            TableRelation = "No. Series";
        }
        field(50020; "B-1 Nos."; Code[10])
        {
            Caption = 'B-1 Nos.';
            TableRelation = "No. Series";
        }
        field(50021; "B-1 (with regions) Nos."; Code[10])
        {
            Caption = 'B-1 (with regions) Nos.';
            TableRelation = "No. Series";
        }
        field(50022; "Stream Nos."; Code[10])
        {
            Caption = 'Stream Nos.';
            TableRelation = "No. Series";
        }
        field(50023; "New employee period"; DateFormula)
        {
            Caption = 'New employee period';
        }
        field(50024; "Legal Training Expire Days"; DateFormula)
        {
            Caption = 'Legal Training Expire Days';
        }
        field(50025; "Tax Administration Report Days"; DateFormula)
        {
            Caption = 'Tax Administration Report Days';
        }
        field(50026; "Company Car Code"; Integer)
        {
            Caption = 'Company Car Code';
            TableRelation = "Misc. Article";
        }
        field(50027; "Title Nos"; Code[10])
        {
            Caption = 'Title';
            TableRelation = "No. Series";
        }
        field(50028; "Profession Nos"; Code[10])
        {
            Caption = 'Profession Nos';
            TableRelation = "No. Series";
        }
        field(50029; "Training Administrator"; Code[10])
        {
            Caption = 'Training Administrator';
            TableRelation = Employee;
        }
        field(50030; "HR Administrator"; Code[10])
        {
            Caption = 'Training Administrator';
            TableRelation = Employee;
        }
        field(50031; "Expiry period (contracts)"; DateFormula)
        {
            Caption = 'Expiry period (contracts)';
        }
        field(50032; "MBO Administrator"; Code[10])
        {
            Caption = 'MBO Administrator';
            TableRelation = Employee;
        }
        field(50339; "Fixed Amount Brutto"; Decimal)
        {
            Caption = 'Fixed Amount Netto';
        }
        field(50340; "Variable Amount Brutto Less"; Decimal)
        {
            Caption = 'variable Amount Netto';
        }
        field(50341; "Variable Amount Brutto Greater"; Decimal)
        {
            Caption = 'variable Amount Netto';
        }
        field(50342; "Notification Expire Days"; DateFormula)
        {
            Caption = 'Notification Expire Days';
        }
        field(50343; "File Path"; Text[250])
        {
            Caption = 'File Path';
        }
        field(50344; "Administrator 1"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50345; "Administrator 2"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50346; "Administrator 3"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50347; "Administrator 4"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50348; "Administrator 5"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50349; "Administrator 6"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50350; "Administrator 7"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50351; "Administrator 8"; Code[10])
        {
            TableRelation = Employee;
        }
        field(50352; "E-mail Sender"; Text[250])
        {
            Caption = 'E-mail Sender';
        }
        field(50353; "E-mail Receiver"; Text[250])
        {
            Caption = 'E-mail Receiver';
        }
        field(50354; "Sender Name"; Text[250])
        {
            Caption = 'Sender Name';
        }
        field(50355; "External Description"; Text[250])
        {
            Caption = 'External Description';
        }
        field(50356; "Administrator Contact Center"; Code[20])
        {
            TableRelation = Employee;
        }
        field(50357; "Chief Executive Administrator"; Code[20])
        {
            TableRelation = Employee;
        }
        field(50358; "Default Org Jed"; Text[250])
        {
            TableRelation = "ORG Dijelovi".Description where(Active = const(true));
            Caption = 'Default Org Jed';
        }
    }

    var
        myInt: Integer;
}