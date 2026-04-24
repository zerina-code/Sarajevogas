page 50054 "Employee Diseases"
{
    Caption = 'Employee Diseases';
    PageType = List;
    SourceTable = "Employee Diseases";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee Name"; "Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Code; Code)
                {
                    ApplicationArea = all;

                    //ovdje

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        myInt: Integer;
                        EBDPage: Page "Types Of Diseases";
                        ED: Record "Types Of Diseases";
                        Users: Record "User Setup";
                    begin


                        CLEAR(EBDPage);

                        EBDPage.LOOKUPMODE(TRUE);

                        ED.SetFilter(Types, '%1', ED.Types::"Types Of Diseases");

                        Commit();
                        EBDPage.SetTableView(ED);
                        IF EBDPage.RUNMODAL = ACTION::LookupOK THEN BEGIN

                            EBDPage.GETRECORD(ED);

                            Code := ED.Code;
                            "Disease Name" := ED.Description;





                        END;

                    end;


                }
                field("Disease Name"; "Disease Name")
                {
                    ApplicationArea = all;
                }
                field("Team Name"; "Team Name")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Group Name"; "Group Name")
                {
                    ApplicationArea = all;
                }
                field("Department Name"; "Department Name")
                {
                    ApplicationArea = all;
                }
                field("Sector Name"; "Sector Name")
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

