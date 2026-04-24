pageextension 50146 "Service Item List" extends "Service Item List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field(Description2; Description) { ApplicationArea = all; }
            field("MM Category"; "MM Category") { ApplicationArea = all; }
            field("Status MM"; "Status MM")
            { }
            field("Dwelling Type"; Rec."Dwelling Type") { ApplicationArea = all; ShowMandatory = true; }
            field("MM VAT Excluded"; "MM VAT Excluded") { ApplicationArea = all; }
            field("Control Number"; "Control Number") { ApplicationArea = all; }
            field("Applied address"; "Applied address") { ApplicationArea = all; }
            field(Street; Street) { ApplicationArea = all; }
            field("Street Name MM"; "Street Name MM") { ApplicationArea = all; Editable = false; }

            field("Street No."; "Street No.") { ApplicationArea = all; }
            field("Street No. Text"; "Street No. Text") { ApplicationArea = all; }

            field("Address MM"; "Address MM") { ApplicationArea = all; }



            field("Municipality Code MM"; "Municipality Code MM") { ApplicationArea = all; Editable = false; }
            field("Municipality Name MM"; "Municipality Name MM") { ApplicationArea = all; Editable = false; }
            field("MZ MM"; "MZ MM") { ApplicationArea = all; Editable = false; }
            field("MZ Name MM"; "MZ Name MM") { ApplicationArea = all; Editable = false; }


            field("Home No."; "Home No.") { ApplicationArea = all; }
            field(Floor; Floor) { ApplicationArea = all; }
            field("Apartment No."; "Apartment No.") { ApplicationArea = all; }
            field("Measuring Point Stroke"; "Measuring Point Stroke") { ApplicationArea = all; Editable = false; }
            field("Measuring Point string"; "Measuring Point string") { ApplicationArea = all; Editable = false; }
            field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = false; }
            field(Hodogram; Hodogram) { ApplicationArea = all; }

            field("Address Customer"; "Address Customer") { ApplicationArea = all; Editable = false; Visible = false; }

            field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Street Customer"; "Street Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Floor Customer"; "Floor Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = false; Visible = false; }
            field("Customer string"; "Customer string") { ApplicationArea = all; Editable = false; Visible = false; }

            field(Activity; Activity)
            {
                ApplicationArea = all;
            }
            field("EU Activity"; "EU Activity") { ApplicationArea = all; }
            field("EF Activity"; "EF Activity") { ApplicationArea = all; }

            field("Summer Zone"; "Summer Zone") { ApplicationArea = all; }
            field("Winter Zone"; "Winter Zone") { ApplicationArea = all; }
            field("Transit Zone"; "Transit Zone") { ApplicationArea = all; }
            field("Measuring Zone - winter"; "Measuring Zone - winter") { ApplicationArea = all; }
            field("Measuring Zone - summer"; "Measuring Zone - summer") { ApplicationArea = all; }
            field("Fictitious Code"; "Fictitious Code") { ApplicationArea = all; }
            field("Pressure Date"; "Pressure Date") { ApplicationArea = all; }
            field("Adjusted Pressure"; "Adjusted Pressure") { ApplicationArea = all; }
            field(GIS; GIS) { ApplicationArea = all; }

            field("Reading Mode"; "Reading Mode")
            {
                ApplicationArea = all;

            }
            field("Reading Type"; "Reading Type") { ApplicationArea = all; Visible = false; }
            field("Type of reading"; "Type of reading") { ApplicationArea = all; }
            field("Reading Time"; "Reading Time") { ApplicationArea = all; }

            field(Remotely; Remotely) { ApplicationArea = all; Editable = true; }
            field("Remotely Type"; "Remotely Type") { ApplicationArea = all; }
            field("Mobile No."; "Mobile No.") { ApplicationArea = all; }
            field("Economic/Technic"; "Economic/Technic") { ApplicationArea = all; Visible = false; }

            field("Gauge Position"; "Gauge Position") { ApplicationArea = all; Editable = true; }
            field("Posting GAS"; "Posting GAS") { ApplicationArea = all; }

            field("Flow Direction"; "Flow Direction")
            {
                ApplicationArea = All;
            }
            field("VU Installation"; "VU Installation")
            {
                ApplicationArea = All;
            }
            field("HV Installation"; "HV Installation")
            {
                ApplicationArea = All;
            }
            field("Pul"; "Pul") { ApplicationArea = all; }
            field("Piz"; "Piz") { ApplicationArea = all; }
            field("Tmin"; "Tmin") { ApplicationArea = all; }
            field("Tmax"; "Tmax") { ApplicationArea = all; }

            field(Contact3; Contact) { ApplicationArea = all; Editable = true; }
            field("Phone No.2"; "Phone No.") { ApplicationArea = all; }
            field("Applied Customer inf"; "Applied Customer inf") { ApplicationArea = all; }

            field("Contact MM"; "Contact MM") { ApplicationArea = all; Editable = true; }
            field("Phone No. MM"; "Phone No. MM") { ApplicationArea = all; }
            field("Fax No."; "Fax No.") { ApplicationArea = all; }
            field("Fax No. - Transfer"; "Fax No. - Transfer") { ApplicationArea = all; }
            field("E-Mail"; "E-Mail") { ApplicationArea = all; }
            field("Mobile Phone No."; "Mobile Phone No.") { ApplicationArea = all; }


            field(Purpose; Purpose) { ApplicationArea = all; }
            field(Designer; Designer) { ApplicationArea = all; }
            field("Consent ID"; "Consent ID") { ApplicationArea = all; }
            field(Measured; Measured) { ApplicationArea = all; }
            field(Unmeasured; Unmeasured) { ApplicationArea = all; }

            field("Date 1"; "Date 1") { ApplicationArea = all; }
            field("Date 2"; "Date 2") { ApplicationArea = all; }
            field("Date 3"; "Date 3") { ApplicationArea = all; }
            field("Minimal Consumption"; "Minimal Consumption") { ApplicationArea = all; }
            field(Elevation; Elevation) { ApplicationArea = all; }
            field("Date TK"; "Date TK") { ApplicationArea = all; }

            field("Starting Measuring"; "Starting Measuring") { ApplicationArea = all; }
            field(Statement; Statement) { ApplicationArea = all; }
            field("Technical review"; "Technical review") { ApplicationArea = all; }

            field("Installed KW"; "Installed KW") { ApplicationArea = all; }
            field("Designed KW"; "Designed KW") { ApplicationArea = all; }


            field("Alternative fuel"; "Alternative fuel") { ApplicationArea = all; }



            field("Owner Primary Contact"; "Owner Primary Contact")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Owner Primary Code';
                Importance = Additional;
            }
            field(ContactNameOwner; "Owner Contact")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Contact Name';

                Importance = Promoted;
                ToolTip = 'Specifies the name of the person you regularly contact when you do business with this customer.';

                trigger OnValidate()
                begin

                end;
            }
            field("Owner Phone No."; "Owner Phone No.")
            {
                ApplicationArea = Basic, Suite;

            }
            field("Owner Mobile Phone No."; "Owner Mobile Phone No.")
            {
                Caption = 'Owner Mobile Phone No.';
                ApplicationArea = Basic, Suite;
                ExtendedDatatype = PhoneNo;
            }
            field("Owner E-Mail"; "Owner E-Mail")
            {
                ApplicationArea = Basic, Suite;
                ExtendedDatatype = EMail;
                Importance = Promoted;
            }
            field("Measuring point off"; "Measuring point off") { }
            field("Measuring point off Date"; "Measuring point off Date") { }
            field("Measuring point in"; "Measuring point in") { }
            field("Measuring point in Date"; "Measuring point in Date") { }
            field("Last Reason"; "Last Reason") { }



        }
    }
    actions
    {
        // Add changes to page actions here

        addbefore(Statistics)
        {
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

                    CopyDocuments.SetParameters(NewTypeCopyObject::MM, rec."No.", rec."Customer Category", rec."Home No.", rec.Floor, rec."Apartment No.");
                    CopyDocuments.RunModal;
                end;
            }

            action(ImportServiceItem)
            {
                ApplicationArea = all;
                Caption = 'Import MM';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportServiceItem: XmlPort "MM Import";

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
        CalcFields("Status MM");

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Status MM");

    end;

    var
        myInt: Integer;
}