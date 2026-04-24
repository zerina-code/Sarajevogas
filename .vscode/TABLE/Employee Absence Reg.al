table 50104 "Employee Absence Reg"
//ED 01 START
{
    Caption = 'Employee Absence Reg';
    DrillDownPageID = "Employee Absence";
    LookupPageID = "Employee Absence";

    fields
    {
        field(1; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(2; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(3; "Quantity"; Integer)
        {
            Caption = 'Quantity';
        }
        field(4; Approved; Boolean)
        {
            Caption = 'Approved';

            trigger OnValidate()
            var
                AbsenceFIll: Codeunit "Absence Fill";
                EmployeeA: Record Employee;
                Preko: Record "Cause of Absence";
                DateFind: Record date;
                TOTAL: Decimal;
                Empl: Record
                 employee;
                WHError: Record "Wage Header";
            begin

                WHError.Reset();
                WHError.SetFilter("Month Of Wage", '%1', Date2DMY("From Date", 2));
                WHError.SetFilter("Year Of Wage", '%1', Date2DMY("From Date", 3));
                WHError.SetFilter("Wage Calculation Type", '%1', WHError."Wage Calculation Type"::Normal);
                if WHError.FindFirst() then begin

                    if UserId <> 'SARAJEVOGAS\TENEO' then
                        Error('Nije moguće mijenjati podatke kada postoji obračun!');

                    if UserId = 'SARAJEVOGAS\TENEO' then begin

                        IF Rec."Approved" = true then begin
                            IF "From Date" <> "To Date" then begin
                                EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                                EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                                EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                                if EmployeeAbsence.FindFirst() then begin
                                    EmployeeAbsence.CalcSums(Quantity);
                                    TOTAL := EmployeeAbsence.Quantity;
                                    /*WageSetup.Get();
                                    if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                        Error(Text005);*/
                                    CauseOfAbsence.Reset();
                                    EmployeeA.Get("Employee No.");
                                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                    IF Rec."Cause of Absence Code" <> '' THEN
                                        Preko.Get(Rec."Cause of Absence Code");

                                    Empl.Reset();
                                    Empl.SetFilter("No.", '%1', "Employee No.");
                                    Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                                    if Empl.FindFirst() then begin
                                        if (CauseOfAbsence.Holiday = false) and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day")
                                        and (Preko."Added To Hour Pool" = false) AND (TOTAL >= 8) then
                                            Error(Text005);

                                    end;
                                end;
                            end;

                            IF "From Date" = "To Date" then begin
                                EmployeeAbsence.SetFilter("From Date", '%1', Rec."From Date");
                                EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                                EmployeeAbsence.SetFilter("Employee No.", '%1', Rec."Employee No.");
                                if EmployeeAbsence.FindFirst() then begin
                                    EmployeeAbsence.CalcSums(Quantity);
                                    TOTAL := EmployeeAbsence.Quantity;
                                    //ĐK
                                    /*WageSetup.Get();
                                    if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                        Error(Text005);*/
                                    CauseOfAbsence.Reset();
                                    EmployeeA.get(Rec."Employee No.");
                                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                    IF Rec."Cause of Absence Code" <> '' THEN
                                        Preko.Get(Rec."Cause of Absence Code");

                                    Empl.Reset();
                                    Empl.SetFilter("No.", '%1', "Employee No.");
                                    Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                                    if Empl.FindFirst() then begin

                                        if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false)
                                        and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day") AND (TOTAL >= 8)
                                     then
                                            Error(Text005);
                                    end;
                                end;
                            end;

                            EmployeeA.GET(Rec."Employee No.");
                            //Hours
                            AbsenceFIll.EmployeeAbsence("From Date", "To Date", EmployeeA, Rec."Cause of Absence Code", Rec.Hours);
                        end;

                        If Rec."Approved" = false then begin
                            EmployeeAbsence.Reset();
                            EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
                            EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                            EmployeeAbsence.SetFilter("Cause of Absence Code", '%1', "Cause of Absence Code");
                            //EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                            //iz kalendara će svaki postavljeni praznik imati u šiframa izostanaka za holiday true
                            //dakle trebam ostaviti samo odsustva gdje je causeofabsence.holiday = false
                            if EmployeeAbsence.FindFirst() then
                                repeat
                                    CauseOfAbsence.Reset();
                                    CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                    if CauseOfAbsence.Holiday = false then
                                        EmployeeAbsence.Delete();
                                until EmployeeAbsence.Next() = 0;
                            /*WageSetup.Get();
                            EmployeeAbsence.SetFilter("Cause of Absence Code", '<>%1', WageSetup."Holiday Code");
                            EmployeeAbsence.DeleteAll();*/
                        end;

                        if Hours = 0 then begin
                            if ("Cause of absence on-call" = true) and (Approved = true) then begin
                                DateFind.Reset();

                                CauseOfAbsence.Reset();
                                CauseOfAbsence.Get(rec."Cause of Absence Code");
                                if CauseOfAbsence.Weekend = false then
                                    DateFind.SetFilter("Period No.", '<>%1 & <>%2', 6, 7);
                                DateFind.SetFilter("Period Type", '%1', DateFind."Period Type"::Date);
                                DateFind.SetFilter("Period Start", '%1..%2', "From Date", "To Date");
                                if DateFind.FindFirst() then begin
                                    EmployeeA.GET(Rec."Employee No.");
                                    Rec.Hours := EmployeeA."Hours In Day" * DateFind.Count;

                                end;






                            end;

                        end;

                    end;


                end
                else begin

                    IF Rec."Approved" = true then begin
                        IF "From Date" <> "To Date" then begin
                            EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                            EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                            EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                            if EmployeeAbsence.FindFirst() then begin
                                EmployeeAbsence.CalcSums(Quantity);
                                TOTAL := EmployeeAbsence.Quantity;
                                /*WageSetup.Get();
                                if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                    Error(Text005);*/
                                CauseOfAbsence.Reset();
                                EmployeeA.Get("Employee No.");
                                CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                IF Rec."Cause of Absence Code" <> '' THEN
                                    Preko.Get(Rec."Cause of Absence Code");

                                Empl.Reset();
                                Empl.SetFilter("No.", '%1', "Employee No.");
                                Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                                if Empl.FindFirst() then begin
                                    if (CauseOfAbsence.Holiday = false) and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day")
                                    and (Preko."Added To Hour Pool" = false) AND (TOTAL >= 8) then
                                        Error(Text005);

                                end;
                            end;
                        end;

                        IF "From Date" = "To Date" then begin
                            EmployeeAbsence.SetFilter("From Date", '%1', Rec."From Date");
                            EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                            EmployeeAbsence.SetFilter("Employee No.", '%1', Rec."Employee No.");
                            if EmployeeAbsence.FindFirst() then begin
                                EmployeeAbsence.CalcSums(Quantity);
                                TOTAL := EmployeeAbsence.Quantity;
                                //ĐK
                                /*WageSetup.Get();
                                if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                                    Error(Text005);*/
                                CauseOfAbsence.Reset();
                                EmployeeA.get(Rec."Employee No.");
                                CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                IF Rec."Cause of Absence Code" <> '' THEN
                                    Preko.Get(Rec."Cause of Absence Code");

                                Empl.Reset();
                                Empl.SetFilter("No.", '%1', "Employee No.");
                                Empl.SetFilter("Rad u smjenama", '%1', Empl."Rad u smjenama"::"Work in shifts");
                                if Empl.FindFirst() then begin
                                    // ne radi ništa
                                end else begin
                                    //if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false)
                                    //and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day") AND (TOTAL >= 8) amir: originalni kod zakomentarisan
                                    //Error(Text005);
                                    // ovaj if blok je prebačen u else dio
                                    if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false)
                                        and (EmployeeAbsence.Quantity >= EmployeeA."Hours In Day") AND (TOTAL >= 8) then
                                        Error(Text009, "Employee No.");
                                end;
                            end;
                        end;

                        EmployeeA.GET(Rec."Employee No.");
                        //Hours
                        AbsenceFIll.EmployeeAbsence("From Date", "To Date", EmployeeA, Rec."Cause of Absence Code", Rec.Hours);
                    end;

                    If Rec."Approved" = false then begin
                        EmployeeAbsence.Reset();
                        EmployeeAbsence.SetFilter("Employee No.", "Employee No.");
                        EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                        EmployeeAbsence.SetFilter("Cause of Absence Code", '%1', "Cause of Absence Code");
                        //EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        //iz kalendara će svaki postavljeni praznik imati u šiframa izostanaka za holiday true
                        //dakle trebam ostaviti samo odsustva gdje je causeofabsence.holiday = false
                        if EmployeeAbsence.FindFirst() then
                            repeat
                                CauseOfAbsence.Reset();
                                CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                                if CauseOfAbsence.Holiday = false then
                                    EmployeeAbsence.Delete();
                            until EmployeeAbsence.Next() = 0;
                        /*WageSetup.Get();
                        EmployeeAbsence.SetFilter("Cause of Absence Code", '<>%1', WageSetup."Holiday Code");
                        EmployeeAbsence.DeleteAll();*/
                    end;

                    if Hours = 0 then begin
                        if ("Cause of absence on-call" = true) and (Approved = true) then begin
                            DateFind.Reset();

                            CauseOfAbsence.Reset();
                            CauseOfAbsence.Get(rec."Cause of Absence Code");
                            if CauseOfAbsence.Weekend = false then
                                DateFind.SetFilter("Period No.", '<>%1 & <>%2', 6, 7);
                            DateFind.SetFilter("Period Type", '%1', DateFind."Period Type"::Date);
                            DateFind.SetFilter("Period Start", '%1..%2', "From Date", "To Date");
                            if DateFind.FindFirst() then begin
                                EmployeeA.GET(Rec."Employee No.");
                                Rec.Hours := EmployeeA."Hours In Day" * DateFind.Count;

                            end;






                        end;

                    end;

                end;
            end;
        }
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(6; "Description"; Code[50])
        {
            Caption = 'Description';
            Editable = false;
        }
        field(7; "Cause of Absence Code"; Code[10])
        {
            Caption = 'Cause of Absence Code';
            TableRelation = "Cause of Absence";

            trigger OnValidate()
            begin
                IF Approved = true then
                    error(Text006);

                CauseOfAbsence.GET("Cause of Absence Code");
                "Cause of absence on-call" := CauseOfAbsence."Cause of Absence On-Call";
                Description := CauseOfAbsence.Description;
                VALIDATE("Unit of Measure Code", CauseOfAbsence."Unit of Measure Code");

                IF "From Date" = 0D then
                    Error(Text001);

                IF "To Date" = 0D then
                    ERROR(Text004);

                if (rec."Employee No." <> '')
   and (rec."From Date" <> 0D)
   and (rec."To Date" <> 0D)
   and (Rec."Cause of Absence Code" <> '') then
                    rec."Calculated Hours by Entry" := CalculateDays(rec."Employee No.", rec."Entry No.", rec."From Date", rec."To Date", rec."Cause of Absence Code", rec.Hours);

            end;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';

            trigger OnValidate()
            var
                Preko: Record "Cause of Absence";
            begin
                IF Approved = true then
                    error(Text006);

                IF "To Date" <> 0D THEN BEGIN

                    IF "From Date" > "To Date" then
                        ERROR(Text002);
                    EmployeeAbsence.Reset();
                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);

                    if EmployeeAbsence.FindFirst() then begin
                        /*WageSetup.Get();
                        if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                            Error(Text005);*/
                        CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                        IF Rec."Cause of Absence Code" <> '' THEn
                            Preko.Get(Rec."Cause of Absence Code");

                        // EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                        if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false) then
                            Error(Text005);
                    end;

                    // Provjera da li su From Date i To Date u istom mjesecu i godini
                    // Ovakav raspored ifova je kako bi validacija dozvolila promjenu datuma
                    // Ukoliko su datum od i datum do pogresno unijeti (Potrebno je obrisati oba datuma, pa tek onda ukucati dva nova datuma)
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                        if ("From Date" > "To Date") then
                            Error(Text002);

                        if (Date2DMY("From Date", 2) <> Date2DMY("To Date", 2)) or
                           (Date2DMY("From Date", 3) <> Date2DMY("To Date", 3)) then
                            Error(Text008);

                        IF "From Date" = 0D THEN
                            ERROR(Text001);
                    end;
                END;
                if (rec."Employee No." <> '')
       and (rec."From Date" <> 0D)
       and (rec."To Date" <> 0D)
       and (Rec."Cause of Absence Code" <> '') then
                    rec."Calculated Hours by Entry" := CalculateDays(rec."Employee No.", rec."Entry No.", rec."From Date", rec."To Date", rec."Cause of Absence Code", rec.Hours);


                Month := Date2DMY("From Date", 2);
                Year := Date2DMY("From Date", 3);
            end;
        }
        field(9; "To Date"; Date)
        {
            Caption = 'To Date';
            trigger OnValidate()
            var
                Preko: Record "Cause of Absence";
            begin
                IF Approved = true then
                    error(Text006);

                IF "From Date" <> 0D THEN BEGIN

                    //IF "From Date" > "To Date" then
                    // ERROR(Text003);

                    EmployeeAbsence.SetFilter("Employee No.", '%1', "Employee No.");
                    EmployeeAbsence.SetFilter("From Date", '%1..%2', Rec."From Date", Rec."To Date");
                    EmployeeAbsence.SetFilter("Add Hours", '%1', false);
                    if EmployeeAbsence.FindFirst() then begin
                        /*WageSetup.Get();
                        if not (EmployeeAbsence."Cause of Absence Code" = WageSetup."Holiday Code") then
                            Error(Text005);*/
                        CauseOfAbsence.Get(EmployeeAbsence."Cause of Absence Code");
                        IF REC."Cause of Absence Code" <> '' THEN
                            Preko.Get(Rec."Cause of Absence Code");

                        if (CauseOfAbsence.Holiday = false) and (Preko."Added To Hour Pool" = false) then
                            Error(Text005);
                    end;

                    // Provjera da li su From Date i To Date u istom mjesecu i godini
                    // Ovakav raspored ifova je kako bi validacija dozvolila promjenu datuma
                    // Ukoliko su datum od i datum do pogresno unijeti (Potrebno je obrisati oba datuma, pa tek onda ukucati dva nova datuma)
                    if ("From Date" <> 0D) and ("To Date" <> 0D) then begin
                        if (Date2DMY("From Date", 2) <> Date2DMY("To Date", 2)) or
                           (Date2DMY("From Date", 3) <> Date2DMY("To Date", 3)) then
                            Error(Text008);

                        IF "To Date" = 0D THEN
                            ERROR(Text004);

                        if ("From Date" > "To Date") then
                            Error(Text003);
                    end;
                END;

                if (rec."Employee No." <> '')
       and (rec."From Date" <> 0D)
       and (rec."To Date" <> 0D)
       and (Rec."Cause of Absence Code" <> '') then
                    rec."Calculated Hours by Entry" := CalculateDays(rec."Employee No.", rec."Entry No.", rec."From Date", rec."To Date", rec."Cause of Absence Code", rec.Hours);

                Month := Date2DMY("To Date", 2);
                Year := Date2DMY("To Date", 3);
            end;
        }
        field(10; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            var
                EmployeeNoAsInt: Integer;
                ECL: Record "Employee Contract Ledger";
            begin
                IF Approved = true then
                    error(Text006);

                Employee.GET("Employee No.");
                "First Name" := Employee."First Name";
                "Last Name" := Employee."Last Name";

                ECL.Reset();
                ECL.SetFilter("Employee No.", '%1', rec."Employee No.");
                ECL.SetFilter(Active, '%1', true);
                ECL.SetFilter("Show Record", '%1', true);
                if ecl.FindFirst() then begin
                    "Department Code" := ecl."Department Code";
                    "Department Name" := ecl."Department Name";
                    "B-1 (with regions) Description" := ecl."Department Cat. Description";
                    "B-1 Description" := ecl."Sector Description";
                    "Stream Description" := ecl."Group Description";
                end
                else begin
                    "Department Code" := '';
                    "Department Name" := '';
                    "B-1 (with regions) Description" := '';
                    "B-1 Description" := '';
                    "Stream Description" := '';
                end;

                // Prilikom kreiranja upiši integer verziju personalnog broja za potrebe sortiranja
                if EVALUATE(EmployeeNoAsInt, "Employee No.") then
                    "Sorting Emp No." := EmployeeNoAsInt
                else
                    "Sorting Emp No." := 0;
            end;
        }

        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            begin
                HumanResUnitOfMeasure.Get("Unit of Measure Code");
                "Qty. per Unit of Measure" := HumanResUnitOfMeasure."Qty. per Unit of Measure";
                Validate(Quantity);
            end;
        }

        field(12; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }

        field(13; "Hours"; Integer)
        {
            Caption = 'Hours';
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                if (rec."Employee No." <> '')
       and (rec."From Date" <> 0D)
       and (rec."To Date" <> 0D)
       and (Rec."Cause of Absence Code" <> '') then
                    rec."Calculated Hours by Entry" := CalculateDays(rec."Employee No.", rec."Entry No.", rec."From Date", rec."To Date", rec."Cause of Absence Code", rec.Hours);

            end;
        }
        field(14; "Cause of absence on-call"; Boolean)
        {
            Caption = 'Pripravnost';
        }
        field(15; "Sorting Emp No."; Integer)
        {
            Caption = 'Sorting Emp No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(50126; "Department Code"; Code[50])
        {
            Caption = 'Department Code';
            Editable = true;
            //šifra org jedinice
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
        field(50094; "Calculated Hours by Entry"; Integer)
        {
            Caption = 'Calculated Hours by Entry';
        }

        field(50095; "Year"; Integer)
        {
            Caption = 'Year';
        }


        field(50096; "Month"; Integer)
        {
            Caption = 'Month';
        }
        field(50097; "Sum by Cause of absence"; Integer)
        {
            Caption = 'Sum by Cause of absence';
            FieldClass = FlowField;
            CalcFormula = sum("Employee Absence Reg"."Calculated Hours by Entry" where("Employee No." = field("Employee No."), "Cause of Absence Code" = field("Cause of Absence Code"), Month = field(Month), Year = field(Year)));
        }

        field(50098; "Sum by Cause of Org"; Integer)
        {
            Caption = 'Sum by Cause of Org';
            FieldClass = FlowField;
            CalcFormula = sum("Employee Absence Reg"."Calculated Hours by Entry" where("Department Code" = field("Department Code"), "Cause of Absence Code" = field("Cause of Absence Code"), Month = field(Month), Year = field(Year)));
        }

    }

    keys
    {
        key(PrimaryKey; "Employee No.", "Entry No.")
        {

        }
        key(SortingKey; "Sorting Emp No.")
        {
            Clustered = true;
        }
        key(Key2; "Employee No.", Hours, Month, Year)
        {
            SumIndexFields = "Calculated Hours by Entry";
        }
        key(Key3; "Department Code", Hours, Month, Year)
        {
            SumIndexFields = "Calculated Hours by Entry";
        }
    }

    var
        HumanResUnitOfMeasure: Record "Human Resource Unit of Measure";
        CauseOfAbsence: Record "Cause of Absence";
        Employee: Record "Employee";
        BlockedErr: Label 'You cannot register absence because the employee is blocked due to privacy.';
        EmployeeAbsenceReg: Record "Employee Absence Reg";
        EmployeeAbsence: Record "Employee Absence";
        WageSetup: Record "Wage Setup";
        Text001: Label 'Starting Date field cannot be blank.';
        Text002: Label 'Starting Date field cannot be after Ending Date field.';
        Text003: Label 'Ending Date field cannot be before Starting Date field.';
        Text004: Label 'Ending Date field cannot be blank.';
        Text005: Label 'A leave for this period already exists.';
        Text006: Label 'Selected record has already been approved.';
        Text007: Label 'Cause of absence field cannot be blank.';
        Text008: Label 'Entries must be within the same month and year.';
        Text009: Label 'A leave for this period already exists. Employee %1 is marked as Regular work and thus cannot have more than 8 hours.';
        VisibleHours: Boolean;

    trigger OnInsert()
    begin
        if rec."Cause of Absence Code" = '' then
            Error(Text007);

        EmployeeAbsenceReg.Reset();
        EmployeeAbsenceReg.SetCurrentKey("Entry No.");
        if EmployeeAbsenceReg.FindLast then
            "Entry No." := EmployeeAbsenceReg."Entry No." + 1
        else begin
            "Entry No." := 1;
        end;


    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin

    end;

    trigger OnDelete()
    begin
        if Rec.Approved = true then begin
            Error(Text006);
        end;
    end;

    procedure CalculateDays(Emp: Code[20]; EntryNo: Integer; DateFrom: date; DateTo: date; CauseOfAbsence: Code[20]; HoursSent: Integer) ReturnNumberHours: Integer
    var
        TOTAL: Decimal;
        CauseOfAbsenceR: Record "Cause of Absence";
        EmployeeA: Record Employee;
        AbsenceFIll: Codeunit "Absence Fill";

    begin
        EmployeeA.get(EMp);
        //Hours
        ReturnNumberHours := AbsenceFIll.EmployeeAbsenceInsertNo(DateFrom, DateTo, EmployeeA, CauseOfAbsence, HoursSent);


    end;



}





