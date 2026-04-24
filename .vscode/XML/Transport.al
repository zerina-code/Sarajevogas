xmlport 50005 Transport
{
    Direction = Import;
    FieldDelimiter = ',';
    FieldSeparator = ',';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("Employee"; "Employee")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Employee';
                UseTemporary = false;
                textelement(JMB)
                {
                    MinOccurs = Zero;
                }
                textelement(transport)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                begin

                    Employee.SETFILTER("No.", '%1', JMB);
                    IF Employee.FIND('-') THEN BEGIN
                        EmployeeContract.RESET;
                        EmployeeContract.SETFILTER("Employee No.", '%1', Employee."No.");
                        EmployeeContract.SETFILTER(Import, '%1', TRUE);
                        EmployeeContract.SETFILTER("Show Record", '%1', TRUE);
                        IF NOT EmployeeContract.FINDFIRST THEN BEGIN
                            EmployeeContract2.SETFILTER("Employee No.", '%1', Employee."No.");
                            EmployeeContract2.SETFILTER("Show Record", '%1', TRUE);
                            IF EmployeeContract2.FINDFIRST THEN BEGIN
                                EmployeeContract2.Import := TRUE;
                                EmployeeContract2.MODIFY;
                            END;
                            EVALUATE(prevoz, transport);
                            Employee.VALIDATE("Transport Amount", prevoz);
                            Employee.MODIFY;
                        END
                        ELSE BEGIN
                            Employee.SETFILTER("No.", '%1', JMB);
                            IF Employee.FIND('-') THEN BEGIN

                                MESSAGE('Zaposlenik ' + Employee."First Name" + ' ' + Employee."Last Name" + ' ' + 'ima dupli unos za prevoz');

                            END;
                        END;
                    END;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnPostXmlPort()
    begin
        MESSAGE(Text);
    end;

    trigger OnPreXmlPort()
    begin
        EmployeeContract.RESET;
        EmployeeContract.SETFILTER(Import, '%1', TRUE);
        IF EmployeeContract.FINDSET THEN
            REPEAT
                EmployeeContract.Import := FALSE;
                EmployeeContract.MODIFY;
            UNTIL EmployeeContract.NEXT = 0;
    end;

    var
        Datum: Date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
}

