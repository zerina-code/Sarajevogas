page 50199 "Interest Calculation"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Interest Calculation";


    layout
    {
        area(Content)
        {
            repeater("")
            {

                field("Line No."; "Line No.") { }
                field("Accusation Line Type"; "Accusation Line Type") { }
                field("Cust. Ledger Entry No."; "Cust. Ledger Entry No.") { }
                field("Document No."; "Document No.") { }
                field("Sales Invoice No."; "Sales Invoice No.")
                {

                }
                field("Line Amount"; "Line Amount") { }
                field("Remaining Amount"; "Remaining Amount") { }
                field("Due Date"; "Due Date") { }
                field("Date from"; "Date from") { }
                field("Date to"; "Date to") { }
                field("Difference Days"; "Difference Days") { }
                field("Interest Calculation Type"; "Interest Calculation Type") { }
                field("Interest Coefficient"; "Interest Coefficient") { }
                field("Interest Amount"; "Interest Amount") { }

            }

        }
    }


    var
        myInt: Integer;
}