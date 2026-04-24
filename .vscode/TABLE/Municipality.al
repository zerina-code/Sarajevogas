table 50006 Municipality
{
    Caption = 'Municipality';
    DrillDownPageID = Municipalities;
    LookupPageID = Municipalities;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';

            trigger OnValidate()
            begin
                "Tax Number" := Code;
                "Short Code" := COPYSTR(Code, 1, 3);
            end;
        }
        field(2; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(3; "Tax Number"; Code[10])
        {
            Caption = 'Tax Number';
        }
        field(4; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(5; "DP Code"; Code[10])
        {
            Caption = 'DP Code';
            TableRelation = Canton;

            trigger OnValidate()
            begin
                Canton.SETFILTER(Code, '%1', "DP Code");
                IF Canton.FIND('-') THEN
                    "DP Name" := Canton.Description
                ELSE
                    "DP Name" := '';
            end;
        }
        field(6; "For Calculation 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(7; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = FILTER('')) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate()
            begin
                PostCode.ValidateCityBirth(City, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
                "Canton Code" := PostCode."Canton Code";
            end;

        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            FieldClass = FlowField;
            CalcFormula = lookup("Post Code"."Country/Region Code" WHERE(City = FIELD(City)));
        }
        field(9; "Entity Code"; Code[10])
        {
            CalcFormula = Lookup(Canton."Entity Code" WHERE(Code = FIELD("DP Code")));
            FieldClass = FlowField;
        }
        field(10; "For Calculation 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(11; "Canton Code"; Code[10])
        {
            CalcFormula = Lookup("Post Code"."Canton Code" WHERE(City = FIELD(City)));
            Caption = 'Canton Code';
            FieldClass = FlowField;
        }
        field(12; "Short Code"; Code[10])
        {
        }
        field(13; "DP Name"; Text[250])
        {
        }
        field(50003; "Operator No."; Code[40])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50004; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(50005; "For Calculation 4"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50006; "For Calculation 5"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50007; "For Calculation 6"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50008; "For Calculation 7"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50009; "For Calculation FA"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50010; "For Calculation FA 2"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50011; "For Calculation FA 3"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50012; "For Calculation 8"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50013; "For Calculation 9"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50014; "For Calculation 10"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50015; "For Calculation 11"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50016; "For Calculation 12"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50017; "For Calculation 13"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50018; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Regular","KO";
            OptionCaption = 'Regular Municipality,Cadastral Municipality';
        }
    }

    keys
    {
        key(Key1; "Code", Type)
        {
        }
        key(Key2; City)
        {
        }
        /* key(Key3; "Country/Region Code")
         {
         }*/
        key(Key4; Name)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    var
        US: Record "User Setup";
    begin
        "Tax Number" := Code;
        "Last Date Modified" := TODAY;
        "Operator No." := USERID;

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if (us."Control Verification" = false) and (us."Wage Allowed" = false) then
                Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

        end;

    end;

    trigger OnModify()
    var
        US: Record "User Setup";
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := USERID;
        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if (us."Control Verification" = false) and (us."Wage Allowed" = false) then
                Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

        end;
    end;

    trigger OnRename()
    var
        US: Record "User Setup";
    begin
        "Tax Number" := Code;

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if (us."Control Verification" = false) and (us."Wage Allowed" = false) then
                Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

        end;
    end;

    trigger OnDelete()
    var
        myInt: Integer;
        US: Record "User Setup";
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if (us."Control Verification" = false) and (us."Wage Allowed" = false) then
                Error('Nemate dozvolu za izvršenje navedene aktivnosti!');

        end;

    end;

    var
        PostCode: Record "Post Code";
        Canton: Record "Canton";

    procedure ValidateMunicipality(MunicipalityCode: Code[20]; var InCity: Text[30]; var InPostCode: Code[20])
    var
        Municipality: Record Municipality;
        PostCodeVar: Record "Post Code";
    begin
        Municipality.Reset();
        Municipality.SetFilter(Code, '%1', MunicipalityCode);
        Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
        if Municipality.FindFirst() then begin
            InCity := Municipality.City;
            PostCodeVar.Reset();
            PostCodeVar.SetFilter(City, '%1', InCity);
            if PostCodeVar.FindFirst() then
                InPostCode := PostCodeVar.Code
            else
                InPostCode := '';
        end
        else begin
            InCity := '';
            InPostCode := '';
        end;
    end;
}

