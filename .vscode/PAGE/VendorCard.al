pageextension 50099 VendorCard extends "Vendor Card"
{
    //ED

    layout
    {
        addbefore(Name)
        {
            field("Old ID"; "Old ID")
            {
                ApplicationArea = all;
            }
        }

        addafter("Balance (LCY)")
        {
            field("Prepayment (LCY)"; "Prepayment (LCY)")
            {

            }
        }

        addafter(Name)
        {

            field("Vendor Subgroup"; "Vendor Subgroup")
            {
                ApplicationArea = all;
            }
            field("Vendor Subgroup Description"; "Vendor Subgroup Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor Group"; "Vendor Group")
            {
                ApplicationArea = all;
            }
            field("Vendor Group Description"; "Vendor Group Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Vendor Category"; "Vendor Category")
            {
                ApplicationArea = all;
            }
            field("Vendor Category Description"; "Vendor Category Description")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field(Grade; Grade)
            {
                ApplicationArea = all;
            }
            /*field("Old No."; "Old No.")
            {
                ApplicationArea = all;
            }*/
            field("Industrial Classification 2"; "Industrial Classification 2")
            {
                ApplicationArea = all;
            }
        }

        addafter("VAT Registration No.")
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = all;
            }
            field("Tax No."; "Tax No.")
            {
                ApplicationArea = all;
            }
        }
        modify("No.")
        {
            Visible = true;
        }

        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify("Last Date Modified")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Our Account No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify(Priority)
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Customized Calendar")
        {
            Visible = false;
        }
        modify("Over-Receipt Code")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Payment Terms Code")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }


    }

    actions //ED
    {
        modify("Vendor - Summary Aging") { Visible = false; }
        addafter(Attachments)
        {
            action("Obrada - knjižne grupe")
            {
                ApplicationArea = all;
                Caption = 'Obrada - knjižne grupe';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    VendorTable: Record Vendor;
                begin
                    VendorTable.Reset();
                    if VendorTable.FindFirst() then
                        repeat
                            if VendorTable."VAT Registration No." <> '' then begin
                                VendorTable."VAT Bus. Posting Group" := 'D-17-PDV';
                                VendorTable.Modify();
                            end else begin
                                VendorTable."VAT Bus. Posting Group" := 'D-0-PDV';
                                VendorTable.Modify();
                            end;

                            //INO DOBAVLJAVLJAČI SU: PRO202020008, PRO302030004, PRO214020005, PRO306010006, PRO202010004, PRO202010005, PRO202020012, PRO203010008, PRO214020023
                            //PRO307010024, PRO202010008, PRO202010009, PRO311010009, PRO202010010, PRO202030002, PRO302020006, PRO214020036, PRO311010014, PRO202010014
                            //PRO302010031, PRO311010015, PRO307010047, PRO305030007, PRO305030009, PRO302030023, PRO311020003, PRO202020030, PRO311010019, PRO214020064

                            //PRO311010025, PRO202010016, PRO202010017, PRO302030024, PRO302030027, PRO302030032, PRO302030033, PRO305030014, PRO202010018, PRO202010019

                            //PRO202010020, PRO312010010, PRO302020007, PRO305030015, PRO316050032, PRO312010015, PRO305010008, PRO102010007, PRO312000023, PRO307010081

                            //PRO206010035, PRO207010023, PRO202030021, PRO201010102, PRO316040010, PRO202010026, PRO312010020, PRO316060021, PRO312010021, PRO312010022
                            //PRO311010047, PRO312010023, PRO312010028, PRO312010029, PRO312010031, PRO312010032, PRO312010033, PRO305030018, PRO206010043, PRO206010044
                            //PRO305030019

                            if (VendorTable."No." = 'PRO202020008') OR (VendorTable."No." = 'PRO302030004') OR (VendorTable."No." = 'PRO214020005') OR (VendorTable."No." = 'PRO306010006') OR
                            (VendorTable."No." = 'PRO202010004') OR (VendorTable."No." = 'PRO202010005') OR (VendorTable."No." = 'PRO202020012') OR (VendorTable."No." = 'PRO203010008') OR

                            (VendorTable."No." = 'PRO214020023') OR (VendorTable."No." = 'PRO307010024') OR (VendorTable."No." = 'PRO202010008') OR (VendorTable."No." = 'PRO202010009') OR
                            (VendorTable."No." = 'PRO311010009') OR (VendorTable."No." = 'PRO202010010') OR (VendorTable."No." = 'PRO202030002') OR (VendorTable."No." = 'PRO302020006') OR

                            (VendorTable."No." = 'PRO214020036') OR (VendorTable."No." = 'PRO311010014') OR (VendorTable."No." = 'PRO202010014') OR (VendorTable."No." = 'PRO311010025') OR
                            (VendorTable."No." = 'PRO202010016') OR (VendorTable."No." = 'PRO202010017') OR (VendorTable."No." = 'PRO302030024') OR (VendorTable."No." = 'PRO302030027') OR

                            (VendorTable."No." = 'PRO302030032') OR (VendorTable."No." = 'PRO302030033') OR (VendorTable."No." = 'PRO305030014') OR (VendorTable."No." = 'PRO202010018') OR
                            (VendorTable."No." = 'PRO202010019') OR (VendorTable."No." = 'PRO202010020') OR (VendorTable."No." = 'PRO312010010') OR (VendorTable."No." = 'PRO302020007') OR

                            (VendorTable."No." = 'PRO305030015') OR (VendorTable."No." = 'PRO305010008') OR (VendorTable."No." = 'PRO102010007') OR (VendorTable."No." = 'PRO312000023') OR
                            (VendorTable."No." = 'PRO307010081') OR (VendorTable."No." = 'PRO206010035') OR (VendorTable."No." = 'PRO207010023') OR (VendorTable."No." = 'PRO202030021') OR

                            (VendorTable."No." = 'PRO201010102') OR (VendorTable."No." = 'PRO316040010') OR (VendorTable."No." = 'PRO202010026') OR (VendorTable."No." = 'PRO312010020') OR
                            (VendorTable."No." = 'PRO316060021') OR (VendorTable."No." = 'PRO312010021') OR (VendorTable."No." = 'PRO312010022') OR (VendorTable."No." = 'PRO311010047') OR

                            (VendorTable."No." = 'PRO312010023') OR (VendorTable."No." = 'PRO312010028') OR (VendorTable."No." = 'PRO312010029') OR (VendorTable."No." = 'PRO312010031') OR
                            (VendorTable."No." = 'PRO312010032') OR (VendorTable."No." = 'PRO312010033') OR (VendorTable."No." = 'PRO305030018') OR (VendorTable."No." = 'PRO206010043') OR
                            (VendorTable."No." = 'PRO206010044') OR (VendorTable."No." = 'PRO305030019') then begin
                                VendorTable."Gen. Bus. Posting Group" := 'INO';
                                VendorTable."Vendor Posting Group" := 'INO';
                                VendorTable."VAT Bus. Posting Group" := 'D-INO';
                                VendorTable.Modify();
                            end else begin
                                VendorTable."Gen. Bus. Posting Group" := 'DOMAĆI';
                                VendorTable."Vendor Posting Group" := 'DOMAĆI';
                                VendorTable.Modify();
                            end;

                        until VendorTable.Next() = 0;
                end;
            }

            action("Obrada - vrsta brojčane serije")
            {
                ApplicationArea = all;
                Caption = 'Obrada - vrsta brojčane serije';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportV: XmlPort "Vendor Import";
                begin
                    ImportV.RUN;
                end;
            }
            action("Obrada - popunjavanje br. serija")
            {
                ApplicationArea = all;
                Caption = 'Obrada - popunjavanje br serija';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Process;
                Visible = true;

                trigger OnAction()
                var
                    NoSeries: Record "No. Series";
                    GenProdPostGr: Text[100];
                    VatProdPostGr: Text[100];
                    VendorTable: Record "Vendor";
                    NoSeries2: Record "No. Series";
                    NoSeriesLine2: Record "No. Series Line";
                begin

                    NoSeries.Reset();
                    NoSeries.SetFilter("Code", '<>%1', '');
                    if NoSeries.Findfirst() then
                        repeat
                            VendorTable.Reset();
                            VendorTable.SetFilter("Vendor Subgroup", '%1', NoSeries."Subgroup Code");
                            VendorTable.SetFilter("Vendor Group", '%1', NoSeries."Group Code");
                            VendorTable.SetFilter("Vendor Category", '%1', NoSeries."Category Code");

                            if VendorTable.Findlast() then begin
                                NoSeries2.Reset();
                                NoSeries2.SetFilter("Subgroup Code", '%1', VendorTable."Vendor Subgroup");
                                NoSeries2.SetFilter("Group Code", '%1', VendorTable."Vendor Group");
                                NoSeries2.SetFilter("Category Code", '%1', VendorTable."Vendor Category");
                                if NoSeries2.findfirst then begin
                                    NoSeriesLine2.SetFilter("Series Code", '%1', NoSeries2.Code);
                                    IF NoSeriesLine2.findfirst then begin
                                        NoSeriesLine2."Last No. Used" := VendorTable."No.";
                                        NoSeriesLine2.Modify();
                                    end;
                                end;
                            end;
                        until NoSeries.next = 0;
                    MESSAGE('Done');
                end;
            }

            action("Obrada - Import")
            {
                ApplicationArea = all;
                Caption = 'Obrada - import';
                Image = PaymentPeriod;
                Promoted = true;
                PromotedCategory = Category9;
                Visible = true;

                trigger OnAction()
                var
                    ImportV: XmlPort "Vendor Import";
                begin
                    ImportV.RUN;
                end;
            }
        }
    }

    local procedure RunReport(ReportNumber: Integer)
    var
        Vendor: Record Vendor;
    begin
        Vendor.SetRange("No.", "No.");
        REPORT.RunModal(ReportNumber, true, true, Vendor);
    end;

    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 2;
            UserSetup.Modify();
        end;
    end;

    trigger OnClosePage()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            UserSetup."Code Category Text" := 0;
            UserSetup.Modify();
        end;
    end;

    var
        UserSetup: Record "User Setup";
}