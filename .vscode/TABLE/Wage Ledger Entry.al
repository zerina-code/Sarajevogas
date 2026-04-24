table 50029 "Wage Ledger Entry"
{
    // //SPNPL01.00 JB 07.06.2004.
    // 
    // //Field list:
    // //
    // //  Field No. Field Name                   Data Type      Length  Description
    // //    1       Entry No.                    Integer                Primary Key
    // //    5       Employee No.                 Code           20
    // //   10       Posting Date                 Date                   Date of posting to GL
    // //   15       Document No.                 Code           20      Wage Header No.
    // //   20       Description                  Text           50
    // //   25       Applies-to Entry             Integer                Not Used
    // //   30       Open                         Boolean                Not Used
    // //   35       Global Dimension 1 Code      Code           20      Taken from Employee
    // //   40       Global Dimension 2 Code      Code           20      Taken from Employee
    // //   45       Document Date                Date                   Document Creation Date
    // //   50       No. Series                   Code           10      Not Used
    // //   55       Correction                   Boolean                Not Used
    // //   60       Cost Posted To G/L           Decimal
    // //   65       Cost                         Decimal
    // //   70       Month Of Calculation         Integer                From Wage Header
    // //   75       Year Of Calculation          Integer                From Wage Header
    // //   80       Net Wage                     Decimal
    // //   81       Net Wage And Sick Leave      Decimal
    // //   85       Brutto Wage                  Decimal
    // //   90       Net Wage Paid                Decimal
    // //   91       Net Wage And Sick Leave Paid Decimal
    // //   95       Brutto Wage Paid             Decimal
    // //  100       Status                       Option                 Not Used-Open,Posted,Paid,Posted+Paid
    // //  105       Month Of Wage                Integer                From Wage Header
    // //  110       Year Of Wage                 Integer                From Wage Header
    // //  115       Date of payment              Date
    // 
    // 
    // //SPNPL01.01 JB 14.10.2004.
    // 
    // //Creation of RS for Contracts
    // 
    // //Added fields:
    // //  120       Contracted Work              Boolean                SPNPL01.01
    // //  125       Wage Type                    Code           10      SPNPL01.01 Wage Type at last calculation
    // //  130       RSID                         Code            4      SPNPL01.01 RS0.RS_SIFRA

    Caption = 'Wage Ledger Entry';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Description = 'Primary Key';
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
        }
        field(10; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Description = 'Date of posting to GL';
        }
        field(15; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Description = 'Wage Header No.';
        }
        field(20; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(25; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
            Description = 'Not Used';
        }
        field(30; Open; Boolean)
        {
            Caption = 'Open';
            Description = 'Not Used';
        }
        field(35; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            Description = 'Taken from Employee';
        }
        field(40; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            Description = 'Taken from Employee';
        }
        field(45; "Document Date"; Date)
        {
            Caption = 'Document Date';
            Description = 'Document Creation Date';
        }
        field(50; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            Description = 'Not Used';
        }
        field(55; Correction; Boolean)
        {
            Caption = 'Correction';
            Description = 'Not Used';
        }
        field(60; "Cost Posted To G/L"; Decimal)
        {
            Caption = 'Cost Posted To G/L';
        }
        field(65; Cost; Decimal)
        {
            Caption = 'Cost';
        }
        field(70; "Month Of Calculation"; Integer)
        {
            Caption = 'Month Of Calculation';
            Description = 'From Wage Header';
        }
        field(75; "Year Of Calculation"; Integer)
        {
            Caption = 'Year Of Calculation';
            Description = 'From Wage Header';
        }
        field(80; "Net Wage"; Decimal)
        {
            Caption = 'Net Wage';
        }
        field(81; "Net Wage And Sick Leave"; Decimal)
        {
            Caption = 'Net Wage And Sick Leave';
        }
        field(85; "Brutto Wage"; Decimal)
        {
            Caption = 'Brutto Wage';
        }
        field(90; "Net Wage Paid"; Decimal)
        {
            Caption = 'Net Wage Paid';
        }
        field(91; "Net Wage And Sick Leave Paid"; Decimal)
        {
            Caption = 'Net Wage And Sick Leave Paid';
        }
        field(95; "Brutto Wage Paid"; Decimal)
        {
            Caption = 'Brutto Wage Paid';
        }
        field(100; Status; Option)
        {
            Description = 'Not Used-Open,Posted,Paid,Posted+Paid';
            OptionCaption = 'Open,Posted,Paid,Posted+Paid';
            OptionMembers = Open,Posted,Paid,"Posted+Paid";
        }
        field(105; "Month Of Wage"; Integer)
        {
            Caption = 'Month Of Calculation';
            Description = 'From Wage Header';
        }
        field(110; "Year Of Wage"; Integer)
        {
            Caption = 'Year Of Calculation';
            Description = 'From Wage Header';
        }
        field(115; "Date of payment"; Date)
        {
            Caption = 'Date of payment';
        }
        field(120; "Contracted Work"; Boolean)
        {
            Caption = 'Contracted Work';
        }
        field(125; "Wage Type"; Code[10])
        {
            Caption = 'Wage Type';
        }
        field(130; RSID; Code[4])
        {
        }
        field(135; "Clean Net Wage"; Decimal)
        {
            Caption = 'Clean Net Wage';
        }
        field(140; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
            Description = 'PK2 from WH';
        }
        field(197; "Shortcut Dimension 4 Code"; Code[10])
        {
        }
        field(198; "Wage Calculation Type"; Option)
        {
            FieldClass = Normal;
            OptionCaption = 'Regular,Temporary Service Contracts-Residents,Temporary Service Contracts-No Residents,Author Contracts,Additions';
            OptionMembers = Regular,"Temporary Service Contracts-Residents","Temporary Service Contracts-No Residents","Author Contracts",Additions;
        }
        field(199; "Wage Calculation Entry No."; Code[20])
        {
            Caption = 'No.';
        }
        field(209; "Netto Taxable"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Netto)" WHERE("Employee No." = FIELD("Employee No."),
                                                                              "Document No." = FIELD("Document No."),
                                                                              "Entry Type" = FILTER('Net Wage|Taxable|Untaxable|Use|Work Experience|Transport|Meal to pay'),
                                                                              "Wage Calculation Type" = FILTER('Regular')));

        }
        field(210; Netto; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Wage Value Entry"."Cost Amount (Actual)" WHERE("Employee No." = FIELD("Employee No."),
                                                                               "Document No." = FIELD("Document No."),
                                                                               "Entry Type" = FILTER('Net Wage|Taxable|Untaxable|Use|Work Experience|Transport|Meal to pay|Tax'),
                                                                               "Wage Calculation Type" = FILTER('Regular')));

        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Posting Date", "Employee No.")
        {
        }
        key(Key3; "Document No.", "Posting Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        WVE.RESET;
        WVE.SETRANGE("Wage Ledger Entry No.", "Entry No.");
        IF NOT WVE.ISEMPTY THEN
            WVE.DELETEALL;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit "DimensionManagement";
        GLSetupRead: Boolean;
        WVE: Record "Wage Value Entry";
}

