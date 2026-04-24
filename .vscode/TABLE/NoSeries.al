tableextension 50049 NoSeries extends "No. Series"
{

    //ED 

    fields
    {
        // Add changes to table fields here
        field(50001; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            TableRelation = "Item Category" where("Code Category Text" = field("Code Category Text"));

            trigger OnValidate()
            begin
                ItemCategory.Reset();
                ItemCategory.SetFilter(Code, '%1', "Category Code");
                ItemCategory.SetFilter("Code Category Text", '%1', "Code Category Text");
                if ItemCategory.FindFirst() then
                    "Category Name" := ItemCategory.Description; //preuzimam naziv klase
            end;
        }
        field(50002; "Group Code"; Code[20])
        {
            Caption = 'Group Code';
            TableRelation = "Item Group" where("Code Category Text" = field("Code Category Text"));

            trigger OnValidate()
            begin
                ItemGroupTable.Reset();
                ItemGroupTable.SetFilter("Group Code", '%1', "Group Code");
                ItemGroupTable.SetFilter("Code Category Text", '%1', "Code Category Text");
                if ItemGroupTable.FindFirst() then begin
                    "Group Name" := ItemGroupTable."Group Description"; //preuzimam naziv grupe
                    Validate("Category Code", ItemGroupTable."Category Code"); //preuzimam šifru klase koja je povezana u sifarniku
                end;
            end;
        }
        field(50003; "Subgroup Code"; Code[20])
        {
            Caption = 'Subgroup Code';
            TableRelation = ItemSubgroup where("Code Category Text" = field("Code Category Text"));

            trigger OnValidate()
            begin
                ItemSubgroup.Reset();
                ItemSubgroup.SetFilter("Subgroup Code", '%1', "Subgroup Code");
                ItemSubgroup.SetFilter("Code Category Text", '%1', "Code Category Text");
                if ItemSubgroup.FindFirst() then begin
                    "Subgroup Name" := ItemSubgroup."Subgroup Description"; //preuzimam naziv podgrupe
                    Validate("Group Code", ItemSubgroup."Group Code"); //preuzimam šifru grupe koja je povezana u sifarniku
                end;
            end;
        }
        field(50004; "Category Name"; Text[100])
        {
            Caption = 'Category Name';
        }
        field(50005; "Group Name"; Text[100])
        {
            Caption = 'Group Name';
        }
        field(50006; "Subgroup Name"; Text[100])
        {
            Caption = 'Subgroup Name';
        }
        field(50007; "Code Category Text"; Option)
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga,Osnovno sredstvo,Kupac';
            OptionMembers = " ",Artikal,Dobavljač,Usluga,OS,Kupac;
        }
        //R        
        field(50008; "Gen. Prod. Posting Group"; Text[100])
        {
            Caption = 'Gen. Prod. Posting Group';
        }
        field(50009; "VAT Prod. Posting Group"; Text[100])
        {
            Caption = 'VAT Prod. Posting Group';
        }
        field(50010; "Inventory Posting Group"; Text[100])
        {
            Caption = 'Inventory Posting Group';
        }
        //Rž

        field(50011; "Cust. Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Cust. Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }

        field(50012; "Cust. VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'Cust. VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(50013; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(50014; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group';
            TableRelation = "Customer Price Group";
        }
        field(50015; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }

        field(50016; "Type Relation"; enum "Contact Business Relation Link To Table")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type Relation';


        }



    }

    trigger OnDelete()
    var
        myInt: Integer;
    begin

        if UserId <> 'SARAJEVOGAS\TENEO' then begin

            Error('Nije vam dozvoljeno brisati brojčanu seriju!');
        end;

    end;


    var
        ItemSubgroup: Record ItemSubgroup;
        ItemGroupTable: Record "Item Group";
        ItemCategory: Record "Item Category";
}
