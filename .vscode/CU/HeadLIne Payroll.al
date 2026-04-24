codeunit 50016 "Headline Payroll"
{

    trigger OnRun()
    var
        HeadlineRCAccountant: Record "Headline Payroll";
    begin
        HeadlineRCAccountant.GET;
        WORKDATE := HeadlineRCAccountant."Workdate for computations";
        OnComputeHeadlines;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnComputeHeadlines()
    begin
    end;
}

