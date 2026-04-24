pageextension 50019 CauseOfAbsence extends "Causes of Absence"
{
    layout
    {

        addbefore(Code)
        {
            field("Short Code"; "Short Code")
            {

            }
        }
        // Add changes to page layout here
        addafter("Unit of Measure Code")
        {
            field("No Report"; "No Report")
            {
                Visible = false;

            }
            field(Coefficient; Coefficient)
            {

            }
            field("Calculated Sick Leave"; "Calculated Sick Leave")
            {
                Visible = false;

            }
            field("Sick Leave"; "Sick Leave")
            {


            }
            field("Sick Leave Paid By Company"; "Sick Leave Paid By Company")
            {

            }
            field(Vacation; Vacation) { }
            field("Added To Hour Pool"; "Added To Hour Pool") { }
            field("Calculation Type"; "Calculation Type") { }
            field("Calculate Experience"; "Calculate Experience") { }
            field("Meal Calculated"; "Meal Calculated") { }
            field("Meal - Hours"; "Meal - Hours") { Visible = false; }
            field("Meal - Half Day Calculated"; "Meal - Half Day Calculated") { }
            field("Payment Type"; "Payment Type")
            { }
            field(Order; Order) { ApplicationArea = all; }

            field("Posting Group"; "Posting Group") { }
            field("G/L Account No."; "G/L Account No.") { }
            field("G/L Balance Account No."; "G/L Balance Account No.") { }
            field("Sick Leave RAD -1"; "Sick Leave RAD -1") { Visible = false; }
            field("Unpaid days"; "Unpaid days") { }
            field("Add Hours"; "Add Hours") { Visible = true; }
            field("Cause of Absence On-Call"; "Cause of Absence On-Call") { ApplicationArea = all; }
            field(Weekend; Weekend) { ApplicationArea = all; }
            field(Holiday; Holiday) { }
            field("Basis of Absence"; "Basis of Absence") { }










        }
        modify("Total Absence (Base)")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}