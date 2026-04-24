tableextension 50004 "Service Mgt. Setup" extends "Service Mgt. Setup"
{
    fields
    {
        field(50000; "Requests No. Series"; Code[20])
        {
            Caption = 'Requests No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50001; "Inform. Issue No. Series"; Code[20])
        {
            Caption = 'Information Issue No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50002; "Inform. On Conn. No. Series"; Code[20])
        {
            Caption = 'Information On Conn. No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50003; "Proj. Overview No. Series"; Code[20])
        {
            Caption = 'Project Overview No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50004; "Proj. Accordance No. Series"; Code[20])
        {
            Caption = 'Project and Energy Accord. No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50005; "Work Execution No. Series"; Code[20])
        {
            Caption = 'Work Execution Request No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50006; "UGI Overview No. Series"; Code[20])
        {
            Caption = 'UGI Overview No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50007; "Gen. Work Order No. Series"; Code[20])
        {
            Caption = 'Gen. Work Order No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50008; "Gen. Work Order Geo No. Series"; Code[20])
        {
            Caption = 'Gen. Work Order - Geo No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50009; "Loc. Accord. Req. No. Series"; Code[20])
        {
            Caption = 'Location Accordance Request No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50010; "Loc. Accord. Info. No. Series"; Code[20])
        {
            Caption = 'Location Accordance Information No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50011; "Route Accord. Req. No. Series"; Code[20])
        {
            Caption = 'Route Accordance Request No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50012; "Route Accord. Info. No. Series"; Code[20])
        {
            Caption = 'Route Accordance Information No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50013; "Spat. Accord. Req. No. Series"; Code[20])
        {
            Caption = 'Spatial Accordance Request No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50014; "Spat. Accord. Info. No. Series"; Code[20])
        {
            Caption = 'Spatial Accordance Information No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50015; "Gauge Code"; Code[20])
        {
            Caption = 'Gauge Code';
            TableRelation = "No. Series";
        }
        field(50016; "Corrector Code"; Code[20])
        {
            Caption = 'Corrector Code';
            TableRelation = "No. Series";
        }
        field(50017; "GEO Workplaces No. Series"; Code[20])
        {
            Caption = 'GEO Workplaces No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50018; "Elaboration No. Series"; Code[20])
        {
            Caption = 'Elaboration No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }

        field(50019; "Sketch No. Series"; Code[20])
        {
            Caption = 'Sketch No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(50020; "Geo Registrator No. Series"; code[20])
        {
            Caption = 'Geo Registrator No. Series';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";


        }

        //
    }
    procedure GetRequestNoSeries(RequestType: Enum "Request Type"): Code[20]
    var
        CZKBy: code[20];
        NoRelationShip: Record "No. Series Relationship";
        US: Record "User Setup";
    begin
        TestField("Service Order Nos.");
        US.Reset();
        US.SetFilter("User Id", '%1', UserId);
        if us.FindFirst() then begin

            if RequestType = RequestType::"Information Issuing Request" then begin
                CZKBy := DefaultNoSeries("Inform. Issue No. Series");

                NoRelationShip.Reset();
                NoRelationShip.SetFilter(Code, '%1', "Inform. Issue No. Series");
                NoRelationShip.SetFilter("Series Code", STRSUBSTNO('*%1*', us.CZK));
                if NoRelationShip.FindFirst() then begin
                    exit(DefaultNoSeries(NoRelationShip."Series Code"));
                end;
            end;


            if RequestType = RequestType::"Project overview Request" then begin
                CZKBy := DefaultNoSeries("Proj. Overview No. Series");

                NoRelationShip.Reset();
                NoRelationShip.SetFilter(Code, '%1', "Proj. Overview No. Series");
                NoRelationShip.SetFilter("Series Code", STRSUBSTNO('*%1*', us.CZK));
                if NoRelationShip.FindFirst() then begin
                    exit(DefaultNoSeries(NoRelationShip."Series Code"));
                end;
            end;

            if RequestType = RequestType::"Work Execution Request" then begin
                CZKBy := DefaultNoSeries("Work Execution No. Series");

                NoRelationShip.Reset();
                NoRelationShip.SetFilter(Code, '%1', "Work Execution No. Series");
                NoRelationShip.SetFilter("Series Code", STRSUBSTNO('*%1*', us.CZK));
                if NoRelationShip.FindFirst() then begin
                    exit(DefaultNoSeries(NoRelationShip."Series Code"));
                end;
            end;


            if RequestType = RequestType::"Location Accordance Issuing Request" then begin
                CZKBy := DefaultNoSeries("Loc. Accord. Req. No. Series");

                NoRelationShip.Reset();
                NoRelationShip.SetFilter(Code, '%1', "Loc. Accord. Req. No. Series");
                NoRelationShip.SetFilter("Series Code", STRSUBSTNO('*%1*', us.CZK));
                if NoRelationShip.FindFirst() then begin
                    exit(DefaultNoSeries(NoRelationShip."Series Code"));
                end;
            end;


            if RequestType = RequestType::"Route Accordance Issuing Request" then begin
                CZKBy := DefaultNoSeries("Route Accord. Req. No. Series");

                NoRelationShip.Reset();
                NoRelationShip.SetFilter(Code, '%1', "Route Accord. Req. No. Series");
                NoRelationShip.SetFilter("Series Code", STRSUBSTNO('*%1*', us.CZK));
                if NoRelationShip.FindFirst() then begin
                    exit(DefaultNoSeries(NoRelationShip."Series Code"));
                end;
            end;



        end;

        case RequestType of
            Enum::"Request Type"::"Others":
                exit("Requests No. Series");
            Enum::"Request Type"::"Information Issuing Request":
                exit(DefaultNoSeries("Inform. Issue No. Series"));
            Enum::"Request Type"::"Information on Connection":
                exit(DefaultNoSeries("Inform. On Conn. No. Series"));
            Enum::"Request Type"::"Project overview Request":
                exit(DefaultNoSeries("Proj. Overview No. Series"));
            Enum::"Request Type"::"Project and Energy Accordance":
                exit(DefaultNoSeries("Proj. Accordance No. Series"));
            Enum::"Request Type"::"UGI Overview and First Release":
                exit(DefaultNoSeries("UGI Overview No. Series"));
            Enum::"Request Type"::"Work Execution Request":
                exit(DefaultNoSeries("Work Execution No. Series"));
            Enum::"Request Type"::"General Work Order":
                exit(DefaultNoSeries("Gen. Work Order No. Series"));
            Enum::"Request Type"::"General Geo. Work Order":
                exit(DefaultNoSeries("Gen. Work Order Geo No. Series"));
            Enum::"Request Type"::"Location Accordance Issuing Request":
                exit(DefaultNoSeries("Loc. Accord. Req. No. Series"));
            Enum::"Request Type"::"Location Accordance Issuing Information":
                exit(DefaultNoSeries("Loc. Accord. Info. No. Series"));
            Enum::"Request Type"::"Route Accordance Issuing Request":
                exit(DefaultNoSeries("Route Accord. Req. No. Series"));
            Enum::"Request Type"::"Route Accordance Issuing Information":
                exit(DefaultNoSeries("Route Accord. Info. No. Series"));
            Enum::"Request Type"::"Spatial plan Accordance Issuing Request":
                exit(DefaultNoSeries("Spat. Accord. Req. No. Series"));
            Enum::"Request Type"::"Spatial plan Accordance Issuing Information":
                exit(DefaultNoSeries("Spat. Accord. Info. No. Series"));
            Enum::"Request Type"::"General Geo. Work Order Office":
                exit(DefaultNoSeries("Gen. Work Order No. Series"));


        end;
    end;

    local procedure DefaultNoSeries(NoSeries: Code[20]): Code[20];
    begin
        if NoSeries = '' then
            exit("Service Order Nos.")
        else
            exit(NoSeries);
    end;
}
