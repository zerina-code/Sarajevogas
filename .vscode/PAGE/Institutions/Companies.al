page 50072 "Institutions/Companies"
{
    Caption = 'Institutions/Companies';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = List;
    SourceTable = "Institution/Company";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater("L")
            {
                field("No."; "No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field("Type"; "Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Operation")
            {
                Caption = '&Operation';
                Image = Task;
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;

                    trigger OnAction()
                    begin
                        ShowComment;
                    end;
                }
                action("&Tools")
                {
                    Caption = '&Tools';
                    Image = Tools;

                    trigger OnAction()
                    begin
                        ShowTools;
                    end;
                }
                action("&Personnel")
                {
                    Caption = '&Personnel';
                    Image = User;

                    trigger OnAction()
                    begin
                        ShowPersonnel;
                    end;
                }
                action("&Quality Measures")
                {
                    Caption = '&Quality Measures';

                    trigger OnAction()
                    begin
                        ShowQualityMeasures;
                    end;
                }
            }
        }
    }

    var
        RtngComment: Record "Web portal connection setup";

    local procedure ShowComment()
    begin
    end;

    local procedure ShowTools()
    var
    //  RtngTool: Record "Employee Certificates";
    begin
    end;

    local procedure ShowPersonnel()
    var
        RtngPersonnel: Record "ORG Dijelovi";
    begin
    end;

    local procedure ShowQualityMeasures()
    var
    //  RtngQltyMeasure: Record "Confidential Clerks";
    begin
    end;
}

