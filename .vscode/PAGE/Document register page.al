/*page 50243 "Document Register"
{
    Caption = 'Document register';
    Editable = true;
    PageType = List;
    SourceTable = "Document Register";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("J")
            {
                field(ID; ID)
                {
                    ApplicationArea = all;
                }
                field("Agreement Code"; "Agreement Code")
                {
                    ApplicationArea = all;
                }
                field(Group; Group)
                {
                    ApplicationArea = all;
                }
                field("Document Description"; "Document Description")
                {
                    ApplicationArea = all;
                }
                field("Show Template"; "Show Template")
                {
                    ApplicationArea = all;
                }
                field("NAV Agreement Code"; "NAV Agreement Code")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }

    procedure GetResult(var WhsePickRqst: Record "Whse. Pick Request")
    begin
    end;

    local procedure GetAsmToOrder(): Boolean
    var
        AsmHeader: Record "Wage Addition SD";
    begin
    end;
}

*/