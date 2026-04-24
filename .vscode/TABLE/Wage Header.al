table 50017 "Wage Header"
{
    // //

    Caption = 'Wage Header';
    DrillDownPageID = "Wage Header List";
    LookupPageID = "Wage Header List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = true;
        }
        field(5; "Year of Calculation"; Integer)
        {
            Caption = 'Year of Calculation';
        }
        field(10; "Month of Calculation"; Integer)
        {
            Caption = 'Month of Calculation';
        }
        field(15; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(20; "Hour Pool"; Integer)
        {
            Caption = 'Hour Pool';
        }
        field(25; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(30; "Last Calculation In Month"; Boolean)
        {
            Caption = 'Last Calculation In Month';
        }
        field(35; Transportation; Boolean)
        {
            Caption = 'Transportation';

            trigger OnValidate()
            begin
                //TESTFIELD("Wage Calculation Type","Wage Calculation Type"::Normal);
            end;
        }
        field(40; Reduction; Boolean)
        {
            Caption = 'Reduction';

            trigger OnValidate()
            begin
                //TESTFIELD("Wage Calculation Type","Wage Calculation Type"::Normal);
            end;
        }
        field(45; "Date Of Calculation"; Date)
        {
            Caption = 'Date of Calculation';

            trigger OnValidate()
            begin
                Description := Txt012 + ' ' + FORMAT("Month Of Wage") + '.' + FORMAT("Year Of Wage");
            end;
        }
        field(50; Status; Option)
        {
            Caption = 'Status';
            Description = ',Open,Close,Locked';
            OptionCaption = ',Open,Closed,Locked';
            OptionMembers = ,Open,Closed,Locked;
        }
        field(70; "Month Of Wage"; Integer)
        {
            Caption = 'Month of Wage';
            Description = 'Month for which the wage is calculated and paid';

            trigger OnValidate()
            begin
                /*"Chamber Year":="Year Of Wage"-1;
                
                WH.SETRANGE("Year Of Wage","Chamber Year");
                IF WH.FINDFIRST THEN REPEAT
                  BEGIN
                   WH.CALCFIELDS(Brutto);
                  "Brutto Sum"+=WH.Brutto;
                  END;
                  UNTIL WH.NEXT=0;
                
                WS.GET();
                "Chamber Amount":=ROUND((WS."Brutto Rate"*WS."Chamber Rate(%)"*"Brutto Sum")/100, 0.001);
                MODIFY;*/

                "Chamber Year" := "Year Of Wage" - 1;

                IF "Brutto Sum" = 0 THEN BEGIN
                    WH.SETRANGE("Year Of Wage", "Chamber Year");
                    IF WH.FINDFIRST THEN
                        REPEAT
                        BEGIN
                            WH.CALCFIELDS(Brutto);
                            "Brutto Sum" += WH.Brutto;
                        END;
                        UNTIL WH.NEXT = 0;
                    WS.GET();
                    "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                    MODIFY;
                END
                ELSE
                    IF "Brutto Sum" <> 0 THEN BEGIN
                        WS.GET();
                        "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                        MODIFY;
                    END;

            end;
        }
        field(75; "Year Of Wage"; Integer)
        {
            Caption = 'Year of Wage';
            Description = 'Year for which the wage is calculated and paid';

            trigger OnValidate()
            begin
                "Chamber Year" := "Year Of Wage" - 1;
                IF "Brutto Sum" = 0 THEN BEGIN
                    WH.SETRANGE("Year Of Wage", "Chamber Year");
                    IF WH.FINDFIRST THEN
                        REPEAT
                        BEGIN
                            WH.CALCFIELDS(Brutto);
                            "Brutto Sum" += WH.Brutto;
                        END;
                        UNTIL WH.NEXT = 0;
                    WS.GET();
                    "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                    MODIFY;
                END
                ELSE
                    IF "Brutto Sum" <> 0 THEN BEGIN
                        WS.GET();
                        "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                        MODIFY;
                    END;
            end;
        }
        field(80; "Minimum Wage"; Decimal)
        {
            Caption = 'Minimum Wage';
            Description = 'From wage setup';
        }
        field(81; "Monthly Minimum Wage"; Decimal)
        {
            Caption = 'Monthly Minimum Wage';
        }
        field(85; "Minimum Untaxable Wage"; Decimal)
        {
            Caption = 'Minimum Untaxed Wage';
            Description = 'From wage setup';
        }
        field(90; "Average Yearly Hour Pool"; Integer)
        {
            Caption = 'Average Yearly Hour Pool';
            Description = 'From wage setup';
        }
        field(95; "Work Experience Basis"; Decimal)
        {
            Caption = 'Work Experience Basis';
            Description = 'Not Used';
        }
        field(100; "Closing Date"; Date)
        {
            Caption = 'Closing Date';
            Description = 'Not Used';

            trigger OnValidate()
            begin
                "Date Of Calculation" := "Closing Date";
            end;
        }
        field(105; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(110; Timestamp_WH; DateTime)
        {
        }
        field(115; "Step 1"; Boolean)
        {
            Description = 'Not visible to user-for internal use';
        }
        field(120; "Step 2"; Boolean)
        {
            Description = 'Not visible to user-for internal use';
        }
        field(125; "Step 3"; Boolean)
        {
            Description = 'Not visible to user-for internal use';
        }
        field(130; "Step 4"; Boolean)
        {
            Description = 'Not visible to user-for internal use';
        }
        field(135; "Step 5"; Boolean)
        {
            Description = 'Not visible to user-for internal use';
        }
        field(140; "Temp Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Calculation Temp".Brutto WHERE("Wage Header No." = FIELD("No."),
                                                                   "Entry No." = FIELD("Entry No.")));
            Caption = 'Brutto';

        }
        field(145; "Temp Net Wage"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Net Wage After Tax" WHERE("Wage Header No." = FIELD("No."),
                                                                                 "Entry No." = FIELD("Entry No.")));
            Caption = 'Net Wage';
            FieldClass = FlowField;
        }
        field(150; "Temp Final Net Wage"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Final Net Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                             "Entry No." = FIELD("Entry No.")));
            Caption = 'Final Net Wage';
            FieldClass = FlowField;
        }
        field(155; "Temp Add. Tax From Brutto"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Contribution From Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                       "Entry No." = FIELD("Entry No.")));
            Caption = 'Additional Tax From Brutto';
            FieldClass = FlowField;
        }
        field(160; "Temp Add. Tax Over Brutto"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Contribution Over Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                       "Entry No." = FIELD("Entry No.")));
            Caption = 'Additional Tax Over Brutto';
            FieldClass = FlowField;
        }
        field(165; "Temp Tax"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp".Tax WHERE("Wage Header No." = FIELD("No."),
                                                                "Entry No." = FIELD("Entry No.")));
            Caption = 'Tax';
            FieldClass = FlowField;
        }
        field(170; "Temp Added Tax Per City"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Contribution Per City" WHERE("Wage Header No." = FIELD("No."),
                                                                                    "Entry No." = FIELD("Entry No.")));
            Caption = 'Added Tax Per City';
            FieldClass = FlowField;
        }
        field(175; "Temp Wage Reduction"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Wage Reduction" WHERE("Wage Header No." = FIELD("No."),
                                                                             "Entry No." = FIELD("Entry No.")));
            Caption = 'Wage Reduction';
            FieldClass = FlowField;
        }
        field(180; "Temp Transport"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp".Transport WHERE("Wage Header No." = FIELD("No."),
                                                                      "Entry No." = FIELD("Entry No.")));
            Caption = 'Transport';
            FieldClass = FlowField;
        }
        field(185; "Temp Sick Leave-Company"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Sick Leave-Company" WHERE("Wage Header No." = FIELD("No."),
                                                                                 "Entry No." = FIELD("Entry No.")));
            Caption = 'Sick Leave-Company';
            FieldClass = FlowField;
        }
        field(190; "Temp Sick Leave-Fund"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp"."Sick Leave-Fund" WHERE("Wage Header No." = FIELD("No."),
                                                                              "Entry No." = FIELD("Entry No.")));
            Caption = 'Sick Leave-Fund';
            FieldClass = FlowField;
        }
        field(191; "Temp Payment"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation Temp".Payment WHERE("Wage Header No." = FIELD("No."),
                                                                    "Entry No." = FIELD("Entry No.")));
            Caption = 'Payment';
            FieldClass = FlowField;
        }
        field(195; Brutto; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Calculation".Brutto WHERE("Wage Header No." = FIELD("No."),
                                                              "Entry No." = FIELD("Entry No."),
                                                               "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Brutto';

        }
        field(200; "Net Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Calculation"."Net Wage After Tax" WHERE("Wage Header No." = FIELD("No."),
                                                                            "Entry No." = FIELD("Entry No."),
                                                                             "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Net Wage';

        }
        field(201; "Average Net Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Average("Wage Calculation"."Net Wage After Tax" WHERE("Wage Header No." = FIELD("No."),
                                                                                "Entry No." = FIELD("Entry No."),
                                                                                 "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Net Wage';

        }
        field(205; "Final Net Wage"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Calculation"."Final Net Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                        "Entry No." = FIELD("Entry No."),
                                                                         "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Final Net Wage';

        }
        field(210; "Add. Tax From Brutto"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution From Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                  "Entry No." = FIELD("Entry No."),
                                                                                   "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Additional Tax From Brutto';
            FieldClass = FlowField;
        }
        field(215; "Add. Tax Over Brutto"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution Over Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                  "Entry No." = FIELD("Entry No."),
                                                                                   "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Additional Tax Over Brutto';
            FieldClass = FlowField;
        }
        field(220; Tax; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Tax WHERE("Wage Header No." = FIELD("No."),
                                                           "Entry No." = FIELD("Entry No."),
                                                            "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Tax';
            FieldClass = FlowField;
        }
        field(225; "Added Tax Per City"; Decimal)
        {
            Caption = 'Added Tax Per City';
        }
        field(230; "Wage Reduction"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Wage Reduction" WHERE("Wage Header No." = FIELD("No."),
                                                                        "Entry No." = FIELD("Entry No."),
                                                                         "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Wage Reduction';
            FieldClass = FlowField;
        }
        field(235; Transport; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Transport WHERE("Wage Header No." = FIELD("No."),
                                                                 "Entry No." = FIELD("Entry No."),
                                                                  "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Transport';
            FieldClass = FlowField;
        }
        field(240; "Sick Leave-Company"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Sick Leave-Company" WHERE("Wage Header No." = FIELD("No."),
                                                                            "Entry No." = FIELD("Entry No."),
                                                                             "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Sick Leave-Company';
            FieldClass = FlowField;
        }
        field(245; "Sick Leave-Fund"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Sick Leave-Fund" WHERE("Wage Header No." = FIELD("No."),
                                                                         "Entry No." = FIELD("Entry No."),
                                                                          "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Sick Leave-Fund';
            FieldClass = FlowField;
        }
        field(250; "Temp VAT"; Decimal)
        {
            Caption = 'VAT';
        }
        field(255; VAT; Decimal)
        {
            Caption = 'VAT';
        }
        field(260; "Tax Deduction"; Decimal)
        {
            Caption = 'Tax Deduction';
        }
        field(265; "Tax Basis"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Tax Basis" WHERE("Wage Header No." = FIELD("No."),
                                                                   "Entry No." = FIELD("Entry No."),
                                                                    "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Tax Basis';
            FieldClass = FlowField;
        }
        field(270; Vacation; Decimal)
        {
            Caption = 'Vacation';
        }
        field(275; "Temp Vacation"; Decimal)
        {
            Caption = 'Vacation';
        }
        field(280; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(285; "Temp Tax Deduction"; Decimal)
        {
            Caption = 'Temp Tax Deduction';
        }
        field(290; "Calculation Count"; Integer)
        {
            Description = 'How many employees are included in calculation';
        }
        field(295; Payment; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Payment WHERE("Wage Header No." = FIELD("No."),
                                                               "Entry No." = FIELD("Entry No."),
                                                                "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Payment';
            FieldClass = FlowField;
        }
        field(300; "Payment Date"; Date)
        {
            Caption = 'Payment Date';
            Description = 'When was the wage paid';
        }
        field(305; "Contract Filter"; Boolean)
        {
            Caption = 'Contract Filter';
            Description = 'SPNPL01.01';
        }
        field(306; "Untaxable Wage"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Untaxable Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                        "Entry No." = FIELD("Entry No."),
                                                                         "Wage Calculation Type" = FILTER(Regular)));
            Caption = 'Untaxable Wage';
            FieldClass = FlowField;
        }
        field(307; "Net Wage (Base)"; Decimal)
        {
            Caption = 'Net Wage (Base)';
        }
        field(308; "Work Experience (Base)"; Decimal)
        {
            Caption = 'Work Experience (Base)';
        }
        field(309; Meal; Boolean)
        {
            Caption = 'Meal';
            Description = 'Is Meal Calculated';

            trigger OnValidate()
            begin
                //TESTFIELD("Wage Calculation Type","Wage Calculation Type"::Normal);
            end;
        }
        field(310; "General Coefficient"; Decimal)
        {
            Caption = 'General Coefficient';
        }
        field(311; "Board Coefficient"; Decimal)
        {
            Caption = 'Board Coefficient';
        }
        field(312; "Wage Calculation Type"; Option)
        {
            Caption = 'Wage Type';
            OptionCaption = 'Normal,Fixed Add,Average Amount Add,Average Percentage Add';
            OptionMembers = Normal,"Fixed Add","Average Amount Add","Average Percentage Add";

            trigger OnValidate()
            begin
                IF "Wage Calculation Type" <> "Wage Calculation Type"::Normal
                  THEN BEGIN
                    Meal := FALSE;
                    Transportation := FALSE;
                    Reduction := FALSE;
                    Taxable := FALSE;
                    HeaderDescriptionAddition := Txt013;
                    Description := HeaderDescriptionAddition + ' ' + FORMAT("Month Of Wage") + '.' + FORMAT("Year Of Wage");
                END
                ELSE
                    Description := Txt012 + ' ' + FORMAT("Month Of Wage") + '.' + FORMAT("Year Of Wage");
            end;
        }
        field(313; "Average Add Period Start"; Date)
        {
            Caption = 'Average Add Period Start';
        }
        field(314; "Average Add Period End"; Date)
        {
            Caption = 'Average Add Period End';
        }
        field(315; "Average Add Amount"; Decimal)
        {
            Caption = 'Average Add Amount';
        }
        field(316; "Average Add Percentage"; Decimal)
        {
            Caption = 'Average Add Percentage';
        }
        field(317; Taxable; Boolean)
        {
            Caption = 'Taxable';
        }
        field(318; "Coefficient Increase"; Decimal)
        {
            Caption = 'Coefficient Increase';
        }
        field(319; "Calc. Chamber Fee"; Boolean)
        {
            Caption = 'Calc. Chamber Fee';
        }
        field(320; "Average Wage"; Decimal)
        {
            Caption = 'Average Wage';
        }
        field(321; Employees; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Header No." = FIELD("No."),
                                                          "Wage Calculation Type" = FILTER(Regular),
                                                          "Contribution Category Code" = FILTER(<> 'BDPIORS')));
            Caption = 'Employees';

        }
        field(322; "Brutto TS"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Calculation".Brutto WHERE("Wage Header No." = FIELD("No."),
                                                               "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Brutto';

        }
        field(323; "Net Wage TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Net Wage 2" WHERE("Wage Header No." = FIELD("No."),
                                                                     "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Net Wage';
            FieldClass = FlowField;
        }
        field(324; "Final Net Wage TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Final Net Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                         "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Final Net Wage';
            FieldClass = FlowField;
        }
        field(325; "Add. Tax From Brutto TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution From Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Additional Tax From Brutto';
            FieldClass = FlowField;
        }
        field(326; "Add. Tax Over Brutto TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution Over Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Additional Tax Over Brutto';
            FieldClass = FlowField;
        }
        field(327; "Tax TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Tax WHERE("Wage Header No." = FIELD("No."),
                                                            "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Tax';
            FieldClass = FlowField;
        }
        field(328; "Tax Basis TS"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Tax Basis" WHERE("Wage Header No." = FIELD("No."),
                                                                    "Wage Calculation Type" = FILTER('Temporary Service Contracts-Residents')));
            Caption = 'Tax Basis';
            FieldClass = FlowField;
        }
        field(329; "Brutto TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Brutto WHERE("Wage Header No." = FIELD("No."),
                                                               "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Brutto';
            FieldClass = FlowField;
        }
        field(330; "Net Wage TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Net Wage After Tax" WHERE("Wage Header No." = FIELD("No."),
                                                                             "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Net Wage';
            FieldClass = FlowField;
        }
        field(331; "Final Net Wage TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Final Net Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                         "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Final Net Wage';
            FieldClass = FlowField;
        }
        field(332; "Add. Tax From Brutto TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution From Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Additional Tax From Brutto';
            FieldClass = FlowField;
        }
        field(333; "Add. Tax Over Brutto TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution Over Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Additional Tax Over Brutto';
            FieldClass = FlowField;
        }
        field(334; "Tax TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Tax WHERE("Wage Header No." = FIELD("No."),
                                                            "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Tax';
            FieldClass = FlowField;
        }
        field(335; "Tax Basis TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Tax Basis" WHERE("Wage Header No." = FIELD("No."),
                                                                    "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Tax Basis';
            FieldClass = FlowField;
        }
        field(336; "Brutto TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Brutto WHERE("Wage Header No." = FIELD("No."),
                                                               "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Brutto';
            FieldClass = FlowField;
        }
        field(337; "Net Wage TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Net Wage 2" WHERE("Wage Header No." = FIELD("No."),
                                                                     "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Net Wage';
            FieldClass = FlowField;
        }
        field(338; "Final Net Wage TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Final Net Wage" WHERE("Wage Header No." = FIELD("No."),
                                                                         "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Final Net Wage';
            FieldClass = FlowField;
        }
        field(339; "Add. Tax From Brutto TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution From Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Additional Tax From Brutto';
            FieldClass = FlowField;
        }
        field(340; "Add. Tax Over Brutto TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Contribution Over Brutto" WHERE("Wage Header No." = FIELD("No."),
                                                                                   "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Additional Tax Over Brutto';
            FieldClass = FlowField;
        }
        field(341; "Tax TS AC"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation".Tax WHERE("Wage Header No." = FIELD("No."),
                                                            "Wage Calculation Type" = FILTER('Author Contracts')));
            Caption = 'Tax';
            FieldClass = FlowField;
        }
        field(342; "Tax Basis TS NR"; Decimal)
        {
            CalcFormula = Sum("Wage Calculation"."Tax Basis" WHERE("Wage Header No." = FIELD("No."),
                                                                    "Wage Calculation Type" = FILTER('Temporary Service Contracts-No Residents')));
            Caption = 'Tax Basis';
            FieldClass = FlowField;
        }
        field(343; "Payment Orders printed"; Boolean)
        {
            Caption = 'Payment Orders printed';
        }
        field(344; "Brutto Sum"; Decimal)
        {
            Caption = 'Brutto Sum';
            FieldClass = Normal;

            trigger OnValidate()
            begin
                //MODIFY;
                "Chamber Year" := "Year Of Wage" - 1;

                IF "Brutto Sum" = 0 THEN BEGIN
                    WH.SETRANGE("Year Of Wage", "Chamber Year");
                    IF WH.FINDFIRST THEN
                        REPEAT
                        BEGIN
                            WH.CALCFIELDS(Brutto);
                            "Brutto Sum" += WH.Brutto;
                        END;
                        UNTIL WH.NEXT = 0;
                    WS.GET();
                    "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                    MODIFY;
                END
                ELSE
                    IF "Brutto Sum" <> 0 THEN BEGIN
                        WS.GET();
                        "Chamber Amount" := ROUND((WS."Brutto Rate" * WS."Chamber Rate(%)" * "Brutto Sum") / 100, 0.001);
                        MODIFY;
                    END;
            end;
        }
        field(345; YearFilter; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(346; "Chamber Amount"; Decimal)
        {
            Caption = 'Chamber Amount';
            FieldClass = Normal;
        }
        field(347; "Chamber Year"; Integer)
        {
            Caption = 'ChamberYear';
            FieldClass = Normal;
        }
        field(348; "Average Wage - Chamber"; Decimal)
        {
            Caption = 'Average Wage - Chamber';
        }
        field(349; "Addition Sum"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Amount WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                            "Year of Wage" = FIELD("Year Of Wage")));

        }
        field(350; "Disabled Employees"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Wage Calculation" WHERE("Wage Header No." = FIELD("No."),
                                                          "Wage Calculation Type" = FILTER(Regular),
                                                          Invalid = FILTER(TRUE)));
            Caption = 'Disabled Employees';

        }
        field(351; "Payment Date (TS Residents)"; Date)
        {
            Caption = 'Payment Date (TS Residents)';
        }
        field(352; "Payment Date (TS No Residents)"; Date)
        {
            Caption = 'Payment Date (TS No Residents)';
        }
        field(353; "Payment Date (Author Contract)"; Date)
        {
            Caption = 'Payment Date (Author Contract)';
        }
        field(354; "Negative Payment"; Integer)
        {
            CalcFormula = Count("Wage Calculation Temp" WHERE(Payment = FILTER(< 0)));
            Caption = 'Negative Payment';
            FieldClass = FlowField;
        }
        field(355; "Payment UPP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Payment Order".Iznos WHERE("Wage Header No." = FIELD("No."),
                                                           "Wage Calculation Type" = FILTER(Regular),
                                                           Contributon = FILTER('PLACA')));

        }
        field(356; "Reduction UPP"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Payment Order".Iznos WHERE("Wage Header No." = FIELD("No."),
                                                           "Wage Calculation Type" = FILTER(Regular),
                                                           Contributon = FILTER('Obustava'),
                                                           SvrhaDoznake1 = FILTER('26*|28*')));

        }
        field(357; "Contribution UPP"; Decimal)
        {
            CalcFormula = Sum("Payment Order".Iznos WHERE("Wage Header No." = FIELD("No."),
                                                           "Wage Calculation Type" = FILTER(Additions),
                                                           VrstaPrihoda = FILTER(<> '')));
            FieldClass = FlowField;
        }
        field(358; "Payment WVE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Netto)" WHERE("Entry Type" = FILTER('Net Wage|Use|Work Experience|Taxable|Untaxable|Meal to pay|Transport')));

        }
        field(359; "Reduction WVE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Actual)" WHERE("Reduction No." = FILTER(<> '')));

        }
        field(360; "Contribution From WVE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Actual)" WHERE("AT From" = FILTER(TRUE)));

        }
        field(361; "Contribution Over WVE"; Decimal)
        {
            FieldClass = FlowField;

            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Actual)" WHERE("Contribution Type" = FILTER(<> ''),
                                                                               "AT From" = FILTER(FALSE),
                                                                               "AT From neto" = FILTER(FALSE)));

        }
        field(362; "Payment Brutto WVE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Brutto)" WHERE("Entry Type" = FILTER('Net Wage|Use|Work Experience|Taxable|Untaxable|Meal to pay|Transport')));

        }
        field(363; "Addition Netto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                                     "Year of Wage" = FIELD("Year Of Wage")));
            Caption = 'Addition Sum';

        }
        field(364; "Addition Brutto"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Brutto WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                            "Year of Wage" = FIELD("Year Of Wage")));
            Caption = 'Addition Sum';

        }
        field(365; "Addition Tax"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Tax WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                         "Year of Wage" = FIELD("Year Of Wage")));
            Caption = 'Addition Sum';

        }
        field(366; "Addition Contr. From"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Month of Wage" = FIELD("Month Of Wage"),
                                                                  "Year of Wage" = FIELD("Year Of Wage")));
            Caption = 'Addition Contribution From';

        }
        field(367; "Addition Contr. To"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                                "Year of Wage" = FIELD("Year Of Wage")));
            Caption = 'Addition Contr. To';

        }
        field(368; "Addition Netto Temp"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition"."Amount to Pay" WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                                     "Year of Wage" = FIELD("Year Of Wage"),
                                                                     "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Sum';

        }
        field(369; "Addition Brutto Temp"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Addition".Brutto WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                            "Year of Wage" = FIELD("Year Of Wage"),
                                                            "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Sum';

        }
        field(370; "Addition Tax Temp"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Tax WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                         "Year of Wage" = FIELD("Year Of Wage"),
                                                         "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Sum';
            FieldClass = FlowField;
        }
        field(371; "Addition Contr. From Temp"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total From" WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                                  "Year of Wage" = FIELD("Year Of Wage"),
                                                                  "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Contribution From';
            FieldClass = FlowField;
        }
        field(372; "Addition Contr. To Temp"; Decimal)
        {
            CalcFormula = Sum("Wage Addition"."Total On" WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                                "Year of Wage" = FIELD("Year Of Wage"),
                                                                "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Contr. To';
            FieldClass = FlowField;
        }
        field(373; "Addition Sum Temp"; Decimal)
        {
            CalcFormula = Sum("Wage Addition".Amount WHERE("Month of Wage" = FIELD("Month of Wage"),
                                                            "Year of Wage" = FIELD("Year Of Wage"),
                                                            "Closing Date" = FIELD("Closing Date")));
            Caption = 'Addition Sum';
            FieldClass = FlowField;
        }
        field(374; "Netto Taxable"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Netto)" WHERE("Entry Type" = FILTER('Net Wage|Taxable|Untaxable|Use|Work Experience|Transport|Meal to pay'),
                                                                              "Document No." = FIELD("No."),
                                                                              "Wage Calculation Type" = FILTER(Regular)));

        }
        field(375; Netto; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Actual)" WHERE("Entry Type" = FILTER('Net Wage|Taxable|Untaxable|Use|Work Experience|Transport|Meal to pay|Tax'),
                                                                               "Document No." = FIELD("No."),
                                                                               "Wage Calculation Type" = FILTER(Regular)));

        }
        field(376; "Tax TPE"; Decimal)
        {
            CalcFormula = Sum("Tax Per Employee".Amount WHERE("Wage Header No." = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(377; "Tax WVE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Netto)" WHERE("Entry Type" = FILTER(Tax),
                                                                              "Document No." = FIELD("No.")));

        }
        field(378; "Contribution UPP Additions"; Decimal)
        {
            CalcFormula = Sum("Payment Order".Iznos WHERE("Wage Header No." = FIELD("No."),
                                                           "Wage Calculation Type" = FILTER(Additions),
                                                           VrstaPrihoda = FILTER(<> '')));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.", "Entry No.")
        {
        }
        key(Key2; "Year Of Wage", "Month Of Wage")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Month Of Wage", "Year Of Wage", Description)
        {
        }
    }

    trigger OnDelete()
    begin
        Calc.RESET;
        Calc.SETFILTER("Wage Header No.", "No.");
        Calc.SETRANGE("Entry No.", "Entry No.");
        IF NOT Calc.ISEMPTY THEN
            Calc.DELETEALL(TRUE);
        CalcTemp.RESET;
        CalcTemp.SETFILTER("Wage Header No.", "No.");
        CalcTemp.SETRANGE("Entry No.", "Entry No.");
        IF NOT CalcTemp.ISEMPTY THEN
            CalcTemp.DELETEALL(TRUE);
        RedTemp.RESET;
        RedTemp.SETFILTER("Wage Header No.", "No.");
        IF NOT RedTemp.ISEMPTY THEN
            RedTemp.DELETEALL;
        RedReal.RESET;
        RedReal.SETFILTER("Wage Header No.", "No.");
        IF NOT RedReal.ISEMPTY THEN
            RedReal.DELETEALL;
        /*ATTax.RESET;
        ATTax.SETFILTER("Wage Header No.", "No.");
        ATTax.SETRANGE("Entry No.", "Entry No.");
        IF NOT ATTax.ISEMPTY THEN
          ATTax.DELETEALL;
        TaxEmp.RESET;
        TaxEmp.SETFILTER("Wage Header No.", "No.");
        TaxEmp.SETRANGE("Entry No.", "Entry No.");
        IF NOT TaxEmp.ISEMPTY THEN
          TaxEmp.DELETEALL;
        ATTaxTemp.RESET;
        ATTaxTemp.SETFILTER("Wage Header No.", "No.");
        ATTaxTemp.SETRANGE("Entry No.", "Entry No.");
        IF NOT ATTaxTemp.ISEMPTY THEN
          ATTaxTemp.DELETEALL;
        TaxEmpTemp.RESET;
        TaxEmpTemp.SETFILTER("Wage Header No.", "No.");
        TaxEmpTemp.SETRANGE("Entry No.", "Entry No.");
        IF NOT TaxEmpTemp.ISEMPTY THEN
          TaxEmpTemp.DELETEALL;*/

    end;

    var
        Calc: Record "Wage Calculation";
        CalcTemp: Record "Wage Calculation Temp";
        RedTemp: Record "Reduction per Wage Temp";
        RedReal: Record "Reduction per Wage";
        ATTax: Record "Contribution Per Employee";
        ATTaxTemp: Record "Contribution Per Employee Temp";
        TaxEmp: Record "Tax Per Employee";
        TaxEmpTemp: Record "Tax Per Employee Temp";
        Employee: Record "Employee";
        WS: Record "Wage Setup";
        WH: Record "Wage Header";
        HeaderDescriptionAddition: Text[250];
        HeaderDescription: Text[250];
        Txt012: Label 'Wage for';
        Txt013: Label 'Additions for';

    procedure Navigate()
    var
        NavigateForm: Page Navigate;
    begin
        NavigateForm.SetDoc("Posting Date", "No.");
        NavigateForm.RUN;
    end;
}

