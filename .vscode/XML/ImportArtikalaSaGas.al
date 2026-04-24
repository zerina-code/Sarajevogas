xmlport 50036 ImportArtikalaSaGas
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'ImportArtikalaSaGas';
    schema
    {
        textelement(Root)
        {

            tableelement(Item; "Item")
            {

                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'Item';
                UseTemporary = false;

                textelement(br)
                {
                    MinOccurs = Zero;
                }
                textelement(naziv)
                {
                    MinOccurs = Zero;
                }
                textelement(osnovna_JM)
                {
                    MinOccurs = Zero;
                }
                textelement(konto)
                {
                    MinOccurs = Zero;
                }
                textelement(sifra_klase)
                {
                    MinOccurs = Zero;
                }
                textelement(naziv_klase)
                {
                    MinOccurs = Zero;
                }
                textelement(sifra_grupe2)
                {
                    MinOccurs = Zero;
                }
                textelement(naziv_grupe)
                {
                    MinOccurs = Zero;
                }
                textelement(sifra_podgrupe)
                {
                    MinOccurs = Zero;
                }
                textelement(naziv_podgrupe)
                {
                    MinOccurs = Zero;
                }
                textelement(ulaza_do_31_03_2024)
                {
                    MinOccurs = Zero;
                }
                textelement(izlaza_do_31_03_2024)
                {
                    MinOccurs = Zero;
                }
                textelement(saldo_31_03_2024)
                {
                    MinOccurs = Zero;
                }


                trigger OnAfterInsertRecord()
                var


                begin

                    Item.Reset();
                    Item.SetFilter("No.", '%1', br);
                    if Item.FindFirst() then begin
                        if naziv <> '' then begin
                            if StrLen(naziv) > 100 then begin
                                Item.Validate(Description, CopyStr(naziv, 1, 100));
                            end
                            else begin
                                Item.Validate(Description, naziv);
                            end;
                        end;
                        /*polje Osnovna JM u BC-u*/
                        if osnovna_JM <> '' then begin
                            //     Item.Validate("Base Unit of Measure", osnovna_JM);
                            Item."Base Unit of Measure" := osnovna_JM;

                        end;
                        /*polje JM za prodaju u BC-u */
                        if osnovna_JM <> '' then begin
                            ItemUnitofMeasure.Reset();
                            ItemUnitofMeasure.SetFilter("Item No.", '%1', br);
                            if not ItemUnitofMeasure.FindFirst() then begin
                                ItemUnitofMeasure.Init();
                                ItemUnitofMeasure."Item No." := br;
                                UnitofMeasure.Reset();
                                UnitofMeasure.SetRange("Code", osnovna_JM);
                                if UnitofMeasure.FindFirst() then begin
                                    ItemUnitofMeasure.Code := UnitofMeasure.Code;
                                end;

                                ItemUnitofMeasure.Insert();
                                Commit();
                            end;

                            Item."Sales Unit of Measure" := ItemUnitofMeasure.Code;

                        end;

                        /*polje JM za nabavu u BC-u */
                        if osnovna_JM <> '' then begin
                            ItemUnitofMeasure.Reset();
                            ItemUnitofMeasure.SetFilter("Item No.", '%1', br);
                            if not ItemUnitofMeasure.FindFirst() then begin
                                ItemUnitofMeasure.Init();
                                ItemUnitofMeasure."Item No." := br;
                                UnitofMeasure.Reset();
                                UnitofMeasure.SetRange("Code", osnovna_JM);
                                if UnitofMeasure.FindFirst() then begin
                                    ItemUnitofMeasure.Code := UnitofMeasure.Code;
                                end;

                                ItemUnitofMeasure.Insert();
                                Commit();
                            end;

                            Item."Purch. Unit of Measure" := ItemUnitofMeasure.Code;

                        end;
                        /* Polje Opšta knjižna grupa proizvoda */
                        if konto <> '' then begin
                            if konto = '10101' then begin
                                Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                Item."VAT Prod. Posting Group" := 'PDV17';
                            end else
                                if konto = '10103' then begin
                                    Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                    Item."VAT Prod. Posting Group" := 'PDV17';
                                end else
                                    if konto = '1040' then begin
                                        Item."Gen. Prod. Posting Group" := 'HTZ';
                                        Item."VAT Prod. Posting Group" := 'PDV17';
                                    end else
                                        if konto = '1030' then begin
                                            Item."Gen. Prod. Posting Group" := 'AUTOGUME';
                                            Item."VAT Prod. Posting Group" := 'PDV17';
                                        end else

                                            if konto = '10140' then begin
                                                Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                                Item."VAT Prod. Posting Group" := 'PDV17';
                                            end;


                        end;


                        /* polje Opšta knjižna grupa proizvoda i Knjižna grupa zaliha */
                        if konto <> '' then begin
                            InventoryPostingGroup.Reset();
                            InventoryPostingGroup.SetFilter(Code, '%1', konto);
                            if not InventoryPostingGroup.FindFirst() then begin
                                InventoryPostingGroup.Init();
                                InventoryPostingGroup.Code := konto;
                                if InventoryPostingGroup.Code = '10101' then begin
                                    InventoryPostingGroup.Description := 'Materijal za tekuće održavanje';
                                end else
                                    if InventoryPostingGroup.Code = '10103' then begin
                                        InventoryPostingGroup.Description := 'Materijal za priključke'
                                    end else
                                        if InventoryPostingGroup.Code = '1040' then begin
                                            InventoryPostingGroup.Description := 'HTZ oprema'
                                        end else
                                            if InventoryPostingGroup.Code = '1030' then begin
                                                InventoryPostingGroup.Description := 'Autogume'
                                            end else
                                                if InventoryPostingGroup.Code = '10140' then begin
                                                    InventoryPostingGroup.Description := 'Kancelarijski materijal'
                                                end;

                                InventoryPostingGroup.Insert();
                                Commit();
                            end;

                            Item."Inventory Posting Group" := InventoryPostingGroup.Code;


                        end;

                        /* polje Šifra klase u BC-u*/
                        if sifra_klase <> '' then begin
                            ItemCategory.Reset();
                            ItemCategory.SetRange("Category Label", sifra_klase);
                            if ItemCategory.FindFirst() then begin
                                Item.Validate("Item Category Code", ItemCategory."Code");

                            end;




                        end;

                        if sifra_klase <> '' then begin
                            Item.Validate("Category Code", Item."Item Category Code")
                        end;

                        /* polje Naziv klase u BC-u */
                        if naziv_klase <> '' then begin
                            Item.Validate("Category Description", naziv_klase);
                        end;

                        /* polje Šifra grupe u BC-u */
                        if sifra_grupe2 <> '' then begin
                            ServiceItemGroup.Reset();
                            ServiceItemGroup.SetFilter(Code, '%1', sifra_grupe2);
                            if not ServiceItemGroup.FindFirst() then begin
                                ServiceItemGroup.Init();
                                ServiceItemGroup.Code := sifra_grupe2;
                                ServiceItemGroup.Description := naziv_grupe;
                                ServiceItemGroup."Category Code" := sifra_klase;
                                ServiceItemGroup."Category Description" := naziv_klase;
                                ServiceItemGroup."Code Category Text" := 1;
                                ServiceItemGroup.Insert();
                                Commit();
                            end;

                            Item."Service Item Group" := ServiceItemGroup.Code;
                            Item."Item Group" := ServiceItemGroup.Code;
                            Item."Group Description" := ServiceItemGroup.Description;

                            //  Item.Validate("Item Group", sifra_grupe2);
                        end;

                        /* polje Šifra podgrupe u BC-u */
                        if sifra_podgrupe <> '' then begin
                            ServiceItemSubgroup.Reset();
                            ServiceItemSubgroup.SetFilter("Subgroup Description", '%1', naziv_podgrupe);
                            ServiceItemSubgroup.SetFilter("Subgroup Label", '%1', sifra_podgrupe);
                            if not ServiceItemSubgroup.FindFirst() then begin
                                ServiceItemSubgroup.Init();
                                ServiceItemSubgroup."Subgroup Code" := sifra_podgrupe;
                                ServiceItemSubgroup."Subgroup Label" := sifra_podgrupe;
                                ServiceItemSubgroup."Subgroup Description" := naziv_podgrupe;
                                ServiceItemSubgroup."Group Description" := naziv_grupe;
                                ServiceItemSubgroup.Insert();
                                Commit();
                            end;

                            Item."Item Subgroup" := ServiceItemSubgroup."Subgroup Label";
                            Item."Subgroup Description" := ServiceItemSubgroup."Subgroup Description";


                            //Item."Subgroup Description" := ServiceItemSubgroup."Subgroup Description";

                            //  Item.Validate("Item Subgroup", sifra_podgrupe);
                        end;
                        /*polje Naziv podgrupe */
                        /*if naziv_podgrupe <> '' then begin
                            Item.Validate("Subgroup Description", naziv_podgrupe);
                        end;*/

                        Item."Price/Profit Calculation" := Item."Price/Profit Calculation"::"Price=Cost+Profit";




                        Item.Modify();

                    end else begin

                        Item.Init();
                        Item."No." := br;

                        if naziv <> '' then begin
                            if StrLen(naziv) > 100 then begin
                                Item.Validate(Description, CopyStr(naziv, 1, 100));
                            end
                            else begin
                                Item.Validate(Description, naziv);
                            end;
                        end;
                        if osnovna_JM <> '' then begin
                            //     Item.Validate("Base Unit of Measure", osnovna_JM);
                            Item."Base Unit of Measure" := osnovna_JM;

                        end;
                        /*polje JM za prodaju u BC-u */
                        if osnovna_JM <> '' then begin
                            ItemUnitofMeasure.Reset();
                            ItemUnitofMeasure.SetFilter("Item No.", '%1', br);
                            if not ItemUnitofMeasure.FindFirst() then begin
                                ItemUnitofMeasure.Init();
                                ItemUnitofMeasure."Item No." := br;
                                UnitofMeasure.Reset();
                                UnitofMeasure.SetRange("Code", osnovna_JM);
                                if UnitofMeasure.FindFirst() then begin
                                    ItemUnitofMeasure.Code := UnitofMeasure.Code;
                                end;

                                ItemUnitofMeasure.Insert();
                                Commit();
                            end;

                            Item."Sales Unit of Measure" := ItemUnitofMeasure.Code;

                        end;

                        /*polje JM za nabavu u BC-u */
                        if osnovna_JM <> '' then begin
                            ItemUnitofMeasure.Reset();
                            ItemUnitofMeasure.SetFilter("Item No.", '%1', br);
                            if not ItemUnitofMeasure.FindFirst() then begin
                                ItemUnitofMeasure.Init();
                                ItemUnitofMeasure."Item No." := br;
                                UnitofMeasure.Reset();
                                UnitofMeasure.SetRange("Code", osnovna_JM);
                                if UnitofMeasure.FindFirst() then begin
                                    ItemUnitofMeasure.Code := UnitofMeasure.Code;
                                end;

                                ItemUnitofMeasure.Insert();
                                Commit();
                            end;

                            Item."Purch. Unit of Measure" := ItemUnitofMeasure.Code;

                        end;

                        /* Polje Opšta knjižna grupa proizvoda */
                        if konto <> '' then begin
                            if konto = '10101' then begin
                                Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                Item."VAT Prod. Posting Group" := 'PDV17';
                            end else
                                if konto = '10103' then begin
                                    Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                    Item."VAT Prod. Posting Group" := 'PDV17';
                                end else
                                    if konto = '1040' then begin
                                        Item."Gen. Prod. Posting Group" := 'HTZ';
                                        Item."VAT Prod. Posting Group" := 'PDV17';
                                    end else
                                        if konto = '1030' then begin
                                            Item."Gen. Prod. Posting Group" := 'AUTOGUME';
                                            Item."VAT Prod. Posting Group" := 'PDV17';
                                        end else

                                            if konto = '10140' then begin
                                                Item."Gen. Prod. Posting Group" := 'MATERIJALI';
                                                Item."VAT Prod. Posting Group" := 'PDV17';
                                            end;


                        end;


                        /* polje Opšta knjižna grupa proizvoda i Knjižna grupa zaliha */
                        if konto <> '' then begin
                            InventoryPostingGroup.Reset();
                            InventoryPostingGroup.SetFilter(Code, '%1', konto);
                            if not InventoryPostingGroup.FindFirst() then begin
                                InventoryPostingGroup.Init();
                                InventoryPostingGroup.Code := konto;
                                if InventoryPostingGroup.Code = '10101' then begin
                                    InventoryPostingGroup.Description := 'Materijal za tekuće održavanje';
                                end else
                                    if InventoryPostingGroup.Code = '10103' then begin
                                        InventoryPostingGroup.Description := 'Materijal za priključke'
                                    end else
                                        if InventoryPostingGroup.Code = '1040' then begin
                                            InventoryPostingGroup.Description := 'HTZ oprema'
                                        end else
                                            if InventoryPostingGroup.Code = '1030' then begin
                                                InventoryPostingGroup.Description := 'Autogume'
                                            end else
                                                if InventoryPostingGroup.Code = '10140' then begin
                                                    InventoryPostingGroup.Description := 'Kancelarijski materijal'
                                                end;

                                InventoryPostingGroup.Insert();
                                Commit();
                            end;

                            Item."Inventory Posting Group" := InventoryPostingGroup.Code;


                        end;


                        /* polje Šifra klase u BC-u*/
                        if sifra_klase <> '' then begin
                            ItemCategory.Reset();
                            ItemCategory.SetRange("Category Label", sifra_klase);
                            if ItemCategory.FindFirst() then begin
                                Item.Validate("Item Category Code", ItemCategory."Code");


                            end;

                        end;

                        if sifra_klase <> '' then begin
                            Item.Validate("Category Code", Item."Item Category Code")
                        end;

                        /* polje Naziv klase u BC-u */
                        if naziv_klase <> '' then begin
                            Item.Validate("Category Description", naziv_klase);
                        end;

                        /* polje Šifra grupe u BC-u */
                        if sifra_grupe2 <> '' then begin
                            ServiceItemGroup.Reset();
                            ServiceItemGroup.SetFilter(Code, '%1', sifra_grupe2);
                            if not ServiceItemGroup.FindFirst() then begin
                                ServiceItemGroup.Init();
                                ServiceItemGroup.Code := sifra_grupe2;
                                ServiceItemGroup.Description := naziv_grupe;
                                ServiceItemGroup."Category Code" := sifra_klase;
                                ServiceItemGroup."Category Description" := naziv_klase;
                                ServiceItemGroup.Insert();
                                Commit();
                            end;

                            Item."Service Item Group" := ServiceItemGroup.Code;
                            Item."Item Group" := ServiceItemGroup.Code;
                            Item."Group Description" := ServiceItemGroup.Description;

                            //  Item.Validate("Item Group", sifra_grupe2);
                        end;

                        /* polje Šifra podgrupe u BC-u */
                        if sifra_podgrupe <> '' then begin
                            ServiceItemSubgroup.Reset();
                            ServiceItemSubgroup.SetFilter("Subgroup Description", '%1', naziv_podgrupe);
                            ServiceItemSubgroup.SetFilter("Subgroup Label", '%1', sifra_podgrupe);
                            if not ServiceItemSubgroup.FindFirst() then begin
                                ServiceItemSubgroup.Init();
                                ServiceItemSubgroup."Subgroup Code" := sifra_podgrupe;
                                ServiceItemSubgroup."Subgroup Label" := sifra_podgrupe;
                                ServiceItemSubgroup."Subgroup Description" := naziv_podgrupe;
                                ServiceItemSubgroup."Group Description" := naziv_grupe;
                                ServiceItemSubgroup.Insert();
                                Commit();
                            end;

                            Item."Item Subgroup" := ServiceItemSubgroup."Subgroup Label";
                            Item."Subgroup Description" := ServiceItemSubgroup."Subgroup Description";


                            //Item."Subgroup Description" := ServiceItemSubgroup."Subgroup Description";

                            //  Item.Validate("Item Subgroup", sifra_podgrupe);
                        end;

                        /* polje Naziv podgrupe */
                        /* if naziv_podgrupe <> '' then begin
                             Item.Validate("Subgroup Description", naziv_podgrupe);
                         end;*/

                        Item."Price/Profit Calculation" := Item."Price/Profit Calculation"::"Price=Cost+Profit";

                        Item.Insert();








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

        InventoryPostingGroup: Record "Inventory Posting Group";
        GenProductPostingGroup: Record "Gen. Product Posting Group";

        ItemCategory: Record "Item Category";

        ServiceItemGroup: Record "Service Item Group";

        ServiceItemSubgroup: Record ItemSubgroup;

        NoSeriesLine: Record "No. Series Line";

        BrojacInt: code[20];

        ItemUnitofMeasure: Record "Item Unit of Measure";

        UnitofMeasure: Record "Unit of Measure";





}
