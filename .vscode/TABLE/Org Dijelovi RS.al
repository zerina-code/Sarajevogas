/*ĐK table 50112 "Org Dijelovi RS"
{
    // //n

    Caption = 'Inventory Profile Track Buffer';

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'ID.';
            NotBlank = false;
        }
        field(2; Description; Text[70])
        {
            Caption = 'Name.';
        }
        field(4; "Municipality Code"; Code[20])
        {
            Caption = 'Municipality Code.';
            TableRelation = Municipality;
        }
        field(5; "Refer To Number"; Text[50])
        {
            Caption = 'Refer To Number';
        }
        field(20; "Version Code"; Text[30])
        {
            Caption = 'Residence';
        }
        field(21; "Registration No."; Text[30])
        {
            Caption = 'Registration No.';
            NotBlank = true;
        }
        field(50000; Telephone; Text[30])
        {
            Caption = 'Telephone';
        }
        field(50001; "Bank Account No."; Text[30])
        {
            Caption = 'Account No';
        }
        field(50002; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(50003; "Industrial Classification"; Text[30])
        {
            Caption = 'Industrial Classification';
        }
        field(50004; "Industrial Classification Name"; Text[30])
        {
            Caption = 'Industrial Classification Name';
        }
        field(50005; "ORG ID"; Text[30])
        {
            Caption = 'Department ID';
        }
        field(50006; "ORG Shema"; Code[10])
        {
            Caption = 'Org Schema';
            TableRelation = "ORG Shema".Code;
        }
        field(50007; City; Text[30])
        {
            Caption = 'City';
        }
        field(50008; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";
        }
        field(50009; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50010; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50011; "Branch Agency"; Option)
        {
            Caption = 'Branch Agency';
            OptionCaption = ' ,Branch,Agency';
            OptionMembers = " ",Branch,Agency;
        }
        field(50012; "Regionalni Head Office"; Option)
        {
            Caption = 'Regional/Head Office';
            OptionCaption = ' ,Regional,Head office';
            OptionMembers = " ","Regional Head Office","Head office";
        }
        field(50013; GF; Text[30])
        {
        }
        field(50014; Region; Integer)
        {
            BlankZero = true;
            Caption = 'Region';
            NotBlank = false;
        }
        field(50015; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            Editable = true;
        }
        field(50016; "Municipality Code for salary"; Code[20])
        {
            Caption = 'Municipality Code for salary';
            TableRelation = Municipality;
        }
        field(50017; "Municipality Code of agency"; Code[20])
        {
            Caption = 'Municipality Code of agency.';
            TableRelation = Municipality;
        }
        field(50018; "JIB Contributes"; Text[30])
        {
            Caption = 'JIB Contributes';
        }
        field(50019; "Municipality Code for reg."; Code[20])
        {
            Caption = 'Municipality Code for registration';
            TableRelation = Municipality;
        }
        field(50020; Change; Text[150])
        {
        }
        field(50021; "For Calculation 4"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50022; "For Calculation 5"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50023; "For Calculation 6"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50024; "For Calculation 7"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50025; "For Calculation FA"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50026; "For Calculation FA 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50027; "For Calculation FA 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50028; "For Calculation 8"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50029; "For Calculation 9"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50030; "For Calculation 10"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50031; "For Calculation 11"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50032; "For Calculation 12"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50033; "For Calculation 13"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50034; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50035; "For Calculation 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50036; "For Calculation 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50037; "For Calculation 14"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50038; "Municipality Code CIPS"; Code[10])
        {
        }
        field(50039; "For Calculation 15"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50040; "For Calculation 16"; Decimal)
        {
            Caption = 'For Calculation';
        }
    }

    keys
    {
        key(Key1; "Code", GF, "Municipality Code CIPS")
        {
            MaintainSIFTIndex = false;
        }
    }

    fieldgroups
    {
    }
}

*/