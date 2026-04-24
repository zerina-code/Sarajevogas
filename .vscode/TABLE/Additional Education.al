table 50127 "Additional Education"
{
    // HR01-12.1.2017 - HR customization

    Caption = 'Education History';
    DataCaptionFields = "Employee No.";
    DrillDownPageID = "Education History";
    LookupPageID = "Education History";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            //   AutoIncrement = true;
            Caption = 'Entry No.';
            //

        }
        field(2; "Employee ID"; Code[13])
        {
            Caption = 'Employee ID';
            TableRelation = Employee."Employee ID";

        }
        field(5; "School of Graduation"; Text[250])
        {
            Caption = 'School of Graduation';
            TableRelation = "Institution/Company".Description WHERE("Type" = FILTER("Education"));

            trigger OnValidate()
            begin

                //ĐK     EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;
        }
        field(6; "Education Level"; Enum School)
        {
            Caption = 'Education Level';


            trigger OnValidate()
            var
                ECLA: Record "Employee Contract Ledger";
            begin

                if Rec.Active = true then begin
                    Employee.RESET;
                    Employee.SETFILTER("No.", "Employee No.");
                    IF Employee.FINDFIRST THEN BEGIN
                        Employee."Education Level" := "Education Level";
                        Employee."School of Graduation" := "School of Graduation";
                        Employee."Major of Graduation" := Major;
                        Employee."Title Code" := Title;
                        Employee."Title Description" := "Title Description";
                        Employee.Vocation := Vocation;
                        Employee.Profession := Profession;
                        Employee.MODIFY;
                    END;
                end;

                if "To Date" <> 0D then begin

                    ECLA.Reset();
                    ECLA.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    //ĐK   ECLA.SetFilter("Starting Date",'<=%1',"From Date");
                    if ("To Date" <> 0D) and ("From Date" <> 0D) then
                        ECLA.SetFilter("Starting Date", '%1..%2', "From Date", "To Date");
                    if ("To Date" <> 0D) then
                        ECLA.SetFilter("Starting Date", '>=%1', "To Date");
                    AEE.Reset();
                    AEE.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    AEE.SetFilter("To Date", '>%1', Rec."To Date");
                    AEE.SetCurrentKey("To Date");
                    AEE.Ascending;
                    if AEE.FindFirst() then
                        ECLA.SetFilter("Ending Date", '<=%1 & <>%2', AEE."To Date", 0D);


                    //ECLA.SetFilter("Employee Education Level",'%1',employe);
                    ECLA.SetCurrentKey("Starting Date");
                    ECLA.Ascending;
                    if ECLA.FindSet() then
                        repeat
                            ECLA."Employee Education Level" := Rec."Education Level";
                            ECLA.Modify();

                        until ECLA.Next() = 0;
                end;
                /*đK IF "Education Level" <> "Education Level"::Empty THEN
                     Rec.INSERT(TRUE);*
 /
               //ĐK  EmployeeResUpdate.AdditionalEducation2(xRec, Rec);

                 //ĐK proba
                 /*
                 */

            end;

        }
        field(9; Major; Text[100])
        {
            Caption = 'Major of Graduation';

            /*trigger OnValidate()
            begin
                Majors.SETFILTER(Major, '%1', Major);
                IF Majors.FIND('-') THEN BEGIN
                    Profession := Majors.Profession;
                    "Profession Description" := Majors."Profession Description";
                END;

                //  EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;*/
        }
        field(10; Finished; Boolean)
        {
            Caption = 'Finished';

            trigger OnValidate()
            begin
                //HR01 start

                IF Finished = TRUE THEN BEGIN
                    Emp2.SETFILTER(Emp2."Employee ID", "Employee ID");
                    IF Emp2.FINDFIRST THEN BEGIN
                        Emp2."Education Level" := "Education Level";
                        Emp2."School of Graduation" := "School of Graduation";
                        Emp2."Major of Graduation" := Major;
                        Emp2.Vocation := Vocation;
                        Emp2.Profession := Profession;
                        Emp2."Title Code" := Title;
                        Emp2."Title Description" := "Title Description";
                        Emp2.MODIFY;
                    END;
                END;

                //HR01 end
            end;
        }
        field(11; Vocation; Code[20])
        {
            Caption = 'Vocation';
            TableRelation = Vocation.Code;
            Editable = false;

            trigger OnValidate()
            begin
                IF Vocation <> '' THEN BEGIN
                    VocationRec.RESET;
                    VocationRec.SETFILTER(Code, Vocation);
                    IF VocationRec.FINDFIRST THEN
                        "Vocation Description" := VocationRec."Description New";

                END
                ELSE
                    "Vocation Description" := '';

                //   EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;
        }
        field(12; Title; Code[10])
        {
            Caption = 'Title';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF Title<>'' THEN BEGIN
                  TitleRec.RESET;
                  TitleRec.SETFILTER(Code,Title);
                  IF TitleRec.FINDFIRST THEN
                    "Title Description":=TitleRec.Description;
                  END
                  ELSE
                  "Title Description":='';*/

            end;
        }
        field(13; Profession; Code[10])
        {
            Caption = 'Profession';
            Editable = false;

            trigger OnValidate()
            begin
                /*IF Profession<>'' THEN BEGIN
                  ProfessionRec.RESET;
                  ProfessionRec.SETFILTER(Code,Profession);
                  IF ProfessionRec.FINDFIRST THEN
                    "Profession Description":=ProfessionRec.Description;
                  END
                  ELSE
                  "Profession Description":='';
                  */

            end;
        }
        field(14; "Vocation Description"; Text[250])
        {
            Caption = 'Vocation Description';
            TableRelation = Vocation."Description New";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Vocation Description" <> '' THEN BEGIN
                    VocationRec.RESET;
                    VocationRec.SETFILTER("Description New", "Vocation Description");
                    IF VocationRec.FINDFIRST THEN
                        Vocation := VocationRec.Code;

                END
                ELSE
                    Vocation := '';

                //  EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;


            //dodati
        }
        field(15; "Title Description"; Text[120])
        {
            Caption = 'Title Description';
            Editable = true;
            TableRelation = Title.Description;

            trigger OnValidate()
            begin
                IF "Title Description" <> '' THEN BEGIN
                    TitleRec.RESET;
                    TitleRec.SETFILTER(Description, "Title Description");
                    IF TitleRec.FINDFIRST THEN
                        Title := TitleRec.Code;
                    //"Title Description":=TitleRec.Description;
                END
                ELSE
                    //"Title Description":='';
                    Title := '';

                //  EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;
        }
        field(16; "Profession Description"; Text[120])
        {
            Caption = 'Profession Description';
            Editable = true;
            TableRelation = Profession.Description;

            trigger OnValidate()
            begin
                IF "Profession Description" <> '' THEN BEGIN
                    ProfessionRec.RESET;
                    ProfessionRec.SETFILTER(Description, "Profession Description");
                    IF ProfessionRec.FINDFIRST THEN
                        Profession := ProfessionRec.Code;
                END
                ELSE
                    Profession := '';

                //   EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
            end;
        }
        field(17; Active; Boolean)
        {
        }
        field(18; "From Date"; Date)
        {
            Caption = 'From Date';

            trigger OnValidate()
            begin
                /*IF "To Date"<>0D THEN BEGIN
                  IF "From Date"=0D THEN
                    ERROR(Text001);
                  IF "To Date"<"From Date" THEN
                      ERROR(Text002);
                    END;*/

                //   EmployeeResUpdate.AdditionalEducation2(xRec, Rec);
                Validate("Education Level", Rec."Education Level");

            end;
        }
        field(19; "To Date"; Date)
        {
            Caption = 'To Date';

            trigger OnValidate()
            begin
                /*IF "To Date"<>0D THEN BEGIN
                  IF "From Date"=0D THEN
                    ERROR(Text001);
                  IF "To Date"<"From Date" THEN
                      ERROR(Text002);
                    END;*/
                Validate("Education Level", Rec."Education Level");

            end;
        }
        field(20; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(21; "Year of End"; Date)
        {
            Caption = 'Year of End';
        }
        field(31; Status; enum "Employee Status Ext")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';
        }
        field(42; "Sector Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Sector Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Sector';
            Editable = false;

        }
        field(43; "Group Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Group Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Group';
            Editable = false;

        }
        field(45; "Team Description"; Text[250])
        {
            FieldClass = FlowField;

            CalcFormula = Lookup("Employee Contract Ledger"."Department Name" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Team';
            Editable = false;

        }
        field(46; "Insert Date"; Date)
        {
            Caption = 'Insert Date';
            Editable = false;
        }
        field(50021; "Employment Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Work Booklet"."Starting Date" WHERE("Current Company" = FILTER(true),
                                                                       "Employee No." = FIELD("Employee No.")));
            Caption = 'Employment Date';

        }
        field(50022; n; Code[10])
        {

            trigger OnValidate()
            begin
                WPConnSetup.FINDFIRST();


                /* CREATE(conn, TRUE, TRUE);
                 conn.Open('PROVIDER=' + WPConnSetup.Provider + ';SERVER=' + WPConnSetup.Server + ';DATABASE=' + WPConnSetup.Database + ';UID=' + WPConnSetup.UID
                           + ';PWD=' + WPConnSetup.Password + ';AllowNtlm=' + FORMAT(WPConnSetup.AllowNtlm));
                 CREATE(comm, TRUE, TRUE);

                 lvarActiveConnection := conn;
                 comm.ActiveConnection := lvarActiveConnection;

                 comm.CommandText := 'dbo.Additional_Education_Insert';
                 comm.CommandType := 4;
                 comm.CommandTimeout := 0;

                 Employee2.SETFILTER("No.", "Employee No.");
                 IF Employee2.FINDFIRST THEN BEGIN

                     param := comm.CreateParameter('@userID', 200, 1, 100, Employee2."No.");
                     comm.Parameters.Append(param);


                     param := comm.CreateParameter('@SchoolOfGraduation', 200, 1, 200, "School of Graduation");
                     comm.Parameters.Append(param);

                     param := comm.CreateParameter('@EducationLevel', 200, 1, 250, FORMAT("Education Level"));
                     comm.Parameters.Append(param);

                     param := comm.CreateParameter('@Major', 200, 1, 250, Major);
                     comm.Parameters.Append(param);


                     param := comm.CreateParameter('@FromDate', 7, 1, 0, "From Date");
                     comm.Parameters.Append(param);

                     param := comm.CreateParameter('@ToDate', 7, 1, 0, "To Date");
                     comm.Parameters.Append(param);

                     param := comm.CreateParameter('@TitleDescription', 200, 1, 250, "Title Description");
                     comm.Parameters.Append(param);
                 END;

                 comm.Execute;
                 conn.Close;
                 CLEAR(conn);
                 CLEAR(comm);*/
            end;
        }
        field(50023; "Department Cat.Description"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Employee Contract Ledger"."Department Cat. Description" WHERE("Employee No." = FIELD("Employee No.")));
            Caption = 'Department Categroy Description';
            Editable = false;

        }
    }

    keys
    {
        key(Key1; "Entry No.", "Employee No.", "Education Level", "From Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        AdditionalD: Record "Additional Education";
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

        IF Active = TRUE THEN BEGIN
            AdditionalD.Reset();
            AdditionalD.SetFilter("Employee No.", '%1', Rec."Employee No.");
            AdditionalD.SetFilter("To Date", '<>%1', Rec."To Date");
            AdditionalD.SetFilter("Education Level", '<>%1', Rec."Education Level");
            AdditionalD.SetFilter("Title Description", '<>%1', Rec."Title Description");
            AdditionalD.SetCurrentKey("To Date");
            if AdditionalD.FindLast() then begin
                AdditionalD.Validate(Active, true);

            end
            else begin


                Employee.RESET;
                Employee.SETFILTER("No.", "Employee No.");
                IF Employee.FINDFIRST THEN BEGIN
                    Employee."Education Level" := Employee."Education Level"::Empty;
                    Employee."School of Graduation" := '';
                    Employee."Major of Graduation" := '';
                    Employee."Title Code" := '';
                    Employee."Title Description" := '';
                    Employee.Vocation := '';
                    Employee.Profession := '';
                    Employee.MODIFY;
                END;
            end;
        END;
        /*  PersonalTrack.RESET;
          PersonalTrack.SETFILTER("Employee No.", '%1', "Employee No.");
          PersonalTrack.SETFILTER("Date of change", '%1', TODAY);
          PersonalTrack.SETFILTER("Code Additional", '%1', Rec."Entry No.");
          PersonalTrack.SETFILTER("Additional Education", '%1', Rec."School of Graduation");
          PersonalTrack.SETFILTER("Education Level", '%1', FORMAT(Rec."Education Level"));
          PersonalTrack.SETFILTER("Code Addr", '%1', 0);
          PersonalTrack.SETFILTER("Code Personal", '%1', '');
          PersonalTrack.SETFILTER("Contract No", '%1', 0);
          IF PersonalTrack.FINDFIRST THEN
              PersonalTrack.DELETE;*/
    end;

    trigger OnInsert()
    var
        OnI: Record "Additional Education";
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

        /*IF "Employee No."<>'' THEN BEGIN
          T_Employee.RESET;
          T_Employee.SETFILTER("No.","Employee No.");
          IF T_Employee.FINDFIRST THEN
            "First Name 2" := T_Employee."First Name";
            "Last Name 2" := T_Employee."Last Name";
        END;*/
        /*đK  if Rec."Entry No." = 0 then begin
              OnI.Reset();
              OnI.SetFilter("Entry No.", '<>%1', 0);
              OnI.SetCurrentKey("Entry No.");
              OnI.Ascending;
              if OnI.FindLast() then
                  "Entry No." := OnI."Entry No." + 1
              else
                  "Entry No." := 1;

          end;*/
        AdditionalEducation.RESET;
        AdditionalEducation.SETFILTER("Employee No.", "Employee No.");
        AdditionalEducation.SetFilter("To Date", '>%1', "To Date");
        if AdditionalEducation.FindFirst() then begin

        end
        else begin


            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Education Level" := "Education Level";
                Employee."School of Graduation" := "School of Graduation";
                Employee."Major of Graduation" := Major;
                Employee."Title Code" := Title;
                Employee."Title Description" := "Title Description";
                Employee.Vocation := Vocation;
                Employee.Profession := Profession;
                Employee.MODIFY;

                AdditionalEducation.RESET;
                AdditionalEducation.SETFILTER("Employee No.", "Employee No.");
                IF AdditionalEducation.FINDFIRST THEN BEGIN
                    REPEAT
                        AdditionalEducation.Active := FALSE;
                        AdditionalEducation.MODIFY;
                    UNTIL AdditionalEducation.NEXT = 0;
                END;

                Active := TRUE;
            END;
        end;
        "Insert Date" := TODAY;

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

        IF Active = TRUE THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Education Level" := "Education Level";
                Employee."School of Graduation" := "School of Graduation";
                Employee."Major of Graduation" := Major;
                Employee."Title Code" := Title;
                Employee."Title Description" := "Title Description";
                Employee.Vocation := Vocation;
                Employee.Profession := Profession;
                Employee.MODIFY;
            END;
        END;
        /*
        WPConnSetup.FINDFIRST();
        
        
                       CREATE(conn, TRUE, TRUE);
                       conn.Open('PROVIDER='+WPConnSetup.Provider+';SERVER='+WPConnSetup.Server+';DATABASE='+WPConnSetup.Database+';UID='+WPConnSetup.UID
                                 +';PWD='+WPConnSetup.Password+';AllowNtlm='+FORMAT(WPConnSetup.AllowNtlm));
                       CREATE(comm,TRUE, TRUE);
        
                       lvarActiveConnection := conn;
                       comm.ActiveConnection := lvarActiveConnection;
        
                       comm.CommandText := 'dbo.Additional_Education_Insert';
                       comm.CommandType := 4;
                       comm.CommandTimeout := 0;
        
                      Employee2.SETFILTER("No.","Employee No.");
                      IF Employee2.FINDFIRST THEN BEGIN
        
                       param:=comm.CreateParameter('@userID', 200, 1, 100, Employee2."No.");
                       comm.Parameters.Append(param);
        
        
                       param:=comm.CreateParameter('@SchoolOfGraduation', 200, 1, 200, "School of Graduation");
                       comm.Parameters.Append(param);
        
                       param:=comm.CreateParameter('@EducationLevel', 200, 1, 250, FORMAT("Education Level"));
                       comm.Parameters.Append(param);
        
                       param:=comm.CreateParameter('@FromDate', 7, 1, 0, "From Date");
                       comm.Parameters.Append(param);
        
                       param:=comm.CreateParameter('@ToDate', 7, 1, 0, "To Date");
                       comm.Parameters.Append(param);
        
                       param:=comm.CreateParameter('@TitleDescription', 200, 1, 250, "Title Description");
                       comm.Parameters.Append(param);
                       END;
        
                       comm.Execute;
                       conn.Close;
                       CLEAR(conn);
                       CLEAR(comm);*/


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

        IF Active = TRUE THEN BEGIN
            Employee.RESET;
            Employee.SETFILTER("No.", "Employee No.");
            IF Employee.FINDFIRST THEN BEGIN
                Employee."Education Level" := "Education Level";
                Employee."School of Graduation" := "School of Graduation";
                Employee."Major of Graduation" := Major;
                Employee."Title Code" := Title;
                Employee."Title Description" := "Title Description";
                Employee.Vocation := Vocation;
                Employee.Profession := Profession;
                Employee.MODIFY;
            END;
        END;
    end;

    var
        T_Employee: Record "Employee";
        AEE: Record "Additional Education";
        Emp: Record "Employee";
        AddEdu: Record "Points per Experience Years";
        AddEdu2: Record "Points per Experience Years";
        EduHis2: Record "Wage/Reduction Bank Accounts";
        Emp2: Record "Employee";
        Emp3: Record "Employee";
        numdays: Integer;
        VocationRec: Record "Vocation";
        TitleRec: Record "Title";
        ProfessionRec: Record "Profession";
        Employee: Record "Employee";
        AdditionalEducation: Record "Additional Education";
        Text001: Label 'Start Date must have value.';
        Text002: Label 'End Date must not be before Start date.';
        AE: Record "Additional Education";
        Empl: Record "Employee";
        //Majors: Record "Majors";
        WPConnSetup: Record "Web portal connection setup";
        /* conn: Automation;
         comm: Automation;
         param: Automation;*/
        lvarActiveConnection: Variant;
        Employee2: Record "Employee";
        //PersonalTrack: Record "Personal track report";
        ECL: Record "Employee Contract Ledger";
        //  EmployeeResUpdate: Codeunit "Employee/Resource Update 2020";
        UserPersonalization: Record "User Personalization";
}

