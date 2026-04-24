/*report 50028 "Lock Calculation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Lock Calculation.rdl';

    dataset
    {
        dataitem(DataItem1; "Wage Header")
        {

            trigger OnPreDataItem()
            begin
                //is the calc already locked?
                WageHeader.RESET;

                WageHeader.RESET;
                WageHeader.COPYFILTERS(DataItem1);
                WageHeader.SETRANGE(Status, WageHeader.Status::Open);

                IF WageHeader.COUNT > 1 THEN ERROR(Err01);

                IF NOT WageHeader.FIND('-') THEN
                    ERROR(Txt001);

                WA.SETRANGE("Year of Wage", WageHeader."Year Of Wage");
                WA.SETRANGE("Month of Wage", WageHeader."Month Of Wage");

                WageHeader."Last Calculation In Month" := TRUE;
                WageHeader."Payment Date" := PaymentDate;
                WageHeader.Status := WageHeader.Status::Closed;
                WageHeader.MODIFY;

                IF WageHeader."Wage Calculation Type" = WageHeader."Wage Calculation Type"::Normal THEN BEGIN
                    E.RESET;
                    E.SETRANGE("For Calculation", TRUE);

                    //WA.SETFILTER("Wage Addition Type",'<>%1',WA."Wage Addition Type"::"3");
                END;

                //ELSE
                // WA.SETFILTER("Wage Addition Type",'%1',WA."Wage Addition Type"::"3");


                WA.MODIFYALL(Locked, TRUE);
                MESSAGE(Txt003);
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
    begin

        //INT1.0 start
        UTemp.SETFILTER("User ID", '%1', USERID);
        IF UTemp.FINDFIRST THEN
            WageAllowed := UTemp."Wage Allowed";

        IF WageAllowed = FALSE THEN
            ERROR(error1);
        //INT1.0 end
    end;

    var
        WageHeader: Record "Wage Header";
        Response: Boolean;
        PaymentDate: Date;
        E: Record Employee;
        WA: Record "Wage Addition";
        Txt001: Label 'This Calculation does not exists or its status is not "Closed"';
        Txt003: Label 'Calculation was succesfully locked.';
        Err01: Label 'You have to choose only one calculation!';
        UTemp: Record "User Setup";
        WageAllowed: Boolean;
        error1: Label 'You do not have permission to access this report. Please contact your system administrator.';
}

*/