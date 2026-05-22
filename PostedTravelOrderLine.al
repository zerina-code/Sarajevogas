
table 50013 "Posted Travel Order Line"
{
    Caption = 'Proknjižene linije putnog naloga';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posted Order No."; Code[20])
        {
            Caption = 'Broj proknjiženog naloga';
            TableRelation = "Posted Travel Order Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Redni broj';
        }
        field(3; "Country Code"; Code[10])
        {
            Caption = 'Država (ISO)';
        }
        field(4; "Entry DateTime"; DateTime)
        {
            Caption = 'Datum i vrijeme ulaska';
        }
        field(5; "Exit DateTime"; DateTime)
        {
            Caption = 'Datum i vrijeme izlaska';
        }
        field(6; "Duration Hours"; Decimal)
        {
            Caption = 'Trajanje (sati)';
        }
        field(7; "Per Diem Amount"; Decimal)
        {
            Caption = 'Iznos dnevnice';
        }
        field(8; "Per Diem Amount BAM"; Decimal)
        {
            Caption = 'Iznos dnevnice (BAM)';
        }
        field(9; "Correction Type"; Option)
        {
            Caption = 'Tip korekcije';
            OptionMembers = " ","Ishrana","Smještaj i ishrana","Bez smještaja";
            OptionCaption = ' ,Ishrana,Smještaj i ishrana,Bez smještaja';
        }
    }

    keys
    {
        key(PK; "Posted Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}