table 50066 "GEO WorkPlace"
{
    Caption = 'GEO WorkPlace';
    DrillDownPageId = "GEO WorkPlaces";
    LookupPageId = "GEO WorkPlaces";
    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Open Date"; Date)
        {
            Caption = 'Open Date';
        }
        field(4; "Status"; enum "Information of processing")
        {
            caption = 'Status';

            FieldClass = FlowField;
            CalcFormula = lookup("Status History 2"."Information of processing" where("Source Table" = filter(50066), "Project Code" = field(Code)));
            // StatusHPage.SetTableView(SH);
            // StatusHPage.Run();

        }
        field(6; "Class"; Option)
        {
            Caption = 'Class';
            OptionMembers = " ","T","T E-um","T E-ins","K";
            OptionCaption = ' ,T,T E-um,T E-ins,K';
        }
        field(7; "No. Series"; Code[20])
        {
            Caption = 'No. series';
        }
        field(8; "Investor"; Code[20])
        {
            Caption = 'Investor';
            TableRelation = Contact."No." where("Type Relation" = filter(Investor));
            trigger onvalidate()
            var
                myInt: Integer;
                Cont: Record Contact;
            begin
                cont.Reset();
                cont.SetFilter("No.", '%1', Investor);
                cont.SetFilter("Type Relation", '%1', cont."Type Relation"::Investor);
                if cont.FindFirst() then
                    "Investor Name" := cont.Name
                else
                    "Investor Name" := ''
                ;
            end;
        }
        field(9; "Investor Name"; Text[250])
        {
            Caption = 'Investor Name';
            //TableRelation=Contact."No." where ("Type Relation"=filter(Investor));

        }
        field(10; "Comment"; Text[250])
        {
            Caption = 'Comment';
        }
        field(11; "GEO Construction Manager"; Code[20])
        {
            Caption = 'Geo Construction Manager';

            TableRelation = Contact."No." where("Type Relation" = filter("GEO Construction Manager"));
            trigger onvalidate()
            var
                myInt: Integer;
                Cont: Record Contact;
            begin
                cont.Reset();
                cont.SetFilter("No.", '%1', Investor);
                cont.SetFilter("Type Relation", '%1', cont."Type Relation"::"GEO Construction Manager");
                if cont.FindFirst() then
                    "GEO Construction Manager Name" := cont.Name
                else
                    "GEO Construction Manager Name" := ''
                ;
            end;
        }
        field(12; "GEO Construction Manager Name"; Text[250])
        {
            Caption = 'GEO Construction Manager Name';
        }
        field(13; "RN Number"; Integer)
        {
            Caption = 'RN Number';
            FieldClass = FlowField;
            CalcFormula = count("Service Header" where("Request Type" = filter(14 | 15), "GEO WorkPlaces Code" = field(Code)));
        }


    }


    keys
    {
        key(PK; Code, Description)
        {
            Clustered = true;
        }
        key(Description; Description)
        {
            Unique = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin

        IF Code = '' THEN BEGIN
            MgmS.GET;
            MgmS.TESTFIELD("GEO Workplaces No. Series");
            NoSeriesMgt.InitSeries(MgmS."GEO Workplaces No. Series", xRec."No. Series", 0D, Code, "No. Series");

            if "Open Date" = 0D then
                "Open Date" := today;
            Code := Code + '/' + format(copystr(format(Date2DMY("Open Date", 3)), 3, 2));
        END;


    end;

    var
        MgmS: Record "Service Mgt. Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
}