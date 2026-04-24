xmlport 50022 "Update Gauge"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Installation History';





    schema
    {
        textelement(Root)
        {
            tableelement(Gauge; Gauge)
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'IH';
                UseTemporary = false;
                textelement(SerialNumber)
                {
                    MinOccurs = Once;
                }
                textelement(VelicinaMjeraca)
                {
                    MinOccurs = Zero;
                }




                trigger OnAfterInsertRecord()
                var
                    ServiceItem: Record "Service Item";
                    CustomerU: Record customer;
                    IH: Record "Installation History";
                    DateI: Date;
                    autoi: Integer;
                    StartP: date;
                    Gauge: Record Gauge;
                    CJL: Record "Calculation Journal Line";
                    Mob: Integer;
                begin










                    Gauge.Reset();
                    //   Gauge.SetFilter("Measuring Point", '%1', BrojMM);
                    Gauge.SetFilter("Inventar number", '%1', SerialNumber);

                    if Gauge.FindFirst() then begin
                        Gauge.Validate("Gauge Size", VelicinaMjeraca);
                        Gauge.Modify();
                        CJL.Reset();
                        cjl.SetFilter(Gauge, '%1', Gauge.Code);
                        if cjl.FindFirst() then begin
                            cjl."Gauge Size" := Gauge."Gauge Size";
                            cjl.Modify();
                        end;



                    end;













                end;


            }
        }
    }
    trigger OnPreXmlPort()
    begin

    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
        Cust: Record customer;
        ServI: Record "Service Item";
        SH: Record "Status History";

        IH: Record "Installation History";
        CJL: Record "Calculation Journal Line";
    begin

        /* CJL.Reset();
         //   CJL.SetFilter("Method of calculation", '%1', CJL."Method of calculation"::" ");
         if cjl.FindSet() then
             repeat
                 cjl."Method of calculation" := cjl."Method of calculation"::"1";
                 cjl.Modify();
             until cjl.Next() = 0;*/

        /*     SH.Reset();
             sh.SetFilter(Type, '%1', sh.Type::Customer);
             sh.SetFilter(Active, '%1', true);
             if sh.FindSet() then
                 repeat
                     cust.Reset();
                     cust.SetFilter("No.", '%1', sh."Customer No.");
                     if cust.FindFirst() then begin

                     end;



                 until sh.Next() = 0;


             SH.Reset();
             sh.SetFilter(Type, '%1', sh.Type::MM);
             sh.SetFilter(Active, '%1', true);
             if sh.FindSet() then
                 repeat
                     ServI.Reset();
                     ServI.SetFilter("No.", '%1', sh."Measuring Point");
                     if ServI.FindFirst() then begin
                         ServI."Status MM" := SH.Status;
                         ServI.Modify();
                     end;



                 until sh.Next() = 0;
         end;*/
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

