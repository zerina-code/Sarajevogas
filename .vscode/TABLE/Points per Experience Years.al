table 50126 "Points per Experience Years"
{
    Caption = 'Points Per Experience Years';

    fields
    {
        field(1; No; Integer)
        {
            //ĐK   AutoIncrement = true;

            Caption = 'No';
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(3; Vacation; Integer)
        {
            Caption = 'Vacation';
        }
        field(4; UpperLimit; Integer)
        {
            Caption = 'Upper Limit';

            /*trigger OnValidate()
            begin
                UpperLimit2 := FORMAT(UpperLimit) + 'Y';
            end;*/
        }
        field(5; LowerLimit; Integer)
        {
            Caption = 'Lower Limit';

            /*trigger OnValidate()
            begin
                LowerLimit2 := FORMAT(LowerLimit) + 'Y';
            end;*/
        }
        field(6; UpperLimit2; Text[30])
        {
            Caption = 'UpperLimit2';
            trigger OnValidate()
            begin
                //UpperLimit := strKeep(UpperLimit2, '0123456789');
            end;
        }
        field(7; LowerLimit2; Text[30])
        {
            Caption = 'LowerLimit2';
        }
        field(8; "Today Min"; Date)
        {
        }
        field(9; "Today Max"; Date)
        {
        }
        field(10; Points; Integer)
        {
            Caption = 'Points';
        }
        field(11; Category; Option)
        {
            Caption = 'Category';
            //OptionCaption = Disability,Military,Conditions;
            OptionMembers = Disability,Military,Conditions;
        }
        field(12; Years; Integer)
        {
            Caption = 'Years';
            BlankZero = true;
        }
        field(13; "Lower Limit Months"; Integer)
        {
            Caption = 'Lower Limit';
        }
        field(14; "Upper Limit Months"; Integer)
        {
            Caption = 'Upper Limit';
        }
        field(15; "Points Category"; Option)
        {
            Caption = 'Points Category';
            //OptionCaption = Disability,Military,Conditions;
            OptionMembers = "Points per Experience Years","Points per Disability Status";
        }
    }

    keys
    {
        key(Key1; No, "Points Category", Category)
        {
        }
    }

    trigger OnInsert()
    begin
        PointsPerEY.Reset();
        PointsPerEY.SetFilter("Points Category", '%1', Rec."Points Category");
        PointsPerEY.SetFilter(Category, '%1', Rec.Category);
        PointsPerEY.SetCurrentKey(No);
        PointsPerEY.Ascending;
        if PointsPerEY.FindLast() then
            No := PointsPerEY.No + 1
        else
            No := 1;

    end;


    /*WA.SetFilter("Entry No.", '<>%1', 0);
            IF WA.FindLast() THEN
                WageAddition."Entry No." := WA."Entry No." + 1
            else
                WageAddition."Entry No." := 1;*/


    var
        PointsPerEY: Record "Points per Experience Years";
}

