page 50004 Payrollgreeting
{
    PageType = HeadLinePart;

    layout
    {
        area(content)
        {
            field(Headline1; hdl1Txt)
            {
                Visible = TRUE;
                editable = FALSE;
                ApplicationArea = all;

            }
            field(Headline2; hdl2Txt)
            {
                Visible = TRUE;
                editable = FALSE;
                ApplicationArea = all;

            }
            field(Headline3; RoleTxt)
            {
                Visible = TRUE;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                begin
                    RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Business Manager");
                    DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
                    UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
                    UserPersonalisation.RESET;
                    UserPersonalisation.SETFILTER("User ID", USERID);
                    IF UserPersonalisation.FINDFIRST THEN BEGIN
                        IF ((UserPersonalisation."Profile ID" <> 'PAYROLL')) THEN begin
                            if UserPersonalisation."Profile ID" = 'SALES AGENT - Natural GAS' then
                                RoleTxt := hdl4Txt_1;

                            if UserPersonalisation."Profile ID" = 'CASHIER' then
                                RoleTxt := hdl5Txt_1;

                            if UserPersonalisation."Profile ID" = 'CNG' then
                                RoleTxt := hdl5Txt_2;

                            RoleTxt := hdl5Txt
                        end
                        else begin

                            RoleTxt := hdl4Txt;
                        end;
                    END;
                end;
            }

            field(Headline4; hdl3Txt)
            {
                Visible = TRUE;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    DrillDownURLTxt: Label 'https://servicedesk.infodom.hr/', Locked = True;
                begin
                    Hyperlink(DrillDownURLTxt)
                end;
            }
        }
    }

    var
        hdl1Txt: Label '<qualifier>Naslov</qualifier><payload>Zdravo!</payload>';
        hdl2Txt: Label '<qualifier>Naslov</qualifier><payload>Dobrodošli u centar uloga</payload>';
        hdl3Txt: Label '<qualifier>Naslov</qualifier><payload>Za pomoć pri korištenju obratite nam se putem c2s2 portala.</payload>';
        hdl4Txt: Label 'za obračun plata.';
        hdl4Txt_1: Label 'za obračun prirodnog gasa.';
        hdl5Txt: Label 'za upravljanje ljudskim resursima.';
        hdl5Txt_1: Label 'za blagajnu';
        hdl5Txt_2: Label 'za CNG';
        UserPersonalisation: Record "User Personalization";
        RoleTxt: Text[500];

    trigger OnOpenPage()
    begin
        RCHeadlinesPageCommon.HeadlineOnOpenPage(Page::"Headline RC Business Manager");
        DefaultFieldsVisible := RCHeadlinesPageCommon.AreDefaultFieldsVisible();
        UserGreetingVisible := RCHeadlinesPageCommon.IsUserGreetingVisible();
        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF ((UserPersonalisation."Profile ID" <> 'PAYROLL')) THEN begin
                RoleTxt := hdl5Txt;
                if UserPersonalisation."Profile ID" = 'SALES AGENT - Natural GAS' then
                    RoleTxt := hdl4Txt_1;
                if UserPersonalisation."Profile ID" = 'CNG' then
                    RoleTxt := hdl5Txt_2;
            end
            ELSE begin
                RoleTxt := hdl4Txt;
            end;
        END;

    end;

    trigger OnAfterGetRecord()
    begin

        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF ((UserPersonalisation."Profile ID" <> 'PAYROLL')) THEN begin
                RoleTxt := hdl5Txt;
                if UserPersonalisation."Profile ID" = 'SALES AGENT - Natural GAS' then
                    RoleTxt := hdl4Txt_1;
                if UserPersonalisation."Profile ID" = 'CNG' then
                    RoleTxt := hdl5Txt_2;
            end
            ELSE begin
                RoleTxt := hdl4Txt;
            end;
        END;
    end;

    var
        [InDataSet]
        DefaultFieldsVisible: Boolean;
        [InDataSet]
        UserGreetingVisible: Boolean;
        RCHeadlinesPageCommon: Codeunit "RC Headlines Page Common";
}