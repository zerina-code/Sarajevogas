table 50170 "Status History MM"

{
    DrillDownPageId = "Status history MM";
    LookupPageId = "Status history MM";
    Caption = 'Status History';


    fields
    {
        field(1; "Integer"; Integer)
        {
            AutoIncrement = true;

        }
        field(2; "Insert Date and Time"; DateTime)
        {
            Caption = 'Insert Date and Time';

        }
        field(3; "Insert User ID"; Code[50])
        {
            Caption = 'Insert User ID';

        }
        field(4; "Active"; Boolean) { Caption = 'Active'; }




        field(6; "Measuring Point"; Code[20])
        {
            Caption = 'Measuring Point';
            TableRelation = "Service Item"."No.";
        }

        field(13; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";


        }
        field(14; "Project Code"; Code[20])
        {
            Caption = 'Project Code';
            TableRelation = Project.Code;
            //  TableRelation = Customer."No.";

        }
        field(15; "Customer Name"; text[250])
        {
            Caption = 'Customer Name';
            // TableRelation = Customer.Name;


        }

        field(17; "Information of processing"; enum "Status Cust/MM")
        {


            Caption = 'Information of processing';

        }
        field(18; "Request No."; Code[20])
        {
            Caption = 'Request No.';
        }


        field(20; "Remark"; Text[250])
        {
            Caption = 'Remark';
        }
        field(21; "Source Table"; Integer)
        {
            Caption = 'Source Table';
        }
        field(60000; "Request Type"; Enum "Request Type")
        {
            Caption = 'Request type';
        }
        field(60001; "Due days"; Integer)
        {
            Caption = 'Due days';
        }
        field(60002; "Status Date"; Date)
        {
            Caption = 'Status Date';
        }
        field(50198; "Customer No. previous"; Code[20])
        {
            Caption = 'Customer No. previous';
        }

        field(50199; "MM previous"; Code[20])
        {
            Caption = 'MM previous';
        }
    }


    keys
    {
        key(Key1; Integer, "Measuring Point", "Customer No.", "Information of processing", "Source Table", "Request No.", "Request Type")
        {
            Clustered = true;
        }
        key(key2M; "Customer No.", "Information of processing", Active, "Source Table") { }
        key(key3M; "Measuring Point", "Information of processing", Active, "Source Table") { }
        key(key4M; "Request Type", "Request No.", "Information of processing", Active, "Source Table") { }

    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        Customer: Record Customer;
        SH: Record "Status History MM";
        MM: Record "Service Item";
        US: Record "User Setup";
        Cu: Record customer;
        Req: Record "Service Header";
        ReqI: Record "Service Invoice Header";
        StatusHistoryNonActive: Record "Status History";
        StatusHistoryNonActiveMM: Record "Status History MM";
        StatusHistoryNonActiveRN: Record "Status History 2";
        Cus: Record Customer;
        CuStatus: Record "Status History";
        SHLastMM: Record "Status History";


    begin


        Customer.reset;
        Customer.SetFilter("No.", '%1', "Customer No.");
        if Customer.FindFirst() then
            "Customer Name" := Customer.Name
        else
            "Customer Name" := '';
        Active := true;
        "Insert User ID" := USERID;
        "Insert Date and Time" := CurrentDateTime;


        if rec."Source Table" = Database::Customer then begin


            StatusHistoryNonActive.Reset();
            StatusHistoryNonActive.SetFilter("Customer No.", '%1', rec."Customer No.");
            StatusHistoryNonActive.SetFilter(Active, '%1', true);
            StatusHistoryNonActive.SetFilter(Integer, '<>%1', rec.Integer);
            if StatusHistoryNonActive.FindSet() then
                repeat
                    StatusHistoryNonActive.Active := false;
                    StatusHistoryNonActive.Modify();
                until StatusHistoryNonActive.Next() = 0;


            Customer.Reset();
            Customer.SetFilter("No.", '%1', Rec."Customer No.");
            if Customer.FindFirst() then begin
                if "Information of processing" = "Information of processing"::Active then begin
                    CompanyInf.Reset();
                    CompanyInf.SetFilter("Show Sales Natural", '%1', true);
                    if CompanyInf.FindFirst() then begin


                        if Customer."Customer Category" = Customer."Customer Category"::CNG then begin

                            CompanyInf.CNG += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Small Economy" then begin

                            CompanyInf."Small Economy" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Large Economy" then begin

                            CompanyInf."Large Economy" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::Household then begin

                            CompanyInf.Household += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"KJKP Heating plant" then begin

                            CompanyInf."KJKP Heating plant" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Special Customer" then begin

                            CompanyInf."Special Customer" += 1;
                        end;

                        CompanyInf."All Customer" += 1;
                        CompanyInf.Modify();
                    end;
                end;
            end;
        end;

        //za MM


        if rec."Source Table" = Database::"Service Item" then begin

            StatusHistoryNonActiveMM.Reset();
            StatusHistoryNonActiveMM.SetFilter("Measuring Point", '%1', rec."Measuring Point");
            StatusHistoryNonActiveMM.SetFilter(Active, '%1', true);
            StatusHistoryNonActiveMM.SetFilter(Integer, '<>%1', rec.Integer);
            if StatusHistoryNonActiveMM.FindSet() then
                repeat
                    StatusHistoryNonActiveMM.Active := false;
                    StatusHistoryNonActiveMM.Modify();
                until StatusHistoryNonActiveMM.Next() = 0;

            CompanyInf.Reset();
            CompanyInf.SetFilter("Show Sales Natural", '%1', true);
            if CompanyInf.FindFirst() then begin


                if rec."Information of processing" = rec."Information of processing"::Active then begin

                    CompanyInf."MM Active" += 1;
                end;
                if rec."Information of processing" = rec."Information of processing"::"Permanently deregistered" then begin

                    CompanyInf."MM PR" += 1;
                end;

                if rec."Information of processing" = rec."Information of processing"::"Temporarily deregistered" then begin

                    CompanyInf."MM TR" += 1;
                end;


                CompanyInf."MM all" += 1;
                CompanyInf.Modify();
                Commit();

                //ovddddddd
                MM.Reset();
                MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                MM.SetFilter("Status MM", '%1|%2|%3|%4', mm."Status MM"::Active, mm."Status MM"::Potential, mm."Status MM"::Terminated, mm."Status MM"::"Permanently deregistered");
                if not MM.FindFirst() then begin

                    CuStatus.SetFilter(Active, '%1', true);
                    CuStatus.SetFilter("Customer No.", '%1', rec."Customer No.");
                    CuStatus.SetFilter("Source Table", '%1', 18);
                    CuStatus.SetFilter("Information of processing", '%1', CuStatus."Information of processing"::"Permanently inactive");
                    if not CuStatus.FindFirst() then begin
                        CuStatus.Init();

                        CuStatus."Customer No." := rec."Customer No.";
                        CuStatus.Active := true;
                        CuStatus."Source Table" := 18;
                        CuStatus."Insert User ID" := UserId;
                        CuStatus."Insert Date and Time" := CurrentDateTime;
                        CuStatus."Information of processing" := CuStatus."Information of processing"::"Permanently inactive";

                        SHLastMM.Reset();
                        SHLastMM.SetFilter("Customer No.", '%1', rec."Customer No.");
                        SHLastMM.SetCurrentKey(Integer);
                        SHLastMM.Ascending;
                        if SHLastMM.FindLast() then
                            CuStatus.Integer := SHLastMM.Integer + 1
                        else
                            CuStatus.Integer := 1;

                        CuStatus.Insert();

                    end;

                end;


            end;
        end;

        if rec."Source Table" = 5900 then begin

            StatusHistoryNonActiveRN.Reset();
            StatusHistoryNonActiveRN.SetFilter("Request No.", '%1', rec."Request No.");
            StatusHistoryNonActiveRN.SetFilter("Request Type", '%1', rec."Request Type");
            StatusHistoryNonActiveRN.SetFilter(Active, '%1', true);
            StatusHistoryNonActiveRN.SetFilter(Integer, '<>%1', rec.Integer);
            if StatusHistoryNonActiveRN.FindSet() then
                repeat
                    StatusHistoryNonActiveRN.Active := false;
                    StatusHistoryNonActiveRN.Modify();
                until StatusHistoryNonActiveRN.Next() = 0;

        end;


    end;
    //kraj



    trigger OnModify()
    var
        Customer: Record customer;
        cs: record "Calculation Setup";
        CU: Codeunit "Update Data Billing";
    begin

        cs.Get();
        if cs."Update Data" = true then begin
            cu.StatusUpdate(rec);
        end;
    end;

    trigger OnDelete()
    var
        SH: Record "Status History";
        Customer: Record Customer;
        SHUpdate: Record "Service Header";
        Cus: Record Customer;
        CuStatus: Record "Status History";
        MM: Record "Service Item";
        SHLastMM: Record "Status History";
    begin

        if rec."Source Table" = Database::Customer then begin


            Customer.Reset();
            Customer.SetFilter("No.", '%1', Rec."Customer No.");
            if Customer.FindFirst() then begin
                if "Information of processing" = "Information of processing"::Active then begin
                    CompanyInf.Reset();
                    CompanyInf.SetFilter("Show Sales Natural", '%1', true);
                    if CompanyInf.FindFirst() then begin


                        if Customer."Customer Category" = Customer."Customer Category"::CNG then begin

                            CompanyInf.CNG += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Small Economy" then begin

                            CompanyInf."Small Economy" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Large Economy" then begin

                            CompanyInf."Large Economy" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::Household then begin

                            CompanyInf.Household += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"KJKP Heating plant" then begin

                            CompanyInf."KJKP Heating plant" += 1;
                        end;
                        if Customer."Customer Category" = Customer."Customer Category"::"Special Customer" then begin

                            CompanyInf."Special Customer" += 1;
                        end;

                        CompanyInf."All Customer" += 1;
                        CompanyInf.Modify();
                    end;
                end;
            end;
        end;

        //za MM


        if rec."Source Table" = Database::"Service Item" then begin
            CompanyInf.Reset();
            CompanyInf.SetFilter("Show Sales Natural", '%1', true);
            if CompanyInf.FindFirst() then begin


                if rec."Information of processing" = rec."Information of processing"::Active then begin

                    CompanyInf."MM Active" += 1;
                end;
                if rec."Information of processing" = rec."Information of processing"::"Permanently deregistered" then begin

                    CompanyInf."MM PR" += 1;
                end;

                if rec."Information of processing" = rec."Information of processing"::"Temporarily deregistered" then begin

                    CompanyInf."MM TR" += 1;
                end;


                CompanyInf."MM all" += 1;
                CompanyInf.Modify();

                Commit();

                //ovddddddd
                MM.Reset();
                MM.SetFilter("Customer No.", '%1', rec."Customer No.");
                MM.SetFilter("Status MM", '%1|%2|%3|%4', mm."Status MM"::Active, mm."Status MM"::Potential, mm."Status MM"::Terminated, mm."Status MM"::"Permanently deregistered");
                if not MM.FindFirst() then begin

                    CuStatus.SetFilter(Active, '%1', true);
                    CuStatus.SetFilter("Customer No.", '%1', rec."Customer No.");
                    CuStatus.SetFilter("Source Table", '%1', 18);
                    CuStatus.SetFilter("Information of processing", '%1', CuStatus."Information of processing"::"Permanently inactive");
                    if not CuStatus.FindFirst() then begin
                        CuStatus.Init();

                        CuStatus."Customer No." := rec."Customer No.";
                        CuStatus.Active := true;
                        CuStatus."Source Table" := 18;
                        CuStatus."Insert User ID" := UserId;
                        CuStatus."Insert Date and Time" := CurrentDateTime;
                        CuStatus."Information of processing" := CuStatus."Information of processing"::"Permanently inactive";
                        SHLastMM.Reset();
                        SHLastMM.SetFilter("Customer No.", '%1', rec."Customer No.");
                        SHLastMM.SetCurrentKey(Integer);
                        SHLastMM.Ascending;
                        if SHLastMM.FindLast() then
                            CuStatus.Integer := SHLastMM.Integer + 1
                        else
                            CuStatus.Integer := 1;
                        CuStatus.Insert();

                    end;

                end;
            end;
        end;

    end;
    //kraj




    trigger OnRename()
    begin

    end;

    var
        CompanyInf: Record "User Setup";
        CustomerRec: Record Customer;

}