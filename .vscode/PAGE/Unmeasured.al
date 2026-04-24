page 50161 "Customer ID"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer ID";
    Caption = 'Customer ID';

    layout
    {
        area(Content)
        {
            repeater("")
            {
                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }

                field(Code; Code) { ApplicationArea = all; }
                field("Identity card issuer"; "Identity card issuer") { ApplicationArea = all; }
                field("Date From"; "Date From") { ApplicationArea = all; }
                field("Date To"; "Date To") { ApplicationArea = all; }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field(Type; Type) { ApplicationArea = all; }

            }

        }
    }


    var
        myInt: Integer;
}