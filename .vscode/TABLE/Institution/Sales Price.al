tableextension 50080 SalesPrice extends "Sales Price"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Maintenance Resource No."; code[20])
        {
            Caption = 'Maintenance Resource No.';
            TableRelation = Resource."No.";
        }
        field(50001; "Unit price of distribution"; Decimal)
        {
            Caption = 'Unit price of distribution';
            AutoFormatType = 2;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Unit Price" := "Unit price of distribution" + "Purchase unit price";


            end;
        }
        field(50002; "Purchase unit price"; Decimal)
        {
            Caption = 'Purchase unit price';
            AutoFormatType = 2;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Unit Price" := "Unit price of distribution" + "Purchase unit price";

            end;
        }
        field(50003; "Retail Unit Price"; Decimal)
        {
            Caption = 'Retail Unit Price';
            AutoFormatType = 2;

        }

        field(50004; "Wholesale Unit Price"; Decimal)
        {
            Caption = 'Wholesale Unit Price';
            AutoFormatType = 2;

        }
        field(50007; "Price not by Gauge"; Boolean)
        {
            Caption = 'Price not by Gauge';
        }

    }
    trigger OnModify()
    var
        myInt: Integer;
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    trigger OnInsert()
    var
        myInt: Integer;
    begin

        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
        if control = false then
            Error('Nemate dozvolu da modifikujete ovu karticu.');
    end;

    var
        myInt: Integer;
        us: Record "User Setup";
        Control: Boolean;
}