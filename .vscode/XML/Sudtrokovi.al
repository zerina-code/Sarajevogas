xmlport 50042 "Sud.troškovi"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Sud.troškovi';
    schema
    {
        textelement(Root)
        {
            tableelement(AccusationHeader; "Accusation Header")
            {

                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'AccusationHeader1';
                UseTemporary = false;

                textelement(Id)
                {
                    MinOccurs = Zero;
                }
                textelement(Šifre)
                {
                    MinOccurs = Zero;
                }
                /* textelement(ip_suda)
                 {
                     MinOccurs = Zero;
                 }*/
                textelement(Opis)
                {
                    MinOccurs = Zero;
                }
                /* textelement(Datum_takse)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Duguje)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Potražuje)
                 {
                     MinOccurs = Zero;
                 }
                 textelement(Saldo)
                 {
                     MinOccurs = Zero;
                 }*/
                textelement(Datum)
                {
                    MinOccurs = Zero;
                }
                textelement(Iznos)
                {
                    MinOccurs = Zero;
                }

                trigger OnAfterInsertRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                    ACCLine: Record "Accusation Line";
                    ACCLine1: Record "Accusation Line";
                    LastLineNo: Integer;
                    Success: Boolean;


                begin

                    "AccusationHeader".Reset();
                    AccusationHeader.SetFilter("No.", '%1', Id);
                    "AccusationHeader".SetFilter("Customer No.", Šifre);

                    if "AccusationHeader".FindFirst() then begin



                        /*  if ip_suda <> '' then begin
                              CourtCode.Reset();
                              CourtCode.SetFilter(Customer, '%1', "Šifre");
                              CourtCode.SetFilter(MALS, '%1', CopyStr(ip_suda, 1, 30));
                              if not CourtCode.FindFirst() then begin
                                  CourtCode.Init();
                                  CourtCode.Code := TerritoryCode;
                                  TerritoryCode := IncStr(TerritoryCode);
                                  CourtCode.Type := 1;
                                  CourtCode.MALS := ip_suda;
                                  CourtCode.Accusation := AccusationHeader."No.";
                                  CourtCode.Customer := "Šifre";

                                  CourtCode.Insert();
                                  Commit();



                              end;

                              "AccusationHeader"."Court number" := CourtCode.Code;
                              "AccusationHeader"."Actual Court Number" := CourtCode.MALS;

                          end;
                          "AccusationHeader".Modify();

  */
                        AccLine.Reset();
                        AccLine.SetRange("Document No.", AccusationHeader."No.");

                        if not ACCLine.FindLast() then begin
                            LastLineNo := 10000;
                        end else begin

                            If AccLine.FindLast() then
                                LastLineNo := ACCLine."Line No." + 1


                        end;


                        AccLine.Init();
                        ACCLine."Document No." := "AccusationHeader"."No.";
                        ACCLine."Line No." := LastLineNo;


                        /*   if Duguje <> '' then begin

                               if Evaluate(DugujeDecimal, Duguje) then
                                   AccLine."Debt Amount - Transfer" := DugujeDecimal;

                           end;

                           if Potražuje <> '' then begin
                               if Evaluate(PotražujeDecimal, "Potražuje") then
                                   ACCLine."Amount Paid - Transfer" := "PotražujeDecimal";

                           end;*/


                        if Opis <> '' then begin

                            /*if Opis = 'Sudski troškovi' then
                                AccLine."Accusation Line Type" := 2;*/
                            ACCLine.Description := Opis;

                        end;

                        if Datum <> '' then begin
                            if Evaluate(DatumD, Datum) then
                                ACCLine."Date - Transfer" := DatumD;
                        end;

                        if Iznos <> '' then begin
                            if Evaluate(IznosD, Iznos) then
                                ACCLine."Line Amount" := IznosD;
                        end;



                        ACCLine.Insert();




                    end
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

    trigger OnInitXmlPort()
    begin

        NoSeriesLine.Reset()
        ;
        BrojacInt := IncStr(BrojacInt);
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := TerritoryCode;

        end;

    end;

    trigger OnPostXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            NoSeriesLine."Last No. Used" := TerritoryCode;

            NoSeriesLine.Modify();
        end;

    end;

    trigger OnPreXmlPort()
    var
        myInt: Integer;
    begin

        NoSeriesLine.Reset();
        NoSeriesLine.SetFilter("Series Code", '%1', 'RED');
        NoSeriesLine.SetFilter("Starting Date", '<=%1', today);
        NoSeriesLine.SetCurrentKey("Starting Date");
        if NoSeriesLine.FindLast() then begin
            if NoSeriesLine."Last No. Used" <> '' then begin
                TerritoryCode := IncStr(NoSeriesLine."Last No. Used");

            end
            else begin
                TerritoryCode := NoSeriesLine."Starting No.";

            end;
        end;


    end;

    var
        IPsifraInsert: Record Territory;

        TerritoryCode: code[20];

        DatumIPDate: Date;

        DugujeDecimal: Decimal;
        PotražujeDecimal: Decimal;
        SaldoDecimal: Decimal;
        NoSeriesLine: Record "No. Series Line";
        BrojacInt: code[20];
        CourtCode: Record Territory;
        DatumD: Date;
        IznosD: Decimal;

}
