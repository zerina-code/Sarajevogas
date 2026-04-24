table 50072 "Obligation"
{
    DataClassification = ToBeClassified;
    LookupPageId = Obligations;
    DrillDownPageId = Obligations;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "Fixed Asset"."No.";

        }
        field(2; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = "FA Location";
            trigger OnValidate()
            var
                FAR: Record "Fixed Asset";
            begin
                FAR.Reset();
                FAR.SetFilter("No.", '%1', Rec."No.");
                if FAR.FindFirst() then begin
                    FAR."FA Location Code" := "Location Code";
                    FAR.Modify();
                end


            end;

        }
        field(3; "Responsible Person Code"; Code[20])
        {
            Caption = 'Responsible Person Code';

        }
        field(4; "Date From"; Date)
        {
            Caption = 'Date From';
            trigger OnValidate()
            var
                myInt: Integer;
                OB: Record Obligation;
                OBRENAME: Record Obligation;
            begin

                IF "Date To" <> 0D THEN BEGIN
                    IF "Date From" = 0D THEN
                        ERROR(Text000);
                    IF "Date To" < "Date From" THEN
                        ERROR(Text001);
                END;



                if ("Date From" <= Today) and (("Date To" >= Today) or ("Date To" = 0D)) then
                    Active := true
                else
                    Active := false;


                if "Date From" <> 0D then begin
                    OB.Reset();
                    OB.SetFilter("No.", '%1', Rec."No.");
                    // OB.SetFilter("Date From", '<>%1', Rec."Date From");
                    OB.SetFilter(Entry, '<>%1', Rec.Entry);
                    OB.SetCurrentKey("Date From");
                    OB.Ascending;
                    if OB.FindLast() then begin
                        if OB."Date To" = 0D then BEGIn

                            //"No.", "Customer No.", Type, "Date From", "Date To", "Responsible Person Name")

                            if OBRENAME.get(OB."No.", ob."Customer No.", OB.Type, OB."Date From", OB."Date To", OB."Responsible Person Name") THEN
                                OBRENAME.RENAME(OB."No.", ob."Customer No.", OB.Type, OB."Date From", CalcDate('<-1D>', "Date From"), OB."Responsible Person Name");

                            if (OBRENAME."Date To" < today) and (OBRENAME."Date To" <> 0D) then begin
                                OBRENAME.Active := false;
                                obrename.MODIFY;
                            end;

                        END
                        else begin
                            if OBRENAME.get(OB."No.", ob."Customer No.", OB.Type, OB."Date From", OB."Date To", OB."Responsible Person Name") THEN begin
                                OBRENAME.RENAME(OB."No.", ob."Customer No.", OB.Type, OB."Date From", CalcDate('<-1D>', "Date From"), OB."Responsible Person Name");


                                if (OBRENAME."Date To" < today) and (OBRENAME."Date To" <> 0D) then begin
                                    OBRENAME.Active := false;
                                    obrename.MODIFY;
                                end;
                            end;
                        end;



                    end;

                    if "Obligation type" = "Obligation type"::"Razduženje" then begin

                        if ("Date From" <= Today) and (("Date To" >= Today) or ("Date To" = 0D)) then
                            Active := false;

                        OB.Reset();
                        OB.SetFilter("No.", '%1', Rec."No.");
                        OB.SetFilter(Entry, '<>%1', Rec.Entry);
                        OB.SetCurrentKey("Date From");
                        OB.Ascending;
                        if OB.FindLast() then begin
                            if OB."Date To" = 0D then BEGIN

                                if OBRENAME.get(OB."No.", ob."Customer No.", OB.Type, OB."Date From", OB."Date To", OB."Responsible Person Name") THEN begin
                                    OBRENAME.RENAME(OB."No.", ob."Customer No.", OB.Type, OB."Date From", CalcDate('<-1D>', "Date From"), OB."Responsible Person Name");


                                    if (OBRENAME."Date To" < today) and (OBRENAME."Date To" <> 0D) then begin
                                        OBRENAME.Active := false;
                                        obrename.MODIFY;
                                    end;
                                end
                                else begin
                                    if (OB."Date To" < Today) and (OB."Date To" <> 0D) then begin

                                        if OBRENAME.get(OB."No.", ob."Customer No.", OB.Type, OB."Date From", OB."Date To", OB."Responsible Person Name") THEN begin
                                            OBRENAME.RENAME(OB."No.", ob."Customer No.", OB.Type, OB."Date From", CalcDate('<-1D>', "Date From"), OB."Responsible Person Name");

                                            if (OBRENAME."Date To" < today) and (OBRENAME."Date To" <> 0D) then begin
                                                OBRENAME.Active := false;
                                                obrename.MODIFY;
                                            end;

                                        end;

                                    end;

                                END;




                            end;
                        end;
                    end;


                end;
            end;

        }
        field(5; "Date To"; Date)
        {
            Caption = 'Date To';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ("Date From" < Today) and (("Date To" >= Today) or ("Date To" = 0D)) then
                    Active := true
                else
                    Active := false;

            end;

        }
        field(6; "Active"; Boolean)
        {
            Caption = 'Active';

        }
        field(7; "Employee Name"; Text[250])
        {
            Caption = 'Employee Name';
            trigger OnValidate()
            var
                FAR: Record "Fixed Asset";
            begin
                if "Employee Name" <> '' then
                    "Responsible Person Name" := "Employee Name";


            end;

        }
        field(8; "Contact Name"; Code[250])
        {
            Caption = 'Contact Name';
            trigger OnValidate()
            var
                FAR: Record "Fixed Asset";
            begin
                if "Contact Name" <> '' then
                    "Responsible Person Name" := "Contact Name";


            end;

        }
        field(9; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                Emp: Record Employee;
                ECL: Record "Employee Contract Ledger";

            begin
                Emp.Reset();
                Emp.SetFilter("No.", '%1', Rec."Employee No.");
                if Emp.FindFirst() then begin
                    Validate("Employee Name", Emp."First Name" + ' ' + Emp."Last Name");
                    ECL.Reset();
                    ECL.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    ECL.SetFilter("Starting Date", '<=%1', Today);
                    ECL.Ascending;
                    if ecl.FindLast() then
                        "Responsible Sector" := ECL."Sector Description"
                    else
                        "Responsible Sector" := '';


                end;
                Validate("Obligation type", Rec."Obligation type");
                if Rec."Employee No. - Use FA" = '' then begin
                    Validate("Use FA Type", "Use FA Type"::Employee);
                    Validate("Employee No. - Use FA", Rec."Employee No.");
                    Validate("Employee Name - Use FA", Rec."Employee Name");

                end;


            end;

        }
        field(10; "Responsible Person Name"; Code[250])
        {
            Caption = 'Responsible Person Name';

        }
        field(11; "Customer No."; Code[20])
        {
            Caption = 'Customer Code';
            TableRelation = Customer."No.";
        }
        field(12; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(13; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = " ",Customer,Employee;
            OptionCaption = ' ,Customer,Employee';

        }
        field(14; "Location Name"; Text[50])
        {
            Caption = 'Location Name';

            FieldClass = FlowField;
            CalcFormula = lookup("FA Location".Name where(Code = field("Location Code")));
            Editable = false;

        }
        field(21; "Obligation type"; Option)
        {
            Caption = 'Obligation Type';
            OptionMembers = ,Zaduženje,Razduženje;
            trigger OnValidate()
            var
                myInt: Integer;
                GeneralS: Record "General Ledger Setup";
                NoSeriesMgt: Codeunit NoSeriesExtented;
                OBToday: Record Obligation;
            begin

                IF ("Obligation type" = "Obligation type"::"Zaduženje") and ("Z.Obligation" = '') and (("Employee No." <> '') or ("Location Code" <> '')) THEN BEGIN

                    GeneralS.GET;
                    GeneralS.TESTFIELD("Z.Obligation Series");
                    OBToday.Reset();
                    IF Rec."Employee No." <> '' then
                        OBToday.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    IF Rec."Location Code" <> '' then
                        OBToday.SetFilter("Location Code", '%1', Rec."Location Code");
                    OBToday.SetFilter("Obligation type", '%1', Rec."Obligation type");
                    OBToday.SetFilter("Date From", '%1', Rec."Date From");
                    OBToday.SetFilter("No.", '<>%1', Rec."No.");
                    OBToday.SetFilter("Z.Obligation", '<>%1', '');
                    if OBToday.FindFirst() then
                        "Z.Obligation" := OBToday."Z.Obligation"
                    else
                        NoSeriesMgt.InitSeries(GeneralS."Z.Obligation Series", '', 0D, "Z.Obligation", GeneralS."Z.Obligation Series");
                END;

                IF ("Obligation type" = "Obligation type"::"Razduženje") and ("R.Obligation" = '') and (("Employee No." <> '') or ("Location Code" <> '')) THEN BEGIN
                    GeneralS.GET;
                    GeneralS.TESTFIELD("R.Obligation Series");
                    OBToday.Reset();
                    IF Rec."Employee No." <> '' then
                        OBToday.SetFilter("Employee No.", '%1', Rec."Employee No.");
                    IF Rec."Location Code" <> '' then
                        OBToday.SetFilter("Location Code", '%1', Rec."Location Code");
                    OBToday.SetFilter("Obligation type", '%1', Rec."Obligation type");
                    OBToday.SetFilter("Date From", '%1', Rec."Date From");
                    OBToday.SetFilter("No.", '<>%1', Rec."No.");
                    OBToday.SetFilter("Z.Obligation", '<>%1', '');
                    if OBToday.FindFirst() then
                        "R.Obligation" := OBToday."R.Obligation"
                    else
                        NoSeriesMgt.InitSeries(GeneralS."R.Obligation Series", '', 0D, "R.Obligation", GeneralS."R.Obligation Series");
                END;



            end;

        }
        field(22; "Z.Obligation"; Code[20])

        {
            TableRelation = "No. Series".Code;

        }
        field(23; "R.Obligation"; Code[20])

        {
            TableRelation = "No. Series".Code;
        }
        field(19; "User Position"; Text[250])
        {
            Caption = 'User Position';
        }
        field(27; "Use FA Type"; Option)
        {
            Caption = 'Use FA Type';
            OptionMembers = ,Department,Employee;
            OptionCaption = ' ,Department, Employee';
        }

        field(25; "Employee Name - Use FA"; text[250])
        {
            Caption = 'Employee Name - Use FA';

        }
        field(16; "User ID Sector"; Text[250])
        {
            Caption = 'User ID Sector';
        }
        field(24; "Employee No. - Use FA"; Code[20])
        {
            Caption = 'Employee No. - Use FA';
            TableRelation =
            IF ("Use FA Type" = FILTER('Department')) Department.Code
            ELSE
            IF ("Use FA Type" = FILTER(= 'Employee')) Employee."No.";


            trigger OnValidate()
            var
                Emp: Record Employee;
                ECL: Record "Employee Contract Ledger";

            begin
                if "Use FA Type" = "Use FA Type"::Employee then begin
                    Emp.Reset();
                    Emp.SetFilter("No.", '%1', Rec."Employee No. - Use FA");
                    if Emp.FindFirst() then begin
                        Validate("Employee Name - Use FA", Emp."First Name" + ' ' + Emp."Last Name");

                    end;
                end;

                if "Use FA Type" = "Use FA Type"::Department then begin

                    Department.reset;
                    Department.setfilter(Code, '%1', "Employee No. - Use FA");
                    if Department.findfirst then begin
                        "Employee Name - Use FA" := Department.description;

                    end;

                end;

                /*  Department.reset;
                  Department.setfilter(Code,'%1',"Employee No. - Use FA");
                  if Department.findfirst then begin 
                      "Employee Name - Use FA":=Department.description;

                  end;*/




            end;
        }
        field(17; "Responsible Sector"; Text[250])
        {
            Caption = 'Responsible Person Sector';
        }
        field(18; "Insert Date"; Date)
        {
            Caption = 'Insert Date';
        }
        field(15; "User ID"; Text[50])
        {
            Caption = 'User ID';
        }
        field(26; "Entry"; Integer)
        {
            Caption = 'Entry';
            AutoIncrement = true;

        }




    }

    keys
    {
        key(Key1; "No.", "Customer No.", Type, "Date From", "Date To", "Responsible Person Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Date From", "Date To")
        {
        }
    }

    var
        myInt: Integer;
        Text000: Label 'Start Date must have value.';
        Text001: Label 'End Date must not be before Start date.';
        Department: Record Department;

    trigger OnInsert()
    var
        ECL: Record "Employee Contract Ledger";
        UserS: Record "User Setup";
    begin
        "User ID" := UserId;
        "Insert Date" := today;
        Active := true;
        UserS.Reset();
        UserS.SetFilter("User ID", '%1', "User ID");
        if UserS.FindFirst() then begin
            ECL.Reset();
            ECL.SetFilter("Employee No.", '%1', UserS."Employee No. for Wage");
            ECL.SetFilter("Starting Date", '<=%1', Today);
            ECL.Ascending;
            if ecl.FindLast() then begin
                "User ID Sector" := ECL."Sector Description";
                "User Position" := ECL."Position Description";
            end
            else begin
                "User ID Sector" := '';
            end;



        end;

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}