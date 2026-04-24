tableextension 50025 EmployeeExtension extends Employee
{


    //dzana

    fields
    {

        modify("Phone No.")
        {
            trigger OnAfterValidate()
            begin
                //elmira

                CLEAR(CheckInt);

                IF "Phone No." <> '' THEN BEGIN
                    IF ((NOT EVALUATE(CheckInt, (COPYSTR("Phone No.", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Phone No.", 5, 4))) OR (COPYSTR("Phone No.", 4, 1) <> ' '))
                      THEN
                        IF (COPYSTR("Phone No.", 4, 1) <> ' ')
                          THEN
                            ERROR(Text016, COPYSTR("Phone No.", 4, 1), 'razmak', "No.")
                        ELSE
                            ERROR(Text017, "Phone No.")
                    ELSE
                        "Full Phone No." := "Country/Region Code Home" + ' ' + "Dial Code Home" + ' ' + "Phone No.";
                END
                ELSE BEGIN
                    IF (("Country/Region Code Home" <> '') OR ("Dial Code Home" <> '')) THEN
                        MESSAGE('Molimo Vas da izvrsite opciju brisanja ostalih podataka za kontakt informacije!');
                    "Full Phone No." := '';
                END;

            end;
        }
        modify("Mobile Phone No.")
        {
            trigger OnAfterValidate()
            begin
                CLEAR(CheckInt);

                IF "Mobile Phone No." <> '' THEN BEGIN

                    IF ((NOT EVALUATE(CheckInt, (COPYSTR("Mobile Phone No.", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Mobile Phone No.", 5, 4))) OR (COPYSTR("Mobile Phone No.", 4, 1) <> ' '))
                      THEN
                        IF (COPYSTR("Mobile Phone No.", 4, 1) <> ' ')
                          THEN
                            ERROR(Text016, COPYSTR("Mobile Phone No.", 4, 1), 'razmak')
                        ELSE
                            ERROR(Text017, "Mobile Phone No.")
                    ELSE
                        "Full Mobile Phone No." := "Country/Region Code Mobile" + ' ' + "Dial Code Mobile" + ' ' + "Mobile Phone No.";
                END
                ELSE BEGIN
                    IF (("Country/Region Code Mobile" <> '') OR ("Dial Code Mobile" <> '')) THEN
                        MESSAGE('Molimo Vas da izvrsite opciju brisanja ostalih podataka za kontakt informacije!');
                    "Full Mobile Phone No." := '';

                END;
            END;
        }

        field(50121; "Contribution Category Code"; Code[10])
        {
            Caption = 'Contribution Category Code';
            TableRelation = "Contribution Category";
        }

        field(52224; "Sector Code"; Code[10])
        {
            Caption = 'Sector Code';
        }

        field(50277; "Modified Employee No."; text[1000])

        {
            Caption = 'Modified Employee No.';
        }

        field(50280; Order; Integer)
        {

        }
        field(50190; "Active Driver"; Boolean)
        {
            Caption = 'Active Driver';
        }
        field(50204; "Year1"; Boolean)
        {
            Caption = 'Year1';
        }
        field(50205; "Year 2"; Boolean)
        {
            Caption = 'Year2';
        }
        field(50206; "Year3"; Boolean)
        {
            Caption = 'Year3';
        }
        field(50209; "Year4"; Boolean)
        {
            Caption = 'Year4';
        }
        field(50264; "Blood Donation History"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Diseases" WHERE("Employee No." = FIELD("No."), Types = filter("Employee Bood Donations")));
            Caption = 'Blood Donation History';
            Editable = false;

        }
        field(52000; "Level of Graduation"; Integer)
        {
            Caption = 'Level of Graduation';
        }
        field(50266; "Employee Qualifications"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Qualification" WHERE("Employee No." = FIELD("No."),
                                                               Switch = filter(Certification)));
            Caption = 'Employee Qualifications';
            Editable = false;

        }
        field(50265; "Employee Languages"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Qualification" WHERE("Employee No." = FIELD("No."), Switch = filter(Languages)));
            Caption = 'Employee Languages';
            Editable = false;

        }
        field(50267; "Employee Computer Knowledge"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Qualification" WHERE("Employee No." = FIELD("No."),
                                                                 Switch = filter('Computer Knowledge')));
            Caption = 'Employee Computer Knowledge';
            Editable = false;

        }
        field(50263; "Employee Diseases"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Diseases" WHERE("Employee No." = FIELD("No."), Types = filter("Employee Diseases")));
            Caption = 'Employee Diseases';
            Editable = false;

        }
        field(503570; Regres; Option)
        {
            Caption = 'Regres';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ",Yes,No;
        }

        field(503562; "Regres Date"; Date)
        {
            Caption = 'Regres date';
        }
        field(50274; "Employment Abroad Remark"; Text[150])
        {
            Caption = 'Employment Abroad Remark';
        }
        field(52333; Remark; text[300])
        {
            caption = 'Remark';
        }

        field(50207; "Employee Category"; Option)
        {
            Caption = 'Employee Category';
            OptionCaption = 'Resident,Non-Resident';
            OptionMembers = "Resident","Non-Resident";
        }

        field(50232; "Additional Work Activity"; Boolean)
        {
            Caption = 'Additional Work Activity';
            Editable = false;
        }
        field(50233; "Additional Work Activity Code"; Code[20])
        {
            Caption = 'Additional Work Activity Code';
            Editable = false;
        }
        field(503559; "Country/Region Code Emergency"; Code[10])
        {
            TableRelation = "Country/Region"."Country Code";
            ValidateTableRelation = false;


            trigger OnValidate()
            begin
                Country_Region.Reset();
                Country_Region.SetFilter("Country Code", '%1', "Country/Region Code Emergency");
                if not Country_Region.FindFirst() then
                    Error('Molimo Vas da popunite podatak u odabranoj državi!');

                IF ("Country/Region Code Emergency" <> '') AND ("Dial Code Emergency" <> '') AND ("Phone No. Emergency" <> '') THEN BEGIN
                    "Tel. No. Of Related Person" := "Country/Region Code Emergency" + ' ' + "Dial Code Emergency" + ' ' + "Phone No. Emergency";
                END
                ELSE BEGIN
                    "Tel. No. Of Related Person" := '';
                END;


            end;
        }
        field(503560; "Dial Code Emergency"; Code[10])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Home"));

            trigger OnValidate()
            begin
                //"Full Phone No.":="Country/Region Code Home"+' '+"Dial Code Home"+' '+"Phone No.";
                IF ("Country/Region Code Emergency" <> '') AND ("Dial Code Emergency" <> '') AND ("Phone No. Emergency" <> '') THEN BEGIN

                    "Tel. No. Of Related Person" := "Country/Region Code Emergency" + ' ' + "Dial Code Emergency" + ' ' + "Phone No. Emergency";
                END
                ELSE BEGIN
                    "Tel. No. Of Related Person" := '';
                END;
            end;
        }
        field(503561; "Phone No. Emergency"; Text[8])
        {
            Caption = 'Mobile Phone No. for Company';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                CLEAR(CheckInt);
                IF "Phone No. Emergency" <> '' THEN BEGIN


                    IF ((NOT EVALUATE(CheckInt, (COPYSTR("Phone No. Emergency", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Phone No. Emergency", 5, 4))) OR (COPYSTR("Phone No. Emergency", 4, 1) <> ' '))
                      THEN
                        IF (COPYSTR("Phone No. Emergency", 4, 1) <> ' ')
                           THEN
                            ERROR(Text016, COPYSTR("Phone No. Emergency", 4, 1), 'razmak')
                        ELSE
                            ERROR(Text017, "Phone No. Emergency")
                    ELSE BEGIN
                        IF ("Country/Region Code Emergency" <> '') AND ("Dial Code Emergency" <> '') AND ("Phone No. Emergency" <> '') THEN BEGIN

                            "Tel. No. Of Related Person" := "Country/Region Code Emergency" + ' ' + "Dial Code Emergency" + ' ' + "Phone No. Emergency";
                        END
                        ELSE BEGIN
                            "Tel. No. Of Related Person" := '';
                        END;

                    END;

                END
                ELSE BEGIN

                    IF (("Country/Region Code Emergency" <> '') OR ("Dial Code Emergency" <> '')) THEN
                        MESSAGE('Molimo Vas da izvrsite opciju brisanja ostalih podataka za kontakt informacije!');
                    "Tel. No. Of Related Person" := '';
                END;
            end;
        }
        field(50254; "Relationship with Related Per."; Text[30])
        {
            Caption = 'Relationship with Related Per.';
        }
        field(50234; "Additional Work Activity Res."; Text[30])
        {
            Caption = 'Additional Work Activity Res.';
            Editable = false;
        }
        field(50235; "Add. Work Activity Remark"; Text[100])
        {
            Caption = 'Add. Work Activity Remark';
            Editable = false;
        }
        field(50253; "Company Mobile Phone No."; Text[30])
        {
            Caption = 'Company Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
            FieldClass = Normal;

        }
        field(503557; "Dial Code Company Mobile"; Code[10])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Company M"),
                                                    Type = FILTER(Mobile));

            trigger OnValidate()
            begin
                //"Full Phone No.":="Country/Region Code Home"+' '+"Dial Code Home"+' '+"Phone No.";
                IF ("Country/Region Code Company M" <> '') AND ("Dial Code Company Mobile" <> '') AND ("Mobile Phone No. for Company" <> '') THEN BEGIN
                    "Company Mobile Phone No." := "Country/Region Code Company M" + ' ' + "Dial Code Company Mobile" + ' ' + "Mobile Phone No. for Company";
                END
                ELSE BEGIN
                    "Company Mobile Phone No." := '';
                END;
            end;
        }
        field(50348; "E-mail user"; Text[30])
        {
            Caption = 'E-mail user';

            trigger OnValidate()
            var
                Comp: Record "Company Information";
            begin
                Comp.get;

                Employee.RESET;
                Employee.SETFILTER("Company E-Mail", "E-mail user" + Comp."Ekstenzija za e-mail");
                IF Employee.FINDFIRST THEN BEGIN
                    ERROR(Text014);
                    //"Company E-Mail":="E-mail user"+'1'+'@raiffeisengroup.ba';
                END
                ELSE BEGIN
                    "Company E-Mail" := "E-mail user" + Comp."Ekstenzija za e-mail";
                    EmployeeSurname.SETFILTER("No.", '%1', "No.");
                    EmployeeSurname.SETFILTER("Last Name", '%1', Rec."Last Name");
                    IF EmployeeSurname.FIND('-') THEN BEGIN
                        EmployeeSurname.VALIDATE("Old Email Adress", xRec."Company E-Mail");
                        EmployeeSurname.VALIDATE("New Email Adress", Rec."Company E-Mail");
                        EmployeeSurname.MODIFY;
                    END;
                END;

                /*******************************************CHANGE SURNAME***********************************************/

                EmployeeSurname.SETFILTER("No.", '%1', Rec."No.");
                IF EmployeeSurname."Old Email Adress" <> '' THEN BEGIN
                    EmailBodyText += '<p><span style="font-size: 9.0pt; font-family: "Tahoma">Po&scaron;tovani,';
                    EmailBodyText += '<br /> <br /> Molim da poduzmete sve aktivnosti iz svoje nadležnosti u vezi sa promjenom prezimena navedene osobe.  ';
                    EmailBodyText += '<br /> <br />';


                    EmailBodyText += '<br /> <br />';
                    EmailBodyText += '<table cellpadding="5" style="border-collapse: collapse; border-left: solid 1px black; " border="1">';
                    //EmailBodyText += '<tr style="Border:solid 1px black;"><span style="font-size: 10.0pt;">';
                    EmailBodyText += '<tr style="Border:solid 1px black;">';
                    EmailBodyText += '<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><strong><span style="font-size: 10.0pt;"> &nbsp;DOSIJE&nbsp</strong></td>';
                    EmailBodyText += ' <td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" > <strong><span style="font-size: 10.0pt;"> STARO IME I PREZIME&nbsp</strong></td>';
                    EmailBodyText += '<td  width="250" style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; STARA E-MAIL ADRESA &nbsp</strong> </td>';
                    EmailBodyText += '<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;"> NOVO PREZIME I IME &nbsp</strong></td>';
                    EmailBodyText += '<td style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;NOVA E-MAIL ADRESA&nbsp;</strong></td>';
                    EmailBodyText += '<td style="border-bottom:solid 1px black;width:250px" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp;   ROLA   &nbsp;&nbsp;&nbsp;</strong></td>';
                    EmailBodyText += '<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF" align="center" ><strong><span style="font-size: 10.0pt;">&nbsp; Neposredni  &nbsp; rukovodilac&nbsp</strong></td>';
                    EmailBodyText += '</tr>';


                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", Rec."No.");
                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        EmployeeContractLedger.CALCFIELDS("Manager 1 First Name", "Manager 1 Last Name");
                        EmployeeContractLedger.CALCFIELDS("Manager 2 First Name", "Manager 2 Last Name");
                        ManagerFull := EmployeeContractLedger."Manager 1 First Name" + ' ' + EmployeeContractLedger."Manager 1 Last Name";
                        IF EmployeeContractLedger."Manager 1 First Name" = '' THEN
                            ManagerFull := EmployeeContractLedger."Manager 2 First Name" + ' ' + EmployeeContractLedger."Manager 2 Last Name";
                    END;


                    PositionMenuOrginal.RESET;
                    PositionMenuOrginal.SETFILTER(Code, '%1', EmployeeContractLedger."Position Code");
                    PositionMenuOrginal.SETFILTER(Description, '%1', EmployeeContractLedger."Position Description");
                    PositionMenuOrginal.SETFILTER("Org. Structure", '%1', EmployeeContractLedger."Org. Structure");
                    IF PositionMenuOrginal.FINDFIRST THEN BEGIN
                        //    RoleCode := PositionMenuOrginal.Role;
                        //      RoleName := PositionMenuOrginal."Role Name";
                    END;

                    OldPrezime.RESET;
                    OldPrezime.SETFILTER("No.", '%1', Rec."No.");
                    OldPrezime.SETFILTER(Old, '%1', TRUE);
                    OldPrezime.SETCURRENTKEY(LineNo);
                    OldPrezime.ASCENDING;
                    IF OldPrezime.FINDLAST THEN BEGIN

                        Staro := OldPrezime."Last Name";
                    END;

                    EmailBodyText += '<tr>';

                    EmailBodyText += STRSUBSTNO('<td style="border-left:solid 0px black;" style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Rec."Internal ID");
                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', Staro + ' ' + Rec."First Name");
                    EmailBodyText += STRSUBSTNO('<td  width="250" style="border-bottom:solid 1px black;width:200px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', EmployeeSurname."Old Email Adress");
                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', EmployeeSurname."Last Name" + ' ' + Rec."First Name");
                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black;width:200px" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', EmployeeSurname."New Email Adress");
                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black;width:200px"  bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', RoleCode + '-' + RoleName);
                    EmailBodyText += STRSUBSTNO('<td style="border-bottom:solid 1px black" bgcolor="#FFFFFF"><span style="font-size: 10.0pt;">%1</td>', ManagerFull);
                    EmailBodyText += '</tr>';

                    EmailBodyText += '</table>';
                    HRSetup.GET;
                    IF (HRSetup."E-mail Receiver" <> '') AND (HRSetup."E-mail Sender" <> '') THEN BEGIN

                        Recipients.Add(HRSetup."E-mail Receiver");

                        SMTPMail.CreateMessage(HRSetup."Sender Name", HRSetup."E-mail Sender", Recipients, 'Obavijest o promjeni prezimena ', EmailBodyText);
                        SMTPMail.Send();
                    END;
                END;

            end;
        }
        field(503558; "Mobile Phone No. for Company"; Text[8])
        {
            Caption = 'Mobile Phone No. for Company';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                CLEAR(CheckInt);
                IF "Mobile Phone No. for Company" <> '' THEN BEGIN


                    IF ((NOT EVALUATE(CheckInt, (COPYSTR("Mobile Phone No. for Company", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Mobile Phone No. for Company", 5, 4))) OR (COPYSTR("Mobile Phone No. for Company", 4, 1) <> ' '))
                      THEN
                        IF (COPYSTR("Mobile Phone No. for Company", 4, 1) <> ' ')
                          THEN
                            ERROR(Text016, COPYSTR("Mobile Phone No. for Company", 4, 1), 'razmak')
                        ELSE
                            ERROR(Text017, "Mobile Phone No. for Company")
                    ELSE BEGIN
                        IF ("Country/Region Code Company M" <> '') AND ("Dial Code Company Mobile" <> '') AND ("Mobile Phone No. for Company" <> '') THEN BEGIN
                            "Company Mobile Phone No." := "Country/Region Code Company M" + ' ' + "Dial Code Company Mobile" + ' ' + "Mobile Phone No. for Company";
                        END
                        ELSE BEGIN
                            "Company Mobile Phone No." := '';
                        END;
                    END;
                END
                ELSE BEGIN

                    IF (("Country/Region Code Company M" <> '') OR ("Dial Code Company Mobile" <> '')) THEN
                        MESSAGE('Molimo Vas da izvrsite opciju brisanja ostalih podataka za kontakt informacije!');

                    "Company Mobile Phone No." := '';
                END;
            end;
        }

        field(503556; "Country/Region Code Company M"; Code[10])
        {
            TableRelation = "Country/Region"."Country Code";

            ValidateTableRelation = false;


            trigger OnValidate()
            begin
                Country_Region.Reset();
                Country_Region.SetFilter("Country Code", '%1', "Country/Region Code Company M");
                if not Country_Region.FindFirst() then
                    Error('Molimo Vas da popunite podatak u odabranoj državi!');

                IF ("Country/Region Code Company M" <> '') AND ("Dial Code Company Mobile" <> '') AND ("Mobile Phone No. for Company" <> '') THEN BEGIN
                    "Company Mobile Phone No." := "Country/Region Code Company M" + ' ' + "Dial Code Company Mobile" + ' ' + "Mobile Phone No. for Company";
                END
                ELSE BEGIN
                    "Company Mobile Phone No." := '';
                END;

            end;
        }
        field(503572; "Employee with 2 JIB"; Boolean)
        {
            Caption = 'Employee with 2 JIB';
            trigger OnValidate()
            begin

            end;
        }
        field(50345; "Default Dimension Name"; Text[300])
        {

            FieldClass = FlowField;
            CalcFormula = Lookup("Dimension Value".Name WHERE(Code = FIELD("Default Dimension")));

            //Lookup("Dimension Value".Name WHERE (Code=FIELD(Default Dimension)))
            Caption = 'Default Dimension';
        }
        field(50276; "Employee Benefits"; Integer)
        {
            Caption = 'Employee Benefits';
            FieldClass = FlowField;
            CalcFormula = Count("Misc. Article Information" WHERE("Employee No." = FIELD("No."), Active = FILTER(true)));
        }
        /*   field(50340; "Job Violations"; Integer)
           {
               Caption = 'Job Violations';
               FieldClass = FlowField;
               CalcFormula = Count("Work Duties Violation" WHERE("Employee No." = FIELD("No.")));

           }
           field(503573; "Disciplinary Measured"; Integer)
           {
               Caption = 'Disciplinary Measured';
               FieldClass = FlowField;
               CalcFormula = Count("Work Duties Violation" WHERE("Employee No." = FIELD("No."), "Page Type" = FILTER('Disciplinary measures')));
           }

           field(503574; "Awards"; Integer)
           {
               Caption = 'Awards';
               FieldClass = FlowField;
               CalcFormula = Count("Work Duties Violation" WHERE("Employee No." = FIELD("No."), "Page Type" = FILTER('Awards')));
           }

           field(503586; "Clauses"; Integer)
           {
               Caption = 'Clauses';
               FieldClass = FlowField;
               CalcFormula = Count("Work Duties Violation" WHERE("Employee No." = FIELD("No."), "Page Type" = FILTER('Clauses')));
           }*/

        field(50350; "Role Code"; Code[20])
        {
            Caption = 'Role Code';
            FieldClass = FlowField;
            CalcFormula = Lookup(Position.Role WHERE(Code = FIELD("Position Code")));
        }
        //Lookup(Position."Role Name" WHERE (Role=FIELD(Role Code)))
        /*     field(50351; "Role Name"; Text[250])
             {
                 Caption = 'Role Description';
                 FieldClass = FlowField;
                 CalcFormula = Lookup(Position."Role Name" WHERE(Role = FIELD("Role Code")));
             }*/
        field(50270; "Benefit Coefficient"; decimal)
        {
            trigger OnValidate()

            begin

                WS.GET;

                IF WS."Base Tax Deduction" <> 0 THEN BEGIN



                    IF (("Contribution Category Code" = 'FBIH') OR ("Contribution Category Code" = 'FBIHRS')) THEN
                        "Tax Deduction Amount" := "Benefit Coefficient" * WS."Base Tax Deduction";

                    IF (("Contribution Category Code" = 'RS')) THEN
                        "Tax Deduction Amount" := "Benefit Coefficient" * WS."Base Tax Deduction RS";

                    IF (("Contribution Category Code" = 'BDPIOFBIH') OR ("Contribution Category Code" = 'BDPIORS')) THEN
                        "Tax Deduction Amount" := "Benefit Coefficient" * WS."Base Tax Deduction BD";



                END;

                ECL.SETFILTER("Employee No.", '%1', "No.");
                ECL.SETFILTER(Active, '%1', TRUE);
                IF ECL.FIND('-') THEN
                    ECL.VALIDATE(Brutto, ECL.Brutto);


            end;

        }


        field(50175; "Age"; Integer)
        {
            Caption = 'Age';
        }
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                DayOfWeekInput := 1;
                WeekOfYearInput := 1;
                Age := ROUND((TODAY - "Birth Date") / 365.2425, 1, '<');
            end;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                companyInf: record "Company Information";

            begin
                IF "No." <> xRec."No." THEN BEGIN
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series" := '';
                END;





            end;
        }


        field(50341; "Default Dimension"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Default Dimension"."Dimension Value Code" WHERE("No." = FIELD("No.")));
            Caption = 'Default Dimension';

        }

        field(50248; "Mother Maiden Name"; Text[30])
        {
            Caption = 'Mother Maiden Name';
            Editable = false;
        }
        field(50247; "Mother Name"; Text[61])
        {
            Caption = 'Mother Name';
            Editable = false;
        }
        field(50238; "Chronic Disease"; Boolean)
        {
            Caption = 'Chronic Disease';
        }
        field(50118; "Tax Deduction Amount"; Decimal)
        {
            Caption = 'Tax Deduction Amount';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                WS.GET;

                IF WS."Base Tax Deduction" <> 0 THEN BEGIN



                    IF (("Contribution Category Code" = 'FBIH') OR ("Contribution Category Code" = 'FBIHRS')) THEN
                        "Benefit Coefficient" := "Tax Deduction Amount" / WS."Base Tax Deduction";

                    IF (("Contribution Category Code" = 'RS')) THEN
                        "Benefit Coefficient" := "Tax Deduction Amount" / WS."Base Tax Deduction RS";

                    IF (("Contribution Category Code" = 'BDPIOFBIH') OR ("Contribution Category Code" = 'BDPIORS')) THEN
                        "Benefit Coefficient" := "Tax Deduction Amount" / WS."Base Tax Deduction BD";



                END;

            end;
        }
        field(50116; "For Calculation"; Boolean)
        {
            Caption = 'For Calculation';
        }
        field(50174; "Old Employee No."; Code[20])
        {
            Caption = 'Old Employee No.';

            trigger OnValidate()
            var
                HumanResSetup: Record "Human Resources Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(50128; "School of Graduation"; Text[100])
        {
            Caption = 'School of Graduation';
        }
        field(50129; "Major of Graduation"; Text[100])
        {
            Caption = 'Major of Graduation';
        }
        field(50130; "Post Graduate Study"; Text[100])
        {
            Caption = 'Post Graduate Study';
        }
        field(50131; "Related Person to be informed"; Text[50])
        {
            Caption = 'Related Person to be informed';
        }
        field(50132; "Tel. No. Of Related Person"; Text[30])
        {
            Caption = 'Tel. No. Of Related Person';
        }
        field(50133; "Blood Type"; Option)
        {
            Caption = 'Blood Type';
            OptionCaption = 'Unknown,A+,A-,B+,B-,AB+,AB-,0+,0-';
            OptionMembers = Unknown,"A+","A-","B+","B-","AB+","AB-","0+","0-";
        }
        field(50134; Size; Integer)
        {
            Caption = 'Size';
            MaxValue = 100;
            MinValue = 20;
        }
        field(50140; "Clothing size"; Option)
        {
            Caption = 'Clothing Size';
            OptionCaption = ' ,XS,S,M,L,XL,XXL,XXXL,XXXXL';
            OptionMembers = " ",XS,S,M,L,XL,XXL,XXXL,XXXXL;
        }
        field(50135; "Shoe size"; Integer)
        {
            Caption = 'Shoe size';
            MaxValue = 100;
            MinValue = 20;
        }
        field(50180; "Salesperson Code"; Code[10])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50136; Branch; Text[50])
        {
            Caption = 'Branch';
        }
        field(50137; "Place of birth"; Text[30])
        {
            Caption = 'Place of birth';
        }

        field(50058; "Job Position"; Text[50])
        {
            Caption = 'Job Position';
            Editable = false;
            //ĐK   TableRelation = Position;
        }
        field(50138; "Marital status"; Option)
        {
            Caption = 'Marital status';
            NotBlank = false;
            OptionCaption = ' ,Married,Single,Divorced,Widowed,Separated';
            OptionMembers = " ",M,S,D,W,P;
        }

        field(50150; "Position Code"; Code[20])
        {


            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Position Code" where("Employee No." = FIELD("No."), Active = const(true)));

        }
        field(50198; "Transport Allowance"; Boolean)
        {
            Caption = 'Transport Allowance';

            trigger OnValidate()
            var
                MiscArticleInformation2: Record "Misc. article information";
            begin
                //HR01
                IF "Transport Allowance" = TRUE THEN BEGIN
                    TESTFIELD("Post Code CIPS");
                    HRSetup.GET;

                    MAI.SETFILTER("Misc. Article Code", '%1', format(HRSetup."Company Car Code"));
                    MAI.SETFILTER("Employee No.", '%1', "No.");
                    IF NOT MAI.FIND('-') THEN BEGIN
                        PostCode.SETFILTER(Code, '%1', "Post Code CIPS");
                        IF PostCode.FIND('-') THEN BEGIN
                            // "Transport Amount":=PostCode."Transport Amount";
                            "Transport Amount Planned" := PostCode."Transport Amount";
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Text006);
                    END
                END
                ELSE BEGIN
                    //"Transport Amount":=0;
                    "Transport Amount Planned" := 0;
                END;
                //HR01

                //SD start
                MiscArticleInformation2.Reset();
                MiscArticleInformation2.SETFILTER("Employee No.", '%1', "No.");
                MiscArticleInformation2.SETFILTER("Misc. Article Code", '%1', '1');
                IF MiscArticleInformation2.FINDFIRST THEN
                    ERROR(Text011);
                //SD end
            end;
        }
        field(50003; "Operator No."; Code[15])
        {
            Caption = 'Operator No.';
            Editable = false;
        }
        field(50111; "Bank No."; Code[20])
        {
            Caption = 'Bank No.';
            TableRelation = "Wage/Reduction Bank".Code;
        }
        field(50113; "Bank Account Code"; Code[20])
        {
            Caption = 'Bank Account Code';
            TableRelation = "Wage/Reduction Bank Accounts"."No." where("Bank Code" = Field("Bank No."));
            trigger OnValidate()
            var
                myInt: Integer;
                EmpAcc: record employee;
            begin
                EmpAcc.RESET;
                EmpAcc.SETFILTER("Bank Account Code", '%1', "Bank Account Code");
                IF EmpAcc.FIND('-') THEN BEGIN


                    "Bank Account No." := "Bank Account Code";

                END
                ELSE BEGIN
                    "Bank Account No." := "Bank Account Code";
                END;

            end;
        }
        field(110; "Party No."; Code[20])
        {
            Caption = 'Party No.';
        }


        field(50122; "Contracted Work"; Boolean)
        {
            CalcFormula = Lookup("Wage Type".Contract WHERE(Code = FIELD("Wage Type")));
            Caption = 'Contracted Work';
            FieldClass = FlowField;
        }
        field(50103; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity.Code;
        }

        field(50000; "Employee ID"; Code[13])
        {
            Caption = 'Employee ID';
            trigger onvalidate()
            var
                myInt: Integer;
                Employee1: Record Employee;
                Text007: Label 'There is already an employee with that Employee ID.';
                LengthJMBG: Integer;
                Text013: Label 'JMBG can not be shorter than 13 characters.';

            begin
                Employee1.RESET;
                Employee1.SETFILTER("Employee ID", "Employee ID");
                Employee1.SetFilter("No.", '<>%1', Rec."No.");
                IF Employee1.FINDFIRST THEN BEGIN
                    IF "Employee with 2 JIB" = FALSE THEN
                        ERROR(Text007);
                END;
                LengthJMBG := STRLEN("Employee ID");
                IF LengthJMBG < 13 THEN
                    ERROR(Text013);


            end;
        }
        field(50144; "ID No."; Code[20])
        {
            Caption = 'ID No.';
        }
        field(50219; "Send PayList"; Boolean)
        {
            Caption = 'Send Paylist on Mail';
        }
        field(50145; "ID Issued in"; Text[30])
        {
            Caption = 'ID Issued in';
        }
        field(50146; "Passport No."; Text[30])
        {
            Caption = 'Passport No.';
        }
        field(50147; "Driving Licence"; Boolean)
        {
            Caption = 'Driving Licence';
        }
        field(50148; "Driving Llicence Category"; Option)
        {
            Caption = 'Driving Llicence Category';
            OptionCaption = ' ,A1,A2,A,B,"B + E",C1,"C1 + E",C,"C + E",D,"D + E",F,G,H,M';
            OptionMembers = " ",A1,A2,A,B,"B + E",C1,"C1 + E",C,"C + E",D,"D + E",F,G,H,M;
        }
        field(70004; "Military rights"; Option)
        {
            Caption = 'Prava/dopunska prava boraca';
            OptionCaption = ' ,Borac,"Pripadnik boračke populacije","Šehidski status"';
            OptionMembers = " ",Borac,"Pripadnik boračke populacije","Šehidski status";
        }

        field(501656; Canton; Code[20])
        {
            TableRelation = "Canton";
        }
        /*  modify(County)
          {

             TableRelation = "Canton";
          }*/
        field(50162; "Inappropriate candidate"; Boolean)
        {
            Caption = 'Inappropriate candidate';

            trigger OnValidate()
            begin
                IF ("Inappropriate candidate" = TRUE) AND ("Potential Employee" = FALSE)
                THEN
                    ERROR(Text002);

                IF ("Inappropriate candidate" = TRUE) THEN
                    "Appropriate candidate" := FALSE
                ELSE
                    "Appropriate candidate" := TRUE;
            end;
        }
        field(50161; "Appropriate candidate"; Boolean)
        {
            Caption = 'Appropriate candidate';

            trigger OnValidate()
            begin
                IF ("Appropriate candidate" = TRUE) AND ("Potential Employee" = FALSE)
                THEN
                    ERROR(Text001);

                IF ("Appropriate candidate" = TRUE) THEN
                    "Inappropriate candidate" := FALSE
                ELSE
                    "Inappropriate candidate" := TRUE;
            end;
        }

        field(50343; Unions; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Diseases" WHERE("Employee No." = FIELD("No."), Types = filter("Union Employees")));
            Caption = 'Unions';

        }
        field(50315; "Incentive Current Month"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(FALSE),
                                                                     Incentive = Filter(TRUE),
                                                                     "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Incentive Current Month';

        }
        field(50316; "Regress Current Month"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(TRUE),
                                                                     "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Regress Current Month';

        }
        field(50317; "Incentive Cumulative"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(FALSE),
                                                                     Incentive = Filter(TRUE),
                                                                     "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Incentive Cumulative';

        }
        field(50318; "Regres Cumulative"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(TRUE),
                                                                     "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Regres Cumulative';

        }
        field(50319; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50320; "Incentive Current Month Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount Brutto" WHERE("Employee No." = FIELD("No."),
                                                                                Regres = Filter(FALSE),
                                                                                Incentive = Filter(TRUE),
                                                                                "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Incentive Current Month';

        }
        field(50321; "Regress Current Month Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Brutto WHERE("Employee No." = FIELD("No."),
                                                            Regres = Filter(TRUE),
                                                            "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Regress Current Month Brutto';

        }
        field(50322; "Incentive Cumulative Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total Cost" WHERE("Employee No." = FIELD("No."),
                                                                  Regres = Filter(FALSE),
                                                                  Incentive = Filter(TRUE),
                                                                  "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Incentive Cumulative Brutto';

        }
        field(50323; "Regres Cumulative Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total Cost" WHERE("Employee No." = FIELD("No."),
                                                                  Regres = Filter(TRUE),
                                                                  "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Regres Cumulative Brutto';

        }
        field(50324; "For Transfer"; Boolean)
        {
            Caption = 'For Tansfer';
        }
        field(50325; "Year Of Current Incentive"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Addition"."Year of Wage" WHERE("Employee No." = FIELD("No."),
                                                                       Regres = Filter(FALSE),
                                                                       Incentive = Filter(TRUE),
                                                                       "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Year Of Current Incentive';

        }
        field(50326; "Month Of Current Incentive"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Addition"."Month of Wage" WHERE("Employee No." = FIELD("No."),
                                                                        Regres = Filter(FALSE),
                                                                        Incentive = Filter(TRUE),
                                                                        "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Month Of Current Incentive';

        }
        field(50327; "Year Of Cumulative Incentive"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Addition"."Year of Wage" WHERE("Employee No." = FIELD("No."),
                                                                       Regres = Filter(FALSE),
                                                                       Incentive = Filter(TRUE),
                                                                       "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Year Of Current Incentive';

        }
        field(50328; "Number of Paid ncentives"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Addition" WHERE("Employee No." = FIELD("No."),
                                                       Regres = Filter(FALSE),
                                                       Incentive = Filter(TRUE),
                                                       "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Number of Paid Incentives';

        }
        field(50329; "Regres Payment Date"; Date)
        {
            CalcFormula = Lookup("Wage Addition"."Payment Date" WHERE("Employee No." = FIELD("No."),
                                                                       Regres = Filter(TRUE)));
            Caption = 'Regres Payment Date';
            FieldClass = FlowField;
        }
        field(50330; "Year Filter"; Integer)
        {
        }
        field(50331; "Date Filter 3"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(50332; "Bonus Current Month"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(FALSE),
                                                                     "Wage Addition Type" = FILTER('BON*'),
                                                                     "Closing Date" = FIELD("Date Filter 2")));
            Caption = 'Incentive Current Month';

        }
        field(50333; "Bonus Payment Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Wage Addition"."Payment Date" WHERE("Employee No." = FIELD("No."),
                                                                       Regres = Filter(FALSE),
                                                                       "Wage Addition Type" = FILTER('BON*')));
            Caption = 'Regres Payment Date';

        }
        field(50334; "Bonus Cumulative"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("No."),
                                                                     Regres = Filter(FALSE),
                                                                     "Wage Addition Type" = FILTER('BON*'),
                                                                     "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Bonus Cumulative';

        }
        field(50335; "Bonus Cumulative Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total Cost" WHERE("Employee No." = FIELD("No."),
                                                                  Regres = Filter(FALSE),
                                                                  "Wage Addition Type" = FILTER('BON*'),
                                                                  "Closing Date" = FIELD("Date Filter 3")));
            Caption = 'Incentive Cumulative Brutto';

        }
        field(50342; "Internal ID"; Integer)
        {
            Caption = 'Internal ID';

            trigger OnValidate()
            begin
                IF "Internal ID" <> 0 THEN BEGIN
                    employee2.RESET;
                    employee2.SETFILTER("Internal ID", '%1', "Internal ID");
                    IF employee2.FINDFIRST THEN
                        Message(Text018);
                END;
            end;
        }
        field(5200; "Salary ID"; Integer)
        {
            Caption = 'Salary ID';
            Editable = true;

            trigger OnValidate()
            begin
                IF "Salary ID" <> 0 THEN BEGIN
                    employee2.RESET;
                    employee2.SETFILTER("Salary ID", '%1', "Salary ID");
                    IF employee2.FINDFIRST THEN
                        Message(Text018);
                END;
            end;
        }
        field(50163; "Probation Period"; Boolean)
        {
            Caption = 'Probation Period';

            trigger OnValidate()
            begin
                /*IF "Probation Period"=FALSE THEN BEGIN
                  CLEAR("Probation Period Start");
                  CLEAR("Probation Period End");
                 END;   */

            end;
        }
        field(50164; "Probation Period Start"; Date)
        {
            Caption = 'Probation Period Start';
            Editable = true;
            Enabled = true;
        }
        field(50165; "Probation Period End"; Date)
        {
            Caption = 'Probation Period End';
        }
        field(50166; "Tax Individual"; Decimal)
        {
            Caption = 'Tax Individual';

            trigger OnValidate()
            begin
                VALIDATE("Tax Deduction Amount", "Additional Tax" + "Tax Individual" + "General Tax");
            end;
        }
        field(50167; "Additional Tax"; Decimal)
        {
            Caption = 'Additional Tax';

            trigger OnValidate()
            begin
                VALIDATE("Tax Deduction Amount", "Additional Tax" + "Tax Individual" + "General Tax");
            end;
        }
        field(50179; "Hard Work conditions"; Boolean)
        {
            Caption = 'Hard Work conditions';
        }
        field(50158; "Disabled Child"; Boolean)
        {
            Caption = 'Disabled Child';
        }
        field(50168; "General Tax"; Decimal)
        {
            Caption = 'General Tax';

            trigger OnValidate()
            begin
                VALIDATE("Tax Deduction Amount", "Additional Tax" + "Tax Individual" + "General Tax");
            end;
        }

        field(50160; "Invited to interview"; Boolean)
        {
            Caption = 'Invited to interview';

            trigger OnValidate()
            begin
                IF ("Invited to interview" = TRUE) AND ("Potential Employee" = FALSE)
                THEN
                    ERROR(Text005);
            end;
        }
        field(50152; "Potential Employee"; Boolean)
        {
            Caption = 'Potential Employee';

            trigger OnValidate()
            begin
                IF "Potential Employee" = FALSE
                THEN BEGIN
                    "Appropriate candidate" := FALSE;
                    "Inappropriate candidate" := FALSE;
                    "Invited to interview" := FALSE;
                END;
            end;
        }
        field(50157; "Disabled Person"; Boolean)
        {
            Caption = 'Disabled Person';
        }
        field(50117; "Tax Deduction"; Boolean)
        {
            Caption = 'Tax Deduction';
        }
        field(50154; "Years of Experience in Company"; Integer)
        {
            Caption = 'Years of Experience in Company';
        }
        field(50347; "Municipality Code for salary"; Code[10])
        {
            Caption = 'Municipality Code for salary';
        }
        field(50155; "Months of Exp. in Company"; Integer)
        {
            Caption = 'Months of Exp. in Company';
        }

        field(50231; "Union Member"; Boolean)
        {
            Caption = 'Union Member';
            Editable = false;
        }
        field(50262; "Blood Donor"; Boolean)
        {
            Caption = 'Blood Donor';
            //Editable = false;
        }
        field(50156; "Days of Experience in Company"; Integer)
        {
            Caption = 'Days of Experience in Company';
        }
        field(50104; "Years of Experience"; Integer)
        {
            Caption = 'Years of Experience';
        }
        field(50105; "Months of Experience"; Integer)
        {
            Caption = 'Months of Experience';
        }
        field(50106; "Days of Experience"; Integer)
        {
            Caption = 'Days of Experience';
        }

        field(50108; "Brought Years of Experience"; Integer)
        {
            Caption = 'Brought Years of Experience';

            trigger OnValidate()
            var
                myInt: Integer;

            begin



                //ĐK   reee.SendWait('{F5}');



            end;




        }
        field(50109; "Brought Months of Experience"; Integer)
        {
            Caption = 'Brought Months of Experience';
        }
        field(50110; "Brought Days of Experience"; Integer)
        {
            Caption = 'Brought Days of Experience';
        }
        field(50139; "Education Level"; Enum School)
        {
            Caption = 'Education level';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin



            end;
        }

        field(50120; "Wage Posting Group"; Code[10])
        {
            Caption = 'Wage Posting Group';
            TableRelation = "Wage Posting Groups";

            trigger OnValidate()
            var
                myInt: Integer;
                WPG: Record "Wage Posting Groups";
            begin
                WPG.Reset();
                WPG.SETFILTER(Code, '%1', "Wage Posting Group");
                IF WPG.FINDFIRST THEN
                    "Temporary Contract Type" := WPG."Temporary Contract Type";

            end;
        }
        field(50337; "Mail Status (Wellcome)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }
        field(50338; Wellcome; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Wellcome E-mail" WHERE(Code = FIELD("Position Code"),
                                                                   "Position ID" = FIELD("Position ID")));
            Caption = 'Wellcome E-mail';

        }
        field(50297; "Position ID"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Position ID" WHERE("Employee No." = FIELD("No."),
                                                                                 "Position Code" = FIELD("Position Code"),
                                                                                 Active = CONST(true)));
            Caption = 'Position ID';

        }
        field(50310; "E-learning app"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."E-learning application" WHERE(Code = FIELD("Position Code"),
                                                                          "Position ID" = FIELD("Position ID")));
            Caption = 'E-learning app:';

        }
        field(50311; "E-learning edu"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."E-learning education" WHERE(Code = FIELD("Position Code"),
                                                                        "Position ID" = FIELD("Position ID")));
            Caption = 'Compliance:';

        }

        field(50305; "Mail Status (E-learning app)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }
        field(50312; "On Boarding"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."On Boarding" WHERE(Code = FIELD("Position Code"),
                                                               "Position ID" = FIELD("Position ID")));
            Caption = 'On boarding';

        }
        field(50307; "Mail Status (On Boarding)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }

        field(50339; "Education Plan"; Option)
        {
            Caption = 'Education Plan';
            OptionCaption = ' ,In Progress,Completed';
            OptionMembers = " ","In Progress",Completed;
        }

        field(50100; "Municipality Code"; Code[10])
        {
            Caption = 'Municipality Code';
            TableRelation = Municipality where(type = filter(Regular));
        }
        field(50115; "Refer To Number"; Text[30])
        {
            Caption = 'Refer To Number';
        }
        field(50249; "Number of Children"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Relative" WHERE("Employee No." = FIELD("No."),
                                                           Relation = FILTER('Child')));
            Caption = 'Number of Children';
            Editable = false;

        }
        //ED 02 START
        field(50012; "Single parent/adopter"; Boolean)
        {
            Caption = 'Single parent/adopter';
        }
        //ED 02 END
        field(50251; "Relatives Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Employee Relative" WHERE("Relative's Employee No." = FILTER(<> ''),
                                                           "Employee No." = FIELD("No.")));
            Caption = 'Relatives Employees';
            Editable = false;

        }
        field(50250; "Spouse Name"; Text[61])
        {
            Caption = 'Spouse Name';
            Editable = false;
        }
        field(50125; Meal; Boolean)
        {
            Caption = 'Meal';
        }
        field(50124; "Transport Amount"; Decimal)
        {
            Caption = 'Transport Amount';
        }
        field(50126; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Code" WHERE("Employee No." = FIELD("No."), Active = FILTER(true)));
            //Department.Code WHERE (Type=FILTER(' '|Department))
        }
        field(50119; "Wage Type"; Code[10])
        {
            Caption = 'Wage Type';
            TableRelation = "Wage Type";
        }
        field(50123; "Hours In Day"; Integer)
        {
            Caption = 'Hours In Day';
        }
        field(50230; "Returned to Company"; Boolean)
        {
            Caption = 'Returned to Company';
        }
        field(50169; "Short Term Contract Start Date"; Date)
        {
            Caption = 'Short Term Contract Start Date';
        }
        field(50170; "Short Term Contract End Date"; Date)
        {
            Caption = 'Short Term Contract End Date';
        }
        field(50171; "Short Term Contract"; Boolean)
        {
            Caption = 'Short Term Contract';

            trigger OnValidate()
            begin
                /*
                IF "Short Term Contract"=FALSE THEN BEGIN
                  CLEAR("Short Term Contract Start Date");
                  CLEAR("Short Term Contract End Date");
                 END;
                 */

            end;
        }
        field(50159; "Documentation delivered"; Boolean)
        {
            Caption = 'Documentation delivered';
        }
        field(50107; "Work Experience Percentage"; Decimal)
        {
            Caption = 'Work Experience Percentage';
            DecimalPlaces = 3 : 3;
        }
        field(50153; "Potential Base Status"; Option)
        {
            Caption = 'Potential Base Status';
            OptionCaption = ' ,New,Fired, Suggested for improvement';
            OptionMembers = " ",New,Fired,"Suggested for improvement";
        }
        field(50268; "Title Code"; Code[10])
        {
            Caption = 'Title';
            Editable = false;
        }
        field(50210; "Title Description"; Text[120])
        {
            Caption = 'Naziv zvanja';

        }
        field(503564; "External employer Status"; Option)
        {
            Caption = 'External employer Status';
            OptionCaption = ' ,Active,Inactive,Unpaid,Terminated,On boarding';
            OptionMembers = " ",Active,Inactive,Unpaid,Terminated,"On boarding";

            trigger OnValidate()
            begin
                /*IF Status=3 THEN BEGIN
                
                WPConnSetup.FINDFIRST();
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.User_Status_Inactive';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@EmployeeNo', 200,1,50, "No.");
                comm.Parameters.Append(param);
                
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                
                END;*/

                /*IF Status=0 THEN BEGIN
                
                WPConnSetup.FINDFIRST();
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.User_Status_Activ';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@EmployeeNo', 200,1,50, "No.");
                comm.Parameters.Append(param);
                
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                
                END;*/



                /*nk EmployeeQualification.SETRANGE("Employee No.","No.");
                EmployeeQualification.MODIFYALL("Employee Status",Status);
                MODIFY;
                */

                /*WPConnSetup.FINDFIRST();
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Employee_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldEmployee_no', 200,1,30, xRec."No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Employee_no', 200,1,30, "No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Email', 200, 1, 30,"E-Mail");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@FirstName', 200, 1, 30,"First Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@LastName', 200, 1, 30, "Last Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Address', 200, 1, 30, Address);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PostCode', 200, 1, 30, "Post Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@City', 200, 1, 30, City);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PhoneNo', 200, 1, 30, "Phone No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Position', 200, 1, 30, "Position Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Sector', 200, 1, 10, "Department code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@ManagerNo', 200, 1, 30, "Manager No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Status', 200, 1, 30, Status);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EmploymentDate', 7,1,0, "Employment Date");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@InactiveDate', 7,1,0, "Inactive Date");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                */

            end;
        }
        field(50275; "Work Experience Document"; Code[20])
        {
            Caption = 'Work Experience Document';
            Editable = false;
        }
        field(50183; Vocation; Code[30])
        {
            Caption = 'Vocation';
            Editable = false;
        }
        field(50269; Profession; Code[10])
        {
            Caption = 'Profession';
            Editable = false;
        }
        field(50278; "Org Municipality"; Code[20])
        {
            Caption = 'Org Municipality';
        }
        field(50217; "Employee User Name"; Code[50])
        {
            Caption = 'Employee User Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(User."User Name" where("User Name" = field("Employee New User Name")));

            Editable = false;

            /*    FieldClass = FlowField;
                CalcFormula = lookup("User Setup"."User ID" where("Employee No." = FIELD("No.")));
                Editable = false;*/

        }

        field(50202; "Work Permit"; Boolean)
        {
            Caption = 'Work Permit';
            Editable = false;
        }
        field(50259; "Residence Permit"; Boolean)
        {
            Caption = 'Residence Permit';
            Editable = false;
        }
        field(50255; "Citizenship 1"; Code[20])
        {
            Caption = 'Citizenship 1';
            Editable = false;
        }
        field(50241; "City of Birth"; Text[30])
        {
            Caption = 'City of Birth';
            TableRelation = IF ("Country/Region Code of Birth" = FILTER('')) "Post Code".City
            ELSE
            IF ("Country/Region Code of Birth" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code of Birth"));

            trigger OnValidate()
            begin
                //   PostCode.ValidateCityBirth("City of Birth", "Country/Region Code of Birth", (CurrFieldNo <> 0) AND GUIALLOWED);
                "Place of birth" := "City of Birth";
            end;
        }
        field(50257; "Additional Passport No."; Text[30])
        {
            Caption = 'Additional Passport No.';
            Editable = false;
        }
        field(50272; "Professional Exam. Result"; Option)
        {
            Caption = 'Professional Exam. Result';
            OptionCaption = ' ,Passed,Failed';
            OptionMembers = " ",Passed,Failed;
        }
        field(50256; "Citizenship 2"; Code[20])
        {
            Caption = 'Citizenship 2';
            Editable = false;
        }
        field(50260; "Residence Permit Expiry Date"; Date)
        {
            Caption = 'Residence Permit';
            Editable = false;
        }
        field(50203; "Type Of Work Permit"; Option)
        {
            Caption = 'Type Of Work Permit';
            Editable = false;
            OptionCaption = ' ,Permanent Residence,Temporary Residence,Work Permit,White Card';
            OptionMembers = " ","Permanent Residence","Temporary Residence","Work Permit","White Card";
        }
        field(50261; "Work Permit Expiry Date"; Date)
        {
            Caption = 'Work Permit Expiry Date';
            Editable = false;
        }
        field(50240; "Country/Region Code of Birth"; Code[10])
        {
            Caption = 'Country/Region Code of Birth';
            TableRelation = "Country/Region".Code;
        }
        field(50191; Nationallity; Code[10])
        {
            Caption = 'Nationallity';
            Editable = false;
        }
        field(50211; "Current Years Total"; Integer)
        {
            Caption = 'Current Years Total';
            Editable = false;
        }
        field(50212; "Current Months Total"; Integer)
        {
            Caption = 'Current Months Total';
            Editable = false;
        }



        field(50192; "Brought Years of Exp. in Curr."; Integer)
        {
            Caption = 'Brought Years of Exp. in Curr.';
            Editable = false;
        }
        field(50193; "Brought Months of Exp.in Curr."; Integer)
        {
            Caption = 'Brought Month of Exp. in Curr.';
            Editable = false;
        }
        field(50194; "Brought Days of Exp.in Curr."; Integer)
        {
            Caption = 'Brought Days of Exp. in Curr.';
            Editable = false;
        }
        field(50195; "Brought Years Total"; Integer)
        {
            Caption = 'Brought Years Total';
            Editable = false;
        }
        field(50252; "Company Phone No."; text[30])
        {
            Caption = 'Company Phone No.';
        }
        field(50246; "Father Name"; Text[61])
        {
            Caption = 'Father Name';
            Editable = false;
        }
        field(503578; Header; Boolean)
        {
            Caption = 'Header';
        }
        field(503563; "Place Of Living"; Text[80])
        {
        }
        field(50300; "Country/Region Code Home"; Code[10])
        {
            TableRelation = "Country/Region"."Country Code";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                Country_Region.Reset();
                Country_Region.SetFilter("Country Code", '%1', "Country/Region Code Home");
                if not Country_Region.FindFirst() then
                    Error('Molimo Vas da popunite podatak u odabranoj državi!');
            end;

        }
        field(50349; Region; Integer)
        {
            BlankZero = true;
            Caption = 'Region';
        }
        field(50223; "Municipality Code CIPS"; Code[10])
        {
            Caption = 'Municipality Code (CIPS)';
            Editable = false;
        }
        field(50222; "Address CIPS"; Text[50])
        {
            Caption = 'Address (CIPS)';
            Editable = false;


            trigger OnValidate()
            begin
                /*WPConnSetup.FINDFIRST();
                CREATE(conn, TRUE, TRUE);
                
                conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                          +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                
                CREATE(comm,TRUE, TRUE);
                
                lvarActiveConnection := conn;
                comm.ActiveConnection := lvarActiveConnection;
                
                comm.CommandText := 'dbo.Employee_Update';
                comm.CommandType := 4;
                comm.CommandTimeout := 0;
                
                param:=comm.CreateParameter('@OldEmployee_no', 200,1,30, xRec."No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Employee_no', 200,1,30, "No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Email', 200, 1, 30,"E-Mail");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@FirstName', 200, 1, 30,"First Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@LastName', 200, 1, 30, "Last Name");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Address', 200, 1, 30, Address);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PostCode', 200, 1, 30, "Post Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@City', 200, 1, 30, City);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@PhoneNo', 200, 1, 30, "Phone No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Position', 200, 1, 30, "Position Code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Sector', 200, 1, 10, "Department code");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@ManagerNo', 200, 1, 30, "Manager No.");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@Status', 200, 1, 30, Status);
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@EmploymentDate', 7,1,0, "Employment Date");
                comm.Parameters.Append(param);
                param:=comm.CreateParameter('@InactiveDate', 7,1,0, "Inactive Date");
                comm.Parameters.Append(param);
                
                comm.Execute;
                conn.Close;
                CLEAR(conn);
                CLEAR(comm);
                */

            end;
        }
        field(50302; "Full Phone No."; Text[16])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50301; "Dial Code Home"; Code[10])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Home"),
                                                    "Type" = FILTER("Fixed"));

            trigger OnValidate()
            begin
                "Full Phone No." := "Country/Region Code Home" + ' ' + "Dial Code Home" + ' ' + "Phone No.";
            end;
        }

        field(50181; "Maiden Name"; Text[30])
        {
            Caption = 'Maiden Name';
        }
        field(50196; "Brought Months Total"; Integer)
        {
            Caption = 'Brought Months Total';
            Editable = false;
        }
        field(50236; "Internal Solidarity Fund"; Boolean)
        {
            Caption = 'Internal Solidarity Fund';
        }
        field(50282; "Int. Solidarity Fund Date To"; Date)
        {
            Caption = 'Int. Solidarity Fund Date To';

            trigger OnValidate()
            begin

                IF "Int. Solidarity Fund Date To" <> 0D THEN BEGIN
                    IF "Int. Solidarity Fund Date From" = 0D THEN
                        ERROR(Text008);
                    IF "Int. Solidarity Fund Date To" < "Int. Solidarity Fund Date From" THEN
                        ERROR(Text009);
                END;
            end;
        }
        field(50281; "Int. Solidarity Fund Date From"; Date)
        {
            Caption = 'Int. Solidarity Fund Date From';

            trigger OnValidate()
            begin
                IF "Int. Solidarity Fund Date To" <> 0D THEN BEGIN
                    IF "Int. Solidarity Fund Date From" = 0D THEN
                        ERROR(Text008);
                    IF "Int. Solidarity Fund Date To" < "Int. Solidarity Fund Date From" THEN
                        ERROR(Text009);
                END;
            end;
        }
        field(50304; "Temporary Contract Type"; Option)
        {
            Caption = 'Temporary Contract Type';
            FieldClass = Normal;
            OptionCaption = '  ,Temporary Contract,Temporary Contract 0,Temporary Contract Non-Residents,Author Contracts';
            OptionMembers = "  ","Temporary Contract","Temporary Contract 0","Temporary Contract Non-Residents","Author Contracts";
        }
        field(50221; "Calculate Wage Addition"; Boolean)
        {
            Caption = 'Calculate Wage Addition';
        }
        field(50271; "Professional Examination Date"; Date)
        {
            Caption = 'Professional Examination Date';
        }

        field(50285; "Last Operator No."; Code[1])
        {
            //CalcFormula = Lookup(User."Operator No." WHERE (Employee No.=FIELD(No.)));
            Caption = 'Last Operator No.';
            // FieldClass = FlowField;
        }

        field(50336; "Transport Amount Planned"; Decimal)
        {
            Caption = 'Transport Amount';
        }
        field(503579; StatusExt; enum "Employee Status Ext")

        {
            Caption = 'Status';

            trigger OnValidate()
            var
                WPConnSetup: Record "Web portal connection setup";
                VG: Record "Vacation Ground 2";
                ConnectionString: Text[1000];
                /*   SQLConn: DotNet SqlConnection2;
                   SQLCommand: DotNet SqlCommand2;
                   SQLParameter: DotNet SqlParameter2;
                   SQLDbType: DotNet DbType2;*/
                companyInf: Record "Company Information";
                emp: Record Employee;
                position_U: Integer;
                user_T: record User;
                username: Text[1000];
            begin

                companyInf.get;
                if companyInf.portal = true then begin
                    IF Status = Status::Terminated THEN BEGIN

                        WPConnSetup.FINDFIRST();
                        ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                        + 'Database=' + WPConnSetup.Database + ';'
                        + 'Uid=' + WPConnSetup.UID + ';'
                        + 'Pwd=' + WPConnSetup.Password + ';';
                        /*    SQLConn := SQLConn.SqlConnection(ConnectionString);
                            SQLConn.Open;
                            SQLCommand := SQLCommand.SqlCommand();

                            SQLCommand.CommandText := 'dbo.User_Status_Inactive';
                            SQLCommand.Connection := SQLConn;
                            SQLCommand.CommandType := 4;
                            SQLCommand.CommandTimeout := 0;


                            SQLParameter := SQLParameter.SqlParameter;
                            SQLParameter.ParameterName := '@EmployeeNo';
                            SQLParameter.DbType := SQLDbType.String;
                            SQLParameter.Direction := SQLParameter.Direction.Input;
                            SQLParameter.Value := Rec."No.";
                            SQLCommand.Parameters.Add(SQLParameter);



                            SQLCommand.ExecuteNonQuery;

                            SQLConn.Close;
                            SQLConn.Dispose;*/



                    END;


                    IF (((xRec.Status.AsInteger() = 3) OR (xRec.Status.AsInteger() = 4)) AND (Rec.Status.AsInteger() = 0)) THEN BEGIN
                        WB2.RESET;
                        WB2.SETFILTER("Employee No.", '%1', Rec."No.");
                        WB2.SETFILTER("Hours change", '%1', FALSE);
                        WB2.SETFILTER("Current Company", '%1', TRUE);
                        WB2.SETCURRENTKEY("Starting Date");
                        WB2.ASCENDING;
                        IF WB2.FINDLAST THEN BEGIN


                            IF WB2."Starting Date" = "Employment Date" THEN BEGIN
                                WPConnSetup.FINDFIRST();
                                ConnectionString := 'Server=' + WPConnSetup.Server + ';'
                                + 'Database=' + WPConnSetup.Database + ';'
                                + 'Uid=' + WPConnSetup.UID + ';'
                                + 'Pwd=' + WPConnSetup.Password + ';';
                                /*   SQLConn := SQLConn.SqlConnection(ConnectionString);
                                   SQLConn.Open;

                                   SQLCommand := SQLCommand.SqlCommand();

                                   SQLCommand.CommandText := 'dbo.User_Status_Activ';
                                   SQLCommand.Connection := SQLConn;
                                   SQLCommand.CommandType := 4;
                                   SQLCommand.CommandTimeout := 0;

                                   Emp.SETFILTER("No.", "No.");
                                   IF Emp.FINDFIRST THEN BEGIN

                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@EmployeeNo';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."No.";
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       position_U := STRPOS(user_T."User Name", '\');
                                       username := DELSTR(user_T."User Name", 1, position_U);


                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Username';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := LOWERCASE(username);
                                       SQLCommand.Parameters.Add(SQLParameter);



                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Role';
                                       SQLParameter.DbType := SQLDbType.Int32;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := 2;
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Email';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Company E-Mail";
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@FirstName';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."First Name";
                                       SQLCommand.Parameters.Add(SQLParameter);



                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@LastName';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Last Name";
                                       SQLCommand.Parameters.Add(SQLParameter);


                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Gender';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := format(Emp.Gender);
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Address';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Address CIPS";
                                       SQLCommand.Parameters.Add(SQLParameter);


                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@PhoneNo';
                                       SQLParameter.DbType := SQLDbType.String;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Company Phone No.";
                                       SQLCommand.Parameters.Add(SQLParameter);


                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@Status';
                                       SQLParameter.DbType := SQLDbType.Int32;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := emp.StatusExt.AsInteger();
                                       SQLCommand.Parameters.Add(SQLParameter);


                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@EmploymentDate';
                                       SQLParameter.DbType := SQLDbType.Date;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Employment Date";
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       SQLParameter := SQLParameter.SqlParameter;
                                       SQLParameter.ParameterName := '@HourNAV';
                                       SQLParameter.DbType := SQLDbType.Int32;
                                       SQLParameter.Direction := SQLParameter.Direction.Input;
                                       SQLParameter.Value := Emp."Hours In Day";
                                       SQLCommand.Parameters.Add(SQLParameter);

                                       SQLCommand.ExecuteNonQuery;

                                       SQLConn.Close;
                                       SQLConn.Dispose;

                                   END;
                               END
                               ELSE BEGIN
                                   ERROR('Datum zaposlenja na kartici zaposlenika ' + "No." + ' ' + FORMAT("Employment Date") + ' se razlikuje u odnosu na datum u radnoj knjižici ' + FORMAT(WB2."Starting Date"));

                               END;

                           END
                           ELSE BEGIN
                               ERROR('Zaposlenik nema trenutni datum zaposlenja');
                           END;
                       END;

                   end;
               end;*/
                            end;
                        end;
                    end;

                end;


            end;

        }
        field(50346; "Org Entity Code"; Code[10])
        {
            Caption = 'Org Entity Code';
        }

        field(50298; "Country/Region Code Mobile"; Code[10])
        {
            TableRelation = "Country/Region"."Country Code";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                Country_Region.Reset();
                Country_Region.SetFilter("Country Code", '%1', "Country/Region Code Mobile");
                if not Country_Region.FindFirst() then
                    Error('Molimo Vas da popunite podatak u odabranoj državi!');
            end;
        }
        field(50303; "Full Mobile Phone No."; Text[16])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }

        field(50299; "Dial Code Mobile"; Code[10])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Mobile"),
                                                    Type = FILTER(Mobile));

            trigger OnValidate()
            begin
                "Full Mobile Phone No." := "Country/Region Code Mobile" + ' ' + "Dial Code Mobile" + ' ' + "Mobile Phone No.";
            end;
        }

        field(50356; "Dial Code Company Home"; Code[10])
        {
            TableRelation = "Dial Codes"."No." WHERE("Country Code" = FIELD("Country/Region Code Company H"),
                                                    Type = FILTER("Fixed"));

            trigger OnValidate()
            begin
                //"Full Phone No.":="Country/Region Code Home"+' '+"Dial Code Home"+' '+"Phone No.";
                IF ("Country/Region Code Company H" <> '') AND ("Dial Code Company Home" <> '') AND ("Phone No. for Company" <> '') THEN BEGIN
                    "Company Phone No." := "Country/Region Code Company H" + ' ' + "Dial Code Company Home" + ' ' + "Phone No. for Company";
                END
                ELSE BEGIN
                    "Company Phone No." := '';
                END;
            end;
        }
        field(50357; "Phone No. for Company"; Text[8])
        {
            Caption = 'Phone No. for Company';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()
            begin
                CLEAR(CheckInt);
                IF "Phone No. for Company" <> '' THEN BEGIN


                    IF ((NOT EVALUATE(CheckInt, (COPYSTR("Phone No. for Company", 1, 3))) OR NOT EVALUATE(CheckInt, COPYSTR("Phone No. for Company", 5, 4))) OR (COPYSTR("Phone No. for Company", 4, 1) <> ' '))
                      THEN
                        IF (COPYSTR("Phone No. for Company", 4, 1) <> ' ')
                          THEN
                            ERROR(Text016, COPYSTR("Phone No. for Company", 4, 1), 'razmak')
                        ELSE
                            ERROR(Text017, "Phone No. for Company")
                    ELSE BEGIN
                        IF ("Country/Region Code Company H" <> '') AND ("Dial Code Company Home" <> '') AND ("Phone No. for Company" <> '')
                          THEN BEGIN
                            "Company Phone No." := "Country/Region Code Company H" + ' ' + "Dial Code Company Home" + ' ' + "Phone No. for Company";
                        END
                        ELSE BEGIN
                            "Company Phone No." := '';
                        END;
                    END;
                END
                ELSE BEGIN
                    IF (("Country/Region Code Company H" <> '') OR ("Dial Code Company Home" <> '')) THEN
                        MESSAGE('Molimo Vas da izvrsite opciju brisanja ostalih podataka za kontakt informacije!');
                    "Company Phone No." := '';
                END;
            end;
        }

        field(503555; "Country/Region Code Company H"; Code[10])
        {
            TableRelation = "Country/Region"."Country Code";

            ValidateTableRelation = false;


            trigger OnValidate()
            begin
                Country_Region.Reset();
                Country_Region.SetFilter("Country Code", '%1', "Country/Region Code Company H");
                if not Country_Region.FindFirst() then
                    Error('Molimo Vas da popunite podatak u odabranoj državi!');

                IF ("Country/Region Code Company H" <> '') AND ("Dial Code Company Home" <> '') AND ("Phone No. for Company" <> '') THEN BEGIN
                    "Company Phone No." := "Country/Region Code Company H" + ' ' + "Dial Code Company Home" + ' ' + "Phone No. for Company";
                END
                ELSE BEGIN
                    "Company Phone No." := '';
                END;
            end;
        }


        field(50197; "Brought Days Total"; Integer)
        {
            Caption = 'Brought Days Total';
            Editable = false;
        }
        field(50237; "External Solidarity Fund"; Boolean)
        {
            Caption = 'External Solidarity Fund';
        }
        field(50296; Associates; Boolean)
        {
            Caption = 'Associates';
        }
        field(50101; "Municipality Name"; Text[30])
        {
            Caption = 'Municipality Name';
            Editable = false;
        }
        field(50306; "Mail Status (E-learning edu)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }
        field(50314; Testing; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position.Test WHERE(Code = FIELD("Position Code"),
                                                      "Position ID" = FIELD("Position ID")));

        }
        field(50313; "Edu plan"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Position."Education plan" WHERE(Code = FIELD("Position Code"),
                                                                  "Position ID" = FIELD("Position ID")));

        }
        field(50309; "Mail Status (Testing)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }


        field(50308; "Mail Status (Education plan)"; Option)
        {
            Caption = 'Mail Status';
            OptionCaption = 'Not sent,Sent';
            OptionMembers = "Not sent",Sent;
        }
        field(50006; "Municipality Name CIPS"; Text[30])
        {
            Caption = 'Municipality Name CIPS';
            Editable = false;
        }
        field(50007; "City CIPS"; Text[30])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code CIPS" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code CIPS" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code CIPS"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //   PostCode.ValidateCity1("City CIPS", "Post Code CIPS", "Country/Region Code CIPS", (CurrFieldNo <> 0) AND GUIALLOWED);
                PostCode.RESET;
                PostCode.SETFILTER(City, "City CIPS");
                IF PostCode.FINDFIRST THEN BEGIN
                    VALIDATE("County Code CIPS", PostCode."Canton Code");
                    VALIDATE("Entity Code CIPS", PostCode."Entity Code");
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END;

            end;
        }
        field(50018; "County Code CIPS"; Code[10])
        {
            Caption = 'County Code CIPS';
            TableRelation = Canton."Code";

            trigger OnValidate()
            begin
                IF "County Code CIPS" <> '' THEN BEGIN
                    CantonR.RESET;
                    CantonR.SETFILTER(Code, "County Code CIPS");
                    IF CantonR.FINDFIRST THEN
                        "County CIPS" := CantonR.Description;
                    VALIDATE("Entity Code CIPS", CantonR."Entity Code");
                END ELSE BEGIN
                    "County CIPS" := '';
                    VALIDATE("Entity Code CIPS", '');
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        Employee."Place Of Living" := "Place Of Living";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        //  END;
                    END;
                END;

            end;
        }
        field(50293; Increment; Integer)
        {
            Caption = 'Stepen uvećanja';
        }
        field(50008; "Country/Region Code CIPS"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        // END;
                    END;
                END

            end;
        }
        field(50017; "County Code"; Code[10])
        {
            Caption = 'County Code';
            TableRelation = Canton.Code;

            trigger OnValidate()
            begin
                IF "County Code" <> '' THEN BEGIN
                    CantonR.RESET;
                    CantonR.SETFILTER(Code, "County Code");
                    IF CantonR.FINDFIRST THEN
                        County := CantonR.Description;
                    VALIDATE("Entity Code", CantonR."Entity Code");
                END ELSE BEGIN
                    County := '';
                    VALIDATE("Entity Code", '');
                END;

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Place Of Living" := "Place Of Living";
                        Employee."Country/Region Code" := "Country/Region Code";
                        /*Employee.MODIFY;
                        END
                        ELSE
                        IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        Employee.MODIFY;
                        // END;
                    END;
                END;

            end;
        }
        field(50019; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(50009; "Post Code CIPS"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code CIPS" = CONST()) "Post Code"
            ELSE
            IF ("Country/Region Code CIPS" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code CIPS"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                //  PostCode.ValidatePostCode1("City CIPS", "Post Code CIPS", "Country/Region Code CIPS", (CurrFieldNo <> 0) AND GUIALLOWED);
                PostCode.RESET;
                PostCode.SETFILTER(Code, "Post Code CIPS");
                IF PostCode.FINDFIRST THEN BEGIN
                    VALIDATE("County Code CIPS", PostCode."Canton Code");
                    VALIDATE("Entity Code CIPS", PostCode."Entity Code");
                END;


                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        IF "Address Type" = "Address Type"::Current THEN BEGIN
                            Employee.Address := Address;
                            Employee."Municipality Code" := "Municipality Code";
                            Employee."Municipality Name" := "Municipality Name";
                            Employee.City := City;
                            Employee."Place Of Living" := "Place Of Living";
                            Employee."Post Code" := "Post Code";
                            Employee.County := "County Code";
                            Employee."Entity Code" := "Entity Code";
                            Employee."Country/Region Code" := "Country/Region Code";
                            Employee.MODIFY;
                        END
                        ELSE
                            IF "Address Type" = "Address Type"::CIPS THEN BEGIN
                                Employee."Address CIPS" := "Address CIPS";
                                Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                                Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                                Employee."City CIPS" := "City CIPS";
                                Employee."Post Code CIPS" := "Post Code CIPS";
                                Employee."County CIPS" := "County Code CIPS";
                                Employee."Entity Code CIPS" := "Entity Code CIPS";
                                Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                                IF "Entity Code CIPS" = 'FBIH' THEN
                                    Employee."Contribution Category Code" := 'FBIH';
                                IF "Entity Code CIPS" = 'RS' THEN
                                    Employee."Contribution Category Code" := 'FBIHRS';
                                IF "Entity Code CIPS" = 'BD' THEN
                                    Employee."Contribution Category Code" := 'BDPIOFBIH';
                                Employee.MODIFY;
                            END;
                    END;
                END;

            end;
        }
        field(50010; "County CIPS"; Text[50])
        {
            Caption = 'County Name';
            Editable = false;
        }
        field(50283; "Ext. Solidarity Fund Date From"; Date)
        {
            Caption = 'Ext. Solidarity Fund Date From';

            trigger OnValidate()
            begin
                IF "Ext. Solidarity Fund Date To" <> 0D THEN BEGIN
                    IF "Ext. Solidarity Fund Date From" = 0D THEN
                        ERROR(Text008);
                    IF "Ext. Solidarity Fund Date To" < "Ext. Solidarity Fund Date From" THEN
                        ERROR(Text009);
                END;
            end;
        }
        field(50284; "Ext. Solidarity Fund Date To"; Date)
        {
            Caption = 'Ext. Solidarity Fund Date To';

            trigger OnValidate()
            begin
                IF "Ext. Solidarity Fund Date To" <> 0D THEN BEGIN
                    IF "Ext. Solidarity Fund Date From" = 0D THEN
                        ERROR(Text008);
                    IF "Ext. Solidarity Fund Date To" < "Ext. Solidarity Fund Date From" THEN
                        ERROR(Text009);
                END;
            end;
        }
        field(50024; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                /*
                Employee.GET("Employee No.");
                Name := Employee."Last Name";
                */

            end;
        }
        field(50004; "Address Type"; Option)
        {
            Caption = 'Address Type';
            OptionCaption = 'Current,CIPS,Both';
            OptionMembers = Current,CIPS," Both";
        }
        field(50011; "Entity Code CIPS"; Code[10])
        {
            Caption = 'Entity Code';
            TableRelation = Entity.Code;

            trigger OnValidate()
            begin
                IF "Entity Code CIPS" <> '' THEN BEGIN
                    "Address Type" := 1;
                    Entity.RESET;
                    Entity.SETFILTER(Code, "Entity Code CIPS");
                    IF Entity.FINDFIRST THEN
                        VALIDATE("Country/Region Code CIPS", Entity."Country/Region Code");
                END ELSE
                    VALIDATE("Country/Region Code CIPS", '');

                IF Active = TRUE THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        // IF "Address Type"="Address Type"::Current THEN BEGIN
                        Employee.Address := Address;
                        Employee."Municipality Code" := "Municipality Code";
                        Employee."Municipality Name" := "Municipality Name";
                        Employee.City := City;
                        Employee."Post Code" := "Post Code";
                        Employee.County := "County Code";
                        Employee."Entity Code" := "Entity Code";
                        Employee."Country/Region Code" := "Country/Region Code";
                        Employee."Place Of Living" := "Place Of Living";
                        /* Employee.MODIFY;
                         END
                         ELSE
                         IF "Address Type"="Address Type"::CIPS THEN BEGIN*/
                        Employee."Address CIPS" := "Address CIPS";
                        Employee."Municipality Code CIPS" := "Municipality Code CIPS";
                        Employee."Municipality Name CIPS" := "Municipality Name CIPS";
                        Employee."City CIPS" := "City CIPS";
                        Employee."Post Code CIPS" := "Post Code CIPS";
                        Employee."County CIPS" := "County Code CIPS";
                        Employee."Entity Code CIPS" := "Entity Code CIPS";
                        Employee."Country/Region Code CIPS" := "Country/Region Code CIPS";
                        IF "Entity Code CIPS" = 'FBIH' THEN
                            Employee."Contribution Category Code" := 'FBIH';
                        IF "Entity Code CIPS" = 'RS' THEN
                            Employee."Contribution Category Code" := 'FBIHRS';
                        IF "Entity Code CIPS" = 'BD' THEN
                            Employee."Contribution Category Code" := 'BDPIOFBIH';
                        Employee.MODIFY;
                        //END;
                    END;
                END;

            end;
        }
        field(50213; "Current Days Total"; Integer)
        {
            Caption = 'Current Days Total';
            Editable = false;
        }
        field(50258; "Work Booklet No."; Text[30])
        {
            Caption = 'Work Booklet No.';
            Editable = false;
        }
        field(50358; "Phisical Department Desc"; Text[30])
        {
            Caption = 'Department Description';
        }
        field(50279; "New Number"; Code[10])
        {
        }
        field(50294; "Org Dio"; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Department."ORG Dio");
            Caption = 'Org. Part';

        }

        field(503569; GF; Code[10])
        {
        }
        field(503568; "Org Jed"; Code[10])
        {
        }

        field(50359; "Brought Years of Experience 2"; Integer)
        {
            Caption = 'Brought Years of Experience';
            Width = 5;
        }
        field(50360; "Brought Months of Experience 2"; Integer)
        {
            Caption = 'Brought Months of Experience';
            Width = 5;
        }
        field(50361; "Brought Days of Experience 2"; Integer)
        {
            Caption = 'Brought Days of Experience';
            Width = 5;

            trigger OnValidate()
            begin
                /*SETFILTER("No.","No.");
                IF Emp.FINDFIRST THEN BEGIN
                IF "Brought Days of Experience"<>0 THEN
                  EmpCL."First Time Employed":=FALSE
                ELSE BEGIN
                EmpCL."First Time Employed":=TRUE;
                END;
                END;*/
            end;

        }

        field(503580; "Insert Training"; Boolean)

        {
            Caption = 'Insert training';
        }
        field(503565; "Brought Years of Experience E"; Integer)
        {
            Caption = 'Brought Years of Experience';
            Width = 5;
        }
        field(50208; "Disability Level"; Code[10])
        {
            Caption = 'Disability Level';
            Editable = false;
        }
        field(50243; "Municipality Name of Birth"; Text[30])
        {
            Caption = 'Municipality Name of Birth';
            Editable = false;
        }
        field(50242; "Municipality Code of Birth"; Code[10])
        {
            Caption = 'Municipality Code of Birth';
            TableRelation = IF ("Country/Region Code of Birth" = FILTER('')) Municipality.Code where(Type = filter(Regular))
            ELSE
            IF ("Country/Region Code of Birth" = FILTER(<> '')) Municipality.Code WHERE("Country/Region Code" = FIELD("Country/Region Code of Birth"), type = filter(Regular));

            trigger OnValidate()
            begin
                Municipality.RESET;
                Municipality.SETFILTER(Code, "Municipality Code of Birth");
                Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                IF Municipality.FINDFIRST THEN BEGIN
                    Municipality.CalcFields("Country/Region Code");
                    "Municipality Name of Birth" := Municipality.Name;
                    VALIDATE("City of Birth", Municipality.City);
                    VALIDATE("Place of birth", Municipality.City);
                    Municipality.calcfields("Country/Region Code");
                    "Country/Region Code of Birth" := Municipality."Country/Region Code";
                END;
                IF "Municipality Code of Birth" = '' THEN
                    "Municipality Name of Birth" := '';
            end;
        }
        field(50142; "Birth City"; Code[10])
        {
            Caption = 'Birth City';
            TableRelation = "Post Code".City;
        }
        field(50353; "Contact Center"; Boolean)
        {
            Caption = 'Contact Center';
        }
        field(503566; "Brought Months of Experience E"; Integer)
        {
            Caption = 'Brought Months of Experience';
            Width = 5;
        }
        field(50354; "Transport Temp"; Decimal)
        {
        }
        field(50352; "Transport Confirmed"; Boolean)
        {
        }
        field(503571; "Iznos poreske kartice"; Decimal)
        {
            trigger OnValidate();
            begin
                "Iznos ličnog odbitka" := "Tax Deduction Amount" - "Iznos poreske kartice";

            end;

        }

        field(503577; "Iznos ličnog odbitka"; Decimal)
        {
            Editable = false;

        }
        field(503567; "Brought Days of Experience E"; Integer)
        {
            Caption = 'Brought Days of Experience';
            Width = 5;

            trigger OnValidate()
            begin
                /*SETFILTER("No.","No.");
                IF Emp.FINDFIRST THEN BEGIN
                IF "Brought Days of Experience"<>0 THEN
                  EmpCL."First Time Employed":=FALSE
                ELSE BEGIN
                EmpCL."First Time Employed":=TRUE;
                END;
                END;*/

            end;
        }
        //BH 01 start
        field(70001; "Military Years of Service"; Integer)
        {
            Caption = 'Military Years of Service';
        }
        field(70002; "Military Months of Service"; Integer)
        {
            Caption = 'Military Months of Service';
        }
        field(70003; "Military Days of Service"; Integer)
        {
            Caption = 'Military Days of Service';
        }
        field(70010; "Years with military"; Integer)
        {
            Caption = 'Years with military';
        }
        field(70011; "Months with military"; Integer)
        {
            Caption = 'Months with military';
        }
        field(70012; "Days with military"; Integer)
        {
            Caption = 'Days';
        }
        field(70014; "Brought Years in C"; Integer)
        {
            Caption = 'Brought Years in C';
        }
        field(70015; "Brought Months in C"; Integer)
        {
            Caption = 'Brought Months in C';
        }
        field(70016; "Brought Days in C"; Integer)
        {
            Caption = 'Brought Days in C';
        }
        field(70017; "Total Brought Years"; Integer)
        {
            Caption = 'Total Brought Years';
        }
        field(70018; "Total Brought Months"; Integer)
        {
            Caption = 'Total Brought Months';
        }
        field(70019; "Total Brought Days"; Integer)
        {
            Caption = 'Total Brought Days';
        }
        field(70021; "Current Years in Company"; Integer)
        {
            Caption = 'Current Years in Company';
        }
        field(70022; "Current Months in Company"; Integer)
        {
            Caption = 'Current Months in Company';
        }
        field(70023; "Current Days in Company"; Integer)
        {
            Caption = 'Current Days in Company';
        }

        //BH 01 end
        field(70020; "Date of graduation"; Date)
        {
            Caption = 'Date of graduation';
        }
        field(50201; "Retirement Date"; Date)
        {
            Caption = 'Retirement Date';
        }
        field(503575; "Military count"; Boolean)
        {
            Caption = 'Vojni staž se obračunava u ukupni staž';
        }
        field(503678; "Department Category"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Category" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503679; "Department Cat. Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Cat. Description" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503680; Sector; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger".Sector where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503681; "Sector Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Sector Description" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503682; "Department Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Department Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503683; "Org Unit Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Org Unit Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503684; "Position Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Position Description" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503685; "Engagement Type"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Contract Type Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503686; "Rad u smjenama"; enum "Shift Work")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Rad u smjenama" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503687; "Superior1"; Text[250])
        {
            Caption = 'Superior 1';
        }
        field(503688; "Superior1Name"; Text[250])
        {
            Caption = 'Superior 2';
        }
        field(503689; Brutto; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger".Brutto where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503690; Netto; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger".Netto where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503700; "Netto Total"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Total Netto" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503701; "Position Coefficient for Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Position Coefficient for Wage" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503702; "Starting Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Starting Date" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503703; "Ending Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Ending Date" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503704; "Contract type"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Contract Type" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503705; "Defaultdimension"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Default Dimension" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503706; "Contract Termination Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Contract Termination Date" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503707; Voocation; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Additional Education".Vocation where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503708; "Vocation Description"; text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Additional Education"."Vocation Description" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(50378; "WEP with military"; Boolean)
        {
            Caption = 'Vojni staž se obračunava u minuli rad';
        }
        /*field(503709; "Superior1 Last Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Manager 1 Last Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503710; "Superior2"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Manager 2" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503712; "Superior2Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Manager 2 First Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }
        field(503713; "Superior2 Last Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Employee Contract Ledger"."Manager 1 Last Name" where("Employee No." = FIELD("No."), Active = const(true)));
        }*/
        field(503709; "Insurence number"; Text[250])
        {
            Caption = 'Insurance number';
        }
        field(503710; "Additional rights millitary"; Option)
        {
            Caption = 'Additional rights millitary';
            OptionMembers = " ",Borac,"Pripadnik boračke populacije","Šehidski status";
        }
        field(50200; "Retirement Condition"; Option)
        {
            Caption = 'Retirement Condition';
            OptionMembers = " ",Staž,"Godine života";
        }
        field(503711; "Group Code"; Code[30])
        {
            Caption = 'Group Code';
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger".Group WHERE("Employee No." = FIELD("No."), Active = FILTER(true)));
            //Department.Code WHERE (Type=FILTER(' '|Department))
        }

        field(503712; "Group Description"; Code[250])
        {
            Caption = 'Group Description';
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("No."), Active = FILTER(true)));
            //Department.Code WHERE (Type=FILTER(' '|Department))
        }
        field(503713; "Employee New User Name"; Code[50])
        {
            Caption = 'Employee User Name';

            Editable = false;

            /*    FieldClass = FlowField;
                CalcFormula = lookup("User Setup"."User ID" where("Employee No." = FIELD("No.")));
                Editable = false;*/

        }
        field(503583; QRCode; BLOB)
        {
            SubType = Bitmap;
        }

        field(50388; "Old Number"; Integer)
        {
            Caption = 'Old Number';
        }
        field(50389; "CNG Employee"; Boolean)
        {
            Caption = 'CNG Employee';
        }
        field(50390; "Registration No."; text[30])
        {
            Caption = 'Registration No.';
        }











    }


    var
        myInt: Integer;
        CheckInt: Integer;
        SMTPMail: Codeunit "SMTP Mail";
        ecl: Record "Employee Contract Ledger";
        WS: record "Wage Setup";
        Text011: Label 'You cannot use Transport if you have official car.';
        mai: Record "Misc. article information";
        Text006: Label 'The employee uses car allowance.';
        Country_Region: Record "Country/Region";
        Staro: Text;
        Recipients: List of [Text];
        SMTPSetup: Record "SMTP Mail Setup";
        HrSetup: Record "Human Resources Setup";

        Text014: Label 'Company E-mail already exsist';
        PostCode: Record "Post Code";
        CantonR: Record Canton;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        managerFull: Text;
        RoleCode: Code[30];
        RoleName: Text[250];

        Education: Record "Additional Education";


        positionMenuOrginal: Record "Position Menu";
        OldPrezime: Record "Employee Surname";
        Municipality: Record Municipality;
        Entity: record Entity;
        employee2: Record Employee;
        DayOfWeekInput: DotNet FirstDayOfWeek;
        WeekOfYearInput: DotNet FirstWeekOfYear;
        Employee: Record Employee;
        WB2: Record "Work Booklet";
        Text018: Label 'There is already an employee with that Internal ID.';
        Text012: Label 'You must enter Contribution Category Code';

        //ĐK Position: Record Position;
        Text001: Label 'Field Appropriate candidate cannot be True if field Potential Employee is False.';
        Text002: Label 'Field Inappropriate candidate cannot be True if field Potential Employee is False.';
        Text003: Label 'Cannot change Status if employee is in potential employee database.';
        Text004: Label 'Cannot change Status to Terminated if Emplymt. Contract Code field is empty.';
        Text005: Label 'Field Invited to interview cannot be True if field Potential Employee is False.';
        Text008: Label 'Start Date must have value.';
        NoSeriesMgt: Codeunit NoSeriesExtented;
        HumanResSetup: Record "Human Resources Setup";
        Text009: Label 'End Date must not be before Start date.';
        Text015: Label 'employee with selected bank account no. already exists!';
        Text016: Label 'Entry %1 is not valid. Expected value is %2 for employee no. %3';
        Text017: Label 'Entry %1 is not valid. ';
        EmployeeSurname: record "Employee Surname";
        EmailBodyText: Text;


    trigger OnInsert()
    var
        Pos: Integer;
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;
        EmployeeNoText: Text[1000];
        //     EmployeePicture: record "Employee Picture";
        //    EmployeePicture1: record "Employee Picture";
        //    EmployeePicture2: record "Employee Picture";
        NoCharacters: Text[1000];
        CopyStrLength: Integer;
        Length: Integer;
        WageSetup: Record "Wage Setup";
        CompanyInfo: Record "Company Information";
        UTemp: Record "User Setup";
        HRAllowed: Boolean;
        CU: Codeunit TestSubsCu;

    begin

        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            HRAllowed := UTemp.HR;

        if NOT HRAllowed then
            Error(CU.HRNotAllowed());


        IF "No." = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;

        DimMgt.UpdateDefaultDim(
          DATABASE::Employee, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");

        /*    EmployeePicture.RESET;
            EmployeePicture.SETFILTER("Employee No.", "No.");
            IF NOT EmployeePicture.FINDFIRST THEN BEGIN
                EmployeePicture1.INIT;
                EmployeePicture1."Employee No." := "No.";
                EmployeePicture2.SETFILTER("Employee No.", 'DEFAULT');
                IF EmployeePicture2.FINDFIRST THEN BEGIN
                    EmployeePicture2.CALCFIELDS(Picture);
                    EmployeePicture1.Picture := EmployeePicture2.Picture;
                END;
                EmployeePicture1.INSERT;
            END;*/

        Pos := 1;
        EmployeeNoText := FORMAT("No.");
        REPEAT
            NoCharacters := COPYSTR(EmployeeNoText, Pos, 1);
            Pos += 1;
        UNTIL NoCharacters <> FORMAT(0);

        Length := STRLEN(EmployeeNoText);
        CopyStrLength := Length - Pos + 2;

        "Modified Employee No." := COPYSTR(EmployeeNoText, Pos - 1, CopyStrLength);
        "Modified Employee No." := "No.";
        EVALUATE(Order, "No.");
        IF "No. Series" = 'UOD' THEN BEGIN
            Associates := TRUE;

        END;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            if UserSetup."Employee Status" = false then
                Rec.StatusExt := rec.StatusExt::"Temporary Contract";


        end;


        IF "No. Series" <> 'UOD' THEN BEGIN
            WageSetup.GET;
            "Hours In Day" := WageSetup."Hours in Day";
            "Wage Type" := WageSetup."Brutto Calculation Code";
            CompanyInfo.GET;
            "Wage Posting Group" := CompanyInfo."Entity Code";

            Meal := TRUE;
            //ĐK  "Bank No." := 'RBBH';
            "Tax Deduction" := TRUE;
            VALIDATE("Benefit Coefficient", 1);
            "Calculate Wage Addition" := true;

            "For Calculation" := true;
            "Send PayList" := TRUE;
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);


    end;

    trigger onmodify()
    var
        myInt: Integer;
        //    EmployeeResUpdate: Codeunit "Employee/Resource Update 2020";
        //     PersonalRecords: Record "Personal Records";
        WageCalc: Record "Wage Calculation";
        Text019: Label 'You cant change hours in a day because wage is already calculated for this moth.';
        WPConnSetup: Record "Web portal connection setup";
        VG: Record "Vacation Ground 2";
        ConnectionString: Text[1000];
        /*  SQLConn: DotNet SqlConnection;
          SQLCommand: DotNet SqlCommand;
          SQLParameter: DotNet SqlParameter2;
          SQLDbType: DotNet DbType2;*/
        companyInf: Record "Company Information";
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
        HRAllowed: Boolean;
        WageAllowed: Boolean;

    begin

        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            HRAllowed := UTemp.HR;

        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp.HR;


        if (HRAllowed = false) and (WageAllowed = false) then
            Error(CU.HRNotAllowed());



        "Last Date Modified" := TODAY;

        ECL.RESET;
        ECL.SETFILTER("Employee No.", '%1', "No.");
        ECL.SETFILTER(Active, '%1', TRUE);
        IF ECL.FINDFIRST THEN BEGIN

            //ĐK       EmployeeResUpdate.EmployeeChange(xRec, Rec);
        END;




        /*     PersonalRecords.RESET;
             PersonalRecords.SETFILTER("Employee No.", "No.");
             IF PersonalRecords.FINDLAST THEN BEGIN
                 PersonalRecords.VALIDATE("Employee No.", "No.");
                 PersonalRecords.MODIFY;
             END;*/
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);

        IF ((xRec."Hours In Day" <> 0) AND (xRec."Hours In Day" <> Rec."Hours In Day")) THEN BEGIN
            WageCalc.RESET;
            WageCalc.SETFILTER("Employee No.", '%1', "No.");
            WageCalc.SETFILTER("Month Of Wage", '%1', DATE2DMY(WORKDATE, 2));
            WageCalc.SETFILTER("Year of Wage", '%1', DATE2DMY(WORKDATE, 3));
            IF WageCalc.FINDFIRST THEN
                MESSAGE(Text019)
            ELSE BEGIN

                companyInf.get();
                if companyInf.Portal = true then begin


                    WPConnSetup.FINDFIRST();

                    ConnectionString := 'Server=' + WPConnSetup.Server + ';'
    + 'Database=' + WPConnSetup.Database + ';'
    + 'Uid=' + WPConnSetup.UID + ';'
    + 'Pwd=' + WPConnSetup.Password + ';';
                    /*         SQLConn := SQLConn.SqlConnection(ConnectionString);
                             SQLConn.Open;

                             SQLCommand := SQLCommand.SqlCommand();


                             SQLCommand.CommandText := 'dbo.Update_hour';
                             SQLCommand.Connection := SQLConn;
                             SQLCommand.CommandType := 4;
                             SQLCommand.CommandTimeout := 0;

                             SQLParameter := SQLParameter.SqlParameter;
                             SQLParameter.ParameterName := '@Employee_no';
                             SQLParameter.DbType := SQLDbType.String;
                             SQLParameter.Direction := SQLParameter.Direction.Input;
                             SQLParameter.Value := Rec."No.";
                             SQLCommand.Parameters.Add(SQLParameter);

                             SQLParameter := SQLParameter.SqlParameter;
                             SQLParameter.ParameterName := '@br_sati';
                             SQLParameter.DbType := SQLDbType.Int32;
                             SQLParameter.Direction := SQLParameter.Direction.Input;
                             SQLParameter.Value := Rec."Hours In Day";
                             SQLCommand.Parameters.Add(SQLParameter);

                             SQLCommand.ExecuteNonQuery;

                             SQLConn.Close;
                             SQLConn.Dispose;

                         END;

                     END;
                     IF ((xRec."Last Name" <> Rec."Last Name") AND (xRec."Last Name" <> '')) THEN BEGIN

                         WPConnSetup.FINDFIRST();

                         ConnectionString := 'Server=' + WPConnSetup.Server + ';'
             + 'Database=' + WPConnSetup.Database + ';'
             + 'Uid=' + WPConnSetup.UID + ';'
             + 'Pwd=' + WPConnSetup.Password + ';';
                         SQLConn := SQLConn.SqlConnection(ConnectionString);
                         SQLConn.Open;

                         SQLCommand := SQLCommand.SqlCommand();


                         SQLCommand.CommandText := 'dbo.User_LastName_Update';
                         SQLCommand.Connection := SQLConn;
                         SQLCommand.CommandType := 4;
                         SQLCommand.CommandTimeout := 0;

                         SQLParameter := SQLParameter.SqlParameter;
                         SQLParameter.ParameterName := '@EmployeeNo';
                         SQLParameter.DbType := SQLDbType.String;
                         SQLParameter.Direction := SQLParameter.Direction.Input;
                         SQLParameter.Value := Rec."No.";
                         SQLCommand.Parameters.Add(SQLParameter);

                         SQLParameter := SQLParameter.SqlParameter;
                         SQLParameter.ParameterName := '@LastName';
                         SQLParameter.DbType := SQLDbType.String;
                         SQLParameter.Direction := SQLParameter.Direction.Input;
                         SQLParameter.Value := Rec."No.";
                         SQLCommand.Parameters.Add(SQLParameter);

                         SQLCommand.ExecuteNonQuery;

                         SQLConn.Close;
                         SQLConn.Dispose;




                     end;
                 end;*/
                end;
            end;
        end;

        VG.SETFILTER("Employee No.", '%1', "No.");
        VG.SETFILTER(Year, '%1', DATE2DMY(WORKDATE, 3));
        IF VG.FINDLAST THEN BEGIN
            VG."Last Name" := "Last Name";
            VG.MODIFY;
        END;



    END;

    trigger OnDelete()
    var
        myInt: Integer;
        Text010: Label 'You cannot delete employee card!';
        UTemp: Record "User Setup";
        HRAllowed: Boolean;
        CU: Codeunit TestSubsCu;
    begin
        IF (Rec."First Name" <> '') AND (Rec."Last Name" <> '') AND (Rec."Employee ID" <> '') THEN BEGIN
            ERROR(Text010);
        END;
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            HRAllowed := UTemp.HR;

        if NOT HRAllowed then
            Error(CU.HRNotAllowed());

    end;

    trigger onrename()
    var
        myInt: Integer;
    begin
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);

    end;

    local procedure FullName(): Text[100];
    var
        myInt: Integer;
    begin
        IF "Middle Name" = '' THEN
            EXIT("First Name" + ' ' + "Last Name");

        EXIT("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");

    end;
}







/*
  /*

  Dyn365 Business Central Codeunits (each)                                  20
Dyn365 Business Central Pages (100)                                      200
Dyn365 Business Central Premium                                           40
Dyn365 Business Central Queries (100)                                    100
Dyn365 Business Central Reports (100)                                    200
Dyn365 Business Central Tables (10)                                      160
Dyn365 Business Central Team Members                                      30
Dyn365 Business Central XML Ports (100)                                  100

  */
