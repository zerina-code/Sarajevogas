/*report 50090 "GLAcc update"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(DataItem1; "G/L Account")
        {


            trigger OnAfterGetRecord()
            begin

                SETFILTER("No.", '<>%1', '');

                IF FIND('-') THEN
                    REPEAT
                        IF (COPYSTR("No.", 1, 1) = '5') or (COPYSTR("No.", 1, 1) = '6') THEN
                            "Income/Balance" := "Income/Balance"::"Income Statement"
                        else
                            "Income/Balance" := "Income/Balance"::"Balance Sheet";

                        MODIFY;
                    UNTIL NEXT = 0;
            end;

        }
    }


    var
        myInt: Integer;
}*/