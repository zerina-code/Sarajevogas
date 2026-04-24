page 50180 "Contract Scope"
{
    Caption = 'Contract Scope';
    DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SaveValues = true;
    SourceTable = "Contract Scope";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group1)
            {
                Editable = true;
                Enabled = true;
                field("Contract Entry No."; "Contract Entry No.")
                {
                    ApplicationArea = All;
                    //Editable = false; //treba biti editable da bi mogli paste cijeli asortiman iz Excel-a
                }
                /*field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }*/
                /*field("Direktni sporazum";"Direktni sporazum")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Exemption;Exemption)
                {
                    ApplicationArea = All;
                    Editable = false;
                }*/
                field(Type; Type) { Visible = false; }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Visible = VisibleItem;
                }
                field("Item Name"; "Item Name")
                {
                    ApplicationArea = All;
                    Visible = VisibleItem;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Visible = VisibleResource;
                }
                field("Resource Name"; "Resource Name")
                {
                    ApplicationArea = All;
                    Visible = VisibleResource;
                }
                field("G/L Account No."; "G/L Account No.")
                {
                    ApplicationArea = All;
                    Visible = VisibleWork;
                }
                field("G/L Account Name"; "G/L Account Name")
                {
                    ApplicationArea = All;
                    Visible = VisibleWork;
                }
                field("Fixed Asset No."; "Fixed Asset No.")
                {
                    ApplicationArea = All;
                    Visible = VisibleAsset;
                }
                field("Fixed Asset Name"; "Fixed Asset Name")
                {
                    ApplicationArea = All;
                    Visible = VisibleAsset;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;

                }
                field("Unit Price"; "Unit Price")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        //NE          CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        ContractEntryNo: code[20];
    begin
        ContractEntryNo := GetFilter("Contract Entry No.");
        PurchaseContractTable.Reset();
        PurchaseContractTable.SetFilter("Contract Entry No.", '%1', ContractEntryNo);
        //PurchaseContractTable.SetFilter("No.", '%1', Rec.GetFilter("Contract No."));

        if PurchaseContractTable.FindFirst() then begin
            if (FORMAT(PurchaseContractTable."Purchase Type") = 'Roba') then begin
                VisibleItem := true;
                VisibleWork := false;
                VisibleResource := false;
                VisibleAsset := false;
            end else
                if (FORMAT(PurchaseContractTable."Purchase Type") = 'Radovi') then begin
                    VisibleItem := false;
                    VisibleWork := true;
                    VisibleResource := false;
                    VisibleAsset := false;
                end else
                    if (FORMAT(PurchaseContractTable."Purchase Type") = 'Usluge') then begin
                        VisibleItem := false;
                        VisibleWork := false;
                        VisibleResource := true;
                        VisibleAsset := false;
                    end else
                        if (FORMAT(PurchaseContractTable."Purchase Type") = 'Osnovna sredstva') then begin
                            VisibleItem := false;
                            VisibleWork := false;
                            VisibleResource := false;
                            VisibleAsset := true;
                        end;
        end;

        EVALUATE(ContractNoFilter, Rec.GetFilter("Contract Entry No."));

    end;

    trigger OnClosePage()
    begin
        Suma := 0; //racunam vrijednost ugovora na osnovu unesenog asortimana
        //tj na osnovu kolicina i jedinicnih cijena

        Rec.Reset();
        Rec.SetFilter("Contract Entry No.", '%1', ContractNoFilter);
        if Rec.FindFirst() then
            repeat
            //NIKAKO NE IDE OVAKO      Suma += Rec.Quantity * Rec."Unit Price";
            until Rec.Next() = 0;

        PurchaseContractTable.Reset();
        PurchaseContractTable.SetFilter("Contract Entry No.", '%1', ContractNoFilter);
        if PurchaseContractTable.FindFirst() then begin
            //NE    PurchaseContractTable.Validate("Contract Amount", Suma);
            //ĐK   PurchaseContractTable.Modify();
        end;

        //NE     PurchaseContractPage.Update();

    end;

    var
        VisibleItem: Boolean;
        VisibleResource: Boolean;
        VisibleWork: Boolean;
        PurchaseContractTable: Record "Purchase Contract";
        PurchaseContractPage: Page "Purchase Contract";
        Suma: Decimal;
        ContractNoFilter: Code[20];
        VisibleAsset: Boolean;
}


