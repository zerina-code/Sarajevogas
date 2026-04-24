table 50148 "Wage Setup"
{
    Caption = 'Wage Setup';
    Permissions = TableData 50148 = rimd;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(15; "Average Yearly Hour Pool"; Integer)
        {
            Caption = 'Average Yearly Hour Pool';
        }

        field(16; "Canton Amount"; Decimal)
        {
            Caption = 'Canton Amount';
        }

        field(2; "Average Salary FBIH"; Decimal)
        {
            Caption = 'Average Salary FBIH';

            trigger OnValidate()
            var
                myInt: Integer;
                ECLUpdate: Record "Employee Contract Ledger";
                eUpdate: Record Employee;
                Wagesetup: Record "Wage Setup";
                PosM: Record "Position Menu";
                WT: Record "Wage Type";
            begin
                WT.Reset();
                WT.SetFilter("Wage Calculation Type", '%1', WT."Wage Calculation Type"::Netto2);
                if WT.FindFirst() then begin

                    eUpdate.Reset();
                    eUpdate.SetFilter(StatusExt, '%1', eUpdate.StatusExt::Active);
                    eUpdate.SetFilter("Wage Type", '%1', WT.Code);
                    if eUpdate.FindSet() then
                        repeat

                            ECLUpdate.Reset();
                            ECLUpdate.SetFilter("Employee No.", '%1', eUpdate."No.");
                            ECLUpdate.SetFilter(Active, '%1', true);
                            ECLUpdate.SetFilter("Show Record", '%1', true);
                            if ECLUpdate.FindSet() then
                                repeat
                                    Wagesetup.Get();

                                    PosM.Reset();
                                    PosM.SetFilter("Org. Structure", '%1', ECLUpdate."Org. Structure");
                                    PosM.SetFilter(Description, '%1', ECLUpdate."Position Description");
                                    PosM.SetFilter(Code, '%1', ECLUpdate."Position Code");
                                    PosM.SetFilter("Department Code", '%1', ECLUpdate."Department Code");
                                    PosM.SetFilter("Position Coefficient for Wage", '<>%1', 0);
                                    if PosM.FindFirst() then begin

                                        if ECLUpdate."Prentice Precentage" <> 0 then
                                            ECLUpdate.Validate(Brutto, ROUND((Wagesetup."Average Salary FBIH" * Wagesetup."Average coefficient statute" * PosM."Position Coefficient for Wage" * 3) * ECLUpdate."Prentice Precentage", 0.01, '>'))
                                        else
                                            ECLUpdate.Validate(Brutto, ROUND(Wagesetup."Average Salary FBIH" * Wagesetup."Average coefficient statute" * PosM."Position Coefficient for Wage" * 3, 0.01, '>'));

                                    end
                                    else begin

                                        if ECLUpdate."Prentice Precentage" <> 0 then
                                            ECLUpdate.Validate(Brutto, ROUND((Wagesetup."Average Salary FBIH" * Wagesetup."Average coefficient statute" * 3) * ECLUpdate."Prentice Precentage", 0.01, '>'))
                                        else
                                            ECLUpdate.Validate(Brutto, ROUND(Wagesetup."Average Salary FBIH" * Wagesetup."Average coefficient statute" * 3, 0.01, '>'));
                                        ECLUpdate.Modify();

                                    end;

                                until ECLUpdate.Next() = 0;
                        until eUpdate.Next() = 0;

                    MESSAGE('Osnovice ažurirane!');
                end;

            end;


        }
        field(3; "Average coefficient statute"; Decimal)
        {
            Caption = 'Average coefficient statute';
            DecimalPlaces = 1 : 3;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Average Salary FBIH", Rec."Average Salary FBIH");
            end;
        }
        field(20; "Work Experience Basis"; Decimal)
        {
            Caption = 'Work Experience Basis';
        }
        field(25; "Day Unit of Measure"; Code[10])
        {
            Caption = 'Day Unit of Measure';
            TableRelation = "Unit of Measure".Code;
        }
        field(30; "Hour Unit of Measure"; Code[10])
        {
            Caption = 'Hour Unit of Measure';
            TableRelation = "Unit of Measure".Code;
        }
        field(35; "Holiday Code"; Code[10])
        {
            Caption = 'Holiday Coode';
            TableRelation = "Cause of Absence".Code;
        }
        field(36; "Holiday Description"; Text[30])
        {
            Caption = 'Holiday Description';
        }
        field(40; "Workday Code"; Code[10])
        {
            Caption = 'Workday Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(41; "Workday Description"; Text[30])
        {
            Caption = 'Workday Description';
        }
        field(45; "Hours in Day"; Decimal)
        {
            Caption = 'Hours in Day';

            trigger OnValidate()
            begin
                IF ("Hours in Day" < 0) OR ("Hours in Day" > 24) THEN
                    ERROR(Txt001, "Hours in Day");
            end;
        }
        field(55; "Wage Amount Code"; Code[10])
        {
            Caption = 'Wage Amount Code';
            TableRelation = Nationallity.Code;
        }
        field(60; "Brutto Calculation Code"; Code[10])
        {
            Caption = 'Brutto Calculation Code';
            TableRelation = "Wage Type".Code;
        }
        field(65; "Netto Calculation Code"; Code[10])
        {
            Caption = 'Netto Calculation Code';
            TableRelation = "Wage Type".Code;
        }
        field(70; "Brutto Hour Calculation Code"; Code[10])
        {
            Caption = 'Brutto Hour Calculation Code';
            TableRelation = "Wage Type".Code;
        }
        field(71; "Netto Hour Calculation Code"; Code[10])
        {
            Caption = 'Netto Hour Calculation Code';
            TableRelation = "Wage Type";
        }
        field(75; "Transport No. Series"; Code[10])
        {
            Caption = 'Transport No. Series';
            TableRelation = "No. Series";
        }
        field(76; "Reduction No. Series"; Code[10])
        {
            Caption = 'Reduction No. Series';
            TableRelation = "No. Series";
        }
        field(80; "Wage Calendar Code"; Code[10])
        {
            Caption = 'Wage Calendar Code';
            TableRelation = "Base Calendar".Code;
        }
        field(105; "RS Contact Name"; Text[50])
        {
            Caption = 'RS Contact Name';
        }
        field(110; "RS Contact Phone"; Text[20])
        {
            Caption = 'RS Contact Phone';
        }
        field(115; "RS Contact E-mail"; Text[30])
        {
            Caption = 'RS Contact E-mail';
        }
        field(120; "Min. wage on state level"; Decimal)
        {
            Caption = 'Min. wage on state level';
        }
        field(125; "Min. wage by coll. contract"; Decimal)
        {
            Caption = 'Min. wage by coll. contract';
        }
        field(130; "Severance Account"; Code[20])
        {
            Caption = 'Severance Account';
            TableRelation = "G/L Account"."No.";
        }
        field(135; "Help Account"; Code[20])
        {
            Caption = 'Help Account';
            TableRelation = "G/L Account"."No.";
        }
        field(140; "Daily Wage Account"; Code[20])
        {
            Caption = 'Daily Wage Account';
            TableRelation = "G/L Account"."No.";
        }
        field(145; "Terrain Supplement Account"; Code[20])
        {
            Caption = 'Terrin Supplement Account';
            TableRelation = "G/L Account"."No.";
        }
        field(150; "Separate Living Account"; Code[20])
        {
            Caption = 'Separate Living Account';
            TableRelation = "G/L Account"."No.";
        }
        field(155; "Car Use Account"; Code[20])
        {
            Caption = 'Car Use Account';
            TableRelation = "G/L Account"."No.";
        }
        field(160; "Stipend Account"; Code[20])
        {
            Caption = 'Stipend Account';
            TableRelation = "G/L Account"."No.";
        }
        field(165; "Jubilee Awards Account"; Code[20])
        {
            Caption = 'Jubilee Awards Account';
            TableRelation = "G/L Account"."No.";
        }
        field(170; "Regress Account"; Code[20])
        {
            Caption = 'Regress Account';
            TableRelation = "G/L Account"."No.";
        }
        field(175; "Gifts Account"; Code[20])
        {
            Caption = 'Gifts Account';
            TableRelation = "G/L Account"."No.";
        }
        field(180; "Commission Code"; Code[10])
        {
            Caption = 'Comission Code';
            TableRelation = Nationallity.Code;
        }
        field(185; "Life Insurance Code"; Code[10])
        {
            Caption = 'Life Insurance Code';
            TableRelation = Nationallity.Code;
        }
        field(186; "Health Insurance Code"; Code[10])
        {
            Caption = 'Add. Health Insurance Code';
            TableRelation = Nationallity.Code;
        }
        field(187; "Add. Pension Code"; Code[10])
        {
            Caption = 'Add. Pension Code';
            TableRelation = Nationallity.Code;
        }
        field(190; "Base Personal Deduction"; Decimal)
        {
            Caption = 'Base Personal Deduction';
            TableRelation = "Tax deduction list".Amount where(Active = filter(true), "Entity Code" = filter('FBIH'), Type = filter("Tax List"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Base Tax Deduction" := "Base Personal Deduction";

            end;
        }
        field(200; "Tax Payment Model"; Code[2])
        {
            Caption = 'Tax Payment Model';
        }
        field(205; "Tax Refer to Number"; Text[22])
        {
            Caption = 'Tax Refer to Number';
        }
        field(210; "RS File Path"; Text[250])
        {
            Caption = 'RS File Path';
        }
        field(301; Meal; Decimal)
        {
            Caption = 'Meal';
            DecimalPlaces = 0 : 3;
        }
        field(302; "Coefficient Netto to Brutto"; Decimal)
        {
            Caption = 'Coefficient Netto to Brutto';
        }
        field(303; "General Coefficient"; Decimal)
        {
            Caption = 'General Coefficient';
        }
        field(304; "Other Wage Amount Code"; Code[10])
        {
            Caption = 'Other Wage Amount Codee';
            TableRelation = Nationallity.Code;
        }
        field(305; "Canton Sick-Leave Amount"; Decimal)
        {
            Caption = 'Canton HourWage for Sick-Leave > 42';
            DecimalPlaces = 4 : 4;
        }
        field(306; "Sick Wage Amount Code"; Code[10])
        {
            Caption = 'Sick Wage Amount Code';
            TableRelation = Nationallity.Code;
        }
        field(307; "Maximum hours for sick wage"; Decimal)
        {
            Caption = 'Maximum Hours for Sick Wage';
        }
        field(308; EAFromDate; Date)
        {
            Caption = 'Employee Absence starting day';
        }
        field(309; EAToDate; Date)
        {
            Caption = 'Employee Absence end date';
        }
        field(310; EAFlag; Boolean)
        {
            Caption = 'Employee Absence Flag';
        }
        field(311; "RS Minimal Tax Level"; Decimal)
        {
            Caption = 'RS Minimal Tax Level';
        }
        field(312; "RS High Tax Level"; Decimal)
        {
            Caption = 'RS High Tax Level';
        }
        field(313; "Meal No. Series"; Code[10])
        {
            Caption = 'Meal No. Series';
            TableRelation = "No. Series";
        }
        field(314; "Export Report Path"; Text[100])
        {
            Caption = 'Export Report Path';
        }
        field(315; "Industry Coefficient"; Decimal)
        {
            Caption = 'Industry Coefficient';
        }
        field(320; Overtime; Boolean)
        {
            Caption = 'Overtime';
        }
        field(325; "Overtime Code"; Code[10])
        {
            Caption = 'Overtime Code';
            TableRelation = "Cause of Absence".Code;
        }
        field(330; "Base Tax Deduction"; Decimal)
        {
            Caption = 'Base Tax Deduction';
            TableRelation = "Tax deduction list".Amount where(Active = filter(true), "Entity Code" = filter('FBIH'), Type = filter("Tax List"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Base Personal Deduction" := "Base Tax Deduction";

            end;


        }
        field(335; "Coefficient Increase"; Decimal)
        {
            Caption = 'Coefficient Increase';
        }
        field(340; "Coefficient Rounding"; Decimal)
        {
            Caption = 'Coefficient Rounding';
        }
        field(345; "Meal - Half Day"; Decimal)
        {
            Caption = 'Meal - Half Day';
        }
        field(50013; "Add. Columns"; Boolean)
        {
            Caption = 'Add. Columns';
        }
        field(50014; "Work Percentage"; Decimal)
        {
            Caption = 'Work Percentage FBiH';
        }
        field(50015; "Type Of Work Percentage Calc."; Option)
        {
            Caption = 'Type Of Work Percentage Calc. FBIH';
            OptionCaption = 'Current,Total';
            OptionMembers = Current,Total;
        }
        field(50016; "Chamber Rate(%)"; Decimal)
        {
            Caption = 'ChamberRate(%)';
        }
        field(50017; "Brutto Rate"; Decimal)
        {
            Caption = 'Brutto Rate';
        }
        field(50018; "Unemployment Federation"; Decimal)
        {
            Caption = 'Unemployment Federation';
        }
        field(50019; "Unemployment Canton"; Decimal)
        {
            Caption = 'Unemployment Canton';
        }
        field(50020; "Health Federation"; Decimal)
        {
            Caption = 'Health Federation';
        }
        field(50021; "Health Canton"; Decimal)
        {
            Caption = 'Health Canton';
        }
        field(50022; "Invalid Fund Contribution Code"; Code[10])
        {
            Caption = 'Invalid Fund Contribution Code';
            TableRelation = Contribution;
        }
        field(50023; "No. Of Employees"; Integer)
        {
            Caption = 'No. Of Employees';
        }
        field(50024; "Invaalid Fund %"; Decimal)
        {
            Caption = 'Invaalid Fund %';
        }
        field(50025; "Chamber Fee Contribution Code"; Code[10])
        {
            Caption = 'Chamber Fee Contribution Code';
            TableRelation = Contribution;
        }
        field(50026; "Temporary Work Cont. Code"; Code[10])
        {
            Caption = 'Chamber Fee Contribution Code';
            TableRelation = Contribution;
        }
        field(50027; "Temporary Work Cont. Code 0%"; Code[10])
        {
            Caption = 'Chamber Fee Contribution Code';
            TableRelation = Contribution;
        }
        field(50028; "Temporary Work Cont. Code NR"; Code[10])
        {
            Caption = 'Chamber Fee Contribution Code';
            TableRelation = Contribution;
        }
        field(50029; "Temporary Work Cont. Code AC"; Code[10])
        {
        }
        field(50030; "Aproved Expenditures"; Decimal)
        {
            Caption = 'Aproved Expenditures';
        }
        field(50031; "RS Municipality Code"; Code[10])
        {
            Caption = 'RS Municipality Code';
            TableRelation = Municipality;
        }
        field(50032; "Use Code"; Code[10])
        {
            Caption = 'Use Code';
        }
        field(50033; "Payment Code"; Code[10])
        {
            Caption = 'Payment Code';
        }
        field(50034; "Global Dimension 1 Code Fund"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50035; "Global Dimension 1 Code Chambe"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
        }
        field(50036; "Travel Order Nos."; Code[10])
        {
            Caption = 'Travel Order Nos.';
            TableRelation = "No. Series";
        }
        field(50037; "Work Percentage RS"; Decimal)
        {
            Caption = 'Work Percentage RS';
        }
        field(50038; "Type Of Work Percentage Cal RS"; Option)
        {
            Caption = 'Type Of Work Percentage Calc. RS';
            OptionCaption = 'Current,Total';
            OptionMembers = Current,Total;
        }
        field(50039; "Work Percentage BD"; Decimal)
        {
            Caption = 'Work Percentage BD';
        }
        field(50040; "Type Of Work Percentage Cal BD"; Option)
        {
            Caption = 'Type Of Work Percentage Calc. BD';
            OptionCaption = 'Current,Total';
            OptionMembers = Current,Total;
        }
        field(50041; "Meal For 6 Hours FBiH"; Decimal)
        {
            Caption = 'Meal For 6 Hours FBiH';
        }
        field(50042; "Meal For 2 Hours FBiH"; Decimal)
        {
            Caption = 'Meal For 2 Hours FBiH';
        }
        field(50043; "Meal Total FBiH"; Decimal)
        {
            Caption = 'Meal Total FBiH';
        }
        field(50044; "Meal Taxable BD"; Decimal)
        {
            Caption = 'Meal Taxable BD';
        }
        field(50045; "Meal Nontaxable BD"; Decimal)
        {
            Caption = 'Meal Nontaxable BD';
        }
        field(50046; "Meal For 6 Hours BD"; Decimal)
        {
            Caption = 'Meal For 6 Hours BD';
        }
        field(50047; "Meal For 2 Hours BD"; Decimal)
        {
            Caption = 'Meal For 2 Hours BD';
        }
        field(50048; "Meal Total BD"; Decimal)
        {
            Caption = 'Meal Total BD';
        }
        field(50049; "Meal Taxable RS"; Decimal)
        {
            Caption = 'Meal Taxable RS';
        }
        field(50050; "Meal Nontaxable RS"; Decimal)
        {
            Caption = 'Meal Nontaxable RS';
        }
        field(50051; "Meal For 6 Hours RS"; Decimal)
        {
            Caption = 'Meal For 6 Hours RS';
        }
        field(50052; "Meal For 2 Hours RS"; Decimal)
        {
            Caption = 'Meal For 2 Hours RS';
        }
        field(50053; "Meal Total RS"; Decimal)
        {
            Caption = 'Meal Total RS';
        }
        field(50054; "Meal Taxable FBiH Untaxable"; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Caption = 'Meal Taxable FBiH';
        }
        field(50055; "Meal Code FBIH"; Code[10])
        {
            Caption = 'Meal Code FBIH';
            TableRelation = "Wage Addition Type";
        }
        field(50056; "Meal Code RS"; Code[10])
        {
            Caption = 'Meal Code FBIH';
            TableRelation = "Wage Addition Type";
        }
        field(50057; "Meal Code FBiH Taxable"; Code[10])
        {
            Caption = 'Meal Taxable FBiH';
            TableRelation = "Wage Addition Type";
        }
        field(50058; "Work Experience Code"; Code[10])
        {
            Caption = 'Work Experience Code';
        }
        field(50059; "Transport Code"; Code[10])
        {
            Caption = 'Transport Code';
        }
        field(50060; "Water Fee RS"; Code[10])
        {
            Caption = 'Water Fee RS';
        }
        field(50061; "Additional Wage Code"; Code[10])
        {
            Caption = 'Additional Wage Code';
            TableRelation = "Wage Addition Type";
        }
        field(50062; "HAlf Additional Wage Code"; Code[10])
        {
            Caption = 'Additional Wage Code';
            TableRelation = "Wage Addition Type";
        }
        field(50063; "Meal Code BD Untaxable"; Code[10])
        {
            Caption = 'Meal Code BD Untaxable';
            TableRelation = "Wage Addition Type";
        }
        field(50064; "Meal Code BD"; Code[10])
        {
            Caption = 'Meal Code BD';
            TableRelation = "Wage Addition Type";
        }
        field(50065; "Base Tax Deduction BD"; Decimal)
        {
            Caption = 'Base Personal Deduction';
            TableRelation = "Tax deduction list".Amount where(Active = filter(true), "Entity Code" = filter('BD'), Type = filter("Tax List"));
        }
        field(50066; "Base Tax Deduction RS"; Decimal)
        {
            Caption = 'Base Personal Deduction';
            TableRelation = "Tax deduction list".Amount where(Active = filter(true), "Entity Code" = filter('RS'), Type = filter("Tax List"));
        }
        field(500067; "Path for CBS"; Text[30])
        {
            Caption = 'Path for CBS';
        }
        field(50068; "Packet Number"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50069; "Municipality Payment Order"; Boolean)
        {
            Caption = 'Virmani doprinosa se prikazuju na osnovu opštine';
        }
        field(50070; "Send Name e-mail"; Text[1000])
        {
            Caption = 'Ime pošiljaoca za platne liste';
        }
        field(50071; "Send e-mail"; Text[1000])
        {
            Caption = 'E-mail adresa pošiljaoca za platne liste';
        }
        field(50072; "Wage Base"; Decimal)
        {
            Caption = 'Wage Base';
            DecimalPlaces = 1 : 4;

            trigger OnValidate()
            var
                ECLUpdate: Record "Employee Contract Ledger";
                Wagesetup: Record "Wage Setup";
                PosM: Record "Position Menu";

            begin
                wa.Reset();
                WA.SETFILTER("Employee No.", '<>%1', '');
                IF WA.FINDFIRST THEN
                    REPEAT
                        IF "Wage Base" <> 0 THEN
                            WA."Wage Amount" := WA.Coefficient * "Wage Base";
                        WA.MODIFY;
                    UNTIL WA.NEXT = 0;


                ECLUpdate.Reset();
                ECLUpdate.SetFilter(Active, '%1', true);
                ECLUpdate.SetFilter("Grounds for Term. Description", '%1', '');
                if ECLUpdate.FindSet() then
                    repeat
                        Wagesetup.Get();
                        PosM.Reset();
                        PosM.SetFilter("Org. Structure", '%1', ECLUpdate."Org. Structure");
                        PosM.SetFilter(Description, '%1', ECLUpdate."Position Description");
                        PosM.SetFilter(Code, '%1', ECLUpdate."Position Code");
                        PosM.SetFilter("Department Code", '%1', ECLUpdate."Department Code");
                        if PosM.FindFirst() then begin
                            PosM.UpdateCoeff(PosM."Position complexity", PosM."Position Responsibility", PosM."Workplace conditions", PosM.Increment);
                            PosM.Modify();
                            ECLUpdate.Validate(Brutto, ROUND(Wagesetup."Wage Base" * PosM."Position Coefficient for Wage", 0.01, '>'));
                            ECLUpdate.Modify();
                        end;

                    until ECLUpdate.Next() = 0;

                MESSAGE('Osnovice ažurirane!');
            end;

        }
        field(50073; "Wage Journal Template"; Code[10])
        {
            Caption = 'Wage Journal Template';
            TableRelation = "Gen. Journal Template"."Name" where("Type" = filter("General"));

        }
        field(50074; "Wage Batch Name"; Code[10])
        {
            Caption = 'Wage Batch Name';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Wage Journal Template"));

        }
        field(50075; "Meal Taxable FBiH "; Decimal)
        {
            DecimalPlaces = 0 : 3;
            Caption = 'Meal Taxable FBiH';
            trigger Onvalidate()
            var
                myInt: Integer;
            begin
                NettoFromBrutto("Meal Taxable FBiH ");

            end;
        }
        field(50076; "Max Work Experience"; Decimal)
        {
            Caption = 'Max Work Experience';
        }
        field(50077; "Year of Experience - min"; Integer)
        {
            Caption = 'Year of Experience - min';
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
    procedure NettoFromBrutto(Amount: Decimal): Decimal
    var
        ATPercent: Decimal;
        AddTaxesPercentage: Decimal;


    begin

        //NettoFromBrutto
        GetAddTaxesPercentage(AddTaxesPercentage);
        "Meal Taxable FBiH Untaxable" := "Meal Taxable FBiH " * (1 - AddTaxesPercentage / 100);


    end;

    procedure GetAddTaxesPercentage(var Percentage: Decimal)
    var
        AddTaxes: Record Contribution;
        ATCCon: Record "Contribution Category Conn.";
    begin

        Percentage := 0;

        AddTaxes.RESET;
        AddTaxes.SETFILTER(Active, '%1', TRUE);
        AddTaxes.SETFILTER("From Brutto", '%1', TRUE);
        IF AddTaxes.FINDFIRST THEN
            REPEAT
                IF ATCCon.GET('FBIH', AddTaxes.Code) THEN
                    IF ATCCon."Calculated in Total Brutto" THEN
                        Percentage += ATCCon.Percentage;
            UNTIL AddTaxes.NEXT = 0;
    end;


    var
        emp: Record "Employee";
        Txt001: Label '<<Ne moze biti #1# sati u danu!>>';
        WA: Record "Wage Amounts";
}

