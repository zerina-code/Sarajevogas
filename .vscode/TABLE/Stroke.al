table 50058 Stroke
{
    DataClassification = ToBeClassified;
    LookupPageId = Strokes;
    DrillDownPageId = Strokes;

    fields
    {
        field(1; Code; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';

        }
        field(2; "Measuring Point string"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Measuring Point string';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();


            end;

        }
        field(3; "Municipality Code"; code[20])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality.code where(Type = filter(Regular));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(4; "MZ-Code"; code[20])
        {
            Caption = 'MZ Code';
            TableRelation = MZ.Code;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                //UpdateMMCust();
            end;

        }
        field(5; "Street"; Code[20])
        {
            Caption = 'Street';
            TableRelation = Street.Code;

            trigger OnValidate()
            var
                myInt: Integer;
                Customer: Record Customer;
                SI: Record "Service Item";
                GaugeUpdate: Record Gauge;
                GaugeUpdateR: Record Gauge;
                InstallHistory: Record "Installation History";
                ElCorrect: Record "El. Volume Corr";
                RM: Record "Radio Module";
            begin

                // UpdateStreet();
            end;
        }
        field(6; "Even stroke from"; Integer)
        {
            Caption = 'Even stroke from';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(7; "Even stroke to"; Integer)
        {
            Caption = 'Even stroke to';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(8; "Odd stroke from"; Integer)
        {
            Caption = 'Odd Stroke from';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(9; "Odd stroke to"; Integer)
        {

            Caption = 'Odd Stroke to';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(10; "Zone stroke"; Integer)
        {
            Caption = 'Zone stroke';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //UpdateMMCust();

            end;
        }
        field(11; "Fictitious Code"; Integer)
        {

            Caption = 'Fictitious Code';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                //UpdateMMCust();
            end;
        }
    }

    keys
    {
        key(Key1; Code, "Measuring Point string", Street, "MZ-Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;



    trigger OnModify()
    var
        Us: Record "User Setup";
        Customer: record "Customer";

    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

        //kada se promijeni hod, da se uradi ažuriranje podataka po svim kupcima i svim mjernim mjestima





    end;

    trigger OnDelete()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    trigger OnRename()
    var
        Us: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if not us.FindFirst() then
            Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

    end;

    procedure ValidateStreetNo(InStreetNo: Code[20]; InStreet: Code[20]; var InMunicipalityCode: Code[20]; var InMZ: Code[20]; var InStrokeNo: Integer; var InCustomerStringNo: Integer; var InZoneStrokeNo: Integer)
    var
        TestSubsCu: Codeunit TestSubsCu;
        StreetText: text[20];
        StreetInteger: integer;
        Stroke: Record Stroke;
        Even: Boolean;
    begin
        if (InStreetNo <> '') and (InStreet <> '') then begin
            StreetText := TestSubsCu.RemoveLetter(InStreetNo);
            Evaluate(StreetInteger, StreetText);
            Even := TestSubsCu.EvenOrOdd(StreetInteger);
            if Even then begin
                Stroke.Reset();
                Stroke.SetFilter(Street, '%1', InStreet);
                Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                if Stroke.FindFirst() then begin
                    InMunicipalityCode := Stroke."Municipality Code";
                    InMZ := Stroke."MZ-Code";
                    InStrokeNo := Stroke.Code;
                    InCustomerStringNo := Stroke."Measuring Point string";
                    InZoneStrokeNo := Stroke."Zone stroke";
                end
                else begin
                    InMunicipalityCode := '';
                    InMZ := '';
                    InStrokeNo := 0;
                    InCustomerStringNo := 0;
                    InZoneStrokeNo := 0;
                end;
            end
            else begin
                Stroke.Reset();
                Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                Stroke.SetFilter(Street, '%1', InStreet);
                if Stroke.FindFirst() then begin
                    InMunicipalityCode := Stroke."Municipality Code";
                    InMZ := Stroke."MZ-Code";
                    InStrokeNo := Stroke.Code;
                    InCustomerStringNo := Stroke."Measuring Point string";
                    InZoneStrokeNo := Stroke."Zone stroke";
                end
                else begin
                    InMunicipalityCode := '';
                    InMZ := '';
                    InStrokeNo := 0;
                    InCustomerStringNo := 0;
                    InZoneStrokeNo := 0;
                end;
            end;
        end
        else begin
            InMunicipalityCode := '';
            InMZ := '';
            InStrokeNo := 0;
            InCustomerStringNo := 0;
            InZoneStrokeNo := 0;
        end;
    end;

    procedure ValidateStreetNo(InStreetNo: Code[20]; InStreet: Code[20]; var InMunicipalityCode: Code[20]; var InMZ: Code[20])
    var
        InStrokeNo: Integer;
        InCustomerStringNo: Integer;
        InZoneStrokeNo: Integer;
    begin
        ValidateStreetNo(InStreetNo, InStreet, InMunicipalityCode, InMZ, InStrokeNo, InCustomerStringNo, InZoneStrokeNo);
    end;

    procedure UpdateMMCust();
    var
        myInt: Integer;
        Customer: Record Customer;
        SI: Record "Service Item";
        GaugeUpdate: Record Gauge;
        InstallHistory: Record "Installation History";
        ElCorrect: Record "El. Volume Corr";
        RM: Record "Radio Module";
    begin
        Customer.Reset();
        Customer.SetFilter("Street Customer", '%1', rec.Street);
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Customer Status");
                if Customer."Customer Status" = Customer."Customer Status"::Active then begin
                    customer.Validate("Street Customer", rec.Street);
                    Customer.Validate("Street No.", Customer."Street No.");
                    Customer.Modify();

                    Commit();

                    si.Reset();
                    si.SetFilter("Customer No.", '%1', Customer."No.");
                    if si.FindSet() then
                        repeat
                            si.CalcFields("Status MM");
                            if si."Status MM" = si."Status MM"::Active then begin
                                Customer.CalcFields("Municipality Name Customer", "Street Name Customer", "MZ Name Customer");

                                si.Validate("Address Customer", Customer.Address);
                                si.Validate("MZ Customer", Customer."MZ Customer");
                                si."MZ Name Customer" := Customer."MZ Name Customer";
                                si.Validate("Street Customer", Customer."Street Customer");
                                si."Street Name Customer" := Customer."Street Name Customer";
                                si."Municipality Code Customer" := Customer."Municipality Code Customer";
                                si."Municipality Name Customer" := Customer."Municipality Name Customer";
                                si."Home No. Customer" := Customer."Home No. Customer";
                                si."Customer Category" := Customer."Customer Category";
                                si."Floor Customer" := Customer."Floor Customer";
                                si."Customer string" := Customer."Customer String";
                                si."Customer Stroke" := Customer."Customer Stroke";

                                si."Apartment No. Customer" := Customer."Apartment No. Customer";
                                si.Modify();
                                Commit();
                            end;
                        until si.Next() = 0;
                end;

            until Customer.next() = 0;

        Customer.Reset();
        Customer.SetFilter("Street Customer 2", '%1', Rec."Street");
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Customer Status");
                if Customer."Customer Status" = Customer."Customer Status"::Active then begin
                    customer.Validate("Street Customer 2", rec.Street);
                    Customer.Validate("Street No. 2", Customer."Street No. 2");
                    Customer.Modify();
                end;

            until Customer.next() = 0;

        SI.Reset();
        SI.SetFilter(street, '%1', Rec.Street);
        if si.FindSet() then
            repeat
                si.CalcFields("Status MM");
                if si."Status MM" = si."Status MM"::Active then begin
                    si.Validate(Street, rec.Street);
                    si.Modify();

                    GaugeUpdate.Reset();
                    GaugeUpdate.SetFilter("Measuring Point", '%1', si."No.");
                    if GaugeUpdate.FindSet() then
                        repeat
                            InstallHistory.Reset();
                            InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                            InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                            InstallHistory.SetFilter(Active, '%1', true);
                            InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Gauge);
                            if InstallHistory.FindFirst() then begin
                                GaugeUpdate."Address MM" := si."Address MM";
                                GaugeUpdate.Modify();
                                if si."Customer No." <> '' then begin
                                    Customer.get(si."Customer No.");
                                    InstallHistory."Customer Address" := Customer.Address;
                                    InstallHistory."Customer City" := Customer.City;
                                    InstallHistory."Customer Post Code" := Customer."Post Code";
                                    InstallHistory."Customer string" := Customer."Customer String";
                                    InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                    InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                    InstallHistory."Measuring Point Adress" := SI."Address MM";
                                    InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                    InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                    InstallHistory.Modify();
                                end;


                            end;
                        until GaugeUpdate.Next() = 0;

                    //el volume
                    ElCorrect.Reset();
                    ElCorrect.SetFilter("Measuring Point", '%1', si."No.");
                    if ElCorrect.FindSet() then
                        repeat
                            InstallHistory.Reset();
                            InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                            InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                            InstallHistory.SetFilter(Active, '%1', true);
                            InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Corrector);
                            if InstallHistory.FindFirst() then begin
                                ElCorrect."Address MM" := si."Address MM";
                                ElCorrect.Modify();
                                if si."Customer No." <> '' then begin
                                    Customer.get(si."Customer No.");
                                    InstallHistory."Customer Address" := Customer.Address;
                                    InstallHistory."Customer City" := Customer.City;
                                    InstallHistory."Customer Post Code" := Customer."Post Code";
                                    InstallHistory."Customer string" := Customer."Customer String";
                                    InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                    InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                    InstallHistory."Measuring Point Adress" := SI."Address MM";
                                    InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                    InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                    InstallHistory.Modify();
                                end;
                                //el volume


                                //

                            end;
                        until ElCorrect.Next() = 0;
                    //

                    //radio modul

                    //el volume
                    RM.Reset();
                    RM.SetFilter("Measuring Point Code", '%1', si."No.");
                    if RM.FindSet() then
                        repeat
                            InstallHistory.Reset();
                            InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                            InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                            InstallHistory.SetFilter(Active, '%1', true);
                            InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Radio_Module);
                            if InstallHistory.FindFirst() then begin

                                if si."Customer No." <> '' then begin
                                    Customer.get(si."Customer No.");
                                    InstallHistory."Customer Address" := Customer.Address;
                                    InstallHistory."Customer City" := Customer.City;
                                    InstallHistory."Customer Post Code" := Customer."Post Code";
                                    InstallHistory."Customer string" := Customer."Customer String";
                                    InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                    InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                    InstallHistory."Measuring Point Adress" := SI."Address MM";
                                    InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                    InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                    InstallHistory.Modify();
                                end;
                                //el volume


                                //

                            end;
                        until RM.Next() = 0;

                    //

                end;

            until si.Next() = 0;




    end;

    procedure UpdateStreet()
    var
        myInt: Integer;
        Customer: Record Customer;
        SI: Record "Service Item";
        GaugeUpdate: Record Gauge;
        GaugeUpdateR: Record Gauge;
        InstallHistory: Record "Installation History";
        ElCorrect: Record "El. Volume Corr";
        RM: Record "Radio Module";
    begin

        if xRec.Street <> rec.Street then begin
            Commit();
            Customer.Reset();
            Customer.SetFilter("Street Customer", '%1', xRec."Street");
            if Customer.FindSet() then
                repeat
                    Customer.CalcFields("Customer Status");
                    if Customer."Customer Status" = Customer."Customer Status"::Active then begin
                        customer.Validate("Street Customer", rec.Street);
                        Customer.Validate("Street No.", Customer."Street No.");
                        if (Customer."Municipality Code Customer" = '') then begin

                            Customer.Validate("Municipality Code Customer", Rec."Municipality Code");
                            Customer.Validate("MZ Customer", Rec."MZ-Code");

                            Customer.Validate("Customer Stroke", Rec.Code);
                            Customer.Validate("Customer String", Rec."Measuring Point string");
                            Customer.Validate("Zone stroke", Rec."Zone stroke");

                        end;
                        //
                        Customer.Modify();

                        Commit();

                        si.Reset();
                        si.SetFilter("Customer No.", '%1', Customer."No.");
                        if si.FindSet() then
                            repeat
                                si.CalcFields("Status MM");
                                if si."Status MM" = si."Status MM"::Active then begin
                                    Customer.CalcFields("Municipality Name Customer", "Street Name Customer", "MZ Name Customer");

                                    si.Validate("Address Customer", Customer.Address);
                                    si.Validate("MZ Customer", Customer."MZ Customer");
                                    si."MZ Name Customer" := Customer."MZ Name Customer";
                                    si.Validate("Street Customer", Customer."Street Customer");
                                    si."Street Name Customer" := Customer."Street Name Customer";
                                    si."Municipality Code Customer" := Customer."Municipality Code Customer";
                                    si."Municipality Name Customer" := Customer."Municipality Name Customer";
                                    si."Home No. Customer" := Customer."Home No. Customer";
                                    si."Customer Category" := Customer."Customer Category";
                                    si."Floor Customer" := Customer."Floor Customer";
                                    si."Customer string" := Customer."Customer String";
                                    si."Customer Stroke" := Customer."Customer Stroke";

                                    si."Apartment No. Customer" := Customer."Apartment No. Customer";
                                    si.Modify();
                                    Commit();
                                end;
                            until si.Next() = 0;
                    end;

                until Customer.next() = 0;

            Customer.Reset();
            Customer.SetFilter("Street Customer 2", '%1', xRec."Street");
            if Customer.FindSet() then
                repeat
                    Customer.CalcFields("Customer Status");
                    if Customer."Customer Status" = Customer."Customer Status"::Active then begin
                        customer.Validate("Street Customer 2", rec.Street);
                        Customer.Validate("Street No. 2", Customer."Street No. 2");
                        if (Customer."Municipality Code Customer 2" = '') then begin
                            customer.Validate("Municipality Code Customer 2", Rec."Municipality Code");
                            customer.Validate("MZ Customer 2", Rec."MZ-Code");

                            customer.Validate("Customer Stroke 2", Rec.Code);
                            customer.Validate("Customer String 2", Rec."Measuring Point string");
                            customer.Validate("Zone stroke 2", Rec."Zone stroke");

                        end;

                        Customer.Modify();
                    end;

                until Customer.next() = 0;

            SI.Reset();
            SI.SetFilter(street, '%1', xRec.Street);
            if si.FindSet() then
                repeat
                    si.CalcFields("Status MM");
                    if si."Status MM" = si."Status MM"::Active then begin
                        si.Validate(Street, rec.Street);
                        si.Modify();

                        GaugeUpdate.Reset();
                        GaugeUpdate.SetFilter("Measuring Point", '%1', si."No.");
                        if GaugeUpdate.FindSet() then
                            repeat
                                InstallHistory.Reset();
                                InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                                InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                                InstallHistory.SetFilter(Active, '%1', true);
                                InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Gauge);
                                if InstallHistory.FindFirst() then begin
                                    if GaugeUpdateR.get(GaugeUpdate.Code, GaugeUpdate."Measuring Point", GaugeUpdate."Customer No.", GaugeUpdate."Address MM")
                                    then
                                        GaugeUpdateR.Rename(GaugeUpdate.Code, GaugeUpdate."Measuring Point", GaugeUpdate."Customer No.", si."Address MM");

                                    if si."Customer No." <> '' then begin
                                        Customer.get(si."Customer No.");
                                        InstallHistory."Customer Address" := Customer.Address;
                                        InstallHistory."Customer City" := Customer.City;
                                        InstallHistory."Customer Post Code" := Customer."Post Code";
                                        InstallHistory."Customer string" := Customer."Customer String";
                                        InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                        InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                        InstallHistory."Measuring Point Adress" := SI."Address MM";
                                        InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                        InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                        InstallHistory.Modify();
                                    end;


                                end;
                            until GaugeUpdate.Next() = 0;

                        //el volume
                        ElCorrect.Reset();
                        ElCorrect.SetFilter("Measuring Point", '%1', si."No.");
                        if ElCorrect.FindSet() then
                            repeat
                                InstallHistory.Reset();
                                InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                                InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                                InstallHistory.SetFilter(Active, '%1', true);
                                InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Corrector);
                                if InstallHistory.FindFirst() then begin
                                    ElCorrect."Address MM" := si."Address MM";
                                    ElCorrect.Modify();
                                    if si."Customer No." <> '' then begin
                                        Customer.get(si."Customer No.");
                                        InstallHistory."Customer Address" := Customer.Address;
                                        InstallHistory."Customer City" := Customer.City;
                                        InstallHistory."Customer Post Code" := Customer."Post Code";
                                        InstallHistory."Customer string" := Customer."Customer String";
                                        InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                        InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                        InstallHistory."Measuring Point Adress" := SI."Address MM";
                                        InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                        InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                        InstallHistory.Modify();
                                    end;
                                    //el volume


                                    //

                                end;
                            until ElCorrect.Next() = 0;
                        //

                        //radio modul

                        //el volume
                        RM.Reset();
                        RM.SetFilter("Measuring Point Code", '%1', si."No.");
                        if RM.FindSet() then
                            repeat
                                InstallHistory.Reset();
                                InstallHistory.SetFilter("Customer No.", '%1', si."Customer No.");
                                InstallHistory.SetFilter("Measuring Point Code", '%1', si."No.");
                                InstallHistory.SetFilter(Active, '%1', true);
                                InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Radio_Module);
                                if InstallHistory.FindFirst() then begin

                                    if si."Customer No." <> '' then begin
                                        Customer.get(si."Customer No.");
                                        InstallHistory."Customer Address" := Customer.Address;
                                        InstallHistory."Customer City" := Customer.City;
                                        InstallHistory."Customer Post Code" := Customer."Post Code";
                                        InstallHistory."Customer string" := Customer."Customer String";
                                        InstallHistory."Customer Stroke" := Customer."Customer Stroke";
                                        InstallHistory."Customer Zone stroke" := Customer."Zone stroke";
                                        InstallHistory."Measuring Point Adress" := SI."Address MM";
                                        InstallHistory."Measuring Point string" := SI."Measuring Point string";
                                        InstallHistory."Measuring Point Stroke" := SI."Measuring Point Stroke";
                                        InstallHistory.Modify();
                                    end;
                                    //el volume


                                    //

                                end;
                            until RM.Next() = 0;

                        //

                    end;

                until si.Next() = 0;




        end;

    end;


}