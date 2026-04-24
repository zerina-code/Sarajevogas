/*table 50085 "HR Cue"
{


    fields
    {

        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Key';


        }
      

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    var
        datum: Date;
        t_Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        datum2: Date;
        HRsetup: Record "Human Resources Setup";
        finalDate: Date;
        datum3: Date;

        OrgShema: Record "Org Shema";
        Sistematizacija: Text;

    procedure SetRespCenterFilter()
    var
        UserSetupMgt: Codeunit "User Setup Management";
        RespCenterCode: Code[10];
    begin
        RespCenterCode := UserSetupMgt.GetPurchasesFilter;
        IF RespCenterCode <> '' THEN BEGIN
            FILTERGROUP(2);
            SETRANGE("Responsibility Center Filter", RespCenterCode);
            FILTERGROUP(0);
        END;
    end;
}

*/