page 50177 "Calculation Journal Line"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Calculation Journal Line";
    Caption = 'Calculation Journal Line';

    layout
    {
        area(Content)
        {
            repeater("")
            {


                field(Code; Code) { ApplicationArea = all; }
                field("Year of Calculation"; "Year of Calculation") { ApplicationArea = all; }
                field("Month of Calculation"; "Month of Calculation") { ApplicationArea = all; }
                field("Previous Date"; "Previous Date") { }
                field("Reading Date From"; "Reading Date From") { }
                field("Reading Date To"; "Reading Date To") { }
                field("Calculation Date To"; "Calculation Date To") { }
                field(Gauge; Gauge) { ApplicationArea = all; }
                field("Serial Number"; "Serial Number") { ApplicationArea = all; }
                field("Corrector Code"; "Corrector Code") { }
                field("EL Volume Description"; "EL Volume Description") { }
                field("EL Correctior Type"; "EL Correctior Type") { ApplicationArea = all; }
                field("EL Correctior previous"; "EL Correctior previous") { ApplicationArea = all; }

                field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
                //  field("MM Description"; "MM Description") {ApplicationArea = all;  }
                field("Address MM"; "Address MM") { ApplicationArea = all; }
                field("Municipality Code MM"; "Municipality Code MM") { ApplicationArea = all; }
                field("Municipality Name MM"; "Municipality Name MM") { ApplicationArea = all; }
                field("MZ MM"; "MZ MM") { ApplicationArea = all; }
                field("MZ Name MM"; "MZ Name MM") { ApplicationArea = all; }
                field(Street; Street) { ApplicationArea = all; }
                field("Street Name MM"; "Street Name MM") { ApplicationArea = all; }
                field("Home No."; "Home No.") { ApplicationArea = all; }
                field(Floor; Floor) { ApplicationArea = all; }
                field("Apartment No."; "Apartment No.") { ApplicationArea = all; }

                field("Customer No."; "Customer No.") { ApplicationArea = all; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; }
                field("MM Description"; "MM Description") { ApplicationArea = all; }
                field("Address Customer"; "Address Customer") { ApplicationArea = all; }
                field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; }
                field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; }
                field("MZ Customer"; "MZ Customer") { ApplicationArea = all; }
                field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; }
                field("Street Customer"; "Street Customer") { ApplicationArea = all; }
                field("Home No. Customer"; "Home No. Customer") { ApplicationArea = all; }
                field("Floor Customer"; "Floor Customer") { ApplicationArea = all; }
                field("Apartment No. Customer"; "Apartment No. Customer") { ApplicationArea = all; }
                field("Remotely Type"; "Remotely Type") { ApplicationArea = all; }

                field("Reading Mode"; "Reading Mode") { ApplicationArea = all; }
                field("Mobile No."; "Mobile No.") { ApplicationArea = All; }
                field("Fictitious Code"; "Fictitious Code") { ApplicationArea = all; }
                field("Type of reading"; "Type of reading") { ApplicationArea = All; }
                field("Reading Time"; "Reading Time") { ApplicationArea = all; }
                field(Posting; Posting) { }
                field(Distribution; Distribution) { }
                field("Distribution - read"; "Distribution - read") { }
                field(Specification; Specification) { }
                field("Bill delivery"; "Bill delivery") { }
                field("RMS Maintenance"; "RMS Maintenance") { }
                field("Category Customer"; "Category Customer") { }
                field("Category MM"; "Category MM") { }
                field("Document No. Posting"; "Document No. Posting") { }
                field("Reminder Terms Code"; "Reminder Terms Code") { }
                field("Reading Date From2"; "Reading Date From") { }
                field("Reading Date To2"; "Reading Date To") { }




            }

        }




    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetRange("Date Filter", 0D, "Calculation Date To");
    end;


    var
        myInt: Integer;
}