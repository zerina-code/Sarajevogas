table 50018 "Wage Calculation"
{
    Caption = 'Wage Calculation';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(5; "Wage Header No."; Code[20])
        {
            Caption = 'Wage Header No.';
        }
        field(10; "Document Year"; Integer)
        {
            Caption = 'Document Year';
        }
        field(20; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';

            trigger OnValidate()
            begin
                /*IF emp.GET("Employee No.") THEN BEGIN
                    "First Name":=emp."First Name";
                    "Last Name":=emp."Last Name";
                    END;*/

                IF "Employee No." <> '' THEN BEGIN
                    T_Employee.SETFILTER("No.", "Employee No.");
                    IF T_Employee.FINDFIRST THEN BEGIN
                        "First Name" := T_Employee."First Name";
                        "Last Name" := T_Employee."Last Name";
                    END;
                END;

                // sd01 start
                /*ECL.SETFILTER("Employee No.","Employee No.");
                IF ECL.FINDFIRST THEN BEGIN
                 Department.SETFILTER(Code, ECL."Department Code");
                 IF Department.FINDFIRST THEN BEGIN
                  "Department Municipality":=Department.Municipality;
                  END;
                 END;*/
                //sd01 end

            end;
        }
        field(30; "Month Of Calculation"; Integer)
        {
            Caption = 'Month of Calculation';
        }
        field(31; "Year Of Calculation"; Integer)
        {
            Caption = 'Year Of Calculation';
        }
        field(35; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(40; "Month Of Wage"; Integer)
        {
            Caption = 'Month of Wage';
        }
        field(45; "Year of Wage"; Integer)
        {
            Caption = 'Year of Wage';
        }
        field(50; "Employee Coefficient"; Decimal)
        {
            Caption = 'Employee Coefficient';
        }
        field(55; "Work Experience Percentage"; Decimal)
        {
            Caption = 'Work Experience Percentage';
        }
        field(60; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
        }
        field(64; "Base Tax Deduction"; Decimal)
        {
            Caption = 'Base Tax Deduction';
        }
        field(65; "Tax Deductions"; Decimal)
        {
            Caption = 'Tax Deductions';
        }
        field(70; "Work Experience Brutto"; Decimal)
        {
            Caption = 'Work Experience Brutto';
        }
        field(75; Brutto; Decimal)
        {
            Caption = 'Brutto';
        }
        field(80; "Contribution From Brutto"; Decimal)
        {
            Caption = 'Contribution From Brutto';
        }
        field(85; "Contribution Over Brutto"; Decimal)
        {
            Caption = 'Contribution Over Brutto';
        }
        field(90; "Net Wage"; Decimal)
        {
            Caption = 'Net Wage';
        }
        field(95; "Untaxable Wage"; Decimal)
        {
            Caption = 'Untaxable Wage';
        }
        field(100; "Tax Basis"; Decimal)
        {
            Caption = 'Tax Basis';
        }
        field(105; Tax; Decimal)
        {
            Caption = 'Tax';
        }
        field(106; "Wage Addition Brutto"; Decimal)
        {
            Caption = 'Wage Addition Brutto';
        }
        field(107; "Wage Addition Netto"; Decimal)
        {
            Caption = 'Wage Addition Netto';
        }
        field(110; "Contribution Per City"; Decimal)
        {
            Caption = 'Contribution Per City';
        }
        field(115; "Final Net Wage"; Decimal)
        {
            Caption = 'Final Net Wage';
        }
        field(120; "Wage Reduction"; Decimal)
        {
            Caption = 'Wage Reduction';
        }
        field(121; Transport; Decimal)
        {
            Caption = 'Transport';
        }
        field(125; Payment; Decimal)
        {
            Caption = 'Payment';
        }
        field(130; "Sick Leave-Company"; Decimal)
        {
            Caption = 'Sick Leave Company';
        }
        field(131; "Sick Leave-Fund"; Decimal)
        {
            Caption = 'Sick Leave-Fund';
        }
        field(135; "Contribution Category Code"; Code[10])
        {
            Caption = 'Additional Tax Category Code';
            TableRelation = "Contribution Category".Code;
        }
        field(140; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(145; VAT; Decimal)
        {
            Caption = 'VAT';
            Description = 'Only applicable for contract incl. VAT';
        }
        field(150; Vacation; Decimal)
        {
            Caption = 'Vacation';
        }
        field(155; Holidays; Decimal)
        {
            Caption = 'Holidays';
        }
        field(160; "Wage Type"; Code[10])
        {
            Caption = 'Wage Type';
            Description = 'Wage calculation type';
        }
        field(165; "Life Premium"; Decimal)
        {
            Caption = 'Life Insurance Premium';
        }
        field(166; "Health Premium"; Decimal)
        {
            Caption = 'Add. Health Ins. Premium';
        }
        field(167; "Pension Premium"; Decimal)
        {
            Caption = 'Add. Pension Ins. Premium';
        }
        field(168; "Insurance Premium"; Decimal)
        {
            Caption = 'Total Ins. Premium';
        }
        field(169; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
        }
        field(170; "Contracted Work"; Boolean)
        {
            Caption = 'Contracted Work';
        }
        field(171; "Wage (Base)"; Decimal)
        {
            Caption = 'Wage (Base)';
        }
        field(172; "Net Wage (Calculated Base)"; Decimal)
        {
            Caption = 'Net Wage (Calculated Base)';
        }
        field(173; "Work Experience (Base)"; Decimal)
        {
            Caption = 'Work Experience (Base)';
        }
        field(174; "Wage (Base) is Neto"; Boolean)
        {
            Caption = 'Wage (Base) is Neto';
        }
        field(175; "Indirect Wage Addition Amount"; Decimal)
        {
            Caption = 'Indirect Wage Addition Amount';
        }
        field(176; "Net Wage After Tax"; Decimal)
        {
            Caption = 'Net Wage After Tax';
        }
        field(177; "Earnings Deduction"; Decimal)
        {
            Caption = 'Earnings Deduction';
        }
        field(178; "Minimal Netto Wage Difference"; Decimal)
        {
            Caption = 'Minimal Netto Wage Difference';
        }
        field(179; "Minimal Netto Wage"; Boolean)
        {
            Caption = 'Minimal Netto Wage';
        }
        field(180; "Meal to pay"; Decimal)
        {
            Caption = 'Meal to pay';
        }
        field(181; "Meal to refund"; Decimal)
        {
            Caption = 'Meal to refund';
        }
        field(182; "Wage Addition"; Decimal)
        {
            Caption = 'Wage Addition';
        }
        field(183; SGC; Code[10])
        {
            Caption = 'SGC';
        }
        field(184; "Experience Total"; Decimal)
        {
            Caption = 'Experience Total';
        }
        field(185; "Sick Fund Total"; Decimal)
        {
            Caption = 'Sick Fund Total';
        }
        field(186; "Calculation Type"; Option)
        {
            Caption = 'Calculation Type';
            OptionCaption = 'Worker, Board, Supervisor, Trainee';
            OptionMembers = Worker,Board,Supervisor,Trainee;
        }
        field(187; SubLinesHidden; Boolean)
        {
        }
        field(188; HiddenLine; Boolean)
        {
        }
        field(189; MasterLine; Boolean)
        {
        }
        field(190; "Hour Pool"; Decimal)
        {
            Caption = 'Hour Pool';
        }
        field(191; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(192; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
        }
        field(193; "General Coefficient"; Decimal)
        {
            Caption = 'General Coefficient';
        }
        field(194; "Contribution Over Netto"; Decimal)
        {
            Caption = 'Additional Tax Over Brutto';
        }
        field(195; "Entity Code"; Code[10])
        {
            Caption = 'Entity Code';
        }
        field(196; "Net Wage Netto 2"; Decimal)
        {
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Calculation Type';
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199; "Approved Expenditures"; Decimal)
        {
            Caption = 'Approved Expenditures';
        }
        field(200; "Net Wage 2"; Decimal)
        {
            Caption = 'Net Wage';
        }
        field(201; "Unpaid Absence"; Decimal)
        {
            Caption = 'Unpaid Absence';
        }
        field(202; "Coeff. Difference"; Decimal)
        {
            Caption = 'Coeff. Difference';
        }
        field(203; "Unpaid Absence Hours"; Decimal)
        {
            Caption = 'Unpaid Absence Hours';
        }
        field(204; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(205; "Last Name"; Text[50])
        {
            Caption = 'Last Name';
        }
        field(206; "Taxable Meal"; Decimal)
        {
            Caption = 'Taxable Meal';
        }
        field(207; "Brutto Meal"; Decimal)
        {
            Caption = 'Brutto Meal';
        }
        field(208; "Taxable Transport"; Decimal)
        {
            Caption = 'Taxable Transport';
        }
        field(209; "Brutto Transport"; Decimal)
        {
            Caption = 'Brutto Transport';
        }
        field(210; "Reported Amount From Brutto"; Decimal)
        {
            Caption = 'Reported Amount From Brutto';
        }
        field(211; "Individual Hour Pool"; Decimal)
        {
            Caption = 'Individual Hour Pool';
        }
        field(212; Use; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount Brutto" WHERE(Use = FILTER(true),
                                                                                "Employee No." = FIELD("Employee No."),
                                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                                "Wage Calculation Entry No." = FIELD("No.")));
            Caption = 'Use';

        }
        field(213; "Tax Basis (RS)"; Decimal)
        {
            Caption = 'Tax Basis (RS)';
        }
        field(214; "Tax (RS)"; Decimal)
        {
            Caption = 'Tax (RS)';
        }
        field(215; "Department Municipality"; Code[10])
        {
            Caption = 'Department Municipality';
            FieldClass = Normal;
        }
        field(216; "Municipality CIPS"; Code[10])
        {
            Caption = 'Municipality CIPS';
        }
        field(217; "Use Netto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Use = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No.")));
            Caption = 'Use Netto';

        }
        field(218; Invalid; Boolean)
        {
        }
        field(219; "Regres Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount Brutto" WHERE(Regres = FILTER(true),
                                                                                "Employee No." = FIELD("Employee No."),
                                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                            "Wage Calculation Entry No." = FIELD("No.")));
            Caption = 'Regres Brutto';

        }
        field(220; "Regres Netto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No.")));
            Caption = 'Regres Netto';

        }
        field(221; "Payment Date (TS Residents)"; Date)
        {
            Caption = 'Payment Date (TS Residents)';
        }
        field(222; "Payment Date (TS No Residents)"; Date)
        {
            Caption = 'Payment Date (TS No Residents)';
        }
        field(223; "Payment Date (Author Contract)"; Date)
        {
            Caption = 'Payment Date (Author Contract)';
        }
        field(224; Status; enum "Employee Status Ext")
        {
            Caption = 'Status';

        }
        field(225; Paid; Boolean)
        {
            Caption = 'Paid';
        }
        field(226; "Regres Brutto Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount Brutto" WHERE(Regres = FILTER(true),
                                                                                "Employee No." = FIELD("Employee No."),
                                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                                "Wage Calculation Entry No." = FIELD("No."),
                                                                                Calculated = CONST(true)));
            Caption = 'Regres Brutto';

        }
        field(227; "Regres Netto Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Calculation Entry No." = FIELD("No."),
                                                                     Calculated = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(228; "Regres Netto Tax Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Calculation Entry No." = FIELD("No."),
                                                                     Calculated = FILTER(true),
                                                                     Taxable = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(229; "Regres Netto Tax"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No.")));
            Caption = 'Regres Netto';

        }
        field(230; "Tax Base Additions"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Calculated Amount" WHERE(Regres = FILTER(true),
                                                                         "Employee No." = FIELD("Employee No."),
                                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                                         "Wage Calculation Entry No." = FIELD("No."),
                                                                         Taxable = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(231; "Tax Additions"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE(Regres = FILTER(true),
                                                         "Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Calculation Entry No." = FIELD("No."),
                                                         Taxable = FILTER(true)));
            Caption = 'Regres Netto';

        }
        field(232; "Employee Name"; Text[250])
        {
            FieldClass = Normal;
        }
        field(233; "Regres Netto With Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(true),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(true),
                                                                     Calculated = FILTER(false)));
            Caption = 'Regres Netto';

        }
        field(234; "SAP 1"; Code[10])
        {
        }
        field(235; "SAP 2"; Code[10])
        {
        }
        field(236; "Date Of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(237; "Meal Correction"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                                     "Year of Wage" = FIELD("Year of Wage"),
                                                                     Meal = FILTER(true),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "System Entry" = FILTER(false),
                                                                     Taxable = FILTER(false)));

        }
        field(238; Calculated; Boolean)
        {
            Caption = 'Calculated';
        }
        field(50295; "Department Name"; Text[100])
        {
            Caption = 'Department Name';
            Editable = false;
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
        }
        field(50320; "Management Level"; Code[50])
        {
            Caption = 'Management Level';
        }
        field(50321; Incentive; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Brutto WHERE("Employee No." = FIELD("Employee No."),
                                                            "Wage Header No." = FIELD("Wage Header No."),
                                                            Incentive = FILTER(true)));

        }
        field(50322; "Phisical Org Dio"; Code[10])
        {
            CalcFormula = Lookup(Department."ORG Dio" WHERE("Code" = FIELD("Phisical Department Code")));
            Caption = 'Org. Part';
            FieldClass = FlowField;
            TableRelation = Department."ORG Dio";
        }
        field(50323; "Org Dio"; Code[10])
        {
            CalcFormula = Lookup(Department."ORG Dio" WHERE("Code" = FIELD("Department Code")));
            Caption = 'Org. Part';
            FieldClass = FlowField;
        }
        field(50328; "Phisical Department Code"; Code[20])
        {
            Caption = 'Department Code';
            TableRelation = Department.Code;
        }
        field(50329; "Incentive SFE"; Decimal)


        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Incentive = FILTER(true)));

        }
        field(50330; "Incentive PRAVNA"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC PRAV')));

        }
        field(50331; "Incentive FIZ"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC FIZ')));

        }
        field(50332; "Incentive CORP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC CORP')));

        }
        field(50333; "Incentive SME"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC SME')));

        }
        field(50334; "Incentive MICRO"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('INC MICRO')));

        }
        field(50335; "Tax Incentive"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         Incentive = FILTER(true)));
            Caption = 'Tax Incentive';

        }
        field(50336; "Contribution From Incentive"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  Incentive = FILTER(true)));
            Caption = 'Contribution From Incentive';

        }
        field(50337; "Contribution Over Incentive"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                Incentive = FILTER(true)));
            Caption = 'Contribution Over Incentive';

        }
        field(50338; "Leaving Payment Retirement"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Leaving Payment Retirement';

        }
        field(50339; "Tax Leaving Payment Retirement"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Tax Leaving Payment Retirement';

        }
        field(50340; "Contribution From LPR"; Decimal)
        {

            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Contribution From LPR';

        }
        field(50341; "Contribution Over LPR"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                "Wage Addition Type" = FILTER('OTPR. PENZ')));
            Caption = 'Contribution Over LPR';

        }
        field(50342; "Leaving Payment"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Leaving Payment';

        }
        field(50343; "Tax Leaving Payment"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Tax Leaving Payment';

        }
        field(50344; "Contribution From LP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Contribution From LP';

        }
        field(50345; "Contribution Over LP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                "Wage Addition Type" = FILTER('OTPREMNINA')));
            Caption = 'Contribution Over LP';

        }
        field(50346; Bonus; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Bonus = FILTER(TRUE)));
            Caption = 'Bonus';
            FieldClass = FlowField;
        }
        field(50347; "Tax Bonus"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         Bonus = FILTER(TRUE)));
            Caption = 'Tax Bonus';
            FieldClass = FlowField;
        }
        field(50348; "Contribution From Bonus"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  Bonus = FILTER(TRUE)));
            Caption = 'Contribution From bonus';
            FieldClass = FlowField;
        }
        field(50349; "Contribution Over Bonus"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                Bonus = FILTER(TRUE)));
            Caption = 'Contribution Over bonus';
            FieldClass = FlowField;
        }
        field(50350; OST; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Wage Addition Type" = FILTER('OST')));
            Caption = 'Other';
            FieldClass = FlowField;
        }
        field(50351; "Tax OST"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Tax WHERE("Employee No." = FIELD("Employee No."),
                                                         "Wage Header No." = FIELD("Wage Header No."),
                                                         "Wage Addition Type" = FILTER('OST')));
            Caption = 'Tax Other';
            FieldClass = FlowField;
        }
        field(50352; "Contribution From OST"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Employee No." = FIELD("Employee No."),
                                                                  "Wage Header No." = FIELD("Wage Header No."),
                                                                  "Wage Addition Type" = FILTER('OST')));
            Caption = 'Contribution From other';
            FieldClass = FlowField;
        }
        field(50353; "Contribution Over OST"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Employee No." = FIELD("Employee No."),
                                                                "Wage Header No." = FIELD("Wage Header No."),
                                                                "Wage Addition Type" = FILTER('OST')));
            Caption = 'Contribution Over other';
            FieldClass = FlowField;
        }
        field(50354; "Total Netto by Contract"; Decimal)
        {
            Caption = 'Total Netto';
        }
        field(50355; "Netto by Contract"; Decimal)
        {
            Caption = ' Netto by Contract';
        }
        field(50356; "Total Netto Without Use"; Decimal)
        {
        }
        field(50357; "Total Netto Without Untaxable"; Decimal)
        {
        }
        field(50358; "Old Brutto"; Decimal)
        {
            Caption = 'Brutto';
        }
        field(50360; "Org Entity Code"; Code[10])
        {
            Caption = 'Org Entity Code';
        }
        field(50361; "Reduction Netto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     "Calculate Deduction" = FILTER(FALSE)));
            Caption = 'Reduction Netto';

        }
        field(50362; "Planned Transport Amount"; Decimal)
        {
            Caption = 'Planned Transport Amount';
        }
        field(50363; "Contact Center"; Boolean)
        {
            Caption = 'Contact Center';
        }
        field(50364; "Send pay list"; Boolean)
        {
            Caption = 'Send pay list';
        }
        field(50365; "JIB Contributes"; Text[30])
        {
            Caption = 'JIB Contributes';
        }
        field(50366; "Regres Netto With Wage Taxable"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(TRUE),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(TRUE),
                                                                     Calculated = FILTER(FALSE),
                                                                     Taxable = FILTER(TRUE)));
            Caption = 'Regres Netto With Wage Taxable';

        }
        field(50367; "Regres Netto With Wage UnTax"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(TRUE),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(TRUE),
                                                                     Calculated = FILTER(FALSE),
                                                                     Taxable = FILTER(FALSE)));
            Caption = 'Regres Netto With Wage UnTax';

        }
        field(50368; "Other Netto Separate Taxable"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(FALSE),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(TRUE),
                                                                     Calculated = FILTER(TRUE),
                                                                     Taxable = FILTER(TRUE),
                                                                     Regres = FILTER(FALSE)));
            Caption = 'Other Netto Separate Taxable';

        }
        field(50369; "Other Netto Separat UnTax"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE(Regres = FILTER(FALSE),
                                                                     "Employee No." = FIELD("Employee No."),
                                                                     "Wage Header No." = FIELD("Wage Header No."),
                                                                     Locked = FILTER(TRUE),
                                                                     Calculated = FILTER(TRUE),
                                                                     Taxable = FILTER(FALSE),
                                                                     Regres = FILTER(FALSE)));
            Caption = 'Other Netto Separat UnTax';

        }
        field(50370; "Regres Netto UnTax Separate"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Amount WHERE(Regres = FILTER(TRUE),
                                                            "Employee No." = FIELD("Employee No."),
                                                            "Wage Header No." = FIELD("Wage Header No."),
                                                            Calculated = FILTER(TRUE),
                                                            Taxable = FILTER(FALSE)));

        }
        field(50371; "Org Jed"; Text[250])
        {
        }
        field(50372; Munif; Text[50])
        {
        }

        field(50390; "Iznos poreske kartice"; Decimal)
        {


        }

        field(50391; "Iznos ličnog odbitka"; Decimal)
        {


        }
        field(50392; "Position Coefficient for Wage"; Decimal)
        {
            Caption = 'Position Coefficient for Wage';
        }
        field(50393; "Wage Base"; Decimal)
        {
            Caption = 'Wage Base';
        }
        field(50375; "Regres Netto With Wage Tax RAD"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Amount WHERE(Regres = FILTER(true), "Employee No." = FIELD("Employee No."),
            "Wage Header No." = FIELD("Wage Header No."), Locked = FILTER(true), Calculated = FILTER(false), Taxable = FILTER(true)));

        }
        field(50376; "Education Level"; Enum School)
        {

        }
        field(5377; "Gender"; enum "Employee Gender")
        {

        }
        field(50378; "Number Of Month"; Integer)
        {

        }
        field(50379; "Employee Disability"; Boolean)
        {

        }
        field(50380; "Sick Leave Brutto"; Decimal)
        {

        }
        field(50381; "Netto Wage Base"; Decimal)
        {

        }
        field(50382; "Brutto Wage Base"; Decimal)
        {

        }
        field(50383; "Average Salary FBIH"; Decimal)
        {

            Caption = 'Average Salary FBIH';
        }
        field(50384; "Average coefficient statute"; Decimal)
        {
            Caption = 'Average coefficient statute';
        }
        field(50385; "Position Coefficient"; Decimal)
        {
            Caption = 'Position Coefficient';

        }



    }

    keys
    {
        key(Key1; "No.", "Wage Header No.", "Wage Calculation Type", "Employee No.")
        {
        }
        key(Key2; "Wage Header No.", "Entry No.", "Contracted Work")
        {
            SumIndexFields = Brutto, "Contribution From Brutto", "Contribution Over Brutto", "Net Wage", Tax, "Contribution Per City", "Final Net Wage", "Wage Reduction", Transport, Payment, "Sick Leave-Company", "Sick Leave-Fund", "Tax Basis", "Wage (Base)", "Untaxable Wage", "Work Experience (Base)";
        }
        key(Key3; "Month Of Calculation", "Payment Date")
        {
        }
        key(Key4; "Wage Header No.", "Employee No.")
        {
            SumIndexFields = Brutto, "Net Wage", "Meal to pay", "Experience Total", "Wage Addition", "Wage Reduction";
        }
        key(Key5; SGC, "Employee No.", "Wage Header No.")
        {
            SumIndexFields = "Net Wage", "Meal to pay", "Experience Total", "Wage Addition", "Wage Reduction", "Sick Fund Total", "Sick Leave-Company";
        }
        key(Key6; "Employee Name")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        Calc.RESET;
        Calc.SETFILTER("Wage Header No.", "Wage Header No.");
        Calc.SETRANGE("Entry No.", "Entry No.");


        IF Calc.FINDFIRST THEN
            REPEAT

                WageV.Reset();
                WageV.SetFilter("Wage Calculation Type", '%1', Calc."Wage Calculation Type");
                WageV.SetFilter("Employee No.", '%1', Calc."Employee No.");
                WageV.SetFilter("Document No.", '%1', Calc."Wage Header No.");
                if WageV.FindSet() then
                    repeat
                        WageV.Delete();
                    until WageV.Next() = 0;

                CalcTemp.RESET;
                CalcTemp.SETFILTER("Wage Header No.", "Wage Header No.");
                CalcTemp.SETRANGE("Entry No.", "Entry No.");
                CalcTemp.SETRANGE("Employee No.", Calc."Employee No.");
                if CalcTemp.FindFirst() then
                    repeat
                        CalcTemp.DELETE(true);
                    until CalcTemp.Next() = 0;
                RedTemp.RESET;
                RedTemp.SETFILTER("Wage Header No.", "Wage Header No.");
                RedTemp.SETRANGE("Employee No.", Calc."Employee No.");


                if RedTemp.FindFirst() then
                    repeat
                        RedTemp.DELETE(true);
                    until RedTemp.Next() = 0;



                RedReal.RESET;
                RedReal.SETFILTER("Wage Header No.", "Wage Header No.");
                RedReal.SETRANGE("Employee No.", Calc."Employee No.");



                if RedReal.FindFirst() then
                    repeat
                        RedReal.DELETE(true);
                    until RedReal.Next() = 0;


                ATTax.RESET;
                ATTax.SETFILTER("Wage Header No.", "Wage Header No.");
                ATTax.SETRANGE("Entry No.", "Entry No.");
                ATTax.SETRANGE("Employee No.", Calc."Employee No.");


                if ATTax.FindFirst() then
                    repeat
                        ATTax.DELETE(true);
                    until ATTax.Next() = 0;



                TaxEmp.RESET;
                TaxEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                TaxEmp.SETRANGE("Entry No.", "Entry No.");
                TaxEmp.SETRANGE("Employee No.", Calc."Employee No.");



                if TaxEmp.FindFirst() then
                    repeat
                        TaxEmp.DELETE(true);
                    until TaxEmp.Next() = 0;



            UNTIL Calc.NEXT = 0;

        //Calc.DELETEALL(TRUE);*/

    end;

    var
        ATTax: Record "Contribution Per Employee";
        TaxEmp: Record "Tax Per Employee";
        E: Record "Employee";
        emp: Record "Employee";
        Calc: Record "Wage Calculation";
        CalcTemp: Record "Wage Calculation Temp";
        RedTemp: Record "Reduction per Wage Temp";
        RedReal: Record "Reduction per Wage";
        ATTaxTemp: Record "Contribution Per Employee Temp";
        TaxEmpTemp: Record "Tax Per Employee Temp";
        T_Employee: Record "Employee";
        ECL: Record "Employee Contract Ledger";
        Department: Record "Department";

        WageV: Record "Wage Value Entry";
}

