xmlport 50508 "Employee No import"
{
    Direction = Import;

    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;


    schema
    {
        textelement(Root)
        {
            tableelement(Employee; Employee)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Employee';
                UseTemporary = false;
                textelement(JMB)
                {
                    MinOccurs = Zero;
                }
                textelement(Godina)
                {
                    MinOccurs = Zero;
                }
                textelement(Mjesec)
                {
                    MinOccurs = Zero;
                }
                textelement(Dan)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                begin
                    Employee.Reset();
                    Employee.SetFilter("No.", '%1', JMB);
                    if Employee.FindFirst() then begin
                        Evaluate(God, Godina);
                        Evaluate(MJ, Mjesec);
                        Evaluate(Da, Dan);
                        Employee."Brought Days of Experience" := Da;
                        Employee."Brought Months of Experience" := mj;
                        Employee."Brought Years of Experience" := God;
                        Employee.Modify();

                    end;





                END;


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
    trigger OnPreXMLport()
    var
        myInt: Integer;
    begin



        brojac := 765;

    end;

    var
        IznosInt: Integer;
        God: Integer;
        MJ: Integer;
        Da: Integer;
        EmpOLD: Record Employee;
        EmpOLD2: Record Employee;
        brojac: Integer;
        EmpOLD3: Record Employee;
}

