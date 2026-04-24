/*page 50217 Certifications
{
    Caption = 'Certification R';
    PageType = List;
    SourceTable = "Certication and solu";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field("Document Description"; "Document Description")
                {
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    ApplicationArea = all;
                }
                field("Agreement Code"; "Agreement Code")
                {
                    ApplicationArea = all;
                }
                field("NAV Agreement Code"; "NAV Agreement Code")
                {
                    ApplicationArea = all;
                }
                field("Show Template"; "Show Template")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin

        UserPersonalisation.RESET;
        UserPersonalisation.SETFILTER("User ID", USERID);
        IF UserPersonalisation.FINDFIRST THEN BEGIN
            IF UserPersonalisation."Profile ID" = 'HR OPERATER - TEST' THEN
                IsVisible := FALSE
            ELSE
                IsVisible := TRUE;
        END;
    end;

    var
        ParentRelationVisible: Boolean;
        AgeT: Decimal;
        UserPersonalisation: Record "User Personalization";
        IsVisible: Boolean;
        CRL2: Record "Custom Report Layout";
        ReportLayoutSelection: Record "Report Layout Selection";
        //ĐK  Certificatematernity: Report "99001047";
        ECLCopy: Record "Employee Contract Ledger";
        ECLCopy2: Record "Employee Contract Ledger";
}

*/