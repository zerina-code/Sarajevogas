table 50023 Reduction
{
    // //

    Caption = 'Reduction';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                /*IF "No." <> xRec."No." THEN BEGIN
                  WageSetup.GET;
                  NoSeriesMgt.TestManual(WageSetup."Reduction No. Series");
                  "No. Series" := '';
                END;*/

            end;
        }
        field(5; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            var
                WageSetup: Record "Wage Setup";
                //ĐK  NoSeriesMgt: Codeunit "NoSeriesManagement";
                RB: Record "Wage/Reduction Bank";
                RBA: Record "Wage/Reduction Bank Accounts";
                RpW: Record "Reduction per Wage";
                RT: Record "Reduction Types";
                Text001: Label '<Ne smijete mijenjati broj zaposlenika ukoliko ima vec otplacenih obustava!>';
                emp: Record "Employee";
            begin
                IF Rec."Employee No." <> xRec."Employee No." THEN BEGIN
                    RpW.RESET;
                    RpW.SETRANGE("Reduction No.", "No.");
                    IF RpW.FIND('-') THEN ERROR(Text001);
                END;
                IF emp.GET("Employee No.") THEN BEGIN
                    "First Name" := emp."First Name";
                    "Last Name" := emp."Last Name";
                END;
            end;
        }
        field(8; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(9; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(10; "Bank Name"; Text[100])
        {
            Caption = 'Bank Name';
        }
        field(15; "Reduction Amount"; Decimal)
        {
            Caption = 'Total Reduction Amount';

            trigger OnValidate()
            begin
                //ĐK   "Installment Amount":="Reduction Amount";
            end;
        }
        field(20; "Payment Start"; Date)
        {
            Caption = 'Payment Start';
        }
        field(25; "Interest Rate"; Decimal)
        {
            Caption = 'Interest Rate';
        }
        field(30; "Interest Calc. Period"; Text[10])
        {
            Caption = 'Interest Calc. Period';
        }
        field(35; "No. of Installments"; Integer)
        {
            Caption = 'No. of Installments';

            trigger OnValidate()
            begin
                IF "No. of Installments" <> 0 THEN
                    "Installment Amount" := ROUND("Reduction Amount" / "No. of Installments", 0.01, '<')
                ELSE
                    "Installment Amount" := "Reduction Amount";
            end;
        }
        field(36; "No. of Installments paid"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Reduction per Wage" WHERE("Employee No." = FIELD("Employee No."),
                                                            "Reduction No." = FIELD("No.")));
            Caption = 'No. of installments paid';

        }
        field(40; "Paid Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Reduction per Wage".Amount WHERE("Employee No." = FIELD("Employee No."),
                                                                "Reduction No." = FIELD("No.")));
            Caption = 'Paid Amount';
            Editable = false;

        }
        field(45; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(50; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Blocked,Open,Closed';
            OptionMembers = Blokiran,Otvoren,Zatvoren;
        }
        field(55; "Payment Model"; Code[10])
        {
            Caption = 'Payment Model';
        }
        field(60; "Refer To Number"; Code[22])
        {
            Caption = 'Refer To Number';
        }
        field(65; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(70; "User ID"; Code[50])
        {
            Caption = 'User ID';
        }
        field(75; "Date of Calculation"; Date)
        {
            Caption = 'Date of Calculation';
        }
        field(80; "Installment Amount"; Decimal)
        {
            Caption = 'Installment Amount';
        }
        field(85; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
        }
        field(90; "G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(100; Type; Code[10])
        {
            Caption = 'Reduction type';
            TableRelation = "Reduction Types";

            trigger OnValidate()
            var
                WageSetup: Record "Wage Setup";
                //ĐK NoSeriesMgt: Codeunit "NoSeriesManagement";
                RB: Record "Wage/Reduction Bank";
                RBA: Record "Wage/Reduction Bank Accounts";
                RpW: Record "Reduction per Wage";
                RT: Record "Reduction Types";
                Text001: Label '<Ne smijete mijenjati broj zaposlenika ukoliko ima vec otplacenih obustava!>';
                emp: Record "Employee";
            begin
                IF RT.GET(Type) THEN BEGIN
                    "G/L Account" := RT."G/L Account";
                END;
            end;
        }
        field(101; ContractNo; Text[30])
        {
            Caption = 'Contract No.';
        }


        field(102; BankAccountCode; Code[10])
        {
            Caption = 'Bank account code';
            TableRelation = "Wage/Reduction Bank".Code;

            trigger OnValidate()
            var
                BACN: Integer;
            begin
                BACN := 0;
                IF RB.GET(BankAccountCode) THEN BEGIN
                    "Bank Name" := RB.Name;
                    RBA.RESET;
                    RBA.SETFILTER("Bank Code", BankAccountCode);
                    /*IF RBA.FIND('-') THEN BEGIN
                     IF RBA.COUNT > 0 THEN BEGIN
                      BACN := RBA."No.";*/
                END;

                /*IF BACN > 0 THEN BEGIN
                 BankAccountCodeNo := BACN;
                 VALIDATE(BankAccountCodeNo);
                END
                ELSE BEGIN
                 BankAccountCodeNo := 0;
                 "Bank Account No." := '';
                END;
               END
               ELSE BEGIN
                "Bank Name" := '';
                BankAccountCodeNo := 0;
                "Bank Account No." := '';
               END;*/

            end;
        }

        field(103; BankAccountCodeNo; Code[20])
        {
            Caption = 'Bank Account Code No.';
            TableRelation = "Wage/Reduction Bank Accounts"."No." WHERE("Bank Code" = FIELD(BankAccountCode));

            trigger OnValidate()
            var
                WageSetup: Record "Wage Setup";
                //ĐK  NoSeriesMgt: Codeunit "NoSeriesManagement";
                RB: Record "Wage/Reduction Bank";
                RBA: Record "Wage/Reduction Bank Accounts";
                RpW: Record "Reduction per Wage";
                RT: Record "Reduction Types";
                Text001: Label '<Ne smijete mijenjati broj zaposlenika ukoliko ima vec otplacenih obustava!>';
                emp: Record "Employee";
            begin
                //   IF RBA.GET(BankAccountCode,BankAccountCodeNo) THEN
                //   "Bank Account No." := RBA."Account No";
            end;
        }
        field(104; WHFilter; Code[20])
        {
            Caption = 'Wage Header Filter';
        }
        field(105; "Wage Header No."; Code[10])
        {
            Caption = 'Wage Header No.';
        }
        field(106; "Wage Header Entry No."; Integer)
        {
            Caption = 'Wage Header Entry No.';
        }
        field(107; "Bal. G/L Account"; Code[20])
        {
            Caption = 'G/L Account';
            TableRelation = "G/L Account";
        }
        field(108; "Reduction has instalments"; Boolean)
        {
            Caption = 'Reduction has instalments';

            trigger OnValidate()
            begin
                IF "Reduction has instalments" = FALSE THEN
                    VALIDATE("No. of Installments", 0);
            end;
        }
        field(109; "Opening balance"; Decimal)
        {
            Caption = 'Opening balance';
        }
        field(110; "Party No."; Code[20])
        {
            Caption = 'Party No.';
        }
        field(111; "Payment End"; Date)
        {
            Caption = 'Payment end';
        }
        field(50009; "Employee Status"; enum "Employee Status")
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Employee.Status WHERE("No." = FIELD("Employee No.")));
            Caption = 'Status';


        }
        field(50010; "Paid Installments"; Integer)
        {
            Caption = 'Paid Installments';
        }
        field(50011; "Remaining Due"; Decimal)
        {
            Caption = 'Remaining Due';
        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Employee No.", Type, "G/L Account")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "User ID" := USERID;

        IF "No." = '' THEN BEGIN
            WageSetup.GET;
            WageSetup.TESTFIELD("Reduction No. Series");
            NoSeriesMgt.InitSeries(WageSetup."Reduction No. Series", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        "User ID" := USERID;
    end;

    var
        WageSetup: Record "Wage Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        RB: Record "Wage/Reduction Bank";
        RBA: Record "Wage/Reduction Bank Accounts";
        RpW: Record "Reduction per Wage";
        RT: Record "Reduction Types";
        Text001: Label '<Ne smijete mijenjati broj zaposlenika ukoliko ima vec otplacenih obustava!>';
        emp: Record "Employee";

    procedure AssistEdit(OldReduction: Record "Reduction"): Boolean
    var
        Reduction: Record "Reduction";
    begin
        WITH Reduction DO BEGIN
            Reduction := Rec;
            WageSetup.GET;
            WageSetup.TESTFIELD("Reduction No. Series");
            IF NoSeriesMgt.SelectSeries(WageSetup."Reduction No. Series", OldReduction."No. Series", "No. Series") THEN BEGIN
                WageSetup.GET;
                WageSetup.TESTFIELD("Reduction No. Series");
                NoSeriesMgt.SetSeries("No.");
                Rec := Reduction;
                EXIT(TRUE);
            END;
        END;
    end;
}

