tableextension 50026 EmploymentContract extends "Employment Contract"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Hours in Day"; Decimal)
        {
            Caption = 'Hours in Day';
        }
        field(50001; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Worker,Board,Supervisor,Trainee';
            OptionMembers = Worker,Board,Supervisor,Trainee;
        }
        field(50002; "Termination Date Mandatory"; Boolean)
        {
            Caption = 'Termination Date Mandatory';
        }

        field(50003; "NAV ID"; Integer)
        {
            Caption = 'NAV ID';
        }
        field(50004; "Type"; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Employee,Customer,Reason,Service Order,A-B';
            OptionMembers = Employee,Customer,Reason,"Service Order","A-B";
        }
        field(50005; "No Series"; code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series".code;
        }
        field(50006; "Custom Report Layout"; code[20])
        {
            Caption = 'Custom Report Layout';
            TableRelation = "Custom Report Layout".Code;
            trigger OnValidate()
            var
                myInt: Integer;
                CRL: Record "Custom Report Layout";
            begin
                CRL.reset;
                CRL.SetFilter(Code, '%1', "Custom Report Layout");
                if crl.FindFirst() then
                    "NAV ID" := crl."Report ID"
                else
                    "NAV ID" := 0;
            end;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if us."E. Contract type" = 1
            then
                rec.Type := rec.Type::Customer;

            if us."E. Contract type" = 2
                       then
                rec.Type := rec.Type::Reason;

            if us."E. Contract type" = 3
                  then
                rec.Type := rec.Type::"Employee";
            if us."E. Contract type" = 7
             then
                rec.Type := rec.Type::"A-B";

            if us."E. Contract type" = 8 then
                rec.Type := rec.Type::Customer;
            if (us."E. Contract type" <> 1) and (us."E. Contract type" <> 2) and (us."E. Contract type" <> 3)
            and (us."E. Contract type" <> 7) and (us."E. Contract type" <> 8)
then
                rec.Type := rec.Type::"Service Order";
        end;
    end;


    var
        myInt: Integer;
}