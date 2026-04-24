tableextension 50037 GroundForTermination extends "Grounds for Termination"
{
    fields
    {
        field(50000; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Reason,Manner';
            OptionMembers = Reason,Manner;
        }
        field(50001; Type2; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Employee,Customer';
            OptionMembers = Employee,Customer;
        }




    }
    trigger OnInsert()
    var
        myInt: Integer;
        USR: Record "User Setup";
    begin
        USR.Reset();
        USR.SetFilter("User ID", '%1', UserId);
        if USR.FindFirst() then begin
            if USR."Customer or Employee" = true
            then
                Type2 := Type2::Customer
            else
                Type2 := Type2::Employee;
        end;
    end;

    var
        myInt: Integer;
}