pageextension 50025 ContactCard extends "Contact Card"
{
    layout
    {

        addafter(Name)
        {
            field("Responsible Contact"; "Responsible Contact")
            {
                ApplicationArea = all;
                Visible = true;
            }
            field(Owner; Owner) { }
            field("Contract Date to"; "Contract Date to") { }
            field("Job Title"; "Job Title") { }
            field(Rpa; Rpa) { }
            field(Rpb; Rpb) { }
        }


        addafter(Type)
        {
            field("Active CNG"; "Active CNG") { ApplicationArea = all; Visible = Visib; }
        }


        addafter("Search Name")
        {
            field("Title Description"; "Title Description") { }
            field("Education Level"; "Education Level") { }
        }
        addafter("Phone No.") { field("Phone - Transfer"; "Phone - Transfer") { ApplicationArea = all; } }
        addafter("Fax No.") { field("Fax - Transfer"; "Fax - Transfer") { ApplicationArea = all; } }
        // Add changes to page layout here
        modify("Next Task Date") { Visible = false; }
        modify("Exclude from Segment") { Visible = false; }
        modify("Privacy Blocked") { Visible = false; }
        modify(Minor) { Visible = false; }
        modify("Parental Consent Received") { Visible = false; }
        modify(LastDateTimeModified) { Visible = false; }
        modify(Control31) { visible = false; }
        modify("Country/Region Code") { Visible = false; }
        modify("Language Code") { Visible = false; }
        addafter("E-Mail") { field("E-Mail 2"; "E-Mail 2") { ApplicationArea = all; } }
        modify("Company No.")
        {
            Visible
        = true;
        }
        modify("Company Name") { Visible = true; }

        addafter(Type)
        {
            field("Type Relation"; "Type Relation") { ApplicationArea = all; }
        }
        modify("Salesperson Code") { Visible = false; }
        modify("Salutation Code") { visible = false; }
        modify("Organizational Level Code") { Visible = false; }
        modify("Correspondence Type") { Visible = false; }
        modify("Foreign Trade") { Visible = false; }
        modify(City)
        {
            Editable = false;
        }

        modify("Post Code")
        {
            Editable = false;
        }
        addafter(Address)
        {
            field("Contractor No"; "Contractor No")
            {
                ApplicationArea = all;
                Visible = false;

            }
            field("Street"; Rec."Street")
            {
                ApplicationArea = all;
            }
            field("Street Name"; Rec."Street Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Street No."; Rec."Street No.")
            {
                ApplicationArea = all;
            }
            field("Municipality Code"; Rec."Municipality Code")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Municipality Name"; Rec."Municipality Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("MZ"; Rec."MZ")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("MZ Name"; Rec."MZ Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addlast(General)
        {
            field("EU Activity"; Rec."EU Activity")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here

        addafter("Create &Interaction")
        {

            action("Obrada - import")
            {
                ApplicationArea = all;
                Caption = 'Obrada - import';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    CustomerTable: XmlPort "Contact Import";

                begin
                    CustomerTable.RUN;
                end;
            }

            //



        }

    }

    var
        myInt: Integer;
        UserS: Record "User Setup";
        Visib: Boolean;
        Visibe: Boolean;
        vis: Boolean;
        CanModify: Boolean;
        CanModify1: Boolean;
        CanModify2: Boolean;
        CanModify3: Boolean;
        CanModify4: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetRelationType();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;


    begin

        if "Type Relation" = "Type Relation"::Contractor then
            Visibe := True
        else
            Visibe := false;

        if "Type Relation" = "Type Relation"::"Construction Manager" then
            vis := true
        else
            vis := false;

        UserS.Reset();
        UserS.setfilter("User ID", '%1', USERID);
        UserS.SetFilter("CNG Administrator", '%1', true);
        if users.FindFirst() then
            Visib := true
        else
            Visib := false;

    end;
    //permissions on modify-EK

    trigger OnModifyRecord(): Boolean
    begin
        UserS.Reset();
        UserS.SetFilter("User ID", '%1', UserId);

        if UserS.FindFirst() then
            CanModify3 := UserS.MM_UGI_M;

        CanModify := UserS.MM_UGI_KON_DIM;
        CanModify1 := UserS.MM_UGI_KON_UGIZV;
        CanModify2 := UserS.MM_UGI_KON_P;
        CanModify4 := UserS.Lista_institucija_za_PPZ_i_ZNR;


        // Check for Type Relation 12, 8, or 10
        if ("Type Relation".AsInteger() = 12) then begin
            if not CanModify then
                Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;


        if ("Type Relation".AsInteger() = 8) then begin
            if not CanModify1 then
                Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;



        if ("Type Relation".AsInteger() = 10) then begin
            if not CanModify2 then
                Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;


        if ("Type Relation".AsInteger() = 16) then begin
            if not CanModify4 then
                Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;
        // Check for all other Type Relation values where CanModify3 must be true

        if ("Type Relation" = "Type Relation"::ServiceItem)
        or ("Type Relation" = "Type Relation"::Customer) then begin
            if not CanModify3 then
                Error('Nemate dozvolu da modifikujete ovu karticu.');
        end;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;

    begin
        if "Type Relation" = "Type Relation"::Contractor then
            Visibe := True
        else
            Visibe := false;

        if "Type Relation" = "Type Relation"::"Construction Manager" then
            vis := true
        else
            vis := false;
        UserS.Reset();
        UserS.setfilter("User ID", '%1', USERID);
        UserS.SetFilter("CNG Administrator", '%1', true);
        if users.FindFirst() then
            Visib := true
        else
            Visib := false;

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        if "Type Relation" = "Type Relation"::"Construction Manager" then
            vis := true
        else
            vis := false;

    end;

    local procedure SetRelationType()
    var
        NewRelationType: enum "Contact Business Relation Link To Table";
    begin
        if Rec.GetFilter("Type Relation") = '' then
            exit;

        NewRelationType := Rec.GetRangeMax("Type Relation");
        Rec."Type Relation" := NewRelationType;
    end;
}