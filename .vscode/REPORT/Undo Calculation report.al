report 50169 "Undo Calculation"
{
    DefaultLayout = RDLC;
    Caption = 'Undo Calculation';
    ProcessingOnly = false;
    ShowPrintStatus = false;
    UseRequestPage = true;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Calculation Journal Line"; "Calculation Journal Line")
        {
            RequestFilterFields = "Document No. Posting";
            trigger OnAfterGetRecord()

            var
                CJLF: Record "Calculation Journal Line";
            begin

                CJLF.Reset();
                CJLF.SetFilter(Code, '%1', CJLInsertCode);
                CJLF.setfilter("Measuring Point Code", '%1', "Calculation Journal Line"."Measuring Point Code");
                CJLF.setfilter("Customer No.", '%1', "Calculation Journal Line"."Customer No.");
                CJLF.Setfilter(Gauge, '%1', "Calculation Journal Line".Gauge);
                CJLF.SetFilter(Autoint, '%1', "Calculation Journal Line".Autoint);
                if not CJLF.FindFirst() then begin
                    CJLInit.Init();
                    CJLInit.TransferFields("Calculation Journal Line");
                    CJLInit.Code := CJLInsertCode;
                    "Calculation Journal Line"."Undo Calculation" := true;
                    //ovdje sam označila storniraj.
                    "Calculation Journal Line".Modify();
                    CJLInit.Insert();
                end;
            end;


        }


    }



    procedure SetParam2(CJLCode: code[20])
    begin
        CJLInsertCode := CJLCode;
    end;


    var
        CJLInsertCode: code[20];
        CJLInit: Record "Calculation Journal Line";


}

