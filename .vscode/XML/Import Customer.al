xmlport 50010 "Customer Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Customer Import';





    schema
    {
        textelement(Root)
        {
            tableelement(Customer; Customer)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Customer';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                textelement(Naziv)
                {
                    MinOccurs = Zero;
                }
                textelement(SifraUliceS)
                {
                    MinOccurs = Zero;
                }
                textelement(BrojUliceS)
                {
                    MinOccurs = Zero;
                }

                textelement(BrojUliceSlovima)
                {
                    MinOccurs = Zero;
                }
                textelement(FaxText)
                {
                    MinOccurs = Zero;
                }
                textelement(PhoneText)
                {
                    MinOccurs = Zero;
                }
                textelement(EmailText)
                {
                    MinOccurs = Zero;
                }
                textelement(EmailDelivery)
                {
                    MinOccurs = Zero;
                }
                textelement(EmailDeliveryDate)
                {

                    MinOccurs = Zero;
                }
                textelement(ActivityCustomer)
                {
                    MinOccurs = Zero;
                }
                textelement(StreetDelivery)
                {
                    MinOccurs = Zero;
                }
                textelement(StreetDeliveryNumber)
                {
                    MinOccurs = Zero;
                }
                textelement(StreetNumberSLovima)
                {
                    MinOccurs = Zero;
                }
                textelement(Sprat)
                {
                    MinOccurs = Zero;
                }
                textelement(Stan)
                {

                    MinOccurs = Zero;
                }
                textelement(IDBroj)
                {
                    MinOccurs = Zero;
                }
                textelement(PDVbroj)
                {
                    MinOccurs = Zero;
                }


                textelement(Kategorija)
                {
                    MinOccurs = Zero;
                }
                textelement(IDActivity)
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


                    Customer.Reset();
                    Customer.SetFilter("No.", '%1', Sifra);
                    if Customer.FindFirst() then begin

                        if Naziv <> '' then begin
                            if StrLen(Naziv) > 100 then begin
                                Customer.Validate(Name, CopyStr(Naziv, 1, 100));
                            end
                            else begin
                                Customer.Validate(Name, Naziv);
                            end;
                        end;

                        if SifraUliceS <> '' then
                            Customer.Validate("Street Customer", SifraUliceS); //šifra kupca sjedište
                        if BrojUliceS <> '' then
                            Customer.Validate("Street No.", BrojUliceS);//Broj ulice - ulica ID
                        if BrojUliceSlovima <> '' then
                            Customer.Validate("Street No. Text", BrojUliceSlovima); //Broj ulice slovima
                        if Kategorija <> '' then begin
                            if Kategorija = '1' then
                                Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                            if Kategorija = '2' then
                                Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                            if Kategorija = '3' then
                                Customer."Customer Category" := Customer."Customer Category"::Household;
                        end;
                        if FaxText <> '' then
                            Customer.Validate("Fax - Transfer", FaxText);
                        if PhoneText <> '' then
                            Customer.Validate("Phone - Transfer", PhoneText);
                        if EmailText <> '' then
                            Customer."E-Mail" := EmailText;

                        if EmailDelivery <> '' then begin
                            Customer."E-Mail 2" := EmailDelivery;

                        end;
                        if EmailDeliveryDate <> '' then begin
                            if Evaluate(EmailDeliveryDate_Date, EmailDeliveryDate) then
                                Customer.Validate("E-mail Delivery Date", EmailDeliveryDate_Date)
                            else
                                Customer.Validate("E-mail Delivery Date", 0D);
                        end;
                        if ActivityCustomer <> '' then begin
                            MMActivitiy.Reset();
                            MMActivitiy.SetFilter(Code, '%1', ActivityCustomer);
                            MMActivitiy.SetFilter(Type, '%1', MMActivitiy.Type::Basic);
                            if MMActivitiy.FindFirst() then begin
                                Customer.Validate(Activity, MMActivitiy.Description);

                            end;

                        end;


                        if StreetDelivery <> '' then
                            Customer.Validate("Street Customer 2", StreetDelivery); //šifra kupca sjedište

                        if StreetDeliveryNumber <> '' then
                            Customer.Validate("Street No. 2", StreetDeliveryNumber);//Broj ulice - ulica ID

                        if StreetNumberSLovima <> '' then
                            Customer.Validate("Street No.2 Text", StreetNumberSLovima); //Broj ulice slovima

                        if Sprat <> '' then
                            Customer.Validate("Apartment No. Customer 2", Sprat);
                        if Stan <> '' then
                            Customer.Validate("Floor Customer 2", Stan);
                        // Customer.Validate(PDV_NUMBER,PDVbroj);
                        if PDVbroj <> '' then
                            Customer."VAT Registration No." := PDVbroj;
                        if IDBroj <> '' then
                            Customer."Registration No." := IDBroj;

                        if IDActivity <> '' then
                            Customer.Validate("Activity ID", IDActivity);







                        /* Customer.Validate("Street Customer", SifraUliceS);
                         Customer.Validate("Street No.", BrojUliceS);
                         Customer.Validate("Activity Code", Djelatnost);
                         if Status = '1' then
                             Customer."Customer Status" := Customer."Customer Status"::Active;
                         if Status = '2' then
                             Customer."Customer Status" := Customer."Customer Status"::Terminated;
                         if Status = '3' then
                             Customer."Customer Status" := Customer."Customer Status"::"Permanently inactive";

                         //ĐK   Customer.Comment:=napomena;
                         Customer.Validate("Street Customer 2", SifraUliceD);
                         Customer.Validate("Street No. 2", BrojUliceD);
                         Customer.Validate("Apartment No. Customer 2", StanD);
                         Customer.Validate("Floor Customer 2", SpratD);
                         if Kategorija = '1' then
                             Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                         if Kategorija = '2' then
                             Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                         if Kategorija = '3' then
                             Customer."Customer Category" := Customer."Customer Category"::Household;*/
                        Customer.Modify();






                    end
                    else begin

                        Customer.Init();

                        Customer.Validate("No.", Sifra);
                        if Naziv <> '' then
                            Customer.Validate(Name, Naziv);

                        if SifraUliceS <> '' then
                            Customer.Validate("Street Customer", SifraUliceS); //šifra kupca sjedište

                        if BrojUliceS <> '' then
                            Customer.Validate("Street No.", BrojUliceS);//Broj ulice - ulica ID
                        if BrojUliceSlovima <> '' then
                            Customer.Validate("Street No. Text", BrojUliceSlovima); //Broj ulice slovima

                        if Kategorija <> '' then begin
                            if Kategorija = '1' then
                                Customer."Customer Category" := Customer."Customer Category"::"Large Economy";
                            if Kategorija = '2' then
                                Customer."Customer Category" := Customer."Customer Category"::"Small Economy";
                            if Kategorija = '3' then
                                Customer."Customer Category" := Customer."Customer Category"::Household;
                        end;
                        if FaxText <> '' then
                            Customer.Validate("Fax - Transfer", FaxText);

                        if PhoneText <> '' then
                            Customer.Validate("Phone - Transfer", PhoneText);
                        if EmailText <> '' then
                            Customer."E-Mail" := EmailText;
                        if EmailDelivery <> '' then
                            Customer."E-Mail 2" := EmailDelivery;
                        if EmailDeliveryDate <> '' then begin
                            if Evaluate(EmailDeliveryDate_Date, EmailDeliveryDate) then
                                Customer.Validate("E-mail Delivery Date", EmailDeliveryDate_Date)
                            else
                                Customer.Validate("E-mail Delivery Date", 0D);
                        end;
                        if ActivityCustomer <> '' then begin
                            MMActivitiy.Reset();
                            MMActivitiy.SetFilter(Code, '%1', ActivityCustomer);
                            MMActivitiy.SetFilter(Type, '%1', MMActivitiy.Type::Basic);
                            if MMActivitiy.FindFirst() then begin
                                Customer.Validate(Activity, MMActivitiy.Description);

                            end;
                        end;




                        if StreetDelivery <> '' then
                            Customer.Validate("Street Customer 2", StreetDelivery); //šifra kupca sjedište
                        if StreetDeliveryNumber <> '' then
                            Customer.Validate("Street No. 2", StreetDeliveryNumber);//Broj ulice - ulica ID
                        if StreetNumberSLovima <> '' then
                            Customer.Validate("Street No.2 Text", StreetNumberSLovima); //Broj ulice slovima
                        if Sprat <> '' then
                            Customer.Validate("Apartment No. Customer 2", Sprat);
                        if Stan <> '' then
                            Customer.Validate("Floor Customer 2", Stan);
                        // Customer.Validate(PDV_NUMBER,PDVbroj);
                        if PDVbroj <> '' then
                            Customer."VAT Registration No." := PDVbroj;
                        if IDBroj <> '' then
                            Customer."Registration No." := IDBroj;



                        Customer.Insert();
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

