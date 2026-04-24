pageextension 50205 "ReminderListExtends" extends "Reminder List"
{

    layout
    {


        addbefore(Control1)
        {
            field(Rows; Rows) { ApplicationArea = all; Caption = 'Rows'; }

        }
        addafter(Name)
        {
            field("Date of Sent Reminder"; "Date of Sent Reminder")
            {
                ApplicationArea = All;
            }
            field("E-mail"; "E-mail") { ApplicationArea = All; }
            field("E-mail delivery"; "E-mail delivery") { ApplicationArea = All; }

        }

    }

    var
        Rows: Integer;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

        Rows := Rec.Count;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        Rows := Rec.Count;
    end;







}