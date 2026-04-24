report 50050 "OLP-1021"
{
    DefaultLayout = RDLC;
    RDLCLayout = './OLP-1021.rdl';

    dataset
    {
        dataitem(DataItem30; "Employee")
        {
            RequestFilterFields = "No.";
            column(EmpNo; DataItem30."No.")
            {
            }
            column(EmpFirstName; DataItem30."First Name")
            {
            }
            column(EmpLastName; DataItem30."Last Name")
            {
            }
            column(EmpAddress; DataItem30."Address CIPS")
            {
            }
            column(EmpCity; DataItem30."City CIPS")
            {
            }
            column(EmpPostCode; DataItem30."Post Code CIPS")
            {
            }
            column(EmpID; DataItem30."Employee ID")
            {
            }
            column(Year; Year)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompanyAddress; CompInfo.Address)
            {
            }
            column(CompanyRegistrationNo; CompInfo."Registration No.")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPostCode; CompInfo."Post Code")
            {
            }
            dataitem(DataItem1; "Wage Calculation")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                DataItemTableView = SORTING("Payment Date")
                                    ORDER(Ascending);
                column(RedBroj; RedBroj)
                {
                }
                column(PrihodKM; Brutto + BruttoAdd)
                {
                }
                column(DatumIsplate; "Payment Date")
                {
                }
                column(PIO; sumPIO)
                {
                }
                column(Zdrav; sumZDR)
                {
                }
                column(Nezap; sumNZ)
                {
                }
                column(PorezOdb; "Tax Deductions")
                {
                }
                column(UkupneStopeDopr; "Contribution From Brutto")
                {
                }
                column(TaxBasis; "Tax Basis" + TaxBasisAdd)
                {
                }
                column(Tax; Tax + TaxAdd)
                {
                }
                column(StopeDopr; StopeDopr)
                {
                }
                column(Use; Use)
                {
                }
                trigger OnAfterGetRecord()
                var
                    ContrCatCon: Record "Contribution Category Conn.";
                    t_ContrEmp: Record "Contribution Per Employee";
                    WVE: Record "Wage Value Entry";
                begin
                    sumZDR := 0;
                    sumPIO := 0;
                    sumNZ := 0;
                    RedBroj += 1;
                    CALCFIELDS("Use Netto");
                    t_ContrEmp.SETFILTER("Employee No.", "Employee No.");
                    t_ContrEmp.SETFILTER("Wage Header No.", "Wage Header No.");
                    t_ContrEmp.SETFILTER(t_ContrEmp."Amount From Wage", '>%1', 0);
                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1|%2', 'D-PIO-IZ', 'D-PIO-IZ2');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumPIO += t_ContrEmp."Amount From Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;

                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1|%2', 'D-ZDRAV-IZ', 'D-ZDRAV-I2');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumZDR += t_ContrEmp."Amount From Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;

                    t_ContrEmp.SETFILTER(t_ContrEmp."Contribution Code", '%1|%2', 'D-NEZAP-IZ', 'D-NEZAP-I2');
                    IF t_ContrEmp.FINDFIRST THEN BEGIN
                        REPEAT
                            sumNZ += t_ContrEmp."Amount From Wage";
                        UNTIL t_ContrEmp.NEXT = 0;
                    END;

                    StopeDopr := 0;
                    ContrCatCon.SETRANGE("Category Code", DataItem1."Contribution Category Code");
                    ContrCatCon.SETRANGE("Contribution Code", 'D-PIO-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;
                    ContrCatCon.SETRANGE("Contribution Code", 'D-ZDRAV-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;
                    ContrCatCon.SETRANGE("Contribution Code", 'D-NEZAP-IZ');
                    IF ContrCatCon.FIND('-') THEN
                        StopeDopr += ContrCatCon.Percentage;

                    BruttoAdd := 0;
                    NettoAdd := 0;
                    TaxAdd := 0;
                    TaxBasisAdd := 0;

                    //*******************************************Additions****************************************//
                    WVE.SETFILTER("Document No.", "Wage Header No.");
                    WVE.SETFILTER("Employee No.", "Employee No.");
                    WVE.SETFILTER("Wage Calculation Type", '%1', WVE."Wage Calculation Type"::"Additions");
                    WVE.SETFILTER("Entry Type", '%1|%2', WVE."Entry Type"::"Net Wage", WVE."Entry Type"::Taxable);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            BruttoAdd += WVE."Cost Amount (Brutto)";
                            NettoAdd += WVE."Cost Amount (Netto)";
                        UNTIL WVE.NEXT = 0;

                    // Dohvati poreze u dodatnim primanjima, ako ih ima!
                    WVE.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Tax);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            TaxAdd := TaxAdd + WVE."Cost Amount (Netto)";
                            TaxBasisAdd += (WVE."Cost Amount (Netto)" / 0.1);
                        UNTIL WVE.NEXT = 0;

                    // Dohvati doprinose u dodatnim primanjima, ako ih ima!
                    WVE.SETFILTER("Entry Type", '%1', WVE."Entry Type"::Contribution);
                    WVE.SETFILTER("AT From", '%1', TRUE);
                    IF WVE.FIND('-') THEN
                        REPEAT
                            CASE WVE."Contribution Type" OF
                                'D-NEZAP-IZ', 'D-NEZAP-I2':
                                    sumNZ += WVE."Cost Amount (Netto)";
                                'D-PIO-IZ', 'D-PIO-IZ2':
                                    sumPIO += WVE."Cost Amount (Netto)";
                                'D-ZDRAV-IZ', 'D-ZDRAV-I2':
                                    sumZDR += WVE."Cost Amount (Netto)";
                            END;
                        UNTIL WVE.NEXT = 0;
                end;

                trigger OnPreDataItem()
                begin
                    CompInfo.GET;
                    DataItem1.SETRANGE("Payment Date", StartDated, EndDated);
                    RedBroj := 0;
                end;
            }

            trigger OnPreDataItem()
            begin
                CompInfo.GET;
                // Sortiranje po prezimenu, zatim po imenu.
                SETCURRENTKEY("Last Name", "First Name");
                EVALUATE(Godina, FORMAT(Year));
                StartDate := '1.1.' + Godina;
                EndDate := '31.12.' + Godina;
                EVALUATE(StartDated, StartDate);
                EVALUATE(EndDated, EndDate);
                SETFILTER("Wage Posting Group", '%1', 'FBiH');
                //SETFILTER(Status,'%1',Status::Active);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Date and year")
                {
                    Caption = 'Year';
                    field(Year; Year)
                    {
                        Caption = 'Year';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());

        Year := DATE2DMY(CALCDATE('-2M', WORKDATE), 3);
    end;

    var
        Year: Integer;
        CompInfo: Record "Company Information";
        sumZDR: Decimal;
        sumPIO: Decimal;
        sumNZ: Decimal;
        Godina: Text;
        StartDate: Text;
        EndDate: Text;
        StartDated: Date;
        EndDated: Date;
        RedBroj: Integer;
        StopeDopr: Decimal;
        TaxBasisAdd: Decimal;
        TaxAdd: Decimal;
        BruttoAdd: Decimal;
        NettoAdd: Decimal;
}

