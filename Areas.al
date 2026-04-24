pageextension 50137 Areas extends Areas
{
    layout
    {
        modify(Text)
        {
            Visible = false;
        }
        modify(Code) { Visible = false; }
        addafter(Code)
        {
            field(Month; Month) { ApplicationArea = all; }
            field(Year; Year) { ApplicationArea = all; }
            field(Category; Category) { ApplicationArea = all; }
            field("Type of gas"; "Type of gas") { ApplicationArea = all; Visible = false; }

            field(Type; Type) { ApplicationArea = all; }
            field("Internal Customer"; "Internal Customer") { ApplicationArea = all; }
            field("Customer Name"; "Customer Name") { ApplicationArea = all; }
            field("Measuring Point Code"; "Measuring Point Code") { ApplicationArea = all; }
            field("Measuring Point Description"; "Measuring Point Description") { ApplicationArea = all; }
            field("Type of vehicle"; "Type of vehicle") { ApplicationArea = all; }
            field("Type of person"; "Type of person") { ApplicationArea = all; }

            field(Amount; Amount) { ApplicationArea = all; }

        }
    }

    actions
    {



    }


    trigger OnOpenPage()
    begin
        SetCurrentKey(Category, Type, "Type of person", "Type of vehicle", Year, Month);
        Ascending;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetCurrentKey(Category, Type, "Type of person", "Type of vehicle", Year, Month);
        Ascending;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        SetCurrentKey(Year, Month, Category, Type, "Type of person", "Type of vehicle");
        Ascending;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        PomocniInt: Integer;
        AR: Record "Area";
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
        //  Rec.Year := Date2DMY(today);
    end;


}
