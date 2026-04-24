tableextension 50100 "Service Cue" extends "Service Cue"
{
    fields
    {
        // Add changes to table fields here

        field(50000; "Service Orders - IIR"; Integer)
        {
            Caption = ' Service Orders - Information Issuing Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Information Issuing Request"), "Request Department" = field("CZK Org")));


        }

        field(50001; "Service Orders - POR"; Integer)
        {
            Caption = ' Service Orders - Project overview Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Project overview Request")));

        }

        field(50002; "Service Orders - WER"; Integer)
        {
            Caption = ' Service Orders - Work Execution Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Work Execution Request")));

        }

        field(50003; "Service Orders - UGI OAFR"; Integer)
        {
            Caption = ' Service Orders - UGI Overview and First Release';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Work Execution Request"), "First view date" = field("Date Filter First View")));

        }


        field(50004; "Service Orders - LAIR"; Integer)
        {
            Caption = ' Service Orders - Location Accordance Issuing Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Location Accordance Issuing Request")));

        }

        field(50005; "Service Orders - RAIR"; Integer)
        {
            Caption = ' Service Orders - Route Accordance Issuing Reques';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Route Accordance Issuing Request")));

        }

        field(50006; "Service Orders - SPAIR"; Integer)
        {
            Caption = ' Service Orders - Route Accordance Issuing Reques';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Spatial plan Accordance Issuing Request")));

        }

        field(50007; "Service Invoice Header"; Integer)
        {
            Caption = ' Service Invoice Header';
            FieldClass = FlowField;
            CalcFormula = Count("Service Invoice Header");

        }
        field(500481; "Date Filter 2"; Date)
        {
            Caption = 'Date Filter 2';
            Editable = false;
            FieldClass = FlowFilter;
        }

        field(500482; "New Reminders"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Potencijalna utuženja';
            CalcFormula = Count("Reminder Header" WHERE("Document Date" = FIELD("Date Filter 2")));
        }
        field(500483; "Date Filter First View"; Date)
        {
            Caption = 'Date Filter First View';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(500484; "CZK Org"; Code[20])
        {
            Caption = 'CZK Org';
            Editable = false;

        }

        field(500485; "Service Orders - Others"; Integer)
        {
            Caption = ' Service Orders - Others';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter('')));

        }
        field(500486; "Service Orders - OIIR"; Integer)
        {
            Caption = ' Service Orders - Processing Information Issuing Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Information on Connection"), "Responsible Department" = field("CZK Org")));


        }

        field(500487; "Service Orders - OPOR"; Integer)
        {
            Caption = ' Service Orders - Processing Project overview Request';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Type" = filter("Project and Energy Accordance")));

        }

        field(500488; "Service Orders - Processing"; Integer)
        {
            Caption = ' Service Orders - CZK Processing';
            FieldClass = FlowField;
            //  CalcFormula = Count("Status History" WHERE("Information of processing" = filter(Processing), "Source Table" = filter(5900), Active = filter(true)));
            CalcFormula = count("Status History 2" where("Information of processing" = filter(Processing), "Source Table" = filter(5900), Active = filter(true)));

        }

        field(500489; "Service Orders - Forwarding"; Integer)
        {
            Caption = ' Service Orders - CZK Forwarding';
            FieldClass = FlowField;
            CalcFormula = Count("Status History 2" WHERE("Information of processing" = filter(45), "Source Table" = filter(5900), Active = filter(true)));

        }
        field(500490; "Service Orders - Received"; Integer)
        {
            Caption = ' Service Orders - CZK Received';
            FieldClass = FlowField;
            CalcFormula = Count("Status History 2" WHERE("Information of processing" = filter(Received), "Source Table" = filter(5900), Active = filter(true)));


        }
        field(500491; "Service Orders - Delivered"; Integer)
        {
            Caption = ' Service Orders - CZK Delivered';
            FieldClass = FlowField;
            CalcFormula = Count("Status History 2" WHERE("Information of processing" = filter(Delivered), "Source Table" = filter(5900), Active = filter(true)));

        }
        field(500492; "Service Orders - Cancelled"; Integer)
        {
            Caption = ' Service Orders - CZK Cancelled';
            FieldClass = FlowField;
            CalcFormula = Count("Status History 2" WHERE("Information of processing" = filter(Cancelled), "Source Table" = filter(5900), Active = filter(true)));

        }
        field(500494; "Date Filter - Request"; Date)
        {
            Caption = 'Date Filter - Request';
            FieldClass = FlowFilter;
        }

        field(500493; "Service Orders - Expiring"; Integer)
        {
            Caption = ' Service Orders - CZK Expiring';
            FieldClass = FlowField;
            CalcFormula = Count("Service Header" WHERE("Request Due Date" = field("Date Filter - Request"), Status_request = filter(" " | "Processing" | "Forwarding" | "Received")));

        }
        field(500495; "Date Filter - List"; Date)
        {
            Caption = 'Date Filter - List';
            FieldClass = FlowFilter;
        }








    }


    var
        myInt: Integer;

}