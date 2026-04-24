/*report 50151 "UpdateData"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItemName; Customer)
        {


            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                //   SetFilter("MM Category", '%1', "MM Category"::" ");

                SETFILTER("Primary Contact No.", '%1', 'KONT-196985');
                SETFILTER("No.", '<>%1', '400003');


            end;

            trigger OnAfterGetRecord()
            var
                Cust: Record Customer;
                DecimalEvalute: Decimal;
                Gauge: record Gauge;
                DataI: Record "Calculation Journal Line";
                CustomerLedgerEntry: Record "Cust. Ledger Entry";
                RezDecimal: Decimal;
                ECL: Record "Employee Contract Ledger";
                CB: record "Contact Business Relation";

            begin

                CB.Reset();
                CB.SetFilter("No.", '%1', "No.");
                CB.SetFilter("Business Relation Code", '%1', 'KUP');
                CB.SetFilter("Link to Table", '%1', 1);
                if CB.FindFirst() then begin
                    DataItemName."Primary Contact No." := cb."Contact No.";
                    DataItemName."Primary Contact No.2" := cb."Contact No.";
                    DataItemName.Modify();
                end;




            end;

        }

    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        //        Brojac := 0;



    end;

    trigger OnPostReport()
    var
        myInt: Integer;
    begin

    end;


    var
        myInt: Integer;
        CodeS: Code[20];
        Brojac: Integer;
        SifraPO: Code[20];
        OldNumber: Code[20];
        Prices: Record "Sales Price";
        PosM: Record "Position Menu";
        AdditionalEd: Record "Additional Education";
        SH: Record "Status History";
        Gau: Record Gauge;
        EL: Record "Employee Level Of Disability";
        EQ: Record "Employee Qualification";
        EmpOLD: Record Employee;
        EmpOLD2: Record Employee;
        Cust: Record Customer;
        ContractP: Record "Contract Phase t";
        MM_I: Record "Service Item";
        SH_MM: Record "Status History";

        EmployeeRelative: Record "Employee Relative";
        PersonalD: Record "Personal Documents";
        ECL: Record "Employee Contract Ledger";
        HeadOf: Record "Head Of's";
        HeadOfOrg: Record "Head Of's";
        Pos: Record Position;
        WB: Record "Work Booklet";
        ECLE: Record "Employee Contract Ledger";

        Alternative: Record "Alternative Address";

        PersonalTrack: Record "Personal track report";


        PlanGO2: Record "Vacation Ground 2";
        Order2: Integer;


        Emp: Record Employee;
        PosR: Record Position;
        alt: Record "Alternative Address";

}*/