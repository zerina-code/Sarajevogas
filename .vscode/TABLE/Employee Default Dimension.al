table 50146 "Employee Default Dimension"
{
    // AJ01 - 01-01-2012, customization
    // Payroll calculation

    Caption = 'Employee Default Dimension';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF emp.GET("No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                END;
            end;
        }
        field(2; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                IF NOT DimMgt.CheckDim("Dimension Code") THEN
                    ERROR(DimMgt.GetDimErr);
            end;
        }
        field(3; "Dimension Value Code"; Code[20])
        {
            Caption = 'Dimension Value Code';

            trigger OnValidate()
            begin
                /* IF NOT DimMgt.CheckDimValue("Dimension Code", "Dimension Value Code") THEN
                     ERROR(DimMgt.GetDimErr);*/

            end;
        }
        field(4; "Amount Distribution Coeff."; Decimal)
        {
            Caption = 'Amount Distribution Coeff.';
        }
        field(5; "Total Hours"; Decimal)
        {
            Caption = 'Total Hours';
        }
        field(6; "Hours By dimension"; Decimal)
        {
            Caption = 'Hours by Dimension';
        }
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
    }

    keys
    {
        key(Key1; "No.", "Dimension Code", "Dimension Value Code", "Amount Distribution Coeff.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
    begin
        IF Employee.GET("No.") THEN BEGIN
            IF DefaultDim.GET(DATABASE::Employee, "No.", "Dimension Code") THEN BEGIN
                xRecRef.GETTABLE(DefaultDim);
                DefaultDim.VALIDATE("Dimension Value Code", "Dimension Value Code");
                DefaultDim.MODIFY;
                RecRef.GETTABLE(DefaultDim);
                ChangeLogMgt.LogModification(xRecRef);
            END
            ELSE BEGIN
                DefaultDim.INIT;
                DefaultDim.VALIDATE("Table ID", DATABASE::Employee);
                DefaultDim.VALIDATE("No.", "No.");
                DefaultDim.VALIDATE("Dimension Code", "Dimension Code");
                DefaultDim.VALIDATE("Dimension Value Code", "Dimension Value Code");
                DefaultDim.INSERT;
                RecRef.GETTABLE(DefaultDim);
                ChangeLogMgt.LogInsertion(RecRef);
            END;
        END;
    end;

    trigger OnModify()
    var
        RecRef: RecordRef;
        xRecRef: RecordRef;
    begin
        IF Employee.GET("No.") THEN BEGIN
            IF DefaultDim.GET(DATABASE::Employee, "No.", "Dimension Code") THEN BEGIN
                xRecRef.GETTABLE(DefaultDim);
                DefaultDim.VALIDATE("Dimension Value Code", "Dimension Value Code");
                DefaultDim.MODIFY;
                RecRef.GETTABLE(DefaultDim);
                ChangeLogMgt.LogModification(xRecRef);
            END;
        END;
    end;

    trigger OnRename()
    begin
        //   ERROR(Text000, TABLECAPTION);
    end;

    var
        DefaultDim: Record "Default Dimension";
        Text000: Label '<Nije moguce preimenovati %1.>';
        Employee: Record "Employee";
        DimMgt: Codeunit DimensionManagement;
        ChangeLogMgt: Codeunit "Change Log Management";
        emp: Record "Employee";
}

