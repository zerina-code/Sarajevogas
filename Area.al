tableextension 50087 "Area" extends "Area"
{
    fields
    {

        field(50000; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(50001; "Month"; Enum "Month")
        {
            Caption = 'Month';
        }
        field(50002; "Category"; Enum Category)
        {
            Caption = 'Category';

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Category = Category::CNG then
                    "Type of gas" := "Type of gas"::CNG
                else
                    "Type of gas" := "Type of gas"::"Natural GAS";
            end;
        }
        field(50003; "Type"; Code[20])
        {
            Caption = 'Type';
            TableRelation = Customer where("Customer Category" = field(Category), "Customer Status" = filter(Active));
            trigger OnValidate()
            var
                myInt: Integer;
                Cust: Record customer;
            begin

                cust.Reset();
                cust.SetFilter("No.", '%1', rec.Type);
                if cust.FindFirst() then begin
                    rec."Internal Customer" := cust."Internal Customer";
                    if Cust."Name 2" <> '' then
                        "Customer Name" := Cust.Name + ' ' + Cust."Name 2"
                    else
                        "Customer Name" := cust.Name;
                end;


            end;
        }
        field(50004; "Amount"; Decimal)
        {
            Caption = 'Amount';
        }
        field(50005; "Type of vehicle"; enum "Type of Vehicle")
        {
            Caption = 'Type of vehicle';

        }
        field(50006; "Type of person"; enum "Type of Person")
        {
            Caption = 'Type of person';
        }
        field(50007; "Type of gas"; enum "Type of GAS")
        {
            Caption = 'Type of gas';
        }
        field(50008; "Year"; Integer)
        {
            Caption = 'Year';
        }
        field(50009; "Internal Customer"; Boolean)
        {
            Caption = 'Internal Customer';
        }
        field(50010; "Measuring Point Code"; Code[20])
        {
            Caption = 'Measuring Point Code';
            TableRelation = "Service Item"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
                CustMM: Record "Service Item";
                CustName: Record Customer;

            begin

                CustMM.Reset();
                CustMM.SetFilter("No.", '%1', "Measuring Point Code");
                if CustMM.FindFirst() then begin
                    validate(Type, CustMM."Customer No.");
                    "Measuring Point Description" := CustMM.Description;
                end
                else begin
                    Type := '';
                    "Customer Name" := '';
                end;

            end;
        }
        field(50011; "Measuring Point Description"; Text[250])
        {
            Caption = 'Measuring Point Description';
        }
        field(50012; "Customer Name"; Text[250])
        {
            Caption = 'Customer Name';
        }


    }

    trigger OnModify()
    var
        myInt: Integer;
        ARR: Record "Area";

    begin

        ARR.Reset();
        ARR.SetFilter(Type, '%1', rec.Type);
        ARR.SetFilter("Type of gas", '%1', rec."Type of gas");
        ARR.SetFilter("Type of person", '%1', rec."Type of person");
        ARR.SetFilter("Type of vehicle", '%1', rec."Type of vehicle");
        ARR.SetFilter(Month, '%1', rec.Month);
        ARR.SetFilter(Year, '%1', rec.Year);
        ARR.SetFilter(Category, '%1', rec.Category);
        ARR.SetFilter(Code, '<>%1', rec.Code);
        if ARR.FindFirst() then
            Error(
Text007
);


    end;

    var
        Counter: Integer;
        Customer: Record Customer;
        Text007: Label 'Date already exist for selected date and category!';

    trigger OnInsert()
    var
        PomocniInt: Integer;
        Ar: Record "Area";
        ARR: Record "Area";
    begin
        Ar.Reset();
        Ar.SetCurrentKey(Order);
        Ar.Ascending;
        if Ar.FindLast() then begin
            Rec.Code := FORMAT(Ar.Order + 1);
            rec.Order := Ar.Order + 1;
        end else begin


            rec.Order := 1;
            Rec.Code := format(1);
        end;

        ARR.Reset();
        ARR.SetFilter(Type, '%1', rec.Type);
        ARR.SetFilter("Type of gas", '%1', rec."Type of gas");
        ARR.SetFilter("Type of person", '%1', rec."Type of person");
        ARR.SetFilter("Type of vehicle", '%1', rec."Type of vehicle");
        ARR.SetFilter(Month, '%1', rec.Month);
        ARR.SetFilter(Year, '%1', rec.Year);
        ARR.SetFilter(Category, '%1', rec.Category);
        ARR.SetFilter(Code, '<>%1', rec.Code);
        if ARR.FindFirst() then
            Error(
Text007
);

    end;

    trigger OnAfterInsert()
    var
        PomocniInt: Integer;
        TArea: Record "Area";
    begin
        TArea.reset();
        TArea.SetCurrentKey(Order);
        TArea.Ascending;
        if TArea.FindLast() then begin
            if TArea.Code <> '' then begin
                Evaluate(PomocniInt, TArea.Code);
                PomocniInt += 1;
                TArea.Code := FORMAT(PomocniInt);
            end else
                TArea.Code := format(1);
        end;
        Commit();
    end;
}
