tableextension 50013 CauseOfAbsence extends "Cause of Absence"
{
    fields
    {
        field(50000; "No Report"; Boolean)
        {
            Caption = 'No Report';
        }
        field(50001; Coefficient; Decimal)
        {
            Caption = 'Coefficient';
        }
        field(50002; "Calculated Sick Leave"; Boolean)
        {
            Caption = 'Calculated Sick Leave';
        }
        field(50003; "Work Experience Basis"; Boolean)
        {
            Caption = 'Work Experience Basis';
        }
        field(50004; "Added To Hour Pool"; Boolean)
        {
            Caption = 'Added To Hour Pool';
        }
        field(50005; "Sick Leave"; Boolean)
        {
            Caption = 'Sick Leave';
        }
        field(50006; "Sick Leave Paid By Company"; Boolean)
        {
            Caption = 'Sick Leave Paid By Company';
        }
        field(50007; Vacation; Boolean)
        {
            Caption = 'Vacation';
        }

        field(50008; "Insurance Basis"; Code[2])
        {
            Caption = 'Insurance Basis';
        }
        field(50009; "Work Abroad"; Boolean)
        {
            Caption = 'Work Abroad';
        }
        field(50010; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Standard,Other,Sick,Paid Absence,Unpaid Absence';
            OptionMembers = Standard,Other,Sick,"Paid Absence","Unpaid Absence";
        }
        field(50011; "Meal Calculated"; Boolean)
        {
            Caption = 'Meal Calculated';
        }
        field(50012; "Meal - Half Day Calculated"; Boolean)
        {
            Caption = 'Meal - Half Day';
        }
        field(50013; "Short Code"; Code[10])
        {
            Caption = 'Short Code';
        }
        field(50014; "Description 2"; Text[50])
        {
            Caption = 'Description 2';

        }
        field(50015; Holiday; Boolean)
        {
            Caption = 'Holiday';
        }// Add changes to table fields here
        field(50020; "Add Hours"; Boolean)
        {
            Caption = 'Add Hours';
        }
        field(50023; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            TableRelation = TS_knjizenja.vrnaloga;
        }
        field(50016; "Bussiness trip"; Boolean)
        {
            Caption = 'Business trip';
        }

        field(50017; "G/L Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('D')));
            Caption = 'G/L Account No.';


        }
        field(50018; "G/L Balance Account No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(TS_knjizenja.konto WHERE(vrnaloga = FIELD("Posting Group"),
                                                           D_C = FILTER('C')));
            Caption = 'G/L Balance Account No.';

        }
        field(50019; "Meal - Hours"; Boolean)
        {
            Caption = 'Meal - Half Day';
        }
        field(50021; "Sick Leave RAD -1"; Boolean)
        {
            Caption = 'Sick Leave RAD -1';
        }
        field(50022; "Unpaid days"; Boolean)
        {
        }
        field(50024; "Payment Type"; Option)
        {
            OptionCaption = ',Regular Work,Additional,Work Performance,Other Additional';
            OptionMembers = "<","Regular Work","Additional>","Work Performance","Other Additional";
        }
        field(50025; "Order"; Integer)
        {

            Caption = 'Order for Pay list';

        }
        field(50026; "Calculate Experience"; Boolean)
        {
            Caption = 'Calculate Experience';


        }
        field(50027; "Weekend"; Boolean)
        {
            Caption = 'Dozvoljen unos vikendom';
        }
        field(50028; "Cause of Absence On-Call"; Boolean)
        {
            Caption = 'Pripravnost';

        }
        field(50029; "Sick Leave Brutto"; Boolean)
        {
            Caption = 'Ne ulazi u obračun bruto satnice za bolovanje';
        }
        field(50030; "Basis of Absence"; Enum "Basis of Absence")
        {
            Caption = 'Basis of absence';
        }
    }

    var
        myInt: Integer;
}