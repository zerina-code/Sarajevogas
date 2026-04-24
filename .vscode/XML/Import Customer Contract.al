xmlport 50028 "Customer Contract Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Customer Contract Import';





    schema
    {
        textelement(Root)
        {
            tableelement("Customer Ledger Entry"; "Customer Ledger Entry")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Customer_Ledger_Entry';
                UseTemporary = false;
                textelement(SifraKupca)
                {
                    MinOccurs = Zero;
                }
                textelement(DatumVazenjagoovra)
                {
                    MinOccurs = Zero;
                }
                textelement(Opis)
                {
                    MinOccurs = Zero;
                }

                /*
                textelement(Djelatnost)
                {
                    MinOccurs = Zero;
                }
                textelement(Status)
                {
                    MinOccurs = Zero;
                }
                textelement(napomena)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraUliceD)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojUliceD)
                {
                    MinOccurs = Zero;
                }
                textelement(SpratD)
                {
                    MinOccurs = Zero;
                }
                textelement(StanD)
                {
                    MinOccurs = Zero;
                }

                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }*/

                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                begin
                    BrojacInt += 1;


                    "Customer Ledger Entry".Reset();
                    "Customer Ledger Entry".SetFilter("Customer No.", '%1', SifraKupca);
                    if "Customer Ledger Entry".FindFirst() then begin
                        if Evaluate(DatumVazenjagoovraDate, DatumVazenjagoovra) then
                            "Customer Ledger Entry".Validate("Starting Date", DatumVazenjagoovraDate);
                        "Customer Ledger Entry".Validate(Description, Opis);
                        "Customer Ledger Entry".Modify();





                    end
                    else begin

                        "Customer Ledger Entry".Init();
                        "Customer Ledger Entry".Code := format(BrojacInt);
                        "Customer Ledger Entry".Validate("Customer No.", SifraKupca);
                        if Evaluate(DatumVazenjagoovraDate, DatumVazenjagoovra) then
                            "Customer Ledger Entry".Validate("Starting Date", DatumVazenjagoovraDate);
                        "Customer Ledger Entry".Validate(Description, Opis);
                        "Customer Ledger Entry".Insert();
                    end;

                end;



            }
        }
    }
    trigger OnPreXmlPort()
    begin
        BrojacInt := 0;
    end;

    var
        Datum: Date;
        EmpVec: Record Employee;
        BrojacInt: Integer;


        EmailDeliveryDate_Date: date;
        DatumVazenjagoovraDate: date;
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

