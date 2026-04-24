pageextension 50093 UserSetup extends "User Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Allow Posting To")
        {
            field("Wage Allowed"; "Wage Allowed")
            {
                Caption = 'Wage Allowed';
            }
            field(HR; HR) { }
            field("Allowed to change Request type"; "Allowed to change Request type") { }
            field("Allowed to CI"; "Allowed to CI") { ApplicationArea = all; }
            field("Modify Old Value"; "Modify Old Value") { }
            field(GEO; GEO) { }
            field(Elaborate; Elaborate) { }
            field("Visible Report"; "Visible Report") { }
            field("Order From Expired Contract"; "Order From Expired Contract") { ApplicationArea = all; }
            field("Main Cashier"; "Main Cashier")
            {
                Caption = 'Main Cashier';
            }
            field("Cashier Report"; "Cashier Report") { }
            field(Commercial; Commercial)
            {
                ApplicationArea = All;
            }
            field("Posting Date Cash"; "Posting Date Cash")
            {
                ApplicationArea = All;
            }
            field("Posting Date Card"; "Posting Date Card")
            {
                ApplicationArea = All;
            }
            field("Visible Request"; "Visible Request") { }

            field("CNG User"; "CNG User") { ApplicationArea = all; }
            /*field(Finance; Finance) //Narudžbenice neće odobravati Finansije, već Računovodstvo
            //Dogovoreno na testiranju
            {
                ApplicationArea = All;
            }*/

            field("CNG Administrator"; "CNG Administrator") { ApplicationArea = all; }
            field(Accounting; Accounting)
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Kupci"; "MM_UGI_K")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Mjerna mjesta"; "MM_UGI_M")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Resursi"; "MM_UGI_R")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Kontakti Dimnjačar"; "MM_UGI_KON_DIM")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Kontakti Ugovoreni izvođač"; "MM_UGI_KON_UGIZV")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Kontakti Projektant"; "MM_UGI_KON_P")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Gasni aparatI"; "MM_UGI_GASNI_APARATI")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Osnovna sredstva"; "MM_UGI_OS")
            {
                ApplicationArea = All;
            }
            field("MM i UGI - Aktivnosti"; "MM_UGI_AKT")
            {
                ApplicationArea = All;
            }
            field("Osnovna sredstva GP i DGM"; "Osnovna_sredstva")
            {
                ApplicationArea = All;
            }
            field("Lista institucija za PPZ i ZNR"; "Lista_institucija_za_PPZ_i_ZNR")
            {
                ApplicationArea = All;
            }
            field(FA; FA) { ApplicationArea = All; }
            field(Intervencije; Intervencije)
            {
                ApplicationArea = All;
            }
            field(DIS_REAS; DIS_REAS) { ApplicationArea = All; }
            field("Resource Update"; "Resource Update") { }

            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Current Journal Batch Name';
            }

        }
        modify("User ID")
        {
            LookupPageId = "User Card";
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        addbefore(Email)
        {
            field("Employee No. for Wage"; "Employee No. for Wage")
            {
                ApplicationArea = all;
            }
            field("Cashier Table"; "Cashier Table") { ApplicationArea = all; }
        }

        addlast(Control1)
        {
            field("CZK User"; Rec."CZK User")
            {
                ApplicationArea = All;
            }
            field(CZK; CZK) { ApplicationArea = All; }
            field("Control Verification"; "Control Verification") { }
            field("Verif R"; "Verif R") { }
            field("Control R"; "Control R") { }
            field("Allowed to update IH"; "Allowed to update IH") { }
            field("Default reason"; "Default reason") { }
            field(Today; Today) { }
            field("Allowed Purchase Order (I)"; "Allowed Purchase Order (I)") { }
            field("Allowed update F"; "Allowed update F") { ApplicationArea = all; }

        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}