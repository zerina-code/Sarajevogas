tableextension 50044 Item extends "Item"
{
    //ED
    fields
    {
        // Add changes to table fields here
        field(50001; "Show"; Boolean)
        {
        }
        field(50002; "Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category" where("Code Category Text" = const(1));

            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Category Code");
                if ItemCategoryTable.FindFirst() then
                    "Category Description" := ItemCategoryTable.Description;
            end;
        }
        field(50003; "Category Description"; Text[100])
        {
            Caption = 'Item Category Decription';
        }
        field(50004; "Item Group"; Code[50])
        {
            Caption = 'Item Group';
            TableRelation = "Item Group" where("Code Category Text" = const(1));

            trigger OnValidate()
            begin
                ItemGroupTable.Reset();
                ItemGroupTable.SetFilter("Group Code", '%1', "Item Group");
                if ItemGroupTable.FindFirst() then
                    "Group Description" := ItemGroupTable."Group Description";
            end;
        }
        field(50005; "Group Description"; Text[100])
        {
            Caption = 'Item Group Decription';
        }
        field(50006; "Item Subgroup"; Code[50])
        {
            Caption = 'Item Subgroup';
            TableRelation = ItemSubgroup where("Code Category Text" = const(1));

            trigger OnValidate()
            begin
                ItemSubgroupTable.Reset();
                ItemSubgroupTable.SetFilter("Subgroup Code", '%1', "Item Subgroup");
                if ItemSubgroupTable.FindFirst() then
                    "Subgroup Description" := ItemSubgroupTable."Subgroup Description";
            end;
        }
        field(50007; "Subgroup Description"; Text[130])
        {
            Caption = 'Item Subgroup Decription';
        }
        field(50008; "Entry Finished"; Boolean)
        {
            Caption = 'Entry Finished';
        }
        field(50009; "Old ID"; Code[10])
        {
            Caption = 'Old ID';
        }
        field(50010; InventoryGL; Decimal)
        {
            CalcFormula = Sum("Item Ledger Entry".Quantity WHERE("Item No." = FIELD("No."),
                                                                  "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                  "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                  "Location Code" = FILTER('GLAVNO'),
                                                                  "Drop Shipment" = FIELD("Drop Shipment Filter"),
                                                                  "Variant Code" = FIELD("Variant Filter"),
                                                                  "Lot No." = FIELD("Lot No. Filter"),
                                                                  "Serial No." = FIELD("Serial No. Filter"),
                                                                  "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            TableRelation = Location.Code WHERE(Name = FILTER('GLAVNO'));
            Caption = 'InventoryGL';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50011; "Qty. on Service Order 2"; Decimal)
        {
            CalcFormula = Sum("Service Line"."Outstanding Qty. (Base)" WHERE("Document Type" = CONST(Order),
                                                                              Type = CONST(Item),
                                                                              "No." = FIELD("No."),
                                                                              "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Filter"),
                                                                              "Shortcut Dimension 2 Code" = FIELD("Global Dimension 2 Filter"),
                                                                              "Location Code" = FIELD("Location Filter"),
                                                                              "Variant Code" = FIELD("Variant Filter"),
                                                                              "Needed by Date" = FIELD("Date Filter"),
                                                                              "Needed by Date" = field("Date Filter 2"),
                                                                              "Request Type" = filter(7),
                                                                              "Unit of Measure Code" = FIELD("Unit of Measure Filter")));
            Caption = 'Qty. on Service Order';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;

        }
        field(50012; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    trigger OnInsert()
    var
        InvtSetup: Record "Inventory Setup";
        NoSeriesTable: Record "No. Series";
        UserS: Record "User Setup";

    begin

        validate("Price/Profit Calculation", "Price/Profit Calculation"::"Price=Cost+Profit");
        UserS.Reset();
        UserS.SetFilter("User Id", '%1', UserId);
        if UserS.FindFirst() then begin
            if UserS."Allowed to CI" = false then
                Error(Txt001);

        end
        else begin
            Error(Txt001);
        end;

        NoSeriesTable.Reset(); //brojcana serija
        NoSeriesTable.SetFilter(Code, '%1', "No. Series");
        if NoSeriesTable.FindFirst() then begin //preuzimam klasu, grupu i podgrupu na karticu artikla
            Validate("Item Subgroup", NoSeriesTable."Subgroup Code");
            Validate("Item Group", NoSeriesTable."Group Code");
            Validate("Category Code", NoSeriesTable."Category Code");
            vALIDATE("Costing Method", "Costing Method"::Average);
            Validate("Gen. Prod. Posting Group", NoSeriesTable."Gen. Prod. Posting Group");
            Validate("VAT Prod. Posting Group", NoSeriesTable."VAT Prod. Posting Group");
            Validate("Inventory Posting Group", NoSeriesTable."Inventory Posting Group");


        end;
    end;

    var
        ItemCategoryTable: Record "Item Category";
        ItemGroupTable: Record "Item Group";
        ItemSubgroupTable: Record ItemSubgroup;
        NoSeries: Record "No. Series";
        Txt001: Label 'You do not have permission to create a new Item!';
}