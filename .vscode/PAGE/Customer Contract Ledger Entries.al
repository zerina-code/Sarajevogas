page 50090 "Customer Ledger Entries -SA"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater("IM")
            {
                field(Code; Code)
                {
                    Editable = CanModify;
                }


                field("Customer Category"; "Customer Category")
                {
                    ApplicationArea = all;
                    Editable = CanModify;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Customer No."; "Customer No.") { ApplicationArea = all; Editable = CanModify; }
                field("VAT Registration No."; "VAT Registration No.") { ApplicationArea = all; Editable = CanModify; }
                field("Customer Name"; "Customer Name") { ApplicationArea = all; Editable = CanModify; }
                field("Father Name"; "Father Name") { Editable = CanModify; }
                field("Contract Name"; "Contract Name") { Editable = CanModify; }
                field(Address; Address) { ApplicationArea = all; Editable = CanModify; }
                field("Street Customer"; "Street Customer") { ApplicationArea = all; Editable = CanModify; }
                field("Street Name Customer"; "Street Name Customer") { ApplicationArea = all; Editable = CanModify; }
                field("Street No."; "Street No.") { ApplicationArea = all; Editable = CanModify; }
                field("Street No.2 Text"; "Street No.2 Text") { Editable = CanModify; }


                field("Municipality Code Customer"; "Municipality Code Customer") { ApplicationArea = all; }
                field("Municipality Name Customer"; "Municipality Name Customer") { ApplicationArea = all; Editable = CanModify; }

                field(City; City) { ApplicationArea = all; Editable = CanModify; }
                field("Post Code"; "Post Code") { ApplicationArea = all; Editable = CanModify; }
                field("MZ Customer"; "MZ Customer") { ApplicationArea = all; Editable = CanModify; }
                field("MZ Name Customer"; "MZ Name Customer") { ApplicationArea = all; Editable = CanModify; }
                field("Customer Stroke"; "Customer Stroke") { ApplicationArea = all; Editable = CanModify; }
                field("Customer String"; "Customer String") { ApplicationArea = all; Editable = CanModify; }
                field("Zone stroke"; "Zone stroke") { ApplicationArea = all; Editable = CanModify; }

                field("Address 2"; "Address 2") { ApplicationArea = all; Editable = CanModify; }
                field("Street Customer 2"; "Street Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Street Name Customer 2"; "Street Name Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Street No. 2"; "Street No. 2") { ApplicationArea = all; Editable = CanModify; }
                field("Municipality Code Customer 2"; "Municipality Code Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Municipality Name Customer 2"; "Municipality Name Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("City 2"; "City 2") { ApplicationArea = all; Editable = CanModify; }
                field("Post Code 2"; "Post Code 2") { ApplicationArea = all; Editable = CanModify; }
                field("MZ Customer 2"; "MZ Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("MZ Name Customer 2"; "MZ Name Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Customer Stroke 2"; "Customer Stroke 2") { ApplicationArea = all; Editable = CanModify; }
                field("Customer String 2"; "Customer String 2") { ApplicationArea = all; Editable = CanModify; }
                field("Zone stroke 2"; "Zone stroke 2") { ApplicationArea = all; Editable = CanModify; }
                field("Floor Customer 2"; "Floor Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Apartment No. Customer 2"; "Apartment No. Customer 2") { ApplicationArea = all; Editable = CanModify; }
                field("Attachment Count"; "Attachment Count") { ApplicationArea = all; Editable = CanModify; }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = all;
                    Editable = CanModify;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                        ECL: Record "Customer Ledger Entry";
                    begin
                        if ("Starting Date" <= Today) and (("Ending Date" = 0D) or ("Ending Date" >= Today)) then
                            active := true
                        else
                            Active := false;

                        ecl.Reset();
                        ecl.SetFilter("Starting Date", '<%1', "Starting Date");
                        ecl.SetFilter("Customer No.", '%1', "Customer No.");
                        ecl.SetCurrentKey("Starting Date");
                        ecl.Ascending;
                        if ecl.FindLast() then begin
                            if ecl."Starting Date" <> 0D then begin
                                ecl.Validate("Ending Date", CalcDate('<-1D>', "Starting Date"));
                                ecl.Active := false;
                                ecl.modify;
                            end;
                        end;

                    end;
                }
                field("Ending Date"; "Ending Date") { ApplicationArea = all; Editable = CanModify; }
                field(Verification; Verification) { Editable = Control; }
                field(SystemCreatedBy; SystemCreatedBy) { Editable = false; Visible = false; }
                field("Author UserName"; "Author UserName") { Editable = false; }
                field(SystemCreatedAt; SystemCreatedAt) { Editable = false; }
                field(SystemModifiedAt; SystemModifiedAt) { Editable = false; }
                field(SystemModifiedBy; SystemModifiedBy) { Editable = false; Visible = false; }
                field("Modify UserName"; "Modify UserName") { Editable = false; }
                field("CZK"; "CZK") { Editable = false; }
                field("Contract Reason"; "Contract Reason")
                {
                    Editable = CanModify;


                    /* trigger OnDrillDown()
                     var
                         myInt: Integer;
                         US: Record "User Setup";

                     begin
                         Clear(PageEC);
                         us.Reset();
                         us.SetFilter("User ID", '%1', UserId);
                         if us.FindFirst() then begin
                             us."E. Contract type" := 2;
                             us.Modify();
                         end;
                         ec.Reset();
                         ec.SetFilter(Type, '%1', ec.Type::Reason);
                         PageEC.SetTableView(ec);
                         PageEC.Run();

                     end;*/

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                        GaugeF: Record "Installation History";
                        MMFind: Record "Service Item";
                    begin
                        Clear(PageEC);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."E. Contract type" := 2;
                            us.Modify();
                        end;

                        ec.Reset();
                        ec.SetFilter(Type, '%1', ec.Type::Reason);
                        if (us."CNG Administrator" = false) and (us."CNG User" = false) then
                            ec.SetFilter(Description, '<>%1', 'Anex');
                        PageEC.SetTableView(EC);
                        Commit();
                        PageEC.LOOKUPMODE(TRUE);
                        IF PageEC.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Commit();
                            PageEC.GETRECORD(ec);
                            Validate("Starting Date", "Starting Date");

                            validate("Contract Reason", ec.Code);

                            //error
                            if rec."Customer Category" = rec."Customer Category"::Household then begin

                                GaugeF.Reset();
                                GaugeF.SetFilter(Type, '%1', GaugeF.Type::Gauge);
                                GaugeF.SetFilter(Active, '%1', true);
                                MMFind.Reset();
                                MMFind.SetFilter("Customer No.", '%1', rec."Customer No.");
                                if MMFind.FindFirst() then
                                    GaugeF.SetFilter("Measuring Point Code", '%1', MMFind."No.")
                                else
                                    Error('Ne postoji mjerno mjesto dodijeljeno ovom kupcu, prema tome ne možete kreirati ugovor!');

                                GaugeF.SetFilter("Customer No.", '%1', rec."Customer No.");
                                if GaugeF.FindFirst() then begin
                                    if GaugeF.Count > 1 then
                                        Error('Ovo mjerno mjesto ima više mjerača, prema tome molimo Vas da prvo provjerite podatke prije nego kreirate ugovor!');

                                    if GaugeF.Count = 0 then
                                        Error('Ne postoji mjerač dodijeljen ovom kupcu, prema tome ne možete kreirati ugovor!');
                                end
                                else begin
                                    Error('Ne postoji mjerač dodijeljen ovom kupcu, prema tome ne možete kreirati ugovor!');
                                end;
                            end;
                            if ec.Code = 'A-B' then begin
                                "Date of creation" := today;
                            end;
                        end;
                        Commit();


                    end;
                }

                field("Employment Contract"; "Employment Contract")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Editable = CanModify;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                    begin
                        Clear(PageEC);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."E. Contract type" := 1;
                            us.Modify();
                        end;
                        ec.Reset();
                        ec.SetFilter(Type, '%1', ec.Type::Reason);
                        PageEC.SetTableView(ec);
                        PageEC.Run();

                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                    begin
                        Clear(PageEC);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."E. Contract type" := 1;
                            us.Modify();
                        end;
                        ec.Reset();
                        ec.SetFilter(Type, '%1', ec.Type::Reason);
                        PageEC.SetTableView(ec);
                        PageEC.Run();
                    end;

                }
                field("Service Order"; "Service Order")
                {
                    // DrillDownPageId = Requests;
                    //  LookupPageId = Requests;

                    Editable = false;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        RCard: page Requests;
                        myInt: Integer;
                        SH: Record "Service Header";
                    begin
                        SH.Reset();
                        SH.SetFilter("A-B", '%1', true);
                        sh.SetFilter("Customer No.", '%1', rec."Customer No.");
                        sh.SetFilter("A-B Entry", '%1', rec.Code);
                        RCard.SetTableView(SH);
                        RCard.Run();

                    end;

                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                        SH: Record "Service Header";
                        RCard: page Requests;
                    begin
                        SH.Reset();
                        SH.SetFilter("A-B", '%1', true);
                        sh.SetFilter("Customer No.", '%1', rec."Customer No.");
                        sh.SetFilter("A-B Entry", '%1', rec.Code);
                        RCard.SetTableView(SH);
                        RCard.Run();

                    end;


                }
                field("Reason for Termination"; "Reason for Termination")
                {
                    ApplicationArea = all;
                    Editable = CanModify;





                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        US: Record "User Setup";
                    begin
                        /*
                        Clear(PageEC2);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin

                            //Kupac ili Zaposlenik (kupac - DA)
                            us."Customer or Employee" := true;
                            us.Modify();
                        end;

                        Ec2.Reset();
                        Ec2.SetFilter(Type2, '%1', Ec2.Type2::Customer);
                        PageEC2.SetTableView(ec2);
                        PageEC2.Run();*/

                        Clear(PageEC2);
                        us.Reset();
                        us.SetFilter("User ID", '%1', UserId);
                        if us.FindFirst() then begin
                            us."Customer or Employee" := true;
                            us.Modify();
                        end;
                        ec2.Reset();
                        ec2.SetFilter(Type2, '%1', ec2.Type2::Customer);
                        PageEC2.SetTableView(EC2);
                        Commit();
                        PageEC2.LOOKUPMODE(TRUE);
                        IF PageEC2.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Commit();
                            PageEC2.GETRECORD(ec2);
                            "Reason for Termination" := ec2.Description;
                        end;
                        Commit();

                    end;
                }

                field(Active; Active) { ApplicationArea = all; Editable = CanModify; }
                field(Description; Description)
                { Editable = CanModify; }
                field(Number_Field; Number_Field) { Visible = false; Editable = CanModify; }
                //field("NAV ID"; "NAV ID") { ApplicationArea = all; }
                field("Attachment No."; "Attachment No." <> 0)
                {
                    Caption = 'Attachment No. Description';
                    ApplicationArea = all;
                    Editable = CanModify;



                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No." <> 0 THEN
                            OpenAttachment;

                        CurrPage.UPDATE;
                    end;



                }
                field("Attachment No.A-B"; "Attachment No. A-B" <> 0)
                {
                    Caption = 'Attachment No. A-B';
                    ApplicationArea = all;
                    Editable = CanModify;



                    trigger OnAssistEdit()
                    begin
                        IF "Attachment No. A-B" <> 0 THEN
                            OpenAttachment2;

                        CurrPage.UPDATE;
                    end;



                }

                field("Public Procurement"; "Public Procurement")
                {
                    ApplicationArea = all;
                    Editable = CanModify;
                }
                field("Public Document No."; "Public Document No.")
                {
                    ApplicationArea = all;
                    Editable = CanModify;
                }
                field("Date of Public Procurement"; "Date of Public Procurement")
                {
                    ApplicationArea = all;
                    Editable = CanModify;
                }


            }
        }
    }


    trigger OnNewRecord(BelowxRec: Boolean)
    var
        myInt: Integer;
        Us: Record "User Setup";
        GLS: Record "General Ledger Setup";
        NoSeriesMgt: Codeunit NoSeriesExtented;
    begin

        us.Reset();
        us.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then begin
            if rec."Customer No." = '' then begin
                Validate("Customer No.", us."Customer No.");
            end;
        end;

        IF Code = '' THEN BEGIN
            GLS.GET;
            GLS.TESTFIELD("Customer Contract Entry");
            NoSeriesMgt.InitSeries(GLS."Customer Contract Entry", xRec."No. Series", 0D, Code, "No. Series");
        END;


    end;


    trigger OnOpenPage()
    var
        myInt: Integer;

    begin
        CanModify := false;

        CalcFields("Service Order", "Author UserName", "Modify UserName");
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;

        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then
            CanModify := US.MM_UGI_K;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Service Order", "Author UserName", "Modify UserName");
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        if us.FindFirst() then
            CanModify := US.MM_UGI_K;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Service Order");
        US.reset;
        US.SetFilter("User ID", '%1', UserId);
        us.SetFilter("Control Verification", '%1', true);
        if us.FindFirst() then
            Control := true
        else
            Control := false;
    end;



    var
        myInt: Integer;
        PageEC: page "Employment Contracts";
        EC: Record "Employment Contract";
        Ec2: Record "Grounds for Termination";
        PageEC2: page "Grounds for Termination";
        Control: Boolean;
        US: Record "User Setup";
        CanModify: Boolean;
}