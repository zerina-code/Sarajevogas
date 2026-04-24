report 50215 "Update Stroke"
{
    DefaultLayout = RDLC;
    Caption = '"Update Stroke';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Choose Street No.")
                {
                    Caption = 'Choose Street No.';
                    field(OldStreetNo; OldStreetNo)
                    {
                        Caption = 'OldStreetNo';
                        // TableRelation=Stroke.Street;
                    }
                    field(OldStreetNew; OldStreetNew)
                    {
                        Caption = 'NewStreetNo';
                        TableRelation = Stroke.Street;
                    }
                    field(updateAll; updateAll)
                    {
                        Caption = 'updateAll';

                    }
                }
            }
        }




    }

    trigger OnPostReport()
    var
        myInt: Integer;
        Customer: Record Customer;
        SI: Record "Service Item";
        GaugeUpdate: Record Gauge;
        InstallHistory: Record "Installation History";
        ElCorrect: Record "El. Volume Corr";
        RM: Record "Radio Module";
        GaugeUpdateRename: Record Gauge;
        ELVolumeRename: Record "El. Volume Corr";
    begin


        Customer.Reset();
        Customer.SetFilter("Street Customer", '%1', OldStreetNo);
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Customer Status");
                if (Customer."Customer Status" = Customer."Customer Status"::Active) or (updateAll = true) then begin
                    customer.Validate("Street Customer", OldStreetNew);
                    Customer.Validate("Street No.", Customer."Street No.");
                    Customer.Validate("Street No. Text", Customer."Street No. Text");
                    Customer.Modify(true);

                    Commit();

                    si.Reset();
                    si.SetFilter("Customer No.", '%1', Customer."No.");
                    if si.FindSet() then
                        repeat
                            si.CalcFields("Status MM");
                            if (si."Status MM" = si."Status MM"::Active) or (updateAll = true) then begin
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
                                //si.Validate("Street No. Text",si."Street No. Text");
                                si.Modify(true);
                                Commit();
                            end;
                        until si.Next() = 0;
                end;

            until Customer.next() = 0;

        Customer.Reset();
        Customer.SetFilter("Street Customer 2", '%1', OldStreetNo);
        if Customer.FindSet() then
            repeat
                Customer.CalcFields("Customer Status");
                if (Customer."Customer Status" = Customer."Customer Status"::Active) or (updateAll = true) then begin
                    customer.Validate("Street Customer 2", OldStreetNew);
                    Customer.Validate("Street No. 2", Customer."Street No. 2");
                    Customer.Validate("Street No.2 Text", Customer."Street No.2 Text");
                    Customer.Modify(true);
                end;

            until Customer.next() = 0;

        SI.Reset();
        SI.SetFilter(street, '%1', OldStreetNo);
        if si.FindSet() then
            repeat
                si.CalcFields("Status MM");
                if (si."Status MM" = si."Status MM"::Active) or (updateAll = true) then begin
                    si.Validate(Street, OldStreetNew);
                    si.validate("Street No.", si."Street No.");
                    si.Validate("Street No. Text", si."Street No. Text");
                    si.Modify(true);

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
                                if GaugeUpdateRename.get(GaugeUpdate."Code", GaugeUpdate."Measuring Point", GaugeUpdate."Customer No.", GaugeUpdate."Address MM")
                                then
                                    GaugeUpdateRename.Rename(GaugeUpdate."Code", GaugeUpdate."Measuring Point", GaugeUpdate."Customer No.", si."Address MM");
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
                                    InstallHistory.Modify(true);
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
                                if ELVolumeRename.get(ElCorrect."Code", ElCorrect."Measuring Point", ElCorrect."Customer No.", ElCorrect."Address MM")
                                     then
                                    ELVolumeRename.Rename(ElCorrect."Code", ElCorrect."Measuring Point", ElCorrect."Customer No.", si."Address MM");
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
                                    InstallHistory.Modify(true);
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
                                    InstallHistory.Modify(true);
                                end;
                                //el volume


                                //

                            end;
                        until RM.Next() = 0;

                    //

                end;

            until si.Next() = 0;




    end;

    trigger OnInitReport()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            OldStreetNew := us."StreetNo.";
            OldStreetNo := us."StreetNo.";
        end;
        updateAll := false;
    end;

    var
        OldStreetNo: Code[20];
        OldStreetNew: code[20];

        updateAll: Boolean;
}

