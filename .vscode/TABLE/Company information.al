tableextension 50014 CompanyInfExt extends "Company Information"
{
    fields
    {
        // Add changes to table fields here


        field(50000; "Bank No. 1"; Code[10])
        {
            Caption = 'Bank No. 1';
            TableRelation = "Bank Account";
        }
        field(50001; "Bank No. 2"; Code[10])
        {
            Caption = 'Bank No. 2';
            TableRelation = "Bank Account";
        }
        field(50002; "Bank No. 3"; Code[10])
        {
            Caption = 'Bank No. 3';
            TableRelation = "Bank Account";
        }
        field(50003; "Bank No. 4"; Code[10])
        {
            Caption = 'Bank No. 4';
            TableRelation = "Bank Account";
        }
        field(50004; "Municipality Code"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality where(Type = filter(Regular));

            trigger OnValidate()
            begin
                IF Municipality.GET("Municipality Code")
                  THEN
                    "Municipality Name" := Municipality.Name;
            end;
        }
        field(50005; "Buss. Scope Description"; Text[80])
        {
            Caption = 'Buss. Scope Description';
        }
        field(50006; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }
        field(50007; "Employees No."; Integer)
        {
            Caption = 'Employees No.';
        }
        field(50017; "Company Prefix"; text[250])
        {
            Caption = 'Company Prefix';
        }
        field(50118; CEO; Text[100])
        {
            Caption = 'CEO';
        }
        field(50119; "Employee No."; Code[10])
        {
            TableRelation = Employee."No.";
        }
        field(50120; "Employeess No."; Code[10])
        {
        }
        field(50011; "Municipality Name"; Text[30])
        {
            Caption = 'Municipality name';
            TableRelation = Municipality.Name where(Type = filter(Regular));
        }
        field(50012; "Code"; Text[30])
        {
            Caption = 'Code';
        }
        field(50013; MBS; Code[50])
        {
        }
        field(50014; "Operater No"; Text[250])
        {
            Caption = 'Operater No';
        }
        field(50015; "Operater E-mail"; Text[250])
        {
            Caption = 'Operater E-mail';
        }
        field(50016; "Prefix for JS"; Text[250])
        {
            Caption = 'Prefix for JS';
        }
        field(50020; "Billing Signatory"; BLOB)
        {
            Caption = 'Billing Signatory';
            SubType = Bitmap;

            trigger OnValidate()
            begin

            end;
        }

        field(50021; "Billing Signatory Emp"; Code[20])
        {
            Caption = 'Billing Signatory Emp"';
            TableRelation = Employee."No.";

        }

        field(50022; "Phone Number Butile"; text[250])
        {
            Caption = 'Phone Number Butile';

        }
        field(50023; "Fax Butile"; text[250])
        {
            Caption = 'Fax Butile';

        }







        field(50025; "Country Code"; Text[30])
        {
            Caption = 'Country Code';
        }
        field(50026; "Portal"; Boolean)
        {
            Caption = 'Portal';
        }
        field(50008; "Country Name"; Text[50])
        {
            Caption = 'Country Name';
            Editable = false;
        }
        field(50077; "Ekstenzija za e-mail"; Text[1000])
        {

        }

        field(50009; "Chief Executive (Sign.)"; Text[50])
        {
            Caption = 'Chief Executive (Sign.)';
        }
        field(50010; "Assistant Chief Exec. (Sign.)"; Text[50])
        {
            Caption = 'Assistant Chief Exec. (Sign.)';
        }
        field(50028; "Bank No. 5"; Code[10])
        {
            Caption = 'Bank No. 5';
            TableRelation = "Bank Account";
        }
        field(50029; "Bank No. 6"; Code[10])
        {
            Caption = 'Bank No. 6';
            TableRelation = "Bank Account";
        }
        field(50030; "Bank No. 7"; Code[10])
        {
            Caption = 'Bank No. 7';
            TableRelation = "Bank Account";
        }
        field(50031; "Bank No. 8"; Code[10])
        {
            Caption = 'Bank No. 8';
            TableRelation = "Bank Account";
        }
        field(50032; "Bank No. 9"; Code[10])
        {
            Caption = 'Bank No. 9';
            TableRelation = "Bank Account";
        }
        field(50033; "Bank No. 10"; Code[10])
        {
            Caption = 'Bank No. 10';
            TableRelation = "Bank Account";
        }
        field(50034; "Bank No. 11"; Code[10])
        {
            Caption = 'Bank No. 11';
            TableRelation = "Bank Account";
        }
        field(50035; "Bank No. 12"; Code[10])
        {
            Caption = 'Bank No. 12';
            TableRelation = "Bank Account";
        }
        field(50036; "Bank No. 13"; Code[10])
        {
            Caption = 'Bank No. 13';
            TableRelation = "Bank Account";
        }
        field(50037; "Bank No. 14"; Code[10])
        {
            Caption = 'Bank No. 14';
            TableRelation = "Bank Account";
        }
        field(50038; "Bank No. 15"; Code[10])
        {
            Caption = 'Bank No. 15';
            TableRelation = "Bank Account";
        }
        field(52015725; "National Classification Number"; Text[30])
        {
            Caption = 'National Classification Number';
            Description = 'SKHR7.00';
        }
        field(52015726; "Note 1"; Text[2000])
        {
            Caption = 'Note 1 for INO customer';
        }
        field(520157267; "Note 2"; Text[2000])
        {
            Caption = 'Note 2 for Sales Header';
        }
        field(520157268; "Path for Documents"; Text[1000])
        {
            Caption = 'Path for Documents';
        }
        field(520157269; "Universal Value for CR"; Text[1000])
        {
            Caption = 'Universal Value for CR';
        }
        field(520157270; "Universal Value for OC"; Text[1000])
        {
            Caption = 'Universal Value for Order Confirmation';
        }
        field(520157271; "Sender Name"; Text[1000])
        {
            Caption = 'Sender';
        }
        field(520157272; "Path Value"; Text[1000])
        {
            Caption = 'Path Value';
        }
        field(520157273; "Logs"; integer)
        {
            Caption = 'KIF/KUF Logs';
            FieldClass = FlowField;
            CalcFormula = count("Types Of Diseases" where(Types = filter("KIF KUF Logs")));

        }
        field(520157274; "Tax No."; Text[20])
        {
            Caption = 'Tax No.';
        }
        field(520157275; "Registration Text"; Text[100])
        {
            Caption = 'Registration Text';
        }
        field(520157276; "Household"; Integer)
        {
            Caption = 'HouseHold';
        }
        field(520157278; "Large Economy"; Integer)
        {
            Caption = 'Large Economy';
        }
        field(520157277; "KJKP Heating plant"; Integer)
        {
            Caption = 'KJKP Heating plan';
        }
        field(520157280; "Special Customer"; Integer)
        {
            Caption = 'Special Customer';
        }
        field(520157281; "CNG"; Integer)
        {
            Caption = 'CNG';
        }
        field(520157282; "Small Economy"; Integer)
        {
            Caption = 'Small Economy';
        }
        field(520157283; "Dispatch Center"; Text[500])
        {
            Caption = 'Dispatch Center';
        }
        field(520157285; "Contact Phone"; Text[500])
        {
            Caption = 'Contact Phone';
        }
        field(520157292; Picture1; BLOB)
        {
            Caption = 'Picture1';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated1 := true;
            end;
        }
        field(520157287; Picture2; BLOB)
        {
            Caption = 'Picture2';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated2 := true;
            end;
        }
        field(520157288; Picture3; BLOB)
        {
            Caption = 'Picture3';
            SubType = Bitmap;

            trigger OnValidate()
            begin
                PictureUpdated3 := true;
            end;
        }

        field(527280; "Accusation Responsible Person Exe"; Text[250])
        {
            Caption = 'Accusation Responsible Person Exe';
            TableRelation = Employee."No.";
        }




        field(520157286; "Accusation Responsible Person"; Text[250])
        {
            Caption = 'Accusation Responsible Person';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Accusation Responsible Person");
                if EmployeeTable.FindFirst() then begin
                    "Accusation Responsible Person Name" := EmployeeTable."First Name" + ' ' + EmployeeTable."Last Name";
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee Status", '%1', "Employee Status"::Active);
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', EmployeeTable."No.");
                    if EmployeeContractLedger.FindFirst() then begin
                        "Accusation Responsible Person Position" := EmployeeContractLedger."Position Description";
                    end;

                end
                else
                    if ("Accusation Responsible Person" = '') then begin
                        "Accusation Responsible Person Position" := '';
                        "Accusation Responsible Person Name" := '';
                    end


            end;
        }
        field(520157289; "Accusation Responsible Person Position"; Text[250])
        {
            Caption = 'Accusation Responsible Person Position';
            Editable = false;

        }
        field(520157290; "Accusation Responsible Person Name"; Text[250])

        {
            Caption = 'First and last name of accusation responsible person';
            Editable = false;
        }
        field(520157291; "Accusation Phone No."; Text[250])

        {
            Caption = 'Accusation Phone No.';
            Editable = true;
        }


        field(520157294; "Activity Code"; Text[250])

        {
            Caption = 'Activity Code';
            Editable = true;
        }
        field(520157295; "Employee Signatory"; COde[20])

        {
            Caption = 'Employee Signatory';
            Editable = true;
            TableRelation = Employee."No.";
        }
        field(520157298; "Spending Plan Responsible Person"; Text[250])
        {
            Caption = 'Spending Plan Responsible Person';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Spending Plan Responsible Person");
                if EmployeeTable.FindFirst() then begin
                    "Spending Plan Responsible Person Name" := EmployeeTable."First Name" + ' ' + EmployeeTable."Last Name";
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee Status", '%1', "Employee Status"::Active);
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', EmployeeTable."No.");
                    if EmployeeContractLedger.FindFirst() then begin
                        "Spending Plan Responsible Person Position" := EmployeeContractLedger."Position Description";
                    end;

                end
                else
                    if ("Spending Plan Responsible Person" = '') then begin
                        "Spending Plan Responsible Person Position" := '';
                        "Spending Plan Responsible Person Name" := '';
                    end


            end;
        }
        field(520157296; "Spending Plan Responsible Person Position"; Text[250])
        {
            Caption = 'Spending Plan Responsible Person Position';
            Editable = false;

        }
        field(520157297; "Spending Plan Responsible Person Name"; Text[250])

        {
            Caption = 'First and last name of Spending Plan responsible person';
            Editable = false;
        }
        field(520157299; "Standard for the gas"; Text[250])
        {
            Caption = 'Standard for the gas';

        }
        field(520157300; "E-mail2"; Text[250])
        {
            Caption = 'E-mail2';

        }
        field(520157301; "Fax2"; Text[250])
        {
            Caption = 'Fax 2';

        }
        field(520157302; "Purchase Phone No."; Text[250])
        {
            Caption = 'Purchase Phone No.';
        }
        field(520157303; "Purchase E-mail"; Text[250])
        {
            Caption = 'Purchase E-mail';
        }
        field(520157304; "Billing Sign"; BLOB)
        {
            Caption = 'Billing Sign';
            SubType = Bitmap;

            trigger OnValidate()
            begin

            end;
        }

    }

    var
        myInt: Integer;
        Municipality: Record "Municipality";
        PictureUpdated1: Boolean;
        PictureUpdated2: Boolean;
        PictureUpdated3: Boolean;
        EmployeeTable: Record Employee;
        EmployeeContractLedger: Record "Employee Contract Ledger";
}