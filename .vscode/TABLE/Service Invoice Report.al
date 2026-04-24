report 50142 "ZR-OU-00-25-01 Invoice"
{
    Caption = 'ZR-OU-00-25-01', Locked = true;
    DefaultLayout = Word;
    WordLayout = '.\.vscode\REPORT\WORD\ZR-OU-00-25-01_2.docx';
    dataset
    {
        dataitem(ServiceHeader; "Service Invoice Header")
        {
            column(No_; "No.")
            {

            }
            column(CZKR; "No.")
            {

            }
            column(Date_for_Execution; format("Date for Execution", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(No__for_Execution; "No. for Execution") { }
            column(First_view_date; format("First view date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(First_view_No_; "First view No.") { }
            column(UGI_type; "UGI type") { }
            column(RD; "Responsible Department")
            {

            }
            column(Name; Name)
            {

            }
            column(Street; Address)
            {

            }
            column(Municipality; "Municipality Name")
            {

            }
            column(City; City)
            {

            }
            column(Service_Header_UGI; "Service Header UGI") { }
            column(Service_Date_UGI; format("Service Date UGI", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Phone_No_; "Phone No.")
            {

            }
            column(Execution_Company_Phone_No_; "Execution Company Phone No.") { }
            column(Designer; StrSubstNo('%1 / %2', "Designer Phone No.", "Designer Email"))
            {

            }
            column(CZKD; Format("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(G_Gauge_Size; "G Gauge Size") { }
            column(Request_Due_Date; Format("Request Due Date", 0, '<Day,2>.<Month,2>.<Year4>'))
            {

            }
            column(kW_Power; "kW Power")
            {

            }
            column(Owner_St; Owner_St)
            {

            }
            column(Owner_StNo; Owner_StNo)
            {

            }
            column(Project; Project) { }
            column(Project_Date; format("Project Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Simbol; Simbol) { }
            column(Owner_Municipality_Name; Owner_Municipality_Name)
            {

            }
            column(CZKName; czk.Name) { }
            column(CZkPhone; czk."Phone No.") { }
            column(CZKAddress; czk.Address) { }
            column(Execution_Company_Name; "Execution Company Name") { }
            column(Execution_Address; "Execution Address") { }
            column(Execution_Protocol_No_; format("Execution Protocol No.", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Work_Execution_Date; format("Work Execution Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Work_Order_Due_Date; "Work Order Due Date") { }
            column(Work_Order_Emergency; "Work Order Emergency") { }
            column(Work_Order_Registry_No_; "Work Order Registry No.") { }
            column(BrojRegistratoraSlovima; "Work Order Registry No. letter") { }
            column(Work_Order_Request_Date; format("Work Order Request Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Work_Order_Request_No_; "Work Order Request No.") { }
            column(Work_Order_Requester; "Work Order Requester") { }
            column(Work_Order_Type; "Work Order Type") { }
            column(Contractor_No; "Contractor No") { }
            column(Responsible_Contact; "Responsible Contact") { }
            column(Vertical; Vertical) { }
            column(Planned_W__Exec__Starting_Date; format("Planned W. Exec. Starting Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }
            column(Planned_W__Exec__Ending_Date; format("Planned W. Exec. Ending Date", 0, '<Day,2>.<Month,2>.<Year4>')) { }

            dataitem("Document Attachment"; "Document Attachment")
            {
                DataItemLink = "No." = field("Order No.");
                DataItemTableView = SORTING("ID")
                                             ORDER(Ascending);

                column(Mandatory_Attachment_Type; "Mandatory Attachment Type")
                { }
                column(Brojac; Brojac) { }
                column(Delivered; Delivered) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter(Information, '%1', false);

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;

                begin
                    Brojac += 1;

                end;

            }

            dataitem("Document Attachment2"; "Document Attachment")
            {
                DataItemLink = "No." = field("Order No.");
                DataItemTableView = SORTING("ID")
                                             ORDER(Ascending);

                column(Mandatory_Attachment_Type2; "Document Attachment2"."Mandatory Attachment Type")
                { }
                column(Brojac2; Brojac2) { }
                column(Delivered2; "Document Attachment2".Delivered) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter(Information, '%1', true);

                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;

                begin
                    Brojac2 += 1;

                end;

            }

            dataitem("Service Comment Line"; "Service Comment Line")
            {

                DataItemLink = "No." = field("No.");

                column(Comment; Comment) { }
                column(ShowComment; ShowComment) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("Comment Option", '%1', "Comment Option"::Customer);

                end;


            }

            dataitem("Service Comment Line2"; "Service Comment Line")
            {

                DataItemLink = "No." = field("No.");

                column(Comment2; Comment) { }
                column(ShowComment2; ShowComment) { }
                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SetFilter("Comment Option", '%1', "Service Comment Line2"."Comment Option"::Internal);
                end;


            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;

            begin
                US.Reset();
                US.SetFilter("User ID", '%1', UserId);
                if us.FindFirst() then begin
                    CZK.Reset();
                    czk.SetFilter("No.", '%1', us.CZK);
                    if czk.FindFirst() then begin

                    end;
                end;

                CalcFields("Owner Street Name", "Owner Municipality Name", "Municipality Name");
                Owner_St := "Owner Street Name";
                if Owner_St = '' then begin
                    Owner_St := "Street Name";
                end;
                Owner_StNo := "Owner Street No.";
                if Owner_StNo = '' then begin
                    Owner_StNo := "Street No.";
                end;
                Owner_Municipality_Name := "Owner Municipality Name";
                if Owner_Municipality_Name = '' then begin
                    Owner_Municipality_Name := "Municipality Name";
                end;


            end;

        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {

                field(ShowComment; ShowComment)
                {
                    Caption = 'ShowComment';
                }

            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Brojac: Integer;
        Brojac2: Integer;
        ShowComment: Boolean;

        Simbol: text[250];
        CZK: Record "Bank Account";
        US: Record "User Setup";
        Owner_St: text[250];
        Owner_StNo: text[250];
        Owner_Municipality_Name: Text[250];



}
