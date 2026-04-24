
pageextension 50226 StandardTextCodes extends "Standard Text Codes"

{


    layout
    {

        modify(Code)
        {
            ApplicationArea = All;
            ToolTip = 'Code';
            Editable = CanModify;
        }
        modify(Description)
        {
            ApplicationArea = All;
            ToolTip = 'Description';
            Editable = CanModify;
        }
        addafter(Description)
        {
            field(Plan; Plan)
            {
                /* trigger OnLookup(var Text: Text): Boolean
                 var
                     myInt: Integer;
                     Plan: Record "Plan RN";
                     PlanPage: page "Plan Page";
                 begin
                     Plan.Reset();
                     Plan.SetFilter(Year, '%1', Date2DMY(workdate, 3));
                     Plan.SetFilter("Plan Filter", '%1..%2', DMY2Date(1, 1, Date2DMY(workdate, 3)), dmy2date(31, 12, Date2DMY(workdate, 3)));
                     PlanPage.SetTableView(Plan);
                     PlanPage.Run();

                 end;

                 trigger OnDrillDown()
                 var
                     myInt: Integer;
                     Plan: Record "Plan RN";
                     PlanPage: page "Plan Page";
                 begin
                     Plan.Reset();
                     Plan.SetFilter(Year, '%1', Date2DMY(workdate, 3));
                     Plan.SetFilter("Plan Filter", '%1..%2', DMY2Date(1, 1, Date2DMY(workdate, 3)), dmy2date(31, 12, Date2DMY(workdate, 3)));
                     PlanPage.SetTableView(Plan);
                     PlanPage.Run();

                 end;*/

            }
        }
    }




    trigger OnOpenPage()

    begin
        CanModify := false;
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.Intervencije;

        end;
        setfilter("Year Filter", '%1', Date2DMY(WorkDate(), 3));
        CalcFields(Plan);
    end;

    trigger OnAfterGetRecord()
    begin
        UserSetup.Reset();
        UserSetup.SetFilter("User ID", '%1', UserId);
        if UserSetup.FindFirst() then begin
            CanModify := UserSetup.Intervencije;

        end;
        CalcFields(Plan);
    end;




    var
        UserSetup: Record "User Setup";
        CanModify: Boolean;
}