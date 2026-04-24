pageextension 50051 JournalLineDetailsFactBox extends "Journal Line Details FactBox"
{
    layout
    {
        modify(PostingGroup)
        {
            Visible = false;
        }
        modify(GenPostingSetup)
        {
            Visible = false;
        }
        modify(VATPostingSetup)
        {
            Visible = false;
        }
        modify(BalAccount)
        {
            Visible = false;
        }


        addafter(AccountName)
        {
            field("Social status"; "Social status")
            {
                Caption = 'Kategorija socijalnih slučajeva';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(Phone_Cust; Phone_Cust)
            {
                Caption = 'Kućni telefonski broj';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(MobilePhone_Cust; MobilePhone_Cust)
            {
                Caption = 'Broj mobilnog telefona';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(Email_Cust; Email_Cust)
            {
                Caption = 'E-mail';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(Address_Cust; Address_Cust)
            {
                Caption = 'Adresa';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }
            field(City_Cust; City_Cust)
            {
                Caption = 'Grad';
                ApplicationArea = All;

                trigger OnDrillDown()
                begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Show Card", Rec);
                end;
            }

            //verzija samo Billing računi

            field(Balance_Cust; Balance_Cust)
            {
                Caption = 'Saldo';
                ApplicationArea = All;
                Style = Unfavorable;
                StyleExpr = BalanceCOlor;

                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";

                begin
                    CustLedgEntry.Reset();
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
                    CustLedgEntry.SetFilter(Prepayment, '%1', false);
                    CustLedgEntry.SetRange(Open, true);
                    PAGE.Run(25, CustLedgEntry);

                    //CustLedgEntry.DrillDownOnEntries2(DtldCustLedgEntry, false);
                end;
            }


            //Avans_Cust

            field(Avans_Cust; Avans_Cust)
            {
                Caption = 'Avans_Cust';
                ApplicationArea = All;
                Style = Strong;
                //                StyleExpr = BalanceCOlor;


                trigger OnDrillDown()
                var
                    DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
                    CustLedgEntry: Record "Cust. Ledger Entry";
                begin
                    CustLedgEntry.Reset();
                    CustLedgEntry.SetRange("Customer No.", "Account No.");
                    CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
                    CustLedgEntry.SetFilter(Prepayment, '%1', false);
                    CustLedgEntry.SetRange(Open, true);
                    PAGE.Run(25, CustLedgEntry);

                    /*CopyFilter(CustomerTable."Global Dimension 1 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 1");
                    CopyFilter(CustomerTable."Global Dimension 2 Filter", DtldCustLedgEntry."Initial Entry Global Dim. 2");
                    CopyFilter("Currency Filter", DtldCustLedgEntry."Currency Code");*/

                end;
            }
            field(ServiceItemLine; ServiceItemLine)
            {
                trigger OnDrillDown()
                var

                    PostedServiceInvoice: Record "Service Invoice Header";
                    PostedServiceInvoicePage: page "Posted Service Invoices";
                begin
                    PostedServiceInvoice.Reset();
                    PostedServiceInvoice.SetFilter("No.", '%1', "Applies-to Doc. No.");
                    PostedServiceInvoicePage.SetTableView(PostedServiceInvoice);
                    PostedServiceInvoicePage.Run();


                end;


            }

            field(Accusations; Accusations)
            {

                Style = Unfavorable;
                StyleExpr = AccCOlor;
                trigger OnDrillDown()

                var

                    Accusations: Record "Accusation Header";
                    ACPage: page "Accusation Document List";
                begin
                    Accusations.Reset();
                    Accusations.SetFilter("Customer No.", '%1', "Account No.");
                    ACPage.SetTableView(Accusations);
                    ACPage.Run();

                end;


            }


            /*field(Avans_Cust; Avans_Cust)
            {
                Caption = 'Avans';
                ApplicationArea = All;
            }
            field(Complaint; Complaint)
            {
                Caption = 'Tužbe';
                ApplicationArea = All;

                /*FILTERI SA KARTONA RADNIKA - RESIDENCE PERMIT
                trigger OnDrillDown()
                begin
                    PersonalDocuments.RESET;
                    PersonalDocuments.SETFILTER("Employee No.", "No.");
                    PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                    PersonalDocuments.SETFILTER(Active, '%1', TRUE);
                    IF PersonalDocuments.FINDFIRST THEN BEGIN
                        PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                        PersonalDocumentsPage.RUN;
                    END
                    ELSE BEGIN
                        PersonalDocuments.RESET;
                        PersonalDocuments.SETFILTER("Employee No.", "No.");
                        PersonalDocuments.SETFILTER(Switch, 'Residence Permit');
                        PersonalDocumentsPage.SETTABLEVIEW(PersonalDocuments);
                        PersonalDocumentsPage.RUN;
                    END;
                    CurrPage.UPDATE;
                end;*/

            /*}
            field(Interest; Interest)
            {
                Caption = 'Kamate';
                ApplicationArea = All;
            }*/
        }





    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        TotalAmount: Decimal;
    begin

        /*  Balance_Cust := 0;
          Avans_Cust := 0;
          CustLedgEntry.Reset();
          CustLedgEntry.SetRange("Customer No.", "Account No.");
          CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
          CustLedgEntry.SetFilter(Prepayment, '%1', false);
          CustLedgEntry.SetRange(Open, true);
          if CustLedgEntry.FindSet() then
              repeat
                  CustLedgEntry.CalcFields("Amount (LCY)");
                  Balance_Cust += CustLedgEntry."Amount (LCY)";
              until CustLedgEntry.Next() = 0;


          CustLedgEntry.Reset();
          CustLedgEntry.SetRange("Customer No.", "Account No.");
          CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
          CustLedgEntry.SetFilter(Prepayment, '%1', true);
          CustLedgEntry.SetRange(Open, true);
          if CustLedgEntry.FindSet() then
              repeat
                  CustLedgEntry.CalcFields("Amount (LCY)");
                  Avans_Cust += CustLedgEntry."Amount (LCY)";
              until CustLedgEntry.Next() = 0;
  */
        //EK
        Balance_Cust := 0;
        Avans_Cust := 0;
        TotalAmount := 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", "Account No.");
        CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
        CustLedgEntry.SetFilter(Prepayment, '%1', false);
        CustLedgEntry.SetRange(Open, true);

        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Amount (LCY)");
                TotalAmount += CustLedgEntry."Amount (LCY)";
            until CustLedgEntry.Next() = 0;

        // LOGIKA:
        Balance_Cust := TotalAmount;
        if TotalAmount < 0 then
            Avans_Cust := Abs(TotalAmount)
        else
            Avans_Cust := 0;

        //EK
        if Balance_Cust > 0 then
            BalanceCOlor := true
        else
            BalanceCOlor := False;

        if Accusations > 0 then
            AccCOlor := true
        else
            AccCOlor := false;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        TotalAmount: Decimal;


    begin
        //EK
        /*    Balance_Cust := 0;
            Avans_Cust := 0;
            CustLedgEntry.Reset();
            CustLedgEntry.SetRange("Customer No.", "Account No.");
            CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
            CustLedgEntry.SetFilter(Prepayment, '%1', false);
            CustLedgEntry.SetRange(Open, true);
            if CustLedgEntry.FindSet() then
                repeat
                    CustLedgEntry.CalcFields("Amount (LCY)");
                    Balance_Cust += CustLedgEntry."Amount (LCY)";
                until CustLedgEntry.Next() = 0;


            CustLedgEntry.Reset();
            CustLedgEntry.SetRange("Customer No.", "Account No.");
            CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
            CustLedgEntry.SetFilter(Prepayment, '%1', true);
            CustLedgEntry.SetRange(Open, true);
            if CustLedgEntry.FindSet() then
                repeat
                    CustLedgEntry.CalcFields("Amount (LCY)");
                    Avans_Cust += CustLedgEntry."Amount (LCY)";
                until CustLedgEntry.Next() = 0;

    */
        //EK
        Balance_Cust := 0;
        Avans_Cust := 0;
        TotalAmount := 0;

        CustLedgEntry.Reset();
        CustLedgEntry.SetRange("Customer No.", "Account No.");
        CustLedgEntry.SetFilter("Bill type", '%1|%2|%3|%4|%5|%6', '01', '1', '02', '2', '03', '3');
        CustLedgEntry.SetFilter(Prepayment, '%1', false);
        CustLedgEntry.SetRange(Open, true);

        if CustLedgEntry.FindSet() then
            repeat
                CustLedgEntry.CalcFields("Amount (LCY)");
                TotalAmount += CustLedgEntry."Amount (LCY)";
            until CustLedgEntry.Next() = 0;

        Balance_Cust := TotalAmount;
        if TotalAmount < 0 then
            Avans_Cust := Abs(TotalAmount)
        else
            Avans_Cust := 0;


        //EK

        if Balance_Cust > 0 then
            BalanceCOlor := true
        else
            BalanceCOlor := False;

        if Accusations > 0 then
            AccCOlor := true
        else
            AccCOlor := false;

    end;

    procedure CalcAvans(): Decimal
    begin

        if Avans_Cust > 0 then
            exit(Avans_Cust);


        if Balance_Cust < 0 then
            exit(Abs(Balance_Cust));


        exit(0);
    end;

    var
        BalanceCOlor: boolean;
        AccCOlor: Boolean;
        Balance_Cust: Decimal;
        CustLedgEntry: Record "Cust. Ledger Entry";
        Avans_Cust: Decimal;
        BalanceStyle: Option "None","Standard","StandardAccent","Strong","StrongAccent","Attention","AttentionAccent","Favorable","Unfavorable","Ambiguous","Subordinate";
        AvansCustVar: Decimal;
}