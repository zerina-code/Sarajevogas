tableextension 50059 Relative_ext extends Relative
{
    fields
    {
        // Add changes to table fields here
        field(50000; Sex; enum "Employee Gender")
        {
            Caption = 'Sex';

        }
        field(50004; Relation; Option)
        {
            Caption = 'Parent';
            OptionCaption = ' ,Mother,Father,Child,Spouse,Others';
            OptionMembers = " ",Mother,Father,Child,Spouse,Others;
        }
        field(50005; Akuzativ; Text[50])
        {
        }
        field(50006; Genitiv; Text[30])
        {
        }
        field(50161; "Order"; Integer)
        {
            Caption = 'Order';
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin


    end;

    var
        myInt: Integer;
}