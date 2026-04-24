tableextension 50071 TransferHeaderExtends extends "Transfer Header"
{

    fields
    {


        modify("Transfer-to Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                GenRec: Record "Gen. Business Posting Group";
                LocRec: Record Location;
            begin
                if ("Transfer-to Code" <> '') and (("Transfer-from Code" <> '')) then begin
                    if "Gen. Bus. Posting Group" = '' then begin
                        GenRec.Reset();
                        GenRec.SetFilter(Code, '%1', 'DOMAĆI');
                        if GenRec.FindFirst()
                         then
                            validate("Gen. Bus. Posting Group", 'DOMAĆI');
                    end;
                    if "In-Transit Code" = '' then begin
                        LocRec.Reset();
                        LocRec.SetFilter(Code, '%1', 'TRANZIT');
                        LocRec.SetFilter("Use As In-Transit", '%1', true);
                        if LocRec.FindFirst() then
                            validate("In-Transit Code", 'TRANZIT');
                    end;

                end;
            end;
        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }
        field(50115; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        //    VAT Base (retro.)
        field(50000; "Gen. Bus. Posting Group"; Code[20])
        {

            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";
            Caption = 'Gen. Business Posting Group';

        }
        field(501156; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Inventory Posting Group";
            Caption = 'G/L Account No.';
        }

        field(50023; "Department Code"; Code[20])
        {
            Caption = 'Department Code';

        }

        field(50020; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Employee No.");
                if EmployeeTable.FindFirst() then
                    "Employee Name" := StrSubstNo('%1 %2', Format(EmployeeTable."First Name"), Format(EmployeeTable."Last Name"));
            end;

        }
        field(50021; "Employee Name"; Text[40])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50022; "Sales Header No."; Code[20])
        {
            Caption = 'Sales Header No.';

        }
        field(51022; "Calculation Number"; Text[50])
        {
            Caption = 'Calculation Number';
            Editable = false;

        }
        field(50018; "Correction"; Boolean)
        {
            Caption = 'Correction';
        }
        field(51024; "Hide CNG MP"; Boolean)
        {
            Caption = 'Hide CNG MP';
        }
        field(51025; "R. CNG MLP"; Boolean)
        {
            Caption = 'R. CNG MLP';
        }
        field(50024; "Sales Line No."; integer)
        {
            Caption = 'Sales Line No.';

        }



    }
    trigger OnInsert()

    var
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Gener: Record "General Ledger Setup";
    begin
        /* Ukloniti komentare ako zatreba      

                                
                                    Gener.Get();
                                    if "Calculation Number" = '' then begin
                                        Gener.Get();
                                        if ("Transfer-to Code" = 'CNG MLP') then begin
                                            "Calculation Number" := NoSeriesMgt.GetNextNo(Gener."Retail Calc. Entry Series", TODAY, true);
                                        end
                                        ELSE
                                            if ("Transfer-from Code" = 'CNG VLP') then begin
                                                "Calculation Number" := NoSeriesMgt.GetNextNo(Gener."Wholesale Calc. Entry Series", TODAY, true);
                                            end;
                                    end;
                                */
    end;

    var
        Cu: Codeunit "TransferOrder-Post Shipment";
        EmployeeTable: Record Employee;
        Gener: Record "General Ledger Setup";
}