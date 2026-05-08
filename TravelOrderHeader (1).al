table 50030 "Travel Order Header SG"
{
    DataClassification = ToBeClassified;
    Caption = 'Putni nalog - zaglavlje';
    LookupPageId = "Travel Order List SG";
    DrillDownPageId = "Travel Order List SG";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Broj naloga';
            NotBlank = true;
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Šifra zaposlenika';
            NotBlank = true;
            DataClassification = ToBeClassified;
            // Bez TableRelation - ne diramo postojeću BC Employee tabelu
            // Validacija postojanja zaposlenika radi se ručno u OnValidate

            trigger OnValidate()
            var
                EmployeeRec: Record Employee;
            begin
                CheckEditAllowed();
                if "Employee No." <> '' then begin
                    if EmployeeRec.Get("Employee No.") then begin
                        "Employee Full Name" := EmployeeRec."First Name" + ' ' + EmployeeRec."Last Name";
                        "Employee Job Title" := EmployeeRec."Job Title";
                    end else begin
                        Error('Zaposlenik sa šifrom %1 ne postoji u sistemu.', "Employee No.");
                    end;
                end else begin
                    "Employee Full Name" := '';
                    "Employee Job Title" := '';
                end;
            end;
        }
        field(3; "Employee Full Name"; Text[100])
        {
            Caption = 'Ime i prezime zaposlenika';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "Employee Job Title"; Text[100])
        {
            Caption = 'Radno mjesto zaposlenika';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Departure Date"; Date)
        {
            Caption = 'Datum polaska';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
                ValidateDates();
            end;
        }
        field(6; "Return Date"; Date)
        {
            Caption = 'Datum dolaska';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
                ValidateDates();
            end;
        }
        field(7; "Departure Time"; Time)
        {
            Caption = 'Vrijeme polaska';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(8; "Return Time"; Time)
        {
            Caption = 'Vrijeme dolaska';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(9; "Destination"; Text[250])
        {
            Caption = 'Odredište';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(10; "Purpose"; Text[500])
        {
            Caption = 'Svrha putovanja';
            NotBlank = true;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(11; "Transport Type"; Text[100])
        {
            Caption = 'Vrsta prijevoza';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(12; "Advance Amount"; Decimal)
        {
            Caption = 'Akontacija';
            MinValue = 0;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
                if "Advance Amount" < 0 then
                    Error(AdvanceNegativeErr);
            end;
        }
        field(13; "Currency Code"; Code[10])
        {
            Caption = 'Valuta';
            DataClassification = ToBeClassified;
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(14; "Status"; Enum "Travel Order Status SG")
        {
            Caption = 'Status';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(15; "Created By"; Code[50])
        {
            Caption = 'Kreirao';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(16; "Created Date"; Date)
        {
            Caption = 'Datum kreiranja';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(17; "Approved By"; Code[50])
        {
            Caption = 'Odobrio';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(18; "Approved Date"; Date)
        {
            Caption = 'Datum odobrenja';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(19; "Cost Center Code"; Code[20])
        {
            Caption = 'Troškovno mjesto';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(20; "Description"; Text[500])
        {
            Caption = 'Napomena';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }
        field(21; "No. Series"; Code[20])
        {
            Caption = 'Serija brojeva';
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(22; "Country Code"; Code[10])
        {
            Caption = 'Zemlja putovanja';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(23; "Travel Status"; Enum "Travel Order Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(K2; "Employee No.", "Departure Date")
        {
        }
        key(K3; "Status")
        {
        }
    }

    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TravelOrderSetup: Record "Travel Order Setup SG";
    begin
        if "No." = '' then begin
            TravelOrderSetup.Get();
            TravelOrderSetup.TestField("Travel Order Nos.");
            NoSeriesMgt.InitSeries(
                TravelOrderSetup."Travel Order Nos.",
                xRec."No. Series",
                0D,
                "No.",
                "No. Series"
            );
        end;
        Status := Status::Open;
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created Date" := Today();
    end;

    trigger OnModify()
    begin
        CheckEditAllowed();
    end;

    trigger OnDelete()
    begin
        CheckEditAllowed();
    end;

    var
        AdvanceNegativeErr: Label 'Akontacija ne može biti negativna.';
        EditNotAllowedErr: Label 'Putni nalog %1 se ne može mijenjati u statusu %2.', Comment = '%1=Broj naloga, %2=Status';

    local procedure CheckEditAllowed()
    begin
        if Status in [
            Status::"Closed Posted",
            Status::"Closed Cancelled",
            Status::Cancelled,
            Status::Closed
        ] then
            Error(EditNotAllowedErr, "No.", Format(Status));
    end;

    local procedure ValidateDates()
    begin
        if ("Departure Date" <> 0D) and ("Return Date" <> 0D) then
            if "Departure Date" > "Return Date" then
                Error('Datum polaska mora biti prije datuma dolaska.');
    end;

    procedure IsEditable(): Boolean
    begin
        exit(Status in [Status::Open, Status::Approved]);
    end;
}
