/*report 50019 Additions
{
    ProcessingOnly = true;
    ShowPrintStatus = false;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem1; "Wage Calculation")
        {

            trigger OnAfterGetRecord()
            begin

                SETFILTER("Wage Header No.", '%1', WHNo);
                SETFILTER("Wage Calculation Type", '%1', 4);
                IF FIND('-') THEN
                    REPEAT
                        Paid := TRUE;
                        MODIFY;
                    UNTIL NEXT = 0;
            end;
        }
        dataitem(DataItem2; "Tax Per Employee")
        {

            trigger OnAfterGetRecord()
            begin
                SETFILTER("Wage Header No.", '%1', WHNo);
                SETFILTER("Wage Calculation Type", '%1', 4);
                IF FIND('-') THEN
                    REPEAT
                        Amount := -Amount;
                        MODIFY;
                    UNTIL NEXT = 0;

            end;
        }
        dataitem(DataItem3; "Contribution Per Employee")
        {

            trigger OnAfterGetRecord()
            begin
                SETFILTER("Wage Header No.", '%1', WHNo);
                SETFILTER("Wage Calculation Type", '%1', 4);
                IF FIND('-') THEN
                    REPEAT
                        "Amount From Wage" := -"Amount From Wage";
                        "Amount Over Wage" := -"Amount Over Wage";
                        "Amount Over Neto" := -"Amount Over Neto";
                        MODIFY;
                    UNTIL NEXT = 0;
            end;
        }
        dataitem(DataItem4; "Wage Value Entry")
        {

            trigger OnAfterGetRecord()
            begin
                SETFILTER("Document No.", '%1', WHNo);
                SETFILTER("Wage Calculation Type", '%1', 4);
                IF FIND('-') THEN
                    REPEAT

                        "Cost Posted to G/L" := -"Cost Posted to G/L";
                        "Cost Amount (Actual)" := -"Cost Amount (Actual)";
                        Round := 2;
                        MODIFY;
                    UNTIL NEXT = 0;
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
        WHNo: Code[10];

    procedure SetWHNo(WageHNo: Code[10])
    begin

        WHNo := WageHNo;
        //HR01
    end;
}

*/