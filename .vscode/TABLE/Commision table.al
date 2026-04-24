/*table 50242 "Comission Members"
{
    Caption = 'Comission Members';

    fields
    {
        field(1; "Job Violation No."; Integer)
        {
            Caption = 'Job violation No.';
            NotBlank = true;
            TableRelation = "Work Duties Violation"."No.";

            trigger OnValidate()
            begin
                "Line No." += 10000;
                //ĐK   Active := TRUE;
            end;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Employee No."; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Work Duties Violation"."Employee No." WHERE("No." = FIELD("Job Violation No.")));
            Caption = 'Employee No.';

        }
        field(10; "Comission Member No."; Code[10])
        {
            Caption = 'Comission Member No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF emp.GET("Comission Member No.") THEN BEGIN
                    "Comission Member First Name" := emp."First Name";
                    "Comission Member Last Name" := emp."Last Name";
                END;

                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", "Comission Member No.");
                EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                IF EmployeeContractLedger.FINDLAST THEN BEGIN
                    EmployeeContractLedger.CALCFIELDS("Position Description");
                    EmployeeContractLedger.CALCFIELDS("Residence/Network", "Department Name", Sector, "Department Category", Group);
                    EmployeeContractLedger.CALCFIELDS("Sector Description", "Department Cat. Description", "Group Description");

                  


                    //"Position Code":=EmployeeContractLedger."Position Code";
                    //"Position ID":=EmployeeContractLedger."Position ID";
                    "Position Description" := EmployeeContractLedger."Position Description";
                    "Department Code" := EmployeeContractLedger."Department Code";
                    "Department Name" := EmployeeContractLedger."Department Name";
                    //"B-1":=EmployeeContractLedger."B-1";
                    "B-1 Description" := EmployeeContractLedger."Sector Description";
                    // "B-1 (with regions)":=EmployeeContractLedger."B-1 (with regions)";
                    "B-1 (with regions) Desc" := EmployeeContractLedger."Department Cat. Description";
                    // Stream:=EmployeeContractLedger.Stream;
                    "Stream Description" := EmployeeContractLedger."Group Description";

                END;

                Department.SETFILTER(Code, '%1', "Department Code");
                IF Department.FIND('+') THEN
                    "Department Type" := (Department."Department Type");
            end;
        }
        field(11; "Comission Member Last Name"; Text[50])
        {
            Caption = 'Comission Member Last Name';
        }
        field(12; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(13; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
        }
        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(15; Position; Code[10])
        {
            Caption = 'Position';
        }
        field(16; "Position 2"; Code[10])
        {
            Caption = 'Position 2';
        }
        field(17; "Position 3"; Code[10])
        {
            Caption = 'Position 3';
        }
        field(18; "Lead-Time Offset"; DateFormula)
        {
            Caption = 'Lead-Time Offset';
        }
        field(19; "Routing Link Code"; Code[10])
        {
            Caption = 'Routing Link Code';
            //ĐK  TableRelation = Type;
        }
        field(20; "Scrap %"; Decimal)
        {
            BlankNumbers = BlankNeg;
            Caption = 'Scrap %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
        }
        field(21; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
        }
        field(22; Comment; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = Normal;
        }
        field(28; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(29; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(40; Length; Decimal)
        {
            Caption = 'Length';
            DecimalPlaces = 0 : 5;
        }
        field(41; Width; Decimal)
        {
            Caption = 'Width';
            DecimalPlaces = 0 : 5;
        }
        field(42; Weight; Decimal)
        {
            Caption = 'Weight';
            DecimalPlaces = 0 : 5;
        }
        field(43; Depth; Decimal)
        {
            Caption = 'Depth';
            DecimalPlaces = 0 : 5;
        }
        field(44; "Calculation Formula"; Option)
        {
            Caption = 'Calculation Formula';
            OptionCaption = ' ,Length,Length * Width,Length * Width * Depth,Weight';
            OptionMembers = " ",Length,"Length * Width","Length * Width * Depth",Weight;
        }
        field(45; "Quantity per"; Decimal)
        {
            Caption = 'Quantity per';
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Designator name"; Code[250])
        {
        }
        field(50002; "Part No. qty per BOM"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50003; "Comission Member First Name"; Text[50])
        {
            Caption = 'Comission Member Last Name';
        }
        field(50320; "B-1 Description"; Text[100])
        {
            Caption = 'B-1 Description';
            Editable = false;
        }
        field(50322; "B-1 (with regions) Desc"; Text[250])
        {
            Caption = 'B-1 SA REGIJAMA člana komisije';
            Editable = false;
        }
        field(50324; "Stream Description"; Text[100])
        {
            Caption = 'Stream Description';
            Editable = false;
        }
        field(50325; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(50326; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
        }
        field(50327; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = false;
        }
        field(50328; "Management Level"; Code[10])
        {
            Caption = 'Manager Management Level';
        }
        field(50330; "Department Type"; Enum "Department Type")
        {
            Caption = 'Department Type';

        }
        field(50331; Active; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Job Violation No.", "Comission Member No.")
        {
        }
        key(Key2; "Comission Member No.", "Comission Member Last Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        ProdBOMComment: Codeunit "Temp Blob";
    //  PlanningAssignment: Record "Total Staff";
    begin
    end;

    var
        Text000: Label '%1 must be later than %2.';
        Item: Record "Item";
        //ĐK  ProdBOMHeader: Record "Institution/Company";
        ItemVariant: Record "Item Variant";
        BOMVersionUOMErr: Label 'The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4.', Comment = '%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code';
        BOMHeaderUOMErr: Label 'The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3.', Comment = '%1=UOM Code;%2=Item No.;%3=Production BOM No.';
        BOMLineUOMErr: Label 'The Unit of Measure Code %1 for Item %2 does not exist. Identification fields and values: Production BOM No. = %3, Version Code = %4, Line No. = %5.', Comment = '%1=UOM Code;%2=Item No.;%3=Production BOM No.;%4=Version Code;%5=Line No.';
        ProdBOMLine: Record "Comission Members";
        EmployeeContractLedger: Record "Employee Contract Ledger";
        emp: Record "Employee";
        //ĐK SegmentationGroup: Record "Segmentation Data";
        WDV: Record "Work Duties Violation";
        Department: Record "Department";
}

*/