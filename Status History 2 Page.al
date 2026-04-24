page 50216 "Status history 2"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Status History 2";
    // SaveValues = true;

    Caption = 'Status history';
    //RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater("")
            {


                field("Information of processing"; "Information of processing")
                {
                    Visible = VisibleDegree;

                    //svi
                    ValuesAllowed = 0, 2, 3, 4, 6, 17, 41, 52, 53, 54, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 22, 23, 25, 26, 27, 24;
                }

                field("Information of processing2"; "Information of processing")
                {
                    Visible = VisiblePr;
                    //Project
                    Caption = 'Status Project';

                    ValuesAllowed = 0, 22, 23, 24, 25, 26, 27;
                }

                field("Information of processing3"; "Information of processing")
                {
                    Visible = VisReq;
                    Caption = 'CZK request status';

                    ValuesAllowed = 0, 38, 45, 46, 47, 48;

                }


                field("Information of processing6"; "Information of processing")
                {
                    Visible = VisibleSub;
                    //SubProject
                    Caption = 'SubProject status';

                    ValuesAllowed = 0, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40;

                }


                field(Active; Active) { ApplicationArea = all; }
                field(Remark; Remark) { }

                field("Insert User ID"; "Insert User ID") { ApplicationArea = all; }
                field("Insert Date and Time"; "Insert Date and Time") { ApplicationArea = all; }

                field("Customer No."; "Customer No.") { ApplicationArea = all; Visible = VisibleCustomer; }

                field("Measuring Point"; "Measuring Point") { ApplicationArea = all; Visible = VisibleMM; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; Visible = VisibleCustomer; Editable = false; }
                field("Due days"; "Due days") { }




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









        User.Reset();
        User.SetFilter("User ID", '%1', UserId);
        if User.FindFirst() then begin

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

    var

    trigger OnAfterGetRecord()
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
}