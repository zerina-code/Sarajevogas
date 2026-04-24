/*page 50089 "Other Document Register"
{
    Caption = 'Other Document Register';
    Editable = true;
    PageType = List;
    SourceTable = "Other Document Register";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("K")
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