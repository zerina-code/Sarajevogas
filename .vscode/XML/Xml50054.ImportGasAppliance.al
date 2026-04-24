xmlport 50054 ImportGasAppliance
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportGasAppliance';
    schema
    {
        textelement(Root)
        {
            tableelement(GasAppliance; "Gas Appliance")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'GA';
                UseTemporary = false;



                textelement(Id)
                {
                    MinOccurs = Once;
                }

                /*  textelement(Kupac_Sifra)
                  {
                      MinOccurs = Zero;
                  }*/

                textelement(Pekarska_peć)
                {
                    MinOccurs = Zero;
                }
                textelement(Pekarska_peć_kW)
                {
                    MinOccurs = Zero;
                }
                textelement(Pekarska_peć_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Roštilj)
                {
                    MinOccurs = Zero;
                }
                textelement(Roštilj_kW)
                {
                    MinOccurs = Zero;
                }
                textelement(Roštilj_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Friteza)
                {
                    MinOccurs = Zero;
                }
                textelement(Friteza_kW)
                {
                    MinOccurs = Zero;
                }
                textelement(Friteza_kom)
                {
                    MinOccurs = Zero;
                }
                /*   textelement(Peć_za_prženje_kafe)
                   {
                       MinOccurs = Zero;
                   }*/
                /*  textelement(Peć_za_prženje_kafe_kW)
                  {
                      MinOccurs = Zero;
                  }
                  textelement(Peć_za_prženje_kafe_kom)

                  {
                      MinOccurs = Zero;
                  }*/
                textelement(Štednjak)
                {
                    MinOccurs = Zero;
                }
                textelement(Štednjak_kW)
                {
                    MinOccurs = Zero;
                }
                textelement(Štednjak_kom)
                {
                    MinOccurs = Zero;
                }

                textelement(Štednjak_Kw_2_5)
                {
                    MinOccurs = Zero;
                }
                textelement(Štednjak_Kw_5)
                {
                    MinOccurs = Zero;
                }
                textelement(Štednjak_Kw_7_5)
                {
                    MinOccurs = Zero;
                }
                textelement(Štednjak_Kw_7_5_11)
                {
                    MinOccurs = Zero;
                }
                /*  textelement(Peći_A_kW_3_5_5)
                  {
                      MinOccurs = Zero;
                  }
                  textelement(Peći_A_kW_5_7)
                  {
                      MinOccurs = Zero;
                  }
                  textelement(Peći_AkW_7_9)
                  {
                      MinOccurs = Zero;
                  }
                  textelement(Peći_A_kW_9_12)
                  {
                      MinOccurs = Zero;
                  }*/
                textelement(Kamin_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Kalijeva_peć_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Ic_grijalica_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Gorionik_kom)
                {
                    MinOccurs = Zero;
                }
                textelement(Aparat_bez_termoelementa_kom)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var
                    MaxEntryNo: Integer;
                begin
                    Evaluate(IdInt, Id);

                    // Uvijek Reset i nađi zadnji Entry No. SAMO JEDNOM!
                    GasAppliance.Reset();
                    MaxEntryNo := 0;
                    GasAppliance.SetRange("Gas Install. Data Entry No.", IdInt);
                    if GasAppliance.FindLast() then
                        MaxEntryNo := GasAppliance."Entry No."
                    else
                        MaxEntryNo := 999;

                    //---------------------------------------
                    // PEKARSKA PEĆ
                    //---------------------------------------
                    if "Pekarska_peć" <> '' then
                        if "Pekarska_peć" = 'pekarska peć' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', "Pekarska_peć");
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                GasAppliance.Validate(Description, "Pekarska_peć");

                                if Pekarska_peć_kW <> '' then
                                    if Evaluate(Pekarska_peć_kWD, Pekarska_peć_kW) then
                                        GasAppliance.Validate("Power To", Pekarska_peć_kWD);

                                if Pekarska_peć_kom <> '' then
                                    if Evaluate(Pekarska_peć_komI, Pekarska_peć_kom) then
                                        GasAppliance.Validate(Quantity, Pekarska_peć_komI);

                                GasAppliance.Insert();
                            end;
                        end;

                    //---------------------------------------
                    // ROŠTILJ
                    //---------------------------------------
                    if "Roštilj" <> '' then
                        if "Roštilj" = 'roštilj' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', "Roštilj");
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1; // VAŽNO!
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                GasAppliance.Validate(Description, "Roštilj");

                                if Roštilj_kW <> '' then
                                    if Evaluate(Roštilj_kWD, Roštilj_kW) then
                                        GasAppliance.Validate("Power To", Roštilj_kWD);

                                if Roštilj_kom <> '' then
                                    if Evaluate(Roštilj_komI, Roštilj_kom) then
                                        GasAppliance.Validate(Quantity, Roštilj_komI);

                                GasAppliance.Insert();
                            end;
                        end;

                    //---------------------------------------
                    // FRITEZA
                    //---------------------------------------
                    if Friteza <> '' then
                        if Friteza = 'friteza' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', Friteza);
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                GasAppliance.Validate(Description, Friteza);

                                if Friteza_kW <> '' then
                                    if Evaluate(Friteza_kWD, Friteza_kW) then
                                        GasAppliance.Validate("Power To", Friteza_kWD);

                                if Friteza_kom <> '' then
                                    if Evaluate(Friteza_komI, Friteza_kom) then
                                        GasAppliance.Validate(Quantity, Friteza_komI);

                                GasAppliance.Insert();
                            end;
                        end;

                    //---------------------------------------
                    // ŠTEDNJAK
                    //---------------------------------------

                    /*
                                        if Štednjak <> '' then
                                            if Štednjak = 'štednjak' then begin
                                                GAT.Reset();
                                                GAT.SetFilter(Description, '%1', 'štednjak');
                                                if GAT.FindFirst() then begin
                                                    MaxEntryNo += 1;
                                                    GasAppliance.Init();
                                                    GasAppliance."Gas Install. Data Entry No." := IdInt;
                                                    GasAppliance."Entry No." := MaxEntryNo;
                                                    GasAppliance."Document No." := Format(IdInt);
                                                    GasAppliance.Validate(Description, Štednjak);

                                                    if Evaluate(Štednjak_komI, Štednjak_kom) then
                                                        GasAppliance.Validate(Quantity, Štednjak_komI);


                                                    Štednjak_kWD := 0;

                                                    if Štednjak_kW <> '' then
                                                        if Evaluate(Štednjak_kWD1, Štednjak_kW) then
                                                            Štednjak_kWD += Štednjak_kWD1;

                                                    if Štednjak_Kw_2_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_2_5D, Štednjak_Kw_2_5) then
                                                            Štednjak_kWD += Štednjak_Kw_2_5D;

                                                    if Štednjak_Kw_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_5D, Štednjak_Kw_5) then
                                                            Štednjak_kWD += Štednjak_Kw_5D;

                                                    if Štednjak_Kw_7_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_7_5D, Štednjak_Kw_7_5) then
                                                            Štednjak_kWD += Štednjak_Kw_7_5D;

                                                    if Štednjak_Kw_7_5_11 <> '' then
                                                        if Evaluate(Štednjak_Kw_7_5_11D, Štednjak_Kw_7_5_11) then
                                                            Štednjak_kWD += Štednjak_Kw_7_5_11D;

                                                    // ➜ Upisi zbir:
                                                    if Štednjak_kWD > 0 then
                                                        GasAppliance.Validate("Power To", Štednjak_kWD);

                                                    GasAppliance.Insert();
                                                end;
                                            end;*/
                    /*
                                        if Štednjak <> '' then
                                            if Štednjak = 'štednjak' then begin
                                                GAT.Reset();
                                                GAT.SetFilter(Description, '%1', 'štednjak');
                                                if GAT.FindFirst() then begin
                                                    MaxEntryNo += 1;
                                                    GasAppliance.Init();
                                                    GasAppliance."Gas Install. Data Entry No." := IdInt;
                                                    GasAppliance."Entry No." := MaxEntryNo;
                                                    GasAppliance."Document No." := Format(IdInt);
                                                    GasAppliance.Validate(Description, Štednjak);

                                                    if Evaluate(Štednjak_komI, Štednjak_kom) then
                                                        GasAppliance.Validate(Quantity, Štednjak_komI);

                                                    Štednjak_kWD := 0;

                                                    if Štednjak_kW <> '' then
                                                        if Evaluate(Štednjak_kWD1, Štednjak_kW) then
                                                            Štednjak_kWD += Štednjak_kWD1;

                                                    if Štednjak_Kw_2_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_2_5D, Štednjak_Kw_2_5) then
                                                            Štednjak_kWD += Štednjak_Kw_2_5D;

                                                    if Štednjak_Kw_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_5D, Štednjak_Kw_5) then
                                                            Štednjak_kWD += Štednjak_Kw_5D;

                                                    if Štednjak_Kw_7_5 <> '' then
                                                        if Evaluate(Štednjak_Kw_7_5D, Štednjak_Kw_7_5) then
                                                            Štednjak_kWD += Štednjak_Kw_7_5D;

                                                    if Štednjak_Kw_7_5_11 <> '' then
                                                        if Evaluate(Štednjak_Kw_7_5_11D, Štednjak_Kw_7_5_11) then
                                                            Štednjak_kWD += Štednjak_Kw_7_5_11D;

                                                    if Štednjak_kWD > 0 then
                                                        GasAppliance.Validate("Power To", Štednjak_kWD);

                                                    GasAppliance.Insert();
                                                end;
                                            end;*/

                    // Ako je Štednjak upisan i tačno piše 'štednjak'
                    if Štednjak <> '' then
                        if Štednjak = 'štednjak' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', 'štednjak');
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                GasAppliance.Validate(Description, Štednjak);

                                if Evaluate(Štednjak_komI, Štednjak_kom) then
                                    GasAppliance.Validate(Quantity, Štednjak_komI);

                                Štednjak_kWD := 0;

                                if Štednjak_kW <> '' then
                                    if Evaluate(Štednjak_kWD1, Štednjak_kW) then
                                        Štednjak_kWD += Štednjak_kWD1;

                                if Štednjak_Kw_2_5 <> '' then
                                    if Evaluate(Štednjak_Kw_2_5D, Štednjak_Kw_2_5) then
                                        Štednjak_kWD += Štednjak_Kw_2_5D;

                                if Štednjak_Kw_5 <> '' then
                                    if Evaluate(Štednjak_Kw_5D, Štednjak_Kw_5) then
                                        Štednjak_kWD += Štednjak_Kw_5D;

                                if Štednjak_Kw_7_5 <> '' then
                                    if Evaluate(Štednjak_Kw_7_5D, Štednjak_Kw_7_5) then
                                        Štednjak_kWD += Štednjak_Kw_7_5D;

                                if Štednjak_Kw_7_5_11 <> '' then
                                    if Evaluate(Štednjak_Kw_7_5_11D, Štednjak_Kw_7_5_11) then
                                        Štednjak_kWD += Štednjak_Kw_7_5_11D;

                                if Štednjak_kWD > 0 then
                                    GasAppliance.Validate("Power To", Štednjak_kWD);

                                GasAppliance.Insert();
                            end;
                        end;

                    // Ako Štednjak NIJE upisan, ali postoji snaga 
                    if (Štednjak = '') and
                       ((Štednjak_kW <> '') or (Štednjak_Kw_2_5 <> '') or (Štednjak_Kw_5 <> '') or
                        (Štednjak_Kw_7_5 <> '') or (Štednjak_Kw_7_5_11 <> '')) then begin

                        GAT.Reset();
                        //   GAT.SetFilter(Description, '%1', 'štednjak');
                        //  if GAT.FindFirst() then begin
                        MaxEntryNo += 1;
                        GasAppliance.Init();
                        GasAppliance."Gas Install. Data Entry No." := IdInt;
                        GasAppliance."Entry No." := MaxEntryNo;
                        GasAppliance."Document No." := Format(IdInt);
                        GasAppliance.Validate(Description, 'štednjak');

                        if Evaluate(Štednjak_komI, Štednjak_kom) then
                            GasAppliance.Validate(Quantity, Štednjak_komI);

                        Štednjak_kWD := 0;

                        if Štednjak_kW <> '' then
                            if Evaluate(Štednjak_kWD1, Štednjak_kW) then
                                Štednjak_kWD += Štednjak_kWD1;

                        if Štednjak_Kw_2_5 <> '' then
                            if Evaluate(Štednjak_Kw_2_5D, Štednjak_Kw_2_5) then
                                Štednjak_kWD += Štednjak_Kw_2_5D;

                        if Štednjak_Kw_5 <> '' then
                            if Evaluate(Štednjak_Kw_5D, Štednjak_Kw_5) then
                                Štednjak_kWD += Štednjak_Kw_5D;

                        if Štednjak_Kw_7_5 <> '' then
                            if Evaluate(Štednjak_Kw_7_5D, Štednjak_Kw_7_5) then
                                Štednjak_kWD += Štednjak_Kw_7_5D;

                        if Štednjak_Kw_7_5_11 <> '' then
                            if Evaluate(Štednjak_Kw_7_5_11D, Štednjak_Kw_7_5_11) then
                                Štednjak_kWD += Štednjak_Kw_7_5_11D;

                        if Štednjak_kWD > 0 then
                            GasAppliance.Validate("Power To", Štednjak_kWD);

                        GasAppliance.Insert();
                        Commit();
                    end;
                    // end;


                    //---------------------------------------
                    // GORIONIK
                    //---------------------------------------
                    /* if Gorionik_kom <> '' then
                         if Gorionik_kom <> '0' then begin
                             MaxEntryNo += 1;
                             GasAppliance.Init();
                             GasAppliance."Gas Install. Data Entry No." := IdInt;
                             GasAppliance."Entry No." := MaxEntryNo;
                             GasAppliance."Document No." := Format(IdInt);
                             //   GasAppliance.Validate(Description, 'gorionik');
                             GasAppliance.Description := 'gorionik';

                             if Evaluate(Gorionik_komI, Gorionik_kom) then
                                 //    GasAppliance.Validate(Quantity, Gorionik_komI);
                                 GasAppliance.Quantity := Gorionik_komI;

                             GasAppliance.Insert();
                             Commit();
                         end;

                     //---------------------------------------
                     // APARAT BEZ TERMOELEMENTA
                     //---------------------------------------
                     if Aparat_bez_termoelementa_kom <> '' then
                         if Aparat_bez_termoelementa_kom <> '0' then begin
                             MaxEntryNo += 1;
                             GasAppliance.Init();
                             GasAppliance."Gas Install. Data Entry No." := IdInt;
                             GasAppliance."Entry No." := MaxEntryNo;
                             GasAppliance."Document No." := Format(IdInt);
                             //  GasAppliance.Validate(Description, 'Aparat bez termoelementa');
                             GasAppliance.Description := 'Aparat bez termoelementa';

                             if Evaluate(Aparat_bez_termoelementa_komI, Aparat_bez_termoelementa_kom) then
                                 //  GasAppliance.Validate(Quantity, Aparat_bez_termoelementa_komI);
                                 GasAppliance.Quantity := Aparat_bez_termoelementa_komI;

                             GasAppliance.Insert();
                             Commit();
                         end;*/

                    if Gorionik_kom <> '' then
                        if Gorionik_kom <> '0' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', 'gorionik');
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                //GasAppliance.Validate(Description, 'gorionik');
                                GasAppliance.Description := 'gorionik';

                                if Evaluate(Gorionik_komI, Gorionik_kom) then
                                    //   GasAppliance.Validate(Quantity, Gorionik_komI);
                                    GasAppliance.Quantity := Gorionik_komI;

                                GasAppliance.Insert();
                            end;
                        end;
                    if Aparat_bez_termoelementa_kom <> '' then
                        if Aparat_bez_termoelementa_kom <> '0' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', 'Aparat bez termoelementa');
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                //  GasAppliance.Validate(Description, 'Aparat bez termoelementa');
                                GasAppliance.Description := 'Aparat bez termoelementa';


                                if Evaluate(Aparat_bez_termoelementa_komI, Aparat_bez_termoelementa_kom) then
                                    //  GasAppliance.Validate(Quantity, Aparat_bez_termoelementa_komI);
                                    GasAppliance.Quantity := Aparat_bez_termoelementa_komI;


                                GasAppliance.Insert();
                            end;
                        end;

                    if Kamin_kom <> '' then
                        if Kamin_kom <> '0' then begin
                            GAT.Reset();
                            GAT.SetFilter(Description, '%1', 'kamin');
                            if GAT.FindFirst() then begin
                                MaxEntryNo += 1;
                                GasAppliance.Init();
                                GasAppliance."Gas Install. Data Entry No." := IdInt;
                                GasAppliance."Entry No." := MaxEntryNo;
                                GasAppliance."Document No." := Format(IdInt);
                                //  GasAppliance.Validate(Description, 'Aparat bez termoelementa');
                                GasAppliance.Description := 'kamin';


                                if Evaluate(Kamin_komI, Kamin_kom) then
                                    //  GasAppliance.Validate(Quantity, Aparat_bez_termoelementa_komI);
                                    GasAppliance.Quantity := Kamin_komI;


                                GasAppliance.Insert();
                            end;
                        end;

                end;




            }
        }
    }










    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }


    var

        IdInt: Integer;
        GAT: Record "Gas Appliance Type";
        Pekarska_peć_kWD: Decimal;
        Pekarska_peć_komI: Integer;
        Roštilj_kWD: Decimal;
        Roštilj_komI: Integer;
        Friteza_kWD: Decimal;
        Friteza_komI: Integer;
        Štednjak_komI: Integer;
        Štednjak_kWD: Decimal;
        Štednjak_Kw_2_5D: decimal;
        Štednjak_Kw_5D: Decimal;
        Štednjak_Kw_7_5D: Decimal;
        Štednjak_Kw_7_5_11D: decimal;
        Gorionik_komI: Integer;
        Aparat_bez_termoelementa_komI: Integer;
        Štednjak_kWD1: Decimal;
        Kamin_komI: Integer;
}
