page 50113 "Accusation Document List"
{
    ApplicationArea = All;
    Caption = 'Accusation Document List';
    CardPageID = "Accusation Document";
    PageType = List;
    Editable = false;
    RefreshOnActivate = true;
    SourceTable = "Accusation Header";
    UsageCategory = Documents;


    layout
    {
        area(content)
        {
            repeater(General)
            {

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                /* field("Court number"; Rec."Court number")
                 {
                     ApplicationArea = All;
                     Editable = false;
                     ToolTip = 'Specifies the value of the Court number field.';
                 }*/
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer Name field.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Debt; Debt)
                {
                    ApplicationArea = All;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = All;
                    Visible = false;

                }

                field("Interest Rate Doument No."; "Interest Rate Doument No.") { }
                field(IP; "Current IP") { }
                field(Note; Rec.Note)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Note field.';
                }

                field("Send on E-mail"; Rec."Send on E-mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Send on E-mail field.';
                }
                field("Document Date"; "Document Date") { }
                field("Date of Interest Payment"; "Date of Interest Payment") { }
                field("Date of Court Decision"; "Date of Court Decision")
                {

                }
                field("Payment Date"; "Payment Date") { }
                field("Accusation Type"; "Accusation Type") { }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Current Accusation Type"; "Current Accusation Type")
                {
                    ApplicationArea = All;
                }
                field("Actual Court Number"; "Actual Court Number") { }
                field("Court Number Record"; "Court Number Record") { }
                field("Court Expenses Amount"; "Court Expenses Amount") { }
                field("Court Expenses Payment Date"; "Court Expenses Payment Date") { }
                field("Court Expenses Amount Paid"; "Court Expenses Amount Paid") { }
                field(Archive; Archive) { Editable = true; }

            }



        }

    }

    actions
    {
        area(Navigation)
        {

            action(ImportAccusationDocumentEE2)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE2';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort "ImportTuzbeSaGas";

                begin
                    ImportServiceItem.RUN;
                end;
            }

            action(ImportAccusationDocumentEE3)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE3';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort ImportTuzbeSeptembar;

                begin
                    ImportServiceItem.RUN;
                end;
            }

            action(ImportAccusationDocumentEE4)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE4';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort "Sud.troškovi";

                begin
                    ImportServiceItem.RUN;
                end;
            }

            action(ImportAccusationDocumentEE5)
            {
                ApplicationArea = all;
                Caption = 'Import Accusation Document EE5';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort ImportTuzbeFebruar;

                begin
                    ImportServiceItem.RUN;
                end;
            }
        }




    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetFilter(Archive, '%1', false);
    end;
}
