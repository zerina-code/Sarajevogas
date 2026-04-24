page 50079 Obligations
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Obligation;
    Caption = 'Obligations';
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater("L")
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Customer No."; "Customer No.") { }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("Date From"; "Date From") { ApplicationArea = all; }
                field("Date To"; "Date To") { ApplicationArea = all; }
                field(Active; Active) { ApplicationArea = all; }


            }
        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Customer Name");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Customer Name");

    end;


    var
        myInt: Integer;

}