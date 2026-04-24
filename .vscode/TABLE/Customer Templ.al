tableextension 50095 Customer_Template extends "Customer Templ."
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Description 2"; Text[300])

        {
            Caption = 'Description';
        }
        field(50004; "CNG"; Boolean)
        {
            Caption = 'CNG';
        }
        field(50005; "NN"; Boolean)
        {
            Caption = 'NN Customer';
        }
        field(50006; "Entry No."; integer)
        {
            Caption = 'Entry No.';
        }
        field(50007; "Bill Category"; enum "Bill Category ")
        {
            Caption = 'Bill Category';
        }
        field(50008; "No. Series Bill"; code[20])
        {
            Caption = 'No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50009; "Advance GK"; code[20])
        {
            Caption = 'Advance GK';
            TableRelation = "G/L Account" where("Direct Posting" = filter(true));
        }
        field(50010; "Posting No. Series Bill"; code[20])
        {
            Caption = 'Posting No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50011; "Contact Phone"; Text[250])
        {
            Caption = 'Contact Phone';
        }
        field(50012; "Undo Posting No. Series Bill"; code[20])
        {
            Caption = 'Undo Posting No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50013; "Undo No. Series Bill"; code[20])
        {
            Caption = 'Undo No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50014; "Advance No. Series Bill"; code[20])
        {
            Caption = 'Advance No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50015; "Post. Advance No. Series Bill"; code[20])
        {
            Caption = 'Post. Advance No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50016; "Corr. Advance No. Series Bill"; code[20])
        {
            Caption = 'Corr. Advance No. Series Bill';
            TableRelation = "No. Series";
        }
        field(50017; "Corr. Post. Advance No. Series Bill"; code[20])
        {
            Caption = ' Corr.Post. Advance No. Series Bill';
            TableRelation = "No. Series";
        }
    }



    var
        myInt: Integer;




}