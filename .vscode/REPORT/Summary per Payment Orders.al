report 50055 "Summary per Payment Orders"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Summary per Payment Orders.rdl';
    Caption = 'Sumarry per Payment Orders';

    dataset
    {
        dataitem(DataItem1; "Payment Order")
        {
            DataItemTableView = WHERE(Contributon = FILTER(<> ''),
                                      Iznos = FILTER(<> 0));
            RequestFilterFields = "Wage Header No.";
            column(Type; DataItem1.Type)
            {
            }
            column("Code"; DataItem1.Code)
            {
            }
            column(Contribution; DataItem1.Contributon)
            {
            }
            column(Amount; DataItem1.Iznos)
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
            column(WageCalculationType_PaymentOrder; DataItem1."Wage Calculation Type")
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
            column(PaymentType; PaymentType)
            {
            }
            column(PaymentAmount; PaymentAmount)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                RDate := TODAY;
                Name := '';

                IF Type = 0 THEN BEGIN
                    IF t_Entity.GET(Code) THEN
                        Name := t_Entity.Description;
                END;
                IF Type = 1 THEN BEGIN
                    Canton.SETFILTER(Code, Code);
                    IF Canton.GET(Code) THEN
                        Name := Canton.Description;
                END;
                IF Type = 2 THEN BEGIN
                    IF Mun.GET(Code) THEN
                        Name := Mun.Name;
                END;
                CompInfo.CALCFIELDS(Picture);


                IF PaymentSummarry.READ THEN BEGIN

                    PaymentType := FORMAT(PaymentSummarry.Wage_Payment_Type);
                    PaymentAmount := PaymentSummarry.Sum_Iznos;


                END
                ELSE BEGIN

                    CLEAR(PaymentType);
                    CLEAR(PaymentAmount);
                END;
            end;

            trigger OnPostDataItem()
            begin
                PaymentSummarry.CLOSE;
            end;

            trigger OnPreDataItem()
            begin
                WCTypeFilter := GETFILTER("Wage Calculation Type");
                IF
                  WCTypeFilter = 'Redovni' THEN
                    WCTypeFilterOption := 0;
                IF
                  WCTypeFilter = 'Ugovor o djelu-rezidenti' THEN
                    WCTypeFilterOption := 1;
                IF
                  WCTypeFilter = 'Ugovor o djelu-nerezidenti' THEN
                    WCTypeFilterOption := 2;
                IF
                  WCTypeFilter = 'Autorski ugovor' THEN
                    WCTypeFilterOption := 3;
                IF
                  WCTypeFilter = 'Dodaci' THEN
                    WCTypeFilterOption := 4;
                PaymentSummarry.SETFILTER(Wage_Calculation_Type, '%1', WCTypeFilterOption);
                //PaymentSummarry.SETFILTER(DatumUplate,'%1',DatumUplate);
                WHeaderFilter := GETFILTER("Wage Header No.");
                PDateFilter := GETFILTER(DatumUplate);
                // PaymentSummarry.SETFILTER(Wage_Header_No,'%1','000000001');
                PaymentSummarry.SETFILTER(Wage_Header_No, '%1', WHeaderFilter);
                EVALUATE(PDateFilterDate, PDateFilter);
                IF PDateFilterDate <> 0D THEN
                    PaymentSummarry.SETFILTER(DatumUplate, '%1', PDateFilterDate);

                PaymentSummarry.OPEN;
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
        Mun: Record "Municipality";
        Canton: Record "Canton";
        Name: Text[150];
        t_Entity: Record "Entity";
        PaymentType: Text[100];
        PaymentAmount: Decimal;
        PaymentSummarry: Query "Payment Orders Summarry";
        WHeaderFilter: Text[30];
        PDateFilter: Text[30];
        PDateFilterDate: Date;
        WCTypeFilter: Text[100];
        WCTypeFilterOption: Option;
}

