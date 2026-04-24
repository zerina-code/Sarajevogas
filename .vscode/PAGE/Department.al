page 50069 Department
{
    Caption = 'Department';
    PageType = List;
    SourceTable = Department;
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin



                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        //GET(Code,"ORG Shema","Team Description","Department Categ.  Description","Group Description");
                        /*Gr.SETFILTER(Code,'%1',Code);
                         IF Gr.FINDSET THEN REPEAT
                            IF Gr.GET(Gr.Code,Gr."Org Shema",Gr.Description)
                              THEN
                              Gr.RENAME(Gr.Code,Gr."Org Shema",Description)
                           UNTIL Gr.NEXT=0;
                           */

                    end;
                }
                field("Department Type"; "Department Type")
                {
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Residence/Network"; "Residence/Network")
                {
                    ApplicationArea = all;
                    visible = false;


                }
                field(City; City)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department ID"; "Department ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Department IC"; "Department IC")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("ORG Shema"; "ORG Shema")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector)
                {
                    Caption = 'Sector';
                    ApplicationArea = all;
                }
                field("Sector  Description"; "Sector  Description")
                {
                    Caption = 'Sector Description';
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Department Categ.  Description"; "Department Categ.  Description")
                {
                    ApplicationArea = all;
                }
                field("Group Code"; "Group Code")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    Editable = true;
                    ApplicationArea = all;

                    trigger OnValidate()
                    begin
                        //GET(Code,"ORG Shema","Team Description","Department Categ.  Description","Group Description");
                    end;
                }
                field("Team Code"; "Team Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Team Description"; "Team Description")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entity of Agency"; "Entity of Agency")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets administrator"; "Timesheets administrator")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets administrator 2"; "Timesheets administrator 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Timesheets Manager"; "Timesheets Manager")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cnfidential Clerk 1"; "Cnfidential Clerk 1")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 1 Full Name"; "Confidential Clerk 1 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 1 Position"; "Confidential Clerk 1 Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cnfidential Clerk 2"; "Cnfidential Clerk 2")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 2 Full Name"; "Confidential Clerk 2 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Confidential Clerk 2 Position"; "Confidential Clerk 2 Position")
                {
                    Editable = false;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Start Date"; "Start Date")

                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1"; "Signatory 1")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Signatory 1 Full Name"; "Signatory 1 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 Position"; "Signatory 1 Position")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Signatory 2"; "Signatory 2")
                {
                    ApplicationArea = all;
                    Visible = true;
                }
                field("Prip Realisation"; "Prip Realisation") { }
                field("Prip Control"; "Prip Control") { }
                field("Prip Verif"; "Prip Verif") { }
                field("Signatory 2 Full Name"; "Signatory 2 Full Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 2 Position"; "Signatory 2 Position")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 Contr With Benef"; "Signatory 1 Contr With Benef")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 1 With Benef Name"; "Signatory 1 With Benef Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("Signatory 2 Contr With Benef"; "Signatory 2 Contr With Benef")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Signatory 2 With Benef Name"; "Signatory 2 With Benef Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Idenity"; "Department Idenity")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Group identity"; "Department Group identity")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Department Team identity"; "Department Team identity")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Sector Identity"; "Sector Identity")
                {
                    Editable = true;
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Short Code"; "Short Code")
                {

                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {



        }
    }

    trigger OnOpenPage()
    begin
        OS.SETFILTER(Status, '%1', OS.Status::Active);
        IF OS.FINDFIRST THEN
            SETFILTER("ORG Shema", '%1', OS.Code);

        IF ("Operator No." = 'MBDOM\HRAPP') OR ("Operator No." = 'MBDOM\FEDJA.BOGDANOVIC') THEN
            EditableB := TRUE
        ELSE
            EditableB := FALSE;
    end;

    var
        OS: Record "ORG Shema";
        LengthCode: Integer;
        Sec: Record "Sector";
        DepCat: Record "Department Category";
        Gr: Record "Group";
        //ĐK     Team: Record "TeamT";
        DepartmentValidate: Record "Department";
        //   OrgReport: Report "Org report";
        //       DimensionForReport5: Record "Dimension for report";
        DimensionCopy5: Record "Dimension temporary";
        Department: Record "Department";
        //OrgGroup: Report "Org GROUP";
        //OrgTeam: Report "Org Team";
        EditableB: Boolean;
        DimensionTemporery: Record "Dimension temporary";
    //DimensPage: Page "Dimensions temporary 2";
}

