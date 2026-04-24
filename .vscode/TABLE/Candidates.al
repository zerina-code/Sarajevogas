/*table 50214 Candidates
{
    Caption = 'Candidates';
    //DrillDownPageID = 50154;
    // LookupPageID = 50154;

    fields
    {
        field(1; "Date of aplication"; Date)
        {
            Caption = 'Date of aplication';
        }
        field(2; Position; Code[30])
        {
            Caption = 'Position';
            TableRelation = "Position Menu".Code;
        }
        field(3; "Serial Number"; Integer)
        {
            AutoIncrement = true;
            Caption = 'Serial number';
            Editable = false;
        }
        field(4; "Name of the Company"; Option)
        {
            Caption = 'Name of the Company';
            OptionCaption = ', ,RBBH,Raiffaisen Leasing,Raiffeisen Assistance,Raiffeisen Invest,Raifeissen Capital';
            OptionMembers = ," ",RBBH,"Raiffaisen Leasing","Raiffeisen Assistance","Raiffeisen Invest","Raifeissen Capital";
        }
        field(5; "Person ID"; Code[20])
        {
            Caption = 'Person ID';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.RESET;
                Employee.SETFILTER("No.", '%1', "Person ID");
                IF Employee.FINDFIRST THEN BEGIN

                    VALIDATE(Name, Employee."First Name");
                    VALIDATE(Surname, Employee."Last Name");
                    VALIDATE("Maiden Name", Employee."Maiden Name");
                    VALIDATE("Father Name", Employee."Father Name");
                    VALIDATE(Gender, Employee.Gender);

                    VALIDATE("Place of living", Employee."Place Of Living");
                    VALIDATE(Address, Employee."Address CIPS");
                    VALIDATE("Date of Birth", Employee."Birth Date");
                    VALIDATE("E-mail", Employee."Company E-Mail");


                    VALIDATE("Country/Region Code Home", Employee."Country/Region Code Home");
                    VALIDATE("Dial Code Home", Employee."Dial Code Home");
                    IF Employee."Dial Code Home" <> '' THEN
                        VALIDATE("Phone No.", Employee."Phone No.");
                    VALIDATE("Full Phone No.", Employee."Full Phone No.");

                    VALIDATE("Driving License", Employee."Driving Licence");

                    AdditionalEducation.RESET;
                    AdditionalEducation.SETFILTER("Employee No.", '%1', "Person ID");
                    IF AdditionalEducation.FINDFIRST THEN BEGIN
                        VALIDATE("Name of edu. institution", AdditionalEducation."School of Graduation");
                        VALIDATE("Department of edu. institution", AdditionalEducation.Major);
                        VALIDATE("Professional qualifications", AdditionalEducation."Education Level");
                        IF AdditionalEducation."To Date" <> 0D THEN
                            VALIDATE("Year of graduation", DATE2DMY(AdditionalEducation."To Date", 3))

                    END;

                    VALIDATE("Candidate status at the moment", Employee.StatusExt);

                    ID := 0;
                  
                    EmployeeQualification.RESET;
                    EmployeeQualification.SETFILTER("Employee No.", '%1', "Person ID");
                    EmployeeQualification.SETFILTER("Language Code", '<>%1', '');
                    IF EmployeeQualification.FINDFIRST THEN
                        REPEAT
                            ID := ID + 1;
                          
                            COMMIT;
                        UNTIL EmployeeQualification.NEXT = 0;

                    EmployeeQualification.RESET;
                    EmployeeQualification.SETFILTER("Employee No.", '%1', "Person ID");
                    EmployeeQualification.SETFILTER("Computer Knowledge Code", '<>%1', '');
                    IF EmployeeQualification.FINDFIRST THEN
                        REPEAT
                            CandidateComputerSkills.INIT;
                            CandidateComputerSkills."Serial Number" := "Serial Number";
                            CandidateComputerSkills."Computer Knowledge Code" := EmployeeQualification."Computer Knowledge Code";
                            CandidateComputerSkills."Computer Knowledge Description" := EmployeeQualification."Computer Knowledge Description";
                            CandidateComputerSkills.INSERT;
                        UNTIL EmployeeQualification.NEXT = 0;



                END;
            end;
        }
        field(6; Candidate; Option)
        {
            Caption = 'Candidate';
            OptionCaption = ',Internal,External,Candidate by base';
            OptionMembers = ,Internal,External,"Candidate by base";

            trigger OnValidate()
            begin
                IF Candidate <> Candidate::Internal THEN
                    "Person ID" := '';
            end;
        }
        field(7; Surname; Text[150])
        {
            Caption = 'Surname';
        }
        field(8; Name; Text[150])
        {
            Caption = 'Name';
        }
        field(9; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
        }
        field(10; Gender; Option)
        {
            Caption = 'Gender';
            InitValue = Male;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(11; "Place of living"; Text[150])
        {
            Caption = 'Place of living';
        }
        field(12; Address; Text[150])
        {
            Caption = 'Address';
        }
        field(13; "Telephone No."; Text[1])
        {
            Caption = 'Telephone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "E-mail"; Text[70])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
        }
        field(15; "Candidate status at the moment"; Option)
        {
            Caption = 'Candidate status at the moment';
            OptionCaption = ' ,Testiran_za dalju selekciju,Testiran_nije za dalju selekciju,Nije odgovarajuÚi kandidat za banku,OdgovarajuÚi profil-drugo radno mjesto,Nije testiran';
            OptionMembers = "Testiran_za dalju selekciju","Testiran_nije za dalju selekciju","Nije odgovarajući kandidat za banku","Odgovarajući profil-drugo radno mjesto","Nije testiran";
        }
        field(16; "Name of edu. institution"; Text[200])
        {
            Caption = 'Name of edu. institution';
            TableRelation = "Institution/Company".Description;
            ValidateTableRelation = false;
        }
        field(17; "Department of edu. institution"; Text[150])
        {
            Caption = 'Department of edu. institution';
            TableRelation = "Additional Education".Major;
            ValidateTableRelation = false;
        }
        field(18; "Professional qualifications"; Option)
        {
            Caption = 'Professional qualifications';
            OptionMembers = "Empty","NSS","SSS","KV","VKV","VS","VSS","MR","DR","PK","NK";
            OptionCaption = 'Empty,NSS,SSS,KV,VKV,VS,VSS,MR,DR,PK,NK';
        }
        field(19; "Year of graduation"; Integer)
        {
            Caption = 'Year of graduation';
        }
      
        field(22; Location; Text[250])
        {
            Caption = 'Location';
        }
        field(24; "Computer Skills"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Candidate Computer Skills" WHERE("Serial Number" = FIELD("Serial Number")));
            Caption = 'Computer Skills';
            Editable = false;

        }
        field(25; "Driving License"; Boolean)
        {
            Caption = 'Driving License';
        }
        field(26; "Education - Seminars"; Text[250])
        {
            Caption = 'Education - Seminars';
            TableRelation = "Education - Seminars".Description;
        }
        field(27; "Work Experience"; Text[50])
        {
            Caption = 'Work Experience';
        }
        field(28; Employer; Text[200])
        {
            Caption = 'Employer';
        }
        field(29; "Former Workplace"; Text[250])
        {
            Caption = 'Former Workplace';
        }
        field(30; "Period From"; Date)
        {
            Caption = 'Period From';
        }
        field(31; "Period To"; Date)
        {
            Caption = 'Period To';
        }
        field(32; "Job Desription"; Text[250])
        {
            Caption = 'Job Desription';
        }
        field(33; Note; Text[250])
        {
            Caption = 'Note';
        }
        field(34; "Test Result"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Candidate Testing" WHERE("Serial Number" = FIELD("Serial Number")));
            Caption = 'Test Result';
            Editable = false;

        }
        field(36; "Test Result - BFQ"; Text[1])
        {
            Caption = 'Test Result - BFQ';
        }
        field(37; "Test Result - EPQ"; Text[1])
        {
            Caption = 'Test Result - EPQ';
        }
        field(38; "Test Result - TN"; Text[1])
        {
            Caption = 'Test Result - TN';
        }
        field(39; "Test Result Eng"; Text[1])
        {
            Caption = 'Test Result Eng';
        }
        field(40; "Managerial Competence"; Text[30])
        {
            Caption = 'Managerial Competence';
        }
        field(41; "Expert Test"; Text[30])
        {
            Caption = 'Expert Test';
        }
        field(42; Tested; Text[2])
        {
            Caption = 'Tested';
            Editable = false;
        }
        field(43; "HR Note"; Text[250])
        {
            Caption = 'HR Note';
        }
        field(44; "Hierarchical Workplace Level"; Text[30])
        {
            Caption = 'Hierarchical Workplace Level';
        }
        field(45; "Grade Workplace"; Integer)
        {
            Caption = 'Grade Workplace';
        }
        field(46; "Offer Acceptance Date"; Date)
        {
            Caption = 'Offer Acceptance Date';
        }
        field(47; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(48; "Try-out"; Text[30])
        {
            Caption = 'Try-out';
        }
        field(49; "Organizational Affiliation"; Text[100])
        {
            Caption = 'Organizational Affiliation';
        }
        field(50; "Hiring Manager"; Text[50])
        {
            Caption = 'Hiring Manager';
        }
        field(51; "Posting Code"; Code[10])
        {
            Caption = 'Posting Code';
        }
        field(52; "Published Date"; Date)
        {
            Caption = 'Published Date';
        }
        field(53; "Employment Relationship Type"; Option)
        {
            Caption = 'Employment Relationship Type';
            OptionCaption = ', ,Employee,Candidate,Professional practice,Fair practice,Intern,Work contract';
            OptionMembers = ," ",Employee,Candidate,"Professional practice","Fair practice",Intern,"Work contract";
        }
        field(54; "Maiden Name"; Text[100])
        {
            Caption = 'Maiden Name';
        }
        field(55; "Father Name"; Text[100])
        {
            Caption = 'Father Name';
        }
        field(63; "Previous Work Experience"; BigInteger)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Previous Work Experience" WHERE("Serial Number" = FIELD("Serial Number")));
            Caption = 'Previous Work Experience';

        }
        field(64; "Insert Month"; Integer)
        {
            Caption = 'Insert Month';
        }
        field(65; "Insert Year"; Integer)
        {
            Caption = 'Insert Year';
        }
        field(66; "Country/Region Code Home"; Code[5])
        {
            TableRelation = "Country/Region"."Country Code";
        }
        field(67; "Dial Code Home"; Code[5])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Home"),
                                                    "Type" = FILTER("Fixed"));

            trigger OnValidate()
            begin
                "Full Phone No." := "Country/Region Code Home" + ' ' + "Dial Code Home" + ' ' + "Phone No.";
            end;
        }
        field(68; "Phone No."; Text[8])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                CLEAR(CheckInt);
                IF ((NOT EVALUATE(CheckInt, (COPYSTR("Phone No.", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Phone No.", 5, 4))) OR (COPYSTR("Phone No.", 4, 1) <> ' '))
                  THEN
                    IF (COPYSTR("Phone No.", 4, 1) <> ' ')
                      THEN
                        ERROR(Text016, COPYSTR("Phone No.", 4, 1), 'razmak', "Serial Number")
                    ELSE
                        ERROR(Text017, "Phone No.")
                ELSE
                    "Full Phone No." := "Country/Region Code Home" + ' ' + "Dial Code Home" + ' ' + "Phone No.";
            end;
        }
        field(69; "Full Phone No."; Text[16])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(70; Posting; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Candidate/Posting" WHERE("Serial Number" = FIELD("Serial Number")));
            Caption = 'Postings';
            Editable = false;

        }
        field(71; "Appropriate Profile for Bank"; Boolean)
        {
            Caption = 'Appropriate Profile for Bank';

            trigger OnValidate()
            begin
                CandidatePosting.RESET;
                CandidatePosting.SETFILTER("Serial Number", '%1', "Serial Number");
                IF CandidatePosting.FINDFIRST THEN
                    REPEAT
                        CandidatePosting."Appropriate Profile for Bank" := "Appropriate Profile for Bank";
                        CandidatePosting.MODIFY;
                    UNTIL CandidatePosting.NEXT = 0;
            end;
        }
        field(72; Question; Boolean)
        {
        }
        field(73; Delete; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; "Serial Number", Name, Surname)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        Tested := 'NE';
        "Insert Month" := DATE2DMY(TODAY, 2);
        "Insert Year" := DATE2DMY(TODAY, 3);
        Candidate := Candidate::External;
    end;

    var
        Candidates: Record "Candidates";
        CheckInt: Integer;
        Text016: Label 'Entry %1 is not valid. Expected value is %2 for candidate no. %3';
        Text017: Label 'Entry %1 is not valid. ';
        Employee: Record "Employee";
        AdditionalEducation: Record "Additional Education";
        //  CandidateForeignLanguage: Record "Candidate Foreign Language";
        EmployeeQualification: Record "Employee Qualification";
        CandidateComputerSkills: Record "Candidate Computer Skills";
        CandidatePosting: Record "Candidate/Posting";
        ID: Integer;
}

*/