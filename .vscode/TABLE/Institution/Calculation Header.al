table 50105 "Calcuation Header"
{
    Caption = 'Calcuation Header';
    DrillDownPageId = "Calc. List";
    LookupPageId = "Calc. List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            NotBlank = true;
            //definisati brojčanu seriju
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Year of Calculation"; Integer)
        {
            Caption = 'Year of Calculation';
        }
        field(4; "Month of Calculation"; Integer)
        {
            Caption = 'Month of Calculation';
        }
        field(5; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(50; Status; Option)
        {
            Caption = 'Status';
            Description = ',Open,Close,Locked';
            OptionCaption = ',Open,Closed,Locked';
            OptionMembers = ,Open,Closed,Locked;
            trigger OnValidate()
            var
                myInt: Integer;
                CSetup: Record "Calculation Setup";
                CJL: Record "Calculation Journal Line";
            begin
                CSetup.get;
                if (xrec.Status = xRec.Status::open)
                and (rec.Status <> rec.Status::Open) then begin
                    CSetup.get;
                    rec."Calorific power coefficient" := CSetup."Calorific power coefficient";

                end;
                if Confirm('Da li ste sigurni da želite zaključati obračun, više nećete moći ništa mijenjati na ovom obračunu?') then begin
                    if rec.Status = rec.Status::Locked then begin
                        CJL.Reset();
                        cjl.SetFilter(Code, '%1', rec.Code);
                        cjl.SetFilter(locked, '%1', false);
                        cjl.ModifyAll(locked, true, false);

                    end;
                end;
            end;
        }
        field(70; "Month Of GAS Calculation"; Integer)
        {
            Caption = 'Month of GAS Calculation';
            Description = 'Month for which the wage is calculated and paid';

            trigger OnValidate()
            var
                CH: Record "Calcuation Header";

            begin
                if ("Month Of GAS Calculation" <> 0) and ("Year Of GAS Calculation" <> 0) then begin
                    "Calculation Date From" := ABS.GetMonthRange("Month Of GAS Calculation", "Year Of GAS Calculation", TRUE);
                    "Calculation Date To" := ABS.GetMonthRange("Month Of GAS Calculation", "Year Of GAS Calculation", FALSE);





                end;

                /*    GaugeV.Reset();
                    GaugeV.SetFilter("Calculation Valide", '%1', true);
                    if GaugeV.FindSet() then
                        repeat
                            GaugeV."Calculation Valide" := false;
                            GaugeV.Modify();
                            Commit();
                        until GaugeV.Next() = 0;
                    InstallHistory.Reset();
                    InstallHistory.SetFilter("Dismantling date", '<=%1', "Calculation Date To");
                    InstallHistory.SetFilter("Installation Date", '>=%1', "Calculation Date From");
                    if InstallHistory.FindSet() then
                        repeat

                            InstallHistory."Calculation Valide" := true;
                            InstallHistory.Modify();

                        until InstallHistory.Next() = 0;
    */
            end;
        }
        field(75; "Year Of GAS Calculation"; Integer)
        {
            Caption = 'Year of GAS Calculation';
            Description = 'Year for which the wage is calculated and paid';

            trigger OnValidate()
            var
                CH: Record "Calcuation Header";
            begin
                if ("Month Of GAS Calculation" <> 0) and ("Year Of GAS Calculation" <> 0) then begin
                    "Calculation Date From" := ABS.GetMonthRange("Month Of GAS Calculation", "Year Of GAS Calculation", TRUE);
                    "Calculation Date To" := ABS.GetMonthRange("Month Of GAS Calculation", "Year Of GAS Calculation", FALSE);


                    /*    GaugeV.Reset();
                        GaugeV.SetFilter("Calculation Valide", '%1', true);
                        if GaugeV.FindSet() then
                            repeat
                                GaugeV."Calculation Valide" := false;
                                GaugeV.Modify();
                                Commit();
                            until GaugeV.Next() = 0;
                        InstallHistory.Reset();
                        InstallHistory.SetFilter("Dismantling date", '<=%1', "Calculation Date To");
                        InstallHistory.SetFilter("Installation Date", '>=%1', "Calculation Date From");
                        if InstallHistory.FindSet() then
                            repeat
                                   GaugeV.Reset();
                                    GaugeV.SetFilter(code, '%1', InstallHistory.Code);
                                    GaugeV.SetFilter("Measuring Point", '%1', InstallHistory."Measuring Point Adress");
                                    if GaugeV.FindFirst() then begin
                                        GaugeV."Calculation Valide" := true;
                                        GaugeV.Modify();
                                    end;
                                InstallHistory."Calculation Valide" := true;
                                InstallHistory.Modify();

                            until InstallHistory.Next() = 0;*/

                end;
            end;
        }

        field(76; "Category Calculation"; enum Category)
        {
            Caption = 'Category Calculation';
            Description = 'Category Calculation';

            trigger OnValidate()
            var
                BilP: Record "Customer Templ.";
            begin
                BilP.Reset();
                BilP.SetFilter("Bill Category", '%1', rec."Category Calculation");
                if BilP.FindFirst() then
                    "Contact Phone No." := BilP."Contact Phone";

            end;
        }

        field(78; "Sales Invoice without VAT"; Boolean)
        {
            Caption = 'Sales Invoice without VAT';
        }
        field(79; "Sales invoice Without M"; Boolean)
        {
            Caption = 'sales invoice without maintenance';
        }

        field(80; "Calculation Date From"; Date)
        {
            Caption = 'Calculation Date From';
            trigger Onvalidate()
            var
                myInt: Integer;
                Us: Record "User Setup";
            begin
                us.Reset();
                us.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    us."Calc Date from" := rec."Calculation Date From";
                    us."Calc Date to" := rec."Calculation Date To";
                    us.Modify();
                end;
                /*  GaugeV.Reset();
                  GaugeV.SetFilter("Calculation Valide", '%1', true);
                  if GaugeV.FindSet() then
                      repeat
                          GaugeV."Calculation Valide" := false;
                          GaugeV.Modify();
                          Commit();
                      until GaugeV.Next() = 0;
                  InstallHistory.Reset();
                  InstallHistory.SetFilter("Dismantling date", '<=%1', "Calculation Date To");
                  InstallHistory.SetFilter("Installation Date", '>=%1', "Calculation Date From");
                  if InstallHistory.FindSet() then
                      repeat

                          InstallHistory."Calculation Valide" := true;
                          InstallHistory.Modify();

                      until InstallHistory.Next() = 0;
  */
            end;
        }
        field(82; "All Customer"; Boolean)
        {
            Caption = 'All Customer';
        }
        field(81; "Calculation Date To"; Date)
        {
            Caption = 'Calculation Date To';
            trigger OnValidate()
            var
                myInt: Integer;
                us: Record "User Setup";

            begin
                /*   GaugeV.Reset();
                   GaugeV.SetFilter("Calculation Valide", '%1', true);
                   if GaugeV.FindSet() then
                       repeat
                           GaugeV."Calculation Valide" := false;
                           GaugeV.Modify();
                           Commit();
                       until GaugeV.Next() = 0;
                   InstallHistory.Reset();
                   InstallHistory.SetFilter("Dismantling date", '<=%1', "Calculation Date To");
                   InstallHistory.SetFilter("Installation Date", '>=%1', "Calculation Date From");
                   if InstallHistory.FindSet() then
                       repeat

                           InstallHistory."Calculation Valide" := true;
                           InstallHistory.Modify();
                       until InstallHistory.Next() = 0;

                       */

                us.Reset();
                us.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    us."Calc Date from" := rec."Calculation Date From";
                    us."Calc Date to" := rec."Calculation Date To";
                    us.Modify();
                end;



            end;
        }
        field(500083; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(500084; "Date Filter 2"; date)
        {
            FieldClass = FlowFilter;
        }
        field(500085; "First Step"; Boolean)
        {
            Caption = 'First Step';
        }

        field(500086; "Include Quartaly"; Boolean)
        {
            Caption = 'Include Quartaly';
        }
        field(500087; "Calculate Month Q."; Integer)
        {
            Caption = 'Calculate Month Quartaly';
        }
        field(500088; "Include Neactive"; Boolean)
        {
            Caption = 'Include Neactive';
        }
        field(500089; "Summer or Winter Zone"; Option)
        {
            Caption = 'Summer or Winter Zone';

            OptionCaption = ' ,Summer,Winter';
            OptionMembers = " ",Summer,Winter;
        }
        field(50020; "Billing Signatory"; BLOB)
        {
            Caption = 'Billing Signatory';
            SubType = Bitmap;

            trigger OnValidate()
            begin

            end;
        }

        field(50021; "Billing Signatory Emp"; Code[20])
        {
            Caption = 'Billing Signatory Emp"';

        }
        field(50022; "Billing Signatory Position"; Text[250])
        {
            Caption = 'Billing Signatory Position';

        }
        field(50023; "Contact Phone No."; Text[250])
        {
            Caption = 'Contact Phone No.';

        }

        field(50024; "Comment"; Text[500])
        {
            Caption = 'Comment';

        }
        field(50025; "Billing Sign"; BLOB)
        {
            Caption = 'Billing Sign';
            SubType = Bitmap;

            trigger OnValidate()
            begin

            end;
        }
        field(50026; "Calorific power coefficient"; Decimal)
        {
            Caption = 'Calorific power coefficient';
            DecimalPlaces = 1 : 6;
        }

        field(50027; "I"; Boolean)
        {
            Caption = 'I';
        }
        field(50028; "II"; Boolean)
        {
            Caption = 'II';
        }
        field(50029; "III"; Boolean)
        {
            Caption = 'III';
        }
        field(50030; "IV"; Boolean)
        {
            Caption = 'IV';
        }
        field(50031; "V"; Boolean)
        {
            Caption = 'V';
        }
        field(50032; "VI"; Boolean)
        {
            Caption = 'VI';
        }
        field(50033; "VII"; Boolean)
        {
            Caption = 'VII';
        }
        field(50034; "VIII"; Boolean)
        {
            Caption = 'VIII';
        }
        field(50035; "IX"; Boolean)
        {
            Caption = 'IX';
        }
        field(50036; "X"; Boolean)
        {
            Caption = 'X';
        }
        field(50037; "Split"; Boolean)
        {
            Caption = 'Split';
        }
        Field(50038; "Add New"; Boolean)
        {
            Caption = 'Add again';
        }
        Field(50039; "Undo Calculation"; Boolean)
        {
            Caption = 'Undo Calculation';
        }





    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; Description)
        {
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
        CalcHeader: Record "Calcuation Header";
        CompInf: Record "Company Information";
        ECL: Record "Employee Contract Ledger";


    begin
        CompInf.get;
        rec."Billing Signatory" := CompInf."Billing Signatory";
        rec."Billing Sign" := CompInf."Billing Sign";
        rec."Billing Signatory Emp" := CompInf."Billing Signatory Emp";
        ECL.Reset();
        ECL.SetFilter("Employee No.", '%1', rec."Billing Signatory Emp");
        ecl.SetFilter(Active, '%1', true);
        if ecl.FindFirst() then
            rec."Billing Signatory Position" := ecl."Position Description"
        else
            rec."Billing Signatory Position" := '';
    end;

    trigger OnDelete()
    var
        myInt: Integer;
        CJL: Record "Calculation Journal Line";
    begin
        CJL.Reset();
        CJL.SetFilter(Code, '%1', Rec.Code);
        cjl.SetFilter(Locked, '%1', true);
        if CJL.FindFirst() then
            Error('Postoji barem jedan račun za ovaj obračun zbog čega ne možete obrisati isti!');


        CJL.Reset();
        CJL.SetFilter(Code, '%1', Rec.Code);
        cjl.SetFilter(Locked, '%1', false);
        if cjl.FindFirst() then
            cjl.DeleteAll();


    end;

    var
        ABS: Codeunit "Absence Fill";
        GaugeV: Record "Installation History";
        InstallHistory: Record "Installation History";
}

