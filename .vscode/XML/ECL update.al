xmlport 50011 "ECL Update"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ECL Update';


    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'ECL';
                UseTemporary = false;
                textelement(PersonalniBr)
                {
                    MinOccurs = Zero;
                }
                textelement(NoviBroj)
                {
                    MinOccurs = Zero;
                }




                trigger OnAfterInsertRecord()
                var
                    NoviBroj_int: Integer;
                    PersonalniBr_int: Integer;
                begin
                    Evaluate(PersonalniBr_int, PersonalniBr);
                    Employee.Reset();
                    Employee.SetFilter("Internal ID", '%1', PersonalniBr_int);
                    if Employee.FindFirst() then begin
                        Evaluate(NoviBroj_int, NoviBroj);

                        Employee.Validate("Old Number", NoviBroj_int);
                        Employee.Modify();


                    end;

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




    end;

    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        EmpVec: Record Employee;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EG: Record Employee;
        ER: Record Employee;
        Redoslijed: Integer;
        NoSeriesMgt: Codeunit NoSeriesExtented;
        EmployeeContract: Record "Employee Contract Ledger";
        EmployeeContract2: Record "Employee Contract Ledger";
        Text: Label 'It''s done';
        AlternativeAddress: Record "Alternative Address";

        Department: Record Department;
        Slozen: Decimal;
        EmployeeU: Record Employee;
        Code2: Code[20];
        Code3: Code[20];
        HumanResSetup: Record "Human Resources Setup";
        Uslov: Decimal;

        Odgovor: Decimal;
}

