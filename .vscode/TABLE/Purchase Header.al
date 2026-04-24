tableextension 50002 PurchaseHeaderExtends extends "Purchase Header"
{

    //ED 

    fields
    {
        //    VAT Base (retro.)
        field(50000; "VAT Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
        }
        field(50001; "Purchase Is Finished"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Prepayment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Vendor Type"; Option)
        {
            OptionMembers = ,Ink,"Spare parts";
            DataClassification = ToBeClassified;
        }
        field(50013; "Contract Entry No."; Code[20])
        {
            Caption = 'Contract Entry No.';
            TableRelation = "Purchase Contract"."Contract Entry No." WHERE("Contract Final Date" = field("Today Date"));


            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                //Rec.Validate("Document Type", 1); //da bi uradio insert narudzbenice, tj dodijelio broj narudzbenice 

                PurchaseContract.Reset();
                PurchaseContract.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                if PurchaseContract.FindFirst() then begin
                    Rec."Contract No." := PurchaseContract."No.";
                    Rec."Contract Purchase Item" := PurchaseContract."Purchase Item";
                    Validate("Buy-from Vendor No.", PurchaseContract."Vendor No.");

                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        if not UserSetup."Order From Expired Contract" then begin
                            if (Rec."Posting Date" < PurchaseContract."Contract Start Date") or (Rec."Posting Date" > PurchaseContract."Contract Final Date") then
                                Error('Narudžbenicu nije moguće kreirati za odabrani ugovor.');
                        end;
                    end;

                    //Rec.Insert();
                end;

                //Rec.Init();
                //Rec.InitInsert();
                if rec."No." = '' then
                    Rec.Insert(true);

                LineNoCounter := 10000;

                /*UserSetup.Reset();
                UserSetup.SetFilter("User ID", '%1', 'TENEO\ELMIRA.DEDOVIC');
                if UserSetup.FindFirst() then begin*/
                PurchaseContract.Reset();
                PurchaseContract.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                //tražim ovaj ugovor da bih mogla vidjeti vrstu nabavke
                //u linijama cu razlicito insertovati robu, radove i usluge
                if PurchaseContract.FindFirst() then begin

                    if PurchaseContract."Purchase Type".AsInteger() = 1 then begin //za artikle je Item 

                        ContractScope.Reset();
                        ContractScope.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                        if ContractScope.FindFirst() then
                            repeat //ubacujem jednu po jednu liniju, odnosno jedan po jedan artikl
                                PurchaseLine.Reset();
                                PurchaseLine.Init();
                                PurchaseLine.Validate("Document Type", 1);
                                PurchaseLine."Document No." := Rec."No.";
                                PurchaseLine.Validate("Line No.", LineNoCounter);
                                LineNoCounter += 10000;
                                PurchaseLine.Type := PurchaseLine.Type::Item; //tip je artikl
                                UserSetup.Reset();
                                UserSetup.SetFilter("User ID", '%1', UserId);
                                if UserSetup.FindFirst() then begin
                                    UserSetup."Contract No." := Rec."Contract Entry No.";
                                    //Message(UserSetup."Contract No.");
                                    UserSetup.Modify();
                                end;

                                PurchaseLine.Validate("No.", ContractScope."Item No.");
                                PurchaseLine.Validate("Location Code", 'GLAVNO');
                                //korisnici su zeljeti da na izvjestaju Artikli po lokacijama prvo bude GLAVNO skladište
                                //zbog toga su sada u nazivima skladišta brojevi na početku
                                PurchaseLine.Validate("Direct Unit Cost", ContractScope."Unit Price");
                                PurchaseLine.Validate(Quantity, ContractScope.Quantity);
                                PurchaseLine.Validate("Contract No.", ContractScope."Contract Entry No.");
                                PurchaseLine.Validate("Contract Entry No.", ContractScope."Contract Entry No.");
                                PurchaseLine.Validate("Direktni sporazum", PurchaseContract."Direktni sporazum");
                                PurchaseLine.Validate("Purchase Type", PurchaseContract."Purchase Type");
                                PurchaseLine.Validate("Plan No.", PurchaseContract."Entry No. Plan");
                                PurchaseLine.Validate("Purchase Plan Code", PurchaseContract."Purchase Plan Code");
                                PurchaseLine.Insert();
                            until ContractScope.Next() = 0;


                    end else
                        if PurchaseContract."Purchase Type".AsInteger() = 2 then begin //za radove je konto GK

                            ContractScope.Reset();
                            ContractScope.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                            if ContractScope.FindFirst() then
                                repeat //ubacujem jednu po jednu liniju
                                    PurchaseLine.Reset();
                                    PurchaseLine.Init();
                                    PurchaseLine.Validate("Document Type", 1);
                                    PurchaseLine.Validate("Document No.", Rec."No.");
                                    PurchaseLine.Validate("Line No.", LineNoCounter);
                                    LineNoCounter += 10000;
                                    PurchaseLine.Validate(Type, 1); //tip je račun GK
                                    PurchaseLine.Validate("No.", ContractScope."G/L Account No.");
                                    PurchaseLine.Validate("Direct Unit Cost", ContractScope."Unit Price");
                                    PurchaseLine.Validate(Quantity, ContractScope.Quantity);
                                    PurchaseLine.Validate("Contract No.", ContractScope."Contract Entry No.");
                                    PurchaseLine.Validate("Contract Entry No.", ContractScope."Contract Entry No.");
                                    PurchaseLine.Validate("Direktni sporazum", PurchaseContract."Direktni sporazum");
                                    PurchaseLine.Validate("Purchase Type", PurchaseContract."Purchase Type");
                                    PurchaseLine.Validate("Plan No.", PurchaseContract."Entry No. Plan");
                                    PurchaseLine.Validate("Purchase Plan Code", PurchaseContract."Purchase Plan Code");

                                    PurchaseLine.Insert();
                                until ContractScope.Next() = 0;

                        end else
                            if PurchaseContract."Purchase Type".AsInteger() = 3 then begin //usluge su resursi

                                ContractScope.Reset();
                                ContractScope.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                                if ContractScope.FindFirst() then
                                    repeat //ubacujem jednu po jednu liniju
                                        PurchaseLine.Reset();
                                        PurchaseLine.Init();
                                        PurchaseLine.Validate("Document Type", 1);
                                        PurchaseLine.Validate("Document No.", Rec."No.");
                                        PurchaseLine.Validate("Line No.", LineNoCounter);
                                        LineNoCounter += 10000;
                                        PurchaseLine.Validate(Type, 3); //tip je resurs
                                        PurchaseLine.Validate("No.", ContractScope."Resource No.");
                                        PurchaseLine.Validate("Direct Unit Cost", ContractScope."Unit Price");
                                        PurchaseLine.Validate(Quantity, ContractScope.Quantity);
                                        PurchaseLine.Validate("Contract No.", ContractScope."Contract Entry No.");
                                        PurchaseLine.Validate("Contract Entry No.", ContractScope."Contract Entry No.");
                                        PurchaseLine.Validate("Direktni sporazum", PurchaseContract."Direktni sporazum");
                                        PurchaseLine.Validate("Purchase Type", PurchaseContract."Purchase Type");
                                        PurchaseLine.Validate("Plan No.", PurchaseContract."Entry No. Plan");
                                        PurchaseLine.Validate("Purchase Plan Code", PurchaseContract."Purchase Plan Code");
                                        PurchaseLine.Insert();
                                    until ContractScope.Next() = 0;

                            end else
                                if PurchaseContract."Purchase Type".AsInteger() = 4 then begin

                                    ContractScope.Reset();
                                    ContractScope.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                                    if ContractScope.FindFirst() then
                                        repeat
                                            PurchaseLine.Reset();
                                            PurchaseLine.Init();
                                            PurchaseLine.Validate("Document Type", 1);
                                            PurchaseLine."Document No." := Rec."No.";
                                            PurchaseLine.Validate("Line No.", LineNoCounter);
                                            LineNoCounter += 10000;
                                            PurchaseLine.Type := PurchaseLine.Type::"Fixed Asset"; //tip je os
                                            UserSetup.Reset();
                                            UserSetup.SetFilter("User ID", '%1', UserId);
                                            if UserSetup.FindFirst() then begin
                                                UserSetup."Contract No." := Rec."Contract Entry No.";
                                                //Message(UserSetup."Contract No.");
                                                UserSetup.Modify();
                                            end;

                                            PurchaseLine.Validate("No.", ContractScope."Fixed Asset No.");
                                            PurchaseLine.Validate("Location Code", 'GLAVNO');
                                            //korisnici su zeljeti da na izvjestaju Artikli po lokacijama prvo bude GLAVNO skladište
                                            //zbog toga su sada u nazivima skladišta brojevi na početku
                                            PurchaseLine.Validate("Direct Unit Cost", ContractScope."Unit Price");
                                            PurchaseLine.Validate(Quantity, ContractScope.Quantity);
                                            PurchaseLine.Validate("Contract No.", ContractScope."Contract Entry No.");
                                            PurchaseLine.Validate("Contract Entry No.", ContractScope."Contract Entry No.");
                                            PurchaseLine.Validate("Direktni sporazum", PurchaseContract."Direktni sporazum");
                                            PurchaseLine.Validate("Purchase Type", PurchaseContract."Purchase Type");
                                            PurchaseLine.Validate("Plan No.", PurchaseContract."Entry No. Plan");
                                            PurchaseLine.Validate("Purchase Plan Code", PurchaseContract."Purchase Plan Code");
                                            PurchaseLine.Insert();
                                        until ContractScope.Next() = 0;
                                end;


                end;
            end;
        }
        field(50007; "Contract Purchase Item"; Text[200])
        {
            Caption = 'Contract Purchase Item';
            Editable = false;
        }
        field(50008; "Commercial"; Boolean) //verifikacija nabavke od strane komercijale
        {
            Caption = 'Commercial';

            trigger OnValidate()
            begin
                "Commercial UserID" := UserId;
            end;
        }
        field(50009; "Accounting"; Boolean) //verifikacija nabavke od strane računovodstva
        {
            Caption = 'Accounting';

            trigger OnValidate()
            begin
                "Accounting UserID" := UserId;
            end;
        }
        field(50010; "Today Date"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50011; "Commercial UserID"; Code[50])
        {
            Caption = 'Commercial UserID';
        }
        field(50012; "Accounting UserID"; Code[50])
        {
            Caption = 'Accounting UserID';
        }
        field(50006; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
        }
        field(50016; "User ID Number"; Code[50])
        {

            Caption = 'User ID Number';

        }
        field(50017; "Sales Header No."; code[20])
        {
            Caption = 'Sales Header No.';
        }
        field(50018; "Purchase Line - Received"; Decimal)
        {
            Caption = 'Purchase Line - Received';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Line"."Quantity Received" where("Document No." = field("No.")));
        }
        field(50019; "KUF"; Code[20])
        {
            Caption = 'KUF';

        }


        modify("Posting Date")
        {
            trigger OnAfterValidate()

            begin
                if Rec."Contract No." <> '' then begin
                    UserSetup.Reset();
                    UserSetup.SetFilter("User ID", '%1', UserId);
                    if UserSetup.FindFirst() then begin
                        if NOT UserSetup."Order From Expired Contract" then begin
                            //datum se provjerava ako korisnik nema dozvolu da kreira narudzbenicu iz ugovora koji je istekao
                            PurchaseContract.Reset();
                            PurchaseContract.SetFilter("Contract Entry No.", '%1', Rec."Contract Entry No.");
                            if PurchaseContract.FindFirst() then begin
                                if (Rec."Posting Date" < PurchaseContract."Contract Start Date") or (Rec."Posting Date" > PurchaseContract."Contract Final Date") then
                                    Error('Narudžbenicu nije moguće kreirati van datuma ugovora.');
                            end;
                        end;
                    end;
                end;
            end;

        }
    }


    trigger OnInsert()
    var
        myInt: Integer;
        P: page "Items by Location";
        PurchaseSetup: Record "Purchases & Payables Setup";
    begin
        "VAT Date" := Today;
        "Language Code" := 'HRV';
        "User ID Number" := UserId;

        if Prepayment = true then begin
            PurchaseSetup.Get();
            "Posting No. Series" := PurchaseSetup."Posted Prepmt. Inv. Nos.";
            if "Document Type" = "Document Type"::"Credit Memo" then
                "Posting Description" := 'Storno avansne fakture ' + Rec."No."
            else
                "Posting Description" := 'Avansna ' + Rec."Posting Description";
        end;


    end;


    trigger OnBeforeInsert()
    begin
        Today := System.Today;
    end;



    var

        myInt: Integer;
        PurchaseContract: Record "Purchase Contract";
        PurchaseLine: Record "Purchase Line";
        Today: Date;
        UserSetup: Record "User Setup";
        ContractScope: Record "Contract Scope";
        LineNoCounter: Integer;
}