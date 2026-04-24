table 50121 "Personal Documents"
{
    Caption = 'Personal Documents';
    DrillDownPageID = "Personal Documents";
    LookupPageID = "Personal Documents";


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(2; Citizenship; Code[10])
        {
            Caption = 'Citizenship';
            TableRelation = "Citizenship Description"."No.";

            trigger OnValidate()
            begin
                IF Citizenship <> '' THEN BEGIN
                    CitizenshipDescription.SETFILTER("No.", Rec.Citizenship);
                    IF CitizenshipDescription.FIND('-') THEN BEGIN
                        Rec."Citizenship Description" := CitizenshipDescription.Description;
                        //rec.MODIFY;
                    END
                END
                ELSE BEGIN
                    Rec."Citizenship Description" := '';

                END;

                Switch := Switch::Citizenship;
                IF (Switch = Switch::Citizenship) THEN BEGIN
                    Rec.INSERT(TRUE);
                    //   Maticna.PersonalDocument2(xRec, Rec, Code);
                END;
            end;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
        }
        field(6; "ID Card No."; Code[20])
        {
            Caption = 'ID Card No.';

            trigger OnValidate()
            begin
                Switch := Switch::IDCard;
            end;
        }
        field(8; "Passport No."; Code[10])
        {
            Caption = 'Passport No.';

            trigger OnValidate()
            begin
                Switch := Switch::Passport;
            end;
        }
        field(9; Nationality; Code[10])
        {
            Caption = 'Nationality';
            TableRelation = Nationallity.Code;

            trigger OnValidate()
            begin
                IF Nationality <> '' THEN BEGIN
                    Nationallity.RESET;
                    Nationallity.SETFILTER(Code, Nationality);
                    IF Nationallity.FINDFIRST THEN
                        "Nationality Description" := Nationallity.Description;
                END
                ELSE
                    "Nationality Description" := '';
                Switch := Switch::Nationality;
                //IF (Switch = Switch::Citizenship) OR (Switch = Switch::"Work Permit") THEN
                //  Maticna.PersonalDocument2(xRec, Rec, Code);
            end;
        }
        field(10; "Social Security No."; Code[30])
        {
            Caption = 'Social Security No.';

            trigger OnValidate()
            begin
                Switch := Switch::"Social Security";
            end;
        }
        field(11; "Work Booklet No."; Code[20])
        {
            Caption = 'Work Booklet No.';
        }
        field(12; "Length Of Service"; Code[10])
        {
            Caption = 'Length Of Service';
        }
        field(25; Switch; Option)
        {
            Caption = 'Option';
            OptionCaption = ' ,Citizenship,Passport,Social Security,Work Booklet,Length Of Service,Residence Permit,Work Permit,IDCard,Nationality';
            OptionMembers = " ",Citizenship,Passport,"Social Security","Work Booklet","Length Of Service","Residence Permit","Work Permit",IDCard,Nationality;
        }
        field(26; "Residence Permit"; Code[50])
        {
            Caption = 'Residence Permit';

            trigger OnValidate()
            begin
                Switch := Switch::"Residence Permit";
                // Maticna.PersonalDocument2(xRec, Rec, Code);
            end;
        }
        field(29; "Work Permit"; Code[50])
        {
            Caption = 'Work Permit';

            trigger OnValidate()
            begin

                Switch := Switch::"Work Permit";
                Rec.INSERT(TRUE);
                // Maticna.PersonalDocument2(xRec, Rec, Code);
            end;
        }
        field(32; "Date For Delivery"; Date)
        {
            Caption = 'Date For Delivery';
        }
        field(33; "Type Of Work Permit"; Option)
        {
            Caption = 'Type Of Work Permit';
            OptionCaption = ' ,Permanent Residence,Temporary Residence';
            OptionMembers = " ","Permanent Residence","Temporary Residence";
        }
        field(34; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(35; "Date From"; Date)
        {
            Caption = 'Date From';

            trigger OnValidate()
            begin

                /*CloseDate:=Rec."Date From"-1;
                PD.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                PD.SETFILTER("Citizenship Option",'%1',"Citizenship Option"::Primary);
                PD.SETFILTER(Switch,'%1',Switch);
                IF PD.COUNT>=1 THEN BEGIN
                IF PD.FIND('+')
                THEN PD.VALIDATE("Date To",CloseDate);
                PD.MODIFY;
                END;


               PD1.SETFILTER("Citizenship Option",'%1',"Citizenship Option");
               IF PD1.FINDFIRST THEN
                  IF ("Citizenship Option"="Citizenship Option"::Secondary)
                     THEN BEGIN
                      CloseDate:=Rec."Date From"-1;
                      PD1.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                      PD.SETFILTER(Switch,'%1',Switch);
                      IF PD1.COUNT>=1 THEN BEGIN
                      IF PD1.FIND('+')
                      THEN PD1.VALIDATE("Date To",CloseDate);
                      PD1.MODIFY;
                      END;
                   END;

              PDValidation.RESET;
                PDValidation.SETFILTER("Citizenship Option",'%1',"Citizenship Option");
                IF PDValidation.FINDFIRST THEN
                  BEGIN
                  PDValidation.SETFILTER(Switch,'%1',Switch);
                  IF PDValidation.FIND('-') THEN
                   BEGIN
                   PDValidation.SETFILTER("Employee No.",'%1',Rec."Employee No.");
                   IF PDValidation.FIND('-')THEN BEGIN
                    // IF  (((PDValidation."Date From"=Rec."Date From") AND (PDValidation."Date To"<>0D)) OR ((PDValidation."Date To"=Rec."Date To") AND (PDValidation."Date To"<>0D)))
                    IF  (PDValidation."Date From"=Rec."Date From")
                     //THEN  ERROR (Text002);
                     THEN ERROR (Text002);
                     END;
                    END;
                   END;

              {IF "Date To"<>0D THEN BEGIN
                IF "Date From"=0D THEN
                  ERROR(Text000);
                 IF "Date To"<"Date From" THEN
                ERROR(Text001);
                  //END;}
                  */
                IF "Citizenship Option" = "Citizenship Option"::Primary THEN BEGIN
                    PD.RESET;
                    PD.SETFILTER("Primary key", '<>%1', Rec."Primary key");
                    PD.SETFILTER("Citizenship Option", '%1', "Citizenship Option"::Primary);
                    PD.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    PD.SETFILTER(Switch, '%1', Rec.Switch);
                    // PD.SETFILTER(Active,'%1',TRUE);
                    PD.SETFILTER("Date From", '<%1', Rec."Date From");
                    PD.SETCURRENTKEY("Date From");
                    PD.ASCENDING;
                    IF PD.FINDLAST THEN BEGIN
                        IF PD."Date From" <= CALCDATE('<-1D>', Rec."Date From") THEN BEGIN
                            IF Rec."Date From" <> 0D THEN
                                PD."Date To" := Rec."Date From" - 1;
                            PD.MODIFY;
                        END;
                    END;
                END;

                IF "Citizenship Option" = "Citizenship Option"::Secondary THEN BEGIN

                    PD.RESET;
                    //PD.SETFILTER("Date To",'%1',0D);
                    PD.SETFILTER("Primary key", '<>%1', Rec."Primary key");
                    // PD.SETFILTER("Citizenship Option",'%1',"Citizenship Option");
                    PD.SETFILTER("Citizenship Option", '%1', "Citizenship Option"::Secondary);
                    //  PD.SETFILTER(Active,'%1',TRUE);
                    PD.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                    PD.SETFILTER("Date From", '<%1', Rec."Date From");
                    PD.SETFILTER(Switch, '%1', Rec.Switch);
                    PD.SETCURRENTKEY("Date From");
                    PD.ASCENDING;
                    IF PD.FINDLAST THEN BEGIN
                        IF PD."Date From" <= CALCDATE('<-1D>', Rec."Date From") THEN BEGIN
                            IF Rec."Date From" <> 0D THEN
                                PD."Date To" := Rec."Date From" - 1;
                            PD.MODIFY;
                        END;
                    END;
                END;

                IF Rec."Date From" <> 0D THEN BEGIN
                    PDValidation.RESET;
                    PDValidation.SETFILTER("Citizenship Option", '%1', "Citizenship Option");
                    IF PDValidation.FINDFIRST THEN BEGIN
                        PDValidation.SETFILTER(Switch, '%1', Switch);
                        IF PDValidation.FIND('-') THEN BEGIN
                            PDValidation.SETFILTER("Employee No.", '%1', Rec."Employee No.");
                            IF PDValidation.FIND('-') THEN BEGIN
                                // IF  (((PDValidation."Date From"=Rec."Date From") AND (PDValidation."Date To"<>0D)) OR ((PDValidation."Date To"=Rec."Date To") AND (PDValidation."Date To"<>0D)))
                                IF (PDValidation."Date From" = Rec."Date From")
                                 //THEN  ERROR (Text002);
                                 THEN
                                    ERROR(Text002);
                            END;
                        END;
                    END;
                END;
                //END;
                //  IF (Switch = Switch::Citizenship) OR (Switch = Switch::"Work Permit") THEN
                //    Maticna.PersonalDocument2(xRec, Rec, Code);

            end;
        }
        field(36; "Date To"; Date)
        {
            Caption = 'Date To';

            trigger OnValidate()
            begin
                /*IF "Date To"<>0D THEN BEGIN
                                                                                 IF "Date From"=0D THEN
                                                                                   ERROR(Text000);*/
                IF "Date To" <> 0D THEN BEGIN
                    IF Rec."Date To" < Rec."Date From" THEN
                        ERROR(Text001);
                END;
                //END;
                //END;

            end;
        }
        field(37; "Citizenship Option"; Option)
        {
            Caption = 'Citizenship Option';
            OptionCaption = 'Primary,Secondary,Other';
            OptionMembers = Primary,Secondary,Other;
        }
        field(38; "Citizenship Description"; Text[50])
        {
            Caption = 'Citizenship Description';
            Editable = false;
        }
        field(39; "Nationality Description"; Text[50])
        {
            Caption = 'Nationality Description';
            Editable = false;
        }
        field(40; Status; enum "Employee Status")
        {
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';
            FieldClass = FlowField;

        }
        field(41; "Employee Name"; Text[81])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Employee Name" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            FieldClass = FlowField;
        }
        field(42; "Sector Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Group Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;
            FieldClass = FlowField;
        }
        field(45; "Team Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Team Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; "Department Name"; Text[250])
        {
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Category Description';
            Editable = false;
            FieldClass = FlowField;
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
        field(50011; "Employee  First Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."First Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; "Employee Last Name"; Text[50])
        {
            CalcFormula = Lookup(Employee."Last Name" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Employee Last Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Primary key"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Code", "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        IF (Active = TRUE) AND (Switch = Switch::"Work Permit") THEN BEGIN
            /*       PersonalRecords.RESET;
                   PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                   IF PersonalRecords.FINDLAST THEN BEGIN
                       PersonalRecords.VALIDATE("Work Permit", "Work Permit");
                       PersonalRecords.VALIDATE("Type Of Work Permit", "Type Of Work Permit");
                       PersonalRecords.MODIFY;
                   END;*/
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Work Permit" := FALSE;
                Employee."Type Of Work Permit" := 0;
                Employee."Work Permit Expiry Date" := 0D;
                Employee.MODIFY;
            END;
        END
        ELSE
            IF (Active = TRUE) AND (Switch = Switch::"Residence Permit") THEN BEGIN
                /*     PersonalRecords.RESET;
                     PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                     IF PersonalRecords.FINDLAST THEN BEGIN
                         PersonalRecords.VALIDATE("Residence Permit", "Residence Permit");
                         PersonalRecords.MODIFY;
                     END;*/
                Employee.RESET;
                Employee.SETFILTER("No.", "Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    Employee."Residence Permit" := FALSE;
                    Employee."Residence Permit Expiry Date" := 0D;
                    Employee.MODIFY;
                END;
            END

            ELSE
                IF (Active = TRUE) AND (Switch = Switch::"Social Security") THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Social Security No." := '';
                        Employee.MODIFY;
                    END;
                END
                ELSE
                    IF (Active = TRUE) AND (Switch = Switch::Nationality) THEN BEGIN
                        Employee.RESET;
                        Employee.SETFILTER("No.", "Employee No.");
                        IF Employee.FINDFIRST THEN BEGIN
                            Employee.Nationallity := '';
                            Employee.MODIFY;
                        END;
                    END
                    ELSE
                        IF (Active = TRUE) AND (Switch = Switch::IDCard) THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("No.", "Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                Employee."ID No." := '';
                                Employee.MODIFY;
                            END;
                        END
                        ELSE
                            IF (Active = TRUE) AND (Switch = Switch::Citizenship) AND ("Citizenship Option" = "Citizenship Option"::Primary) THEN BEGIN

                                /*      PersonalRecords.RESET;
                                      PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                                      IF PersonalRecords.FINDLAST THEN BEGIN
                                          PersonalRecords.VALIDATE(Citizenship, Citizenship);
                                          PersonalRecords.MODIFY;
                                      END;*/

                                Employee.RESET;
                                Employee.SETFILTER("No.", "Employee No.");
                                IF Employee.FINDFIRST THEN BEGIN
                                    Employee."Citizenship 1" := '';
                                    Employee.MODIFY;
                                END;
                            END
                            ELSE
                                IF (Active = TRUE) AND (Switch = Switch::Citizenship) AND ("Citizenship Option" = "Citizenship Option"::Secondary) THEN BEGIN
                                    Employee.RESET;
                                    Employee.SETFILTER("No.", "Employee No.");
                                    IF Employee.FINDFIRST THEN BEGIN
                                        Employee."Citizenship 2" := '';
                                        Employee.MODIFY;
                                    END;
                                END
                                ELSE
                                    IF (Active = TRUE) AND (Switch = Switch::Passport) AND ("Citizenship Option" = "Citizenship Option"::Primary) THEN BEGIN
                                        Employee.RESET;
                                        Employee.SETFILTER("No.", "Employee No.");
                                        IF Employee.FINDFIRST THEN BEGIN
                                            Employee."Passport No." := '';
                                            Employee.MODIFY;
                                        END;
                                    END
                                    ELSE
                                        IF (Active = TRUE) AND (Switch = Switch::Passport) AND ("Citizenship Option" = "Citizenship Option"::Secondary) THEN BEGIN
                                            Employee.RESET;
                                            Employee.SETFILTER("No.", "Employee No.");
                                            IF Employee.FINDFIRST THEN BEGIN
                                                Employee."Additional Passport No." := '';
                                                Employee.MODIFY;
                                            END;
                                        END;
        /*    PersonalTrack.RESET;
            PersonalTrack.SETFILTER("Employee No.", '%1', "Employee No.");
            PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
            PersonalTrack.SETFILTER("Code Personal", '%1', Rec.Code);
            PersonalTrack.SETFILTER("Code Additional", '%1', 0);
            PersonalTrack.SETFILTER("Code Addr", '%1', 0);
            PersonalTrack.SETFILTER("Code Personal", '%1', '');
            IF PersonalTrack.FINDFIRST THEN
                PersonalTrack.DELETE;*/
    end;

    trigger OnInsert()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        IF Code = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD("Personal Documents Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Personal Documents Nos.", HRSetup."Personal Documents Nos.", 0D, Code, HRSetup."Personal Documents Nos.");
        END;

        Employee.RESET;
        Employee.SETFILTER("No.", "Employee No.");
        IF Employee.FINDFIRST THEN BEGIN
            IF Switch = Switch::"Work Permit" THEN BEGIN
                Employee."Work Permit" := TRUE;
                Employee."Type Of Work Permit" := "Type Of Work Permit";
                Employee."Work Permit Expiry Date" := "Date To";
                Employee.MODIFY;

                /*   PersonalRecords.RESET;
                   PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                   IF PersonalRecords.FINDLAST THEN BEGIN
                       PersonalRecords.VALIDATE("Work Permit", "Work Permit");
                       PersonalRecords.VALIDATE("Type Of Work Permit", "Type Of Work Permit");
                       PersonalRecords.MODIFY;
                   END;*/

                PersonalDocuments.RESET;
                PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                PersonalDocuments.SETFILTER(Switch, 'Work Permit');
                IF PersonalDocuments.FINDFIRST THEN BEGIN
                    REPEAT
                        PersonalDocuments.Active := FALSE;
                        PersonalDocuments.MODIFY;
                    UNTIL PersonalDocuments.NEXT = 0;
                END;

                Active := TRUE;
            END
            ELSE
                IF Switch = Switch::"Residence Permit" THEN BEGIN
                    Employee."Residence Permit" := TRUE;
                    Employee."Residence Permit Expiry Date" := "Date To";
                    Employee.MODIFY;

                    /*                    PersonalRecords.RESET;
                                        PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                                        IF PersonalRecords.FINDLAST THEN BEGIN
                                            PersonalRecords.VALIDATE("Residence Permit", "Residence Permit");
                                            PersonalRecords.MODIFY;
                                        END;*/

                    PersonalDocuments.RESET;
                    PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                    PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                    IF PersonalDocuments.FINDFIRST THEN BEGIN
                        REPEAT
                            PersonalDocuments.Active := FALSE;
                            PersonalDocuments.MODIFY;
                        UNTIL PersonalDocuments.NEXT = 0;
                    END;

                    Active := TRUE;
                END
                /*ELSE IF Switch=Switch::"Work Booklet" THEN BEGIN
                  Employee."Work Booklet No.":="Work Booklet No.";
                  Employee.MODIFY;
                  PersonalDocuments.RESET;
                  PersonalDocuments.SETFILTER("Employee No.","Employee No.");
                  PersonalDocuments.SETFILTER(Switch,'Work Booklet');
                  IF PersonalDocuments.FINDFIRST THEN BEGIN
                    REPEAT
                      PersonalDocuments.Active:=FALSE;
                      PersonalDocuments.MODIFY;
                      UNTIL PersonalDocuments.NEXT=0;
                   END;

                  Active:=TRUE;
                END*/
                ELSE
                    IF Switch = Switch::"Social Security" THEN BEGIN
                        Employee."Social Security No." := "Social Security No.";
                        Employee.MODIFY;
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                        PersonalDocuments.SETFILTER(Switch, 'Social Security');
                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                            REPEAT
                                PersonalDocuments.Active := FALSE;
                                PersonalDocuments.MODIFY;
                            UNTIL PersonalDocuments.NEXT = 0;
                        END;

                        Active := TRUE;
                    END
                    ELSE
                        IF Switch = Switch::Nationality THEN BEGIN
                            Employee.Nationallity := Nationality;
                            Employee.MODIFY;
                            PersonalDocuments.RESET;
                            PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                            PersonalDocuments.SETFILTER(Switch, 'Nationality');
                            IF PersonalDocuments.FINDFIRST THEN BEGIN
                                REPEAT
                                    PersonalDocuments.Active := FALSE;
                                    PersonalDocuments.MODIFY;
                                UNTIL PersonalDocuments.NEXT = 0;
                            END;

                            Active := TRUE;
                        END
                        ELSE
                            IF Switch = Switch::IDCard THEN BEGIN
                                Employee."ID No." := "ID Card No.";
                                Employee.MODIFY;
                                PersonalDocuments.RESET;
                                PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                                PersonalDocuments.SETFILTER(Switch, 'IDCard');
                                IF PersonalDocuments.FINDFIRST THEN BEGIN
                                    REPEAT
                                        PersonalDocuments.Active := FALSE;
                                        PersonalDocuments.MODIFY;
                                    UNTIL PersonalDocuments.NEXT = 0;
                                END;

                                Active := TRUE;
                            END
                            ELSE
                                IF Switch = Switch::Citizenship THEN BEGIN
                                    IF "Citizenship Option" = "Citizenship Option"::Primary THEN BEGIN
                                        Employee."Citizenship 1" := Citizenship;
                                        Employee.MODIFY;

                                        /*       PersonalRecords.RESET;
                                               PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                                               IF PersonalRecords.FINDLAST THEN BEGIN
                                                   PersonalRecords.VALIDATE(Citizenship, Citizenship);
                                                   PersonalRecords.MODIFY;
                                               END;*/

                                        PersonalDocuments.RESET;
                                        PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                                        PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                                        PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                                        IF PersonalDocuments.FINDFIRST THEN BEGIN
                                            REPEAT
                                                PersonalDocuments.Active := FALSE;
                                                PersonalDocuments.MODIFY;
                                            UNTIL PersonalDocuments.NEXT = 0;
                                        END;

                                        Active := TRUE;
                                    END
                                    ELSE
                                        IF "Citizenship Option" = "Citizenship Option"::Secondary THEN BEGIN
                                            Employee."Citizenship 2" := Citizenship;
                                            Employee.MODIFY;
                                            PersonalDocuments.RESET;
                                            PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                                            PersonalDocuments.SETFILTER(Switch, 'Citizenship');
                                            PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                                            IF PersonalDocuments.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    PersonalDocuments.Active := FALSE;
                                                    PersonalDocuments.MODIFY;
                                                UNTIL PersonalDocuments.NEXT = 0;
                                            END;

                                            Active := TRUE;
                                        END;
                                END
                                ELSE
                                    IF Switch = Switch::Passport THEN BEGIN
                                        IF "Citizenship Option" = "Citizenship Option"::Primary THEN BEGIN
                                            Employee."Passport No." := "Passport No.";
                                            Employee.MODIFY;
                                            PersonalDocuments.RESET;
                                            PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                                            PersonalDocuments.SETFILTER(Switch, 'Passport');
                                            PersonalDocuments.SETFILTER("Citizenship Option", 'Primary');
                                            IF PersonalDocuments.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    PersonalDocuments.Active := FALSE;
                                                    PersonalDocuments.MODIFY;
                                                UNTIL PersonalDocuments.NEXT = 0;
                                            END;

                                            Active := TRUE;
                                        END
                                        ELSE
                                            IF "Citizenship Option" = "Citizenship Option"::Secondary THEN BEGIN
                                                Employee."Additional Passport No." := "Passport No.";
                                                Employee.MODIFY;
                                                PersonalDocuments.RESET;
                                                PersonalDocuments.SETFILTER("Employee No.", "Employee No.");
                                                PersonalDocuments.SETFILTER(Switch, 'Passport');
                                                PersonalDocuments.SETFILTER("Citizenship Option", 'Secondary');
                                                IF PersonalDocuments.FINDFIRST THEN BEGIN
                                                    REPEAT
                                                        PersonalDocuments.Active := FALSE;
                                                        PersonalDocuments.MODIFY;
                                                    UNTIL PersonalDocuments.NEXT = 0;
                                                END;

                                                Active := TRUE;
                                            END;
                                    END;
        END;
        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15)

    end;

    trigger OnModify()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;

        IF (Active = TRUE) AND (Switch = Switch::"Work Permit") THEN BEGIN
            /*     PersonalRecords.RESET;
                 PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                 IF PersonalRecords.FINDLAST THEN BEGIN
                     PersonalRecords.VALIDATE("Work Permit", "Work Permit");
                     PersonalRecords.VALIDATE("Type Of Work Permit", "Type Of Work Permit");
                     PersonalRecords.MODIFY;
                 END;*/
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Work Permit" := TRUE;
                Employee."Type Of Work Permit" := "Type Of Work Permit";
                Employee."Work Permit Expiry Date" := "Date To";
                Employee.MODIFY;
            END;
        END
        ELSE
            IF (Active = TRUE) AND (Switch = Switch::"Residence Permit") THEN BEGIN
                /*  PersonalRecords.RESET;
                  PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                  IF PersonalRecords.FINDLAST THEN BEGIN
                      PersonalRecords.VALIDATE("Residence Permit", "Residence Permit");
                      PersonalRecords.MODIFY;
                  END;*/
                Employee.RESET;
                Employee.SETFILTER("No.", "Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    Employee."Work Permit" := TRUE;
                    Employee."Type Of Work Permit" := "Type Of Work Permit";
                    Employee."Work Permit Expiry Date" := "Date To";
                    Employee.MODIFY;
                END;
            END
            /*ELSE
            IF (Active=TRUE) AND (Switch=Switch::"Work Booklet") THEN BEGIN
              Employee.RESET;
            Employee.SETFILTER("No.","Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Work Booklet No.":="Work Booklet No.";
                Employee.MODIFY;
              END;
            END*/
            ELSE
                IF (Active = TRUE) AND (Switch = Switch::"Social Security") THEN BEGIN
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Social Security No." := "Social Security No.";
                        Employee.MODIFY;
                    END;
                END
                ELSE
                    IF (Active = TRUE) AND (Switch = Switch::Nationality) THEN BEGIN
                        Employee.RESET;
                        Employee.SETFILTER("No.", "Employee No.");
                        IF Employee.FINDFIRST THEN BEGIN
                            Employee.Nationallity := Nationality;
                            Employee.MODIFY;
                        END;
                    END
                    ELSE
                        IF (Active = TRUE) AND (Switch = Switch::IDCard) THEN BEGIN
                            Employee.RESET;
                            Employee.SETFILTER("No.", "Employee No.");
                            IF Employee.FINDFIRST THEN BEGIN
                                Employee."ID No." := "ID Card No.";
                                Employee.MODIFY;
                            END;
                        END
                        ELSE
                            IF (Active = TRUE) AND (Switch = Switch::Citizenship) AND ("Citizenship Option" = "Citizenship Option"::Primary) THEN BEGIN

                                /*    PersonalRecords.RESET;
                                    PersonalRecords.SETFILTER("Employee No.", "Employee No.");
                                    IF PersonalRecords.FINDLAST THEN BEGIN
                                        PersonalRecords.VALIDATE(Citizenship, Citizenship);
                                        PersonalRecords.MODIFY;
                                    END;
    */
                                Employee.RESET;
                                Employee.SETFILTER("No.", "Employee No.");
                                IF Employee.FINDFIRST THEN BEGIN
                                    Employee."Citizenship 1" := Citizenship;
                                    Employee.MODIFY;
                                END;
                            END
                            ELSE
                                IF (Active = TRUE) AND (Switch = Switch::Citizenship) AND ("Citizenship Option" = "Citizenship Option"::Secondary) THEN BEGIN
                                    Employee.RESET;
                                    Employee.SETFILTER("No.", "Employee No.");
                                    IF Employee.FINDFIRST THEN BEGIN
                                        Employee."Citizenship 2" := Citizenship;
                                        Employee.MODIFY;
                                    END;
                                END
                                ELSE
                                    IF (Active = TRUE) AND (Switch = Switch::Passport) AND ("Citizenship Option" = "Citizenship Option"::Primary) THEN BEGIN
                                        Employee.RESET;
                                        Employee.SETFILTER("No.", "Employee No.");
                                        IF Employee.FINDFIRST THEN BEGIN
                                            Employee."Passport No." := "Passport No.";
                                            Employee.MODIFY;
                                        END;
                                    END
                                    ELSE
                                        IF (Active = TRUE) AND (Switch = Switch::Passport) AND ("Citizenship Option" = "Citizenship Option"::Secondary) THEN BEGIN
                                            Employee.RESET;
                                            Employee.SETFILTER("No.", "Employee No.");
                                            IF Employee.FINDFIRST THEN BEGIN
                                                Employee."Citizenship 2" := Citizenship;
                                                Employee.MODIFY;
                                            END;
                                        END;

        "Last Date Modified" := TODAY;
        "Operator No." := COPYSTR(USERID, 1, 15);
        //  IF (Switch = Switch::Citizenship) OR (Switch = Switch::"Work Permit") THEN
        //    Maticna.PersonalDocument2(xRec, Rec, Code);

    end;

    trigger OnRename()
    begin
        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'LEGAL' THEN
                ERROR('Rola "Legal" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;


        UserPersonalization.RESET;
        UserPersonalization.SETFILTER("User ID", '%1', USERID);
        IF UserPersonalization.FINDFIRST THEN BEGIN
            IF UserPersonalization."Profile ID" = 'TRAINING MANAGER' THEN
                ERROR('Rola "TRAINING MANAGER" nema mogućnost unosa/ažuriranja ili brisanja podataka');
        END;
    end;

    var
        Employee: Record "Employee";
        PersonalDocuments: Record "Personal Documents";
        CitizenshipDescription: Record "Citizenship Description";
        Nationallity: Record "Nationallity";
        //     PersonalRecords: Record "Personal Records";
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
        date: Date;
        CloseDate: Date;
        PD: Record "Personal Documents";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
        Text002: Label 'You can''t have two active documents the same tame.';
        PDValidation: Record "Personal Documents";
        PD1Validation: Record "Personal Documents";
        PD1: Record "Personal Documents";
        pd3: Record "Personal Documents";
        // PersonalTrack: Record "Personal track report";
        // Maticna: Codeunit "Employee/Resource Update 2020";
        UserPersonalization: Record "User Personalization";
}

