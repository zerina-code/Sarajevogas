/*page 50134 "Vacation setup"
{
    Caption = 'Absence setup';
    PageType = Card;
    SourceTable = "Vacation Setup";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(Vacation)
            {
                Caption = 'Vacation';
                field("Primary Key"; "Primary Key")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vacation Code"; "Vacation Code")
                {
                    ApplicationArea = all;
                }
                field("Vacation Code Last Year"; "Vacation Code Last Year")
                {
                    ApplicationArea = all;
                }
                field("Min. of Previous Exp. (Years)"; "Min. of Previous Exp. (Years)")
                {

                    ApplicationArea = all;
                    Visible = false;
                }
                field("Days for previous exp."; "Days for previous exp.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Min. of Curr. Exp. (Years)"; "Min. of Curr. Exp. (Years)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Days for current exp."; "Days for current exp.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Base Days"; "Base Days")
                {
                    ApplicationArea = all;
                }
                field("Base Days RS"; "Base Days RS")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Base Days BD"; "Base Days BD")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Vacation Validation Date"; "Vacation Validation Date")
                {
                    ApplicationArea = all;
                }
                field("Vacation Descision Date"; "Vacation Descision Date")
                {
                    ApplicationArea = all;
                }
            }
            group(Candelmas)
            {
                Caption = 'Candelmas';
                field("Paid Candelmas Code"; "Paid Candelmas Code")
                {
                    ApplicationArea = all;
                }
                field("Paid Candelmas Quantity"; "Paid Candelmas Quantity")
                {
                    ApplicationArea = all;
                }
                field("Unpaid Candelmas Code"; "Unpaid Candelmas Code")
                {
                    ApplicationArea = all;
                }
                field("Unpaid Candelmas Quantity"; "Unpaid Candelmas Quantity")
                {
                    ApplicationArea = all;
                }

            }
            group("Paid Absence")
            {
                Caption = 'Paid Absence';
                field("Paid Absence Code"; "Paid Absence Code")
                {
                    ApplicationArea = all;
                }
                field("Paid Absence Quantity"; "Paid Absence Quantity")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

*/