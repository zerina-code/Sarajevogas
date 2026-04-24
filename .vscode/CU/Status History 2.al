table 50176 "Status History 2"

{
    DrillDownPageId = "Status history 2";
    LookupPageId = "Status history 2";
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

        field(17; "Information of processing"; enum "Information of processing")
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
    }


    keys
    {
        key(Key1; Integer, "Measuring Point", "Customer No.", "Information of processing", "Source Table", "Request No.", "Request Type")
        {
            Clustered = true;
        }
        key(key2M; "Customer No.", "Information of processing", Active, "Source Table") { }
        key(key3M; "Measuring Point", "Information of processing", Active, "Source Table") { }
        key(key4M; "Request Type", "Request No.", "Information of processing", Active, "Source Table")
        {
        }
        key(key5M; "Request No.", Active, "Source Table", "Request Type")
        {
        }

    }
    var
        myInt: Integer;

    trigger OnInsert()
    var
        Customer: Record Customer;
        SH: Record "Status History";
        MM: Record "Service Item";
        US: Record "User Setup";
        Cu: Record customer;
        Req: Record "Service Header";
        ReqI: Record "Service Invoice Header";
        StatusHistoryNonActive: Record "Status History";
        StatusHistoryNonActiveMM: Record "Status History MM";
        StatusHistoryNonActiveRN: Record "Status History 2";


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


        if rec."Source Table" = 18 then begin


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


        if rec."Source Table" = 5940 then begin

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
    begin


    end;

    trigger OnDelete()
    var
        SH: Record "Status History";
        SHMM: Record "Status History MM";
        SHRN: Record "Status History 2";
        Customer: Record Customer;
        SHUpdate: Record "Service Header";
    begin

        if rec."Source Table" = 18 then begin


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


        if rec."Source Table" = 5940 then begin
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