table 50009 "Wage/Reduction Bank Accounts"
{
    Caption = 'Wage/Reduction Bank Accounts';
    DrillDownPageID = "Wage/Reduction bank accounts";
    LookupPageID = "Wage/Reduction bank accounts";

    fields
    {
        field(1; "Bank Code"; Code[10])
        {
            Caption = 'Bank Code';
            TableRelation = "Wage/Reduction Bank";

            trigger OnValidate()
            begin
                //
            end;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            trigger onvalidate()
            var
                myInt: Integer;
            begin
                "Account No" := "No.";

            end;
        }
        field(3; "Account No"; Code[20])
        {
            Caption = 'AccountNo';

            trigger OnValidate()
            begin
                //"No.":="Account No";
            end;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(5; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(6; n; Text[30])
        {
        }


    }


    keys
    {
        key(Key1; "Bank Code", "No.")
        {
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
        WR: Record "Wage/Reduction Bank Accounts";
    begin
        if ("Bank Code" <> '') and ("Account No" <> '') then begin
            WR.Reset();
            WR.SetFilter("Account No", '%1', "Account No");
            WR.SetFilter("Bank Code", '<>%1', "Bank Code");
            if WR.FindFirst() then begin
                Error('Već postoji kreiran račun samo za banku ' + WR."Bank Code");
            end;


        end;


    end;

    trigger OnModify()
    var
        myInt: Integer;
        WR: Record "Wage/Reduction Bank Accounts";
    begin
        if ("Bank Code" <> '') and ("Account No" <> '') then begin
            WR.Reset();
            WR.SetFilter("Account No", '%1', "Account No");
            WR.SetFilter("Bank Code", '<>%1', "Bank Code");
            if WR.FindFirst() then begin
                Error('Već postoji kreiran račun samo za banku ' + WR."Bank Code");
            end;


        end;

    end;



}

