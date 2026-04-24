tableextension 50061 SalesInvoiceHeaderExtends extends "Sales Invoice Header"
{
    fields
    {
        //    VAT Base (retro.)
        field(50006; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }
        field(70249; "Employee Prepare Responsible"; Code[20])
        {
            Caption = 'Employee Prepare Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70250; "Employee Control Responsible"; Code[20])
        {
            Caption = 'Employee Control Responsible', Comment = 'Odgovorni zaposlenik';
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(70212; "RN Source"; enum "RN Source")
        {
            Caption = 'RN Source';
        }

        field(50102; "CZK Request"; code[20])
        {
            Caption = 'CZK Request';
        }
        field(50103; "CZK Credit Memo"; boolean)
        {
            caption = 'CZK Credit Memo';
        }



        //Fiscal DateTime

        field(50066; "Fiscal DateTime"; DateTime)
        {
            Caption = 'Fiscal DateTime';
            DataClassification = ToBeClassified;

        }

        field(50068; "Fiscal User"; COde[250])
        {
            Caption = 'Fiscal User';
            DataClassification = ToBeClassified;

        }
        field(50100; "Billing Credit Memo"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Billing Credit Memo';

        }
        field(50101; "Billing Created"; Boolean)
        {
            Caption = 'Billing Created';
        }

        field(50067; "Fiscal No."; COde[20])
        {
            Caption = 'Fiscal No.';
            DataClassification = ToBeClassified;

        }




        field(50008; Prepayment; Boolean)
        {
            Caption = 'Prepayment';
            Description = 'BH1.01';
        }
        field(50025; "Total Packaging"; Text[250])
        {
            Caption = 'Total Packaging';
            Description = 'BH1.01';
        }
        field(50026; "Total Value Letters"; Text[250])
        {
            Caption = 'Total Value Letters';
            Description = 'BH1.01';
        }
        field(50027; "Country of Origin"; Code[20])
        {
            Caption = 'Country of Origin';
            Description = 'BH1.01';
            TableRelation = "Country/Region";
        }
        field(50028; "Note 1"; Text[250])
        {
            Caption = 'Note 1';
            Description = 'BH1.01';
        }
        field(50029; "Note 2"; Text[250])
        {
            Caption = 'Note 2';
            Description = 'BH1.01';
        }
        field(50030; "Note 3"; Text[250])
        {
            Caption = 'Note 3';
            Description = 'BH1.01';
        }
        field(828; "Internal Customer"; Boolean)
        {
            Caption = 'Internal Customer';
        }

        field(50032; "Contract Number"; Text[1000])
        {
            Caption = 'Contract Number';
        }
        field(50034; "Order person"; Text[1000])
        {
            Caption = 'Order person';
        }
        field(50035; "Responsible Person"; Text[1000])
        {
            Caption = 'Responsible Person';

        }
        field(50036; "Designer"; Text[1000])
        {
            Caption = 'Designer';
        }
        field(50037; "Project manager"; Text[1000])
        {
            Caption = 'Project manager';
        }

        field(50031; "Orderer"; text[1000])
        {
            Caption = 'Orderer';
        }

        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.';
        }

        field(50015; "Due Date 2"; Date)
        {
            Caption = 'Due Date 2';
        }
        field(50016; "Due Date 3"; Date)
        {
            Caption = 'Due Date';
        }
        field(50017; "Payment Terms Code 2"; Code[10])
        {
            Caption = 'Payment Terms Code 2';
            TableRelation = "Payment Terms";
        }
        field(50020; "Document Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Payment Terms Code 3"; Code[10])
        {
            Caption = 'Payment Terms Code 3';
            TableRelation = "Payment Terms";
        }
        field(50033; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50049; "Payment Type Invoice"; Code[10]) //ED
        {
            Caption = 'Payment Type Invoice';
        }

        field(50050; "Bill type"; Code[20]) //ED
        {
            Caption = 'Bill Type';
            TableRelation = "Customer Templ.";
        }
        field(50089; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }

        field(50062; "New Price"; Decimal)
        {
            Caption = 'New Price';

            trigger OnValidate()
            var
                myInt: Integer;
                SalesL: Record "Sales Line";
            begin




            end;


        }

        field(50065; "Fiscal printed"; Boolean)
        {
            Caption = 'Fiscal printed';
        }

        field(50063; "Old Price Date"; Date)
        {
            Caption = 'Old Price Date';


        }


        field(50061; "Payment Reference 2"; Text[50])
        {
            Caption = 'Payment Reference';
        }

        field(50080; "Repost"; Boolean)
        {
            Caption = 'Repost';
        }
        field(5081; "Quantity"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            CalcFormula = Sum("Sales Invoice Line".Quantity WHERE("Document No." = FIELD("No.")));
            Caption = 'Quantity';
            Editable = false;
            FieldClass = FlowField;
        }

        field(50069; "Document No_"; COde[22])
        {
            Caption = 'Document No_';
            DataClassification = ToBeClassified;

        }
        field(50070; "Subsidies"; Boolean)
        {
            Caption = 'Subsidies - yes';
        }
        field(50071; "Subsidies Amount"; Decimal)
        {
            Caption = 'Subsidies Amount';
        }

        field(50072; "Subsidies Line"; Integer)
        {
            Caption = 'Subsidies Line';
            FieldClass = FlowField;
            CalcFormula = count("Sales Invoice Line" where("Document No." = field("No."), Subsidies = filter(false)));
        }
        field(50073; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }

        field(50074; "Invoice Responsible Person"; Text[250])
        {
            Caption = 'Invoice Responsible Person';
        }
        field(50075; "Invoice Responsible Code"; Code[20])
        {
            Caption = 'Invoice Responsible Code';
        }
        field(50076; "Invoice Position Descr"; Text[250])
        {
            Caption = 'Invoice Position Descr';
        }
        field(50077; "KIF_Entry"; Code[20])

        {
            Caption = 'KIF Entry';
        }
        field(50099; "Customer Category"; enum Category)
        {
            DataClassification = ToBeClassified;


        }



    }
}