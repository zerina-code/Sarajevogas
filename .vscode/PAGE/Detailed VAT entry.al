page 50143 "Detailed VAT entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Detailed VAT Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("VAT Entry No."; "VAT Entry No.")
                {
                    ApplicationArea = All;

                }

                field(Column1; Column1)
                {
                    ApplicationArea = All;

                }
                field(Column2; Column2)
                {
                    ApplicationArea = All;

                }
                field(Column3; Column3)
                {

                }
                field(Column4; Column4)
                {

                }
                field(Column5; Column5)
                {

                }
                field(Column6; Column6)
                {

                }
                field(Column7; Column7)
                {

                }
                field(Column8; Column8)
                {

                }
                field(Column9; Column9)
                {

                }
                field(Column10; Column10)
                { }
                field(Type; Type)
                {

                }

            }
        }
    }



    var
        myInt: Integer;
}