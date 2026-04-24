xmlport 50000 "Import GK"
{
    Direction = Import;
    FieldDelimiter = ';';
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = UTF8;
    Caption = 'Import GK';




    schema
    {
        textelement(Root)
        {
            tableelement("G/L Entry"; "G/L Entry")
            {
                AutoSave = false;
                MinOccurs = Once;
                XmlName = 'EL_Module';
                UseTemporary = false;
                textelement(EntryNot)
                {
                    MinOccurs = Zero;
                }
                textelement(GK_A)
                {
                    MinOccurs = Zero;
                }
                textelement(PostingDatet)
                {
                    MinOccurs = Zero;
                }
                textelement(DocumentNOt)
                {
                    MinOccurs = Zero;
                }

                textelement(Descriptiont)
                {
                    MinOccurs = Zero;
                }

                textelement(Amountt)
                {
                    MinOccurs = Zero;
                }
                textelement(Useridd)
                {
                    MinOccurs = Zero;
                }


                textelement(TransactionNo)
                {
                    MinOccurs = Zero;
                }
                textelement(Debitt)
                {
                    MinOccurs = Zero;
                }
                textelement(Creditt)
                {
                    MinOccurs = zero;
                }

                textelement(Referenct)
                {
                    MinOccurs = Zero;
                }
                textelement(External)
                {
                    MinOccurs = Zero;
                }





                trigger OnAfterInsertRecord()
                var
                    RecRef: RecordRef;
                    RecordRefExample: Codeunit "Modiy Permissions";
                    EntrInt: integer;
                    PostingDD: date;
                    AmountDecimal: decimal;
                    TransactionNoInt: Integer;
                    DebitDecimal: Decimal;
                    CreditDecimal: Decimal;
                    GLentry: Record "G/L Entry";
                begin

                    if ModifyDelete = true then begin

                        if Confirm('Da li ste sigurni da želite obrisati stavke GK') then begin
                            evaluate(EntrInt, EntryNot);
                            GLentry.Reset();
                            GLentry.SetFilter("Entry No.", '%1', EntrInt);
                            if GLentry.FindFirst() then begin

                                RecRef.GetTable(GLentry);
                                RecordRefExample.DeleteRecords(RecRef);

                            end;

                        end;
                    end
                    else begin
                        evaluate(EntrInt, EntryNot);
                        evaluate(PostingDD, PostingDatet);
                        evaluate(AmountDecimal, Amountt);
                        evaluate(TransactionNoInt, TransactionNo);
                        Evaluate(DebitDecimal, Debitt);
                        Evaluate(CreditDecimal, Creditt);
                        GLentry.Reset();
                        GLentry.SetFilter("Entry No.", '%1', EntrInt);
                        if GLentry.FindFirst() then begin
                            GLentry.Validate("G/L Account No.", GK_A);
                            RecRef.GetTable(GLentry);
                            RecordRefExample.ModifyRecords(RecRef);

                        end
                        else begin

                            "G/L Entry".init;
                            "G/L Entry"."Entry No." := EntrInt;
                            "G/L Entry"."G/L Account No." := GK_A;
                            "G/L Entry"."Posting Date" := PostingDD;

                            "G/L Entry"."Document Date" := PostingDD;
                            "G/L Entry"."Document No." := DocumentNOt;

                            "G/L Entry"."Description" := Descriptiont;
                            "G/L Entry"."Payment Reference" := Referenct;
                            "G/L Entry"."Amount" := AmountDecimal;
                            "G/L Entry"."User ID" := Useridd;
                            "G/L Entry"."Source Code" := 'KNJTROSZAL';
                            "G/L Entry"."System-Created Entry" := true;
                            "G/L Entry"."Bal. Account Type" := "G/L Entry"."Bal. Account Type"::"G/L Account";
                            "G/L Entry"."Transaction No." := TransactionNoInt;
                            "G/L Entry"."Debit Amount" := DebitDecimal;
                            "G/L Entry"."Credit Amount" := CreditDecimal;
                            "G/L Entry"."External Document No." := External;
                            "G/L Entry".KUF_Type := "G/L Entry".KUF_Type::"DOMAĆI";

                            //    RecRef.GetTable("G/L Entry");
                            //  RecordRefExample.ModifyRecords(RecRef);

                            CODEUNIT.Run(CODEUNIT::"Insert Permissions", "G/L Entry");
                        end;
                    end;
                end;
            }
        }
    }
    requestpage
    {
        Caption = 'Action';

        layout
        {
            area(content)
            {

                field(ModifyDelete; ModifyDelete)
                {
                    Caption = 'Delete';
                }
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        //   
    end;

    trigger OnInitXmlPort()
    var
        myInt: Integer;
    begin
        ModifyDelete := false;

    end;



    var
        ModifyDelete: boolean;

}


