report 50111 "Obligations Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Obligations Report.rdl';

    dataset
    {
        dataitem(Obligation; Obligation)
        {
            column(InventarniBroj; "No.") { }
            column(Tip; Tip) { }
            column(Z_Obligation; "Z.Obligation") { }
            column(R_Obligation; "R.Obligation") { }
            column(Selected; Selected) { }
            column(ToDayDate; ToDayDate) { }
            column(Brojac; Brojac) { }
            column(Location_Code; Location_Name) { }
            column(SerijskiBroj; SerijskiBroj) { }
            column(NazivOs; NazivOs) { }
            column(Insert_Position; "User Position") { }
            column(Konto; Konto) { }
            column(Date_From; "Date From") { }
            column(Date_To; "Date To") { }
            column(Employee_No_; "Employee No.") { }
            column(Responsible_Person_Name; "Responsible Person Name") { }
            column(Use_FA_Type; "Use FA Type") { }
            column(Employee_No____Use_FA; "Employee No. - Use FA") { }
            column(Employee_Name___Use_FA; "Employee Name - Use FA") { }
            column(User_ID; Emp."First Name" + ' ' + Emp."Last Name") { }
            column(User_ID_Sector; "User ID Sector") { }
            column(Responsible_Sector; "Responsible Sector") { }
            column(Insert_Date; "Insert Date") { }
            column(Picture_CompanyInfo; CompanyInformation.Picture) { }
            column(ReportTitle; ReportTitle) { }
            column(BrDokZadRaz; BrDokZadRaz) { }
            column(columnLabel; columnLabel) { }
            column(footerLabel; footerLabel) { }
            column(footerAction; footerAction) { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                Employee.deleteall;
                Brojac := 0;
                SetCurrentKey("Employee No.");
                Ascending;
                CompanyInformation.GET;
                CompanyInformation.CALCFIELDS(Picture);
                ReportTitle := '';
                BrDokZadRaz := '';
                columnLabel := '';
                footerLabel := '';
                footerAction := '';
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                NAB: Record "FA Ledger Entry";
                G_L: Record "G/L Entry";
            begin
                if "Obligation type" = "Obligation type"::"Zaduženje" then begin
                    ReportTitle := 'Z A D U Ž E N J E';
                    BrDokZadRaz := "Z.Obligation";
                    columnLabel := 'Zaduženje';
                    footerLabel := 'Radnik koji preuzima predmet zaduženja';
                    footerAction := 'Primio';
                end
                else
                    if "Obligation type" = "Obligation type"::"Razduženje" then begin
                        ReportTitle := 'R A Z D U Ž E N J E';
                        BrDokZadRaz := "R.Obligation";
                        columnLabel := 'Razduženje';
                        footerLabel := 'Radnik koji razdužuje predmet';
                        footerAction := 'Razdužio';
                    end
                    else
                        ReportTitle := '';
                Location.Reset();
                Location.SetFilter(Code, '%1', "Location Code");
                if Location.FindFirst() then
                    Location_Name := Location.Name
                else
                    Location_Name := '';

                NAB.Reset();
                NAB.SetFilter("FA No.", '%1', Obligation."No.");
                NAB.SetFilter("FA Posting Type", '%1', NAB."FA Posting Type"::"Acquisition Cost");
                NAB.SetFilter(Description, '<>%1', 'A');
                NAB.SetCurrentKey("Posting Date", "Entry No.");
                NAB.Ascending;
                if NAB.FindLast() then begin
                    G_L.Reset();
                    G_L.SetFilter("Document No.", '%1', NAB."Document No.");
                    G_L.SetFilter("Entry No.", '%1', NAB."G/L Entry No.");
                    if G_L.FindFirst() then
                        Konto := G_L."G/L Account No.";
                end;
                if "Obligation type" = "Obligation type"::"Zaduženje" then
                    Selected := selected::"Zaduženje"
                else
                    Selected := selected::"Razduženje";

                Employee.Reset();
                Employee.SetFilter("No.", '%1', Obligation."Employee No.");
                if not Employee.FindFirst() then begin
                    Employee.init;
                    Employee."No." := Obligation."Employee No.";
                    Employee.Insert();
                    Brojac := 1;
                end
                else begin
                    Brojac += 1;
                end;
                ToDayDate := Today;
                US.Reset();
                US.SetFilter("User ID", '%1', Obligation."User ID");
                if US.FindFirst() then begin
                    Emp.Get(US."Employee No. for Wage");


                end;
                fA.Reset();
                FA.SetFilter("No.", '%1', Obligation."No.");
                if FA.FindFirst() then begin
                    SerijskiBroj := FA."Serial No.";
                    NazivOs := fa.Description;
                    FC.Reset();
                    FC.SetFilter(Code, '%1', FA."FA Class Code");
                    if FC.FindFirst() then
                        Tip := FC.Name
                    else
                        Tip := '';

                end
                else begin
                    Tip := '';
                    SerijskiBroj := '';
                    NazivOs := '';

                end;

            end;

        }



    }



    requestpage
    {
        layout
        {
            area(Content)
            {

                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    Caption = 'Selected';
                    Visible = false;


                }


            }

        }



    }



    var
        myInt: Integer;
        US: Record "User Setup";
        Selected: Option " ","Zaduženje","Razduženje";
        Emp: Record Employee;
        FA: Record "Fixed Asset";

        Location: Record "FA Location";
        FC: Record "FA Class";
        Tip: Text[250];
        Konto: Code[20];
        SerijskiBroj: Text[250];
        NazivOs: Text[250];
        Brojac: Integer;
        ToDayDate: Date;
        Naziv: Text[250];
        Ime: Text[250];
        Employee: Record Employee temporary;
        Location_Name: text[250];
        CompanyInformation: Record "Company Information";
        ReportTitle: Text;
        BrDokZadRaz: Text;
        columnLabel: Text;
        footerLabel: Text;
        footerAction: Text;
}