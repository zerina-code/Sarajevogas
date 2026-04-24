report 50207 "Send mail from RN"
{
    // BH1.00, PLAN POTROSNJE
    DefaultLayout = RDLC;
    RDLCLayout = './SpendingPlan.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;



    dataset
    {



        dataitem(DataItem2; "Service Header")
        {



            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                WageS: Record "Wage Setup";



            begin

                if Confirm('Da li ste sigurni da želite poslati mail kupcu?') then begin


                    CLEAR(FileManagement);
                    CLEAR(Mail);

                    Customer.get(DataItem2."Customer No.");
                    Clear(Recipients);
                    CLEAR(FileManagement);

                    SMTPSetup.GET;
                    TempMessage.Reset();
                    TempMessage.SetFilter("Message Code", '%1', MessageTemp);
                    if TempMessage.FindFirst() then begin
                        TempMessage.CALCFIELDS("Message Text");
                        TempMessage."Message Text".CREATEINSTREAM(IStream);
                        TextMsg.READ(IStream);

                    end;

                    ResultReplace := format(TextMsg);
                    ResultReplace := Replacestring_TName(ResultReplace, '@BrojDokumenta', DataItem2."No.");


                    Recipients.Add(Customer."E-Mail 2");
                    SMTPMail.CreateMessage(TempMessage."Message Subject", TempMessage."E-mail sender", 'djemina.karalic@teneo.ba', '', format(ResultReplace), TRUE);
                    SMTPMail.Send();
                    DataItem2."Sent Mail" := true;
                    DataItem2.Modify();

                end;
            end;

            trigger OnPreDataItem()
            begin


            end;


        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                field(MessageTemp; MessageTemp)
                {
                    Caption = 'Message Template';
                    TableRelation = Template_Message."Message Code";
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        CompInfo.GET;
        CompInfo.CalcFields(Picture);

    end;

    trigger OnInitReport()
    var
        myInt: Integer;
    begin

    end;

    trigger OnPostReport()
    var
        myInt: Integer;
        WageS: Record "Wage Setup";
    begin



    end;



    procedure Setparam(CustomerNo: code[20]; MM: code[20])
    var
        CustomReportLayout: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
    begin
        SifraInitCust := CustomerNo;
        MMInit := MM;


    end;


    procedure Replacestring_TName(String: Text; FindWhat: Text; ReplaceWith: Text) NewString: Text
    begin
        WHILE STRPOS(String, FindWhat) > 0 DO
            String := DELSTR(String, STRPOS(String, FindWhat)) + ReplaceWith + COPYSTR(String, STRPOS(String, FindWhat) + STRLEN(FindWhat));
        NewString := String;
    end;


    var
        CompInfo: Record "Company Information";

        Customer: Record Customer;
        TempMessage: Record Template_Message;
        filename: Text;
        IStream: InStream;
        SifraInitCust: code[20];
        MMInit: code[20];
        MM: Record "Service Item";
        ResultReplace: text;
        TextMsg: BigText;
        mmcODE1: Record "Service Item";
        Gauge: Record Gauge;
        plan1: Decimal;
        GeneratePlan: boolean;
        plan1Spent: Decimal;
        AreaRec: record "Area";
        Recipients: List of [Text];
        IH: record "Installation History";
        SpendingPlan: Report "SpendingPlan";
        FileManagement: Codeunit "File Management";
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        Mail: Codeunit Mail;
        AreaRec2: record "Area";

        Plan_Month: array[12] of Integer;
        Realized_Month: array[12] of Integer;
        Plan2_Month: array[12] of Integer;
        plan2: Decimal;
        AreaR: Record "Area";
        SendEmail: Boolean;
        mmCode: Text;
        mmName: Text;
        mmAddress: Text;
        CJL: record "Calculation Journal Line";
        mmZoneStroke: Text;
        MessageTemp: code[20];
        mmSerialNumber: Text;
        mmCustomerStroke: Text;
        gaugeSize: Text;

        respPerson: Text;
        respPosition: Text;
        Year_int: Integer;

        MonthValue: enum Month;
        mm1Spent: Record "Sales Invoice Header";
        sline: Record "Sales Invoice Line";


}

