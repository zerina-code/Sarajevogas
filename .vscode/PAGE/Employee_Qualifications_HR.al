page 50102 Employee_Qualifications_HR
{

    PageType = List;
    Caption = 'Employee Qualifications HR';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Qualification";
    RefreshOnActivate = true;


    layout
    {
        area(content)
        {
            repeater(Control1)
            {

                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = all;
                    Visible = false;

                }

                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Computer Knowledge Code"; "Computer Knowledge Code")
                {
                    ApplicationArea = all;
                    Visible = visibleComputer;

                }
                field("Computer Knowledge Description"; "Computer Knowledge Description")
                {
                    ApplicationArea = all;
                    Visible = visibleComputer;
                }
                field("Language Code"; "Language Code")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;

                    /*  trigger OnDrillDown()
                      var
                          EmployeeDon: Record "Types Of Diseases";
                          EBD: Page "Language";
                      begin
                          EmployeeDon.RESET;
                          EmployeeDon.SETFILTER(Types, '%1', EmployeeDon.Types::Languages);
                          EBD.SETTABLEVIEW(EmployeeDon);
                          EBD.RUN;

                      END;*/

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        EBDPage: Page Language;
                        ED: Record "Types Of Diseases";
                        Users: Record "User Setup";
                    begin


                        CLEAR(EBDPage);

                        EBDPage.LOOKUPMODE(TRUE);

                        ED.SetFilter(Types, '%1', ED.Types::Languages);
                        Commit();
                        UserS.Reset();
                        UserS.SetFilter("User ID", '%1', UserId);
                        if UserS.FindFirst() then begin
                            UserS."Qualification Type" := UserS."Qualification Type"::Languages;
                            UserS.Modify();


                        end;
                        Commit();
                        EBDPage.SetTableView(ED);
                        IF EBDPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            EBDPage.GETRECORD(ED);

                            "Language Code" := ED.Code;
                            "Language Name" := ED.Description;




                        END;

                    end;





                }
                field("Language Name"; "Language Name")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;
                    trigger OnDrillDown()
                    var
                        EmployeeDon: Record "Types Of Diseases";
                        EBD: Page "Language";
                    begin
                        EmployeeDon.RESET;
                        EmployeeDon.SETFILTER(Types, '%1', EmployeeDon.Types::Languages);
                        EBD.SETTABLEVIEW(EmployeeDon);
                        EBD.RUN;

                    END;


                }
                field("Language Level"; "Language Level")
                {
                    ApplicationArea = all;
                    Visible = visibleLanguage;
                }
                field("Qualification Code"; "Qualification Code")
                {
                    ApplicationArea = all;
                    Visible = visibleQualification;
                }
                field(Description2; Description2)
                {
                    ApplicationArea = all;
                    Visible = visibleQualification;
                }
                field("Institution/Company"; "Institution/Company")
                {
                    ApplicationArea = all;
                }
                field("Decision No."; "Decision No.")
                {
                    ApplicationArea = all;
                }
                field("Exam Passed"; "Exam Passed")
                {
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field("Evidence of certification"; "Evidence of certification")
                {
                    ApplicationArea = all;
                }
                field("Expiration Date"; "Expiration Date")
                {

                }
                field(Comment; Comment)
                {
                    ApplicationArea = all;
                }
                field("Sector Description"; "Sector Description")
                {
                    ApplicationArea = all;
                }
                field("Department Category"; "Department Category")
                {
                    ApplicationArea = all;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field(Position; Position)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
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
        UserS: Record "User Setup";


    begin
        Filter := '';
        Filter1 := '';
        Filter2 := '';
        UserS.Reset();
        UserS.SetFilter("User ID", '%1', UserId);
        if UserS.FindFirst() then begin
            if UserS."Qualification Type" = UserS."Qualification Type"::Certification then
                Filter := 'Kvalifikcija';
            if UserS."Qualification Type" = UserS."Qualification Type"::"Computer Knowledge" then
                Filter1 := 'Kompjuter';

            if UserS."Qualification Type" = UserS."Qualification Type"::Languages then
                Filter2 := 'Jezik';

        end;
        IF (Filter <> '') THEN BEGIN
            visibleQualification := TRUE;
            visibleComputer := FALSE;
            visibleLanguage := FALSE;
        END
        ELSE
            IF (Filter1 <> '') THEN BEGIN
                visibleQualification := FALSE;
                visibleComputer := TRUE;
                visibleLanguage := FALSE;
            END
            ELSE
                IF (Filter2 <> '') THEN BEGIN
                    visibleQualification := FALSE;
                    visibleComputer := FALSE;
                    visibleLanguage := TRUE;
                END
                ELSE BEGIN
                    visibleQualification := TRUE;
                    visibleComputer := TRUE;
                    visibleLanguage := TRUE;
                END;


        FilterGroup(0);

    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin




    end;

    var
        myInt: Integer;
        Userset: Record "User Setup";
        Filter: Text;
        Filter1: Text;
        Filter2: Text;
        visibleQualification: Boolean;
        Cert: Boolean;
        visibleLanguage: Boolean;
        visibleComputer: Boolean;



}


