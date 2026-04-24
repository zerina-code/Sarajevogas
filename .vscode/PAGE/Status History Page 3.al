page 50225 "Status history MM"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Status History MM";
    // SaveValues = true;

    Caption = 'Status history';
    //RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater("")
            {



                field("Information of processing4"; "Information of processing")
                {
                    Visible = VisibleMM;
                    Editable = CanModify;

                    //   ValuesAllowed = 0, 18, 19, 49, 50;
                    Caption = 'Status MM';
                }

                field(Active; Active) { ApplicationArea = all; Editable = CanModify; }
                field(Remark; Remark) { Editable = CanModify; }
                field("Status Date"; "Status Date") { }

                field("Insert User ID"; "Insert User ID") { ApplicationArea = all; Editable = CanModify; }
                field("Insert Date and Time"; "Insert Date and Time") { ApplicationArea = all; Editable = CanModify; }

                field("Customer No."; "Customer No.") { ApplicationArea = all; Visible = VisibleCustomer; Editable = CanModify; }

                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; Visible = VisibleMM; Editable = CanModify; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; Visible = VisibleCustomer; Editable = false; }
                field("Due days"; "Due days") { Editable = CanModify; }




            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
        User: Record "User Setup";
        Sh: Record "Service Header";

    begin


        VisibleCustomer := false;
        VisibleMM := false;
        CanModify := false;









        User.Reset();
        User.SetFilter("User ID", '%1', UserId);
        if User.FindFirst() then begin


            // Check for MM_UGI_K permission
            CanModify := User.MM_UGI_K;  // This flag will control editability


            if User."Source Table" = 18 then
                VisibleCustomer := true;
            if "Project Code" <> '' then
                VisiblePr := true;
            if User."Source Table" = 5940 then
                VisibleMM := true;
            if User."Source Table" = 5900 then
                VisibleDegree := true;


            if (User."Request Type" = User."Request Type"::"Work Execution Request")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order Office")
                         //   or ("Request Type" = "Request Type"::"General Work Order")
                         or (User."Request Type" = User."Request Type"::"Information Issuing Request")
                          or (User."Request Type" = User."Request Type"::"Location Accordance Issuing Request")

                           or (User."Request Type" = User."Request Type"::"Project overview Request")
                            or (User."Request Type" = User."Request Type"::"Route Accordance Issuing Request")
                             or (User."Request Type" = User."Request Type"::"Spatial plan Accordance Issuing Request")
                              or (User."Request Type" = User."Request Type"::"UGI Overview and First Release")

                   then
                VisReq := true
            else
                VisibleDegree := true;

        end;
        if (VisibleCustomer = true) or (VisibleMM = true) then begin
            VisReq := false;
            VisibleDegree := false;
        end;
    end;

    /* trigger OnModifyRecord(): Boolean
     begin
         UserSetup.Reset();
         UserSetup.SetFilter("User ID", '%1', UserId);
         if UserSetup.FindFirst() then
             CanModify := UserSetup.MM_UGI_K;
         if not CanModify then begin
             Error('You do not have permission to modify this item.');
         end;
     end;*/

    var

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        User: Record "User Setup";
    begin




        User.reset;
        User.setfilter("User ID", '%1', userid);
        if User.findfirst then begin
            CanModify := User.MM_UGI_K;
            if User."Source Table" = 18 then
                VisibleCustomer := true;
            if "Project Code" <> '' then
                VisiblePr := true;
            if User."Source Table" = 18 then
                VisibleCustomer := true;
            if "Project Code" <> '' then
                VisiblePr := true;
            if User."Source Table" = 5940 then
                VisibleMM := true;
            if User."Source Table" = 5900 then
                VisibleDegree := true;


            if "Request Type" = "Request Type"::Others then
                "Request Type" := User."Request Type";
            if ("Request Type" = "Request Type"::"Work Execution Request")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order Office")
                         //   or ("Request Type" = "Request Type"::"General Work Order")
                         or ("Request Type" = "Request Type"::"Information Issuing Request")
                          or ("Request Type" = "Request Type"::"Location Accordance Issuing Request")

                           or ("Request Type" = "Request Type"::"Project overview Request")
                            or ("Request Type" = "Request Type"::"Route Accordance Issuing Request")
                             or ("Request Type" = "Request Type"::"Spatial plan Accordance Issuing Request")
                              or ("Request Type" = "Request Type"::"UGI Overview and First Release")

                   then
                VisReq := true
            else
                VisibleDegree := true;
        end;

        if (VisibleCustomer = true) or (VisibleMM = true) then begin
            VisReq := false;
            VisibleDegree := false;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
        User: Record "User Setup";
    begin




        User.reset;
        User.setfilter("User ID", '%1', userid);
        if User.findfirst then begin

            if User."Source Table" = 18 then
                VisibleCustomer := true;
            if "Project Code" <> '' then
                VisiblePr := true;
            if User."Source Table" = 18 then
                VisibleCustomer := true;
            if "Project Code" <> '' then
                VisiblePr := true;
            if User."Source Table" = 5940 then
                VisibleMM := true;
            if User."Source Table" = 5900 then
                VisibleDegree := true;


            if "Request Type" = "Request Type"::Others then
                "Request Type" := User."Request Type";
            if ("Request Type" = "Request Type"::"Work Execution Request")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order")
                         //  or ("Request Type" = "Request Type"::"General Geo. Work Order Office")
                         //   or ("Request Type" = "Request Type"::"General Work Order")
                         or ("Request Type" = "Request Type"::"Information Issuing Request")
                          or ("Request Type" = "Request Type"::"Location Accordance Issuing Request")

                           or ("Request Type" = "Request Type"::"Project overview Request")
                            or ("Request Type" = "Request Type"::"Route Accordance Issuing Request")
                             or ("Request Type" = "Request Type"::"Spatial plan Accordance Issuing Request")
                              or ("Request Type" = "Request Type"::"UGI Overview and First Release")

                   then
                VisReq := true
            else
                VisibleDegree := true;
        end;

        if (VisibleCustomer = true) or (VisibleMM = true) then begin
            VisReq := false;
            VisibleDegree := false;
        end;
    end;




    var
        myInt: Integer;
        VisibleMM: Boolean;
        VisiblePr: Boolean;
        VisibleInf_P: Boolean;
        VisibleSub: Boolean;
        VisibleInf: Boolean;
        VisibleDegree: Boolean;
        VisibleCustomer: Boolean;
        VisReq: Boolean;
        VisLoc: Boolean;
        CanModify: Boolean;
        UserSetup: Record "User Setup";
}