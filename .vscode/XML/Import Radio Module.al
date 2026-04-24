xmlport 50029 "Radio Import"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Radio Import';





    schema
    {
        textelement(Root)
        {
            tableelement("Radio Module"; "Radio Module")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Radio_Module';
                UseTemporary = false;
                textelement(SifraRadio)
                {
                    MinOccurs = Zero;
                }

                textelement(DatumUgradnje)
                {
                    MinOccurs = Zero;
                }
                textelement(GaugeCode)
                {
                    MinOccurs = Zero;
                }
                textelement(Serijskibroj1)
                {
                    MinOccurs = Zero;
                }
                textelement(TipRadioModula)
                {
                    MinOccurs = Zero;
                }



                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    RMGET: Record "Radio Module";
                    InstallationHistory: Record "Installation History";
                    GaugeF: Record Gauge;
                    SifraMM: Code[20];
                    InstallationHistoryF: Record "Installation History";
                begin


                    "Radio Module".Reset();
                    "Radio Module".SetFilter(Code, '%1', SifraRadio);
                    if "Radio Module".FindFirst() then begin
                        SifraMM := '';

                        InstallationHistory.Reset();
                        InstallationHistory.SetFilter(Type, '%1', InstallationHistory.Type::Gauge);
                        InstallationHistory.SetFilter(Code, '%1', GaugeCode);
                        InstallationHistory.SetFilter(Active, '%1', true);
                        if InstallationHistory.FindFirst() then begin
                            SifraMM := InstallationHistory."Measuring Point Code";
                            if RMGET.get("Radio Module".Code, "Radio Module"."Gauge Code", "Radio Module"."Measuring Point Code")
                           then
                                RMGET.Rename("Radio Module".Code, GaugeCode, InstallationHistory."Measuring Point Code");
                        end;



                        //pa sad dodam u linijama ovog radio modula kretanje

                        InstallationHistoryR.Reset();
                        InstallationHistoryR.setfilter(Code, '%1', SifraRadio);
                        InstallationHistoryR.setfilter(Type, '%1', InstallationHistoryR.Type::Radio_Module);
                        InstallationHistoryR.SetFilter(Active, '%1', true);
                        if InstallationHistoryR.FindSet() then
                            repeat
                                InstallationHistoryR.Active := false;
                                if Evaluate(DatumUgradnjeDate, DatumUgradnje) then
                                    InstallationHistoryR.Validate("Dismantling date", DatumUgradnjeDate)
                                else
                                    InstallationHistoryR.Validate("Dismantling date", 0D);
                                InstallationHistoryR.Modify();
                            until InstallationHistoryR.Next() = 0;


                        InstallationHistory.Init();
                        InstallationHistory.Validate(Code, SifraRadio);
                        InstallationHistory.Validate(Type, InstallationHistory.Type::Radio_Module);
                        if Evaluate(DatumUgradnjeDate, DatumUgradnje) then
                            InstallationHistory.Validate("Installation Date", DatumUgradnjeDate)
                        else
                            InstallationHistory.Validate("Installation Date", 0D);

                        InstallationHistory.Validate("Measuring Point Code", SifraMM);
                        ServiceItem.reset;
                        ServiceItem.setfilter("No.", '%1', SifraMM);
                        if ServiceItem.FindFirst() then begin
                            InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                            InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                        end;


                        InstallationHistory.Validate("Serial Number I", "Radio Module"."Serial Number I");
                        InstallationHistory.Validate("Serial Number II", "Radio Module"."Serial Number II");

                        InstallationHistory.Validate(Active, true);


                        InstallationHistory.Insert();



                        //kraj


                    end
                    else begin
                        SifraMM := '';

                        InstallationHistoryF.Reset();
                        InstallationHistoryF.SetFilter(Type, '%1', InstallationHistoryF.Type::Gauge);
                        InstallationHistoryF.SetFilter(Code, '%1', GaugeCode);
                        InstallationHistoryF.SetFilter(Active, '%1', true);
                        if InstallationHistoryF.FindFirst() then begin
                            SifraMM := InstallationHistoryF."Measuring Point Code";
                        end;

                        "Radio Module".Init();
                        "Radio Module".Validate(Code, SifraRadio);
                        "Radio Module".Validate("Gauge Code", GaugeCode);
                        "Radio Module".Validate("Measuring Point Code", SifraMM);
                        "Radio Module".Validate("Serial Number II", Serijskibroj1);
                        if TipRadioModula = 'VMS DP3' then
                            "Radio Module".Validate("Type Radio Module", "Radio Module"."Type Radio Module"::"VMS DP3");
                        if TipRadioModula = 'DP3' then
                            "Radio Module".Validate("Type Radio Module", "Radio Module"."Type Radio Module"::Recording);


                        "Radio Module".Insert();
                        Commit();

                        InstallationHistory.Init();
                        InstallationHistory.Validate(Code, SifraRadio);
                        InstallationHistory.Validate(Type, InstallationHistory.Type::Radio_Module);
                        if Evaluate(DatumUgradnjeDate, DatumUgradnje) then
                            InstallationHistory.Validate("Installation Date", DatumUgradnjeDate)
                        else
                            InstallationHistory.Validate("Installation Date", 0D);

                        InstallationHistory.Validate("Measuring Point Code", SifraMM);
                        ServiceItem.reset;
                        ServiceItem.setfilter("No.", '%1', SifraMM);
                        if ServiceItem.FindFirst() then begin
                            InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                            InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                        end;


                        InstallationHistory.Validate("Serial Number II", Serijskibroj1);

                        if TipRadioModula = 'VMS DP3' then
                            InstallationHistory.Validate("Type Radio Module", "Radio Module"."Type Radio Module"::"VMS DP3");
                        if TipRadioModula = 'DP3' then
                            InstallationHistory.Validate("Type Radio Module", "Radio Module"."Type Radio Module"::Recording);


                        InstallationHistory.Validate(Active, true);


                        InstallationHistory.Insert();
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
        DatumProgramiranjaDate: date;
        DatumreprogramiranjaDate: date;
        InstallationHistory: Record "Installation History";
        ServiceItem: Record "Service Item";
        DatumUgradnjeDate: Date;
        EmpVec: Record Employee;
        GodinaProizvodnjeInt: Integer;
        EmailDeliveryDate_Date: date;
        InstallationHistoryR: Record "Installation History";
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

