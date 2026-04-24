/*table 50063 "Points per Disability Status"
{
    Caption = 'Points per Disability Status';

    fields
    {
        field(1; "No."; Code[10])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            NotBlank = false;
        }
        field(4; Points; Integer)
        {
            Caption = 'Points';
        }
        //ED 02 START
        field(6; Category; Option)
        {
            Caption = 'Category';
            //OptionCaption = Disability,Military,Conditions;
            OptionMembers = Disability,Military,Conditions;
        }
        field(7; Years; Integer)
        {
            Caption = 'Years';
            BlankZero = true;
        }
        field(8; "Lower Limit Months"; Integer)
        {
            Caption = 'Lower Limit';
        }
        field(9; "Upper Limit Months"; Integer)
        {
            Caption = 'Upper Limit';
        }
        //ED 02 END
    }

    keys
    {
        key(Key1; "No.", "Category")
        {
        }
    }

    fieldgroups
    {
    }
}

*/