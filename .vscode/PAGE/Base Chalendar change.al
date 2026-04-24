pageextension 50016 BaseChalendarChange extends "Base Calendar Changes"
{
    layout
    {
        modify("Base Calendar Code")
        {
            Visible = true;
            Editable = true;
        }

        addafter(Day)
        {
            field("Holiday Cause of Absence"; "Holiday Cause of Absence")
            {
                trigger OnValidate()
                var
                    myInt: Integer;
                    Cause: Record "Cause of Absence";
                begin
                    Cause.Reset();
                    Cause.SetFilter(Code, '%1', cause.Code);
                    if Cause.FindFirst() then begin
                        Description := Cause.Description;
                    end;

                end;

            }

        }

        addafter(Nonworking)
        {
            field("Paid Holiday"; "Paid Holiday")
            {
                trigger OnValidate()
                begin
                    Question := Text000;
                    if "Paid Holiday" then
                        Answer := Dialog.Confirm(Question, true);

                    if Answer AND "Paid Holiday" then begin
                        AbsenceFill.FillHoliday(Rec.Date, rec."Holiday Cause of Absence", rec.Description);
                        Message(Text009); //registracija izostanaka je završena
                    end;
                end;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        AbsenceFill: Codeunit "Absence Fill";
        Question: Text;
        Finish: Text;
        Answer: Boolean;
        Text000: Label 'Do you want to set paid holiday for all employees?';
        Text009: Label 'Registration of absences is completed.';
}