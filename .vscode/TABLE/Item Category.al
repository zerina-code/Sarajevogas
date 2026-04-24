tableextension 50041 ItemCategory extends "Item Category"
{
    fields
    {

        // Add changes to table fields here
        field(50003; "Min. Item Profiit"; Decimal)
        {
            Caption = 'Min. Item Profiit';
        }
        field(50004; "Code Category Text"; Option) //ED da bih razlikovala klase artikala, dobavljača i usluga
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga,Osnovno sredstvo,Kupac';
            OptionMembers = " ",Artikal,Dobavljač,Usluga,OS,Kupac;
        }
        field(50005; "Category Label"; Code[20])
        {
            Caption = 'Category Label';
        }
    }
}