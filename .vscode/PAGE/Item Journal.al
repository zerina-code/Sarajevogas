pageextension 50109 "Item Journal" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        addafter("Unit Cost")
        {

            field("Inventory Posting Group"; "Inventory Posting Group") { }
            field("Source Posting Group"; "Source Posting Group") { }
            field("Employee No."; "Employee No.") { }
            field("Employee Name"; "Employee Name") { }

            field("Org Name"; "Org Name") { }

        }
        modify("Gen. Bus. Posting Group") { Visible = true; }
        modify("Gen. Prod. Posting Group") { Visible = false; }
        modify("Entry Type")
        {
            OptionCaption = 'Purchase,Sale,Positive Adjmt.,Negative Adjmt.';

        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("Test Report")
        {

            action("Import Upotreba")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Import Item Journal';
                Ellipsis = true;
                Image = ImportExcel;

                trigger OnAction()
                var
                    Im: XmlPort "Import Item Journal";
                begin
                    Im.Run;
                end;
            }
        }
    }

    var
        myInt: Integer;

}