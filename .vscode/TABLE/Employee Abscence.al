tableextension 50022 MyExtension extends "Employee Absence"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "RS Code"; Code[20])
        {
            Caption = 'RS Code';
        }
        field(50001; "Statistics Group Code"; Code[20])
        {
            Caption = 'Statistics Group Code';
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
        }
        field(50003; "Vacation from Year"; Integer)
        {
            Caption = 'Vacation from Year';

        }
        field(50004; "First Name"; Text[30])
        {
            Caption = 'First Name';
            Editable = false;
        }
        field(50005; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
            Editable = false;
        }
        field(50126; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            Editable = true;
            //šifra org jedinice
        }
        field(50127; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(50128; "Wage Calculation No."; Code[20])
        {
            Caption = 'Wage Calculaion No.';
        }
        field(50129; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(50130; "Cause of Absence Subtype Code"; Code[50])
        {
            Caption = 'Cause of Absence Subtype Code';

            trigger OnValidate()
            begin
                /*COAS.GET("Cause of Absence Code",Rec."Cause of Absence Subtype Code");
                "Cause of Absence Subtype Desc" := COAS.Description;*/

            end;
        }
        field(50131; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = true;
            FieldClass = Normal;

            //naziv organizacione jedincie
        }
        field(50132; "B-1 Description"; Text[250])
        {
            Caption = 'B-1 Description';
            Editable = true;
            FieldClass = Normal;
            //sektor
        }
        field(50133; "B-1 (with regions) Description"; Text[250])
        {
            Caption = 'B-1 (with regions) Description';
            Editable = true;
            FieldClass = Normal;
            //SLužba
        }
        field(50134; "Stream Description"; Text[250])
        {
            Caption = 'Stream Description';
            Editable = true;
            FieldClass = Normal;
            ///Odjel
        }
        /*  field(50135; "Cause of Absence Subtype Desc"; Text[250])
          {
              CalcFormula = Lookup("Cause of Absence Subtype".Description WHERE(Code = FIELD("Cause of Absence Subtype Code")));
              Caption = 'Cause of Absence Subtype Desc';
              Editable = false;
              FieldClass = FlowField;
          }*/
        field(50136; "Full Name"; Text[250])
        {
            Caption = 'Full Name';
        }
        field(50137; "Cause of Absence Subtype Corr."; Code[50])
        {
            Caption = 'Cause of Absence Subtype Code -Corr.';
            NotBlank = false;

            trigger OnValidate()
            begin
                /*COAS.GET("Cause of Absence Code",Rec."Cause of Absence Subtype Code");
                "Cause of Absence Subtype Desc" := COAS.Description;*/

            end;
        }
        field(50138; "Real Date"; Date)
        {
            Caption = 'Real Date';
            NotBlank = false;
        }
        field(50139; "Cause of Absence Code Corr."; Code[50])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            begin
                CauseOfAbsence.GET("Cause of Absence Code");
                Description := CauseOfAbsence.Description;
                VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");
                VALIDATE("Short Code Corrections", CauseOfAbsence."Short Code");
            end;
        }
        field(50140; Status; enum "Employee Abs ")
        {
            Caption = 'Status';


        }
        field(50141; "Order"; Integer)
        {
        }
        modify("Employee No.")
        {
            trigger OnAfterValidate()
            var
                EmployeeRecord: Record Employee;
                EmployeeNoAsInt: Integer;
            begin
                // Prilikom kreiranja upiši integer verziju personalnog broja za potrebe sortiranja
                if EVALUATE(EmployeeNoAsInt, "Employee No.") then
                    "Sorting Emp No." := EmployeeNoAsInt
                else
                    "Sorting Emp No." := 0;

                //popuni polja ime i prezime:
                if EmployeeRecord.Get("Employee No.") then begin
                    "First Name" := EmployeeRecord."First Name";
                    "Last Name" := EmployeeRecord."Last Name";
                end else begin
                    "First Name" := '';
                    "Last Name" := '';
                end;
            end;
        }

        modify("From Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
                VacationSetup: Record "Vacation Setup history";
            begin

                if "Cause of Absence Code" = VacationSetup."Vacation Code" then
                    "Vacation from Year" := Date2DMY("From Date", 3);
                if "Cause of Absence Code" = VacationSetup."Vacation Code Last Year" then
                    "Vacation from Year" := Date2DMY("From Date", 3) - 1;

                IF "To Date" <> 0D THEN BEGIN
                    // Provjera da li su From Date i To Date u istom mjesecu i godini
                    // Ovakav raspored ifova je kako bi validacija dozvolila promjenu datuma
                    // Ukoliko su datum od i datum do pogresno unijeti (Potrebno je obrisati oba datuma, pa tek onda ukucati dva nova datuma)
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                        if ("From Date" > "To Date") then
                            Error(Text002);

                        if (Date2DMY("From Date", 2) <> Date2DMY("To Date", 2)) or
                           (Date2DMY("From Date", 3) <> Date2DMY("To Date", 3)) then
                            Error(Text003);

                        IF "From Date" = 0D THEN
                            ERROR(Text001);
                    end;
                end;
            end;
        }

        modify("To Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                IF "From Date" <> 0D THEN BEGIN
                    // Provjera da li su From Date i To Date u istom mjesecu i godini
                    // Ovakav raspored ifova je kako bi validacija dozvolila promjenu datuma
                    // Ukoliko su datum od i datum do pogresno unijeti (Potrebno je obrisati oba datuma, pa tek onda ukucati dva nova datuma)
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                        if (Date2DMY("From Date", 2) <> Date2DMY("To Date", 2)) or
                           (Date2DMY("From Date", 3) <> Date2DMY("To Date", 3)) then
                            Error(Text003);

                        if ("From Date" > "To Date") then
                            Error(Text005);

                        IF "To Date" = 0D THEN
                            ERROR(Text004);
                    end;
                end;
            end;
        }

        field(50142; "Short Code"; Code[10])
        {
            Caption = 'Short Code';
            TableRelation = "Cause of Absence"."Short Code";
        }
        field(50143; "Short Code Corrections"; Code[10])
        {
            Caption = 'Short Code Corrections';
            TableRelation = "Cause of Absence"."Short Code";
        }
        field(50144; "Correction Resumed"; Boolean)
        {
            Caption = 'Correction Resumed';
        }
        field(50145; "Comment 2"; Text[250])
        {
            Caption = 'Comment';
        }
        field(50146; "Old Wage Base"; Boolean)
        {
            Caption = 'Old Wage Base';
        }
        field(50147; "Correction Quantity"; Integer)
        {
            Caption = 'Correction Resumed';
        }
        field(50148; Approved; Boolean)
        {
            Caption = 'Approved';
        }

        field(50149; "Bound to Year"; Integer)
        {
            Caption = 'Bound to Year';
        }

        field(50150; "Work Type"; Option)
        {
            Caption = 'Work Type';
            OptionMembers = " ","Vacation";
        }
        field(50151; "Add Hours"; Boolean)
        {
            Caption = 'Add Hours';
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Added To Hour Pool" where(Code = field("Cause of Absence Code")));
        }

        //UnPaid Days
        field(50152; "Unpaid"; Boolean)
        {
            Caption = 'Neplaćeno';
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Unpaid days" where(Code = field("Cause of Absence Code")));
        }
        field(50153; "Sick Leave"; Boolean)
        {
            Caption = 'Sick Leave';
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Sick Leave" where(Code = field("Cause of Absence Code")));
        }

        //Weekend
        field(50154; "Weekend"; Boolean)
        {
            Caption = 'Weekend';
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Weekend" where(Code = field("Cause of Absence Code")));
        }
        field(50155; "Payment Type"; Option)
        {
            OptionCaption = ',Regular Work,Additional,Work Performance,Other Additional';
            OptionMembers = "<","Regular Work","Additional>","Work Performance","Other Additional";
            FieldClass = FlowField;
            CalcFormula = lookup("Cause of Absence"."Payment Type" where(Code = field("Cause of Absence Code")));
        }
        field(50156; "Sorting Emp No."; Integer)
        {
            Caption = 'Sorting Emp No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50092; "Author UserName"; Text[250])
        {
            Caption = 'Author UserName';
            FieldClass = FlowField;
            CalcFormula = lookup(user."User Name" where("User Security ID" = field(SystemCreatedBy)));

        }
        field(50093; "Modify UserName"; Text[250])
        {
            Caption = 'Modify UserName';
            FieldClass = FlowField;
            CalcFormula = lookup(user."User Name" where("User Security ID" = field(SystemModifiedBy)));

        }







        modify("Cause of Absence Code")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                CauseOfAbsence.reset();
                CauseOfAbsence.SetFilter(Code, '%1', "Cause of Absence Code");
                if CauseOfAbsence.FindFirst() then begin
                    "Short Code" := CauseOfAbsence."Short Code";
                end
                else begin
                    "Short Code" := '';
                end;

            end;



        }











    }

    trigger OnAfterModify()
    begin
        if ("From Date" = 0D) or ("To Date" = 0D) then
            Error(Text006);
    end;

    var
        myInt: Integer;
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Entries must be within the same month and year.';
        Text004: Label 'Ending Date field cannot be blank.';
        Text005: Label 'Ending Date field cannot be before Starting Date field.';
        Text006: Label 'Both "From Date" and "To Date" must be set before saving the record.';

}