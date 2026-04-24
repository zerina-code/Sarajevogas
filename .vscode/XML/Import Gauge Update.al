xmlport 50048 "Import Gauge verzija2"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import Gauge';





    schema
    {
        textelement(Root)
        {
            tableelement(Gauge; Gauge)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Gauge';
                UseTemporary = false;
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }


                textelement(Serijskibroj)
                {
                    MinOccurs = Zero;
                }

                textelement(MjernoMjesto)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var
                    MMActivitiy: Record "MM Activity";
                    ServiceItem: Record "Service Item";
                    Manuf: record "Manufacturer";
                    GFond: Record Gauge;
                    CustF: Record customer;
                    InstallationHistoryPrevios: Record "Installation History";
                begin


                    Gauge.Reset();
                    Gauge.SetFilter(Code, '%1', Sifra);
                    if Gauge.FindFirst() then begin

                        if (gauge."Measuring Point" = '')
                         and (Gauge."Customer No." = '') then begin


                            //"Code", "Measuring Point", "Customer No.", "Address MM")
                            if GFond.Get(gauge.Code, GFond."Measuring Point", GFond."Customer No.", GFond."Address MM") then begin
                                ServiceItem.Reset();
                                ServiceItem.SetFilter("No.", '%1', MjernoMjesto);
                                if ServiceItem.FindFirst() then
                                    GFond.Rename(Gauge.Code, MjernoMjesto, ServiceItem."Customer No.", ServiceItem."Address MM");

                                InstallationHistoryPrevios.Reset();
                                InstallationHistoryPrevios.SetFilter(Type, '%1', InstallationHistoryPrevios.Type::Gauge);
                                InstallationHistoryPrevios.SetFilter(Code, '%1', Gauge.Code);
                                InstallationHistoryPrevios.SetCurrentKey("Installation Date");
                                InstallationHistoryPrevios.Ascending;
                                if InstallationHistoryPrevios.Active = true then begin
                                    InstallationHistoryPrevios.Active := false;
                                    InstallationHistoryPrevios.Modify();
                                    InstallationHistory.Init();
                                    InstallationHistory.Validate(Code, Gauge.Code);
                                    InstallationHistory.Validate("Inventory Number", Gauge."Inventar number");
                                    InstallationHistory.InvterentoryFil := InstallationHistory."Inventory Number";
                                    InstallationHistory.Validate(Type, InstallationHistory.Type::Gauge);
                                    InstallationHistory.Validate("Installation Date", 0D);
                                    InstallationHistory.Validate("Measuring Point Code", MjernoMjesto);
                                    InstallationHistory.Validate("Address MM", ServiceItem."Address MM");
                                    InstallationHistory.Validate("Customer No.", ServiceItem."Customer No.");
                                    InstallationHistory.Validate("Production Year", Gauge."Year of Production");
                                    InstallationHistory.Validate("DD calibration", Gauge."DD calibration");
                                    InstallationHistory.Validate("Year of production", Gauge."Year of Production");
                                    InstallationHistory.Validate(Active, true);


                                    InstallationHistory.Insert();
                                end;
                            end;
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
        QmaxDecimal: Decimal;
        NonpDecimal: Decimal;
        DUzinaDecimal: Decimal;
        EmpVec: Record Employee;
        GodinaProizvodnjeInt: Integer;
        GodinaBazdarenjaInt: Integer;
        EmailDeliveryDate_Date: date;
        ol: Decimal;
        prevoz: Decimal;
        empno: Integer;
        InstallationHistory: Record "Installation History";
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

