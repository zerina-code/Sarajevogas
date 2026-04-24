pageextension 50030 CustomerList extends "Customer List"
{
    layout
    {
        addafter(Control1)
        {



            field(Rows; Rows)
            {

                Caption = 'Rows';
            }
        }

        addafter("Phone No.")
        {
            field("Phone - Transfer"; "Phone - Transfer") { ApplicationArea = all; }
            field("Telex Answer Back"; "Telex Answer Back") { ApplicationArea = all; }
            field("Telex No."; "Telex No.") { ApplicationArea = all; }
        }


        modify("Responsibility Center") { Visible = false; }
        modify("Location Code") { Visible = false; }
        addbefore("No.") { field("Customer Category"; "Customer Category") { ApplicationArea = all; } }

        addafter("Telex No.")
        {

            field("Fax No."; "Fax No.") { ApplicationArea = all; }
            field("Fax - Transfer"; "Fax - Transfer") { ApplicationArea = all; }
        }
        addafter(Contact)
        {
            field("Mobile Phone No."; "Mobile Phone No.") { ApplicationArea = all; }
            field("E-Mail 2"; "E-Mail 2") { ApplicationArea = all; }
            field("E-mail Delivery"; "E-mail Delivery") { ApplicationArea = all; }
            field("E-mail Delivery Date"; "E-mail Delivery Date") { ApplicationArea = all; }
            field("E-mail Delivery Date to"; "E-mail Delivery Date to") { ApplicationArea = all; }
            field(Address; Address) { ApplicationArea = all; }
            field("Street Customer"; "Street Customer") { ApplicationArea = all; }
            field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = false; }
            field("Street No."; "Street No.") { ApplicationArea = all; }
            field("Street No. Text"; "Street No. Text") { ApplicationArea = all; }

            field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; Editable = false; }
            field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = false; }
            field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = false; }
            field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = false; }
            field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; Visible = false; }
            field("Floor Customer"; "Floor Customer") { ApplicationArea = all; Visible = false; }
            field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; Visible = false; }
            field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = false; }
            field("Customer String"; "Customer String") { ApplicationArea = all; Editable = false; }
            field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }
            field("Address 2"; "Address 2") { ApplicationArea = all; }

            field("Street Customer 2"; "Street Customer 2") { ApplicationArea = all; }
            field("Street Name Customer 2"; "Street Name Customer 2") { ApplicationArea = all; Editable = false; }
            field("Street No. 2"; "Street No. 2") { ApplicationArea = all; }
            field("Street No.2 Text"; "Street No.2 Text") { ApplicationArea = all; }


            field("Municipality Code Customer 2"; "Municipality Code Customer 2") { ApplicationArea = all; Editable = false; }
            field("Municipality Name Customer 2"; "Municipality Name Customer 2") { ApplicationArea = all; Editable = false; }
            field("City 2"; "City 2") { ApplicationArea = all; Editable = false; }
            field("Post Code 2"; "Post Code 2") { ApplicationArea = all; Editable = false; }
            field("MZ Customer 2"; "MZ Customer 2") { ApplicationArea = all; Editable = false; }
            field("MZ Name Customer 2"; "MZ Name Customer 2") { ApplicationArea = all; Editable = false; }

            field("Home No. Customer 2"; "Home No. Customer 2") { ApplicationArea = all; Visible = false; }
            field("Floor Customer 2"; "Floor Customer 2") { ApplicationArea = all; }
            field("Apartment No. Customer 2"; "Apartment No. Customer 2") { ApplicationArea = all; }

            field("Box Number"; "Box Number") { ApplicationArea = all; }




            field("Customer Stroke 2"; "Customer Stroke 2") { ApplicationArea = all; Editable = false; }
            field("Customer String 2"; "Customer String 2") { ApplicationArea = all; Editable = false; }
            field("Zone stroke 2"; "Zone stroke 2") { ApplicationArea = all; Editable = false; }
            field(Activity; Activity) { ApplicationArea = all; }
            field("Activity Code"; "Activity Code") { ApplicationArea = all; }
            field(Agreement; Agreement) { ApplicationArea = all; }

            field("Bill distribution percentage"; "Bill distribution percentage") { ApplicationArea = all; }



            field("Registration No."; "Registration No.") { ApplicationArea = all; }
            field("VAT Registration No."; "VAT Registration No.") { ApplicationArea = all; }
            field("Customer Status"; "Customer Status") { ApplicationArea = all; }
            field("Social status category"; "Social status category") { ApplicationArea = all; }
            field("Subsidies - YES/NO "; "Subsidies - YES/NO") { ApplicationArea = all; }
            field("Customer Contract Number"; "Customer Contract Number") { }
            field("Contract Starting Date"; "Contract Starting Date") { }


        }
        addafter("Payments (LCY)")
        {
            field("Prepayment (LCY)"; "Prepayment (LCY)") { ApplicationArea = all; Editable = false; }

        }


    }

    actions
    {
        // Add changes to page actions here
        modify("Customer - Order Summary") { Promoted = false; }
        modify("Customer - Sales List") { Promoted = false; }

        addafter(CustomerLedgerEntries)
        {
            action("Customer Listing")
            {
                ApplicationArea = all;
                Caption = 'Customer Listing';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                RunObject = Report "Current Data";
            }
            action("Customer Listing2")
            {
                ApplicationArea = all;
                Caption = 'Customer Listing2';
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                RunObject = Report "Current Data 2";
            }

            action("Repost Doubtful Receiveables")
            {
                ApplicationArea = all;
                Caption = 'Izračunaj sumnjiva i sporna potraživanja';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;
                RunObject = Report "Doubtful receivables";
            }

            action("Notification Setup")
            {
                ApplicationArea = all;
                Caption = 'Notification Setup';
                Image = MailSetup;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                // RunObject = page "List of Template Messages";
            }

            action("Import txt file MP")
            {
                Caption = 'Import txt file MP';
                Ellipsis = true;
                Image = Import;
                Visible = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CopyDocuments: Report "Copy MM or Customer";
                    NewTypeCopyObject: Enum "Enum Copy Document";

                begin

                    CopyDocuments.SetParameters(NewTypeCopyObject::Customer, rec."No.", rec."Customer Category", rec."Home No. Customer", rec."Floor Customer", rec."Apartment No. Customer");
                    CopyDocuments.RunModal;
                end;
            }


            //List of Template Messages
        }
        addafter("Cash Receipt Journal")
        {
            action("Transfer to Gen journal Line")
            {
                ApplicationArea = All;
                Caption = 'Transfer to Gen Journal Line';
                Image = TransferToGeneralJournal;
                Visible = true;
                Tooltip = 'This action will transfer the balance amount to the General Journal Line and reprogram the debt.';

                trigger OnAction()
                var
                    ReprogramReport: Report "Reprogramming of debt";
                begin
                    ReprogramReport.Run();
                end;
            }
        }
    }





    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin

        Rows := Rec.Count;
        UserSetup.GET(UserID);
        IF ((USerSetup."CNG User") OR (UserSetup."CNG Administrator"))
        then
            rec.SETFILTER("Customer Category", '%1', rec."Customer Category"::CNG);


    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin

        Rows := Rec.Count;
    end;

    var
        myInt: Integer;
        Rows: Integer;
        CustomerLedEntry: Record "Customer Ledger Entry";
        CustLedEntries: Page "Customer Ledger Entries -SA";
}