pageextension 50033 EmployeeList extends "Employee List"
{
    layout
    {
        modify("Search Name")
        {
            Visible = false;
        }
        modify(Comment)
        {
            Visible = false;
        }
        modify("No.")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = FieldsVisible;
        }
        // Add changes to page layout here
        addafter("No.")
        {
            field(Order; Order)
            {
                Visible = FieldsVisible;

            }
            field("Old Number"; "Old Number") { Visible = FieldsVisible; }
            field("Internal ID"; "Internal ID")

            {
                Visible = FieldsVisible;

            }
            field("CNG Employee"; "CNG Employee") { Visible = cng; }
            field("Salary ID"; "Salary ID") { Caption = 'Salary ID'; Visible = FieldsVisible; }
            field("Employee Full Name"; FullName())
            {
                Caption = 'Employee Full Name';
                Visible = FieldsVisible;

            }





        }
        addafter("Last Name")
        {
            field("Employee ID"; "Employee ID") { Visible = FieldsVisible; }
            field("Birth Date"; "Birth Date") { Visible = FieldsVisible; }
            field(Age; Age2) { Caption = 'Age'; Visible = FieldsVisible; }
            field(Gender; Gender) { Visible = FieldsVisible; }
            field("Org Jed"; "Org Jed") { Visible = FieldsVisible; }
            field("Department Code"; "Department Code") { Visible = FieldsVisible; }
            field("Department Name"; "Department Name") { Visible = FieldsVisible; }
            field("Group Code"; "Group Code") { Visible = FieldsVisible; }
            field("Group Description"; "Group Description") { Visible = FieldsVisible; }
            field("Department Category"; "Department Category") { Visible = FieldsVisible; }
            field("Department Cat. Description"; "Department Cat. Description") { Visible = FieldsVisible; }


            field(Sector; Sector) { Visible = FieldsVisible; }
            field("Sector Description"; "Sector Description") { Visible = FieldsVisible; }

            field("Position Code"; "Position Code") { Visible = FieldsVisible; }
            field("Position Description"; "Position Description") { Visible = FieldsVisible; }
            field("Rad u smjenama"; "Rad u smjenama") { Visible = FieldsVisible; }
            field("Engagement Type"; "Engagement Type") { Visible = FieldsVisible; }
            field("Manager 1"; EmployeeContractLedger."Manager 1")
            {
                Caption = 'Manager 1';
                Visible = FieldsVisible;

            }
            field(Manager1PositionCode; EmployeeContractLedger."Manager 1 Position Code")
            {

                Caption = 'Manager 1 Position Code';
                Visible = FieldsVisible;

            }
            field("Manager 1 position code"; EmployeeContractLedger."Manager 1 Position ID")
            {
                Caption = 'Manager 1 Position ID';
                Visible = false;
            }
            field(Manager1; EmployeeContractLedger."Manager 1 Last Name" + ' ' + EmployeeContractLedger."Manager 1 First Name")
            {
                Caption = 'Ime i prezime prvog nadređenog';
                Visible = FieldsVisible;




            }
            field("Manager 2"; EmployeeContractLedger."Manager 2") { Caption = 'Manager 2'; Visible = FieldsVisible; }
            field(Manager2PositionCode; EmployeeContractLedger."Manager 2 Position Code") { Caption = 'Manager 2 Position Code'; Visible = FieldsVisible; }

            field(Manager2; EmployeeContractLedger."Manager 2 Last Name" + ' ' + EmployeeContractLedger."Manager 2 First Name")
            {
                Caption = 'Ime i prezime drugog nadređenog';
                Visible = FieldsVisible;




            }





            field("Position Coefficient for Wage"; "Position Coefficient for Wage")
            {
                Visible = IsWageAllowed;
            }
            field(Brutto; Brutto)
            {
                Visible = IsWageAllowed;
            }
            field(Netto; Netto)
            {
                Visible = IsWageAllowed;
            }
            field("Netto Total"; "Netto Total")
            {
                Visible = IsWageAllowed;
            }


            field("Starting Date"; "Starting Date")
            {
                Visible = IsWageAllowed;
            }
            field("Ending Date"; "Ending Date")
            {
                Visible = IsWageAllowed;
            }
            field("Contract type"; "Contract type") { Caption = 'Contract Type'; Visible = false; }
            field("First employment"; EmployeeContractLedger."First Time Employed")
            {
                Caption = 'First Employment';
                Visible = IsWageAllowed;
            }
            field("Termination"; EmployeeContractLedger."Manner of Term. Code")
            {
                Caption = 'Termination';
                Visible = IsWageAllowed;
            }
            field("Termination name"; EmployeeContractLedger."Manner of Term. Description")
            {
                Caption = 'Termination Name';
                Visible = IsWageAllowed;
            }
            field("Grounds for termination"; EmployeeContractLedger."Grounds for Term. Code")
            {
                Caption = 'Grounds for termination Code';
                Visible = IsWageAllowed;
            }
            field("Grounds for term name"; EmployeeContractLedger."Grounds for Term. Description")
            {
                Caption = 'Grounds for term name';
                Visible = IsWageAllowed;
            }
            // field("Contract Termination Date"; "Contract Termination Date") { }
            field("Education Level"; "Education Level") { Visible = FieldsVisible; }


            field("Major of Graduation"; "Major of Graduation") { Visible = FieldsVisible; }
            field("Title Code"; "Title Code") { Caption = 'Title Code'; Visible = FieldsVisible; }
            field("Title Description"; "Title Description") { Visible = FieldsVisible; }
            field(Voocation; Voocation) { Visible = FieldsVisible; }
            field("Vocation Description"; "Vocation Description") { Visible = FieldsVisible; }

            field(Profession; Profession)
            {
                Visible = FieldsVisible;

            }

            field("Default Dimension"; "Default Dimension") { Visible = FieldsVisible; }
            field("Default Dimension Name"; "Default Dimension Name") { Visible = FieldsVisible; }

        }
        modify("Job Title")
        {
            Visible = false;
        }

        /*addafter("Job Title")
        {

            field("Job Position"; "Job Position")
            {

            }
        }*/
        modify("Country/Region Code")
        {
            Caption = 'Šifra države';
            Visible = FieldsVisible;

        }
        addafter("Country/Region Code")
        {
            field("Municipality Code"; "Municipality Code")
            {
                Visible = FieldsVisible;

            }
        }

        addafter(Comment)
        {

            field("Potential Employee"; "Potential Employee")
            {
                Visible = false;

            }
            field("Documentation delivered"; "Documentation delivered")
            {
                Visible = FieldsVisible;

            }
            field("Invited to interview"; "Invited to interview")
            {
                Visible = FieldsVisible;

            }
            field("Appropriate candidate"; "Appropriate candidate")
            {
                Visible = false;
            }
            field("Inappropriate candidate"; "Inappropriate candidate")
            {
                Visible = false;
            }
            field("Probation Period"; "Probation Period")
            {
                Visible = FieldsVisible;

            }
            field("Emplymt. Contract Code"; "Emplymt. Contract Code")
            {
                Visible = FieldsVisible;

            }
            field("Send PayList"; "Send PayList")
            {
                Visible = FieldsVisible;

            }
            //BH 01 start
            field("Brought Years of Experience"; "Brought Years of Experience")
            {
                ApplicationArea = all;
                Visible = FieldsVisible;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    CurrPage.update();
                end;



                trigger OnDrillDown()
                var
                    myInt: Integer;
                begin
                    CurrPage.update();
                end;

            }
            field("Brought Months of Experience"; "Brought Months of Experience")
            { Visible = FieldsVisible; }
            field("Brought Days of Experience"; "Brought Days of Experience")
            { Visible = FieldsVisible; }
            field("Brought Years of Exp. in Curr."; "Brought Years of Exp. in Curr.")
            { Visible = FieldsVisible; }
            field("Brought Months of Exp. in Curr."; "Brought Months of Exp.in Curr.")
            { Visible = FieldsVisible; }
            field("Brought Days of Exp. in Curr."; "Brought Days of Exp.in Curr.")
            { Visible = FieldsVisible; }
            field("Brought Years Total"; "Brought Years Total")
            { Visible = FieldsVisible; }
            field("Brought Months Total"; "Brought Months Total")
            { Visible = FieldsVisible; }
            field("Brought Days Total"; "Brought Days Total")
            { Visible = FieldsVisible; }
            field("Years of Experience in Company"; "Years of Experience in Company")
            { Visible = FieldsVisible; }
            field("Months of Exp. in Company"; "Months of Exp. in Company")
            { Visible = FieldsVisible; }
            field("Days of Experience in Company"; "Days of Experience in Company")
            { Visible = FieldsVisible; }
            field("Current Years Total"; "Current Years Total")
            { Visible = FieldsVisible; }
            field("Current Months Total"; "Current Months Total")
            { Visible = FieldsVisible; }
            field("Current Days Total"; "Current Days Total")
            { Visible = FieldsVisible; }
            field("Military Years of Service"; "Military Years of Service")
            {
                Visible = FieldsVisible;

            }
            field("Military Months of Service"; "Military Months of Service")
            {
                Visible = FieldsVisible;

            }
            field("Military Days of Service"; "Military Days of Service")
            { Visible = FieldsVisible; }
            field("Years of Experience"; "Years of Experience")
            {
                Visible = FieldsVisible;

            }
            field("Months of Experience"; "Months of Experience")
            {
                Visible = FieldsVisible;

            }
            field("Days of Experience"; "Days of Experience")
            {
                Visible = FieldsVisible;

            }
            field("Years with military"; "Years with military")
            {
                Visible = FieldsVisible;

            }
            field("Months with military"; "Months with military")
            {
                Visible = FieldsVisible;

            }
            field("Days with military"; "Days with military")
            {
                Visible = FieldsVisible;

            }
            field("Bank Account Code"; "Bank Account Code")
            {
                Visible = IsWageAllowed;

            }
            field("Bank Account No."; "Bank Account No.")
            {
                Caption = 'Bank Account No.';
                Visible = IsWageAllowed;
            }
            field("Bank No."; "Bank No.")
            {
                Visible = IsWageAllowed;
            }
            field("Refer To Number"; "Refer To Number")
            {
                Visible = IsWageAllowed;
            }
            field("Hours In Day"; "Hours In Day") { Visible = FieldsVisible; }
            field("Transport Allowance"; "Transport Allowance")
            {
                Visible = IsWageAllowed;
            }
            field("Transport Amount Planned"; "Transport Amount Planned")
            {
                Visible = IsWageAllowed;
            }
            field("Transport Amount"; "Transport Amount")
            {
                Visible = IsWageAllowed;
            }
            field("Wage Type"; "Wage Type")
            {
                Visible = IsWageAllowed;
            }
            field(Meal; Meal)
            {
                Visible = IsWageAllowed;
            }
            field("Tax Deduction"; "Tax Deduction") { Visible = FieldsVisible; }
            field("Tax Individual"; "Tax Individual") { Visible = FieldsVisible; }
            field("General Tax"; "General Tax") { Visible = FieldsVisible; }
            field("Additional Tax"; "Additional Tax") { Visible = FieldsVisible; }
            field("Tax Deduction Amount"; "Tax Deduction Amount")
            {
                Visible = IsWageAllowed;
            }
            field("Wage Posting Group"; "Wage Posting Group") { Visible = FieldsVisible; }
            field("Contribution Category Code"; "Contribution Category Code") { Visible = FieldsVisible; }
            field("Calculate Wage Addition"; "Calculate Wage Addition") { Visible = FieldsVisible; }

            field("Disabled Person"; "Disabled Person") { Visible = FieldsVisible; }
            field("Disability Level"; "Disability Level") { Visible = FieldsVisible; }

            field("Disabled Child"; "Disabled Child") { Visible = FieldsVisible; }

            field("Chronic Disease"; "Chronic Disease") { Visible = FieldsVisible; }
            field(Nationallity; Nationallity)
            {
                Caption = 'Nacionalnost';
                Visible = FieldsVisible;

            }
            field("Passport No."; "Passport No.") { Visible = FieldsVisible; }

            field("Citizenship 1"; "Citizenship 1") { Visible = FieldsVisible; }
            field("City of Birth"; "City of Birth") { Visible = FieldsVisible; }
            field("Municipality Code of Birth"; "Municipality Code of Birth") { Visible = FieldsVisible; }
            field("Municipality Name of Birth"; "Municipality Name of Birth") { Visible = FieldsVisible; }
            field("Country/Region Code of Birth"; "Country/Region Code of Birth") { Visible = FieldsVisible; }
            field("Address CIPS"; "Address CIPS") { Visible = FieldsVisible; }
            field("Post Code CIPS"; "Post Code CIPS") { Visible = FieldsVisible; }

            field("City CIPS"; "City CIPS") { Visible = FieldsVisible; }

            field("Municipality Code CIPS"; "Municipality Code CIPS") { Visible = FieldsVisible; }
            field("Municipality Name CIPS"; "Municipality Name CIPS") { Visible = FieldsVisible; }
            field("Country/Region Code CIPS"; "Country/Region Code CIPS") { Visible = FieldsVisible; }

            field("Entity Code CIPS"; "Entity Code CIPS") { Visible = FieldsVisible; }


            field("Municipality Code for salary"; "Municipality Code for salary") { Visible = FieldsVisible; }
            field("Mobile Phone No. for Company"; "Mobile Phone No. for Company") { Caption = 'Mobile Phone No. for company'; Visible = FieldsVisible; }

            field("Phone No.Company"; "Country/Region Code Company M" + ' ' + "Dial Code Company Mobile" + ' ' + "Mobile Phone No. for Company") { Caption = 'Phone No. for company'; Visible = FieldsVisible; }
            field("Company E-Mail"; "Company E-Mail") { Visible = FieldsVisible; }
            field("Father Name"; "Father Name") { Visible = FieldsVisible; }
            field("Mother Maiden Name"; "Mother Maiden Name") { Visible = FieldsVisible; }
            field("Mother Name"; "Mother Name") { Visible = FieldsVisible; }
            field("Marital status"; "Marital status") { Visible = FieldsVisible; }
            field("Spouse Name"; "Spouse Name") { Visible = FieldsVisible; }
            field("Number of Children"; "Number of Children") { Visible = FieldsVisible; }
            field("Full Phone No."; "Full Phone No.") { Visible = FieldsVisible; }
            field("Full Mobile Phone No."; "Full Mobile Phone No.") { Visible = FieldsVisible; }
            field("Employee Computer Knowledge"; "Employee Computer Knowledge") { Visible = FieldsVisible; }
            field("Employee Qualifications"; "Employee Qualifications") { Visible = FieldsVisible; }
            field("Employee Languages"; "Employee Languages") { Visible = FieldsVisible; }
            field("Driving Licence"; "Driving Licence") { Visible = FieldsVisible; }
            field("Driving Llicence Category"; "Driving Llicence Category") { Visible = FieldsVisible; }
            field("Active Driver"; "Active Driver") { Visible = FieldsVisible; }
            field("Blood Donor"; "Blood Donor") { Visible = FieldsVisible; }
            field("Blood Type"; "Blood Type") { Visible = FieldsVisible; }


            field("Citizenship 2"; "Citizenship 2") { Caption = 'Citizenship2'; Visible = FieldsVisible; }
            field("Additional Passport No."; "Additional Passport No.") { Visible = FieldsVisible; }

            field("Residence Permit"; "Residence Permit") { Visible = false; }
            field("Residence Permit Expiry Date"; "Residence Permit Expiry Date") { Visible = false; }
            field("Work Permit"; "Work Permit") { Visible = false; }
            field("Type Of Work Permit"; "Type Of Work Permit") { Visible = false; }
            field("Social Security No."; "Social Security No.") { Visible = FieldsVisible; }
            field("Work Booklet No."; "Work Booklet No.") { Visible = FieldsVisible; }
            field("Work Experience Document"; "Work Experience Document") { Visible = FieldsVisible; }
            field("For Calculation"; "For Calculation") { Visible = FieldsVisible; }







            //BH 01 end

        }



    }

    actions
    {
        // Add changes to page actions here
        Modify("Contact")
        {
            Visible = false;
        }

        modify(PayEmployee)
        {
            Visible = false;
        }
        modify("Ledger E&ntries")
        {
            Visible = false;
        }
        modify("Misc. Articles &Overview")
        {
            Visible = false;
        }
        modify("Mi&sc. Article Information")
        {
            Visible = false;
        }
        modify("Co&nfidential Information")
        { Visible = false; }
        modify("Con&fidential Info. Overview")
        {
            Visible = false;
        }
        /*modify(Contact)
        {
            Visible = false;
        }*/





        addafter("Co&mments")
        {

            /*//ED 01 START
            action("Base Calendar List")
            {
                Caption = 'Base Calendar List';
                Image = CalendarChanged;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BaseCalendarList.Run();
                end;
            }
            //ED 01 END

            /*action("Fill The Whole Month")
            {
                Caption = 'Fill The Whole Month';
                Image = CalendarMachine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    FillTheWholeMonth.Run();
                end;
            }*/

            action("Update Work Experience")
            {
                Caption = 'Ažuriraj staž';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    R_WorkExperience.RUN;
                    R_BroughtExperience.RUN;
                end;
            }


            /*action("Import Worksheet")
            {
                Caption = 'Import Worksheete';
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    XMLPortExample.Run;
                end;
            }*/
            action("Employee Trainings Ledger")
            {
                Caption = 'Employee Training Ledger';

                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Employee Trainings Ledger";


            }
            action("Check All For Calculation")
            {
                Caption = 'Check All For Calculation';

                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.FINDFIRST;
                    BEGIN
                        filter := Rec.GETFILTERS;
                        IF Rec."For Calculation" = FALSE THEN BEGIN
                            REPEAT
                                Rec."For Calculation" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        ELSE BEGIN
                            REPEAT
                                Rec."For Calculation" := FALSE;
                                Rec.MODIFY;

                            UNTIL Rec.NEXT = 0


                        END;
                    END;

                end;

            }
            action("Check All For Wage Addition")
            {
                Caption = 'Check All For Wage Addition';

                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.FINDFIRST;
                    BEGIN
                        filter := Rec.GETFILTERS;
                        IF Rec."Calculate Wage Addition" = FALSE THEN BEGIN

                            REPEAT
                                Rec."Calculate Wage Addition" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        ELSE BEGIN
                            REPEAT
                                Rec."Calculate Wage Addition" := FALSE;
                                Rec.MODIFY;

                            UNTIL Rec.NEXT = 0

                        END;
                    END;
                    // Rec.FINDFIRST;
                end;

            }

            action("Check All For Military Work Experience")
            {
                Caption = 'Check All For Military Work Experience';

                Image = Ledger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Rec.FINDFIRST;
                    BEGIN
                        filter := Rec.GETFILTERS;
                        IF Rec."WEP with military" = FALSE THEN BEGIN

                            REPEAT
                                Rec."WEP with military" := TRUE;
                                Rec.MODIFY;
                            UNTIL Rec.NEXT = 0;
                        END
                        ELSE BEGIN
                            REPEAT
                                Rec."WEP with military" := FALSE;
                                Rec.MODIFY;

                            UNTIL Rec.NEXT = 0

                        END;
                    END;
                    // Rec.FINDFIRST;
                end;

            }


            group(Izvještaji)
            {



                action("Izvjestaj starosne strukture")
                {
                    Caption = 'Izvještaj starosne strukture';

                    Image = Ledger;
                    ApplicationArea = all;
                    Visible = false;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj starosne strukture";


                }

                action("Pregled Bolovanja")
                {
                    Caption = 'Pregled Bolovanja';

                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Pregled Bolovanja";


                }

                action("Izvjestaj starosna spolna")
                {
                    Caption = 'Izvještaj starosna spolna';

                    Image = Ledger;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj starosna spolna";


                }

                action("Izvjestaj za trening")
                {
                    Caption = 'Izvještaj za trening';

                    Image = Ledger;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Izvjestaj za trening";


                }

                action("Evidencija preraspoređeni")
                {
                    Caption = 'Evidencija preraspoređeni';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Evidencija preraspoređeni";
                    Visible = false;


                }

                action("Uslov za penziju")
                {
                    Caption = 'Uslov za penziju';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslov za penziju";


                }
                action("Uslovi za odlazak u penziju")
                {
                    Caption = 'Uslovi za odlazak u penziju';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Uslovi za odlazak u penziju";
                    Visible = false;


                }
                action("Lista svih radnika")
                {
                    Caption = 'Lista svih radnika';
                    Image = Report;
                    ApplicationArea = all;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = report "Svi radnici";


                }


            }

            /*action("Create Worksheet")
            {
                Caption = 'Create Worksheet';
                Image = Timesheet;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    TimeSheetCreate.Run;
                end;

            }*/





        }




    }


    trigger OnOpenPage()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
        UTemp: Record "User Setup";
        HRAllowed: Boolean;
        WagesAllowed: Boolean;
        CU: Codeunit TestSubsCu;
    begin

        if "Birth Date" <> 0D then
            Age2 := ROUND((TODAY - "Birth Date") / 365.2425, 1, '<')
        else
            Age2 := 0;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        UserSetup.SetFilter("CNG Administrator", '%1', true);
        if UserSetup.FindFirst() then
            cng := true
        else
            cng := false;

        SetCurrentKey(Order);
        Ascending;
        //EmployeeContractLedger.CalcFields("Manager 1 First Name", "Manager 2 First Name");
        SetCurrentKey(Order);



        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            HRAllowed := UTemp.HR;
        WagesAllowed := UTemp."Wage Allowed";
        FieldsVisible := HRAllowed OR WagesAllowed;
        IsWageAllowed := WagesAllowed;

        if NOT FieldsVisible then
            FieldsVisible := false;


        if IsWageAllowed then
            IsWageAllowed := true;





    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        UserSetup: Record "User Setup";
    begin
        cng := false;

        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        UserSetup.SetFilter("CNG Administrator", '%1', true);
        if UserSetup.FindFirst() then
            cng := true
        else
            cng := false;


        Rec.CalcFields("Position Code");
        if "Birth Date" <> 0D then
            Age2 := ROUND((TODAY - "Birth Date") / 365.2425, 1, '<')
        else
            Age2 := 0;

        Ascending;
        EmployeeContractLedger.RESET;
        EmployeeContractLedger.SETFILTER("Employee No.", "No.");
        EmployeeContractLedger.SETFILTER(Active, '%1', TRUE);
        IF EmployeeContractLedger.FINDFIRST THEN BEGIN
            EmployeeContractLedger.CALCFIELDS("Manager Department Code", "Manager 1 Position Code", "Manager Position ID", "Manager 1 First Name", "Manager 1 Last Name", "Manager 2 First Name", "Manager 1 Last Name", "Manager 2 Last Name");

        end
        ELSE BEGIN
            EmployeeContractLedger.RESET;

            EmployeeContractLedger."Manager 1 First Name" := '';
            EmployeeContractLedger."Manager 2 First Name" := '';

        END;



    end;

    var

        R_WorkExperience: Report "Work experience in Company";

        Age2: Integer;
        filter: Text;
        R_BroughtExperience: Report "Update Brought Experience";


        //ED 01 START       
        //    FillTheWholeMonth: Report "Fill The Whole Month";

        BaseCalendarList: Page "Base Calendar List";
        //ED 01 END
        //BH 01 start
        // R_MilitaryService: Report "MilitaryService";
        //BH 01 end

        XMLPortExample: XmlPort "Import sihterica";

        //  TimeSheetCreate: Report TimeSheet2;

        myInt: Integer;
        EmployeeContractLedger: Record "Employee Contract Ledger";
        EmployeeContractLedgerPage: page "Employee Contract Ledger";
        cng: Boolean;
        IsWageAllowed: Boolean;
        FieldsVisible: Boolean;
        FieldsVisible2: Boolean;
}