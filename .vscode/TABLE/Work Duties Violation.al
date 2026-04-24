/*table 50205 "Work Duties Violation"
{
    //  EC, 23.01.2016, Customization
    // On validation of Employee No., Employee Name is filled in automatically.
    // On validation of Violation Type, Violation Description is filled in automatically.

    Caption = 'Work Duties Violation';
    //  DrillDownPageID = "Employee Disciplinary Measures";
    // LookupPageID = "Employee Disciplinary Measures";

    fields
    {
        field(1; "No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'No.';
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = IF ("Update Org jed" = FILTER(false)) Employee."No.";

            trigger OnValidate()
            begin

                IF "Update Org jed" = FALSE THEN BEGIN
                    emp.SETFILTER("No.", '%1', Rec."Employee No.");
                    IF emp.FINDFIRST THEN BEGIN
                        "First Name" := emp."First Name" + ' ' + emp."Last Name";
                        "Internal ID" := emp."Internal ID";
                        emp.CALCFIELDS("Employee User Name");

                        "Employee User Name" := emp."Employee User Name";
                        //ĐK "Worker Activity Category" := emp.Status;
                    END
                    ELSE BEGIN
                        ERROR('Uključite polje "Ažuriraj historijske podatke" ukoliko želite dodati podatke za novog radnika.');

                    END;
                    Active := TRUE;
                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        EmployeeContractLedger.CALCFIELDS("Residence/Network", "Manager 1");
                        "Sector Name" := EmployeeContractLedger."Sector Description";
                        //"Contract Type":=EmployeeContractLedger.Description;
                        //"Type Of Agreement":=EmployeeContractLedger."Cert and solu name";
                           SegmentationGroup.RESET;
                           SegmentationGroup.SETFILTER("Position No.", '%1', EmployeeContractLedger."Position Code");
                           SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                           SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                           SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                           IF SegmentationGroup.FIND('+') THEN
                               "Management Level" := FORMAT(SegmentationGroup."Management Level");
   

                        "Position Code" := EmployeeContractLedger."Position Code";
                        "Position Description" := EmployeeContractLedger."Position Description";

                    END;

                END ELSE BEGIN
                    emp.SETFILTER("No.", '%1', Rec."Employee No.");
                    IF emp.FINDFIRST THEN BEGIN
                        ERROR('Uključite polje "Ažuriraj historijske podatke" ukoliko želite dodati novi personalni broj.');
                        "Employee No." := '';
                    END;
                END;
            end;
        }
        field(3; "Internal ID"; Integer)
        {
            Caption = 'Internal ID';
            TableRelation = IF ("Update Org jed" = FILTER(false)) Employee."Internal ID";
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                IF "Update Org jed" = FALSE THEN BEGIN
                    emp.SETFILTER("Internal ID", '%1', Rec."Internal ID");
                    IF emp.FINDFIRST THEN BEGIN
                        "First Name" := emp."First Name" + ' ' + emp."Last Name";

                        "Employee No." := emp."No.";
                        emp.CALCFIELDS("Employee User Name");

                        "Employee User Name" := emp."Employee User Name";
                        //ĐK  "Worker Activity Category" := emp.Status;
                    END
                    ELSE BEGIN
                        ERROR('Uključite polje "Ažuriraj historijske podatke" ukoliko želite dodati novi personalni broj.');
                    END;

                    Active := TRUE;
                    EmployeeContractLedger.RESET;
                    EmployeeContractLedger.SETFILTER("Employee No.", "Employee No.");
                    EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
                    IF EmployeeContractLedger.FINDLAST THEN BEGIN
                        EmployeeContractLedger.CALCFIELDS("Residence/Network", "Manager 1");
                        "Sector Name" := EmployeeContractLedger."Sector Description";
                        //"Contract Type":=EmployeeContractLedger."Contract Type Name";
                        //"Type Of Agreement":=EmployeeContractLedger."Cert and solu name";
                        "Department Name" := EmployeeContractLedger."Department Name";
                        "Group Description" := EmployeeContractLedger."Group Description";
                           SegmentationGroup.RESET;
                           SegmentationGroup.SETFILTER("Position No.", '%1', EmployeeContractLedger."Position Code");
                           SegmentationGroup.SETFILTER("Segmentation Name", '%1', EmployeeContractLedger."Position Description");
                           SegmentationGroup.SETFILTER(Coefficient, '<>%1', 0);
                           SegmentationGroup.SETFILTER("Ending Date", '%1', 0D);
                           IF SegmentationGroup.FIND('+') THEN
                               "Management Level" := FORMAT(SegmentationGroup."Management Level");


                        "Position Code" := EmployeeContractLedger."Position Code";
                        "Position Description" := EmployeeContractLedger."Position Description";
                    END;
                END ELSE BEGIN
                    emp.SETFILTER("Internal ID", '%1', Rec."Internal ID");
                    IF emp.FINDFIRST THEN BEGIN
                        ERROR('Uključite polje "Ažuriraj historijske podatke" ukoliko želite dodati novi personalni broj.');
                        "Internal ID" := 0;
                    END;
                END;
            end;
        }
        field(4; "First Name"; Text[100])
        {
            Caption = 'First Name';
        }
        field(7; "Employee User Name"; Code[50])
        {
            Caption = 'Employee User Name';
            Editable = false;
            FieldClass = Normal;
        }
        field(9; "Expiry Date"; Date)
        {
            Caption = 'Expiry Date';
        }
        field(13; "Contract Type"; Option)
        {
            Caption = 'Contract Type';
            OptionCaption = 'Old clause,New clause';
            OptionMembers = "Old clause","New clause";
        }
        field(14; Accused; Option)
        {
            Caption = 'Accused';
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",NE,DA;
        }
        field(15; "Date Of Booking Of Receivable"; Date)
        {
            Caption = 'Date Of Booking Of Receivable';
        }
        field(16; "Amount Of Pay. Per Clause"; Decimal)
        {
            Caption = 'Amount Of Pay. Per Clause';

            trigger OnValidate()
            begin
                "Outstanding Amount" := "Amount Of Pay. Per Clause" - "Amount Of a Booking Receivable";
            end;
        }
        field(17; "Outstanding Amount"; Decimal)
        {
            Caption = 'Outstanding Amount';
            Editable = false;
        }
        field(18; "Payments by Clasue"; Decimal)
        {
            Caption = 'Payments by Clause';
        }
        field(19; "Date Of Payments by Clause"; Date)
        {
            Caption = 'Date Of Payments by Clause';
        }
        field(20; "Date Sent Notice 1"; Date)
        {
            Caption = 'Date Sent Notice 1';
        }
        field(21; "Date Sent Notice 2"; Date)
        {
            Caption = 'Date Sent Notice 2';
        }
        field(22; "Date Sue"; Date)
        {
            Caption = 'Date Sue';
        }
               field(23; "Description Subject"; Text[50])
               {
                   Caption = 'Description Of The Subject';
                   TableRelation = "Description Subject"."Description Subject";
               }*/
/*    field(24; "Status Of The Case"; Text[60])
    {
        Caption = 'Status Of The Case in Court';
        TableRelation = "Status Of The Case"."Status Of The Case";
    }
field(27; "Employed At"; Text[100])
{
    Caption = 'Employed At';
    TableRelation = "Work at"."Place Of Employment";
}
field(28; "Cross Clause"; Option)
{
    Caption = 'Cross Clause';
    OptionCaption = ' ,No,Yes';
    OptionMembers = " ",NE,DA;
}
field(29; Notice; Integer)
{
    FieldClass = FlowField;
    CalcFormula = Count("Notes/Comments" WHERE("Type" = FILTER("Note 1"),
                                              "No." = FIELD("No.")));
    Caption = 'Notice';
    Editable = false;

}
field(30; "Pay By Clause"; Option)
{
    Caption = 'Pay By Clause';
    OptionCaption = ' ,No,Yes';
    OptionMembers = " ",NE,DA;
}
field(31; "Payment From"; Date)
{
    Caption = 'Payment From';

    trigger OnValidate()
    begin

        IF "Payment From" <> 0D THEN BEGIN

            "Payment From1" := ReplaceString("Payment From1", '.''', '.20');

            Bool2 := TRUE;
            IF STRLEN("Payment From1") < 10 THEN BEGIN
                "Payment From1" := FORMAT("Payment From", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                Bool2 := FALSE;
            END ELSE BEGIN
                "Payment From1" := "Payment From1" + '/ ';
                j := 1;
                FOR i := 1 TO (STRLEN("Payment From1") / 12) DO BEGIN
                    DatePom[i] := COPYSTR("Payment From1", j, 10);
                    j := j + 12;
                END;
            END;
            Bool := TRUE;
            "Payment From3" := FORMAT("Payment From", 0, '<day,2>.<month,2>.<year4>');
            IF ("Payment From3" <> '') AND (STRLEN("Payment From3") < 12) THEN BEGIN
                EVALUATE(Day1, COPYSTR("Payment From3", 1, 2));
                EVALUATE(Month1, COPYSTR("Payment From3", 4, 2));
                EVALUATE(Year1, COPYSTR("Payment From3", 7, 4));
            END;
            FOR i2 := 1 TO i DO BEGIN
                EVALUATE(Day, COPYSTR(DatePom[i2], 1, 2));
                EVALUATE(Month, COPYSTR(DatePom[i2], 4, 2));
                EVALUATE(Year, COPYSTR(DatePom[i2], 7, 4));

                date1 := DMY2DATE(Day, Month, Year);
                date2 := DMY2DATE(Day1, Month1, Year1);

                IF (date1 >= date2) THEN BEGIN
                    Bool := FALSE;
                    BREAK;
                END;

            END;
            IF (Bool = TRUE) AND (Bool2 = TRUE) THEN BEGIN
                "Payment From1" := "Payment From1" + FORMAT("Payment From", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                "Payment From1" := COPYSTR("Payment From1", 1, STRLEN("Payment From1") - 2);
            END;
            IF (Bool2 = FALSE) THEN
                "Payment From1" := COPYSTR("Payment From1", 1, STRLEN("Payment From1") - 2);

            IF (Bool = FALSE) THEN
                "Payment From1" := COPYSTR("Payment From1", 1, STRLEN("Payment From1") - 2);

            "Payment From1" := ReplaceString("Payment From1", '.20', '.''');

        END;
    end;
}
field(32; "Payment to"; Date)
{
    Caption = 'Payment From';

    trigger OnValidate()
    begin

        IF "Payment to" <> 0D THEN BEGIN

            "Payment to1" := ReplaceString("Payment to1", '.''', '.20');

            Bool2 := TRUE;
            IF STRLEN("Payment to1") < 10 THEN BEGIN
                "Payment to1" := FORMAT("Payment to", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                Bool2 := FALSE;
            END ELSE BEGIN
                "Payment to1" := "Payment to1" + '/ ';
                j := 1;
                FOR i := 1 TO (STRLEN("Payment to1") / 12) DO BEGIN
                    DatePom[i] := COPYSTR("Payment to1", j, 10);
                    j := j + 12;
                END;
            END;
            Bool := TRUE;
            "Payment From3" := FORMAT("Payment to", 0, '<day,2>.<month,2>.<year4>');
            IF ("Payment From3" <> '') AND (STRLEN("Payment From3") < 12) THEN BEGIN
                EVALUATE(Day1, COPYSTR("Payment From3", 1, 2));
                EVALUATE(Month1, COPYSTR("Payment From3", 4, 2));
                EVALUATE(Year1, COPYSTR("Payment From3", 7, 4));
            END;
            FOR i2 := 1 TO i DO BEGIN
                EVALUATE(Day, COPYSTR(DatePom[i2], 1, 2));
                EVALUATE(Month, COPYSTR(DatePom[i2], 4, 2));
                EVALUATE(Year, COPYSTR(DatePom[i2], 7, 4));

                date1 := DMY2DATE(Day, Month, Year);
                date2 := DMY2DATE(Day1, Month1, Year1);

                IF (date1 >= date2) THEN BEGIN
                    Bool := FALSE;
                    BREAK;
                END;

            END;
            IF (Bool = TRUE) AND (Bool2 = TRUE) THEN BEGIN
                "Payment to1" := "Payment to1" + FORMAT("Payment to", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                "Payment to1" := COPYSTR("Payment to1", 1, STRLEN("Payment to1") - 2);
            END;
            IF (Bool2 = FALSE) THEN
                "Payment to1" := COPYSTR("Payment to1", 1, STRLEN("Payment to1") - 2);

            IF (Bool = FALSE) THEN
                "Payment to1" := COPYSTR("Payment to1", 1, STRLEN("Payment to1") - 2);

            "Payment to1" := ReplaceString("Payment to1", '.20', '.''');

        END;
    end;
}
field(33; "Total Amaunt Paid"; Decimal)
{
    Caption = 'Total amount Paid';
}
field(34; "Date Executed"; Date)
{
    Caption = 'Date Executed';

    trigger OnValidate()
    begin


    end;
}
field(35; "Total Amount Paid by Dispute"; Decimal)
{
    Caption = 'Total Amount Paid by Dispute';

    trigger OnValidate()
    begin
        "Total Amaunt Paid" := "Total Amount Paid by Dispute" - "Sum Of Payments";
    end;
}
field(36; "Notice 2"; Integer)
{
    FieldClass = FlowField;
    CalcFormula = Count("Notes/Comments" WHERE(Type = FILTER("Note 2"),
                                              "No." = FIELD("No.")));
    Caption = 'Notice 2';
    Editable = false;

}
field(37; "Payment Date"; Date)
{
    Caption = 'Payment Date';

    trigger OnValidate()
    begin
        IF "Payment Date" <> 0D THEN BEGIN

            "Payment Date1" := ReplaceString("Payment Date1", '.''', '.20');

            Bool2 := TRUE;
            IF STRLEN("Payment Date1") < 10 THEN BEGIN
                "Payment Date1" := FORMAT("Payment Date", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                Bool2 := FALSE;
            END ELSE BEGIN
                "Payment Date1" := "Payment Date1" + '/ ';
                j := 1;
                FOR i := 1 TO (STRLEN("Payment Date1") / 12) DO BEGIN
                    DatePom[i] := COPYSTR("Payment Date1", j, 10);
                    j := j + 12;
                END;
            END;
            Bool := TRUE;
            "Payment From3" := FORMAT("Payment Date", 0, '<day,2>.<month,2>.<year4>');
            IF ("Payment From3" <> '') AND (STRLEN("Payment From3") < 12) THEN BEGIN
                EVALUATE(Day1, COPYSTR("Payment From3", 1, 2));
                EVALUATE(Month1, COPYSTR("Payment From3", 4, 2));
                EVALUATE(Year1, COPYSTR("Payment From3", 7, 4));
            END;
            FOR i2 := 1 TO i DO BEGIN
                EVALUATE(Day, COPYSTR(DatePom[i2], 1, 2));
                EVALUATE(Month, COPYSTR(DatePom[i2], 4, 2));
                EVALUATE(Year, COPYSTR(DatePom[i2], 7, 4));

                date1 := DMY2DATE(Day, Month, Year);
                date2 := DMY2DATE(Day1, Month1, Year1);

                IF (date1 >= date2) THEN BEGIN
                    Bool := FALSE;
                    BREAK;
                END;

            END;
            IF (Bool = TRUE) AND (Bool2 = TRUE) THEN BEGIN
                "Payment Date1" := "Payment Date1" + FORMAT("Payment Date", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                "Payment Date1" := COPYSTR("Payment Date1", 1, STRLEN("Payment Date1") - 2);
            END;
            IF (Bool2 = FALSE) THEN
                "Payment Date1" := COPYSTR("Payment Date1", 1, STRLEN("Payment Date1") - 2);

            IF (Bool = FALSE) THEN
                "Payment Date1" := COPYSTR("Payment Date1", 1, STRLEN("Payment Date1") - 2);
            "Payment Date1" := ReplaceString("Payment Date1", '.20', '.''');
        END;
    end;
}
field(39; "Amount Of Payments"; Decimal)
{
    Caption = 'Amount Of Payments';

    trigger OnValidate()
    begin
        //IF "Amount Of Payments"<0 THEN
        //   ERROR('Unesite pozitivnu vrijednost uplate');

        IF ("Amount Of Payments" <> 0) THEN BEGIN //AND ("Amount Of Payments">0) THEN BEGIN
            IF STRLEN("Amount Of Payments1") > 1 THEN
                "Amount Of Payments1" := "Amount Of Payments1" + '/ ';

            "Amount Of Payments1" := "Amount Of Payments1" + FORMAT("Amount Of Payments") + '/ ';
            "Amount Of paymets Sum" := "Amount Of paymets Sum" + "Amount Of Payments";
            "Amount Of Payments1" := COPYSTR("Amount Of Payments1", 1, STRLEN("Amount Of Payments1") - 2);

            "Sum Of Payments" := "Sum Of Payments" + "Amount Of Payments";
            "Total Amaunt Paid" := "Total Amount Paid by Dispute" - "Sum Of Payments";

        END;
    end;
}
field(40; "Sum Of Payments"; Decimal)
{
    Caption = 'Sum Of Payments';

    trigger OnValidate()
    begin
        "Total Amaunt Paid" := "Total Amount Paid by Dispute" - "Sum Of Payments";
    end;
}
    field(41; "First Instance Procedure"; Text[50])
    {
        Caption = 'First Instance Procedure';
        TableRelation = Procedure.Description WHERE("Type of procedure" = FILTER("First instance procedure"));
    }
    field(42; "Second Instance Procedure"; Text[50])
    {
        Caption = 'Second Instance Procedure';
        TableRelation = Procedure.Description WHERE("Type of procedure" = FILTER("Second instance procedure"));
    }
field(43; Revision; Option)
{
    Caption = 'Revision';
    OptionCaption = ' ,No,Yes';
    OptionMembers = " ",NE,DA;
}
field(44; Appeal; Option)
{
    Caption = 'Appeal';
    OptionCaption = ' ,No,Yes';
    OptionMembers = " ",NE,DA;
}
   field(45; "Ground For Dispute"; Text[150])
   {
       Caption = 'Ground For Dispute';
       TableRelation = "Grounds For Dispute"."Grounds For Dispute";
       ValidateTableRelation = false;
   }
field(46; "Worker Activity Category"; Option)
{
    Caption = 'Worker Activity Category';
    OptionCaption = 'Worker, Old worker';
    OptionMembers = Worker," Old worker";
}
field(47; "Potentional Lost"; Decimal)
{
    Caption = 'Potentional Lost';
}
field(48; "Amount Of the Disput Lawsuit"; Decimal)
{
    Caption = 'Amount Of the Disput In The Lawsuit';
}
field(49; Court; Text[90])
{
    Caption = 'Court';
}
field(50; Judge; Text[90])
{
    Caption = 'Judge';
}
field(51; "Amount Of Loss"; Decimal)
{
    Caption = 'Amount Of Loss';
}
field(52; "Short Description"; Text[200])
{
    Caption = 'Short Description';
}
field(53; "Bank Lawyer"; Text[80])
{
    Caption = 'Bank Lawyer';
}
field(54; "Plaintiff's Attorney"; Text[80])
{
    Caption = 'Plaintiff''s Attorney';
}
field(55; Notice3; Integer)
{
    FieldClass = FlowField;
    CalcFormula = Count("Notes/Comments" WHERE(Type = FILTER("Note 3"),
                                              "Note No." = FIELD("Internal ID")));
    Caption = 'Notice 3';
    Editable = false;

}
field(56; "Estimation Time Comp. Of Dis."; Text[4])
{
    Caption = 'Estimation Time Comp. Of Dis.';

    trigger OnValidate()
    begin
        EVALUATE(Procjena, COPYSTR("Estimation Time Comp. Of Dis.", 1, 4));
        Godina := DATE2DMY(TODAY, 3);
        IF (Procjena >= Godina) THEN BEGIN
            "Estimation Time Comp. Of Dis." := "Estimation Time Comp. Of Dis.";
        END ELSE BEGIN
            "Estimation Time Comp. Of Dis." := '';
            ERROR('Ne možete vrštiti retrospektivni unos godine!');

        END;
    end;
}
field(57; "Amount in ORCA Base"; Decimal)
{
    Caption = 'Amount in ORCA Base';
}
field(58; "Chargeable Dispute"; Option)
{
    Caption = 'Chargeable Dispute';
    OptionCaption = ' ,No,Yes';
    OptionMembers = " ",NE,DA;
}
field(59; "Notice For Execution"; Integer)

{
    FieldClass = FlowField;
    CalcFormula = Count("Notes/Comments" WHERE(Type = FILTER("Note for execution"),
                                              "Note No." = FIELD("Internal ID")));
    Caption = 'Notice For Execution';
    Editable = false;

}
field(60; "Date Of Term. Employment"; Date)
{
    Caption = 'Date Of Termination Employment';
}
field(61; "Type Of Roles"; Text[80])
{
    Caption = 'Type Of Roles';
}
field(62; "Lawsuit To Sue"; Date)
{
    Caption = 'Lawsuit To Sue';
}
field(63; "Search by Clause"; Decimal)
{
    Caption = 'Search by Clause';
}
field(64; "Amount Of a Booking Receivable"; Decimal)
{
    Caption = 'Amount Of a Booking Receivable';

    trigger OnValidate()
    begin
        "Outstanding Amount" := "Amount Of Pay. Per Clause" - "Amount Of a Booking Receivable";
    end;
}
field(65; "Sector Name"; Text[80])
{
    Caption = 'Sector Name';
    TableRelation = Sector.Description;
    //This property is currently not supported
    //TestTableRelation = true;
    ValidateTableRelation = false;
}
field(66; "Payment From1"; Text[200])
{
    Caption = 'Payment From';
}
field(67; "Payment to1"; Text[200])
{
    Caption = 'Payment From';
}
field(68; "Date Executed1"; Text[150])
{
    Caption = 'Date Executed';
}
field(69; "Payment Date1"; Text[250])
{
    Caption = 'Payment Date';
}
field(70; "Amount Of Payments1"; Text[120])
{
    Caption = 'Amount Of Payments';

    trigger OnValidate()
    begin
        IF "Amount Of Payments1" = '' THEN
            "Amount Of paymets Sum" := 0;
    end;
}
field(71; "Amount Of paymets Sum"; Decimal)
{
    Caption = 'Amount Of paymets Sum';

    trigger OnValidate()
    begin
        IF "Amount Of paymets Sum" = 0 THEN
            "Amount Of Payments1" := '';
    end;
}
field(72; "Amount Of Payment"; Decimal)
{
    Caption = 'Amount Of Payment';
}
field(73; "Dte From"; Date)
{
    Caption = 'Date From';
}
field(74; "Date To"; Date)
{
    Caption = 'Date To';
}
field(75; "Date From Reward"; Date)
{
    Caption = 'Date Reward';
}
field(77; "Document Template pdf"; Integer)
{
    Caption = 'Document Template';
}
field(78; "Version Disciplinary Measure"; Integer)
{
    Caption = 'Version Disciplinary Measure';
}
field(79; "File naame"; Text[1])
{
}
field(50302; "Type Of Agreement"; Option)
{
    Caption = 'Type Of Agreement';
    OptionCaption = 'Old clause,New clause';
    OptionMembers = "Old clause","New clause";
}
field(50306; "Position Code"; Code[20])
{
    Caption = 'Position Code';
}
field(50308; "Position Description"; Text[150])
{
    Caption = 'Position Description';
    TableRelation = "Position"."Description";
    //TableRelation=Position.d
    ValidateTableRelation = false;

    trigger OnValidate()
    begin

    end;
}
field(50309; "Management Level"; Code[10])
{
    Caption = 'Management Level';
}
field(50311; "Last Name"; Text[1])
{
    Caption = 'Last Name';
}
field(50312; "Handed Ower to Lawyer"; Date)
{
    Caption = 'Handed Ower to Lawyer';
}
field(50333; "Reported By First Name"; Text[1])
{
    Caption = 'Manager 1 First Name';
    Editable = false;
}
field(50334; "Reported By Last Name"; Text[1])
{
    Caption = 'Manager 1 Last Name';
    Editable = false;
}
field(50381; "Update Org jed"; Boolean)
{
    Caption = 'Update Org jed';
}
field(50382; Entity; Text[40])
{
    Caption = 'Entities';
    TableRelation = Entity.Description;
    ValidateTableRelation = false;
}
field(50383; "Checks in PU"; Date)
{
    Caption = 'Checks in PU';

    trigger OnValidate()
    begin
        IF "Checks in PU" <> 0D THEN BEGIN

            "Checks in PU2" := ReplaceString("Checks in PU2", '.''', '.20');

            Bool2 := TRUE;
            IF STRLEN("Checks in PU2") < 10 THEN BEGIN
                "Checks in PU2" := FORMAT("Checks in PU", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                Bool2 := FALSE;
            END ELSE BEGIN
                "Checks in PU2" := "Checks in PU2" + '/ ';
                j := 1;
                FOR i := 1 TO (STRLEN("Checks in PU2") / 12) DO BEGIN
                    DatePom[i] := COPYSTR("Checks in PU2", j, 10);
                    j := j + 12;
                END;
            END;
            Bool := TRUE;
            "Payment From3" := FORMAT("Checks in PU", 0, '<day,2>.<month,2>.<year4>');
            IF ("Payment From3" <> '') AND (STRLEN("Payment From3") < 12) THEN BEGIN
                EVALUATE(Day1, COPYSTR("Payment From3", 1, 2));
                EVALUATE(Month1, COPYSTR("Payment From3", 4, 2));
                EVALUATE(Year1, COPYSTR("Payment From3", 7, 4));
            END;
            FOR i2 := 1 TO i DO BEGIN
                EVALUATE(Day, COPYSTR(DatePom[i2], 1, 2));
                EVALUATE(Month, COPYSTR(DatePom[i2], 4, 2));
                EVALUATE(Year, COPYSTR(DatePom[i2], 7, 4));

                date1 := DMY2DATE(Day, Month, Year);
                date2 := DMY2DATE(Day1, Month1, Year1);

                IF (date1 >= date2) THEN BEGIN
                    Bool := FALSE;
                    BREAK;
                END;

            END;
            IF (Bool = TRUE) AND (Bool2 = TRUE) THEN BEGIN
                "Checks in PU2" := "Checks in PU2" + FORMAT("Checks in PU", 0, '<day,2>.<month,2>.<year4>') + '/ ';
                "Checks in PU2" := COPYSTR("Checks in PU2", 1, STRLEN("Checks in PU2") - 2);
                "Checks No." := "Checks No." + 1;
            END;
            IF (Bool2 = FALSE) THEN BEGIN
                "Checks in PU2" := COPYSTR("Checks in PU2", 1, STRLEN("Checks in PU2") - 2);
                "Checks No." := "Checks No." + 1;
            END;

            IF (Bool = FALSE) THEN BEGIN
                "Checks in PU2" := COPYSTR("Checks in PU2", 1, STRLEN("Checks in PU2") - 2);
            END;
            "Checks in PU2" := ReplaceString("Checks in PU2", '.20', '.''');
        END;
    end;
}
field(50384; "Checks in PU2"; Text[100])
{
    Caption = 'Checks in PU2';

    trigger OnValidate()
    begin
        IF "Checks in PU2" = '' THEN
            "Checks No." := 0;
    end;
}
field(50385; "Checks No."; Integer)
{
    Caption = 'Checks No.';
    Editable = false;
}
field(50389; Active; Boolean)
{
    Caption = 'Active';
}
field(50390; "Category Disciplinary Measure"; Text[5])
{
    Caption = 'Category Disciplinary Measure';
}
field(50393; Comment; Text[200])
{
    Caption = 'Comment';
}
   field(50395; Measure; Text[250])
    {
        Caption = 'Disciplinary Measure';
        TableRelation = "Disciplinary Measures"."Subcategory Name" WHERE("Measure Type" = FIELD("Measure Type"));
    }
field(50396; "Measure From"; Date)
{
    Caption = 'Measure From';

    trigger OnValidate()
    begin
        "Act Effective Date" := "Measure From";

        IF "Measure From" <> 0D THEN BEGIN
            DisciplinaryMeasures.RESET;
            DisciplinaryMeasures.SETFILTER("Subcategory Name", '%1', Measure);
            IF DisciplinaryMeasures.FINDFIRST THEN BEGIN

              IF DisciplinaryMeasures."Measure Type" = DisciplinaryMeasures."Measure Type"::Heavier THEN BEGIN
                "Measure To" := CALCDATE('<+6M>', "Measure From");
              END ELSE IF DisciplinaryMeasures."Measure Type" = DisciplinaryMeasures."Measure Type"::Lighter THEN BEGIN
                "Measure To" := CALCDATE('<+1Y>', "Measure From");
              END;

            END;
            IF "Measure Type" = "Measure Type"::Heavier THEN BEGIN
                "Measure To" := CALCDATE('<+1Y>', "Measure From");
            END ELSE
                IF "Measure Type" = "Measure Type"::Lighter THEN BEGIN
                    "Measure To" := CALCDATE('<+6M>', "Measure From");
                END;
        END;

        IF ("Measure From" <= TODAY) AND ("Expiration Measure" >= TODAY) THEN
            "Active Measure" := TRUE
        ELSE
            "Active Measure" := FALSE;

    end;
}
field(50397; "Measure To"; Date)
{
    Caption = 'Measure To';
}
  field(50398; "First Instance Disciplinary"; Text[1])
   {
       Caption = 'First Instance Disciplinary';
       TableRelation = "Disciplinary Measures"."Category Name" WHERE(Category = FILTER(2));
       ValidateTableRelation = false;
   }
field(50399; "First Instance D. Date From"; Date)
{
    Caption = 'First Instance D. Date From';
}
field(50400; "First Instance D. Date To"; Date)
{
    Caption = 'First Instance D. Date To';
}
  field(50401; "Second Instance Disciplinary"; Text[1])
  {
      Caption = 'Second Instance Disciplinary';
      TableRelation = "Disciplinary Measures"."Category Name" WHERE(Category = FILTER(3));
      ValidateTableRelation = false;
  }
field(50402; "Second Instance D. Date From"; Date)
{
    Caption = 'Second Instance D. Date From';
}
field(50403; "Second Instance D. Date To"; Date)
{
    Caption = 'Second Instance D. Date To';
}
    field(50404; Reward; Text[100])
    {
        Caption = 'Reward';
        TableRelation = Awards."Subcategory Name";
    }
field(50405; "Reward Date"; Date)
{
    Caption = 'Reward Date';
}
   field(50406; Praise; Text[1])
   {
       Caption = 'Praise';
       TableRelation = Awards."Category Name" WHERE(Category = FILTER(2));
       ValidateTableRelation = false;
   }
field(50407; "Praise Date"; Date)
{
    Caption = 'Praise Date';
}
field(50408; "Page Type"; Option)
{
    Caption = 'Page Type';
    OptionCaption = 'Disciplinary measures,Awards,Clauses,Lawsuits';
    OptionMembers = "Disciplinary measures",Awards,Clauses,Lawsuits;
}
field(50409; "Department Name"; Text[150])
{
    Caption = 'Department Name';
    TableRelation = "Employee Contract Ledger"."Department Name";
    ValidateTableRelation = false;
}
field(50410; "Group Description"; Text[200])
{
    Caption = 'Group Description';
    TableRelation = "Employee Contract Ledger"."Group Description";
    ValidateTableRelation = false;
}
     field(50411; "Lawsuit Document"; Integer)
     {
         FieldClass = FlowField;
         CalcFormula = Count("Lawsuit Documents" WHERE("Lawsuit No." = FIELD("No.")));
         Caption = 'Lawsuit Document';
         Editable = false;

     }
field(50412; "Document Template"; Integer)
{
    Caption = 'Document Template';
}
field(50413; "Active Measure"; Boolean)
{
    Caption = 'Active Measure';
    Editable = false;
}
field(50414; "Imposition/Adoption Date"; Date)
{
    Caption = 'Imposition measures/Adoption of the act';
}
field(50415; Complaint; Option)
{
    Caption = 'Complaint';
    OptionCaption = ' ,Yes,No';
    OptionMembers = " ",Yes,No;
}
field(50416; "Act Effective Date"; Date)
{
    Caption = 'Act Effective Date';

    trigger OnValidate()
    begin
        "Measure From" := "Act Effective Date";

        IF "Measure From" <> 0D THEN BEGIN
            DisciplinaryMeasures.RESET;
            DisciplinaryMeasures.SETFILTER("Subcategory Name", '%1', Measure);
            IF DisciplinaryMeasures.FINDFIRST THEN BEGIN

              IF DisciplinaryMeasures."Measure Type" = DisciplinaryMeasures."Measure Type"::Heavier THEN BEGIN
                "Measure To" := CALCDATE('<+6M>', "Measure From");
              END ELSE IF DisciplinaryMeasures."Measure Type" = DisciplinaryMeasures."Measure Type"::Lighter THEN BEGIN
                "Measure To" := CALCDATE('<+1Y>', "Measure From");
              END;

            END;

            IF "Measure Type" = "Measure Type"::Heavier THEN BEGIN
                "Measure To" := CALCDATE('<+1Y>', "Measure From");
            END ELSE
                IF "Measure Type" = "Measure Type"::Lighter THEN BEGIN
                    "Measure To" := CALCDATE('<+6M>', "Measure From");
                END;
            IF ("Measure From" <= TODAY) AND ("Expiration Measure" >= TODAY) THEN
                "Active Measure" := TRUE
            ELSE
                "Active Measure" := FALSE;
        END;

    end;
}
field(50417; "Expiration Measure"; Date)
{
    Caption = 'Expiration Measure';

    trigger OnValidate()
    begin

        IF ("Measure From" <= TODAY) AND ("Expiration Measure" >= TODAY) THEN
            "Active Measure" := TRUE
        ELSE
            "Active Measure" := FALSE;
    end;
}
field(50418; "Measure Type"; Option)
{
    Caption = 'Measure Type';
    OptionCaption = ' ,Lighter,Heavier';
    OptionMembers = " ",Lighter,Heavier;
}
  field(50419; "Injury Name"; Text[250])
   {
       Caption = 'Injury Name';
       TableRelation = Injury."Injury Name" WHERE("Measure Type" = FIELD("Measure Type"));
   }
}

keys
{
key(Key1; "No.", "Employee No.", "Internal ID")
{
}
}

fieldgroups
{
}

var
T_Employee: Record "Employee";
//    T_TypesJobDutiesViol: Record "Types of Job Duties Violation";
HRSetup: Record "Human Resources Setup";
EmployeeContractLedger: Record "Employee Contract Ledger";
emp: Record "Employee";
//  SegmentationGroup: Record "Segmentation Data";
WDV: Record "Work Duties Violation";
wb: Record "Work Booklet";
EmployeeContractLedgerM: Record "Employee Contract Ledger";
empM: Record "Employee";
//  SegmentationGroupM: Record "Segmentation Data";
EmployeeContractLedgerR: Record "Employee Contract Ledger";
empR: Record "Employee";
//   SegmentationGroupR: Record "Segmentation Data";
Department: Record "Department";
DepartmentR: Record "Department";
DepartmentM: Record "Department";
//  Types: Record "Types of Job Duties Violation";
DepartmentP: Record "Department";
Position: Record "Position";
//  CM: Record "Comission Members";
MonthsConstant: Text;
ECL: Record "Employee Contract Ledger";
DatePom: array[20] of Text;
i: Integer;
j: Integer;
"Payment From2": Text;
Day: Integer;
Month: Integer;
Year: Integer;
//   Pomocna: Record "Disciplinary Measures";
Bool: Boolean;
Br: Integer;
i2: Integer;
"Payment From3": Text;
Day1: Integer;
Month1: Integer;
Year1: Integer;
Bool2: Boolean;
Weight: Text;
Modulus: Integer;
Procjena: Integer;
Godina: Integer;
date1: Date;
date2: Date;
//  DisciplinaryMeasures: Record "Disciplinary Measures";

local procedure ReplaceString(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
begin
WHILE STRPOS(String, FindWhat) > 0 DO
    String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
NewString := String;
end;
}

*/