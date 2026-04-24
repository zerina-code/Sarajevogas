/*table 50140 "KIF/KUF Log"
{
    Caption = 'Work Type';
    DrillDownPageID = "KIF KUF Logs";
    LookupPageID = "KIF KUF Logs";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Unit of Measure";
        }
        field(4; Year; Integer)
        {
            Caption = 'Year';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,KIF,KUF';
            OptionMembers = " ",KIF,KUF;
        }
        field(6; "Number No. from"; Integer)
        {
            Caption = 'Number No.';
        }
        field(7; Month; Integer)
        {
            Caption = 'Month';
        }
        field(8; "Number No. to"; Integer)
        {
            Caption = 'Number No.';
        }
    }

    keys
    {
        key(Key1; "Code", Type, Description, Year, Month)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description, "Unit of Measure Code")
        {
        }
    }

    trigger OnInsert()
    begin
        ERROR('Ne možete ručno unositi podatke!');
    end;

    trigger OnModify()
    begin

        WorkType.RESET;
        WorkType.SETFILTER(Type, '%1', Type);
        WorkType.SETFILTER(Description, '%1', Description);
        WorkType.SETCURRENTKEY(Year, Month);
        WorkType.ASCENDING;
        IF WorkType.FINDLAST THEN BEGIN

            IF (Rec.Year <> WorkType.Year) OR (Rec.Month <> WorkType.Month) THEN
                ERROR('Ne možete ažurirati prethodne podatke!');
        END;
    end;

    trigger OnRename()
    begin
        ERROR('Ne možete ručno ažurirati podatke!');
    end;

    var
        WorkType: Record "KIF/KUF Log";
}

*/