table 50032 "Wage Addition"
{
    Caption = 'Wage addition';
    DrillDownPageID = "Wage Addition";
    LookupPageID = "Wage Addition";
    ;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF emp.GET("Employee No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                    "Contribution Category Code" := emp."Contribution Category Code";
                    "Org Entity Code" := emp."Org Entity Code";
                END;

                EmployeeContractLedger.RESET;
                EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                IF EmployeeContractLedger.FINDLAST THEN BEGIN
                    //EmployeeContractLedger.CALCFIELDS("Position Description");
                    //EmployeeContractLedger.CALCFIELDS("Residence/Network","Department Name",Sector,"Department Category",Group);
                    EmployeeContractLedger.CALCFIELDS("Residence/Network");
                    //EmployeeContractLedger.CALCFIELDS("Sector Description","Department Cat. Description","Group Description");

                    /*  SegmentationGroup.RESET;
                      SegmentationGroup.SETFILTER("Position No.", '%1', EmployeeContractLedger."Position Code");
                      SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                      SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                      SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                      IF SegmentationGroup.FIND('+') THEN
                          "Management Level" := FORMAT(SegmentationGroup."Management Level");*/
                    "Management Level" := format(EmployeeContractLedger."Management Level");



                    "Position Code" := EmployeeContractLedger."Position Code";
                    "Position ID" := EmployeeContractLedger."Position ID";
                    "Position Description" := EmployeeContractLedger."Position Description";
                    "Department Code" := EmployeeContractLedger."Department Code";
                    "Department Name" := EmployeeContractLedger."Department Name";
                    "B-1" := EmployeeContractLedger.Sector;
                    "B-1 Description" := EmployeeContractLedger."Sector Description";
                    "B-1 (with regions)" := EmployeeContractLedger."Department Category";
                    "B-1 (with regions) Description" := EmployeeContractLedger."Department Cat. Description";
                    Stream := EmployeeContractLedger.Group;
                    "Stream Description" := EmployeeContractLedger."Group Description";
                    IF (EmployeeContractLedger."Grounds for Term. Code" <> '') AND (EmployeeContractLedger."Ending Date" <> 0D) THEN
                        "Ending Date" := EmployeeContractLedger."Ending Date"
                    ELSE
                        "Ending Date" := 0D;
                END;
                wb.RESET;
                wb.SETFILTER("Employee No.", "Employee No.");
                wb.SETFILTER("Current Company", '%1', TRUE);
                IF wb.FINDLAST THEN BEGIN
                    "Starting Date" := wb."Starting Date"
                END;

                edf.RESET;
                edf.SETFILTER("No.", "Employee No.");
                IF edf.FINDLAST THEN BEGIN
                    "Global Dimension 1 Code" := edf."Dimension Value Code"
                END;
                /*
                IF "Employee No."<>'' THEN BEGIN
                 IF ((((TODAY-"Starting Date") DIV 30)<6) AND (("Wage Addition Type"='INC') OR ("Wage Addition Type"='INC FIZ')
                   OR ("Wage Addition Type"='INC SFE') OR ("Wage Addition Type"='INC SME') OR ("Wage Addition Type"='INC MICRO')
                   OR("Wage Addition Type"='INC PRAV')))
                THEN ERROR('Zaposlenik nije ostvario pravo na incentive!!');
                END;
                */

            end;
        }
        field(2; "Month of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(3; "Year of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(4; "Wage Addition Type"; Code[10])
        {
            Caption = 'Wage Addition Type';
            TableRelation = "Wage Addition Type";

            trigger OnValidate()
            var
                WAT: Record "Wage Addition Type";
                EA: Record "Employee Absence";
                COA: Record "Cause of Absence";
                StartDate: date;
                UnPaid: text;
                EndDate: date;
                AbsenceFill: Codeunit "Absence Fill";
                UnpaidHours: Decimal;
                HP: Decimal;
            begin
                if "Wage Addition Type" <> '' then begin
                    WAT.GET("Wage Addition Type");
                    Description := WAT.Description;
                    //Amount := WAT."Default Amount";
                    IF WAT."Default Amount" <> 0 THEN
                        VALIDATE(Amount, WAT."Default Amount");
                    VALIDATE(Taxable, WAT.Taxable);
                    VALIDATE(Use, WAT.Use);
                    VALIDATE(Regres, WAT.Regres);
                    VALIDATE(Incentive, WAT.Incentive);
                    VALIDATE(Meal, WAT.Meal);
                    VALIDATE("Calculate Deduction", WAT."Calculate Deduction");
                    VALIDATE("Use Apportionment Account", WAT."Use Apportionment Account");
                    VALIDATE("Calculated on Brutto", WAT."Calculated on Brutto");

                    IF ((WAT."Calculated on Brutto") AND (WAT."Calculation Type" = 0)) THEN BEGIN
                        WAmounts.SETFILTER("Employee No.", "Employee No.");
                        IF WAmounts.FINDLAST THEN BEGIN
                            ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                            IF ConCat.FINDSET THEN BEGIN
                                ConCat.CALCFIELDS("From Brutto");
                                if strpos("Wage Addition Type", 'R. UCINAK') <> 0 then begin
                                    UnPaid := '';
                                    UnpaidHours := 0;
                                    COA.Reset();
                                    COA.SetFilter("Unpaid days", '%1', true);
                                    if COA.FindSet() then
                                        repeat
                                            UnPaid += COA.Code + '|';

                                        until COA.Next() = 0;
                                    if StrLen(UnPaid) > 2 then
                                        UnPaid := CopyStr(UnPaid, 1, StrLen(UnPaid) - 1);

                                    if UnPaid <> '' then begin

                                        StartDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", TRUE);
                                        EndDate := AbsenceFill.GetMonthRange("Month Of Wage", "Year Of Wage", FALSE);
                                        ea.Reset();
                                        ea.SetFilter("Employee No.", '%1', rec."Employee No.");
                                        ea.SetFilter("From Date", '%1..%2', StartDate, EndDate);
                                        ea.SetFilter("Cause of Absence Code", UnPaid);
                                        if ea.FindFirst() then begin
                                            ea.CalcSums(Quantity);
                                            UnpaidHours := ea.Quantity;
                                        end;
                                    end;

                                    if UnpaidHours <> 0 then begin
                                        WageSetup.get;
                                        HP := AbsenceFill.GetHourPool(Rec."Month Of Wage", Rec."Year Of Wage", WageSetup."Hours in Day");
                                        if HP <> 0 then
                                            WAmounts."Wage Amount" := WAmounts."Wage Amount" - (WAmounts."Wage Amount" * UnpaidHours) / HP

                                    end;

                                end;
                                VALIDATE(Amount, (WAmounts."Wage Amount" * (WAT."Default Amount" / 100)) * (1 - ConCat."From Brutto" / 100));
                            END;
                        END;
                    END;
                end
                else begin
                    Description := '';
                    "Amount to Pay" := 0;
                    Amount := 0;
                    "Calculated on Brutto" := false;
                    Taxable := false;
                    Use := false;
                    Regres := false;
                    Incentive := false;
                    Meal := false;
                    "Calculate Deduction" := false;
                    "Use Apportionment Account" := false;




                end;
            end;
        }
        field(5; Amount; Decimal)
        {
            Caption = 'Amount';

            trigger OnValidate()
            var
                WT: Record "Wage Addition Type";
                EmpW: Record Employee;
                WagSetup: Record "Wage Setup";
            begin
                Class.RESET;
                Class.SETCURRENTKEY("Valid From Amount");
                Class.SETRANGE(Active, TRUE);
                CompInfo.GET;
                Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                Class.FINDFIRST;
                //dodati ovdje
                WT.Get(Rec."Wage Addition Type");
                EmpW.Get("Employee No.");
                if WT."Work experience base" = true then begin
                    WagSetup.Get();
                    if WT."Default Amount" <> 0 then begin

                        if (EmpW."Years of Experience" >= WagSetup."Year of Experience - min") and (WagSetup."Year of Experience - min" <> 0) then
                            Amount := Amount * (((WagSetup."Max Work Experience") - (EmpW."Years of Experience" * WagSetup."Work Percentage")) / WT."Default Amount")
                        else
                            Amount := Amount * EmpW."Years of Experience";
                    end
                    else begin
                        Amount := Amount * EmpW."Years of Experience";

                    end;

                end;

                IF Taxable THEN
                    VALIDATE("Amount to Pay", Amount * (1 - (Class.Percentage / 100)))
                ELSE
                    VALIDATE("Amount to Pay", Amount);
            end;
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(100; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(101; Locked; Boolean)
        {
            Caption = 'Locked';
        }
        field(102; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(103; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(104; "Calculated Amount"; Decimal)
        {
            Caption = 'Calculated Amount';
        }
        field(105; Taxable; Boolean)
        {
            Caption = 'Taxable';

            trigger OnValidate()
            begin
                Class.RESET;
                Class.SETCURRENTKEY("Valid From Amount");
                Class.SETRANGE(Active, TRUE);
                CompInfo.GET;
                Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                Class.FINDFIRST;
                IF Taxable = TRUE THEN BEGIN
                    /*   IF Rec."Contribution Category Code"<>'FBIHRS' THEN
                    ConCat.SETFILTER(Code,'%1','FBIH')
                  ELSE*/
                    ConCat.SETFILTER(Code, '%1', Rec."Contribution Category Code");
                    IF ConCat.FINDSET THEN BEGIN
                        //đK  ConCat.calcfields("From Brutto");


                        Rec."Calculated Amount Brutto" := (Rec."Amount to Pay") / ((1 - ConCat."From Brutto" / 100) * (1 - (Class.Percentage / 100)));
                        Rec.Tax := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto") - Rec."Amount to Pay";
                        Rec."Tax Basis" := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto");
                        //Rec.Amount:=Rec."Amount to Pay"+Rec.Tax;
                        Rec.Brutto := Rec."Calculated Amount Brutto";
                    END
                    //END
                    ELSE BEGIN
                        Rec.Amount := Rec."Amount to Pay";
                    END
                END
                ELSE BEGIN
                    Rec."Calculated Amount Brutto" := 0;
                    Rec.Tax := 0;
                    Rec."Tax Basis" := 0;
                    Rec.Amount := Rec."Amount to Pay";
                    Rec.Brutto := Rec.Amount;
                END;


            end;
        }
        field(106; "Calculated Amount Brutto"; Decimal)
        {
        }
        field(107; "Amount to Pay"; Decimal)
        {
            Caption = 'Calculated Amount';

            trigger OnValidate()
            begin
                Class.RESET;
                Class.SETCURRENTKEY("Valid From Amount");
                Class.SETRANGE(Active, TRUE);
                CompInfo.GET;
                Class.SETRANGE("Entity Code", CompInfo."Entity Code");
                Class.FINDFIRST;

                IF Taxable = TRUE THEN BEGIN
                    ConCat.SETFILTER(Code, '%1', "Contribution Category Code");
                    IF ConCat.FINDSET THEN BEGIN
                        ConCat.CALCFIELDS("From Brutto");
                        Rec."Calculated Amount Brutto" := (Rec."Amount to Pay") / ((1 - ConCat."From Brutto" / 100) * (1 - (Class.Percentage / 100)));
                        Rec.Tax := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto") - Rec."Amount to Pay";
                        Rec."Tax Basis" := ((1 - ConCat."From Brutto" / 100) * Rec."Calculated Amount Brutto");
                        Rec.Amount := Rec."Amount to Pay" + Rec.Tax;
                        Rec.Brutto := Rec."Calculated Amount Brutto";
                        AddTaxes.RESET;
                        ATCCon.SETFILTER("Category Code", '%1', Rec."Contribution Category Code");
                        IF ATCCon.FINDFIRST THEN
                            REPEAT
                                /*   IF ((Rec."Contribution Category Code"='FBIHRS') OR (Rec."Contribution Category Code"='BDPIORS')) THEN BEGIN
                                    IF ATCConRS.GET('RS', Rec."Contribution Category Code") THEN
                                      ATPercentRS:= ATCConRS.Percentage/100;
                                 END;*/
                                ATPercent := ATCCon.Percentage / 100;
                                IF ATCCon."Contribution Code" = 'D-PIO-IZ' THEN
                                    "PIO From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-PIO-NA' THEN
                                    "PIO On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-NEZAP-IZ' THEN
                                    "Unemployment From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-NEZAP-NA' THEN
                                    "Unemployment On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-ZDRAV-IZ' THEN
                                    "Health From" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'D-ZDRAV-NA' THEN
                                    "Health On" := ROUND(Rec.Brutto * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'P-VOD' THEN
                                    "Water Fee" := ROUND(Rec."Amount to Pay" * ATCCon.Percentage / 100, 0.01, '=');

                                IF ATCCon."Contribution Code" = 'P-ELNEP' THEN
                                    "Disaster Fee" := ROUND(Rec."Amount to Pay" * ATCCon.Percentage / 100, 0.01, '=');

                                "Total From" := "PIO From" + "Health From" + "Unemployment From";
                                "Total On" := "PIO On" + "Health On" + "Unemployment On";
                                "Total Cost" := "Total From" + "Total On" + "Disaster Fee" + "Water Fee" + "Amount to Pay" + Tax;
                            //ATAmount := ROUND(Rec.Brutto * ATPercent,0.01,'>');
                            // ATAmountRS := ROUND(Rec.Brutto * ATPercentRS,0.01,'=');
                            UNTIL ATCCon.NEXT = 0;
                    END
                    //END
                    ELSE BEGIN
                        Rec.Amount := Rec."Amount to Pay";
                    END
                END
                ELSE BEGIN
                    Rec."Calculated Amount Brutto" := 0;
                    Rec.Tax := 0;
                    Rec."Tax Basis" := 0;
                    Rec.Amount := Rec."Amount to Pay";
                    Rec.Brutto := Rec.Amount;
                END;

            end;
        }
        field(108; Tax; Decimal)
        {
        }
        field(109; "Contribution Category Code"; Code[10])
        {
        }
        field(111; Use; Boolean)
        {
            Caption = 'Use';
        }
        field(112; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(113; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(114; Regres; Boolean)
        {
        }
        field(115; "Use Apportionment Account"; Boolean)
        {
            Caption = 'Use Apportionment Account';
        }
        field(116; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
        }
        field(117; Incentive; Boolean)
        {
        }
        field(118; Brutto; Decimal)
        {
        }
        field(119; "PIO From"; Decimal)
        {
            Caption = 'PIO From';
        }
        field(120; "Health From"; Decimal)
        {
            Caption = 'Health From';
        }
        field(121; "Unemployment From"; Decimal)
        {
            Caption = 'Unemployment From';
        }
        field(122; "Total From"; Decimal)
        {
            Caption = 'Total From';
        }
        field(123; "PIO On"; Decimal)
        {
            Caption = 'PIO On';
        }
        field(124; "Health On"; Decimal)
        {
            Caption = 'Health On';
        }
        field(125; "Unemployment On"; Decimal)
        {
            Caption = 'Unemployment On';
        }
        field(126; "Total On"; Decimal)
        {
            Caption = 'Total On';
        }
        field(127; "Water Fee"; Decimal)
        {
            Caption = 'Water Fee';
        }
        field(128; "Disaster Fee"; Decimal)
        {
            Caption = 'Disaster Fee';
        }
        field(129; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
        }
        field(130; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(131; "Payment Year"; Integer)
        {
            Caption = 'Payment Year';
        }
        field(132; "Payment Moth"; Integer)
        {
            Caption = 'Payment Month';
        }
        field(133; Gender; enum "Employee Gender")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Gender WHERE("No." = FIELD("Employee No.")));
            Caption = 'Gender';


        }
        field(134; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
        }
        field(135; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
        }
        field(136; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Unpaid,Terminated,On boarding,Practicians,Trainee';
            OptionMembers = Active,Inactive,Unpaid,Terminated,"On boarding",Practicians,Trainee;
        }
        field(217; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(50010; "Internal ID"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee."Internal ID" WHERE("No." = FIELD("Employee No.")));
            Caption = 'Internal ID';

        }
        field(50295; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(50299; "B-1"; Code[20])
        {
            Caption = 'B-1';
            Editable = false;
        }
        field(50300; "B-1 Description"; Text[250])
        {
            Caption = 'B-1 Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50301; "B-1 (with regions)"; Code[20])
        {
            Caption = 'B-1 (with regions)';
            Editable = false;
        }
        field(50302; "B-1 (with regions) Description"; Text[250])
        {
            Caption = 'B-1 (with regions) Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50303; Stream; Code[20])
        {
            Caption = 'Stream';
            Editable = false;
        }
        field(50304; "Stream Description"; Text[250])
        {
            Caption = 'Stream Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50316; "Department Code"; Code[20])
        {
            Caption = 'Department Code';
        }
        field(50317; "Position Code"; Code[20])
        {
            Caption = 'Position Code';

            trigger OnValidate()
            begin
                /*CALCFIELDS("Position Description","Minimal Education Level");
                
                   position.SETFILTER(Code,"Position Code");
                   IF position.FINDFIRST THEN BEGIN
                     "Position Benef".SETFILTER("Position Code","Position Code");
                     IF "Position Benef".FINDFIRST THEN BEGIN
                       REPEAT
                     MAI.INIT;
                     MAI."Employee No.":="Employee No.";
                     MAI."Position Code":="Position Code";
                     MAI."Misc. Article Code":="Position Benef".Code;
                     MAI.Description:="Position Benef".Description;
                     MAI.Amount:="Position Benef".Amount;
                     MAI."Emp. Contract Ledg. Entry No.":=Rec."No.";
                     MAI."From Date":="Starting Date";
                     MAI.INSERT;
                     UNTIL "Position Benef".NEXT=0;
                     END
                END;
                position.SETFILTER("Org. Structure",'%1', "Org. Structure");
                position.SETFILTER(Code,'%1',"Position Code");
                position.SETFILTER("Position ID",'%1',"Position ID");
                IF position.FINDFIRST THEN
                  BEGIN
                    position."Employee No.":="Employee No.";
                    position."Employee Full Name":= "Employee Name";
                    position.MODIFY;
                  END;*/

            end;
        }
        field(50318; "Position ID"; Code[10])
        {
            Caption = 'Position ID';
        }
        field(50319; "Position Description"; Text[250])
        {
            Caption = 'Position Description';
            Editable = false;
            FieldClass = Normal;
        }
        field(50320; "Management Level"; Code[50])
        {
            Caption = 'Management Level';
        }
        field(50321; Meal; Boolean)
        {
            Caption = 'Meal';
        }
        field(50322; "No. Of Days"; Integer)
        {
            Caption = 'No. Of Days';

            trigger OnValidate()
            begin
                IF Meal THEN BEGIN
                    IF "Org Entity Code" = 'FBIH' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code FBIH", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            VALIDATE(Amount, WageSetup.Meal * "No. Of Days");
                            Response := CONFIRM('Da li želite unijeti i oporezivi dio?', TRUE);
                            IF Response THEN BEGIN
                                //  MESSAGE(FORMAT(Response));
                                WAM.INIT;
                                IF WAM2.FINDLAST THEN
                                    WAM."Entry No." := WAM2."Entry No." + 1
                                ELSE
                                    WAM."Entry No." := 0;
                                WAM.VALIDATE("Employee No.", "Employee No.");
                                WAM.VALIDATE("Wage Addition Type", '821');
                                WAM.VALIDATE("No. Of Days", "No. Of Days");
                                WAM.VALIDATE(Amount, WageSetup."Meal Taxable FBiH Untaxable" * "No. Of Days");
                                WAM.VALIDATE("Year of Wage", "Year of Wage");
                                WAM.VALIDATE("Month of Wage", "Month of Wage");
                                WAM.INSERT(TRUE);
                            END;
                        END;
                    END;
                    IF "Org Entity Code" = 'BD' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code FBiH Taxable", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            VALIDATE(Amount, WageSetup."Meal Total BD" * "No. Of Days");
                        END;
                    END;

                    IF "Org Entity Code" = 'RS' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code RS", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            VALIDATE(Amount, WageSetup."Meal Total RS" * "No. Of Days");
                        END;
                    END;
                END;
            end;
        }
        field(50323; "System Entry"; Boolean)
        {
        }
        field(50324; "Org Entity Code"; Code[10])
        {
            Caption = 'Org Entity Code';
        }
        field(50325; "Calculated on Brutto"; Boolean)
        {
            Caption = 'Calculated on Neto (base)';
        }
        field(50326; "No. Of Hours"; Decimal)
        {
            Caption = 'No. Of Days';

            trigger OnValidate()
            begin
                IF Meal THEN BEGIN
                    IF "Org Entity Code" = 'FBIH' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code FBIH", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            VALIDATE(Amount, WageSetup.Meal * ("No. Of Hours" / 8));
                            Response := CONFIRM('Da li želite unijeti i oporezivi dio?', TRUE);
                            IF Response THEN BEGIN
                                //  MESSAGE(FORMAT(Response));
                                WAM.INIT;
                                IF WAM2.FINDLAST THEN
                                    WAM."Entry No." := WAM2."Entry No." + 1
                                ELSE
                                    WAM."Entry No." := 0;
                                WAM.VALIDATE("Employee No.", "Employee No.");
                                WAM.VALIDATE("Wage Addition Type", '821');
                                WAM.VALIDATE("No. Of Days", "No. Of Days");
                                WAM.VALIDATE("No. Of Hours", "No. Of Hours");
                                IF emp.GET("Employee No.") THEN
                                    WAM.VALIDATE(Amount, WageSetup."Meal Taxable FBiH Untaxable" * ("No. Of Hours" / emp."Hours In Day"));
                                WAM.VALIDATE("Year of Wage", "Year of Wage");
                                WAM.VALIDATE("Month of Wage", "Month of Wage");
                                WAM.INSERT(TRUE);
                            END;
                        END;
                    END;
                    IF "Org Entity Code" = 'BD' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code FBiH Taxable", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            IF emp.GET("Employee No.") THEN
                                VALIDATE(Amount, WageSetup."Meal Total BD" * ("No. Of Hours" / emp."Hours In Day"));
                        END;
                    END;

                    IF "Org Entity Code" = 'RS' THEN BEGIN
                        WageSetup.SETFILTER("Meal Code RS", "Wage Addition Type");
                        IF WageSetup.FINDFIRST THEN BEGIN
                            IF emp.GET("Employee No.") THEN
                                VALIDATE(Amount, WageSetup."Meal Total RS" * ("No. Of Hours" / emp."Hours In Day"));
                        END;
                    END;
                END;
            end;
        }
        field(50327; "Calculate Deduction"; Boolean)
        {
            Caption = 'Calculate Deduction';
        }
        field(50328; Bonus; Boolean)
        {
        }
        field(50329; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50330; "Sent e-mail"; Boolean)
        {
            Caption = 'Sent e-mail';
        }
        field(50331; "RAD-1 Wage Excluded"; Boolean)
        {
            CalcFormula = Lookup("Wage Addition Type"."RAD-1 Wage Excluded" WHERE("Code" = FIELD("Wage Addition Type")));
            FieldClass = FlowField;
        }
        field(50332; "Tax Basis"; Decimal)
        {
            Caption = 'Tax Basis';
        }

    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Employee No.", "Year of Wage", "Month of Wage", "Wage Addition Type")
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Wage Addition Type", "Year of Wage", "Month of Wage", "Employee No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //IF xRec.Locked OR xRec.Calculated  THEN ERROR(Txt001);
        IF WH.GET("Wage Header No.") THEN BEGIN
            IF WH.Status = WH.Status::Closed THEN
                ERROR('Ne možete obrisati dodatke plate koja je zaključena');
        END;
    end;

    trigger OnInsert()
    begin
        NextEntryNo := 0;
        IF WA.FIND('+') THEN
            NextEntryNo := WA."Entry No.";

        NextEntryNo += 1;
        "Entry No." := NextEntryNo;
        /*IF ((((TODAY-"Starting Date") DIV 30)<6) AND (("Wage Addition Type"='INC') OR ("Wage Addition Type"='INC FIZ')
          OR ("Wage Addition Type"='INC SFE') OR ("Wage Addition Type"='INC SME') OR ("Wage Addition Type"='INC MICRO')
          OR("Wage Addition Type"='INC PRAV')))
       THEN ERROR('Zaposlenik nije ostvario pravo na incentive!!');*/

    end;

    trigger OnModify()
    begin
        //IF xRec.Locked xRec.Calculated  THEN ERROR(Txt001);
    end;

    trigger OnRename()
    begin
        IF xRec.Locked THEN ERROR(Txt001);
    end;

    var
        Txt001: Label '<Ne smijete mijenjati zakljucani red>';
        Txt002: Label '<Morate navesti tip dodatka>';
        WA: Record "Wage Addition";
        NextEntryNo: Integer;
        emp: Record "Employee";
        ConCat: Record "Contribution Category";
        ATCCon: Record "Contribution Category Conn.";
        ATCConRS: Record "Contribution Category Conn.";
        AddTaxes: Record "Contribution";
        AddTaxesRS: Record "Contribution";
        ATPercentRS: Decimal;
        ATPercent: Decimal;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        //   SegmentationGroup: Record "Segmentation Data";
        wb: Record "Work Booklet";
        WAT: Record "Wage Addition";
        WageAdditionType: Record "Wage Addition Type";
        Class: Record "Tax Class";
        CompInfo: Record "Company Information";
        WageSetup: Record "Wage Setup";
        Response: Boolean;
        WAM: Record "Wage Addition";
        WAMOld: Record "Wage Addition";
        WAM2: Record "Wage Addition";
        WAmounts: Record "Wage Amounts";
        edf: Record "Employee Default Dimension";
        WH: Record "Wage Header";
}

