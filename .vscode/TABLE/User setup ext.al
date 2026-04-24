tableextension 50072 User_setup_ext extends "User Setup"
{
    fields
    {
        field(60021; "Undo Shipment"; Boolean)
        {
            Caption = 'Undo Shipment';
        }
        // Add changes to table fields here
        field(50000; "User Name"; Code[250])
        {
            Caption = 'User Name';
        }
        field(50001; "Date for Training"; Date)
        {
            Caption = 'Date for Training';
        }
        field(50002; "Employee No."; code[20])
        {
            Caption = 'Employee No.';
        }
        field(50003; "UserEmp"; Code[20])
        {

        }
        field(50004; Slovo; Text[250])
        {

        }
        field(50005; "Slovo 2"; Text[250])
        {

        }
        field(50006; "Red"; Text[250])
        {

        }
        field(50007; Final; Text[250])
        {

        }
        field(50070; "Delete Wage"; Boolean)
        {
            Caption = 'Moguće obrisati obračun nakon knjiženja!';
        }
        field(5001; "Wage Allowed"; Boolean)
        {
            Caption = 'Wage Allowed';
        }
        field(5002; "Open Value"; Text[250])
        {

        }
        field(5003; "New Username"; Text[250])
        {

        }
        field(5004; "Last ECL No."; Integer)
        {
            Caption = 'Last Employee Contract Ledger No.';

        }
        field(5005; "Last Org Shema"; Code[20])
        {
            Caption = 'Last Org Shema';

        }
        field(5006; "Employee No. for Wage"; Code[20])
        {
            Caption = 'Employee No. for Wage';
            TableRelation = Employee;

        }

        field(50008; "Cashier Table"; Code[10])
        {
            Caption = 'Cashier Table';
            TableRelation = Cashier;

        }

        field(5007; "Main Cashier"; Boolean) //ED
        {
            Caption = 'Main Cashier';
        }
        field(5008; CurrentJnlBatchName; Code[10]) //ED
        {
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = const('CASH RECE'));

            trigger OnValidate()
            begin

            end;
        }
        field(5009; "Contract No."; Code[20]) //ED
        {
            Caption = 'Contract No.';
        }
        field(50010; "Code Category Text"; Option) //ED
        {
            Caption = 'Code Category Text';
            OptionCaption = ' ,Artikal,Dobavljač,Usluga,Kupac';
            OptionMembers = " ",Artikal,Dobavljač,Usluga,Kupac;
        }
        field(50011; "Commercial"; Boolean) //ED
        {
            Caption = 'Commercial';
        }
        field(50012; "Finance"; Boolean) //ED
        {
            Caption = 'Finance';
        }
        field(50013; "Accounting"; Boolean) //ED
        {
            Caption = 'Accounting';
        }
        field(50014; "Counter"; Integer)
        {
            Caption = 'Counter';
        }
        field(50015; "Customer or Employee"; Boolean)
        {
            Caption = 'Customer or Employee';
        }
        field(50016; "Allowed to CI"; Boolean)
        {
            Caption = 'Allowed to create Item Card';
        }
        field(50017; "Adress MM"; text[250])
        {

        }
        field(50018; "Customer No."; Code[20])
        {

        }
        field(50019; "Entries or Calculation"; Boolean)
        { }
        field(50020; "Type Relation"; enum "Contact Business Relation Link To Table")
        { }
        field(50021; "No."; Code[20])
        { }
        field(50022; "Employee Status"; Boolean)
        { }
        field(50023; "CZK User"; Boolean)
        {
            Caption = 'CZK User';
            DataClassification = CustomerContent;
        }
        field(50024; "Qualification Type"; Option)
        {
            Caption = 'Qualification Type';
            OptionCaption = ' ,"Computer Knowledge",Languages,Certification';
            OptionMembers = " ","Computer Knowledge",Languages,Certification;

        }
        field(50025; "Order From Expired Contract"; Boolean) //ED
        {
            Caption = 'Order From Expired Contract';
        }
        field(50026; "Status History"; Option) //ED
        {
            Caption = 'Status History';
            OptionMembers = " ","MM","Project","SubProject","Degree","Information","Customer","Request","ProcessingInf","LocationRoute";
            OptionCaption = ' ,MM,Project,SubProject,Degree,Information,Customer,Request,ProcessingInf,LocationRoute';
        }

        field(50027; "Description"; Text[250])
        {
            Caption = 'Description';
        }
        field(500028; "MM_UGI_K"; Boolean)
        {
            Caption = 'MM and UGI-Kupci';
        }
        field(500029; "MM_UGI_M"; Boolean)
        {
            Caption = 'MM and UGI-Mjerna mjesta';
        }
        field(500030; "MM_UGI_R"; Boolean)
        {
            Caption = 'MM and UGI-Usluge';
        }
        field(500031; "MM_UGI_KON_DIM"; Boolean)
        {
            Caption = 'MM and UGI-KON_Dimnjačar';
        }
        field(500032; "MM_UGI_KON_UGIZV"; Boolean)
        {
            Caption = 'MM and UGI-KON_IzvođačRadova';
        }
        field(500033; "MM_UGI_KON_P"; Boolean)
        {
            Caption = 'MM and UGI-KON_Projektant';
        }
        field(500034; "MM_UGI_GASNI_APARATI"; Boolean)
        {
            Caption = 'MM and UGI-Gasni aparati';
        }

        field(500035; "MM_UGI_OS"; Boolean)
        {
            Caption = 'MM and UGI-Osnovna sredstva';
        }
        field(500037; "MM_UGI_AKT"; Boolean)
        {
            Caption = 'MM and UGI-Aktivnosti';
        }
        field(500038; "Osnovna_sredstva"; Boolean)
        {
            Caption = 'Osnovna sredstva_GP_DGM';
        }
        field(500039; "Lista_institucija_za_PPZ_i_ZNR"; Boolean)
        {
            Caption = 'Lista institucija za PPZ i ZNR';
        }
        field(500040; "Intervencije"; Boolean)
        {
            Caption = 'Popis intervencija';
        }
        field(500041; "DIS_REAS"; Boolean)
        {
            Caption = 'Razlozi za demontažu';
        }

        field(50107; "Posting Date Cash"; date)
        {
            caption = 'Posting Date Cash';
        }
        field(50108; "Posting Date Card"; date)
        {
            caption = 'Posting Date Card';
        }
        field(50028; "CNG User"; Boolean)
        {
            Caption = 'CNG';
        }
        field(520157276; "Household"; Integer)
        {
            Caption = 'HouseHold';
        }
        field(520157278; "Large Economy"; Integer)
        {
            Caption = 'Large Economy';
        }
        field(520157277; "KJKP Heating plant"; Integer)
        {
            Caption = 'KJKP Heating plan';
        }
        field(520157280; "Special Customer"; Integer)
        {
            Caption = 'Special Customer';
        }
        field(520157281; "CNG"; Integer)
        {
            Caption = 'CNG';
        }
        field(520157282; "Small Economy"; Integer)
        {
            Caption = 'Small Economy';
        }
        field(520157283; "All Customer"; Integer)
        {
            Caption = 'All Customer';
        }
        field(520157284; "CNG Administrator"; Boolean)
        {
            Caption = 'CNG Administrator';
        }
        field(50051; "KUF_Entry"; integer)

        {
            Caption = 'KUF Entry';
        }
        field(50052; "KIF_Entry"; integer)

        {
            Caption = 'KIF Entry';
        }
        field(50053; "KUF_Type"; Option)
        {
            Caption = 'KUF Type';
            OptionCaption = 'DOMAĆI,INO,AVANSI';
            OptionMembers = "DOMAĆI",INO,AVANSI;
        }
        field(50054; "Show Sales Natural"; Boolean)

        {
            Caption = 'Show Sales Natural';
        }
        field(50055; "Gauge Code"; code[20])
        {
            Caption = 'Gauge Code';
        }
        field(50056; "Radio Module Code"; code[20])
        {
            Caption = 'Radio module code';
        }
        field(50057; "Corrector Code"; code[20])
        {
            Caption = 'Corrector code';
        }
        field(50058; "Measuring Code"; code[20])
        {
            Caption = 'Measuring code';
        }
        field(520157286; "Accusation No."; Code[20])
        {
            Caption = 'Accusation No.';
        }
        field(520157285; "Accusation Record"; Enum AccusationRecordType)
        {
            Caption = 'Accusation Record';
        }
        field(5201588; "Accusation Type"; Enum AccusationType)
        {
            Caption = 'Accusation Type';
        }

        field(520157287; "MM all"; Integer)
        {
            Caption = 'MM all';
        }

        field(520157288; "MM Active"; Integer)
        {
            Caption = 'MM Active';
        }

        field(520157289; "MM TR"; Integer)
        {
            Caption = 'MM TR';
        }

        field(520157290; "MM PR"; Integer)
        {
            Caption = 'MM PR';
        }
        field(520157291; "E. Contract type"; Integer)
        {
            Caption = 'E. Contract Type';
        }
        field(60000; "Request Type"; Enum "Request Type")
        {
            DataClassification = CustomerContent;
            Caption = 'Request Type';
        }
        field(60001; "CZK"; code[20])
        {
            TableRelation = "Bank Account"."No." where(CZK = filter(true));
        }

        field(60002; "Calc Date from"; Date)
        {

        }
        field(60003; "Calc Date to"; Date)
        {

        }
        field(60004; "Nivelacija"; Boolean)
        {

        }
        field(60005; "GEO"; Boolean)
        {
            Caption = 'GEO';
        }
        field(60006; "Reason"; Text[250])
        {
            Caption = 'Reason';
        }
        field(60007; "Remark"; Text[250])
        {
            Caption = 'Remark';
        }
        field(43424; AddressType; Option)
        {
            OptionMembers = " ","Adresa dostave","Adresa sjedišta";
            OptionCaption = ' ,Adresa dostave,Adresa sjedišta';
        }
        field(60008; "Control Verification"; Boolean)
        {
            Caption = 'Control Verification';
        }
        field(60009; "Calculation V"; code[20])
        {
            Caption = 'Calculation';
        }
        field(60010; "I"; text[250])
        {
            Caption = 'I';
        }
        field(60011; "Cashier Report"; Boolean)
        {
            Caption = 'Cashier Report';
        }
        field(60012; "Verif R"; Boolean)
        {
            Caption = 'Verif R';
        }
        field(60013; "Control R"; Boolean)
        {
            Caption = 'Control R';
        }
        field(60014; "Crl Code"; code[20])
        {
            Caption = 'Crl Code';
        }
        field(60015; "Value entries Cost"; Decimal)
        {
            Caption = 'Value entries Cost';
        }
        field(60016; "GKUpdate"; Code[20])
        {
            //  Caption = 'Value entries Cost';
        }
        field(60017; "Allowed to change Request type"; Boolean)
        {
            Caption = 'Allowed to change Request type';
        }
        field(60018; "Source Table"; Integer)
        {
            Caption = 'Source Table';
        }
        field(60019; "Visible Request"; Boolean)
        {
            Caption = 'Visible Request';
        }
        field(60020; "RMS Code"; Code[20])
        {
            Caption = 'RMS Code';
        }
        field(60022; "IsCopyWorkOrder"; Boolean)
        {
            Caption = 'Is Copy Work Order';
        }
        field(60023; "HR"; Boolean)
        {
            Caption = 'HR';
        }
        field(60024; "Povrat"; Boolean)
        {
            Caption = 'Povrat';
        }
        field(60025; "SortBilling"; Boolean)
        {
            Caption = 'SortBilling';
        }
        field(60026; "FA"; Boolean)
        {
            Caption = 'FA';
        }
        field(60027; "GaugeInsert"; Code[20])
        {
            Caption = 'GaugeInsert';
        }
        field(60028; "GaugeInsertNEW"; Code[20])
        {
            Caption = 'GaugeInsert';
        }
        field(60029; "Visible Report"; Boolean)
        {
            Caption = 'Visible Report';
        }
        field(60030; "StreetNo."; Code[20])
        {
            Caption = 'StreetNo';
        }
        field(60031; "Resource Update"; Boolean)
        {
            Caption = 'Resource Update';
        }
        field(60032; "Allowed to update IH"; Boolean)
        {
            Caption = 'Allowed to update IH';
        }
        field(60033; "NewCust"; Code[20])
        {
            Caption = 'New Customer';
        }
        field(60034; "NewMM"; Code[20])
        {
            Caption = 'New MM';
        }
        field(60035; "Elaborate"; Boolean)
        {
            Caption = 'Elaborate';
        }
        field(60036; "Default reason"; text[250])
        {
            Caption = 'Default reason';
            TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
        }

        field(60037; "Reason MM"; text[250])
        {
            Caption = 'Reason';
            //  TableRelation = "Dismantling Reason".Description where(Type = filter("Reason for dismantling"));
        }

        field(60038; "Today"; Boolean)
        {
            Caption = 'Today';

        }
        field(60039; "Upd"; Boolean)
        {

        }

        field(600340; "StartEmpty"; Time)
        {

        }
        field(600341; "EndEmpty"; Time)
        {

        }
        field(600342; "HS"; Boolean)
        {

        }


        field(600344; "Allowed Purchase Order (I)"; Boolean)
        {

            Caption = 'Allowed Purchase Order (Item)';
        }

        field(600345; "Bill type"; Code[20])
        {

            Caption = 'Bill type';
        }
        field(600355; "Allowed update F"; Boolean)
        {
            Caption = 'Allowed update F';
        }
        field(600356; "Advance"; Boolean)
        {
            Caption = 'Advance';
        }
        field(600357; "Modify Old Value"; Boolean)
        {
            Caption = 'Modify Old Value';
        }
        field(50059; "Type of vehicle"; enum "Type of Vehicle")
        {
        }













    }


    var
        myInt: Integer;

    trigger OnInsert()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        p: page "Institutions/Companies";

    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', USERID);
        if UserSetup.FindFirst() then begin
            Rec."Employee No." := UserSetup.UserEmp;

        end;
    end;

    trigger OnModify()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";

    begin

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', USERID);
        if UserSetup.FindFirst() then begin
            Rec."Employee No." := UserSetup.UserEmp;
        end;
    end;

}