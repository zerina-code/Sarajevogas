xmlport 50041 "SudskiTroškovi"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'SudskiTroškovi';
    schema
    {
        textelement(Root)
        {
            tableelement("Accusation Line"; "Accusation Line")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'AccHeader';
                UseTemporary = false;



                textelement(Br)
                {
                    MinOccurs = Zero;
                }
                textelement(Sifra)
                {
                    MinOccurs = Zero;
                }
                /*textelement(IDGlavne)
                {
                    MinOccurs = Zero;
                }*/

                /*   textelement(Potrosac)
                   {
                       MinOccurs = Zero;
                   }*/
                textelement(TuzeniRnBrojRn)
                {
                    MinOccurs = Zero;
                }
                textelement(TuzeniRnIznosTuzeni)
                {
                    MinOccurs = Zero;
                }
                textelement(Naplaceno)
                {
                    MinOccurs = Zero;
                }




                trigger OnPreXmlItem()
                var
                    myInt: Integer;
                begin
                    LineNo := 1000;

                end;

                trigger OnAfterInsertRecord()
                var
                    CustLedgEntry: Record "Cust. Ledger Entry";
                    ACCLine: Record "Accusation Line";
                    ACCLine1: Record "Accusation Line";

                    LastLineNo: Integer;
                    TempDebtAmount: Decimal;
                    Success: Boolean;
                    ACH: Record "Accusation Header";
                    TempPaidAmount: Decimal;
                begin
                    ACH.Reset();
                    ACH.SetFilter("Customer No.", Sifra);
                    ACH.SetFilter("No.", Br);

                    if ACH.FindFirst() then begin
                        CustLedgEntry.Reset();
                        CustLedgEntry.SetRange("External Document No.", TuzeniRnBrojRn);

                        if CustLedgEntry.FindFirst() then begin

                            Success := Evaluate(TempDebtAmount, TuzeniRnIznosTuzeni);

                            if Success then begin
                                if not Evaluate(TempPaidAmount, Naplaceno) then begin
                                    Message('Invalid paid amount format: ' + Naplaceno);
                                    TempPaidAmount := 0;
                                end;


                                ACCLine.Init();
                                ACCLine."Document No." := ACH."No.";
                                ACCLine."Cust. Ledger Entry No." := CustLedgEntry."Entry No.";
                                ACCLine.Description := TuzeniRnBrojRn;
                                ACCLine."Line No." := LineNo;
                                LineNo += 1000;

                                ACCLine."Debt Amount - Transfer" := TempDebtAmount;
                                ACCLine."Amount Paid - Transfer" := TempPaidAmount;


                                ACCLine.Insert();
                            end else begin

                                Message('Invalid debt amount format: ' + TuzeniRnIznosTuzeni);
                            end;
                        end
                        else begin


                            ACCLine.Init();
                            ACCLine."Document No." := ACH."No.";
                            // ACCLine."Cust. Ledger Entry No." := CustLedgEntry."Entry No.";
                            ACCLine.Description := TuzeniRnBrojRn;
                            ACCLine."Line No." := LineNo;
                            LineNo += 1000;

                            ACCLine."Debt Amount - Transfer" := TempDebtAmount;


                            ACCLine.Insert();


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
        TuzeniRnIznosDecimal: Decimal;
        LineNo: integer;
}
