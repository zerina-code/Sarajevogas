page 50176 "Calculation Step 1"
{
    Caption = 'Calculation Step 1';
    PageType = Card;
    SourceTable = "Calcuation Header";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Code)
                {

                    ApplicationArea = all;
                }
                field("Year of Calculation"; "Year of Calculation") { ApplicationArea = all; Editable = false; }
                field("Month of Calculation"; "Month of Calculation") { ApplicationArea = all; Editable = false; }
                field("All Customer"; "All Customer") { ApplicationArea = all; }
                field("Include Neactive"; "Include Neactive") { Visible = false; }
                field("Include Quartaly"; "Include Quartaly") { }
                field("Summer or Winter Zone"; "Summer or Winter Zone") { }
                field("Category Calculation"; "Category Calculation")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        TypeOption: Label 'Normal,Fixed Add,Average Add,Average Coefficient Add;';
                        CalcHeader: Record "Calcuation Header";
                        CalcHeader2: Record "Calcuation Header";
                        GaugeV: Record "Installation History";
                        InstallHistory: Record "Installation History";
                        Customer: Record Customer;
                    begin

                        /* GaugeV.Reset();
                         GaugeV.SetFilter("Calculation Valide", '%1', true);
                         GaugeV.SetFilter("Customer Category", '%1', Rec."Category Calculation");
                         if GaugeV.FindSet() then
                             repeat
                                 GaugeV."Calculation Valide" := false;
                                 GaugeV.Modify();
                                 Commit();
                             until GaugeV.Next() = 0*/

                        /*ĐK     Customer.Reset();
                            Customer.SetFilter("Customer Category", '%1', Rec."Category Calculation");
                            Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                            if Customer.FindSet() then
                                repeat


                                    InstallHistory.Reset();

                                    InstallHistory.SetFilter("Dismantling date", '<=%1|>=%2|%3', "Calculation Date To", "Calculation Date From", 0D);
                                    //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023

                                    InstallHistory.SetFilter("Installation Date", '<=%1', "Calculation Date From");
                                    InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Gauge);
                                    InstallHistory.SetFilter("Customer No.", '%1', Customer."No.");
                                    if InstallHistory.FindSet() then
                                        repeat
                                                GaugeV.Reset();
                                                 //DJEMINA 2 POSLIJE   GaugeV.SetFilter(code, '%1', InstallHistory.Code);
                                                 GaugeV.SetFilter("Measuring Point", '%1', InstallHistory."Measuring Point Code");
                                                 ///   GaugeV.SetFilter("Status Gauge",'%1',Ga);
                                                 if GaugeV.FindFirst() then begin
                                                     GaugeV."Calculation Valide" := true;
                                                     GaugeV.Modify();
                                                 end;
                                            InstallHistory."Calculation Valide" := true;
                                            InstallHistory.Modify();

                                        until InstallHistory.Next() = 0;
                                until Customer.Next() = 0;
    */
                    end;


                }
                field("Undo Calculation"; "Undo Calculation") { }
                field(Split; Split) { }
                field("Add New"; "Add New") { }
                field("Contact Phone No."; "Contact Phone No.") { }
                field(Comment; Comment) { }
                field("Sales Invoice without VAT"; "Sales Invoice without VAT") { ApplicationArea = all; Visible = false; }
                field("Sales invoice Without M"; "Sales invoice Without M") { ApplicationArea = all; Visible = false; }
                field("Entry No."; "Entry No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                group(Period)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;

                    field("Month Of GAS Calculation"; "Month Of GAS Calculation")
                    {
                        BlankZero = true;
                        Style = Unfavorable;
                        StyleExpr = true;
                        ApplicationArea = all;




                    }
                    field("Year Of GAS Calculation"; "Year Of GAS Calculation")
                    {
                        Style = Unfavorable;
                        StyleExpr = TRUE;
                        ApplicationArea = all;
                    }
                    field("Calculation Date From"; "Calculation Date From") { ApplicationArea = all; }
                    field("Calculation Date To"; "Calculation Date To") { ApplicationArea = all; }
                    field(Status; Status) { }

                }
            }
            part("Installation History"; "Installation History")

            {
                Caption = 'Gauge List';
                ApplicationArea = all;
                Editable = false;
                SubPageLink = "Customer Category Filter" = field("Category Calculation"), "Dismantling date" = field("Date Filter 2"), Type = filter(Gauge), "Installation Date" = field("Date Filter");
                //, "Installation Date" = field("Date Filter"), Type = filter(Gauge), "Dismantling date" = field("Date Filter 2");


            }

        }
    }

    actions
    {
        area(processing)
        {
            action(Next)
            {
                Image = NextSet;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = all;

                trigger OnAction()
                var
                    Gauges: Record "Installation History";
                    FIlters: text[250];
                    CalculatioList: page "Calculation List";
                    CAlJournal: Record "Calculation Journal Line";
                    CAlJournal2: Record "Calculation Journal Line";
                    US: Record "User Setup";
                    CHF: Record "Calcuation Header";
                    ReportUndo: Report "Undo Calculation";




                begin

                    if rec."Undo Calculation" = true then begin
                        //sada ide opcija dodaj storno
                        //
                        Clear(ReportUndo);
                        ReportUndo.SetParam2(Rec.Code);
                        ReportUndo.Run();

                    end
                    else begin

                        //da se kreira forma očitačke liste koja ima listu svih mjerača koji su odabrani u listi
                        CAlJournal.Reset();
                        CAlJournal.SetFilter(Code, '%1', Rec.Code);
                        if rec."All Customer" = false then
                            CAlJournal.SetFilter("Category Customer", '%1', Rec."Category Calculation");

                        if CAlJournal."Category Customer" = CAlJournal."Category Customer"::"Large Economy" then
                            CAlJournal.SetFilter("Category Customer", '%1|%2', Rec."Category Calculation", rec."Category Calculation"::"KJKP Heating plant")
                        else
                            CAlJournal.SetFilter("Category Customer", '%1', Rec."Category Calculation");

                        CAlJournal.SetFilter(Locked, '%1', false);
                        if rec."Add New" = true then
                            CAlJournal.SetFilter(Code, '%1', 'Djemina');
                        if not CAlJournal.FindFirst() then begin
                            //   CAlJournal.DeleteAll();
                            //  FIlters := CurrPage.Gauges.PAGE.GetF(Rec.Code);
                            filters := CurrPage."Installation History".Page.getf(rec.Code);



                        end
                        else begin
                            if rec."Category Calculation" = rec."Category Calculation"::Household then begin
                                CHF.Reset();
                                CHF.SetFilter(Code, '%1', rec.Code);
                                if CHF.FindFirst() then begin
                                    if (CHF.I = false)
                                    or (chf.II = false)
                                    or (chf.III = false)
                                    or (chf.IV = false)
                                    or (chf.V = false)
                                    or (chf.VI = false)
                                    or (chf.VII = false)
                                    or (chf.VIII = false)
                                    or (chf.IX = false)
                                    or (chf.X = false)
                                    then
                                        filters := CurrPage."Installation History".Page.getf(rec.Code);
                                end;
                            end;
                        end;
                        US.Reset();
                        US.SetFilter("User ID", '%1', UserId);
                        if Us.FindFirst() then begin
                            us."Entries or Calculation" := true;
                            us.Modify();
                            CAlJournal2.Reset();
                            CAlJournal2.SetFilter(Locked, '%1', false);
                            CAlJournal2.SetFilter(Code, '%1', rec.Code);
                            CalculatioList.SetTableView(CAlJournal2);
                            CalculatioList.Run();
                        end;
                        //ĐK Gauges.reset;
                        //ĐK Gauges.setrange(CurrPage.Gauges.PAGE.GetF());



                    end;






                end;
            }
            action(Cancel)
            {
                Image = Cancel;
                ApplicationArea = all;

                trigger OnAction()
                var
                    US: Record "User Setup";
                begin
                    CurrPage.CLOSE;
                    US.Reset();
                    US.SetFilter("User ID", '%1', UserId);
                    if Us.FindFirst() then begin
                        us."Entries or Calculation" := false;
                        us.Modify();
                    end;
                end;
            }
        }
    }
    var
        GaugeGet: Record Gauge;

    trigger OnAfterGetRecord()
    begin


    end;

    trigger OnClosePage()
    var
        US: Record "User Setup";
    begin
        US.Reset();
        US.SetFilter("User ID", '%1', UserId);
        if Us.FindFirst() then begin
            us."Entries or Calculation" := false;
            us.Modify();

        end;
    end;

    /*trigger OnInit()
    var
        CalcHeader: Record "Calcuation Header";
    begin


    end;*/

    trigger OnOpenPage()
    var
        TypeOption: Label 'Normal,Fixed Add,Average Add,Average Coefficient Add;';
        CalcHeader: Record "Calcuation Header";
        CalcHeader2: Record "Calcuation Header";
        GaugeV: Record "Installation History";
        InstallHistory: Record "Installation History";
        Customer: Record customer;
        Text01: Label 'Do you want to create a new calculation?';
        IH: Record "Installation History";
        IH2: Record "Installation History";
    //ovdje dodati datume
    begin


        if Confirm(Text01) then begin

            Rec.Init();
            Rec.Status := Rec.Status::Open;
            Rec.validate("Year Of GAS Calculation", Date2DMY(today, 3));

            Rec.validate("Month Of GAS Calculation", Date2DMY(Today, 2));
            Rec."Year of Calculation" := Date2DMY(today, 3);
            Rec."Month of Calculation" := Date2DMY(Today, 2);
            CalcHeader.Reset();
            CalcHeader.SetCurrentKey(Code);
            CalcHeader.Ascending;
            Code := '000000000000000';

            Rec."Year of Calculation" := Date2DMY(Today, 3);
            Rec."Month of Calculation" := Date2DMY(Today, 2);
            if CalcHeader.FindLast() then begin
                Code := IncStr(CalcHeader.Code);
            end;


            Rec.Insert();

        end
        else begin

            CalcHeader2.Reset();
            // CalcHeader2.SetFilter("Year Of GAS Calculation", '%1', Date2DMY(today, 3));
            //  CalcHeader2.SetFilter("Month Of GAS Calculation", '%1', Date2DMY(today, 2));
            CalcHeader2.SetFilter(Status, '%1', CalcHeader2.Status::Open);
            if not CalcHeader2.FindFirst() then begin
                Rec.Init();
                Rec.Status := Rec.Status::Open;
                Rec.validate("Year Of GAS Calculation", Date2DMY(today, 3));

                Rec.validate("Month Of GAS Calculation", Date2DMY(Today, 2));
                Rec."Year of Calculation" := Date2DMY(today, 3);
                Rec."Month of Calculation" := Date2DMY(Today, 2);
                CalcHeader.Reset();
                CalcHeader.SetCurrentKey(Code);
                CalcHeader.Ascending;
                Code := '000000000000000';

                Rec."Year of Calculation" := Date2DMY(Today, 3);
                Rec."Month of Calculation" := Date2DMY(Today, 2);
                if CalcHeader.FindLast() then begin
                    Code := IncStr(CalcHeader.Code);
                end;


                Rec.Insert();


                /*    Customer.Reset();
                    if Rec."All Customer" = false then
                        Customer.SetFilter("Customer Category", '%1', Rec."Category Calculation");
                    Customer.SetFilter("Customer Status", '%1', Customer."Customer Status"::Active);
                    if Customer.FindSet() then
                        repeat

                            InstallHistory.Reset();
                            InstallHistory.SetFilter("Dismantling date", '<=%1|>=%2|%3', "Calculation Date To", "Calculation Date From", 0D);
                            //datum za demontažu mora biti <=Datum Do (Jer ako obračunavam 6 mjesec, trebalo bi biti svi oni kod kojih je demontaža bila <=30.06.2023

                            InstallHistory.SetFilter("Installation Date", '<=%1', "Calculation Date From");
                            InstallHistory.SetFilter(Type, '%1', InstallHistory.Type::Gauge);
                            InstallHistory.SetFilter("Customer No.", '%1', customer."No.");
                            if InstallHistory.FindSet() then
                                repeat
                                    GaugeV.Reset();
                                       GaugeV.SetFilter(code, '%1', InstallHistory.Code);
                                       GaugeV.SetFilter("Measuring Point", '%1', InstallHistory."Measuring Point Code");
                                       if GaugeV.FindFirst() then begin
                                           GaugeV."Calculation Valide" := true;
                                           GaugeV.Modify();

                                    InstallHistory."Calculation Valide" := true;
                                    InstallHistory.Modify();

                                until InstallHistory.Next() = 0;
                        until Customer.Next() = 0;*/

            end;
        end;


        SetFilter("Date Filter", '<=%1', "Calculation Date To");
        SetFilter("Date Filter 2", '<=%1 & >=%2|>=%3|%4', calcdate('<-1M>', "Calculation Date From"), "Calculation Date To", "Calculation Date From", 0D);
        if "Category Calculation" = "Category Calculation"::"Large Economy" then
            SetFilter("Category Calculation", '%1|%2', "Category Calculation"::"KJKP Heating plant", "Category Calculation"::"Large Economy")
        else
            SetFilter("Category Calculation", '%1', rec."Category Calculation");
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        //bt

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin

        //  SetFilter("Date Filter", '<=%1', "Calculation Date To");
        //SetFilter("Date Filter 2", '<=%1 & >=%2|>=%3|%4', calcdate('<-1M>', "Calculation Date From"), "Calculation Date To", "Calculation Date From", 0D);

        SetFilter("Date Filter", '<=%1', Rec."Calculation Date To");
        SetFilter("Date Filter 2", '<=%1 & >=%2|>=%3|%4', calcdate('<-1M>', Rec."Calculation Date From"), Rec."Calculation Date To", Rec."Calculation Date From", 0D);
        if "Category Calculation" = "Category Calculation"::"Large Economy" then
            SetFilter("Category Calculation", '%1|%2', Rec."Category Calculation"::"KJKP Heating plant", Rec."Category Calculation"::"Large Economy")
        else
            SetFilter("Category Calculation", '%1', rec."Category Calculation");
    end;

}

