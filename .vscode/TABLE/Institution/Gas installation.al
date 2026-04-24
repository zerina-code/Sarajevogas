

table 50088 "GasInstallationsE"

{

    Caption = 'Gas Installations';
    LookupPageID = "Gas InstallationsE";
    DataClassification = CustomerContent;
    DrillDownPageId = "Gas InstallationsE";



    fields

    {

        field(1; "Gas Installation No."; Code[20])

        {

            Caption = 'Gas Installation No.';

            TableRelation = "Fixed Asset";

        }

        field(3; "Main Asset Comp. No."; Code[20])

        {

            Caption = 'Main Asset Comp. No.';

            NotBlank = true;

            TableRelation = "Item";
            trigger OnValidate()
            var
                myInt: Integer;
                ItemR: Record Item;
            begin
                ItemR.Reset();
                ItemR.SetFilter("No.", '%1', rec."Main Asset Comp. No.");
                if ItemR.FindFirst() then
                    "Main Asset Comp. Description." := ItemR."Description"
                else
                    "Main Asset Comp. Description." := '';
            end;


        }
        field(6; "Main Asset Comp. Description."; text[250])

        {

            Caption = 'Main Asset Comp.Description';

            NotBlank = true;



        }


        field(4; LineNo; Integer)

        {

            Caption = 'Line No.';


        }

        field(5; "Serial Number from the Scheme"; Integer)

        {

            Caption = 'Serial Number from the Scheme';


        }

        field(7; "Autoint"; Integer)

        {

            Caption = 'Autoint';
            AutoIncrement = true;

        }


    }


    keys

    {

        key(Key1; "Gas Installation No.", "Main Asset Comp. No.", LineNo, Autoint, "Serial Number from the Scheme")

        {

            Clustered = true;

        }


    }


    fieldgroups

    {

    }


    var


        FA: Record "Fixed Asset";

        FADeprBook: Record "FA Depreciation Book";

        MainAssetComp: Record "Main Asset Component";


}




