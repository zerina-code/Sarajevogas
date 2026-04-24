report 50157 "Leveling report"
{
    DefaultLayout = RDLC;
    PreviewMode = Normal;
    RDLCLayout = './Izvjestaj_nivelacija.rdl';

    dataset
    {
        dataitem(DataItem1; "Value Entry")
        {
            DataItemTableView = WHERE(nivelacija = filter(true));

            column(Name_CompanyInformation; comp.Name)
            {
            }
            column(Address_CompanyInformation; comp.Address)
            {
            }
            column(ExecutionTime; FORMAT(reportdate, 0, '<day,2>.<month,2>.<year4>'))
            {
            }
            column(OldPrice; OldPrice) { }
            column(Wholesale_Unit_Price; "Wholesale Unit Price") { }
            column(OldV; OldV) { }
            column(NewValue; NewValue) { }
            column(Niv; Niv) { }
            column(ItemV; ItemV) { }
            column(UnitM; UnitM) { }
            column(Valued_Quantity; "Valued Quantity") { }
            column(NiB; NiB) { }
            column(Control_Employee_Name; "Control Employee Name") { }
            column(Prepare_Employee_Name; "Prepare Employee Name") { }
            column(Verif_Employee_Name; "Verif Employee Name") { }
            column(PreparePos; PreparePos) { }
            column(VerifPost; VerifPost) { }
            column(COntrolPos; COntrolPos) { }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                VE: Record "Value Entry";
                ItemG: Record item;

            begin


                VerifPost := '';
                COntrolPos := '';
                PreparePos := '';
                EmployeeCL.Reset();
                EmployeeCL.SetFilter("Employee No.", '%1', DataItem1."Prepare Employee No.");
                EmployeeCL.SetFilter(Active, '%1', true);
                if EmployeeCL.FindFirst() then
                    PreparePos := EmployeeCL."Position Description";


                EmployeeCL.Reset();
                EmployeeCL.SetFilter("Employee No.", '%1', DataItem1."Control Employee No.");
                EmployeeCL.SetFilter(Active, '%1', true);
                if EmployeeCL.FindFirst() then
                    COntrolPos := EmployeeCL."Position Description";


                EmployeeCL.Reset();
                EmployeeCL.SetFilter("Employee No.", '%1', DataItem1."Verif Employee No.");
                EmployeeCL.SetFilter(Active, '%1', true);
                if EmployeeCL.FindFirst() then
                    VerifPost := EmployeeCL."Position Description";


                comp.get;
                reportdate := today;
                VE.Reset();
                VE.SetFilter("Entry No.", '%1', DataItem1."Item Ledger Entry No.");
                if VE.findfirst then begin
                    OldPrice := ve."Wholesale Unit Price";


                end;

                Niv := DataItem1."Valued Quantity" * DataItem1."Wholesale Unit Price" - DataItem1."Valued Quantity" * OldPrice;
                OldV := DataItem1."Valued Quantity" * OldPrice;
                NewValue := DataItem1."Valued Quantity" * DataItem1."Wholesale Unit Price";
                ItemG.Get(DataItem1."Item No.");
                ItemV := ItemG.Description;
                UnitM := ItemG."Sales Unit of Measure";
                NiB := DataItem1."Nivelacija No.";


            end;

        }


    }

    var
        comp: record "Company Information";
        OldV: Decimal;
        ItemV: text[250];
        NewValue: Decimal;
        reportdate: date;
        OldPrice: Decimal;

        Niv: Decimal;
        UnitM: code[20];
        NiB: text[250];
        EmployeeCL: Record "Employee Contract Ledger";
        PreparePos: Text[250];
        COntrolPos: Text[250];
        VerifPost: text[250];

}

