/*table 50171 "Personal track report"
{
    // //NK1

    Caption = 'Personal track report';

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = false;
            Caption = 'LiNE No.';
        }
        field(2; "Employee No."; Code[10])
        {
            Caption = 'Employee No.';
            TableRelation = IF ("Employee type" = FILTER(External | Internal)) Employee."No.";

            trigger OnValidate()
            begin
                / pocetak komentara IF "Date of change"=0D THEN
                  "Date of change":=TODAY;
                Employee.RESET;
                Employee.SETFILTER("No.",'%1',"Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                
                  "First Name":=Employee."First Name";
                  JMBG:=Employee."Employee ID";
                "Last Name":=Employee."Last Name";
                "Line No.":=Employee."Internal ID";
                Gender:=Employee.Gender;
                "Birth Date":=Employee."Birth Date";
                "Birth City":=Employee."Birth City";
                "Place of birth":=Employee."Place of birth";
                //"Birth Municipality":=Employee."Municipality Code of Birth";
                CountryCode.RESET;
                CountryCode.SETFILTER(Code,'%1',Employee."Country/Region Code of Birth");
                IF CountryCode.FINDFIRST THEN
                "Birth State":=CountryCode.Name;
                MunicipalityCode.RESET;
                MunicipalityCode.SETFILTER(Code,'%1',Employee."Municipality Code of Birth");
                MunicipalityCode.SETFILTER("Country/Region Code",'%1',Employee."Country/Region Code of Birth");
                IF MunicipalityCode.FINDFIRST THEN
                  "Birth Municipality":=MunicipalityCode.Name
                ELSE
                  "Birth Municipality":='';
                PersonalDocument.RESET;
                PersonalDocument.SETFILTER("Employee No.",'%1',"Employee No.");
                PersonalDocument.SETFILTER(Switch,'%1',PersonalDocument.Switch::Citizenship);
                PersonalDocument.SETFILTER("Date From",'<=%1',"Date of change");
                PersonalDocument.SETCURRENTKEY("Date From");
                PersonalDocument.ASCENDING;
                IF PersonalDocument.FINDLAST THEN
                Citizenship:=PersonalDocument."Citizenship Description";
                
                PersonalDocument.RESET;
                PersonalDocument.SETFILTER("Employee No.",'%1',"Employee No.");
                PersonalDocument.SETFILTER(Switch,'%1',PersonalDocument.Switch::"Work Permit");
                PersonalDocument.SETFILTER("Date From",'<=%1',"Date of change");
                PersonalDocument.SETCURRENTKEY("Date From");
                PersonalDocument.ASCENDING;
                IF PersonalDocument.FINDLAST THEN BEGIN
                  "Work Permit Code":=PersonalDocument."Work Permit";
                  "Work Permit Type":=FORMAT(PersonalDocument."Type Of Work Permit");
                  "Work Permit To":=PersonalDocument."Date To";
                  "Work Permit From":=PersonalDocument."Date From";
                  END
                  ELSE BEGIN
                      "Work Permit Code":='';
                  "Work Permit Type":='';
                  "Work Permit To":=0D;
                  "Work Permit From":=0D;
                    END;
                
                AdditionalEducation.RESET;
                AdditionalEducation.SETFILTER("Employee No.",'%1',"Employee No.");
                AdditionalEducation.SETFILTER("From Date",'<=%1',"Date of change");
                IF AdditionalEducation.FINDFIRST THEN BEGIN
                
                  "Education Level":=FORMAT(AdditionalEducation."Education Level");
                "Additional Education":=AdditionalEducation."School of Graduation";
                END
                ELSE BEGIN
                    "Education Level":='';
                "Additional Education":='';
                  END;
                
                
                Qualification.RESET;
                Qualification.SETFILTER("Employee No.",'%1',"Employee No.");
                Qualification.SETFILTER("From Date",'<=%1',"Date of change");
                IF Qualification.FINDSET THEN REPEAT
                  Qua.RESET;
                  Qua.SETFILTER(Code,'%1',Qualification."Qualification Code");
                  IF Qua.FINDFIRST THEN BEGIN
                  "Proffessional Exam":="Proffessional Exam"+' ;'+Qualification.Description;
                    END
                    ELSE BEGIN
                      "Proffessional Exam":='';
                      END;
                      UNTIL Qualification.NEXT=0;
                //Work Permit
                WorkBooklet.RESET;
                WorkBooklet.SETFILTER("Employee No.",'%1',"Employee No.");
                WorkBooklet.SETFILTER("Starting Date",'<=%1',"Date of change");
                WorkBooklet.SETCURRENTKEY("Starting Date");
                WorkBooklet.ASCENDING;
                IF WorkBooklet.FINDFIRST THEN
                  "Employment Date":=WorkBooklet."Starting Date"
                ELSE
                  "Employment Date":=0D;
                AlternativeAddress.RESET;
                AlternativeAddress.SETFILTER("Employee No.",'%1',"Employee No.");
                AlternativeAddress.SETFILTER("Date From",'<=%1',"Date of change");
                AlternativeAddress.SETCURRENTKEY("Date From");
                AlternativeAddress.ASCENDING;
                IF AlternativeAddress.FINDFIRST THEN BEGIN
                
                MunicipalityCode.RESET;
                MunicipalityCode.SETFILTER(Code,'%1',AlternativeAddress."Municipality Code CIPS");
                
                IF MunicipalityCode.FINDFIRST THEN
                "Municipality CIPS":=MunicipalityCode.Name;
                END
                ELSE BEGIN
                  "Municipality CIPS":='';
                  END;
                
                "City CIPS":=Employee."City CIPS";
                "Address CIPS":=Employee."Address CIPS";
                END
                ELSE BEGIN
                  "First Name":='';
                  JMBG:='';
                "Last Name":='';
                "Line No.":=0;
                Gender:=0;
                "Birth Date":=0D;
                "Birth City":='';
                "Place of birth":='';
                "Birth State":='';
                Citizenship:='';
                "Municipality CIPS":='';
                "City CIPS":='';
                "Address CIPS":='';
                "Municipality Code of Birth":='';
                "Birth Municipality":='';
                 "Work Permit Code":='';
                  "Work Permit Type":='';
                  "Work Permit To":=0D;
                  "Work Permit From":=0D;
                   "Education Level":='';
                   "Proffessional Exam":='';
                "Additional Education":='';
                 "Employment Date":=0D;
                
                  END;
            
//kraj komentara
            end;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(4; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(5; Gender; enum "Employee Gender")
        {
            Caption = 'Gender';

        }
        field(6; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(7; "Birth City"; Text[10])
        {
            Caption = 'Birth City';
        }
        field(8; "Birth State"; Text[30])
        {
            Caption = 'Birth State';
        }
        field(9; Citizenship; Text[50])
        {
            Caption = 'Citizenship';
        }
        field(10; "City CIPS"; Text[30])
        {
            Caption = 'City CIPS';
        }
        field(11; "Address CIPS"; Text[50])
        {
            Caption = 'Address CIPS';
        }
        field(12; "Municipality CIPS"; Text[30])
        {
            Caption = 'Municipality CIPS';
            TableRelation = Municipality.Name where(Type = filter(Regular));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(13; "Work Permit Code"; Code[20])
        {
            Caption = 'Work Permit Code';
        }
        field(14; "Work Permit Type"; Text[50])
        {
            Caption = 'Work Permit Type';
        }
        field(15; "Work Permit From"; Date)
        {
            Caption = 'Work Permit From';
        }
        field(16; "Work Permit To"; Date)
        {
            Caption = 'Work Permit To';
        }
        field(17; "Education Level"; Text[250])
        {
            Caption = 'Education Level';
        }
        field(18; "Proffessional Exam"; Text[250])
        {
            Caption = 'Proffessional Exam';
        }
        field(19; "Additional Education"; Text[250])
        {
            Caption = 'Additional Education';
        }
        field(21; "Employee Contract o."; Text[30])
        {
            Caption = 'Employee Contract No. ';
        }
        field(22; "Starting Date Contract"; Date)
        {
            Caption = 'Starting Date Contract';
        }
        field(23; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
       
        field(25; "Contract type"; Text[50])
        {
            Caption = 'Contract type';
        }
        field(26; "Definitely Contract From"; Date)
        {
            Caption = 'Definitely Contract From';
        }
        field(27; "Definitely Contract To"; Date)
        {
            Caption = 'Definitely Contract To';
        }
        field(28; "Probation From"; Date)
        {
            Caption = 'Probation From';
        }
        field(29; "Probation To"; Date)
        {
            Caption = 'Probation To';
        }
        field(30; "Prentice Contract No."; Text[30])
        {
            Caption = 'Prentice Contract No.';
        }
        field(31; "Prentice Contract From"; Date)
        {
            Caption = 'Prentice Contract From';
        }
        field(32; "Prentice Contract To"; Date)
        {
            Caption = 'Prentice Contract To';
        }
        field(34; "Abroad From"; Date)
        {
            Caption = 'Abroad From';
        }
        field(35; "Abroad To"; Date)
        {
            Caption = 'Abroad To';
        }
        field(36; "Abroad City"; Text[30])
        {
            Caption = 'Abroad City';
        }
        field(37; "Abroad State"; Text[50])
        {
            Caption = 'Abroad State';
        }
        field(39; "Working Hours Week"; Integer)
        {
            Caption = 'Working Hours Week';
        }
        field(40; "Working Hours Day"; Integer)
        {
            Caption = 'Working Hours day';
        }
        field(42; "Work Experience Year"; Integer)
        {
            Caption = 'Work Experience Year';
        }
        field(43; "Work Experience Month"; Integer)
        {
            Caption = 'Work experience month';
        }
        field(44; "Work Experience Day"; Integer)
        {
            Caption = 'Work experience day';
        }
        field(45; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(46; "Termination Reason"; Text[200])
        {
            Caption = 'Termination Reason';
        }
        field(64; JMBG; Text[13])
        {
            Caption = 'JMBG';
        }
        field(65; "Date of change"; Date)
        {
            Caption = 'Date of change';
        }
        field(66; "Birth Municipality"; Code[30])
        {
            Caption = 'Birth Municipality';
            TableRelation = Municipality.Name where(Type = filter(Regular));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(69; "Name of Act"; Text[50])
        {
            Caption = 'Name of Act';
        }
        field(70; "Employee type"; Option)
        {
            Caption = 'Employee type';
            OptionCaption = ' ,External,Internal,Out of base';
            OptionMembers = " ",External,Internal,"Out of base";
        }
        field(71; "Internal ID"; Code[20])
        {
            Caption = 'Internal ID';
        }
        field(72; "Indication for work experience"; Boolean)
        {
            Caption = 'Indication for work experience';
        }
        field(73; "Indication of capability"; Boolean)
        {
            Caption = 'Indication of capability';
        }
        field(74; "Another place of work"; Text[50])
        {
            Caption = 'Another place of work';
        }
        field(75; "Ret. Work Experience Year"; Integer)
        {
            Caption = 'Work Experience Year';
        }
        field(76; "Ret. Work Experience Month"; Integer)
        {
            Caption = 'Work experience month';
        }
        field(77; "Retirement Work Experience Day"; Integer)
        {
            Caption = 'Work experience day';
        }
        field(78; "Inaction From"; Date)
        {
            Caption = 'Inaction From';
        }
        field(79; "Inaction to"; Date)
        {
            Caption = 'Inaction to';
        }
        field(80; "Breastfeeding from"; Date)
        {
            Caption = 'Breastfeeding from';
        }
        field(83; "Proof of doing job"; Boolean)
        {
            Caption = 'Proof of doing job';
        }
        field(84; "Place of birth"; Text[50])
        {
            Caption = 'Place of birth';
        }
        field(85; "Municipality Code of Birth"; Code[30])
        {
            Enabled = false;
        }
        field(86; "Number of Act"; Code[50])
        {
            Caption = 'Number of Act';
        }
        field(87; "Working Place"; Text[50])
        {
            Caption = 'Working Place';
        }
        field(89; "Contract No"; Integer)
        {
            Caption = 'Contract No';
        }
        field(90; "Position Name"; Text[250])
        {
            Caption = 'Position Name';
        }
        field(91; "Proffesional Exam Date"; Date)
        {
            Caption = 'Proffesional Exam Date';
        }
        field(92; "Proffesional Exam Result"; Text[50])
        {
            Caption = 'Proffesional Exam Result';
        }
        field(93; "Act Date"; Date)
        {
            Caption = 'Act Date';
        }
        field(94; Certificate; Text[250])
        {
            Caption = 'Certificate';
        }
        field(95; AutoIncrement; Integer)
        {
            AutoIncrement = true;
        }
        field(96; "Code Addr"; Integer)
        {
            AutoIncrement = false;
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
               
            end;
        }
        field(97; "Code Additional"; Integer)
        {
            AutoIncrement = false;
            Caption = 'Code';
            NotBlank = false;

            trigger OnValidate()
            begin
              
            end;
        }
        field(98; "Code Personal"; Code[10])
        {
            Caption = 'Jedinstveni ID za lične podatke';
        }
        field(99; "Extract Additional"; Text[250])
        {
            Caption = 'Extract Additional';
        }
        field(100; TestID; Integer)
        {
        }
        field(101; "Proffessional Exam From"; Date)
        {
            Caption = 'Proffessional Exam From';
        }
        field(102; "Proffessional Exam To"; Date)
        {
            Caption = 'Proffessional Exam To';
        }
        field(103; "Position Code"; Code[20])
        {
        }
        field(104; "Org Shema"; Code[10])
        {
        }
        field(105; "Entity CIPS"; Code[10])
        {
            Caption = 'Entity CIPS';
        }
        field(106; "Residence Permit Code"; Code[30])
        {
            Caption = 'Residence Permit Code';
        }
        field(107; "Residence Permit From"; Date)
        {
            Caption = 'Residence Permit From';
        }
        field(108; "Residence Permit To"; Date)
        {
            Caption = 'Residence Permit To';
        }
        field(109; "Title Description"; Text[250])
        {
            Caption = 'Title Description';
        }
        field(110; "Personal track 2"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Personal track 2" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Personal track 2';

        }
        field(111; "Working State"; Text[30])
        {
            Caption = 'Birth State';
        }
        field(112; "Municipality Working"; Text[30])
        {
            Caption = 'Municipality CIPS';
            TableRelation = Municipality.Name where(Type = filter(Regular));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(113; "Disability and pension persona"; Text[200])
        {
            Caption = 'Invalid rada i uživalac penzije';
        }
        field(114; "Part-time workers"; Text[250])
        {
            Caption = 'Za radnike koji rade sa nepunim radnim vremenom podatak o svakom drugom poslodavcu kod kojeg radnik radi sa nepunim radnim vremenom';
        }
        field(115; "Self-employment"; Text[200])
        {
            Caption = 'Da li se radnik bavi samostalnom djelatnošću';
        }
        field(116; "Employee activity"; Text[250])
        {
            Caption = 'Djelatnost poslodavca';
        }
        field(117; "City Real"; Text[30])
        {
            Caption = 'City CIPS';
        }
        field(118; "Address Real"; Text[50])
        {
            Caption = 'Address CIPS';
        }
        field(119; "Municipality Real"; Text[30])
        {
            Caption = 'Municipality CIPS';
            TableRelation = Municipality.Name where(Type = filter(Regular));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(120; "Entity Real"; Code[10])
        {
            Caption = 'Entity CIPS';
        }
        field(121; Identitet; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Line No.", "Employee No.", "Date of change", AutoIncrement)
        {
        }
    }

    fieldgroups
    {
    }

    var
        Employee: Record "Employee";
        CountryCode: Record "Country/Region";
        MunicipalityCode: Record "Municipality";
        PersonalDocument: Record "Personal Documents";
        AlternativeAddress: Record "Alternative Address";
        AdditionalEducation: Record "Additional Education";
        Qualification: Record "Employee Qualification";
        Qua: Record "Qualification";
        WorkBooklet: Record "Work Booklet";
}

*/