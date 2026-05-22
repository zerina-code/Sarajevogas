table 50030 "Travel Order Header SG"
{
    DataClassification = ToBeClassified;
    Caption = 'Putni nalog - zaglavlje';
    LookupPageId = "Travel Order List SG";
    DrillDownPageId = "Travel Order List SG";
    Permissions = TableData 50030 = rimd;




    fields
    {
        field(1; "No."; integer)
        {
            Caption = 'Broj naloga';
            DataClassification = ToBeClassified;
            editable = true;
            autoincrement = true;

        }


        field(2; "Employee No."; Code[20])
        {
            Caption = 'Šifra zaposlenika';
            tableRelation = Employee."No.";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                NoSeriesMgt: Codeunit NoSeriesManagement;
                WageSetup: Record "Wage Setup";
            begin
                if "No." <> xRec."No." then begin
                    WageSetup.Get();
                    NoSeriesMgt.TestManual(WageSetup."Travel Order Nos.");
                    "No. Series" := '';
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

                if "Departure Date" < Today() then
                    Error('Datum polaska ne može biti u prošlosti.');

                ValidateDates();
                CalculatePerDiem();
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
                CalculatePerDiem();
            end;
        }

        field(7; "Departure Time"; Time)
        {
            Caption = 'Vrijeme polaska';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
                CalculatePerDiem();
            end;
        }

        field(8; "Return Time"; Time)
        {
            Caption = 'Vrijeme dolaska';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
                CalculatePerDiem();
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

                if StrLen(Purpose) < 10 then
                    Error('Svrha putovanja mora imati najmanje 10 karaktera.');
            end;
        }

        field(11; "Transport Type"; Option)
        {
            Caption = 'Vrsta prijevoza';
            DataClassification = ToBeClassified;
            OptionMembers = Sluzbeno,Privatno;
            OptionCaption = 'Službeno, Privatno';
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
                CalculatePerDiem();
            end;
        }

        field(23; "Travel Status"; Enum "Travel Order Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
        }

        field(24; "Destination City"; Text[100])
        {
            Caption = 'Odredište grad';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(25; "Post Code"; Code[20])
        {
            Caption = 'Poštanski broj';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(26; "Address"; Text[250])
        {
            Caption = 'Adresa';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(27; "Vehicle No."; Code[20])
        {
            Caption = 'Vozilo';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(28; "Start Mileage"; Integer)
        {
            Caption = 'Početni kilometri';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(29; "End Mileage"; Integer)
        {
            Caption = 'Krajnji kilometri';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();

                if ("End Mileage" <> 0) and ("Start Mileage" <> 0) then
                    if "End Mileage" < "Start Mileage" then
                        Error('Krajnji kilometri ne mogu biti manji od početnih kilometara.');
            end;
        }

        field(30; "Authorized Person"; Code[50])
        {
            Caption = 'Ovlašteno lice';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(31; "Order Issuer"; Code[50])
        {
            Caption = 'Nalogodavac';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                CheckEditAllowed();
            end;
        }

        field(32; "Duration Minutes"; Integer)
        {
            Caption = 'Trajanje (minuti)';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(33; "Duration Text"; Text[100])
        {
            Caption = 'Trajanje';
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(34; "Per Diem Type"; Option)
        {
            Caption = 'Tip dnevnice';
            Editable = false;
            DataClassification = ToBeClassified;
            OptionMembers = None,"Half","Full","Multiple Full";
            OptionCaption = 'Nema,Polovična,Puna,Više puna';
        }

        field(35; "Per Diem Base Amount"; Decimal)
        {
            Caption = 'Osnovna dnevnica (BAM)';
            Editable = false;
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }

        field(36; "Per Diem Amount"; Decimal)
        {
            Caption = 'Dnevnica (BAM)';
            Editable = false;
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
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
        WageSetup: Record "Wage Setup";
    begin





        "Travel Status" := "Travel Status"::Open;
        Status := Status::Open;
        "Created By" := CopyStr(UserId(), 1, MaxStrLen("Created By"));
        "Created Date" := Today();
    end;

    trigger OnModify()
    begin
        CheckEditAllowed();
        CheckEditable();
    end;

    trigger OnDelete()
    begin
        CheckEditAllowed();
    end;

    var
        AdvanceNegativeErr: Label 'Akontacija ne može biti negativna.';
        EditNotAllowedErr: Label 'Putni nalog %1 se ne može mijenjati u statusu %2.', Comment = '%1=Broj naloga, %2=Status';

    local procedure CheckEditable()
    begin
        if not ("Travel Status" in ["Travel Status"::Open, "Travel Status"::Approved]) then
            Error('Nalog nije moguće uređivati u statusu %1.', "Travel Status");
    end;

    local procedure CheckEditAllowed()
    begin
        if Status in [
            Status::"ClosedPosted",
            Status::"ClosedCancelled",
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

    local procedure CalculatePerDiem()
    var
        TravelOrderMgt: Codeunit "Travel Order Mgt. SG";
    begin
        TravelOrderMgt.CalculatePerDiem(Rec);
    end;
}