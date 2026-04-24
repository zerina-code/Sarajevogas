/*table 50122 "Personal Records"
{
    Caption = 'Personal Records';
    DrillDownPageID = 99000807;
    LookupPageID = 99000807;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                IF "Employee No." <> '' THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        "Employee Name" := Employee."First Name" + ' ' + Employee."Last Name";
                        "Employee ID" := Employee."Employee ID";
                        Gender := Employee.Gender;
                        "Birth Date" := Employee."Birth Date";
                        "Country/Region Code of Birth" := Employee."Country/Region Code of Birth";
                        VALIDATE("City of Birth", Employee."City of Birth");
                        "Employment Date" := Employee."Employment Date";
                        "Professional Exam. Result" := Employee."Professional Exam. Result";
                    END;
                END
                ELSE BEGIN
                    "Employee Name" := '';
                    "Employee ID" := Employee."Employee ID";
                    Gender := Gender::" ";
                    "Birth Date" := 0D;
                    "Country/Region Code of Birth" := '';
                    VALIDATE("City of Birth", '');
                    "Employment Date" := 0D;
                    "Professional Exam. Result" := "Professional Exam. Result"::" ";
                END;
            end;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
        }
        field(10; "Employee Name"; Text[61])
        {
            Caption = 'Employee Name';
            Editable = false;
        }
        field(50000; "Employee ID"; Code[13])
        {
            Caption = 'Personal Identification Number';
        }
        field(50001; Gender; enum "Employee Gender")
        {
            Caption = 'Gender';

        }
        field(50002; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(50003; "Country/Region Code of Birth"; Code[10])
        {
            Caption = 'Country/Region Code of Birth';
            TableRelation = "Country/Region".Code;
        }
        field(50004; "City of Birth"; Text[30])
        {
            Caption = 'City of Birth';
            TableRelation = IF ("Country/Region Code of Birth" = FILTER('')) "Post Code".City
            ELSE
            IF ("Country/Region Code of Birth" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code of Birth"));

            trigger OnValidate()
            begin
                //ĐK     PostCode.ValidateCityBirth("City of Birth", "Country/Region Code of Birth", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50005; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            TableRelation = "Citizenship Description"."No.";

            trigger OnValidate()
            begin
                IF Citizenship <> '' THEN BEGIN
                    CitizenshipDescription.RESET;
                    CitizenshipDescription.SETFILTER("No.", Citizenship);
                    IF CitizenshipDescription.FINDFIRST THEN
                        "Citizenship Description" := CitizenshipDescription.Description;
                END
                ELSE
                    "Citizenship Description" := '';
            end;
        }
        field(50006; "Citizenship Description"; Text[50])
        {
            Caption = 'Citizenship Description';
            Editable = false;
        }
        field(50007; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(50008; "Municipality Code"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality.Code;

            trigger OnValidate()
            begin
                IF "Municipality Code" <> '' THEN BEGIN
                    Municipality.RESET;
                    Municipality.SETFILTER(Code, "Municipality Code");
                    IF Municipality.FINDFIRST THEN
                        "Municipality Name" := Municipality.Name;
                    VALIDATE(City, Municipality.City);
                END
                ELSE BEGIN
                    "Municipality Name" := '';
                    VALIDATE(City, '');
                END;
            end;
        }
        field(50009; "Municipality Name"; Text[30])
        {
            Caption = 'Municipality Name';
            Editable = false;
        }
        field(50010; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //ĐK    PostCode.ValidateCity1(City, "Post Code", "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50011; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(50012; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //ĐK    PostCode.ValidatePostCode1(City, "Post Code", "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50013; "Residence Permit"; Code[10])
        {
            Caption = 'Residence Permit';
        }
        field(50014; "Work Permit"; Code[10])
        {
            Caption = 'Work Permit';
        }
        field(50015; "Type Of Work Permit"; Option)
        {
            Caption = 'Type Of Work Permit';
            OptionCaption = ' ,Permanent Residence,Temporary Residence';
            OptionMembers = " ","Permanent Residence","Temporary Residence";
        }
        field(50016; "Education Level"; Option)
        {
            Caption = 'Education Level';
            OptionCaption = ' ,I Stepen četiri razreda osnovne,II Stepen - osnovna škola,III Stepen - SSS srednja škola,IV Stepen - SSS srednja škola,V Stepen - VKV - SSS srednja škola,VI Stepen - VS viša škola,VII Stepen - VSS visoka stručna sprema,VII-1 Stepen - Specijalista,VII-2 Stepen - Magistratura,VIII Stepen - Doktorat  ';
            OptionMembers = " ","I Stepen četiri razreda osnovne","II Stepen - osnovna škola","III Stepen - SSS srednja škola","IV Stepen - SSS srednja škola","V Stepen - VKV - SSS srednja škola","VI Stepen - VS viša škola","VII Stepen - VSS visoka stručna sprema","VII-1 Stepen - Specijalista","VII-2 Stepen - Magistratura","VIII Stepen - Doktorat  ";
        }
        field(50017; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(50018; "Contract Date"; Date)
        {
            Caption = 'Contract Date';
        }
        field(50019; "Contract No."; Code[10])
        {
            Caption = 'Contract No.';
        }
        field(50020; "Contract Type"; Code[20])
        {
            Caption = 'Contract Type';
            TableRelation = "Employment Contract".Code;
        }
        field(50021; "Contract Ending Date"; Date)
        {
            Caption = 'Contract Ending Date';
        }
        field(50022; "Testing Period Duration"; Option)
        {
            Caption = 'Testing Period (Duration Opt.)';
            OptionCaption = ' ,1 month,2 months,3 months,4 months,5 months,6 months';
            OptionMembers = " ","1 month","2 months","3 months","4 months","5 months","6 months";
        }
        field(50023; Prentice; Boolean)
        {
            Caption = 'Prentice';
        }
        field(50024; "Professional Exam. Result"; Option)
        {
            Caption = 'Professional Exam. Result';
            OptionCaption = ' ,Passed,Failed';
            OptionMembers = " ",Passed,Failed;
        }
        field(50025; "Testing Period"; Boolean)
        {
            Caption = 'Testing Period';
        }
        field(50026; "Employment Abroad City"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Empl. Abroad Country/Region" = FILTER('')) "Post Code".City
            ELSE
            IF ("Empl. Abroad Country/Region" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Empl. Abroad Country/Region"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //     PostCode.ValidateCityBirth("Employment Abroad City", "Empl. Abroad Country/Region", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(50027; "Empl. Abroad Country/Region"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region".Code;
        }
        field(50028; "Employment Abroad"; Boolean)
        {
            Caption = 'Employment Abroad';
        }
        field(50029; "Incr. Duration for Work Exp."; Boolean)
        {
            Caption = 'Incr. Duration for Work Exp.';
        }
        field(50030; "Posit. Requires Previous Exp."; Boolean)
        {
            Caption = 'Posit. Requires Previous Exp.';
        }
        field(50031; "Work in Different Places"; Boolean)
        {
            Caption = 'Work in Different Places';
        }
        field(50032; "Employment Years"; Integer)
        {
            Caption = 'Employment Years';
        }
        field(50033; "Employment Months"; Integer)
        {
            Caption = 'Employment Months';
        }
        field(50034; "Employment Days"; Integer)
        {
            Caption = 'Employment Days';
        }
        field(50035; "Work Experience Years"; Integer)
        {
            Caption = 'Work Experience Years';
        }
        field(50036; "Work Experience Months"; Integer)
        {
            Caption = 'Work Experience Months';
        }
        field(50037; "Work Experience Days"; Integer)
        {
            Caption = 'Work Experience Days';
        }
        field(50038; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination" WHERE(Type = FILTER(' '));

            trigger OnValidate()
            begin
                IF "Grounds for Term. Code" <> '' THEN BEGIN
                    GroundsForTermination.RESET;
                    GroundsForTermination.SETFILTER(Type, 'Reason');
                    GroundsForTermination.SETFILTER(code, "Grounds for Term. Code");
                    IF GroundsForTermination.FINDFIRST THEN
                        "Grounds for Term. Description" := GroundsForTermination.Description;
                END
                ELSE
                    "Grounds for Term. Description" := '';
            end;
        }
        field(50039; "Grounds for Term. Description"; Text[50])
        {
            Caption = 'Grounds for Term. Description';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee";
        PostCode: Record "Post Code";
        CitizenshipDescription: Record "Citizenship Description";
        Municipality: Record "Municipality";
        GroundsForTermination: Record "Grounds for Termination";
}

*/