tableextension 50077 VendorExtented extends Vendor
{
    //ED

    fields
    {

        field(50034; "Prepayment (LCY)"; Decimal)
        {
            Caption = 'Prepayment (LCY)';
            FieldClass = FlowField;
            CalcFormula = - sum("Detailed Vendor Ledg. Entry"."Amount (LCY)" where("Vendor No." = field("No."), "Initial Entry Global Dim. 1"
              = field("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2" = field("Global Dimension 2 Filter"),
              "Currency Code" = field("Currency Filter"), Prepayment = FILTER(true)));
        }
        field(50020; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(50021; "Vendor Category"; Code[50])
        {
            Caption = 'Vendor Category';
            TableRelation = "Item Category" where("Code Category Text" = const(2));

            trigger OnValidate()
            begin
                ItemCategoryTable.Reset();
                ItemCategoryTable.SetFilter(Code, '%1', "Vendor Category");
                ItemCategoryTable.SetFilter("Code Category Text", '%1', 2);
                if ItemCategoryTable.FindFirst() then
                    "Vendor Category Description" := ItemCategoryTable.Description;
            end;

        }
        field(50022; "Vendor Group"; Code[50])
        {
            Caption = 'Vendor Group';
            TableRelation = "Item Group" where("Code Category Text" = const(2));

            trigger OnValidate()
            begin
                ItemGroupTable.Reset();
                ItemGroupTable.SetFilter("Group Code", '%1', "Vendor Group");
                ItemGroupTable.SetFilter("Code Category Text", '%1', 2);
                if ItemGroupTable.FindFirst() then
                    "Vendor Group Description" := ItemGroupTable."Group Description";
            end;
        }
        field(50023; "Vendor Subgroup"; Code[50])
        {
            Caption = 'Vendor Subgroup';
            TableRelation = ItemSubgroup where("Code Category Text" = const(2));

            trigger OnValidate()
            begin
                ItemSubgroupTable.Reset();
                ItemSubgroupTable.SetFilter("Subgroup Code", '%1', "Vendor Subgroup");
                ItemSubgroupTable.SetFilter("Code Category Text", '%1', 2);
                if ItemSubgroupTable.FindFirst() then
                    "Vendor Subgroup Description" := ItemSubgroupTable."Subgroup Description";
            end;
        }
        field(50024; "Industrial Classification"; Text[20])
        {
            Caption = 'Industrial Classification';
        }
        field(50025; "Tax No."; Text[20])
        {
            Caption = 'Tax No.';
        }
        field(50026; "Old No."; Integer)
        {
            Caption = 'Old No.';
        }
        field(50027; "Vendor Category Description"; Text[100])
        {
            Caption = 'Vendor Category Decription';
        }
        field(50028; "Vendor Group Description"; Text[100])
        {
            Caption = 'Vendor Group Decription';
        }
        field(50029; "Vendor Subgroup Description"; Text[100])
        {
            Caption = 'Vendor Subgroup Decription';
        }
        field(50030; "Entry Finished"; Boolean)
        {
            Caption = 'Entry Finished';
        }
        field(50031; "Old ID"; Code[20])
        {
            Caption = 'Old ID Number';
        }
        field(50032; "Grade"; integer)
        {
            Caption = 'Grade';
        }
        field(50033; "Industrial classification 2"; Code[20])
        {
            Caption = 'Industrial classification 2';
        }

        field(50005; "Entity Code"; Code[2048])
        {

            DataClassification = ToBeClassified;
            TableRelation = Entity;
        }

    }

    trigger OnInsert()
    var
        InvtSetup: Record "Inventory Setup";
        NoSeriesTable: Record "No. Series";
    begin
        NoSeriesTable.Reset(); //brojcana serija
        NoSeriesTable.SetFilter(Code, '%1', "No. Series");
        if NoSeriesTable.FindFirst() then begin //preuzimam klasu, grupu i podgrupu na karticu dobavljača
            Validate("Vendor Subgroup", NoSeriesTable."Subgroup Code");
            Validate("Vendor Group", NoSeriesTable."Group Code");
            Validate("Vendor Category", NoSeriesTable."Category Code");
        end;
    end;

    var
        ItemSubgroupTable: Record ItemSubgroup;
        ItemCategoryTable: Record "Item Category";
        ItemGroupTable: Record "Item Group";
}