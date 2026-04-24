/*page 50034 "Headline Payroll"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;
    SourceTable = "Headline Payroll";
    UsageCategory = Administration;
    ApplicationArea = all;
    layout
    {
        area(content)
        {

            // Visible = true;
            field(GreetingText; GreetingText)
            {
                //ApplicationArea = Basic, Suite;
                Caption = 'Greeting headline';
                DrillDown = true;
                Editable = false;
                Visible = true;

            }

            field(DocumentationText; DocumentationText)
            {
                // ApplicationArea = Basic,Suite;
                Caption = 'Documentation headline';
                DrillDown = true;
                Editable = false;
                Visible = true;

                trigger OnDrillDown()
                begin
                    HYPERLINK(DocumentationUrlTxt);
                end;
            }

        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        ComputeDefaultFieldsVisibility;

    end;

    trigger OnOpenPage()
    var
        Uninitialized: Boolean;
    begin
        IF NOT GET THEN
            IF WRITEPERMISSION THEN BEGIN
                INIT;
                INSERT;
            END ELSE
                Uninitialized := TRUE;

        IF NOT Uninitialized AND WRITEPERMISSION THEN BEGIN
            "Workdate for computations" := WORKDATE;
            MODIFY;
            //ĐK   HeadlineManagement.ScheduleTask(CODEUNIT::"Headline Payroll");
        END;

        //ĐK  HeadlineManagement.GetUserGreetingText(GreetingText);
        GreetingText := 'Obračun plate!';
        DocumentationText := STRSUBSTNO(DocumentationTxt, PRODUCTNAME.SHORT);

        IF Uninitialized THEN
            // table is uninitialized because of permission issues. OnAfterGetRecord won't be called
            ComputeDefaultFieldsVisibility;

        COMMIT; // not to mess up the other page parts that may do IF CODEUNIT.RUN()
    end;

    var
        //ĐK HeadlineManagement: Codeunit "Headline Management";
        DefaultFieldsVisible: Boolean;
        DocumentationTxt: Label 'Want to learn more about %1?', Comment = '%1 is the NAV short product name.';
        DocumentationUrlTxt: Label 'https://go.microsoft.com/fwlink/?linkid=867580', Locked = true;
        GreetingText: Text[250];
        hdl1Txt: Label '<qualifier>NASLOV</qualifier><payload>This is the <emphasize>Obračun plate</emphasize>.</payload>';
        DocumentationText: Text[250];
        UserGreetingVisible: Boolean;

    local procedure ComputeDefaultFieldsVisibility()
    var
        ExtensionHeadlinesVisible: Boolean;
    begin
        OnIsAnyExtensionHeadlineVisible(ExtensionHeadlinesVisible);
        DefaultFieldsVisible := NOT ExtensionHeadlinesVisible;
        //ĐK   UserGreetingVisible := HeadlineManagement.ShouldUserGreetingBeVisible;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnIsAnyExtensionHeadlineVisible(var ExtensionHeadlinesVisible: Boolean)
    begin
    end;
}

*/