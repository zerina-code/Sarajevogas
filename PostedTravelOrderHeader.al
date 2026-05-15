table 50300 "Posted Travel Order Header"
{
    Caption = 'Proknjiženi putni nalog';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Broj naloga';
        }
        field(2; "Travel Order No."; Code[20])
        {
            Caption = 'Originalni broj naloga';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Zaposlenik';
        }
        field(4; "Departure Date"; Date)
        {
            Caption = 'Datum polaska';
        }
        field(5; "Return Date"; Date)
        {
            Caption = 'Datum povratka';
        }
        field(6; Destination; Text[100])
        {
            Caption = 'Odredište';
        }
        field(7; Purpose; Text[250])
        {
            Caption = 'Svrha putovanja';
        }
        field(8; "Advance Amount"; Decimal)
        {
            Caption = 'Akontacija';
        }
        field(9; "Posted By"; Code[50])
        {
            Caption = 'Proknjižio';
        }
        field(10; "Posted At"; DateTime)
        {
            Caption = 'Datum knjiženja';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(ByOriginal; "Travel Order No.") { }
    }
}