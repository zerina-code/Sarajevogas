table 50033 "Training Catalogue"
{
    Caption = 'Katalog treninga';
    LookupPageId = "Trainings Catalogue";
    DrillDownPageId = "Trainings Catalogue";

    fields
    {
        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';
            Editable = false;

        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';

        }
        field(3; Type; Option)
        {
            OptionMembers = "-",Interni,Eksterni;
            Caption = 'Type';

        }

        field(5; Month; enum Month)
        {
            Caption = 'Month';
        }


        field(6; TypeOF; Code[20])
        {
            Caption = 'Vrsta Treninga';
            TableRelation = "Training Type";




        }

        field(7; Year; Integer)
        {
            Caption = 'Godina';
        }
        field(8; "Type of name"; text[250])
        {
            Caption = 'Naziv vrste treninga';
            // FieldClass = FlowField;
            //   CalcFormula = lookup("Training Type".Description where(Code = field(TypeOF)));
            Editable = false;
            TableRelation = "Training Type";

        }


    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

}