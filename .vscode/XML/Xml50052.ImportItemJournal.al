xmlport 50055 "Import Item Journal"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import Item Journal';

    schema
    {
        textelement(Root)
        {
            tableelement(ItemJournalLine; "Item Journal Line")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Upotreba';
                UseTemporary = false;
                textelement(LineNo)
                {
                    MinOccurs = Zero;
                }
                textelement(konto)
                {
                    MinOccurs = Zero;
                }

                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                /*   textelement(Artikl)
                   {
   */
                textelement(JeMj)
                {
                    MinOccurs = Zero;
                }
                textelement(Kol_R)
                {
                    MinOccurs = Zero;
                }
                textelement(Zad_Sif)
                {
                    MinOccurs = Zero;
                }
                textelement(Zaduzen)
                {
                    MinOccurs = Zero;
                }
                textelement(BrDokumenta)
                {
                    MinOccurs = Zero;
                }
                textelement(DatumKnjiženja)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                var
                    DatumKnjizenjaDate: Date;
                begin

                    /*
                                        ItemJournalBatch.Reset();
                                        ItemJournalBatch.SetRange("Journal Template Name", 'ITEM');
                                        ItemJournalBatch.SetRange(Name, konto);
                                        if not ItemJournalBatch.FindFirst() then begin
                                            ItemJournalBatch.Init();
                                            ItemJournalBatch."Journal Template Name" := 'ITEM';
                                            ItemJournalBatch.Name := konto;
                                            ItemJournalBatch.Transfer := true;
                                            ItemJournalBatch.Insert();
                                        end;


                                        ItemJournalLine.Init();
                                        ItemJournalLine."Journal Template Name" := 'ITEM';
                                        ItemJournalLine."Journal Batch Name" := konto;

                                        if LastLineNo = 0 then
                                            LastLineNo := 10000;
                                        ItemJournalLine."Line No." := LastLineNo;
                                        LastLineNo += 10000;


                                        if Sifra <> '' then begin
                                            Item.Reset();
                                            Item.SetRange("No.", Sifra);
                                            if Item.FindFirst() then begin
                                                ItemJournalLine.Validate("Item No.", Sifra);
                                            end else
                                                exit;
                                        end else
                                            exit;

                                        if BrDokumenta <> '' then
                                            ItemJournalLine."Document No." := BrDokumenta;

                                        if DatumKnjiženja <> '' then
                                            if Evaluate(DatumKnjizenjaDate, DatumKnjiženja) then
                                                ItemJournalLine."Posting Date" := DatumKnjizenjaDate;


                                        if JeMj <> '' then begin
                                            ItemUnitsOfMeasure.Reset();
                                            ItemUnitsOfMeasure.SetRange(Code, JeMj);
                                            if not ItemUnitsOfMeasure.FindFirst() then begin
                                                ItemUnitsOfMeasure.Init();
                                                ItemUnitsOfMeasure.Code := JeMj;
                                                ItemUnitsOfMeasure.Insert();
                                            end;
                                            ItemJournalLine."Unit of Measure Code" := JeMj;
                                        end;

                                        if Zad_Sif <> '' then begin
                                            Empl.Reset();
                                            Empl.SetRange("No.", Zad_Sif);
                                            if Empl.FindFirst() then begin
                                                ItemJournalLine.Validate("Employee No.", Zad_Sif);
                                                ItemJournalLine.Validate("Employee Name", Zaduzen);
                                            end;
                                        end;


                                        ItemJournalLine.Insert();*/


                    /*     ItemJournalLine.Reset();
                         ItemJournalLine.SetFilter("Journal Template Name", '%1', 'ITEM');
                         ItemJournalLine.setfilter("Journal Batch Name", '%1', konto);

                         // Message('Ušao sam u OnAfterGetRecord za red: %1', Sifra);
                         if not ItemJournalLine.FindFirst() then begin
                             ItemJournalBatch.Init();
                             ItemJournalBatch."Journal Template Name" := 'ITEM';
                             ItemJournalBatch.Name := konto;
                             ItemJournalBatch.Insert();

                         end else

                             if konto <> '' then begin
                                 ItemJournalLine."Journal Template Name" := 'ITEM';
                                 ItemJournalLine."Journal Batch Name" := konto;
                             end;

                         if LineNo <> '' then begin
                             if Evaluate(LienNoInt, LineNo) then
                                 ItemJournalLine."Line No." := LienNoInt;
                         end;


                         if Sifra <> '' then begin
                             Item.Reset();
                             Item.SetFilter("No.", '%1', Sifra);
                             if Item.FindFirst() then begin
                                 ItemJournalLine."Item No." := Item."No.";
                                 ItemJournalLine.Description := Item.Description;
                             end
                         end;

                         if JeMj <> '' then begin
                             ItemUnitsOfMeasure.Reset();
                             ItemUnitsOfMeasure.setfilter(Code, '%1', JeMj);
                             if ItemUnitsOfMeasure.FindFirst() then begin
                                 ItemJournalLine."Unit of Measure Code" := ItemUnitsOfMeasure.Code;
                             end;
                         end;

                         if Zad_Sif <> '' then begin
                             Empl.Reset();
                             Empl.SetFilter("No.", '%1', Zad_Sif);
                             if Empl.FindFirst() then begin
                                 ItemJournalLine."Employee No." := Empl."No.";
                                 ItemJournalLine."Employee Name" := Empl."Search Name";
                             end;

                         end;

                         if BrDokumenta <> '' then begin
                             ItemJournalLine."Document No." := BrDokumenta;
                         end;

                         if "DatumKnjiženja" <> '' then begin
                             if Evaluate(DatumKnjizenjaDate, DatumKnjiženja) then
                                 ItemJournalLine."Posting Date" := DatumKnjizenjaDate;

                         end;

                         ItemJournalLine.Insert();

                     end;*/
                    ItemJournalBatch.Reset();
                    ItemJournalBatch.SetRange("Journal Template Name", 'ITEM');
                    //  ItemJournalBatch.SetRange(Name, konto);;
                    ItemJournalBatch.SetRange(Name, 'PS');

                    if not ItemJournalBatch.FindFirst() then begin
                        ItemJournalBatch.Init();
                        ItemJournalBatch."Journal Template Name" := 'ITEM';
                        ItemJournalBatch.Name := 'PS';
                        ItemJournalBatch.Insert();
                    end;

                    // Sada sigurno postavi polja u liniju
                    ItemJournalLine.Init();
                    ItemJournalLine."Journal Template Name" := 'ITEM';
                    ItemJournalLine."Journal Batch Name" := 'PS';

                    if LineNo <> '' then
                        if Evaluate(LienNoInt, LineNo) then
                            ItemJournalLine."Line No." := LienNoInt;

                    if Sifra <> '' then begin
                        Item.Reset();
                        Item.SetFilter("No.", '%1', Sifra);
                        if Item.FindFirst() then begin
                            ItemJournalLine."Item No." := Item."No.";
                            ItemJournalLine.Description := Item.Description;


                            /*    if Item."Inventory Posting Group" <> konto then
                                    Error('Inventory Posting Group za artikal %1 (%2) ne odgovara vrijednosti iz Excel kolone Konto (%3).',
                                        Item."No.", Item."Inventory Posting Group", konto);*/

                        end;
                    end;

                    if JeMj <> '' then begin
                        ItemUnitsOfMeasure.Reset();
                        ItemUnitsOfMeasure.SetFilter(Code, '%1', JeMj);
                        if ItemUnitsOfMeasure.FindFirst() then
                            ItemJournalLine."Unit of Measure Code" := ItemUnitsOfMeasure.Code;
                    end;

                    if Kol_R <> '' then begin
                        if Evaluate(QuantityD, Kol_R) then
                            ItemJournalLine.Quantity := QuantityD;
                    end;

                    /*  if Zad_Sif <> '' then begin
                          Empl.Reset();
                          Empl.SetFilter("No.", '%1', Zad_Sif);
                          if Empl.FindFirst() then begin
                              ItemJournalLine."Employee No." := Empl."No.";
                            //  ItemJournalLine."Employee Name" := Empl."Search Name";
                              ItemJournalLine.Validate("Employee Name", Zaduzen);
                          end;
                      end;*/

                    /*  if Zad_Sif <> '' then begin
                          Empl.Reset();
                          Empl.SetFilter("No.", '%1', Zad_Sif);
                          if Empl.FindFirst() then begin
                              if (Zad_Sif = Empl."No.") and
                                 (UPPERCASE(Zaduzen) = UPPERCASE(Empl."Search Name")) then begin
                                  ItemJournalLine."Employee No." := Empl."No.";
                                  ItemJournalLine."Employee Name" := Empl."Search Name";
                              end;
                          end;
                      end;*/

                    if Zad_Sif <> '' then begin
                        if Evaluate(IntZadSif, Zad_Sif) then begin
                            Empl.Reset();
                            Empl.SetFilter("Old Number", '%1', IntZadSif);
                            if Empl.FindFirst() then begin
                                // Kombinacija prezime + ime
                                PunoIme := Empl."Last Name" + ' ' + Empl."First Name";

                                if (IntZadSif = Empl."Old Number") and
                                   (UPPERCASE(Zaduzen) = UPPERCASE(PunoIme)) then begin
                                    ItemJournalLine."Employee No." := Format(Empl."Old Number");
                                    ItemJournalLine."Employee Name" := PunoIme;
                                end;
                            end;
                        end;
                    end;




                    if BrDokumenta <> '' then
                        ItemJournalLine."Document No." := BrDokumenta;

                    if DatumKnjiženja <> '' then
                        if Evaluate(DatumKnjizenjaDate, DatumKnjiženja) then
                            ItemJournalLine."Posting Date" := DatumKnjizenjaDate;

                    ItemJournalLine.Insert();
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

    trigger OnPreXmlPort()
    begin
        Message('Počeo import u XMLport.');
    end;


    var
        DatumKnjizenjaDate: Date;
        Empl: Record "Employee";
        ItemUnitsOfMeasure: Record "Item Unit of Measure";
        ItemJournalBatch: Record "Item Journal Batch";
        LastLineNo: Integer;
        text001: Label 'Succesfully importred.';
        Item: Record Item;
        LienNoInt: Integer;
        IntZadSif: Integer;
        PunoIme: Text[100];
        QuantityD: Decimal;
}