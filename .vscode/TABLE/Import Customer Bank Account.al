xmlport 50031 "Bank Account Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Contact Import';





    schema
    {
        textelement(Root)
        {
            tableelement("Customer Bank Account"; "Customer Bank Account")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'CBA';
                UseTemporary = false;
                textelement(CustomerCode)
                {
                    MinOccurs = Zero;
                }
                textelement(BankAccount)
                {
                    MinOccurs = Zero;

                }
                textelement(BankName)
                {
                    MinOccurs = Zero;
                }



                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    CB: Record "Contact Business Relation";

                begin


                    "Customer Bank Account".Reset();
                    "Customer Bank Account".SetFilter("Bank Account No.", '%1', BankAccount);
                    "Customer Bank Account".SetFilter("Customer No.", '%1', CustomerCode);
                    if not "Customer Bank Account".FindFirst() then begin


                        "Customer Bank Account".Init();
                        "Customer Bank Account".Code := CopyStr(BankAccount, 1, 20);
                        "Customer Bank Account".Validate("Customer No.", CustomerCode);
                        "Customer Bank Account".Validate("Bank Account No.", BankAccount);
                        "Customer Bank Account".Validate(Name, BankName);
                        "Customer Bank Account".Insert();
                        Commit();
                        Cust.Reset();
                        cust.SetFilter("No.", '%1', CustomerCode);
                        if cust.FindFirst() then begin
                            cust."Preferred Bank Account Code" := "Customer Bank Account".Code;
                            Cust.Modify();
                        end;
                    end
                    else begin
                        "Customer Bank Account".Reset();
                        "Customer Bank Account".SetFilter("Customer No.", '%1', CustomerCode);
                        if "Customer Bank Account".FindFirst() then begin
                            "Customer Bank Account".Validate("Bank Account No.", BankAccount);
                            "Customer Bank Account".Validate(Name, BankName);
                        end;
                        Cust.Reset();
                        cust.SetFilter("No.", '%1', CustomerCode);
                        if cust.FindFirst() then begin
                            cust."Preferred Bank Account Code" := "Customer Bank Account".Code;
                            Cust.Modify();
                        end;

                    end;






                end;
            }
        }
    }
    trigger OnPreXmlPort()
    begin

    end;

    var
        Datum: Date;
        EmpVec: Record Employee;
        EmailDeliveryDate_Date: date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        EG: Record Employee;
        ER: Record Employee;
        Cust: Record Customer;
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

