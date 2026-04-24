page 50198 "Request Work Orders FactBox"
{
    Caption = 'Request Work Orders FactBox';
    PageType = ListPart;
    SourceTable = "Service Header";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                        Rec.OpenCardPage();
                    end;
                }
                field("Request Type"; "Request Type") { }
                field("Document Date"; "Document Date") { }
                field(Status_request; Status_request) { }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = All;
                }
            }

        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields(Status_request);
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        CalcFields(Status_request);
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        CalcFields(Status_request);
    end;
}
