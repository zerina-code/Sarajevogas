page 50201 "Page by Intervention"
{
    Caption = 'Page by Intervention';
    // CardPageID = "E.mail templates";
    PageType = List;
    SourceTable = "Service Line";




    layout
    {
        area(content)
        {

            repeater(General)
            {



                field("Document No."; "Document No.")
                {
                    Caption = 'Document No.';

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        rp.SetTableView(shi);
                        rp.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        SHI: Record "Service Header";
                        RP: page "Request Card";
                    begin
                        SHI.Reset();
                        SHI.SetFilter("No.", '%1', rec."Document No.");
                        rp.SetTableView(shi);
                        rp.Run();

                    end;
                }
                field("Document Date"; "Document Date") { }


                field("RN Type"; "RN Type") { }

                field("Customer No."; "Customer No.") { Caption = 'Customer No.'; }
                field("Customer Name"; "Customer Name") { }
                field("Location Name"; "Location Name") { }
                field(Description; Description) { }

                field("Request Resource Type"; Rec."Request Resource Type")
                {
                    ApplicationArea = All;
                    Visible = false;


                }
                field("Resource Connection Type"; Rec."Resource Connection Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Resource Name"; Rec."Resource Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Intent; Rec.Intent)
                {
                    ApplicationArea = All;
                    Visible = false;
                }

                field("Unit of Measure Code"; "Unit of Measure Code2") { }
                field("Planned Quantity"; Rec."Planned Quantity")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity) { }
                field("Quantity RN"; "Quantity RN") { }
                field("Number of leaks detected"; "Number of leaks detected") { }

                field("Unit Price"; "Unit Price") { Visible = FalsE; }
                field("Request Department"; "Request Department") { }
                field("Request Department Name"; "Request Department Name") { }
                field("Responsible Department"; "Responsible Department") { }
                field("Responsible Department Name"; "Responsible Department Name") { }
                field("Fixed Asset OS"; "Fixed Asset OS") { }
                field("Fixed Asset Mark"; "Fixed Asset Mark") { }
                field("Done Date"; "Done Date") { }

            }

        }

    }

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        CalcFields("Document Date", "Request Department", "Request Department Name", "Responsible Department", "Responsible Department Name", "Location Name", "Customer Name");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Document Date", "Request Department", "Request Department Name", "Responsible Department", "Responsible Department Name", "Location Name", "Customer Name");

    end;


    var
        myInt: Integer;
}