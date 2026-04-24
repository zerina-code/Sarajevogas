/*table 50149 Documents
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';

        }
        field(2; "ID document"; Integer)
        {
            AutoIncrement = true;

        }
        field(3; "Attachment No"; Integer)
        {
            Caption = 'Attachment No';

        }
        field(4; "Print Confirmation"; Boolean)
        {
            Caption = 'Print Confirmation';

        }
        field(5; "Document Name"; Text[500])
        {
            Caption = 'Document Name';
        }
        field(6; "CR"; Boolean)
        {
            Caption = 'CR';
        }
        field(7; ID_New; Integer)
        {

        }

    }

    keys
    {
        key(PK; "Document No", "ID document", ID_New)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        myInt: Integer;
        Documentt: Record Documents;
    begin
        Documentt.Reset();
        if Documentt.FindFirst() then
            ID_New := Documentt.Count + 1
        else
            ID_New := 1;

    end;

}
*/