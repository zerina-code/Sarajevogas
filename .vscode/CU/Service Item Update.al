codeunit 50012 "ServiceItem-Update"
{

    trigger OnRun()
    begin
    end;

    var
        RMSetup: Record "Marketing Setup";
        VendContactUpdateCategoryTxt: Label 'Service Item Contact Orphaned Links', Locked = true;
        VendContactUpdateTelemetryMsg: Label 'Contact %1 does not exist. The contact business relation with code %2 which points to it has been deleted', Locked = true;

    procedure OnInsert(var Vend: Record "Service Item")
    begin
        RMSetup.Get();
        if RMSetup."Bus. Rel. Code for SI" = '' then
            exit;

        InsertNewContact(Vend, true);
    end;



    procedure OnModify(var Vend: Record "Service Item")
    var
        Cont: Record Contact;
        OldCont: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        ContNo: Code[20];
        NoSeries: Code[20];
        SalespersonCode: Code[20];
        IsHandled: Boolean;
    begin
        with ContBusRel do begin
            SetCurrentKey("Link to Table", "No.");
            SetRange("Link to Table", "Link to Table"::ServiceItem);
            SetRange("No.", Vend."No.");
            if not FindFirst then
                exit;
            if not Cont.Get("Contact No.") then begin
                Delete();
                Session.LogMessage('0000B36', StrSubstNo(VendContactUpdateTelemetryMsg, "Contact No.", "Business Relation Code"), Verbosity::Normal, DataClassification::EndUserIdentifiableInformation, TelemetryScope::ExtensionPublisher, 'Category', VendContactUpdateCategoryTxt);
                exit;
            end;
            OldCont := Cont;
        end;

        ContNo := Cont."No.";
        NoSeries := Cont."No. Series";
        SalespersonCode := Cont."Salesperson Code";


        Cont.Validate("E-Mail", Vend."E-Mail");
        Cont.Address := Vend."Address MM";
        Cont."Phone No." := Vend."Phone No. MM";
        Cont."Address 2" := Vend.Address;
        Cont."Post Code" := Vend."Post Code";
        Cont.City := Vend.City;
        Cont."Mobile Phone No." := Vend."Mobile Phone No.";
        Cont."E-Mail" := Vend."E-Mail";
        Cont."Fax No." := Vend."Fax No.";
        Cont."Fax - Transfer" := Vend."Fax No. - Transfer";


        Cont.TransferFields(Vend);


        IsHandled := false;

        if not IsHandled then begin
            Cont."No." := ContNo;
            Cont."No. Series" := NoSeries;
        end;
        Cont."Salesperson Code" := SalespersonCode;
        Cont.Validate(Name);
        Cont.DoModify(OldCont);
        Cont.Modify(true);

        Vend.Get(Vend."No.");


    end;

    procedure OnDelete(var Vend: Record "Service Item")
    var
        ContBusRel: Record "Contact Business Relation";
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        with ContBusRel do begin
            SetCurrentKey("Link to Table", "No.");
            SetRange("Link to Table", "Link to Table"::ServiceItem);
            SetRange("No.", Vend."No.");
            DeleteAll(true);
        end;
    end;

    procedure InsertNewContact(var Vend: Record "Service Item"; LocalCall: Boolean)
    var
        Cont: Record Contact;
        ContBusRel: Record "Contact Business Relation";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        IsHandled: Boolean;
    begin
        IsHandled := false;

        if IsHandled then
            exit;

        if not LocalCall then begin
            RMSetup.Get();
            RMSetup.TestField("Bus. Rel. Code for SI");
        end;

        if ContBusRel.UpdateEmptyNoForContact(Vend."No.", Vend."Contact MM", ContBusRel."Link to Table"::ServiceItem) then
            exit;

        with Cont do begin
            Init;
            "No." := Vend."No.";
            Name := Vend.Description;

            "Name 2" := Vend."Name 2";
            "Search Name" := Vend.Description;
            Address := Vend.Address;
            Address := Vend."Address MM";

            "Address 2" := Vend."Address 2";

            City := Vend.City;
            "Phone No." := Vend."Phone No.";
            "Country/Region Code" := vend."Country/Region Code";
            comment := Vend.Comment;
            "Post Code" := Vend."Post Code";
            County := Vend.County;
            "E-Mail" := Vend."E-Mail";
            "Phone No." := Vend."Phone No. MM";
            "Mobile Phone No." := Vend."Mobile Phone No.";
            "Fax - Transfer" := Vend."Fax No. - Transfer";
            "Fax No." := Vend."Fax No.";


            //ĐK  "No. Series" := Vend."No. Series";
            // Vend.


            //ĐK  TransferFields(Vend);

            //   Validate(Name);
            Validate("E-Mail");
            "Search E-Mail" := "E-Mail";
            IsHandled := false;

            if not IsHandled then begin
                "No." := '';
                "No. Series" := '';
                RMSetup.TestField("Contact Nos.");
                NoSeriesMgt.InitSeries(RMSetup."Contact Nos.", '', 0D, "No.", "No. Series");
            end;
            Type := Type::Company;
            TypeChange;
            SetSkipDefault;
            "Type Relation" := "Type Relation"::ServiceItem;

            Insert(true);
        end;

        with ContBusRel do begin
            Init;
            "Contact No." := Cont."No.";
            "Business Relation Code" := RMSetup."Bus. Rel. Code for SI";
            "Link to Table" := "Link to Table"::ServiceItem;
            "No." := Vend."No.";
            Insert(true);
        end;
    end;

    procedure InsertNewContactPerson(var Vend: Record "Service Item"; LocalCall: Boolean)
    var
        Cont: Record Contact;
        VendorC: Record Vendor;
        ContComp: Record Contact;
        ContBusRel: Record "Contact Business Relation";
    begin
        if not LocalCall then begin
            RMSetup.Get();
            RMSetup.TestField("Bus. Rel. Code for SI");
        end;

        ContBusRel.SetCurrentKey("Link to Table", "No.");
        ContBusRel.SetRange("Link to Table", ContBusRel."Link to Table"::ServiceItem);
        ContBusRel.SetRange("No.", Vend."No.");
        if ContBusRel.FindFirst then
            if ContComp.Get(ContBusRel."Contact No.") then
                with Cont do begin
                    Init;
                    "No." := '';
                    Insert(true);
                    "Company No." := ContComp."No.";
                    Type := Type::Person;
                    Validate(Name, Vend.Contact);

                    InheritCompanyToPersonData(ContComp);
                    Modify(true);
                    Vend."Contact MM" := "No.";
                end
    end;

    procedure ContactNameIsBlank(VendorNo: Code[20]): Boolean
    var
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
    begin
        with ContactBusinessRelation do begin
            SetCurrentKey("Link to Table", "No.");
            SetRange("Link to Table", "Link to Table"::ServiceItem);
            SetRange("No.", VendorNo);
            if not FindFirst then
                exit(false);
            if not Contact.Get("Contact No.") then
                exit(true);
            exit(Contact.Name = '');
        end;
    end;


}
