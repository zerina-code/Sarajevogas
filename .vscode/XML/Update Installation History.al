xmlport 50021 "Update Installation History"
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
            tableelement("Service Item"; "Service Item")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'IH';
                UseTemporary = false;
                textelement(BrojMM)
                {
                    MinOccurs = Once;
                }
                textelement(VrstaOcitanja)
                {
                    MinOccurs = Zero;
                }
                textelement(StartPotrosnje)
                {
                    MinOccurs = Zero;
                }
                textelement(NacinObracuna)
                {
                    MinOccurs = Zero;

                }
                textelement(NacinOcitanja)
                {
                    MinOccurs = Zero;
                }
                textelement(Mobitel)
                {
                    MinOccurs = Zero;
                }
                textelement(Mjeerac)
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
                    "Service Item".Reset();
                    "Service Item".SetFilter("No.", '%1', BrojMM);
                    if "Service Item".FindFirst() then begin
                        if VrstaOcitanja = '1' then
                            "Service Item"."Type of reading" := "Service Item"."Type of reading"::"Radio Module";
                        if VrstaOcitanja = '3' then
                            "Service Item"."Type of reading" := "Service Item"."Type of reading"::"Module Type 3";

                        if (VrstaOcitanja <> '1') and (VrstaOcitanja <> '3') then
                            "Service Item"."Type of reading" := "Service Item"."Type of reading"::Unknown;

                        if Evaluate(StartP, StartPotrosnje) then begin
                            "Service Item"."Starting Measuring" := startP;

                            if NacinOcitanja = '0' then
                                "Service Item"."Reading Mode" := "Service Item"."Reading Mode"::"Reading List";
                            if NacinOcitanja = '1' then
                                "Service Item"."Reading Mode" := "Service Item"."Reading Mode"::Digital;

                            Evaluate(mob, Mobitel);
                            "Service Item"."Mobile No." := Mob;



                        end;
                        "Service Item".Modify();
                        CJL.Reset();
                        CJL.SetFilter("Measuring Point Code", '%1', BrojMM);
                        if cjl.FindFirst() then begin
                            cjl."Type of reading" := "Service Item"."Type of reading";
                            if NacinObracuna = '1' then
                                cjl."Method of calculation" := cjl."Method of calculation"::"1";
                            if NacinObracuna = '2' then
                                cjl."Method of calculation" := cjl."Method of calculation"::"2";
                            if NacinObracuna = '3' then
                                cjl."Method of calculation" := cjl."Method of calculation"::"3";

                            if NacinObracuna = '4' then
                                cjl."Method of calculation" := cjl."Method of calculation"::"4";

                            if NacinOcitanja = '0' then
                                cjl."Reading Mode" := cjl."Reading Mode"::"Reading List";
                            if NacinOcitanja = '1' then
                                CJL."Reading Mode" := cjl."Reading Mode"::Digital;
                            cjl."Mobile No." := mob;


                            cjl.Modify();
                        end;

                        Gauge.Reset();
                        Gauge.SetFilter("Measuring Point", '%1', BrojMM);
                        Gauge.SetFilter("Inventar number", '%1', Mjeerac);
                        if Gauge.FindFirst() then begin


                            if NacinObracuna = '1' then
                                Gauge."Method of calculation" := Gauge."Method of calculation"::"1";
                            if NacinObracuna = '2' then
                                Gauge."Method of calculation" := Gauge."Method of calculation"::"2";
                            if NacinObracuna = '3' then
                                Gauge."Method of calculation" := Gauge."Method of calculation"::"3";

                            if NacinObracuna = '4' then
                                Gauge."Method of calculation" := Gauge."Method of calculation"::"4";


                            IH.Reset();
                            IH.SetFilter(Type, '%1', Ih.Type::Gauge);
                            IH.SetFilter(Code, '%1', Gauge.Code);
                            ih.SetFilter("Measuring Point Code", '%1', BrojMM);
                            if ih.FindFirst() then begin
                                ih."Installation Date" := StartP;
                                ih.Modify();
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
                         Cust."Customer Status" := SH."Customer Status";
                         Cust.Modify();
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

