page 50206 "Accusation Role Activities"
{
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = "Payroll Cue";
    RefreshOnActivate = true;

    layout
    {

        area(content)
        {
            field(WORKDATE; WORKDATE)
            {
                Caption = 'WorkDate';
                ApplicationArea = all;
            }

            cuegroup(Reminders)
            {
                Caption = 'Reminders';
                field("New Reminders"; "New Reminders")
                {
                    DrillDownPageId = "Reminder List";
                    trigger OnDrillDown()
                    var
                        Reminder: Record "Reminder Header";
                        ReminderPage: Page "Reminder List";
                    begin
                        Reminder.RESET;
                        Reminder.SetRange("Document Date", Today - 10, Today);
                        ReminderPage.SETTABLEVIEW(Reminder);
                        ReminderPage.RUN;
                        CurrPage.UPDATE(true);
                    end;

                }
            }

            cuegroup(ReminderCategories)
            {


                Caption = 'Reminders Per Category';
                field("Household"; Category::Household)
                {
                    ApplicationArea = all;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin

                        reminder.setCategory(Category::Household);
                        reminder.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::Household);
                        reminder.Run();
                    end;
                }
                field("SmallEconomy"; Category::"Small Economy")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"Small Economy");
                        reminder.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"Small Economy");
                        reminder.Run();
                    end;
                }


                field("LargeEconomy"; Category::"Large Economy")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"Large Economy");
                        reminder.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"Large Economy");
                        reminder.Run();
                    end;
                }
                field(HeatingPlant; Category::"KJKP Heating plant")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"KJKP Heating plant");
                        reminder.Run();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        reminder: Report AccusationReminder;
                    begin
                        reminder.setCategory(Category::"KJKP Heating plant");
                        reminder.Run();
                    end;
                }


            }
            cuegroup(Proceedings)
            {
                Caption = 'Proceedings';
                field("Criminal Proceedings"; AccusationType::"Criminal proceedings")
                {
                    ApplicationArea = all;
                    Visible = true;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Criminal proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Criminal proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;
                }

                field("Litigation Proceedings"; AccusationType::"Criminal proceedings")
                {
                    ApplicationArea = all;
                    Visible = true;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Litigation proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Litigation Proceedings");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;
                }

                field("Executive Litigations"; AccusationType::"Criminal proceedings")
                {
                    ApplicationArea = all;
                    Visible = true;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Executive Procedure");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Current Accusation Type", '%1', AccusationType::"Executive Procedure");
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;
                }
            }
            cuegroup(Limitations)
            {
                Caption = 'Limitations';
                field("Statue Limitations"; "Statue Limitations")
                {
                    ApplicationArea = all;
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetRange("Statue of Limitation Date", Today - 10, Today);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetRange("Statue of Limitation Date", Today - 10, Today);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;

                }
            }
            cuegroup(Reprogrammed)
            {
                Caption = 'Reprogrammed';


                field("Reprogram"; "Reprogram")
                {
                    ApplicationArea = all;


                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Reprogrammed Debt", '%1', true);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        accDocuments: page "Accusation Document List";
                        accusations: Record "Accusation Header";
                    begin
                        accusations.Reset();
                        accusations.SetFilter("Reprogrammed Debt", '%1', true);
                        accDocuments.SETTABLEVIEW(accusations);
                        accDocuments.RUN;
                    end;
                }

            }




        }
    }

    actions
    {


    }


    trigger OnOpenPage()
    begin
        RESET;
        IF NOT GET THEN BEGIN
            INIT;
            INSERT;
        END;


        LocationF := '';

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin

            if UserSetup."CNG User" = true then begin

                LocationT.Reset();
                LocationT.SetFilter("CNG MP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';

                LocationT.Reset();
                LocationT.SetFilter("CNG VP", '%1', true);
                if LocationT.FindFirst() then
                    LocationF += LocationT.Code + '|';


            end
            else begin

                WE.Reset();
                WE.SetFilter("User ID", '%1', UserId);
                if WE.FindSet() then
                    repeat
                        LocationF += we."Location Code" + '|';

                    until WE.Next() = 0;


            end;

            if (LocationF <> '') and (StrLen(LocationF) >= 2) then begin
                LocationF := CopyStr(LocationF, 1, StrLen(LocationF) - 1);
            end
        end;
        //
        SalesOr.Reset;
        SalesOr.SetFilter("Document Type", '%1', SalesOr."Document Type"::Order);
        if LocationF <> '' then begin
            SalesOr.SetFilter("Location Filter", LocationF);
            if SalesOr.FindFirst() // [THEN] z
            then
                SalesOrdersOpen := SalesOr.Count
            else
                SalesOrdersOpen := 0;
        end;
        SetRange("Date Filter 2", CALCDATE('<-10D>', WorkDate), WorkDate);
    end;

    var

        SalesOrdersOpen: Integer;
        SalesOr: Record "Sales Header";
        LocationF: Text[1024];
        UserSetup: Record "User Setup";
        LocationT: Record Location;
        WE: Record "Warehouse Employee";

}


