tableextension 50043 ItemJournalLineExtends extends "Item Journal Line"
{
    fields
    {


        modify("Applies-to Entry")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                ItemL: Record "Item Ledger Entry";
                Prices: Record "Sales Price";
            begin
                if Nivelacija = true then begin
                    ItemL.reset;
                    ItemL.SetFilter("Entry No.", '%1', "Applies-to Entry");
                    if ItemL.FindFirst() then begin
                        "Unit Price Old" := ItemL."Retail Unit Price";


                        if ItemL."Retail Unit Price" = 0 then begin
                            Prices.Reset();
                            Prices.SetFilter("Starting Date", '<%1', "Posting Date");
                            Prices.SetFilter("Retail Unit Price", '<>%1', 0);
                            Prices.SetCurrentKey("Starting Date");
                            Prices.Ascending;
                            if prices.FindLast() then
                                "Unit Price Old" := ItemL."Retail Unit Price";
                        end;
                        "Unit Cost (Calculated)" := 0;
                        "Unit Cost (Revalued)" := 0;
                        "Inventory Value (Calculated)" := 0;
                        "Inventory Value (Revalued)" := 0;
                        validate(Amount, "Unit Price New" - "Unit Price Old");
                    end;
                end

            end;
        }
        field(50000; "G/L Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50100; LongDes; Text[100])
        {

        }
        field(50101; "Sales Header No."; Code[20])
        {

        }
        field(50020; "Gen Bus Posting"; Code[20])
        {
            Caption = 'Gen Bus Posting';
        }
        field(50021; "Prod Bus Posting"; Code[20])
        {
            Caption = 'Prod Bus Posting';
        }
        field(50022; "Nivelacija"; Boolean)
        {
            Caption = 'Nivelacija';
        }
        field(50048; "Unit Price Old"; Decimal)
        {
            Caption = 'Unit Price Old';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(Amount, "Unit Price New" - "Unit Price Old");

            end;
        }
        field(50024; "Unit Price New"; Decimal)
        {
            Caption = 'Unit Price New';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate(Amount, "Unit Price New" - "Unit Price Old");

            end;
        }
        field(50025; "Prepare Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Prepare Employee No.';

            trigger OnValidate()
            var
                myInt: Integer;

                Emp: Record Employee;
            begin
                Emp.Reset();
                emp.SetFilter("No.", '%1', "Prepare Employee No.");
                if emp.FindFirst() then
                    "Prepare Employee Name" := emp."First Name" + ' ' + Emp."Last Name"
                else
                    "Prepare Employee Name" := '';
            end;
        }
        field(50026; "Prepare Employee Name"; Text[250])
        {
            Caption = 'Prepare Employee Name';

        }

        field(50027; "Control Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Control Employee No.';

            trigger OnValidate()
            var
                myInt: Integer;

                Emp: Record Employee;
            begin
                Emp.Reset();
                emp.SetFilter("No.", '%1', "Control Employee No.");
                if emp.FindFirst() then
                    "Control Employee Name" := emp."First Name" + ' ' + Emp."Last Name"
                else
                    "Control Employee Name" := '';
            end;
        }
        field(50028; "Control Employee Name"; Text[250])
        {

            Caption = 'Control Employee Name';

        }
        field(50029; "Verif Employee No."; Code[20])
        {
            TableRelation = Employee."No.";
            Caption = 'Verif Employee No.';
            trigger OnValidate()
            var
                myInt: Integer;

                Emp: Record Employee;
            begin
                Emp.Reset();
                emp.SetFilter("No.", '%1', "Verif Employee No.");
                if emp.FindFirst() then
                    "Verif Employee Name" := emp."First Name" + ' ' + Emp."Last Name"
                else
                    "Verif Employee Name" := '';
            end;

        }
        field(50030; "Verif Employee Name"; Text[250])
        {

            Caption = 'Verif Employee Name';

        }
        field(50031; "Employee No."; code[20])
        {

            Caption = 'Employee No.';

        }
        field(50032; "Employee Name"; text[250])
        {

            Caption = 'Employee Name';

        }
        field(50033; "Org Name"; text[250])
        {

            Caption = 'Org Name';

        }
        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }
        field(50034; "Sales Line No."; integer)
        {
            Caption = 'Sales Line No.';

        }


    }

    trigger OnInsert()
    var
        myInt: Integer;
        JooruBa: Record "Item Journal Batch";
    begin
        rec.Nivelacija := false;
        JooruBa.Reset();
        JooruBa.SetFilter(Name, '%1', rec."Journal Batch Name");
        JooruBa.SetFilter("Journal Template Name", '%1', "Journal Template Name");
        if JooruBa.FindFirst() then begin
            if JooruBa.Nivelacija = true then begin
                rec.Nivelacija := true;
            end;
        end;

    end;
}