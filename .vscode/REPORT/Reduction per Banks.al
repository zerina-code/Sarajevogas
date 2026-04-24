report 50074 "Reduction per Banks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reduction per Banks.rdl';
    Caption = 'Reduction per Banks';
    UseSystemPrinter = true;

    dataset
    {
        dataitem("Reduction Types"; "Reduction Types")
        {

            dataitem(DataItem1; "Reduction per Wage")
            {
                //ĐK DataItemLink = Type = FIELD(Code);
                RequestFilterFields = "Wage Header No.";
                column(EmployeeNo; DataItem1."Employee No.")
                {
                }
                column(Amount; DataItem1.Amount)
                {
                }
                column(DateofCalculation; DataItem1."Date of Calculation")
                {
                }
                column(WHo; DataItem1."Wage Header No.")
                {
                }
                column(ReductionNo_ReductionperWage; DataItem1."Reduction No.")
                {
                }
                column(EmployeeNo_ReductionperWage; DataItem1."Employee No.")
                {
                }
                column(Amount_ReductionperWage; DataItem1.Amount)
                {
                }
                column(DateofCalculation_ReductionperWage; DataItem1."Date of Calculation")
                {
                }
                column(Type_ReductionperWage; DataItem1.Type)
                {
                }
                column(Rbr; RBr)
                {
                }
                column(Year; DataItem1."Year of Wage")
                {
                }
                column(Month; DataItem1."Month of Wage")
                {
                }
                column(Bankname; Bankname)
                {
                }
                column(InstallmentNo; InstallmentNo)
                {
                }
                column(No; No_Code)
                {
                }
                column(Status; Reduction_Status)
                {
                }
                column(PaidAmount; Reduction_Paid_Amount)
                {
                }
                column(Type_Reduction; "Reduction Types"."Reduction Type")
                {
                }
                column(CompanyName; CompInfo.Name)
                {
                }
                column(Address; CompInfo.Address)
                {
                }
                column(PostCode; CompInfo."Post Code")
                {
                }
                column(City; CompInfo.City)
                {
                }
                column(Picture; CompInfo.Picture)
                {
                }
                column(Type; Type)
                {
                }
                column(User; USERID)
                {
                }
                column(RDate; RDate)
                {
                }
                column(Name; Name)
                {
                }
                column(Description; "Reduction Types".Description)
                {
                }
                //column(Party; DataItem5."Refer To Number")
                column(Party; Reduction_Party_No) //ED
                {
                }
                column(AccountNo; AccountNo)
                {
                }
                column(FaxNo; FaxNo)
                {
                }

                trigger OnPreDataItem()
                begin
                    SETFILTER(Type, '%1', "Reduction Types".Code);
                    RBr := 0;
                    IF WH.GET("Wage Header No.")
                      THEN BEGIN
                        YearId := WH."Year Of Wage";
                        MonthID := WH."Month Of Wage";
                    END;

                    /* ELSE BEGIN
                       ERROR(Txt001);
                       END;*/


                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    RBr += 1;
                    WR.Reset();
                    WR.SetFilter("Account No", '%1', DataItem1."Bank Account No.");
                    if WR.FindFirst()
                    then
                        Bankname := WR."Bank Code" else
                        Bankname := '';

                    IF emp.GET(DataItem1."Employee No.") THEN
                        Name := emp."First Name" + ' ' + emp."Last Name";

                    if Name = '' then
                        CurrReport.Skip();

                    ReductionRec.Reset();
                    ReductionRec.SetFilter("No.", '%1', DataItem1."Reduction No.");
                    if ReductionRec.FindFirst() then begin
                        Reduction_Party_No := ReductionRec."Party No.";
                        AccountNo := ReductionRec.BankAccountCodeNo;
                    end;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                //ĐK CALCFIELDS("Paid Amount");

                RBr += 0;

                CompInfo.GET;
                RDate := TODAY;
                Name := '';
                CompInfo.CALCFIELDS(Picture);

                //         RBr += 1;

                /*ĐK TEST   IF RBA.GET(DataItem1.BankAccountCode)
                     THEN BEGIN
                       AccountNo := RBA."Account No";
                       FaxNo := RBA."Fax No."
                   END;*/

            end;

            trigger OnPreDataItem()
            begin
                RBr := 0;
                AccountNo := '';
                FaxNo := '';
            end;
        }
    }

    requestpage
    {

        layout
        {
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
    end;

    var
        CompInfo: Record "Company Information";
        RDate: Date;
        Name: Text[250];
        emp: Record "Employee";
        Reduction_Paid_Amount: Decimal;
        RBr: Integer;
        WH: Record "Wage Header";
        Bankname: text[250];
        WR: Record "Wage/Reduction Bank Accounts";

        MonthID: Integer;
        YearId: Integer;
        Txt001: Label 'You must enter Wage Header No.';
        RBA: Record "Wage/Reduction Bank Accounts";
        FaxNo: Text[30];
        AccountNo: Text[30];
        No_Code: code[20];
        InstallmentNo: Decimal;
        Reduction_Status: text[250];
        BankAccountCodeNo: code[20];
        Reduction_Party_No: code[30];
        ReductionRec: Record Reduction;
}

