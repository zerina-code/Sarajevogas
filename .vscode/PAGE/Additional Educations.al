page 50147 "Education History"
{
    Caption = 'Education History';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "Additional Education";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field(FullName; format(LastName) + ' ' + format(FirstName))
                {
                    Caption = 'Full Name';
                    ApplicationArea = all;
                }
                field("Education Level"; "Education Level")
                {
                    ApplicationArea = all;
                }
                field("School of Graduation"; "School of Graduation")
                {
                    ApplicationArea = all;
                }
                /*field(Major; Major)
                {
                    ApplicationArea = all;
                }*/

                field("Title Description"; "Title Description")
                {
                    ApplicationArea = all;
                }
                field(Title; Title)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }

                field("Vocation Description"; "Vocation Description")
                {
                    ApplicationArea = all;

                }

                field(Vocation; Vocation)
                {
                    ApplicationArea = all;

                }


                field("Profession Description"; "Profession Description")
                {
                    ApplicationArea = all;
                }
                field(Profession; Profession)
                {
                    Visible = IsVisible;
                    ApplicationArea = all;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = all;
                }
                field("Insert Date"; "Insert Date")
                {
                    ApplicationArea = all;
                }
                field("Employee ID"; "Employee ID")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }

                field("Team Description"; "Team Description")
                {
                    ApplicationArea = all;
                    visible = false;
                }
                field("Group Description"; "Group Description")
                {
                    ApplicationArea = all;
                }
                field("Department Cat.Description"; "Department Cat.Description")
                {
                    ApplicationArea = all;
                }
                field("Sector Description"; "Sector Description")
                {
                    ApplicationArea = all;
                }
                /* field("Department Cat.Description"; "Department Cat.Description")
                 {
                     Caption = '<Department Categroy>';
                     ApplicationArea = all;
                 }*/

            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        IF "Employee No." <> '' THEN BEGIN
            Emp.RESET;
            Emp.SETFILTER("No.", "Employee No.");
            IF Emp.FINDFIRST THEN
                FirstName := Emp."First Name";
            LastName := Emp."Last Name";
        END;
    end;

    trigger OnClosePage()
    begin
        //IF "Current Education"=FALSE THEN BEGIN
        //Emp.RESET;
        //AddEdu.RESET;
        //AddEdu2.RESET;
        //CurrPage.UPDATE;
        //END;
    end;

    trigger OnOpenPage()
    begin
        IF "Employee No." <> '' THEN BEGIN
            Emp.RESET;
            Emp.SETFILTER("No.", "Employee No.");
            IF Emp.FINDFIRST THEN
                FirstName := Emp."First Name";
            LastName := Emp."Last Name";
        END;

        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" = 'HR OPERATER - TEST' THEN
                IsVisible := FALSE
            ELSE
                IsVisible := TRUE;
        END;
    end;

    var
        Emp: Record "Employee";
        AddEdu: Record "Points per Experience Years";
        AddEdu2: Record "Points per Experience Years";
        EduHis2: Record "Wage/Reduction Bank Accounts";
        Emp2: Record "Employee";
        FirstName: Text[250];
        LastName: Text[250];
        UserPersonalisation: Record "User Personalization";
        IsVisible: Boolean;
}

