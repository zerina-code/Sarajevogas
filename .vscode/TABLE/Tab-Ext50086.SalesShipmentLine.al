tableextension 50086 SalesShipmentLine extends "Sales Shipment Line"
{
    fields
    {
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50001; "Manufacturer Code"; Code[20])
        {

            DataClassification = ToBeClassified;

        }
        field(50049; "Payment Type Invoice"; Code[10]) //ED
        {
            Caption = 'Payment Type Invoice';
            TableRelation = "Customer Templ.";
        }
        field(50050; "Fiscal printed"; Boolean)
        {
            Caption = 'Fiscal printed';
        }
        field(50051; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }
        field(50052; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50053; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }

        field(50055; "Vehicle Registration"; Text[250])
        {
            Caption = 'Vehicle Registration';
        }

        field(50056; "Driver type"; Option)
        {
            Caption = 'Driver type';
            OptionCaption = ' ,External,Internal';
            OptionMembers = " ",External,Internal;


        }
        field(50057; "Driver ID"; Code[20])
        {

            TableRelation = "Employee Statistics Group".Code;



        }

        field(50578; "Driver Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Name';



        }
        field(50579; "Driver Registration No."; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Driver Registration No.';



        }
        field(50580; "Payment Method Code"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Payment Method Code';



        }
        field(50581; "Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';

        }
        field(50582; "Amount Incl. VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount Incl. VAT';



        }

        field(50595; "Internal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Internal';



        }
        field(50596; "NN"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'NN';



        }
        field(50054; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';

        }
        field(500858; "Bill Type"; Code[20])
        {
            Caption = 'Bill Type';

        }
    }
}
