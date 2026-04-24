report 50027 "Post Wage to GL"
{
    ProcessingOnly = true;


    dataset
    {
        dataitem("<Wage Ledger Entry>"; "Wage Ledger Entry")
        {

            trigger OnAfterGetRecord()
            begin
                //SETFILTER("Wage Calculation Type",'<>%1','');
                WageSetupGET.get();

                IF ("Wage Calculation Type" = 0) THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 0 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;


                IF (("Wage Calculation Type" = 1)) THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 2 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                IF "Wage Calculation Type" = 3 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;
                IF "Wage Calculation Type" = 4 THEN BEGIN
                    TemplateName := WageSetupGET."Wage Journal Template";
                    BatchName := WageSetupGET."Wage Batch Name";
                END;

                GenJnlTemplate.GET(TemplateName);
                GenJnlBatch.GET(TemplateName, BatchName);
                GenJnlLine.SETRANGE("Journal Template Name", GenJnlBatch."Journal Template Name");
                IF GenJnlBatch.Name <> '' THEN
                    GenJnlLine.SETRANGE("Journal Batch Name", GenJnlBatch.Name)
                ELSE
                    GenJnlLine.SETRANGE("Journal Batch Name", '');
                IF GenJnlLine.FIND('+') THEN;

                IF GenJnlBatch."No. Series" <> '' THEN BEGIN
                    CLEAR(NoSeriesMgt);
                    DocNo := NoSeriesMgt.TryGetNextNo(GenJnlBatch."No. Series", "Posting Date");
                END;


                C1 += 1;

                IF FirstRow THEN BEGIN
                    FirstRow := FALSE;
                    WageHeader.Reset();
                    WageHeader.SetFilter("No.", '%1', "Document No.");
                    WageHeader.FindFirst();

                    PostDate := "Document Date";
                END;
            end;

            trigger OnPostDataItem()
            begin
                RoundItems;
            end;

            trigger OnPreDataItem()
            begin
                LastNo := 0;


                GenJnlLine.LOCKTABLE;

                TotalRecNo1 := COUNTAPPROX;
                C1 := 0;

                WJB.RESET;
                //BT
                WJB.DELETEALL;

                NextWBNo := 0;

                FirstRow := TRUE;
            end;
        }
        dataitem("<Wage Value Entry>"; "Wage Value Entry")
        {
            RequestFilterFields = "Wage Calculation Type", "Employee No.", "Document Date";

            trigger OnAfterGetRecord()
            begin


                PostSetup.GET("Wage Posting Group");

                CASE "Entry Type" OF
                    "Entry Type"::Contribution:
                        BEGIN
                            AddTaxPostSetup.GET("Contribution Type", "Wage Posting Group");
                            //ĐK AddTaxPostSetup.CALCFIELDS(Account);
                            // ĐK AddTaxPostSetup.CALCFIELDS("Bal. Account");
                            AddTaxPostSetup.TESTFIELD(Account);
                            AddTaxPostSetup.TESTFIELD("Bal. Account");

                            Account := AddTaxPostSetup.Account;
                            BalAccount := AddTaxPostSetup."Bal. Account";
                            // "Shortcut Dimension 4 Code":=AddTaxPostSetup."Posting Group";
                            ContributionDesc.SETFILTER(Code, '%1', AddTaxPostSetup."Additional Tax Code");
                            IF ContributionDesc.FINDFIRST THEN BEGIN
                                IF ContributionDesc."From Brutto" THEN
                                    Desc := 'DOPRINOS IZ PLATE';
                                IF ContributionDesc."Over Brutto" THEN
                                    Desc := 'DOPRINOS NA PLATU';
                                IF ContributionDesc."Over Netto" THEN
                                    Desc := ContributionDesc.Description;
                            END;
                        END;



                    "Entry Type"::Tax:
                        BEGIN

                            IF (("Wage Addition Type" <> '') AND (Round <> 2)) THEN BEGIN
                                WAT.SETFILTER(Code, '%1', "Wage Addition Type");
                                IF WAT.FINDFIRST THEN BEGIN
                                    //    WAT.TESTFIELD(Bonus);
                                    //   PostSetup.GET(WAT.Bonus);
                                    PostSetup.TESTFIELD("Tax Account");
                                    PostSetup.TESTFIELD("Tax Bal. Account");
                                    Account := PostSetup."Tax Account";
                                    BalAccount := PostSetup."Tax Bal. Account";
                                    Transit := PostSetup."Tax Transit Account";
                                END;
                            END
                            ELSE BEGIN
                                PostSetup.GET("Wage Posting Group");
                                PostSetup.TESTFIELD("Tax Account");
                                PostSetup.TESTFIELD("Tax Bal. Account");

                                Account := PostSetup."Tax Account";
                                BalAccount := PostSetup."Tax Bal. Account";
                                Transit := PostSetup."Tax Transit Account";

                            END;
                        END;



                    "Entry Type"::"Added Tax Per City":
                        BEGIN
                            PostSetup.TESTFIELD("City Tax Account");
                            PostSetup.TESTFIELD("City Tax Bal. Account");

                            Account := PostSetup."City Tax Account";
                            BalAccount := PostSetup."City Tax Bal. Account";

                        END;

                    "Entry Type"::"Net Wage":
                        IF "Wage Calculation Type" = 0 THEN BEGIN
                            BEGIN
                                COA.RESET;
                                COA.SETFILTER("Short Code", '%1', Description);
                                IF COA.FINDFIRST THEN BEGIN
                                    COA.CalcFields("G/L Account No.", "G/L Balance Account No.");

                                    COA.TESTFIELD("G/L Account No.");
                                    COA.TESTFIELD("G/L Balance Account No.");

                                    Account := COA."G/L Account No.";
                                    BalAccount := COA."G/L Balance Account No.";
                                    // "Shortcut Dimension 4 Code":=COA."Posting Group";
                                    //Desc:=UPPERCASE(COA.Description);
                                END;
                            END;

                        END
                        ELSE BEGIN

                            if ("Wage Calculation Type" in [1, 2, 3]) then begin
                                PostSetup.TESTFIELD("Netto Account");
                                PostSetup.TESTFIELD("Netto Bal. Account");
                                PostSetup.TESTFIELD("Netto Transit Account");
                                Account := PostSetup."Netto Account";
                                BalAccount := PostSetup."Netto Bal. Account";
                                Transit := PostSetup."Netto Transit Account";



                            end
                            else begin
                                WageAdditionType.RESET;
                                WageAdditionType.GET(Description);
                                WageAdditionType.CalcFields("G/L Account No.", "G/L Balance Account No.");
                                WageAdditionType.TESTFIELD("G/L Account No.");
                                WageAdditionType.TESTFIELD("G/L Balance Account No.");

                                Account := WageAdditionType."G/L Account No.";
                                BalAccount := WageAdditionType."G/L Balance Account No.";
                                "Shortcut Dimension 4 Code" := WageAdditionType."Posting Group";
                            end;
                            //Desc:=WageAdditionType.Description;
                        END;

                    "Entry Type"::"Work Experience":
                        IF "Wage Calculation Type" = 0 THEN BEGIN
                            BEGIN
                                WageSetupGET.Get();
                                COA.RESET;
                                COA.SETFILTER("Short Code", '%1', WageSetupGET."Workday Code");
                                IF COA.FINDFIRST THEN BEGIN
                                    COA.CalcFields("G/L Account No.", "G/L Balance Account No.");

                                    COA.TESTFIELD("G/L Account No.");
                                    COA.TESTFIELD("G/L Balance Account No.");

                                    Account := COA."G/L Account No.";
                                    BalAccount := COA."G/L Balance Account No.";
                                END;
                            END;

                        END;

                    "Entry Type"::"Sick Leave-Company":
                        BEGIN
                        END;
                    "Entry Type"::Reduction:
                        BEGIN
                            IF ("Reduction No.") <> '' THEN BEGIN
                                Red.GET("Reduction Type");
                                Red.CalcFields("G/L Account", "Bal. G/L Account");
                                Red.TESTFIELD("Bal. G/L Account");
                                Red.TESTFIELD("G/L Account");

                                Account := Red."G/L Account";
                                BalAccount := Red."Bal. G/L Account";


                            END;
                        END;
                    "Entry Type"::"Meal to pay":
                        BEGIN
                            PostSetup.TESTFIELD("Meal Account to pay");
                            PostSetup.TESTFIELD("Meal Bal. Account to pay");


                            Account := PostSetup."Meal Account to pay";
                            BalAccount := PostSetup."Meal Bal. Account to pay";
                            Transit := PostSetup."Meal Transit Account"
                            //Org:= "Global Dimension 1 Code";
                            //Emp:= "Employee No.";
                        END;
                    "Entry Type"::Transport:
                        BEGIN
                            PostSetup.TESTFIELD("Transport Account");
                            PostSetup.TESTFIELD("Transport Bal. Account");


                            Account := PostSetup."Transport Account";
                            BalAccount := PostSetup."Transport Bal. Account";
                            Transit := PostSetup."Transport Transit Account"
                        END;

                    "Entry Type"::Untaxable:
                        BEGIN

                            WageAdditionType.GET("Wage Addition Type");
                            WageAdditionType.CalcFields("G/L Account No.", "G/L Balance Account No.");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");

                            Account := WageAdditionType."G/L Account No.";
                            BalAccount := WageAdditionType."G/L Balance Account No.";
                            Transit := WageAdditionType."Transit Account No.";
                        END;

                    "Entry Type"::Taxable:

                        BEGIN

                            WageAdditionType.GET("Wage Addition Type");
                            WageAdditionType.CalcFields("G/L Account No.", "G/L Balance Account No.");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");
                            WageAdditionType.TESTFIELD("G/L Account No.");
                            WageAdditionType.TESTFIELD("G/L Balance Account No.");

                            Account := WageAdditionType."G/L Account No.";
                            BalAccount := WageAdditionType."G/L Balance Account No.";
                            Transit := WageAdditionType."Transit Account No.";

                        END;
                    /* "Entry Type"::Reduction:
                       BEGIN
                         AddTaxPostSetup.GET("Contribution Type","Wage Posting Group");
                         AddTaxPostSetup.TESTFIELD(Account);
                         AddTaxPostSetup.TESTFIELD("Bal. Account");

                         Account:=AddTaxPostSetup.Account;
                         BalAccount:=AddTaxPostSetup."Bal. Account";
                       END;          */
                    "Entry Type"::Use:

                        BEGIN

                            WageAdditionType.SETFILTER(Use, '%1', TRUE);
                            IF WageAdditionType.FINDFIRST THEN BEGIN
                                WageAdditionType.CalcFields("G/L Account No.", "G/L Balance Account No.");
                                WageAdditionType.TESTFIELD("G/L Account No.");
                                WageAdditionType.TESTFIELD("G/L Balance Account No.");
                                WageAdditionType.TESTFIELD("G/L Account No.");
                                WageAdditionType.TESTFIELD("G/L Balance Account No.");

                                Account := WageAdditionType."G/L Account No.";
                                BalAccount := WageAdditionType."G/L Balance Account No.";
                                Transit := WageAdditionType."Transit Account No.";
                            END;
                        END;

                END;

                GLAcc.GET(Account);
                GLAcc.CheckGLAcc();
                GLAcc.GET(BalAccount);
                GLAcc.CheckGLAcc();

                DimCode := "Global Dimension 1 Code";
                //DimCode := "Global Dimension 2 Code";
                External := "Global Dimension 1 Code";
                InsertLine := FALSE;
                IsClass3 := FALSE;

                GenJnlLine.RESET;
                //GenJnlLine.SETFILTER("Journal Template Name",TemplateName);
                //GenJnlLine.SETFILTER("Journal Batch Name",BatchName);
                //GenJnlLine.SETFILTER("Document No.",DocNo);
                WageSetupGET.Get();
                IF "Wage Calculation Type" = 0 THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 1) or ("Wage Calculation Type" = 4) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 2) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 3) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;



                GenJnlLine.SETFILTER("Account No.", Account);
                //ĐK
                GenJnlLine.SETFILTER("Bal. Account No.", BalAccount);
                //ĐK
                GenJnlLine.SETFILTER("Credit Amount", '%1', 0);
                IF COPYSTR(Account, 1, 1) = '5' THEN BEGIN
                    IsClass3 := TRUE;
                    GenJnlLine.SETFILTER("Shortcut Dimension 1 Code", External);
                END;

                IF ((GenJnlLine.FINDFIRST) AND ("Entry Type" <> "Entry Type"::Use)) THEN BEGIN
                    AppendAmount := GenJnlLine."Debit Amount Payroll" + "Cost Amount (Netto)";


                    GenJnlLine.Validate("Debit Amount Payroll", AppendAmount);

                    GenJnlLine.VALIDATE("Debit Amount", AppendAmount);
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", External);

                    GenJnlLine.MODIFY;

                    WJB.RESET;
                    WJB.SETFILTER("Account No.", '%1|%2|%3', Account, Transit, BalAccount);
                    WJB.SETFILTER("Credit Amount", '%1', 0);
                    IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                    IF WJB.FINDFIRST THEN
                        WJB."Debit Amount" += "Cost Amount (Netto)";
                    WJB.MODIFY;

                END
                ELSE BEGIN
                    WageSetupGET.Get();
                    GenJnlLine.RESET;
                    GenJnlLine.INIT;
                    IF "Wage Posting Group" = 'FBIH' THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF (("Wage Calculation Type" = 1) or ("Wage Calculation Type" = 4)) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 2) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 3) THEN BEGIN
                        GenJnlLine.VALIDATE("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.VALIDATE("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    GenJnlLine.VALIDATE("Source Code", GenJnlTemplate."Source Code");
                    GenJnlLine.VALIDATE("Reason Code", GenJnlBatch."Reason Code");
                    LastNo += 10000;
                    GenJnlLine."Line No." := LastNo;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::" ");

                    GenJnlLine.Validate("Debit Amount Payroll", "Cost Amount (Netto)");
                    GenJnlLine.VALIDATE("Debit Amount", "Cost Amount (Netto)");
                    IF (("Wage Calculation Type" = 4) AND (Round <> 2)) THEN
                        GenJnlLine."Document No." := 'DODACI ' + FORMAT("Document Date")
                    ELSE
                        IF (("Wage Calculation Type" = 0) OR (("Wage Calculation Type" = 4) AND (Round = 2))) THEN
                            GenJnlLine."Document No." := 'PLATE ' + FORMAT("Posting Date")
                        ELSE
                            GenJnlLine."Document No." := 'UOD ' + FORMAT("Document Date");
                    //NK

                    IF (("Wage Calculation Type" = 0) AND (Round = 2)) THEN BEGIN
                        IF WH.GET("Document No.") THEN
                            GenJnlLine.VALIDATE("Posting Date", WH."Closing Date")
                        ELSE
                            GenJnlLine.VALIDATE("Posting Date", TODAY);
                    END
                    ELSE BEGIN
                        IF "Employee No." = '' THEN BEGIN
                            IF WH.GET("Document No.") THEN
                                GenJnlLine.VALIDATE("Posting Date", WH."Closing Date")
                            ELSE
                                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                        END
                        ELSE BEGIN
                            GenJnlLine.VALIDATE("Posting Date", "Document Date");
                        END;
                    END;
                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Account No.", Account);
                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Bal. Account No.", BalAccount);

                    GenJnlLine.VALIDATE("Gen. Bus. Posting Group", ' ');
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", External);
                    IF GenJnlLine."Bal. Account No." = '2878110040' THEN BEGIN
                        Emp2.SETFILTER("No.", '%1', "Employee No.");
                        IF Emp2.FIND('-') THEN
                            GenJnlLine.Description := Emp2."Employee ID";
                    END;
                    GenJnlLine.INSERT;

                    WJB.RESET;
                    WJB.INIT;
                    NextWBNo += 1;
                    WJB."Entry No." := NextWBNo;
                    WJB."Account No." := Account;
                    WJB."Credit Amount" := 0;
                    WJB."Debit Amount" := "Cost Amount (Netto)";
                    WJB."Document  No." := FORMAT("Entry Type");
                    //NK IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                    IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                    WJB.INSERT;

                    /*ec IF IsClass3 THEN BEGIN
                      GenDim.INIT;
                      GenDim.VALIDATE("Table ID", DATABASE::"Gen. Journal Line");
                      GenDim.VALIDATE("Journal Template Name", GenJnlLine."Journal Template Name");
                      GenDim.VALIDATE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                      GenDim.VALIDATE("Journal Line No.", GenJnlLine."Line No.");
                      GenDim."Dimension Code":='PROJECT';
                      GenDim."Dimension Value Code":=DimCode;
                      GenDim.INSERT(TRUE);

                      {
                      DefDim.RESET;
                      DefDim.SETRANGE("Table ID",DATABASE::Employee);
                      DefDim.SETRANGE("No.","Wage Ledger Entry"."Employee No.");
                      IF DefDim.FINDFIRST THEN
                       REPEAT
                        GenDim.INIT;
                        GenDim.VALIDATE("Table ID", DATABASE::"Gen. Journal Line");
                        GenDim.VALIDATE("Journal Template Name", GenJnlLine."Journal Template Name");
                        GenDim.VALIDATE("Journal Batch Name", GenJnlLine."Journal Batch Name");
                        GenDim.VALIDATE("Journal Line No.", GenJnlLine."Line No.");
                        GenDim."Dimension Code":=DefDim."Dimension Code";
                        GenDim."Dimension Value Code":=DefDim."Dimension Value Code";
                        GenDim.INSERT(TRUE);
                       UNTIL DefDim.NEXT=0;
                       }
                     END;    */
                END;

                "Cost Posted to G/L" := "Cost Amount (Netto)";
                "G/L Account No." := Account;
                MODIFY;
                InsertLine := FALSE;
                IsClass3 := FALSE;

                GenJnlLine.RESET;
                WageSetupGET.Get();
                //GenJnlLine.SETFILTER("Journal Template Name",TemplateName);
                //GenJnlLine.SETFILTER("Journal Batch Name",BatchName);
                //GenJnlLine.SETFILTER("Document No.",DocNo);
                IF ("Wage Calculation Type" = 0) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF (("Wage Calculation Type" = 1) or ("Wage Calculation Type" = 4)) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 2) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;

                IF ("Wage Calculation Type" = 3) THEN BEGIN
                    GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                    GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    GenJnlLine.SETFILTER("Document No.", DocNo);
                END;


                GenJnlLine.SETFILTER("Account No.", '%1|%2', BalAccount, Transit);
                GenJnlLine.SETFILTER("Debit Amount", '%1', 0);
                IF (COPYSTR(Account, 1, 1) = '5') THEN BEGIN
                    IsClass3 := TRUE;
                    GenJnlLine.SETFILTER("Shortcut Dimension 1 Code", External);
                END;


                IF ((GenJnlLine.FINDFIRST) AND ("Entry Type" <> "Entry Type"::Use)) THEN BEGIN
                    AppendAmount := GenJnlLine."Credit Amount Payroll" + "Cost Amount (Netto)";
                    GenJnlLine.Validate("Credit Amount Payroll", AppendAmount);
                    GenJnlLine.VALIDATE("Credit Amount", AppendAmount);
                    GenJnlLine.MODIFY;

                    /*
                     WJB.RESET;
                     WJB.SETRANGE("Account No.",Transit);
                    // WJB.SETFILTER("Debit Amount",'%1',0);
                    //NK IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code",DimCode);
                    IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                     IF WJB.FINDFIRST THEN
                     WJB."Credit Amount" += "Cost Amount (Netto)";
                     WJB.MODIFY;

                    END
                    ELSE BEGIN
                     GenJnlLine.RESET;
                     GenJnlLine.INIT;*/
                    // GenJnlLine.VALIDATE("Journal Template Name",TemplateName);
                    // GenJnlLine.VALIDATE("Journal Batch Name",BatchName);
                    WageSetupGET.get();


                    IF ("Wage Calculation Type" = 0) THEN BEGIN
                        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");

                    END;

                    IF (("Wage Calculation Type" = 1) or ("Wage Calculation Type" = 4)) THEN BEGIN
                        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 2) THEN BEGIN
                        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
                    END;

                    IF ("Wage Calculation Type" = 3) THEN BEGIN
                        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
                        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");

                    END;

                    GenJnlLine.VALIDATE("Source Code", GenJnlTemplate."Source Code");
                    GenJnlLine.VALIDATE("Reason Code", GenJnlBatch."Reason Code");
                    LastNo += 10000;
                    GenJnlLine."Line No." := LastNo;
                    GenJnlLine.VALIDATE("Document Type", GenJnlLine."Document Type"::" ");
                    GenJnlLine.VALIDATE("Credit Amount Payroll", "Cost Amount (Netto)");
                    GenJnlLine.VALIDATE("Credit Amount", "Cost Amount (Netto)");


                    GenJnlLine."Shortcut Dimension 1 Code" := External;
                    GenJnlLine.VALIDATE("Gen. Bus. Posting Group", ' ');
                    IF (("Wage Calculation Type" = 4) AND (Round <> 2)) THEN
                        GenJnlLine."Document No." := 'DODACI ' + FORMAT("Document Date")
                    ELSE
                        IF (("Wage Calculation Type" = 0) OR (("Wage Calculation Type" = 4) AND (Round = 2))) THEN
                            GenJnlLine."Document No." := 'PLATE ' + FORMAT("Posting Date")
                        ELSE
                            GenJnlLine."Document No." := 'UOD ' + FORMAT("Document Date");

                    IF (("Wage Calculation Type" = 0) AND (Round = 2)) THEN BEGIN
                        IF WH.GET("Document No.") THEN
                            GenJnlLine.VALIDATE("Posting Date", WH."Closing Date")
                        ELSE
                            GenJnlLine.VALIDATE("Posting Date", TODAY);
                    END
                    ELSE BEGIN
                        IF "Employee No." = '' THEN BEGIN
                            IF WH.GET("Document No.") THEN
                                GenJnlLine.VALIDATE("Posting Date", WH."Closing Date")
                            ELSE
                                GenJnlLine.VALIDATE("Posting Date", "Document Date");
                        END
                        ELSE BEGIN
                            GenJnlLine.VALIDATE("Posting Date", "Document Date");
                        END;
                    END;

                    GenJnlLine.VALIDATE("Account Type", GenJnlLine."Account Type"::"G/L Account");
                    GenJnlLine.VALIDATE("Account No.", Transit);

                    GenJnlLine.VALIDATE("Bal. Account Type", GenJnlLine."Bal. Account Type"::"G/L Account");

                    GenJnlLine.VALIDATE("Bal. Account No.", Transit);
                    GenJnlLine.VALIDATE("Shortcut Dimension 1 Code", WJB."Global Dimension 1 Code");
                    IF GenJnlLine."Bal. Account No." = '2878110040' THEN BEGIN
                        Emp2.SETFILTER("No.", '%1', "Employee No.");
                        IF Emp2.FIND('-') THEN
                            GenJnlLine.Description := Emp2."Employee ID";
                    END;
                    GenJnlLine.INSERT;



                    WJB.RESET;
                    WJB.INIT;
                    NextWBNo += 1;
                    WJB."Entry No." := NextWBNo;
                    WJB."Account No." := BalAccount;
                    WJB."Debit Amount" := 0;
                    WJB."Credit Amount" := "Cost Amount (Netto)";
                    IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                    IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                    WJB.INSERT;


                END;

                "Cost Posted to G/L" := "Cost Amount (Netto)";
                "G/L Bal. Account No." := BalAccount;
                MODIFY;

                /*
                IF "Entry Type"="Entry Type"::Reduction THEN BEGIN
                
                GenJnlLine.SETFILTER("Account No.",'%1',Transit2);
                GenJnlLine.SETFILTER("Debit Amount",'%1',0);
                
                IF GenJnlLine.FINDFIRST THEN BEGIN
                 AppendAmount := GenJnlLine."Credit Amount" + "Cost Amount (Netto)";
                 GenJnlLine.VALIDATE("Credit Amount",AppendAmount);
                 GenJnlLine.MODIFY;
                
                
                 WJB.RESET;
                 WJB.SETRANGE("Account No.",Transit2);
                IF IsClass3 THEN WJB.SETRANGE("Global Dimension 1 Code", External);
                 IF WJB.FINDFIRST THEN
                 WJB."Credit Amount" += "Cost Amount (Netto)";
                 WJB.MODIFY;
                
                END
                ELSE BEGIN
                 GenJnlLine.RESET;
                 GenJnlLine.INIT;
                
                
                 IF ("Wage Calculation Type"=0)   THEN BEGIN
                GenJnlLine.VALIDATE("Journal Template Name",'OPŠTE');
                GenJnlLine.VALIDATE("Journal Batch Name",'OPŠTE');
                
                END;
                 GenJnlLine.VALIDATE("Source Code",GenJnlTemplate."Source Code");
                 GenJnlLine.VALIDATE("Reason Code",GenJnlBatch."Reason Code");
                 LastNo += 10000;
                 GenJnlLine."Line No." := LastNo;
                 GenJnlLine.VALIDATE("Document Type",GenJnlLine."Document Type"::" ");
                 GenJnlLine.VALIDATE("Credit Amount","Cost Amount (Netto)");
                
                 //NK
                 GenJnlLine."Shortcut Dimension 1 Code":=External;
                 GenJnlLine.VALIDATE("Gen. Bus. Posting Group",' ');
                  IF (("Wage Calculation Type"=4) AND (Round <>2))  THEN
                  GenJnlLine."Document No.":='DODACI '+FORMAT("Document Date")
                  ELSE IF (("Wage Calculation Type"=0) OR (("Wage Calculation Type"=4) AND (Round =2))) THEN
                 GenJnlLine."Document No.":='PLATE '+FORMAT("Posting Date")
                 ELSE
                 GenJnlLine."Document No.":='UOD '+FORMAT("Document Date");
                
                 IF (("Wage Calculation Type"=0) AND (Round =2))  THEN BEGIN
                  IF WH.GET("Document No.") THEN
                  GenJnlLine.VALIDATE("Posting Date",WH."Closing Date")
                  ELSE
                  GenJnlLine.VALIDATE("Posting Date",TODAY);
                  END
                  ELSE BEGIN
                     IF "Employee No."='' THEN BEGIN
                       IF WH.GET("Document No.") THEN
                        GenJnlLine.VALIDATE("Posting Date",WH."Closing Date")
                         ELSE
                        GenJnlLine.VALIDATE("Posting Date","Document Date");
                        END
                        ELSE BEGIN
                        GenJnlLine.VALIDATE("Posting Date","Document Date");
                        END;
                 END;
                 GenJnlLine.VALIDATE("Account Type",GenJnlLine."Account Type"::"G/L Account");
                GenJnlLine.VALIDATE("Account No.",Transit2);
                
                 GenJnlLine.VALIDATE("Bal. Account Type",GenJnlLine."Bal. Account Type"::"G/L Account");
                
                 GenJnlLine.VALIDATE("Bal. Account No.",Transit2);
                 GenJnlLine.VALIDATE("Shortcut Dimension 1 Code",WJB."Global Dimension 1 Code");
                 GenJnlLine.INSERT;
                
                END;
                */
                WJB.RESET;
                WJB.INIT;
                NextWBNo += 1;
                WJB."Entry No." := NextWBNo;
                WJB."Account No." := Transit2;
                WJB."Debit Amount" := 0;
                WJB."Credit Amount" := "Cost Amount (Netto)";
                IF IsClass3 THEN WJB."Global Dimension 1 Code" := DimCode;
                IF IsClass3 THEN WJB."Global Dimension 1 Code" := External;
                WJB.INSERT;

                "Cost Posted to G/L" := "Cost Amount (Netto)";
                "G/L Account No." := Transit2;
                MODIFY;
                InsertLine := FALSE;
                IsClass3 := FALSE;

                GenJnlLine.RESET;

                // END;


            end;

            trigger OnPreDataItem()
            begin
                FINDLAST;
                SETFILTER("Document No.", '%1', "<Wage Ledger Entry>"."Document No.");
                IF GETFILTER("Wage Addition Type") <> '' THEN
                    SETFILTER("Wage Addition Type", '%1', GETFILTER("Wage Addition Type"))
                ELSE
                    SETFILTER("Wage Addition Type", '<>%1', 'KOREKCIJA');
                // SETFILTER("Entry Type",'<>%1',"Entry Type"::Taxable);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    VAR
        wAGEv: Record "Wage Value Entry";
        GenJnlLine2rEZ: Record "Gen. Journal Line";
    begin

        MESSAGE(Txt001);
        Commit();
        GenJournalTemp.DeleteAll();
        //URADI UPDATE PA DA VIDIMO
        WageSetupGET.GET;
        GenJnlLine.RESET;



        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
        GenJnlLine.SetCurrentKey("Line No.");
        GenJnlLine.Ascending(false);
        //GenJnlLine.SETFILTER("Document No.",DocNo);
        IF GenJnlLine.FINDSET THEN
            repeat

                wAGEv.RESET;
                wAGEv.CopyFilters("<Wage Value Entry>");
                wAGEv.SetFilter("G/L Bal. Account No.", '%1', GenJnlLine."Bal. Account No.");
                IF wAGEv.FINDFIRST THEN BEGIN
                    wAGEv.CalcSums("Cost Amount (Netto)");
                    GenJnlLine2rEZ.Reset();
                    GenJnlLine2rEZ.CopyFilters(GenJnlLine);
                    GenJnlLine2rEZ.SetFilter("Bal. Account No.", '%1', GenJnlLine."Bal. Account No.");
                    IF GenJnlLine2rEZ.FindFirst() THEN BEGIN
                        GenJnlLine2rEZ.CalcSums(Amount);
                        IF ROUND(GenJnlLine2rEZ.Amount, 0.01, '=') <> ROUND(wAGEv."Cost Amount (Netto)", 0.01, '=') THEN BEGIN
                            GenJournalTemp.Reset();
                            GenJournalTemp.SetFilter("Bal. Account No.", '%1', GenJnlLine."Bal. Account No.");
                            if not GenJournalTemp.FindFirst() then begin
                                GenJnlLine.VALIDATE(AMOUNT, GenJnlLine.AMOUNT + (ROUND(wAGEv."Cost Amount (Netto)", 0.01, '=') - ROUND(GenJnlLine2rEZ.Amount, 0.01, '=')));
                                GenJnlLine.Modify();
                                GenJournalTemp.Init();
                                GenJournalTemp.TransferFields(GenJnlLine);
                                GenJournalTemp.Insert();
                                Commit();
                            end;
                        END;
                    END;

                END;


            UNTIL GenJnlLine.Next() = 0;

        //end//

        GenJournalPage.RUN;
        Commit();
    end;

    trigger OnPreReport()
    begin
        WageSetupGET.get();
        GenJnlLine.SETFILTER("Journal Template Name", WageSetupGET."Wage Journal Template");
        GenJnlLine.SETFILTER("Journal Batch Name", WageSetupGET."Wage Batch Name");
        //GenJnlLine.SETFILTER("Document No.",DocNo);
        IF GenJnlLine.FINDSET THEN GenJnlLine.DELETEALL;
    end;

    var
        WAT: Record "Wage Addition Type";
        WageSetupGET: Record "Wage Setup";
        GenJournalPage: Page "General Journal";
        PostSetup: Record "Wage Posting Groups";
        AddTaxPostSetup: Record "Contribution Posting Setup";
        GLAcc: Record "G/L Account";
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlBatch: Record "Gen. Journal Batch";
        GenJnlTemplate: Record "Gen. Journal Template";
        WageAdditionType: Record "Wage Addition Type";
        WageHeader: Record "Wage Header";
        WageSetup: Record "Wage Setup";
        TemplateName: Code[10];
        BatchName: Code[10];
        Account: Code[10];
        DocumentNoo: Code[20];
        BalAccount: Code[10];
        Transit: Code[10];
        Dimen: Record "Dimension";
        DefDim: Record "Default Dimension";
        Employee: Record "Employee";
        Red: Record "Reduction types";
        Org: Code[10];
        AccountNo: Code[10];
        BalanceAccountNo: Code[10];
        GenJnlLineForPosting: Record "Gen. Journal Line";
        GenJournalTemp: Record "Gen. Journal Line" temporary;
        External: Code[30];
        Emp: Code[10];
        NoSeriesMgt: Codeunit NoSeriesExtented;
        DocNo: Code[20];
        DimCode: Code[20];
        InsertLine: Boolean;
        IsClass3: Boolean;
        Window: Dialog;
        TotalRecNo1: Integer;
        TotalRecNo2: Integer;
        C1: Integer;
        C2: Integer;
        AppendAmount: Decimal;
        AppendAmount2: Decimal;
        LastNo: Integer;
        WJB: Record "Wage Jnl. Buffer";
        NextWBNo: Integer;
        FirstRow: Boolean;
        PostDate: Date;
        Txt001: Label 'Wage Calculation has been transfered to General journal -Wages.';
        Wve: Record "Wage Value Entry";
        Transit2: Code[10];
        TotalSum: array[30] of Decimal;
        TotalRez: array[30] of Decimal;
        AppendAmountRez: array[30] of Decimal;
        Emp2: Record "Employee";
        WH: Record "Wage Header";
        COA: Record "Cause of Absence";
        ContributionDesc: Record "Contribution";
        Desc: Text;

    procedure RoundItems()
    begin
        WJB.RESET;

        IF WJB.FINDFIRST THEN
            REPEAT
                GenJnlLine.RESET;
                GenJnlLine.SETFILTER("Journal Template Name", TemplateName);
                GenJnlLine.SETFILTER("Journal Batch Name", BatchName);
                GenJnlLine.SETFILTER("Document No.", DocNo);

                GenJnlLine.SETFILTER("Account No.", WJB."Account No.");
                IF WJB."Debit Amount" = 0 THEN
                    GenJnlLine.SETFILTER("Debit Amount", '%1', 0)
                ELSE
                    GenJnlLine.SETFILTER("Credit Amount", '%1', 0);

                IF WJB."Global Dimension 1 Code" <> '' THEN
                    GenJnlLine.SETRANGE("Shortcut Dimension 1 Code", WJB."Global Dimension 1 Code");

                GenJnlLine.FINDFIRST;
                if WJB."Debit Amount" <> 0 then
                    GenJnlLine.Validate("Debit Amount Payroll", WJB."Debit Amount")
                else
                    GenJnlLine.Validate("Credit Amount Payroll", WJB."Credit Amount");
                IF WJB."Debit Amount" <> 0 THEN
                    GenJnlLine.VALIDATE("Debit Amount", WJB."Debit Amount");
                // ELSE
                GenJnlLine.VALIDATE("Credit Amount", WJB."Credit Amount");
                //vratila

                GenJnlLine."Document No." := 'PLATE ';
                GenJnlLine.MODIFY;
            UNTIL WJB.NEXT = 0;
    end;
}