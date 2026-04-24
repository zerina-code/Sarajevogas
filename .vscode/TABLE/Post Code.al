tableextension 50050 PostCode extends "Post Code"
{
    fields
    {
        field(50000; "Entity Code"; Code[20])
        {
            Caption = 'Entity Code';
            TableRelation = Entity;
        }

        // Add changes to table fields here
        field(50002; "For Calculation"; Decimal)
        {
            Caption = 'For Calculation';
        }
        field(50003; "Tax Number"; Text[5])
        {
            Caption = 'Tax Number';
        }
        field(50004; "Transport Basis"; Decimal)
        {
            Caption = 'Transport Basis';
        }
        field(50005; "Tax Bank Account"; Text[18])
        {
            Caption = 'Tax Bank Account';
        }
        field(50006; "Tax Authority"; Text[30])
        {
            Caption = 'Tax Authority';
        }
        field(50007; "RS - High Tax Percentage"; Decimal)
        {
            Caption = 'RS - High Tax Percentage';
        }
        field(50008; "Transport Amount"; Decimal)
        {
            Caption = 'Transport Amount';
        }
        field(50009; "Health Check Amount"; Decimal)
        {
            Caption = 'Health Check Amount';
        }
        field(50001; "Canton Code"; Code[10])
        {
            Caption = 'Canton Code';
            TableRelation = Canton;

            trigger OnValidate()
            begin
                Canton.Reset();
                Canton.SetFilter(code, '%1', "Canton Code");
                IF Canton.FindFirst()
                  THEN
                    "Entity Code" := Canton."Entity Code"
                else
                    "Entity Code" := '';
                MODIFY;
            end;
        }
    }

    var
        myInt: Integer;
        Canton: record "Canton";

    procedure ValidateCityBirth(var City: Text[30]; var CountryCode: Code[10]; UseDialog: Boolean)
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
        SearchCity: Code[30];
    begin
        IF NOT GUIALLOWED THEN
            EXIT;

        IF City <> '' THEN BEGIN
            SearchCity := City;
            PostCodeRec.SETCURRENTKEY("Search City");
            IF STRPOS(SearchCity, '*') = STRLEN(SearchCity) THEN
                PostCodeRec.SETFILTER("Search City", SearchCity)
            ELSE
                PostCodeRec.SETRANGE("Search City", SearchCity);
            IF NOT PostCodeRec.FINDFIRST THEN
                EXIT;
            PostCodeRec2.COPY(PostCodeRec);
            IF UseDialog AND (PostCodeRec2.NEXT = 1) THEN
                IF PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) <> ACTION::LookupOK THEN
                    EXIT;
            City := PostCodeRec.City;
            CountryCode := PostCodeRec."Country/Region Code";
        END;
    end;

    procedure ValidateCity1(var City: Text[30]; var PostCode: Code[20]; var CountryCode: Code[10]; UseDialog: Boolean)
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
        SearchCity: Code[30];
    begin
        IF NOT GUIALLOWED THEN
            EXIT;

        IF City <> '' THEN BEGIN
            SearchCity := City;
            PostCodeRec.SETCURRENTKEY("Search City");
            IF STRPOS(SearchCity, '*') = STRLEN(SearchCity) THEN
                PostCodeRec.SETFILTER("Search City", SearchCity)
            ELSE
                PostCodeRec.SETRANGE("Search City", SearchCity);
            IF NOT PostCodeRec.FINDFIRST THEN
                EXIT;
            PostCodeRec2.COPY(PostCodeRec);
            IF UseDialog AND (PostCodeRec2.NEXT = 1) THEN
                IF PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) <> ACTION::LookupOK THEN
                    EXIT;
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
            CountryCode := PostCodeRec."Country/Region Code";
        END;
    end;

    procedure ValidatePostCode1(var City: Text[30]; var PostCode: Code[20]; var CountryCode: Code[10]; UseDialog: Boolean)
    var
        PostCodeRec: Record "Post Code";
        PostCodeRec2: Record "Post Code";
    begin
        IF PostCode <> '' THEN BEGIN
            IF STRPOS(PostCode, '*') = STRLEN(PostCode) THEN
                PostCodeRec.SETFILTER(Code, PostCode)
            ELSE
                PostCodeRec.SETRANGE(Code, PostCode);
            IF NOT PostCodeRec.FINDFIRST THEN
                EXIT;
            PostCodeRec2.COPY(PostCodeRec);
            IF UseDialog AND (PostCodeRec2.NEXT = 1) AND GUIALLOWED THEN
                IF PAGE.RUNMODAL(PAGE::"Post Codes", PostCodeRec, PostCodeRec.Code) <> ACTION::LookupOK THEN
                    EXIT;
            PostCode := PostCodeRec.Code;
            City := PostCodeRec.City;
            CountryCode := PostCodeRec."Country/Region Code";
        END;
    end;
}