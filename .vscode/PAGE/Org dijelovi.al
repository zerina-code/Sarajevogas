page 50186 "ORG Dijelovi"
{
    Caption = 'ORG Part';
    PageType = List;
    SourceTable = "ORG Dijelovi";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("S")
            {
                field(Code; Code)
                {
                    ApplicationArea = all;
                    Caption = 'Org part';
                }
                field(GF; GF)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Order; Order)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Municipality Code"; "Municipality Code")
                {
                    ApplicationArea = all;
                }
                field("Municipality Code of agency"; "Municipality Code of agency")
                {
                    ApplicationArea = all;
                }
                field("Municipality Code for salary"; "Municipality Code for salary")
                {
                    ApplicationArea = all;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = all;
                }
                field("Refer To Number"; "Refer To Number")
                {
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    ApplicationArea = all;
                }
                field("Version Code"; "Version Code")
                {
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    ApplicationArea = all;
                }
                field(Canton; Canton)
                {
                    ApplicationArea = all;
                }
                field(Telephone; Telephone)
                {
                    ApplicationArea = all;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    ApplicationArea = all;
                }
                field(Region; Region)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Registration No."; "Registration No.")
                {
                    ApplicationArea = all;
                }



                field("ORG ID"; "ORG ID")
                {
                    ApplicationArea = all;
                }

                field("JIB Contributes"; "JIB Contributes")
                {
                    ApplicationArea = all;
                }
                field("Industrial Classification"; "Industrial Classification")
                {
                    ApplicationArea = all;
                }
                field("Industrial Classification Name"; "Industrial Classification Name")
                {
                    ApplicationArea = all;

                }
                field(Active; Active)
                {
                    ApplicationArea = all;
                }
                field("Branch Agency"; "Branch Agency")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Regionalni Head Office"; "Regionalni Head Office")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entity Code"; "Entity Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Routing Sheet")
            {
                Caption = 'Routing Sheet';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report 99000787;
            }
        }
    }

    trigger OnOpenPage()
    begin
        SETFILTER(Active, '%1', TRUE);
        /*IF COMPANYNAME='RAIFFAISEN BANK' THEN BEGIN
        REPORT.RUNMODAL(186,FALSE,FALSE);
        REPORT.RUNMODAL(411,FALSE,FALSE);
        END;*/

    end;
}

