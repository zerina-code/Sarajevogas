tableextension 50070 ShipAddress extends "Ship-to Address"
{


    fields
    {

        field(50000; "Measuring Point string"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Measuring Point string';

        }

        field(50001; "MZ-Code"; code[20])
        {
            Caption = 'MZ Code';
            TableRelation = MZ.Code;

        }
        field(50002; "Street"; Code[20])
        {
            Caption = 'Street';
            TableRelation = Street.Code;
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                if ("Street No." <> '') and ("Street" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate("MZ-Code", Stroke."MZ-Code");
                            //ĐK   Rec.validate("Street Customer", Stroke.Street);
                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                            Rec.Validate("Measuring Point string", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code" := '';
                            "MZ-Code" := '';
                            //ĐK       "Street Customer" := '';
                            "Measuring Point Stroke" := 0;
                            "Measuring Point string" := 0;
                            "Zone stroke" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();

                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate("MZ-Code", Stroke."MZ-Code");
                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code" := '';
                            "MZ-Code" := '';

                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Zone stroke" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code" := '';
                    "MZ-Code" := '';
                    "Measuring Point Stroke" := 0;
                    "Measuring Point String" := 0;
                    "Zone stroke" := 0;


                end;


            end;
        }
        field(50003; "Home No."; Code[20])
        {
            Caption = 'Home No.';

        }
        field(50004; "Measuring Point Stroke"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Measuring Point Stroke';

        }

        field(50005; "Municipality Code"; code[20])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code where(Type = filter(Regular));
        }
        field(50006; "Municipality Name"; Text[250])
        {
            Caption = 'Municipality name';
            FieldClass = FlowField;
            CalcFormula = lookup(Municipality.Name where(Code = field("Municipality Code"), Type = filter(Regular)));
        }

        field(50008; "MZ Name"; Text[250])
        {
            Caption = 'MZ Name Customer';
            FieldClass = FlowField;
            CalcFormula = lookup(MZ.Description where(Code = field("MZ-Code")));
        }

        field(50009; "Street Name"; Text[250])
        {
            Caption = 'Street Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Street.Description where(Code = field("Street")));
        }



        field(50011; "Apartment No."; Code[5])
        {
            Caption = 'Apartment No.';
            //ĐK  TableRelation = Street."Apartment No." where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"), Floor = field("Floor Customer"));
        }
        field(50012; "Floor"; code[20])
        {
            Caption = 'Floor';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"));


        }
        field(50062; "Street No."; code[20])
        {
            Caption = 'Street No.';
            //ĐK  TableRelation = Street.Floor where(Code = field("Street Customer"), "Home No." = field("Home No. Customer"))
            trigger OnValidate()
            var
                myInt: Integer;
                TestSubsCu: Codeunit TestSubsCu;
                StreetText: text[20];
                StreetInteger: integer;
                Stroke: Record Stroke;
                Even: Boolean;
            begin

                if ("Street No." <> '') and ("Street" <> '') then begin

                    StreetText := TestSubsCu.RemoveLetter("Street No.");
                    Evaluate(StreetInteger, StreetText);
                    Even := TestSubsCu.EvenOrOdd(StreetInteger);
                    if Even = true then begin
                        Stroke.Reset();
                        Stroke.SetFilter(Street, '%1', "Street");
                        Stroke.SetFilter("Even stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Even stroke to", '>=%1', StreetInteger);
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate("MZ-Code", Stroke."MZ-Code");
                            //ĐK   Rec.validate("Street Customer", Stroke.Street);
                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                            Rec.Validate("Measuring Point string", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code" := '';
                            "MZ-Code" := '';
                            //ĐK       "Street Customer" := '';
                            "Measuring Point Stroke" := 0;
                            "Measuring Point string" := 0;
                            "Zone stroke" := 0;

                        end;
                        //tražim parne

                    end
                    else begin

                        Stroke.Reset();

                        Stroke.SetFilter("Odd stroke from", '<=%1', StreetInteger);
                        Stroke.SetFilter("Odd stroke to", '>=%1', StreetInteger);
                        Stroke.SetFilter(Street, '%1', "Street");
                        if Stroke.FindFirst() then begin
                            Rec.Validate("Municipality Code", Stroke."Municipality Code");
                            Rec.Validate("MZ-Code", Stroke."MZ-Code");
                            Rec.Validate("Measuring Point Stroke", Stroke.Code);
                            Rec.Validate("Measuring Point String", Stroke."Measuring Point string");
                            Rec.Validate("Zone stroke", Stroke."Zone stroke");
                        end
                        else begin
                            "Municipality Code" := '';
                            "MZ-Code" := '';

                            "Measuring Point Stroke" := 0;
                            "Measuring Point String" := 0;
                            "Zone stroke" := 0;

                        end;


                    end;
                end
                else begin

                    "Municipality Code" := '';
                    "MZ-Code" := '';
                    "Measuring Point Stroke" := 0;
                    "Measuring Point String" := 0;
                    "Zone stroke" := 0;


                end;
                CalcFields("Street Name");
                Address := "Street Name" + ' ' + "Street No.";

            end;

        }
        field(50063; "Zone stroke"; Integer)
        {
            Caption = 'Zone stroke';

        }




    }


    var
        myInt: Integer;

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesExtented;
        GEN: Record "General Ledger Setup";
    begin
        GEN.get;

        //ovdje dodati brojčanu seriju
        Code := NoSeriesMgt.GetNextNo(GEN."No. series for Shipment A", TODAY, FALSE);

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}