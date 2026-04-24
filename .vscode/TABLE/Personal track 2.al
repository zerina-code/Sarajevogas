/*Đemina ne treba table 50170 "Personal track 2"
{
    Caption = 'Personal track 2';

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
                //bio koment cijeli IF "Date of change"=0D THEN
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
        field(47; "Pregnancy Keeping From"; Text[250])
        {
            Caption = 'Pregnancy Keeping From';
        }
        field(49; "Pregnancy Leave From"; Text[250])
        {
            Caption = 'Pregnancy Leave From';
        }
        field(51; "Proffessional Illness"; Text[250])
        {
            Caption = 'Proffessional Illness';
        }
        field(55; "Decrease Inability"; Text[250])
        {
            Caption = 'Decrease Inability';
        }
        field(56; "Employee Disability"; Text[250])
        {
            Caption = 'Employee Disability';
        }
        field(65; "Date of change"; Date)
        {
            Caption = 'Date of change';
        }
        field(70; "Employee type"; Option)
        {
            Caption = 'Employee type';
            OptionCaption = ' ,External,Internal,Out of base';
            OptionMembers = " ",External,Internal,"Out of base";
        }
        field(82; "Others data set"; Text[250])
        {
            Caption = 'Others data set';
        }
        field(89; "Contract No"; Integer)
        {
            Caption = 'Contract No';
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
        }
        field(99; "Work Violation Note"; Text[250])
        {
            Caption = 'Work Violation Note';
        }
        field(100; "Breastfeeding from"; Text[250])
        {
            Caption = 'Breastfeeding from';
        }
        field(101; Disability; Boolean)
        {
            Caption = 'Disability';
        }
        field(102; "Status samohranog roditelj"; Text[250])
        {
            Caption = 'Single parent';
        }
        field(103; "Adaption status"; Text[250])
        {
            Caption = 'Adaption status';
        }
        field(104; Unproffesionality; Text[250])
        {
            Caption = 'Unproffesionality';
        }
        field(105; "Partial decrease Inability"; Text[250])
        {
            Caption = 'Partial decrease Inability';
        }
        field(106; "Risk of impairment"; Text[250])
        {
            Caption = 'Risk of impairment';
        }
        field(107; "Risk of disability"; Text[250])
        {
            Caption = 'Risk of disability';
        }
        field(108; "Level of partial disability"; Text[250])
        {
            Caption = 'Level of partial disability';
        }
        field(109; "Level Date from"; Date)
        {
            Caption = 'Level Date from';
        }
        field(110; "Level Date to"; Date)
        {
            Caption = 'Level Date to';
        }
    }

    keys
    {
        key(Key1; "Line No.", "Code Addr", "Code Additional", "Code Personal", "Employee No.", "Date of change", "First Name", "Last Name", "Contract No")
        {
        }
    }

    fieldgroups
    {
    }
}

*/