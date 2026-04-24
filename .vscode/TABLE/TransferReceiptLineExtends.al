tableextension 50099 TransferReceiptLineExtends extends "Transfer Receipt Line"
{

    fields
    {
        field(50027; "Group Calculation Number"; Text[1000])
        {
            Caption = 'Group Calculation Number';
        }
        field(50018; "Correction"; Boolean)
        {
            Caption = 'Correction';
        }
    }
    trigger OnInsert()
    /* var
         Gener: Record "General Ledger Setup";
         NoSeriesMgt: Codeunit NoSeriesExtented;
         controlTrLine: Record "Transfer Receipt Line";
         number: Text;*/
    begin
        /* Gener.Get();
         controlTrLine.SetFilter("Receipt Date", '%1', "Receipt Date");
         controlTrLine.SetFilter("Transfer-to Code", '%1', 'CNG MLP');
         if controlTrLine.FindFirst() then begin
             if controlTrLine."Group Calculation Number" = '' then begin
                 if "Transfer-to Code" = 'CNG MLP' then begin
                     number := NoSeriesMgt.GetNextNo(Gener."Group Retail Calculation Entry Series", TODAY, true);
                     "Group Calculation Number" := number;
                 end;
             end
             else
                 if controlTrLine."Group Calculation Number" <> '' then begin
                     if "Transfer-to Code" = 'CNG MLP' then begin
                         "Group Calculation Number" := controlTrLine."Group Calculation Number";
                     end;
                 end;
         end else begin
             number := NoSeriesMgt.GetNextNo(Gener."Group Retail Calculation Entry Series", TODAY, true);
             "Group Calculation Number" := number;
         end;*/
    end;
}