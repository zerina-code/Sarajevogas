page 50127 "Purchase Contract"
{

    //ED

    Caption = 'Purchase Contract';
    //DelayedInsert = true;
    Editable = true;
    MultipleNewLines = false;
    PageType = List;
    SourceTable = "Purchase Contract";
    UsageCategory = Lists;
    ApplicationArea = all;
    RefreshOnActivate = true;

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
                }
                field("Registration Number"; "Registration Number")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Contract Start Date"; "Contract Start Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Final Date"; "Contract Final Date")
                {
                    ApplicationArea = All;
                }
                field("Direktni sporazum"; "Direktni sporazum")
                {
                    ApplicationArea = All;
                }
                /*field(Exemption; Exemption)
                {
                    ApplicationArea = All;
                }*/
                field("Purchase Type"; "Purchase Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                //R
                field("Contract Scope"; "Contract Scope")
                {
                    ApplicationArea = all;




                }
                field("Purchase Plan Code"; "Purchase Plan Code")
                {
                    ApplicationArea = All;
                }
                field("Entry No. Plan"; "Entry No. Plan")
                {
                    ApplicationArea = All;
                }
                field("Entry Name Plan"; "Entry Name Plan")
                {
                    ApplicationArea = All;
                }
                field("Purchase Item"; "Purchase Item")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Name"; "Vendor Name")
                {
                    ApplicationArea = all;
                }

                field("Fixed Price"; "Fixed Price")
                {
                    ApplicationArea = all;
                }
                field("Contract Amount"; "Contract Amount")
                {
                    ApplicationArea = all;
                }
                field(Realized; Realized)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Tekući trošak"; "Tekući trošak")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Komercijalni trošak"; "Komercijalni trošak")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Investicioni trošak"; "Investicioni trošak")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Date Filter"; "Date Filter")
                {
                    ApplicationArea = all;
                    //Visible = false;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetCurrentKey(Order);
        Ascending;
        CalcFields("Contract Amount", "Contract Scope");
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Contract Amount", "Contract Scope");

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Contract Amount", "Contract Scope");

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        /*if GetFilter("Purchase Plan Code") <> '' then
            Validate("Purchase Plan Code", GetFilter("Purchase Plan Code"));
        if GetFilter("Entry No. Plan") <> '' then begin
            Evaluate(PomocniInt, GetFilter("Entry No. Plan"));
            Validate("Entry No. Plan", PomocniInt);
        end;
        if GetFilter("Direktni sporazum") <> '' then begin
            Evaluate(PomocniBoolean, GetFilter("Direktni sporazum"));
            Validate("Direktni sporazum", PomocniBoolean);
        end;
        if GetFilter("Purchase Type") <> '' then begin
            Evaluate(PomocniInt, GetFilter("Purchase Type"));
            Validate("Purchase Type", PomocniInt);
        end;*/

        //Message(Format(GetFilter("Purchase Plan Code")));
    end;

    var
        ContractScopeTable: Record "Contract Scope";
        ContractScopePage: Page "Contract Scope";
        PurchaseContract: Record "Purchase Contract";
        PomocniInt: Integer;
        PomocniBoolean: Boolean;
}

