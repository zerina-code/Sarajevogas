tableextension 50046 LocationExtends extends Location
{

    //ED

    fields
    {
        field(50001; "Use As In-Revers"; Boolean)
        {
            Caption = 'Use As In-Revers';
        }
        field(50002; Order; Integer)
        {
            Caption = 'Order';
        }
        field(50003; "Responsible Person"; code[20])
        {
            Caption = 'Responsible Person in warehouse';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Responsible Person");
                if EmployeeTable.FindFirst() then begin
                    "Responsible Person Name" := EmployeeTable."First Name" + ' ' + EmployeeTable."Last Name";
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee Status", '%1', "Employee Status"::Active);
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', EmployeeTable."No.");
                    if EmployeeContractLedger.FindFirst() then begin
                        "Responsible Person Position" := EmployeeContractLedger."Position Description";
                    end;

                end
                else
                    if ("Responsible Person" = '') then begin
                        "Responsible Person Position" := '';
                        "Responsible Person Name" := '';
                    end


            end;
        }

        field(50004; "Responsible Person Position"; Text[250])
        {
            Caption = 'Responsible Person Position';
            Editable = false;

        }
        field(50005; "Responsible Person Name"; Text[250])

        {
            Caption = 'First and last name of responsible person';
            Editable = false;
        }
        field(50006; "Responsible Person Exit"; Code[20])
        {
            Caption = 'Responsible Person Exit';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Responsible Person Exit");
                if EmployeeTable.FindFirst() then begin
                    "Responsible Person Exit Name" := EmployeeTable."First Name" + ' ' + EmployeeTable."Last Name";
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee Status", '%1', "Employee Status"::Active);
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', EmployeeTable."No.");
                    if EmployeeContractLedger.FindFirst() then begin
                        "Responsible Person E Position" := EmployeeContractLedger."Position Description";
                        "Responsible Person Exit Unit" := EmployeeContractLedger."Department Code";
                    end;

                end
                else
                    if ("Responsible Person Exit" = '') then begin
                        "Responsible Person Exit Name" := '';

                        "Responsible Person E Position" := '';
                        "Responsible Person Exit Unit" := '';

                    end

            end;
        }
        field(50007; "Responsible Person Exit Name"; Text[250])
        {
            Caption = 'Responsible Person Exit Name';
            Editable = false;
        }
        field(50008; "Responsible Person E Position"; Text[250])
        {
            Caption = 'Responsible Person Exit Position';
            Editable = false;
        }
        field(50009; "Responsible Person Exit Unit"; Text[250])
        {
            Caption = 'Responsible Person Exit Unit';
            Editable = false;
        }
        field(50010; "CNG MP"; Boolean)
        {
            Caption = 'CNG MP';
        }
        field(50011; "CNG VP"; Boolean)
        {
            Caption = 'CNG VP';
        }

        field(50012; "Invoice Responsible Person"; Code[20])
        {
            Caption = 'Invoice Responsible Person';
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                EmployeeTable.Reset();
                EmployeeTable.SetFilter("No.", '%1', "Invoice Responsible Person");
                if EmployeeTable.FindFirst() then begin
                    "Invoice Responsible Person N" := EmployeeTable."First Name" + ' ' + EmployeeTable."Last Name";
                    EmployeeContractLedger.Reset();
                    EmployeeContractLedger.SetFilter("Employee Status", '%1', "Employee Status"::Active);
                    EmployeeContractLedger.SetFilter("Employee No.", '%1', EmployeeTable."No.");
                    if EmployeeContractLedger.FindFirst() then begin
                        "Invoice Responsible Person Pos" := EmployeeContractLedger."Position Description";
                    end;

                end
                else
                    if ("Invoice Responsible Person" = '') then begin
                        "Invoice Responsible Person Pos" := '';
                        "Invoice Responsible Person N" := '';
                    end


            end;
        }

        field(50013; "Invoice Responsible Person Pos"; Text[250])
        {
            Caption = 'Invoice Responsible Person Position';
            Editable = false;

        }
        field(50014; "Invoice Responsible Person N"; Text[250])

        {
            Caption = 'First and last name of invoice responsible person';
            Editable = false;
        }
        field(50015; "CNG VL"; Boolean)
        {
            Caption = 'CNG VL';
        }
        field(50016; "Hide PP"; Boolean)
        {
            Caption = 'Hide PP';
        }
    }

    var
        EmployeeTable: Record Employee;
        EmployeeContractLedger: Record "Employee Contract Ledger";

}