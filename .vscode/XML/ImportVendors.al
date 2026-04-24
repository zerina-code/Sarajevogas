xmlport 50024 "Vendor Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Vendor Import';




    schema
    {
        textelement(Root)
        {
            tableelement(Vendor; Vendor)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Vendor';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                /* textelement(Naziv)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Adresa)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Grad)
                 {
                     MinOccurs = Zero;
                 }*/
                textelement(BrTelefona)
                {
                    MinOccurs = Zero;
                }
                /*textelement(PDV)
                {
                    MinOccurs = Zero;
                }*/
                /* textelement(Podgr)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Gr)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Klasa)
                 {
                     MinOccurs = Zero;
                 }*/


                trigger OnAfterInsertRecord()
                begin
                    Vendor.Reset();
                    Vendor.SetFilter("No.", '%1', Sifra);
                    if Vendor.FindFirst() then begin

                        /* Vendor.Validate(Name, Naziv);
                         Vendor.Validate("Address", Adresa);
                         Vendor.Validate("City", Grad);*/
                        //IF BrTelefona <> '' then
                        Vendor."Industrial Classification" := BrTelefona;


                        //Vendor.Validate("Registration No.", PDV);
                        /*  Vendor.Validate("Vendor SubGroup", Podgr);
                         MESSAGE(PodGr);
                         Vendor.Validate("Vendor Group", Gr);
                         Vendor.Validate("Vendor Category", Klasa);
                         Vendor.Validate("Gen. Bus. Posting Group", 'DOMAĆI');
                         if PDV <> '' then
                              Vendor.Validate("VAT Bus. Posting Group", 'D-17-PDV')
                          ELSE
                              Vendor.Validate("VAT Bus. Posting Group", 'D-0-PDV');
                          Vendor.Validate("Vendor Posting Group", 'DOMAĆI');*/

                        Vendor.MODIFY();






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

