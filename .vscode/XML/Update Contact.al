xmlport 50009 "Contact Update"
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
            tableelement(Contact; Contact)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Contact';
                UseTemporary = false;
                textelement(Contact_No)
                {
                    MinOccurs = Zero;
                }
                textelement(CompanyNo)
                {
                    MinOccurs = Zero;
                }



                trigger OnAfterInsertRecord()
                var
                    Cont: Record Contact;
                    Customer: Record Customer;
                    Buss: Record "Contact Business Relation";
                begin
                    Contact.Reset();
                    Contact.SetFilter("No.", '%1', Contact_No);
                    if Contact.FindFirst() then begin
                        Contact."Company No." := CompanyNo;
                        Cont.Reset();
                        Cont.SetFilter("No.", '%1', CompanyNo);
                        if Cont.FindFirst() then
                            Contact."Company Name" := Cont.Name;
                        Contact.Modify();
                        Buss.Reset();
                        Buss.SetFilter("Contact No.", '%1', CompanyNo);
                        Buss.SetFilter("Business Relation Code", '%1', 'KUP');
                        if Buss.FindFirst() then begin

                            Customer.Reset();
                            Customer.SetFilter("No.", '%1', Buss."No.");
                            if Customer.FindFirst() then begin
                                //  Customer.Validate(prima, Contact_No);
                                Customer.validate("Primary Contact No.", Contact."No.");
                                /*   Customer.Contact := Contact.Name;
                                   Customer."Phone No." := Contact."Phone No.";
                                   Customer."Mobile Phone No." := Contact."Mobile Phone No.";
                                   Customer."E-Mail" := Contact."E-Mail";
                                   Customer."E-Mail 2" := Contact."E-Mail 2";
                                   Customer."Fax No." := Contact."Fax No.";*/

                                Customer."Phone - Transfer" := Contact."Phone - Transfer";
                                Customer."Fax - Transfer" := Contact."Fax - Transfer";
                                Customer."Primary Contact No." := Contact."No.";
                                Customer.Validate("Primary Contact No.2", Contact_No);
                                Customer."Primary Contact No.2" := Contact_No;
                                Customer.Modify();

                            end;
                        end;






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

