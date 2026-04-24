page 50030 "Wage Value Entries"
{
    PageType = List;
    SourceTable = "Wage Value Entry";
    Caption = 'Wage Value Entries';


    layout
    {
        area(content)
        {
            repeater(Group2)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                }
                field("Wage Header Entry No."; "Wage Header Entry No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Wage Posting Group"; "Wage Posting Group")
                {
                    ApplicationArea = all;
                }
                field(Sector; Sector) { }

                field("Department Category"; "Department Category") { }
                field(Group; Group) { }
                field("Wage Ledger Entry No."; "Wage Ledger Entry No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Posted to G/L"; "Cost Posted to G/L")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Applies-to Entry"; "Applies-to Entry")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = all;

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Actual)"; "Cost Amount (Actual)")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = all;
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Contribution Type"; "Contribution Type")
                {
                    ApplicationArea = all;
                }
                field(Status; Status)
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("G/L Entry No. (Account)"; "G/L Entry No. (Account)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("G/L Entry No. (Bal. Account)"; "G/L Entry No. (Bal. Account)")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Cost Amount (Netto)"; "Cost Amount (Netto)")
                {
                    ApplicationArea = all;
                }
                field("Cost Amount (Brutto)"; "Cost Amount (Brutto)")
                {
                    ApplicationArea = all;
                }

            }
        }
    }

    actions
    {
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        CalcFields("Include WVE");
    end;

    trigger OnOpenPage()
    var
        WageAllowed: Boolean;
        UTemp: Record "User Setup";
        CU: Codeunit TestSubsCu;
    begin
        CalcFields("Include WVE");
        UTemp.Reset();
        UTemp.SetFilter("User ID", '%1', UserId);
        if UTemp.FindFirst() then
            WageAllowed := UTemp."Wage Allowed";

        if NOT WageAllowed then
            Error(CU.WagesNotAllowed());
    end;
}

