xmlport 50030 "Contact Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Contact Import2';





    schema
    {
        textelement(Root)
        {
            tableelement(Contact; Contact)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Contact';
                UseTemporary = false;
                textelement(ContactCode)
                {
                    MinOccurs = Zero;
                }
                textelement(CustomerCode)
                {
                    MinOccurs = Zero;

                }
                textelement(ContactNaziv)
                {
                    MinOccurs = Zero;

                }


                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    CB: Record "Contact Business Relation";

                begin


                    Contact.Reset();
                    Contact.SetFilter("No.", '%1', ContactCode);
                    if Contact.FindFirst() then begin

                        if ContactNaziv <> '' then begin

                            Contact.Validate(Name, CopyStr(ContactNaziv, 1, 100));
                        end;

                        Contact.Validate("Type Relation", Contact."Type Relation"::Customer);
                        Contact."Company No." := Contact."No.";

                        CB.Reset();
                        CB.SetFilter("Business Relation Code", '%1', 'KUP');
                        CB.SetFilter("Contact No.", '%1', ContactCode);
                        cb.SetFilter("Link to Table", '%1', 1);
                        cb.SetFilter("No.", '%1', CustomerCode);
                        if not cb.FindFirst() then begin
                            cb.Init();
                            cb."Business Relation Code" := 'KUP';
                            cb."Contact No." := ContactCode;
                            cb."Link to Table" := 1;
                            cb."No." := CustomerCode;
                            cb.Insert();

                        end;
                        Cust.reset;
                        Cust.SetFilter("No.", '%1', CustomerCode);


                        if Cust.FindFirst() then begin
                            Contact."Phone - Transfer" := cust."Phone - Transfer";
                            Contact."Fax - Transfer" := cust."Fax - Transfer";

                            if cust."Customer Category" = cust."Customer Category"::Household then
                                Contact.Validate(Type, Contact.type::Person) else
                                Contact.Validate(Type, Contact.Type::Company);
                            cust."Primary Contact No." := Contact."No.";
                            cust."Primary Contact No.2" := Contact."No.";
                            cust.Contact := Contact.Name;
                            cust.Modify();
                        end;
                        Contact.Modify();


                    end
                    else begin

                        Contact.Init();
                        Contact."No." := ContactCode;
                        Contact.Name := CopyStr(ContactNaziv, 1, 100);
                        Contact."Company No." := Contact."No.";
                        Contact.Validate("Type Relation", Contact."Type Relation"::Customer);
                        Cust.reset;
                        Cust.SetFilter("No.", '%1', CustomerCode);
                        CB.Reset();
                        CB.SetFilter("Business Relation Code", '%1', 'KUP');
                        CB.SetFilter("Contact No.", '%1', ContactCode);
                        cb.SetFilter("Link to Table", '%1', 1);
                        cb.SetFilter("No.", '%1', CustomerCode);
                        if not cb.FindFirst() then begin
                            cb.Init();
                            cb."Business Relation Code" := 'KUP';
                            cb."Contact No." := ContactCode;
                            cb."Link to Table" := 1;
                            cb."No." := CustomerCode;
                            cb.Insert();

                        end;


                        if Cust.FindFirst() then begin
                            Contact."Phone - Transfer" := cust."Phone - Transfer";
                            Contact."Fax - Transfer" := cust."Fax - Transfer";

                            if cust."Customer Category" = cust."Customer Category"::Household then
                                Contact.Validate(Type, Contact.type::Person) else
                                Contact.Validate(Type, Contact.Type::Company);



                            Contact.Insert();
                            Commit();
                            cust."Primary Contact No." := Contact."No.";
                            cust."Primary Contact No.2" := Contact."No.";
                            cust.Contact := Contact.Name;
                            cust.Modify();
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

