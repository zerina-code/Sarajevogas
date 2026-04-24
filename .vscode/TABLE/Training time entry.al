table 50044 "Training Time Entry"
{
    Caption = 'Evidencija održavanja obuka/edukacija';
    LookupPageId = "Training Time Entries";
    DrillDownPageId = "Training Time Entries";

    fields
    {

        field(1; Code; Integer)
        {
            AutoIncrement = true;
            Caption = 'Code';
            Editable = false;


        }
        field(2; Code2; Integer)
        {
            Caption = 'Training catalogue code';
            TableRelation = "Training Catalogue".Code;



        }
        field(3; Name; Text[250])
        {
            Caption = 'Traning Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Name where(Code = field(Code2)));

        }
        field(4; Type; Option)
        {
            OptionMembers = "-",Interni,Eksterni;
            Editable = false;
            Caption = 'Type';
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Type where(Code = field(Code2)));

        }

        field(5; Location; Code[30])
        {
            Caption = 'Location';
            TableRelation = "Country/Region";
            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                Country.Reset();
                Country.SetFilter(Code, '%1', Location);
                if Country.FindFirst() then begin
                    "Location Name" := Country.Name;
                end else begin
                    "Location Name" := '';
                end;
            end;

        }
        field(6; Month; enum Month)
        {
            Caption = 'Month';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Training Catalogue".Month where(Code = field(Code2)));
        }

        field(8; "Start date"; Date)
        {
            Caption = 'Start date';

        }
        field(9; "End date"; Date)
        {
            Caption = 'End date';
            //var AbsenceFill: Codeunit "Absence Fill";
            trigger OnValidate()
            begin
                if ("End date" < "Start date") then
                    Error('"End date" can not be before "Start date."');






            end;

        }
        field(10; Status; Option)
        {
            OptionMembers = " ","In progress",Finished,"In preparation";
            Caption = 'Status';

        }
        field(11; "Number of people"; Integer)
        {
            Caption = 'Number of planed people';

        }

        field(12; "Travel cost ino"; Decimal)
        {
            Caption = 'Troškovi puta inostranstvo';

        }
        field(13; "Travel cost home"; Decimal)
        {
            Caption = 'Troškovi puta u zemlji';

        }
        field(14; "Daily rate home"; Decimal)
        {

        }
        field(15; "Daily rate ino"; Decimal)
        {

        }
        field(16; "Number of days"; Integer)
        {
            Caption = 'Broj dana';
            Editable = false;

        }
        field(17; "Daily rate home SUM"; Decimal)
        {
            Editable = false;


        }
        field(18; "Daily rate ino SUM"; Decimal)
        {
            Editable = false;

        }
        field(19; "Kotizacija"; Decimal)
        {

        }
        field(20; "Hours"; Integer)
        {

        }
        field(21; "Number of people attended"; Integer)
        {
            Caption = 'Number of people that attended';
            FieldClass = FlowField;
            CalcFormula = count("Employee Training Ledger" where(Code2Entry = field(Code)));
        }
        field(22; TypeOF; code[20])
        {
            Caption = 'Vrsta treninga';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = lookup("Training Catalogue".TypeOF where(Code = field(Code2)));









        }
        field(23; "Type of name"; Text[250])
        {
            Caption = 'Naziv vrste treninga';
            Editable = false;
            FieldClass = FlowField;

            CalcFormula = lookup("Training Catalogue"."Type of name" where(Code = field(Code2)));





        }
        field(24; "Location Name"; Code[30])
        {
            Caption = 'Naziv lokazije';
            TableRelation = "Country/Region";
            Editable = false;


        }



    }
    keys
    {
        key(Key1; Code)
        {
        }
    }

    var
        Catalogue: Record "Training Catalogue";

}