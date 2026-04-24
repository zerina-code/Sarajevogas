page 50017 "Wage Header Card"
{
    Caption = 'Wage Header Card';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Wage Header";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Basic)
            {
                Caption = 'Basic';
                field("No."; "No.")
                {
                    ApplicationArea = all;
                }
                field("Year Of Wage"; "Year Of Wage")
                {
                    ApplicationArea = all;
                }
                field("Month Of Wage"; "Month Of Wage")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Wage Calculation Type"; "Wage Calculation Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                }
                field("Date Of Calculation"; "Date Of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Year of Calculation"; "Year of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Month of Calculation"; "Month of Calculation")
                {
                    ApplicationArea = all;
                }
                field("Average Wage"; "Average Wage")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WageSetup.GET;

                        //emp.SETFILTER("Contribution Category Code",'%1','FBiH' );
                        //emp.SETFILTER("For Calculation",'%1',TRUE );
                        //IF emp.FIND('-')THEN REPEAT

                        IF cpe1.FINDLAST THEN No := INCSTR(cpe1."Wage Calc No.");
                        cpe1.SETRANGE("Wage Header No.", xRec."No.");
                        cpe1.SETRANGE("Wage Calculation Type", 0);
                        IF cpe1.FIND('+')
                        THEN BEGIN
                            CALCFIELDS(Employees);
                            CALCFIELDS("Disabled Employees");


                            cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                            //cpe1.SETFILTER("Wage Calc No.",'%1',"No.");
                            cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Invalid Fund Contribution Code");
                            IF NOT cpe1.FINDFIRST THEN BEGIN
                                cpe1.INIT;
                                cpe1."Wage Header No." := xRec."No.";
                                cpe1."Wage Calc No." := No;
                                cpe1."Employee No." := '';
                                cpe1."Contribution Code" := WageSetup."Invalid Fund Contribution Code";
                                cpe1."Amount Over Wage" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                cpe1."Amount Over Neto" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                cpe1.Basis := "Average Wage";
                                WageSetup.GET;
                                cpe1."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Fund";
                                cpe1.INSERT;
                            END
                            ELSE BEGIN
                                cpe1.SETFILTER("Employee No.", '%1', '');
                                cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                                cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Invalid Fund Contribution Code");
                                IF cpe1.FIND('-') THEN BEGIN
                                    cpe1."Amount Over Wage" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                    cpe1."Amount Over Neto" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                    cpe1.Basis := "Average Wage";
                                    cpe1.MODIFY;
                                END;
                            END;
                        END;

                        wve2.SETFILTER("Document No.", '%1', xRec."No.");
                        wve2.SETFILTER("Contribution Type", '%1', WageSetup."Invalid Fund Contribution Code");
                        IF NOT wve2.FINDFIRST THEN BEGIN
                            IF wve.FINDLAST THEN ValueEntryNo := wve."Entry No." + 1;
                            wve.INIT;
                            wve."Entry No." := ValueEntryNo;
                            wve."Employee No." := '';
                            wve."Document No." := xRec."No.";
                            wve.Description := 'Doprinos za fond solidarnosti';
                            wve."Wage Posting Group" := 'FBiH';
                            wve."Wage Ledger Entry No." := WLE."Entry No.";
                            wve."User ID" := USERID;
                            wve."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Fund";
                            //WVE."Global Dimension 2 Code":=WLE."Global Dimension 2 Code";
                            //WVE."Shortcut Dimension 4 Code":=WLE."Shortcut Dimension 4 Code";
                            wve."Document Date" := TODAY;
                            wve."Posting Date" := af.GetMonthRange(xRec."Month Of Wage", xRec."Year Of Wage", FALSE);
                            ;
                            wve."Contribution Type" := WageSetup."Invalid Fund Contribution Code";
                            wve."Post Code" := emp."Post Code";
                            wve.Basis := xRec."Average Wage";
                            wve."Entry Type" := 3;
                            wve."Cost Amount (Actual)" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                            wve."Cost Posted to G/L" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                            wve.INSERT;
                        END
                        ELSE BEGIN
                            //wve.SETFILTER("Contribution Type",'%1',WageSetup."Invalid Fund Contribution Code");
                            wve.SETFILTER("Employee No.", '%1', '');
                            IF wve.FIND('-') THEN BEGIN
                                wve."Cost Amount (Actual)" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                wve."Cost Posted to G/L" := ("Average Wage" * WageSetup."Invaalid Fund %" / 100) * ((Employees DIV WageSetup."No. Of Employees") - "Disabled Employees");
                                wve.MODIFY;
                            END;
                        END;

                        // UNTIL emp.NEXT=0 ;
                    end;
                }
                field("Payment Date"; "Payment Date")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        WC.SETFILTER("Wage Calculation Type", '%1', 0);
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date" := "Payment Date";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
                field("Closing Date"; "Closing Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field(Timestamp_WH; Timestamp_WH)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Payment Orders printed"; "Payment Orders printed")
                {
                    ApplicationArea = all;
                    Style = Attention;
                    StyleExpr = TRUE;
                }
                field(Employees; Employees)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Brutto Sum"; "Brutto Sum")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WageSetup.GET;
                        "Average Wage - Chamber(triple)" := ((WageSetup."Chamber Rate(%)" / 100) * "Brutto Sum") * WageSetup."Brutto Rate";
                        "Average Wage - Chamber" := "Average Wage - Chamber(triple)" / 3;

                        IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                            "For payment - Chamber" := "Average Wage - Chamber"
                        ELSE
                            "For payment - Chamber" := "Average Wage - Chamber";
                        "Chamber Amount" := "Average Wage - Chamber";

                        //emp.SETFILTER("Contribution Category Code",'%1','FBiH' );
                        //emp.SETFILTER("For Calculation",'%1',TRUE );
                        //IF emp.FIND('-')THEN REPEAT

                        IF cpe1.FINDLAST THEN No := INCSTR(cpe."Wage Calc No.");
                        cpe.SETRANGE("Wage Header No.", xRec."No.");
                        cpe.SETRANGE("Wage Calculation Type", 0);
                        IF cpe.FIND('+')
                        THEN BEGIN
                            cpe1.SETFILTER("Wage Header No.", '%1', xRec."No.");
                            cpe1.SETFILTER("Wage Calc No.", '%1', "No.");
                            cpe1.SETFILTER("Contribution Code", '%1', WageSetup."Chamber Fee Contribution Code");
                            IF NOT cpe1.FINDFIRST THEN BEGIN
                                cpe1.INIT;
                                cpe1."Wage Header No." := xRec."No.";
                                cpe1."Wage Calc No." := No;
                                cpe1."Employee No." := '';
                                cpe1."Contribution Code" := WageSetup."Chamber Fee Contribution Code";
                                cpe1."Amount Over Wage" := "For payment - Chamber";
                                cpe1."Amount Over Neto" := "For payment - Chamber";
                                IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                    cpe1.Basis := Rec."Average Wage - Chamber"
                                ELSE
                                    cpe1.Basis := "Chamber Amount";
                                WageSetup.GET;
                                cpe1."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Chambe";
                                cpe1.INSERT;
                            END
                            ELSE BEGIN
                                cpe1.SETFILTER("Employee No.", '%1', '');
                                IF cpe1.FIND('-') THEN BEGIN
                                    cpe1."Amount Over Wage" := "For payment - Chamber";
                                    IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                        cpe1.Basis := Rec."Average Wage - Chamber"
                                    ELSE
                                        cpe1.Basis := "Chamber Amount";
                                    cpe1.MODIFY;
                                END;
                            END;
                        END;

                        wve2.SETFILTER("Document No.", '%1', xRec."No.");
                        wve2.SETFILTER("Contribution Type", '%1', WageSetup."Chamber Fee Contribution Code");
                        IF NOT wve2.FINDFIRST THEN BEGIN
                            IF wve.FINDLAST THEN ValueEntryNo := wve."Entry No." + 1;
                            wve.INIT;
                            wve."Entry No." := ValueEntryNo;
                            wve."Employee No." := '';
                            wve."Document No." := xRec."No.";
                            wve.Description := 'Doprinos za privrednu komoru';
                            wve."Wage Posting Group" := 'FBiH';
                            wve."Wage Ledger Entry No." := WLE."Entry No.";
                            wve."User ID" := USERID;
                            wve."Global Dimension 1 Code" := WageSetup."Global Dimension 1 Code Chambe";
                            //WVE."Global Dimension 2 Code":=WLE."Global Dimension 2 Code";
                            //WVE."Shortcut Dimension 4 Code":=WLE."Shortcut Dimension 4 Code";
                            wve."Document Date" := TODAY;
                            wve."Posting Date" := af.GetMonthRange(xRec."Month Of Wage", xRec."Year Of Wage", FALSE);
                            ;
                            wve."Contribution Type" := WageSetup."Chamber Fee Contribution Code";
                            wve."Post Code" := emp."Post Code";
                            IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                wve.Basis := Rec."Average Wage - Chamber"
                            ELSE
                                wve.Basis := "Chamber Amount";
                            wve."Entry Type" := 3;
                            wve."Cost Amount (Actual)" := "For payment - Chamber";
                            wve."Cost Posted to G/L" := "For payment - Chamber";
                            wve.INSERT;
                        END
                        ELSE BEGIN
                            //wve.SETFILTER("Contribution Type",'%1',WageSetup."Invalid Fund Contribution Code");
                            wve.SETFILTER("Employee No.", '%1', '');
                            IF wve.FIND('-') THEN BEGIN
                                wve."Cost Amount (Actual)" := "For payment - Chamber";
                                wve."Cost Posted to G/L" := "For payment - Chamber";
                                IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
                                    wve.Basis := Rec."Average Wage - Chamber"
                                ELSE
                                    wve.Basis := "Chamber Amount";
                                wve.MODIFY;
                            END;
                        END;

                        // UNTIL emp.NEXT=0 ;
                    end;
                }
            }
            group(Parameters)
            {
                Caption = 'Parameters';
                field("Hour Pool"; "Hour Pool")
                {
                    ApplicationArea = all;
                }
                field(Transportation; Transportation)
                {
                    ApplicationArea = all;
                }
                field(Reduction; Reduction)
                {
                    ApplicationArea = all;
                }
            }
            group(Chamber)
            {
                Caption = 'Chamber';
                field("Average Wage - Chamber"; "Average Wage - Chamber")
                {
                    ApplicationArea = all;
                }
                field("Average Wage - Chamber(triple)"; "Average Wage - Chamber(triple)")
                {
                    ApplicationArea = all;
                    Caption = 'Average Wage - Chamber(triple)';
                }
                field("Chamber Amount"; "Chamber Amount")
                {
                    ApplicationArea = all;
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field(Brutto; Brutto)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Net Wage"; "Net Wage")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto"; "Add. Tax From Brutto")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto"; "Add. Tax Over Brutto")
                {
                    ApplicationArea = all;
                }
                field("Wage Reduction"; "Wage Reduction")
                {
                    ApplicationArea = all;
                }
                field(Transport; Transport)
                {
                    ApplicationArea = all;
                }

                field("Sick Leave-Company"; "Sick Leave-Company")
                {
                    ApplicationArea = all;
                }
                field("Sick Leave-Fund"; "Sick Leave-Fund")
                {
                    ApplicationArea = all;
                }
                field("Untaxable Wage"; "Untaxable Wage")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis"; "Tax Basis")
                {
                    ApplicationArea = all;
                }
                field(Tax; Tax)
                {
                    ApplicationArea = all;
                }
                field(Payment; Payment)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
            group(Additions)
            {
                Caption = 'Additions';
                field("Addition Sum"; "Addition Sum")
                {
                    ApplicationArea = all;
                }
                field("Addition Netto"; "Addition Netto")
                {
                    ApplicationArea = all;
                }
                field("Addition Brutto"; "Addition Brutto")
                {
                    ApplicationArea = all;
                }
                field("Addition Tax"; "Addition Tax")
                {
                    ApplicationArea = all;
                }
                field("Addition Contr. From"; "Addition Contr. From")
                {
                    ApplicationArea = all;
                }
                field("Addition Contr. To"; "Addition Contr. To")
                {
                    ApplicationArea = all;
                }
            }
            group("Totals TS")
            {
                Caption = 'Totals for Temporary services';
                field("Brutto TS"; "Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS"; "Net Wage TS")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS"; "Add. Tax From Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS"; "Add. Tax Over Brutto TS")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS"; "Tax Basis TS")
                {
                    ApplicationArea = all;
                }
                field("Tax TS"; "Tax TS")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (TS Residents)"; "Payment Date (TS Residents)")
                {
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (TS Residents)" := "Payment Date (TS Residents)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
            group("Totals TS NR")
            {
                Caption = 'Totals for Temporary services Non Residents';
                field("Brutto TS NR"; "Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS NR"; "Net Wage TS NR")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS NR"; "Add. Tax From Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS NR"; "Add. Tax Over Brutto TS NR")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS NR"; "Tax Basis TS NR")
                {
                    ApplicationArea = all;
                }
                field("Tax TS NR"; "Tax TS NR")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (TS No Residents)"; "Payment Date (TS No Residents)")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (TS No Residents)" := "Payment Date (TS No Residents)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
            group("Totals TS AC")
            {
                Caption = 'Totals for Author Contracts';
                field("Brutto TS AC"; "Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Net Wage TS AC"; "Net Wage TS AC")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax From Brutto TS AC"; "Add. Tax From Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Add. Tax Over Brutto TS AC"; "Add. Tax Over Brutto TS AC")
                {
                    ApplicationArea = all;
                }
                field("Tax Basis TS AC"; "Tax Basis TS AC")
                {
                    ApplicationArea = all;
                }
                field("Tax TS AC"; "Tax TS AC")
                {
                    ApplicationArea = all;
                }
                field("Payment Date (Author Contract)"; "Payment Date (Author Contract)")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        WC.SETFILTER("Wage Header No.", '%1', "No.");
                        IF WC.FIND('-') THEN
                            REPEAT
                                WC."Payment Date (Author Contract)" := "Payment Date (Author Contract)";
                                WC.MODIFY;
                            UNTIL WC.NEXT = 0;
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Payment Orders1")
            {
                Caption = 'Payment Orders';
                Image = Payables;
                action("Priprema UPP naloga")
                {
                    //  Caption = 'Payment Order preparation';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            Municipality.SETFILTER(Code, '<>%1', '');
                            Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                            IF Municipality.FIND('-') THEN
                                REPEAT
                                    Municipality."For Calculation" := 0;
                                    Municipality."For Calculation 2" := 0;
                                    Municipality.MODIFY;
                                UNTIL Municipality.NEXT = 0;
                            //WithConfirm := CONFIRM(Txt005,FALSE);
                            CloseWageCalc.POrdersInitValue(Rec, WithConfirm);
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;
                    end;
                }
                action("Priprema UPP naloga - odvojeni obračun dodataka")
                {
                    Caption = 'Priprema UPP naloga - odvojeni obračun dodataka';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;


                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        CloseWageCalc.POrdersAdditionsInitValue(Rec, WithConfirm);


                        /*Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;

                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       //WithConfirm := CONFIRM(Txt005,FALSE);

                       CloseWageCalc.DoprinosiDodaci(Rec);

                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;
                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiDodaciBD(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiDodaciBDRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                          Municipality."For Calculation 3":=0;
                           Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                         Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DoprinosiRSFBIH(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;
                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.PoreziDodaciBDRS(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;

                       CloseWageCalc.DodaciPoBankama(Rec);
                       CloseWageCalc.PoreziDodaci(Rec);
                         Municipality.SETFILTER(Code,'<>%1','');
                         IF Municipality.FIND('-') THEN REPEAT
                         Municipality."For Calculation":=0;
                         Municipality."For Calculation 2":=0;
                         Municipality."For Calculation 3":=0;
                         Municipality."For Calculation 4":=0;
                         Municipality."For Calculation FA 3":=0;
                         Municipality."For Calculation 5":=0;
                         Municipality."For Calculation 6":=0;
                         Municipality."For Calculation 7":=0;
                         Municipality."For Calculation FA":=0;
                         Municipality."For Calculation 8":=0;
                         Municipality."For Calculation 9":=0;
                         Municipality."For Calculation 10":=0;
                         Municipality."For Calculation 11":=0;
                         Municipality."For Calculation 12":=0;
                         Municipality."For Calculation 13":=0;
                         Municipality.MODIFY;
                         UNTIL Municipality.NEXT=0;

                       Orgdijelovi.RESET;

                        IF Orgdijelovi.FINDFIRST THEN REPEAT
                       Orgdijelovi."For Calculation":=0;
                       Orgdijelovi."For Calculation 2":=0;
                       Orgdijelovi."For Calculation 3":=0;
                       Orgdijelovi."For Calculation 4":=0;
                       Orgdijelovi."For Calculation 5":=0;
                       Orgdijelovi."For Calculation 6":=0;
                       Orgdijelovi."For Calculation 7":=0;
                       Orgdijelovi."For Calculation FA":=0;
                       Orgdijelovi."For Calculation FA 2":=0;
                       Orgdijelovi."For Calculation FA 3":=0;
                       Orgdijelovi."For Calculation 8":=0;
                       Orgdijelovi."For Calculation 9":=0;
                       Orgdijelovi."For Calculation 10":=0;
                       Orgdijelovi."For Calculation 11":=0;
                       Orgdijelovi."For Calculation 12":=0;
                       Orgdijelovi."For Calculation 13":=0;
                       Orgdijelovi."For Calculation 14":=0;
                       Orgdijelovi."For Calculation 15":=0;
                       Orgdijelovi.MODIFY;
                        UNTIL Orgdijelovi.NEXT=0;
                       CloseWageCalc.PoreziDodaciRS(Rec);
                       CloseWageCalc.PoreziDodaciBD(Rec);*/


                    end;
                }
                action("Pregled UPP naloga")
                {
                    Caption = 'Payment Orders';
                    Image = Check;
                    RunObject = Page "Payment Orders";
                    ApplicationArea = all;
                }

                action("Priprema  UPP naloga - privremeni i povremeni ugovori")
                {
                    Caption = ' i povremeni ugovori';
                    Image = Payment;
                    Promoted = false;
                    ApplicationArea = all;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = false;

                    trigger OnAction()
                    var
                        WithConfirm: Boolean;
                    begin
                        CompanyInfo.get();
                        Municipality.SETFILTER(Code, '<>%1', '');
                        Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality."For Calculation 3" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;

                        WithConfirm := CONFIRM(Txt005, FALSE);


                        Municipality.SETFILTER(Code, '<>%1', '');
                        Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;


                        Municipality.SETFILTER(Code, '<>%1', '');
                        Municipality.SetFilter(type, '%1', Municipality.Type::Regular);
                        IF Municipality.FIND('-') THEN
                            REPEAT
                                Municipality."For Calculation" := 0;
                                Municipality."For Calculation 2" := 0;
                                Municipality."For Calculation 3" := 0;
                                Municipality.MODIFY;
                            UNTIL Municipality.NEXT = 0;


                        if CompanyInfo."Entity Code" <> 'RS' then begin
                            CloseWageCalc.UOD(Rec);
                            CloseWageCalc.DoprinosiTCAC(Rec);
                            CloseWageCalc.DoprinosiTC(Rec);
                            CloseWageCalc.DoprinosiTCNR(Rec);
                            CloseWageCalc.PoreziTC(Rec);
                            CloseWageCalc.PoreziTCNR(Rec);
                            CloseWageCalc.PoreziTCAC(Rec);
                        end
                        else begin


                            CloseWageCalc.UOD(Rec);
                            CloseWageCalc.DoprinosiTCACRS(Rec);
                            CloseWageCalc.DoprinosiTCRS(Rec);
                            CloseWageCalc.DoprinosiTCNR(Rec);
                            CloseWageCalc.PoreziTC(Rec);
                            CloseWageCalc.PoreziTCNR(Rec);
                            CloseWageCalc.PoreziTCAC(Rec);

                        end;
                        AddTaxPE.SETFILTER(Calculated, '%1', FALSE);
                        AddTaxPE.SETFILTER("Wage Calculation Type", '%1|%2|%3', 1, 2, 3);
                        IF AddTaxPE.FIND('-') THEN
                            REPEAT
                                AddTaxPE.Calculated := TRUE;
                                AddTaxPE.MODIFY;
                            UNTIL AddTaxPE.NEXT = 0;
                    end;
                }
                /*ĐK  action("Priprema virmana za eksterno bankatstvo")
                  {
                      //Hypo export
                      Caption = 'Priprema virmana za eksterno bankatstvo';
                      Image = Check;
                      RunObject = Report "Hypo export";
                      ApplicationArea = all;

                  }*/

            }




            action("Kreiraj nalog za knjiženje")

            {
                Caption = 'Tranfer calculation to Gen. Journal';
                Image = Post;
                Promoted = false;
                ApplicationArea = all;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = false;

                trigger OnAction()
                begin
                    IF Rec."Negative Payment" = 0 THEN BEGIN
                        IF CONFIRM(Txt003, FALSE, Rec.Description) THEN BEGIN
                            WLE.SETRANGE("Document No.", xRec."No.");
                            WLE.SETRANGE("Wage Header Entry No.", xRec."Entry No.");
                            Commit();
                            REPORT.RUNMODAL(REPORT::"Post Wage to GL", TRUE, TRUE, WLE);
                            Commit();
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Txt013);
                    END;
                end;

            }

            group("Create files1")
            {
                Caption = 'Create files';
                Image = Transactions;
                Visible = true;
                /*       action("Wage Posting")
                       {
                           Caption = 'Wage Posting';
                           Image = WageLines;
                           ApplicationArea = all;
                           trigger OnAction()
                           var
                               R_TS1: Report "TS_knjizenja 1";
                               WH: Record "Wage Header";
                               Calc: Record "Wage Calculation";
                               FileManagement: Codeunit "File Management";
                               filename: Text;
                           begin
                               IF Rec."Negative Payment" = 0 THEN BEGIN
                                   WH.RESET;
                                   WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                                   WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                                   IF NOT WH.FIND('-') THEN
                                       ERROR('Ne postoji obračun plata!')
                                   ELSE BEGIN


                                       CLEAR(R_TS1);
                                       CLEAR(FileManagement);
                                       WS.GET;
                                       PO.RESET;
                                       WH.CALCFIELDS("Payment UPP");
                                       filename := WS."Export Report Path" + FORMAT(WH."Payment UPP") + '~02~LD RBBH~' + FORMAT(WH."Date Of Calculation") + '.xls';
                                       R_TS1.SetParam(Rec."No.");
                                       PO.SetRange("Wage Header No.", Rec."No.");
                                       R_TS1.SAVEASEXCEL(filename);
                                       FileManagement.DownloadToFile(filename, filename);
                                       //FileManagement.DownloadToFile(filename, filename);


                                   END;
                               END
                               ELSE BEGIN
                                   ERROR(Txt013);
                               END;
                           end;
                       }*/
                /*   action("Wage Posting Additions")
                   {
                       Caption = 'Wage Posting';
                       Image = WageLines;
                       ApplicationArea = all;
                       trigger OnAction()
                       var
                           //ĐK      R_TS1: Report "TS_knjizenja 1";
                           WH: Record "Wage Header";
                           Calc: Record "Wage Calculation";
                           FileManagement: Codeunit "File Management";
                           filename: Text;
                       begin
                           IF Rec."Negative Payment" = 0 THEN BEGIN
                               WH.RESET;
                               WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                               WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                               IF NOT WH.FIND('-') THEN
                                   ERROR('Ne postoji obračun plata!')
                               ELSE BEGIN


                                   //ĐK     CLEAR(R_TSAdd);
                                   CLEAR(FileManagement);
                                   WS.GET;
                                   PO.RESET;
                                   WH.CALCFIELDS("Addition Netto");
                                   PaymentOrderNew.RESET;
                                   PaymentOrderNew.SETFILTER("Wage Calculation Type", '%1', PaymentOrderNew."Wage Calculation Type"::Additions);
                                   PaymentOrderNew.SETFILTER(Contributon, '%1', 'DODACI');
                                   PaymentOrderNew.SETFILTER("Wage Header No.", '%1', WH."No.");
                                   IF PaymentOrderNew.FINDFIRST THEN BEGIN
                                       PaymentOrderNew.CALCSUMS(Iznos);
                                       filename := WS."Export Report Path" + FORMAT(WH."Addition Netto") + '~02~LD RBBH~' + FORMAT(WH."Date Of Calculation") + '.xls';
                                       //R_TSAdd.SetParam(Rec."No.");
                                       // R_TSAdd.SAVEASEXCEL(filename);
                                       //     R_TSAdd.SetParam(Rec."No.");
                                       //ĐK   R_TSAdd.SAVEASEXCEL(filename);
                                       FileManagement.DownloadToFile(filename, filename);
                                       //  FileManagement.DownloadToFile(filename, filename);
                                   END;

                               END;
                           END
                           ELSE BEGIN
                               ERROR(Txt013);
                           END;
                       end;
                   }*/

                action("Export Payment Order")
                {
                    Caption = 'Export Payment Order';
                    Image = Reject;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        R_TS2: Report "Export Payment Order";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                        Newfilename: Text;
                        PO: Record "Payment Order";

                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN


                                CLEAR(R_TS2);
                                CLEAR(FileManagement);
                                WS.GET;

                                PO.RESET;
                                PO.Reset();
                                PO.SetFilter("Wage Header No.", '%1', WH."No.");
                                po.SetFilter("Wage Calculation Type", '%1', WH."Wage Calculation Type");

                                Report.RunModal(50100, true, false, po);
                                //ĐK


                                //     filename := WS."Export Report Path" + FORMAT('PLACA I OSTALA PRIMANJA' + delchr(format(WH."Payment Date"), '.') + ' - +' + 'Naziv Banke') + '.xls';
                                // R_TS2.SetParam(Rec."No.");
                                //R_TS2.Run();
                                //   R_TS2.SAVEASEXCEL(filename);
                                //  FileManagement.DownloadToFile(filename, filename);
                                // PO.SetRange("Wage Header No.", Rec."No.");
                                //REPORT.SAVEASEXCEL(50099, filename, PO);

                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;

                    end;
                }
                action("Reduction Posting")
                {
                    Caption = 'Reduction Posting';
                    Image = Reject;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        R_TS2: Report "TS_knjizenja 2";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                        Newfilename: Text;
                        TempBlob: Codeunit "Temp Blob";
                        OStream: OutStream;
                        Pocetak: Integer;
                        Kraj: Integer;
                        ReportParameter: Text;


                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN

                                TempBlob.CreateOutStream(OStream);
                                WH.RESET;
                                WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                                WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");
                                wh.FindFirst();
                                ReportParameter := Report.RunRequestPage(50030);

                                Report.SaveAs(50030, ReportParameter, ReportFormat::Excel, OStream);

                                //ĐK  Message(Report.RunRequestPage(50030));
                                Pocetak := StrPos(ReportParameter, 'Fields');
                                Kraj := StrPos(CopyStr(ReportParameter, Pocetak + strlen('WHERE(Fields1=1('), StrLen(ReportParameter)), ')');
                                if (Pocetak <> 0) and (Kraj > 0) then
                                    NazivBanke := CopyStr(ReportParameter, Pocetak, Kraj);


                                FileManagement.BLOBExport(TempBlob, 'PLACA I OSTALA PRIMANJA ' + delchr(FORMAT(wh."Payment Date", 0, '<day,2>.<month,2>.<year4>'), '.', '') + ' - ' + NazivBanke + '.xlsx', true);

                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;

                    end;
                }
                action("Contribution Posting")
                {
                    Caption = 'Export RBBH';
                    Image = Relationship;
                    ApplicationArea = all;


                    trigger OnAction()
                    var
                        ReportExport: Report "RBBH Export";

                    begin
                        //50102
                        ReportExport.SetParam(Rec."No.");
                        ReportExport.Run();


                    end;
                }
                action("Contribution Posting 2")
                {
                    Caption = 'Export RBBH 2';
                    Image = Relationship;
                    ApplicationArea = all;


                    trigger OnAction()
                    var
                        ReportExport: Report "RBBH report 2";

                    begin
                        //50102
                        ReportExport.SetParam(Rec."No.");
                        ReportExport.Run();


                    end;
                }
                action("Contribution Posting Add")
                {
                    Caption = 'Contribution Posting';
                    Image = Relationship;
                    ApplicationArea = all;
                    Visible = false;
                    trigger OnAction()
                    var
                        //ĐK     R_TS3: Report "TS_knjizenja 3";
                        WH: Record "Wage Header";
                        Calc: Record "Wage Calculation";
                        FileManagement: Codeunit "File Management";
                        filename: Text;
                    begin
                        IF Rec."Negative Payment" = 0 THEN BEGIN
                            WH.RESET;
                            WH.SETRANGE("Month Of Wage", Rec."Month Of Wage");
                            WH.SETRANGE("Year Of Wage", Rec."Year Of Wage");

                            IF NOT WH.FIND('-') THEN
                                ERROR('Ne postoji obračun plata!')
                            ELSE BEGIN


                                //                                CLEAR(R_TS3);
                                CLEAR(FileManagement);
                                WS.GET;
                                PO.RESET;
                                WH.CALCFIELDS("Contribution UPP Additions");
                                filename := WS."Export Report Path" + FORMAT(WH."Contribution UPP Additions") + '~01~DOPRINOSI LD~' + FORMAT(WH."Month Of Wage") + ' ' + FORMAT(WH."Year Of Wage") + '.xls';
                                /*     R_TS3.SetParam(Rec."No.", 2);
                                     R_TS3.SAVEASEXCEL(filename);*/
                                FileManagement.DownloadToFile(filename, filename);
                                //PO.SetRange("Wage Header No.", Rec."No.");
                                //PO.SETFILTER("Wage Calculation Type", '%1', PO."Wage Calculation Type"::Additions);
                                //REPORT.SAVEASEXCEL(50100, filename, PO);

                            END;
                        END
                        ELSE BEGIN
                            ERROR(Txt013);
                        END;
                    end;
                }

            }


            action("Zaključi obračun")
            {
                Image = Lock;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                var
                    DataItem1: Record "Wage Header";
                    WageHeader: Record "Wage Header";
                    Response: Boolean;
                    PaymentDate: Date;
                    E: Record Employee;
                    WA: Record "Wage Addition";
                    Txt001: Label 'This Calculation does not exists or its status is not "Closed"';
                    Txt003: Label 'Calculation was succesfully locked.';
                    Err01: Label 'You have to choose only one calculation!';
                    UTemp: Record "User Setup";
                    WageAllowed: Boolean;
                    error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
                begin
                    UTemp.SETFILTER("User ID", '%1', USERID);
                    IF UTemp.FINDFIRST THEN
                        WageAllowed := UTemp."Wage Allowed";

                    IF WageAllowed = FALSE THEN
                        ERROR(error1);
                    IF Rec."Negative Payment" = 0 THEN BEGIN
                        BEGIN
                            CurrPage.SETSELECTIONFILTER(wh);
                            WageHeader.RESET;

                            WageHeader.RESET;
                            WageHeader.COPYFILTERS(DataItem1);
                            WageHeader.SETRANGE(Status, WageHeader.Status::Open);

                            IF WageHeader.COUNT > 1 THEN ERROR(Err01);

                            IF NOT WageHeader.FIND('-') THEN
                                ERROR(Txt001);

                            WA.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                            WA.SETRANGE("Month of Wage", WageHeader."Month Of Wage");

                            WageHeader."Last Calculation In Month" := TRUE;
                            WageHeader."Payment Date" := PaymentDate;
                            WageHeader.Status := WageHeader.Status::Closed;
                            WageHeader.MODIFY;

                            IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN BEGIN
                                E.RESET;
                                E.SETRANGE("For Calculation", TRUE);

                                //WA.SETFILTER("Wage Addition Type",'<>%1',WA."Wage Addition Type"::"3");
                            END;

                            //ELSE
                            // WA.SETFILTER("Wage Addition Type",'%1',WA."Wage Addition Type"::"3");


                            WA.MODIFYALL(Locked, TRUE);
                            MESSAGE(Txt003);
                            //*ĐK  REPORT.RUNMODAL(REPORT::"Lock Calculation", FALSE, FALSE, wh);
                        END;
                    END
                    ELSE BEGIN
                        ERROR(Txt013);
                    END;
                end;
            }


            group(Delete1)
            {
                Caption = 'Delete';
                Image = Confirm;

                action("Otvori obračun")
                {
                    Caption = 'Open calculation';
                    Image = OpenWorksheet;
                    Promoted = false;
                    Visible = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        WageHeader: Record "Wage Header";
                        RedMain: Record "Reduction";
                        RedLine: Record "Reduction per Wage";
                        RedType: Record "Reduction Types";
                        TPE: Record "Tax Per Employee";
                        ATPE: Record "Contribution Per Employee";
                        WLE: Record "Wage Ledger Entry";
                        RPE: Record "Reduction per Wage";
                        WC: Record "Wage Calculation";
                        WVE: Record "Wage Value Entry";
                        TH: Record "Transport Header";
                        TL: Record "Transport Line";
                        MH: Record "Meal Header";
                        ML: Record "Meal Line";
                        WA: Record "Wage Addition";
                        Window: Dialog;
                        CurrRecNo: Integer;
                        TotalRecNo: Integer;
                        RedLockFlag: Boolean;
                        WageSetup: Record "Wage Setup";
                        WPClose: Codeunit "Wage Precalculation";
                        Txt003: Label 'Calculation was succesfully unlocked.';
                        Txt001: Label 'This calculation is not closed';
                        Err01: Label 'You have to choose only one calculation!';
                    begin

                        IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                            CurrPage.SETSELECTIONFILTER(wh);
                            //   REPORT.RUN(REPORT::"Reopen Calculation", FALSE, FALSE, wh);
                            //da ne trošim objekat, preslikala sam kod ovdje

                            WageHeader.RESET;

                            WageHeader.copyfilters(wh);
                            //WageHeader.SETRANGE("Last Calculation In Month", TRUE);

                            IF WageHeader.COUNT > 1 THEN ERROR(Err01);
                            IF WageHeader.FIND('+') THEN
                                IF WageHeader.Status <> WageHeader.Status::Open THEN
                                    ERROR(Txt001);

                            CurrRecNo := 0;
                            TotalRecNo := 12;

                            Window.OPEN('Otvaranje plata :' + '#1#' + ' od ' + FORMAT(TotalRecNo));
                            Window.UPDATE(1, 0);

                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            // Reduction!
                            IF WageHeader.Reduction THEN BEGIN

                                RedLine.SETFILTER("Wage Header No.", WageHeader."No.");
                                RedLine.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
                                RedLine.MODIFYALL(Locked, FALSE);

                                RedMain.RESET;
                                RedMain.RESET;
                                RedMain.SETRANGE(RedMain.Status, RedMain.Status::Zatvoren);
                                IF RedMain.FIND('-') THEN
                                    REPEAT
                                        RedLockFlag := TRUE;
                                        IF RedType.GET(RedMain.Type) THEN
                                            IF RedType.AmountWithoutLimit THEN
                                                RedLockFlag := FALSE;

                                        IF RedLockFlag THEN BEGIN
                                            RedMain.CALCFIELDS("No. of Installments paid", "Paid Amount");
                                            IF ((RedMain."No. of Installments" > 0) AND (RedMain."No. of Installments paid" < RedMain."No. of Installments")) OR
                                               ((RedMain."Reduction Amount" > 0) AND (RedMain."Paid Amount" < RedMain."Reduction Amount")) THEN BEGIN
                                                RedMain.Status := RedMain.Status::Otvoren;
                                                RedMain.MODIFY;
                                            END;
                                        END;
                                    UNTIL RedMain.NEXT = 0;
                                RedLine.DELETEALL(TRUE);
                            END;
                            WageSetup.GET;


                            // Brisanja!
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            TPE.SETFILTER("Wage Header No.", WageHeader."No.");
                            TPE.SETRANGE("Entry No.", WageHeader."Entry No.");

                            ATPE.SETFILTER("Wage Header No.", WageHeader."No.");
                            ATPE.SETRANGE("Entry No.", WageHeader."Entry No.");

                            RPE.SETFILTER("Wage Header No.", WageHeader."No.");
                            RPE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                            WC.SETFILTER("Wage Header No.", WageHeader."No.");
                            WC.SETRANGE("Entry No.", WageHeader."Entry No.");

                            IF WageHeader.Transportation THEN BEGIN
                                TH.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                                TH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                                TH.FIND('-');
                                TL.SETRANGE("Document No.", TH."No.");
                            END;

                            IF WageHeader.Meal THEN BEGIN
                                MH.SETRANGE("Year Of Wage", WageHeader."Year Of Wage");
                                MH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
                                MH.FIND('-');
                                ML.SETRANGE("Document No.", MH."No.");
                            END;

                            WA.SETRANGE("Wage Header No.", WageHeader."No.");
                            WA.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            TPE.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            ATPE.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            RPE.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            WC.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            IF WageHeader.Transportation THEN
                                TL.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            IF WageHeader.Transportation THEN
                                TL.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            IF WageHeader.Meal THEN
                                ML.DELETEALL(TRUE);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            WA.MODIFYALL("Calculated Amount", 0);
                            WA.MODIFYALL("Wage Header No.", '');
                            WA.MODIFYALL("Wage Header Entry No.", 0);
                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);


                            WVE.SETFILTER("Document No.", WageHeader."No.");
                            WVE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");

                            IF WVE.FIND('-') THEN
                                REPEAT
                                    WLE.GET(WVE."Wage Ledger Entry No.");
                                    WLE.MARK(TRUE);
                                UNTIL WVE.NEXT = 0;

                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            WLE.MARKEDONLY(TRUE);
                            WLE.DELETEALL(TRUE);

                            WageHeader.Status := WageHeader.Status::Closed;
                            WageHeader.MODIFY;

                            CurrRecNo += 1;
                            Window.UPDATE(1, CurrRecNo);

                            Window.CLOSE;

                            MESSAGE(Txt003);
                        end;

                    END;

                }
                action("Obriši obračun")
                {
                    Caption = 'Delete wage calculation';
                    Image = Delete;
                    Promoted = false;
                    ApplicationArea = all;

                    trigger OnAction()
                    var
                        GL: Record "G/L entry";
                        Wh: Record "Wage Header";
                        UserSet: Record "User Setup";
                    begin
                        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::Normal THEN BEGIN
                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    UserSet.reset;
                                    UserSet.setfilter("User ID", '%1', UserId);
                                    UserSet.SetFilter("Delete Wage", '%1', true);
                                    if not UserSet.FindFirst() then begin

                                        GL.Reset();
                                        GL.SetFilter("Document No.", '%1', 'PLATE ' + format(Rec."Payment Date"));
                                        if GL.FindFirst() then
                                            Error('Ne možete obrisati obračun koji je već proknjižen!');

                                        REPORT.RUN(REPORT::"Delete Calculation", FALSE, FALSE, wh);

                                    end
                                    else begin
                                        REPORT.RUN(REPORT::"Delete Calculation", FALSE, FALSE, wh);

                                    end;
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('Za brisanje dodataka, koristite opciju Obriši obračun dodataka');
                        END;
                    end;
                }
                action("Obriši obračun dodataka")
                {
                    Caption = 'Delete wage calculation';
                    Image = DeleteExpiredComponents;
                    Promoted = false;
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        WHC: Page "Wage Header Card";
                    begin
                        IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::"Fixed Add" THEN BEGIN
                            IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                    CurrPage.SETSELECTIONFILTER(wh);
                                    //ĐK   REPORT.RUN(REPORT::"Delete Additions", FALSE, FALSE, wh);
                                    //u proceduri brisanje je true za dodatke, a false za privremene ugovore
                                    WHC.Brisanje(Rec."No.", true, Rec."Payment Date"); //ED
                                END;
                            END;
                        END ELSE BEGIN
                            MESSAGE('Za brisanje dodataka, koristite opciju Obriši redovni obračun');
                        END;
                    end;
                }

                /*   action("Obriši obračun privremenih ugovora")
                   {
                       Caption = 'Delete wage calculation';
                       Image = DeleteExpiredComponents;
                       Promoted = false;
                       ApplicationArea = all;
                       trigger OnAction()
                       begin
                           IF Rec."Wage Calculation Type" = Rec."Wage Calculation Type"::"Fixed Add" THEN BEGIN
                               IF CONFIRM(Txt002, FALSE, Rec.Description) THEN BEGIN
                                   IF CONFIRM(Txt012, FALSE, Rec.Description) THEN BEGIN
                                       CurrPage.SETSELECTIONFILTER(wh);
                                       //ĐK       REPORT.RUN(REPORT::"Delete Additions", FALSE, FALSE, wh);
                                   END;
                               END;
                           END ELSE BEGIN
                               MESSAGE('Za brisanje dodataka, koristite opciju Obriši redovni obračun');
                           END;
                       end;
                   }*/



            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        //MODIFY;
        /*CurrPage.Brutto.UPDATE;
        CurrPage."Net Wage".UPDATE;
        CurrPage."Final Net Wage".UPDATE;
        CurrPage."Add. Tax From Brutto".UPDATE;
        CurrPage."Add. Tax Over Brutto".UPDATE;
        CurrPage.Tax.UPDATE;
        CurrPage."Tax Basis".UPDATE;
        //CurrPage."Added Tax Per City".UPDATE;
        CurrPage."Wage Reduction".UPDATE;
        CurrPage.Transport.UPDATE;
        CurrPage."Sick Leave-Company".UPDATE;
        CurrPage."Sick Leave-Fund".UPDATE;*/
        "Average Wage - Chamber(triple)" := 3 * "Average Wage - Chamber";

        IF "Average Wage - Chamber(triple)" <= "Chamber Amount" THEN
            "For payment - Chamber" := "Average Wage - Chamber(triple)"
        ELSE
            "For payment - Chamber" := "Chamber Amount";

    end;

    trigger OnInit()
    begin
        WS.GET();
    end;

    Procedure Brisanje(WageHeaderCode: code[20]; Additions: Boolean; PaymentDelete: Date)
    var
        WageHeader: Record "Wage Header";
        WaSetup: Record "Wage Setup";
        Txt003: Label 'Calculation was succesfully deleted';
        Txt001: Label 'This calculation is not closed';
        Err01: Label 'You have to choose only one calculation!';
        CurrRecNo: Integer;
        TotalRecNo: Integer;
        RedLine: Record "Reduction per Wage";
        TPE: Record "Tax Per Employee";
        WLE: Record "Wage Ledger Entry";
        WVE: Record "Wage Value Entry";
        ML: Record "Meal Header";
        WA: Record "Wage Addition";
        WC: Record "Wage Calculation";
        RPE: Record "Reduction per Wage";
        ATPE: Record "Contribution Per Employee";
        TH: Record "Transport Header";
        TL: Record "Transport Line";
        Window: Dialog;
        mh: Record "Meal Header";
        WH: Record "Wage Header";
        tpe2: Record "Tax Per Employee";
        AbsenceFill: Codeunit "Absence Fill";
        PaymentOrder: Record "Payment Order";
        StartDate: Date;
        EndDate: Date;
        EA: Record "Employee Absence";
        EMP: Record Employee;
        WageCalc: Record "Wage Calculation";
    begin

        WageHeader.reset;
        WageHeader.setfilter("No.", '%1', WageHeaderCode);
        if Additions = true then begin
            WageHeader.setfilter("Wage Calculation Type", '%1', WageHeader."Wage Calculation Type"::"Fixed Add");

        end;
        if WageHeader.findfirst then begin

            TPE.reset;
            TPE.SETFILTER("Wage Header No.", WageHeader."No.");

            if Additions = true then //dodaci
                tpe.SetFilter("Wage Calculation Type", '%1', tpe."Wage Calculation Type"::Additions)
            else
                if Additions = false then //privremeni ugovori
                    tpe.SetFilter("Wage Calculation Type", '%1|%2|%3', tpe."Wage Calculation Type"::"Author Contracts", tpe."Wage Calculation Type"::"Temporary Service Contracts-Residents", tpe."Wage Calculation Type"::"Temporary Service Contracts-No Residents");
            tpe.SetFilter("Payment date", '%1', PaymentDelete);
            IF TPE.FINDFIRST THEN
                TPE.DELETEALL;


            PaymentOrder.Reset();
            PaymentOrder.SetFilter("Wage Header No.", '%1', WageHeader."No.");
            PaymentOrder.SetFilter(DatumUplate, '%1', PaymentDelete);
            if Additions = true then
                PaymentOrder.SetFilter("Wage Calculation Type", '%1', PaymentOrder."Wage Calculation Type"::Additions)
            else
                PaymentOrder.SetFilter("Wage Calculation Type", '%1|%2|%3', PaymentOrder."Wage Calculation Type"::"Author Contracts", PaymentOrder."Wage Calculation Type"::"Temporary Service Contracts-Residents", PaymentOrder."Wage Calculation Type"::"Temporary Service Contracts-No Residents");
            PaymentOrder.DeleteAll();
            ATPE.SETFILTER("Wage Header No.", WageHeader."No.");
            ATPE.SETRANGE("Entry No.", WageHeader."Entry No.");

            ATPE.setfilter("Payment Date", '%1', PaymentDelete);
            IF ATPE.FINDFIRST THEN
                ATPE.DELETEALL;

            /*   RPE.SETFILTER("Wage Header No.", WageHeader."No.");
               RPE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
               IF RPE.FINDFIRST THEN
                   RPE.DELETEALL;*/

            WC.SETFILTER("Wage Header No.", WageHeader."No.");
            WC.SETRANGE("Entry No.", WageHeader."Entry No.");
            wc.SetFilter("Wage Calculation Type", '<>%1', wc."Wage Calculation Type"::Regular);

            IF WC.FINDFIRST THEN
                WC.DELETEALL;
            /* TH.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
             TH.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
             IF TH.FIND('-') THEN
                 TL.SETRANGE("Document No.", TH."No.");
             IF TL.FINDFIRST THEN
                 TL.DELETEALL;

             mh.SETRANGE("Year Of Wage", WageHeader."Year Of Wage");
             mh.SETRANGE("Month Of Wage", WageHeader."Month Of Wage");
             IF mh.FIND('-') THEN
                 mh.DELETEALL;
             // ML.SETRANGE("Document No.",MH."No.");*/



            WA.Reset();
            //  WA.SETRANGE("Wage Header No.", WageHeader."No.");
            WA.SetFilter("Month of Wage", '%1', WageHeader."Month Of Wage");
            WA.SetFilter("Year of Wage", '%1', WageHeader."Year Of Wage");
            //    wa.SetFilter("Wage Header Entry No.",'%1',WageHeader.en);
            //ĐK  WA.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
            WA.setfilter("Closing Date", '%1', PaymentDelete);

            IF WA.FindSet() then
                repeat
                    WaSetup.Get();
                    if (WA."Wage Addition Type" = WaSetup."Meal Code FBIH") or
                    (WA."Wage Addition Type" = WaSetup."Meal Code FBiH Taxable") then begin
                        WA.Delete();
                    end
                    else begin



                        if WA.Locked = true then
                            WA.Locked := false;
                        if WA.Calculated = true then
                            WA.Calculated := false;

                        wa."Wage Header No." := '';
                        WA.Modify();
                    end;

                until WA.Next() = 0;

            CurrRecNo += 1;
            WH.SETFILTER("No.", WageHeader."No.");


            //WageHeader.SETRANGE("Entry No.",WageHeader."Entry No.");


            /* TPE.DELETEALL(TRUE);

             ATPE.DELETEALL(TRUE);

             RPE.DELETEALL(TRUE);

             WC.DELETEALL(TRUE);
             WH.DELETEALL(TRUE);*/
            /*  TL.Reset();
              TL.setfilter("Document No.", '%1', WageHeader."No.");
              IF WageHeader.Transportation THEN
                  TL.DELETEALL(TRUE);*/

            CurrRecNo += 1;

            // TH.DELETEALL;

            /* ML.Reset();
             ML.SetFilter("Month Of Wage", '%1', WageHeader."Month of Wage");
             ML.SetFilter("Year Of Wage", '%1', WageHeader."Year of Wage");
             IF WageHeader.Meal THEN
                 ML.DELETEALL(TRUE);*/
            CurrRecNo += 1;

            WA.Reset();
            WA.SetFilter("Month of Wage", '%1', WageHeader."Month of Wage");
            WA.SetFilter("Year of Wage", '%1', WageHeader."Year of Wage");
            WA.setfilter("Payment Date", '%1', PaymentDelete);
            IF WA.FIND('-') THEN begin


                WA.MODIFYALL("Calculated Amount", 0);
                WA.MODIFYALL("Wage Header No.", '');
                WA.MODIFYALL("Wage Header Entry No.", 0);
            end;

            CurrRecNo += 1;
            /* WLE.Reset();
             WLE.SETFILTER("Document No.", WageHeader."No.");
             //WLE.SETRANGE("Wage Header Entry No.",WageHeader."Entry No.");
             IF WLE.FINDFIRST THEN
                 WLE.DELETEALL(TRUE);*/

            wve.Reset();
            WVE.SETFILTER("Document No.", WageHeader."No.");
            WVE.SetFilter("Document Date", '%1', PaymentDelete);
            //  if Additions = true then
            // WVE.SETRANGE("Wage Header Entry No.", WageHeader."Entry No.");
            //       wve.SetFilter("Wage Calculation Type", '%1', wve."Wage Calculation Type"::Additions)
            //else
            //    WVE.SetFilter("Wage Calculation Type", '%1|%2|%3', WVE."Wage Calculation Type"::"Author Contracts", WVE."Wage Calculation Type"::"Temporary Service Contracts-Residents", WVE."Wage Calculation Type"::"Temporary Service Contracts-No Residents");

            IF WVE.FINDFIRST THEN
                WVE.DELETEALL(TRUE);



            CurrRecNo += 1;


            //   WLE.MARKEDONLY(TRUE);
            WLE.reset;
            WLE.setfilter("Document No.", WageHeader."No.");
            WLE.SetFilter("Document Date", '%1', PaymentDelete);
            //   if Additions = true then
            //  WLE.SetFilter("Wage Calculation Type", '%1', WLE."Wage Calculation Type"::Additions)
            //  else
            // WLE.SetFilter("Wage Calculation Type", '%1|%2|%3', WLE."Wage Calculation Type"::"Author Contracts", WLE."Wage Calculation Type"::"Temporary Service Contracts-Residents", WLE."Wage Calculation Type"::"Temporary Service Contracts-No Residents");

            IF WLE.FINDFIRST THEN
                WLE.DELETEALL(TRUE);
            Commit();

            WageCalc.Reset();
            WageCalc.SetFilter("No.", '%1', WageHeaderCode);
            if not WageCalc.findfirst then begin
                wve.Reset();
                WVE.SETFILTER("Document No.", WageHeader."No.");
                wve.SetFilter("Posting Date", '<>%1', PaymentDelete);
                if not wve.FindFirst() then
                    WageHeader.delete;

            end;
        end;

    end;

    var
        Orgdijelovi: Record "ORG Dijelovi";

        NazivBanke: Text;
        TempFile: File;
        //  R_SetGLE: Report "Prenos nalog_knjiženja";
        Name: Text;
        Newstream: InStream;
        WageAm: Record "Wage Amounts";
        ToFile: Text;
        ReturnValue: Boolean;
        Department: Record "Department";
        EmpDefDim: Record "Employee Default Dimension";
        OrgD: Record "ORG Dijelovi";
        PaymentOrder: Record "Payment Order";
        WA: Record "Wage Addition";
        No: Code[10];
        PaymentOrderNew: Record "Payment Order";
        Correct: Decimal;
        wh: Record "Wage Header";
        WLE: Record "Wage Ledger Entry";
        WC: Record "Wage Calculation";
        Txt001: Label 'Do you want to close calculation %1?';
        Txt002: Label 'Do you want to delete calculatio %1? Note that deleting calculation does not reverse posting!';
        Txt003: Label 'Do you want to tranfer calculation %1 to Gen. Journal?';
        CloseWageCalc: Codeunit "Close Wage Calculation";
        // R_TSAdd: Report "TS_knjizenja dodaci";
        CCC: Record "Contribution Category Conn.";
        zaglavlje: Code[30];
        cpe: Record "Contribution Per Employee";
        prosjek: Decimal;
        dialbox: Dialog;
        Txt004: Label 'Enter average wage.';
        wve: Record "Wage Value Entry";
        Txt005: Label 'Do you want to review each payment order separately?';
        cpe1: Record "Contribution Per Employee";
        emp: Record "Employee";
        ValueEntryNo: Integer;
        af: Codeunit "Absence Fill";
        Municipality: Record "Municipality";
        Response: Boolean;
        //ĐK  Recapitulation: Record "Recapitulation";
        // IntegrationTable: Record "Integration";
        Contribution: Record "Contribution";
        Txt006: Label 'Are you sure you want to transfer data?';
        Txt007: Label 'Data transffered.';
        WS: Record "Wage Setup";
        "Average Wage - Chamber(triple)": Decimal;
        "For payment - Chamber": Decimal;
        SickHourPool: Integer;
        Employee: Record "Employee";
        canton: Record "Canton";
        ConCat: Record "Contribution Category";
        CompanyInfo: Record "Company Information";
        WPConnSetup: Record "Web portal connection setup";
        /* conn: Automation;
         comm: Automation;
         param: Automation;
         lvarActiveConnection: Variant;*/
        WPConnSetupOB: Record "Web portal connection setup";
        /*connOB: Automation;
        commOB: Automation;
        paramOB: Automation;
        lvarActiveConnectionOB: Variant;*/
        WPConnSetupPL: Record "Web portal connection setup";
        /*connPL: Automation;
        commPL: Automation;
        paramPL: Automation;
        lvarActiveConnectionPL: Variant;*/
        EA: Record "Employee Absence";
        COA: Record "Cause of Absence";
        WageSetup: Record "Wage Setup";
        WPConnSetupRAS: Record "Web portal connection setup";
        /* connRAS: Automation;
         commRAS: Automation;
         paramRAS: Automation;
         lvarActiveConnectionRAS: Variant;*/
        cpe9: Record "Contribution Per Employee";
        cpe2: Record "Contribution Per Employee";
        cpe3: Record "Contribution Per Employee";
        cpe4: Record "Contribution Per Employee";
        cpe5: Record "Contribution Per Employee";
        cpe10: Record "Contribution Per Employee";
        cpe6: Record "Contribution Per Employee";
        cpe7: Record "Contribution Per Employee";
        cpe8: Record "Contribution Per Employee";
        Txt008: Label 'Accounting period opened!';
        Txt009: Label 'Calculation transfered succesfully!';
        Txt010: Label 'Calculation transfered succesfully!';
        Txt011: Label 'Calculation transfered succesfully!';
        wve2: Record "Wage Value Entry";
        AddTaxPE: Record "Contribution Per Employee";
        Txt012: Label 'Do you want to delete calculatio %1? Note that deleting calculation does not reverse posting!';
        ReportName: Text;
        FileVar: File;
        IStream: InStream;
        MagicPath: Text;
        //FileSystemObject: Automation;
        DestinationFileName: Text;
        Txt013: Label 'Postoje obračuni sa negativnom isplatom.';
        PO: Record "Payment Order";

    procedure Replacestring(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;

    procedure SetParam(NazivB: Code[20])

    begin


        nazivBanke := NazivB;

    end;

}

