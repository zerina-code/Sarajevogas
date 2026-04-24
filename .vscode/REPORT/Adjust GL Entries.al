report 50220 "Adjust GL Entries"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(GL_Entry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.") where("G/L Account No." = filter(1040 | 10940 | 1041 | 51400));
            RequestFilterFields = "Document No.";
            trigger OnAfterGetRecord()
            begin
                //  SETFILTER("Document No.", '%1', 'OP25-00017');
                SETFILTER("Adjusted", '%1', false);
                if(Amount <> 0) and (Amount > -10) and (Amount < 10) then begin
                    GL_Entry."Debit Amount" := 0;
                    GL_Entry."Credit Amount" := 0;

                    if(Amount > 0) then
                        GL_Entry."Debit Amount" := -Amount
                    else
                    GL_Entry."Credit Amount" := Amount;
                    GL_Entry.Amount := -Amount;
                    GL_Entry.Adjusted := true;
                    RecRef.GetTable(GL_entry);
                    RecordRefExample.ModifyRecords(RecRef);

                end;
            end;
        }
    }
    var
        RecRef: RecordRef;
        RecordRefExample: Codeunit "Modiy Permissions";

}