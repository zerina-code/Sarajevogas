report 50058 "Payment List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Payment List.rdl';
    Caption = 'Payment List';

    dataset
    {
        dataitem(DataItem1; "Reduction per Wage")
        {
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
            column(Rbr; Rbr)
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
            column(User; USERID)
            {
            }
            column(RDate; RDate)
            {
            }
            dataitem(DataItem5; "Reduction")
            {
                DataItemLink = "No." = FIELD("Reduction No.");
                column(Bank; DataItem5."Bank Name")
                {
                }
                column(InstallmentNo; DataItem5."No. of Installments paid")
                {
                }
                column(No; DataItem5.Type)
                {
                }
                column(Status; DataItem5.Status)
                {
                }
                column(PaidAmount; DataItem5."Paid Amount")
                {
                }
                column(Name; Name)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                Rbr += 1;
                CompInfo.GET;
                RDate := TODAY;
                Name := '';
                CompInfo.CALCFIELDS(Picture);
                IF emp.GET(DataItem1."Employee No.") THEN
                    Name := emp."First Name" + ' ' + emp."Last Name";
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

    var
        Rbr: Integer;
        CompInfo: Record "Company Information";
        RDate: Date;
        emp: Record "Employee";
        Name: Text[250];
}

