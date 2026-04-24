table 50144 "Customer ID"
{
    Caption = 'Customer ID';
    DrillDownPageId = "Customer ID";
    LookupPageId = "Customer ID";

    fields
    {
        field(1; "ID"; Integer)
        {
            Caption = 'ID';
            AutoIncrement = true;
        }
        field(2; Code; Code[30])
        {
            Caption = 'Code';
        }
        field(3; "Identity card issuer"; text[250])
        {
            Caption = 'Identity card issuer';
        }
        field(4; "Date From"; Date)
        {
            Caption = 'Date From';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Date To" <> 0D THEN BEGIN
                    IF "Date From" = 0D THEN
                        ERROR(Text000);
                    IF "Date To" < "Date From" THEN
                        ERROR(Text001);
                END;

                if ("Date From" <= Today) and (("Date To" >= Today) or ("Date To" = 0D)) then begin
                    Active := true

                end
                else begin
                    Active := false;
                end;

                //amir: ovaj kod je zakomentiran na zahtjev korisnika
                /*CustomerID.Reset();
                CustomerID.SetFilter(ID, '<>%1', Rec.ID);
                CustomerID.SetFilter("Customer No.", '%1', Rec."Customer No.");
                //đK CustomerID.SetFilter("Date From",'<>%1',0D);
                CustomerID.SetCurrentKey("Date From");
                CustomerID.Ascending;
                if CustomerID.FindLast() then begin
                    if (CustomerID."Date To" = 0D) and (CustomerID."Date From" <> 0D) then begin
                        CustomerID."Date To" := CalcDate('<-1D>', Rec."Date From");
                        if (CustomerID."Date From" <= Today) and ((CustomerID."Date To" >= Today) or (CustomerID."Date To" = 0D)) then begin
                            CustomerID.Active := true
                        end
                        else begin
                            CustomerID.Active := false;
                        end;
                        CustomerID.Modify();
                    end;
                end;*/
            end;
        }
        field(5; "Date To"; Date)
        {
            Caption = 'Date To';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Date To" <> 0D THEN BEGIN
                    IF "Date From" = 0D THEN
                        ERROR(Text000);
                    IF "Date To" < "Date From" THEN
                        ERROR(Text001);
                END;

                if ("Date From" <= Today) and (("Date To" >= Today) or ("Date To" = 0D)) then begin
                    Active := true
                end
                else begin
                    Active := false;
                end;

                //amir: ovaj kod je zakomentiran na zahtjev korisnika Issue: SH-94
                /*CustomerID.Reset();
                CustomerID.SetFilter(ID, '<>%1', Rec.ID);
                CustomerID.SetFilter("Customer No.", '%1', Rec."Customer No.");
                //đK CustomerID.SetFilter("Date From",'<>%1',0D);
                CustomerID.SetCurrentKey("Date From");
                CustomerID.Ascending;
                if CustomerID.FindLast() then begin
                    if (CustomerID."Date To" = 0D) and (CustomerID."Date From" <> 0D) then begin
                        CustomerID."Date To" := CalcDate('<-1D>', Rec."Date From");
                        if (CustomerID."Date From" <= Today) and ((CustomerID."Date To" >= Today) or (CustomerID."Date To" = 0D)) then begin
                            CustomerID.Active := true
                        end
                        else begin
                            CustomerID.Active := false;
                        end;
                        CustomerID.Modify();
                    end;
                end;*/
            end;
        }
        field(6; "Active"; Boolean)
        {
            Caption = 'Active';
        }
        field(7; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            trigger OnValidate()
            var
                myInt: Integer;
                CUstF: Record Customer;
            begin
                CUstF.reset;
                CUstF.SetFilter("No.", '%1', rec."Customer No.");
                if CUstF.FindFirst() then begin
                    if CUstF."Name 2" <> '' then
                        "Customer Name" := CUstF.Name + ' ' + CUstF."Name 2"
                    else
                        "Customer Name" := CUstF.Name;
                end
                else begin
                    "Customer Name" := '';
                end;
            end;
        }
        field(8; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
            // FieldClass = FlowField;
            // CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(9; "Type"; Option)
        {
            OptionCaption = ' ,Permanent,Temporery';
            OptionMembers = ,Permanent,Temporery;
        }
    }




    keys
    {
        key(Key1; ID, Code, "Customer No.")
        {
        }

    }

    trigger OnInsert()
    var
        myInt: Integer;
        CUstF: Record Customer;
    begin

        CUstF.reset;
        CUstF.SetFilter("No.", '%1', rec."Customer No.");
        if CUstF.FindFirst() then begin
            if CUstF."Name 2" <> '' then
                "Customer Name" := CUstF.Name + ' ' + CUstF."Name 2"
            else
                "Customer Name" := CUstF.Name;
        end
        else begin
            "Customer Name" := '';
        end;
    end;


    var
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
        CustomerID: Record "Customer ID";


}

